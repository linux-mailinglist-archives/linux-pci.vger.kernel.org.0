Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB250B02
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 14:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfFXMnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 08:43:19 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17937 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXMnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 08:43:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d10c5660000>; Mon, 24 Jun 2019 05:43:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Jun 2019 05:43:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Jun 2019 05:43:16 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 12:43:13 +0000
Subject: Re: [PATCH v2] PCI: PM: Skip devices in D0 for suspend-to-idle
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <1668247.RaJIPSxJUN@kreacher>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9906d02b-8c77-f2c8-7168-93ea444b950e@nvidia.com>
Date:   Mon, 24 Jun 2019 13:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1668247.RaJIPSxJUN@kreacher>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561380198; bh=72hRzQ5M8WqLC8S6DA2yTe1zPRLknqSL8+/TVaDaFhE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Z1z+yCpiXNVynehrsas1bZqY3T9qdWUeAhzPU6f/JOfbw9VUrS9U0MdoK8mOtnQNb
         JtvRSp5T/ZiBCpI7nRsCi3EfSssXicJjE2SCCX3XGsyK7+kw2WjUHto0fqMVO2Vvop
         FPq5mMXOrTDWnif8COXExigBmxhiLdzX7We8Csyj8jIfeR0LbOYaMNIGir/DFWlF5E
         ivh41Y+Qf1T2+P71jrdfUEBJfc9OCLOUgoRf0cXga69SFV37wD9AMBem8cqEOvWsyD
         BcLXG66oXzCNoBiK9mAdHAZ3Hjw2dFw/vYJwtzXEH9GKg53lmbPeeiOkIOWKSQzNFi
         ina+6lDzPELsA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On 13/06/2019 22:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> attempted to avoid a problem with devices whose drivers want them to
> stay in D0 over suspend-to-idle and resume, but it did not go as far
> as it should with that.
> 
> Namely, first of all, the power state of a PCI bridge with a
> downstream device in D0 must be D0 (based on the PCI PM spec r1.2,
> sec 6, table 6-1, if the bridge is not in D0, there can be no PCI
> transactions on its secondary bus), but that is not actively enforced
> during system-wide PM transitions, so use the skip_bus_pm flag
> introduced by commit d491f2b75237 for that.
> 
> Second, the configuration of devices left in D0 (whatever the reason)
> during suspend-to-idle need not be changed and attempting to put them
> into D0 again by force is pointless, so explicitly avoid doing that.
> 
> Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I have noticed a regression in both the mainline and -next branches on
one of our boards when testing suspend. The bisect is point to this
commit and reverting on top of mainline does fix the problem. So far I
have not looked at this in close detail but kernel log is showing ...

[   52.775138] PM: suspend entry (deep)
[   52.779040] Filesystems sync: 0.000 seconds
[   52.783476] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   52.791891] OOM killer disabled.
[   52.795174] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   52.803752] printk: Suspending console(s) (use no_console_suspend to debug)
[   52.823750] r8169 0000:01:00.0 eth0: Link is Down
[   52.823908] pci_generic_config_write32: 22 callbacks suppressed
[   52.823914] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x9c may corrupt adjacent RW1C bits
[   53.045383] Disabling non-boot CPUs ...
[   53.048481] Entering suspend state LP1
[   53.048508] Enabling non-boot CPUs ...
[   53.049402] CPU1 is up
[   53.050182] CPU2 is up
[   53.051017] CPU3 is up
[   53.051613] tegra-pcie 1003000.pcie: probing port 1, using 1 lanes
[   53.069689] pcieport 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
[   53.093751] r8169 0000:01:00.0: Refused to change power state, currently in D3
[   53.156586] tegra-pcie 1003000.pcie: Slot present pin change, signature: 00000004
[   53.156593] tegra-pcie 1003000.pcie: Response decoding error, signature: 10010045
[   53.156596] tegra-pcie 1003000.pcie:   FPCI address: fe10010044
[   53.156711] tegra-pcie 1003000.pcie: Response decoding error, signature: 2000000c
[   53.156714] tegra-pcie 1003000.pcie:   FPCI address:   2000000c
[   53.156719] tegra-pcie 1003000.pcie: Response decoding error, signature: 20000001
[   53.156722] tegra-pcie 1003000.pcie:   FPCI address:   20000000
[   53.177372] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x88 may corrupt adjacent RW1C bits
[   53.177379] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x90 may corrupt adjacent RW1C bits
[   53.177384] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x98 may corrupt adjacent RW1C bits
[   53.177389] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x9c may corrupt adjacent RW1C bits
[   53.177394] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0xa8 may corrupt adjacent RW1C bits
[   53.177399] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0xb0 may corrupt adjacent RW1C bits
[   53.177451] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x52 may corrupt adjacent RW1C bits
[   53.177461] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x52 may corrupt adjacent RW1C bits
[   53.177470] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x5c may corrupt adjacent RW1C bits
[   53.187746] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   53.188030] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.224105] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.224394] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.224679] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.224966] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.225247] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.225528] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.225813] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.226089] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.226372] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.226654] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.226934] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.227213] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.227495] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.227773] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.228050] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.228326] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.228609] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.228896] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   53.229181] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.064108] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.064429] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.064713] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.064996] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.065013] Generic Realtek PHY r8169-100:00: Master/Slave resolution failed, maybe conflicting manual settings?
[   54.065016] ------------[ cut here ]------------
[   54.065025] WARNING: CPU: 1 PID: 617 at /home/jonathanh/workdir/tegra/mlt-linux_torvalds/kernel/drivers/net/phy/phy.c:735 phy_error+0x1c/0x54
[   54.065028] Modules linked in: ttm
[   54.065039] CPU: 1 PID: 617 Comm: kworker/1:2 Not tainted 5.2.0-rc6 #1
[   54.065041] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   54.065049] Workqueue: events_power_efficient phy_state_machine
[   54.065068] [<c0112244>] (unwind_backtrace) from [<c010cad8>] (show_stack+0x10/0x14)
[   54.065075] [<c010cad8>] (show_stack) from [<c0a60624>] (dump_stack+0xb4/0xc8)
[   54.065082] [<c0a60624>] (dump_stack) from [<c0123cbc>] (__warn+0xe0/0xf8)
[   54.065090] [<c0123cbc>] (__warn) from [<c0123dec>] (warn_slowpath_null+0x40/0x48)
[   54.065095] [<c0123dec>] (warn_slowpath_null) from [<c06173f8>] (phy_error+0x1c/0x54)
[   54.065101] [<c06173f8>] (phy_error) from [<c06184ec>] (phy_state_machine+0x64/0x1c0)
[   54.065112] [<c06184ec>] (phy_state_machine) from [<c013e744>] (process_one_work+0x204/0x578)
[   54.065119] [<c013e744>] (process_one_work) from [<c013f444>] (worker_thread+0x44/0x584)
[   54.065123] [<c013f444>] (worker_thread) from [<c01445d4>] (kthread+0x148/0x150)
[   54.065128] [<c01445d4>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[   54.065131] Exception stack(0xe91b3fb0 to 0xe91b3ff8)
[   54.065134] 3fa0:                                     00000000 00000000 00000000 00000000
[   54.065138] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   54.065141] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   54.065145] ---[ end trace f59188238fc6fed4 ]---
[   54.065168] r8169 0000:01:00.0 eth0: Link is Down
[   54.075411] r8169 0000:01:00.0 eth0: rtl_chipcmd_cond == 1 (loop: 100, delay: 100).
[   54.085652] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.095833] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.106017] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.116214] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.126419] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.136613] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.146829] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.157030] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.167223] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.177433] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.187635] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.197840] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
[   54.199008] r8169 0000:01:00.0 eth0: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
[   54.200173] r8169 0000:01:00.0 eth0: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
[   54.201336] r8169 0000:01:00.0 eth0: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
[   54.202502] r8169 0000:01:00.0 eth0: rtl_ephyar_cond == 1 (loop: 100, delay: 10).
[   54.203018] r8169 0000:01:00.0 eth0: rtl_ocp_gphy_cond == 1 (loop: 10, delay: 25).
[   54.546178] ata1: SATA link down (SStatus 0 SControl 300)
[   56.810813] OOM killer enabled.
[   56.813953] Restarting tasks ... done.
[   56.819622] PM: suspend exit
[   72.504381] nfs: server 192.168.99.1 not responding, still trying
[   78.104369] nfs: server 192.168.99.1 not responding, still trying

Let me know if you have any thoughts.

Cheers
Jon

-- 
nvpublic
