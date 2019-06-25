Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C734D54F24
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfFYMqN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 08:46:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13364 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfFYMqM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 08:46:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d12178f0000>; Tue, 25 Jun 2019 05:46:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 25 Jun 2019 05:46:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 25 Jun 2019 05:46:09 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Jun
 2019 12:46:06 +0000
Subject: Re: [PATCH v2] PCI: PM: Skip devices in D0 for suspend-to-idle
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <1668247.RaJIPSxJUN@kreacher>
 <9906d02b-8c77-f2c8-7168-93ea444b950e@nvidia.com>
 <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b562e5b6-68f5-d267-1529-72b881006534@nvidia.com>
Date:   Tue, 25 Jun 2019 13:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561466767; bh=ERBHrU4QDgCswI3zylKwm8dVXWmR44kgqk1oVpS1FV8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=opy9uQyN2DI5EfKPN5VlXUlQwN5LZhN7gkSIh1adjQbR+Qv5oWGDSfZLnl/IGH99w
         d3FPGzH578syAx5NW2Exym4UdLbcGFTQVRHkVW2tvDnFWwk7UJak6FT+d9K7ag68XA
         zlY4zXkrjdB/jceVyIL//YOHs/1weBTyNdJ3B72sPS3sT7VRVZaDJ4AeJ00osKYv33
         84i2pMSFVSwXAdO8q9qkk4qv+/7hIvXHXuRMmzxTUDoqGRNQljdJSN4ndGoYyZz9eF
         ekn1o7Q3BjAQkyOeJ0SQTsW+f884IxUuTYwmdNnh+uzR2dkLtkM46nvcG7YQtkZlBI
         vtbDJPP7NB9vw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 24/06/2019 22:37, Rafael J. Wysocki wrote:
> On Mon, Jun 24, 2019 at 2:43 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>> Hi Rafael,
>>
>> On 13/06/2019 22:59, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
>>> attempted to avoid a problem with devices whose drivers want them to
>>> stay in D0 over suspend-to-idle and resume, but it did not go as far
>>> as it should with that.
>>>
>>> Namely, first of all, the power state of a PCI bridge with a
>>> downstream device in D0 must be D0 (based on the PCI PM spec r1.2,
>>> sec 6, table 6-1, if the bridge is not in D0, there can be no PCI
>>> transactions on its secondary bus), but that is not actively enforced
>>> during system-wide PM transitions, so use the skip_bus_pm flag
>>> introduced by commit d491f2b75237 for that.
>>>
>>> Second, the configuration of devices left in D0 (whatever the reason)
>>> during suspend-to-idle need not be changed and attempting to put them
>>> into D0 again by force is pointless, so explicitly avoid doing that.
>>>
>>> Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
>>> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> I have noticed a regression in both the mainline and -next branches on
>> one of our boards when testing suspend. The bisect is point to this
>> commit and reverting on top of mainline does fix the problem. So far I
>> have not looked at this in close detail but kernel log is showing ...
> 
> Can you please collect a log like that, but with dynamic debug in
> pci-driver.c enabled?

Yes, here you go ...

[   52.939258] PM: suspend entry (deep)
[   52.942963] Filesystems sync: 0.000 seconds
[   52.947596] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   52.956145] OOM killer disabled.
[   52.959371] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   52.968088] printk: Suspending console(s) (use no_console_suspend to debug)
[   52.992168] r8169 0000:01:00.0 eth0: Link is Down
[   52.992245] pci_generic_config_write32: 22 callbacks suppressed
[   52.992250] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x9c may corrupt adjacent RW1C bits
[   53.204186] r8169 0000:01:00.0: PCI PM: Suspend power state: D3hot
[   53.204221] pcieport 0000:00:02.0: PCI PM: Suspend power state: D0
[   53.204224] pcieport 0000:00:02.0: PCI PM: Skipped
[   53.215716] Disabling non-boot CPUs ...
[   53.218833] Entering suspend state LP1
[   53.218860] Enabling non-boot CPUs ...
[   53.219731] CPU1 is up
[   53.220482] CPU2 is up
[   53.221289] CPU3 is up
[   53.221850] tegra-pcie 1003000.pcie: probing port 1, using 1 lanes
[   53.239925] pcieport 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
[   53.264145] r8169 0000:01:00.0: Refused to change power state, currently in D3
[   53.326969] tegra-pcie 1003000.pcie: Slot present pin change, signature: 00000004
[   53.326975] tegra-pcie 1003000.pcie: Response decoding error, signature: 10010045
[   53.326978] tegra-pcie 1003000.pcie:   FPCI address: fe10010044
[   53.327091] tegra-pcie 1003000.pcie: Response decoding error, signature: 2000000c
[   53.327095] tegra-pcie 1003000.pcie:   FPCI address:   2000000c
[   53.327099] tegra-pcie 1003000.pcie: Response decoding error, signature: 20000001
[   53.327102] tegra-pcie 1003000.pcie:   FPCI address:   20000000
[   53.347944] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x88 may corrupt adjacent RW1C bits
[   53.347955] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x90 may corrupt adjacent RW1C bits
[   53.347962] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x98 may corrupt adjacent RW1C bits
[   53.347969] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x9c may corrupt adjacent RW1C bits
[   53.347977] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0xa8 may corrupt adjacent RW1C bits
[   53.347984] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0xb0 may corrupt adjacent RW1C bits
[   53.348025] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x52 may corrupt adjacent RW1C bits
[   53.348033] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x52 may corrupt adjacent RW1C bits
[   53.348043] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x5c may corrupt adjacent RW1C bits
[   53.358310] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   53.358592] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.394498] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.394789] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.395072] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.395352] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.395635] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.395919] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.396209] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.396488] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.396771] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.397055] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.397330] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.397608] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.397884] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.398162] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.398441] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.398721] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.399006] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.399295] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.399579] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.234501] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.234819] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.235104] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.235386] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.235403] Generic Realtek PHY r8169-100:00: Master/Slave resolution failed, maybe conflicting manual settings?
[   54.235406] ------------[ cut here ]------------
[   54.235416] WARNING: CPU: 3 PID: 112 at /home/jonathanh/workdir/tegra/mlt-linux_torvalds/kernel/drivers/net/phy/phy.c:735 phy_error+0x1c/0x54
[   54.235419] Modules linked in: ttm
[   54.235429] CPU: 3 PID: 112 Comm: kworker/3:1 Not tainted 5.2.0-rc6-dirty #3
[   54.235431] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   54.235441] Workqueue: events_power_efficient phy_state_machine
[   54.235455] [<c0112244>] (unwind_backtrace) from [<c010cad8>] (show_stack+0x10/0x14)
[   54.235463] [<c010cad8>] (show_stack) from [<c0a606a4>] (dump_stack+0xb4/0xc8)
[   54.235471] [<c0a606a4>] (dump_stack) from [<c0123cbc>] (__warn+0xe0/0xf8)
[   54.235477] [<c0123cbc>] (__warn) from [<c0123dec>] (warn_slowpath_null+0x40/0x48)
[   54.235482] [<c0123dec>] (warn_slowpath_null) from [<c0617470>] (phy_error+0x1c/0x54)
[   54.235488] [<c0617470>] (phy_error) from [<c0618564>] (phy_state_machine+0x64/0x1c0)
[   54.235498] [<c0618564>] (phy_state_machine) from [<c013e744>] (process_one_work+0x204/0x578)
[   54.235503] [<c013e744>] (process_one_work) from [<c013f444>] (worker_thread+0x44/0x584)
[   54.235507] [<c013f444>] (worker_thread) from [<c01445d4>] (kthread+0x148/0x150)
[   54.235512] [<c01445d4>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[   54.235515] Exception stack(0xe9ea1fb0 to 0xe9ea1ff8)
[   54.235518] 1fa0:                                     00000000 00000000 00000000 00000000
[   54.235522] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   54.235525] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   54.235528] ---[ end trace 772a7ce78ffff5e6 ]---
[   54.235551] r8169 0000:01:00.0 eth0: Link is Down
[   54.245804] r8169 0000:01:00.0 eth0: rtl_chipcmd_cond == 1 (loop: 100, delay: 100).
[   54.256058] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.266257] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.276454] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.286656] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.296860] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.307064] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.317263] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.327464] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.337660] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.347902] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.358102] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.368303] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.369471] r8169 0000:01:00.0 eth0: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
[   54.370637] r8169 0000:01:00.0 eth0: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
[   54.371799] r8169 0000:01:00.0 eth0: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
[   54.372961] r8169 0000:01:00.0 eth0: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
[   54.373416] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.716510] ata1: SATA link down (SStatus 0 SControl 300)
[   56.998780] OOM killer enabled.
[   57.001909] Restarting tasks ... done.
[   57.007392] PM: suspend exit
[   73.144767] nfs: server 192.168.99.1 not responding, still trying
[   77.624567] nfs: server 192.168.99.1 not responding, still trying

Cheers
Jon

-- 
nvpublic
