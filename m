Return-Path: <linux-pci+bounces-23839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C15A62F5B
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 16:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B751770DA
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85521D8A12;
	Sat, 15 Mar 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtohCnfn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B54A29
	for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053426; cv=none; b=l1K8qFGOExFrT81iBtJNSpJ+n2noBNftIUQmkRFgrjVewqnd096XjAuRPAW5oBwvP6nbs2P9k4EZsQ4uZMikQIFRT8TQw83uTqwnuAmN7B3PlLKClTl/r0zur6AjdR9zuOD1rR4XAzYBPykp943V1hdWa3yMDPCiWzUDTOf8EXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053426; c=relaxed/simple;
	bh=XF/V7iXER81SPk/6cw20VPRS6Hww/nvTtNkFLwYXg68=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nUPbgIS6IM5kVc3amNYlcXne/CYkfUOasmhVRVJV2RXLhnRce5W8rHhIEQQqeBlM/+BEFYXfuxwveUf5qwV9mpoRpQ8mxmeZaIaUeIxN+AC7m2+Izk/XmOlMTPxD0IeDDbCE0QA89Pn4EpjtqkE7FX3wOlTlvkHc7zrWPxpcDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtohCnfn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742053424; x=1773589424;
  h=date:from:to:cc:subject:message-id;
  bh=XF/V7iXER81SPk/6cw20VPRS6Hww/nvTtNkFLwYXg68=;
  b=VtohCnfnBcrTcgtsImRh3iadXCs2nxOz6fy7iQNK4rcePqHVjvqz9M1A
   dAOaD00c4GZRZ+8SfIBgSBqcNhK5ceu+LI0Hu2bAjvCXfp4G0mma0plQo
   bg/HaPwDIhnbh3/ScaW00bfWU/6S6Jfh5bl6Ck3Jn84Zdh7reNluOk7Nl
   IAfEQOgLysZOkdS0dsd4jIm0qkzW3PV9L/tsavjJEN3DsiIX0sf0bg8Bd
   KHn1skNxX5Jgggx4R1WvXC2pAcxBeMKyLdwobphIGQL1sUaNSYCfRwSSi
   lgDXmOgfbFRLIzZa1Erd5zqg0jWpfh+2eBH+lOxbv5QPuuXlNiDurafxe
   w==;
X-CSE-ConnectionGUID: men4d/EKQFierqM9ho5EjA==
X-CSE-MsgGUID: QZrmcfFnSvmSoAmbUWWzqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="42927195"
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="42927195"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 08:43:43 -0700
X-CSE-ConnectionGUID: ez2AxtU4SXqj7v3W+DpMUw==
X-CSE-MsgGUID: NaBnCfzDSxyFnVTep5aCzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,250,1736841600"; 
   d="scan'208";a="121488980"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 15 Mar 2025 08:43:42 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttTfo-000BQH-0b;
	Sat, 15 Mar 2025 15:43:40 +0000
Date: Sat, 15 Mar 2025 23:43:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 e3260237aaadc9799107ccb940c6688195c4518d
Message-ID: <202503152301.28urqFOM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: e3260237aaadc9799107ccb940c6688195c4518d  PCI: pciehp: Avoid unnecessary device replacement check

elapsed time: 1454m

configs tested: 211
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250315    gcc-13.2.0
arc                   randconfig-001-20250315    gcc-14.2.0
arc                   randconfig-002-20250315    gcc-13.2.0
arc                   randconfig-002-20250315    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    clang-21
arm                            hisi_defconfig    gcc-14.2.0
arm                   randconfig-001-20250315    gcc-14.2.0
arm                   randconfig-002-20250315    clang-21
arm                   randconfig-002-20250315    gcc-14.2.0
arm                   randconfig-003-20250315    clang-21
arm                   randconfig-003-20250315    gcc-14.2.0
arm                   randconfig-004-20250315    gcc-14.2.0
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250315    gcc-14.2.0
arm64                 randconfig-002-20250315    gcc-14.2.0
arm64                 randconfig-003-20250315    clang-16
arm64                 randconfig-003-20250315    gcc-14.2.0
arm64                 randconfig-004-20250315    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250315    gcc-14.2.0
csky                  randconfig-002-20250315    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250315    clang-21
hexagon               randconfig-001-20250315    gcc-14.2.0
hexagon               randconfig-002-20250315    clang-17
hexagon               randconfig-002-20250315    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250314    clang-19
i386        buildonly-randconfig-001-20250315    clang-19
i386        buildonly-randconfig-002-20250314    clang-19
i386        buildonly-randconfig-002-20250315    clang-19
i386        buildonly-randconfig-003-20250314    gcc-12
i386        buildonly-randconfig-003-20250315    clang-19
i386        buildonly-randconfig-004-20250314    gcc-12
i386        buildonly-randconfig-004-20250315    clang-19
i386        buildonly-randconfig-005-20250314    gcc-12
i386        buildonly-randconfig-005-20250315    clang-19
i386        buildonly-randconfig-006-20250314    gcc-12
i386        buildonly-randconfig-006-20250315    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250315    clang-19
i386                  randconfig-002-20250315    clang-19
i386                  randconfig-003-20250315    clang-19
i386                  randconfig-004-20250315    clang-19
i386                  randconfig-005-20250315    clang-19
i386                  randconfig-006-20250315    clang-19
i386                  randconfig-007-20250315    clang-19
i386                  randconfig-011-20250315    gcc-12
i386                  randconfig-012-20250315    gcc-12
i386                  randconfig-013-20250315    gcc-12
i386                  randconfig-014-20250315    gcc-12
i386                  randconfig-015-20250315    gcc-12
i386                  randconfig-016-20250315    gcc-12
i386                  randconfig-017-20250315    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250315    gcc-14.2.0
loongarch             randconfig-002-20250315    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    clang-21
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
mips                        qi_lb60_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250315    gcc-14.2.0
nios2                 randconfig-002-20250315    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250315    gcc-14.2.0
parisc                randconfig-002-20250315    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-21
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250315    clang-21
powerpc               randconfig-001-20250315    gcc-14.2.0
powerpc               randconfig-002-20250315    gcc-14.2.0
powerpc               randconfig-003-20250315    clang-18
powerpc               randconfig-003-20250315    gcc-14.2.0
powerpc64             randconfig-001-20250315    gcc-14.2.0
powerpc64             randconfig-002-20250315    clang-18
powerpc64             randconfig-002-20250315    gcc-14.2.0
powerpc64             randconfig-003-20250315    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250315    gcc-14.2.0
riscv                 randconfig-002-20250315    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250315    clang-19
s390                  randconfig-001-20250315    gcc-14.2.0
s390                  randconfig-002-20250315    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250315    gcc-14.2.0
sh                    randconfig-002-20250315    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                           se7724_defconfig    clang-21
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    clang-21
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            shmin_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250315    gcc-14.2.0
sparc                 randconfig-002-20250315    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250315    gcc-14.2.0
sparc64               randconfig-002-20250315    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250315    gcc-12
um                    randconfig-001-20250315    gcc-14.2.0
um                    randconfig-002-20250315    clang-18
um                    randconfig-002-20250315    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250315    clang-19
x86_64      buildonly-randconfig-001-20250315    gcc-12
x86_64      buildonly-randconfig-002-20250315    clang-19
x86_64      buildonly-randconfig-003-20250315    clang-19
x86_64      buildonly-randconfig-004-20250315    clang-19
x86_64      buildonly-randconfig-005-20250315    clang-19
x86_64      buildonly-randconfig-006-20250315    clang-19
x86_64      buildonly-randconfig-006-20250315    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250315    clang-19
x86_64                randconfig-002-20250315    clang-19
x86_64                randconfig-003-20250315    clang-19
x86_64                randconfig-004-20250315    clang-19
x86_64                randconfig-005-20250315    clang-19
x86_64                randconfig-006-20250315    clang-19
x86_64                randconfig-007-20250315    clang-19
x86_64                randconfig-008-20250315    clang-19
x86_64                randconfig-071-20250315    clang-19
x86_64                randconfig-072-20250315    clang-19
x86_64                randconfig-073-20250315    clang-19
x86_64                randconfig-074-20250315    clang-19
x86_64                randconfig-075-20250315    clang-19
x86_64                randconfig-076-20250315    clang-19
x86_64                randconfig-077-20250315    clang-19
x86_64                randconfig-078-20250315    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250315    gcc-14.2.0
xtensa                randconfig-002-20250315    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

