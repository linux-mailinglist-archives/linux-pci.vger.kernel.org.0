Return-Path: <linux-pci+bounces-2629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2499183F5AA
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 14:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20BE2821D4
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25612375A;
	Sun, 28 Jan 2024 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIS7DMfX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8F23746;
	Sun, 28 Jan 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706449954; cv=none; b=IwlxgEtuoKnkoTZ2pM7SSjAzBH2R6jxc6hsmmxZC56YyM3VY1orz0smzeFzBSXbGP5mu8tZKER2IL/OnNv+4BCNU6EpL6Jzqp3L5GXDu1HDlxA7MBw6jtVZJ5kEqQFiYbrbz1iiCQ6O6cjgxHTA7xMwRPMpdxPNyuHSEJN5y8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706449954; c=relaxed/simple;
	bh=nhYuGtXnAaux4ynleUMyAtLpgnH96e3BLASb8XhVvhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWM38jD83sLtnK+l5sMpAsf1xmii5o83JTDKQ8ncrWJxTqMdEhBtdc7ZicjG+83LoP7gl1eiTyrK3h+ZF8/gvchhp6G9iGoJRL1fIQaYt2uoMVg9uWV78H2mGumnFFokXW6nTVR3DcH7Xefs2e+9Eg+kj5oPfsZsSUc9xU7vIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIS7DMfX; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706449952; x=1737985952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nhYuGtXnAaux4ynleUMyAtLpgnH96e3BLASb8XhVvhs=;
  b=OIS7DMfXjcnOTHT/WpP4Hvkau9tTj0THpARi3gZC8Eu4ZH1p/nsniPBu
   fuEqiEBu9WfqGQSJHyy5dkOZUc27zYmXfJM9yReBmgwJfjRvMXARqVvMQ
   CQxIkz7+iK8g4AWWw+uull5IwguPN83+HCc8T3FYQ6cy28Nbw7U2b+OkX
   FEfW7W8sktWacwJdcXC+g7Qls+qJsY5PlhiY0u0IDnCJ7XFDCrFsPorsj
   5NbdtB4Xl0tujvLe7M2JsrLkqWosYllg1Z1pMkLo6kGkKiE/Rdv0MQ+8h
   0MUkI9HtiMtj6NMKfFthvoOkQEvzpCJpPOAXZjinGYgDbMIKu11gpUHQf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="433937186"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433937186"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 05:52:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="21848575"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jan 2024 05:52:28 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU5aE-0003Qo-0X;
	Sun, 28 Jan 2024 13:52:26 +0000
Date: Sun, 28 Jan 2024 21:52:14 +0800
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
Message-ID: <202401282130.cXuwGvQq-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.8-rc1 next-20240125]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Zhao/PCI-make-pci_dev_is_disconnected-helper-public-for-other-drivers/20240126-094305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240126014002.481294-4-haifeng.zhao%40linux.intel.com
patch subject: [PATCH v11 3/5] iommu/vt-d: simplify parameters of qi_submit_sync() ATS invalidation callers
config: x86_64-randconfig-005-20240128 (https://download.01.org/0day-ci/archive/20240128/202401282130.cXuwGvQq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401282130.cXuwGvQq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401282130.cXuwGvQq-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/intel/svm.c: In function 'intel_flush_svm_all':
   drivers/iommu/intel/svm.c:229:67: warning: passing argument 2 of 'qi_flush_dev_iotlb_pasid' makes pointer from integer without a cast [-Wint-conversion]
     229 |                         qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
         |                                                               ~~~~^~~~~
         |                                                                   |
         |                                                                   u16 {aka short unsigned int}
   In file included from drivers/iommu/intel/svm.c:22:
   drivers/iommu/intel/iommu.h:1047:58: note: expected 'struct device_domain_info *' but argument is of type 'u16' {aka 'short unsigned int'}
    1047 |                               struct device_domain_info *info, u64 addr,
         |                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> drivers/iommu/intel/svm.c:229:25: error: too many arguments to function 'qi_flush_dev_iotlb_pasid'
     229 |                         qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/intel/iommu.h:1046:6: note: declared here
    1046 | void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/intel/svm.c:232:25: error: too many arguments to function 'quirk_extra_dev_tlb_flush'
     232 |                         quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/intel/iommu.h:1049:6: note: declared here
    1049 | void quirk_extra_dev_tlb_flush(struct device_domain_info *info, u32 pasid,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/qi_flush_dev_iotlb_pasid +229 drivers/iommu/intel/svm.c

2f26e0a9c9860db drivers/iommu/intel-svm.c David Woodhouse 2015-09-09  217  
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  218  static void intel_flush_svm_all(struct intel_svm *svm)
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  219  {
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  220  	struct device_domain_info *info;
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  221  	struct intel_svm_dev *sdev;
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  222  
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  223  	rcu_read_lock();
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  224  	list_for_each_entry_rcu(sdev, &svm->devs, list) {
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  225  		info = dev_iommu_priv_get(sdev->dev);
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  226  
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  227  		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 0);
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  228  		if (info->ats_enabled) {
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22 @229  			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  230  						 svm->pasid, sdev->qdep,
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  231  						 0, 64 - VTD_PAGE_SHIFT);
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22 @232  			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  233  						  svm->pasid, sdev->qdep);
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  234  		}
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  235  	}
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  236  	rcu_read_unlock();
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  237  }
e7ad6c2a4b1aa71 drivers/iommu/intel/svm.c Lu Baolu        2023-11-22  238  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

