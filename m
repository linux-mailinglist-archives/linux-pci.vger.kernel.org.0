Return-Path: <linux-pci+bounces-40280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F976C32B06
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03423BDE9F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4A3328E1;
	Tue,  4 Nov 2025 18:40:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D6381C4;
	Tue,  4 Nov 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281618; cv=none; b=RL8ZNC8Z0C/Q7Tl0Y4weNYxoP47/Ea5CEJy90dbR5B+MEiFYj4aCVw7ZQnYh/hjx+sMa2EGsJvtf3y/z6FZKBMxp40YG+Bxv41gJDOm+qT4DRtDeGYnMkQa1efDqsIiII8t9t8SIvKpUJi7oBeI+uwYxlGNdN5EjcUYrNdckPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281618; c=relaxed/simple;
	bh=Vm4+31yavI3qWhxTlEgm1fIPajd2HY+u461uSVPTkro=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKtIDzeyzG0hus0vm3BIiElShkK6eQcnJrXkx4d6lipmKsizTFB2d7d3+HUXjBTLa+8U/muhQGwd4A6OLkwXWDPOMKmZXRhnokM7MuTWyBOm/sPB74tCWQsxgAL5J0f6sOlHO4TG0yntO0CJopChnaXQbf9x9eB27CkcpPiifvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1HLw3QNlzHnGgC;
	Wed,  5 Nov 2025 02:40:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 505D014038F;
	Wed,  5 Nov 2025 02:40:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:40:11 +0000
Date: Tue, 4 Nov 2025 18:40:09 +0000
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
Subject: Re: [RESEND v13 21/25] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20251104184009.00005d27@huawei.com>
In-Reply-To: <20251104170305.4163840-22-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-22-terry.bowman@amd.com>
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

On Tue, 4 Nov 2025 11:03:01 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER driver now forwards CXL protocol errors to the CXL driver via a
> kfifo. The CXL driver must consume these work items, initiate protocol
> error handling, and ensure RAS mappings remain valid throughout processing.
> 
> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
> AER service driver and begin protocol error processing by calling
> cxl_handle_proto_error().
> 
> Add a PCI device lock on &pdev->dev within cxl_proto_err_work_fn() to
> keep the PCI device structure valid during handling. Locking an Endpoint
> will also defer RAS unmapping until the device is unlocked.
> 
> For Endpoints, add a lock on CXL memory device cxlds->dev. The CXL memory
> device structure holds the RAS register reference needed during error
> handling.
> 
> Add lock for the parent CXL Port for Root Ports, Downstream Ports, and
> Upstream Ports to prevent destruction of structures holding mapped RAS
> addresses while they are in use.
> 
> Invoke cxl_do_recovery() for uncorrectable errors. Treat this as a stub for
> now; implement its functionality in a future patch.
> 
> Export pci_clean_device_status() to enable cleanup of AER status following
> error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
Various comments inline.
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 142ca8794107..5bc144cde0ee 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> -int cxl_ras_init(void)
> -{
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> -}
> -
> -void cxl_ras_exit(void)
> -{
> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);
> -}
> -
>  static bool is_pcie_endpoint(struct pci_dev *pdev)
>  {
>  	return pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT;
> @@ -178,6 +167,51 @@ static void __iomem *cxl_get_ras_base(struct device *dev)
>  	return NULL;
>  }
>  
> +/*
> + * Return 'struct cxl_port *' parent CXL port of dev's
> + *
> + * Reference count increments on success
> + *
> + * dev: Find the parent port of this dev

pdev. 

Generally I'd prefer kernel-doc style even for non exported
/ exposed functions.  Makes it easy to check for stuff like
this as the script will moan at you.

> + */
> +static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
> +{
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port;
> +	}
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	{
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +		struct cxl_port *port = cxlds->cxlmd->endpoint;
> +
> +		get_device(&port->dev);
> +		return port;
> +	}
> +	}
> +	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> @@ -212,6 +246,23 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
>  
> +static bool device_lock_if(struct device *dev, bool cond)
> +{
> +	if (cond)
> +		device_lock(dev);
> +	return cond;
> +}
> +
> +static void device_unlock_if(struct device *dev, bool take)
> +{
> +	if (take)
> +		device_unlock(dev);
> +}

See below. To me these are too weird to wrap up.  Open code them inline
where we can see what they are doing.

> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	while (cxl_proto_err_kfifo_get(&wd)) {
> +		struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(wd.pdev);
> +		struct device *cxlmd_dev;
> +
> +		if (!pdev) {
> +			pr_err_ratelimited("NULL PCI device passed in AER-CXL KFIFO\n");
> +			continue;
> +		}
> +
> +		guard(device)(&pdev->dev);
> +		if (is_pcie_endpoint(pdev)) {
> +			struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +
> +			if (!cxl_pci_drv_bound(pdev))
> +				return;
> +			cxlmd_dev = &cxlds->cxlmd->dev;
> +			device_lock_if(cxlmd_dev, cxlmd_dev);

As below. Too odd.  Also needs comments to explain why conditionally locking it
would be useful.

> +		} else {
> +			cxlmd_dev = NULL;

Set it to NULL at declaration and drop this else leg.

> +		}
> +
> +		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +		if (!port)
> +			return;
> +		guard(device)(&port->dev);
> +
> +		cxl_handle_proto_error(&wd);
> +		device_unlock_if(cxlmd_dev, cxlmd_dev);
This is too odd to wrap up like that.  Particularly given the
very generic sounding device_unlock_if() naming.

> +	}
> +}


