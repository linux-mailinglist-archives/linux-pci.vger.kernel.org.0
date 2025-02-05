Return-Path: <linux-pci+bounces-20739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CCCA28D60
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 15:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695A116931E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1B15530B;
	Wed,  5 Feb 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Uq8gkxrK"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4713C9C4;
	Wed,  5 Feb 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763960; cv=pass; b=NA3K9l3Ss5aS1/tKtvsyKc96415zH0VPR7PY3QHtAO84MqtL6y+1iKyRFuosQGXApqIQ1Y0rgmp8z6vY+JpYHRvN/yKLeqXMaLNk6YLmnS2rEazaMnPUT/tHFKFqMEaBwAnZ40qlG8lXqGiDxUhvBDTMhcbbzNT97kZ29Oi+L+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763960; c=relaxed/simple;
	bh=6Iu92BHDCFXwJN6g5+K7+E57DlodDPTYA2Hj2/Qttnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oGIerBCCppDjNr2ZBtYO/BG0DdyJeg4tJlCjwI7jka5WM0WXndjMQvc7GXM1V8H0bN+U3qE7llziEByqJVRzsmqW4LbqFEv7hUmw1kxwgoTNwwKHyZKfU2vocsmJPEE6og/vg8ka0sC04Qy3bHV0rCMmaE3J2rMwGwVWhj3gb7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Uq8gkxrK; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1738763934; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eklh8eHKDNLf/vqQgqihdn1CvlezfldVegFxkH2s37DSsx+MUti0JgGbn4FAYrBfyD/3mCKHmlIqwVFPYr+UydMWpsQ3cFBPv4TvabJPuBdKx6th4IfLHMnG5mPVfnL8dEkSxVJ6Nm0onf6Q09dsl4vqtRTeuyTZVwtgRpOzK9U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738763934; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=/7RYgJ+3RIpz5fQSELyDgebzd34b0vMAOGvAqmVNtkM=; 
	b=AUtx+Mvs5dILkvYvW7FBUltBMyGWJllKX/2Qv5zj20h4g9Lre/b6ZBSPo+NfxAFh58w8IDx3Z46QgaQzWKdRvbLO2A7+EJcVdu5Tm+MDsgEWxg1VjrvR498WfHq69cZRBxdWmr75Ih+JfGJdK19n9czjCXpeIOMAqDpAiz5vfc8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738763934;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=/7RYgJ+3RIpz5fQSELyDgebzd34b0vMAOGvAqmVNtkM=;
	b=Uq8gkxrKGDWVn+T/LLsuKYJU8K8AVt3PWe7wIYPNkooO0rpDAYKpy/7fkWsVNcMa
	4yslpKxqUdLKdaLWXMd3eBzHOx3NMLGWOtggFgTFOobS4FGxEw0PwUlzE4zYgQDvdjj
	7QQeiTQ0vZbjv6YEujAwR/T/tHFgLpwmVUlInzPI=
Received: by mx.zohomail.com with SMTPS id 1738763929968554.257648413077;
	Wed, 5 Feb 2025 05:58:49 -0800 (PST)
Message-ID: <77f23d53-5bbb-451d-b1c5-272e016b77f4@zohomail.com>
Date: Wed, 5 Feb 2025 21:58:43 +0800
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
 <a8950b91-3485-4dd5-9d84-7d3a3031b752@zohomail.com>
 <2b9a8693-2218-4109-b20f-8a57618d9006@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <2b9a8693-2218-4109-b20f-8a57618d9006@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122746601602bddea034351a641b0000405049dd64a72fbbdcc45a9e03e4bb5a012dd1b9b79f1f1983:zu08011227db1a4905a8b39c340baf685900001cbdf679201615d329a596d664ad40a695e9e4c2d8bcbba1bf:rf0801122d311ec566a48d27fa29a2872b0000ec87bb57208d316add66c82aa12eec2d91d9979100f314c77605453581c9db:ZohoMail
X-ZohoMailClient: External

On 2/5/2025 11:46 AM, Bowman, Terry wrote:
>
> On 1/15/2025 9:15 PM, Li Ming wrote:
>> On 1/15/2025 10:39 PM, Bowman, Terry wrote:
>>> On 1/14/2025 7:18 PM, Li Ming wrote:
>>>> On 1/15/2025 3:29 AM, Bowman, Terry wrote:
>>>>> On 1/14/2025 12:54 AM, Li Ming wrote:
>>>>>> On 1/7/2025 10:38 PM, Terry Bowman wrote:
>>>>>>> The AER service driver supports handling Downstream Port Protocol Errors in
>>>>>>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>>>>>>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>>>>>>> mode.[1]
>>>>>>>
>>>>>>> CXL and PCIe Protocol Error handling have different requirements that
>>>>>>> necessitate a separate handling path. The AER service driver may try to
>>>>>>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>>>>>>> suitable for CXL PCIe Port devices because of potential for system memory
>>>>>>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>>>>>>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>>>>>>> Error handling does not panic the kernel in response to a UCE.
>>>>>>>
>>>>>>> Introduce a separate path for CXL Protocol Error handling in the AER
>>>>>>> service driver. This will allow CXL Protocol Errors to use CXL specific
>>>>>>> handling instead of PCIe handling. Add the CXL specific changes without
>>>>>>> affecting or adding functionality in the PCIe handling.
>>>>>>>
>>>>>>> Make this update alongside the existing Downstream Port RCH error handling
>>>>>>> logic, extending support to CXL PCIe Ports in VH mode.
>>>>>>>
>>>>>>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>>>>>>> config. Update is_internal_error()'s function declaration such that it is
>>>>>>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>>>>>>> or disabled.
>>>>>>>
>>>>>>> The uncorrectable error (UCE) handling will be added in a future patch.
>>>>>>>
>>>>>>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>>>>>> Upstream Switch Ports
>>>>>>>
>>>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>>>> ---
>>>>>>>  drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
>>>>>>>  1 file changed, 40 insertions(+), 21 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>>>>> index f8b3350fcbb4..62be599e3bee 100644
>>>>>>> --- a/drivers/pci/pcie/aer.c
>>>>>>> +++ b/drivers/pci/pcie/aer.c
>>>>>>> @@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
>>>>>>>  	return true;
>>>>>>>  }
>>>>>>>  
>>>>>>> -#ifdef CONFIG_PCIEAER_CXL
>>>>>>> +static bool is_internal_error(struct aer_err_info *info)
>>>>>>> +{
>>>>>>> +	if (info->severity == AER_CORRECTABLE)
>>>>>>> +		return info->status & PCI_ERR_COR_INTERNAL;
>>>>>>>  
>>>>>>> +	return info->status & PCI_ERR_UNC_INTN;
>>>>>>> +}
>>>>>>> +
>>>>>>> +#ifdef CONFIG_PCIEAER_CXL
>>>>>>>  /**
>>>>>>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>>>>>>   * @dev: pointer to the pcie_dev data structure
>>>>>>> @@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>>>>>  	return (pcie_ports_native || host->native_aer);
>>>>>>>  }
>>>>>>>  
>>>>>>> -static bool is_internal_error(struct aer_err_info *info)
>>>>>>> -{
>>>>>>> -	if (info->severity == AER_CORRECTABLE)
>>>>>>> -		return info->status & PCI_ERR_COR_INTERNAL;
>>>>>>> -
>>>>>>> -	return info->status & PCI_ERR_UNC_INTN;
>>>>>>> -}
>>>>>>> -
>>>>>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>>>>  {
>>>>>>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>>>>>>> @@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>>>>  
>>>>>>>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>>>>  {
>>>>>>> -	/*
>>>>>>> -	 * Internal errors of an RCEC indicate an AER error in an
>>>>>>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>>>>>>> -	 * device driver.
>>>>>>> -	 */
>>>>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>>>>> -	    is_internal_error(info))
>>>>>>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>>>>> +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>>>>> +
>>>>>>> +	if (info->severity == AER_CORRECTABLE) {
>>>>>>> +		struct pci_driver *pdrv = dev->driver;
>>>>>>> +		int aer = dev->aer_cap;
>>>>>>> +
>>>>>>> +		if (aer)
>>>>>>> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>>>>>>> +					       info->status);
>>>>>>> +
>>>>>>> +		if (pdrv && pdrv->cxl_err_handler &&
>>>>>>> +		    pdrv->cxl_err_handler->cor_error_detected)
>>>>>>> +			pdrv->cxl_err_handler->cor_error_detected(dev);
>>>>>>>
>>>>>>> +		pcie_clear_device_status(dev);
>>>>>>> +	}
>>>>>>>  }
>>>>>>>  
>>>>>>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>>>>>> @@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
>>>>>>>  {
>>>>>>>  	bool handles_cxl = false;
>>>>>>>  
>>>>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>>>>> -	    pcie_aer_is_native(dev))
>>>>>>> +	if (!pcie_aer_is_native(dev))
>>>>>>> +		return false;
>>>>>>> +
>>>>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>>>>>  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>>>>>>> +	else
>>>>>>> +		handles_cxl = pcie_is_cxl_port(dev);
>>>>>> My understanding is if a cxl RP/USP/DSP is working on PCIe mode, they are also possible to expose a DVSEC ID 3(CXL r3.1 section 9.12.3). In such case, the AER handler should be pci_aer_handle_error() rather than cxl_handle_error().
>>>>>>
>>>>>> pcie_is_cxl_port() only checks if there is a DVSEC ID 3, but I think it should also check if the cxl port is working on CXL mode, does it make more sense?
>>>>>>
>>>>>>
>>>>>> Ming
>>>>> Hi Ming and Jonathan,
>>>>>
>>>>> RCH AER & RCH RAS are currently logged by the CXL driver's RCH handlers.
>>>>>
>>>>> If the recommended change is made then RCH RAS will not be logged and the
>>>>> user would miss CXL details about the alternate protocol training failure.
>>>>> Also, AER is not CXL required and as a result in some cases you would only
>>>>> have the RCEC forwarded UIE/CIE message logged by the AER driver without
>>>>> any other logging.
>>>>>
>>>>> Is there value in *not* logging CXL RAS for errors on an untrained RCH
>>>>> link? Isn't it more informative to log PCIe AER and CXL RAS in this case?
>>>>>
>>>>> Regards,
>>>>> Terry
>>>> Hi Terry,
>>>>
>>>>
>>>> I don't understand why the recommended change will influence RCH RAS handling, would you mind giving more details?
>>>>
>>>> My understanding is that above 'pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)' is used for RCH case.
>>>>
>>>> And the 'else' block is used for VH case, so just check if the cxl port is working on CXL mode in pcie_is_cxl_port() or adding an extra function to check it in the 'else' block. I think it will not change RCH AER & RAS handling, is it right? or do I miss other details?
>>>>
>>>>
>>>> Ming
>>> Hi Ming,
>>>
>>> You're recommending this example case is handled by pci_aer_handle_error() rather than cxl_handle_error(). Correct me if I misunderstood. And, I believe this should continue to be handled by cxl_handle_error(). There are 2 issues with the recommended approach that deserve to be mentioned.
>> I guess that what you thought is the recommended change using pci_aer_handle_error() to handle CXL RAS issues? If yes, it is not what I meant.
>>
>> handles_cxl_errors() is used to distinguish if the errors is a CXL error or a PCIe error. if the returned value of handles_cxl_errors() is 'true', that means the error is a CXL error. Then invoking either cxl_handle_error() or pcie_aer_handle_error() depending on the returned value. I think no problem in this part.
>>
>> handles_cxl_errors() is using pcie_is_cxl_port() to distinguish CXL errors for VH cases. the implementation of pcie_is_cxl_port() is only checking if there is a DVSEC ID 3 exposed on the CXL RP/DSP/USP. I think it is not enough.
>>
>> For example, If a CXL device connected to a CXL RP, there is no problem, because the return value of handles_cxl_errors() will be 'true' then cxl_handle_error() will be invoked to handle the errors.
>>
>> If a PCIe device connected to a CXL RP, the CXL RP is working on PCIe mode, the CXL RP is possible to expose a DVSEC ID 3[1]. If the CXL RP has a DVSEC ID 3 in the case, the return value of handles_cxl_errors() is also 'true' and also invoking cxl_handle_error() to handle the error, I thinks it is not right, the CXL RP is working on PCIe mode, the error should be a PCIe error, and it should be handled by pcie_aer_handle_error(). So my suggestion is about checking if the CXL RP/DSP/USP is working on CXL mode in pcie_is_cxl_port() for VH cases.
>>
>>
>> [1] CXL r3.1 - 9.12.3 Enumerating CXL RPs and DSPs
>>
>>    "CXL root port or DSP connected to a PCIe device/switch may or may not expose theCXL DVSEC ID 3 and the CXL DVSEC ID 7 capability structures."
>>
> Hi Ming,
>
> I apologize for the delayed response. Thanks for the patience in explaining.
>
> In your example using a RP with downstream non-CXL device, the RP AER will log the
> RP's CE/UCE and RAS status for a protocol error. It's not helpful in this case
> because it's a non-CXL device but it is failing alternate prootcol training that can
> also happen with a CXL endpoint. I expect the RAS registers contain details about
> the failed CXL training in the endpoint case.
>
> I believe we should give the user as much error details within reason. And for CXL using
> AER CE/UCE errors, this should include the RAS logging. If we rely on the PCIe handling path,
> this information will not be logged.
>
> Also, CE/UCE AER is logged in the CXL handling path. The AER driver logs AER status before
> calling the CE/UCE CXL handlers.
>
> Are there any other use cases or reasons why to use PCIe handling if alt. protocol training
> fails? Is there anything lost by using CXL handling?

One problem I realized is if using cxl_handle_error() instead of pci_aer_handle_error() for the above case I described(a CXL RP is working on PCIe mode because it connected to a PCIe device), the CXL RP will miss pcie_do_recovery() invoked in pci_aer_handle_error() when the error is an UCE, and it will also miss pcie error handler implemented in pcie port driver. 

It means that AER handling logic is different between CXL RP working on PCIe mode and PCIe RP. I am not sure whether it is OK.


Although cxl_handle_error() includes cxl_do_recovery() implemented in patch #7, cxl_do_recovery() seems like only for CXL cases(CXL RP working on CXL mode), is it suitable for pcie port recovery(CXL RP working on PCIe mode)?

Please correct me if I am wrong.


Ming

>
> Terry
>>> First, the RCH Downstream Port (DP) is implemented as an RCRB and does not have a
>>> SBDF.[1] The RCH AER error is reported with the RCEC SBDF in the AER SRC_ID register.[2] The
>>> RCEC is used to find the RCH's handlers using a CXL unique procedure (see cxl_handle_error()).
>>>
>>> The logic in pci_aer_handle_error() operates on a 'struct pci_dev' type and pci_aer_handle_error() is not plumbed to support searching for the RCH handlers.
>>>
>>> Using pci_aer_handle_error would require significant changes to support a CXL RCH
>>> in addition to a PCIe device. These changes are already in cxl_handle_error().
>>>  
>>> Another issue to note is the CXL RAS information will (should) not be logged with this
>>> recommended change. pci_aer_handle_error is PCIe specific and is not aware of CXL RAS. As a result,pci_aer_handle_error() is not suited to log the CXL RAS.
>>>
>>> The example scenario was the RCH DP failed training. The user needs to know why training
>>> failed and these details are stored in the CXL RAS registers. Again, CXL RAS needs to be logged
>>> as well but CXL specific awareness shouldn't be added to pci_aer_handle_error().
>> For these two issues, handles_cxl_errors() is always using "pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)" for RCH cases. I believe no change on this part, the return value of handles_cxl_errors() will be 'true' as expected in the cases you mentioned, cxl_handle_error() will help to handle these errors.
>>
>>
>> Ming
>>
>>> Terry
>>>
>>> [1] CXL r3.1 - 8.2 Memory Mapped Registers
>>> [2] CXL r3.1 - 12.2.1.1 RCH Downstream Port-detected Errors+
>>>>>>>  
>>>>>>>  	return handles_cxl;
>>>>>>>  }
>>>>>>> @@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
>>>>>>>  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>>>>>>>  static inline void cxl_handle_error(struct pci_dev *dev,
>>>>>>>  				    struct aer_err_info *info) { }
>>>>>>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>>>>>> +{
>>>>>>> +	return false;
>>>>>>> +}
>>>>>>>  #endif
>>>>>>>  
>>>>>>>  /**
>>>>>>> @@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>>>>  
>>>>>>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>>>>>  {
>>>>>>> -	cxl_handle_error(dev, info);
>>>>>>> -	pci_aer_handle_error(dev, info);
>>>>>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>>>>>> +		cxl_handle_error(dev, info);
>>>>>>> +	else
>>>>>>> +		pci_aer_handle_error(dev, info);
>>>>>>> +
>>>>>>>  	pci_dev_put(dev);
>>>>>>>  }
>>>>>>>  



