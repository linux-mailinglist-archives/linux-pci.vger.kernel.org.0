Return-Path: <linux-pci+bounces-33834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AF4B21CD7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31BF4673BD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642F6311C34;
	Tue, 12 Aug 2025 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oka7R82l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3B145A05
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754976289; cv=none; b=JloDJvEdw9Gq4iL8OHeg3qzFSKRNZyExOnOJyouAJHGbb0yVTitQYIv9lPzN+mG2+vL+kzR8P4IGMheOQkmyx2zl2SR5ftopLXJ81xRZmnH5TtZ1LBdFXGlD2HX2fGGskCTdgxnwd8+9a/+SQEFpeTCZoGlcN/uJZ3adTQWF9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754976289; c=relaxed/simple;
	bh=Ci+rBnrVUnlt6XLcjC+eInQ0vDlesiNKwnv7/kH5bc4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UxtEutd7026dy/J1urvTwzXWGRbvVZUSYisy9Gphf7p8nNWH2y/gp4+9E/AsjClwDpqM263u8BzzHGhl8f/LG6PaAzky3uNdJWis0kacBFF+kP/0jIvsDBxosTa/UOeu4R4Kax7DsbHO/P5O+bHYlMeODmW1E6Za5AuJwO1SGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oka7R82l; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754976287; x=1786512287;
  h=date:from:to:cc:subject:message-id;
  bh=Ci+rBnrVUnlt6XLcjC+eInQ0vDlesiNKwnv7/kH5bc4=;
  b=Oka7R82lt85K7dq4Wn72wbDjtblqPkr3gdyosprNZw5K8arOm0pm3Ug4
   Rh37QkoioT1Tgd0Ooo89LodTIT8Jim7qg3zOGyAVHuo0AXqN9Nhd+/NQi
   +oHi2tQPLYPh4R/pX2l8tXhGtTi8O4SFrAmS2VrHmlAIJfOCKmI1Qw+ef
   iblIA0HkYI1SzuiNqm1pIXFSwrAsmE5G6QYQxHDTfB7dNwMCqMdWmTSh5
   xq6/3rAUS1zZWUizAXQ8afRytSaQsePkj47OTv2691EQT9lqOOXipP5Mq
   x+bV72risOgTAOUeFvLTg6VrwTmK/9PWYs4T8NrVKH471NSTWdfh48BBP
   g==;
X-CSE-ConnectionGUID: kmbc46HgQeuhiFCZOrK4UQ==
X-CSE-MsgGUID: pwl/0uvBQy6QyA8dN6wo7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="61039822"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="61039822"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 22:24:46 -0700
X-CSE-ConnectionGUID: 1MWEYEKqQ8WM4pXr/ZXEzA==
X-CSE-MsgGUID: Benkg4nkTIize4wXlBlMmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165601880"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 11 Aug 2025 22:24:46 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulhV5-0006R2-12;
	Tue, 12 Aug 2025 05:24:43 +0000
Date: Tue, 12 Aug 2025 13:24:33 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc-endpoint] BUILD SUCCESS
 799639e03fcfd943c7d1cc7330f248c2d017686e
Message-ID: <202508121327.4MdI5wsz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc-endpoint
branch HEAD: 799639e03fcfd943c7d1cc7330f248c2d017686e  misc: pci_endpoint_test: Fix array underflow in pci_endpoint_test_ioctl()

elapsed time: 1077m

configs tested: 242
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250811    gcc-8.5.0
arc                   randconfig-001-20250812    gcc-14.3.0
arc                   randconfig-002-20250811    gcc-10.5.0
arc                   randconfig-002-20250812    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           omap1_defconfig    clang-22
arm                   randconfig-001-20250811    gcc-10.5.0
arm                   randconfig-001-20250812    gcc-14.3.0
arm                   randconfig-002-20250811    gcc-13.4.0
arm                   randconfig-002-20250812    gcc-14.3.0
arm                   randconfig-003-20250811    clang-22
arm                   randconfig-003-20250812    gcc-14.3.0
arm                   randconfig-004-20250811    gcc-10.5.0
arm                   randconfig-004-20250812    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                               defconfig    clang-22
arm64                 randconfig-001-20250811    clang-22
arm64                 randconfig-001-20250812    gcc-14.3.0
arm64                 randconfig-002-20250811    clang-19
arm64                 randconfig-002-20250812    gcc-14.3.0
arm64                 randconfig-003-20250811    clang-20
arm64                 randconfig-003-20250812    gcc-14.3.0
arm64                 randconfig-004-20250811    clang-22
arm64                 randconfig-004-20250812    gcc-14.3.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250811    gcc-15.1.0
csky                  randconfig-001-20250812    gcc-12.5.0
csky                  randconfig-002-20250811    gcc-15.1.0
csky                  randconfig-002-20250812    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250811    clang-17
hexagon               randconfig-001-20250812    gcc-12.5.0
hexagon               randconfig-002-20250811    clang-16
hexagon               randconfig-002-20250812    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250811    clang-20
i386        buildonly-randconfig-001-20250812    gcc-12
i386        buildonly-randconfig-002-20250811    clang-20
i386        buildonly-randconfig-002-20250812    gcc-12
i386        buildonly-randconfig-003-20250811    gcc-12
i386        buildonly-randconfig-003-20250812    gcc-12
i386        buildonly-randconfig-004-20250811    gcc-12
i386        buildonly-randconfig-004-20250812    gcc-12
i386        buildonly-randconfig-005-20250811    gcc-12
i386        buildonly-randconfig-005-20250812    gcc-12
i386        buildonly-randconfig-006-20250811    gcc-12
i386        buildonly-randconfig-006-20250812    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250812    clang-20
i386                  randconfig-002-20250812    clang-20
i386                  randconfig-003-20250812    clang-20
i386                  randconfig-004-20250812    clang-20
i386                  randconfig-005-20250812    clang-20
i386                  randconfig-006-20250812    clang-20
i386                  randconfig-007-20250812    clang-20
i386                  randconfig-011-20250812    gcc-12
i386                  randconfig-012-20250812    gcc-12
i386                  randconfig-013-20250812    gcc-12
i386                  randconfig-014-20250812    gcc-12
i386                  randconfig-015-20250812    gcc-12
i386                  randconfig-016-20250812    gcc-12
i386                  randconfig-017-20250812    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250811    gcc-15.1.0
loongarch             randconfig-001-20250812    gcc-12.5.0
loongarch             randconfig-002-20250811    gcc-12.5.0
loongarch             randconfig-002-20250812    gcc-12.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250811    gcc-10.5.0
nios2                 randconfig-001-20250812    gcc-12.5.0
nios2                 randconfig-002-20250811    gcc-11.5.0
nios2                 randconfig-002-20250812    gcc-12.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250811    gcc-9.5.0
parisc                randconfig-001-20250812    gcc-12.5.0
parisc                randconfig-002-20250811    gcc-14.3.0
parisc                randconfig-002-20250812    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      katmai_defconfig    clang-22
powerpc               randconfig-001-20250811    gcc-13.4.0
powerpc               randconfig-001-20250812    gcc-12.5.0
powerpc               randconfig-002-20250811    clang-22
powerpc               randconfig-002-20250812    gcc-12.5.0
powerpc               randconfig-003-20250811    gcc-13.4.0
powerpc               randconfig-003-20250812    gcc-12.5.0
powerpc64             randconfig-001-20250811    clang-22
powerpc64             randconfig-001-20250812    gcc-12.5.0
powerpc64             randconfig-002-20250811    clang-22
powerpc64             randconfig-002-20250812    gcc-12.5.0
powerpc64             randconfig-003-20250811    gcc-14.3.0
powerpc64             randconfig-003-20250812    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250811    gcc-8.5.0
riscv                 randconfig-001-20250812    clang-18
riscv                 randconfig-002-20250811    clang-22
riscv                 randconfig-002-20250812    clang-18
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250811    gcc-8.5.0
s390                  randconfig-001-20250812    clang-18
s390                  randconfig-002-20250811    clang-17
s390                  randconfig-002-20250812    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20250811    gcc-15.1.0
sh                    randconfig-001-20250812    clang-18
sh                    randconfig-002-20250811    gcc-15.1.0
sh                    randconfig-002-20250812    clang-18
sh                             sh03_defconfig    clang-22
sh                     sh7710voipgw_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250811    gcc-8.5.0
sparc                 randconfig-001-20250812    clang-18
sparc                 randconfig-002-20250811    gcc-8.5.0
sparc                 randconfig-002-20250812    clang-18
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250811    clang-22
sparc64               randconfig-001-20250812    clang-18
sparc64               randconfig-002-20250811    gcc-14.3.0
sparc64               randconfig-002-20250812    clang-18
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250811    clang-18
um                    randconfig-001-20250812    clang-18
um                    randconfig-002-20250811    clang-22
um                    randconfig-002-20250812    clang-18
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250811    gcc-12
x86_64      buildonly-randconfig-001-20250812    gcc-12
x86_64      buildonly-randconfig-002-20250811    clang-20
x86_64      buildonly-randconfig-002-20250812    gcc-12
x86_64      buildonly-randconfig-003-20250811    clang-20
x86_64      buildonly-randconfig-003-20250812    gcc-12
x86_64      buildonly-randconfig-004-20250811    clang-20
x86_64      buildonly-randconfig-004-20250812    gcc-12
x86_64      buildonly-randconfig-005-20250811    clang-20
x86_64      buildonly-randconfig-005-20250812    gcc-12
x86_64      buildonly-randconfig-006-20250811    clang-20
x86_64      buildonly-randconfig-006-20250812    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250812    gcc-11
x86_64                randconfig-002-20250812    gcc-11
x86_64                randconfig-003-20250812    gcc-11
x86_64                randconfig-004-20250812    gcc-11
x86_64                randconfig-005-20250812    gcc-11
x86_64                randconfig-006-20250812    gcc-11
x86_64                randconfig-007-20250812    gcc-11
x86_64                randconfig-008-20250812    gcc-11
x86_64                randconfig-071-20250812    clang-20
x86_64                randconfig-072-20250812    clang-20
x86_64                randconfig-073-20250812    clang-20
x86_64                randconfig-074-20250812    clang-20
x86_64                randconfig-075-20250812    clang-20
x86_64                randconfig-076-20250812    clang-20
x86_64                randconfig-077-20250812    clang-20
x86_64                randconfig-078-20250812    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250811    gcc-9.5.0
xtensa                randconfig-001-20250812    clang-18
xtensa                randconfig-002-20250811    gcc-9.5.0
xtensa                randconfig-002-20250812    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

