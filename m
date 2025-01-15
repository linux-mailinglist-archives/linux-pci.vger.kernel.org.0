Return-Path: <linux-pci+bounces-19808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F4A11670
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 02:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5711188A7CE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A01798F;
	Wed, 15 Jan 2025 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="aXwolmvI"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846763A9;
	Wed, 15 Jan 2025 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903914; cv=pass; b=JoyYi8LOk7doEs215bG0SHx7assnvD7GFcuOFo+qzR81KupGS4oSJJa9lTcgl7eb+sDYy28Bgukf0iR3whNSKSmmRMNdzhZRIHxpdZQeQfGdFTBkdVS2UtMXjaNJQHLumd17DKJcfRms9Tr7ubtnuXepvDXrPRY3nkxlmUMRUks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903914; c=relaxed/simple;
	bh=fMwwnjYCT9auZgVWPLIxjst+KNOlmdp82Db/aLUHZkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cO/vHXUU0buhVTh8yyU3j4ryAOcXvwBCqIJRiegkcByXuF4hcUBSgEmGiTmCJ5VFSVglluEx7tU9JmosWt8W9uoG4yb6lralC1DVW/h9ieBTuwqiX5M4YT2XxxpDyNow6UasxutidpTECC7vPLRF2QiLOlKq2ndZOpFooVc98OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=aXwolmvI; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1736903895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QCsmd/SRJF203cqsQz1Ihn+PaYch/MzOs/uDwlLnpMH5M8p95l5fKN2Ez5o17Vgn68BR9XwirPg9swm0Xx1/7SUscTNcbYX6gCahU2eYMSywWENjQtfed8Eja0W1mBMJIWDDBGvtvNphtfCGb7SIosYMAzG62EAjICrFmHBWeOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736903895; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=iFUaws4Uu1ZaIKMmEO2TZ96XF8RrT3ty0nPk3aDadQ8=; 
	b=gR+FzveLxJELkZYUCxbyrYMQkEpZ1gTX9ncQO9ju6aIK/lFScXAQvH9aSNgeVdp5Z5QnaWMf3uSpP1tm/uUXlqxXqK473VMb+ONhLa8EiNjQQks96cclzQhNdOtTONBJEBfhFM2jnvSL8FobQDxEL71i69NPGF+nVLk/Urc9Deo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736903895;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=iFUaws4Uu1ZaIKMmEO2TZ96XF8RrT3ty0nPk3aDadQ8=;
	b=aXwolmvIQiEX+nQJFIJeFk6chyhgQBz29PgDMBrNk5g3Ly0LJazVVjXGfLApxOMA
	3fUm3E4+x7GFPv05ikYqhJA2vX0f8MDW2nskopr0Mf1/jEt9u6RoeVcr6t5sq8Sfyet
	lvsLVDUc7XNvBBUq0Uk/N4vpCjaPWRAnuJLsxtHU=
Received: by mx.zohomail.com with SMTPS id 1736903892545362.0168427246173;
	Tue, 14 Jan 2025 17:18:12 -0800 (PST)
Message-ID: <c7e6298c-ae12-4e86-a74b-8b3aea698772@zohomail.com>
Date: Wed, 15 Jan 2025 09:18:10 +0800
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
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <708db61f-2a69-40a0-ab9a-0fdb889ff443@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227207efb01024cc145eb2022000000135543a8c383bc5e975e225a957db33b775b5dd1ff41c6ba46:zu0801122759548c786fcf3fb1bb4704fd00002f27b968a83214aad3de0b4b137141e29ffa7a12b74ebbabc6:rf0801122c0e8eee5a3cdc01de17adc29d0000704cca52e9427e96114f6f316a1771de4b2bd619d4ab0cdfebdc13d4f124:ZohoMail
X-ZohoMailClient: External

On 1/15/2025 3:29 AM, Bowman, Terry wrote:
>
> On 1/14/2025 12:54 AM, Li Ming wrote:
>> On 1/7/2025 10:38 PM, Terry Bowman wrote:
>>> The AER service driver supports handling Downstream Port Protocol Errors in
>>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>>> mode.[1]
>>>
>>> CXL and PCIe Protocol Error handling have different requirements that
>>> necessitate a separate handling path. The AER service driver may try to
>>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>>> suitable for CXL PCIe Port devices because of potential for system memory
>>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>>> Error handling does not panic the kernel in response to a UCE.
>>>
>>> Introduce a separate path for CXL Protocol Error handling in the AER
>>> service driver. This will allow CXL Protocol Errors to use CXL specific
>>> handling instead of PCIe handling. Add the CXL specific changes without
>>> affecting or adding functionality in the PCIe handling.
>>>
>>> Make this update alongside the existing Downstream Port RCH error handling
>>> logic, extending support to CXL PCIe Ports in VH mode.
>>>
>>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>>> config. Update is_internal_error()'s function declaration such that it is
>>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>>> or disabled.
>>>
>>> The uncorrectable error (UCE) handling will be added in a future patch.
>>>
>>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>> Upstream Switch Ports
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>  drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
>>>  1 file changed, 40 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index f8b3350fcbb4..62be599e3bee 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
>>>  	return true;
>>>  }
>>>  
>>> -#ifdef CONFIG_PCIEAER_CXL
>>> +static bool is_internal_error(struct aer_err_info *info)
>>> +{
>>> +	if (info->severity == AER_CORRECTABLE)
>>> +		return info->status & PCI_ERR_COR_INTERNAL;
>>>  
>>> +	return info->status & PCI_ERR_UNC_INTN;
>>> +}
>>> +
>>> +#ifdef CONFIG_PCIEAER_CXL
>>>  /**
>>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>>   * @dev: pointer to the pcie_dev data structure
>>> @@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>  	return (pcie_ports_native || host->native_aer);
>>>  }
>>>  
>>> -static bool is_internal_error(struct aer_err_info *info)
>>> -{
>>> -	if (info->severity == AER_CORRECTABLE)
>>> -		return info->status & PCI_ERR_COR_INTERNAL;
>>> -
>>> -	return info->status & PCI_ERR_UNC_INTN;
>>> -}
>>> -
>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>  {
>>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>>> @@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>  
>>>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>  {
>>> -	/*
>>> -	 * Internal errors of an RCEC indicate an AER error in an
>>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>>> -	 * device driver.
>>> -	 */
>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>> -	    is_internal_error(info))
>>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>> +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>> +
>>> +	if (info->severity == AER_CORRECTABLE) {
>>> +		struct pci_driver *pdrv = dev->driver;
>>> +		int aer = dev->aer_cap;
>>> +
>>> +		if (aer)
>>> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>>> +					       info->status);
>>> +
>>> +		if (pdrv && pdrv->cxl_err_handler &&
>>> +		    pdrv->cxl_err_handler->cor_error_detected)
>>> +			pdrv->cxl_err_handler->cor_error_detected(dev);
>>>
>>> +		pcie_clear_device_status(dev);
>>> +	}
>>>  }
>>>  
>>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>> @@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
>>>  {
>>>  	bool handles_cxl = false;
>>>  
>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>> -	    pcie_aer_is_native(dev))
>>> +	if (!pcie_aer_is_native(dev))
>>> +		return false;
>>> +
>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>>> +	else
>>> +		handles_cxl = pcie_is_cxl_port(dev);
>> My understanding is if a cxl RP/USP/DSP is working on PCIe mode, they are also possible to expose a DVSEC ID 3(CXL r3.1 section 9.12.3). In such case, the AER handler should be pci_aer_handle_error() rather than cxl_handle_error().
>>
>> pcie_is_cxl_port() only checks if there is a DVSEC ID 3, but I think it should also check if the cxl port is working on CXL mode, does it make more sense?
>>
>>
>> Ming
> Hi Ming and Jonathan,
>
> RCH AER & RCH RAS are currently logged by the CXL driver's RCH handlers.
>
> If the recommended change is made then RCH RAS will not be logged and the
> user would miss CXL details about the alternate protocol training failure.
> Also, AER is not CXL required and as a result in some cases you would only
> have the RCEC forwarded UIE/CIE message logged by the AER driver without
> any other logging.
>
> Is there value in *not* logging CXL RAS for errors on an untrained RCH
> link? Isn't it more informative to log PCIe AER and CXL RAS in this case?
>
> Regards,
> Terry

Hi Terry,


I don't understand why the recommended change will influence RCH RAS handling, would you mind giving more details?

My understanding is that above 'pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)' is used for RCH case.

And the 'else' block is used for VH case, so just check if the cxl port is working on CXL mode in pcie_is_cxl_port() or adding an extra function to check it in the 'else' block. I think it will not change RCH AER & RAS handling, is it right? or do I miss other details?


Ming

>>>  
>>>  	return handles_cxl;
>>>  }
>>> @@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
>>>  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>>>  static inline void cxl_handle_error(struct pci_dev *dev,
>>>  				    struct aer_err_info *info) { }
>>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>> +{
>>> +	return false;
>>> +}
>>>  #endif
>>>  
>>>  /**
>>> @@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>  
>>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>  {
>>> -	cxl_handle_error(dev, info);
>>> -	pci_aer_handle_error(dev, info);
>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>> +		cxl_handle_error(dev, info);
>>> +	else
>>> +		pci_aer_handle_error(dev, info);
>>> +
>>>  	pci_dev_put(dev);
>>>  }
>>>  



