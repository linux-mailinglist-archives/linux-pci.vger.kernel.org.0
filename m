Return-Path: <linux-pci+bounces-30668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FDFAE9189
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 01:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215281C40D50
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 23:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8925A33F;
	Wed, 25 Jun 2025 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkYkLSKh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A540199FBA;
	Wed, 25 Jun 2025 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892595; cv=none; b=MBuSa/FTciiycXSb187IDfR8bbRsOU8CP6hgr5vsvNP0W4mWeyAhEB688d5VwTNP6K/pHyAUj7/W2cqEMnIkrBfRTzZDNgfWs1MAL8KeezylArW/K84nu7x70iimfqhylrCqBru9o2pQFqQ0CRGThNuLAVkfPZjw6EjBKU5gwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892595; c=relaxed/simple;
	bh=HM1PijCWVdSzhve5/G3djxtAr15MNy1qDo2hMNSw2IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CGWMDEkVACdP5HCbasPLz5IPMVrOfxlq0WnoZ7NIZx8ttAJQlfMK3vll1VDdD4xNZBNjomW1XSwXE2UkjbEXEzBQ0j1hx4wBqAE6EyhcrDL07PvL+h8dM5N7CNAxak0ooJhdAgbCMGWDSwKVol2iSroJff2ucotipT4ORSD2BYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkYkLSKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2E8C4CEEA;
	Wed, 25 Jun 2025 23:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750892595;
	bh=HM1PijCWVdSzhve5/G3djxtAr15MNy1qDo2hMNSw2IQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QkYkLSKhWyP0hIFbSPr2TlsPK29fvSpj1u2pBDhU1cI0D7p6TGxH7phqmDq3g1cnU
	 LpnBqaxRKLFxjGfkLVqxl6iHYibc60y/dQ3QVv710eYD19IemsDUx2yN3ONUEZSz8h
	 kh2kIZTqkJVvyjQlko5RT+miFlOrOlF/IRKShTnOlSgEmyhPrtbOu9N1ke6mm2K9Q+
	 zhDImdMS0XmwGluT+zdJqFE4GhgP76Cx85qs47V+rgseGr73OX26K6vcmr9C6kspq/
	 3cQ54HPyHCnGiSaPlt5GGHPAN5KNpf8e/DqImKne9Dy2j1mQa9dMGkvZ6EI/IbcR7h
	 150PmDJnM1OXg==
Date: Wed, 25 Jun 2025 18:03:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Vipin Sharma <vipinsh@google.com>,
	Aaron Lewis <aaronlewis@google.com>
Subject: Re: [RFC PATCH] PCI: Support Immediate Readiness on devices without
 PM capabilities
Message-ID: <20250625230313.GA1593493@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624171637.485616-1-seanjc@google.com>

On Tue, Jun 24, 2025 at 10:16:37AM -0700, Sean Christopherson wrote:
> Query support for Immediate Readiness irrespective of whether or not the
> device supports PM capabilities, as nothing in the PCIe spec suggests that
> Immediate Readiness is in any way dependent on PM functionality.

Huh, I forgot that we had support for Immediate Readiness at all.

I agree, Immediate Readiness has nothing to do with PM except that we
take advantage of it in a PM path, and I think pci_pm_init() was
probably not the best place to put this.

> Opportunistically add a comment to explain why "errors" during PM setup
> are effectively ignored.
> 
> Fixes: d6112f8def51 ("PCI: Add support for Immediate Readiness")
> Cc: David Matlack <dmatlack@google.com>
> Cc: Vipin Sharma <vipinsh@google.com>
> Cc: Aaron Lewis <aaronlewis@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> RFC as I'm not entirely sure this is useful/correct.
> 
> Found by inspection when debugging a VFIO VF passthrough issue that turned out
> to be 907a7a2e5bf4 ("PCI/PM: Set up runtime PM even for devices without PCI PM").
> 
> The folks on the Cc list are looking at parallelizing VF assignment to avoid
> serializing the 100ms wait on FLR.  I'm hoping we'll get lucky and the VFs in
> question do (or can) support PCI_STATUS_IMM_READY.
> 
>  drivers/pci/pci.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9e42090fb108..cd91adbf0269 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3198,33 +3198,22 @@ void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
>  	pci_update_current_state(pci_dev, PCI_D0);
>  }
>  
> -/**
> - * pci_pm_init - Initialize PM functions of given PCI device
> - * @dev: PCI device to handle.
> - */
> -void pci_pm_init(struct pci_dev *dev)
> +static void __pci_pm_init(struct pci_dev *dev)
>  {
>  	int pm;
> -	u16 status;
>  	u16 pmc;
>  
> -	device_enable_async_suspend(&dev->dev);
> -	dev->wakeup_prepared = false;
> -
> -	dev->pm_cap = 0;
> -	dev->pme_support = 0;
> -
>  	/* find PCI PM capability in list */
>  	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
>  	if (!pm)
> -		goto poweron;
> +		return;
>  	/* Check device's ability to generate PME# */
>  	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
>  
>  	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
>  		pci_err(dev, "unsupported PM cap regs version (%u)\n",
>  			pmc & PCI_PM_CAP_VER_MASK);
> -		goto poweron;
> +		return;
>  	}
>  
>  	dev->pm_cap = pm;
> @@ -3265,11 +3254,32 @@ void pci_pm_init(struct pci_dev *dev)
>  		/* Disable the PME# generation functionality */
>  		pci_pme_active(dev, false);
>  	}
> +}
> +
> +/**
> + * pci_pm_init - Initialize PM functions of given PCI device
> + * @dev: PCI device to handle.
> + */
> +void pci_pm_init(struct pci_dev *dev)
> +{
> +	u16 status;
> +
> +	device_enable_async_suspend(&dev->dev);
> +	dev->wakeup_prepared = false;
> +
> +	dev->pm_cap = 0;
> +	dev->pme_support = 0;
> +
> +	/*
> +	 * Note, support for the PCI PM spec is optional for legacy PCI devices
> +	 * and for VFs.  Continue on even if no PM capabilities are supported.
> +	 */
> +	__pci_pm_init(dev);
>  
>  	pci_read_config_word(dev, PCI_STATUS, &status);
>  	if (status & PCI_STATUS_IMM_READY)
>  		dev->imm_ready = 1;

I would rather just move this PCI_STATUS read to somewhere else.  I
don't think there's a great place to put it.  We could put it in
set_pcie_port_type(), which is sort of a grab bag of PCIe-related
things.

I don't know if it's necessarily even a PCIe-specific thing, but it
would be unexpected if somebody made a conventional PCI device that
set it, since the bit was reserved (and should be zero) in PCI r3.0
and defined in PCIe r4.0.

Maybe we should put it in pci_setup_device() close to where we call
pci_intx_mask_broken()?

Both PCI_STATUS_IMM_READY and PCI_STATUS_CAP_LIST are read-only, and
we currently read PCI_STATUS for every single pci_find_capability()
call, which is kind of stupid.  Maybe someday we can optimize that and
read PCI_STATUS once for both PCI_STATUS_CAP_LIST and
PCI_STATUS_IMM_READY.

> -poweron:
> +
>  	pci_pm_power_up_and_verify_state(dev);
>  	pm_runtime_forbid(&dev->dev);
>  	pm_runtime_set_active(&dev->dev);
> 
> base-commit: 86731a2a651e58953fc949573895f2fa6d456841
> -- 
> 2.50.0.714.g196bf9f422-goog
> 

