Return-Path: <linux-pci+bounces-32537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6862B0A6F2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32249189AF31
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1181D6AA;
	Fri, 18 Jul 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKrOZ215"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D42171CD
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851785; cv=none; b=VP/9Dcpsxb5DT4AZfcJb5X/AWWVxJaDuS00lub8aXCNXAY49oFsg/dyY1/9NRKsEE8wdzfiJGGkrwXH0PkedSEgAeVPxehY6wPeZ1nz/itIw/mamf/FFb7Rktq5efh2DOAS2Ki04azcTFLX6QovwDnfOHHpiMm4Y1ldXHPEVPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851785; c=relaxed/simple;
	bh=7LqiHZcmOQoEMdWcZOZitCkRULCOIHXmEra8dVk2PGw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pYZ+sdwhO1vgVuehZNvHMFcr9arDPViv0sWQY53d7hiH+QCfLMRZxpo44Sa2ym5mGeOXsJxmEvrnS96n5rMaOR9x9Ll5ZuhRfa/Y56q0qv1AXlTIQQ0Ve8D8/FKQTU1pifKvOnzCdZeul3Zu80p7CfPSYmOoYuqnOxxAx0t5Tvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKrOZ215; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752851784; x=1784387784;
  h=date:from:to:cc:subject:message-id;
  bh=7LqiHZcmOQoEMdWcZOZitCkRULCOIHXmEra8dVk2PGw=;
  b=FKrOZ2150AEi8f2mtdKv8rLPiO823iPHNJkQxjBnUQUYn+vXtm+tFNhf
   9q4K2SXw7i49gkirlDg1oVOlFeHU6lFMANX3jEHpA2cIA26i96JSg5i5n
   brSsE3jiumRSlUHO5r07rhTVhiFzFpR8k3Us8p4eOuB3JD5Mg/OUXtt05
   0q+N1lqCODJqrjm6QKr1KCGWYLfhYRHBf1QolXNsbXNU/2/Zi7G23/2eC
   WY/QPbcerytLuFNUJRWD+r15t6pHpg0GlI6yR8k+GmUEK5kk6u5G42qXq
   mnzPvd8VtzeGz8zdp3aot7Y9XvgYeUDoIoDlPS6m1WmG8pyQAk5A6tv57
   Q==;
X-CSE-ConnectionGUID: /Ul3dHm7Rr638+9GsEWDXw==
X-CSE-MsgGUID: GIv4iOUoTVu00T1Fi9Zxug==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55301587"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="55301587"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 08:16:23 -0700
X-CSE-ConnectionGUID: BW0c2O8xRPuX0XOGf0XDxA==
X-CSE-MsgGUID: A1ZUeLBsTcCJnj3HQEylBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="162396483"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Jul 2025 08:16:22 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucmou-000EmT-0H;
	Fri, 18 Jul 2025 15:16:20 +0000
Date: Fri, 18 Jul 2025 23:16:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dev_fwnode] BUILD SUCCESS
 632297708045220b6e289e943f42e08708659d51
Message-ID: <202507182303.aFTpzihV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dev_fwnode
branch HEAD: 632297708045220b6e289e943f42e08708659d51  PCI: altera: Use dev_fwnode() for irq_domain_create_linear()

elapsed time: 1122m

configs tested: 208
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250718    gcc-10.5.0
arc                   randconfig-002-20250718    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250718    gcc-8.5.0
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-003-20250718    gcc-8.5.0
arm                   randconfig-004-20250718    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250718    gcc-13.4.0
arm64                 randconfig-002-20250718    gcc-8.5.0
arm64                 randconfig-003-20250718    clang-21
arm64                 randconfig-004-20250718    gcc-8.5.0
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-002-20250718    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250718    clang-21
hexagon               randconfig-001-20250718    gcc-15.1.0
hexagon               randconfig-002-20250718    clang-21
hexagon               randconfig-002-20250718    gcc-15.1.0
i386                             alldefconfig    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-002-20250718    clang-20
i386        buildonly-randconfig-002-20250718    gcc-12
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-004-20250718    gcc-11
i386        buildonly-randconfig-004-20250718    gcc-12
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-006-20250718    clang-20
i386        buildonly-randconfig-006-20250718    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250718    gcc-12
i386                  randconfig-002-20250718    gcc-12
i386                  randconfig-003-20250718    gcc-12
i386                  randconfig-004-20250718    gcc-12
i386                  randconfig-005-20250718    gcc-12
i386                  randconfig-006-20250718    gcc-12
i386                  randconfig-007-20250718    gcc-12
i386                  randconfig-011-20250718    clang-20
i386                  randconfig-012-20250718    clang-20
i386                  randconfig-013-20250718    clang-20
i386                  randconfig-014-20250718    clang-20
i386                  randconfig-015-20250718    clang-20
i386                  randconfig-016-20250718    clang-20
i386                  randconfig-017-20250718    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-002-20250718    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250718    gcc-15.1.0
nios2                 randconfig-001-20250718    gcc-8.5.0
nios2                 randconfig-002-20250718    gcc-11.5.0
nios2                 randconfig-002-20250718    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250718    gcc-14.3.0
parisc                randconfig-001-20250718    gcc-15.1.0
parisc                randconfig-002-20250718    gcc-13.4.0
parisc                randconfig-002-20250718    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-21
powerpc               randconfig-001-20250718    gcc-15.1.0
powerpc               randconfig-001-20250718    gcc-9.3.0
powerpc               randconfig-002-20250718    gcc-11.5.0
powerpc               randconfig-002-20250718    gcc-15.1.0
powerpc               randconfig-003-20250718    clang-17
powerpc               randconfig-003-20250718    gcc-15.1.0
powerpc64             randconfig-001-20250718    clang-18
powerpc64             randconfig-001-20250718    gcc-15.1.0
powerpc64             randconfig-002-20250718    clang-21
powerpc64             randconfig-002-20250718    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250718    clang-21
riscv                 randconfig-001-20250718    gcc-15.1.0
riscv                 randconfig-002-20250718    clang-16
riscv                 randconfig-002-20250718    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250718    clang-21
s390                  randconfig-001-20250718    gcc-15.1.0
s390                  randconfig-002-20250718    clang-21
s390                  randconfig-002-20250718    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    clang-21
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250718    gcc-15.1.0
sh                    randconfig-002-20250718    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250718    gcc-10.3.0
sparc                 randconfig-001-20250718    gcc-15.1.0
sparc                 randconfig-002-20250718    gcc-11.5.0
sparc                 randconfig-002-20250718    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250718    gcc-10.5.0
sparc64               randconfig-001-20250718    gcc-15.1.0
sparc64               randconfig-002-20250718    clang-20
sparc64               randconfig-002-20250718    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250718    gcc-12
um                    randconfig-001-20250718    gcc-15.1.0
um                    randconfig-002-20250718    gcc-12
um                    randconfig-002-20250718    gcc-15.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    gcc-12
x86_64      buildonly-randconfig-003-20250718    clang-20
x86_64      buildonly-randconfig-003-20250718    gcc-12
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250718    clang-20
x86_64                randconfig-002-20250718    clang-20
x86_64                randconfig-003-20250718    clang-20
x86_64                randconfig-004-20250718    clang-20
x86_64                randconfig-005-20250718    clang-20
x86_64                randconfig-006-20250718    clang-20
x86_64                randconfig-007-20250718    clang-20
x86_64                randconfig-008-20250718    clang-20
x86_64                randconfig-071-20250718    clang-20
x86_64                randconfig-072-20250718    clang-20
x86_64                randconfig-073-20250718    clang-20
x86_64                randconfig-074-20250718    clang-20
x86_64                randconfig-075-20250718    clang-20
x86_64                randconfig-076-20250718    clang-20
x86_64                randconfig-077-20250718    clang-20
x86_64                randconfig-078-20250718    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-8.5.0
xtensa                randconfig-002-20250718    gcc-12.4.0
xtensa                randconfig-002-20250718    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

