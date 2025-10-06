Return-Path: <linux-pci+bounces-37636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3468CBBF2AF
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 22:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89051897EBD
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DFE19E819;
	Mon,  6 Oct 2025 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAuBZ+Ss"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4C846F;
	Mon,  6 Oct 2025 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781834; cv=none; b=XiUPuDpHu7zkBlG7V3ID6R1wm2P9CC0DhXFoqipM8mu2sjK18t4Mhh2DFVQlb3LTRrHUFEMGBigUmAPrNk1sToIVaRUYuyhf8Tak4l8FCrt48r+3b5DiHbzl60dl1WIMuR8acxmHUxCsuyukdbs9++3uPa67p3PiLtHKYZrd5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781834; c=relaxed/simple;
	bh=+oT/xuytsjmBWaOYYjWmCBaW4i4nhXKCXQF1DctjriA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGa1yn5SHeDYzjdcLnF/rVQm58+TWsrHvOTCxHcggC4PytK74TW/pChZFO1pPPK9xcp5cJmhJTwVmtP0II9MOlqOHQRMqWtCxGc/f4oJMmEdfEu21lWoBwhwWB1lXHQXWYd3qSkQ3N4whUjJ9xvYToYychYrVMFDcVVPHUVUh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAuBZ+Ss; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759781833; x=1791317833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+oT/xuytsjmBWaOYYjWmCBaW4i4nhXKCXQF1DctjriA=;
  b=eAuBZ+SsXPQHDRizP2yBrTO4CRhY5C45khVOEOWGr9Pgg5t/+S3iFV9y
   5081paK8YxoN2VrgsFiGYUKhwD5MaX907ftcNgZFQ8ZciN0liThcEzMQh
   /9D9il57FaE3Qjbku7wHt1n4zz1GsFDIWx85ErvYA24xZpeposdYm4wwH
   ZDWFyMcC7uL59UbnnzzW3/hI26Bf/F3MaedHadWWKjIbErCfkG69pOaNW
   OkGjHPNpG8rpX4/ahzJm2htRelxnDIYo4UU9khnTpYpCalxfHWD99Puzb
   yffXdw+fTMwHWrlGNI3hHWE2bZeMAgyyfGO99V3LI9ifZhuUN21dN9YWt
   g==;
X-CSE-ConnectionGUID: 1WEFXnK8Rj2sQWNIS6S4Ag==
X-CSE-MsgGUID: wE4LinCuRFCOfJyCpX2nGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="73065434"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="73065434"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 13:17:13 -0700
X-CSE-ConnectionGUID: os7z3RI6RTmDyWYoEHB69Q==
X-CSE-MsgGUID: V9O7MdJ1TKKGda+HCy87dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="180762982"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.110]) ([10.125.110.110])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 13:17:10 -0700
Message-ID: <e54a790d-2fd9-4224-b9e8-96b3a4a5ff0e@intel.com>
Date: Mon, 6 Oct 2025 13:17:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 20/25] PCI/AER: Dequeue forwarded CXL error
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Terry Bowman <terry.bowman@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-21-terry.bowman@amd.com>
 <c38af7bc-140c-419f-9071-08eed448e585@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <c38af7bc-140c-419f-9071-08eed448e585@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/3/25 1:12 PM, Cheatham, Benjamin wrote:
> [snip]
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 1a4f61caa0db..c8f17233a18e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
> 
> Probably should just use EXPORT_SYMBOL_GPL() here. Doesn't make sense to export in the CXL namespace
> for a non-CXL specific function.

Typically unless the function is being used somewhere else besides CXL, it's probably good to reside in the CXL namespace. Of course it's up to Bjorn if he wants it different.

DJ

> 
>>  #endif
>>  
>>  /**
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 22e8f9a18a09..189b22ab2b1b 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -692,16 +692,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>>  void pci_rcec_init(struct pci_dev *dev);
>>  void pci_rcec_exit(struct pci_dev *dev);
>>  void pcie_link_rcec(struct pci_dev *rcec);
>> -void pcie_walk_rcec(struct pci_dev *rcec,
>> -		    int (*cb)(struct pci_dev *, void *),
>> -		    void *userdata);
>>  #else
>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> -				  int (*cb)(struct pci_dev *, void *),
>> -				  void *userdata) { }
>>  #endif
>>  
>>  #ifdef CONFIG_PCI_ATS
>> @@ -1081,7 +1075,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>>  static inline void pci_no_aer(void) { }
>>  static inline void pci_aer_init(struct pci_dev *d) { }
>>  static inline void pci_aer_exit(struct pci_dev *d) { }
>> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index ccefbcfe5145..e018531f5982 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -288,6 +288,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>  	if (status)
>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>  }
>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>>  
>>  /**
>>   * pci_aer_raw_clear_status - Clear AER error registers.
>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>> index d0bcd141ac9c..fb6cf6449a1d 100644
>> --- a/drivers/pci/pcie/rcec.c
>> +++ b/drivers/pci/pcie/rcec.c
>> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>>  
>>  	walk_rcec(walk_rcec_helper, &rcec_data);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
> 
> Same thing as above?
> 
>>  
>>  void pci_rcec_init(struct pci_dev *dev)
>>  {
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 6b2c87d1b5b6..64aef69fb546 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -66,6 +66,7 @@ struct cxl_proto_err_work_data {
>>  
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>  #else
>> @@ -73,6 +74,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  {
>>  	return -EINVAL;
>>  }
>> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>>  #endif
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index bc3a7b6d0f94..b8e36bde346c 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1825,6 +1825,9 @@ extern bool pcie_ports_native;
>>  
>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  			  bool use_lt);
>> +void pcie_walk_rcec(struct pci_dev *rcec,
>> +		    int (*cb)(struct pci_dev *, void *),
>> +		    void *userdata);
>>  #else
>>  #define pcie_ports_disabled	true
>>  #define pcie_ports_native	false
>> @@ -1835,8 +1838,14 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> +
>> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> +				  int (*cb)(struct pci_dev *, void *),
>> +				  void *userdata) { }
>>  #endif
>>  
>> +void pcie_clear_device_status(struct pci_dev *dev);
>> +
>>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
> 


