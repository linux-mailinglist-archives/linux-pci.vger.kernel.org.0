Return-Path: <linux-pci+bounces-6889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7ED8B77B1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB3D1C21EE7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CAD172790;
	Tue, 30 Apr 2024 13:57:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5D171E45;
	Tue, 30 Apr 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485468; cv=none; b=MCjSIrFosH+V6JSQh6/NTYxdYrE1t2TuLQ0bwpO/uAYwboZ+VsJOn9v0Y2ydSstOqviMt0B4Y+iRDKoL8WyQauXP4qN+ASguIaUAlBkb7DrFFSyTmQDoLeBpd91LUn7NW+9TcgtPdglVbzdwO60/elqhiy7BdBYLX2QfXYdNUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485468; c=relaxed/simple;
	bh=d3de5/KXMvxeq8MnSdU5E/wPbV5Mz0Ui+6Jt0WlOLK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcFaB5UGEkqlg3wLgml5KQn1oFlb/t/xaFCMSxLaTPVnDkGbz57HA8pgbi0ZYlBbhWKAVcG17ruvnUaTQN9kzutgoDYps9HH749213NZdHcwDsjnuj8cGZ1fuEVuekoplyuT2W0LacF27UX3P5uJ6njo5aespYyVcvZnIJPrdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53042F4;
	Tue, 30 Apr 2024 06:58:11 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A8343F793;
	Tue, 30 Apr 2024 06:57:43 -0700 (PDT)
Message-ID: <46eba57e-edbf-4fe5-8cc6-5fe11bf7aca0@arm.com>
Date: Tue, 30 Apr 2024 14:57:42 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/of: Support ats-supported device-tree property
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, liviu.dudau@arm.com,
 sudeep.holla@arm.com, joro@8bytes.org
Cc: nicolinc@nvidia.com, ketanp@nvidia.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org
References: <20240429113938.192706-2-jean-philippe@linaro.org>
 <20240429113938.192706-4-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240429113938.192706-4-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2024 12:39 pm, Jean-Philippe Brucker wrote:
> Device-tree declares whether a PCI root-complex supports ATS by setting
> the "ats-supported" property. Copy this flag into device fwspec to let
> IOMMU drivers quickly check if they can enable ATS for a device.

I don't think this functionally conflicts with what I've got going on in 
this area at the moment, and although the way it fits around the other 
error handling seems a bit obtuse and clunky IMO, apparently that's the 
fault of the existing ACPI implementation, so for now,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Ketan Patil <ketanp@nvidia.com>
> ---
>   drivers/iommu/of_iommu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 3afe0b48a48db..082b94c2b3291 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -105,6 +105,14 @@ static int of_iommu_configure_device(struct device_node *master_np,
>   		      of_iommu_configure_dev(master_np, dev);
>   }
>   
> +static void of_pci_check_device_ats(struct device *dev, struct device_node *np)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (fwspec && of_property_read_bool(np, "ats-supported"))
> +		fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> +}
> +
>   /*
>    * Returns:
>    *  0 on success, an iommu was configured
> @@ -147,6 +155,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>   		pci_request_acs();
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>   					     of_pci_iommu_init, &info);
> +		of_pci_check_device_ats(dev, master_np);
>   	} else {
>   		err = of_iommu_configure_device(master_np, dev, id);
>   	}

