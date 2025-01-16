Return-Path: <linux-pci+bounces-19942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33750A131B1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 04:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C00165867
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 03:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E8643AA9;
	Thu, 16 Jan 2025 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="clNW4bCK"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96A225D6;
	Thu, 16 Jan 2025 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736997377; cv=pass; b=rC78KY/v4ws34FOtyAHwTkmQ0BszlEKyVh78y4g2UR3IERxX+lQFcfifqwshscqOhJxUDvPUGzIuF9fyrUQ2usnduvR1f8WxF11kTWO2r3AeH6weIgoMhEW6XsAgA9avcYBLiJ+TQyUbXjqND8FldtrrW4PVNKc/M8L6doGAGhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736997377; c=relaxed/simple;
	bh=YT4DWpboiLqJc3DyZhwkRZE8N6Nd0YAvfrfjhAXXFgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eXxeKK25o+MSXb4ZD/vGPOf3cRhgOYQhqv3BZa+r3C0LHsIx+O7qKqwTVU6ujvPW4B9ZBgqYn+QhxsgtUyMr4iFzWIjCOCjrYSLvVV8uCVfVL+7K8TGCdWGRjw8pYbkYYwplL0VeK2TOPMZPqbVMGheOZpOCCVHx5MEuYFQLtUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=clNW4bCK; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1736997355; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k8ZY7m7vO/pZ+K4AETX1xej0SRBZOt7rs0J72V9oc5MBsQTw7gSC19gBr8h3jm5leBpUfNkqYMafbc9DZU2rUmw8lk+UeZDfBJzw9B+L0gVJAaqVUHhNo7dMtH9ZxVVHPoHgbJ/2nfyB0KDDYulZXe8vUQU4P3S8PSXcB88M2Bo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736997355; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Y52p4lLj4d6UnrrUPgpPHpIBJnpbHBDCO5rztbsXad4=; 
	b=QHcGD/Ew7+RXvLBRZXsOz095NFmpq0AkohO7NoLpVeVjLCz0THzqvh8D8NtUAHVphQL10kBnQc/rikbQ/jk/gPBJjL1Jm8/q/wSPo6t2vbbCCYlO+2a7iZcPJ7kbLehsrXm+8swWORTSZshiS5E/vwvIpz7ka9cIP5l9V8e17Xc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736997355;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=Y52p4lLj4d6UnrrUPgpPHpIBJnpbHBDCO5rztbsXad4=;
	b=clNW4bCKQAMJfSRYU/5CiMrNfufQIYP7L3QKf56D63/n0KN40Zs7+cl7HJUFdT7i
	ujhjH52wGq5DynOwSwRP8xP5jT9h7DO6DCmHLzyGhW5maFFKEknYynoM6maNM7B9KfQ
	Ut/QZ3zc472jVaBPKwWRI5cO3GyckvIA6XNf7Kag=
Received: by mx.zohomail.com with SMTPS id 1736997353886830.4739045867353;
	Wed, 15 Jan 2025 19:15:53 -0800 (PST)
Message-ID: <a8950b91-3485-4dd5-9d84-7d3a3031b752@zohomail.com>
Date: Thu, 16 Jan 2025 11:15:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-6-terry.bowman@amd.com>
 <cb087065-f2f3-481c-84cf-aca2c5fd5ac4@zohomail.com>
 <708db61f-2a69-40a0-ab9a-0fdb889ff443@amd.com>
 <c7e6298c-ae12-4e86-a74b-8b3aea698772@zohomail.com>
 <5ad954c8-2254-4f45-8018-7fa345597ee2@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <5ad954c8-2254-4f45-8018-7fa345597ee2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270ba13d9fea777bbd077b5700000055626aae4bcc9e2c5809284d89a74e787bde1b98d36d1313a4:zu08011227746a5ccf1250e356e2de98660000a1990815f95997cfb291eff8096f0b5f6df4d2d8e2fd831a32:rf0801122dbe712b2e6fd64d8ec9b55f120000ac6e49c5084416ae6e0fb0d0f780d05db57b6014f245ddc3a1a6da7122a3f2:ZohoMail
X-ZohoMailClient: External

On 1/15/2025 10:39 PM, Bowman, Terry wrote:
>
>
> On 1/14/2025 7:18 PM, Li Ming wrote:
>> On 1/15/2025 3:29 AM, Bowman, Terry wrote:
>>> On 1/14/2025 12:54 AM, Li Ming wrote:
>>>> On 1/7/2025 10:38 PM, Terry Bowman wrote:
>>>>> The AER service driver supports handling Downstream Port Protocol Errors in
>>>>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>>>>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>>>>> mode.[1]
>>>>>
>>>>> CXL and PCIe Protocol Error handling have different requirements that
>>>>> necessitate a separate handling path. The AER service driver may try to
>>>>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>>>>> suitable for CXL PCIe Port devices because of potential for system memory
>>>>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>>>>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>>>>> Error handling does not panic the kernel in response to a UCE.
>>>>>
>>>>> Introduce a separate path for CXL Protocol Error handling in the AER
>>>>> service driver. This will allow CXL Protocol Errors to use CXL specific
>>>>> handling instead of PCIe handling. Add the CXL specific changes without
>>>>> affecting or adding functionality in the PCIe handling.
>>>>>
>>>>> Make this update alongside the existing Downstream Port RCH error handling
>>>>> logic, extending support to CXL PCIe Ports in VH mode.
>>>>>
>>>>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>>>>> config. Update is_internal_error()'s function declaration such that it is
>>>>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>>>>> or disabled.
>>>>>
>>>>> The uncorrectable error (UCE) handling will be added in a future patch.
>>>>>
>>>>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>>>> Upstream Switch Ports
>>>>>
>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>> ---
>>>>>  drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
>>>>>  1 file changed, 40 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>>> index f8b3350fcbb4..62be599e3bee 100644
>>>>> --- a/drivers/pci/pcie/aer.c
>>>>> +++ b/drivers/pci/pcie/aer.c
>>>>> @@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
>>>>>  	return true;
>>>>>  }
>>>>>  
>>>>> -#ifdef CONFIG_PCIEAER_CXL
>>>>> +static bool is_internal_error(struct aer_err_info *info)
>>>>> +{
>>>>> +	if (info->severity == AER_CORRECTABLE)
>>>>> +		return info->status & PCI_ERR_COR_INTERNAL;
>>>>>  
>>>>> +	return info->status & PCI_ERR_UNC_INTN;
>>>>> +}
>>>>> +
>>>>> +#ifdef CONFIG_PCIEAER_CXL
>>>>>  /**
>>>>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>>>>   * @dev: pointer to the pcie_dev data structure
>>>>> @@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>>>  	return (pcie_ports_native || host->native_aer);
>>>>>  }
>>>>>  
>>>>> -static bool is_internal_error(struct aer_err_info *info)
>>>>> -{
>>>>> -	if (info->severity == AER_CORRECTABLE)
>>>>> -		return info->status & PCI_ERR_COR_INTERNAL;
>>>>> -
>>>>> -	return info->status & PCI_ERR_UNC_INTN;
>>>>> -}
>>>>> -
>>>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>>  {
>>>>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>>>>> @@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>>  
>>>>>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>>  {
>>>>> -	/*
>>>>> -	 * Internal errors of an RCEC indicate an AER error in an
>>>>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>>>>> -	 * device driver.
>>>>> -	 */
>>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>>> -	    is_internal_error(info))
>>>>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>>> +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>>> +
>>>>> +	if (info->severity == AER_CORRECTABLE) {
>>>>> +		struct pci_driver *pdrv = dev->driver;
>>>>> +		int aer = dev->aer_cap;
>>>>> +
>>>>> +		if (aer)
>>>>> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>>>>> +					       info->status);
>>>>> +
>>>>> +		if (pdrv && pdrv->cxl_err_handler &&
>>>>> +		    pdrv->cxl_err_handler->cor_error_detected)
>>>>> +			pdrv->cxl_err_handler->cor_error_detected(dev);
>>>>>
>>>>> +		pcie_clear_device_status(dev);
>>>>> +	}
>>>>>  }
>>>>>  
>>>>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>>>> @@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
>>>>>  {
>>>>>  	bool handles_cxl = false;
>>>>>  
>>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>>> -	    pcie_aer_is_native(dev))
>>>>> +	if (!pcie_aer_is_native(dev))
>>>>> +		return false;
>>>>> +
>>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>>>  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>>>>> +	else
>>>>> +		handles_cxl = pcie_is_cxl_port(dev);
>>>> My understanding is if a cxl RP/USP/DSP is working on PCIe mode, they are also possible to expose a DVSEC ID 3(CXL r3.1 section 9.12.3). In such case, the AER handler should be pci_aer_handle_error() rather than cxl_handle_error().
>>>>
>>>> pcie_is_cxl_port() only checks if there is a DVSEC ID 3, but I think it should also check if the cxl port is working on CXL mode, does it make more sense?
>>>>
>>>>
>>>> Ming
>>> Hi Ming and Jonathan,
>>>
>>> RCH AER & RCH RAS are currently logged by the CXL driver's RCH handlers.
>>>
>>> If the recommended change is made then RCH RAS will not be logged and the
>>> user would miss CXL details about the alternate protocol training failure.
>>> Also, AER is not CXL required and as a result in some cases you would only
>>> have the RCEC forwarded UIE/CIE message logged by the AER driver without
>>> any other logging.
>>>
>>> Is there value in *not* logging CXL RAS for errors on an untrained RCH
>>> link? Isn't it more informative to log PCIe AER and CXL RAS in this case?
>>>
>>> Regards,
>>> Terry
>> Hi Terry,
>>
>>
>> I don't understand why the recommended change will influence RCH RAS handling, would you mind giving more details?
>>
>> My understanding is that above 'pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)' is used for RCH case.
>>
>> And the 'else' block is used for VH case, so just check if the cxl port is working on CXL mode in pcie_is_cxl_port() or adding an extra function to check it in the 'else' block. I think it will not change RCH AER & RAS handling, is it right? or do I miss other details?
>>
>>
>> Ming
> Hi Ming,
>
> You're recommending this example case is handled by pci_aer_handle_error() rather than cxl_handle_error(). Correct me if I misunderstood. And, I believe this should continue to be handled by cxl_handle_error(). There are 2 issues with the recommended approach that deserve to be mentioned.

I guess that what you thought is the recommended change using pci_aer_handle_error() to handle CXL RAS issues? If yes, it is not what I meant.

handles_cxl_errors() is used to distinguish if the errors is a CXL error or a PCIe error. if the returned value of handles_cxl_errors() is 'true', that means the error is a CXL error. Then invoking either cxl_handle_error() or pcie_aer_handle_error() depending on the returned value. I think no problem in this part.

handles_cxl_errors() is using pcie_is_cxl_port() to distinguish CXL errors for VH cases. the implementation of pcie_is_cxl_port() is only checking if there is a DVSEC ID 3 exposed on the CXL RP/DSP/USP. I think it is not enough.

For example, If a CXL device connected to a CXL RP, there is no problem, because the return value of handles_cxl_errors() will be 'true' then cxl_handle_error() will be invoked to handle the errors.

If a PCIe device connected to a CXL RP, the CXL RP is working on PCIe mode, the CXL RP is possible to expose a DVSEC ID 3[1]. If the CXL RP has a DVSEC ID 3 in the case, the return value of handles_cxl_errors() is also 'true' and also invoking cxl_handle_error() to handle the error, I thinks it is not right, the CXL RP is working on PCIe mode, the error should be a PCIe error, and it should be handled by pcie_aer_handle_error(). So my suggestion is about checking if the CXL RP/DSP/USP is working on CXL mode in pcie_is_cxl_port() for VH cases.


[1] CXL r3.1 - 9.12.3 Enumerating CXL RPs and DSPs

   "CXL root port or DSP connected to a PCIe device/switch may or may not expose theCXL DVSEC ID 3 and the CXL DVSEC ID 7 capability structures."

>
> First, the RCH Downstream Port (DP) is implemented as an RCRB and does not have a
> SBDF.[1] The RCH AER error is reported with the RCEC SBDF in the AER SRC_ID register.[2] The
> RCEC is used to find the RCH's handlers using a CXL unique procedure (see cxl_handle_error()).
>
> The logic in pci_aer_handle_error() operates on a 'struct pci_dev' type and pci_aer_handle_error() is not plumbed to support searching for the RCH handlers.
>
> Using pci_aer_handle_error would require significant changes to support a CXL RCH
> in addition to a PCIe device. These changes are already in cxl_handle_error().
>  
> Another issue to note is the CXL RAS information will (should) not be logged with this
> recommended change. pci_aer_handle_error is PCIe specific and is not aware of CXL RAS. As a result,pci_aer_handle_error() is not suited to log the CXL RAS.
>
> The example scenario was the RCH DP failed training. The user needs to know why training
> failed and these details are stored in the CXL RAS registers. Again, CXL RAS needs to be logged
> as well but CXL specific awareness shouldn't be added to pci_aer_handle_error().

For these two issues, handles_cxl_errors() is always using "pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)" for RCH cases. I believe no change on this part, the return value of handles_cxl_errors() will be 'true' as expected in the cases you mentioned, cxl_handle_error() will help to handle these errors.


Ming

>
> Terry
>
> [1] CXL r3.1 - 8.2 Memory Mapped Registers
> [2] CXL r3.1 - 12.2.1.1 RCH Downstream Port-detected Errors+
>>>>>  
>>>>>  	return handles_cxl;
>>>>>  }
>>>>> @@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
>>>>>  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>>>>>  static inline void cxl_handle_error(struct pci_dev *dev,
>>>>>  				    struct aer_err_info *info) { }
>>>>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>>>> +{
>>>>> +	return false;
>>>>> +}
>>>>>  #endif
>>>>>  
>>>>>  /**
>>>>> @@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>>  
>>>>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>>>  {
>>>>> -	cxl_handle_error(dev, info);
>>>>> -	pci_aer_handle_error(dev, info);
>>>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>>>> +		cxl_handle_error(dev, info);
>>>>> +	else
>>>>> +		pci_aer_handle_error(dev, info);
>>>>> +
>>>>>  	pci_dev_put(dev);
>>>>>  }
>>>>>  



