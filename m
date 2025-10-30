Return-Path: <linux-pci+bounces-39852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0472C225E0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8019B3AF17B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C901C84A0;
	Thu, 30 Oct 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf8efHjm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035634D3A1
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857979; cv=none; b=Pss9IvfoECw0IdB/pEHT2gB0KE0uiLfoaSUWA79anF7Q83EHemZxNulYFtKgmuXvMLoZir8sVul/UUmVj8ZEPpCtvh774FnacGusJ8EX0GabKQs8Op2P6AVVfofgnCLDTgjAzxzWupByP+M7NKqHY8gZJLVkHS2i0m3kqOzkK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857979; c=relaxed/simple;
	bh=TwhEIVOlGT3hjb1bVF2dsPTf1899iHh+s1PQE7SAdrk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aPA20QHhadK/Ld7C7X9nziUFL0FFe6Oe3Cvz3K35vllbDzL1JbKj8UHNtpGGimj+Qzhis2zJQZCEfRdlFK4xDQ9JhKWt96FeeDCElDjA2aGtOHEhdrFG3t8gEYdaKqOnt75pSR4z7pbyZ8bASsy1Ju9eyn1386C43rSrZau0ROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf8efHjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46522C4CEF1;
	Thu, 30 Oct 2025 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761857979;
	bh=TwhEIVOlGT3hjb1bVF2dsPTf1899iHh+s1PQE7SAdrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Zf8efHjmLhdItJt1WQEYqcPb0t/BWgTCu8O+vyzYSZi2HAwrg/9od7hkldZAxXmZV
	 CV4BqVCx1XvVrezODkuin4qkglfWLnGZfsq1sj9NKtXZJqE/2dy+A+wePEdQAOfMt3
	 c2gzBRQUzrlRHC67HE9LsxpdEsPRpk7JrMyZgRlcs1cm6YFZ9WfUcTbbirNhwoZrc6
	 pYvePFTOae4QOwg7aDIxsaihTqh3GPOOaYHvNmqy7XS9aA4dozO7sbSf0H7jZw10jU
	 C1PSUmqw7vNKDjjXxTDLydRgoB3mwc7q+yjjAUYHl9J5Em7sr9YDf9oBOBIbuSWx1/
	 k2+aCEfYv9UDQ==
Date: Thu, 30 Oct 2025 15:59:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <20251030205937.GA1648870@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030134606.3782352-1-mika.westerberg@linux.intel.com>

In subject, s/existense/existence/

Actually, I'd try to include something more specific like "enable PTM
only if it advertises a role".

On Thu, Oct 30, 2025 at 02:46:05PM +0100, Mika Westerberg wrote:
> It is not advisable to enable PTM solely based on the fact that the
> capability exists. Instead there are separate bits in the capability
> register that need to be set for the feature to be enabled for a given
> component (this is suggestion from Intel PCIe folks, and also shown in
> PCIe r7.0 sec 6.21.1 figure 6-21):

Can we start with a minimal statement of what's wrong?  Is the problem
that 01:00.0 sent a PTM Request Message that 00:07.0 detected as an
ACS violation?

I guess we enabled PTM on 01:00.0 even though it doesn't advertise any
roles in the PTM Capability, and it sent a PTM Request Message anyway?

Weird to expose a PTM Capability and not advertise any roles, and also
weird to send PTM Messages when enabled in that case.

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

I don't think the windows are relevant.

>   pci 0000:01:00.0: PTM enabled, 4ns granularity
>   ...
>   pcieport 0000:00:07.0: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.0
>   pcieport 0000:00:07.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
>   pcieport 0000:00:07.0:   device [8086:e44e] error status/mask=00200000/00000000
>   pcieport 0000:00:07.0:    [21] ACSViol                (First)

Is there any Header Log info here?  I assume if there is, it would
show a PTM Message?

> The 01:00.0 PCIe Upstream Port has this:
> 
>   Capabilities: [220 v1] Precision Time Measurement
> 		PTMCap: Requester- Responder- Root-
> 
> This happens because Linux sees the PTM capability and blindly enables
> PTM which then causes the AER error to trigger.
> 
> Fix this by enabling PTM only if the above described criteria is met.
> ...

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
> @@ -144,6 +159,18 @@ static int __pci_enable_ptm(struct pci_dev *dev)
>  			return -EINVAL;
>  	}
>  
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_LEG_END) {
> +		u32 cap;
> +		/*
> +		 * PCIe Endpoint must declare Requester Capable before we
> +		 * can enable PTM for it.
> +		 */
> +		pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
> +		if (!(cap & PCI_PTM_CAP_REQ))
> +			return -EINVAL;
> +	}

The asymmetry of testing PCI_PTM_CAP_ROOT back in pci_ptm_init() (via
dev->ptm_root) but testing PCI_PTM_CAP_REQ here feels a little
confusing to me.

Also, we already read PCI_PTM_CAP in pci_ptm_init(), and we did cache
ptm_root.  Maybe we should also cache ptm_responder and ptm_requester
and test all of them here in __pci_enable_ptm() and drop the tests in
pci_ptm_init()?

>  	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
>  
>  	ctrl |= PCI_PTM_CTRL_ENABLE;
> -- 
> 2.50.1
> 

