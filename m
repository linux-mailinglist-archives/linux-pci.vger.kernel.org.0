Return-Path: <linux-pci+bounces-29260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E1AAD2774
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A889B170C38
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F09021C9EB;
	Mon,  9 Jun 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCBNP3SA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C57310E3;
	Mon,  9 Jun 2025 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500252; cv=none; b=Av7iPCy85kS/6YipEfy58eW7oAa8hVpzyyi4nCtRph6u65qjfafCzyeAKno87ivwRx5T1XWqCKFSD5y3K/6EkHnykntFyDyy8/xfHPaI0lQSBF/0KAb66/4uU8rAt+rdDcmbt4QJQgn0Tn1YlkRSKzT4LM0gEtMMNtOktoG0V4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500252; c=relaxed/simple;
	bh=2m0fqy9xhWCweo0efmD2Kur2DN9ZUpbwrjKqN2ifTT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V4hqOKprU4zWP9qsAow8ZVVgrHo6SOWp3ZiSbXqyVknsYFcWm0UZuRTqvUW/khIpTYVz2ye+ph6e39JUhM8kFXyawzUM+FpS16W1Dckqv8hnOhRgT5PE3rPR1mGLx9AROigVYPcalsKelFEsICBA0VgVTmkoHN4LNwt9Js82U5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCBNP3SA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749500250; x=1781036250;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2m0fqy9xhWCweo0efmD2Kur2DN9ZUpbwrjKqN2ifTT4=;
  b=BCBNP3SAizWvVaSmODTWVTq8Bu/eMFbaGRDX1axbqVj02IoNSLpBTTUn
   R+WFI59zttS9QBbmSYHGPOUg/5GxrSgXmNywQBCf+bUaWWsk+UamhkyzD
   fYDaJGM4cHBoEZ0ygsEnCRuLPKFMDMNcj2nBYbWDVm3/GVoNwoOU4M3Yq
   96uAqXYYqcK4PZ5GfdBxbtg2ETDitBkjdVsDHUZUKSjk9NmRE3xWzJHG9
   9HnvWUj47yUGhX6qia3dxrgHP/u4EbHThsE0KcNlHzcbY6zXViKoLtkER
   RxuGNxzSLPLr/Y+DBEC6EF9PgeUOWUmGbDMbnBOKHBYrdCjtGpTbgmKZh
   g==;
X-CSE-ConnectionGUID: ArV9I6EtT2a7mxLkQCOmWg==
X-CSE-MsgGUID: 2txMPAzfROybfigXv8+KTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69037708"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="69037708"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:17:29 -0700
X-CSE-ConnectionGUID: iLYiB1McRu+0Tp57IJnzAQ==
X-CSE-MsgGUID: 533La9BeRcywKIL8WofBqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151493758"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:17:26 -0700
Message-ID: <4db30968-42a4-449c-9269-4817e4c89a46@intel.com>
Date: Mon, 9 Jun 2025 13:17:23 -0700
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
 <f1886301-3c5b-4c38-8003-dd6cdf43b945@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f1886301-3c5b-4c38-8003-dd6cdf43b945@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/25 4:15 PM, Bowman, Terry wrote:
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
>>
>>> +		return 0;
>>> +
>>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
>> I think you need to hold the pdev->dev lock while checking if the driver exists.
> Hi Dave,
> 
> Wouldn't a reference count increment prevent the driver from being unbound and thus
> make this access here to the driver safe (given the pci_dev_get() above)? And a lock
> would prevent concurrent access with a busy wait when the driver executes the next
> lock take?

Actually nothing prevents a driver from being unbound unless you are holding the device lock. Because device core needs the device lock in order to call driver removal [1]. So if you acquire the lock, either the driver is still bound and you are ok, or the driver is gone and there's nothing to do. The incremented refcount prevents ->release() of the device and the memory allocated for the device from being freed based on kref behavior [2].

[1]: https://elixir.bootlin.com/linux/v6.15.1/source/drivers/base/dd.c#L1292
[2]: https://elixir.bootlin.com/linux/v6.15.1/source/include/linux/kref.h#L48

DJ

> 
> Terry
> 
> [snip]
> 


