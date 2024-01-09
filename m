Return-Path: <linux-pci+bounces-1859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCFF827C87
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 02:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53ACA1F234D0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1513A5E;
	Tue,  9 Jan 2024 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dtf5FdSV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E8186E;
	Tue,  9 Jan 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704763450; x=1736299450;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=tztNPMuvQXiNw1r7vUmDEia96WTG9eqw7fOwv3oe8+k=;
  b=Dtf5FdSVkuYo5mOXUe2Ei1or5b2KQU2LARRyDzgPz8et9JRP+YDcEc3D
   bhOAcPjkyMy4eilmabBoMC9laZgbv551HMpd63Z8pSAiFeQFK62+64tnz
   oeDf7Cke8UePACm6efud4aSSG8RKJYPgx1ttgnDg9xmafX5hK70Hnfvlo
   M04cjnrLo3fDPOhi9elonZgIu/MjsszK/mbZzYxXuEcXuuccgKbf1pEgh
   V16ah0EY8bJsuxueF2DDhlrBp+uwskOw5nANIWuOC8J+HoMb7HT0lTu+G
   gpht8COcGjCambaWuitNgpzErbT88vxnZhkRo1NBe6Hj/nxkzzw5UQQ4k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11399747"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="11399747"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="904984767"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="904984767"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.19.162]) ([10.93.19.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:24:07 -0800
Message-ID: <fb4f62a9-131d-4c3c-b290-e77041ee0019@linux.intel.com>
Date: Tue, 9 Jan 2024 09:24:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: kevin.tian@intel.com, bhelgaas@google.com, baolu.lu@linux.intel.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/29/2023 1:02 AM, Ethan Zhao wrote:
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
> driver is unloading an iommu device-TLB invalidation (Intel VT-d spec, or
> 'ATS Invalidation' in PCIe spec) request issued to that link down device,
> thus a long time completion/timeout waiting in interrupt context causes
> continuous hard lockup warnning and system hang.
>                                                                           
> Other detail, see every patch commit log.
>                                                                           
> patch [3&4] were tested by yehaorong@bytedance.com on stable v6.7-rc4.
> patch [1-5] passed compiling on stable v6.7-rc6.
>                                                                           
>                                                                           
> change log:
> v10:
> - refactor qi_submit_sync() and its callers to get pci_dev instance, as
>    Kevin pointed out add target_flush_dev to iommu is not right.
> v9:
> - unify all spelling of ATS Invalidation adhere to PCIe spec per Bjorn's
>    suggestion.
> v8:
> - add a patch to break the loop for timeout device-TLB invalidation, as
>    Bjorn said there is possibility device just no response but not gone.
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
>
> Ethan Zhao (5):
>    iommu/vt-d: add pci_dev parameter to qi_submit_sync and refactor
>      callers
>    iommu/vt-d: break out ATS Invalidation if target device is gone
>    PCI: make pci_dev_is_disconnected() helper public for other drivers
>    iommu/vt-d: don't issue ATS Invalidation request when device is
>      disconnected
>    iommu/vt-d: don't loop for timeout ATS Invalidation request forever
>
>   drivers/iommu/intel/dmar.c          | 55 ++++++++++++++++++++++-------
>   drivers/iommu/intel/iommu.c         | 26 ++++----------
>   drivers/iommu/intel/iommu.h         | 17 +++++----
>   drivers/iommu/intel/irq_remapping.c |  2 +-
>   drivers/iommu/intel/pasid.c         | 13 +++----
>   drivers/iommu/intel/svm.c           | 13 ++++---
>   drivers/pci/pci.h                   |  5 ---
>   include/linux/pci.h                 |  5 +++
>   8 files changed, 74 insertions(+), 62 deletions(-)

Any new comment for this patchset ?


Thanks,

Ethan


