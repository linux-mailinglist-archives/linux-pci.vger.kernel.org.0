Return-Path: <linux-pci+bounces-33492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4FCB1CEEA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 00:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA7B18C69A9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA2237165;
	Wed,  6 Aug 2025 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFdqmzkX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312221CA03
	for <linux-pci@vger.kernel.org>; Wed,  6 Aug 2025 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517733; cv=none; b=j80k1F34XND7daS79q1tJ7bZ/53dzBA3Yabjqj4KJb9s3VbB4Zn4TvZzwJgrLL1EkKnPdRfE7Q7qI59aYQtX8YcJ1mxKF4Rzb1kHIDlKa4uaqvE5BCwTxZPtgPr2PDMqs7US5hlxiRO7Tnl8l5XcRc1CNXma5RBC/s9AzkcR8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517733; c=relaxed/simple;
	bh=sBGR4NtuEpYLnU8xLpZkN2kUNrTNO6/D2QzCl2EwKDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5iGv3vG1WJFzHKKbXmO4+QJw84ZTJdPSt9jY8B27RA6nCmti28hU61vpM/+xLUVx9eTGZRIUWUoBwkJJTYOo5/6TcwtT4552I7wfbmjKIMXrPeX3IKEmTgK/MwfNfT8os7k8aHi3ZBFcgUnEYg7DPJxuHkfF/T8R5dOjy0wdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFdqmzkX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754517730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPKtzeEHbCO/oC/mPOhJydcV6bGZHZZqGISB9ILuO/c=;
	b=CFdqmzkXwjG7/90VFtMUN12j30HgBWafM3zN1/K36BMDJmGJqaoAWh11AXsNwIt3vtZhgy
	eCkNPcT7BppW6x84/Vn8r6n4zLedL2r4suT8IWJ0GaOlzgVzWbHJtPTqhu1V7s+CeCLE9J
	48+RGb7UcKsexp4IfnPS6250Gte8pxs=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-89rO5VGaM4qf1r3NUim5fw-1; Wed, 06 Aug 2025 18:02:08 -0400
X-MC-Unique: 89rO5VGaM4qf1r3NUim5fw-1
X-Mimecast-MFC-AGG-ID: 89rO5VGaM4qf1r3NUim5fw_1754517728
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e51bf0a924so898895ab.1
        for <linux-pci@vger.kernel.org>; Wed, 06 Aug 2025 15:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517728; x=1755122528;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPKtzeEHbCO/oC/mPOhJydcV6bGZHZZqGISB9ILuO/c=;
        b=JmTchxuknXpxl9VUlBXYpSo5SOIbcZgJZRKuGGdFcXH31+WvaWVYKKlF3PZINAWEI0
         NxODEVEe/mXsPpjmbuWc6pzi7BXm4LMMKueCu8IuNdBjjAh+UryIW89VfWIGygpPsPk1
         FDM4TZPCnt9v6fZ8vulubf+ZpA79I+hfQob90Bce8nMhD3SE5Bh+Ytv22T2wcs0dFeN+
         +VG6l0QytuHGKPFPZ4WUu6G6L4RL6cvH/b9wAssbK7KMlsOdJn0cPPOR9KT5hYseZOFW
         4VrQchH77dSAOF+AABAJxBUQd36hSIoXbbGo+lLrf2jMTYL8cqIVSd7fdT2+aZQ/ee+P
         8wCg==
X-Forwarded-Encrypted: i=1; AJvYcCWxNy794sZUyhHNTu+Gw7RN8VbSSGugmP54hXOVksynzeqT5nYsbhi8NmOLf13k1Di7zrsXEMIsiy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHrTopfRBpa5f7WBPo+El/nI/sGu2YGXEq1kQ1vk6kxIJ5QFn
	P6CGgHU6mbCRNFwWf5mueVP95xm5RwE0QG6v00SI6Ky2Rty7ztqC9EmsG2Nrv2Vj5gH5jkPrQtz
	B5srK+/Tq8q6P/ncRBf985rcvOMXGCC3iMfff5SVsyzUMhzQokSS5PC5f8Uy0og==
X-Gm-Gg: ASbGncs8FcPT2VS58KHt7pE9SI+myK+HPxkkBbT6X2GgzkJZgbNEjiBwyRR4pZkAnb2
	CbtALIJYYKCHlbGjBg0QmAqfBmM0AJvbTu9lfhH84nHtEcMukPoc3kWSz4rSDmSrLgAXojWJf2i
	3WmsfhAp5weYzyTPJvETZLuqLdr8v0YVt+T7yab84Auy9g/21dR3yd3qOPJDEFIKhhVroyfo5u7
	y9GyRyCap3WkZPQo6oYDJGtqmfDuHfkzx20H1/0jqDCTYh8zFBqamLoH39eqK5t59twIUJtopow
	nD+7AcS4pFu/POfa7M3tiyjhH9BBK7EFxFw9bIO0TCk=
X-Received: by 2002:a05:6e02:3193:b0:3dd:c927:3b4f with SMTP id e9e14a558f8ab-3e51b8854c1mr22433155ab.2.1754517727966;
        Wed, 06 Aug 2025 15:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIzdy8eeJry7tYq6oPCO7e2LCNwpZ/0SyAUMoLDbyTlBwk+OaaK/N75sVSFjgffH+CpRQ7JQ==
X-Received: by 2002:a05:6e02:3193:b0:3dd:c927:3b4f with SMTP id e9e14a558f8ab-3e51b8854c1mr22432755ab.2.1754517727346;
        Wed, 06 Aug 2025 15:02:07 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e40297c389sm63783105ab.2.2025.08.06.15.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:02:05 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:02:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 08/10] vfio/pci: Enable peer-to-peer DMA transactions
 by default
Message-ID: <20250806160201.2b72e7a0.alex.williamson@redhat.com>
In-Reply-To: <edb2ec654fc27ba8f73695382ab0a029f18422b5.1754311439.git.leon@kernel.org>
References: <cover.1754311439.git.leon@kernel.org>
	<edb2ec654fc27ba8f73695382ab0a029f18422b5.1754311439.git.leon@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Aug 2025 16:00:43 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Make sure that all VFIO PCI devices have peer-to-peer capabilities
> enables, so we would be able to export their MMIO memory through DMABUF,
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 4 ++++
>  include/linux/vfio_pci_core.h    | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 31bdb9110cc0f..df9a32d3deac9 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -28,6 +28,7 @@
>  #include <linux/nospec.h>
>  #include <linux/sched/mm.h>
>  #include <linux/iommufd.h>
> +#include <linux/pci-p2pdma.h>
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
>  #endif
> @@ -2088,6 +2089,9 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	INIT_LIST_HEAD(&vdev->dummy_resources_list);
>  	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>  	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
> +	vdev->provider = pci_p2pdma_enable(vdev->pdev);
> +	if (IS_ERR(vdev->provider))
> +		return PTR_ERR(vdev->provider);

I think this just made all vfio-pci drivers functionally dependent on
CONFIG_PCI_P2PDMA.  Seems at best exporting a dma-buf should be
restricted if this fails.  Thanks,

Alex

>  	init_rwsem(&vdev->memory_lock);
>  	xa_init(&vdev->ctx);
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index fbb472dd99b36..b017fae251811 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -94,6 +94,7 @@ struct vfio_pci_core_device {
>  	struct vfio_pci_core_device	*sriov_pf_core_dev;
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
> +	struct p2pdma_provider  *provider;
>  };
>  
>  /* Will be exported for vfio pci drivers usage */


