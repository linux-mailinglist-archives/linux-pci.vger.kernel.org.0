Return-Path: <linux-pci+bounces-41661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC83C6FF8E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 17:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DA87F28ED6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFFE2E8B66;
	Wed, 19 Nov 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="N3AamHaH"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747461F463E;
	Wed, 19 Nov 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568720; cv=none; b=e/XdI7cclr9DP2SqifJLsNQOjlpAP3U3X/xxWLIncmI5K/3q+R91jWczSI00s0JqLFzhq+cXMk4Jt7vOKaontwo7tMmtNilVzPyHMWzDNsh0n99PJWMmbuFac4CgoQvg+FIDmA8lK5f74ATYDMctL2LFRWBmnLDWT6OC1pDfCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568720; c=relaxed/simple;
	bh=VKtIi9EYMzDKzvT85LA50F6VBpmoAORqCYOXVXARLsg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7Sknrv13QDMTPpymm3RXjMS/LzBj5Xjx5y7cqAlv07hgmGDfpV5BZA56YLIE23/ixJfcYKYjDu4GWD63nHjWO4o34yUAegAZygmUmslYcI8MPgkaLZg7jI5KAQr8Rb0J/bLNr6ahzKbKyTxExGZO5wu324spuBSeiUtnIv9WD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=N3AamHaH; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uPer+0zUouYQflZKOjIi8F+VvjFsXukWzLta7c51w5Y=;
	b=N3AamHaHSG59kZl8zhI/w7eV5iJkjtLu2WLkCRedFEni5oK+iJnpiqwEBCrVT+JqdWxuHjkmg
	yn0Af0G0tylxhQGSHAypKjtU2fu4rmN/JfxuwemxSxrxfRUHzgaDP005Rtui2hBUoK0Y0Z2PCUb
	5m8M2rSa0sm/ojZhFMOeZgk=
Received: from frasgout.his.huawei.com (unknown [172.18.146.32])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dBQxv18WwzMtYq;
	Wed, 19 Nov 2025 23:53:38 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dBQyZ2n6TzHnGhy;
	Wed, 19 Nov 2025 23:54:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AD1E14033C;
	Wed, 19 Nov 2025 23:54:47 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 19 Nov
 2025 15:54:46 +0000
Date: Wed, 19 Nov 2025 15:54:44 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 04/11] coco: guest: arm64: Add support for updating
 interface reports from device
Message-ID: <20251119155444.00002925@huawei.com>
In-Reply-To: <20251117140007.122062-5-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
	<20251117140007.122062-5-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 19:30:00 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Support collecting interface reports using RSI calls. The fetched
> interface report will be cached in the host.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> index f4c9e529c43e..7988ff6d4b2e 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
> @@ -212,6 +212,12 @@ static struct pci_tsm *cca_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pde
>  	if (ret)
>  		return ERR_PTR(-EIO);
>  
> +	ret = cca_update_device_object_cache(pdev, cca_dsc);
> +	if (ret) {
> +		cca_device_unlock(pdev);
> +		return ERR_PTR(-EIO);

Why not return ERR_PTR(ret);

> +	}
> +
>  	return &no_free_ptr(cca_dsc)->pci.base_tsm;
>  }
>  
> diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coco/arm-cca-guest/rhi-da.c
> index 3430d8df4424..f4fb8577e1b5 100644
> --- a/drivers/virt/coco/arm-cca-guest/rhi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
> @@ -156,3 +156,47 @@ int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_state)
>  
>  	return ret;
>  }
> +
> +static inline int rhi_vdev_get_interface_report(unsigned long vdev_id,
> +						unsigned long *cookie)
> +{
> +	unsigned long ret;
> +
> +	struct rsi_host_call *rhi_call __free(kfree) =
> +		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
> +	if (!rhi_call)
> +		return -ENOMEM;
> +
> +	rhi_call->imm = 0;
> +	rhi_call->gprs[0] = RHI_DA_VDEV_GET_INTERFACE_REPORT;
> +	rhi_call->gprs[1] = vdev_id;
> +
> +	ret = rsi_host_call(virt_to_phys(rhi_call));

Given every rsi_host_call I've seen in here is passed
output of virt_to_phys() maybe a wrapper that does that is worthwhile?

rsi_host_call_va() or something like that.

> +	if (ret != RSI_SUCCESS)
> +		return -EIO;
> +
> +	*cookie = rhi_call->gprs[1];
> +	return map_rhi_da_error(rhi_call->gprs[0]);
> +}


> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> index d1f4641a0fa1..fd4792a50daf 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
> @@ -31,4 +31,6 @@ static inline int rsi_vdev_id(struct pci_dev *pdev)
>  
>  int cca_device_lock(struct pci_dev *pdev);
>  int cca_device_unlock(struct pci_dev *pdev);
> +int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *dsc);
> +

If the blank line makes sense, should have been in previous patch.

>  #endif


