Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2A4E2E83
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351392AbiCUQvz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 12:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbiCUQvy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 12:51:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435D160140;
        Mon, 21 Mar 2022 09:50:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id E51B01F4391F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647881426;
        bh=3AcObqKJvoQYP8pFCTNS2aLjVKgY2LjJcynj7NSILVc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KvrxNdLwPZbg2/jeAlMLW5mwRpzebBf7b0AQZt5U+lU+SfPpA5npdDcPrEw9L8X9V
         HI5YDBV6K+FXVYlPeMSZY7aJkTeRc21fdZJGJ5ilXbpiksMa2P+KN75RMofR5HjP3f
         cVFujVci64xchLMtVUL0si8WvwdOYoMudvhZYwihORmIJ+K4vUEHeoDHsQ9Jgg3vDl
         Xejc6ABUObhKXRN3euw5WF4gIuGJTzwiah0pqeLDxW3lGbFhAolakqlFwccmXKZFaB
         FKqd6i4mXQzbRMroZKVPHil3/zjnwtXLQLHN6SsrO8TZB5ctz0HZmXftEaTp+nYAM0
         hse3U+8tMyjEA==
Message-ID: <bf09ba9d-f6b9-8fe0-93ff-e3fb78216ef5@collabora.com>
Date:   Mon, 21 Mar 2022 19:50:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/4] x86/PCI: Add $IRT PIRQ routing table support
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        Michal Necasek <mnecasek@yahoo.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
 <alpine.DEB.2.21.2201022058050.56863@angie.orcam.me.uk>
 <a2791312-2957-27e6-43af-c805bbb90266@collabora.com>
 <alpine.DEB.2.21.2203161740350.24248@angie.orcam.me.uk>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <alpine.DEB.2.21.2203161740350.24248@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/16/22 21:09, Maciej W. Rozycki wrote:
> On Tue, 15 Mar 2022, Dmitry Osipenko wrote:
> 
>>> Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP 
>>> (BIOS Configuration Program) external tool meant for tweaking BIOS 
>>> structures without the need to rebuild it from sources[1].
>>>
>>> The $IRT format has been invented by AMI before Microsoft has come up 
>>> with its $PIR format and a $IRT table is therefore there in some systems 
>>> that lack a $PIR table, such as the DataExpert EXP8449 mainboard based 
>>> on the ALi FinALi 486 chipset (M1489/M1487), which predates DMI 2.0 and 
>>> cannot therefore be easily identified at run time.
>>>
>>> Unlike with the $PIR format there is no alignment guarantee as to the 
>>> placement of the $IRT table, so scan the whole BIOS area bytewise.
> [...]
>> This patch broke crosvm using recent linux-next. The "ir = (struct
>> irt_routing_table *)addr;" contains invalid pointer. Any ideas why?
> 
>  This specific pointer refers to the BIOS area being iterated over:
> 
> 	for (addr = (u8 *)__va(0xf0000);
> 	     addr < (u8 *)__va(0x100000);
> 	     addr++) {
> 
> and it is conceptually not new code in that a similar piece as below:
> 
> 	for (addr = (u8 *)__va(0xf0000);
> 	     addr < (u8 *)__va(0x100000);
> 	     addr += 16) {
> 
> used to be there before my change and even now it is executed earlier on 
> in `pirq_find_routing_table'.
> 
>> PCI: Probing PCI hardware
>> BUG: unable to handle page fault for address: ffffed1000020000
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD 12fff4067 P4D 12fff4067 PUD 12fff3067 PMD 12fff2067 PTE 0
>> Oops: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc7-next-20220310+ #226
>> Hardware name: ChromiumOS crosvm, BIOS 0
>> RIP: 0010:kasan_check_range+0xe6/0x1a0
>> Code: 00 74 ee 48 89 c2 b8 01 00 00 00 48 85 d2 75 5d 5b 41 5c 41 5d 5d
>> c3 48 85 d2 74 63 4c 01 e2 eb 09 48 83 c0 01 48 39 d0 74 55 <80> 38 00
>> 74 f2 eb d2 41 bd 08 00 00 00 45 29 dd 4b 8d 54 25 00 eb
> 
>  Thank you for your report and apologies for the trouble.
> 
>  I don't know what a "ChromiumOS crosvm" is, but the mention of "Chromium" 
> indicates to me it is something reasonably recent that should be using 
> ACPI rather than legacy PCI IRQ routing, and even then it should be using 
> the standardised $PIR format rather than AMI's proprietary $IRT one.  I am 
> more than surprised this code is active for x86-64 even, as this is solely 
> i386 legacy.
> 
>  In any case we need to debug this and possibly work around somehow as 
> this BIOS is likely giving us rubbish information.  Unfortunately without 
> access to your Linux build tree along with debug information I can do very 
> little.  The faulting piece of code is as follows:
> 
>   21:	48 83 c0 01          	add    $0x1,%rax
>   25:	48 39 d0             	cmp    %rdx,%rax
>   28:	74 55                	je     7f <foo+0x7f>
>   2a:	80 38 00             	cmpb   $0x0,(%rax)
>   2d:	74 f2                	je     21 <foo+0x21>
> 
> -- with the CMPB at 2a being the offender and further information required 
> as to what RAX holds at the moment.
> 
>  So as the first approximation I would like to see what your BIOS actually 
> tells Linux.  Would you therefore please try the following debug patch, 
> boot with the `debug' kernel parameter and send me the resulting bootstrap 
> log?
> 
>   Maciej
> 
> ---
>  arch/x86/include/asm/pci_x86.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> linux-x86-pci-debug.diff
> Index: linux-macro/arch/x86/include/asm/pci_x86.h
> ===================================================================
> --- linux-macro.orig/arch/x86/include/asm/pci_x86.h
> +++ linux-macro/arch/x86/include/asm/pci_x86.h
> @@ -7,7 +7,7 @@
>  
>  #include <linux/ioport.h>
>  
> -#undef DEBUG
> +#define DEBUG 1
>  
>  #ifdef DEBUG
>  #define DBG(fmt, ...) printk(fmt, ##__VA_ARGS__)

Hi Maciej,

I applied yours patch to today's linux-next and added the `debug` to
kernel's cmdline, here is the boot log:

[    0.000000] Linux version 5.17.0-next-20220321+ (dima@dimapc) (gcc
(GCC) 11.2.1 20220127 (Red Hat 11.2.1-9), GNU ld version 2.37-10.fc35)
#242 SMP PREEMPT_DYNAMIC Mon Mar 21 19:27:24 MSK 2022
[    0.000000] Command line: panic=-1 acpi=noirq console=ttyS0
root=/dev/vda rw console=ttyS0 nokaslr rw
ip=127.0.0.15::127.0.0.2:255.255.255.0 init=/lib/systemd/systemd debug
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832
bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000200000-0x00000000cfffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f4000000-0x00000000f7ffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000012fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] ACPI: MPS support code is not built-in, using acpi=off or
acpi=noirq or pci=noacpi may have problem
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: ChromiumOS crosvm, BIOS 0
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000004] kvm-clock: using sched offset of 184313261 cycles
[    0.000016] clocksource: kvm-clock: mask: 0xffffffffffffffff
max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000044] tsc: Detected 3403.346 MHz processor
[    0.000289] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000304] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000315] last_pfn = 0x130000 max_arch_pfn = 0x400000000
[    0.000369] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC-
WT
[    0.000396] last_pfn = 0xd0000 max_arch_pfn = 0x400000000
[    0.002351] ACPI: Early table checksum verification disabled
[    0.002423] ACPI: RSDP 0x00000000000E0000 000024 (v02 CROSVM)
[    0.002441] ACPI: XSDT 0x00000000000E0480 00003C (v01 CROSVM CROSVMDT
00000001 CROS 00000000)
[    0.002468] ACPI: FACP 0x00000000000E01C0 000114 (v06 CROSVM CROSVMDT
00000001 CROS 00000000)
[    0.002488] ACPI: DSDT 0x00000000000E0080 00013B (v06 CROSVM CROSVMDT
00000001 CROS 00000000)
[    0.002502] ACPI: FACS 0x00000000000E0040 000040
[    0.002514] ACPI: APIC 0x00000000000E0300 000088 (v05 CROSVM CROSVMDT
00000001 CROS 00000000)
[    0.002528] ACPI: MCFG 0x00000000000E03C0 00003C (v01 CROSVM CROSVMDT
00000001 CROS 00000000)
[    0.002539] ACPI: Reserving FACP table memory at [mem 0xe01c0-0xe02d3]
[    0.002545] ACPI: Reserving DSDT table memory at [mem 0xe0080-0xe01ba]
[    0.002550] ACPI: Reserving FACS table memory at [mem 0xe0040-0xe007f]
[    0.002555] ACPI: Reserving APIC table memory at [mem 0xe0300-0xe0387]
[    0.002559] ACPI: Reserving MCFG table memory at [mem 0xe03c0-0xe03fb]
[    0.002735] Zone ranges:
[    0.002742]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002752]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002759]   Normal   [mem 0x0000000100000000-0x000000012fffffff]
[    0.002766] Movable zone start for each node
[    0.002770] Early memory node ranges
[    0.002773]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.002781]   node   0: [mem 0x0000000000200000-0x00000000cfffffff]
[    0.002787]   node   0: [mem 0x0000000100000000-0x000000012fffffff]
[    0.002794] Initmem setup node 0 [mem
0x0000000000001000-0x000000012fffffff]
[    0.002834] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.003212] On node 0, zone DMA: 353 pages in unavailable ranges
[    0.553684] kasan: KernelAddressSanitizer initialized
[    0.555420] TSC deadline timer available
[    0.555429] No local APIC present
[    0.555433] APIC: disable apic facility
[    0.555437] APIC: switched to apic NOOP
[    0.555449] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.555668] [mem 0xd0000000-0xf3ffffff] available for PCI devices
[    0.555677] Booting paravirtualized kernel on KVM
[    0.555700] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.555727] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1
nr_node_ids:1
[    0.557630] percpu: Embedded 67 pages/cpu s235424 r8192 d30816 u2097152
[    0.557651] pcpu-alloc: s235424 r8192 d30816 u2097152 alloc=1*2097152
[    0.557662] pcpu-alloc: [0] 0
[    0.557721] kvm-guest: PV spinlocks disabled, single CPU
[    0.557760] Built 1 zonelists, mobility grouping on.  Total pages:
1031685
[    0.557770] Kernel command line: panic=-1 acpi=noirq console=ttyS0
root=/dev/vda rw console=ttyS0 nokaslr rw
ip=127.0.0.15::127.0.0.2:255.255.255.0 init=/lib/systemd/systemd debug
[    0.561748] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.563562] Inode-cache hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.563655] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.563683] Stack Depot allocating hash table with memblock_alloc
[    0.751869] Memory: 3442904K/4192888K available (28689K kernel code,
9509K rwdata, 10528K rodata, 1944K init, 12916K bss, 749728K reserved,
0K cma-reserved)
[    0.752348] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.752448] ftrace: allocating 54984 entries in 215 pages
[    0.773204] ftrace: allocated 215 pages with 6 groups
[    0.773792] Dynamic Preempt: full
[    0.774049] Running RCU self tests
[    0.774074] rcu: Preemptible hierarchical RCU implementation.
[    0.774081] rcu:     RCU lockdep checking is enabled.
[    0.774087] rcu:     RCU restricting CPUs from NR_CPUS=64 to
nr_cpu_ids=1.
[    0.774093]  Trampoline variant of Tasks RCU enabled.
[    0.774096]  Rude variant of Tasks RCU enabled.
[    0.774100]  Tracing variant of Tasks RCU enabled.
[    0.774105] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    0.774109] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.791623] NR_IRQS: 4352, nr_irqs: 32, preallocated irqs: 16
[    0.792049] rcu: srcu_init: Setting srcu_struct sizes based on
contention.
[    0.793931] Console: colour VGA+ 142x228
[    0.914308] printk: console [ttyS0] enabled
[    0.915187] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.916771] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.917628] ... MAX_LOCK_DEPTH:          48
[    0.918500] ... MAX_LOCKDEP_KEYS:        8192
[    0.919407] ... CLASSHASH_SIZE:          4096
[    0.920313] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.921237] ... MAX_LOCKDEP_CHAINS:      65536
[    0.922158] ... CHAINHASH_SIZE:          32768
[    0.923134]  memory used by lock dependency info: 6365 kB
[    0.924311]  memory used for stack traces: 4224 kB
[    0.925306]  per task-struct memory footprint: 1920 bytes
[    0.926515] ACPI: Core revision 20211217
[    0.927867] ACPI: setting ELCR to 0020 (from 0000)
[    0.928977] APIC disabled via kernel command line
[    0.930060] APIC: Keep in PIC mode(8259)
[    0.930894] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x310ea79c150, max_idle_ns: 440795317982 ns
[    0.933209] Calibrating delay loop (skipped) preset value.. 6806.69
BogoMIPS (lpj=3403346)
[    0.934198] pid_max: default: 32768 minimum: 301
[    0.936283] LSM: Security Framework initializing
[    0.937299] random: get_random_bytes called from setup_net+0xbc/0x4c0
with crng_init=0
[    0.937546] Mount-cache hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    0.940265] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
[    0.946239] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.948567] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.949194] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.950260] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.952205] Spectre V2 : Kernel not compiled with retpoline; no
mitigation available!
[    0.952212] Spectre V2 : Vulnerable
[    0.955194] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling
RSB on context switch
[    0.957192] Spectre V2 : Enabling Restricted Speculation for firmware
calls
[    0.958217] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.960193] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.961195] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    0.963216] SRBDS: Unknown: Dependent on hypervisor status
[    0.964196] MDS: Mitigation: Clear CPU buffers
[    0.988223] Freeing SMP alternatives memory: 48K
[    0.990207] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    0.991196] smpboot: SMP disabled
[    0.993657] cblist_init_generic: Setting adjustable number of
callback queues.
[    0.994194] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.995570] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.997454] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.998355] Running RCU-tasks wait API self tests
[    1.002264] Performance Events: IvyBridge events, full-width counters,
[    1.002335] no APIC, boot with the "lapic" boot parameter to
force-enable it.
[    1.005195] no hardware sampling interrupt available.
[    1.006222] Intel PMU driver.
[    1.006891] ... version:                2
[    1.007195] ... bit width:              48
[    1.008291] Callback from call_rcu_tasks_trace() invoked.
[    1.009204] ... generic registers:      8
[    1.010195] ... value mask:             0000ffffffffffff
[    1.011195] ... max period:             00007fffffffffff
[    1.013193] ... fixed-purpose events:   3
[    1.014043] ... event mask:             00000007000000ff
[    1.015990] rcu: Hierarchical SRCU implementation.
[    1.018049] smp: Bringing up secondary CPUs ...
[    1.018233] smp: Brought up 1 node, 1 CPU
[    1.019203] smpboot: Max logical packages: 1
[    1.020220] smpboot: Total of 1 processors activated (6806.69 BogoMIPS)
[    1.026922] devtmpfs: initialized
[    1.036933] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.038217] futex hash table entries: 256 (order: 3, 32768 bytes, linear)
[    1.041550] PM: RTC time: 16:30:00, date: 2022-03-21
[    1.043488] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.046179] audit: initializing netlink subsys (disabled)
[    1.049355] thermal_sys: Registered thermal governor 'step_wise'
[    1.049361] thermal_sys: Registered thermal governor 'user_space'
[    1.050344] audit: type=2000 audit(1647880200.313:1):
state=initialized audit_enabled=0 res=1
[    1.053269] cpuidle: using governor ladder
[    1.054266] cpuidle: using governor menu
[    1.057234] dca service started, version 1.12.1
[    1.058389] PCI: Using configuration type 1 for base access
[    1.059324] core: PMU erratum BJ122, BV98, HSD29 workaround disabled,
HT off
[    1.107384] Callback from call_rcu_tasks_rude() invoked.
[    1.112651] cryptd: max_cpu_qlen set to 1000
[    1.120728] ACPI: Added _OSI(Module Device)
[    1.121200] ACPI: Added _OSI(Processor Device)
[    1.122197] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.123217] ACPI: Added _OSI(Processor Aggregator Device)
[    1.124210] ACPI: Added _OSI(Linux-Dell-Video)
[    1.125242] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.126203] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    1.129036] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    1.136462] ACPI: Interpreter enabled
[    1.137367] ACPI: PM: (supports S0 S1 S5)
[    1.138211] ACPI: Using PIC for interrupt routing
[    1.139381] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    1.145033] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    1.146228] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments
MSI HPX-Type3]
[    1.147216] acpi PNP0A08:00: _OSC: not requesting OS control; OS
requires [ExtendedConfig ASPM ClockPM MSI]
[    1.150992] PCI host bridge to bus 0000:00
[    1.151219] pci_bus 0000:00: root bus resource [mem
0xd0000000-0xf3ffffff window]
[    1.153208] pci_bus 0000:00: root bus resource [mem
0x130000000-0xed0000000 window]
[    1.155196] pci_bus 0000:00: root bus resource [bus 00-3f]
[    1.156501] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.159966] pci 0000:00:01.0: [1af4:1052] type 00 class 0x00ff00
[    1.161532] pci 0000:00:01.0: reg 0x10: [mem 0xd0000000-0xd0007fff]
[    1.166032] pci 0000:00:02.0: [1af4:1052] type 00 class 0x00ff00
[    1.167574] pci 0000:00:02.0: reg 0x10: [mem 0xd0008000-0xd000ffff]
[    1.172427] pci 0000:00:03.0: [1af4:1050] type 00 class 0x038000
[    1.173557] pci 0000:00:03.0: reg 0x10: [mem 0xd0010000-0xd0017fff]
[    1.176325] pci 0000:00:03.0: reg 0x20: [mem 0x200000000-0x3ffffffff
64bit]
[    1.180197] pci 0000:00:04.0: [1af4:1042] type 00 class 0x00ff00
[    1.181501] pci 0000:00:04.0: reg 0x10: [mem 0xd0018000-0xd001ffff]
[    1.186411] pci 0000:00:05.0: [1af4:1044] type 00 class 0x00ff00
[    1.187512] pci 0000:00:05.0: reg 0x10: [mem 0xd0020000-0xd0027fff]
[    1.189239] random: fast init done
[    1.193429] pci 0000:00:06.0: [1af4:1045] type 00 class 0x00ff00
[    1.195199] pci 0000:00:06.0: reg 0x10: [mem 0xd0028000-0xd002ffff]
[    1.199934] pci 0000:00:07.0: [1af4:1041] type 00 class 0x00ff00
[    1.201555] pci 0000:00:07.0: reg 0x10: [mem 0xd0030000-0xd0037fff]
[    1.205988] pci 0000:00:08.0: [1b73:1000] type 00 class 0x0c0330
[    1.207482] pci 0000:00:08.0: reg 0x10: [mem 0xd0040000-0xd004ffff]
[    1.210750] pci 0000:00:09.0: [1b36:0011] type 00 class 0xffff00
[    1.211319] Callback from call_rcu_tasks() invoked.
[    1.213486] pci 0000:00:09.0: reg 0x10: [mem 0xd0038000-0xd003800f]
[    1.216742] pci 0000:00:0a.0: [8086:3420] type 01 class 0x060400
[    1.218196] pci 0000:00:0a.0: reg 0x10: [mem 0xd0039000-0xd0039fff]
[    1.221324] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    1.225043] pci 0000:00:0a.0: PCI bridge to [bus 01]
[    1.226284] pci 0000:00:0a.0:   bridge window [mem 0xd0100000-0xd08fffff]
[    1.227277] pci 0000:00:0a.0:   bridge window [mem
0x130000000-0x133ffffff 64bit pref]
[    1.229335] pci_bus 0000:00: on NUMA node 0
[    1.231668] iommu: Default domain type: Translated
[    1.232196] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.235752] SCSI subsystem initialized
[    1.236671] libata version 3.00 loaded.
[    1.238530] ACPI: bus type USB registered
[    1.239561] usbcore: registered new interface driver usbfs
[    1.241289] usbcore: registered new interface driver hub
[    1.242299] usbcore: registered new device driver usb
[    1.243461] mc: Linux media interface: v0.10
[    1.244288] videodev: Linux video capture interface: v2.00
[    1.246657] EDAC MC: Ver: 3.0.0
[    1.249424] Advanced Linux Sound Architecture Driver Initialized.
[    1.253285] NetLabel: Initializing
[    1.254056] NetLabel:  domain hash size = 128
[    1.254196] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.256462] NetLabel:  unlabeled traffic allowed by default
[    1.258491] PCI: Probing PCI hardware
[    1.259203] PCI: root bus 00: using default resources
[    1.260206] PCI: Probing PCI hardware (bus 00)
[    1.261241] PCI: IRQ init
[    1.262625] BUG: unable to handle page fault for address:
ffffed1000020000
[    1.263187] #PF: supervisor read access in kernel mode
[    1.263187] #PF: error_code(0x0000) - not-present page
[    1.263187] PGD 12fff4067 P4D 12fff4067 PUD 12fff3067 PMD 12fff2067 PTE 0
[    1.263187] Oops: 0000 [#1] PREEMPT SMP KASAN
[    1.263187] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.17.0-next-20220321+ #242
[    1.263187] Hardware name: ChromiumOS crosvm, BIOS 0
[    1.263187] RIP: 0010:kasan_check_range+0xe6/0x1a0
[    1.263187] Code: 00 74 ee 48 89 c2 b8 01 00 00 00 48 85 d2 75 5d 5b
41 5c 41 5d 5d c3 48 85 d2 74 63 4c 01 e2 eb 09 48 83 c0 01 48 39 d0 74
55 <80> 38 00 74 f2 eb d2 41 bd 08 00 00 00 45 29 dd 4b 8d 54 25 00 eb
[    1.263187] RSP: 0000:ffff8881002c7da0 EFLAGS: 00010297
[    1.263187] RAX: ffffed1000020000 RBX: ffffed1000020001 RCX:
ffffffff8440fd8d
[    1.263187] RDX: ffffed1000020001 RSI: 0000000000000004 RDI:
ffff8880000ffffd
[    1.263187] RBP: ffff8881002c7db8 R08: 0000000000000000 R09:
ffff888000100000
[    1.263187] R10: ffffed1000020000 R11: 515249203a494350 R12:
ffffed100001ffff
[    1.263187] R13: 0000000080000000 R14: ffff888000000000 R15:
ffff8881002c7eb8
[    1.263187] FS:  0000000000000000(0000) GS:ffff88810b200000(0000)
knlGS:0000000000000000
[    1.263187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.263187] CR2: ffffed1000020000 CR3: 0000000003a29001 CR4:
0000000000170ef0
[    1.263187] Call Trace:
[    1.263187]  <TASK>
[    1.263187]  __asan_loadN+0xf/0x20
[    1.263187]  pcibios_irq_init+0x108/0x54a
[    1.263187]  ? pci_legacy_init+0x3b/0x3b
[    1.263187]  pci_subsys_init+0x69/0xa2
[    1.263187]  do_one_initcall+0xba/0x3e0
[    1.263187]  ? trace_event_raw_event_initcall_level+0x140/0x140
[    1.263187]  ? rcu_read_lock_sched_held+0x46/0x80
[    1.263187]  kernel_init_freeable+0x33c/0x395
[    1.263187]  ? rest_init+0x280/0x280
[    1.263187]  kernel_init+0x1e/0x130
[    1.263187]  ret_from_fork+0x1f/0x30
[    1.263187]  </TASK>
[    1.263187] Modules linked in:
[    1.263187] CR2: ffffed1000020000
[    1.263187] ---[ end trace 0000000000000000 ]---
[    1.263187] RIP: 0010:kasan_check_range+0xe6/0x1a0
[    1.263187] Code: 00 74 ee 48 89 c2 b8 01 00 00 00 48 85 d2 75 5d 5b
41 5c 41 5d 5d c3 48 85 d2 74 63 4c 01 e2 eb 09 48 83 c0 01 48 39 d0 74
55 <80> 38 00 74 f2 eb d2 41 bd 08 00 00 00 45 29 dd 4b 8d 54 25 00 eb
[    1.263187] RSP: 0000:ffff8881002c7da0 EFLAGS: 00010297
[    1.263187] RAX: ffffed1000020000 RBX: ffffed1000020001 RCX:
ffffffff8440fd8d
[    1.263187] RDX: ffffed1000020001 RSI: 0000000000000004 RDI:
ffff8880000ffffd
[    1.263187] RBP: ffff8881002c7db8 R08: 0000000000000000 R09:
ffff888000100000
[    1.263187] R10: ffffed1000020000 R11: 515249203a494350 R12:
ffffed100001ffff
[    1.263187] R13: 0000000080000000 R14: ffff888000000000 R15:
ffff8881002c7eb8
[    1.263187] FS:  0000000000000000(0000) GS:ffff88810b200000(0000)
knlGS:0000000000000000
[    1.263187] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.263187] CR2: ffffed1000020000 CR3: 0000000003a29001 CR4:
0000000000170ef0
[    1.264197] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000009
