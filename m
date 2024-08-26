Return-Path: <linux-pci+bounces-12199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F7595F01C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 13:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08632870BD
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FDE156225;
	Mon, 26 Aug 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/UmmYQo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023C155A5D;
	Mon, 26 Aug 2024 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672828; cv=none; b=YoUPPTQ0x0U0R26dVZpEaH7JE4lHJ5/bDp+bir7FDWdx+PljCyk773ZN1Jc33iVNIJPp6fVU/1DknA+LY0qkVXNr8iEJyFcjIadP1hEXVXzMkpon3fAOZgvkdGLdyFj1c6kAsq1WqIeMpwcZcTKKRB/twCIUrBzEuFsx36NxcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672828; c=relaxed/simple;
	bh=FIp0iRgd7S3IbgZ7/Eu/tmSZWUh2umZ9WKVSWgKLxko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuEeRgxJ8RcYsT5DodVR9znrsYHyypYqf6qZEuMlkw3ydYiHjnt9TjOU8b2Ly8dAUaP0ngFFgukbriFAyLrC2ANWdSRDk9a43g2a8NJjQgZxMIWwlEfOUkV9vD+CM+YP5cBm1g1+eXiYnRnC8OLHpXIiBQykKNVUjby5jtJEntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/UmmYQo; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724672827; x=1756208827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FIp0iRgd7S3IbgZ7/Eu/tmSZWUh2umZ9WKVSWgKLxko=;
  b=E/UmmYQoqbVgT31qUeyHMzLt/YiSyBWy4eq6E9KY7yz1oTYrtFIG4k4a
   iN/b3wtGVtwe+k6LYifyvHlycZ3r5FoZoA5hl1XspGcSvt+W/XDtYbBUC
   nu5vW5Uv4LQQ65wkBEe7LLvRT3+aNUaxz2yHgrDi3eV2YHmV85n2jNAEs
   x+Ye4/zd5g4db6iOLouDdUc7hQfyFMCW2Fj7eTW+eSc5iWxKkcGaNoldX
   hKDZQnefdXUnropvh9i/NV8plXDJkz6Rwpq1CE1REeJhJXOlCOhMJ6Z/h
   Ov+zuACgShuUiRYu/M1QWI/ha4GJOjrFNpqt4jc4+dw5mkRYrF4RUP+ou
   w==;
X-CSE-ConnectionGUID: hCtPuIcdSceOSxwPi+0D5w==
X-CSE-MsgGUID: 08q8crEbRTWjAa2TitUnHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="23243771"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23243771"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 04:47:06 -0700
X-CSE-ConnectionGUID: NriRihhNQvW0cnXETzoSfw==
X-CSE-MsgGUID: vO4WWXUwRQuZOP57+w9XPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62183218"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Aug 2024 04:47:00 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siYBV-000H0F-2x;
	Mon, 26 Aug 2024 11:46:57 +0000
Date: Mon, 26 Aug 2024 19:46:22 +0800
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
Subject: Re: [PATCH V4 07/12] PCI/TPH: Add pcie_tph_set_st_entry() to set ST
 tag
Message-ID: <202408261902.hGVx0hL8-lkp@intel.com>
References: <20240822204120.3634-8-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822204120.3634-8-wei.huang2@amd.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Huang/PCI-Introduce-PCIe-TPH-support-framework/20240826-121149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240822204120.3634-8-wei.huang2%40amd.com
patch subject: [PATCH V4 07/12] PCI/TPH: Add pcie_tph_set_st_entry() to set ST tag
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240826/202408261902.hGVx0hL8-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261902.hGVx0hL8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408261902.hGVx0hL8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pcie/tph.c:116:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     116 |         val |= FIELD_PREP(mask, tag);
         |                ^~~~~~~~~~~~~~~~~~~~~
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


vim +116 drivers/pci/pcie/tph.c

    87	
    88	/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
    89	static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
    90	{
    91		struct msi_desc *msi_desc = NULL;
    92		void __iomem *vec_ctrl;
    93		u32 val, mask;
    94		int err = 0;
    95	
    96		msi_lock_descs(&pdev->dev);
    97	
    98		/* Find the msi_desc entry with matching msix_idx */
    99		msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
   100			if (msi_desc->msi_index == msix_idx)
   101				break;
   102		}
   103	
   104		if (!msi_desc) {
   105			err = -ENXIO;
   106			goto err_out;
   107		}
   108	
   109		/* Get the vector control register (offset 0xc) pointed by msix_idx */
   110		vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
   111		vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
   112	
   113		val = readl(vec_ctrl);
   114		mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
   115		val &= ~mask;
 > 116		val |= FIELD_PREP(mask, tag);
   117		writel(val, vec_ctrl);
   118	
   119		/* Read back to flush the update */
   120		val = readl(vec_ctrl);
   121	
   122	err_out:
   123		msi_unlock_descs(&pdev->dev);
   124		return err;
   125	}
   126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

