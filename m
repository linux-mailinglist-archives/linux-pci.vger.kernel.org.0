Return-Path: <linux-pci+bounces-13618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B385E988F2A
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC261F218E6
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD951187870;
	Sat, 28 Sep 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SX7uwgI/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10951187858;
	Sat, 28 Sep 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727526383; cv=none; b=P4jtBjVzYW/jLypUWlkpJD6fbtYSOsLj4FHs6TZt0Hw4xyLXlFspGAoqyyDoQ+49k3uVYofN5ssvCn9EwF1zEmXqvqPoBI7ZfMjJWV2oWxA7yg6Dkh8A1XoU8EzTLvu9lO0rg5chnmHqxgV6sxV3RVGzG71DGZdeKTEVyDn3eU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727526383; c=relaxed/simple;
	bh=0O0bP0IrBhKutucM950AErodJ/ElrwHuacHsGrdmOL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fodQ4P0jZCrQHomJamEINbb+xH+vZTU1CmLNAJblr94l4nxh0a51vC9tRoSOI49xy1GapU6WSMtWXhVYM4Vz1KzLICPcOdSiy4v41q4vf2vNFJzVgDKyFy54DgWkKwINSEe/KRev5NgZtzUFuZiBw5WeZeo3W005OwGOA4avg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SX7uwgI/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727526382; x=1759062382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0O0bP0IrBhKutucM950AErodJ/ElrwHuacHsGrdmOL0=;
  b=SX7uwgI/bzo2IPYwplUAb/6TV1nzHERKIIfVJfcr997WWzNLVxBvI/Ul
   JQwGFItuWYIScipfgSS/5Np6lu0psZF0yQPfoK/4TjLqwoyZ9VV9dYMaQ
   9ZqsJyqILxB1Hqw78L5l5ttcQ0S44KAeRzucgtkw4hCD/P+FHkRTnUrdS
   gtbdWA4sr1stItIyWQSf4zlUqVMXM4IKOm7i6ExnIIWYi+CmcQ8ZqaxSW
   B+Cr/vSKKbJSMKZr3w0IDSWuvmmCJNKehfqD3zalKmNk3lEGchUdvPDXs
   /gjqO6OcNcbcZFtG5hIupOlZJR5K+TUDLzQFLJSm2KhIH4XUugWf2OA1O
   Q==;
X-CSE-ConnectionGUID: OTniNFF/SMiv6IrXN1Zojg==
X-CSE-MsgGUID: 27+CBRIgQf6mJvxSCAhgqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26174337"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26174337"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 05:26:21 -0700
X-CSE-ConnectionGUID: tqVLSgj5RGiBg6fDPtfYcA==
X-CSE-MsgGUID: iXlxDZxGRlO5tpgIe7GV2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="72677358"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2024 05:26:15 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suWWa-000NFb-0k;
	Sat, 28 Sep 2024 12:26:12 +0000
Date: Sat, 28 Sep 2024 20:25:46 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	wei.huang2@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
	bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
	paul.e.luse@intel.com, jing2.liu@intel.com
Subject: Re: [PATCH V6 2/5] PCI/TPH: Add Steering Tag support
Message-ID: <202409282017.PWd5zICd-lkp@intel.com>
References: <20240927215653.1552411-3-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927215653.1552411-3-wei.huang2@amd.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master next-20240927]
[cannot apply to v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Huang/PCI-Add-TLP-Processing-Hints-TPH-support/20240928-055915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240927215653.1552411-3-wei.huang2%40amd.com
patch subject: [PATCH V6 2/5] PCI/TPH: Add Steering Tag support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240928/202409282017.PWd5zICd-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240928/202409282017.PWd5zICd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409282017.PWd5zICd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/tph.c:236:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     236 |         val |= FIELD_PREP(mask, st_val);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      74 |                                  _pfx "type of reg too small for mask"); \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/linux/compiler_types.h:517:22: note: expanded from macro 'compiletime_assert'
     517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:505:23: note: expanded from macro '_compiletime_assert'
     505 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:497:9: note: expanded from macro '__compiletime_assert'
     497 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   1 warning generated.


vim +236 drivers/pci/tph.c

   205	
   206	/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
   207	static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
   208	{
   209		struct msi_desc *msi_desc = NULL;
   210		void __iomem *vec_ctrl;
   211		u32 val, mask, st_val;
   212		int err = 0;
   213	
   214		msi_lock_descs(&pdev->dev);
   215	
   216		/* Find the msi_desc entry with matching msix_idx */
   217		msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
   218			if (msi_desc->msi_index == msix_idx)
   219				break;
   220		}
   221	
   222		if (!msi_desc) {
   223			err = -ENXIO;
   224			goto err_out;
   225		}
   226	
   227		st_val = (u32)tag;
   228	
   229		/* Get the vector control register (offset 0xc) pointed by msix_idx */
   230		vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
   231		vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
   232	
   233		val = readl(vec_ctrl);
   234		mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
   235		val &= ~mask;
 > 236		val |= FIELD_PREP(mask, st_val);
   237		writel(val, vec_ctrl);
   238	
   239		/* Read back to flush the update */
   240		val = readl(vec_ctrl);
   241	
   242	err_out:
   243		msi_unlock_descs(&pdev->dev);
   244		return err;
   245	}
   246	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

