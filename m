Return-Path: <linux-pci+bounces-33251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD18B17564
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56FD62838F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000942264BC;
	Thu, 31 Jul 2025 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VApVAH+G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F572637;
	Thu, 31 Jul 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981490; cv=none; b=AUeq4N4Ig929ffq24vHGOdIPjMTVCVboa88pZxS2TXrFpOCios0X2j9Kac0yVYCA18GityZqZ1zhXC1joaG5Hrnl+Febq77hdufwyqAQDZDWwF0GSx3fdOEvkzpPMQDFNXTya23iuCWaKfq/TGE+OH1uLnA41/oi3QtnKof/rYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981490; c=relaxed/simple;
	bh=m0YH97sXQRmjbG9xHs4D9l3xM41GzX9EBnf6R6A8CU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QG2l6FeR/v5AXucN5rJDPImxOVnO6OIMxILSH6UwLGWqg7Fo8nTetz87eQjyxyocST3sEJApwWwMBS/a/hiLJtAbaT1P7Y+XfYHHmXw6rf0f8mDMGe7NNmcwSROdvpPa6hxrNamrJYWP+bnI4uKoM5kFurXDtycpvnnJfAFSIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VApVAH+G; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753981489; x=1785517489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m0YH97sXQRmjbG9xHs4D9l3xM41GzX9EBnf6R6A8CU0=;
  b=VApVAH+G3ChjbL8cB4X/8CxISQyy7AsM1rlOZCFUH+GtroUJG2yi9fTJ
   VpwZgxAF0CYpk4uKKzDVaomXsiB3bLN1UcCYIipQX2blYVlrUaaLOAIS0
   2Cb9ez6TOg424MHRVBjrSls/v0heqpierr6CxkDbH2+HNgn1vnNC9yQZA
   kPTm/3A/jGlOoLT3/irHMi0JCtT1w8yavnfg3SyoN0qik3TBJ+VDVLDPc
   Muyb0DIc6qqGwz+KjmymRu+Wm5W1jfBvBugJc++jWYs6kQEH0yuwRNy5p
   qq7FFuIEONYhxjqiFp1aEgXYzr0nEVp89QgWv3Ou0MgSClnQq2YpzQ9Gm
   g==;
X-CSE-ConnectionGUID: pKFMrZ0qSjCCDIm0K+Q/5A==
X-CSE-MsgGUID: Wtl4W2yORjOTr5v/oE78MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="73773596"
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; 
   d="scan'208";a="73773596"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 10:04:39 -0700
X-CSE-ConnectionGUID: /HdguQcrRuSrI4tW/hco+w==
X-CSE-MsgGUID: 8Jq8hCUQSzSgrKeF61LPPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; 
   d="scan'208";a="163327978"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 10:04:40 -0700
Received: from [10.124.222.117] (unknown [10.124.222.117])
	by linux.intel.com (Postfix) with ESMTP id 861D620B571C;
	Thu, 31 Jul 2025 10:04:38 -0700 (PDT)
Message-ID: <4969c441-fe2a-470f-9efd-4661efca56ec@linux.intel.com>
Date: Thu, 31 Jul 2025 10:04:38 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI/AER: Fix missing uevent on recovery when a
 reset is requested
To: Lukas Wunner <lukas@wunner.de>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Linas Vepstas <linasvepstas@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Oliver O'Halloran
 <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com>
 <20250730-add_err_uevents-v3-1-540b158c070f@linux.ibm.com>
 <aIp6LiKJor9KLVpv@wunner.de> <aIp_Z9IdwSjMtDho@wunner.de>
 <aItpKIhYr0T8jf7A@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aItpKIhYr0T8jf7A@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/31/25 6:01 AM, Lukas Wunner wrote:
> On Wed, Jul 30, 2025 at 10:24:07PM +0200, Lukas Wunner wrote:
>> On Wed, Jul 30, 2025 at 10:01:50PM +0200, Lukas Wunner wrote:
>>> On Wed, Jul 30, 2025 at 01:20:57PM +0200, Niklas Schnelle wrote:
>>>> Since commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery
>>>> status for udev") AER uses the result of error_detected() as parameter
>>>> to pci_uevent_ers(). As pci_uevent_ers() however does not handle
>>>> PCI_ERS_RESULT_NEED_RESET this results in a missing uevent for the
>>>> beginning of recovery if drivers request a reset. Fix this by treating
>>>> PCI_ERS_RESULT_NEED_RESET as beginning recovery.
>>> [...]
>>>> +++ b/drivers/pci/pci-driver.c
>>>> @@ -1592,6 +1592,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum pci_ers_result err_type)
>>>>   	switch (err_type) {
>>>>   	case PCI_ERS_RESULT_NONE:
>>>>   	case PCI_ERS_RESULT_CAN_RECOVER:
>>>> +	case PCI_ERS_RESULT_NEED_RESET:
>>>>   		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
>>>>   		envp[idx++] = "DEVICE_ONLINE=0";
>>>>   		break;
>>> I note that PCI_ERS_RESULT_NO_AER_DRIVER is also missing in that
>>> switch/case statement.  I guess for the patch to be complete,
>>> it needs to be added to the PCI_ERS_RESULT_DISCONNECT case.
>>> Do you agree?
>> I realize now there's a bigger problem here:  In pcie_do_recovery(),
>> when control reaches the "failed:" label, a uevent is only signaled
>> for the *bridge*.  Shouldn't a uevent instead be signaled for every
>> device *below* the bridge?  (And possibly the bridge itself if it was
>> the device reporting the error.)
> The small patch below should resolve this issue.
> Please let me know what you think.
>
>> In that case you don't need to add PCI_ERS_RESULT_NO_AER_DRIVER to
>> the switch/case statement because we wouldn't want to have multiple
>> uevents reporting disconnect, so the one emitted below the "failed:"
>> label would be sufficient.
> I'll send a separate Reviewed-by for your original patch as the small
> patch below should resolve my concern about PCI_ERS_RESULT_NO_AER_DRIVER.
>
>> This all looks so broken that I'm starting to wonder if there's any
>> user space application at all that takes advantage of these uevents?
> I'd still be interested to know which user space application you're
> using to track these uevents?
>
> Thanks,
>
> Lukas
>
> -- >8 --
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index e795e5ae..3a95aa2 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -165,6 +165,12 @@ static int report_resume(struct pci_dev *dev, void *data)
>   	return 0;
>   }
>   
> +static int report_disconnect(struct pci_dev *dev, void *data)
> +{
> +	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> +	return 0;
> +}

Since you are notifying the user space, I am wondering whether the drivers
should be notified about the recovery failure?

> +
>   /**
>    * pci_walk_bridge - walk bridges potentially AER affected
>    * @bridge:	bridge which may be a Port, an RCEC, or an RCiEP
> @@ -272,7 +278,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   failed:
>   	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
>   
> -	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
> +	pci_walk_bridge(bridge, report_disconnect, NULL);
>   
>   	pci_info(bridge, "device recovery failed\n");
>   
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


