Return-Path: <linux-pci+bounces-33494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18342B1CF07
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 00:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3DC566E04
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA98F2343CF;
	Wed,  6 Aug 2025 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bh9a1F/Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFEB21CC68
	for <linux-pci@vger.kernel.org>; Wed,  6 Aug 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519105; cv=none; b=PRrkLOs3xAzAxBNZ8t5iii/CuolhH0RW9a8Gy8D2xntEvjuBf/1tDYKuBmwop+qqnQM5U0K5nIQKcclRifb7WCa2F94QhN5v4dm4hl/TjNuF9Jh/Wec2dlV19tJ5xtRBwltnjKuagiqUgwd2pZKWziBNnRAGGKAX1hnqQf3tpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519105; c=relaxed/simple;
	bh=E8mVSJu/tMPT+RCSYBB/JKwAzVd4GM2qVRUojQoI5Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsWbx3Bt/SnjkDMEu9gx/iWgenb4tNlNfylL0ukwOU0Kk8u9L5wiB9irygb/4lE1I6QETSqTbo/dQAoVzqsK95KV37TX9r6Q0vDB2HLtyX9xATNdo8VTFgraVjhiMT80awbclSx8M/HbZWw3pbR0qZJXjtf0JH1RuM3SC4cPrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bh9a1F/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754519102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KWudinkIbXD4F4ulzK9/+oUi2avXDJW6sBf89lUWmU=;
	b=bh9a1F/QQZqimR8naHWs7xCUacLE+AxSbAHAEijZVyyquS0D9T2eFJ0G0hp0DDa1n9qNXp
	YJmz395QE9CrfZJ8Mqk+Fh/sa7Coqbv4/P3Mmrk2l3YyYXIOgIEN9dros7cP28LKQGa+eL
	HAC4VmznYjuYblq7jM72edaJ8bmTtvk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-kJJ9nSReP2SnBlzCnpte0Q-1; Wed, 06 Aug 2025 18:25:01 -0400
X-MC-Unique: kJJ9nSReP2SnBlzCnpte0Q-1
X-Mimecast-MFC-AGG-ID: kJJ9nSReP2SnBlzCnpte0Q_1754519101
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e410d87802so630525ab.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Aug 2025 15:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754519100; x=1755123900;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KWudinkIbXD4F4ulzK9/+oUi2avXDJW6sBf89lUWmU=;
        b=oTp1Oi4OQwPML1kIeW/GwX3S7jQBhQ/TFtZkE8b/7GYsK2Jj+5FoSPw/IUSH2nxnCx
         1GVWNQB0uvVqXek0IT7FbePvF8ejvl8P1+IF0dqCNWQ8LUy+RNnyAIObwnnFOKTEKKjF
         qB42JCTTf6WJqkxwit30ZqffAcFRRQ/LMb7o49dnwfmefXO84ny0NgetYch5Z7Cc3twF
         a+jp0plyI05vRJCKQWVLcuRmMU5PKQuBttHdb8wFSaHVCnU3O10vjnNax7nWviF0j+q2
         BIbE5/fTfzvuvRhioJYNQQCrdJLxCcSxZ41tBinBFNFswcka0UkGHzJb1031DXXggI3A
         tauA==
X-Forwarded-Encrypted: i=1; AJvYcCWWYqKmnQZcH7joo1l4bb7ROWFUIzqzvgrIIGx9rMd1YVl1MVfYGfw1I4YBjtN3ArtSVqZcSEGIbpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWR3enzPybjtumcsKhdDs2KAGGN324Q79TjLKQX24X0ja3Qkw
	lTkKO0aaT1phN1gM4yV+G2Q4vnjnicHK5aBOwXOvfVT5gMrUmm/TewoD2x+TYzjDqnXqWbQSpJS
	DwEze5CvDTj9X+xjyS33VLxhKs4kIzXtv1C3tta2jKuj8im4+qIHlBzAuI/G6Uw==
X-Gm-Gg: ASbGncu8F4tr8wNtNwvVMlzMygPWk6A+ipsD5eE8Y20ZvojhpZN8W/BnsDbeBovXClW
	4lQDkKGixFrdYJ6GO+zaxuoTXJCYe9GAwfumTZes28Q1pZwGg4LW1iu5iqq6l1BR3C6wfDTJmE0
	qmwU/bS4Ep5vz6Jk38TWLUudJfLrwOU64wOheesFzIz8B+vsOOrXDy33lOr2utOHKZln7GZbETe
	S3W87xhhcMfB0ajD0glwICsZ11hGcmh9Z2flrUJ5FEfZwotHSOD96E2Xt5qWfG+KD8Gwc2+xNgz
	N9InkDQA2nUS76cCLucKgeGqv6VBUzFFT1nUzDkER4A=
X-Received: by 2002:a05:6602:148a:b0:85d:9793:e0d8 with SMTP id ca18e2360f4ac-8819eddca30mr265751339f.0.1754519100569;
        Wed, 06 Aug 2025 15:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJbvSuwj5vna+ENO4HZHTFh+EQIF6Bqd2408Pfz1T06ISMEQUJO+65aGvhO/KGJJ7KSEu0KQ==
X-Received: by 2002:a05:6602:148a:b0:85d:9793:e0d8 with SMTP id ca18e2360f4ac-8819eddca30mr265749739f.0.1754519100087;
        Wed, 06 Aug 2025 15:25:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88175b2e0c6sm314280239f.31.2025.08.06.15.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:24:59 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:24:55 -0600
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
Subject: Re: [PATCH v1 10/10] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20250806162455.350f73a4.alex.williamson@redhat.com>
In-Reply-To: <5e043d8b95627441db6156e7f15e6e1658e9d537.1754311439.git.leon@kernel.org>
References: <cover.1754311439.git.leon@kernel.org>
	<5e043d8b95627441db6156e7f15e6e1658e9d537.1754311439.git.leon@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Aug 2025 16:00:45 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add support for exporting PCI device MMIO regions through dma-buf,
> enabling safe sharing of non-struct page memory with controlled
> lifetime management. This allows RDMA and other subsystems to import
> dma-buf FDs and build them into memory regions for PCI P2P operations.
> 
> The implementation provides a revocable attachment mechanism using
> dma-buf move operations. MMIO regions are normally pinned as BARs
> don't change physical addresses, but access is revoked when the VFIO
> device is closed or a PCI reset is issued. This ensures kernel
> self-defense against potentially hostile userspace.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/Kconfig           |  20 ++
>  drivers/vfio/pci/Makefile          |   2 +
>  drivers/vfio/pci/vfio_pci_config.c |  22 +-
>  drivers/vfio/pci/vfio_pci_core.c   |  25 +-
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 390 +++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_priv.h   |  23 ++
>  include/linux/dma-buf.h            |   1 +
>  include/linux/vfio_pci_core.h      |   3 +
>  include/uapi/linux/vfio.h          |  25 ++
>  9 files changed, 506 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/vfio/pci/vfio_pci_dmabuf.c
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 2b0172f546652..55ae888bf26ae 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -55,6 +55,26 @@ config VFIO_PCI_ZDEV_KVM
>  
>  	  To enable s390x KVM vfio-pci extensions, say Y.
>  
> +config VFIO_PCI_DMABUF
> +	bool "VFIO PCI extensions for DMA-BUF"
> +	depends on VFIO_PCI_CORE
> +	depends on PCI_P2PDMA && DMA_SHARED_BUFFER
> +	default y
> +	help
> +	  Enable support for VFIO PCI extensions that allow exporting
> +	  device MMIO regions as DMA-BUFs for peer devices to access via
> +	  peer-to-peer (P2P) DMA.
> +
> +	  This feature enables a VFIO-managed PCI device to export a portion
> +	  of its MMIO BAR as a DMA-BUF file descriptor, which can be passed
> +	  to other userspace drivers or kernel subsystems capable of
> +	  initiating DMA to that region.
> +
> +	  Say Y here if you want to enable VFIO DMABUF-based MMIO export
> +	  support for peer-to-peer DMA use cases.
> +
> +	  If unsure, say N.
> +
>  source "drivers/vfio/pci/mlx5/Kconfig"
>  
>  source "drivers/vfio/pci/hisilicon/Kconfig"
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index cf00c0a7e55c8..f9155e9c5f630 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -2,7 +2,9 @@
>  
>  vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>  vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
> +
>  obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
> +vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
>  
>  vfio-pci-y := vfio_pci.o
>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 8f02f236b5b4b..7e23387a43b4d 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -589,10 +589,12 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		virt_mem = !!(le16_to_cpu(*virt_cmd) & PCI_COMMAND_MEMORY);
>  		new_mem = !!(new_cmd & PCI_COMMAND_MEMORY);
>  
> -		if (!new_mem)
> +		if (!new_mem) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
> -		else
> +			vfio_pci_dma_buf_move(vdev, true);
> +		} else {
>  			down_write(&vdev->memory_lock);
> +		}
>  
>  		/*
>  		 * If the user is writing mem/io enable (new_mem/io) and we
> @@ -627,6 +629,8 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		*virt_cmd &= cpu_to_le16(~mask);
>  		*virt_cmd |= cpu_to_le16(new_cmd & mask);
>  
> +		if (__vfio_pci_memory_enabled(vdev))
> +			vfio_pci_dma_buf_move(vdev, false);
>  		up_write(&vdev->memory_lock);
>  	}
>  
> @@ -707,12 +711,16 @@ static int __init init_pci_cap_basic_perm(struct perm_bits *perm)
>  static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
>  					  pci_power_t state)
>  {
> -	if (state >= PCI_D3hot)
> +	if (state >= PCI_D3hot) {
>  		vfio_pci_zap_and_down_write_memory_lock(vdev);
> -	else
> +		vfio_pci_dma_buf_move(vdev, true);
> +	} else {
>  		down_write(&vdev->memory_lock);
> +	}
>  
>  	vfio_pci_set_power_state(vdev, state);
> +	if (__vfio_pci_memory_enabled(vdev))
> +		vfio_pci_dma_buf_move(vdev, false);
>  	up_write(&vdev->memory_lock);
>  }
>  
> @@ -900,7 +908,10 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>  
>  		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
> +			vfio_pci_dma_buf_move(vdev, true);
>  			pci_try_reset_function(vdev->pdev);
> +			if (__vfio_pci_memory_enabled(vdev))
> +				vfio_pci_dma_buf_move(vdev, true);

@revoked true -> true seems wrong.

>  			up_write(&vdev->memory_lock);
>  		}
>  	}
> @@ -982,7 +993,10 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>  
>  		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
> +			vfio_pci_dma_buf_move(vdev, true);
>  			pci_try_reset_function(vdev->pdev);
> +			if (__vfio_pci_memory_enabled(vdev))
> +				vfio_pci_dma_buf_move(vdev, true);

Same.

>  			up_write(&vdev->memory_lock);
>  		}
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index b1863d84b11aa..8e840ac413e9b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -28,7 +28,9 @@
>  #include <linux/nospec.h>
>  #include <linux/sched/mm.h>
>  #include <linux/iommufd.h>
> +#ifdef CONFIG_VFIO_PCI_DMABUF
>  #include <linux/pci-p2pdma.h>
> +#endif
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
>  #endif
> @@ -287,6 +289,8 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
>  	 * semaphore.
>  	 */
>  	vfio_pci_zap_and_down_write_memory_lock(vdev);
> +	vfio_pci_dma_buf_move(vdev, true);
> +
>  	if (vdev->pm_runtime_engaged) {
>  		up_write(&vdev->memory_lock);
>  		return -EINVAL;
> @@ -370,6 +374,8 @@ static void vfio_pci_runtime_pm_exit(struct vfio_pci_core_device *vdev)
>  	 */
>  	down_write(&vdev->memory_lock);
>  	__vfio_pci_runtime_pm_exit(vdev);
> +	if (__vfio_pci_memory_enabled(vdev))
> +		vfio_pci_dma_buf_move(vdev, false);
>  	up_write(&vdev->memory_lock);
>  }
>  
> @@ -690,6 +696,8 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  #endif
>  	vfio_pci_core_disable(vdev);
>  
> +	vfio_pci_dma_buf_cleanup(vdev);
> +
>  	mutex_lock(&vdev->igate);
>  	if (vdev->err_trigger) {
>  		eventfd_ctx_put(vdev->err_trigger);
> @@ -1222,7 +1230,10 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	 */
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
> +	vfio_pci_dma_buf_move(vdev, true);
>  	ret = pci_try_reset_function(vdev->pdev);
> +	if (__vfio_pci_memory_enabled(vdev))
> +		vfio_pci_dma_buf_move(vdev, false);
>  	up_write(&vdev->memory_lock);
>  
>  	return ret;
> @@ -1511,6 +1522,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_pm_exit(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_DMA_BUF:
> +		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -2085,9 +2098,13 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	INIT_LIST_HEAD(&vdev->dummy_resources_list);
>  	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>  	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
> +#ifdef CONFIG_VFIO_PCI_DMABUF
>  	vdev->provider = pci_p2pdma_enable(vdev->pdev);
>  	if (IS_ERR(vdev->provider))
>  		return PTR_ERR(vdev->provider);
> +
> +	INIT_LIST_HEAD(&vdev->dmabufs);
> +#endif
>  	init_rwsem(&vdev->memory_lock);
>  	xa_init(&vdev->ctx);
>  
> @@ -2470,11 +2487,17 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  	 * cause the PCI config space reset without restoring the original
>  	 * state (saved locally in 'vdev->pm_save').
>  	 */
> -	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
> +	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
> +		vfio_pci_dma_buf_move(vdev, true);
>  		vfio_pci_set_power_state(vdev, PCI_D0);
> +	}

The revoke should have happened at the time the BARs were zapped.
Thanks,

Alex

>  
>  	ret = pci_reset_bus(pdev);
>  
> +	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
> +		if (__vfio_pci_memory_enabled(vdev))
> +			vfio_pci_dma_buf_move(vdev, false);
> +
>  	vdev = list_last_entry(&dev_set->device_list,
>  			       struct vfio_pci_core_device, vdev.dev_set_list);
>  


