Return-Path: <linux-pci+bounces-32689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD6EB0CD52
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 00:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5383B2E22
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 22:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A00522F164;
	Mon, 21 Jul 2025 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHW/wG6A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153D22F769;
	Mon, 21 Jul 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137329; cv=none; b=GOl5W7Ir5lOY4ecHzqxVo/qIE+kuJqYDgU1GsGhTi5m7AnK1JxshGmO7jFc6qyc86UBXMig87AKK4Cy0yteJ3rBRi9+kEJLKwCdLpgz9yudpAoEr2ah7rdFCkEfLR2JEDqs1tVIPbMj8JJmsE43eHXkVpAKnJG769S53PcE+nvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137329; c=relaxed/simple;
	bh=fdxqWqOmf5/I2IVdSsvLdUoS86n8s5pV/0lo4LZzIzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU9O7m9BK5+vVOx0H9AVKHr+T78fad5cw36wq5FHldEagbEIA1rdJYNxBXr5wRjJY3iCfV217Xt4Re/jCufnlZkOLjOcdwHMLyGxUHfkByIddNtigLENXoWRxrQzYBT4cD2XVtAq85fjT85d4lTLUYCA0DRByQrsFQakAhh0gHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHW/wG6A; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753137328; x=1784673328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fdxqWqOmf5/I2IVdSsvLdUoS86n8s5pV/0lo4LZzIzw=;
  b=mHW/wG6A4uKD6yLsDF2dI2/LUY01ZpQ6ayxdkmsojZrZ4SC9BPD59p8z
   DsLhhIhRSi2u0sJYjq6ttTVj7/Z0wZYdpVMiIZPYVFG0M5czi1HTVAXAi
   KvjZmPO5dNrSbDna34pkJr85sOy6paPvVMXRPRLzTmIBJP9JRFN7U9ymE
   g42B9cq2EmXaYIZc6hBg+MIUxwyt3n4fnE1BmUcmRPpccjrcdJg/E52Oi
   RMoLfA0pykdeSngV7SRmvDhBsiyWuilgtfgarSDUfFF+8PxZvOfORB8L4
   YCDji4cIb1lquhWIhaLR5G+MUVb8lI3h3WrJeBt0BPy8zx81c591IkYmG
   g==;
X-CSE-ConnectionGUID: nSH3EIkkQbKmPmAoZ9c7Sw==
X-CSE-MsgGUID: qGDdfuSrS0uzW2bL68tQSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="42987037"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="42987037"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:35:27 -0700
X-CSE-ConnectionGUID: N1U0xvjRSbGfMd8iM9/hYA==
X-CSE-MsgGUID: QkER1yJCQoesruyDsT2OKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="189915630"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.247.118.153]) ([10.247.118.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:35:18 -0700
Message-ID: <24643016-688e-4c50-a577-3cf831cfb73a@intel.com>
Date: Mon, 21 Jul 2025 15:35:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 14/17] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-15-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250626224252.1415009-15-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/25 3:42 PM, Terry Bowman wrote:
> CXL Endpoint protocol errors are currently handled using PCI error
> handlers. The CXL Endpoint requires CXL specific handling in the case of
> uncorrectable error (UCE) handling not provided by the PCI handlers.
> 
> Add CXL specific handlers for CXL Endpoints. Rename the existing
> cxl_error_handlers to be pci_error_handlers to more correctly indicate
> the error type and follow naming consistency.
> 
> The PCI handlers will be called if the CXL device is not trained for
> alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
> CXL UCE handlers.

Would the CXL device still be functional if it can't train the CXL protocols? Just wondering if we still need the standard PCI handlers in that case at all. 

DJ

> 
> The existing EP UCE handler includes checks for various results. These are
> no longer needed because CXL UCE recovery will not be attempted. Implement
> cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC. The
> CXL UCE handler is called by cxl_do_recovery() that acts on the return
> value. In the case of the PCI handler path, call panic() if the result is
> PCI_ERS_RESULT_PANIC.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/cxl/core/native_ras.c | 15 ++++---
>  drivers/cxl/core/pci.c        | 77 ++++++++++++++++++-----------------
>  drivers/cxl/cxl.h             |  4 ++
>  drivers/cxl/cxlpci.h          |  6 +--
>  drivers/cxl/pci.c             |  8 ++--
>  5 files changed, 59 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
> index 19f8f2ac8376..89b65a35f2c0 100644
> --- a/drivers/cxl/core/native_ras.c
> +++ b/drivers/cxl/core/native_ras.c
> @@ -7,18 +7,20 @@
>  #include <cxlmem.h>
>  #include <core/core.h>
>  #include <cxlpci.h>
> +#include <core/core.h>
>  
>  static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
>  {
>  	pci_ers_result_t vote, *result = data;
> +	struct device *dev = &pdev->dev;
>  
>  	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>  	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
>  		return 0;
>  
> -	guard(device)(&pdev->dev);
> +	guard(device)(dev);
>  
> -	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
> +	vote = cxl_error_detected(dev);
>  	*result = merge_result(*result, vote);
>  
>  	return 0;
> @@ -82,16 +84,17 @@ static bool is_cxl_rcd(struct pci_dev *pdev)
>  static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>  {
>  	struct cxl_proto_error_info *err_info = data;
> +	struct device *dev = &pdev->dev;
>  
> -	guard(device)(&pdev->dev);
> +	guard(device)(dev);
>  
>  	if (!is_cxl_rcd(pdev) || !cxl_pci_drv_bound(pdev))
>  		return 0;
>  
>  	if (err_info->severity == AER_CORRECTABLE)
> -		cxl_cor_error_detected(pdev);
> +		cxl_cor_error_detected(dev);
>  	else
> -		cxl_error_detected(pdev, pci_channel_io_frozen);
> +		cxl_error_detected(dev);
>  
>  	return 1;
>  }
> @@ -126,7 +129,7 @@ static void cxl_handle_proto_error(struct cxl_proto_error_info *err_info)
>  						       aer + PCI_ERR_COR_STATUS,
>  						       0, PCI_ERR_COR_INTERNAL);
>  
> -		cxl_cor_error_detected(pdev);
> +		cxl_cor_error_detected(&pdev->dev);
>  
>  		pcie_clear_device_status(pdev);
>  	} else {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 887b54cf3395..7209ffb5c2fe 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -705,8 +705,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool cxl_handle_ras(struct device *dev, u64 serial,
> -			   void __iomem *ras_base)
> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
> +				       void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -715,13 +715,13 @@ static bool cxl_handle_ras(struct device *dev, u64 serial,
>  
>  	if (!ras_base) {
>  		dev_warn_once(dev, "CXL RAS register block is not mapped");
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>  	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>  
>  	/* If multiple errors, log header points to first error from ctrl reg */
>  	if (hweight32(status) > 1) {
> @@ -738,7 +738,7 @@ static bool cxl_handle_ras(struct device *dev, u64 serial,
>  	trace_cxl_aer_uncorrectable_error(dev, serial, status, fe, hl);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> -	return true;
> +	return PCI_ERS_RESULT_PANIC;
>  }
>  
>  #ifdef CONFIG_PCIEAER_CXL
> @@ -833,13 +833,14 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>  #endif
>  
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> +void cxl_cor_error_detected(struct device *dev)
>  {
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct device *dev = &cxlds->cxlmd->dev;
> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> +	scoped_guard(device, cxlmd_dev) {
> +		if (!cxlmd_dev->driver) {
>  			dev_warn(&pdev->dev,
>  				 "%s: memdev disabled, abort error handling\n",
>  				 dev_name(dev));
> @@ -854,20 +855,26 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +void pci_cor_error_detected(struct pci_dev *pdev)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> +	cxl_cor_error_detected(&pdev->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> +pci_ers_result_t cxl_error_detected(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
> +	pci_ers_result_t ue;
> +
> +	scoped_guard(device, cxlmd_dev) {
> +
> +		if (!cxlmd_dev->driver) {
>  			dev_warn(&pdev->dev,
>  				 "%s: memdev disabled, abort error handling\n",
>  				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> +			return PCI_ERS_RESULT_PANIC;
>  		}
>  
>  		if (cxlds->rcd)
> @@ -881,29 +888,23 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>  	}
>  
> -
> -	switch (state) {
> -	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
> -		return PCI_ERS_RESULT_CAN_RECOVER;
> -	case pci_channel_io_frozen:
> -		dev_warn(&pdev->dev,
> -			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> -		return PCI_ERS_RESULT_NEED_RESET;
> -	case pci_channel_io_perm_failure:
> -		dev_warn(&pdev->dev,
> -			 "failure state error detected, request disconnect\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> -	return PCI_ERS_RESULT_NEED_RESET;
> +	return ue;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>  
> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t error)
> +{
> +	pci_ers_result_t rc;
> +
> +	rc = cxl_error_detected(&pdev->dev);
> +	if (rc == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
> +
>  static int cxl_flit_size(struct pci_dev *pdev)
>  {
>  	if (cxl_pci_flit_256(pdev))
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d696d419bd5a..a2eedc8a82e8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -11,6 +11,7 @@
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> +#include <linux/pci.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> @@ -797,6 +798,9 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
>  }
>  int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  
> +void cxl_cor_error_detected(struct device *dev);
> +pci_ers_result_t cxl_error_detected(struct device *dev);
> +
>  /**
>   * struct cxl_endpoint_dvsec_info - Cached DVSEC info
>   * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index ed3c9701b79f..e69a47f0cd94 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -133,8 +133,8 @@ struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  			struct cxl_endpoint_dvsec_info *info);
>  void read_cdat_data(struct cxl_port *port);
> -void cxl_cor_error_detected(struct pci_dev *pdev);
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state);
> +void pci_cor_error_detected(struct pci_dev *pdev);
> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t error);
>  bool cxl_pci_drv_bound(struct pci_dev *pdev);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index cae049f9ae3e..91fab33094a9 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1112,11 +1112,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	}
>  }
>  
> -static const struct pci_error_handlers cxl_error_handlers = {
> -	.error_detected	= cxl_error_detected,
> +static const struct pci_error_handlers pci_error_handlers = {
> +	.error_detected = pci_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
> -	.cor_error_detected	= cxl_cor_error_detected,
> +	.cor_error_detected	= pci_cor_error_detected,
>  	.reset_done	= cxl_reset_done,
>  };
>  
> @@ -1124,7 +1124,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.name			= KBUILD_MODNAME,
>  	.id_table		= cxl_mem_pci_tbl,
>  	.probe			= cxl_pci_probe,
> -	.err_handler		= &cxl_error_handlers,
> +	.err_handler		= &pci_error_handlers,
>  	.dev_groups		= cxl_rcd_groups,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,


