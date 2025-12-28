Return-Path: <linux-pci+bounces-43766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C2ACE4926
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 05:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6A3A30049E2
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 04:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D822F77B;
	Sun, 28 Dec 2025 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b32o8bxz"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14A22FE11
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 04:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766894682; cv=none; b=SXsJKnVF7kbvl+FfW91jo5XJnyDIOBpHSnEL6CabjwrhK0ACt9y6ULWrmWYtlC2LYUs2sFKgTSaha0BA0HiBXqyR6nY7+exQzOuFlswFoA3nTcvU+7K/GB39yGmKpqTHD+yFC6DKqxE4XO6vm2zUjlGH+G69ulRuEziEwn1NX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766894682; c=relaxed/simple;
	bh=rwso1IvqVHcmC0OFBZ+qtFY1RlZNlcFe2TJYNy85Vu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QApEQtbsLOCsCwFFCUzvhlwl1rby4VCytHND3GqzdhtI/ucWqiul8a10D+51oCBHPgOAFFG+i7wsEwFlzSdmt5Getpd1O+VLKeJ11SJDP7f0UIs4Raev4dxwI/w1CIJ3hrT81O4xRPnJUZL5wg7XyHIMP3T4KRhjEfZsUOrFMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b32o8bxz; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0439348-dca7-4f1b-9d96-b5a596c9407d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766894668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R92CBy0/1nAfk4g7pT7vyN8U+OvLxgWMegNQkEwQja0=;
	b=b32o8bxzsyw4dCZSx+bpqNAJk7/PyR2MGYbTDMgtJY2V/pQjv+E38m1RzAfzoUM1Re4Wkf
	Z+jePIFQK/tqmJseD59D3NVigjbFNUHxiwqMb316IIyKeXtCQP2nPzZH7nTDmOYAhIjzp3
	TzIB8uV16gjSj0XMpIIlMnkJxUNWmjc=
Date: Sat, 27 Dec 2025 20:03:44 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 19/21] vfio: selftests: Expose low-level helper routines
 for setting up struct vfio_pci_device
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>,
 Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
 Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-20-dmatlack@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251126193608.2678510-20-dmatlack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/26 11:36, David Matlack 写道:
> Expose a few low-level helper routings for setting up vfio_pci_device
> structs. These routines will be used in a subsequent commit to assert
> that VFIO_GROUP_GET_DEVICE_FD fails under certain conditions.
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>   .../lib/include/libvfio/vfio_pci_device.h     |  5 +++
>   .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++------
>   2 files changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 896dfde88118..2389c7698335 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -125,4 +125,9 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
>   
>   const char *vfio_pci_get_cdev_path(const char *bdf);
>   
> +/* Low-level routines for setting up a struct vfio_pci_device */
> +struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu);
> +void vfio_pci_group_setup(struct vfio_pci_device *device);
> +void vfio_pci_iommu_setup(struct vfio_pci_device *device);
> +
>   #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index e9423dc3864a..c1a3886dee30 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -199,7 +199,7 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
>   	return group;
>   }
>   
> -static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
> +void vfio_pci_group_setup(struct vfio_pci_device *device)
>   {
>   	struct vfio_group_status group_status = {
>   		.argsz = sizeof(group_status),
> @@ -207,7 +207,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
>   	char group_path[32];
>   	int group;
>   
> -	group = vfio_pci_get_group_from_dev(bdf);
> +	group = vfio_pci_get_group_from_dev(device->bdf);
>   	snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
>   
>   	device->group_fd = open(group_path, O_RDWR);
> @@ -219,14 +219,12 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
>   	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->iommu->container_fd);
>   }
>   
> -static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
> +void vfio_pci_iommu_setup(struct vfio_pci_device *device)
>   {
>   	struct iommu *iommu = device->iommu;
>   	unsigned long iommu_type = iommu->mode->iommu_type;
>   	int ret;
>   
> -	vfio_pci_group_setup(device, bdf);
> -
>   	ret = ioctl(iommu->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
>   	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
>   
> @@ -236,8 +234,14 @@ static void vfio_pci_container_setup(struct vfio_pci_device *device, const char
>   	 * because the IOMMU type is already set.
>   	 */
>   	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
> +}
>   
> -	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
> +static void vfio_pci_container_setup(struct vfio_pci_device *device)
> +{
> +	vfio_pci_group_setup(device);
> +	vfio_pci_iommu_setup(device);
> +
> +	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, device->bdf);
>   	VFIO_ASSERT_GE(device->fd, 0);
>   }
>   
> @@ -337,9 +341,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
>   	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
>   }
>   
> -struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
> -					       struct iommu *iommu,
> -					       int device_fd)
> +struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
>   {
>   	struct vfio_pci_device *device;
>   
> @@ -349,9 +351,20 @@ struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
>   	device->bdf = bdf;
>   	device->iommu = iommu;
>   
> +	return device;
> +}
> +

In the latest kernel, this part changes too much.

Yanjun.Zhu

> +struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
> +					       struct iommu *iommu,
> +					       int device_fd)
> +{
> +	struct vfio_pci_device *device;
> +
> +	device = vfio_pci_device_alloc(bdf, iommu);
> +
>   	if (device->iommu->mode->container_path) {
>   		VFIO_ASSERT_EQ(device_fd, -1);
> -		vfio_pci_container_setup(device, bdf);
> +		vfio_pci_container_setup(device);
>   	} else {
>   		vfio_pci_iommufd_setup(device, bdf, device_fd);
>   	}

-- 
Best Regards,
Yanjun.Zhu


