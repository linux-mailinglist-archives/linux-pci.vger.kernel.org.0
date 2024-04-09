Return-Path: <linux-pci+bounces-5981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6577B89E542
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 23:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2991C2206A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5FB158A3C;
	Tue,  9 Apr 2024 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auGz3AHo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA0156F4E;
	Tue,  9 Apr 2024 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699777; cv=none; b=tdqhZ6ZFNKu9RTe2ENdM9DQ3s136ILbcXNlOD0tUL4jdgvXT7fahyz6Ud6fOIt3DTMcRQoSrj0wtMWpN/cYciYMUlIeP3Bc7Ehc8JKWwS/jP7odXykbn4Wlt+ht5ry9/LdO38fEbB2fpO+5g6T2siRJZ+PxqMJu218uGJdivNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699777; c=relaxed/simple;
	bh=3hH75J+luzP89krvbXIUT8FPNT7qogtdWTvLF7nXnn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9dqiEGT4/GccCMcg6YYcb53slmbeVQt5KfDmNA5Ihoc0lYn4ucx1FWLl2kwH3qAxUkNJ8vqTcTOxkUuIu9+vAcOSbdxXmEvZU3GaRzvjrn3RH9guSHcQX0v1/w+QlM+x90FLD74hYN0t7TzMQ4kUGsL/RubILA3k6igh683oEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auGz3AHo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712699775; x=1744235775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3hH75J+luzP89krvbXIUT8FPNT7qogtdWTvLF7nXnn8=;
  b=auGz3AHok1jvy2bai53LASMtgC+enucS7v76HZa10Ijq7B5Jgrx7tj7u
   AuOTFuYlfS/GAycrJyGh/Qo7U0iTEXd4xn2tQnD3oJF3ee4877tc5XtES
   z/oYDb0P/NcJer8xicp32e5QOkxMPnfd0LsVMqhKHyuPPNJ4wsl4fdh3O
   yPv1uRKzPUlsQzFrWKUp8fVltZf7HC9KeF5RvUYxvVLpmAgmOlGks0bU1
   z0JdXeL71I69Z39j2bDU+ATPszSUdn8OhhsOXMGEpk0a8jKotLe92LIZE
   g6ZPixMI/TjNBm1v2W7dGwCxnWZJdQlUZPZXlV6zEMPxsxCXPLedzLhhC
   w==;
X-CSE-ConnectionGUID: 7hSx0F5SSWW0G/r0PzpTwg==
X-CSE-MsgGUID: EyuLTKEqS3mMAKgPE98/AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19423835"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19423835"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:56:13 -0700
X-CSE-ConnectionGUID: PdI5lZtrSpS00zIE8basiw==
X-CSE-MsgGUID: L/aymBEcSdahNjTL32JFAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57799106"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.183.123]) ([10.213.183.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:56:10 -0700
Message-ID: <f3394e7d-8094-4821-9fec-1d7b296805bc@intel.com>
Date: Tue, 9 Apr 2024 14:56:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] PCI: Add check for CXL Secondary Bus Reset
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com, lukas@wunner.de
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-3-dave.jiang@intel.com>
 <da8ca6a2-860f-44a5-bb47-b5967f40be90@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <da8ca6a2-860f-44a5-bb47-b5967f40be90@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/24 2:39 PM, Kuppuswamy Sathyanarayanan wrote:
> 
> On 4/9/24 9:01 AM, Dave Jiang wrote:
>> Per CXL spec r3.1 8.1.5.2, Secondary Bus Reset (SBR) is masked unless the
>> "Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
>> path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
>> the CXL Port Control Extensions register by returning -ENOTTY.
>>
>> When the "Unmask SBR" bit is set to 0 (default), the bus_reset would
>> appear to have executed successfully. However the operation is actually
>> masked. The intention is to inform the user that SBR for the CXL device
>> is masked and will not go through.
>>
>> If the "Unmask SBR" bit is set to 1, then the bus reset will execute
>> successfully.
>>
>> Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v4:
>> - cxl_port_dvsec() should return u16. (Lukas)
>> ---
>>  drivers/pci/pci.c             | 45 +++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/pci_regs.h |  5 ++++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e5f243dd4288..570b00fe10f7 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>>  }
>>  
>> +static u16 cxl_port_dvsec(struct pci_dev *dev)
>> +{
>> +	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					 PCI_DVSEC_CXL_PORT);
>> +}
> 
> Since cxl_sbr_masked() is the only user of this function, why not directly
> check for this capability there.

It's used by another function in the 3rd patch. I previously had it open coded. But Dan said to reduce churn, just create the function to begin with instead of moving that code to a function later on.

> 
>> +
>> +static bool cxl_sbr_masked(struct pci_dev *dev)
>> +{
>> +	u16 dvsec, reg;
>> +	int rc;
>> +
>> +	/*
>> +	 * No DVSEC found, either is not a CXL port, or not connected in which
>> +	 * case mask state is a nop (CXL r3.1 sec 9.12.3 "Enumerating CXL RPs
>> +	 * and DSPs"
>> +	 */
>> +	dvsec = cxl_port_dvsec(dev);
>> +	if (!dvsec)
>> +		return false;
>> +
>> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
>> +	if (rc || PCI_POSSIBLE_ERROR(reg))
>> +		return false;
>> +
>> +	/*
>> +	 * CXL spec r3.1 8.1.5.2
>> +	 * When 0, SBR bit in Bridge Control register of this Port has no effect.
>> +	 * When 1, the Port shall generate hot reset when SBR bit in Bridge
>> +	 * Control gets set to 1.
>> +	 */
>> +	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>>  {
>> +	struct pci_dev *bridge = pci_upstream_bridge(dev);
>>  	int rc;
>>  
>> +	/* If it's a CXL port and the SBR control is masked, fail the SBR */
>> +	if (bridge && cxl_sbr_masked(bridge)) {
>> +		if (probe)
>> +			return 0;
> 
> Why return success during the probe?

Otherwise the reset_method will disappear as available after initial probe. We want to leave the reset method available. If the register bit gets unmasked we can perform a bus reset. We don't want to take it away the option entirely if it's masked.

> 
>> +
>> +		return -ENOTTY;
>> +	}
>> +
>>  	rc = pci_dev_reset_slot_function(dev, probe);
>>  	if (rc != -ENOTTY)
>>  		return rc;
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index a39193213ff2..d61fa43662e3 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1148,4 +1148,9 @@
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>>  
>> +/* Compute Express Link (CXL) */
>> +#define PCI_DVSEC_CXL_PORT				3
>> +#define PCI_DVSEC_CXL_PORT_CTL				0x0c
>> +#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>> +
>>  #endif /* LINUX_PCI_REGS_H */
> 

