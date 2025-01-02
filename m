Return-Path: <linux-pci+bounces-19174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E89FFC79
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 18:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2AD1883042
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D77613D297;
	Thu,  2 Jan 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIOt6Zlh"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67833DF51
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735837450; cv=none; b=bQNeji749JIiCf3DJ5IA4E56F8fo2EwpjPUONXBJn4/QFMnQ6H0U+/7ZqsrnwrywLhwPZ+ve1DrdAklWBMDfs+pKdjayeQKhVQvkioAlaTS+kVh3ippZY4ISJsZmoNwlpoEshu6oJqQYgcFRXQAVSH9sesrPSDgL+Y2pM0kG6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735837450; c=relaxed/simple;
	bh=2s40S4b6USjGIdNljcVdkIWW3U93jkP6hNwEQFJvfis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPRBHwkK23AcADihAJxkS/H13gtyU2/VhYPzEaw6wEiWr+vyU0VyJyBh01yCYQdsvxtxkZLjtYVLrgqTKHp+zMiPLx3uaZT5/Yt9n0LYJvUeY5NI3BdmmKFg1GHDAYqP54uV7b5WERnO3Hc5x48LkLMIosCNFaIqJXEMNM7TmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIOt6Zlh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735837447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIhfj2neT2Cq5Sys8iG+Q7GAI3LQhoUylThNksKZoFg=;
	b=UIOt6Zlhoz68QrFrKNeHtL8c7+1utU51RAM5TdXUL8RJgyY5dlN1GCAi/XSLea7Aaebuz6
	1YyU6nnSubc20mPnaKQ1Sl2F+PgYY6/b4luSEWmN2xfCwDT6WM3ZRt4XlL29RQpF1PG9TN
	Xq8UH6r+9kjA/ZR+ZybwLf+QMmj0Fbo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-2HXCrr5XOXy6CMwKxHxenA-1; Thu, 02 Jan 2025 12:04:06 -0500
X-MC-Unique: 2HXCrr5XOXy6CMwKxHxenA-1
X-Mimecast-MFC-AGG-ID: 2HXCrr5XOXy6CMwKxHxenA
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9d431dd89so15887955ab.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2025 09:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735837445; x=1736442245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIhfj2neT2Cq5Sys8iG+Q7GAI3LQhoUylThNksKZoFg=;
        b=Dd46GWR+OAfoem/iYfGXKIFC1yDv0qzM6JINwPbPV7gwl8qK3JpnFvnddfcAHNx22z
         SkNeTv2qmHHL30xdoRVO+alK0Co849IkTCu+NahmlT22WEO1VdVEmU8vjhSe0y7YmtZH
         uzp5iVxgkNpV5wDZ5EcwRHFRGQRymhIOjUL7n1xgp2bLc7hKjzBMcJeGQizVeJrObqkz
         vc1Ow+8XkN+XGkOMfprh1W0Z1+CqxLtzfQbT5WJjR/NXbQtKS4ZcOsM3sUT8xt0Js8MX
         6vW300JzMJwPR85YHU+d4yP6o78X+mLByEJSX9yvVWMj9vJcG4S35Eg/SwnJNWUF//2a
         Bdog==
X-Forwarded-Encrypted: i=1; AJvYcCVUCUMZCkK8QuIScb2bfUthTf1un09CqRCXd7jTP9lPvsvEpLVPk/9stYNR7H84Ww7toHQ8IPLYea0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRgV0LgtEQl9cNeYeUYjPdIFVvbyY546ImAUmM3oNqgHt+MjE
	ZC6FmsQOqTwze/Zf2NVV58Er2njmGRvM3QB3rvLb+kehK5G/I2DvZa+RN3fCEUFII+TEpdgitbx
	kEKDKh1FwCHkT4awhhryZUfT4sYYCWPersOCa9anwPlNTZMQHRsH8niRjPw==
X-Gm-Gg: ASbGncvNB1iMJCHr6OiivEC0lp65G6PRhxmGUn0GKxsPHL77C/obPj6EhTx7QuoVJP8
	075she1ajQAk1mQpWoyprSaxynxEy162ncMpjwzjQBWWpU9lVisNtzzq/Z4jbMRROpVzK7aBEiU
	/OIFw3+meGT2dPquhGQs3Rh51RmyYuXdLJhslTZtnseadzS+hyhCncQ/R6tpdWRAXjPAwU/rqjd
	XOPJ7k5lOJ3otc25jI2PZtMB4OheeETAX6xrAutvKPlXp1iAspQaNByQMFa
X-Received: by 2002:a05:6e02:1a66:b0:3a7:de79:4bae with SMTP id e9e14a558f8ab-3c2d591aba1mr104010855ab.6.1735837445305;
        Thu, 02 Jan 2025 09:04:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUmgEQfcn/IbV4FmINh8hatAVeprR0hKK9j3SVlEr6dy3vdn1vftIkSYMIzcRiJ3nHmzeMEA==
X-Received: by 2002:a05:6e02:1a66:b0:3a7:de79:4bae with SMTP id e9e14a558f8ab-3c2d591aba1mr104010705ab.6.1735837444924;
        Thu, 02 Jan 2025 09:04:04 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0e402a5a9sm75384225ab.58.2025.01.02.09.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 09:04:04 -0800 (PST)
Date: Thu, 2 Jan 2025 10:04:02 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Precific <precification@posteo.de>, Athul Krishna
 <athul.krishna.kr@protonmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Linux PCI
 <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 219619] New: vfio-pci: screen
 graphics artifacts after 6.12 kernel upgrade]
Message-ID: <20250102100402.33fa8435.alex.williamson@redhat.com>
In-Reply-To: <Z3bBOxFaCyizcxmx@x1n>
References: <20241222223604.GA3735586@bhelgaas>
	<Hb6kvXlGizYbogNWGJcvhY3LsKeRwROtpRluHKsGqRcmZl68J35nP60YdzW1KSoPl5RO_dCxuL5x9mM13jPBbU414DEZE_0rUwDNvzuzyb8=@protonmail.com>
	<Z2mW2k8GfP7S0c5M@x1n>
	<16ea1922-c9ce-4d73-b9b6-8365ca3fcf32@posteo.de>
	<20241230182737.154cd33a.alex.williamson@redhat.com>
	<bba03a61-9504-40d0-9b2c-115b4f70e8ca@posteo.de>
	<20241231090733.5cc5504a.alex.williamson@redhat.com>
	<Z3bBOxFaCyizcxmx@x1n>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 11:39:23 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Dec 31, 2024 at 09:07:33AM -0700, Alex Williamson wrote:
> > On Tue, 31 Dec 2024 15:44:13 +0000
> > Precific <precification@posteo.de> wrote:
> >   
> > > On 31.12.24 02:27, Alex Williamson wrote:  
> > > > On Mon, 30 Dec 2024 21:03:30 +0000
> > > > Precific <precification@posteo.de> wrote:
> > > >     
> > > >> In my case, commenting out (1) the huge_fault callback assignment from
> > > >> f9e54c3a2f5b suffices for GPU initialization in the guest, even if (2)
> > > >> the 'install everything' loop is still removed.
> > > >>
> > > >> I have uploaded host kernel logs with vfio-pci-core debugging enabled
> > > >> (one log with stock sources, one large log with vfio-pci-core's
> > > >> huge_fault handler patched out):
> > > >> https://bugzilla.kernel.org/show_bug.cgi?id=219619#c1
> > > >> I'm not sure if the logs of handled faults say much about what
> > > >> specifically goes wrong here, though.
> > > >>
> > > >> The dmesg portion attached to my mail is of a Linux guest failing to
> > > >> initialize the GPU (BAR 0 size 16GB with 12GB of VRAM).    
> > > > 
> > > > Thanks for the logs with debugging enabled.  Would you be able to
> > > > repeat the test with QEMU 9.2?  There's a patch in there that aligns
> > > > the mmaps, which should avoid mixing 1G and 2MB pages for huge faults.
> > > > With this you should only see order 18 mappings for BAR0.
> > > > 
> > > > Also, in a different direction, it would be interesting to run tests
> > > > disabling 1G huge pages and 2MB huge pages independently.  The
> > > > following would disable 1G pages:
> > > > 
> > > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > > > index 1ab58da9f38a..dd3b748f9d33 100644
> > > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > > @@ -1684,7 +1684,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
> > > >   							     PFN_DEV), false);
> > > >   		break;
> > > >   #endif
> > > > -#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
> > > > +#if 0
> > > >   	case PUD_ORDER:
> > > >   		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn + pgoff,
> > > >   							     PFN_DEV), false);
> > > > 
> > > > This should disable 2M pages:
> > > > 
> > > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > > > index 1ab58da9f38a..d7dd359e19bb 100644
> > > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > > @@ -1678,7 +1678,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
> > > >   	case 0:
> > > >   		ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
> > > >   		break;
> > > > -#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> > > > +#if 0
> > > >   	case PMD_ORDER:
> > > >   		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn + pgoff,
> > > >   							     PFN_DEV), false);
> > > > 
> > > > And applying both together should be functionally equivalent to
> > > > pre-v6.12.  Thanks,
> > > > 
> > > > Alex
> > > >     
> > > 
> > > Logs with QEMU 9.1.2 vs. 9.2.0, all huge_page sizes/1G only/2M only: 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=219619#c3
> > > 
> > > You're right, I was still using QEMU 9.1.2. With 9.2.0, the 
> > > passed-through GPU works fine indeed with both Linux and Windows guests.
> > > 
> > > The huge_fault calls are aligned nicely with QEMU 9.2.0. Only the lower 
> > > 16MB of BAR 0 see repeated calls at 2M/4K page sizes but no misalignment.
> > > The QEMU 9.1.2 'stock' log shows a misalignment with 1G faults (order 
> > > 18), e.g., huge_faulting 0x40000 pages at page offset 0 and later 
> > > 0x4000. I'm not sure if that is a problem, or if the offsets are simply 
> > > masked off to the correct alignment.
> > > QEMU 9.1.2 also works with 1G pages disabled. Perhaps coincidentally, 
> > > the offsets are aligned properly for order 9 (0x200 'page offset' 
> > > increments) from what I've seen.  
> > 
> > Thank you so much for your testing, this is immensely helpful!  This
> > all suggests to me we're dealing with an alignment issue for 1GB pages.
> > We're getting 2MB alignment on the mmap by default, so that's working
> > everywhere.  QEMU 9.2 provides us with proper 1GB alignment, but it
> > seems we need to filter alignment more strictly when that's not present.
> > Please give this a try with QEMU 9.1.x and an otherwise stock v6.12.x:
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 1ab58da9f38a..bdfdc8ee4c2b 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1661,7 +1661,8 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
> >  	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
> >  	vm_fault_t ret = VM_FAULT_SIGBUS;
> >  
> > -	if (order && (vmf->address & ((PAGE_SIZE << order) - 1) ||
> > +	if (order && (pgoff & ((1 << order) - 1) ||
> > +		      vmf->address & ((PAGE_SIZE << order) - 1) ||
> >  		      vmf->address + (PAGE_SIZE << order) > vma->vm_end)) {
> >  		ret = VM_FAULT_FALLBACK;
> >  		goto out;  
> 
> That's a great finding..  I wish we could have some sanity check in things
> like pud_mkhuge() on the pfns at least for x86: SDM says the rest bits for
> a huge pfn must be zero (for example, bit 29-13 for 1G), but didn't say
> what if not. I assume that could panic at the right place if such check
> ever existed.
> 
> OTOH, a pure question here is whether we should check pfn+pgoff instead of
> pgoff alone.  I have no idea how firmware would allocate BAR resources,
> especially on start address alignments.  I assume that needs to be somehow
> relevant to the max size of the bar, probably the start address should
> always be aligned to that max bar size?  If so, there should have no
> functional difference checking either pfn+pgoff or pgoff.  It could be a
> matter of readability in that case, saying that the limitation is about pfn
> (of pgtable) rather than directly relevant to the offset of the bar.

Yes, I'm working on the proper patch now that we have a root cause and
I'm changing this to test alignment of pfn+pgoff.  The PCI BARs
themselves are required to have natural alignment, but the vma mapping
the BAR could be at an offset from the base of the BAR, which is
accounted for in our local vma_to_pfn() function.  So I agree that
pfn+pgoff is the more complete fix, which I'll post soon, and hope that
Precific can re-verify the fix.  Thanks,

Alex


