Return-Path: <linux-pci+bounces-13726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10A998E3E3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 22:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A045028399D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 20:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA4216A02;
	Wed,  2 Oct 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuG/CjHe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D58216A17
	for <linux-pci@vger.kernel.org>; Wed,  2 Oct 2024 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899418; cv=none; b=qbjylx5Alg+edm/t31boXICiQ/GQsWOq+BTNuQ05yCk9blys9d+TY+2X8vwXjUQGeU4XAfuWU32WZnlE2Y+7Bq+tg3v5zP7+s8PU4Ibl2HzNYT/4ya9fDF3X5M+Rx3a4+rE0w+Q9Ej2WdMIsuenaqFERFziIi/os7pJtwy5aThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899418; c=relaxed/simple;
	bh=NstOhBFjj5vtTGmazlhWekuoeN746DUGMNikZFxw7RM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kxWIdAezmg/RI2rmxwsx2wNm7QBt+NKP9i+kRe2dPt9/hkoV1GhtNaa96f+OAI3cTMiUUCJUPOJcsat0T5qLes2Dgx6FHY2fCPBBCaC2eUuK88BF8ECK64/aWq0wgoq7lAwSXTGPNwZHEFa+jqh1GpNmTDJZdc+bqFX/jB9T8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuG/CjHe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727899417; x=1759435417;
  h=date:from:to:cc:subject:message-id;
  bh=NstOhBFjj5vtTGmazlhWekuoeN746DUGMNikZFxw7RM=;
  b=PuG/CjHeFwUttDtEizSK8ioWsOaTAG2uEDeIUa8srTx60Cj8HepxL1zl
   Mp8W1sfETWHDDSiF7EFhDkiAx5hK881TmgreaAq6NvVDyYoUN1T8vKH3V
   8bnnDZElp1tLqFk5EpCWes+wCnGclKOOq2tucclE3CX8jfcnHv50oKzrr
   0f9YyW334+JYVY/HYuBJBcYkSuWdNgfRbb7PGsKF+swXnMfXmm4dxgWG7
   ClgntWg8w4mlixQfvE21idlyeoC4ARUX2zOoiqW/U25aKOacewe2iWs0K
   slGqzN5Yjg4n+DZu3EmGtBxwFpGOBDJsKsFtX2Z8/H6ZAYai93KhZ+lI0
   w==;
X-CSE-ConnectionGUID: 4RfDa32JTP2OrYWZuZtU9g==
X-CSE-MsgGUID: nNrCH6fUTBS8GeUfOVqVnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26585263"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="26585263"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 13:03:36 -0700
X-CSE-ConnectionGUID: Tm1bvxVMSuCRAhJvZMjOig==
X-CSE-MsgGUID: 8LN45/tsRJSvaPraYQ9VQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73787298"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Oct 2024 13:03:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sw5ZM-000UW6-2s;
	Wed, 02 Oct 2024 20:03:32 +0000
Date: Thu, 03 Oct 2024 04:03:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 26a255a8c4701e47f2c080f1bc8aa50e4af6058a
Message-ID: <202410030404.tkATg8XN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 26a255a8c4701e47f2c080f1bc8aa50e4af6058a  Merge branch 'pci/misc'

elapsed time: 1273m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241002    gcc-14.1.0
arc                   randconfig-002-20241002    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                            mmp2_defconfig    gcc-14.1.0
arm                   randconfig-001-20241002    gcc-14.1.0
arm                   randconfig-002-20241002    gcc-14.1.0
arm                   randconfig-003-20241002    gcc-14.1.0
arm                   randconfig-004-20241002    gcc-14.1.0
arm                           stm32_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241002    gcc-14.1.0
arm64                 randconfig-002-20241002    gcc-14.1.0
arm64                 randconfig-003-20241002    gcc-14.1.0
arm64                 randconfig-004-20241002    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241002    gcc-14.1.0
csky                  randconfig-002-20241002    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241002    gcc-14.1.0
hexagon               randconfig-002-20241002    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241002    clang-18
i386        buildonly-randconfig-002-20241002    clang-18
i386        buildonly-randconfig-003-20241002    clang-18
i386        buildonly-randconfig-003-20241002    gcc-12
i386        buildonly-randconfig-004-20241002    clang-18
i386        buildonly-randconfig-004-20241002    gcc-12
i386        buildonly-randconfig-005-20241002    clang-18
i386        buildonly-randconfig-005-20241002    gcc-12
i386        buildonly-randconfig-006-20241002    clang-18
i386        buildonly-randconfig-006-20241002    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241002    clang-18
i386                  randconfig-001-20241002    gcc-12
i386                  randconfig-002-20241002    clang-18
i386                  randconfig-002-20241002    gcc-12
i386                  randconfig-003-20241002    clang-18
i386                  randconfig-004-20241002    clang-18
i386                  randconfig-005-20241002    clang-18
i386                  randconfig-006-20241002    clang-18
i386                  randconfig-006-20241002    gcc-12
i386                  randconfig-011-20241002    clang-18
i386                  randconfig-012-20241002    clang-18
i386                  randconfig-013-20241002    clang-18
i386                  randconfig-013-20241002    gcc-12
i386                  randconfig-014-20241002    clang-18
i386                  randconfig-015-20241002    clang-18
i386                  randconfig-016-20241002    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241002    gcc-14.1.0
loongarch             randconfig-002-20241002    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5272c3_defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           jazz_defconfig    gcc-14.1.0
mips                          rm200_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241002    gcc-14.1.0
nios2                 randconfig-002-20241002    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-14.1.0
parisc                randconfig-001-20241002    gcc-14.1.0
parisc                randconfig-002-20241002    gcc-14.1.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc               randconfig-001-20241002    gcc-14.1.0
powerpc               randconfig-002-20241002    gcc-14.1.0
powerpc               randconfig-003-20241002    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc                        warp_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241002    gcc-14.1.0
powerpc64             randconfig-002-20241002    gcc-14.1.0
powerpc64             randconfig-003-20241002    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241002    gcc-14.1.0
riscv                 randconfig-002-20241002    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241002    gcc-14.1.0
s390                  randconfig-002-20241002    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    gcc-14.1.0
sh                          r7780mp_defconfig    gcc-14.1.0
sh                          r7785rp_defconfig    gcc-14.1.0
sh                    randconfig-001-20241002    gcc-14.1.0
sh                    randconfig-002-20241002    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241002    gcc-14.1.0
sparc64               randconfig-002-20241002    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241002    gcc-14.1.0
um                    randconfig-002-20241002    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241002    gcc-12
x86_64      buildonly-randconfig-002-20241002    gcc-12
x86_64      buildonly-randconfig-003-20241002    gcc-12
x86_64      buildonly-randconfig-004-20241002    gcc-12
x86_64      buildonly-randconfig-005-20241002    gcc-12
x86_64      buildonly-randconfig-006-20241002    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241002    gcc-12
x86_64                randconfig-002-20241002    gcc-12
x86_64                randconfig-003-20241002    gcc-12
x86_64                randconfig-004-20241002    gcc-12
x86_64                randconfig-005-20241002    gcc-12
x86_64                randconfig-006-20241002    gcc-12
x86_64                randconfig-011-20241002    gcc-12
x86_64                randconfig-012-20241002    gcc-12
x86_64                randconfig-013-20241002    gcc-12
x86_64                randconfig-014-20241002    gcc-12
x86_64                randconfig-015-20241002    gcc-12
x86_64                randconfig-016-20241002    gcc-12
x86_64                randconfig-071-20241002    gcc-12
x86_64                randconfig-072-20241002    gcc-12
x86_64                randconfig-073-20241002    gcc-12
x86_64                randconfig-074-20241002    gcc-12
x86_64                randconfig-075-20241002    gcc-12
x86_64                randconfig-076-20241002    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241002    gcc-14.1.0
xtensa                randconfig-002-20241002    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

