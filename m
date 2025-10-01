Return-Path: <linux-pci+bounces-37357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7423BB1142
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 17:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791F02A18FB
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A81520468E;
	Wed,  1 Oct 2025 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVi3EI8t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F82149C7B;
	Wed,  1 Oct 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332796; cv=none; b=P+Q2nDcuaTt7AkXOdabh2csfJTnZR4rPKexTdEXKPhJcVhAwZ9pHp4ZDwLTQ/byAKrG7TMwMJG/X3nehSWCKjSxDIlNyzdHPZQLdT2Jh8ZZEdJiWHD7uBrFIueiUSzMBSMm9MUJuA2DniGfKiehMG22fsDi5BBdt50oD+U9528w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332796; c=relaxed/simple;
	bh=TrYKaRw4yvXUgtnQf5699OHD93E1imr3KHFSq9KfifA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jac0Wjz5ixODh2fxS+xul6a0VbPffm7nrFDLCOZEOSRanSluAm1fs9UmUPMvk5rA2ksEIwJ3Y9U7Ut2Mq25TBzZQ049D95G0Hwmoo22Z+TUQa+FpCfHHOM2YVQ3pz3SXaUDQ9N1j8u+NPUxcL5y0S/vpggaZUCA01s89/3txNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVi3EI8t; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759332794; x=1790868794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TrYKaRw4yvXUgtnQf5699OHD93E1imr3KHFSq9KfifA=;
  b=cVi3EI8twERN4rj1gdo+e9tiZ1QkucEdN0M2SnXKLoipYUW57nVlB2uW
   TquQw6gX8maHEESMcGPWZ175P0vbIm/TtkwxMxnTKNZoyN2cKA/Rx0pF3
   MZp75ZvV3vJowImUiXDGoMVMf4X6fzFTiGGhgQf9wFbk2DP07qFOpPu/p
   szviKGXSUYoASPGgLusgLDVs0g/XJwOmhSo2fz6IXbLsN97KjoU3o0wWF
   3tv1NbVlWgreld5GllBa/OePetOoq0W31F+VcFGPaS/P//H3mW2kWXMk2
   qqgSeKyb/PGwPjhQNNoqgqiUAO1CmYclBF+h/XnezrpR4lGsomc6AA6hv
   Q==;
X-CSE-ConnectionGUID: 47/6r68/QvKMpV6ksffbsA==
X-CSE-MsgGUID: E+zT5MhRQHq0Y1c0Hh4w/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60647127"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="60647127"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 08:33:13 -0700
X-CSE-ConnectionGUID: uDwDT4VUSL+tvyzdVe3ujg==
X-CSE-MsgGUID: O0kw/+RYSy+W2TMDSG4giA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="183995820"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.109.218]) ([10.125.109.218])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 08:33:12 -0700
Message-ID: <ea9c02b0-bcd4-4e22-a8bf-3477c82c595b@intel.com>
Date: Wed, 1 Oct 2025 08:33:11 -0700
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
 <ab001a63-47e4-4d85-b536-8103835a5b39@intel.com>
 <cf1a759f-5327-4e47-8632-23010b337983@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <cf1a759f-5327-4e47-8632-23010b337983@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/1/25 6:58 AM, Bowman, Terry wrote:
> 
> 
> On 9/30/2025 11:46 AM, Dave Jiang wrote:
>>
>> On 9/30/25 9:43 AM, Bowman, Terry wrote:
>>>
>>> On 9/30/2025 11:13 AM, Dave Jiang wrote:
>>>> On 9/30/25 7:38 AM, Bowman, Terry wrote:
>>>>> On 9/29/2025 7:26 PM, Dave Jiang wrote:
>>>>>> On 9/25/25 3:34 PM, Terry Bowman wrote:
>>>>>>> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
>>>>>>> handling. Follow similar design as found in PCIe error driver,
>>>>>>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>>>>>>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>>>>>>
>>>>>>> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
>>>>>>> CXL ports instead. This will iterate through the CXL topology from the
>>>>>>> erroring device through the downstream CXL Ports and Endpoints.
>>>>>>>
>>>>>>> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
>>>>>>>
>>>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>>>>
>>>>>>> ---
>>>>>>>
>>>>>>> Changes in v11->v12:
>>>>>>> - Cleaned up port discovery in cxl_do_recovery() (Dave)
>>>>>>> - Added PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
>>>>>>>
>>>>>>> Changes in v10->v11:
>>>>>>> - pci_ers_merge_results() - Move to earlier patch
>>>>>>> ---
>>>>>>>  drivers/cxl/core/ras.c | 111 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>  1 file changed, 111 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>>>>> index 7e8d63c32d72..45f92defca64 100644
>>>>>>> --- a/drivers/cxl/core/ras.c
>>>>>>> +++ b/drivers/cxl/core/ras.c
>>>>>>> @@ -443,8 +443,119 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>>>>>>  }
>>>>>>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>>>>>>  
>>>>>>> +static int cxl_report_error_detected(struct device *dev, void *data)
>>>>>>> +{
>>>>>>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>>>>>> +	pci_ers_result_t vote, *result = data;
>>>>>>> +
>>>>>>> +	guard(device)(dev);
>>>>>>> +
>>>>>>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>>>>>>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>>>>>>> +		if (!cxl_pci_drv_bound(pdev))
>>>>>>> +			return 0;
>>>>>>> +
>>>>>>> +		vote = cxl_error_detected(dev);
>>>>>>> +	} else {
>>>>>>> +		vote = cxl_port_error_detected(dev);
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	*result = pci_ers_merge_result(*result, vote);
>>>>>>> +
>>>>>>> +	return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
>>>>>>> +{
>>>>>>> +	struct cxl_port *port;
>>>>>>> +
>>>>>>> +	if (!is_cxl_port(dev))
>>>>>>> +		return 0;
>>>>>>> +
>>>>>>> +	port = to_cxl_port(dev);
>>>>>>> +
>>>>>>> +	return port->parent_dport->dport_dev == dport_dev;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void cxl_walk_port(struct device *port_dev,
>>>>>>> +			  int (*cb)(struct device *, void *),
>>>>>>> +			  void *userdata)
>>>>>>> +{
>>>>>>> +	struct cxl_dport *dport = NULL;
>>>>>>> +	struct cxl_port *port;
>>>>>>> +	unsigned long index;
>>>>>>> +
>>>>>>> +	if (!port_dev)
>>>>>>> +		return;
>>>>>>> +
>>>>>>> +	port = to_cxl_port(port_dev);
>>>>>>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>>>>>>> +		cb(port->uport_dev, userdata);
>>>>>> Could use some comments on what is being walked. Also an explanation of what is happening here would be good.
>>>>> Ok
>>>>>> If this is an endpoint port, this would be the PCI endpoint device.
>>>>>> If it's a switch port, then this is the upstream port.
>>>>>> If it's a root port, this is skipped.
>>>>>>
>>>>>>> +
>>>>>>> +	xa_for_each(&port->dports, index, dport)
>>>>>>> +	{
>>>>>>> +		struct device *child_port_dev __free(put_device) =
>>>>>>> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
>>>>>>> +					match_port_by_parent_dport);
>>>>>>> +
>>>>>>> +		cb(dport->dport_dev, userdata);
>>>>>> This is going through all the downstream ports
>>>>>>> +
>>>>>>> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	if (is_cxl_endpoint(port))
>>>>>>> +		cb(port->uport_dev->parent, userdata);
>>>>>> And this is the downstream parent port of the endpoint device
>>>>>>
>>>>>> Why not move this before the xa_for_each() and return early? endpoint ports don't have dports, no need to even try to run that block above.
>>>>> Sure, I'll change that.
>>>>>> So in the current implementation,
>>>>>> 1. Endpoint. It checks the device, and then it checks the downstream parent port for errors. Is checking the parent dport necessary?
>>>>>> 2. Switch. It checks the upstream port, then it checks all the downstream ports for errors.
>>>>>> 3. Root port. It checks all the downstream ports for errors.
>>>>>> Is this the correct understanding of what this function does?
>>>>> Yes. The ordering is different as you pointed out. I can move the endpoint 
>>>>> check earlier with an early return. 
>>>> As the endpoint, what is the reason the check the parent dport? Pardon my ignorance.
>>> There is none. An endpoint port will not have downstream ports.
>> parent dport. It would be the root port or the switch downstream port. This is what the current code is doing:
>>
>>>>>>> +	if (is_cxl_endpoint(port))
>>>>>>> +		cb(port->uport_dev->parent, userdata);
>> DJ
>>
>>   
> 
> Yes. I need to change port->uport_dev->parent to be port->uport_dev. Thanks. Terry

I believe your first chunk already covered the endpoint device:
>>>>>>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>>>>>>> +		cb(port->uport_dev, userdata);

So you can probably just drop the last chunk entirely. 


