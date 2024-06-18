Return-Path: <linux-pci+bounces-8935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D590DE5F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EB31F22358
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8281891CB;
	Tue, 18 Jun 2024 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLLLbPZ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EC17921D
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745866; cv=none; b=bXMxdDzpleSUykocXjBsiLU9sWbJJdkNKoR/GnV7SzRrmbK1D39hBOKFCDGWTNtgJd4JokwFe2KI8u7YZ4CfqnwF9K5yWD2oFCzp6qYA51Qb+TgQMuMcM17XUdYkBTzzAIq41Z42UnAJ7CcZnsbvRQnCTeeAG8t5Vc5F0syt5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745866; c=relaxed/simple;
	bh=rKy0jtg4Q2OfYjjIPixwplPvWQsd5XHUugBQVc5/jOI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mnUI8sZ4dvKIrnv9WdHsH6vpettq7yR2rsI6i7Olrm5pWIaOQNuqqEOhQ06/AfIVScIkkIFAD6IUaLkzZinTV1eD6qAdeYUbKWoddmDp5vmg9MWMferXwvr4gqy+ouVHkYMWJ4bO4/iAtpXVKOy5tT33hUuvo5O4Vku+9pDfEiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLLLbPZ+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718745864; x=1750281864;
  h=date:from:to:cc:subject:message-id;
  bh=rKy0jtg4Q2OfYjjIPixwplPvWQsd5XHUugBQVc5/jOI=;
  b=VLLLbPZ+Ce2SlAqGmpGHhc2z0EO5+VLJE8MxhEPpAYTAkyWvQGK0Qv6+
   gtyL0IbUz6jmJypxREey1N8vneUT22AKURfK/uho0znBF3SsF8//gMSDT
   wHX7dDNowmud7r6+OZcr2l9T/MrXgYMkMkYHhG1JPbr3Q53z0kg36pElD
   VSD9jz2/U3PlsZKd54FVVAaPVPjwyewJIGvfL9KSPGh1p1q/QAQqHl1sl
   ZpMOBtHX8L0Fzcy+Y7h3YLfCb91S/1xI7D/JWu5rGOsd2h3AEDoNfdni0
   nCW95fLUCCi/DNKuHZuVJ1zCUznSaxLh6a+H7xIeDfSCuZpl7lUEv6xG5
   g==;
X-CSE-ConnectionGUID: yGcJLhECRD65nwHHepkmCw==
X-CSE-MsgGUID: kKCYmpphQeS4ueucIAS6OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15626735"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15626735"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 14:24:23 -0700
X-CSE-ConnectionGUID: mlLKdmUvTJ+kbFHGnDkLgg==
X-CSE-MsgGUID: tz43zw/5QVSWeWsoQolEQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41789694"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2024 14:24:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJgJQ-0005w6-1K;
	Tue, 18 Jun 2024 21:24:20 +0000
Date: Wed, 19 Jun 2024 05:23:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 5ce20759783efc56600111480accac8397e0204d
Message-ID: <202406190522.SG9Rp6pz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: 5ce20759783efc56600111480accac8397e0204d  drm/vboxvideo: fix mapping leaks

elapsed time: 6028m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                         bcm2835_defconfig   clang-19
arm                     davinci_all_defconfig   clang-19
arm                                 defconfig   clang-14
arm                        mvebu_v7_defconfig   clang-15
arm                           u8500_defconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240615   clang-18
i386         buildonly-randconfig-002-20240615   gcc-9
i386         buildonly-randconfig-003-20240615   gcc-7
i386         buildonly-randconfig-004-20240615   clang-18
i386         buildonly-randconfig-005-20240615   clang-18
i386         buildonly-randconfig-006-20240615   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240615   clang-18
i386                  randconfig-002-20240615   gcc-13
i386                  randconfig-003-20240615   clang-18
i386                  randconfig-004-20240615   clang-18
i386                  randconfig-005-20240615   clang-18
i386                  randconfig-006-20240615   clang-18
i386                  randconfig-011-20240615   clang-18
i386                  randconfig-012-20240615   gcc-12
i386                  randconfig-013-20240615   gcc-13
i386                  randconfig-014-20240615   clang-18
i386                  randconfig-015-20240615   clang-18
i386                  randconfig-016-20240615   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5208evb_defconfig   gcc-13.2.0
m68k                          multi_defconfig   gcc-13.2.0
microblaze                       alldefconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                       eiger_defconfig   clang-19
powerpc                          g5_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   clang-16
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   clang-19
powerpc                     tqm8555_defconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                ecovec24-romimage_defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                generic_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

