Return-Path: <linux-pci+bounces-29120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB57AD0A06
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 00:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC08E1899838
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 22:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2593A2367A4;
	Fri,  6 Jun 2025 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCaW670m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BBB1EF091;
	Fri,  6 Jun 2025 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749249808; cv=none; b=WFedeyE7lzq1Rm2UHU2pJhGW+72YUhEwpC4izrkY3LCDrPVlRMEl9NHosF73fEdMucEJC6TaBo0/8evL88C2ye5hao3xlw/ajYjzmXz++H7NxmWmc7/Ur+sJmsRFbKSh6wuGfa+BE+Z7eP1WlK0AwRFcF/UFvonOI6BOF049mCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749249808; c=relaxed/simple;
	bh=4yGBvyJ73VZFkxUL6/oSJlM3aKp895GwbFUG4Jge2nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lLtYnUeqUT3OR/Dcui0kxpR0hnlfH8eiSM6H6JICxKf8rIh4wksjXP0O8hHefK4v4EDnyS5X+YAR9GwosH9UCKuwZrYhiIto+I15I+zEbbiir8gpoPPOjNUbSkQnx1kKNzzRI5OoJETDcQOHBTRNkWgAzbl8paGqDTVVbqPBZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCaW670m; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749249806; x=1780785806;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4yGBvyJ73VZFkxUL6/oSJlM3aKp895GwbFUG4Jge2nU=;
  b=WCaW670mn+EKKShe231yz2LeEjeyIbAUZnT+a5b7b9Ybb5e5+0GK5b6Y
   cCFcbBSxzUaut1w0IcMWfXqPG4LmcmSvbX1QnhoBEDxTFrON69tBFodfM
   khGkWQH6PEsqCROqXjkW8cDcAXckQHsMETbyabePDtFIPfVaHBbFi+Hku
   pUahT9VUuRMinMG4uVKTf14tEz9ZfF/TX6eirTNiiJsOzteBboOaJxFvK
   KUrzrwQWNCIBH8vyOZ2nepklJrJxpNEBkxW4iWKWEChXG0PDAVsHp6Hez
   5m2Lj+2s1VZ09v9jhI1s9udugKSTfKR/CpeVEmy+zyrGMaLvcVh+mywf5
   w==;
X-CSE-ConnectionGUID: Aw/qEwm9R4CjHjo4nGQy5g==
X-CSE-MsgGUID: nxvyN1cqTi+oqJGPqGrBew==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="62803797"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="62803797"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 15:43:25 -0700
X-CSE-ConnectionGUID: wWHliW8ZR7aDvewJAHsZ8A==
X-CSE-MsgGUID: SH/cm56GRb2sOrCksKDs9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="176891392"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.33]) ([10.125.111.33])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 15:43:23 -0700
Message-ID: <180a024d-9f93-4439-b25c-808a22665d2a@intel.com>
Date: Fri, 6 Jun 2025 15:43:22 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
To: "Bowman, Terry" <terry.bowman@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org,
 coly.li@suse.de, uaisheng.ye@intel.com,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
 <81214183-fd94-428b-abeb-3ec3d2688030@intel.com>
 <c013da01-dc6b-470f-9dbb-e209e293763a@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <c013da01-dc6b-470f-9dbb-e209e293763a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/25 11:14 AM, Bowman, Terry wrote:
> 
> 
> On 6/6/2025 10:57 AM, Dave Jiang wrote:
>>
>> On 6/3/25 10:22 AM, Terry Bowman wrote:
>>> The AER driver is now designed to forward CXL protocol errors to the CXL
>>> driver. Update the CXL driver with functionality to dequeue the forwarded
>>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>>> error handling processing using the work received from the FIFO.
>>>
>>> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
>>> AER service driver. This will begin the CXL protocol error processing
>>> with a call to cxl_handle_prot_error().
>>>
>>> Update cxl/core/ras.c by adding cxl_rch_handle_error_iter() that was
>>> previously in the AER driver.
>>>
>>> Introduce sbdf_to_pci() to take the SBDF values from 'struct cxl_prot_error_info'
>>> and use in discovering the erring PCI device. Make scope based reference
>>> increments/decrements for the discovered PCI device and the associated
>>> CXL device.
>>>
>>> Implement cxl_handle_prot_error() to differentiate between Restricted CXL
>>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
>>> RCH errors will be processed with a call to walk the associated Root
>>> Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
>>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
>>> so the CXL driver can walk the RCEC's downstream bus, searching for
>>> the RCiEP.
>>>
>>> VH correctable error (CE) processing will call the CXL CE handler. VH
>>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>>> and pci_clean_device_status() used to clean up AER status after handling.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> ---
>>>  drivers/cxl/core/ras.c  | 92 +++++++++++++++++++++++++++++++++++++++++
>>>  drivers/pci/pci.c       |  1 +
>>>  drivers/pci/pci.h       |  8 ----
>>>  drivers/pci/pcie/aer.c  |  1 +
>>>  drivers/pci/pcie/rcec.c |  1 +
>>>  include/linux/aer.h     |  2 +
>>>  include/linux/pci.h     | 10 +++++
>>>  7 files changed, 107 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>> index d35525e79e04..9ed5c682e128 100644
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> @@ -110,8 +110,100 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>>  
>>>  #ifdef CONFIG_PCIEAER_CXL
>>>  
>>> +static void cxl_do_recovery(struct pci_dev *pdev)
>>> +{
>>> +}
>>> +
>>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>>> +{
>>> +	struct cxl_prot_error_info *err_info = data;
>>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
>>> +	struct cxl_dev_state *cxlds;
>>> +
>>> +	/*
>>> +	 * The capability, status, and control fields in Device 0,
>>> +	 * Function 0 DVSEC control the CXL functionality of the
>>> +	 * entire device (CXL 3.0, 8.1.3).
>>> +	 */
>>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>>> +	 * 3.0, 8.1.12.1).
>>> +	 */
>>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
>> Should use FIELD_GET() to be consistent with the rest of CXL code base
> 
> Ok.
> 
>>> +		return 0;
>>> +
>>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
>> I think you need to hold the pdev->dev lock while checking if the driver exists.
> Ok.
>>> +		return 0;
>>> +
>>> +	cxlds = pci_get_drvdata(pdev);
>>> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> Maybe a comment on why cxlmd->dev ref is needed here.
> Good point.
>>> +
>>> +	if (err_info->severity == AER_CORRECTABLE)
>>> +		cxl_cor_error_detected(pdev);
>>> +	else
>>> +		cxl_do_recovery(pdev);
>>> +
>>> +	return 1;
>>> +}
>>> +
>>> +static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>>> +{
>>> +	unsigned int devfn = PCI_DEVFN(err_info->device,
>>> +				       err_info->function);
>>> +	struct pci_dev *pdev __free(pci_dev_put) =
>>> +		pci_get_domain_bus_and_slot(err_info->segment,
>>> +					    err_info->bus,
>>> +					    devfn);
>> Looks like DanC already caught that. Maybe have this function return with a ref held. I would also add a comment for the function mention that the caller need to put the device.
> Right. I made the change in v10 source after DanC commented. I'll add a comment that callers must decrement the reference count..
>>> +	return pdev;
>>> +}
>>> +
>>> +static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>>> +{
>>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
>>> +
>>> +	if (!pdev) {
>>> +		pr_err("Failed to find the CXL device\n");
>>> +		return;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Internal errors of an RCEC indicate an AER error in an
>>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>>> +	 * device driver.
>>> +	 */
>>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
>>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>>> +
>> cxl_rch_handle_error_iter() holds the pdev device lock when handling errors. Does the code block below need locking?
>>
>> DJ
> There is a guard_lock() in the EP CXL error handlers (cxl_error_detected()/cxl_cor_error_detected()). I have question about
> the same for the non-EP handlers added later: should we add the same guard() for the CXL port handlers? That is in following patch:
> [PATCH v9 13/16] cxl/pci: Introduce CXL Port protocol error handlers.

I would think so....

DJ

> 
> Terry
>>> +	if (err_info->severity == AER_CORRECTABLE) {
>>> +		int aer = pdev->aer_cap;
>>> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> +		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>>> +
>>> +		if (aer)
>>> +			pci_clear_and_set_config_dword(pdev,
>>> +						       aer + PCI_ERR_COR_STATUS,
>>> +						       0, PCI_ERR_COR_INTERNAL);
>>> +
>>> +		cxl_cor_error_detected(pdev);
>>> +
>>> +		pcie_clear_device_status(pdev);
>>> +	} else {
>>> +		cxl_do_recovery(pdev);
>>> +	}
>>> +}
>>> +
>>>  static void cxl_prot_err_work_fn(struct work_struct *work)
>>>  {
>>> +	struct cxl_prot_err_work_data wd;
>>> +
>>> +	while (cxl_prot_err_kfifo_get(&wd)) {
>>> +		struct cxl_prot_error_info *err_info = &wd.err_info;
>>> +
>>> +		cxl_handle_prot_error(err_info);
>>> +	}
>>>  }
>>>  
>>>  #else
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index e77d5b53c0ce..524ac32b744a 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>>  }
>>> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>>>  #endif
>>>  
>>>  /**
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index d6296500b004..3c54a5ed803e 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -649,16 +649,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>>>  void pci_rcec_init(struct pci_dev *dev);
>>>  void pci_rcec_exit(struct pci_dev *dev);
>>>  void pcie_link_rcec(struct pci_dev *rcec);
>>> -void pcie_walk_rcec(struct pci_dev *rcec,
>>> -		    int (*cb)(struct pci_dev *, void *),
>>> -		    void *userdata);
>>>  #else
>>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>>>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>>> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
>>> -				  int (*cb)(struct pci_dev *, void *),
>>> -				  void *userdata) { }
>>>  #endif
>>>  
>>>  #ifdef CONFIG_PCI_ATS
>>> @@ -967,7 +961,6 @@ void pci_no_aer(void);
>>>  void pci_aer_init(struct pci_dev *dev);
>>>  void pci_aer_exit(struct pci_dev *dev);
>>>  extern const struct attribute_group aer_stats_attr_group;
>>> -void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>>  int pci_aer_clear_status(struct pci_dev *dev);
>>>  int pci_aer_raw_clear_status(struct pci_dev *dev);
>>>  void pci_save_aer_state(struct pci_dev *dev);
>>> @@ -976,7 +969,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>>>  static inline void pci_no_aer(void) { }
>>>  static inline void pci_aer_init(struct pci_dev *d) { }
>>>  static inline void pci_aer_exit(struct pci_dev *d) { }
>>> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index 5350fa5be784..6e88331c6303 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -290,6 +290,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>>  	if (status)
>>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>>  }
>>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>>>  
>>>  /**
>>>   * pci_aer_raw_clear_status - Clear AER error registers.
>>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>>> index d0bcd141ac9c..fb6cf6449a1d 100644
>>> --- a/drivers/pci/pcie/rcec.c
>>> +++ b/drivers/pci/pcie/rcec.c
>>> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>>>  
>>>  	walk_rcec(walk_rcec_helper, &rcec_data);
>>>  }
>>> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
>>>  
>>>  void pci_rcec_init(struct pci_dev *dev)
>>>  {
>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>> index 550407240ab5..c9a18eca16f8 100644
>>> --- a/include/linux/aer.h
>>> +++ b/include/linux/aer.h
>>> @@ -77,12 +77,14 @@ struct cxl_prot_err_work_data {
>>>  
>>>  #if defined(CONFIG_PCIEAER)
>>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>>  int pcie_aer_is_native(struct pci_dev *dev);
>>>  #else
>>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>  {
>>>  	return -EINVAL;
>>>  }
>>> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>>  #endif
>>>  
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index bff3009f9ff0..cd53715d53f3 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -1806,6 +1806,9 @@ extern bool pcie_ports_native;
>>>  
>>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>>  			  bool use_lt);
>>> +void pcie_walk_rcec(struct pci_dev *rcec,
>>> +		    int (*cb)(struct pci_dev *, void *),
>>> +		    void *userdata);
>>>  #else
>>>  #define pcie_ports_disabled	true
>>>  #define pcie_ports_native	false
>>> @@ -1816,8 +1819,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>>>  {
>>>  	return -EOPNOTSUPP;
>>>  }
>>> +
>>> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
>>> +				  int (*cb)(struct pci_dev *, void *),
>>> +				  void *userdata) { }
>>> +
>>>  #endif
>>>  
>>> +void pcie_clear_device_status(struct pci_dev *dev);
>>> +
>>>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>>>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>>>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
> 
> 


