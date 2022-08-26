Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5F25A277A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiHZMRV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiHZMRV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 08:17:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CC517E03;
        Fri, 26 Aug 2022 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661516238; x=1693052238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MO0tvvrlbNTcgcasvKU2WmNROliMDlqgfs5fC3Hx/2Q=;
  b=jczeQ5Dd3tenv+3NU65oUv+4TaqevhDqf0BpMd4dd1t14c6lMdPhe52G
   fW8sofwCvUqB9WYCdAQsNhHD1PId/TK1VXNuH7zuZSrl5gvqR5VRcclam
   myShtqlIdGZwrA2xOxhl6kpQlzfSRfFc0p1YriVfXL8Wm+8Cvm4J8Ihqo
   w/qo3gH1KRokECUVJgoE3+TiI7EmY136Y6Q9xBs6TJSL7SejkG1103aYx
   qZXS5HHdhipu9ghR/frtKVga/Hx+sAhTBgCPXApwQ3Q/cLSque7r3PF8d
   kC4fbnfI9YOLWAvcqq4HFk3JcuKSjSna/jfr4Ac26vep9+EGT1sgdt5fL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="293234162"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="293234162"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606747455"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:17:13 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v12 00/17] iommu: SVA and IOPF refactoring
Date:   Fri, 26 Aug 2022 20:11:24 +0800
Message-Id: <20220826121141.50743-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi folks,

The former part of this series introduces the IOMMU interfaces to attach
or detach an iommu domain to/from a pasid of a device, and refactors the
exsiting IOMMU SVA implementation by assigning an SVA type of iommu
domain to a shared virtual address and replacing sva_bind/unbind iommu
ops with a set_dev_pasid domain ops.

The latter part changes the existing I/O page fault handling framework
from only serving SVA to a generic one. Any driver or component could
handle the I/O page faults for its domain in its own way by installing
an I/O page fault handler.

This series has been functionally tested by Tony Zhu on Intel hardware
and Zhangfei Gao on arm64 (Kunpeng920) hardware. Thanks a lot for the
efforts. 

This series is also available on github:
https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v12

Please review and suggest.

Best regards,
baolu

Change log:
v12:
 - Add blocking domain support in both vt-d and smmuv3 drivers and make
   the set blocking domain through its own domain ops.
 - Add a type parameter in iommu_get_domain_for_dev_pasid() to matach
   the interested domain type.
 - Only enforce ACS RR & UF in pci_enable_pasid() and refine the commit
   messages according to Bjorn's suggestions.
 - Misc code and comment refinement.

v11:
 - https://lore.kernel.org/linux-iommu/20220817012024.3251276-1-baolu.lu@linux.intel.com/
 - [PATCH 04/13] PCI: Allow PASID only when ACS enforced on upstreaming path
   - new patch
 - [PATCH 05/13] iommu: Add attach/detach_dev_pasid iommu interface
   - Remove block_dev_pasid domain ops and use setting group blocking
     domain instead.
   - Remove iommu_group_immutable_singleton(). Move the PCI/ACS
     requirement into the pci_enable_pasid(). All devices in an iommu
     group share a same iommu domain for each pasid.
 - [PATCH 06/13] iommu: Add IOMMU SVA domain support
   - Add a refcount for SVA multiple bindings.
 - [PATCH 07/13] iommu/vt-d: Add SVA domain support
   - Use set_dev_pasid for both domain attaching and detaching.
 - [PATCH 08/13] arm-smmu-v3/sva: Add SVA domain support
   - Use set_dev_pasid for both domain attaching and detaching.
 - [PATCH 09/13] iommu/sva: Refactoring iommu_sva_bind/unbind_device()
   - Remove the refcount of iommu_sva::users.
   - Add iommu_sva::domain.
 - [PATCH 11/13] iommu: Prepare IOMMU domain for IOPF
   - Remove unnecessary check of IS_ERR_OR_NULL(mm).
 - [Overall]
   - Rebase to v6.0-rc1.
   - Remove previous Test-by's as some APIs are changed.
   - Polishing of various codes and comments.

v10:
 - https://lore.kernel.org/linux-iommu/20220705050710.2887204-1-baolu.lu@linux.intel.com/
 - Rebase on next branch of iommu tree.
 - Split attach/detach_device_pasid interfaces and SVA domain extensions
   to different patches.
 - Handle the return error of xa_cmpxchg() gracefully.
 - Directly pass mm in as the SVA fault data.
 - Rename iopf_handle_group() to iopf_handler().
 - Some commit message and code comment refinement.
 - Add Tested-by's from Zhangfei and Tony.

v9:
 - https://lore.kernel.org/linux-iommu/20220621144353.17547-1-baolu.lu@linux.intel.com/
 - Some minor changes on comments and function names.
 - Simplify dev_iommu_get_max_pasids().

v8:
 - https://lore.kernel.org/linux-iommu/20220607014942.3954894-1-baolu.lu@linux.intel.com/
 - Add support for calculating the max pasids that a device could
   consume.
 - Replace container_of_safe() with container_of.
 - Remove iommu_ops->sva_domain_ops and make sva support through the
   generic domain_alloc/free() interfaces.
 - [Robin] It would be logical to pass IOMMU_DOMAIN_SVA to the normal
   domain_alloc call, so that driver-internal stuff like context
   descriptors can be still be hung off the domain as usual (rather than
   all drivers having to implement some extra internal lookup mechanism
   to handle all the SVA domain ops).
 - [Robin] I'd just stick the mm pointer in struct iommu_domain, in a
   union with the fault handler stuff those are mutually exclusive with
   SVA.
 - https://lore.kernel.org/linux-iommu/f3170016-4d7f-e78e-db48-68305f683349@arm.com/

v7:
 - https://lore.kernel.org/linux-iommu/20220519072047.2996983-1-baolu.lu@linux.intel.com/
 - Remove duplicate array for sva domain.
 - Rename detach_dev_pasid to block_dev_pasid.
 - Add raw device driver interfaces for iommufd.
 - Other misc refinements and patch reorganization.
 - Drop "dmaengine: idxd: Separate user and kernel pasid enabling" which
   has been picked for dmaengine tree.

v6:
 - https://lore.kernel.org/linux-iommu/20220510061738.2761430-1-baolu.lu@linux.intel.com/
 - Refine the SVA basic data structures.
   Link: https://lore.kernel.org/linux-iommu/YnFv0ps0Ad8v+7uH@myrica/
 - Refine arm smmuv3 sva domain allocation.
 - Fix a possible lock issue.
   Link: https://lore.kernel.org/linux-iommu/YnFydE8j8l7Q4m+b@myrica/

v5:
 - https://lore.kernel.org/linux-iommu/20220502014842.991097-1-baolu.lu@linux.intel.com/
 - Address review comments from Jean-Philippe Brucker. Very appreciated!
 - Remove redundant pci aliases check in
   device_group_immutable_singleton().
 - Treat all buses except PCI as static in immutable singleton check.
 - As the sva_bind/unbind() have already guaranteed sva domain free only
   after iopf_queue_flush_dev(), remove the unnecessary domain refcount.
 - Move domain get() out of the list iteration in iopf_handle_group().

v4:
 - https://lore.kernel.org/linux-iommu/20220421052121.3464100-1-baolu.lu@linux.intel.com/
 - Solve the overlap with another series and make this series
   self-contained.
 - No objection to the abstraction of data structure during v3 review.
   Hence remove the RFC subject prefix.
 - Refine the immutable singleton group code according to Kevin's
   comments.

v3:
 - https://lore.kernel.org/linux-iommu/20220410102443.294128-1-baolu.lu@linux.intel.com/
 - Rework iommu_group_singleton_lockdown() by adding a flag to the group
   that positively indicates the group can never have more than one
   member, even after hot plug.
 - Abstract the data structs used for iommu sva in a separated patches to
   make it easier for review.
 - I still keep the RFC prefix in this series as above two significant
   changes need at least another round review to be finalized.
 - Several misc refinements.

v2:
 - https://lore.kernel.org/linux-iommu/20220329053800.3049561-1-baolu.lu@linux.intel.com/
 - Add sva domain life cycle management to avoid race between unbind and
   page fault handling.
 - Use a single domain for each mm.
 - Return a single sva handler for the same binding.
 - Add a new helper to meet singleton group requirement.
 - Rework the SVA domain allocation for arm smmu v3 driver and move the
   pasid_bit initialization to device probe.
 - Drop the patch "iommu: Handle IO page faults directly".
 - Add mmget_not_zero(mm) in SVA page fault handler.

v1:
 - https://lore.kernel.org/linux-iommu/20220320064030.2936936-1-baolu.lu@linux.intel.com/
 - Initial post.

Lu Baolu (17):
  iommu: Add max_pasids field in struct iommu_device
  iommu: Add max_pasids field in struct dev_iommu
  iommu: Remove SVM_FLAG_SUPERVISOR_MODE support
  PCI: Enable PASID only when ACS RR & UF enabled on upstream path
  iommu: Add attach/detach_dev_pasid iommu interface
  iommu: Add IOMMU SVA domain support
  iommu: Try to allocate blocking domain when probing device
  iommu: Make free of iommu_domain_ops optional
  iommu/vt-d: Add blocking domain support
  iommu/vt-d: Add SVA domain support
  arm-smmu-v3: Add blocking domain support
  arm-smmu-v3/sva: Add SVA domain support
  iommu/sva: Refactoring iommu_sva_bind/unbind_device()
  iommu: Remove SVA related callbacks from iommu ops
  iommu: Prepare IOMMU domain for IOPF
  iommu: Per-domain I/O page fault handling
  iommu: Rename iommu-sva-lib.{c,h}

 include/linux/intel-svm.h                     |  13 -
 include/linux/iommu.h                         | 112 +++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  22 +-
 drivers/iommu/intel/iommu.h                   |  17 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |  14 +-
 drivers/dma/idxd/cdev.c                       |   3 +-
 drivers/dma/idxd/init.c                       |  25 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 104 ++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  45 ++-
 drivers/iommu/intel/dmar.c                    |   7 +
 drivers/iommu/intel/iommu.c                   |  48 ++-
 drivers/iommu/intel/svm.c                     | 147 ++++-----
 drivers/iommu/io-pgfault.c                    |  77 +----
 drivers/iommu/iommu-sva-lib.c                 |  71 -----
 drivers/iommu/iommu-sva.c                     | 239 ++++++++++++++
 drivers/iommu/iommu.c                         | 294 +++++++++++-------
 drivers/misc/uacce/uacce.c                    |   2 +-
 drivers/pci/ats.c                             |   3 +
 drivers/iommu/Makefile                        |   2 +-
 19 files changed, 769 insertions(+), 476 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (83%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

