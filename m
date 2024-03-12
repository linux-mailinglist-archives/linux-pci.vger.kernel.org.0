Return-Path: <linux-pci+bounces-4765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207D0879D8B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 22:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6C11F219A3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 21:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34914372E;
	Tue, 12 Mar 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuSjw6TV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6A142636;
	Tue, 12 Mar 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279332; cv=none; b=fibHV/HaEDptUXX6G1y6Izj9fYmWl8Id+jCXVjkwvDKxWieIzzJCnk3w3ka8PfkQxwHMgtdYjiKkRmaIjedZxCedXAr2gaaKJnNJ4HICdNBDB2KJTDqfR1I4M4llwUcxlc5MiUgk+/7yvW6JAgTa2LQ0KMhG6N+xsiIcGFvbFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279332; c=relaxed/simple;
	bh=XML562LF1d6RHMdbpv9ahIlWmITBcDunaVyk6YWAcgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQZtNieAwmQ1uz4IH7wI8doeQPGYiYC7jPaAlrT/bslLwfoDsDKkryeOj44Pr6mpFhWOd1KvSA347JlS/C8uA509NcWFeS8cCMK0kPiodtfGPgdUYq1zTcIZAh/mC2LlLHzl3gRAsDN8YlAp0kF3k096CDOgu5bOknXT60KDrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuSjw6TV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710279331; x=1741815331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XML562LF1d6RHMdbpv9ahIlWmITBcDunaVyk6YWAcgA=;
  b=PuSjw6TVQJrU3VSVwsyitisuMRDuE4tNeizPhWTMPKlKC3dc+1zU3ln9
   uFf9KG7EXZ02YcXt58Kt8iPhrxAtj0nhat3A9L+NfIwJyHANoFeUAGUbt
   3esytFyQrMvxvtHV+fu8Zdft9wIpT0a2z5BqLQMW9mrKXo/XCjxHRNdhc
   y/mgjw5gUj2NwnpnIjyJ6RVZ+o6Ia+uDst+2dXL66tEqh7kQeSyN9idWb
   MhzxBbG0LVFxpM6tHy40sjLEYaUs8RSTLWaXvx/SacR03Go+Bf76S9CkQ
   kdN6yeNSLXV2U86TMk+Kg2T3pyhqj3KjsjiAV/6qaqmLWJ+Vw7fsV3N7g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4946873"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4946873"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16271532"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.101.145]) ([10.212.101.145])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:35:29 -0700
Message-ID: <c50492a9-0fcc-47be-bce2-f5543587a5f2@intel.com>
Date: Tue, 12 Mar 2024 14:35:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: Add check for CXL Secondary Bus Reset
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 bhelgaas@google.com
References: <20240311204132.62757-1-dave.jiang@intel.com>
 <20240311204132.62757-2-dave.jiang@intel.com> <ZfAEncKttj9qFQHw@wunner.de>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZfAEncKttj9qFQHw@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/12/24 12:30 AM, Lukas Wunner wrote:
> On Mon, Mar 11, 2024 at 01:39:53PM -0700, Dave Jiang wrote:
>> +static bool is_cxl_device(struct pci_dev *dev)
>> +{
>> +	return pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
>> +					 CXL_DVSEC_PCIE_DEVICE);
>> +}
> 
> If this was my bikeshed, I'd call it pci_is_cxl() to match pci_is_pcie().

Ok will change.
> 
> 
>> +static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
>> +{
>> +	int dvsec;
>> +	int rc;
>> +	u16 reg;
> 
> Nit: Inverse Christmas tree?

Will change.
> 
> 
>>  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>>  {
>>  	int rc;
>>  
>> +	/* If it's a CXL port and the SBR control is masked, fail the SBR */
>> +	if (is_cxl_device(dev) && dev->bus->self &&
>> +	    is_cxl_port_sbr_masked(dev->bus->self)) {
>> +		if (probe)
>> +			return 0;
>> +
>> +		return -EPERM;
>> +	}
>> +
> 
> Is this also necessary if CONFIG_CXL_PCI=n?

Yes. As the kernel only loads type3 mem class CXL device driver. This is attempt to cover all CXL devices and not dependent on a loaded driver.

> 
> Return code on non-availability of a reset method is generally -ENOTTY.

Ok I can change it to that.

> Or is the choice deliberate to expose this reset method despite the bit
> being set and thus allow user space to unmask it in the first place?

Yes the idea is if user intentionally unmasks the bit via a user tool then reset can go through.

> 
> Also, we mostly use pci_upstream_bridge(dev) in lieu of dev->bus->self.
> Is the choice to use the latter deliberate because maybe is_virtfn is
> never set and the device can never be on the root bus?  (What about
> RCiEP CXL devices?)

I'll change to pci_upstream_bridge() call. I didn't realize that existed.

> 
> Thanks,
> 
> Lukas

