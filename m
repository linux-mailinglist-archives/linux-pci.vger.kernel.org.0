Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B173C537916
	for <lists+linux-pci@lfdr.de>; Mon, 30 May 2022 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiE3KND (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 May 2022 06:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiE3KNB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2022 06:13:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100D03EBB4;
        Mon, 30 May 2022 03:12:59 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.170]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsqMq-1ng8ps2W1Q-00t8kq; Mon, 30 May 2022 12:12:40 +0200
Message-ID: <d7a5a0d8-5d27-548f-bc94-0e7d116cc3f2@i2se.com>
Date:   Mon, 30 May 2022 12:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Fix regression regarding missing
 PCIe linkup
Content-Language: en-US
To:     Cyril Brulebois <kibi@debian.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, james.dutton@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220528224423.7017-1-jim2101024@gmail.com>
 <20220528224423.7017-2-jim2101024@gmail.com>
 <20220529011526.4lzuvkv5zclwntce@mraw.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220529011526.4lzuvkv5zclwntce@mraw.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X6zz3xruG0Mm0SMgqnOkGTso0yDamTe+KRXiTUlbqs5HZaqCveg
 rzksIO55d/mQd5xz7K8MAXsHCwzaRwKa/OFnFAbtmhwFJ19Yd5DilErjXQqmuUGWSCN1tE6
 +4FbPflYIzWXLaQKWxUzCOpdXObMENXC2FeVMub78d0K6lHXnFfCTmWg1Pu/NxhVdBA+doX
 5qJvXWtqnwsz7fzBjqVEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LRdd73yRQww=:nG5PWsEl7zYYnqWa0BeYSj
 +9vqf4ScijIgOrkgtCwd1QdQatG/Um7nxdC9iZ1xrl8IJ8lo5vVTtR6DI3Qz7SWHejT4TeJZz
 0FwbLSrQ+KrKDSvawm28lQBtvnIlHNx2A+1j0lMGwIc5YwUY45KPGKAVtrz4JQgsVnDQJ3vVS
 fI2Sg6u6Tltvp74pXLmkw4uoF9LVrCOA/fYB7V4GILAtHUnhmYB94H9ot6W/+FB1Da0eqQ7Fy
 6kqBRqk7U2XY4nlustpfCGsFDW41w+QsVQj0CfhyEymBEAmRSOL+NW5s5HrgA0K9qEPKgj6h7
 gAoo858DxJz2GUZy5ztS8RwkDLbFyLV8bArrCl6aSXXE+gG511TBTfQa0fnKYpHKcsHwqHQrq
 q1zjYSVpI8+Wxl+p6gQQgvXUJJ2uSC+M448yg0Q+s8LpHra8NZFyuOjBLwfstt0EG8SdUKRCO
 4PX9IR6O8jWSEmSyv5gFCymRh6zUal9WdR/8bMOHwB0LXIEostu+LNgU71p4Dge6oOanW8t00
 e6ufB+f8yfadvu1SSAKAw7rFU1pvdqzvzgug6CVln2EDV+VEtyhXN7zuLOZ2bmdRfNwyCZjdG
 5sW17bbXU1avWkxvon2X845xzvctSOu59I1xgditqUnv/TOW07oLdbiGgP4kWt7YIe6kunfsL
 +0Wl9xLRHaOTXCDCl+b8cj1LXZ6BPXROSMgDjkzQg+//LAgNufJykro3OjM3Cq1okUnAfFp4q
 WXweEMiTvZWuYQXuA9pvYkjv/3R9duySR9VtBWYRaAF1Un4QcZnX4yIqRKA=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Cyril,

Am 29.05.22 um 03:15 schrieb Cyril Brulebois:
> Hi Jim,
>
> Jim Quinlan <jim2101024@gmail.com> (2022-05-28):
>> commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
>>
>> introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
>> root port DT node described in [2] was missing, no linkup would be attempted,
>> and subsequent accesses would cause a panic because this particular PCIe HW
>> causes a CPU abort on illegal accesses (instead of returning 0xffffffff).
>>
>> We fix this by allowing the DT root port node to be missing, as it behaved
>> before the original patchset messed things up.
>>
>> In addition, two small changes are made:
>>
>>    1. Having pci_subdev_regulators_remove_bus() call
>>       regulator_bulk_free() in addtion to regulator_bulk_disable().
>>    2. Having brcm_pcie_add_bus() return 0 if there is an
>>       error in calling pci_subdev_regulators_add_bus().
>>       Instead, we dev_err() and turn on our refusal mode instead.
>>
>> It would be best if this commit were tested by someone with a Rpi CM4
>> platform, as that is how the regression was found.  I have only emulated
>> the problem and fix on different platform.
> Testing is less flawless than it was with the earlier version, but this
> might be related to the fact master has moved a lot since then (from
> v5.18-rcX to open merge window).
>
> Overall, it's still a net win over the status quo (broken boot).
>
>
> Applying your patch on 664a393a2663a0f62fc1b18157ccae33dcdbb8c8 and
> performing cold boots is mostly fine:
>   - without anything on the PCIe slot;
>   - with a PCIe→quad-USB extension board, a USB keyboard and a USB stick
>     (both work fine).
>
> However, with an empty PCIe slot, I'm no longer able to perform the
> following (which was rock solid, and has been used in all my testing up
> to now):
>   - boot the exact same Debian stable image as before (running v5.10.y if
>     that matters);
>   - deploy the patched kernel;
>   - enable serial console;
>   - reboot into the patched kernel.
>
> PCI-related messages, a call trace, and broken storage:
>
>      [    3.425331] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 ranges:
>      [    3.425353] brcm-pcie fd500000.pcie:   No bus range found for /scb/pcie@7d500000, using [bus 00-ff]
>      [    3.425388] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603ffffff -> 0x00f8000000
>      [    3.425420] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x003fffffff -> 0x0400000000
>      [    3.426229] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
>      [    3.426243] pci_bus 0000:00: root bus resource [bus 00-ff]
>      [    3.426255] pci_bus 0000:00: root bus resource [mem 0x600000000-0x603ffffff] (bus address [0xf8000000-0xfbffffff])
>      [    3.426303] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
>      [    3.426398] pci 0000:00:00.0: PME# supported from D0 D3hot
>      [    3.428797] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>      [    3.745909] brcm-pcie fd500000.pcie: link down
>      [    3.747915] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>      [    3.747944] pci 0000:00:00.0: PCI bridge to [bus 01]
>      [    3.748294] pcieport 0000:00:00.0: PME: Signaling with IRQ 23
>      [    3.748691] pcieport 0000:00:00.0: AER: enabled with IRQ 23
>      [    3.749201] pci_bus 0000:01: busn_res: [bus 01] is released
>      [    3.749462] pci_bus 0000:00: busn_res: [bus 00-ff] is released
>      …
>      [    5.617308] irq 35: nobody cared (try booting with the "irqpoll" option)
>      [    5.617335] CPU: 0 PID: 127 Comm: systemd-udevd Not tainted 5.18.0+ #1
>      [    5.617350] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
>      [    5.617358] Call trace:
>      [    5.617362]  dump_backtrace+0xc0/0x130
>      [    5.617386]  show_stack+0x24/0x70
>      [    5.617396]  dump_stack_lvl+0x68/0x84
>      [    5.617415]  dump_stack+0x18/0x34
>      [    5.617426]  __report_bad_irq+0x54/0x16c
>      [    5.617436]  note_interrupt+0x324/0x41c
>      [    5.617445]  handle_irq_event+0xc0/0x180
>      [    5.617460]  handle_fasteoi_irq+0xc8/0x1fc
>      [    5.617468]  generic_handle_domain_irq+0x38/0x50
>      [    5.617481]  gic_handle_irq+0x68/0xa0
>      [    5.617489]  call_on_irq_stack+0x2c/0x60
>      [    5.617500]  do_interrupt_handler+0x88/0x90
>      [    5.617511]  el0_interrupt+0x58/0x124
>      [    5.617526]  __el0_irq_handler_common+0x18/0x2c
>      [    5.617538]  el0t_64_irq_handler+0x10/0x20
>      [    5.617549]  el0t_64_irq+0x18c/0x190
>      [    5.617558] handlers:
>      [    5.617563] [<(____ptrval____)>] sdhci_irq [sdhci] threaded [<(____ptrval____)>] sdhci_thread_irq [sdhci]
>      [    5.617613] Disabling IRQ #35
>      …
>      [   15.581894] mmc0: Timeout waiting for hardware cmd interrupt.
>      [   15.581914] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>      [   15.581920] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
>      [   15.581931] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
>      [   15.581937] mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
>      [   15.581944] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000001
>      [   15.581951] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
>      [   15.581957] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00007d07
>      [   15.581964] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00018000
>      [   15.581971] mmc0: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
>      [   15.581976] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
>      [   15.581982] mmc0: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
>      [   15.581988] mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00080008
>      [   15.581996] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
>      [   15.582001] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>      [   15.582005] mmc0: sdhci: Host ctl2: 0x00000000
>      [   15.582011] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
>      [   15.582016] mmc0: sdhci: ============================================
>
> This last part gets repeated over and over, and storage (external SD
> card) never comes up. I can share fuller logs if that's desirable. I can
> also test booting with irqpoll if that's desirable. Or anything else that
> might help.
>
>
> I did check that applying the same patch on top of the v5.18 tag gives
> good results (cold boots and reboots are fine, with or without an empty
> PCIe slot, as that was the case during earlier test sessions), so I'd
> guess something changed since then, and makes reboots more brittle than
> they used to be.

i think we should better trust the results based on the v5.18 tag. 
During the merge window, regressions from other subsystems are possible.

Best regards

>
> I can also check applying the v1 patch on top of master and compare
> results, to give a different perspective.
>
> But I'd also be happy to get some directions as to which test(s) would
> be most beneficial, which would help me cut down on combinatorics.
>
>
> Cheers,
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
