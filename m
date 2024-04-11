Return-Path: <linux-pci+bounces-6102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB98A05DB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 04:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B724A1C22855
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 02:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827A13AD1F;
	Thu, 11 Apr 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSgU+cSi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4351F5FA;
	Thu, 11 Apr 2024 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802785; cv=none; b=OnBeanuLGPXWKtyjFrXDKee5J+zeiNDzwfbyfoP0ghzF9p5NaEydBU5a0HAmxTwT+CnSAzXnN1ap5CXIGcbK0FXQlDtDXf2ghlsAWXKNnBtd1YxpW0SzAXVgNy8MY/sqQfBI8tiimJ6FO2/UFTePUFDpwieXnCQIGa7TJ2nSSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802785; c=relaxed/simple;
	bh=lbTPOYvSPz3ocuH2IuW7VvwSA+zx01OQxCxSasNyqVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8L0Fzw6CAFC/9arlSV9MeuIdZ3VAyIZNa+3xaO5BMsx/Nlpew5Wu64GevBDiyvrihAOd7qo4Mj/PaKiNZ34+2Od9GC180sk0WnSAfauFdndmxgZaCvAwwlCt6w9IQHC5/PASuUJam2mzo9no35HXzKU2UUHtVWgV058ljblUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSgU+cSi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712802784; x=1744338784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lbTPOYvSPz3ocuH2IuW7VvwSA+zx01OQxCxSasNyqVk=;
  b=NSgU+cSia3EWuZS5aT32c5rcmXGq5hkwymwgmJFGl5dHg27/WGPR7XwT
   ybEv4EXD0tx846q807K6CnVXN6EvP1vScxGy7YyawRJ1KD8vOXGZRf85q
   nbl2XwPOrJz7x8jQFFQJEPl9iyuIkx1ut1C14j/HLdnVDKHps6j5WwoIk
   u7i490ziVvO9fchLWI1I2TYcuyay419Rtv+QCHFXFbvqpZcKwqL6YnN20
   OiLMWpCzM9AMQryAhsN5CSoBQNpqRJSN+R+PEZ0gIw0z6Qb50B5Tf5HIU
   hhTukP67c6H4t4drlvF9K1Y4dNqU8A/lGfHrEvNoLI97igQ1zfT48q6qW
   g==;
X-CSE-ConnectionGUID: tbSE+BstTxGgN+RqcxhzMg==
X-CSE-MsgGUID: m6fUNGKbS7u5iKpIprXzKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8053543"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8053543"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:33:03 -0700
X-CSE-ConnectionGUID: 1xxNz+KsR0e5RVKCjx9U+A==
X-CSE-MsgGUID: FfgGP88QSwyjrxTM0753XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25274483"
Received: from tashley-mobl.amr.corp.intel.com (HELO [10.255.230.246]) ([10.255.230.246])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:33:02 -0700
Message-ID: <f18734ef-9a9e-47d6-b302-81f61ad3c438@linux.intel.com>
Date: Wed, 10 Apr 2024 19:33:02 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] PCI: Add check for CXL Secondary Bus Reset
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com, lukas@wunner.de
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-3-dave.jiang@intel.com>
 <da8ca6a2-860f-44a5-bb47-b5967f40be90@linux.intel.com>
 <f3394e7d-8094-4821-9fec-1d7b296805bc@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <f3394e7d-8094-4821-9fec-1d7b296805bc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/9/24 2:56 PM, Dave Jiang wrote:
>
> On 4/9/24 2:39 PM, Kuppuswamy Sathyanarayanan wrote:
>> On 4/9/24 9:01 AM, Dave Jiang wrote:
>>> Per CXL spec r3.1 8.1.5.2, Secondary Bus Reset (SBR) is masked unless the
>>> "Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
>>> path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
>>> the CXL Port Control Extensions register by returning -ENOTTY.
>>>
>>> When the "Unmask SBR" bit is set to 0 (default), the bus_reset would
>>> appear to have executed successfully. However the operation is actually
>>> masked. The intention is to inform the user that SBR for the CXL device
>>> is masked and will not go through.
>>>
>>> If the "Unmask SBR" bit is set to 1, then the bus reset will execute
>>> successfully.
>>>
>>> Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>>> v4:
>>> - cxl_port_dvsec() should return u16. (Lukas)
>>> ---
>>>  drivers/pci/pci.c             | 45 +++++++++++++++++++++++++++++++++++
>>>  include/uapi/linux/pci_regs.h |  5 ++++
>>>  2 files changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index e5f243dd4288..570b00fe10f7 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>>>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>>>  }
>>>  
>>> +static u16 cxl_port_dvsec(struct pci_dev *dev)
>>> +{
>>> +	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>>> +					 PCI_DVSEC_CXL_PORT);
>>> +}
>> Since cxl_sbr_masked() is the only user of this function, why not directly
>> check for this capability there.
> It's used by another function in the 3rd patch. I previously had it open coded. But Dan said to reduce churn, just create the function to begin with instead of moving that code to a function later on.

May be that patch would be the right place to introduce a helper function. But I think it fine either way.

>>> +
>>> +static bool cxl_sbr_masked(struct pci_dev *dev)
>>> +{
>>> +	u16 dvsec, reg;
>>> +	int rc;
>>> +
>>> +	/*
>>> +	 * No DVSEC found, either is not a CXL port, or not connected in which
>>> +	 * case mask state is a nop (CXL r3.1 sec 9.12.3 "Enumerating CXL RPs
>>> +	 * and DSPs"
>>> +	 */
>>> +	dvsec = cxl_port_dvsec(dev);
>>> +	if (!dvsec)
>>> +		return false;
>>> +
>>> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
>>> +	if (rc || PCI_POSSIBLE_ERROR(reg))
>>> +		return false;
>>> +
>>> +	/*
>>> +	 * CXL spec r3.1 8.1.5.2
>>> +	 * When 0, SBR bit in Bridge Control register of this Port has no effect.
>>> +	 * When 1, the Port shall generate hot reset when SBR bit in Bridge
>>> +	 * Control gets set to 1.
>>> +	 */
>>> +	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
>>> +		return false;
>>> +
>>> +	return true;
>>> +}
>>> +
>>>  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>>>  {
>>> +	struct pci_dev *bridge = pci_upstream_bridge(dev);
>>>  	int rc;
>>>  
>>> +	/* If it's a CXL port and the SBR control is masked, fail the SBR */
>>> +	if (bridge && cxl_sbr_masked(bridge)) {
>>> +		if (probe)
>>> +			return 0;
>> Why return success during the probe?
> Otherwise the reset_method will disappear as available after initial probe. We want to leave the reset method available. If the register bit gets unmasked we can perform a bus reset. We don't want to take it away the option entirely if it's masked.

Ok.

>>> +
>>> +		return -ENOTTY;
>>> +	}
>>> +
>>>  	rc = pci_dev_reset_slot_function(dev, probe);
>>>  	if (rc != -ENOTTY)
>>>  		return rc;
>>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>>> index a39193213ff2..d61fa43662e3 100644
>>> --- a/include/uapi/linux/pci_regs.h
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -1148,4 +1148,9 @@
>>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>>>  
>>> +/* Compute Express Link (CXL) */
>>> +#define PCI_DVSEC_CXL_PORT				3
>>> +#define PCI_DVSEC_CXL_PORT_CTL				0x0c
>>> +#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>>> +
>>>  #endif /* LINUX_PCI_REGS_H */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


