Return-Path: <linux-pci+bounces-13325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9097D466
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6361C222AF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074B14A0AB;
	Fri, 20 Sep 2024 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaGt3r1c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95313F42A;
	Fri, 20 Sep 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828792; cv=none; b=Wbdoizvx+2b21YtLo831SCLS8N/hZfwGWzxMUD1yWDx98qenmjil/QZR6+fFJzxk781z5behoWSmDUHTziWkJ9DOdeug28IMU/67MkSwHMEH9c417V0YQ/Ux4GwhhWTgVRYtFZx48OBzfT/b6ccV6u92TcfPIrcUgsW315twUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828792; c=relaxed/simple;
	bh=Xl/B9fsLp01cGiBdnirAFhj8EJziPZNE0c5sXznYMu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ6wP6/o+2D6K5E1QmpkHXR0gx7qvsUbnPKM2ZD4hpenzRpHka8HVhWFZlObDaaLKAZlF+BWWVexhVo54vKZEuezytLPEP1wr6vv79++Pv4cMx/8w/CJVcbLyniUvFJCtLzkg2Dq0vUGPo8DvHMkV6slFNCZqrZPwTWdthJ9Yks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaGt3r1c; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726828791; x=1758364791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xl/B9fsLp01cGiBdnirAFhj8EJziPZNE0c5sXznYMu8=;
  b=TaGt3r1c2IeNllxqfyxKuKhSv821Y0Fyc/3vxZxBfvm3ydPX/RPF72ar
   0OL3rA7H4eHxC1fswzox0/Fn3QWEvELCpsey8dihcutJXYqQvf7XeVSej
   K8wFBDF1+xfdgA1ZRwzVS8QoPHgt6e5lBgM2w3SQptiinkjAj1uK4K4hv
   +9tOfV4phqADK/ms5BGi26AE+AQRORvzufDPG4CtTcWE6y2HGHyXlgOMa
   8Q8P4fqKb0Hw+rcWEflzgxmDa1SjXkJulL7Xak4ae24CiNt/8gr36XnSc
   SZtDBbnpJONhKB5ACf132cvFQ3oeOfiL7NQ8vj7rZ6vxji53DZVPtCdsb
   w==;
X-CSE-ConnectionGUID: RvxVcXrGR92MzkqYDhqwHw==
X-CSE-MsgGUID: bqSDbQFYSq+2fzorL+ciXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25702682"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25702682"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 03:39:48 -0700
X-CSE-ConnectionGUID: UIg4HKJhTa6t7iVSuuM0+g==
X-CSE-MsgGUID: ivzM5L1VQEeTzHuii7+ayg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75214262"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Sep 2024 03:39:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srb34-000EHt-2o;
	Fri, 20 Sep 2024 10:39:38 +0000
Date: Fri, 20 Sep 2024 18:38:56 +0800
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
Subject: Re: [PATCH V5 2/5] PCI/TPH: Add Steering Tag support
Message-ID: <202409201840.tDMBEi4q-lkp@intel.com>
References: <20240916205103.3882081-3-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916205103.3882081-3-wei.huang2@amd.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11 next-20240920]
[cannot apply to pci/next pci/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Huang/PCI-Add-TLP-Processing-Hints-TPH-support/20240917-045345
base:   linus/master
patch link:    https://lore.kernel.org/r/20240916205103.3882081-3-wei.huang2%40amd.com
patch subject: [PATCH V5 2/5] PCI/TPH: Add Steering Tag support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240920/202409201840.tDMBEi4q-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409201840.tDMBEi4q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409201840.tDMBEi4q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pcie/tph.c:232:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     232 |         val |= FIELD_PREP(mask, (u32)tag);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   1 warning generated.


vim +232 drivers/pci/pcie/tph.c

   203	
   204	/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
   205	static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
   206	{
   207		struct msi_desc *msi_desc = NULL;
   208		void __iomem *vec_ctrl;
   209		u32 val, mask;
   210		int err = 0;
   211	
   212		msi_lock_descs(&pdev->dev);
   213	
   214		/* Find the msi_desc entry with matching msix_idx */
   215		msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
   216			if (msi_desc->msi_index == msix_idx)
   217				break;
   218		}
   219	
   220		if (!msi_desc) {
   221			err = -ENXIO;
   222			goto err_out;
   223		}
   224	
   225		/* Get the vector control register (offset 0xc) pointed by msix_idx */
   226		vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
   227		vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
   228	
   229		val = readl(vec_ctrl);
   230		mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
   231		val &= ~mask;
 > 232		val |= FIELD_PREP(mask, (u32)tag);
   233		writel(val, vec_ctrl);
   234	
   235		/* Read back to flush the update */
   236		val = readl(vec_ctrl);
   237	
   238	err_out:
   239		msi_unlock_descs(&pdev->dev);
   240		return err;
   241	}
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

