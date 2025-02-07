Return-Path: <linux-pci+bounces-20916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC258A2C9C9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C87188FDCA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF820194C9E;
	Fri,  7 Feb 2025 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCFDYtxn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CC18F2C3
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947998; cv=none; b=GjbnTWY2/b9CHy96/hSBvPIloaFJ0G3Tmm+IMhjtX/pWQb9R9Aq6dq6dvRFm9wbWrkpJKOUCmhe6d97KQfIhXkn2loAW10E5n3l4RS+DY/OlvJdLWDZIcQB7YyvR4sARVQVRbWgf+MKKUtP2BiUGEOuBh8iGss/mN9BSUBiqX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947998; c=relaxed/simple;
	bh=DANT/5hXWue2N5M2F0nBUFQ3JCGuB0XwHaDpGfg3hNU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FzIEP1sbFRRO1oTkDc8HPDkrI543wy9+N1qWNaoTxj6MmdzJQBApzUvhDEUx0gLzPdMDcJrm9fEI1w/tJhqDL5Wvcl4LqWLoTvILUMayCN4YN28FF9IATocJNB9n8PGtD9ri6Fy0S/ZsRMvX+cZRjigoHh+9bSLqEaU24giaaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCFDYtxn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738947997; x=1770483997;
  h=date:from:to:cc:subject:message-id;
  bh=DANT/5hXWue2N5M2F0nBUFQ3JCGuB0XwHaDpGfg3hNU=;
  b=UCFDYtxn8Nf26cL8A3xLbFifwV2UHdDziKEw9wlvsqa1xiq8H/8ZPTSI
   +yFlw3Br/1HgT9Z+FsoIHkXmSihpuiamBfRT5jvYXwlE0HVAXnHBK+VxR
   p86ZzEyhaPQKt6R+BfUEmpl/2tt5u7Tw5mblVf8QBajcaocDgJ8voNr2R
   MKcymvAMhFDQCXL3PldwgZ6qlnfECPXq1eUXqPWlrBBM8wY44Dguzm4j0
   ZEC16kr2jfOf/cTO3urlRrXyWnSP6qeYMRFC6AeCuOkZLYHQ4Dx5eBApk
   26gYZsU7Jg7up9+tQ5lEmBBw4OPEvK4djeB8jWwFiUm7ywBRWe1iOcqnX
   g==;
X-CSE-ConnectionGUID: D4S2peKXR7OcJ6cA2MiWxg==
X-CSE-MsgGUID: gNxc4TFpTzKTjyNAljeisw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="64953194"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="64953194"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 09:06:36 -0800
X-CSE-ConnectionGUID: rE9x1+Y6QcOwF0OiYjbDZA==
X-CSE-MsgGUID: gS9mYkyVTn6yw076xsxP0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111406310"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Feb 2025 09:06:35 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgRoG-000yev-34;
	Fri, 07 Feb 2025 17:06:32 +0000
Date: Sat, 08 Feb 2025 01:05:47 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 6f64b83d9fe9729000a0616830cb1606945465d8
Message-ID: <202502080137.V1hIfj8C-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 6f64b83d9fe9729000a0616830cb1606945465d8  PCI/TPH: Restore TPH Requester Enable correctly

elapsed time: 1456m

configs tested: 193
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    clang-19
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    clang-19
arc                   randconfig-001-20250207    gcc-13.2.0
arc                   randconfig-002-20250207    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250207    gcc-13.2.0
arm                   randconfig-001-20250207    gcc-14.2.0
arm                   randconfig-002-20250207    gcc-13.2.0
arm                   randconfig-002-20250207    gcc-14.2.0
arm                   randconfig-003-20250207    gcc-13.2.0
arm                   randconfig-003-20250207    gcc-14.2.0
arm                   randconfig-004-20250207    clang-21
arm                   randconfig-004-20250207    gcc-13.2.0
arm                         s3c6400_defconfig    clang-19
arm                         wpcm450_defconfig    clang-19
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250207    gcc-13.2.0
arm64                 randconfig-001-20250207    gcc-14.2.0
arm64                 randconfig-002-20250207    gcc-13.2.0
arm64                 randconfig-002-20250207    gcc-14.2.0
arm64                 randconfig-003-20250207    clang-16
arm64                 randconfig-003-20250207    gcc-13.2.0
arm64                 randconfig-004-20250207    clang-21
arm64                 randconfig-004-20250207    gcc-13.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250207    gcc-14.2.0
csky                  randconfig-002-20250207    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250207    clang-21
hexagon               randconfig-001-20250207    gcc-14.2.0
hexagon               randconfig-002-20250207    clang-17
hexagon               randconfig-002-20250207    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250207    gcc-12
i386        buildonly-randconfig-002-20250207    gcc-12
i386        buildonly-randconfig-003-20250207    gcc-12
i386        buildonly-randconfig-004-20250207    gcc-12
i386        buildonly-randconfig-005-20250207    clang-19
i386        buildonly-randconfig-005-20250207    gcc-12
i386        buildonly-randconfig-006-20250207    clang-19
i386        buildonly-randconfig-006-20250207    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250207    gcc-12
i386                  randconfig-002-20250207    gcc-12
i386                  randconfig-003-20250207    gcc-12
i386                  randconfig-004-20250207    gcc-12
i386                  randconfig-005-20250207    gcc-12
i386                  randconfig-006-20250207    gcc-12
i386                  randconfig-007-20250207    gcc-12
i386                  randconfig-011-20250207    gcc-12
i386                  randconfig-012-20250207    gcc-12
i386                  randconfig-013-20250207    gcc-12
i386                  randconfig-014-20250207    gcc-12
i386                  randconfig-015-20250207    gcc-12
i386                  randconfig-016-20250207    gcc-12
i386                  randconfig-017-20250207    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250207    gcc-14.2.0
loongarch             randconfig-002-20250207    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-19
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250207    gcc-14.2.0
nios2                 randconfig-002-20250207    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-21
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250207    gcc-14.2.0
parisc                randconfig-002-20250207    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                 canyonlands_defconfig    clang-19
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250207    clang-21
powerpc               randconfig-001-20250207    gcc-14.2.0
powerpc               randconfig-002-20250207    clang-21
powerpc               randconfig-002-20250207    gcc-14.2.0
powerpc               randconfig-003-20250207    gcc-14.2.0
powerpc                     tqm5200_defconfig    clang-19
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250207    gcc-14.2.0
powerpc64             randconfig-002-20250207    clang-21
powerpc64             randconfig-002-20250207    gcc-14.2.0
powerpc64             randconfig-003-20250207    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250207    gcc-14.2.0
riscv                 randconfig-002-20250207    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250207    gcc-14.2.0
s390                  randconfig-002-20250207    clang-21
s390                  randconfig-002-20250207    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250207    gcc-14.2.0
sh                    randconfig-002-20250207    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250207    gcc-14.2.0
sparc                 randconfig-002-20250207    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250207    gcc-14.2.0
sparc64               randconfig-002-20250207    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250207    clang-21
um                    randconfig-001-20250207    gcc-14.2.0
um                    randconfig-002-20250207    gcc-12
um                    randconfig-002-20250207    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250207    clang-19
x86_64      buildonly-randconfig-001-20250207    gcc-12
x86_64      buildonly-randconfig-002-20250207    clang-19
x86_64      buildonly-randconfig-003-20250207    clang-19
x86_64      buildonly-randconfig-004-20250207    clang-19
x86_64      buildonly-randconfig-005-20250207    clang-19
x86_64      buildonly-randconfig-006-20250207    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250207    clang-19
x86_64                randconfig-002-20250207    clang-19
x86_64                randconfig-003-20250207    clang-19
x86_64                randconfig-004-20250207    clang-19
x86_64                randconfig-005-20250207    clang-19
x86_64                randconfig-006-20250207    clang-19
x86_64                randconfig-007-20250207    clang-19
x86_64                randconfig-008-20250207    clang-19
x86_64                randconfig-071-20250207    gcc-12
x86_64                randconfig-072-20250207    gcc-12
x86_64                randconfig-073-20250207    gcc-12
x86_64                randconfig-074-20250207    gcc-12
x86_64                randconfig-075-20250207    gcc-12
x86_64                randconfig-076-20250207    gcc-12
x86_64                randconfig-077-20250207    gcc-12
x86_64                randconfig-078-20250207    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250207    gcc-14.2.0
xtensa                randconfig-002-20250207    gcc-14.2.0
xtensa                         virt_defconfig    clang-19

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

