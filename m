Return-Path: <linux-pci+bounces-37276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDB6BAE06B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC4D166B65
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A94296BD0;
	Tue, 30 Sep 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1++i4u2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF57A4501A;
	Tue, 30 Sep 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248833; cv=none; b=uzNuJarV/WkxHY8U6nGanWSaROnF5hCrmDCdbrX8UzrsuOZSYkWYGm358QAx99qZhaEfaAYE9AuKQM1O5GCP6XMrhWnU6BqMCNbBCbEdDWjwt1i901FRP3l6xbSNBl/DJIUZNYV2rNDl5lT1yl3yBdTMMlBjoK89LTMg/vn4syk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248833; c=relaxed/simple;
	bh=5+T6dQJkhqnXsd8OU+/4OXe2jUb92hyssTPkFheuZf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hL9tWOI+zXOh24k/ac1z4pc4KV1yUjGSUfxDas9lhFFAzRyXUfmUNBDI2haio3RmfFkjISHhLgrz8BCvbkQQIFp49pyBZN48h41b6Zstm0CYHj9JN2e2fnvbWQV6+gHDZR00ejd8vFuZmvXJGLPAvwMYqHgxNoA6OyEHCuyqHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1++i4u2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759248832; x=1790784832;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5+T6dQJkhqnXsd8OU+/4OXe2jUb92hyssTPkFheuZf4=;
  b=A1++i4u2CEy5eilh1uE0ELW/7qtCStAT8pGcQ8WmU5Wd9N/jgvzz3Qdj
   nKXzkodmcqD2JDo++UcTLPiGcvonkNoaxhQdhxcm1lermEe7EBUffj3Gb
   5cUwUsrrLr/mZKEeKZUzM3tSpUzCKeMV1Lto8atGJdLMA0JwDYmpmrvf0
   JOxcNkoUhrImr+XOAc2lFbMAEUM4fT8tGCmllq3mjFK8Cy+TKw4X51dBn
   VcefeUl1SfTPafoA2Adp0CB6m0I1Ls0wSscWoWtf2LwhYAe/KA38o/Qh6
   PyqK2mgX9paGPtNbUCMdat/fkXKSDO7Me4EcAAKds+JYcoS2JlqkxpAeH
   g==;
X-CSE-ConnectionGUID: q3f08OtGTICoqO1lIrzQlQ==
X-CSE-MsgGUID: OtYRpGkKRwKh49TD6mnyrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79162120"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="79162120"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:13:50 -0700
X-CSE-ConnectionGUID: LZTaY9RiSya9cIQd0xvE+w==
X-CSE-MsgGUID: k5JAID56SiKd4RsivZBBgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178975308"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.162]) ([10.125.109.162])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:13:48 -0700
Message-ID: <5706b8ca-6046-4f96-a93b-8dd677494352@intel.com>
Date: Tue, 30 Sep 2025 09:13:46 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: "Bowman, Terry" <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-24-terry.bowman@amd.com>
 <d3d3ab84-8cdd-4386-82dd-de8149159985@intel.com>
 <a2b5d6f0-7f6a-4ac3-b302-73fb3c1a92b2@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <a2b5d6f0-7f6a-4ac3-b302-73fb3c1a92b2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/30/25 7:38 AM, Bowman, Terry wrote:
> 
> 
> On 9/29/2025 7:26 PM, Dave Jiang wrote:
>>
>> On 9/25/25 3:34 PM, Terry Bowman wrote:
>>> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
>>> handling. Follow similar design as found in PCIe error driver,
>>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>>
>>> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
>>> CXL ports instead. This will iterate through the CXL topology from the
>>> erroring device through the downstream CXL Ports and Endpoints.
>>>
>>> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>
>>> ---
>>>
>>> Changes in v11->v12:
>>> - Cleaned up port discovery in cxl_do_recovery() (Dave)
>>> - Added PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
>>>
>>> Changes in v10->v11:
>>> - pci_ers_merge_results() - Move to earlier patch
>>> ---
>>>  drivers/cxl/core/ras.c | 111 +++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 111 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>> index 7e8d63c32d72..45f92defca64 100644
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> @@ -443,8 +443,119 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>>  }
>>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>>  
>>> +static int cxl_report_error_detected(struct device *dev, void *data)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>> +	pci_ers_result_t vote, *result = data;
>>> +
>>> +	guard(device)(dev);
>>> +
>>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>>> +		if (!cxl_pci_drv_bound(pdev))
>>> +			return 0;
>>> +
>>> +		vote = cxl_error_detected(dev);
>>> +	} else {
>>> +		vote = cxl_port_error_detected(dev);
>>> +	}
>>> +
>>> +	*result = pci_ers_merge_result(*result, vote);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
>>> +{
>>> +	struct cxl_port *port;
>>> +
>>> +	if (!is_cxl_port(dev))
>>> +		return 0;
>>> +
>>> +	port = to_cxl_port(dev);
>>> +
>>> +	return port->parent_dport->dport_dev == dport_dev;
>>> +}
>>> +
>>> +static void cxl_walk_port(struct device *port_dev,
>>> +			  int (*cb)(struct device *, void *),
>>> +			  void *userdata)
>>> +{
>>> +	struct cxl_dport *dport = NULL;
>>> +	struct cxl_port *port;
>>> +	unsigned long index;
>>> +
>>> +	if (!port_dev)
>>> +		return;
>>> +
>>> +	port = to_cxl_port(port_dev);
>>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>>> +		cb(port->uport_dev, userdata);
>> Could use some comments on what is being walked. Also an explanation of what is happening here would be good.
> Ok
>> If this is an endpoint port, this would be the PCI endpoint device.
>> If it's a switch port, then this is the upstream port.
>> If it's a root port, this is skipped.
>>
>>> +
>>> +	xa_for_each(&port->dports, index, dport)
>>> +	{
>>> +		struct device *child_port_dev __free(put_device) =
>>> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
>>> +					match_port_by_parent_dport);
>>> +
>>> +		cb(dport->dport_dev, userdata);
>> This is going through all the downstream ports
>>> +
>>> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
>>> +	}
>>> +
>>> +	if (is_cxl_endpoint(port))
>>> +		cb(port->uport_dev->parent, userdata);
>> And this is the downstream parent port of the endpoint device
>>
>> Why not move this before the xa_for_each() and return early? endpoint ports don't have dports, no need to even try to run that block above.
> Sure, I'll change that.
>> So in the current implementation,
>> 1. Endpoint. It checks the device, and then it checks the downstream parent port for errors. Is checking the parent dport necessary?
>> 2. Switch. It checks the upstream port, then it checks all the downstream ports for errors.
>> 3. Root port. It checks all the downstream ports for errors.
>> Is this the correct understanding of what this function does?
> 
> Yes. The ordering is different as you pointed out. I can move the endpoint 
> check earlier with an early return. 

As the endpoint, what is the reason the check the parent dport? Pardon my ignorance.

>>> +}
>>> +
>>>  static void cxl_do_recovery(struct device *dev)
>>>  {
>>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>> +	struct cxl_port *port = NULL;
>>> +
>>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>>> +		struct cxl_dport *dport;
>>> +		struct cxl_port *rp_port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>>> +
>>> +		port = rp_port;
>>> +
>>> +	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>>> +		struct cxl_port *us_port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>>> +
>>> +		port = us_port;
>>> +
>>> +	} else	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>>> +		struct cxl_dev_state *cxlds;
>>> +
>>> +		if (!cxl_pci_drv_bound(pdev))
>>> +			return;
>> Need to have the pci dev lock before checking driver bound.
>> DJ
> 
> Ok, I'll try to add that into cxl_pci_drv_bound(). Terry

Do you need the lock beyond just checking the driver data? Maybe do it outside cxl_pci_drv_bound(). I would have an assert in the function though to ensure lock is held when calling this function.

DJ
>>> +
>>> +		cxlds = pci_get_drvdata(pdev);
>>> +		port = cxlds->cxlmd->endpoint;
>>> +	}
>>> +
>>> +	if (!port) {
>>> +		dev_err(dev, "Failed to find the CXL device\n");
>>> +		return;
>>> +	}
>>> +
>>> +	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
>>> +	if (status == PCI_ERS_RESULT_PANIC)
>>> +		panic("CXL cachemem error.");
>>> +
>>> +	/*
>>> +	 * If we have native control of AER, clear error status in the device
>>> +	 * that detected the error.  If the platform retained control of AER,
>>> +	 * it is responsible for clearing this status.  In that case, the
>>> +	 * signaling device may not even be visible to the OS.
>>> +	 */
>>> +	if (cxl_error_is_native(pdev)) {
>>> +		pcie_clear_device_status(pdev);
>>> +		pci_aer_clear_nonfatal_status(pdev);
>>> +		pci_aer_clear_fatal_status(pdev);
>>> +	}
>>>  }
>>>  
>>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> 
> 


