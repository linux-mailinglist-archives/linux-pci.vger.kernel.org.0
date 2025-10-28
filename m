Return-Path: <linux-pci+bounces-39551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE830C16144
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6873B12A7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C2347FE3;
	Tue, 28 Oct 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuZSRBdD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA26346E63
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671201; cv=none; b=t5nI79iHEs3/4WkrVFHB+9NZVI+xqozgcQoloPAdsimYG7YiXl84THpfPFfBllTlNiaGjBOu4mD8NTG6IY7jXDlugrPL9NIlCeyje5hqsVZu6yLhTVxCwBEOk9by3cBbR7VURnSStshWCa5mhocB8YBZDxCRkPH3lLlQL1h4OjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671201; c=relaxed/simple;
	bh=OsBmjAIgJG6vAo7/+5vvft5H8y1EDhJCqzJ+PDJMkS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fKXL8dpnfwxn0iluuaDVxFpu7BLlzb6BLbNhKP4CA8oJWt4BPaUZW94l7CyxxqP14W3uoohERAAX6t/EM5mivluZGIOBGebUSOnmMUAcexghGXo2+nMb/U47w5rc/LX+hB98RJcrxqcHzid6EhVHMo0UD/B6zg2njq4MZygQs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuZSRBdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D440DC4CEE7;
	Tue, 28 Oct 2025 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761671201;
	bh=OsBmjAIgJG6vAo7/+5vvft5H8y1EDhJCqzJ+PDJMkS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tuZSRBdDS1yTnBAp1SyLmV4Sl/+FnOGzoVt6Hfry5XKrocUCuVJg0Ziw2arLidARQ
	 gdDSGOs10xUD+ax0gAAxkVeTZMq+NiIEgN+zxwTcO6xiXPc6SvuuULxdwkzXqj4zKC
	 DGmnMdfjCpHXm7s1Ie8Lz9DQfVtf0awEGSTyHPmf6/OEMHgJCnexQfRrzXh6qEeQKz
	 DgXOOQHFLdDdJ1vfxk/ocj8HS6wLuWhvj7Fzcqv+4FZLx8uxVvmqTJSYXIz6Y2NhWh
	 //Vap/AcYbIE9K+w+YiA0nE3HONR1dOrimzFO2AKWlE63aJ1TIhD+cvc247akXjMGS
	 L835pPazcnDMA==
Date: Tue, 28 Oct 2025 12:06:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <20251028170639.GA1518773@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028060427.2163115-1-mika.westerberg@linux.intel.com>

On Tue, Oct 28, 2025 at 07:04:27AM +0100, Mika Westerberg wrote:
> It is not advisable to enable PTM solely based on the fact that the
> capability exists. Instead there are separate bits in the capability
> register that need to be set for the feature to be enabled for a given
> component (this is suggestion from Intel PCIe folks):
> 
>   - PCIe Endpoint that has PTM capability must to declare requester
>     capable
>   - PCIe Switch Upstream Port that has PTM capability must declare
>     at least responder capable
>   - PCIe Root Port must declare root port capable.
> 
> Currently we see following:
> 
>   pci 0000:01:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream Port
>   pci 0000:01:00.0: PCI bridge to [bus 00]
>   pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]
>   pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
>   pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>   ...
>   pci 0000:01:00.0: PTM enabled, 4ns granularity
>   ...
>   pcieport 0000:00:07.0: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.0
>   pcieport 0000:00:07.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
>   pcieport 0000:00:07.0:   device [8086:e44e] error status/mask=00200000/00000000
>   pcieport 0000:00:07.0:    [21] ACSViol                (First)
> 
> The 01:00.0 PCIe Upstream Port has this:
> 
>   Capabilities: [220 v1] Precision Time Measurement
> 		PTMCap: Requester- Responder- Root-
> 
> This happens because Linux sees the PTM capability and blindly enables
> PTM which then causes the AER error to trigger.
> 
> Fix this by enabling PTM only if the above described criteria is met.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Previous version can be seen:
> 
>   https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/
> 
> Changes from the previous version:
> 
>   - Limit Switch Upstream Port only to Responder, not both Requester and
>     Responder.
> 
>  drivers/pci/pcie/ptm.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 65e4b008be00..5ebb2edb4dec 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -81,9 +81,24 @@ void pci_ptm_init(struct pci_dev *dev)
>  		dev->ptm_granularity = 0;
>  	}
>  
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
> -		pci_enable_ptm(dev, NULL);
> +	switch (pci_pcie_type(dev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		/*
> +		 * Root Port must declare Root Capable if we want to
> +		 * enable PTM for it.
> +		 */
> +		if (dev->ptm_root)
> +			pci_enable_ptm(dev, NULL);
> +		break;
> +	case PCI_EXP_TYPE_UPSTREAM:
> +		/*
> +		 * Switch Upstream Ports must at least declare Responder
> +		 * Capable if we want to enable PTM for it.
> +		 */
> +		if (cap & PCI_PTM_CAP_RES)
> +			pci_enable_ptm(dev, NULL);
> +		break;
> +	}
>  }
>  
>  void pci_save_ptm_state(struct pci_dev *dev)
> @@ -125,7 +140,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>  {
>  	u16 ptm = dev->ptm_cap;
>  	struct pci_dev *ups;
> -	u32 ctrl;
> +	u32 cap, ctrl;
>  
>  	if (!ptm)
>  		return -EINVAL;
> @@ -144,6 +159,14 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>  			return -EINVAL;
>  	}
>  
> +	/*
> +	 * PCIe Endpoint must declare Requester Capable before we can
> +	 * enable PTM for it.
> +	 */
> +	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
> +	if (!(cap & PCI_PTM_CAP_REQ))
> +		return -EINVAL;

Isn't this going to prevent enabling PTM on Root Ports?

>  	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
>  
>  	ctrl |= PCI_PTM_CTRL_ENABLE;
> -- 
> 2.50.1
> 

