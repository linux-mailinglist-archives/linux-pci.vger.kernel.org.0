Return-Path: <linux-pci+bounces-40279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E01C6C32ABB
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B98D34C86D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19A6324B32;
	Tue,  4 Nov 2025 18:32:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E8261B98;
	Tue,  4 Nov 2025 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281153; cv=none; b=UScqpqkXcNSHzwXemYqfufURTPXWNk1x50fsMAkwNc3sMtS6UVl7BxbmfGpCIKkNSRhQyb83vxguzRiwcCBb2vaegal1yC97TiEVFLXgvX5saposDH5ZOavvMfkmR0h309rBwdP2Aut/UYhAG7r/jaClbznU5lERWR6AF++k3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281153; c=relaxed/simple;
	bh=FmWYMI4qz60lGgkKpPSp7ZtCjOpNTjKTxWgKY6kyHfI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApCuvM32jBnVDAXMS1M37mlwaRPMo1cQIK2BKqiEFdxnDm7Iy9GqQeQLDmtT5zMh127PrsN31eolxqpNYXu/GTmalNZdITEuvg/vkud/PTh9FbDcLhzyG45cAU5WNdzQ+BzzKxokhnX7fRw7FJJwJ8D50tAtV23VCvbjLZlCm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1H5f4G2gz6L55x;
	Wed,  5 Nov 2025 02:28:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B43141401DC;
	Wed,  5 Nov 2025 02:32:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:32:27 +0000
Date: Tue, 4 Nov 2025 18:32:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 20/25] CXL/PCI: Introduce CXL Port protocol error
 handlers
Message-ID: <20251104183226.00001117@huawei.com>
In-Reply-To: <20251104170305.4163840-21-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-21-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 11:03:00 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Add CXL protocol error handlers for CXL Port devices (Root Ports,
> Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
> and cxl_port_error_detected() to handle correctable and uncorrectable errors
> respectively.
> 
> Introduce cxl_get_ras_base() to retrieve the cached RAS register base
> address for a given CXL port. This function supports CXL Root Ports,
> Downstream Ports, and Upstream Ports by returning their previously mapped
> RAS register addresses.
> 
> Add device lock assertions to protect against concurrent device or RAS
> register removal during error handling. The port error handlers require
> two device locks:
> 
> 1. The port's CXL parent device - RAS registers are mapped using devm_*
>    functions with the parent port as the host. Locking the parent prevents
>    the RAS registers from being unmapped during error handling.
> 
> 2. The PCI device (pdev->dev) - Locking prevents concurrent modifications
>    to the PCI device structure during error handling.
> 
> The lock assertions added here will be satisfied by device locks introduced
> in a subsequent patch.
> 
> Introduce get_pci_cxl_host_dev() to return the device responsible for
> managing the RAS register mapping. This function increments the reference
> count on the host device to prevent premature resource release during error
> handling. The caller is responsible for decrementing the reference count.
> For CXL endpoints, which manage resources without a separate host device,
> this function returns NULL.
> 
> Update the AER driver's is_cxl_error() to recognize CXL Port devices in
> addition to CXL Endpoints, as both now have CXL-specific error handlers.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
Really trivial comment follows.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index beb142054bda..142ca8794107 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> @@ -254,6 +287,22 @@ pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ra
>  	return PCI_ERS_RESULT_PANIC;
>  }
>  
> +void cxl_port_cor_error_detected(struct device *dev)
> +{
> +	void __iomem *ras_base = cxl_get_ras_base(dev);
> +
> +	cxl_handle_cor_ras(dev, 0, ras_base);
To me no significant loss of readability to do

	cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));

I don't really care much so feel free to ignore.

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
> +
> +pci_ers_result_t cxl_port_error_detected(struct device *dev)
> +{
> +	void __iomem *ras_base = cxl_get_ras_base(dev);
> +
> +	return cxl_handle_ras(dev, 0, ras_base);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
> +
>  void cxl_cor_error_detected(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 5dbc81341dc4..25f9512b57f7 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -43,7 +43,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>  	if (!info || !info->is_cxl)
>  		return false;
>  
> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
>  		return false;
>  
>  	return is_internal_error(info);


