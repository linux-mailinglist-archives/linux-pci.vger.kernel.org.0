Return-Path: <linux-pci+bounces-44976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B4DD25B51
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE247301A480
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653A43B8D6C;
	Thu, 15 Jan 2026 16:18:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E528C009;
	Thu, 15 Jan 2026 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493912; cv=none; b=a2Dh5D7YlLA7NitiODtvxS9Q1m1GoAoAu85s2HawqBoXn+S3SjzTuwnpfdmqwWNkUZXfTwnXv5qDUHF1s00ZIhUEYo9tKyu/jPOuVHTMCHAT8dUHDhDCdWJ1ZdYh4ubQ2/l+3VgnIpUi3FCK4oeti6vox4uGPbOELrN1Lemwdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493912; c=relaxed/simple;
	bh=Dm+jw4Gb/mlpCCkePm2VIvTGs2QSFEdXL++DYel1vt8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SI+5wFCj8RNpez8BiLWDqUv5ADwL/oQkhUc7JhmGrl9v9d4LdOas+duPBfByVu+c2R+aIuz7u0moIavRJGQrvxbOR6nJquaxYw0fXymIzbn/C/6uCjbMo5UIZB7gCVnnK/mhsEYXiyJprbU2rE+qTjqCBPL0u7EnUyz9CP89lJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsSnp5vrPzJ46BS;
	Fri, 16 Jan 2026 00:18:06 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 575AD40563;
	Fri, 16 Jan 2026 00:18:23 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 16:18:22 +0000
Date: Thu, 15 Jan 2026 16:18:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 34/34] cxl: Enable CXL protocol errors during CXL
 Port probe
Message-ID: <20260115161821.0000157d@huawei.com>
In-Reply-To: <20260114182055.46029-35-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-35-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:55 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL protocol errors are not enabled for all CXL devices after boot. These
> must be enabled inorder to process CXL protocol errors.
> 
> Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
> correctable internal errors and uncorrectable internal errors for all CXL
> devices.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 

A question inline.

> ---
> 
> Changes in v13->v14:
> - Update commit title's prefix (Bjorn)
> 
> Changes in v12->v13:
> - Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
> - Add Dave Jiang's and Ben's review-by
> 
> Changes in v11->v12:
> - None
> 
> Changes in v10->v11:
> - Added check for valid PCI devices in is_cxl_error() (Terry)
> - Removed check for RCiEP in cxl_handle_proto_err() and
>   cxl_report_error_detected() (Terry)
> ---
>  drivers/cxl/core/port.c |  2 ++
>  drivers/cxl/core/ras.c  | 22 ++++++++++++++++++++++
>  drivers/cxl/cxlpci.h    |  4 ++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0bec10be5d56..588801c5d406 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1828,6 +1828,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  
>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>  
> +			cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
> +
>  			/*
>  			 * If the endpoint already exists in the port's list,
>  			 * that's ok, it was added on a previous pass.
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 427009a8a78a..e299eb50fbe4 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -117,6 +117,24 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> +void cxl_unmask_proto_interrupts(struct device *dev)
> +{
> +	if (!dev || !dev_is_pci(dev))
> +		return;
> +
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
> +
> +	if (!pdev->aer_cap) {

Add a comment to say why this might not be set.  How did we get here
with out calling pci_aer_init()?

> +		pdev->aer_cap = pci_find_ext_capability(pdev,
> +							PCI_EXT_CAP_ID_ERR);
> +		if (!pdev->aer_cap)
> +			return;
> +	}
> +
> +	pci_aer_unmask_internal_errors(pdev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unmask_proto_interrupts, "CXL");
> +
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map = &dport->reg_map;
> @@ -127,6 +145,8 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>  	else if (cxl_map_component_regs(map, &dport->regs.component,
>  					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
> +
> +	cxl_unmask_proto_interrupts(dev);
>  }
>  
>  /**
> @@ -159,6 +179,8 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>  	if (cxl_map_component_regs(map, &port->regs,
>  				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>  		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +
> +	cxl_unmask_proto_interrupts(port->uport_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 3d70f9b4a193..0c915c0bdfac 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -89,6 +89,7 @@ void __cxl_uport_init_ras_reporting(struct cxl_port *port,
>  int __cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  resource_size_t __cxl_rcd_component_reg_phys(struct device *dev,
>  					     struct cxl_dport *dport);
> +void cxl_unmask_proto_interrupts(struct device *dev);
>  #else
>  static inline void cxl_pci_cor_error_detected(struct pci_dev *pdev)
>  {
> @@ -104,6 +105,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
>  static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
>  {
>  }
> +static inline void cxl_unmask_proto_interrupts(struct device *dev)
> +{
> +}
>  #endif
>  
>  int cxl_port_setup_regs(struct cxl_port *port,


