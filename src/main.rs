#![no_std]
#![no_main]


use ch32_metapac;
// use qingke_rt::entry;
use riscv_rt::entry;

use embedded_hal::pwm;
use embedded_hal::delay;
use embedded_hal::digital;
use ch32_metapac::gpio;

extern crate panic_halt;

#[entry]
fn main() -> ! {
    let gpiod = ch32_metapac::GPIOD;
    let rcc = ch32_metapac::RCC;
    // rcc.apb2pcenr().write(|_w|0b10_0000);
    // gpiod.cfglr().write(|_w|0x0100_0000);
    rcc.apb2pcenr().modify(|f|
        f.set_iopden(true)
    );
    gpiod.cfglr().modify(|f|
        f.set_mode(6, gpio::vals::Mode::OUTPUT_10MHZ)
    );
    gpiod.cfglr().modify(|f|
        f.set_cnf(6, gpio::vals::Cnf::ANALOG_IN__PUSH_PULL_OUT)
    );
    
    loop {
        gpiod.outdr().modify(|f|
            f.set_odr(6, true)
        );
        for _ in 0..1_000_000 {
            core::hint::black_box(()); // Do nothing, but keep the loop
        }
        gpiod.outdr().modify(|f|
            f.set_odr(6, false)
        );
        for _ in 0..1_000_000 {
            core::hint::black_box(()); // Do nothing, but keep the loop
        }
    }
    // let RCC_APB2PCENR: *mut u32 = 0x4002_1018 as _;
    // let GPIOD_CFGLR: *mut u32 = 0x4001_1400 as _;
    // let GPIOD_OUTDR: *mut u32 = 0x4001_140C as _;

    // unsafe {
    //     // Enable clocks to the GPIOC bank
    //     RCC_APB2PCENR.write_volatile(0b10_0000);
    //     // Write 0b0001 to pin 1 configuration
    //     GPIOD_CFGLR.write_volatile(0x0100_0000);
    //     loop {
    //         // Set pin 1 to high
    //         GPIOD_OUTDR.write_volatile(0x0000_0040);
    //         for _ in 0..1_000_000 {
    //             core::hint::black_box(()); // Do nothing, but keep the loop
    //         }
    //         // Set pin 0 to high
    //         GPIOD_OUTDR.write_volatile(0x0000_0000);
    //         for _ in 0..1_000_000 {
    //             core::hint::black_box(()); // Do nothing, but keep the loop
    //         }
    //     }
    // }
}
