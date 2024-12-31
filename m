Return-Path: <linux-pci+bounces-19104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BF39FEC21
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 02:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFCE3A2586
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 01:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D025A7FD;
	Tue, 31 Dec 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jad/fU/O"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A447524C
	for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 01:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735608465; cv=none; b=vGMiUvQgls5Ti9S8QIKN0tDEp9bjoH3vB+tBAYiSngDcyQsAbr9ivRsH1iHL+GfKV2n2T9DbhVcgTfojlllmTADR1mhDQYqmk6S7Ut0s8cTL76+73CDu4ppCERbNiSIC1Krm61kEwtywuQZhZ1t3WzGzjuLhU8aeHSX/6PaRVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735608465; c=relaxed/simple;
	bh=cYwx81FiscoKPuQUcoEjGxNvsT4PQHMGFwYOIJGDDdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrLA/Wyvgc0cbOEzEO+YDZLCIcq6c23yQFRWAqmMws9XFJwJAtpARpxeRS865IlskhUvTM5ZCS7CPvrkkyy12injp6iZ8SbGoyJ8gYT/WI+KwaCS4cRpu8cW9bV5UgMqif+mRAcxf0COGrwzN49G6U1Obb6dbo9K2b+tRia1ivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jad/fU/O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735608462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbSubt0jW6XprDSYA3GtrEByRivXdyFWNaGrTU8y1fc=;
	b=Jad/fU/OCM9L5VEhnJKUoIKvFmTknev/rXjkVT2cSen7WsLXQ781G3+TynKgr7Dv7g97wB
	zuKwaivCaLM+eMYv/4o1sAzsaZumSKMtwhx+SzYuT8oKMgJq4iVf9ZD8l55UWCYAiF6IQz
	lYNSVM+puEtEBkLNR12NrI8Y+ZLKVAA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-jG1q7z1FMXC1LB87BUafHg-1; Mon, 30 Dec 2024 20:27:41 -0500
X-MC-Unique: jG1q7z1FMXC1LB87BUafHg-1
X-Mimecast-MFC-AGG-ID: jG1q7z1FMXC1LB87BUafHg
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7ea122d0bso11718235ab.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 17:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735608460; x=1736213260;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbSubt0jW6XprDSYA3GtrEByRivXdyFWNaGrTU8y1fc=;
        b=V76tno2jNpP3p3OhBZJtJT/FIMx0gcgEVXG8/GrM5lAEIea2IFBhLdw22ZRl5e09Lr
         LH4RXqPYopu2LpyG/sjLbDrrIEvSkVAEa68GX21p4VDIsk2sRHWICq1Nlsfd5MiIX9Id
         DU6e84N74lGLYPMfuHaN0RbVszbHHwDgoOUft3VlYuQtEVzyr1NREoT+RvSfP6i5AWyI
         8BsNWyeHjm2tIsbRhsXS39z253BUokLfxxMHU6+K6+SsYZdDwaHX7c0SIt5NIJBSwuIB
         /tv6B8WwClU+WYWrUlvs1EDovsUzZpTdZPzQvVVLOhLj44UfsQjjvTvcs7NQ0Cjc0BER
         s6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUfZ3Ru7EWHxUpXdXDfa/7c+drshT1EPZbaCEB5lFvF9ofINrsE9dKzimLv0i5nK7cVbzrcjH+CgOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZJdz9NwBSziRouJbg5vkk9r40WGpe9CgwgX9kpjyHaeWwG6n
	Z0I4WML/NQRykCe/RlwFqwRNHzE48E6oMVvABkrFYY9YBOHc0WBvC/uDm+fCyhIqXaMGhDwRIRw
	NFXOY05v9B4j0yGJmarkfyK/JMcVgXmyKsuCDXyAqTpE7XncpItmlJVLfAZMhxykUXA==
X-Gm-Gg: ASbGncuMxT/45RAmB2Jo76wAJuUh6V6jxXhywmPf5ulRr3djs4HzYbh7f6HIwwFGZMA
	NykQ4QoIjvcr0+0NU6nU1bbAkihcbEiKGgNNBF8Q9t6zbMetk/v5YzOpNZcj/3e2Y70pJ/AYSd2
	q2w1Q/06+KZLp/KioFyq3qiYN7KkPhxsN3pMiQ/vFrVo2X70ULi24aK/QqlHkfSZMOt9VR82SZm
	3155kkeOGMaWQMFYPDw2zg23fqZqe2ed6J8hWf5To7GewCDSXQC9aCdMmBm
X-Received: by 2002:a05:6e02:1c81:b0:3a7:bd4c:b17e with SMTP id e9e14a558f8ab-3c2cbd89eedmr90279635ab.0.1735608459895;
        Mon, 30 Dec 2024 17:27:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7XZPI30EYeszFNZ0Jt4u4Phtf61lCBYw7J/duvSKrhB3IGnVslVa4n/XJNjdJsoxpLUzIVA==
X-Received: by 2002:a05:6e02:1c81:b0:3a7:bd4c:b17e with SMTP id e9e14a558f8ab-3c2cbd89eedmr90279545ab.0.1735608459520;
        Mon, 30 Dec 2024 17:27:39 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf67e8fsm5815988173.58.2024.12.30.17.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 17:27:38 -0800 (PST)
Date: Mon, 30 Dec 2024 18:27:37 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Precific <precification@posteo.de>
Cc: Peter Xu <peterx@redhat.com>, Athul Krishna
 <athul.krishna.kr@protonmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Linux PCI
 <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 219619] New: vfio-pci: screen
 graphics artifacts after 6.12 kernel upgrade]
Message-ID: <20241230182737.154cd33a.alex.williamson@redhat.com>
In-Reply-To: <16ea1922-c9ce-4d73-b9b6-8365ca3fcf32@posteo.de>
References: <20241222223604.GA3735586@bhelgaas>
	<Hb6kvXlGizYbogNWGJcvhY3LsKeRwROtpRluHKsGqRcmZl68J35nP60YdzW1KSoPl5RO_dCxuL5x9mM13jPBbU414DEZE_0rUwDNvzuzyb8=@protonmail.com>
	<Z2mW2k8GfP7S0c5M@x1n>
	<16ea1922-c9ce-4d73-b9b6-8365ca3fcf32@posteo.de>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 21:03:30 +0000
Precific <precification@posteo.de> wrote:

> On 23.12.24 17:59, Peter Xu wrote:
> > On Mon, Dec 23, 2024 at 07:37:46AM +0000, Athul Krishna wrote:  
> >> Can confirm. Reverting f9e54c3a2f5b from v6.13-rc1 fixed the problem.  
> >>>   
> >>>   Device: Asus Zephyrus GA402RJ
> >>>   CPU: Ryzen 7 6800HS
> >>>   GPU: RX 6700S
> >>>   Kernel: 6.13.0-rc3-g8faabc041a00
> >>>   
> >>>   Problem:
> >>>   Launching games or gpu bench-marking tools in qemu windows 11 vm will cause
> >>>   screen artifacts, ultimately qemu will pause with unrecoverable error.  
> > 
> > Is there more information on what setup can reproduce it?
> > 
> > For example, does it only happen with Windows guests?  Does the GPU
> > vendor/model matter?  
> 
> In my case, both Windows and Linux guests fail to initialize the GPU in 
> the first place since 6.12; QEMU does not crash. I also found commit 
> f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101 by bisection.
> 
> CPU: AMD 7950X3D
> GPU (guest): AMD RX 6700XT (12GB)
> Mainboard: ASRock X670E Steel Legend
> Kernel: 6.12.0-rc0 .. 6.13.0-rc2
> 
> Based on a handful of reports on the Arch forum and on r/vfio, my guess 
> is that affected users have Resizable BAR or similar settings enabled in 
> the firmware, which usually applies the maximum possible BAR size 
> advertised by the GPU on startup. Non-2^n-sized VRAM buffers may be 
> another commonality.
> 
> Some other reports I found that could fit to this regression:
> [1] https://bbs.archlinux.org/viewtopic.php?id=301352
>    - Several reports (besides mine), not clear which of those cases are 
> triggered by the vfio-pci commit. One case is clearly caused by a 
> different commit in KVM. Potential candidates for the vfio-pci commit 
> (speculation): (a) 6700XT GPU; (b) 5950X CPU, RTX 3090 GPU
> [2] https://old.reddit.com/r/VFIO/comments/1hkvedq/
>    - Two users, 7900XT and 7900XTX, reported that reverting 6.12 or 
> disabling ReBAR resolves Windows guest GPU initialization.
> 
> On my 6700XT (PCI address 03:00.0, 12GB of VRAM), I get the following 
> Resizable BAR default configuration with the host firmware/UEFI setting 
> enabled:
> 
> [root]# lspci -s 03:00.0 -vv
> ...
> Capabilities: [200 v1] Physical Resizable BAR
> 	BAR 0: current size: 16GB, supported: 256MB 512MB 1GB 2GB 4GB 8GB 16GB
> 	BAR 2: current size: 256MB, supported: 2MB 4MB 8MB 16MB 32MB 64MB 128MB 
> 256MB
> ...
> 
> The 16GB configuration above fails with 6.12 (unless I revert commit 
> f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101).
> Now, if I change BAR 0 to 8GB (as below), which is below the GPU's VRAM 
> size of 12GB, the Linux guest manages to initialize the GPU.

Interesting test.

> [root]# echo "0000:03:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
> [root]# #13: 8GB, 14: 16GB
> [root]# echo 13 > /sys/bus/pci/devices/0000:03:00.0/resource0_resize
> [root]# echo "0000:03:00.0" > /sys/bus/pci/drivers/vfio-pci/bind
> 
> On my mainboard, 'Resizable BAR off' sets BAR 0 to 256MB, which also 
> works with 6.12.
> 
> Only the size of BAR 0 (VRAM) appears to be relevant here. BAR 2 sizes 
> of 2MB vs. 256MB have no effect on the outcome.
> 
> >   
> >>>   
> >>>   Commit:
> >>>   f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101 is the first bad commit
> >>>   commit f9e54c3a2f5b79ecc57c7bc7d0d3521e461a2101
> >>>   Author: Alex Williamson <alex.williamson@redhat.com>
> >>>   Date:   Mon Aug 26 16:43:53 2024 -0400
> >>>   
> >>>       vfio/pci: implement huge_fault support  
> > 
> > Personally I have no clue yet on how this could affect it.  I was initially
> > worrying on any implicit cache mode changes on the mappings, but I don't
> > think any of such was involved in this specific change.
> > 
> > This commit majorly does two things: (1) allow 2M/1G mappings for BARs
> > instead of small 4Ks always, and (2) always lazy faults rather than
> > "install everything in the 1st fault".  Maybe one of the two could have
> > some impact in some way.  
> 
> In my case, commenting out (1) the huge_fault callback assignment from 
> f9e54c3a2f5b suffices for GPU initialization in the guest, even if (2) 
> the 'install everything' loop is still removed.
> 
> I have uploaded host kernel logs with vfio-pci-core debugging enabled 
> (one log with stock sources, one large log with vfio-pci-core's 
> huge_fault handler patched out):
> https://bugzilla.kernel.org/show_bug.cgi?id=219619#c1
> I'm not sure if the logs of handled faults say much about what 
> specifically goes wrong here, though.
> 
> The dmesg portion attached to my mail is of a Linux guest failing to 
> initialize the GPU (BAR 0 size 16GB with 12GB of VRAM).

Thanks for the logs with debugging enabled.  Would you be able to
repeat the test with QEMU 9.2?  There's a patch in there that aligns
the mmaps, which should avoid mixing 1G and 2MB pages for huge faults.
With this you should only see order 18 mappings for BAR0.

Also, in a different direction, it would be interesting to run tests
disabling 1G huge pages and 2MB huge pages independently.  The
following would disable 1G pages:

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1ab58da9f38a..dd3b748f9d33 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1684,7 +1684,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 							     PFN_DEV), false);
 		break;
 #endif
-#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
+#if 0
 	case PUD_ORDER:
 		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn + pgoff,
 							     PFN_DEV), false);

This should disable 2M pages:

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1ab58da9f38a..d7dd359e19bb 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1678,7 +1678,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 	case 0:
 		ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
 		break;
-#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+#if 0
 	case PMD_ORDER:
 		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn + pgoff,
 							     PFN_DEV), false);

And applying both together should be functionally equivalent to
pre-v6.12.  Thanks,

Alex


