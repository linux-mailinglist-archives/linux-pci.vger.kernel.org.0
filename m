Return-Path: <linux-pci+bounces-3244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DBD84E8F0
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 20:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8E3B2EFCD
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 19:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DC3374F0;
	Thu,  8 Feb 2024 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idJ6Ga1V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6436B17
	for <linux-pci@vger.kernel.org>; Thu,  8 Feb 2024 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420479; cv=none; b=E3Hdl4kVNiBi78NKKtHqfOil/toNiGr4Xtd/mEUeVEOoWKbuv1msnKwzWlLgDYDlrB5fof4q/ncFso8+D6DItYeS5PTqAdrI3OeZV11LH+vaDmZi2sl2zL130UiqxI81adFU4xXbUarVBxoEB6nd+eMh1LAsDoD/5DWu9vF/yHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420479; c=relaxed/simple;
	bh=4WF4b5VKBGVLSvdf8GKMiVLbBulNAVoOD1IGvuw1pBQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HZ98+RFhprato+E+nQ30+421c0kV8b9heDNiP5cs1ndV21MvldPBJsYIIOUmzFfLoIYSoawZ+xqnrKuVGpqTtoS4Kq6mJvDvMc5cfPAxFnmnmY6HCl0NZdts/BIFVS8T9T8MKYhhcLUhr9YqXlcxQy7iktp1e2eSCKt3louLIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idJ6Ga1V; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707420477; x=1738956477;
  h=date:from:to:cc:subject:message-id;
  bh=4WF4b5VKBGVLSvdf8GKMiVLbBulNAVoOD1IGvuw1pBQ=;
  b=idJ6Ga1Vl4U9PE4jgs+XpYISay/YKHsc/o1DjdipvDwW3LAX4Vx31aV1
   t2E1zsg2aX3HMAkVJSJ8ZpvS6SBZeRIeZwCpI6S3IqJJyNAhpp9KtcA+E
   9PrpvqfadTR1/yRH+6H7J5ojAkiKvsdK5yTq1v95/j46ZiC0c6omLF+wO
   o9Es45kfwUvxkRs0BSPXfBjaDL0/Z/hibv6KUU9RzUGgKeLJptdCS5U5k
   ji71Q9jW7gpkmbpzfjbnIyQEp1qKVQNfJmUAEvXMl0odMW1PcEuBpjDSr
   z881Dku0e5Sc6mV2sfkwvttpzi4iIKXWIZ7ygJ6xvJqkwQpaOhXlvZwkq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1441087"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1441087"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 11:27:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6352218"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Feb 2024 11:27:55 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYA3t-00044Q-0o;
	Thu, 08 Feb 2024 19:27:53 +0000
Date: Fri, 09 Feb 2024 03:26:55 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 67057f48df79a3d73683385f521215146861684b
Message-ID: <202402090353.KHNlosDa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 67057f48df79a3d73683385f521215146861684b  PCI: dwc: Clean up dw_pcie_ep_raise_msi_irq() alignment

elapsed time: 1450m

configs tested: 176
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240208   gcc  
arc                   randconfig-002-20240208   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240208   gcc  
arm                   randconfig-002-20240208   gcc  
arm                   randconfig-003-20240208   gcc  
arm                           tegra_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-004-20240208   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240208   gcc  
csky                  randconfig-002-20240208   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240208   gcc  
i386         buildonly-randconfig-002-20240208   clang
i386         buildonly-randconfig-003-20240208   gcc  
i386         buildonly-randconfig-004-20240208   gcc  
i386         buildonly-randconfig-005-20240208   gcc  
i386         buildonly-randconfig-006-20240208   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240208   gcc  
i386                  randconfig-002-20240208   gcc  
i386                  randconfig-003-20240208   gcc  
i386                  randconfig-004-20240208   clang
i386                  randconfig-005-20240208   gcc  
i386                  randconfig-006-20240208   gcc  
i386                  randconfig-011-20240208   clang
i386                  randconfig-012-20240208   clang
i386                  randconfig-013-20240208   clang
i386                  randconfig-014-20240208   clang
i386                  randconfig-015-20240208   clang
i386                  randconfig-016-20240208   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240208   gcc  
loongarch             randconfig-002-20240208   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                     cu1830-neo_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240208   gcc  
nios2                 randconfig-002-20240208   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240208   gcc  
parisc                randconfig-002-20240208   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                       eiger_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                      pcm030_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-002-20240208   gcc  
powerpc               randconfig-003-20240208   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64                        alldefconfig   clang
powerpc64             randconfig-001-20240208   gcc  
powerpc64             randconfig-002-20240208   gcc  
powerpc64             randconfig-003-20240208   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240208   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240208   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240208   gcc  
sh                    randconfig-002-20240208   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240208   gcc  
sparc64               randconfig-002-20240208   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-002-20240208   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-003-20240208   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240208   gcc  
x86_64                randconfig-002-20240208   gcc  
x86_64                randconfig-003-20240208   gcc  
x86_64                randconfig-005-20240208   gcc  
x86_64                randconfig-006-20240208   gcc  
x86_64                randconfig-011-20240208   gcc  
x86_64                randconfig-012-20240208   gcc  
x86_64                randconfig-073-20240208   gcc  
x86_64                randconfig-075-20240208   gcc  
x86_64                randconfig-076-20240208   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240208   gcc  
xtensa                randconfig-002-20240208   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

