Return-Path: <linux-pci+bounces-13314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A90797D08A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 06:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C1D1F24552
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 04:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1102231C;
	Fri, 20 Sep 2024 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3G5jYtc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0310879D2;
	Fri, 20 Sep 2024 04:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726806562; cv=none; b=Zc5NWk6d6kPCwgZv+6fX0g/MwSNhevG+VDjCun2f0hzGAsGGOnm1fXij/1NEbVvd+lIRUuVsGSrvlQ37cyd/XWGWixeAkExWrW2vuT7duO1FhAdWUrBMjGQ6iIWTca4itMPAEqsAwCLKlaDe+CsUl8QwOMFX5XHsFs+qSwEBZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726806562; c=relaxed/simple;
	bh=7OI69Dbq64XO6NFe8O3Ks+AB5DeVlameRcJBVDTMDzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9hTM+JSnbkj+7rQzp3bhm/y+bcevO0eIJogSGrmeN7lRcat2pFTOtK9C5vuvv/ZGr3ml91UBBm3rCuqDtHsaL3i5ZbZFToMQOX2+FnE8eDpb0euaZ3rm5KRsZ802ZhOScnOIlOsvTYZ/QoF0XoIX3tlfSjhkQEaUWxbJhjvuig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3G5jYtc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726806560; x=1758342560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7OI69Dbq64XO6NFe8O3Ks+AB5DeVlameRcJBVDTMDzw=;
  b=Q3G5jYtc1hHAaOWyU1rs+o9TvGf37NusH601BFhwfF2krAyqH6RDUwl8
   rahp7MFdI3PwA8/Y6sNuuICNlD7ExJIx3XWLmzauo1OGQZhQUvikDptFo
   /ETx72J2E+b4unk0uz+EiLI5motCYYW8oE8NdgUrTEbHp+xGvj1JbH1qs
   r6TixXmhzuPfWwDyJqFX6ggHuM4yfwPaI135SxyaU+Sb79xo5NEFMC3L1
   u0sfWol+Kcyq039JWtzGufYoiXI5oGA//N3CV46KnXEzvTchiViTTIc8L
   quEqjLDvSei6PGjVsAD6/vMNET3E5Wyk/ziiQSwqdy/a6sf0lQtH9V+/W
   g==;
X-CSE-ConnectionGUID: QdHXSsH9Rx6tVZf/ZpBBPA==
X-CSE-MsgGUID: U34lEFizSLCaEBTsI6eKAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25745771"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25745771"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 21:29:19 -0700
X-CSE-ConnectionGUID: mIXwfmt3Q36E5AYC2QmlEg==
X-CSE-MsgGUID: klCmEn5HRjiekeu+HFuJKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70404987"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2024 21:29:17 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srVGc-000Dxo-1w;
	Fri, 20 Sep 2024 04:29:14 +0000
Date: Fri, 20 Sep 2024 12:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org, logang@deltatee.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com, sjeaugey@nvidia.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [PATCH 1/2 v2] PCI/portdrv: Enable reporting inter-switch P2P
 links
Message-ID: <202409201219.feYAxGor-lkp@intel.com>
References: <1726733624-2142-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726733624-2142-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>

Hi Shivasharan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20240919]
[cannot apply to pci/for-linus linus/master v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shivasharan-S/PCI-portdrv-Enable-reporting-inter-switch-P2P-links/20240919-162626
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1726733624-2142-2-git-send-email-shivasharan.srikanteshwara%40broadcom.com
patch subject: [PATCH 1/2 v2] PCI/portdrv: Enable reporting inter-switch P2P links
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240920/202409201219.feYAxGor-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409201219.feYAxGor-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409201219.feYAxGor-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pcie/portdrv.c:86: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Determine if device supports Inter switch P2P links.


vim +86 drivers/pci/pcie/portdrv.c

    84	
    85	/**
  > 86	 * Determine if device supports Inter switch P2P links.
    87	 *
    88	 * Return value: true if inter switch P2P is supported, return false otherwise.
    89	 */
    90	static bool pcie_port_is_p2p_supported(struct pci_dev *dev)
    91	{
    92		/* P2P link attribute is supported on upstream ports only */
    93		if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
    94			return false;
    95	
    96		/*
    97		 * Currently Broadcom PEX switches are supported.
    98		 */
    99		if (dev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&
   100		    (dev->device == PCI_DEVICE_ID_BRCM_PEX_89000_HLC ||
   101		     dev->device == PCI_DEVICE_ID_BRCM_PEX_89000_LLC))
   102			return pcie_brcm_is_p2p_supported(dev);
   103	
   104		return false;
   105	}
   106	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

