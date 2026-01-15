Return-Path: <linux-pci+bounces-44981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DB0D278DE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 19:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D67E532990EF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064C3BFE5D;
	Thu, 15 Jan 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWC1dbu/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88E3BF309;
	Thu, 15 Jan 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499150; cv=none; b=esYAIEAikXcfwVbRGrMx2sCx9VLhwaKT1PaJho7/EEF8irHj/KzV0W+HajXVnk8BcEN7ZZwDdiP1OkmMHtGVmMJjvKXSZQA2dNkPwviQyfY2wwTX5u5BH0sizLGVYIJgWsp4L8BfUOb28TdU8QXYUGTHQZ2HA3AeNCD71x0IbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499150; c=relaxed/simple;
	bh=7y5GZutTT6vu6rSfOVsILzhDGRx7gArXmT4MXYQzpo8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=goLg5zEPdN6s57rQxigZ9UGygwzxnacL+TqBYIe3In3OoWCKfLildPulpwW48d0XgJ/ofbGmr1FSR20tvPh29Pa11kpCaydD3e2ZbkdLFuyQm3GTL01jdpV8srglkNnahQOMAF0VnFqoYKbVx5ScmiQ7tya8FKVwcX5rWXBIiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWC1dbu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB702C19423;
	Thu, 15 Jan 2026 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499149;
	bh=7y5GZutTT6vu6rSfOVsILzhDGRx7gArXmT4MXYQzpo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tWC1dbu/Y+1idPEqAS5UlUBs9hUwE4kL8rLdUlTAlDVPqugW22cMaXIREhw4DiSrw
	 tM71Sxj+O6awmq4rmBIvo/bWPZGP81H6PwSue+RIMEspcYJ3yNSo6oo8Phww1Mexnt
	 mjr8uYWMYV86J24VaBwlzg0umPr24bfCaKOVM5htFJQd4HN6kMlBBg/JI5qgUTrw7F
	 2RlTmdUiQFDZi2QYmlM+uLbRdkE1ct/9Rb3LZZbeAZ1ft30VKDW4Wze6Vov/PujO/N
	 7P6pld56zIICJsX4Jae0t1lvuyzEeO1X0QZi+ogoGKdKsB27k94dKHqCcEeIcPYdOF
	 xAUwxNGdmj5HA==
Date: Thu, 15 Jan 2026 11:45:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Message-ID: <20260115174548.GA873328@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52ED30CB-08FB-44AD-B366-AA3263236FA5@oracle.com>

On Thu, Jan 15, 2026 at 03:39:21PM +0000, Haakon Bugge wrote:
> Thanks for the review, Bjørn!
> ...

> >> +	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_RELAX_EN   |
> >> +				    PCI_EXP_DEVCTL_PAYLOAD    |
> >> +				    PCI_EXP_DEVCTL_EXT_TAG    |
> >> +				    PCI_EXP_DEVCTL_PHANTOM    |
> >> +				    PCI_EXP_DEVCTL_AUX_PME    |
> >> +				    PCI_EXP_DEVCTL_NOSNOOP_EN |
> >> +				    PCI_EXP_DEVCTL_READRQ     |
> >> +				    PCI_EXP_DEVCTL_BCR_FLR);
> >> 
> > Instead of listing the bits we *don't* want to touch, I think we
> > should explicitly *include* CERE, NFERE, FERE, URRE.  Maybe we should
> > move the PCI_EXP_AER_FLAGS #define to drivers/pci/pci.h so we could
> > use it directly, e.g.,
> > 
> >  hpx->pci_exp_devctl_and |= ~PCI_EXP_AER_FLAGS;
> >  hpx->pci_exp_devctl_or &= PCI_EXP_AER_FLAGS;
> 
> Good idea. But what about moving it to include/uapi/linux/pci_regs.h
> and also rename it from PCI_EXP_AER_FLAGS to PCI_EXP_DEVCTL_AER, to
> match the convention for DEVCTL in pci_regs.h?

I suggested drivers/pci/pci.h because (so far) the only need for
PCI_EXP_AER_FLAGS is in drivers/pci, and that set of flags seems like
an OS policy.  Most of pci_regs.h is basically translating the PCI
spec into #defines, without any real usage or policy parts.  I'm not
sure whether PCI_EXP_AER_FLAGS would be useful to userspace.

> >> 	if (pcie_cap_has_lnkctl(dev)) {
> >> +		u16 lnkctl;
> >> 
> >> -		/*
> >> -		 * If the Root Port supports Read Completion Boundary of
> >> -		 * 128, set RCB to 128.  Otherwise, clear it.
> >> -		 */
> >> -		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
> >> -		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
> >> -		if (pcie_root_rcb_set(dev))
> >> -			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
> >> -
> >> -		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> >> -			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
> >> +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> >> +		if (lnkctl)
> >> +			pci_warn(dev, "Some bits in PCIe Link Control are set: 0x%04x\n",
> >> +				 lnkctl);
> >> 
> > Sorry, I wasn't clear about this.  I meant that we could log the
> > LNKCTL AND/OR values from _HPX, not the values from PCI_EXP_LNKCTL
> > itself.  There will definitely be bits set in PCI_EXP_LNKCTL in normal
> > operation, which is perfectly fine.
> > 
> > But if pci_exp_lnkctl_and or pci_exp_lnkctl_or are non-zero, the
> > platform is telling us to do something, and we're ignoring it.
> > *That's* what I think we might want to know about.  pci_info() is
> > probably sufficient; the user doesn't need to *do* anything with it, I
> > just want it in case we need to debug an issue.
> 
> My bad, Yes, that makes more sense to me. And, you're OK with
> removing the RCB tweaking as well?

Good question.  My hope is that the code here is just to make sure
that we don't *clear* PCI_EXP_LNKCTL_RCB when we want it set but a
type 2 record might clear it by mistake.

We should audit PCI_EXP_LNKCTL_RCB usage to be sure that if we remove
this code, PCI_EXP_LNKCTL_RCB will still be set whenever it needs to
be set.  If we rely on the existence of an _HPX type 2 record for it
to be set, that would be completely wrong.

Bjorn

