Return-Path: <linux-pci+bounces-40923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48036C4ED61
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 16:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1D194F668F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C077036654C;
	Tue, 11 Nov 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZn23WnE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54936997A
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875584; cv=none; b=W3AeoQLxU2lKoMZMGDtaGZAe8/9K5JZYnkpiqlizq+VCnULUq7/03lN15qjK6Z1za0LwE2jYweUNoy9AOpIr8FSWb9gfLt6AtbYbhAoenvqm6dCb9QQqOnOh1/nNqNyPTEzvXbq90HUyCZaxgMgk0W84NAra9qzJGhoA5y7WDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875584; c=relaxed/simple;
	bh=PsSSGy9XVAcdYlIrWf00faJOj3OHiVP5p7a3Iice4Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fxriwtbG5PlDDeVvb68w6l6Ue5qWO3UaPsyDvLadRJxEBHqycuSNrTfSJiY/daHHJ+fkpQ0C/UQek8gT6QKsdtfbDQyz5137Gw4HTk16bMZ00VNJBCCRtRqxWWa3HP5jeYiEmDqaXcldO7iijI0oRFp61qYPxm3JOUrSmnOJpUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZn23WnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD75C19423;
	Tue, 11 Nov 2025 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875584;
	bh=PsSSGy9XVAcdYlIrWf00faJOj3OHiVP5p7a3Iice4Cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CZn23WnEazaXnSk8LREiZZQxTHV9lDscBVrIkfoG2qyK98gJA78KoNR1XAzIHXndQ
	 cnhPIjDVlFB/TVYpTsKcosS+kSYnSZoEsp4LbPlVKIkCvaUg2dB2DZ3TqP7q8PpGKs
	 5Y+kpIA9f/5I7fOFPOrYAgFaSDpvFjNndtOSUb3qlKdxfd4QKsMNV2ZLX8Gz6NNMyl
	 wYlD28p46qddd9lkfPBsPNUZOY6/Fvf7nTcTjB/rnNwyTEVW5FAaVm3nJUG1MaBD1D
	 Xh4Uorg/JNPABer6IC01z/P9zB9ixfuXzMVmoNkWpVK3bsHasaozhMK3IXZ0PYScsz
	 og3CauYNuMevg==
Date: Tue, 11 Nov 2025 09:39:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4] PCI/PTM: Enable PTM only if it advertises a role
Message-ID: <20251111153942.GA2174680@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111061048.681752-1-mika.westerberg@linux.intel.com>

On Tue, Nov 11, 2025 at 07:10:48AM +0100, Mika Westerberg wrote:
> We have a Upstream Port (2b:00.0) that has following in the PTM capability:
> 
>   Capabilities: [220 v1] Precision Time Measurement
> 		PTMCap: Requester- Responder- Root-
> 
> Linux enables PTM for this without looking into what roles it actually
> supports. Immediately after enabling PTM we start getting these:
> 
>   pci 0000:2b:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream Port
>   ...
>   pci 0000:2b:00.0: PTM enabled, 4ns granularity
>   ...
>   pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
>   pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
>   pcieport 0000:00:07.1:   device [8086:e44f] error status/mask=00200000/00000000
>   pcieport 0000:00:07.1:    [21] ACSViol                (First)
>   pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
> 
> Fix this by enabling PTM only if any of the following conditions are
> true (see more in PCIe r7.0 sec 6.21.1 figure 6-21):
> 
>   - PCIe Endpoint that has PTM capability must to declare requester
>     capable
>   - PCIe Switch Upstream Port that has PTM capability must declare
>     at least responder capable
>   - PCIe Root Port must declare root port capable.
> 
> While there make the enabling happen for all in __pci_enable_ptm() instead
> of enabling some in pci_ptm_init() and some in __pci_enable_ptm().
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Previous versions can be seen:
> 
>   v3: https://lore.kernel.org/linux-pci/20251030134606.3782352-1-mika.westerberg@linux.intel.com/
>   v2: https://lore.kernel.org/linux-pci/20251028060427.2163115-1-mika.westerberg@linux.intel.com/
>   v1: https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/
> 
> Changes from v3:
> 
>   - Cache the responder and requester capability bits.
>   - Enable PTM only in __pci_enable_ptm().
>   - Update $subject and commit message.
>   - Since this is changed quite a lot, I dropped the Reviewed-by from Lukas
>     and also stable tag.
> 
> Changes from v2:
> 
>   - Limit the check in __pci_enable_ptm() to Endpoints and Legacy
>     Endpoints.
>   - Added stable tags suggested by Lukas, and PCIe spec reference.
>   - Added Reviewed-by tag from Lukas (hope it is okay to keep).
> 
> Changes from v1:
> 
>   - Limit Switch Upstream Port only to Responder, not both Requester and
>     Responder.
> 
>  drivers/pci/pcie/ptm.c | 41 ++++++++++++++++++++++++++++++++++++++---
>  include/linux/pci.h    |  2 ++
>  2 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 65e4b008be00..30e25f1ad28e 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -81,9 +81,12 @@ void pci_ptm_init(struct pci_dev *dev)
>  		dev->ptm_granularity = 0;
>  	}
>  
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
> -		pci_enable_ptm(dev, NULL);
> +	if (cap & PCI_PTM_CAP_RES)
> +		dev->ptm_responder = 1;
> +	if (cap & PCI_PTM_CAP_REQ)
> +		dev->ptm_requester = 1;
> +
> +	pci_enable_ptm(dev, NULL);

This seems nice and clean overall.

I do wonder about the fact that previously we automatically enabled
PTM only for Root Ports and Switch Upstream Ports, but we didn't
enable it for Endpoints until a driver called pci_enable_ptm().

With this change, it looks like we automatically enable PTM for every
device that supports it.  Worth a mention in the commit log, and we
might also want to revisit the drivers (ice, idpf, igc, mlx5) that
explicitly enable it to remove the enable and disable calls there.

PTM consumes some link bandwidth, so the idea was to avoid paying that
cost unless a driver actually wanted to use PTM.  PTM Messages are
local, so they terminate at the Switch Downstream Port or Root Port
that receives them.  I assumed that Switches would only send PTM
Requests upstream if they received a PTM Request from a downstream
device, so I thought it would be free to enable PTM on the Switch.

But apparently that isn't true; these errors happen immediately when
enabling PTM on the Switch, before it's enabled on any downstream
device.  And it makes sense that a Switch could provide better service
if it kept its local Time Source updated so it could generate PTM
Responses directly instead of sending a request upstream, waiting for
a response, and passing it along downstream.

I still feel like it's worth avoiding the bandwidth cost by leaving
PTM disabled unless a driver wants it.  The cost is probably small,
but why pay it if we're not using PTM?  What are your thoughts?

I could imagine leaving everything disabled until an endpoint driver
enables it, and then enabling it in the whole path up to the root.  I
don't really *like* modifying things outside the actual device owned
by the driver, because then we have to worry about concurrency and
locking for the rest of the path.  But maybe that's the only way?

The errors seem pretty important to fix, so maybe we should apply this
for v6.19 even if we want to do more work to avoid the bandwidth cost
later?

>  }
>  
>  void pci_save_ptm_state(struct pci_dev *dev)
> @@ -144,6 +147,38 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>  			return -EINVAL;
>  	}
>  
> +	switch (pci_pcie_type(dev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		/*
> +		 * Root Port must declare Root Capable if we want to enable
> +		 * PTM for it.
> +		 */
> +		if (!dev->ptm_root)
> +			return -EINVAL;
> +		break;
> +	case PCI_EXP_TYPE_UPSTREAM:
> +		/*
> +		 * Switch Upstream Ports must at least declare Responder
> +		 * Capable if we want to enable PTM for it.
> +		 */
> +		if (!dev->ptm_responder)
> +			return -EINVAL;
> +		break;
> +
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_LEG_END:
> +		/*
> +		 * PCIe Endpoint must declare Requester Capable before we
> +		 * can enable PTM for it.
> +		 */
> +		if (!dev->ptm_requester)
> +			return -EINVAL;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
>  
>  	ctrl |= PCI_PTM_CTRL_ENABLE;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d1fdf81fbe1e..d5018cb5c331 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -500,6 +500,8 @@ struct pci_dev {
>  #ifdef CONFIG_PCIE_PTM
>  	u16		ptm_cap;		/* PTM Capability */
>  	unsigned int	ptm_root:1;
> +	unsigned int	ptm_responder:1;
> +	unsigned int	ptm_requester:1;
>  	unsigned int	ptm_enabled:1;
>  	u8		ptm_granularity;
>  #endif
> -- 
> 2.50.1
> 

