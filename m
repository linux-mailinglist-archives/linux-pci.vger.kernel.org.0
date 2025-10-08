Return-Path: <linux-pci+bounces-37730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A3ABC68B6
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 22:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E65B188C219
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4DE278E5D;
	Wed,  8 Oct 2025 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDY+fhUx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E8278156;
	Wed,  8 Oct 2025 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954173; cv=none; b=TmNV51/Qpl2XTEEzb+++bNUhzq9wPlA+1e3wXzT5tcTqN/nhnz8cVolt62gw871z3HpclITkyfTMHz/WZgm1TP9cbTACv34HAs8ILXp8UM1dp5f77S0jkhmk+aqhM2ztfcaJm/IsIuDjqjejLHW8DVTttfo1NMQ1Y1XMgZQHfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954173; c=relaxed/simple;
	bh=094Dr4zx8rrSHogzBdvL1gJFQqQp1aTCmP4scR+TQl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uSksz96dgkbjBM2d3Gxmt1g2UhEKeKIzorRgro4Hk4ZxIuxNgT/H2QO3/NZzl4y0z/yd316KBYqRW+R9YWaRw8VUpWq/21W6ypzVIjy4Z7N6IXyJN9I7EtxuepT3+MjspvU0wV9FCw7VM7hc9fCkR1xT0sDxdXCOIY9Cn7/YRxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDY+fhUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E176C4CEE7;
	Wed,  8 Oct 2025 20:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759954171;
	bh=094Dr4zx8rrSHogzBdvL1gJFQqQp1aTCmP4scR+TQl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QDY+fhUxMKedMDab3rasEzVuN+VNc57PR5eWx6qOAvav8aVYC3sSim7myFiJ+sZhu
	 Kieifv/dGfVy0i95OXt+Yixqdyu/0fGVMf7AnlTycPPvDUVNd1120aSfqukbZhKbdF
	 YJDBfr9wDoxvJSgZxFeE+Ahsr3/u31Xhk4Gm+MObGH6XEPKy6UAsWClr7ebaMAJndk
	 v9jSvRXA/491ZqJ3aSvjdPAVzLllSv5lv4qtzMD34diMGEZN+Mu1VM5E3IXHtadh6K
	 FTbNnImNNV3izeaPr7Ke0CnbSiw8476r0fsKu6XdUHVrCK2IqaW2fjRnh1zFS4I/Hq
	 l2quWxYWv9xgA==
Date: Wed, 8 Oct 2025 15:09:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-pci@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] PCI: Fix regression in
 pci_bus_distribute_available_resources
Message-ID: <20251008200930.GA638461@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com>

On Wed, Oct 08, 2025 at 10:36:52PM +0800, Yangyu Chen wrote:
> The refactoring in upstream commit 4292a1e45fd4 ("PCI: Refactor
> distributing available memory to use loops") switched
> pci_bus_distribute_available_resources to operate on an array of bridge
> windows. That rewrite accidentally looked up bus resources via
> pci_bus_resource_n and then passed those pointers to helper routines
> that expect the resource to belong to the device. As soon as we
> execute that code, pci_resource_num warned because the resource
> wasn't in the bridge's resource array.
> 
> This happens on my AMD Strix Halo machine with Thunderbolt device, the
> error message is shown below:
> 
> [    4.212389] ------------[ cut here ]------------
> [    4.212391] WARNING: CPU: 6 PID: 272 at drivers/pci/pci.h:471 pci_bus_distribute_available_resources+0x6ad/0x6d0
> [    4.212400] Modules linked in: raid6_pq(+) hid_generic uas usb_storage scsi_mod usbhid hid scsi_common amdgpu amdxcp drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper cec rc_core drm_client_lib drm_kms_helper sdhci_pci sdhci_uhs2 xhci_pci sp5100_tco xhci_hcd r8169 drm nvme sdhci watchdog realtek usbcore thunderbolt cqhci atlantic nvme_core mdio_devres psmouse libphy mmc_core nvme_keyring video i2c_piix4 macsec nvme_auth serio_raw mdio_bus i2c_smbus usb_common crc16 hkdf wmi
> [    4.212443] CPU: 6 UID: 0 PID: 272 Comm: irq/33-pciehp Not tainted 6.17.0+ #1 PREEMPT(voluntary)
> [    4.212447] Hardware name: PELADN YO Series/YO1, BIOS 1.04 05/15/2025
> [    4.212449] RIP: 0010:pci_bus_distribute_available_resources+0x6ad/0x6d0
> [    4.212453] Code: ff e9 a2 48 c7 c7 b8 b7 83 a3 4c 89 4c 24 18 e8 a9 2a fb ff 4c 8b 4c 24 18 e9 ca fd ff ff 48 8b 05 60 53 47 01 e9 94 fe ff ff <0f> 0b e9 5d fe ff ff 48 8b 05 55 53 47 01 e9 81 fe ff ff e8 4b 87
> [    4.212455] RSP: 0018:ffffaffcc0d4f9a8 EFLAGS: 00010206
> [    4.212458] RAX: 00000000000000cd RBX: ffff9721a687f800 RCX: ffff9721a687c828
> [    4.212459] RDX: 0000000000000000 RSI: 00000000000000cd RDI: ffff97218bc8a3c0
> [    4.212461] RBP: ffff9721a687c828 R08: ffffaffcc0d4f9f8 R09: 0000000000000001
> [    4.212462] R10: ffff97218bc8d700 R11: 0000000000000000 R12: ffffaffcc0d4f9f8
> [    4.212462] R13: ffffaffcc0d4f9f8 R14: 0000000000000000 R15: ffff97218bc8a000
> [    4.212464] FS:  0000000000000000(0000) GS:ffff973ee1ad9000(0000) knlGS:0000000000000000
> [    4.212465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.212467] CR2: 00005640b0f29360 CR3: 0000000ccb224000 CR4: 0000000000f50ef0
> [    4.212469] PKRU: 55555554
> [    4.212470] Call Trace:
> [    4.212473]  <TASK>
> [    4.212478]  pci_bus_distribute_available_resources+0x590/0x6d0
> [    4.212483]  pci_bridge_distribute_available_resources+0x62/0xb0
> [    4.212487]  pci_assign_unassigned_bridge_resources+0x65/0x1b0
> [    4.212490]  pciehp_configure_device+0x92/0x160
> [    4.212495]  pciehp_handle_presence_or_link_change+0x1b5/0x350
> [    4.212498]  pciehp_ist+0x147/0x1c0
> [    4.212502]  irq_thread_fn+0x20/0x60
> [    4.212508]  irq_thread+0x1cc/0x360
> [    4.212511]  ? __pfx_irq_thread_fn+0x10/0x10
> [    4.212515]  ? __pfx_irq_thread_dtor+0x10/0x10
> [    4.212518]  ? __pfx_irq_thread+0x10/0x10
> [    4.212521]  kthread+0xf9/0x240
> [    4.212525]  ? __pfx_kthread+0x10/0x10
> [    4.212528]  ret_from_fork+0x195/0x1d0
> [    4.212533]  ? __pfx_kthread+0x10/0x10
> [    4.212536]  ret_from_fork_asm+0x1a/0x30
> [    4.212540]  </TASK>
> [    4.212541] ---[ end trace 0000000000000000 ]---
> 
> Fix the regression by always fetching the resource directly from the
> bridge: use pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i). This
> restores the original behaviour while keeping the refactored structure.
> And then we can successfully assign resources to the Thunderbolt device.
> 
> Fixes: 4292a1e45fd4 ("PCI: Refactor distributing available memory to use loops")
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Tentatively applied to pci/for-linus for v6.18, pending Ilpo's review.

Thank you very much for debugging and providing a patch!

> ---
>  drivers/pci/setup-bus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 362ad108794d..4a8735b275e4 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2085,7 +2085,8 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	int i;
>  
>  	for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
> -		struct resource *res = pci_bus_resource_n(bus, i);
> +		struct resource *res =
> +			pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i);
>  
>  		available[i] = available_in[i];
>  
> @@ -2158,7 +2159,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  			continue;
>  
>  		for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
> -			res = pci_bus_resource_n(bus, i);
> +			res = pci_resource_n(dev, PCI_BRIDGE_RESOURCES + i);
>  
>  			/*
>  			 * Make sure the split resource space is properly
> -- 
> 2.51.0
> 

