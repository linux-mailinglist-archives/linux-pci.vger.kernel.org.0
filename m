Return-Path: <linux-pci+bounces-44674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66693D1B55F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 22:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62B2230318F7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 21:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621F27EFE9;
	Tue, 13 Jan 2026 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru1gw063"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8531DDA4;
	Tue, 13 Jan 2026 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338181; cv=none; b=Ye3fDRvJrLLBHO5VW0cw8Exjv+7FnfQwEYGY0MVZCl+8YXLnPL7LZKiHzuspBKkCTmj/o56xXfJ7OMrCEM+j4Rh4eIyEigEcb9vY3oNsFWk42GuQZPBDmOTzPxvXUxcNPaNNkfdhx/aG132CGNOTm5h+CGgxhyIdxvuzE4WWC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338181; c=relaxed/simple;
	bh=Zapr/Vr73MEIhkB/M4aRPNGRaz4gnjhxscdbTnQ+hJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q7wLeznLAiu4fftE3we/gG+gf+9uvTxtRiGD9sDbIPP9AQIPr73Va3kB12ATdjywVVRH0FhTG1FzBv7I3/YHPiD2o5TA1/KNCSdLMyNPdz1qVYXVXFrp5x2Bae74XepVvViwviHIacDAwK+5Z4HPX8qXnNjDgmUtL27cd9jUckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru1gw063; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FD7C116C6;
	Tue, 13 Jan 2026 21:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768338180;
	bh=Zapr/Vr73MEIhkB/M4aRPNGRaz4gnjhxscdbTnQ+hJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ru1gw063UHP0TX5zcOmbiToLfTrVzA1uDpPsa6PRlyVO9rJbXZ6PjWvIiJPFsXWju
	 Qr5xh/ZmjHKsSCPrgOrCMc+I10u6DXOUnZv1Xgsx4mJAb4kKDWaRI/dIncLq0PtaeL
	 abJs4Sp0ow8t3/qO2/F8ppc3tum8s3B6BTXeN8BoCLKje9qWbizuqVphfbbPOOUAV0
	 QXSUTGchj1c0Hf7X1mm9Ri/vvJQA3gy6sZ85dcPfmTd7N68IkZ/2pnrnZhylHz9k+K
	 d9WRE45aNEFQ8OaPe20AJqekr3uDYi/M8GwnJu6SYkxnppuQhB12/GJwZPdBWHIp3p
	 NFwVg0gNbgC4w==
Date: Tue, 13 Jan 2026 15:02:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] pci_read_bridge_bases: skip prefetch window if
 pref_window not set?
Message-ID: <20260113210259.GA715789@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWTBrOzw73FLvsUb@DESKTOP-TIT0J8O.localdomain>

On Mon, Jan 12, 2026 at 01:41:00PM +0400, Ahmed Naseef wrote:
> Hello,
> 
> I apologize in advance if this question is naive - I am very new to
> PCIe and Linux kernel development in general.
> 
> Context:
> 
> I am porting OEM GPL source code to OpenWrt for the EcoNET EN7528 SoC
> (MIPS-based) using 6.12 stable kernel . The PCIe controller is similar to the
> v2 section of drivers/pci/controller/pcie-mediatek.c. This SoC has two PCIe
> root ports, and I have:
> - Port 0: MediaTek MT7603E (2.4GHz WiFi) - works fine
> - Port 1: MediaTek MT7615E (5GHz WiFi) - fails during EEPROM init
> 
> The Problem:
> 
> The MT7615E driver fails with a warning at mt7615/eeprom.c in
> mt7615_efuse_read() (EFUSE read returns invalid data), followed by
> "Firmware is not ready for download".
> 
>   [  159.873208] mtk-pcie 1fb83000.pcie: host bridge /pcie@1fb83000 ranges:
>   [  159.879993] mtk-pcie 1fb83000.pcie:       IO 0x001f610000..0x001f61ffff -> 0x0000000000
>   [  159.888082] mtk-pcie 1fb83000.pcie:      MEM 0x0028000000..0x002fffffff -> 0x0028000000
>   [  159.968086] mtk-pcie 1fb83000.pcie: EN7528: port1 retraining link (Gen1 -> Gen2)
>   [  160.238227] mtk-pcie 1fb83000.pcie: EN7528: port1 link trained to Gen2

Can we look forward to a patch to add support for EN7528?

>   [  160.245128] mtk-pcie 1fb83000.pcie: PCI host bridge to bus 0001:00
>   [  160.251467] pci_bus 0001:00: root bus resource [bus 00-ff]
>   [  160.256998] pci_bus 0001:00: root bus resource [mem 0x28000000-0x2fffffff]
>   [  160.264331] pci 0001:00:01.0: [14c3:0811] type 01 class 0x060400 PCIe Root Port
>   [  160.280550] pci 0001:00:01.0: PCI bridge to [bus 00]
>   [  160.285620] pci 0001:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
>   [  160.323099] pci 0001:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>   [  160.332147] pci 0001:01:00.0: [14c3:7663] type 00 class 0x000280 PCIe Endpoint
>   [  160.339730] pci 0001:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit pref]
>   [  160.346757] pci 0001:01:00.0: BAR 2 [mem 0x00000000-0x00003fff 64bit pref]
>   [  160.353833] pci 0001:01:00.0: BAR 4 [mem 0x00000000-0x00000fff 64bit pref]
>   [  160.361536] pci 0001:01:00.0: supports D1 D2
>   [  160.365819] pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>   [  160.381859] pci 0001:00:01.0: PCI bridge to [bus 01-ff]
>   [  160.472951] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
>   [  160.479722] pci 0001:00:01.0: bridge window [mem 0x28000000-0x280fffff]: assigned
>   [  160.487241] pci 0001:00:01.0: bridge window [mem 0x28100000-0x282fffff pref]: assigned
>   [  160.495221] pci 0001:00:01.0: bridge window [io  size 0x1000]: can't assign; no space
>   [  160.503117] pci 0001:00:01.0: bridge window [io  size 0x1000]: failed to assign
>   [  160.510511] pci 0001:01:00.0: BAR 0 [mem 0x28100000-0x281fffff 64bit pref]: assigned
>   [  160.518425] pci 0001:01:00.0: BAR 2 [mem 0x28200000-0x28203fff 64bit pref]: assigned
>   [  160.526279] pci 0001:01:00.0: BAR 4 [mem 0x28204000-0x28204fff 64bit pref]: assigned
>   [  160.534188] pci 0001:00:01.0: PCI bridge to [bus 01]
>   [  160.539261] pci 0001:00:01.0:   bridge window [mem 0x28000000-0x280fffff]
>   [  160.546094] pci 0001:00:01.0:   bridge window [mem 0x28100000-0x282fffff pref]
>   [  160.553403] pci_bus 0001:00: Some PCI device resources are unassigned, try booting with pci=realloc
>   [  160.562510] pci_bus 0001:00: resource 4 [mem 0x28000000-0x2fffffff]
>   [  160.568849] pci_bus 0001:01: resource 1 [mem 0x28000000-0x280fffff]
>   [  160.575145] pci_bus 0001:01: resource 2 [mem 0x28100000-0x282fffff pref]
>   [  160.582807] pci 0001:00:01.0: enabling device (0000 -> 0002)
>   [  160.588666] mt7615e 0001:01:00.0: enabling device (0000 -> 0002)
>   [  160.596498] ------------[ cut here ]------------
>   [  160.601213] WARNING: CPU: 3 PID: 1777 at target-mipsel_24kc_musl/linux-econet_en7528/mt76-2025.11.06~eb567bc7/mt7615/eeprom.c:31 mt7615_eeprom_init+0x484/0x548 [mt7615_common]
>   [  160.617022] Modules linked in: pcie_mediatek(+) pppoe ppp_async nft_fib_inet nf_flow_table_inet pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir
>   nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack
>   mt76x2e(O) mt76x2_common(O) mt76x02_lib(O) mt7615e(O) mt7615_common(O) mt7603e(O) mt76_connac_lib(O) mt76(O) mac80211(O) cfg80211(O) slhc nfnetlink nf_reject_ipv6 nf_reject_ipv4
>   nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c hwmon crc_ccitt compat(O) i2c_dev i2c_core sha512_generic seqiv sha3_generic jitterentropy_rng drbg hmac geniv rng cmac
>   crc32c_generic
>   [  160.681351] CPU: 3 UID: 0 PID: 1777 Comm: insmod Tainted: G           O       6.12.62 #0
>   [  160.681383] Tainted: [O]=OOT_MODULE
>   [  160.681391] Hardware name: DASAN H660GM-A
>   [  160.681401] Stack : 000000f6 00000004 0000000c 8187273c 82bed984 8102db2c 00000001 01000000
>   [  160.681467]         00000000 00000000 00000000 00000000 00000000 00000001 82bed930 808ab720
>   [  160.681530]         00000000 00000000 81832514 82bed7b8 ffffefff 00000000 81912b38 000000f7
>   [  160.681594]         82bed804 000000f9 81912b68 fffffff9 00000001 00000000 81832514 00000000
>   [  160.681658]         00000000 82eb82a4 8190b530 00000400 00000003 fffc4313 0000000c 81ad000c
>   [  160.681723]         ...
>   [  160.681739] Call Trace:
>   [  160.681746] [<81006788>] show_stack+0x28/0xf0
>   [  160.681796] [<8173e8a0>] dump_stack_lvl+0x70/0xb0
>   [  160.681826] [<8102e35c>] __warn+0x9c/0x114
>   [  160.681871] [<8102e4fc>] warn_slowpath_fmt+0x128/0x188
>   [  160.681923] [<82eb82a4>] mt7615_eeprom_init+0x484/0x548 [mt7615_common]
>   [  160.682018] [<82e482c8>] mt7615_register_device+0xb0/0x230 [mt7615e]
>   [  160.682099] [<82e4a140>] mt7615_mmio_probe+0x184/0x244 [mt7615e]
>   [  160.682178] [<82e4812c>] 0x82e4812c
>   [  160.682238]
>   [  160.682246] ---[ end trace 0000000000000000 ]---
>   [  160.795616] mt7615e 0001:01:00.0: registering led 'mt76-phy1'
>   [  160.944376] mt7615e 0001:01:00.0: Firmware is not ready for download 
> 
> The EN7528's PCIe root complex does not implement prefetchable memory
> window registers - they are hardwired to zero. I'm not sure why EN7528
> ignores writes to the prefetch registers - could be a hardware
> limitation or maybe I'm missing some initialization step.( The only
> resource reference I have is the OEM GPL tarball).
> 
> During initial enumeration, pci_read_bridge_windows() in
> drivers/pci/probe.c correctly detects this. It reads PCI_PREF_MEMORY_BASE
> which returns 0. Then it writes 0xffe0fff0 to test writability and reads
> back 0, confirming the register is not implemented. So bridge->pref_window
> remains 0 and the function returns early. This is correct behavior.
> 
> However, later during resource allocation, pci_read_bridge_bases() unconditionally
> calls pci_read_bridge_mmio_pref() without checking bridge->pref_window.
> 
> Inside pci_read_bridge_mmio_pref(), it reads PCI_PREF_MEMORY_BASE and
> PCI_PREF_MEMORY_LIMIT which both return 0x0000. This results in base = 0
> and limit = 0. The condition "if (base <= limit)" evaluates to true
> (since 0 <= 0), so a bogus prefetch window [mem 0x00000000-0x000fffff pref]
> is created.

It's too bad we didn't log this in dmesg.  It looks like we claimed
there was a [mem 0x28100000-0x282fffff pref] window.

> The MT7615E has 64-bit prefetchable BARs, and I believe this bogus window
> causes resource allocation issues that ultimately break the driver's
> register access.
> 
> Proposed Fix:
> 
> I found that checking dev->pref_window before calling
> pci_read_bridge_mmio_pref() fixes my issue:
> 
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -541,7 +541,8 @@ void pci_read_bridge_bases(struct pci_bu
> 
>         pci_read_bridge_io(child->self, child->resource[0], false);
>         pci_read_bridge_mmio(child->self, child->resource[1], false);
> -       pci_read_bridge_mmio_pref(child->self, child->resource[2], false);
> +       if (dev->pref_window)
> +               pci_read_bridge_mmio_pref(child->self, child->resource[2], false);

This seems reasonable to me, but I wonder if we should put the test
inside pci_read_bridge_mmio_pref() instead of relying on the caller to
do the test?

Also, I suspect the IO window has a similar problem since it is also
optional.  What do you think?

>         if (dev->transparent) {
>                 pci_bus_for_each_resource(child->parent, res) {
> 
> 
> Logs after the patch:
> 
> 	[   53.372751] mtk-pcie 1fb83000.pcie: host bridge /pcie@1fb83000 ranges:
> 	[   53.379499] mtk-pcie 1fb83000.pcie:       IO 0x001f610000..0x001f61ffff -> 0x0000000000
> 	[   53.387553] mtk-pcie 1fb83000.pcie:      MEM 0x0028000000..0x002fffffff -> 0x0028000000
> 	[   53.458812] mtk-pcie 1fb83000.pcie: EN7528: port1 retraining link (Gen1 -> Gen2)
> 	[   53.718227] mtk-pcie 1fb83000.pcie: EN7528: port1 link trained to Gen2
> 	[   53.725136] mtk-pcie 1fb83000.pcie: PCI host bridge to bus 0001:00
> 	[   53.731453] pci_bus 0001:00: root bus resource [bus 00-ff]
> 	[   53.736975] pci_bus 0001:00: root bus resource [mem 0x28000000-0x2fffffff]
> 	[   53.744229] pci 0001:00:01.0: [14c3:0811] type 01 class 0x060400 PCIe Root Port
> 	[   53.751873] pci 0001:00:01.0: PCI bridge to [bus 00]
> 	[   53.756927] pci 0001:00:01.0:   bridge window [mem 0x00000000-0x000fffff]
> 	[   53.766082] pci 0001:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> 	[   53.775098] pci 0001:01:00.0: [14c3:7663] type 00 class 0x000280 PCIe Endpoint
> 	[   53.782645] pci 0001:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit pref]
> 	[   53.789698] pci 0001:01:00.0: BAR 2 [mem 0x00000000-0x00003fff 64bit pref]
> 	[   53.796701] pci 0001:01:00.0: BAR 4 [mem 0x00000000-0x00000fff 64bit pref]
> 	[   53.804357] pci 0001:01:00.0: supports D1 D2
> 	[   53.808682] pci 0001:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> 	[   53.816252] pci 0001:00:01.0: PCI bridge to [bus 01-ff]
> 	[   53.821626] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
> 	[   53.828391] pci 0001:00:01.0: bridge window [mem 0x28000000-0x281fffff]: assigned
> 	[   53.835899] pci 0001:00:01.0: bridge window [io  size 0x1000]: can't assign; no space
> 	[   53.843786] pci 0001:00:01.0: bridge window [io  size 0x1000]: failed to assign
> 	[   53.851160] pci 0001:01:00.0: BAR 0 [mem 0x28000000-0x280fffff 64bit pref]: assigned
> 	[   53.859068] pci 0001:01:00.0: BAR 2 [mem 0x28100000-0x28103fff 64bit pref]: assigned
> 	[   53.866927] pci 0001:01:00.0: BAR 4 [mem 0x28104000-0x28104fff 64bit pref]: assigned
> 	[   53.874816] pci 0001:00:01.0: PCI bridge to [bus 01]
> 	[   53.879888] pci 0001:00:01.0:   bridge window [mem 0x28000000-0x281fffff]
> 	[   53.886771] pci_bus 0001:00: Some PCI device resources are unassigned, try booting with pci=realloc
> 	[   53.895862] pci_bus 0001:00: resource 4 [mem 0x28000000-0x2fffffff]
> 	[   53.902188] pci_bus 0001:01: resource 1 [mem 0x28000000-0x281fffff]
> 	[   53.909337] pci 0001:00:01.0: enabling device (0000 -> 0002)
> 	[   53.915132] mt7615e 0001:01:00.0: enabling device (0000 -> 0002)
> 	[   53.929071] mt7615e 0001:01:00.0: registering led 'mt76-phy1'
> 	root@OpenWrt:/tmp# [   54.301116] mt7615e 0001:01:00.0: mediatek/mt7663pr2h.bin not found, switching to mediatek/mt7663pr2h_rebb.bin
> 	[   54.484190] mt7615e 0001:01:00.0: HW/SW Version: 0x65322d31, Build Time: 2009041715da1a1
> 	[   54.484190]
> 	[   54.783490] mt7615e 0001:01:00.0: N9 Firmware Version: 7663mp1827, Build Time: 20200904171623
> 	[   54.792127] mt7615e 0001:01:00.0: Region number: 0x3
> 	[   54.797104] mt7615e 0001:01:00.0: Parsing tailer Region: 0
> 	[   54.805252] mt7615e 0001:01:00.0: Region 0, override_addr = 0x00112c00
> 	[   54.811929] mt7615e 0001:01:00.0: Parsing tailer Region: 1
> 	[   54.818100] mt7615e 0001:01:00.0: Parsing tailer Region: 2
> 	[   54.823972] mt7615e 0001:01:00.0: override_addr = 0x00112c00, option = 3
> 
> 
> 
> My Question:
> 
> This patch fixes my problem, but I am not sure if it could break other
> devices or platforms. Is this the correct approach, or am I missing
> some initialization in the host controller driver that is supposed to
> be there?
> 
> I would appreciate any guidance.
> 
> Thank you for your time.
> 
> Best regards,
> Ahmed Naseef

