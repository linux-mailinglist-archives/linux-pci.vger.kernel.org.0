Return-Path: <linux-pci+bounces-44687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF53D1BC37
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 00:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8926301462E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 23:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1528335EDCF;
	Tue, 13 Jan 2026 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P11URlCr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F028EA72;
	Tue, 13 Jan 2026 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348787; cv=none; b=jjD8FCaLwejZJcYl0UlVswMlT0gTEYe886saSdh5qnc2KnQ5Kk7/RHosDzoRfbHncMX4iCjgAogXEgRh8RP8GZhmdGUfFthDIiPH1qUOgXvYgf0rOrMnOB+4mu6+lwFIB77YNXyzXFyOJb/GtFsdH0627MUlv7Sd27ur+PuFguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348787; c=relaxed/simple;
	bh=K9R7l0cROeNekSeWyIkNpzEvhO4yWMmjOH7Qw18sbGs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C8U6e31L1PitdHneyPUxkUUCmtw1uIDzAv20eUMAh/k4c6cZC92B3LONuBlbo59POKL+Uj19Qg+ahcyezsZH78lpdlQHaGpJosOTKToLs9u+poTfHVpfJRZyWeOhUeGTUMK3jTIq4FBJXHeTMtYRD9di8dZhL7ZrvlpZrDvIYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P11URlCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9646BC116C6;
	Tue, 13 Jan 2026 23:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768348786;
	bh=K9R7l0cROeNekSeWyIkNpzEvhO4yWMmjOH7Qw18sbGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P11URlCrylRLM0rgx1VFeYONBYuIgxm/mXSM8hU0zqLJMXRupMyjIYbDVA9pz6qFd
	 o7T1F00xEkkSsud9hopqe9IC8f7dVC5zIIhYZh9oJKhvSfhe/1EFXYm1119Oa4+bOD
	 leQB3OatLxuDX28u5XArdY0nghLzTAWGZDij3pSw9u3mQrdcJNyCdFSn6UBjPsLsJi
	 ii0ORPgQ+MO3LYg3MJM8zPe6odgljNuOV8o+IlWpcxecPLvl0cHRpTqDpQLGSnRK0F
	 0fLkB2TzFVml26sSGZsyh+L+V/r4E8kzGJp0u2wsfw4ROuarMCh8c5KkaGaworjFSu
	 /w+DPpq5QF54A==
Date: Tue, 13 Jan 2026 17:59:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Message-ID: <20260113235945.GA787062@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113171522.3446407-1-haakon.bugge@oracle.com>

On Tue, Jan 13, 2026 at 06:15:20PM +0100, Håkon Bugge wrote:
> program_hpx_type2() is today unconditionally called, despite the fact
> that when the _HPX was added to the ACPI spec. v3.0, the description
> stated:

> +	/* We only do the HP programming if we own the PCIe native
> +	 * hotplug and not the AER ownership
> +	 */

Conventional multi-line comments are:

  /*
   * We ...
   */

> +	if (!host->native_pcie_hotplug || host->native_aer)
> +		return;
> +
>  	if (hpx->revision > 1) {
>  		pci_warn(dev, "PCIe settings rev %d not supported\n",
>  			 hpx->revision);
>  		return;
>  	}
>  
> -	/*
> -	 * Don't allow _HPX to change MPS or MRRS settings.  We manage
> -	 * those to make sure they're consistent with the rest of the
> +	/* We only allow _HPX to program the AER registers, namely
> +	 * PCI_EXP_DEVCTL_CERE, PCI_EXP_DEVCTL_NFERE,
> +	 * PCI_EXP_DEVCTL_FERE, and PCI_EXP_DEVCTL_URRE.
> +	 *
> +	 * The other settings in PCIe DEVCTL are managed by OS in
> +	 * order to make sure they're consistent with the rest of the
>  	 * platform.
>  	 */
> -	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
> -				    PCI_EXP_DEVCTL_READRQ;
> -	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
> -				    PCI_EXP_DEVCTL_READRQ);
> +	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_RELAX_EN   |
> +				   PCI_EXP_DEVCTL_PAYLOAD    |
> +				   PCI_EXP_DEVCTL_EXT_TAG    |
> +				   PCI_EXP_DEVCTL_PHANTOM    |
> +				   PCI_EXP_DEVCTL_AUX_PME    |
> +				   PCI_EXP_DEVCTL_NOSNOOP_EN |
> +				   PCI_EXP_DEVCTL_READRQ     |
> +				   PCI_EXP_DEVCTL_BCR_FLR;
> +	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_RELAX_EN   |
> +				    PCI_EXP_DEVCTL_PAYLOAD    |
> +				    PCI_EXP_DEVCTL_EXT_TAG    |
> +				    PCI_EXP_DEVCTL_PHANTOM    |
> +				    PCI_EXP_DEVCTL_AUX_PME    |
> +				    PCI_EXP_DEVCTL_NOSNOOP_EN |
> +				    PCI_EXP_DEVCTL_READRQ     |
> +				    PCI_EXP_DEVCTL_BCR_FLR);

Instead of listing the bits we *don't* want to touch, I think we
should explicitly *include* CERE, NFERE, FERE, URRE.  Maybe we should
move the PCI_EXP_AER_FLAGS #define to drivers/pci/pci.h so we could
use it directly, e.g.,

  hpx->pci_exp_devctl_and |= ~PCI_EXP_AER_FLAGS;
  hpx->pci_exp_devctl_or &= PCI_EXP_AER_FLAGS;

>  	/* Initialize Device Control Register */
>  	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>  			~hpx->pci_exp_devctl_and, hpx->pci_exp_devctl_or);
>  
> -	/* Initialize Link Control Register */
> +	/* Log the Link Control Register if any bits are set */
>  	if (pcie_cap_has_lnkctl(dev)) {
> +		u16 lnkctl;
>  
> -		/*
> -		 * If the Root Port supports Read Completion Boundary of
> -		 * 128, set RCB to 128.  Otherwise, clear it.
> -		 */
> -		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
> -		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
> -		if (pcie_root_rcb_set(dev))
> -			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
> -
> -		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> -			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
> +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> +		if (lnkctl)
> +			pci_warn(dev, "Some bits in PCIe Link Control are set: 0x%04x\n",
> +				 lnkctl);

Sorry, I wasn't clear about this.  I meant that we could log the
LNKCTL AND/OR values from _HPX, not the values from PCI_EXP_LNKCTL
itself.  There will definitely be bits set in PCI_EXP_LNKCTL in normal
operation, which is perfectly fine.

But if pci_exp_lnkctl_and or pci_exp_lnkctl_or are non-zero, the
platform is telling us to do something, and we're ignoring it.
*That's* what I think we might want to know about.  pci_info() is
probably sufficient; the user doesn't need to *do* anything with it, I
just want it in case we need to debug an issue.

Bjorn

