Return-Path: <linux-pci+bounces-35138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B1B3C1A3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 19:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48784583B2B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4888334707;
	Fri, 29 Aug 2025 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jD2TGxjE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94C221D9E
	for <linux-pci@vger.kernel.org>; Fri, 29 Aug 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487933; cv=none; b=Qe3oIVBbmQm5JtdIJuF4+EIMNVxh7bdhOABV0xb9zPuxCAjBCa9odd/280At7uNrTGECF9sA6vn+ePGXHnbiW8QBqM7xs+p2OSEc71XYnbJm+lDPNdAgvI08NCjzb5UnScJaHAoTJM6TMF43ShzyA7wXcAud+sm/66hdgnQtUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487933; c=relaxed/simple;
	bh=6uD8Jy3DvuqUpe2a3d5K5Jbld5qt89b+IdtvPHcFttM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f4TlFkWPoHDzLNPVqJ+85JXPHDjD1brOZ45lFr8qmS6jvWag1BE/6NJyrF0JtqsgSzK1ATuT675/xj4QfkZ6I6W+b27F5d9WVn6UoSD0wM15W2bCGez4Z6YKnjk2GrnaG6GeIgaGDUeiudLPeKvX/yLX0YrkCmDO33LAgBJypR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jD2TGxjE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756487932; x=1788023932;
  h=date:from:to:cc:subject:message-id;
  bh=6uD8Jy3DvuqUpe2a3d5K5Jbld5qt89b+IdtvPHcFttM=;
  b=jD2TGxjE4AzHwxKJlTB3yj0QPCXluDy7XD1rIzKQr07Lv9NKZecqvRih
   ZqEXRYQmq5sq6L0b167FIhEhw69KaOzoYQTcm6aYn6LjxWr4y5H/lP0i+
   Lf6R4rhj/YxxdP5m2AyKScx05/RPKRjjR585/n3vwAocfTkLbXHVIF3Je
   ILhCVTZy7dAO+zJ/iOY3ZR1oC0WHWZcBt1qlIZGgPLQDExmmYO72M2XyG
   T+MFSm/5J90Ia2h1rFuss6cr02SWDqYrxIatiiBWkgbtpPcIY7+ldBXKl
   L+o+A/OvO8Tlrn7mJbFkGXaPqDWbjFdvuCyRwdppiMjXejJBzZPyjcjJC
   Q==;
X-CSE-ConnectionGUID: sKGPr5hxTpWVXOxJADHB0A==
X-CSE-MsgGUID: YymM8EvrR9m8/u5HPZCJGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="70212652"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="70212652"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:18:52 -0700
X-CSE-ConnectionGUID: nI//hgDLRpazDou6nK+0jw==
X-CSE-MsgGUID: uUvXxHmrT6iudxhN5fscXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170818078"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 29 Aug 2025 10:18:49 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us2kB-000Unr-32;
	Fri, 29 Aug 2025 17:18:37 +0000
Date: Sat, 30 Aug 2025 01:18:11 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-binding] BUILD SUCCESS
 57a48a2619c5f99d48748f9c34db510efe5ee7c9
Message-ID: <202508300101.QMvNAvUd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-binding
branch HEAD: 57a48a2619c5f99d48748f9c34db510efe5ee7c9  dt-bindings: PCI: ti,am65: Extend for use with PVU

elapsed time: 1457m

configs tested: 212
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250829    gcc-12.5.0
arc                   randconfig-001-20250829    gcc-8.5.0
arc                   randconfig-002-20250829    gcc-10.5.0
arc                   randconfig-002-20250829    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    clang-18
arm                                 defconfig    clang-19
arm                          exynos_defconfig    gcc-15.1.0
arm                       imx_v4_v5_defconfig    clang-18
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                         lpc18xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250829    gcc-10.5.0
arm                   randconfig-001-20250829    gcc-12.5.0
arm                   randconfig-002-20250829    clang-22
arm                   randconfig-002-20250829    gcc-12.5.0
arm                   randconfig-003-20250829    clang-22
arm                   randconfig-003-20250829    gcc-12.5.0
arm                   randconfig-004-20250829    clang-22
arm                   randconfig-004-20250829    gcc-12.5.0
arm                        spear6xx_defconfig    clang-18
arm                         vf610m4_defconfig    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250829    clang-22
arm64                 randconfig-001-20250829    gcc-12.5.0
arm64                 randconfig-002-20250829    gcc-12.5.0
arm64                 randconfig-003-20250829    clang-22
arm64                 randconfig-003-20250829    gcc-12.5.0
arm64                 randconfig-004-20250829    gcc-12.5.0
arm64                 randconfig-004-20250829    gcc-9.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250829    clang-22
csky                  randconfig-001-20250829    gcc-9.5.0
csky                  randconfig-002-20250829    clang-22
csky                  randconfig-002-20250829    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250829    clang-22
hexagon               randconfig-002-20250829    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250829    clang-20
i386        buildonly-randconfig-001-20250829    gcc-12
i386        buildonly-randconfig-002-20250829    clang-20
i386        buildonly-randconfig-003-20250829    clang-20
i386        buildonly-randconfig-004-20250829    clang-20
i386        buildonly-randconfig-005-20250829    clang-20
i386        buildonly-randconfig-005-20250829    gcc-12
i386        buildonly-randconfig-006-20250829    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250829    clang-20
i386                  randconfig-002-20250829    clang-20
i386                  randconfig-003-20250829    clang-20
i386                  randconfig-004-20250829    clang-20
i386                  randconfig-005-20250829    clang-20
i386                  randconfig-006-20250829    clang-20
i386                  randconfig-007-20250829    clang-20
i386                  randconfig-011-20250829    clang-20
i386                  randconfig-012-20250829    clang-20
i386                  randconfig-013-20250829    clang-20
i386                  randconfig-014-20250829    clang-20
i386                  randconfig-015-20250829    clang-20
i386                  randconfig-016-20250829    clang-20
i386                  randconfig-017-20250829    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250829    clang-22
loongarch             randconfig-002-20250829    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
nios2                         3c120_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250829    clang-22
nios2                 randconfig-001-20250829    gcc-11.5.0
nios2                 randconfig-002-20250829    clang-22
nios2                 randconfig-002-20250829    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250829    clang-22
parisc                randconfig-001-20250829    gcc-14.3.0
parisc                randconfig-002-20250829    clang-22
parisc                randconfig-002-20250829    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250829    clang-22
powerpc               randconfig-001-20250829    gcc-13.4.0
powerpc               randconfig-002-20250829    clang-22
powerpc               randconfig-003-20250829    clang-22
powerpc               randconfig-003-20250829    gcc-12.5.0
powerpc64             randconfig-001-20250829    clang-22
powerpc64             randconfig-002-20250829    clang-22
powerpc64             randconfig-003-20250829    clang-22
powerpc64             randconfig-003-20250829    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                           se7721_defconfig    clang-18
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250829    clang-20
x86_64      buildonly-randconfig-001-20250829    gcc-11
x86_64      buildonly-randconfig-002-20250829    clang-20
x86_64      buildonly-randconfig-002-20250829    gcc-11
x86_64      buildonly-randconfig-003-20250829    clang-20
x86_64      buildonly-randconfig-003-20250829    gcc-12
x86_64      buildonly-randconfig-004-20250829    clang-20
x86_64      buildonly-randconfig-005-20250829    clang-20
x86_64      buildonly-randconfig-006-20250829    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250829    gcc-12
x86_64                randconfig-002-20250829    gcc-12
x86_64                randconfig-003-20250829    gcc-12
x86_64                randconfig-004-20250829    gcc-12
x86_64                randconfig-005-20250829    gcc-12
x86_64                randconfig-006-20250829    gcc-12
x86_64                randconfig-007-20250829    gcc-12
x86_64                randconfig-008-20250829    gcc-12
x86_64                randconfig-071-20250829    clang-20
x86_64                randconfig-072-20250829    clang-20
x86_64                randconfig-073-20250829    clang-20
x86_64                randconfig-074-20250829    clang-20
x86_64                randconfig-075-20250829    clang-20
x86_64                randconfig-076-20250829    clang-20
x86_64                randconfig-077-20250829    clang-20
x86_64                randconfig-078-20250829    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

