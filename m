Return-Path: <linux-pci+bounces-41053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E87C55B78
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 864D334E4C0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 04:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01175301000;
	Thu, 13 Nov 2025 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+yUYbQv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7283009F8
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009605; cv=none; b=MCqX9dGbhwrkwosDOUmtj/Sfa7mCcHTcxb6IKcQTX6Y6kYw0csMgQXWbx3J7n59hZGs9gLo1gpma1ght0jAZk7q9hPrRaPRUmtjvfXxcjn0rwIfeR7A0dhFeS2NQGb2qPQWh6k2d8df0ITY8aaU23IuGaytZ1NF8k1x1o6xs5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009605; c=relaxed/simple;
	bh=MDTy5l7zBehoe+SZ4+HdMgrSU8NN3NUhiMGEUnkraTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MEGUg3DtXxeLdLq/NTfn3NZgc+qAouaimYNd6M1UMmgPFHbdbv2JtdAHFbmM9KImKG4wsGyQtT1oDVaiX2RQ6GyxcnKvDMo67Ms7pq411bQ9lGBVo1sWETC1UkO7SylB56ARh3ICN1Hu7kmDxByP477QXKlJWb+eqRFvg3otFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+yUYbQv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009605; x=1794545605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MDTy5l7zBehoe+SZ4+HdMgrSU8NN3NUhiMGEUnkraTU=;
  b=Y+yUYbQvz84duTC8xO1eP/H7Mu4yGOygixkEJ7H6uL8PvvuvZnTmerhc
   N6vWDy4a0OGxgbE+K5rRX9SyVEubfH/0r/wcEKhgc0xytF6vZ9GsaJrSd
   MJgxM4WGgqsIt3W5nTzNvoOiqrCYy+qMov9+nL88qlzX0M0Emm014xACz
   b1nin6GRKhFyt0TRe+1fG6e6x3tu7yVbXfIQMSA51hle7Ugt1e3hxAmmx
   ZcoGJnW++3180atNPU+xcUS7b71hmchgvFLXWW++ukeJpCzeUBxPkK/mF
   rmQ2l1LmwRbKqHHjKNmUBpCrtvD6Hgpxn7JjtmggVvTXb+RfokUqEXxpy
   w==;
X-CSE-ConnectionGUID: AbuU8RHuS4e9LWZ2PuL5Vg==
X-CSE-MsgGUID: YeQZsdeJS3ycga5PesPu/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82480075"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="82480075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:53:24 -0800
X-CSE-ConnectionGUID: rijXJvZUSse0BSAmNvPBpQ==
X-CSE-MsgGUID: tODqS8BESkOR7W5dEGWH9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189415463"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2025 20:53:21 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPKh-0004uO-1s;
	Thu, 13 Nov 2025 04:53:19 +0000
Date: Thu, 13 Nov 2025 12:52:30 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:for-linus 6/6] drivers/pci/quirks.c:2528:56: error: use of
 undeclared identifier 'quirk_disable_aspm_l0s_l1_cap'; did you mean
 'quirk_disable_aspm_l0s_l1'?
Message-ID: <202511131032.6htiMYJT-lkp@intel.com>
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
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20251113/202511131032.6htiMYJT-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 996639d6ebb86ff15a8c99b67f1c2e2117636ae7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131032.6htiMYJT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131032.6htiMYJT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/quirks.c:2528:56: error: use of undeclared identifier 'quirk_disable_aspm_l0s_l1_cap'; did you mean 'quirk_disable_aspm_l0s_l1'?
    2528 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                        quirk_disable_aspm_l0s_l1
   include/linux/pci.h:2362:40: note: expanded from macro 'DECLARE_PCI_FIXUP_HEADER'
    2362 |                 hook, vendor, device, PCI_ANY_ID, 0, hook)
         |                                                      ^~~~
   include/linux/pci.h:2321:43: note: expanded from macro 'DECLARE_PCI_FIXUP_SECTION'
    2321 |                 = { vendor, device, class, class_shift, hook };
         |                                                         ^~~~
   drivers/pci/quirks.c:2514:13: note: 'quirk_disable_aspm_l0s_l1' declared here
    2514 | static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
         |             ^
   1 error generated.


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

