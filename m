Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8A3D2ED
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405347AbfFKQrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 12:47:18 -0400
Received: from sed198n136.SEDSystems.ca ([198.169.180.136]:45226 "EHLO
        sed198n136.sedsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405345AbfFKQrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2019 12:47:17 -0400
Received: from barney.sedsystems.ca (barney [198.169.180.121])
        by sed198n136.sedsystems.ca  with ESMTP id x5BGl7tq020009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jun 2019 10:47:08 -0600 (CST)
Received: from eng1n65.eng.sedsystems.ca (eng1n65.eng.sedsystems.ca [172.21.1.65])
        by barney.sedsystems.ca (8.14.7/8.14.4) with ESMTP id x5BGl7dY059404
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 11 Jun 2019 10:47:07 -0600
Subject: Re: iMX6 5.2-rc3 boot failure due to "PCI: imx6: Allow asynchronous
 probing"
From:   Robert Hancock <hancock@sedsystems.ca>
To:     linux-kernel@vger.kernel.org
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <f297c15c-af4f-e4b3-feac-ca313f46f13e@sedsystems.ca>
Openpgp: preference=signencrypt
Autocrypt: addr=hancock@sedsystems.ca; prefer-encrypt=mutual; keydata=
 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
Organization: SED Systems
Message-ID: <74703679-96d4-b759-a332-c3f3bff9a7c7@sedsystems.ca>
Date:   Tue, 11 Jun 2019 10:47:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f297c15c-af4f-e4b3-feac-ca313f46f13e@sedsystems.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.64 on 198.169.180.136
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding linux-pci.

One thing that may be slightly unusual about our setup is that we are
using CONFIG_PREEMPT=y, which may be allowing more concurrency to come
into play.

On 2019-06-07 6:28 p.m., Robert Hancock wrote:
> I am seeing a boot failure on our iMX6D-based embedded platform running
> v5.2-rc3. It seems to stall for about 20 seconds after "random: crng
> init done" and then panic with a bunch of RCU stall and soft-lockup
> errors. It seems like something is hanging up in the iMX6 PCIe driver.
> Boot log is below.
> 
> Suspecting the following patch, I reverted it locally and it seems to
> resolve the issue. (Well it gets into userspace at least; it later
> oopses in the ksz switch driver, appears unrelated..)
> 
> commit 1b8df7aa78748ddafc6f3b16a6328a3c500087b3
> Author: Lucas Stach <l.stach@pengutronix.de>
> Date:   Thu Apr 4 18:45:17 2019 +0200
> 
>     PCI: imx6: Allow asynchronous probing
> 
>     Establishing a PCIe link can take a while; allow asynchronous probing so
>     that link establishment can happen in the background while other devices
>     are being probed.
> 
>     Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> I would say either that patch needs a fix or it should be reverted for now.
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 5.2.0-rc3
> (hancock@SED.RFC1918.192.168.sedsystems.ca) (gcc version 8.3.0
> (Buildroot 2019.02.1-00510-gcc60ea2)) #1 SMP PREEMPT Fri Jun 7 17:44:38
> CST 2019
> [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7),
> cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] OF: fdt: Machine model: SED Systems xxx
> [    0.000000] printk: bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] cma: Reserved 64 MiB at 0x3c000000
> [    0.000000] percpu: Embedded 16 pages/cpu s36364 r8192 d20980 u65536
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260608
> [    0.000000] Kernel command line: console=ttymxc0,115200 earlyprintk
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
> bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
> bytes)
> [    0.000000] Memory: 940708K/1048576K available (6144K kernel code,
> 304K rwdata, 2036K rodata, 1024K init, 377K bss, 42332K reserved, 65536K
> cma-reserved, 262144K highmem)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
> [    0.000000]  Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> is 100 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] L2C-310 errata 752271 769419 enabled
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> [    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
> [    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
> [    0.000000] random: get_random_bytes called from
> start_kernel+0x2ac/0x434 with crng_init=0
> [    0.000000] Switching to timer-based delay loop, resolution 333ns
> [    0.000007] sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps
> every 715827882841ns
> [    0.008211] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 637086815595 ns
> [    0.019178] Console: colour dummy device 80x30
> [    0.023670] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 6.00 BogoMIPS (lpj=3000)
> [    0.033799] pid_max: default: 32768 minimum: 301
> [    0.038557] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.045211] Mountpoint-cache hash table entries: 2048 (order: 1, 8192
> bytes)
> [    0.052846] *** VALIDATE proc ***
> [    0.056285] *** VALIDATE cgroup1 ***
> [    0.059886] *** VALIDATE cgroup2 ***
> [    0.063483] CPU: Testing write buffer coherency: ok
> [    0.068401] CPU0: Spectre v2: using BPIALL workaround
> [    0.073698] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.085424] Setting up static identity map for 0x10100000 - 0x10100060
> [    0.093365] rcu: Hierarchical SRCU implementation.
> [    0.103365] smp: Bringing up secondary CPUs ...
> [    0.115623] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> [    0.115630] CPU1: Spectre v2: using BPIALL workaround
> [    0.126488] smp: Brought up 1 node, 2 CPUs
> [    0.130636] SMP: Total of 2 processors activated (12.00 BogoMIPS).
> [    0.136846] CPU: All CPU(s) started in SVC mode.
> [    0.142366] devtmpfs: initialized
> [    0.153902] VFP support v0.3: implementor 41 architecture 3 part 30
> variant 9 rev 4
> [    0.161920] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.171715] futex hash table entries: 512 (order: 3, 32768 bytes)
> [    0.181088] pinctrl core: initialized pinctrl subsystem
> [    0.187300] NET: Registered protocol family 16
> [    0.200572] DMA: preallocated 256 KiB pool for atomic coherent
> allocations
> [    0.208274] cpuidle: using governor menu
> [    0.212276] CPU identified as i.MX6Q, silicon rev 1.5
> [    0.224679] vdd1p1: supplied by regulator-dummy
> [    0.229707] vdd3p0: supplied by regulator-dummy
> [    0.234698] vdd2p5: supplied by regulator-dummy
> [    0.251174] No ATAGs?
> [    0.251273] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
> watchpoint registers.
> [    0.261602] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [    0.268154] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
> [    0.305898] mxs-dma 110000.dma-apbh: initialized
> [    0.311919] SCSI subsystem initialized
> [    0.315876] usbcore: registered new interface driver usbfs
> [    0.321440] usbcore: registered new interface driver hub
> [    0.326854] usbcore: registered new device driver usb
> [    0.333218] i2c i2c-0: IMX I2C adapter registered
> [    0.338665] i2c i2c-1: IMX I2C adapter registered
> [    0.344097] i2c i2c-2: IMX I2C adapter registered
> [    0.348996] pps_core: LinuxPPS API ver. 1 registered
> [    0.353989] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    0.363170] PTP clock support registered
> [    0.367981] clocksource: Switched to clocksource mxc_timer1
> [    0.373841] VFS: Disk quotas dquot_6.6.0
> [    0.377902] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096
> bytes)
> [    0.394255] NET: Registered protocol family 2
> [    0.399197] tcp_listen_portaddr_hash hash table entries: 512 (order:
> 0, 6144 bytes)
> [    0.406932] TCP established hash table entries: 8192 (order: 3, 32768
> bytes)
> [    0.414093] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.420715] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.427291] UDP hash table entries: 512 (order: 2, 16384 bytes)
> [    0.433288] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> [    0.439846] NET: Registered protocol family 1
> [    0.444268] PCI: CLS 0 bytes, default 64
> [    0.448405] Trying to unpack rootfs image as initramfs...
> [   13.138778] Freeing initrd memory: 21968K
> [   13.143193] hw perfevents: no interrupt-affinity property for /pmu,
> guessing.
> [   13.150628] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7
> counters available
> [   13.160714] workingset: timestamp_bits=30 max_order=18 bucket_order=0
> [   13.171611] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [   13.177956] bounce: pool size: 64 pages
> [   13.181837] io scheduler mq-deadline registered
> [   13.186401] io scheduler kyber registered
> [   13.193578] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000
> ranges:
> [   13.200635] imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff ->
> 0x00000000
> [   13.201454] imx-sdma 20ec000.sdma: loaded firmware 3.3
> [   13.208445] random: fast init done
> [   13.216275] imx-pgc-pd imx-pgc-power-domain.0: DMA mask not set
> [   13.222661] imx-pgc-pd imx-pgc-power-domain.1: DMA mask not set
> [   13.239568] random: crng init done
> [   34.207973] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   34.213742] rcu:     0-...!: (20992 ticks this GP)
> idle=94a/1/0x40000004 softirq=72/72 fqs=5
> [   34.222025]  (t=21000 jiffies g=2937 q=7)
> [   34.226048] rcu: rcu_preempt kthread starved for 20964 jiffies! g2937
> f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> [   34.236331] rcu: RCU grace-period kthread stack dump:
> [   34.241392] rcu_preempt     R  running task        0    10      2
> 0x00000000
> [   34.248489] [<c06b77e0>] (__schedule) from [<c06b7a50>]
> (schedule+0x58/0x104)
> [   34.255652] [<c06b7a50>] (schedule) from [<c06bb51c>]
> (schedule_timeout+0x15c/0x270)
> [   34.263427] [<c06bb51c>] (schedule_timeout) from [<c017f104>]
> (rcu_gp_kthread+0x548/0xab8)
> [   34.271721] [<c017f104>] (rcu_gp_kthread) from [<c013e78c>]
> (kthread+0x144/0x14c)
> [   34.279230] [<c013e78c>] (kthread) from [<c01010e8>]
> (ret_from_fork+0x14/0x2c)
> [   34.286469] Exception stack(0xe808bfb0 to 0xe808bff8)
> [   34.291534] bfa0:                                     00000000
> 00000000 00000000 00000000
> [   34.299731] bfc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [   34.307928] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   34.314559] NMI backtrace for cpu 0
> [   34.318061] CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.2.0-rc3 #1
> [   34.324515] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   34.331064] Workqueue: events_unbound async_run_entry_fn
> [   34.336404] [<c0110be4>] (unwind_backtrace) from [<c010bac0>]
> (show_stack+0x10/0x14)
> [   34.344174] [<c010bac0>] (show_stack) from [<c069f790>]
> (dump_stack+0x88/0x9c)
> [   34.351420] [<c069f790>] (dump_stack) from [<c06a5e88>]
> (nmi_cpu_backtrace+0x90/0xc4)
> [   34.359275] [<c06a5e88>] (nmi_cpu_backtrace) from [<c06a6020>]
> (nmi_trigger_cpumask_backtrace+0x164/0x1a4)
> [   34.368958] [<c06a6020>] (nmi_trigger_cpumask_backtrace) from
> [<c01810a4>] (rcu_dump_cpu_stacks+0xa4/0xcc)
> [   34.378640] [<c01810a4>] (rcu_dump_cpu_stacks) from [<c0180224>]
> (rcu_sched_clock_irq+0x7c4/0xa40)
> [   34.387630] [<c0180224>] (rcu_sched_clock_irq) from [<c01864b4>]
> (update_process_times+0x34/0x6c)
> [   34.396536] [<c01864b4>] (update_process_times) from [<c0197234>]
> (tick_sched_timer+0x4c/0xa8)
> [   34.405177] [<c0197234>] (tick_sched_timer) from [<c01876a8>]
> (__hrtimer_run_queues+0x154/0x1fc)
> [   34.413987] [<c01876a8>] (__hrtimer_run_queues) from [<c0187a84>]
> (hrtimer_interrupt+0x11c/0x2b0)
> [   34.422885] [<c0187a84>] (hrtimer_interrupt) from [<c010fa48>]
> (twd_handler+0x30/0x38)
> [   34.430829] [<c010fa48>] (twd_handler) from [<c0172e7c>]
> (handle_percpu_devid_irq+0x78/0x138)
> [   34.439379] [<c0172e7c>] (handle_percpu_devid_irq) from [<c016d424>]
> (generic_handle_irq+0x24/0x34)
> [   34.448449] [<c016d424>] (generic_handle_irq) from [<c016d9e0>]
> (__handle_domain_irq+0x5c/0xb4)
> [   34.457178] [<c016d9e0>] (__handle_domain_irq) from [<c0398cd0>]
> (gic_handle_irq+0x3c/0x78)
> [   34.465555] [<c0398cd0>] (gic_handle_irq) from [<c0101a8c>]
> (__irq_svc+0x6c/0xa8)
> [   34.473052] Exception stack(0xe8081a88 to 0xe8081ad0)
> [   34.478117] 1a80:                   2ad3e000 00000000 2ad3e000
> c0a60f00 00000002 00000000
> [   34.486317] 1aa0: 00000001 ffffe000 e800c000 c0b03080 c0b4eb88
> c0b4e688 04208060 e8081ad8
> [   34.494513] 1ac0: 04208060 c0102258 60000113 ffffffff
> [   34.499583] [<c0101a8c>] (__irq_svc) from [<c0102258>]
> (__do_softirq+0xb0/0x2ac)
> [   34.507004] [<c0102258>] (__do_softirq) from [<c01259c0>]
> (irq_exit+0xb0/0xd4)
> [   34.514250] [<c01259c0>] (irq_exit) from [<c016d9e4>]
> (__handle_domain_irq+0x60/0xb4)
> [   34.522103] [<c016d9e4>] (__handle_domain_irq) from [<c0398cd0>]
> (gic_handle_irq+0x3c/0x78)
> [   34.530477] [<c0398cd0>] (gic_handle_irq) from [<c0101a8c>]
> (__irq_svc+0x6c/0xa8)
> [   34.537974] Exception stack(0xe8081b68 to 0xe8081bb0)
> [   34.543039] 1b60:                   20000193 2ad3e000 00000000
> 20000113 00000001 00000000
> [   34.551238] 1b80: 00000053 00000000 e8080000 c01149e4 c0b4eb88
> c0b4e688 0000000a e8081bb8
> [   34.559433] 1ba0: c016ace4 c016acec 20000113 ffffffff
> [   34.564508] [<c0101a8c>] (__irq_svc) from [<c016acec>]
> (console_unlock+0x290/0x410)
> [   34.572190] [<c016acec>] (console_unlock) from [<c016c4f8>]
> (vprintk_emit+0x170/0x228)
> [   34.580134] [<c016c4f8>] (vprintk_emit) from [<c0429c48>]
> (dev_vprintk_emit+0x1d4/0x1f4)
> [   34.588247] [<c0429c48>] (dev_vprintk_emit) from [<c0429c94>]
> (dev_printk_emit+0x2c/0x50)
> [   34.596446] [<c0429c94>] (dev_printk_emit) from [<c0429d34>]
> (__dev_printk+0x7c/0x90)
> [   34.604297] [<c0429d34>] (__dev_printk) from [<c042a058>]
> (_dev_info+0x44/0x68)
> [   34.611636] [<c042a058>] (_dev_info) from [<c03c4154>]
> (devm_of_pci_get_host_bridge_resources+0x198/0x298)
> [   34.621322] [<c03c4154>] (devm_of_pci_get_host_bridge_resources) from
> [<c03d0a2c>] (dw_pcie_host_init+0xb4/0x544)
> [   34.631611] [<c03d0a2c>] (dw_pcie_host_init) from [<c03d261c>]
> (imx6_pcie_probe+0x3a0/0x6b8)
> [   34.640077] [<c03d261c>] (imx6_pcie_probe) from [<c042dd20>]
> (platform_drv_probe+0x48/0x98)
> [   34.648454] [<c042dd20>] (platform_drv_probe) from [<c042bfac>]
> (really_probe+0xf0/0x2c8)
> [   34.656656] [<c042bfac>] (really_probe) from [<c042c2e4>]
> (driver_probe_device+0x60/0x16c)
> [   34.664943] [<c042c2e4>] (driver_probe_device) from [<c042c440>]
> (__driver_attach_async_helper+0x50/0x54)
> [   34.674536] [<c042c440>] (__driver_attach_async_helper) from
> [<c014188c>] (async_run_entry_fn+0x44/0x118)
> [   34.684136] [<c014188c>] (async_run_entry_fn) from [<c013865c>]
> (process_one_work+0x17c/0x390)
> [   34.692775] [<c013865c>] (process_one_work) from [<c01393a0>]
> (worker_thread+0x44/0x518)
> [   34.700890] [<c01393a0>] (worker_thread) from [<c013e78c>]
> (kthread+0x144/0x14c)
> [   34.708307] [<c013e78c>] (kthread) from [<c01010e8>]
> (ret_from_fork+0x14/0x2c)
> [   34.715545] Exception stack(0xe8081fb0 to 0xe8081ff8)
> [   34.720607] 1fa0:                                     00000000
> 00000000 00000000 00000000
> [   34.728804] 1fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [   34.737000] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   40.259973] watchdog: BUG: soft lockup - CPU#1 stuck for 22s!
> [migration/1:15]
> [   40.267211] Modules linked in:
> [   40.270279] CPU: 1 PID: 15 Comm: migration/1 Not tainted 5.2.0-rc3 #1
> [   40.276732] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   40.283284] PC is at multi_cpu_stop+0xe0/0x124
> [   40.287738] LR is at multi_cpu_stop+0x114/0x124
> [   40.292279] pc : [<c01ae4d8>]    lr : [<c01ae50c>]    psr: 60000013
> [   40.298558] sp : e809df10  ip : 00000000  fp : 00000000
> [   40.303794] r10: 00000000  r9 : a0000013  r8 : 00000000
> [   40.309030] r7 : 00000001  r6 : e81cbea4  r5 : 00000001  r4 : e81cbeb8
> [   40.315571] r3 : 00000001  r2 : 00000000  r1 : 00000004  r0 : 00000000
> [   40.322114] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> Segment none
> [   40.329266] Control: 10c5387d  Table: 1000404a  DAC: 00000051
> [   40.335025] CPU: 1 PID: 15 Comm: migration/1 Not tainted 5.2.0-rc3 #1
> [   40.341477] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   40.348031] [<c0110be4>] (unwind_backtrace) from [<c010bac0>]
> (show_stack+0x10/0x14)
> [   40.355799] [<c010bac0>] (show_stack) from [<c069f790>]
> (dump_stack+0x88/0x9c)
> [   40.363047] [<c069f790>] (dump_stack) from [<c01af5c0>]
> (watchdog_timer_fn+0x244/0x2bc)
> [   40.371080] [<c01af5c0>] (watchdog_timer_fn) from [<c01876a8>]
> (__hrtimer_run_queues+0x154/0x1fc)
> [   40.379978] [<c01876a8>] (__hrtimer_run_queues) from [<c0187a84>]
> (hrtimer_interrupt+0x11c/0x2b0)
> [   40.388875] [<c0187a84>] (hrtimer_interrupt) from [<c010fa48>]
> (twd_handler+0x30/0x38)
> [   40.396818] [<c010fa48>] (twd_handler) from [<c0172e7c>]
> (handle_percpu_devid_irq+0x78/0x138)
> [   40.405367] [<c0172e7c>] (handle_percpu_devid_irq) from [<c016d424>]
> (generic_handle_irq+0x24/0x34)
> [   40.414434] [<c016d424>] (generic_handle_irq) from [<c016d9e0>]
> (__handle_domain_irq+0x5c/0xb4)
> [   40.423159] [<c016d9e0>] (__handle_domain_irq) from [<c0398cd0>]
> (gic_handle_irq+0x3c/0x78)
> [   40.431534] [<c0398cd0>] (gic_handle_irq) from [<c0101a8c>]
> (__irq_svc+0x6c/0xa8)
> [   40.439032] Exception stack(0xe809dec0 to 0xe809df08)
> [   40.444098] dec0: 00000000 00000004 00000000 00000001 e81cbeb8
> 00000001 e81cbea4 00000001
> [   40.452296] dee0: 00000000 a0000013 00000000 00000000 00000000
> e809df10 c01ae50c c01ae4d8
> [   40.460490] df00: 60000013 ffffffff
> [   40.463993] [<c0101a8c>] (__irq_svc) from [<c01ae4d8>]
> (multi_cpu_stop+0xe0/0x124)
> [   40.471586] [<c01ae4d8>] (multi_cpu_stop) from [<c01ae748>]
> (cpu_stopper_thread+0x8c/0x128)
> [   40.479963] [<c01ae748>] (cpu_stopper_thread) from [<c0142330>]
> (smpboot_thread_fn+0x150/0x2bc)
> [   40.488687] [<c0142330>] (smpboot_thread_fn) from [<c013e78c>]
> (kthread+0x144/0x14c)
> [   40.496450] [<c013e78c>] (kthread) from [<c01010e8>]
> (ret_from_fork+0x14/0x2c)
> [   40.503686] Exception stack(0xe809dfb0 to 0xe809dff8)
> [   40.508749] dfa0:                                     00000000
> 00000000 00000000 00000000
> [   40.516946] dfc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [   40.525142] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   40.531771] Kernel panic - not syncing: softlockup: hung tasks
> [   40.537619] CPU: 1 PID: 15 Comm: migration/1 Tainted: G             L
>    5.2.0-rc3 #1
> [   40.545464] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   40.552012] [<c0110be4>] (unwind_backtrace) from [<c010bac0>]
> (show_stack+0x10/0x14)
> [   40.559778] [<c010bac0>] (show_stack) from [<c069f790>]
> (dump_stack+0x88/0x9c)
> [   40.567028] [<c069f790>] (dump_stack) from [<c0120ec0>]
> (panic+0x114/0x324)
> [   40.574013] [<c0120ec0>] (panic) from [<c01af610>]
> (watchdog_timer_fn+0x294/0x2bc)
> [   40.581608] [<c01af610>] (watchdog_timer_fn) from [<c01876a8>]
> (__hrtimer_run_queues+0x154/0x1fc)
> [   40.590504] [<c01876a8>] (__hrtimer_run_queues) from [<c0187a84>]
> (hrtimer_interrupt+0x11c/0x2b0)
> [   40.599399] [<c0187a84>] (hrtimer_interrupt) from [<c010fa48>]
> (twd_handler+0x30/0x38)
> [   40.607338] [<c010fa48>] (twd_handler) from [<c0172e7c>]
> (handle_percpu_devid_irq+0x78/0x138)
> [   40.615886] [<c0172e7c>] (handle_percpu_devid_irq) from [<c016d424>]
> (generic_handle_irq+0x24/0x34)
> [   40.624953] [<c016d424>] (generic_handle_irq) from [<c016d9e0>]
> (__handle_domain_irq+0x5c/0xb4)
> [   40.633676] [<c016d9e0>] (__handle_domain_irq) from [<c0398cd0>]
> (gic_handle_irq+0x3c/0x78)
> [   40.642049] [<c0398cd0>] (gic_handle_irq) from [<c0101a8c>]
> (__irq_svc+0x6c/0xa8)
> [   40.649546] Exception stack(0xe809dec0 to 0xe809df08)
> [   40.654611] dec0: 00000000 00000004 00000000 00000001 e81cbeb8
> 00000001 e81cbea4 00000001
> [   40.662809] dee0: 00000000 a0000013 00000000 00000000 00000000
> e809df10 c01ae50c c01ae4d8
> [   40.671003] df00: 60000013 ffffffff
> [   40.674505] [<c0101a8c>] (__irq_svc) from [<c01ae4d8>]
> (multi_cpu_stop+0xe0/0x124)
> [   40.682096] [<c01ae4d8>] (multi_cpu_stop) from [<c01ae748>]
> (cpu_stopper_thread+0x8c/0x128)
> [   40.690469] [<c01ae748>] (cpu_stopper_thread) from [<c0142330>]
> (smpboot_thread_fn+0x150/0x2bc)
> [   40.699191] [<c0142330>] (smpboot_thread_fn) from [<c013e78c>]
> (kthread+0x144/0x14c)
> [   40.706954] [<c013e78c>] (kthread) from [<c01010e8>]
> (ret_from_fork+0x14/0x2c)
> [   40.714191] Exception stack(0xe809dfb0 to 0xe809dff8)
> [   40.719255] dfa0:                                     00000000
> 00000000 00000000 00000000
> [   40.727453] dfc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [   40.735650] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   40.742284] CPU0: stopping
> [   40.745004] CPU: 0 PID: 7 Comm: kworker/u4:0 Tainted: G             L
>    5.2.0-rc3 #1
> [   40.752850] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   40.759397] Workqueue: events_unbound async_run_entry_fn
> [   40.764731] [<c0110be4>] (unwind_backtrace) from [<c010bac0>]
> (show_stack+0x10/0x14)
> [   40.772497] [<c010bac0>] (show_stack) from [<c069f790>]
> (dump_stack+0x88/0x9c)
> [   40.779741] [<c069f790>] (dump_stack) from [<c010f100>]
> (handle_IPI+0x1a8/0x1d4)
> [   40.787159] [<c010f100>] (handle_IPI) from [<c0398d08>]
> (gic_handle_irq+0x74/0x78)
> [   40.794749] [<c0398d08>] (gic_handle_irq) from [<c0101a8c>]
> (__irq_svc+0x6c/0xa8)
> [   40.802247] Exception stack(0xe8081a88 to 0xe8081ad0)
> [   40.807311] 1a80:                   2ad3e000 00000000 2ad3e000
> c0a60f00 00000002 00000000
> [   40.815510] 1aa0: 00000001 ffffe000 e800c000 c0b03080 c0b4eb88
> c0b4e688 04208060 e8081ad8
> [   40.823706] 1ac0: 04208060 c0102258 60000113 ffffffff
> [   40.828774] [<c0101a8c>] (__irq_svc) from [<c0102258>]
> (__do_softirq+0xb0/0x2ac)
> [   40.836191] [<c0102258>] (__do_softirq) from [<c01259c0>]
> (irq_exit+0xb0/0xd4)
> [   40.843432] [<c01259c0>] (irq_exit) from [<c016d9e4>]
> (__handle_domain_irq+0x60/0xb4)
> [   40.851283] [<c016d9e4>] (__handle_domain_irq) from [<c0398cd0>]
> (gic_handle_irq+0x3c/0x78)
> [   40.859654] [<c0398cd0>] (gic_handle_irq) from [<c0101a8c>]
> (__irq_svc+0x6c/0xa8)
> [   40.867151] Exception stack(0xe8081b68 to 0xe8081bb0)
> [   40.872215] 1b60:                   20000193 2ad3e000 00000000
> 20000113 00000001 00000000
> [   40.880414] 1b80: 00000053 00000000 e8080000 c01149e4 c0b4eb88
> c0b4e688 0000000a e8081bb8
> [   40.888609] 1ba0: c016ace4 c016acec 20000113 ffffffff
> [   40.893680] [<c0101a8c>] (__irq_svc) from [<c016acec>]
> (console_unlock+0x290/0x410)
> [   40.901358] [<c016acec>] (console_unlock) from [<c016c4f8>]
> (vprintk_emit+0x170/0x228)
> [   40.909300] [<c016c4f8>] (vprintk_emit) from [<c0429c48>]
> (dev_vprintk_emit+0x1d4/0x1f4)
> [   40.917410] [<c0429c48>] (dev_vprintk_emit) from [<c0429c94>]
> (dev_printk_emit+0x2c/0x50)
> [   40.925608] [<c0429c94>] (dev_printk_emit) from [<c0429d34>]
> (__dev_printk+0x7c/0x90)
> [   40.933457] [<c0429d34>] (__dev_printk) from [<c042a058>]
> (_dev_info+0x44/0x68)
> [   40.940791] [<c042a058>] (_dev_info) from [<c03c4154>]
> (devm_of_pci_get_host_bridge_resources+0x198/0x298)
> [   40.950471] [<c03c4154>] (devm_of_pci_get_host_bridge_resources) from
> [<c03d0a2c>] (dw_pcie_host_init+0xb4/0x544)
> [   40.960757] [<c03d0a2c>] (dw_pcie_host_init) from [<c03d261c>]
> (imx6_pcie_probe+0x3a0/0x6b8)
> [   40.969220] [<c03d261c>] (imx6_pcie_probe) from [<c042dd20>]
> (platform_drv_probe+0x48/0x98)
> [   40.977593] [<c042dd20>] (platform_drv_probe) from [<c042bfac>]
> (really_probe+0xf0/0x2c8)
> [   40.985792] [<c042bfac>] (really_probe) from [<c042c2e4>]
> (driver_probe_device+0x60/0x16c)
> [   40.994079] [<c042c2e4>] (driver_probe_device) from [<c042c440>]
> (__driver_attach_async_helper+0x50/0x54)
> [   41.003671] [<c042c440>] (__driver_attach_async_helper) from
> [<c014188c>] (async_run_entry_fn+0x44/0x118)
> [   41.013266] [<c014188c>] (async_run_entry_fn) from [<c013865c>]
> (process_one_work+0x17c/0x390)
> [   41.021902] [<c013865c>] (process_one_work) from [<c01393a0>]
> (worker_thread+0x44/0x518)
> [   41.030015] [<c01393a0>] (worker_thread) from [<c013e78c>]
> (kthread+0x144/0x14c)
> [   41.037430] [<c013e78c>] (kthread) from [<c01010e8>]
> (ret_from_fork+0x14/0x2c)
> [   41.044667] Exception stack(0xe8081fb0 to 0xe8081ff8)
> [   41.049730] 1fa0:                                     00000000
> 00000000 00000000 00000000
> [   41.057926] 1fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [   41.066123] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [   41.072758] Rebooting in 30 seconds..
> 
> 

-- 
Robert Hancock
Senior Software Developer
SED Systems, a division of Calian Ltd.
Email: hancock@sedsystems.ca
