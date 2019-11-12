Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B152F84F4
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 01:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKLANF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 19:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfKLANE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 19:13:04 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D28F20840;
        Tue, 12 Nov 2019 00:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573517583;
        bh=mKhT5dTY2Qb9HHDx4CjMQCqCrclZK8nXKrRsR/6szJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qjMrQWKicxEygqXW41hZe26x+p2++BZFWqfP6SiGMqP4vjgfXQflh8CoCeRXefVMO
         hBsRp7ZkvFX9TxYI5gZWR3cmHCoMtfPs2vy9L89bBA1gcNfnONEVSG6rsRW/Skx6A0
         Ee3IUqoPmeALilGFOZomPDZ0TJI+9GiLEB9/U/EM=
Date:   Mon, 11 Nov 2019 18:13:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [BUG] rk3399-rockpro64 pcie synchronous external abort
Message-ID: <20191112001301.GA76049@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYoTwjKz4EN8PtD5pZfu3+SX+68JL+dfvmCrSnLL=K6Few@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 04, 2019 at 01:55:40PM -0500, Peter Geis wrote:
> Good Morning,
> 
> I'm attempting to debug an issue with the rockpro64 pcie port.
> It would appear that the port does not like various cards, including
> cards of the same make that randomly work or do not work, such as
> Intel i340 based NICs.
> I'm experiencing it with a GTX645 gpu.
> 
> This seems to be a long running issue, referenced both at [0], and [1].
> There was an attempt to rectify it, by adding a delay between training
> and probing [2], but that doesn't seem to be the issue here.
> It appears that when we probe further into the card, such as devfn >
> 1, we trigger the bug.
> I've added a print statement that prints the devfn, address, and size
> information, which you can see below.
> 
> I've attempted setting the available number of lanes to 1 as well, to
> no difference.
> 
> If anyone could point me in the right direction as to where to
> continue debugging, I'd greatly appreciate it.
> 
> [0] https://github.com/ayufan-rock64/linux-build/issues/254
> [1] https://github.com/rockchip-linux/kernel/issues/116
> [2] https://github.com/ayufan-rock64/linux-kernel/commit/3cde5c624c9c39aa03251a55c2d26a48b5bdca5b
> 
> [  198.491458] rockchip-pcie f8000000.pcie: missing legacy phy; search
> for per-lane PHY
> [  198.492986] rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
> [  198.493060] rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
> [  198.550444] rockchip-pcie f8000000.pcie: current link width is x1
> [  198.550458] rockchip-pcie f8000000.pcie: idling lane 1
> [  198.550479] rockchip-pcie f8000000.pcie: idling lane 2
> [  198.550490] rockchip-pcie f8000000.pcie: idling lane 3
> [  198.550608] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> [  198.550625] rockchip-pcie f8000000.pcie: Parsing ranges property...
> [  198.550656] rockchip-pcie f8000000.pcie:   MEM
> 0xfa000000..0xfbdfffff -> 0xfa000000
> [  198.550676] rockchip-pcie f8000000.pcie:    IO
> 0xfbe00000..0xfbefffff -> 0xfbe00000
> [  198.552908] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> [  198.552933] pci_bus 0000:00: root bus resource [bus 00-1f]
> [  198.552943] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
> [  198.552954] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> (bus address [0xfbe00000-0xfbefffff])
> [  198.552965] pci_bus 0000:00: scanning bus
> [  198.554198] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
> [  198.555508] pci 0000:00:00.0: supports D1
> [  198.555516] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> [  198.556023] pci 0000:00:00.0: PME# disabled
> [  198.561245] pci_bus 0000:00: fixups for bus
> [  198.561269] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
> [  198.561277] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [  198.566429] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> [  198.567008] pci_bus 0000:01: scanning bus
> [  198.567171] pci 0000:01:00.0: [10de:11c4] type 00 class 0x030000
> [  198.567420] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00ffffff]
> [  198.567515] pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x07ffffff
> 64bit pref]
> [  198.567608] pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x01ffffff
> 64bit pref]
> [  198.567665] pci 0000:01:00.0: reg 0x24: initial BAR value 0x00000000 invalid
> [  198.567673] pci 0000:01:00.0: reg 0x24: [io  size 0x0080]
> [  198.567730] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
> [  198.567815] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
> [  198.569051] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
> limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 126.016 Gb/s
> with 8 GT/s x16 link)
> [  198.570225] pci 0000:01:00.0: vgaarb: VGA device added:
> decodes=io+mem,owns=none,locks=none
> [  198.570481] pci 0000:01:00.1: [10de:0e0b] type 00 class 0x040300
> [  198.570663] pci 0000:01:00.1: reg 0x10: [mem 0x00000000-0x00003fff]
> [  198.571039] pci 0000:01:00.1: Max Payload Size set to 256 (was 128, max 256)
> <snip>
> [  198.749857] pci_bus 0000:01: read pcie, devfn 1, at 100, size 2
> [  198.750252] pci_bus 0000:01: read pcie, devfn 2, at 0, size 4
> [  198.750881] Internal error: synchronous external abort: 96000210
> [#1] PREEMPT SMP

Is there really supposed to be a device at 01:00.2?

Maybe this is just the PCIe Unsupported Request error that we expect
to get when trying to read config space of a device that doesn't
exist.

On "most" platforms, we just get ~0 data back when that happens, but
I'm not sure that's always the case on arm64.  I think it depends on
how the PCIe host bridge is designed, and there might be some CPU
configuration, too.

> [  198.751581] Modules linked in: drm_panel_orientation_quirks
> pcie_rockchip_host(+) cpufreq_dt sch_fq_codel ip_tables x_tables ipv6
> crc_ccitt nf_defrag_ipv6
> [  198.752861] CPU: 1 PID: 1686 Comm: systemd-udevd Not tainted
> 5.4.0-rc5-next-20191031-00001-gddbfb17ac1c4-dirty #5
> [  198.753791] Hardware name: Pine64 RockPro64 (DT)
> [  198.754215] pstate: 60400085 (nZCv daIf +PAN -UAO)
> [  198.754672] pc : __raw_readl+0x0/0x8 [pcie_rockchip_host]
> [  198.755172] lr : rockchip_pcie_rd_conf+0x140/0x1dc [pcie_rockchip_host]
> [  198.755773] sp : ffff8000132af530
> [  198.756079] x29: ffff8000132af530 x28: 0000000000000000
> [  198.756565] x27: 0000000000000001 x26: 0000000000000000
> [  198.757049] x25: ffff0000c20ac000 x24: 0000000000002000
> [  198.757534] x23: ffff0000c20ae5c0 x22: ffff8000132af5d4
> [  198.758018] x21: 0000000000002000 x20: 0000000000000004
> [  198.758502] x19: 0000000000102000 x18: 0000000000000001
> [  198.758987] x17: 0000000000000000 x16: 0000000000000000
> [  198.759472] x15: ffffffffffffffff x14: ffff80001159bcc8
> [  198.759957] x13: 0000000000000000 x12: ffff800011b2c000
> [  198.760441] x11: ffff8000115bf000 x10: ffff800011310018
> [  198.760926] x9 : 00000000fffb9fff x8 : 0000000000000001
> [  198.761410] x7 : 0000000000000000 x6 : ffff0000f7492548
> [  198.761894] x5 : 0000000000000001 x4 : ffff0000f7492548
> [  198.762379] x3 : 0000000000000000 x2 : 0000000000c00008
> [  198.762863] x1 : ffff80001dc00008 x0 : ffff80001a102000
> [  198.763348] Call trace:
> [  198.763583]  __raw_readl+0x0/0x8 [pcie_rockchip_host]
> [  198.764057]  pci_bus_read_config_dword+0x88/0xd0
> [  198.764484]  pci_bus_generic_read_dev_vendor_id+0x40/0x1b8
> [  198.764982]  pci_bus_read_dev_vendor_id+0x58/0x88
> [  198.765413]  pci_scan_single_device+0x84/0xf8
> [  198.765812]  pci_scan_slot+0x7c/0x120
> [  198.766149]  pci_scan_child_bus_extend+0x68/0x2dc
> [  198.766579]  pci_scan_bridge_extend+0x350/0x588
> [  198.766992]  pci_scan_child_bus_extend+0x21c/0x2dc
> [  198.767430]  pci_scan_child_bus+0x24/0x30
> [  198.767797]  pci_scan_root_bus_bridge+0xc4/0xd0
> [  198.768215]  rockchip_pcie_probe+0x610/0x74c [pcie_rockchip_host]
> [  198.768770]  platform_drv_probe+0x58/0xa8
> [  198.769139]  really_probe+0xe0/0x318
> [  198.769468]  driver_probe_device+0x5c/0xf0
> [  198.769844]  device_driver_attach+0x74/0x80
> [  198.770227]  __driver_attach+0x64/0xe8
> [  198.770572]  bus_for_each_dev+0x84/0xd8
> [  198.770924]  driver_attach+0x30/0x40
> [  198.771253]  bus_add_driver+0x188/0x1e8
> [  198.771605]  driver_register+0x64/0x110
> [  198.771956]  __platform_driver_register+0x54/0x60
> [  198.772388]  rockchip_pcie_driver_init+0x28/0x10000 [pcie_rockchip_host]
> [  198.772998]  do_one_initcall+0x94/0x390
> [  198.773353]  do_init_module+0x88/0x268
> [  198.773697]  load_module+0x1e18/0x2198
> [  198.774043]  __do_sys_finit_module+0xd0/0xe8
> [  198.774435]  __arm64_sys_finit_module+0x28/0x38
> [  198.774858]  el0_svc_common.constprop.3+0xa4/0x1d8
> [  198.775297]  el0_svc_handler+0x34/0xa0
> [  198.775645]  el0_svc+0x14/0x40
> [  198.775928]  el0_sync_handler+0x118/0x290
> [  198.776295]  el0_sync+0x164/0x180
> [  198.776609] Code: bad PC value
> [  198.776897] ---[ end trace 88fc77651b5e2909 ]---
