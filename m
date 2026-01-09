Return-Path: <linux-pci+bounces-44395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B993D0BC9F
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 19:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2C1730146FD
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C635B139;
	Fri,  9 Jan 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3hin1A4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE61366567
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981936; cv=none; b=BAAzZiNZ4WOIKsJKRWPI7UVH/EF7A23T4l31xDOozo9ohhFpIHc/lZSTLlWuoByxLwLkEhKXdldNuPlAW3zzZy7nYurDfiK0+VGwmx0IVspWyKHe4vlu95YTrJfD5ttjG9JiDSS2F7rIEHw73SBVaB/fG2qXPVsAbi58TaYyWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981936; c=relaxed/simple;
	bh=YH8CD7UEKflElLgCCrn2tacds5WGEsZU9+ZREW2NblY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=teqVwfwrWX0jSgHgdmPsA7+XWpgN1k0evNNaO6YTyq2kbaRnL6FD6quIpejexum53Cx1ujkVJ+0GyLEAzkwsSo3eN1K4vlGFj+APBeHW8/l0CMEwByBfqxg6NSA39mDoND1QsRnkk3AzSOJeT45Z4846XcrdvH/YJxazxlo8+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3hin1A4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767981935; x=1799517935;
  h=date:from:to:cc:subject:message-id;
  bh=YH8CD7UEKflElLgCCrn2tacds5WGEsZU9+ZREW2NblY=;
  b=f3hin1A4Hp14BTsXBtJ5V/Np1d41kxCQdlCj2FFLFSrAC/q4SJgr1eFM
   lDYJPuIyw6agFShNodCTzVxb8tSp2MnKaKYnsQmR6/v/xcWY2oV0DXLRu
   1q5G2WMWPp5jhJXmAoMriX8tNat0Vh1BdQMj0EoPdegjxfNVlUeZKAmfO
   35VJk1nMv3o9HXnXSCagV1eh+tLdO20V30zich8W1d38qjUhkRwKxTEtl
   mkYm1383QN/6JpPI6/s5Z2AeDgcX/Xskld5STRWuBFb7qc60+cxgF1Ppk
   nn+NJw+TcklRI4kPC2mYAew+ozEnwHTYJZPjv+ihVNNY6SmUsmXv6zd0y
   w==;
X-CSE-ConnectionGUID: /eV9pYj3QAOVCMD4yfnTfA==
X-CSE-MsgGUID: Om4JwVDOT/K21CmQPtxOeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="80085280"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="80085280"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 10:05:35 -0800
X-CSE-ConnectionGUID: OnYCnhgHSLKEfsyCn1Srxg==
X-CSE-MsgGUID: z8zpUgUcT0i6TAJTkoMUlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="202736567"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 Jan 2026 10:05:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veGrb-000000007b2-00EF;
	Fri, 09 Jan 2026 18:05:31 +0000
Date: Sat, 10 Jan 2026 02:04:33 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:p2pdma] BUILD SUCCESS
 cb500023a75246f60b79af9f7321d6e75330c5b5
Message-ID: <202601100228.EJOn7t6Q-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git p2pdma
branch HEAD: cb500023a75246f60b79af9f7321d6e75330c5b5  PCI/P2PDMA: Fix p2pmem_alloc_mmap() warning condition

elapsed time: 1562m

configs tested: 226
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20260109    gcc-13.4.0
arc                   randconfig-002-20260109    gcc-13.4.0
arc                   randconfig-002-20260109    gcc-9.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    clang-22
arm                      footbridge_defconfig    clang-17
arm                   randconfig-001-20260109    gcc-10.5.0
arm                   randconfig-001-20260109    gcc-13.4.0
arm                   randconfig-002-20260109    gcc-13.4.0
arm                   randconfig-002-20260109    gcc-15.1.0
arm                   randconfig-003-20260109    gcc-13.4.0
arm                   randconfig-003-20260109    gcc-8.5.0
arm                   randconfig-004-20260109    gcc-11.5.0
arm                   randconfig-004-20260109    gcc-13.4.0
arm                        shmobile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260109    clang-22
arm64                 randconfig-001-20260109    gcc-8.5.0
arm64                 randconfig-002-20260109    clang-22
arm64                 randconfig-002-20260109    gcc-8.5.0
arm64                 randconfig-003-20260109    gcc-11.5.0
arm64                 randconfig-003-20260109    gcc-8.5.0
arm64                 randconfig-004-20260109    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260109    gcc-8.5.0
csky                  randconfig-001-20260109    gcc-9.5.0
csky                  randconfig-002-20260109    gcc-15.1.0
csky                  randconfig-002-20260109    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260109    clang-22
hexagon               randconfig-001-20260109    gcc-8.5.0
hexagon               randconfig-002-20260109    clang-17
hexagon               randconfig-002-20260109    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260109    clang-20
i386        buildonly-randconfig-002-20260109    clang-20
i386        buildonly-randconfig-002-20260109    gcc-14
i386        buildonly-randconfig-003-20260109    clang-20
i386        buildonly-randconfig-003-20260109    gcc-14
i386        buildonly-randconfig-004-20260109    clang-20
i386        buildonly-randconfig-005-20260109    clang-20
i386        buildonly-randconfig-005-20260109    gcc-12
i386        buildonly-randconfig-006-20260109    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260109    gcc-14
i386                  randconfig-002-20260109    gcc-14
i386                  randconfig-003-20260109    gcc-12
i386                  randconfig-003-20260109    gcc-14
i386                  randconfig-004-20260109    gcc-14
i386                  randconfig-005-20260109    gcc-14
i386                  randconfig-006-20260109    clang-20
i386                  randconfig-006-20260109    gcc-14
i386                  randconfig-007-20260109    gcc-14
i386                  randconfig-011-20260109    clang-20
i386                  randconfig-012-20260109    gcc-14
i386                  randconfig-013-20260109    clang-20
i386                  randconfig-014-20260109    gcc-14
i386                  randconfig-015-20260109    clang-20
i386                  randconfig-016-20260109    clang-20
i386                  randconfig-017-20260109    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260109    clang-22
loongarch             randconfig-001-20260109    gcc-8.5.0
loongarch             randconfig-002-20260109    gcc-15.1.0
loongarch             randconfig-002-20260109    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.2.0
mips                           jazz_defconfig    clang-17
mips                          rm200_defconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260109    gcc-8.5.0
nios2                 randconfig-002-20260109    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260109    gcc-12.5.0
parisc                randconfig-002-20260109    gcc-15.1.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                     rainier_defconfig    gcc-15.1.0
powerpc               randconfig-001-20260109    clang-22
powerpc               randconfig-002-20260109    clang-22
powerpc64             randconfig-001-20260109    gcc-15.1.0
powerpc64             randconfig-002-20260109    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260109    clang-22
riscv                 randconfig-001-20260109    gcc-14.3.0
riscv                 randconfig-002-20260109    clang-22
riscv                 randconfig-002-20260109    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260109    clang-22
s390                  randconfig-002-20260109    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20260109    clang-22
sh                    randconfig-001-20260109    gcc-14.3.0
sh                    randconfig-002-20260109    clang-22
sh                    randconfig-002-20260109    gcc-13.4.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260109    gcc-14.3.0
sparc                 randconfig-001-20260109    gcc-8.5.0
sparc                 randconfig-002-20260109    gcc-13.4.0
sparc                 randconfig-002-20260109    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260109    gcc-14.3.0
sparc64               randconfig-001-20260109    gcc-8.5.0
sparc64               randconfig-002-20260109    clang-20
sparc64               randconfig-002-20260109    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260109    gcc-14
um                    randconfig-001-20260109    gcc-14.3.0
um                    randconfig-002-20260109    gcc-14
um                    randconfig-002-20260109    gcc-14.3.0
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260109    clang-20
x86_64      buildonly-randconfig-001-20260109    gcc-14
x86_64      buildonly-randconfig-002-20260109    gcc-14
x86_64      buildonly-randconfig-003-20260109    gcc-14
x86_64      buildonly-randconfig-004-20260109    gcc-14
x86_64      buildonly-randconfig-005-20260109    gcc-14
x86_64      buildonly-randconfig-006-20260109    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260109    clang-20
x86_64                randconfig-001-20260109    gcc-14
x86_64                randconfig-002-20260109    clang-20
x86_64                randconfig-002-20260109    gcc-14
x86_64                randconfig-003-20260109    gcc-14
x86_64                randconfig-004-20260109    clang-20
x86_64                randconfig-004-20260109    gcc-14
x86_64                randconfig-005-20260109    clang-20
x86_64                randconfig-005-20260109    gcc-14
x86_64                randconfig-006-20260109    gcc-14
x86_64                randconfig-011-20260109    gcc-12
x86_64                randconfig-011-20260109    gcc-14
x86_64                randconfig-012-20260109    clang-20
x86_64                randconfig-012-20260109    gcc-14
x86_64                randconfig-013-20260109    gcc-14
x86_64                randconfig-014-20260109    gcc-14
x86_64                randconfig-015-20260109    gcc-12
x86_64                randconfig-015-20260109    gcc-14
x86_64                randconfig-016-20260109    gcc-14
x86_64                randconfig-071-20260109    clang-20
x86_64                randconfig-071-20260109    gcc-14
x86_64                randconfig-072-20260109    clang-20
x86_64                randconfig-073-20260109    clang-20
x86_64                randconfig-073-20260109    gcc-14
x86_64                randconfig-074-20260109    clang-20
x86_64                randconfig-074-20260109    gcc-14
x86_64                randconfig-075-20260109    clang-20
x86_64                randconfig-075-20260109    gcc-14
x86_64                randconfig-076-20260109    clang-20
x86_64                randconfig-076-20260109    gcc-12
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260109    gcc-12.5.0
xtensa                randconfig-001-20260109    gcc-14.3.0
xtensa                randconfig-002-20260109    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

