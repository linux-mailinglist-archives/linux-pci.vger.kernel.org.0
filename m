Return-Path: <linux-pci+bounces-36798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03289B972B1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 20:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA003209E1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182292F90E6;
	Tue, 23 Sep 2025 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgwCqdwX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626952E040A
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650980; cv=none; b=pHOtCJDkm0YnbiVExHv72tq4iX2cRX6iCZtQLMYctyFDarb+4weoDLZ97O80wgzoZ2n09+R0YEXqY5tOgV1XJUlMULmMm+N8g5EdoJePn0eEnSgaM+xoZ84dyjrrdxxLaGmHoPxubB5wcbjra2kvlBp3ZHjdsVLdoWmLn4gCLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650980; c=relaxed/simple;
	bh=heNGPwMdoK/TojT+3JCMQol9WuwGJyrL7m6JFryZsqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNdkzczb5zPjoYwGYsb/WP7r+TE98wdW9rA7O9GD3en33+k8jr4vN32FA+/eFich2y1k/7HunvTQCP4eaR/2YhVLwCbkh1wdQfSQXSDB1nWQVb9AQfXNx4rECemJaw0NGNp4kXXTEBjZ/auEVmKnrNGDm7BKTLwwXMigNLXliU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgwCqdwX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758650977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQIcre9d/GLURHCzSftYDLgKY/Tx/WICcqQ2djA+XCg=;
	b=WgwCqdwXaYN3Trerny7CPtN4SBPyc/HSKDsoex+YwLeP0gtV+SgGmQ/UMR1Tnh+RpS1iuO
	dKdFLD77MyzuEVG8CFDFv4XOzWcgUlIqjirngbu1iFBv2/dvCPe/VCFzCfuVa2FsZewXG7
	8xEDTJQxTKTkD4GB86sD0clhH88n8/Y=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-Cr4ZD2FmOFCf1ylG84QSZw-1; Tue, 23 Sep 2025 14:09:36 -0400
X-MC-Unique: Cr4ZD2FmOFCf1ylG84QSZw-1
X-Mimecast-MFC-AGG-ID: Cr4ZD2FmOFCf1ylG84QSZw_1758650975
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-889252db9feso108046739f.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 11:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650975; x=1759255775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQIcre9d/GLURHCzSftYDLgKY/Tx/WICcqQ2djA+XCg=;
        b=hgTbX4ICa01zFbUDqSGeFRuSyKq7Kxr3Z1rWDrkQ+NakwpedKckS0j5aDdZOHbWonA
         1acbjKhsM3JbAR/48uGlqtf5tEr2DqHWzomTVfBHkYdvq+rUge2sBa6X1/7VAqYKvgyx
         YUvWQ/j5oNK48Vox59qN9PzD7uevlBxGCyQJm45uQ/Wh7dY7CXAUT7fHzuG1rQRGGRBi
         YGZsyqK73K5f1mowlVWg8trhXvsiWLMbCBekFslVcKGER3NEXavd49alpSuLSZTOUMXq
         w4L94rNhQrJpEJZDLIbUPLP5vPfmytgdk4b9IvdBUiN4s2WwjwXleEXyA87NGRjX16is
         jyRA==
X-Forwarded-Encrypted: i=1; AJvYcCUls63mgEL87JcEHg1I9JNPWgUDS/91jnOleD04+fXFayGicos3C/921bVGa2nD+GLVqVrdAPoMvAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDDpg1NXCnIpAD2J98MeyPgxKvN4zfGDflZSvpjjCaj8hK5Rz
	0HUpMhUZ5f4WC+blEjU23hnk4LlE/00XE0kfRqC9iaSqVBbOwoWtPum/2vIg3dJPcj4y3g0dKKQ
	jj8H3iKTbNXvwG1d7SeIP/gW2VSOjDGLNHosjRw310r8qV/pxJWh8KfomEuUFVQ==
X-Gm-Gg: ASbGnctlc/FqR0GrHoMbb2DKNPKxXLxNPh54z6yh0JnaRhQBOXBqc+kM6yljqQJhXgH
	XQif/hs6cI0BY2xIysmncS1RShu02aYZVMNPrajNu/6kfRW3IsFnqwIrGH5boU7mLMYCCXYHOok
	X5VJv4X6h7f+xxYtrxpizsYFOGs3P/BQ1y+NFzzHhdCxCVCj++fF7qiM/zYUZ9JbsBU7M1/YELk
	2bNWYVvJrIztN5T2kVmKzHxEQZqxeGEXCo9i0lw9PKJg/F4lk52B2tNWc8A76rqT7WOWEDU9/WC
	tGaoDcX4+ktvXVBNBjF3RlCL37sxaC2MEyLJKy7UJf4=
X-Received: by 2002:a05:6e02:1528:b0:412:5782:c7c1 with SMTP id e9e14a558f8ab-42581ea129fmr20080725ab.5.1758650975138;
        Tue, 23 Sep 2025 11:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq8NLMhZ8QXjx/u5jq96UNETG/D0tlVJnMFlvqXnog3t1PaipQH1rILjZIuw/YRGMbPtKiFQ==
X-Received: by 2002:a05:6e02:1528:b0:412:5782:c7c1 with SMTP id e9e14a558f8ab-42581ea129fmr20080265ab.5.1758650974546;
        Tue, 23 Sep 2025 11:09:34 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-54f69c6262esm5209728173.79.2025.09.23.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:09:33 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:09:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250923120932.47df57b2.alex.williamson@redhat.com>
In-Reply-To: <20250923174333.GE2608121@nvidia.com>
References: <cover.1757589589.git.leon@kernel.org>
	<1e2cb89ea76a92949d06a804e3ab97478e7cacbb.1757589589.git.leon@kernel.org>
	<20250922150032.3e3da410.alex.williamson@redhat.com>
	<20250923150414.GA2608121@nvidia.com>
	<20250923113041.38bee711.alex.williamson@redhat.com>
	<20250923174333.GE2608121@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 14:43:33 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 23, 2025 at 11:30:41AM -0600, Alex Williamson wrote:
> > On Tue, 23 Sep 2025 12:04:14 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Mon, Sep 22, 2025 at 03:00:32PM -0600, Alex Williamson wrote:  
> > > > But then later in patch 8/ and again in 10/ why exactly do we cache
> > > > the provider on the vfio_pci_core_device rather than ask for it on
> > > > demand from the p2pdma?    
> > > 
> > > It makes the most sense if the P2P is activated once during probe(),
> > > it is just a cheap memory allocation, so no reason not to.
> > > 
> > > If you try to do it on-demand then it will require more locking.  
> > 
> > I'm only wondering about splitting to an "initialize/setup" function
> > where providers for each BAR are setup, and a "get provider" interface,
> > which doesn't really seem to be a hot path anyway.  Batching could
> > still be done to setup all BAR providers at once.  
> 
> I agree it is a weird interface, but it is close to the existing weird
> interface :\

Seems like it would help if we just positioned it as a "get provider
for BAR" function that happens to initialize all the providers on the
first call, rather than an "enable" function with some strange BAR
argument and provider return.  pcim_p2pdma_provider(pdev, bar)?

It would at least make sense to me then to store the provider on the
vfio_pci_dma_buf object at the time of the get feature call rather than
vfio_pci_core_init_dev() though.  That would eliminate patch 08/ and
the inline #ifdefs.

> > However, the setup isn't really once per probe(), even in the case of a
> > new driver probing we re-use the previously setup providers.    
> 
> It uses devm to call pci_p2pdma_release() which NULL's pdev->p2pdma.

Ah, right.  So the /* PCI device was "rebound" to the driver */ comment
is further misleading, a new probe would do a new setup.  Thanks,

Alex


