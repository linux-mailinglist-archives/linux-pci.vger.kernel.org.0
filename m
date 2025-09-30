Return-Path: <linux-pci+bounces-37287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20511BAE188
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7664C0F97
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45F2512D7;
	Tue, 30 Sep 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G02T/CxW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45E246795
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251176; cv=none; b=jUTohQj//bYd3g+5vX9VXGhXT8YJ/DfQZYt7oS7btHYpsFMxcuQPEInyLjzZOjhd+Eu3yS9UkxK3h2rFWi8zTvqzsHsiyOHUyTJ/2thcq/ihPTx7LaqgpUFBBF7yFK913Bhvj+GoFQXZYd762W1KbVlC+5raSEs8O+6fcxtgjWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251176; c=relaxed/simple;
	bh=XRHExvG/tHB5daSSKAmQDIMiwtytKVKqlEgrmiHYtGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNhhTPuDYQKNFm6GIUkbTyBZYLjBxgbIzpUXX6KGVkPPBQcU08tY7n4keT20qpPoff40FiXg7TQ2TLdhwrthsUBjGYimi4EDI5rSNz3SMEXVPZ3v8J2swgdtUV7HjisNJ7fj31YbmKY/FODnni7AsJGmp+JoslzED/QVrGGLBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G02T/CxW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759251173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JryoONnZtvrch8iWe5kQa/bp3US7CnLH1VFoC2oPQRw=;
	b=G02T/CxWdFzdWNfhlIFwdrUzUnNBxZAHRXbim9H6o7KQF5KMS4DNUuK0/q0tS1t4VDHqf1
	GOfXb5jTCrqx4i4h3f5VwHtoD6hlai8QA77ya8Sck7zGbs4bYIpeUgCs+aMFoPl2guGAKD
	IxWFGeHTQKPEyMC6jJaM17C6FhYIod4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-lLMLX9glOsCctR5sO7VAmw-1; Tue, 30 Sep 2025 12:52:51 -0400
X-MC-Unique: lLMLX9glOsCctR5sO7VAmw-1
X-Mimecast-MFC-AGG-ID: lLMLX9glOsCctR5sO7VAmw_1759251171
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7a6cda1b2a9so1823181a34.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 09:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251171; x=1759855971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JryoONnZtvrch8iWe5kQa/bp3US7CnLH1VFoC2oPQRw=;
        b=Tu88A2O/n15sUdifZMzRklxF983iYY5PR1E/edScaTS2Tf/6651i0B7U+lyUVP00eN
         KVK5wHaYnhqi2wun+VvTLh02oHXGeom3VNMMxgsvUDYU0KxTjhS/pWJVjTzTgWqMROju
         BceyanGoCORpgtzdZzDEYw+e/2zXvTooqE+fody7Dhu0QoR9/YSLRzIdJeM9tNzF6qrh
         SKywyDIdDIhhHOfdzstncL924QzAWZQhDUSDOIOcYGP4KT4ujmKFGP9WeFjOIzCgEbwG
         Yla6jyT58OXvaNRwb2nYXS0nOccmUORYKkX8J/b8GounC8SrWFxxXGYjo40TJoP8SgPc
         V5RA==
X-Forwarded-Encrypted: i=1; AJvYcCV/N4TIYYoXVGSxhIsH70NI7z/NeANkS+u2Yj5h85Kb4UV3hJeLzLZ9kOLmqsfd7ameiNR2rY/CEV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziicuDTUt4dqzSc1S/cQNqIIhS3Hphy3BzxG6NFdyJpusvskmg
	1UOT5QRRTkNi2CHzWVnvKx0/FGPQtfjY5kevQzFfy63dvwG6jhSuGovvsps/Rn9n4Dadl0tR/Ul
	L25f2d6orPPaR7P5gurpAkNj8ySP+muux4ugl4awKVghuVnxbvzzMcy5Zdp0ehQ==
X-Gm-Gg: ASbGncvFH9Ss9tvGEpiLU19OGxB7T4vVHiUVKY8jrzjEJ8d/yCv0+VcJd4kxqGg79NW
	i9wYeN+mIioYyTAETeQVNUgtw0wdlNr+Jt+plDDwtD9NPwlrRWNZtx65IbgWxy6k0CjR3z2AQbM
	05yoMAyFh8VZxy0mxXF1OywjPT0vy8U3LgaVC12NpWefDHs5FbmlG8U6MUCPxPyWGjHGP9gR+g8
	w8mh2Yo2kxdnoxzcGnqoWt3SajSevDSqV31xYtFjjN8a+cCKY/O87XK0lIK1B8rnhy/m452nNj2
	7Chtl+svCF1Fb4u4L6BCpMLLFuhJGOA1ifrs+ob5WRNCFtkv
X-Received: by 2002:a05:6808:f86:b0:438:33fd:317c with SMTP id 5614622812f47-43fa41bd61fmr82475b6e.3.1759251171054;
        Tue, 30 Sep 2025 09:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwZ3/lKZz7Fdu2TvHNlTbKRk5qveSl6rvSejYaxAMAP02EZ6HQb/uugFp+9XcOcN4obhcZxg==
X-Received: by 2002:a05:6808:f86:b0:438:33fd:317c with SMTP id 5614622812f47-43fa41bd61fmr82463b6e.3.1759251170626;
        Tue, 30 Sep 2025 09:52:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51238c63sm2746753b6e.22.2025.09.30.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:52:49 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:52:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 10/10] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20250930105247.1935b553.alex.williamson@redhat.com>
In-Reply-To: <20250930143408.GI2942991@nvidia.com>
References: <cover.1759070796.git.leon@kernel.org>
	<53f3ea1947919a5e657b4f83e74ca53aa45814d4.1759070796.git.leon@kernel.org>
	<20250929151749.2007b192.alex.williamson@redhat.com>
	<20250930090048.GG324804@unreal>
	<CH3PR12MB754801DC65227CC39A3CB1F3AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
	<20250930143408.GI2942991@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 11:34:08 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 30, 2025 at 12:50:47PM +0000, Shameer Kolothum wrote:
> 
> > This is where hisi_acc reports a different BAR size as it tries to hide
> > the migration control region from Guest access.  
> 
> I think for now we should disable DMABUF for any PCI driver that
> implements a VFIO_DEVICE_GET_REGION_INFO
> 
> For a while I've wanted to further reduce the use of the ioctl
> multiplexer, so maybe this series:
> 
> https://github.com/jgunthorpe/linux/commits/vfio_get_region_info_op/
> 
> And then the dmabuf code can check if the ops are set to the generic
> or not and disable itself automatically.
> 
> Otherwise perhaps route the dmabuf through an op and deliberately omit
> it (with a comment!) from hisi, virtio, nvgrace.
> 
> We need to route it through an op anyhow as those three drivers will
> probably eventually want to implement their own version.

Can't we basically achieve the same by testing the ioctl is
vfio_pci_core_ioctl?  Your proposal would have better granularity, but
we'd probably want an ops callback that we can use without a userspace
buffer to get the advertised region size if we ever want to support a
device that both modifies the size of the region relative to the BAR
and supports p2p.  Thanks,

Alex


