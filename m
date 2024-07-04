Return-Path: <linux-pci+bounces-9769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F4926D34
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 03:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EEC3B2226D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 01:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317ECC2ED;
	Thu,  4 Jul 2024 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpUMt8Qb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B451746E
	for <linux-pci@vger.kernel.org>; Thu,  4 Jul 2024 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057725; cv=none; b=D2VqFK7DOrSMUmmEp5AcnE8yVkNEcjzuuZG7Y94mMQdwaRpDs3xUjxsdy4Fyx88w9mmradJo0Kn2cKoor6jvP0dynb+l6R7Dq7lfwLs1IlMRqmXC2/bOMG9c62TZFxL9I15B1RLuFF3y9aD4g+almY0BKYp0U0BTRKlmQCeo2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057725; c=relaxed/simple;
	bh=ay5N3T3404hEVW5WZcDsFXLGmhLzRzYObQuR+II+aNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oI+4AXNzgavQFqybNAr+aVp+BHMVSdxHwWCpGW6bJCe/vWmtvh+sLuA9NBdOpYkliL5PEaZQCPe5W9M522LPLrlb5zEH555fbA0JIXPvLgeL/07/8DSRmIN0arzPtwN769gsUfD5GA0bnGT6LI4jsZUC/RhDpvfV2CqOZz+hK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpUMt8Qb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720057724; x=1751593724;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ay5N3T3404hEVW5WZcDsFXLGmhLzRzYObQuR+II+aNE=;
  b=SpUMt8QbobdO0Zuy0ZLcbyo2Q7UaTH6sNRADrmP5YfoOy9LdWD27sJkj
   u7xz1XDTzxd2En4HvTXj+6UCu6iOEkTMv6duI5RJFxYhaJ5KL7Cr4sv4L
   B0cbSq6UEmI+DgJ3A1o2nNMpzg4lV8nMEWIL5yzW55xgVMewAtUyRG69z
   NXFaLg6HX5XXs4KWKWBNApFacFC56VUMphLa2ilj4QnjEQVj67wF3VPOg
   MvVUV4syAfKSHK7beSqHvM2cdkemuDrnMkrkWLZEEhTbL6bRSep/qL0vn
   kYhR7ArBLg+4po0mcupziwGoYzV3V/V98zaik7FfR0EbYss2KiK1C/40W
   Q==;
X-CSE-ConnectionGUID: hc0pFNS0SZyTkTqdy8a2Eg==
X-CSE-MsgGUID: Bm6l850kTrqNMxdkcYXmlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="42740474"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="42740474"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:48:43 -0700
X-CSE-ConnectionGUID: FSTpzRz3T3CgWr/YN4wBKQ==
X-CSE-MsgGUID: qmOy/n8LSKaaz9x1B1kEDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51616012"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Jul 2024 18:48:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPBaR-000QQO-1S;
	Thu, 04 Jul 2024 01:48:39 +0000
Date: Thu, 04 Jul 2024 09:47:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 c13072f930dab2340a4b16382162b4c0f010281c
Message-ID: <202407040936.3qAi4tjN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: c13072f930dab2340a4b16382162b4c0f010281c  PCI: dwc: ep: Enforce DWC specific 64-bit BAR limitation

elapsed time: 1463m

configs tested: 195
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240703   gcc-13.2.0
arc                   randconfig-002-20240703   gcc-13.2.0
arm                              alldefconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                          collie_defconfig   gcc-13.2.0
arm                     davinci_all_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                           h3600_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                   randconfig-001-20240703   gcc-13.2.0
arm                   randconfig-002-20240703   gcc-13.2.0
arm                   randconfig-003-20240703   gcc-13.2.0
arm                   randconfig-004-20240703   gcc-13.2.0
arm                       spear13xx_defconfig   gcc-13.2.0
arm                        spear3xx_defconfig   gcc-13.2.0
arm                       versatile_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240703   gcc-13.2.0
arm64                 randconfig-002-20240703   gcc-13.2.0
arm64                 randconfig-003-20240703   gcc-13.2.0
arm64                 randconfig-004-20240703   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240703   gcc-13.2.0
csky                  randconfig-002-20240703   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240703   clang-18
i386         buildonly-randconfig-002-20240703   clang-18
i386         buildonly-randconfig-003-20240703   clang-18
i386         buildonly-randconfig-004-20240703   clang-18
i386         buildonly-randconfig-005-20240703   clang-18
i386         buildonly-randconfig-006-20240703   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240703   clang-18
i386                  randconfig-002-20240703   clang-18
i386                  randconfig-003-20240703   clang-18
i386                  randconfig-004-20240703   clang-18
i386                  randconfig-005-20240703   clang-18
i386                  randconfig-006-20240703   clang-18
i386                  randconfig-011-20240703   clang-18
i386                  randconfig-012-20240703   clang-18
i386                  randconfig-013-20240703   clang-18
i386                  randconfig-014-20240703   clang-18
i386                  randconfig-015-20240703   clang-18
i386                  randconfig-016-20240703   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240703   gcc-13.2.0
loongarch             randconfig-002-20240703   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                         amcore_defconfig   gcc-13.2.0
m68k                          atari_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        stmark2_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          eyeq5_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                           mtx1_defconfig   gcc-13.2.0
mips                          rm200_defconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240703   gcc-13.2.0
nios2                 randconfig-002-20240703   gcc-13.2.0
openrisc                         allmodconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                  or1klitex_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240703   gcc-13.2.0
parisc                randconfig-002-20240703   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                     asp8347_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                   motionpro_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc               mpc834x_itxgp_defconfig   gcc-13.2.0
powerpc                      ppc40x_defconfig   gcc-13.2.0
powerpc               randconfig-003-20240703   gcc-13.2.0
powerpc                     tqm8560_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240703   gcc-13.2.0
powerpc64             randconfig-002-20240703   gcc-13.2.0
powerpc64             randconfig-003-20240703   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240703   gcc-13.2.0
riscv                 randconfig-002-20240703   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240703   gcc-13.2.0
s390                  randconfig-002-20240703   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                               j2_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                    randconfig-001-20240703   gcc-13.2.0
sh                    randconfig-002-20240703   gcc-13.2.0
sh                          rsk7264_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                            allyesconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240703   gcc-13.2.0
sparc64               randconfig-002-20240703   gcc-13.2.0
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240703   gcc-13.2.0
um                    randconfig-002-20240703   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                           alldefconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240703   clang-18
x86_64       buildonly-randconfig-002-20240703   clang-18
x86_64       buildonly-randconfig-003-20240703   clang-18
x86_64       buildonly-randconfig-004-20240703   clang-18
x86_64       buildonly-randconfig-005-20240703   clang-18
x86_64       buildonly-randconfig-006-20240703   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240703   clang-18
x86_64                randconfig-002-20240703   clang-18
x86_64                randconfig-003-20240703   clang-18
x86_64                randconfig-004-20240703   clang-18
x86_64                randconfig-005-20240703   clang-18
x86_64                randconfig-006-20240703   clang-18
x86_64                randconfig-011-20240703   clang-18
x86_64                randconfig-012-20240703   clang-18
x86_64                randconfig-013-20240703   clang-18
x86_64                randconfig-014-20240703   clang-18
x86_64                randconfig-015-20240703   clang-18
x86_64                randconfig-016-20240703   clang-18
x86_64                randconfig-071-20240703   clang-18
x86_64                randconfig-072-20240703   clang-18
x86_64                randconfig-073-20240703   clang-18
x86_64                randconfig-074-20240703   clang-18
x86_64                randconfig-075-20240703   clang-18
x86_64                randconfig-076-20240703   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                           allyesconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240703   gcc-13.2.0
xtensa                randconfig-002-20240703   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

