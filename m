Return-Path: <linux-pci+bounces-35409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA5AB42CC8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 00:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6507C64BA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 22:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688023A98E;
	Wed,  3 Sep 2025 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdofzlLm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA833E7;
	Wed,  3 Sep 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938646; cv=none; b=Kf0tRCjwmPDbpKMR7gKoGaMRgdzWX+I/+NkCMSI4i24uPuVqxZC3VjI68BQspjwf+VxfITvmOxRx0r8VH2BqEVStqRuOZfdyPhFdUJzUOYmVHSYyIvJPvB5zZFm9eK5CyyPMopSOnZ3fmLnTY3qV9Exon/JywOvfT79S82hRaJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938646; c=relaxed/simple;
	bh=wT0acTdXG8ar1RP1Irfs6y+vc9K+qRE+pEMd+EneUPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUjX9GtcHcj8Z6FGr054XMEBoAbTbysL04t7j2y2o9rLaNS4m3Ml5yEmf6NRcoYa6XKTgC/rhRKS5wWI/weSz+4r7x7iLBWA9K7jbxzEtCYzhGAXTGZdZXQk25VDT8PRdSNi3wg9vDkiza9mmdyPsA+KsTfRMpgB8zWH7fgncQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdofzlLm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756938644; x=1788474644;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wT0acTdXG8ar1RP1Irfs6y+vc9K+qRE+pEMd+EneUPw=;
  b=HdofzlLmMixhoV+TOGSVhTrWu7aG2lY6iMf1/kXiVFdaCa+YLp3yKzIw
   ZFDN35xJZay/y7QNJVQeRQtl3f47I30hJh85PAzo0J/BuqcLaGTG3nX9T
   +ZJUBzeifAvpPm5pO0H1Q9eQhjetaE1pQsFT/Iw2ewMeZSmfEc7Rqu7S7
   h1zIhNCcphz/47QvXMYDvS9EVBRaqsTYj1SkdoAR0HsW+lhRdQAyOvW75
   bALuzJg2r7feXXqtMwZtqtdEkPeRtL3lEZ/f+tNAmknRVALxQX5+6F9WF
   C8LdiVr95TruvEFSFXAYmXSiCHaRUGXNkikZqspMZouH19f2CsGd8keF3
   Q==;
X-CSE-ConnectionGUID: XWZBUw16RSW8r37khmPYLQ==
X-CSE-MsgGUID: t5zW2NQ/THO8ywtWb78oGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="58300567"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="58300567"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 15:30:43 -0700
X-CSE-ConnectionGUID: 431Tpw+jRP6myCs40tbZ5A==
X-CSE-MsgGUID: s/H2LROrSJWGSbBQlZxG9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="175854278"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.251]) ([10.125.109.251])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 15:30:41 -0700
Message-ID: <7a59101b-4ccd-4d86-b97b-21602ebcd1a5@intel.com>
Date: Wed, 3 Sep 2025 15:30:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 21/23] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-22-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-22-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
> handling. Follow similar design as found in PCIe error driver,
> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
> 
> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
> CXL ports instead. This will iterate through the CXL topology from the
> erroring device through the downstream CXL Ports and Endpoints.
> 
> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> Changes in v10->v11:
> - pci_ers_merge_results() - Move to earlier patch
> ---
>  drivers/cxl/core/port.c |  1 +
>  drivers/cxl/core/ras.c  | 94 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h       |  2 -
>  include/linux/aer.h     |  2 +
>  4 files changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 758fb73374c1..085c8620a797 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1347,6 +1347,7 @@ struct cxl_port *find_cxl_port(struct device *dport_dev,
>  	port = __find_cxl_port(&ctx);
>  	return port;
>  }
> +EXPORT_SYMBOL_NS_GPL(find_cxl_port, "CXL");
>  
>  static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
>  					 struct device *dport_dev,
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 536ca9c815ce..3da675f72616 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -6,6 +6,7 @@
>  #include <cxl/event.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
> +#include <cxl.h>
>  #include "trace.h"
>  
>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> @@ -468,8 +469,101 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>  
> +static int cxl_report_error_detected(struct device *dev, void *data)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	pci_ers_result_t vote, *result = data;
> +
> +	guard(device)(dev);
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
> +		vote = cxl_error_detected(dev);
> +	else
> +		vote = cxl_port_error_detected(dev);
> +
> +	vote = cxl_error_detected(dev);
> +	*result = pci_ers_merge_result(*result, vote);
> +
> +	return 0;
> +}
> +
> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
> +{
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->parent_dport->dport_dev == dport_dev;
> +}
> +
> +static void cxl_walk_port(struct device *port_dev,
> +			  int (*cb)(struct device *, void *),
> +			  void *userdata)
> +{
> +	struct cxl_dport *dport = NULL;
> +	struct cxl_port *port;
> +	unsigned long index;
> +
> +	if (!port_dev)
> +		return;
> +
> +	port = to_cxl_port(port_dev);
> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
> +		cb(port->uport_dev, userdata);
> +
> +	xa_for_each(&port->dports, index, dport)
> +	{
> +		struct device *child_port_dev __free(put_device) =
> +			bus_find_device(&cxl_bus_type, &port->dev, dport,
> +					match_port_by_parent_dport);
> +
> +		cb(dport->dport_dev, userdata);
> +
> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
> +	}
> +
> +	if (is_cxl_endpoint(port))
> +		cb(port->uport_dev->parent, userdata);
> +}
> +
>  static void cxl_do_recovery(struct device *dev)
>  {
> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		port = find_cxl_port(&pdev->dev, &dport);
> +	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> +		struct device *port_dev = bus_find_device(&cxl_bus_type, NULL,
> +							  &pdev->dev, match_uport);
> +		port = to_cxl_port(port_dev);
> +	}

Do we not attempt recovery if the device is an endpoint? Is it because it is handled directly by AER callback of the cxl_pci driver? Should endpoint error just not be forwarded from the AER kfifo producer instead of being checked on the consumer end after going through the kfifo mechanism?

DJ

> +
> +	if (!port)
> +		return;
> +
> +	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (cxl_error_is_native(pdev)) {
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
> +	put_device(&port->dev);
>  }
>  
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 69ff7c2d214f..0c4f73dd645f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1170,13 +1170,11 @@ static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
>  
>  #ifdef CONFIG_CXL_RAS
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> -bool cxl_error_is_native(struct pci_dev *dev);
>  bool is_internal_error(struct aer_err_info *info);
>  bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
>  void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
>  #else
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
> -static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
>  static inline bool is_internal_error(struct aer_err_info *info) { return false; }
>  static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
>  static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 1f79f0be4bf7..751a026fea73 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -81,10 +81,12 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
>  void cxl_register_proto_err_work(struct work_struct *work);
>  void cxl_unregister_proto_err_work(void);
> +bool cxl_error_is_native(struct pci_dev *dev);
>  #else
>  static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
>  static inline void cxl_register_proto_err_work(struct work_struct *work) { }
>  static inline void cxl_unregister_proto_err_work(void) { }
> +static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,


