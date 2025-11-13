Return-Path: <linux-pci+bounces-41052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F7EC55B63
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7F984E1EE5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 04:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228562DFF3F;
	Thu, 13 Nov 2025 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep8kBNy8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA13009D3
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009605; cv=none; b=MLfOwJhp0SWxaZnABAsV8h89kPhRYOUaMH9usV8xKpbglxeSziHJBIdmM84x4K3DnO4CfTQb5bSuENdRhfuG5zCsWVpSTcg6J2t3p1bEPBWRN+wnO5GGLf/r2QxyD7506MrLLy4q6EzAhyCuDkyYf9p7upLrzziUBGvVKIHqd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009605; c=relaxed/simple;
	bh=Sgk4sNsoPmm9DQzn3ceYNqEReekm5CzcVM4xwpOkc0o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SHMnAWGxUfnjmnsN9dvsWMs/hVTA4PUEi7i3qpQaAeleroHSF0ilx9wroITRGn5L1qLJy07Kz+bWdbhZHyZnMnvQGNZ6NY6gfdG2sTBfoSkV5FrD77+AncxnGDVsTQKskZbQm20QTmx5oE7W/PnWw7rU9NDjn5nSlUzGvdhSM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep8kBNy8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009604; x=1794545604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Sgk4sNsoPmm9DQzn3ceYNqEReekm5CzcVM4xwpOkc0o=;
  b=Ep8kBNy8qKorytH/NAIRp1/vRAyO68fevUzgRq2DZYyhb4pIIwDgVzCN
   UcFbrH9+zKGWMDHxBANSxqe77CUmyzi6Df1TFeM3rsgoH7cBx3YO0rNxu
   XW1UPmOs/mdPrFAavHSMmpSDOlWGjJbj631q7nDIqRQku+yEM09ruFerX
   0rSVi94USU2zoO+CitkV0aAUybWmMqptG+UIUcK1KiJFvih3grLhcZTBM
   xRjFiAJZ6xnFHGyhtN5yPZVlV2PPo/zMNkarIr9PQCMRwauHyzRi1jSY0
   XHHyA+ip+DaTKKudNa4tv2k5v386cEWx+NqDMfwHYxGEGVyENLka0Gs7r
   g==;
X-CSE-ConnectionGUID: lLuQAr/1Qc65Qz6wZ8MhFw==
X-CSE-MsgGUID: 79QCNSm1T9OyD6Gfil0/Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82480071"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="82480071"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:53:23 -0800
X-CSE-ConnectionGUID: ABE8EZQ2SUax+nD615gsTw==
X-CSE-MsgGUID: E/QqV3EQSUSu8ZNfMYlAdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189415464"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2025 20:53:21 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPKh-0004uL-1o;
	Thu, 13 Nov 2025 04:53:19 +0000
Date: Thu, 13 Nov 2025 12:52:34 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:for-linus 6/6] drivers/pci/quirks.c:2528:56: error:
 'quirk_disable_aspm_l0s_l1_cap' undeclared here (not in a function); did you
 mean 'quirk_disable_aspm_l0s_l1'?
Message-ID: <202511131022.oNFNddSz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
head:   c478e1774359af6039f586f0a49280cfe180a21b
commit: c478e1774359af6039f586f0a49280cfe180a21b [6/6] PCI/ASPM: Avoid L0s and L1 on Hi1105 [19e5:1105] Wi-Fi
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20251113/202511131022.oNFNddSz-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131022.oNFNddSz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131022.oNFNddSz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/quirks.c:21:
>> drivers/pci/quirks.c:2528:56: error: 'quirk_disable_aspm_l0s_l1_cap' undeclared here (not in a function); did you mean 'quirk_disable_aspm_l0s_l1'?
    2528 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:2321:57: note: in definition of macro 'DECLARE_PCI_FIXUP_SECTION'
    2321 |                 = { vendor, device, class, class_shift, hook };
         |                                                         ^~~~
   drivers/pci/quirks.c:2528:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
    2528 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
         | ^~~~~~~~~~~~~~~~~~~~~~~~


vim +2528 drivers/pci/quirks.c

  2519	
  2520	/*
  2521	 * ASM1083/1085 PCIe-PCI bridge devices cause AER timeout errors on the
  2522	 * upstream PCIe root port when ASPM is enabled. At least L0s mode is affected;
  2523	 * disable both L0s and L1 for now to be safe.
  2524	 */
  2525	DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
  2526	DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
  2527	DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PASEMI, 0xa002, quirk_disable_aspm_l0s_l1);
> 2528	DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
  2529	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

