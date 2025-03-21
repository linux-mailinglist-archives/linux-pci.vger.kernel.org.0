Return-Path: <linux-pci+bounces-24381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F6A6C0ED
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED76D1892A9F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F41522D78D;
	Fri, 21 Mar 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw8crC3D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8021D6DC8;
	Fri, 21 Mar 2025 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576961; cv=none; b=hhXqrWmveTLBuTPFplhAZbgi7TEamyJKBBJIQsmxhKhzBz114/UYsZr5efa95e9qsbCJz8nPdxmIhtDBpbHEjSk8zt7BH3TEQE+kKAj16XOxbxgAkxS+V3L3xWYxc9Z1VnbryxGGG7gn2c8dNtGjngh64b4eCMyxnktEfGo67ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576961; c=relaxed/simple;
	bh=PeMp7Z+m4dja5l4Z3HYeC8k40w/e6Gjh2ar9JxXK7Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IF+9FOWxftUj528U4HvhYw26FDaPp4meSYuWx9MNG7rEahTYUBt8oKV1VGd10TV1qNdRTSeMEWraFTlCmtyibPgd3PKgs3Ob/P1lNfPSlLFGIQ2G26Tt4mI+gow7SkLyUXwlK4s1vt4PGGybaalJu++3RMUBl4lwF0U57wFtvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw8crC3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0819C4CEE3;
	Fri, 21 Mar 2025 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742576960;
	bh=PeMp7Z+m4dja5l4Z3HYeC8k40w/e6Gjh2ar9JxXK7Dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uw8crC3DW/289dMz/NgMNEEsyo6gaEFWwtFHRKaVB5k7+a56xc7/aYa61O6kDHG6p
	 UuBdwQV1VlZ9rZBPkZwhsuejw6Vttu/I8bkbSeNjaiUtXSKBbjxoTr6FvjXtjhkjd1
	 DEtKVXe3e2KPIXy47e46ca00Z1fT1qXJzDxVuSDL6Asno2u4Mi6V8GmoUdhpchm+1C
	 1b/ka2lzxgkdV+MdFcWeVKPo9A8ny5CEQSsGn8nwOZoRmbjYzLfstUQUzLRuvVXrZ+
	 63WhKh7/8i7xaVwEjWq2lv00SAjY5T5LlZMaCQSIFGGDLrgqOOndOo8aLjeSNk3GLZ
	 PMUceXWPK0VQQ==
Date: Fri, 21 Mar 2025 12:09:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Don't enable HPIE in poll mode
Message-ID: <20250321170919.GA1130592@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321162114.3939-1-ilpo.jarvinen@linux.intel.com>

On Fri, Mar 21, 2025 at 06:21:14PM +0200, Ilpo Järvinen wrote:
> PCIe hotplug can operate in poll mode without interrupt handlers using
> a polling kthread only. The commit eb34da60edee ("PCI: pciehp: Disable
> hotplug interrupt during suspend") failed to consider that and enables
> HPIE (Hot-Plug Interrupt Enable) unconditionally when resuming the
> Port.
> 
> Only set HPIE if non-poll mode is in use. This makes
> pcie_enable_interrupt() match how pcie_enable_notification() already
> handles HPIE.
> 
> Fixes: eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/hotplug with subject:

  PCI: pciehp: Don't enable HPIE when resuming in poll mode

to match the pciehp history.

Random things that I noticed while looking at this:

  - It does make me wonder why we have both pcie_enable_interrupt()
    and pcie_enable_notification().  Apparently we don't need to
    restore the other PCI_EXP_SLTCTL bits when resuming?  Maybe we
    depend on some other restoration, e.g., pci_restore_pcie_state(),
    that happens first?

    That makes me worry that there's a window between
    pci_restore_pcie_state() and pcie_enable_interrupt().  I suppose
    we probably saved the pcie state after pcie_disable_interrupt(),
    so HPIE would be disabled in the saved state.

  - I also wonder about the fact that pci_restore_pcie_state() doesn't
    account for Command Completed events, so we might write to Slot
    Control too fast.

  - It's annoying that pcie_enable_interrupt() and
    pcie_disable_interrupt() are global symbols, a consequence of
    pciehp being split across five files instead of being one, which
    is also a nuisance for code browsing.

    Also annoying that they are generically named, with no pciehp
    connection (probably another consequence of being split into
    several files).

  - The eb34da60edee commit log hints at the reason for testing
    pme_is_native().  Would be nice if there were also a comment in
    the code about this because it's not 100% obvious why we test PME
    support in the PCIe native hotplug driver.

  - Also slightly weird that eb34da60edee added the pme_is_native()
    tests in pciehp_suspend() and pciehp_resume(), but somewhere along
    the line the suspend-side one got moved to
    pciehp_disable_interrupt(), so they're no longer parallel for no
    obvious reason.

  - I forgot why we have both pcie_write_cmd() and
    pcie_write_cmd_nowait() and how to decide which to use.

Whew, that was a lot.  I feel unusually ignorant this morning.

> ---
> 
> v2:
> - Dropped other hotplug fixes/changes (Lukas' approach/fix is better)
> - Fixed typo in shortlog
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bb5a8d9f03ad..28ab393af1c0 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -842,7 +842,9 @@ void pcie_enable_interrupt(struct controller *ctrl)
>  {
>  	u16 mask;
>  
> -	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
> +	mask = PCI_EXP_SLTCTL_DLLSCE;
> +	if (!pciehp_poll_mode)
> +		mask |= PCI_EXP_SLTCTL_HPIE;
>  	pcie_write_cmd(ctrl, mask, mask);
>  }
>  
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> -- 
> 2.39.5
> 

