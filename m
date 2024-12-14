Return-Path: <linux-pci+bounces-18443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8049F1EC9
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 14:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55DF167061
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB36191F6C;
	Sat, 14 Dec 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="crs4yI3V"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F863C;
	Sat, 14 Dec 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734183323; cv=pass; b=Fe7xDTcXoKujYlHt4ifgCt1dMbx4BEd7jyu1rNuIFyawTs/ZwhZNdg80V+hEL+Q/yJqYbeHr84ljbxqQcz6Hb8C6XsmTaHd83dK1kdA12DFaTJU6G6ouKYTflZq3cHjRdemPt/CBlEYGzjE+QlAYkLBNgWKjghNbFD7hfmWvykI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734183323; c=relaxed/simple;
	bh=DNp5NyLYjpTHovQ1y6WoZ3lMswAME79gMoNY2Rnnwb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FFswwetTbLKPmZXwggEFWZzaaAdMgdeTcHrWbpVhO4+WN1ZpZCH3DLAsT0IBo/m+8OlW/uOE0NNONdHoijz+ni9ZvZZZimB2Fa/3l2RvEB3BohzOqbsEJ8ngucLkP9DwdtSdosM4by2wGFpJzPR4SNEqt9IiYrfKWDrnMM9NIUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=crs4yI3V; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1734183302; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AELDF5dDitodFZd2a7439oMtPNMM/AWuhQsFhmw8SCiuDDfANpyInItNd4ZxiUw8XJMz4Krk9exppn9HrclkZBeLTIMMOg/Uff0vcX7bOmo+kWIgS/uZaCzyd5+CtRBvDUXcf41PopeP6A2y9qTe7XaHgkOJxRdfxzbrX58Yx5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734183302; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=MuQDYAnAiCnupF2c2O/j5fvSk5ZV3CYb+uG6AjERERg=; 
	b=DYUwN6eEMYU0xQ7jtk75RmlvccABACCuCSgtlymDaic9pWhhlsA4fZikWuzczQ7j0JzrYeTf6cPYM87JKqkSceQQ6jKUxAEPqGWqYmti1eJ5t7WhLpdeYmq1ZJJM5SGQolVbrYymgSv60ahnB+EOpC3O1Ph+qIjUhD7LcUue+kI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734183302;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=MuQDYAnAiCnupF2c2O/j5fvSk5ZV3CYb+uG6AjERERg=;
	b=crs4yI3VTG5e0wH1OwGzfdLHMgw8OCGbvoX1cn64Z5C4mOcUGVZTss9VCW7MClFR
	sNWZQc2DtiVNYVOQ2fb+a2KnPQIK/AuZZJCcCldkNZqKqIb7dNljGq835s9sCRqu4oi
	fLimkkm4kbQMY8+gUcOzn8eTplRFLPHbb3y3bqsI=
Received: by mx.zohomail.com with SMTPS id 173418329954737.32446005016391;
	Sat, 14 Dec 2024 05:34:59 -0800 (PST)
Message-ID: <d5bf9c4f-fde5-475c-9e4f-600b35508cb8@zohomail.com>
Date: Sat, 14 Dec 2024 21:34:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] PCI/AER: Modify AER driver logging to report CXL
 or PCIe bus error type
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-5-terry.bowman@amd.com>
 <ef7d45cc-d5ed-4a76-a9af-52c2a423ead0@zohomail.com>
 <208e6639-a394-428f-bfe9-a3b8d48d6144@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <208e6639-a394-428f-bfe9-a3b8d48d6144@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112271c8d1833567dfefef03c7cf600002e50a68bfccd368470f93d8ca3c200031c9f46a82d6a31686e:zu080112278e854838a7a0ec0bf31e1ca20000e2709ff0c6002f061ae2ef3e3e0f5a51527a88dd9d7822d32a:rf0801122b7e45eafa645a239bf48f77690000fb1547e023d3a302104576ee2bf8b13728d3fa9c2fac99f8fce135e78c:ZohoMail
X-ZohoMailClient: External

On 12/13/2024 3:59 AM, Bowman, Terry wrote:
>
>
> On 12/11/2024 7:34 PM, Li Ming wrote:
>> On 12/12/2024 7:39 AM, Terry Bowman wrote:
>>> The AER driver and aer_event tracing currently log 'PCIe Bus Type'
>>> for all errors.
>>>
>>> Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
>>> device errors.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>> ---
>>>  drivers/pci/pcie/aer.c  | 14 ++++++++------
>>>  include/ras/ras_event.h |  9 ++++++---
>>>  2 files changed, 14 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index fe6edf26279e..53e9a11f6c0f 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -699,13 +699,14 @@ static void __aer_print_error(struct pci_dev *dev,
>>>  
>>>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>>  {
>>> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
>>>  	int layer, agent;
>>>  	int id = pci_dev_id(dev);
>>>  	const char *level;
>>>  
>>>  	if (!info->status) {
>>> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>>> -			aer_error_severity_string[info->severity]);
>>> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>>> +			bus_type, aer_error_severity_string[info->severity]);
>>>  		goto out;
>>>  	}
>>>  
>>> @@ -714,8 +715,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>>  
>>>  	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>>>  
>>> -	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>>> -		   aer_error_severity_string[info->severity],
>>> +	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
>>> +		   bus_type, aer_error_severity_string[info->severity],
>>>  		   aer_error_layer[layer], aer_agent_string[agent]);
>>>  
>>>  	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>>> @@ -730,7 +731,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>>  	if (info->id && info->error_dev_num > 1 && info->id == id)
>>>  		pci_err(dev, "  Error of this Agent is reported first\n");
>>>  
>>> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
>>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
>>>  			info->severity, info->tlp_header_valid, &info->tlp);
>>>  }
>>>  
>>> @@ -764,6 +765,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>>  		   struct aer_capability_regs *aer)
>>>  {
>>> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
>>>  	int layer, agent, tlp_header_valid = 0;
>>>  	u32 status, mask;
>>>  	struct aer_err_info info;
>>> @@ -798,7 +800,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>>  	if (tlp_header_valid)
>>>  		__print_tlp_header(dev, &aer->header_log);
>>>  
>>> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>>>  			aer_severity, tlp_header_valid, &aer->header_log);
>>>  }
>>>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
>>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>>> index e5f7ee0864e7..1bf8e7050ba8 100644
>>> --- a/include/ras/ras_event.h
>>> +++ b/include/ras/ras_event.h
>>> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>>>  
>>>  TRACE_EVENT(aer_event,
>>>  	TP_PROTO(const char *dev_name,
>>> +		 const char *bus_type,
>>>  		 const u32 status,
>>>  		 const u8 severity,
>>>  		 const u8 tlp_header_valid,
>>>  		 struct pcie_tlp_log *tlp),
>>>  
>>> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>>> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>>>  
>>>  	TP_STRUCT__entry(
>>>  		__string(	dev_name,	dev_name	)
>>> +		__string(	bus_type,	bus_type	)
>>>  		__field(	u32,		status		)
>>>  		__field(	u8,		severity	)
>>>  		__field(	u8, 		tlp_header_valid)
>>> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>>>  
>>>  	TP_fast_assign(
>>>  		__assign_str(dev_name);
>>> +		__assign_str(bus_type);
>>>  		__entry->status		= status;
>>>  		__entry->severity	= severity;
>>>  		__entry->tlp_header_valid = tlp_header_valid;
>>> @@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
>>>  		}
>>>  	),
>>>  
>>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>>> -		__get_str(dev_name),
>>> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
>>> +		__get_str(dev_name), __get_str(bus_type),
>>>  		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>>>  			__entry->severity == AER_FATAL ?
>>>  			"Fatal" : "Uncorrected, non-fatal",
>> Hi Terry,
>>
>>
>> Patch #3 is using flexbus dvsec to identify CXL RP/USP/DSP. But per CXL r3.1 section 9.12.3 "Enumerating CXL RPs and DSPs", there may be a flexbus dvsec if CXL RP/DSP is in disconnect state or connecting to a PCIe device.
>>
>> If a PCIe device connects to a CXL RP/DSP, and the CXL RP/DSP reports an error, the error log will be also "CXL Bus Type", is it expected? My understanding is that the CXL RP/DSP is working on PCIe mode.
>>
>> If not, I think that setting "pci_dev->is_cxl" during cxl port enumeration and CXL device probing is another option.
>>
>>
>> Thanks
>>
>> Ming
>>
> Hi Ming,
>
> aer_print_error() logs the AER details (including bus type) for the device that detected the error
> not the RPAER reporting agent unless the error is detected in the RP. The bus type is determined
> using the 'dev' parameter and in your example is a PCIe device not a CXL device. aer_print_error()
> will log "PCI bus" because the flexbus DVSEC will not be present in 'dev' config space.
>
> I agree in your example the RP and downstream device will train to PCIe mode and not CXL mode. But, the
> flexbus DVSEC will still be present in the RP PCIe configuration space. The pci_dev::is_cxl structure
> member indicates CXL support and is not reflective of the current training state.
>
> Regards,
> Terry
>
>
Got it, thanks for your explanation.


Thanks

Ming



