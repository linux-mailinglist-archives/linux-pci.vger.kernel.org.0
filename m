Return-Path: <linux-pci+bounces-33310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2AB18673
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A31892EC1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49D1B21BF;
	Fri,  1 Aug 2025 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGx01Ar/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120B19C546;
	Fri,  1 Aug 2025 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068849; cv=none; b=ddXVN1MB/eUVJzfmO8KTZ5WtbdXIEldSy1Y20sCdxdCT6Na4kTgDuDTDfpKUfOX6e5b8K0Ks6oaQyExaGVkcxH3nvTUqPJRuXnDJPc5JgDdczD/0HR7pggdpbfP/hjOhLBicX7ZyP/p2iw5TFl+ux6C4IZ1eNE8J26cscrw62fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068849; c=relaxed/simple;
	bh=DWBXfCvR6lt84c6Psk2frdJburkpSgkJO5zbV9ApcSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpG3u0XtNQk4HYquHb2+o8ZEdH43qz227eaT498HHgsSA9rZDtvUD5q6J6B87Tgq50NSmVw6f2IrUEBgN0friUEamssBJYNlAraFMx2IMK40+5EwLbxEBqiPfSpW5t8X+02av88XvY41EePCW/QF8fD9fMfbKWsWG7Xj2roZ2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGx01Ar/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754068848; x=1785604848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DWBXfCvR6lt84c6Psk2frdJburkpSgkJO5zbV9ApcSc=;
  b=SGx01Ar/MSx3c2WaMljTFfFuPG8CSpOIhS2zpZW9rCgP646+jWkYWZ4P
   v/RKbLPwjVQKzjpAn0AsBp7Cy9Y3fOBQgQbRkVnmgjImicy2VozZrB2mc
   6Hg21ynuIGPTv9CFZa4Onsfsq5DR0fjWh140VUkTunB/wYkQoYI6abYJ5
   VlILT+uH+51FuPs9TPgyC2YwqcqP9q3bXNqgq0kCOH02h0Ko+IkRrLNKy
   n52HvvVHfSA11El9VSSfJB88cFLS9ZhRU8hj2X8sWbYihh0e+tQW4jGq1
   f4qmwjU8EnzWd0fFpbpmsv5+unGLGqqsx3YyY6lybnBGYuA5L0zOhbtoK
   w==;
X-CSE-ConnectionGUID: LSKRgRX1QbeaFWSdTeqktg==
X-CSE-MsgGUID: XE6ySvpxQVCS7Wi1LA5VTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56125364"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56125364"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 10:20:45 -0700
X-CSE-ConnectionGUID: XHBnGVulTByiK5/G+LgD8w==
X-CSE-MsgGUID: PUZotDJoRi6tlTVHvOgLSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="164068288"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 10:20:45 -0700
Received: from [10.124.222.201] (unknown [10.124.222.201])
	by linux.intel.com (Postfix) with ESMTP id 829A020B571C;
	Fri,  1 Aug 2025 10:20:43 -0700 (PDT)
Message-ID: <f496fc0f-64d7-46a4-8562-dba74e31a956@linux.intel.com>
Date: Fri, 1 Aug 2025 10:20:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI/AER: Fix missing uevent on recovery when a
 reset is requested
To: Lukas Wunner <lukas@wunner.de>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
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
 <4969c441-fe2a-470f-9efd-4661efca56ec@linux.intel.com>
 <aIxULlDfQw4yhFDv@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aIxULlDfQw4yhFDv@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lukas,

On 7/31/25 10:44 PM, Lukas Wunner wrote:
> On Thu, Jul 31, 2025 at 10:04:38AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 7/31/25 6:01 AM, Lukas Wunner wrote:
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -165,6 +165,12 @@ static int report_resume(struct pci_dev *dev, void *data)
>>>    	return 0;
>>>    }
>>> +static int report_disconnect(struct pci_dev *dev, void *data)
>>> +{
>>> +	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>>> +	return 0;
>>> +}
>> Since you are notifying the user space, I am wondering whether the drivers
>> should be notified about the recovery failure?
> The drivers are usually *causing* the recovery failure by returning
> PCI_ERS_RESULT_DISCONNECT from their pci_error_handlers callbacks
> (or by lacking pci_error_handlers, in particular ->error_detected()).
>
> So in principle the drivers should be aware of recovery failure.
>
> There are cases where multiple drivers are involved.  E.g. on GPUs,
> there's often a PCIe switch with a graphics device and various sound
> or telemetry devices.  Typically errors are reported by the Upstream
> Port, so the Secondary Bus Reset occurs at the Root or Downstream Port
> above the Upstream Port and affects the switch and all subordinate
> devices.  In cases like this, recovery failure may be caused by a
> single driver (e.g. GPU) and the other drivers (e.g. telemetry) may
> be unaware of it.

Yes, my comment was referring to the scenario mentioned above. If one of the
subordinate devices fails recovery, then recovery effectively fails for all devices
under that downstream port (or root port). Notifying all devices under that port
would allow their drivers to perform the necessary cleanup

>
> The recovery flow documented in Documentation/PCI/pci-error-recovery.rst
> was originally conceived for EEH and indeed EEH does notify all drivers
> of recovery failures by invoking the ->error_detected() callback with
> channel_state pci_channel_io_perm_failure.  See this call ...
>
> 	eeh_pe_report("error_detected(permanent failure)", pe,
> 		      eeh_report_failure, NULL);
>
> ... in arch/powerpc/kernel/eeh_driver.c below the recover_failed label
> in eeh_handle_normal_event().

Agree. The current implementation does not seem to follow the steps
mentioned in the Documentation/PCI/pci-error-recovery.rst.

STEP 6: Permanent Failure
-------------------------
A "permanent failure" has occurred, and the platform cannot recover
the device.  The platform will call error_detected() with a
pci_channel_state_t value of pci_channel_io_perm_failure.

The device driver should, at this point, assume the worst. It should
cancel all pending I/O, refuse all new I/O, returning -EIO to
higher layers. The device driver should then clean up all of its
memory and remove itself from kernel operations, much as it would
during system shutdown.


>
> I don't know why pcie_do_recovery() doesn't do the same on recovery
> failure.  This is one of several annoying deviations between AER and
> EEH.  Ideally the behavior should be the same across all platforms
> so that drivers don't have to cope with platform-specific quirks.
>
> However I think that's orthogonal to the pci_uevent_ers() invocation
> in pcie_do_recovery().

Agree. My thought is, since there is an attempt to fix the user notification
side of things, may be the driver side should also be fixed together .

> Thanks,
>
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


