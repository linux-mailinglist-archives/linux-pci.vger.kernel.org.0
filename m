Return-Path: <linux-pci+bounces-2617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362C83EABE
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jan 2024 04:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A701C21ADC
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jan 2024 03:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89B1170A;
	Sat, 27 Jan 2024 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzj2cAyX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170A11C80;
	Sat, 27 Jan 2024 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706327729; cv=none; b=TibgpiOOn29CxAohOFVNjGD2JfYtIrJ1d8gyn84braCTUChCSq0VFAxbqYd56baEEQhY18MEhVAsz/3IIOKd6xvX2qAwCd5cJDrHzmH/abBW3FhOLXDvVOpCvuHa499EquGWzMGHxy0qIEiMrND7o0G1CbX8/Ge4mLNa+NM8RX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706327729; c=relaxed/simple;
	bh=2YlrNsvY5YZx4tzdNL1t9wV1F+wTN43iqnuvGWOALuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB8IsMvYbvVXTtUzeD8CKsnByWD8mu7lvt8vvfUt7LhAq0G9gPxUcSWtts+gxPOTdDZhaeBqBYVwrnnRE0vljowLuGF7hb3Qq9v2Tsbx9XjS5I+/zHSfzrizjF3oL1wYhGTVh677ZdCrT1D92paK5nCxLe3A0ou3T1Wsnt79r48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzj2cAyX; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706327726; x=1737863726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2YlrNsvY5YZx4tzdNL1t9wV1F+wTN43iqnuvGWOALuI=;
  b=mzj2cAyX5vh6OuuISaGqkkA5leUdepStDnG0wYBM0fq+axoqObDIMkoz
   I5mL/A0ICPsSmUdLKPn5xusAT3fVQSwTIlDqWElF9PkqQy/Nu03XTex81
   C/Vtqch78hxxLzfiTWR7q80O7ad+yAFohtrVYfbjK5tdU92HHa7E7ACre
   XQ380N7JmPQdHIETQeMEvW6eqd7xKeHzZrBoZorZ/6thc09VhoR6ZUiG2
   gNnxy4Hk5sI6DbLcVcaBoL7nmm3P+rZZuWp4iMhiUsezvllEFygUYaO2t
   sUNGupLYmi6OsZ7/gXFhGqH8wmf4ALcyzQ4fD7W2NMb6/iGL6E5BXM8ls
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466917310"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="466917310"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 19:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="29280502"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Jan 2024 19:55:23 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTZmq-0001ck-31;
	Sat, 27 Jan 2024 03:55:20 +0000
Date: Sat, 27 Jan 2024 11:55:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, baolu.lu@linux.intel.com,
	bhelgaas@google.com, robin.murphy@arm.com, jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, kevin.tian@intel.com,
	dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
	yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: Re: [PATCH v11 3/5] iommu/vt-d: simplify parameters of
 qi_submit_sync() ATS invalidation callers
Message-ID: <202401271122.0kJRQe33-lkp@intel.com>
References: <20240126014002.481294-4-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126014002.481294-4-haifeng.zhao@linux.intel.com>

Hi Ethan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.8-rc1 next-20240125]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Zhao/PCI-make-pci_dev_is_disconnected-helper-public-for-other-drivers/20240126-094305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240126014002.481294-4-haifeng.zhao%40linux.intel.com
patch subject: [PATCH v11 3/5] iommu/vt-d: simplify parameters of qi_submit_sync() ATS invalidation callers
config: i386-buildonly-randconfig-001-20240127 (https://download.01.org/0day-ci/archive/20240127/202401271122.0kJRQe33-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401271122.0kJRQe33-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401271122.0kJRQe33-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iommu/intel/iommu.c: In function 'quirk_extra_dev_tlb_flush':
>> drivers/iommu/intel/iommu.c:4987:6: warning: variable 'sid' set but not used [-Wunused-but-set-variable]
     u16 sid;
         ^~~


vim +/sid +4987 drivers/iommu/intel/iommu.c

e65a6897be5e49 Jacob Pan  2022-12-01  4957  
e65a6897be5e49 Jacob Pan  2022-12-01  4958  /*
e65a6897be5e49 Jacob Pan  2022-12-01  4959   * Here we deal with a device TLB defect where device may inadvertently issue ATS
e65a6897be5e49 Jacob Pan  2022-12-01  4960   * invalidation completion before posted writes initiated with translated address
e65a6897be5e49 Jacob Pan  2022-12-01  4961   * that utilized translations matching the invalidation address range, violating
e65a6897be5e49 Jacob Pan  2022-12-01  4962   * the invalidation completion ordering.
e65a6897be5e49 Jacob Pan  2022-12-01  4963   * Therefore, any use cases that cannot guarantee DMA is stopped before unmap is
e65a6897be5e49 Jacob Pan  2022-12-01  4964   * vulnerable to this defect. In other words, any dTLB invalidation initiated not
e65a6897be5e49 Jacob Pan  2022-12-01  4965   * under the control of the trusted/privileged host device driver must use this
e65a6897be5e49 Jacob Pan  2022-12-01  4966   * quirk.
e65a6897be5e49 Jacob Pan  2022-12-01  4967   * Device TLBs are invalidated under the following six conditions:
e65a6897be5e49 Jacob Pan  2022-12-01  4968   * 1. Device driver does DMA API unmap IOVA
e65a6897be5e49 Jacob Pan  2022-12-01  4969   * 2. Device driver unbind a PASID from a process, sva_unbind_device()
e65a6897be5e49 Jacob Pan  2022-12-01  4970   * 3. PASID is torn down, after PASID cache is flushed. e.g. process
e65a6897be5e49 Jacob Pan  2022-12-01  4971   *    exit_mmap() due to crash
e65a6897be5e49 Jacob Pan  2022-12-01  4972   * 4. Under SVA usage, called by mmu_notifier.invalidate_range() where
e65a6897be5e49 Jacob Pan  2022-12-01  4973   *    VM has to free pages that were unmapped
e65a6897be5e49 Jacob Pan  2022-12-01  4974   * 5. Userspace driver unmaps a DMA buffer
e65a6897be5e49 Jacob Pan  2022-12-01  4975   * 6. Cache invalidation in vSVA usage (upcoming)
e65a6897be5e49 Jacob Pan  2022-12-01  4976   *
e65a6897be5e49 Jacob Pan  2022-12-01  4977   * For #1 and #2, device drivers are responsible for stopping DMA traffic
e65a6897be5e49 Jacob Pan  2022-12-01  4978   * before unmap/unbind. For #3, iommu driver gets mmu_notifier to
e65a6897be5e49 Jacob Pan  2022-12-01  4979   * invalidate TLB the same way as normal user unmap which will use this quirk.
e65a6897be5e49 Jacob Pan  2022-12-01  4980   * The dTLB invalidation after PASID cache flush does not need this quirk.
e65a6897be5e49 Jacob Pan  2022-12-01  4981   *
e65a6897be5e49 Jacob Pan  2022-12-01  4982   * As a reminder, #6 will *NEED* this quirk as we enable nested translation.
e65a6897be5e49 Jacob Pan  2022-12-01  4983   */
e2fcf16ac26679 Ethan Zhao 2024-01-25  4984  void quirk_extra_dev_tlb_flush(struct device_domain_info *info, u32 pasid,
e2fcf16ac26679 Ethan Zhao 2024-01-25  4985  			       unsigned long address, unsigned long mask)
e65a6897be5e49 Jacob Pan  2022-12-01  4986  {
e65a6897be5e49 Jacob Pan  2022-12-01 @4987  	u16 sid;
e65a6897be5e49 Jacob Pan  2022-12-01  4988  
e65a6897be5e49 Jacob Pan  2022-12-01  4989  	if (likely(!info->dtlb_extra_inval))
e65a6897be5e49 Jacob Pan  2022-12-01  4990  		return;
e65a6897be5e49 Jacob Pan  2022-12-01  4991  
e65a6897be5e49 Jacob Pan  2022-12-01  4992  	sid = PCI_DEVID(info->bus, info->devfn);
4298780126c298 Jacob Pan  2023-08-09  4993  	if (pasid == IOMMU_NO_PASID) {
e2fcf16ac26679 Ethan Zhao 2024-01-25  4994  		qi_flush_dev_iotlb(info->iommu, info, address, mask);
e65a6897be5e49 Jacob Pan  2022-12-01  4995  	} else {
e2fcf16ac26679 Ethan Zhao 2024-01-25  4996  		qi_flush_dev_iotlb_pasid(info->iommu, info, address, pasid, mask);
e65a6897be5e49 Jacob Pan  2022-12-01  4997  	}
e65a6897be5e49 Jacob Pan  2022-12-01  4998  }
dc57875866ab9f Kan Liang  2023-01-31  4999  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

