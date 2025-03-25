Return-Path: <linux-pci+bounces-24634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5245A6ED01
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02DB3B1F04
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491D253332;
	Tue, 25 Mar 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSQ8maGz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34E1FF1A1;
	Tue, 25 Mar 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896037; cv=none; b=BWEtbo/gvBeh7YnOKtqOv37jZOpBkQ2fQmTOZUQ66ruxuP6ogjAi3VkFv8RkY6FmZhOAtDQVRoIG8ac3htNcpPFfPEcsFgjkvXVoN2a4cv8WuZlPjspBiScnQr+gc3zm2l/avTwW5urt+4Qjy21Kcm2/tDVgKQAvn3eHpyWTiFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896037; c=relaxed/simple;
	bh=e/cDwoDYdQaopoXoOusl1jpVk2a3pu7zoD7m7IynecY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcgX8EI4UptWVB2L+0laFCJyn1i3h74b7K9fpqFEPnj1UkAkKC/87kBFbK+cQfHfDoV+2QbMXKlDytW8jEWtLJu3TamfmxjVgD/weAM0lQ3yYgWZaRpwOD3mykscKcs9/hQcbzx3xQ4g+8Gx9Cb0mcvV+p4ld20OZGU9AjHrPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSQ8maGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36E4C4CEF0;
	Tue, 25 Mar 2025 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742896037;
	bh=e/cDwoDYdQaopoXoOusl1jpVk2a3pu7zoD7m7IynecY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSQ8maGzxFhBcSBD98bBUetgXwUzTMQK5kVJCEOKHf7ep4LnNnGQYuruubV+f7i1Q
	 l6JrBXyixWQhqMiq39yAPsXSumlFxCm1dbcue9vG9VNWSSAOnczfDULgIvtxxbuduy
	 ewCCmcSgfYSowrlvcY3cRZFLD2zC4N5heFz4QKFV+XdfkUhyPT6k83KUDQ3WLoskGm
	 KX5BUo7I3FISHLPBazsfflFZ0Q9Bv3YzOY8og3hu+0n/cDvLgNzqEKB2tOLAxR5qLu
	 7eHygN1UplrEtFdLGk7rpmdAZF6WTbWe8WmDBKOPa3hzHVbCfqbQNtqJSHmRWI2+MB
	 +jU5N7rdahzSw==
Date: Tue, 25 Mar 2025 10:47:14 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>, 
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
Message-ID: <gu73hcbm5opv7wpdsbyyrends3dcxkzvran2asoepujlhfeqas@76rncc27opy2>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local>
 <87y0wtzg0z.ffs@tglx>
 <87v7rxzct0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7rxzct0.ffs@tglx>

On Tue, Mar 25, 2025 at 10:20:43AM +0100, Thomas Gleixner wrote:
> On Tue, Mar 25 2025 at 09:11, Thomas Gleixner wrote:
> 
> > On Mon, Mar 24 2025 at 20:18, Roger Pau Monné wrote:
> >> On Mon, Mar 24, 2025 at 07:58:14PM +0100, Daniel Gomez wrote:
> >>> The issue is that info appears to be uninitialized. So, this worked for me:
> >>
> >> Indeed, irq_domain->host_data is NULL, there's no msi_domain_info.  As
> >> this is x86, I was expecting x86 ot always use
> >> x86_init_dev_msi_info(), but that doesn't seem to be the case.  I
> >> would like to better understand this.
> >
> > Indeed. On x86 this should not happen at all. On architectures, which do
> > not use (hierarchical) interrupt domains, it will return NULL.
> >
> > So I really want to understand why this happens on x86 before such a
> > "fix" is deployed.
> 
> So after staring at it some more it's clear. Without XEN, the domain
> returned is the MSI parent domain, which is the vector domain in that
> setup. That does not have a domain info set. But on legacy architectures
> there is not even a domain.
> 
> It's really wonderful that we have a gazillion ways to manage the
> backends of PCI/MSI....
> 
> So none of the suggested pointer checks will cover it correctly. Though
> there is already a function which allows to query MSI domain flags
> independent of the underlying insanity. Sorry for not catching it in
> review.
> 
> Untested patch below.
> 
> Thanks,
> 
>         tglx
> ---
>  drivers/pci/msi/msi.c |   18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -285,8 +285,6 @@ static void pci_msi_set_enable(struct pc
>  static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
>  			      struct irq_affinity_desc *masks)
>  {
> -	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
> -	const struct msi_domain_info *info = d->host_data;
>  	struct msi_desc desc;
>  	u16 control;
>  
> @@ -297,7 +295,7 @@ static int msi_setup_msi_desc(struct pci
>  	/* Lies, damned lies, and MSIs */
>  	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
>  		control |= PCI_MSI_FLAGS_MASKBIT;
> -	if (info->flags & MSI_FLAG_NO_MASK)
> +	if (pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY))
>  		control &= ~PCI_MSI_FLAGS_MASKBIT;
>  
>  	desc.nvec_used			= nvec;
> @@ -605,20 +603,18 @@ static void __iomem *msix_map_region(str
>   */
>  void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
>  {
> -	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
> -	const struct msi_domain_info *info = d->host_data;
> -
>  	desc->nvec_used				= 1;
>  	desc->pci.msi_attrib.is_msix		= 1;
>  	desc->pci.msi_attrib.is_64		= 1;
>  	desc->pci.msi_attrib.default_irq	= dev->irq;
>  	desc->pci.mask_base			= dev->msix_base;
> -	desc->pci.msi_attrib.can_mask		= !(info->flags & MSI_FLAG_NO_MASK) &&
> -						  !desc->pci.msi_attrib.is_virtual;
>  
> -	if (desc->pci.msi_attrib.can_mask) {
> +
> +	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY) &&
> +	    !desc->pci.msi_attrib.is_virtual) {
>  		void __iomem *addr = pci_msix_desc_addr(desc);
>  
> +		desc->pci.msi_attrib.can_mask = true;

can_mask is u8.

>  		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  	}
>  }
> @@ -715,8 +711,6 @@ static int msix_setup_interrupts(struct
>  static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  				int nvec, struct irq_affinity *affd)
>  {
> -	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
> -	const struct msi_domain_info *info = d->host_data;
>  	int ret, tsize;
>  	u16 control;
>  
> @@ -747,7 +741,7 @@ static int msix_capability_init(struct p
>  	/* Disable INTX */
>  	pci_intx_for_msi(dev, 0);
>  
> -	if (!(info->flags & MSI_FLAG_NO_MASK)) {
> +	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY)) {
>  		/*
>  		 * Ensure that all table entries are masked to prevent
>  		 * stale entries from firing in a crash kernel.

It works, thanks!

For the final patch:

Tested-by: Daniel Gomez <da.gomez@samsung.com>

Daniel

