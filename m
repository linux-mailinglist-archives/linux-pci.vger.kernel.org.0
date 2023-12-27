Return-Path: <linux-pci+bounces-1407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9981EBBA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 04:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055041C2120F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79A2100;
	Wed, 27 Dec 2023 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6pfeXe9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054302113;
	Wed, 27 Dec 2023 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703646366; x=1735182366;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Di0ZIIBU2RAZW1q3JZ/+o8Dm3ukq5vKsHsHy6vwtPIY=;
  b=E6pfeXe9UoQqFNHqpjmyCF8x0elttuXiFcHjiqsXL1kZeOS02iFfGM02
   jMjlkylp3ELOr5sxe/u+eIouKSRvxbxo+rfjioV68LK70KjgGrljCxCko
   D2WONtLRGE7ocsPN4OzvijvthLET8TnQEv/nSRmL4GaKZAFvF/tT4/MXe
   piHbEbNfWibcYncJPxSKilsLh2gS6+6pPzdXsM89bnqeGbgMWkI3/BQK7
   K7Y//x0BdCWbVw1flFLOZnrar33QeAAoS5KimQiPya4PgV7Apo/+DOFWL
   jijESHWtPVZmPkaLJlEMQgTv+yUwQhzK+SX3YENNGivti9pQ3IyAHYLGZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="3235276"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="3235276"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:06:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="26461233"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.28.66]) ([10.255.28.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:06:02 -0800
Message-ID: <c71fb26d-4475-42bf-b017-9065a02f8e6d@linux.intel.com>
Date: Wed, 27 Dec 2023 11:05:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231227025923.536148-1-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231227025923.536148-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/27/2023 10:59 AM, Ethan Zhao wrote:
> This patchset is used to fix vt-d hard lockup reported when surprise
> unplug ATS capable endpoint device connects to system via PCIe switch
> as following topology.
>                                                                      
>       +-[0000:15]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d
>       |           +-00.1  Intel Corporation Ice Lake Mesh 2 PCIe
>       |           +-00.2  Intel Corporation Ice Lake RAS
>       |           +-00.4  Intel Corporation Device 0b23
>       |           \-01.0-[16-1b]----00.0-[17-1b]--+-00.0-[18]----00.0
>                                             NVIDIA Corporation Device 2324
>       |                                           +-01.0-[19]----00.0
>                            Mellanox Technologies MT2910 Family [ConnectX-7]
>                                                                            
> User brought endpoint device 19:00.0's link down by flapping it's hotplug
> capable slot 17:01.0 link control register, as sequence DLLSC response,
> pciehp_ist() will unload device driver and power it off, durning device
> driver is unloading an iommu device-TLB invalidation (Intel vt-d spec, or
> 'ATS invalidation' in PCIe spec) request issued to that link down device,
> thus a long time completion/timeout waiting in interrupt context causes
> continuous hard lockup warnning and system hang.
>                                                                           
> Other detail, see every patch commit log.
>                                                                           
> patch [3&4] were tested by yehaorong@bytedance.com on stable v6.7-rc4.
> patch [1&2] only passed compiling on stable v6.7-rc6.
>                                                                           
>                                                                           
> change log:
> v8:
> - add a patch to break the loop for timeout device-TLB invalidation, as
>    Bjorn said there is possibility device just no reponse but not gone.
> v7:
> - reorder patches and revise commit log per Bjorn's guide.
> - other code and commit log revise per Lukas' suggestion.
> - rebased to stable v6.7-rc6.
> v6:
> - add two patches to break out device-TLB invalidation if device is gone.
> v5:
> - add a patch try to fix the rare case (surprise remove a device in
>    safe removal process). not work because surprise removal handling can't
>    re-enter when another safe removal is in process.
> v4:
> - move the PCI device state checking after ATS per Baolu's suggestion.
> v3:
> - fix commit description typo.
> v2:
> - revise commit[1] description part according to Lukas' suggestion.
> - revise commit[2] description to clarify the issue's impact.
> v1:
> - https://lore.kernel.org/lkml/20231213034637.2603013-1-haifeng.zhao@
> linux.intel.com/T/
>                                                                            
>                                                                            
> Thanks,
> Ethan
>
> Ethan Zhao (5):
>    iommu/vt-d: add flush_target_dev member to struct intel_iommu and pass
>      device info to all ATS invalidation functions
>    iommu/vt-d: break out device-TLB invalidation if target device is gone
>    PCI: make pci_dev_is_disconnected() helper public for other drivers
>    iommu/vt-d: don't issue device-TLB invalidate request when device is
>      disconnected
>    iommu/vt-d: don't loop for timeout device-TLB invalidation request
>      forever
>
>   drivers/iommu/intel/dmar.c  | 14 +++++++++++++-
>   drivers/iommu/intel/iommu.c |  1 +
>   drivers/iommu/intel/iommu.h |  2 ++
>   drivers/iommu/intel/pasid.c |  4 ++++
>   drivers/iommu/intel/svm.c   |  1 +
>   drivers/pci/pci.h           |  5 -----
>   include/linux/pci.h         |  5 +++++
>   7 files changed, 26 insertions(+), 6 deletions(-)

Sorry, post the wrong call stack, will re-send.


>

