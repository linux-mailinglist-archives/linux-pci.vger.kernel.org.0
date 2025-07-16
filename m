Return-Path: <linux-pci+bounces-32328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1DFB07ED4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD5018840D1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 20:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951329CB49;
	Wed, 16 Jul 2025 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHMjHxgX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFDA262815
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697449; cv=none; b=dBx6aQn4luSDsrXJG62EqQMBbq+p0D0NoRwXg6kPOCs5qoqor7+1q/24e3jCwgVFLir9i5avB1JWr/DVY00cicr8ir03ak9bxHKDI6O/Er6ULrRIV6Pt/mPvGAOSTWX07yavQqg/ZTqYMgvWQLcueLZ7qsyRkHMQ3JiSYXfLZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697449; c=relaxed/simple;
	bh=OWwOEwoL4c/cHl9tlOPdM7T7kTDMxYThoiSS5XwyRkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgDL4WifwMI1O0FYazBQreL9pDKYGtXNmzSNnEjc1OA5iy5XxoZBn6W4i7kNrx1it0yRzDLFUVBceBUB1e90Lq0gOdxkVQJ59aUBdJrLX2uGsOoz8bTMgvEiQ8/Sd5L8bIpj9xpGglNj5OVr2+Sh15VJcytZWgCL9ta1LAtahb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHMjHxgX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752697447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPvdI3YhlO9GI6rBP8ySVGpgSYgi0LJtZ9QTwrrpP/g=;
	b=JHMjHxgXko4K7r4B2eMfwBAx2XbU7kRJ58rf1rBow1MUZ2rpwWIpjcBXLe4nM885zL2IxL
	3KFgaypKXyYYDMsBixBWZOhD7naznmqSbsCEqDeaShF+zF7MUNJP7p1mXSkdbsb/euKUog
	xx2gbSQ9V2l1QCcZvSRbhbTjeki0vm4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-ap8WehmzMvmZs74Hlw0Jmg-1; Wed, 16 Jul 2025 16:24:04 -0400
X-MC-Unique: ap8WehmzMvmZs74Hlw0Jmg-1
X-Mimecast-MFC-AGG-ID: ap8WehmzMvmZs74Hlw0Jmg_1752697444
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8769aa1f0c7so3351839f.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 13:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752697444; x=1753302244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPvdI3YhlO9GI6rBP8ySVGpgSYgi0LJtZ9QTwrrpP/g=;
        b=wr89kqETFJrpShHb37Vq+YPX//o6Nto2AVBp+fgCZjlDqHPYuusmBX1UKwDhUGc/44
         vO5LUF8Fyk4HYfNNQEX77r4f7rEKYLH821ZocIIqENHPr2k9nLWCQRgqXQFXJstvm5If
         Y03FnrXSdbmcH9KN3auIZB2fShjACWjfwzaS2LYb8yRHf8P1ydweCqY1AQe9pSdozrlS
         BzvDQz5KEM3kAaAgRxdsZpq3eNx5BqoVBW18plVn7kPecgcGS3sveUQvdslIJa4lHsy8
         eR6/BsgrLFbqDAikQZDgeeDpytBHZ22Xft5aSsU0FtX2WUZe3b/q+FLUTV7jD1QgHHtX
         IP1g==
X-Forwarded-Encrypted: i=1; AJvYcCWahs9/MMshS9pT9Gtfc2skKZxRiHu/H5s5a3kiHWVftIv6Y2o84BK14c7FLOj1i52nmhmYwU454P0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza5R2kqWfo62C7mnBzqr66C/rPHC68CrqlAxUQP9hJ/q4kDpmw
	SjcvIFgu8UTPGBzL2U83MLL69RrqJbQGd2jlsr4yjDLadU/Jig10pbJNtD5cy0/Mp54WPuCYrj8
	gHLQrgfJybPVsRQhozf3J8op8PwE75uKhP+KjXs/h5t56DyYnC9DmoXkmX1j5+Q==
X-Gm-Gg: ASbGncutwKd5hVlyzC8W1wqPVerfH6R/V1sDdY3vjsKo4DHSitxSeE/OFVPy1jD4Y4Y
	AfSTlo9eyE5l/sfuw7act9/EM1LZFWWzx1Cu8nUx2NT9LYf9f/nYako6uSXNptDnln+X60gvChg
	wtrairfKf3wYpDPM8agxK2Wq+rDUbLAjSsZLgYepT8n1c2IEHnr7YEL3OdpIX1B52hrf2oHkbL/
	9Sdb2a84CtP/n1NCKp4VC8pP6oIFCPGRYir53ovm6PiwCNuLhgeRlgxT2dHmyBzdc1H87Ud2Jok
	1u2kGQSRxopyubHYQDrIh6pNtCqRGIFet3/BWt1rx+I=
X-Received: by 2002:a05:6602:2c93:b0:876:6fc6:1358 with SMTP id ca18e2360f4ac-879c090005fmr159784639f.4.1752697443993;
        Wed, 16 Jul 2025 13:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQM57KH4/hrYzJ2qXCdt8qoMrmX+6pQyjYsFU6u0/Mwn4A6JffpiIcPzJ2oqyc3L8xzdEkFQ==
X-Received: by 2002:a05:6602:2c93:b0:876:6fc6:1358 with SMTP id ca18e2360f4ac-879c090005fmr159783739f.4.1752697443521;
        Wed, 16 Jul 2025 13:24:03 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-879c3419538sm52469639f.19.2025.07.16.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 13:24:02 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:24:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <paulmck@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] vfio/type1: conditional rescheduling while pinning
Message-ID: <20250716142401.3104ee01.alex.williamson@redhat.com>
In-Reply-To: <20250715184622.3561598-1-kbusch@meta.com>
References: <20250715184622.3561598-1-kbusch@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 11:46:22 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> A large DMA mapping request can loop through dma address pinning for
> many pages. In cases where THP can not be used, the repeated vmf_insert_pfn can
> be costly, so let the task reschedule as need to prevent CPU stalls. Failure to
> do so has potential harmful side effects, like increased memory pressure
> as unrelated rcu tasks are unable to make their reclaim callbacks and
> result in OOM conditions.
> 
>  rcu: INFO: rcu_sched self-detected stall on CPU
>  rcu:   36-....: (20999 ticks this GP) idle=b01c/1/0x4000000000000000 softirq=35839/35839 fqs=3538
>  rcu:            hardirqs   softirqs   csw/system
>  rcu:    number:        0        107            0
>  rcu:   cputime:       50          0        10446   ==> 10556(ms)
>  rcu:   (t=21075 jiffies g=377761 q=204059 ncpus=384)
> ...
>   <TASK>
>   ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>   ? walk_system_ram_range+0x63/0x120
>   ? walk_system_ram_range+0x46/0x120
>   ? pgprot_writethrough+0x20/0x20
>   lookup_memtype+0x67/0xf0
>   track_pfn_insert+0x20/0x40
>   vmf_insert_pfn_prot+0x88/0x140
>   vfio_pci_mmap_huge_fault+0xf9/0x1b0 [vfio_pci_core]
>   __do_fault+0x28/0x1b0
>   handle_mm_fault+0xef1/0x2560
>   fixup_user_fault+0xf5/0x270
>   vaddr_get_pfns+0x169/0x2f0 [vfio_iommu_type1]
>   vfio_pin_pages_remote+0x162/0x8e0 [vfio_iommu_type1]
>   vfio_iommu_type1_ioctl+0x1121/0x1810 [vfio_iommu_type1]
>   ? futex_wake+0x1c1/0x260
>   x64_sys_call+0x234/0x17a0
>   do_syscall_64+0x63/0x130
>   ? exc_page_fault+0x63/0x130
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   Merged up to vfio/next
> 
>   Moved the cond_resched() to a more appropriate place within the
>   loop, and added a comment about why it's there.
> 
>   Update to change log describing one of the consequences of not doing
>   this.
> 
>  drivers/vfio/vfio_iommu_type1.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 1136d7ac6b597..ad599b1601711 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -647,6 +647,13 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
>  
>  	while (npage) {
>  		if (!batch->size) {
> +			/*
> +			 * Large mappings may take a while to repeatedly refill
> +			 * the batch, so conditionally relinquish the CPU when
> +			 * needed to avoid stalls.
> +			 */
> +			cond_resched();
> +
>  			/* Empty batch, so refill it. */
>  			ret = vaddr_get_pfns(mm, vaddr, npage, dma->prot,
>  					     &pfn, batch);

Applied to vfio next branch for v6.17.  Thanks,

Alex


