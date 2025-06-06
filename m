Return-Path: <linux-pci+bounces-29066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CEDACFA65
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 02:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A157A4012
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6AC748D;
	Fri,  6 Jun 2025 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WW5yt1qZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9652322A;
	Fri,  6 Jun 2025 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749169336; cv=none; b=VjkQn/GnvSsxMUYXoeSvPCcjMObQtItfQNPrV0v85YgaxsdLOfIYGcz6/h1rNNMVhrn6g4cMsfknMRiBXIF/alofQnObAcQTT3Zwt9f2v01EbN/y8MHITsSdOiBySG7QQ6/Y18vSs1yXObWzOzFshArIBpyPshjmySfV04ek288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749169336; c=relaxed/simple;
	bh=ywsZp22e4U7YuscL5vGVUpZ4zDi8R8WJRkqU5ZvezUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QQax7JMEuAgYeg0N+yBsNbPnEmsCWnyX77C1nQzRTzICNGoWe+EpCsxIRFGl7uOrwAapH8gyYKpvF+XrxY5rMvWrUjI1eaQrkWx1UBAp1f1H06mvE1k0EoFaRbvPvX9tenOZvyI2v9wPwxUaE6TLnI0jYofH3RC0CJajMuM7hOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WW5yt1qZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749169334; x=1780705334;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ywsZp22e4U7YuscL5vGVUpZ4zDi8R8WJRkqU5ZvezUA=;
  b=WW5yt1qZwQS9CjUzA27L8BtRlsaoXGy2zW5ECItnTPVi4i4j1CWALiJ+
   lm8vdGCLOhmnUTpSpvdc7LLvSUjU5Bn//Ijn6j0qmFSgkKdVGdmXLCWoh
   JP5Ymhoy5zLEDXTNRQnYu4f7jV/DRcWu7RkH8qj39QB67RJ3URQh3yVl0
   Gxs3Gp2K51/LiQcOpvnL1SoTqi1oBDCglBzhP/3R10+qier0gZIekNAHh
   x9CgB2wrRmaUUbVkeaS1jZ1mGT0zfWXNJbizVqE2hD+k64J8gP+cDnYki
   kZZMZSKEKy03xcyh69GCrpH6C9P95K9+gawKCL1cfbhrYgPisPyXQgzms
   w==;
X-CSE-ConnectionGUID: w7hQpmydQVmfV05L9NIrPA==
X-CSE-MsgGUID: OGqfdBa1SBS+PQdaJOLPcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="62673262"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="62673262"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:22:12 -0700
X-CSE-ConnectionGUID: 7TAywpovQH+ZyPM4lvzECg==
X-CSE-MsgGUID: VW1k9bexRjWRNIKBpak4uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="150540913"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:22:11 -0700
Received: from [10.124.222.132] (unknown [10.124.222.132])
	by linux.intel.com (Postfix) with ESMTP id C086620B5736;
	Thu,  5 Jun 2025 17:22:09 -0700 (PDT)
Message-ID: <07ee7b91-f65c-4b02-b16e-da59b5097baf@linux.intel.com>
Date: Thu, 5 Jun 2025 17:22:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/16] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-13-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-13-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> CXL Endpoint protocol errors are currently handled using PCI error
> handlers. The CXL Endpoint requires CXL specific handling in the case of
> uncorrectable error handling not provided by the PCI handlers.
>
> Add CXL specific handlers for CXL Endpoints. Rename the existing
> cxl_error_handlers to be pci_error_handlers to more correctly indicate
> the error type and follow naming consistency.
>
> Keep the existing PCI Endpoint handlers. PCI handlers can be called if the
> CXL device is not trained for alternate protocol (CXL). Update the CXL
> Endpoint PCI handlers to call the CXL handler. If the CXL uncorrectable
> handler returns PCI_ERS_RESULT_PANIC then the PCI handler invokes panic().
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/cxl/core/pci.c | 80 ++++++++++++++++++++++--------------------
>   drivers/cxl/core/ras.c | 10 +++---
>   drivers/cxl/cxl.h      |  4 +++
>   drivers/cxl/cxlpci.h   |  6 ++--
>   drivers/cxl/pci.c      |  8 ++---
>   5 files changed, 58 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f5f87c2c3fd5..e094ef518e0a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -710,8 +710,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>    * Log the state of the RAS status registers and prepare them to log the
>    * next error status. Return 1 if reset needed.
>    */
> -static bool __cxl_handle_ras(struct device *dev, u64 serial,
> -			     void __iomem *ras_base)
> +static pci_ers_result_t __cxl_handle_ras(struct device *dev, u64 serial,
> +					 void __iomem *ras_base)
>   {
>   	u32 hl[CXL_HEADERLOG_SIZE_U32];
>   	void __iomem *addr;
> @@ -720,13 +720,13 @@ static bool __cxl_handle_ras(struct device *dev, u64 serial,
>   
>   	if (!ras_base) {
>   		dev_warn_once(dev, "CXL RAS register block is not mapped");
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>   	}
>   
>   	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
>   	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>   
>   	/* If multiple errors, log header points to first error from ctrl reg */
>   	if (hweight32(status) > 1) {
> @@ -743,12 +743,11 @@ static bool __cxl_handle_ras(struct device *dev, u64 serial,
>   	trace_cxl_aer_uncorrectable_error(dev, serial, status, fe, hl);
>   	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>   
> -	return true;
> +	return PCI_ERS_RESULT_PANIC;
>   }
>   
>   static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>   {
> -
>   	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>   }
>   
> @@ -844,14 +843,15 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>   static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>   #endif
>   
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> +void cxl_cor_error_detected(struct device *dev)
>   {
> +	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct device *dev = &cxlds->cxlmd->dev;
> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
>   
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> +	scoped_guard(device, cxlmd_dev) {
> +		if (!cxlmd_dev->driver) {
> +			dev_warn(dev,
>   				 "%s: memdev disabled, abort error handling\n",
>   				 dev_name(dev));
>   			return;
> @@ -865,20 +865,28 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>   
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +void pci_cor_error_detected(struct pci_dev *pdev)
>   {
>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> +	struct device *cxlmd_dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>   
> -	scoped_guard(device, dev) {
> +	cxl_cor_error_detected(&pdev->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
> +
> +pci_ers_result_t cxl_error_detected(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
> +	pci_ers_result_t ue;
> +
> +	scoped_guard(device, cxlmd_dev) {
>   		if (!dev->driver) {
>   			dev_warn(&pdev->dev,
>   				 "%s: memdev disabled, abort error handling\n",
>   				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> +			return PCI_ERS_RESULT_PANIC;
>   		}
>   
>   		if (cxlds->rcd)
> @@ -892,29 +900,25 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>   		ue = cxl_handle_endpoint_ras(cxlds);
>   	}
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
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>   
> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t error)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct device *cxlmd_dev __free(put_device) = &cxlds->cxlmd->dev;
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
>   static int cxl_flit_size(struct pci_dev *pdev)
>   {
>   	if (cxl_pci_flit_256(pdev))
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0ef8c2068c0c..664f532cc838 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -153,7 +153,7 @@ static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
>   	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>   
>   	device_lock(&pdev->dev);
> -	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
> +	vote = cxl_error_detected(&pdev->dev);
>   	*result = cxl_merge_result(*result, vote);
>   	device_unlock(&pdev->dev);
>   
> @@ -223,7 +223,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>   	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>   
>   	if (err_info->severity == AER_CORRECTABLE)
> -		cxl_cor_error_detected(pdev);
> +		cxl_cor_error_detected(dev);
>   	else
>   		cxl_do_recovery(pdev);
>   
> @@ -244,6 +244,8 @@ static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>   static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>   {
>   	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct device *cxlmd_dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>   
>   	if (!pdev) {
>   		pr_err("Failed to find the CXL device\n");
> @@ -260,15 +262,13 @@ static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>   
>   	if (err_info->severity == AER_CORRECTABLE) {
>   		int aer = pdev->aer_cap;
> -		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>   
>   		if (aer)
>   			pci_clear_and_set_config_dword(pdev,
>   						       aer + PCI_ERR_COR_STATUS,
>   						       0, PCI_ERR_COR_INTERNAL);
>   
> -		cxl_cor_error_detected(pdev);
> +		cxl_cor_error_detected(&pdev->dev);
>   
>   		pcie_clear_device_status(pdev);
>   	} else {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 73be66ef36a2..6fd9a42eb304 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -11,6 +11,7 @@
>   #include <linux/log2.h>
>   #include <linux/node.h>
>   #include <linux/io.h>
> +#include <linux/pci.h>
>   
>   extern const struct nvdimm_security_ops *cxl_security_ops;
>   
> @@ -797,6 +798,9 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
>   }
>   int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>   
> +void cxl_cor_error_detected(struct device *dev);
> +pci_ers_result_t cxl_error_detected(struct device *dev);
> +
>   /**
>    * struct cxl_endpoint_dvsec_info - Cached DVSEC info
>    * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 6f1396ef7b77..a572c57c6c63 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -133,7 +133,7 @@ struct cxl_dev_state;
>   int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>   			struct cxl_endpoint_dvsec_info *info);
>   void read_cdat_data(struct cxl_port *port);
> -void cxl_cor_error_detected(struct pci_dev *pdev);
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state);
> +void pci_cor_error_detected(struct pci_dev *pdev);
> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
> +				    pci_channel_state_t error);
>   #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 785aa2af5eaa..2b948e94bc97 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1112,11 +1112,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
>   	}
>   }
>   
> -static const struct pci_error_handlers cxl_error_handlers = {
> -	.error_detected	= cxl_error_detected,
> +static const struct pci_error_handlers pci_error_handlers = {
> +	.error_detected = pci_error_detected,
>   	.slot_reset	= cxl_slot_reset,
>   	.resume		= cxl_error_resume,
> -	.cor_error_detected	= cxl_cor_error_detected,
> +	.cor_error_detected	= pci_cor_error_detected,
>   	.reset_done	= cxl_reset_done,
>   };
>   
> @@ -1124,7 +1124,7 @@ static struct pci_driver cxl_pci_driver = {
>   	.name			= KBUILD_MODNAME,
>   	.id_table		= cxl_mem_pci_tbl,
>   	.probe			= cxl_pci_probe,
> -	.err_handler		= &cxl_error_handlers,
> +	.err_handler		= &pci_error_handlers,
>   	.dev_groups		= cxl_rcd_groups,
>   	.driver	= {
>   		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


