Return-Path: <linux-pci+bounces-39479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E863C11F1C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 00:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828C05674F0
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3F32C938;
	Mon, 27 Oct 2025 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4thHGD1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7542E8E10
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606818; cv=none; b=SCkCViGWRvOniWrvE2wZFvM6AURRw6RalhsKT0+mEMfcz4vYjl2ekpFX8l6HBb3z31D9L6O9LqtaqsgsghAS2Djr2VW2X8V9SnBHZqT2JUhVkP5Vk8eLTlhsBYtrAVXtetWXEAUyqwo0gmgyRvq6XpjQYvSfJ7yJORYeDOvYBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606818; c=relaxed/simple;
	bh=Mox7WVrx2nsqFbNnAMpCHXjsIB1mhexPun4YkmTSVd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmX0pXrtUa2+LrfALz/PkZHTXYKsTR7MBmJBJ93Z10NkTht2/tLe/fVXftOA/3ZdEtU8F9kV85kCPojzGFtaq9Afs3G2LwRZEs76CYzgt6cn/2BWpCDSssBLY3GwoECOxn6JctDE6uVPdgQJnwtfzdqfGGrPCl3ujq17HwR0WrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4thHGD1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-592ee9a16adso8968262e87.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761606814; x=1762211614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVb3sBQg3S7kfhJuRLHfxPiQ08+Bc1FaH34bvysQgyo=;
        b=o4thHGD1/OUIjggnndqTnwnlW10eAEpX/HB4h+bHLKvOx8B1TxlHznc4je/pXuHVJb
         KUWtUQR1veipMr2Rmi2ifY0nHaQJE4SOZsgGUYvgroxjQaBNPA4fc8tIJjVWU+P5ydbN
         NMUJ0wQsP36BKbBPsDSPRE7pBO2mpYQgI0W6TZleqsHMtObXMIq70gyxPDxYUJwNLxh8
         XlEkLw2+Qf2apLB06O5B0unQU9dZVLF2iZhswvxbkKJ9L9OijIDYQO/dP7G6zUwDGVKX
         XkCJBuLbYSDWcFoYhBoM28SI/CUXMs1s/NHilUSaIj2p9npeD+I+8mm5i9UUiERiMfDH
         VQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761606814; x=1762211614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVb3sBQg3S7kfhJuRLHfxPiQ08+Bc1FaH34bvysQgyo=;
        b=Bv8ExKXDMBiKT2k2D9lk8PLSQ1jX+SwP1xB5wN3Ug+CaQrysZXYhUX/xTx5A9SrtZA
         cYC8vD78t4ncPQR4UMwuqwTIy90GnNPh/OvBgXJ6ySfGCL/qjvKat4zYhniXqIyUQyfP
         8VDhwhbOIqGJccDxg+xYax8sffD1zbOMPLDW3b4bIU7+BasfpK3II9WtvAEvFKSJZRpk
         1yqOx/gy8pRhp9SKqDEUrRcN92GTFDGSECtLZYHP7vgz56rotZtVMMOBk27Vcq2x/u4l
         jxWzFCyjc8StqH7tlNO4I10deZ67Sqa12LyChyNw3XqPEZ0KYv+EprSqEsc+uV+Mfl2t
         ZRcg==
X-Forwarded-Encrypted: i=1; AJvYcCXiy38csuBuZEwLUImSyQUfImA8H9ZbaJVTwCfOE4GPcmno48sfj5YGus7kNe0aGtXHh8caoJwrONE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuoiYWNQxCoLPqCumRJRQuCgNC180dSzMuwrktK2kbhjs7y/+m
	mTFCIhaFztP/avP/Au9x6t6ZALuD/9TJMG7OCjlci5KV+ivccY72dfsu27NkmbpaJDrPs2hV795
	Tmgs+nZ0dp0Er8VbCY+lit73LQ05qOMJcY19lb2Xg
X-Gm-Gg: ASbGncsh7Tx4B0M0vZ8fnTLjPP5O+F0nrhNYMQt9S55JnbcQjH1WlYpdV3dKY9CUtx6
	MoqGklnrVOyUu1KqYRh0SEYeHppcvWC0Ec83eK2tIlmm12p92HnJe3VzgASXzG2hPktcd0WGtct
	CUTrWRGmBZO3stpxlX4dfim7Z7lVZRaj3jhUfxtRRfk1HeCaq8JrMWkaOLKAWbEPiKzbTuBgV+q
	LfXf0XuJKhKYGvKVvEl2qXhJTl2Qi8DgiT7109MV8/WG/3BTsdRcP50AVM0pEZcz89vxjE=
X-Google-Smtp-Source: AGHT+IGl3ca765JSYQeeeNWnOc4ez61Rh9cYHuTu2Z8wbfu4++aeMX3ejm6+mpCGbnxLweY96XJw4Qd/Jsw/gJioL2Q=
X-Received: by 2002:a05:6512:39ce:b0:585:c51e:e99d with SMTP id
 2adb3069b0e04-5930e98f2bbmr555951e87.3.1761606813913; Mon, 27 Oct 2025
 16:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760368250.git.leon@kernel.org> <72ecaa13864ca346797e342d23a7929562788148.1760368250.git.leon@kernel.org>
In-Reply-To: <72ecaa13864ca346797e342d23a7929562788148.1760368250.git.leon@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 16:13:05 -0700
X-Gm-Features: AWmQ_blG76O58dB2_ktM5H7ZDlww5WUOcPernLo2oZm94nuYAfy2S9NihsUA1rg
Message-ID: <CALzav=cj_g8ndvbWdm=dukW+37cDh04k1n7ssFrDG+dN3D+cbw@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] vfio/pci: Add dma-buf export support for MMIO regions
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:44=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Add support for exporting PCI device MMIO regions through dma-buf,
> enabling safe sharing of non-struct page memory with controlled
> lifetime management. This allows RDMA and other subsystems to import
> dma-buf FDs and build them into memory regions for PCI P2P operations.

> +/**
> + * Upon VFIO_DEVICE_FEATURE_GET create a dma_buf fd for the
> + * regions selected.
> + *
> + * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOE=
XEC,
> + * etc. offset/length specify a slice of the region to create the dmabuf=
 from.
> + * nr_ranges is the total number of (P2P DMA) ranges that comprise the d=
mabuf.
> + *
> + * Return: The fd number on success, -1 and errno is set on failure.
> + */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF 11
> +
> +struct vfio_region_dma_range {
> +       __u64 offset;
> +       __u64 length;
> +};
> +
> +struct vfio_device_feature_dma_buf {
> +       __u32   region_index;
> +       __u32   open_flags;
> +       __u32   flags;
> +       __u32   nr_ranges;
> +       struct vfio_region_dma_range dma_ranges[];
> +};

This uAPI would be a good candidate for a VFIO selftest. You can test
that it returns an error when it's supposed to, and a valid fd when
it's supposed to. And once the iommufd importer side is ready, we can
extend the test and verify that the fd can be mapped into iommufd.

It will probably be challenging to meaningfully exercise device P2P
through a selftest, I haven't thought about how to extend the driver
framework for that yet... But you can at least test that all the
ioctls behave like they should.

