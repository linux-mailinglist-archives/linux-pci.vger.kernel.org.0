Return-Path: <linux-pci+bounces-40302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2634C33693
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 00:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E9818C53C7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED5434A3B2;
	Tue,  4 Nov 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqso4c7M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE873491D1;
	Tue,  4 Nov 2025 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299834; cv=none; b=KdKvBp9pdEdsbVo7XZSfIZRR9lUyS+mYOOYV3bGOc1kTwXFoUO4pKc6AmJc7/dGNySsiBIkHAhGCnmx7VrKWyZ0fwCpOPcCTIK92yl4A7RlHrD4GjFR6jQNeEKg3VTLTEsZiW+kocv5JQhzfqDJW6zDyliMFS86zAFMs6GFKfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299834; c=relaxed/simple;
	bh=UK4vZIITwF8JjEK52jIihmjwyoZkH/d/GKDEqOLnalM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dr640OJ2SDfnziYIKEGlSUX5PEiRjPWvSxmNmo9Z4zsGA83iCHi2p6YVKNDqUUugfYtj1/CBPQKe/oPRLdaklPtND/pkgAponQ5viARWQYt2mBvbe+1FiKVHH3hUJAL+6JIAE+hrQNvxGu/M3wGQxOqDWLRMvv9Azt4AlJ8CHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqso4c7M; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762299833; x=1793835833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UK4vZIITwF8JjEK52jIihmjwyoZkH/d/GKDEqOLnalM=;
  b=gqso4c7MEIpCn0OyhyhmMLBOZjrDL/eXDHqpubZWkQAgX8+4uIv0Dpuq
   VV4qfqhVgGjjN3Z5mtEbJwLODFTq58wXqPkr/R7Ha3Ob6H0+3A0syj9CN
   XIP7osANKv6k7sQejm2IRp2gax7PAlTfWGqfQN041TI0mn7fN8Qt9/D5O
   h3I2NtuuMdabX0K+wS2UNNlGB9xvF2YrJ2D5v7j5XsjAV8CGQPu3Y02oK
   pDRRuSGdO7xhqJQjTfbZZhXi4jDxlbtiBpdiMwb2+7SZmSUSxCUkZ1xE7
   +moM1PQmuMFhVLagR/SCfxTo5qxcQjuvu/7WBF9HOygPRm0fc55x8vu2n
   w==;
X-CSE-ConnectionGUID: AWl3T8u2Qb2oetwvvtWfyA==
X-CSE-MsgGUID: 5tiYunuiRgq3rE+an69i0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75087563"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="75087563"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:43:50 -0800
X-CSE-ConnectionGUID: 9zGA8ibxTyeDzR6kveuCaw==
X-CSE-MsgGUID: tX17l40aT4S+E3c0b+KDeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="187238881"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:43:48 -0800
Message-ID: <10115294-8be9-42af-a466-40a194cfa4e8@intel.com>
Date: Tue, 4 Nov 2025 16:43:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 23/25] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, alison.schofield@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-24-terry.bowman@amd.com>
 <20251104184732.0000362f@huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251104184732.0000362f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 11:47 AM, Jonathan Cameron wrote:
> On Tue, 4 Nov 2025 11:03:03 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> Implement cxl_do_recovery() to handle uncorrectable protocol
>> errors (UCE), following the design of pcie_do_recovery(). Unlike PCIe,
>> all CXL UCEs are treated as fatal and trigger a kernel panic to avoid
>> potential CXL memory corruption.
>>
>> Add cxl_walk_port(), analogous to pci_walk_bridge(), to traverse the
>> CXL topology from the error source through downstream CXL ports and
>> endpoints.
>>
>> Introduce cxl_report_error_detected(), mirroring PCI's
>> report_error_detected(), and implement device locking for the affected
>> subtree. Endpoints require locking the PCI device (pdev->dev) and the
>> CXL memdev (cxlmd->dev). CXL ports require locking the PCI
>> device (pdev->dev) and the parent CXL port.
>>
>> The device locks should be taken early where possible. The initially
>> reporting device will be locked after kfifo dequeue. Iterated devices
>> will be locked in cxl_report_error_detected() and must lock the
>> iterated devices except for the first device as it has already been
>> locked.
>>
>> Export pci_aer_clear_fatal_status() for use when a UCE is not present.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Follow on comments around the locking stuff. If that has been there
> a while and I didn't notice before, sorry!
> 
>>
>> ---
>>
>> Changes in v12->v13:
>> - Add guard() before calling cxl_pci_drv_bound() (Dave Jiang)
>> - Add guard() calls for EP (cxlds->cxlmd->dev & pdev->dev) and ports
>>   (pdev->dev & parent cxl_port) in cxl_report_error_detected() and
>>   cxl_handle_proto_error() (Terry)
>> - Remove unnecessary check for endpoint port. (Dave Jiang)
>> - Remove check for RCIEP EP in cxl_report_error_detected(). (Terry)
>>
>> Changes in v11->v12:
>> - Clean up port discovery in cxl_do_recovery() (Dave)
>> - Add PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()
>>
>> Changes in v10->v11:
>> - pci_ers_merge_results() - Move to earlier patch
>> ---
>>  drivers/cxl/core/ras.c | 135 ++++++++++++++++++++++++++++++++++++++++-
>>  drivers/pci/pci.h      |   1 -
>>  drivers/pci/pcie/aer.c |   1 +
>>  include/linux/aer.h    |   2 +
>>  4 files changed, 135 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 5bc144cde0ee..52c6f19564b6 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -259,8 +259,138 @@ static void device_unlock_if(struct device *dev, bool take)
>>  		device_unlock(dev);
>>  }
>>  
>> +/**
>> + * cxl_report_error_detected
>> + * @dev: Device being reported
>> + * @data: Result
>> + * @err_pdev: Device with initial detected error. Is locked immediately
>> + *            after KFIFO dequeue.
>> + */
>> +static int cxl_report_error_detected(struct device *dev, void *data, struct pci_dev *err_pdev)
>> +{
>> +	bool need_lock = (dev != &err_pdev->dev);
> 
> Add a comment on why this controls need for locking.
> The resulting code is complex enough I'd be tempted to split the whole
> thing into locked and unlocked variants.

May not be a bad idea. Terry, can you see if this would reduce the complexity?

DJ 

> 
>> +	pci_ers_result_t vote, *result = data;
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return 0;
>> +	pdev = to_pci_dev(dev);
>> +
>> +	device_lock_if(&pdev->dev, need_lock);
>> +	if (is_pcie_endpoint(pdev) && !cxl_pci_drv_bound(pdev)) {
>> +		device_unlock_if(&pdev->dev, need_lock);
>> +		return PCI_ERS_RESULT_NONE;
>> +	}
>> +
>> +	if (pdev->aer_cap)
>> +		pci_clear_and_set_config_dword(pdev,
>> +					       pdev->aer_cap + PCI_ERR_COR_STATUS,
>> +					       0, PCI_ERR_COR_INTERNAL);
>> +
>> +	if (is_pcie_endpoint(pdev)) {
>> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +
>> +		device_lock_if(&cxlds->cxlmd->dev, need_lock);
>> +		vote = cxl_error_detected(&cxlds->cxlmd->dev);
>> +		device_unlock_if(&cxlds->cxlmd->dev, need_lock);
>> +	} else {
>> +		vote = cxl_port_error_detected(dev);
>> +	}
>> +
>> +	pcie_clear_device_status(pdev);
>> +	*result = pcie_ers_merge_result(*result, vote);
>> +	device_unlock_if(&pdev->dev, need_lock);
>> +
>> +	return 0;
>> +}
> 
>> +
>> +/**
>> + * cxl_walk_port
> Needs a short description I think to count as valid kernel-doc and
> stop the tool moaning if anyone runs it on this.
> 
>> + *
>> + * @port: Port be traversed into
>> + * @cb: Callback for handling the CXL Ports
>> + * @userdata: Result
>> + * @err_pdev: Device with initial detected error. Is locked immediately
>> + *            after KFIFO dequeue.
>> + */
>> +static void cxl_walk_port(struct cxl_port *port,
>> +			  int (*cb)(struct device *, void *, struct pci_dev *),
>> +			  void *userdata,
>> +			  struct pci_dev *err_pdev)
>> +{
>> +	struct cxl_port *err_port __free(put_cxl_port) = get_cxl_port(err_pdev);
>> +	bool need_lock = (port != err_port);
>> +	struct cxl_dport *dport = NULL;
>> +	unsigned long index;
>> +
>> +	device_lock_if(&port->dev, need_lock);
>> +	if (is_cxl_endpoint(port)) {
>> +		cb(port->uport_dev->parent, userdata, err_pdev);
>> +		device_unlock_if(&port->dev, need_lock);
>> +		return;
>> +	}
>> +
>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>> +		cb(port->uport_dev, userdata, err_pdev);
>> +
>> +	/*
>> +	 * Iterate over the set of Downstream Ports recorded in port->dports (XArray):
>> +	 *  - For each dport, attempt to find a child CXL Port whose parent dport
>> +	 *    match.
>> +	 *  - Invoke the provided callback on the dport's device.
>> +	 *  - If a matching child CXL Port device is found, recurse into that port to
>> +	 *    continue the walk.
>> +	 */
>> +	xa_for_each(&port->dports, index, dport)
>> +	{
> 
> Move that to line above for normal kernel loop formatting.
> 
> 	xa_for_each(&port->dports, index, dport) {
> 
>> +		struct device *child_port_dev __free(put_device) =
>> +			bus_find_device(&cxl_bus_type, &port->dev, dport->dport_dev,
>> +					match_port_by_parent_dport);
>> +
>> +		cb(dport->dport_dev, userdata, err_pdev);
>> +		if (child_port_dev)
>> +			cxl_walk_port(to_cxl_port(child_port_dev), cb, userdata, err_pdev);
>> +	}
>> +	device_unlock_if(&port->dev, need_lock);
>> +}
>> +
> 
>>  
>>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>> @@ -483,16 +613,15 @@ static void cxl_proto_err_work_fn(struct work_struct *work)
>>  			if (!cxl_pci_drv_bound(pdev))
>>  				return;
>>  			cxlmd_dev = &cxlds->cxlmd->dev;
>> -			device_lock_if(cxlmd_dev, cxlmd_dev);
>>  		} else {
>>  			cxlmd_dev = NULL;
>>  		}
>>  
>> +		/* Lock the CXL parent Port */
>>  		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> -		if (!port)
>> -			return;
>>  		guard(device)(&port->dev);
>>  
>> +		device_lock_if(cxlmd_dev, cxlmd_dev);
>>  		cxl_handle_proto_error(&wd);
>>  		device_unlock_if(cxlmd_dev, cxlmd_dev);
> Same issue on these helpers, but I'm also not sure why moving them in this
> patch makes sense. I'm not sure what changed.
> 
> Perhaps this is stuff that ended up in wrong patch?
>>  	}
> 
> 


