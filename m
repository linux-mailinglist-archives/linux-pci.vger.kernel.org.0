Return-Path: <linux-pci+bounces-2140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1768D82D4C8
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 08:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD541C2103C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C55380;
	Mon, 15 Jan 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pw9PZv5o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650626FA6;
	Mon, 15 Jan 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705305523; x=1736841523;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Z7J9xPHy03mt18iRWUula0r+n8Hcr6zT+lxWC08VcYs=;
  b=Pw9PZv5o0D8ZZA4NU8dACpWfItFjg5OBqJhRgTIXSZ8uBbzv4MAXHS9G
   iqPoj8rOa46fI0Tg/ZZQEIVP13XIyu48G74EtAtNPVHL/YNbwDYVXPIK3
   pnpfu/wnPe+cJFEomQRvZintfqtEOiBeniI+MGg+w+DVHTPsUiglPBoUh
   oGu+WCQMbgJAzy7vWgjLqZTw1fBdhDgs/EhRNUQqtTamdKEwxoMFdNXiw
   WDZOVgtvH4GX6QEb/fPBFidjFmX/tUp6O4P/Y99XZiPzCqag8kdisYJEd
   fnY5ozNuemdA7VOfVbaVH87rlIZAmfsOtXcl4aHdDxvI5/4wG7gkq8JZC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="21034602"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="21034602"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 23:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="927046183"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="927046183"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.208.103]) ([10.254.208.103])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 23:58:39 -0800
Message-ID: <1a2a4069-c737-4a3c-a2f6-cce06823331b@linux.intel.com>
Date: Mon, 15 Jan 2024 15:58:37 +0800
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
Content-Transfer-Encoding: 8bit


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

How aobut refactor the qi_submit_sync() and qi_check_fault() like

following, combination of patch

[2] iommu/vt-d: break out ATS Invalidation if target device is gone

[5] iommu/vt-d: don't loop for timeout ATS Invalidation request forever

but sending them in seperated patches seems better ? each of them

handling different case.

- fold additional errors/fault/exception handling into qi_check_fault()

- the detetion of target device presence use to handle surprise removal

  or device died /no response.

- the ITE part use to break out the timeout ATS invalidation request,

   use to handle the case response time of device is too long.

- if passed invalid target_pdev, means this is ATS invalidation request.

- no error handling change in qi_submit_sync().


Please comment.


--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1267,16 +1267,28 @@ static void qi_dump_fault(struct intel_iommu 
*iommu, u32 fault)
                (unsigned long long)desc->qw1);
  }

-static int qi_check_fault(struct intel_iommu *iommu, int index, int 
wait_index)
+static int qi_check_fault(struct intel_iommu *iommu, int index, int 
wait_index,
+                  pci_dev *target_pdev)
  {
         u32 fault;
         int head, tail;
+       u64 iqe_err, ice_sid;
         struct q_inval *qi = iommu->qi;
         int shift = qi_shift(iommu);

         if (qi->desc_status[wait_index] == QI_ABORT)
                 return -EAGAIN;

+       /*
+        * If the ATS invalidation target device is gone this moment 
(surprise
+        * removed, died, no response) don't try this request again. this
+        * request will not get valid result anymore. but the request was
+        * already submitted to hardware and we predict to get a ITE in
+        * followed batch of request, if so, it will get handled then.
+        */
+       if (target_pdev && !pci_device_is_present(target_pdev))
+               return -EINVAL;
+
         fault = readl(iommu->reg + DMAR_FSTS_REG);
         if (fault & (DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE))
                 qi_dump_fault(iommu, fault);
@@ -1315,6 +1327,13 @@ static int qi_check_fault(struct intel_iommu 
*iommu, int index, int wait_index)
                 tail = readl(iommu->reg + DMAR_IQT_REG);
                 tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;

+               /*
+                * SID field is valid only when the ITE field is Set in 
FSTS_REG
+                * see Intel VT-d spec r4.1, section 11.4.9.9
+                */
+               iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+               ice_sid = DMAR_IQER_REG_ITESID(iqe_err);
+
                 writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
                 pr_info("Invalidation Time-out Error (ITE) cleared\n");

@@ -1324,6 +1343,16 @@ static int qi_check_fault(struct intel_iommu 
*iommu, int index, int wait_index)
                         head = (head - 2 + QI_LENGTH) % QI_LENGTH;
                 } while (head != tail);

+               /*
+                * If got ITE, we need to check if the sid of ITE is the 
same as
+                * current ATS invalidation target device, if yes, don't 
try this
+                * request anymore, the target device has a response 
time beyound
+                * expected. 0 value of ice_sid means old device, no 
ice_sid value.
+                */
+               if (target_pdev && ice_sid && ice_sid ==
+                   pci_dev_id(pci_physfn(target_pdev))
+                               return -ETIMEDOUT;
+
                 if (qi->desc_status[wait_index] == QI_ABORT)
                         return -EAGAIN;
         }
@@ -1344,7 +1373,7 @@ static int qi_check_fault(struct intel_iommu 
*iommu, int index, int wait_index)
   * can be part of the submission but it will not be polled for completion.
   */
  int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
-                  unsigned int count, unsigned long options)
+                  unsigned int count, unsigned long options, pci_dev 
*target_pdev)
  {
         struct q_inval *qi = iommu->qi;
         s64 devtlb_start_ktime = 0;
@@ -1430,7 +1459,7 @@ int qi_submit_sync(struct intel_iommu *iommu, 
struct qi_desc *desc,
                  * a deadlock where the interrupt context can wait 
indefinitely
                  * for free slots in the queue.
                  */
-               rc = qi_check_fault(iommu, index, wait_index);
+               rc = qi_check_fault(iommu, index, wait_index, target_pdev);
                 if (rc)
                         break;


Thanks,

Ethan

>

