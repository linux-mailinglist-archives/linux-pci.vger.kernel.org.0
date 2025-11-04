Return-Path: <linux-pci+bounces-40301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAABC3367E
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 00:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35CD34EBA75
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C4E347FF0;
	Tue,  4 Nov 2025 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dT38Nbxk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09651347FE4;
	Tue,  4 Nov 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299580; cv=none; b=JXT+JgZXemlge3B3sr5kiaEY0yHG6cK7U6xXaVzekPXnQSt972X0ymELKWuwPS9+uEZm6GSD0GNaib95EwHYl5xpMVZEfiwkoyOjjVqKGJ7E+W54DeZCUo2Bo3yHcAbLeDGKBgn/aaiqkvOyhpRA6rbVOuhXYD8BSZkvmr3nRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299580; c=relaxed/simple;
	bh=ngSWtS+7t7YeDDelZmLGDkmDvHQs35IKcq0WhDg97t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwSltpJlCJ7fgkp7kqqmWWZuHARcBCnFx5TBGfgdzw8Yr24tf83lvFVx4EKNkvDJrXhXwBfDLVZQd66e/xpvuWXzRXuXOPy+gDJFz1euEGB5c4VTXSHR2PS0pET0KVWcDUu5hoRvBLM2TB0mKXqcHG14UtTM/LTvYe2MeNn9PxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dT38Nbxk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762299578; x=1793835578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ngSWtS+7t7YeDDelZmLGDkmDvHQs35IKcq0WhDg97t4=;
  b=dT38NbxkiGbAYguISil7yx77Qgv+PKWi3LTz+rECvd8nh8SUeR9DPEwA
   9YfIxJquXVHBEpmtWARxGYd3fDLXJCr9DO+klNhX+fx0Uh7lM2N+1M7xE
   kakNyMYj9XFMhJjU9j+40683npSOglBHYDUnwUO79APsgNciDOdZLL3e4
   3HzppSEA4mQ5sNbBHCIwavgi4iQN2xo/9ZFl7Crq/+WHt+PweI0AWYOxP
   IgKlYG971Zotsmf3MKg8Tqg3UagHPIFUZ3WG+QHS+RLBwaKJINwtEWpjE
   2psJ2FM6C782aR80681lzIJLOEHR5a5FX+SRwl/ZwPK8soBBXHkbMGgXy
   Q==;
X-CSE-ConnectionGUID: 7BT8hNfCS3Wv3cd5hVKKJA==
X-CSE-MsgGUID: OUo8TTzCSCqo2cQkLhjkUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64437913"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="64437913"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:39:37 -0800
X-CSE-ConnectionGUID: COpyCtZmShyX7qdMSvkFQw==
X-CSE-MsgGUID: 3PzKnvF3SfaiQPHca9eOcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="187238158"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:39:36 -0800
Message-ID: <848c69cd-297a-4c6b-9411-3dfa1fb3a259@intel.com>
Date: Tue, 4 Nov 2025 16:39:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 20/25] CXL/PCI: Introduce CXL Port protocol error
 handlers
To: "Bowman, Terry" <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-21-terry.bowman@amd.com>
 <5ed52253-a74d-4643-bdb6-a8d4852a9be7@intel.com>
 <f09df618-987e-4051-b5a2-fd9d2cef18e2@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <f09df618-987e-4051-b5a2-fd9d2cef18e2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 2:27 PM, Bowman, Terry wrote:
> 
> 
> On 11/4/2025 3:20 PM, Dave Jiang wrote:
>>
>> On 11/4/25 10:03 AM, Terry Bowman wrote:
>>> Add CXL protocol error handlers for CXL Port devices (Root Ports,
>>> Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
>>> and cxl_port_error_detected() to handle correctable and uncorrectable errors
>>> respectively.
>>>
>>> Introduce cxl_get_ras_base() to retrieve the cached RAS register base
>>> address for a given CXL port. This function supports CXL Root Ports,
>>> Downstream Ports, and Upstream Ports by returning their previously mapped
>>> RAS register addresses.
>>>
>>> Add device lock assertions to protect against concurrent device or RAS
>>> register removal during error handling. The port error handlers require
>>> two device locks:
>>>
>>> 1. The port's CXL parent device - RAS registers are mapped using devm_*
>>>    functions with the parent port as the host. Locking the parent prevents
>>>    the RAS registers from being unmapped during error handling.
>>>
>>> 2. The PCI device (pdev->dev) - Locking prevents concurrent modifications
>>>    to the PCI device structure during error handling.
>>>
>>> The lock assertions added here will be satisfied by device locks introduced
>>> in a subsequent patch.
>>>
>>> Introduce get_pci_cxl_host_dev() to return the device responsible for
>>> managing the RAS register mapping. This function increments the reference
>>> count on the host device to prevent premature resource release during error
>>> handling. The caller is responsible for decrementing the reference count.
>>> For CXL endpoints, which manage resources without a separate host device,
>>> this function returns NULL.
>>>
>>> Update the AER driver's is_cxl_error() to recognize CXL Port devices in
>>> addition to CXL Endpoints, as both now have CXL-specific error handlers.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>
>>> ---
>>>
>>> Changes in v12->v13:
>>> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>>>   patch (Terry)
>>> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
>>> - Remove check for dport->dport_dev (Dave)
>>> - Remove whitespace (Terry)
>>>
>>> Changes in v11->v12:
>>> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>>>   pci_to_cxl_dev()
>>> - Change cxl_error_detected() -> cxl_cor_error_detected()
>>> - Remove NULL variable assignments
>>> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>>>   port searches.
>>>
>>> Changes in v10->v11:
>>> - None
>>> ---
>>>  drivers/cxl/core/core.h       | 10 +++++++
>>>  drivers/cxl/core/port.c       |  7 ++---
>>>  drivers/cxl/core/ras.c        | 49 +++++++++++++++++++++++++++++++++++
>>>  drivers/pci/pcie/aer_cxl_vh.c |  5 +++-
>>>  4 files changed, 67 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>> index b2c0ccd6803f..046ec65ed147 100644
>>> --- a/drivers/cxl/core/core.h
>>> +++ b/drivers/cxl/core/core.h
>>> @@ -157,6 +157,8 @@ void cxl_cor_error_detected(struct device *dev);
>>>  pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>>>  				    pci_channel_state_t error);
>>>  void pci_cor_error_detected(struct pci_dev *pdev);
>>> +pci_ers_result_t cxl_port_error_detected(struct device *dev);
>>> +void cxl_port_cor_error_detected(struct device *dev);
>>>  #else
>>>  static inline int cxl_ras_init(void)
>>>  {
>>> @@ -176,6 +178,11 @@ static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>>>  	return PCI_ERS_RESULT_NONE;
>>>  }
>>>  static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
>>> +static inline void cxl_port_cor_error_detected(struct device *dev) { }
>>> +static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
>>> +{
>>> +	return PCI_ERS_RESULT_NONE;
>>> +}
>>>  #endif /* CONFIG_CXL_RAS */
>>>  
>>>  /* Restricted CXL Host specific RAS functions */
>>> @@ -190,6 +197,9 @@ static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>>>  #endif /* CONFIG_CXL_RCH_RAS */
>>>  
>>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>>> +			       struct cxl_dport **dport);
>>> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>>>  
>>>  struct cxl_hdm;
>>>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index b70e1b505b5c..d060f864cf2e 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -1360,8 +1360,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>>>  	return NULL;
>>>  }
>>>  
>>> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
>>> -				      struct cxl_dport **dport)
>>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>>> +			       struct cxl_dport **dport)
>>>  {
>>>  	struct cxl_find_port_ctx ctx = {
>>>  		.dport_dev = dport_dev,
>>> @@ -1564,7 +1564,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>>>   * Function takes a device reference on the port device. Caller should do a
>>>   * put_device() when done.
>>>   */
>>> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>>  {
>>>  	struct device *dev;
>>>  
>>> @@ -1573,6 +1573,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>>  		return to_cxl_port(dev);
>>>  	return NULL;
>>>  }
>>> +EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");
>>>  
>>>  static int update_decoder_targets(struct device *dev, void *data)
>>>  {
>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>> index beb142054bda..142ca8794107 100644
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> @@ -145,6 +145,39 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>>>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>>>  }
>>>  
>>> +static void __iomem *cxl_get_ras_base(struct device *dev)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>> +
>>> +	switch (pci_pcie_type(pdev)) {
>>> +	case PCI_EXP_TYPE_ROOT_PORT:
>>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>>> +	{
>>> +		struct cxl_dport *dport;
>>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>>> +
>>> +		if (!dport) {
>>> +			pci_err(pdev, "Failed to find the CXL device");
>>> +			return NULL;
>>> +		}
>>> +		return dport->regs.ras;
>> The RAS MMIO mapping is done via devm_cxl_iomap_block() and is a devres against the device. Without holding the device lock, the port driver can unbind and the address mapping may go away in the middle or before cxl_handle_cor_ras()/cxl_handle_ras() being called. I think you'll have to hold the port lock here and make sure that the port driver is bound before reading the RAS register? I think the dport ras should be covered under the port umbrella.
>>
>>> +	}
>>> +	case PCI_EXP_TYPE_UPSTREAM:
>>> +	{
>>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>>> +
>>> +		if (!port) {
>>> +			pci_err(pdev, "Failed to find the CXL device");
>>> +			return NULL;
>>> +		}
>>> +		return port->uport_regs.ras;
>> same here
>>
>> DJ> +	}
> 
> 
> The cxl_port parent of the reported devices are locked previously. Locking is added in the CE case in the next patch.
> and the UCE locking is in patch23. Locking logic is all made ASAP after after dequeueing.

Ok I see them.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Terry
> 
>>> +	}
>>> +
>>> +	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>>> +	return NULL;
>>> +}
>>> +
>>>  /**
>>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>>   * @dport: the cxl_dport that needs to be initialized
>>> @@ -254,6 +287,22 @@ pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ra
>>>  	return PCI_ERS_RESULT_PANIC;
>>>  }
>>>  
>>> +void cxl_port_cor_error_detected(struct device *dev)
>>> +{
>>> +	void __iomem *ras_base = cxl_get_ras_base(dev);
>>> +
>>> +	cxl_handle_cor_ras(dev, 0, ras_base);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_port_cor_error_detected, "CXL");
>>> +
>>> +pci_ers_result_t cxl_port_error_detected(struct device *dev)
>>> +{
>>> +	void __iomem *ras_base = cxl_get_ras_base(dev);
>>> +
>>> +	return cxl_handle_ras(dev, 0, ras_base);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_port_error_detected, "CXL");
>>> +
>>>  void cxl_cor_error_detected(struct device *dev)
>>>  {
>>>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
>>> index 5dbc81341dc4..25f9512b57f7 100644
>>> --- a/drivers/pci/pcie/aer_cxl_vh.c
>>> +++ b/drivers/pci/pcie/aer_cxl_vh.c
>>> @@ -43,7 +43,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>>>  	if (!info || !info->is_cxl)
>>>  		return false;
>>>  
>>> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
>>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
>>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
>>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
>>>  		return false;
>>>  
>>>  	return is_internal_error(info);
> 


