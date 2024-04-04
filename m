Return-Path: <linux-pci+bounces-5644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3551C897CFD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 02:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE71328DC66
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C23D647;
	Thu,  4 Apr 2024 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aE7C3M0M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F18367;
	Thu,  4 Apr 2024 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190083; cv=none; b=rR6ifs2/fmCaeMqRluloBo4DlEQrX2c1ypI33DcLK4lRcNaoqOJvM/uBIrYGLasTTK/dVCsA4g40PkdWfxXOJ80B7MqP7taEvHTXkJnSxrS7o7E2CBJAwooo2JuRncKIWCDbW16Mz0tmbpFapR7f7A2KW8x31axAca7rycoanmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190083; c=relaxed/simple;
	bh=vFTQ82vo8wGIbhelQLMSbqColCwk5sKeS/9E2qjoF8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgem2FPuxSRj5hng0ORp9weddmmZSqu26VqL3S+x6CRrcQYRkGzXvbXh0fU0Pr5N8LYBvCcYydV5YccbUmtYjynLzk0QwovKtQc50CpZoEptPUgkNDapNfDXQLfPceM47OBSDmVJLpqJMBNhyUMhdV0/IKa03ICTlIXMhZ/YWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aE7C3M0M; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712190081; x=1743726081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vFTQ82vo8wGIbhelQLMSbqColCwk5sKeS/9E2qjoF8M=;
  b=aE7C3M0MXJte8Acv3RETZShxJFETavivQvwYkZmEdCwZbr4IhtwyQP0H
   WG1G88ESbzKIHVxuvw6977cTdDszSex1tCm66y+FZlJdZC5WGWWrivK8S
   sjiDpwr3mwPXIvjal2THErw6dOSIUNoc2HX9fc4UMRwsNMr7OuFpVk8RK
   MdCcH/ruXAD+Ts0iPE3ockh844FAvHhzILB+N7GXT5DWNGjEkIXPHwdDu
   KJqQsAKv/hHK2+ncC+R7JOtE+SzViV6Dkpt3pTKrF5Gpu4bkk567SIaNf
   K3HfUWPsJSzr6wF5rB8bJrv1Zh/9r8gVFyCyo314uZyrSuS/38a+pPWXU
   w==;
X-CSE-ConnectionGUID: uga1aK/3SKy/XsuBGWycBA==
X-CSE-MsgGUID: ow57S+uuRSCvJaVIJOZJMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7323862"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7323862"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 17:21:21 -0700
X-CSE-ConnectionGUID: uf4d4fHeT2SKBUWxYb6q0Q==
X-CSE-MsgGUID: JneW1IhoTLOEExVvXt62NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="23072107"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.162.81]) ([10.213.162.81])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 17:21:20 -0700
Message-ID: <3d4a14a8-7720-4ecc-9099-1bb94b3e7013@intel.com>
Date: Wed, 3 Apr 2024 17:21:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PCI: Create new reset method to force SBR for CXL
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net, bhelgaas@google.com,
 lukas@wunner.de
References: <20240402234848.3287160-1-dave.jiang@intel.com>
 <20240402234848.3287160-4-dave.jiang@intel.com>
 <20240403160911.000016c0@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240403160911.000016c0@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/3/24 8:09 AM, Jonathan Cameron wrote:
> On Tue, 2 Apr 2024 16:45:31 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> CXL spec r3.1 8.1.5.2
>> By default Secondary Bus Reset (SBR) is masked for CXL ports. Introduce a
>> new PCI reset method "cxl_bus" to force SBR on CXL ports by setting
>> the unmask SBR bit in the CXL DVSEC port control register before performing
>> the bus reset and restore the original value of the bit post reset. The
>> new reset method allows the user to intentionally perform SBR on a CXL
>> device without needing to set the "Unmask SBR" bit via a user tool.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> A few trivial things inline.  Otherwise looks fine.
> 
> FWIW
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>> v3:
>> - move cxl_port_dvsec() to previous patch. (Dan)
>> - add pci_cfg_access_lock() for the bridge. (Dan)
>> - Change cxl_bus_force method to cxl_bus. (Dan)
>> ---
>>  drivers/pci/pci.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci.h |  2 +-
>>  2 files changed, 45 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 00eddb451102..3989c8888813 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4982,6 +4982,49 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>>  	return pci_parent_bus_reset(dev, probe);
>>  }
>>  
>> +static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>> +{
>> +	struct pci_dev *bridge;
>> +	int dvsec;
> 
> Lukas' comment on previous applies to this as well.

ok

> 
>> +	int rc;
>> +	u16 reg, val;
> 
> Maybe combine lines as appropriate.

ok

> 
>> +
>> +	bridge = pci_upstream_bridge(dev);
>> +	if (!bridge)
>> +		return -ENOTTY;
>> +
>> +	dvsec = cxl_port_dvsec(bridge);
>> +	if (!dvsec)
>> +		return -ENOTTY;
>> +
>> +	if (probe)
>> +		return 0;
>> +
>> +	pci_cfg_access_lock(bridge);
>> +	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
>> +	if (rc) {
>> +		rc = -ENOTTY;
>> +		goto out;
>> +	}
>> +
>> +	if (!(reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)) {
>> +		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
>> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>> +				      val);
>> +	} else {
>> +		val = reg;
>> +	}
>> +
>> +	rc = pci_reset_bus_function(dev, probe);
>> +
>> +	if (reg != val)
>> +		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, reg);
>> +
>> +out:
>> +	pci_cfg_access_unlock(bridge);
> 
> Maybe a guard() use case to allow early returns in error paths?

I'm not seeing a good way to do it. pci_cfg_access_lock/unlock() isn't like your typical lock/unlock. It locks, changes some pci_dev internal stuff, and then unlocks in both functions. The pci_lock isn't being held after lock() call.

> 
>> +	return rc;
>> +}
>> +
>>  void pci_dev_lock(struct pci_dev *dev)
>>  {
>>  	/* block PM suspend, driver probe, etc. */
>> @@ -5066,6 +5109,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>>  	{ pci_af_flr, .name = "af_flr" },
>>  	{ pci_pm_reset, .name = "pm" },
>>  	{ pci_reset_bus_function, .name = "bus" },
>> +	{ cxl_reset_bus_function, .name = "cxl_bus" },
>>  };
>>  
>>  static ssize_t reset_method_show(struct device *dev,
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 16493426a04f..235f37715a43 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -51,7 +51,7 @@
>>  			       PCI_STATUS_PARITY)
>>  
>>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
>> -#define PCI_NUM_RESET_METHODS 7
>> +#define PCI_NUM_RESET_METHODS 8
>>  
>>  #define PCI_RESET_PROBE		true
>>  #define PCI_RESET_DO_RESET	false
> 

