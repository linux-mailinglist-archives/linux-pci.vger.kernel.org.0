Return-Path: <linux-pci+bounces-44262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E04D01C9A
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 10:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4FE532DD3BC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD83563ED;
	Thu,  8 Jan 2026 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwKUjO6f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E4350D51;
	Thu,  8 Jan 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859116; cv=none; b=l/2Oz8743qlz4ckrZBTGiIVBiR40pax7Lvbcb7LNQ3Bpo1rblWS9gvi9NT6dxE++1jcFyDuuZKWsbKsFR44wCY++l6im8FxlMUDg7Dgkc+m+n6tE5/w8U5Tlxw3EQNb6HviqYVUgvgsRFyDpSvsay31i7fMTY5Wzx3UaeO5lX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859116; c=relaxed/simple;
	bh=BHWjH60r0N8ZBDVV0Is9BFHZ05CWiNlrCK64NpYA3js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvJ5ji1EFnQDVhk/KE6tn8YWUxURFSTL3xKyXLKD68Jtmw0e7hPPd3hRD3+TnNTX7MwI146Eq90aKOFrkxNdP6yBtoQNTvE29PK42jSVLAo1d1Aq0lvdWidP3JBhV0C15BVUUH9JdEY3MzPa/1GmcXZFXEF6i6uFp68srp17Bv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwKUjO6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C332BC16AAE;
	Thu,  8 Jan 2026 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767859112;
	bh=BHWjH60r0N8ZBDVV0Is9BFHZ05CWiNlrCK64NpYA3js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GwKUjO6fNvi0qeVn1AsJxoFsJh600X+LDFxJRjriXP3F5XZSl/qYcsu02FrKPhfMS
	 J4gU/skb25xhTD+scfP/bB+BVIUzEEzXbd54GExTiE2EypsbF2IlN87H/vYaW0zThp
	 WfZstZ4dbYt3LoSgGftRhTYg5cAhEuZbAveFtIyKvOeoYBeOMRAWMNvFz5bDfDxmal
	 iB0Dpq1ai20nwJr/PAZbjGICz5liX8VzBoXVCuJ/J0LgTw2xZFMdn+hN6PUYt4DDkj
	 SVCiT9O5T6ly1e5FEgpOIIAZTc2VI7L0sb4qUDxH5Z+1svZed8XYjy2g5P30eY01qN
	 jzXD+Y+xavYVw==
Date: Thu, 8 Jan 2026 08:58:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, lpieralisi@kernel.org, vidyas@nvidia.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Koichiro Den <den@valinux.co.jp>
Subject: Re: [PATCH 1/1] PCI: endpoint: Fix swapped parameters in
 primary/secondary unlink callbacks
Message-ID: <aV9joi3jF1R6ca02@ryzen>
References: <20260108062747.1870669-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108062747.1870669-1-mmaddireddy@nvidia.com>

On Thu, Jan 08, 2026 at 11:57:47AM +0530, Manikanta Maddireddy wrote:
> When using the primary/secondary EPC linking method via configfs, unlinking
> the symlink causes a kernel crash with NULL pointer dereference. The crash
> occurs in pci_epf_unbind() with a corrupted pointer (e.g., 0x0000000300000857),
> and WARN_ON_ONCE(epc_group->start) triggers even when the EPC was properly
> stopped before unlinking.
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1774 at drivers/pci/endpoint/pci-ep-cfs.c:143 pci_primary_epc_epf_unlink+0x6c/0x74
> CPU: 1 PID: 1774 Comm: unlink Tainted:
> Hardware name: NVIDIA Jetson
> pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : pci_primary_epc_epf_unlink+0x6c/0x74
> lr : configfs_unlink+0xe0/0x208
> sp : ffff8000854fbcc0
> x29: ffff8000854fbcc0 x28: ffff00008fd0ddc0 x27: 0000000000000000
> x26: 0000000000000000 x25: ffff00008b756220 x24: ffffc46154d53248
> x23: ffff000095368088 x22: ffffc461568bdd18 x21: ffff00008afb3f00
> x20: ffff00008068ec00 x19: ffff000095368088 x18: 0000000000000000
> x17: 0000000000000000 x16: ffffc46153e6f32c x15: 0000000000000000
> x14: 0000000000000000 x13: ffff00008eec2043 x12: ffff8000854fbc64
> x11: 00000007ec988e71 x10: 0000000000000002 x9 : 0000000000000007
> x8 : ffff0000824c3540 x7 : e0fee0d0d0d0a0b5 x6 : 0000000000000002
> x5 : 0000000000000064 x4 : 0000000200000000 x3 : 0000000200000000
> x2 : ffffc46153e6f32c x1 : ffff000088009c00 x0 : 0000000000000073
> Call trace:
>  pci_primary_epc_epf_unlink+0x6c/0x74
>  configfs_unlink+0xe0/0x208
>  vfs_unlink+0x120/0x29c
>  do_unlinkat+0x25c/0x2c4
>  __arm64_sys_unlinkat+0x3c/0x90
>  invoke_syscall+0x48/0x134
>  el0_svc_common.constprop.0+0xd0/0xf0
>  do_el0_svc+0x1c/0x30
>  el0t_64_sync_handler+0x130/0x13c
>  el0t_64_sync+0x194/0x198
>
> ------------[ cut here ]------------
> Unable to handle kernel paging request at virtual address 0000000300000857
> Mem abort info:
>   SET = 0, FnV = 0(current EL), IL = 32 bits
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010ed28000
> [0000000300000857] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> pstate: 034000c9 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)n
> pc : string+0x54/0x14c
> lr : vsnprintf+0x280/0x6e8
> sp : ffff8000854fb940
> x29: ffff8000854fb940 x28: ffffc461555540fd x27: 00000000ffffffd8
> x26: ffff8000854fbc90 x25: 0000000000000008 x24: ffff8000854fba70
> x23: ffff8000854fbc90 x22: ffff8000854fba78 x21: 0000000000000002
> x20: ffff8000854fba75 x19: ffffc461555540fd x18: 0000000000000006
> x17: 0000000000000000 x16: ffffc46154a438a0 x15: ffff8000854fb5e0
> x14: 0000000000000000 x13: 00000000ffffffea x12: ffffc46156333e80
> x11: 0000000000000001 x10: 0000000000000020 x9 : ffff8000854fbc90
> x8 : 0000000000000020 x7 : 00000000ffffffff x6 : ffff8000854fba78
> x5 : 0000000000000000 x4 : ffffffffffffffff x3 : ffff0a00ffffff04
> x2 : 0000000300000857 x1 : 0000000000000000 x0 : ffff8000854fba75
> Call trace:
>  string+0x54/0x14c
>  vsnprintf+0x280/0x6e8
>  vprintk_default+0x38/0x4c
>  vprintk+0xc4/0xe0
>  pci_epf_unbind+0xdc/0x108
>  configfs_unlink+0xe0/0x208+0x44/0x74
>  vfs_unlink+0x120/0x29c
>  __arm64_sys_unlinkat+0x3c/0x90
>  invoke_syscall+0x48/0x134
>  do_el0_svc+0x1c/0x30prop.0+0xd0/0xf0
>
> The pci_primary_epc_epf_unlink() and pci_secondary_epc_epf_unlink() functions
> have their parameter names swapped compared to the corresponding _link()
> functions, but the function body was not updated to match.
>
> ConfigFS drop_link callback receives parameters as (src_item, target_item):
> - src_item: the config_item of the directory containing the symlink (primary/ group)
> - target_item: the config_item that the symlink points to (EPC controller)
>
> The _link() functions correctly use:
>   pci_primary_epc_epf_link(struct config_item *epf_item, struct config_item *epc_item)
>   - epf_item (1st param) = primary/ group -> epf_item->ci_parent = EPF group
>   - epc_item (2nd param) = EPC controller
>
> But the _unlink() functions had parameters swapped:
>   pci_primary_epc_epf_unlink(struct config_item *epc_item, struct config_item *epf_item)
>   - epc_item (1st param) = actually primary/ group (misnamed!)
>   - epf_item (2nd param) = actually EPC controller (misnamed!)
>
> The body then incorrectly uses:
>   to_pci_epf_group(epf_item->ci_parent) -> EPC's parent = controllers/ group (WRONG!)
>   to_pci_epc_group(epc_item) -> primary/ group cast as EPC group (WRONG!)
>
> This causes garbage pointer dereferences leading to the crash.
>
> Swap the parameter names in both unlink functions to match the link functions,
> so the body logic correctly interprets the parameters.
>
> Verification steps:
> 1. cd /sys/kernel/config/pci_ep/
> 2. Create EPF function: mkdir functions/<driver>/func1
> 3. Link via primary: ln -s controllers/<epc> functions/<driver>/func1/primary/
> 4. Start EPC: echo 1 > controllers/<epc>/start
> 5. Stop EPC: echo 0 > controllers/<epc>/start
> 6. Unlink: unlink functions/<driver>/func1/primary/<epc>
> 7. Cleanup: rmdir functions/<driver>/func1
> 8. Verify no crash occurs during unlink
>
> Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---

I think the commit message is a bit too verbose.
Something like the following would suffice:

struct configfs_item_operations callbacks are defined like the following:
int (*allow_link)(struct config_item *src, struct config_item *target);
void (*drop_link)(struct config_item *src, struct config_item *target);

While pci_primary_epc_epf_link() and pci_secondary_epc_epf_link() specifies
the parameters in the correct order, pci_primary_epc_epf_unlink() and
pci_secondary_epc_epf_unlink() specifies the parameters in the wrong order,
leading to a kernel crash when using the unlink command in configfs.

With that:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


Note that a fix for this is also is part of Koichiro series:
https://lore.kernel.org/linux-pci/20251202072348.2752371-3-den@valinux.co.jp/


Kind regards,
Niklas

