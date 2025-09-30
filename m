Return-Path: <linux-pci+bounces-37285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9EFBAE14F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5174A3B7449
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9331DE8AD;
	Tue, 30 Sep 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/k9kWUz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683CF1A9F94;
	Tue, 30 Sep 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250799; cv=none; b=YsL5+/x1XQCz6UKoIvzsrV+BV/jqUx9CMTf1N4N1LYIDUlSjXkAlv1R7AN4Ffj65bpssUL2/kfC02Vx7xmECH9LKMDK1Et/PcN2JLT6hAVADvYKcJHCwoMqssO/6qDwkKmO+H7CV/+3H7H2Ey6scPqvqHuJrTvr66sls+d3BRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250799; c=relaxed/simple;
	bh=IvXzJAPR2nD7hHU8ysmAhxuGN8VIYhoyaWGqDyqUN1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBqrd8iA4ByrXi7gEiRsx+smfJZiN5Y0nbVs0ZIHrtaG/Pl1VQ0DGQVtoWyw5MOxfDg3p1DfqakyHkhQpuWNRS5Qe3h9dqyFZeHjFZtSFy7qCEEhhIegOQlOpRvI68bSBnnWOA5YqEr1aOkxgQXKR7Z3yDBMDdeUiBwQejT+vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/k9kWUz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759250797; x=1790786797;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IvXzJAPR2nD7hHU8ysmAhxuGN8VIYhoyaWGqDyqUN1Y=;
  b=R/k9kWUzR8XUssG0tK34m4uJzzKIwhfcnW4u/kLdIHMqZoUJWI8va02W
   aHr8qwvNqOyDkpkzSxA2pzK8LL4r8nHffhxnqL0v3+XpdZb2lLVHssGpY
   ye4P2fe4Nbr5IqvNPvX4hAK2Xgzja/6a+VJNjQVmkgMi9UUE7NWgUfvJq
   d1XYcVVQX8DI5Kg7jRJaguTOCrH9UzAzQkq0hniTo9QNOFGHD9fzLETIT
   kJqBTv6E1RBVvmTx1qzHwdVZGIbJg/cNYxn+Cgu8Xf5Sh3+bjA4Yqo6rW
   WwkQNnRPpX+b0qJklVG+acJZN6V8O0akQA6WDZOi+tXSOj7BkC1XnnJ8l
   w==;
X-CSE-ConnectionGUID: H0hTGtFJQK2dmA68dwxW1Q==
X-CSE-MsgGUID: mE7lhQQ5SH2Xu5mS6D+xrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65371264"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="65371264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:46:36 -0700
X-CSE-ConnectionGUID: zRX1aw9+RGGZ4bzJCB3dqw==
X-CSE-MsgGUID: 2fN6JuZJQwK4mA5Y4C/QSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178147602"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.162]) ([10.125.109.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 09:46:35 -0700
Message-ID: <ab001a63-47e4-4d85-b536-8103835a5b39@intel.com>
Date: Tue, 30 Sep 2025 09:46:34 -0700
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
 <5706b8ca-6046-4f96-a93b-8dd677494352@intel.com>
 <20351ea0-4bb7-4b5e-b097-42ef145dea68@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20351ea0-4bb7-4b5e-b097-42ef145dea68@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/30/25 9:43 AM, Bowman, Terry wrote:
> 
> 
> On 9/30/2025 11:13 AM, Dave Jiang wrote:
>>
>> On 9/30/25 7:38 AM, Bowman, Terry wrote:
>>>
>>> On 9/29/2025 7:26 PM, Dave Jiang wrote:
>>>> On 9/25/25 3:34 PM, Terry Bowman wrote:
>>>>> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
>>>>> handling. Follow similar design as found in PCIe error driver,
>>>>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>>>>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>>>>
>>>>> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
>>>>> CXL ports instead. This will iterate through the CXL topology from the
>>>>> erroring device through the downstream CXL Ports and Endpoints.
>>>>>
>>>>> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
>>>>>
>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>>
>>>>> ---
>>>>>
>>>>> Changes in v11->v12:
>>>>> - Cleaned up port discovery in cxl_do_recovery() (Dave)
>>>>> - Added PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
>>>>>
>>>>> Changes in v10->v11:
>>>>> - pci_ers_merge_results() - Move to earlier patch
>>>>> ---
>>>>>  drivers/cxl/core/ras.c | 111 +++++++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 111 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>>> index 7e8d63c32d72..45f92defca64 100644
>>>>> --- a/drivers/cxl/core/ras.c
>>>>> +++ b/drivers/cxl/core/ras.c
>>>>> @@ -443,8 +443,119 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>>>>  }
>>>>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>>>>  
>>>>> +static int cxl_report_error_detected(struct device *dev, void *data)
>>>>> +{
>>>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>>>> +	pci_ers_result_t vote, *result = data;
>>>>> +
>>>>> +	guard(device)(dev);
>>>>> +
>>>>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>>>>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>>>>> +		if (!cxl_pci_drv_bound(pdev))
>>>>> +			return 0;
>>>>> +
>>>>> +		vote = cxl_error_detected(dev);
>>>>> +	} else {
>>>>> +		vote = cxl_port_error_detected(dev);
>>>>> +	}
>>>>> +
>>>>> +	*result = pci_ers_merge_result(*result, vote);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
>>>>> +{
>>>>> +	struct cxl_port *port;
>>>>> +
>>>>> +	if (!is_cxl_port(dev))
>>>>> +		return 0;
>>>>> +
>>>>> +	port = to_cxl_port(dev);
>>>>> +
>>>>> +	return port->parent_dport->dport_dev == dport_dev;
>>>>> +}
>>>>> +
>>>>> +static void cxl_walk_port(struct device *port_dev,
>>>>> +			  int (*cb)(struct device *, void *),
>>>>> +			  void *userdata)
>>>>> +{
>>>>> +	struct cxl_dport *dport = NULL;
>>>>> +	struct cxl_port *port;
>>>>> +	unsigned long index;
>>>>> +
>>>>> +	if (!port_dev)
>>>>> +		return;
>>>>> +
>>>>> +	port = to_cxl_port(port_dev);
>>>>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>>>>> +		cb(port->uport_dev, userdata);
>>>> Could use some comments on what is being walked. Also an explanation of what is happening here would be good.
>>> Ok
>>>> If this is an endpoint port, this would be the PCI endpoint device.
>>>> If it's a switch port, then this is the upstream port.
>>>> If it's a root port, this is skipped.
>>>>
>>>>> +
>>>>> +	xa_for_each(&port->dports, index, dport)
>>>>> +	{
>>>>> +		struct device *child_port_dev __free(put_device) =
>>>>> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
>>>>> +					match_port_by_parent_dport);
>>>>> +
>>>>> +		cb(dport->dport_dev, userdata);
>>>> This is going through all the downstream ports
>>>>> +
>>>>> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
>>>>> +	}
>>>>> +
>>>>> +	if (is_cxl_endpoint(port))
>>>>> +		cb(port->uport_dev->parent, userdata);
>>>> And this is the downstream parent port of the endpoint device
>>>>
>>>> Why not move this before the xa_for_each() and return early? endpoint ports don't have dports, no need to even try to run that block above.
>>> Sure, I'll change that.
>>>> So in the current implementation,
>>>> 1. Endpoint. It checks the device, and then it checks the downstream parent port for errors. Is checking the parent dport necessary?
>>>> 2. Switch. It checks the upstream port, then it checks all the downstream ports for errors.
>>>> 3. Root port. It checks all the downstream ports for errors.
>>>> Is this the correct understanding of what this function does?
>>> Yes. The ordering is different as you pointed out. I can move the endpoint 
>>> check earlier with an early return. 
>> As the endpoint, what is the reason the check the parent dport? Pardon my ignorance.
> 
> There is none. An endpoint port will not have downstream ports.

parent dport. It would be the root port or the switch downstream port. This is what the current code is doing:

>>>>> +	if (is_cxl_endpoint(port))
>>>>> +		cb(port->uport_dev->parent, userdata);

DJ

  
> 
>>>>> +}
>>>>> +
>>>>>  static void cxl_do_recovery(struct device *dev)
>>>>>  {
>>>>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>>>> +	struct cxl_port *port = NULL;
>>>>> +
>>>>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>>>>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>>>>> +		struct cxl_dport *dport;
>>>>> +		struct cxl_port *rp_port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>>>>> +
>>>>> +		port = rp_port;
>>>>> +
>>>>> +	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>>>>> +		struct cxl_port *us_port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>>>>> +
>>>>> +		port = us_port;
>>>>> +
>>>>> +	} else	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>>>>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>>>>> +		struct cxl_dev_state *cxlds;
>>>>> +
>>>>> +		if (!cxl_pci_drv_bound(pdev))
>>>>> +			return;
>>>> Need to have the pci dev lock before checking driver bound.
>>>> DJ
>>> Ok, I'll try to add that into cxl_pci_drv_bound(). Terry
>> Do you need the lock beyond just checking the driver data? Maybe do it outside cxl_pci_drv_bound(). I would have an assert in the function though to ensure lock is held when calling this function.
> 
> Ok, good idea.
> 
> Terry
>> DJ
>>>>> +
>>>>> +		cxlds = pci_get_drvdata(pdev);
>>>>> +		port = cxlds->cxlmd->endpoint;
>>>>> +	}
>>>>> +
>>>>> +	if (!port) {
>>>>> +		dev_err(dev, "Failed to find the CXL device\n");
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
>>>>> +	if (status == PCI_ERS_RESULT_PANIC)
>>>>> +		panic("CXL cachemem error.");
>>>>> +
>>>>> +	/*
>>>>> +	 * If we have native control of AER, clear error status in the device
>>>>> +	 * that detected the error.  If the platform retained control of AER,
>>>>> +	 * it is responsible for clearing this status.  In that case, the
>>>>> +	 * signaling device may not even be visible to the OS.
>>>>> +	 */
>>>>> +	if (cxl_error_is_native(pdev)) {
>>>>> +		pcie_clear_device_status(pdev);
>>>>> +		pci_aer_clear_nonfatal_status(pdev);
>>>>> +		pci_aer_clear_fatal_status(pdev);
>>>>> +	}
>>>>>  }
>>>>>  
>>>>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>>
> 


