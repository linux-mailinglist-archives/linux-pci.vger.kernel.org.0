Return-Path: <linux-pci+bounces-8422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197B98FF7A7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 00:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089041C22236
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D74315F;
	Thu,  6 Jun 2024 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZUWF0bi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943319D8B9;
	Thu,  6 Jun 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713041; cv=none; b=MXZTmRkl0d8HNgFbsAZ5ZLdI8YdPETlIJr0qIVTPWktxjrCqgwS3RoXfyuwH3mKP12ubEdHj/5vjU5PwEDplkuHjaPCGuAq6DvdcMSy+uNpcJRd1gwtu1ZkpT35eblzDBjm10alvi2lAvnnxLsyPgs7edVreWaykWNWV7N9hQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713041; c=relaxed/simple;
	bh=Lz5+wZ49vAR/azXrLnct2FWvU4U+hh5dMj/QxWj5AjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGN4masSVoxigQcEpUyNVWZI+pxxxmzwQsZFULWJdiMBWt+NmyqcaX+1szZtuaZ+yOGIKu4G0MVTp+CnIuz9+gRa7qMOTxO39EGsrsU3gX95eQMiwBHDVpJGLtr9JJPYOAUUbNxlEPIga37HMaObcFHSA9zVz8O59mv9zjgZ6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZUWF0bi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717713039; x=1749249039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lz5+wZ49vAR/azXrLnct2FWvU4U+hh5dMj/QxWj5AjA=;
  b=AZUWF0biHmLarGWu7mwQdlzPp0Gt1tnr9w7Q6T9UULusF7qU5zjbcNdm
   CTm5iQWEEuFrOtpw25GMrrE2ntOKjorDVQcMCMybZAazcdxzQJLfnZZly
   8+2CEF6AUnJjWKLMj7r0R+ysw87zn0SglEAIm1nsKFYu9HKRTajvD1QxH
   ZdR7/TTDXK83S1Dw+d0e/RS/DSac+nd3lpqz4dTByTyaPLVp2HVY5TEtX
   yVz1/G3irRBRIaD4ATiX6MmZWvUg88b9lmGgEo0MPK5uu1XbIyOio8Zlz
   gPpDYHF9oIM4f2mW8YRoaxQviTHJukPaVVAQXoZ/xjK3BUGHlf0wYwfD2
   Q==;
X-CSE-ConnectionGUID: lASWJykfTKeg0iX3RJfMNw==
X-CSE-MsgGUID: F4gqdjR+RweURiCWiBfSkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14596948"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14596948"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 15:30:38 -0700
X-CSE-ConnectionGUID: 2z5zrgD4QMuo60MP3iEFhQ==
X-CSE-MsgGUID: h2PhUJP+Qgm2lTqoeZq3aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="68910874"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Jun 2024 15:30:33 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFLcs-0003ns-1m;
	Thu, 06 Jun 2024 22:30:30 +0000
Date: Fri, 7 Jun 2024 06:30:17 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	wei.huang2@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
	bagasdotme@gmail.com
Subject: Re: [PATCH V2 5/9] PCI/TPH: Introduce API functions to manage
 steering tags
Message-ID: <202406070602.DyLemS9q-lkp@intel.com>
References: <20240531213841.3246055-6-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531213841.3246055-6-wei.huang2@amd.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus awilliam-vfio/next linus/master awilliam-vfio/for-linus v6.10-rc2 next-20240606]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Huang/PCI-Introduce-PCIe-TPH-support-framework/20240601-054423
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240531213841.3246055-6-wei.huang2%40amd.com
patch subject: [PATCH V2 5/9] PCI/TPH: Introduce API functions to manage steering tags
config: arm-randconfig-r122-20240607 (https://download.01.org/0day-ci/archive/20240607/202406070602.DyLemS9q-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240607/202406070602.DyLemS9q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070602.DyLemS9q-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/pcie/tph.c:18:
   In file included from include/linux/pci.h:1653:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/pci/pcie/tph.c:95:15: error: no member named 'msix_base' in 'struct pci_dev'; did you mean 'msix_cap'?
      95 |         entry = dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;
         |                      ^~~~~~~~~
         |                      msix_cap
   include/linux/pci.h:350:6: note: 'msix_cap' declared here
     350 |         u8              msix_cap;       /* MSI-X capability offset */
         |                         ^
   1 warning and 1 error generated.


vim +95 drivers/pci/pcie/tph.c

    80	
    81	/*
    82	 * For a given device, return a pointer to the MSI table entry at msi_index.
    83	 */
    84	static void __iomem *tph_msix_table_entry(struct pci_dev *dev,
    85						  u16 msi_index)
    86	{
    87		void __iomem *entry;
    88		u16 tbl_sz;
    89		int ret;
    90	
    91		ret = tph_get_table_size(dev, &tbl_sz);
    92		if (ret || msi_index > tbl_sz)
    93			return NULL;
    94	
  > 95		entry = dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;
    96	
    97		return entry;
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

