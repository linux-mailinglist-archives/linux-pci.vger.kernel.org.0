Return-Path: <linux-pci+bounces-13621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD13A989169
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDFB1C22EE5
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03418308A;
	Sat, 28 Sep 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5ammNvw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90F17C7D4;
	Sat, 28 Sep 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727557028; cv=none; b=BEzYP/PUbtaHPVUNWIhSWGtJD1v1y9SmSAV6agNaxw+T68FH18CJqpZZnG1frWGEwXKZDZs+SoPBigCdrelLCt7UoNyUo8C88zDKYKQLDjdBdZvol+tD1Gx6tk7ZgCRwbs8eWw9/+PSw/7o6DT4gwfUHU0L3E+wofUKS1xiWWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727557028; c=relaxed/simple;
	bh=OK5RveDLSz5tFyXUinR9c5kALUI2j3KDOCHCIRzL/ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OawwzYEezWGqV5Y6msx5L0PXZum1Q4rfgNREjLirogJzcswvJaVtw68vtZ1ax4lJP4Ld6ypj5NhBM6R/GFgYfS/dk/eYghDamDHJpE5iMz0n+4aI2gpb+aHg8RvU6WUYYjKNsaUiG0yvtfVgekPa8XQufX4nAhuXdjOp3IkLa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5ammNvw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727557025; x=1759093025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OK5RveDLSz5tFyXUinR9c5kALUI2j3KDOCHCIRzL/ug=;
  b=K5ammNvwqmIX83nFP6U1LVHv8plnNyZYRNKaE8uW8Af6D36VgF1kabOD
   //XF9rA+yXJuKqPf7VVChGOaflVRr6r7q9gNcyf3T3TuyI7KIX/H5NW/d
   yt37ebvCyAmquu0bm3r8xJjlqH2mHumz0SAKr1xgjdJ+fdzyAobS1nc2m
   +hjv3XD4KMIxJDBbMqU9mSFTlnX6dFEEnpH10FXf0QtSvE9iyH3qUv3hV
   yUxFxovV1qgCMgQio1FqNNy4RfemQOBAc1m5tmS9lUM7yhr835+ChUaWd
   Vzqd36QX9EO2pOdC8qrQWIKADpf9k/Jb17R2XXPTIuHUmENeJB4k+RUvA
   Q==;
X-CSE-ConnectionGUID: V4Va7bwRRc+Uv68uQmpFwg==
X-CSE-MsgGUID: r82VU8LZRCC71GLxShgDyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="30381435"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="30381435"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 13:57:05 -0700
X-CSE-ConnectionGUID: 6qhZtbjVRJmEAVdY4rD6Yw==
X-CSE-MsgGUID: RZ0r+Ll4ReGVrTFCGCBMVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="96208155"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Sep 2024 13:56:59 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sueUq-000NeZ-27;
	Sat, 28 Sep 2024 20:56:56 +0000
Date: Sun, 29 Sep 2024 04:56:04 +0800
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
Message-ID: <202409290413.EtVuNEgl-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master next-20240927]
[cannot apply to v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Huang/PCI-Add-TLP-Processing-Hints-TPH-support/20240928-055915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240927215653.1552411-3-wei.huang2%40amd.com
patch subject: [PATCH V6 2/5] PCI/TPH: Add Steering Tag support
config: x86_64-buildonly-randconfig-001-20240929 (https://download.01.org/0day-ci/archive/20240929/202409290413.EtVuNEgl-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409290413.EtVuNEgl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409290413.EtVuNEgl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/tph.c:230:19: error: no member named 'msix_base' in 'struct pci_dev'; did you mean 'msix_cap'?
     230 |         vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
         |                          ^~~~~~~~~
         |                          msix_cap
   include/linux/pci.h:350:6: note: 'msix_cap' declared here
     350 |         u8              msix_cap;       /* MSI-X capability offset */
         |                         ^
   drivers/pci/tph.c:236:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
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
   1 warning and 1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_CRC32C_INTEL
   Depends on [n]: CRYPTO [=y] && !KMSAN [=y] && X86 [=y]
   Selected by [y]:
   - ISCSI_TARGET [=y] && TARGET_CORE [=y] && INET [=y] && X86 [=y]


vim +230 drivers/pci/tph.c

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
 > 230		vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
   231		vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
   232	
   233		val = readl(vec_ctrl);
   234		mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
   235		val &= ~mask;
   236		val |= FIELD_PREP(mask, st_val);
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

