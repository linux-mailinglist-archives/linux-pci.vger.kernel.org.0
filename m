Return-Path: <linux-pci+bounces-19171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E099FFC03
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68D51883692
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015DB187FEC;
	Thu,  2 Jan 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5b11ZkC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481914BFA2
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835971; cv=none; b=WRAAmVQnbnNsRhQYUVeSn2lFVjNMk5FxgVCNbkAgmQjOLUkm4PgUeT/OiHiwyaGQQBLki5Yf66SvtllkbOF4h4bmBxsKIm5EBqIiGH9mtXbYjKJO8V3OrjzFoMr+SM+hGgJ5OjljRP0Gqlw9ZPs3xAq64ikarCf7yOMkPe1cITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835971; c=relaxed/simple;
	bh=5q+8JjcrKKOdHbLWvobmytsVYQr6L7Z9RV1Q/0kwrS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkYPA+Scak8gUBHJXfGdjgK+2j9eTWP/NaIBp9zoY6nJUt0jUdtC6s8C5cYvpIlTfMome2sbSfWFL4/fV1Qauk9tVaOyfY97iyILW6i7VbpQIB961H3LwlI0M2UjMKtq5gxhiv4oMpwu1QF2QMniZ+ezDs4Lh195wvLtzu4Ggls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5b11ZkC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735835968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6mSaAhcXBA0YnKtRWFvg7xIGQvscrbfSodX8i2/8vE=;
	b=S5b11ZkCBbalKddsJGO4gfHNog3CJ8um6OmRcL8myiV6ER3HXICB4TKUesHjxDUenv7GX4
	DHF897vbgSG4iTspKguzjZwblwKz1ZUu5HLg9SZ8sqRMaQh33i+bATXXbkvbNhN6XaWQbn
	uqG94M7QbblUGcfCy4PJncBNSp+TsVw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-anuKRsh3P-ezqUYomdPGBA-1; Thu, 02 Jan 2025 11:39:27 -0500
X-MC-Unique: anuKRsh3P-ezqUYomdPGBA-1
X-Mimecast-MFC-AGG-ID: anuKRsh3P-ezqUYomdPGBA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-467ae19e34bso67131321cf.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2025 08:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735835967; x=1736440767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6mSaAhcXBA0YnKtRWFvg7xIGQvscrbfSodX8i2/8vE=;
        b=PP38ox10Q8x+uCZ/Vvj547jgJ59b66B6V1Xirvr1VSG5Tur+ysq1Usc6uwYgTxPuu1
         mpPfmGDtDXYljTxpHoVNkx3NENTnmipNiQRPyC4tkMzcvzO6SzDyr8AI4H+9yjZbKM25
         xhUsVtfS9eaHSSYizsSS6M65ahToGG39ofpfWXMOnCBbhve6ZM/mwN1VJPh8KNqFoZX9
         /rU6kZglIz6Dvu5rvLraSwFYQ8Xglx0DL+UMeRNEZ+2/OFwY0Ekl9sHJ1NEbi86YRC8A
         o9wM0F7S1EgE/AKUdgjRiBDK7aZsUTl+iQTXbHu9QuqbpGrEGcKiHSruZjIDDUO37A3X
         19Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVW6/N3uq8WtEjydaKlaQJPtVlyZmTyanS5Udnx8DiMqY73enlR5NJOP0yd/BlaWL+EFbH++KAw70E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWvbeeZvreruip7ihaz1FFEWo23HPv+JJJywxY1rj5z+PWBwY
	4yJXZeeGLkoRucJmBB0XHqE9vXZGSmkO1VpGDNCQPLK2wuHA8fRnteXwhyFzW2JeSjfFu/odYRj
	KpePVnUvtl9ywsGAySbnhToT4NehXl93X3CmY6QAjrG0Gj04C0T74KyaOjDKyFHa5UA==
X-Gm-Gg: ASbGncvdIdsUT1kVzFnw0WpDqpxMZQp6bMfg3TvOIq9Qvo3tfmK7wa7iJPZelrHJslW
	0iKjLotvLcktQui3ACujKTj9O3rW1nqWtasSQV4OyLpLJHeo+vqF0+qFCtYiRtGERLOuo8apaRT
	X6Xo2Yajve0mlcYHOolo3+avK6NkDF8q6G0C8rVZS55tMCA/Z2D8LRLxMo036dH9eecVCWWjcSU
	cgEyt5x6D/lBnPqTajARKFNfspFQtYTDY6sAotAaJna1XvA84GW6Pt80f3w0oztHzD4IIwPd1iA
	5Tk2haGXtK/z7hOofw==
X-Received: by 2002:ac8:7f94:0:b0:466:85eb:6118 with SMTP id d75a77b69052e-46a4a8dcd5fmr716740521cf.16.1735835967007;
        Thu, 02 Jan 2025 08:39:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGr9oTZZCQq3x5f41Tw7snp0cWem1xv5LNFxJYZtqcjHbXo2XyK5xC3eV3tnF5YwhDfssKtQ==
X-Received: by 2002:ac8:7f94:0:b0:466:85eb:6118 with SMTP id d75a77b69052e-46a4a8dcd5fmr716740141cf.16.1735835966665;
        Thu, 02 Jan 2025 08:39:26 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb175eesm137500911cf.55.2025.01.02.08.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 08:39:25 -0800 (PST)
Date: Thu, 2 Jan 2025 11:39:23 -0500
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Precific <precification@posteo.de>,
	Athul Krishna <athul.krishna.kr@protonmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 219619] New: vfio-pci: screen
 graphics artifacts after 6.12 kernel upgrade]
Message-ID: <Z3bBOxFaCyizcxmx@x1n>
References: <20241222223604.GA3735586@bhelgaas>
 <Hb6kvXlGizYbogNWGJcvhY3LsKeRwROtpRluHKsGqRcmZl68J35nP60YdzW1KSoPl5RO_dCxuL5x9mM13jPBbU414DEZE_0rUwDNvzuzyb8=@protonmail.com>
 <Z2mW2k8GfP7S0c5M@x1n>
 <16ea1922-c9ce-4d73-b9b6-8365ca3fcf32@posteo.de>
 <20241230182737.154cd33a.alex.williamson@redhat.com>
 <bba03a61-9504-40d0-9b2c-115b4f70e8ca@posteo.de>
 <20241231090733.5cc5504a.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241231090733.5cc5504a.alex.williamson@redhat.com>

On Tue, Dec 31, 2024 at 09:07:33AM -0700, Alex Williamson wrote:
> On Tue, 31 Dec 2024 15:44:13 +0000
> Precific <precification@posteo.de> wrote:
> 
> > On 31.12.24 02:27, Alex Williamson wrote:
> > > On Mon, 30 Dec 2024 21:03:30 +0000
> > > Precific <precification@posteo.de> wrote:
> > >   
> > >> In my case, commenting out (1) the huge_fault callback assignment from
> > >> f9e54c3a2f5b suffices for GPU initialization in the guest, even if (2)
> > >> the 'install everything' loop is still removed.
> > >>
> > >> I have uploaded host kernel logs with vfio-pci-core debugging enabled
> > >> (one log with stock sources, one large log with vfio-pci-core's
> > >> huge_fault handler patched out):
> > >> https://bugzilla.kernel.org/show_bug.cgi?id=219619#c1
> > >> I'm not sure if the logs of handled faults say much about what
> > >> specifically goes wrong here, though.
> > >>
> > >> The dmesg portion attached to my mail is of a Linux guest failing to
> > >> initialize the GPU (BAR 0 size 16GB with 12GB of VRAM).  
> > > 
> > > Thanks for the logs with debugging enabled.  Would you be able to
> > > repeat the test with QEMU 9.2?  There's a patch in there that aligns
> > > the mmaps, which should avoid mixing 1G and 2MB pages for huge faults.
> > > With this you should only see order 18 mappings for BAR0.
> > > 
> > > Also, in a different direction, it would be interesting to run tests
> > > disabling 1G huge pages and 2MB huge pages independently.  The
> > > following would disable 1G pages:
> > > 
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > > index 1ab58da9f38a..dd3b748f9d33 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1684,7 +1684,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
> > >   							     PFN_DEV), false);
> > >   		break;
> > >   #endif
> > > -#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
> > > +#if 0
> > >   	case PUD_ORDER:
> > >   		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn + pgoff,
> > >   							     PFN_DEV), false);
> > > 
> > > This should disable 2M pages:
> > > 
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > > index 1ab58da9f38a..d7dd359e19bb 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1678,7 +1678,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
> > >   	case 0:
> > >   		ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
> > >   		break;
> > > -#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> > > +#if 0
> > >   	case PMD_ORDER:
> > >   		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn + pgoff,
> > >   							     PFN_DEV), false);
> > > 
> > > And applying both together should be functionally equivalent to
> > > pre-v6.12.  Thanks,
> > > 
> > > Alex
> > >   
> > 
> > Logs with QEMU 9.1.2 vs. 9.2.0, all huge_page sizes/1G only/2M only: 
> > https://bugzilla.kernel.org/show_bug.cgi?id=219619#c3
> > 
> > You're right, I was still using QEMU 9.1.2. With 9.2.0, the 
> > passed-through GPU works fine indeed with both Linux and Windows guests.
> > 
> > The huge_fault calls are aligned nicely with QEMU 9.2.0. Only the lower 
> > 16MB of BAR 0 see repeated calls at 2M/4K page sizes but no misalignment.
> > The QEMU 9.1.2 'stock' log shows a misalignment with 1G faults (order 
> > 18), e.g., huge_faulting 0x40000 pages at page offset 0 and later 
> > 0x4000. I'm not sure if that is a problem, or if the offsets are simply 
> > masked off to the correct alignment.
> > QEMU 9.1.2 also works with 1G pages disabled. Perhaps coincidentally, 
> > the offsets are aligned properly for order 9 (0x200 'page offset' 
> > increments) from what I've seen.
> 
> Thank you so much for your testing, this is immensely helpful!  This
> all suggests to me we're dealing with an alignment issue for 1GB pages.
> We're getting 2MB alignment on the mmap by default, so that's working
> everywhere.  QEMU 9.2 provides us with proper 1GB alignment, but it
> seems we need to filter alignment more strictly when that's not present.
> Please give this a try with QEMU 9.1.x and an otherwise stock v6.12.x:
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1ab58da9f38a..bdfdc8ee4c2b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1661,7 +1661,8 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>  	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
>  	vm_fault_t ret = VM_FAULT_SIGBUS;
>  
> -	if (order && (vmf->address & ((PAGE_SIZE << order) - 1) ||
> +	if (order && (pgoff & ((1 << order) - 1) ||
> +		      vmf->address & ((PAGE_SIZE << order) - 1) ||
>  		      vmf->address + (PAGE_SIZE << order) > vma->vm_end)) {
>  		ret = VM_FAULT_FALLBACK;
>  		goto out;

That's a great finding..  I wish we could have some sanity check in things
like pud_mkhuge() on the pfns at least for x86: SDM says the rest bits for
a huge pfn must be zero (for example, bit 29-13 for 1G), but didn't say
what if not. I assume that could panic at the right place if such check
ever existed.

OTOH, a pure question here is whether we should check pfn+pgoff instead of
pgoff alone.  I have no idea how firmware would allocate BAR resources,
especially on start address alignments.  I assume that needs to be somehow
relevant to the max size of the bar, probably the start address should
always be aligned to that max bar size?  If so, there should have no
functional difference checking either pfn+pgoff or pgoff.  It could be a
matter of readability in that case, saying that the limitation is about pfn
(of pgtable) rather than directly relevant to the offset of the bar.

Thanks,

-- 
Peter Xu


