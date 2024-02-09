Return-Path: <linux-pci+bounces-3269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A2A84F040
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 07:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC93F1C21894
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF53527A;
	Fri,  9 Feb 2024 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKhiasXx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7ED651AC
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460399; cv=none; b=oAANazjbV9gwuhxGW/msqXh0bz1Qk9jljqJ7HOmc+c9G3eBcIN9wZtu+t+2EUblZhPcYlXXoWHvYihUNDIaHYBtojONZIQRWOJmuUw8yMQ2w+jB25roRnQ0hb3gjVXZzHeE5QkWULQekgdSS1ZAih/Rb4pSNfHAa9Dc8Qmy2a0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460399; c=relaxed/simple;
	bh=ITIeP8vbObiBM1zadARfanQrjWHXHJUwBef/AEn+DtI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lDQqmvwB46EFsPXnEYZBN3rUibDVS65PL54gygQV8/nBMHhgYg+p1Y24kgiIwftfqHuJtWVxmYKeifcd3JUacaTq2KY5RxhbAuCuVgErZjKnDgKEzCzbUtjZN/JRa3XyiSjIh7yCmXQIeXeRKx73Q96yXG3Z5CWubLTpa2EbXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKhiasXx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707460397; x=1738996397;
  h=date:from:to:cc:subject:message-id;
  bh=ITIeP8vbObiBM1zadARfanQrjWHXHJUwBef/AEn+DtI=;
  b=kKhiasXxIcTnIv8rR1eRqVq75/YN7Jm9X8+EgyUibQXvNrLwiRKi0N7M
   HNYmc6ogHAJYkN9HdHFk8RjHv1CcfV5EMsIaa1YXpkyLmeyCFh+Y9TQQG
   bVA7c7cLuLX4f0SMIVFtXmDLquqRnpJApzluDCzOUsPX41J24Pa09oGzF
   2HvvFu+VD4b6AFoRik7TP5dk3PZnue7DfycVUY5Bckrlu7nFKIpJG1l5P
   cTyFs0734VRkuXdGGD8jMVbEGrGT8uQNmG/oIr1NYD+OqoKDxDzFJa6H9
   atH4me9qrEmS2oXGslL5xh3tj2aPtZ6hoJmbHNHJLfYHWi9Lsv4d3b5PR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12026767"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="12026767"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 22:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="25100196"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Feb 2024 22:33:15 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYKRk-0004SA-3A;
	Fri, 09 Feb 2024 06:33:12 +0000
Date: Fri, 09 Feb 2024 14:32:16 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 b91da7308171ac4ad2623d371f37288dafbb3bdc
Message-ID: <202402091413.dTYQLcpi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: b91da7308171ac4ad2623d371f37288dafbb3bdc  PCI: endpoint: Make pci_epf_bus_type const

elapsed time: 1462m

configs tested: 265
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240208   gcc  
arc                   randconfig-001-20240209   gcc  
arc                   randconfig-002-20240208   gcc  
arc                   randconfig-002-20240209   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-001-20240208   gcc  
arm                   randconfig-002-20240208   gcc  
arm                   randconfig-002-20240209   gcc  
arm                   randconfig-003-20240208   gcc  
arm                   randconfig-003-20240209   gcc  
arm                   randconfig-004-20240208   clang
arm                   randconfig-004-20240209   gcc  
arm                       spear13xx_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240208   clang
arm64                 randconfig-002-20240208   clang
arm64                 randconfig-003-20240208   clang
arm64                 randconfig-004-20240208   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240208   gcc  
csky                  randconfig-001-20240209   gcc  
csky                  randconfig-002-20240208   gcc  
csky                  randconfig-002-20240209   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240208   clang
hexagon               randconfig-002-20240208   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240208   gcc  
i386         buildonly-randconfig-002-20240208   clang
i386         buildonly-randconfig-003-20240208   gcc  
i386         buildonly-randconfig-003-20240209   gcc  
i386         buildonly-randconfig-004-20240208   gcc  
i386         buildonly-randconfig-005-20240208   gcc  
i386         buildonly-randconfig-006-20240208   gcc  
i386         buildonly-randconfig-006-20240209   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240208   gcc  
i386                  randconfig-002-20240208   gcc  
i386                  randconfig-002-20240209   gcc  
i386                  randconfig-003-20240208   gcc  
i386                  randconfig-004-20240208   clang
i386                  randconfig-005-20240208   gcc  
i386                  randconfig-006-20240208   gcc  
i386                  randconfig-006-20240209   gcc  
i386                  randconfig-011-20240208   clang
i386                  randconfig-011-20240209   gcc  
i386                  randconfig-012-20240208   clang
i386                  randconfig-012-20240209   gcc  
i386                  randconfig-013-20240208   clang
i386                  randconfig-014-20240208   clang
i386                  randconfig-014-20240209   gcc  
i386                  randconfig-015-20240208   clang
i386                  randconfig-015-20240209   gcc  
i386                  randconfig-016-20240208   gcc  
i386                  randconfig-016-20240209   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240208   gcc  
loongarch             randconfig-001-20240209   gcc  
loongarch             randconfig-002-20240208   gcc  
loongarch             randconfig-002-20240209   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240208   gcc  
nios2                 randconfig-001-20240209   gcc  
nios2                 randconfig-002-20240208   gcc  
nios2                 randconfig-002-20240209   gcc  
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
parisc                randconfig-001-20240209   gcc  
parisc                randconfig-002-20240208   gcc  
parisc                randconfig-002-20240209   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                        fsp2_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20240208   clang
powerpc               randconfig-002-20240208   gcc  
powerpc               randconfig-003-20240208   gcc  
powerpc               randconfig-003-20240209   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-001-20240208   gcc  
powerpc64             randconfig-002-20240208   gcc  
powerpc64             randconfig-003-20240208   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240208   gcc  
riscv                 randconfig-002-20240208   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240208   clang
s390                  randconfig-001-20240209   gcc  
s390                  randconfig-002-20240208   gcc  
s390                  randconfig-002-20240209   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240208   gcc  
sh                    randconfig-001-20240209   gcc  
sh                    randconfig-002-20240208   gcc  
sh                    randconfig-002-20240209   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240208   gcc  
sparc64               randconfig-001-20240209   gcc  
sparc64               randconfig-002-20240208   gcc  
sparc64               randconfig-002-20240209   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240208   clang
um                    randconfig-001-20240209   gcc  
um                    randconfig-002-20240208   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240208   clang
x86_64       buildonly-randconfig-001-20240209   gcc  
x86_64       buildonly-randconfig-002-20240208   clang
x86_64       buildonly-randconfig-002-20240209   gcc  
x86_64       buildonly-randconfig-003-20240208   gcc  
x86_64       buildonly-randconfig-003-20240209   clang
x86_64       buildonly-randconfig-004-20240208   clang
x86_64       buildonly-randconfig-004-20240209   gcc  
x86_64       buildonly-randconfig-005-20240208   clang
x86_64       buildonly-randconfig-005-20240209   clang
x86_64       buildonly-randconfig-006-20240208   clang
x86_64       buildonly-randconfig-006-20240209   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240208   gcc  
x86_64                randconfig-001-20240209   clang
x86_64                randconfig-002-20240208   gcc  
x86_64                randconfig-002-20240209   gcc  
x86_64                randconfig-003-20240208   gcc  
x86_64                randconfig-003-20240209   gcc  
x86_64                randconfig-004-20240208   clang
x86_64                randconfig-004-20240209   clang
x86_64                randconfig-005-20240208   gcc  
x86_64                randconfig-005-20240209   gcc  
x86_64                randconfig-006-20240208   gcc  
x86_64                randconfig-006-20240209   gcc  
x86_64                randconfig-011-20240208   gcc  
x86_64                randconfig-011-20240209   clang
x86_64                randconfig-012-20240208   gcc  
x86_64                randconfig-012-20240209   clang
x86_64                randconfig-013-20240208   clang
x86_64                randconfig-013-20240209   gcc  
x86_64                randconfig-014-20240208   clang
x86_64                randconfig-014-20240209   clang
x86_64                randconfig-015-20240208   clang
x86_64                randconfig-015-20240209   gcc  
x86_64                randconfig-016-20240208   clang
x86_64                randconfig-016-20240209   clang
x86_64                randconfig-071-20240208   clang
x86_64                randconfig-071-20240209   gcc  
x86_64                randconfig-072-20240208   clang
x86_64                randconfig-072-20240209   clang
x86_64                randconfig-073-20240208   gcc  
x86_64                randconfig-073-20240209   clang
x86_64                randconfig-074-20240208   clang
x86_64                randconfig-074-20240209   gcc  
x86_64                randconfig-075-20240208   gcc  
x86_64                randconfig-075-20240209   gcc  
x86_64                randconfig-076-20240208   gcc  
x86_64                randconfig-076-20240209   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240208   gcc  
xtensa                randconfig-001-20240209   gcc  
xtensa                randconfig-002-20240208   gcc  
xtensa                randconfig-002-20240209   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

