Return-Path: <linux-pci+bounces-33580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCA2B1DEEF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 23:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5427240CB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8598523372C;
	Thu,  7 Aug 2025 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eby9nJEt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9D321E08B
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754602869; cv=none; b=bA/LXPG0G1FbOtMY5ixTf1mGtMoM4Y2NR7gns+3UR0BBLeFrW+RM3+BUmjIljmEdMAOmxBVfvJYNe6+AS7BQIBbeUSgXReq7OgJqg9o0IpGXGUam4j4Rf00NAYVmu8lmuTTeGr1PitjCJeaUsRFUIpUaSkQ+Rk2zk+FNfg5KjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754602869; c=relaxed/simple;
	bh=4p21OzJ2R3epIB6ttqsoDLlSwuFAMMrv+ihhP1EbSUI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FnxonKuCVELC6+R974imYMEoApakzeSUylYQyqy3rZWmoolsB47Re6lYK3XqE89M6iS63LA806M9befoyUTvtNgIrGtsQw76Jdh0zd1bC9exelNEsy0K3Lf975tK/PVm2n/ySn+Hb+pPqftAwmBznpc/naJm3wbsni6ovvcOd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eby9nJEt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754602867; x=1786138867;
  h=date:from:to:cc:subject:message-id;
  bh=4p21OzJ2R3epIB6ttqsoDLlSwuFAMMrv+ihhP1EbSUI=;
  b=Eby9nJEtvLJHaPONx+Y0hges0EujnRDPOxYYVvwgLR193q35XHs4VK9h
   Skbe/voEGfIhsH3Ovj/C5+e1z6QdYqiZjGT7UeHhZIsQRGjNfkI9kkjkO
   mY1MNkvm56LItclc1d2MphNDgdayqtdaYFZB7CBHiURcOtZH1ZfldU+O0
   EzK7/OY1YzqGHcHjKtZoBSvfKNexfJjhifcNPh7ebnXdpgWcqpMLvwwIh
   kD9G6KSFNeFiGxI9bMWLTSc0ws5Zhy8BDZ8N5NWBAS/ecXpHr7tJ5T0hH
   4MbgmcWeHgoiGaHc7L+JO0MBABaFmrPCN/3T76owlsSwyH9W/z0P/uTUG
   w==;
X-CSE-ConnectionGUID: eDvjl6PPSFuypun/umZ85A==
X-CSE-MsgGUID: bP+FwnOyQaa50x+u5oAD9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57084164"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57084164"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 14:41:06 -0700
X-CSE-ConnectionGUID: u9gxv+95RN+/VMg2OARswg==
X-CSE-MsgGUID: Y1lxK79SSuG3j3SHnWdSIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196001697"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 14:41:06 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uk8MB-0003GE-1i;
	Thu, 07 Aug 2025 21:41:03 +0000
Date: Fri, 08 Aug 2025 05:40:58 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:msi] BUILD SUCCESS
 69583ff3489c97689d577275ef2e7ffe63aec38a
Message-ID: <202508080549.0kLw6YtQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git msi
branch HEAD: 69583ff3489c97689d577275ef2e7ffe63aec38a  PCI: Disable MSI on RDC PCI to PCIe bridges

elapsed time: 1394m

configs tested: 293
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
arc                   randconfig-001-20250807    clang-22
arc                   randconfig-001-20250807    gcc-13.4.0
arc                   randconfig-002-20250807    clang-22
arc                   randconfig-002-20250807    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-22
arm                                 defconfig    clang-19
arm                      jornada720_defconfig    clang-22
arm                        mvebu_v7_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                   randconfig-001-20250807    clang-22
arm                   randconfig-002-20250807    clang-22
arm                   randconfig-002-20250807    gcc-10.5.0
arm                   randconfig-003-20250807    clang-22
arm                   randconfig-004-20250807    clang-22
arm                   randconfig-004-20250807    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.1.0
arm                        spear3xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250807    clang-22
arm64                 randconfig-001-20250807    gcc-8.5.0
arm64                 randconfig-002-20250807    clang-22
arm64                 randconfig-002-20250807    gcc-8.5.0
arm64                 randconfig-003-20250807    clang-22
arm64                 randconfig-004-20250807    clang-22
arm64                 randconfig-004-20250807    gcc-14.3.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                                defconfig    clang-22
csky                  randconfig-001-20250807    gcc-15.1.0
csky                  randconfig-002-20250807    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250807    clang-22
hexagon               randconfig-001-20250807    gcc-15.1.0
hexagon               randconfig-002-20250807    clang-22
hexagon               randconfig-002-20250807    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250807    clang-20
i386        buildonly-randconfig-001-20250807    gcc-12
i386        buildonly-randconfig-001-20250808    gcc-12
i386        buildonly-randconfig-002-20250807    clang-20
i386        buildonly-randconfig-002-20250807    gcc-12
i386        buildonly-randconfig-002-20250808    gcc-12
i386        buildonly-randconfig-003-20250807    gcc-12
i386        buildonly-randconfig-003-20250808    gcc-12
i386        buildonly-randconfig-004-20250807    gcc-11
i386        buildonly-randconfig-004-20250807    gcc-12
i386        buildonly-randconfig-004-20250808    gcc-12
i386        buildonly-randconfig-005-20250807    gcc-12
i386        buildonly-randconfig-005-20250808    gcc-12
i386        buildonly-randconfig-006-20250807    gcc-12
i386        buildonly-randconfig-006-20250808    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250807    gcc-12
i386                  randconfig-001-20250808    clang-20
i386                  randconfig-002-20250807    gcc-12
i386                  randconfig-002-20250808    clang-20
i386                  randconfig-003-20250807    gcc-12
i386                  randconfig-003-20250808    clang-20
i386                  randconfig-004-20250807    gcc-12
i386                  randconfig-004-20250808    clang-20
i386                  randconfig-005-20250807    gcc-12
i386                  randconfig-005-20250808    clang-20
i386                  randconfig-006-20250807    gcc-12
i386                  randconfig-006-20250808    clang-20
i386                  randconfig-007-20250807    gcc-12
i386                  randconfig-007-20250808    clang-20
i386                  randconfig-011-20250807    clang-20
i386                  randconfig-011-20250808    clang-20
i386                  randconfig-012-20250807    clang-20
i386                  randconfig-012-20250808    clang-20
i386                  randconfig-013-20250807    clang-20
i386                  randconfig-013-20250808    clang-20
i386                  randconfig-014-20250807    clang-20
i386                  randconfig-014-20250808    clang-20
i386                  randconfig-015-20250807    clang-20
i386                  randconfig-015-20250808    clang-20
i386                  randconfig-016-20250807    clang-20
i386                  randconfig-016-20250808    clang-20
i386                  randconfig-017-20250807    clang-20
i386                  randconfig-017-20250808    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250807    clang-22
loongarch             randconfig-001-20250807    gcc-15.1.0
loongarch             randconfig-002-20250807    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-22
mips                         rt305x_defconfig    gcc-15.1.0
nios2                            alldefconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250807    gcc-11.5.0
nios2                 randconfig-001-20250807    gcc-15.1.0
nios2                 randconfig-002-20250807    gcc-15.1.0
nios2                 randconfig-002-20250807    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250807    gcc-15.1.0
parisc                randconfig-001-20250807    gcc-8.5.0
parisc                randconfig-002-20250807    gcc-11.5.0
parisc                randconfig-002-20250807    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    clang-22
powerpc                   currituck_defconfig    clang-22
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc                       ppc64_defconfig    clang-22
powerpc               randconfig-001-20250807    gcc-12.5.0
powerpc               randconfig-001-20250807    gcc-15.1.0
powerpc               randconfig-002-20250807    gcc-10.5.0
powerpc               randconfig-002-20250807    gcc-15.1.0
powerpc               randconfig-003-20250807    gcc-11.5.0
powerpc               randconfig-003-20250807    gcc-15.1.0
powerpc                         wii_defconfig    clang-22
powerpc64             randconfig-001-20250807    gcc-11.5.0
powerpc64             randconfig-001-20250807    gcc-15.1.0
powerpc64             randconfig-002-20250807    clang-22
powerpc64             randconfig-002-20250807    gcc-15.1.0
powerpc64             randconfig-003-20250807    gcc-13.4.0
powerpc64             randconfig-003-20250807    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                               defconfig    gcc-15.1.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20250807    gcc-12.5.0
riscv                 randconfig-002-20250807    gcc-12.5.0
riscv                 randconfig-002-20250807    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250807    clang-22
s390                  randconfig-001-20250807    gcc-12.5.0
s390                  randconfig-002-20250807    clang-22
s390                  randconfig-002-20250807    gcc-12.5.0
sh                               alldefconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250807    gcc-12.5.0
sh                    randconfig-001-20250807    gcc-14.3.0
sh                    randconfig-002-20250807    gcc-12.5.0
sh                    randconfig-002-20250807    gcc-9.5.0
sh                      rts7751r2d1_defconfig    clang-22
sh                           se7721_defconfig    clang-22
sh                             sh03_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250807    gcc-12.5.0
sparc                 randconfig-001-20250807    gcc-14.3.0
sparc                 randconfig-002-20250807    gcc-12.5.0
sparc                 randconfig-002-20250807    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250807    clang-22
sparc64               randconfig-001-20250807    gcc-12.5.0
sparc64               randconfig-002-20250807    clang-22
sparc64               randconfig-002-20250807    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250807    gcc-12
um                    randconfig-001-20250807    gcc-12.5.0
um                    randconfig-002-20250807    gcc-11
um                    randconfig-002-20250807    gcc-12.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250807    clang-20
x86_64      buildonly-randconfig-001-20250807    gcc-11
x86_64      buildonly-randconfig-001-20250808    gcc-12
x86_64      buildonly-randconfig-002-20250807    gcc-11
x86_64      buildonly-randconfig-002-20250807    gcc-12
x86_64      buildonly-randconfig-002-20250808    gcc-12
x86_64      buildonly-randconfig-003-20250807    clang-20
x86_64      buildonly-randconfig-003-20250807    gcc-11
x86_64      buildonly-randconfig-003-20250808    gcc-12
x86_64      buildonly-randconfig-004-20250807    clang-20
x86_64      buildonly-randconfig-004-20250807    gcc-11
x86_64      buildonly-randconfig-004-20250808    gcc-12
x86_64      buildonly-randconfig-005-20250807    gcc-11
x86_64      buildonly-randconfig-005-20250808    gcc-12
x86_64      buildonly-randconfig-006-20250807    gcc-11
x86_64      buildonly-randconfig-006-20250807    gcc-12
x86_64      buildonly-randconfig-006-20250808    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250807    gcc-12
x86_64                randconfig-001-20250808    gcc-12
x86_64                randconfig-002-20250807    gcc-12
x86_64                randconfig-002-20250808    gcc-12
x86_64                randconfig-003-20250807    gcc-12
x86_64                randconfig-003-20250808    gcc-12
x86_64                randconfig-004-20250807    gcc-12
x86_64                randconfig-004-20250808    gcc-12
x86_64                randconfig-005-20250807    gcc-12
x86_64                randconfig-005-20250808    gcc-12
x86_64                randconfig-006-20250807    gcc-12
x86_64                randconfig-006-20250808    gcc-12
x86_64                randconfig-007-20250807    gcc-12
x86_64                randconfig-007-20250808    gcc-12
x86_64                randconfig-008-20250807    gcc-12
x86_64                randconfig-008-20250808    gcc-12
x86_64                randconfig-071-20250807    clang-20
x86_64                randconfig-072-20250807    clang-20
x86_64                randconfig-073-20250807    clang-20
x86_64                randconfig-074-20250807    clang-20
x86_64                randconfig-075-20250807    clang-20
x86_64                randconfig-076-20250807    clang-20
x86_64                randconfig-077-20250807    clang-20
x86_64                randconfig-078-20250807    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250807    gcc-12.5.0
xtensa                randconfig-001-20250807    gcc-15.1.0
xtensa                randconfig-002-20250807    gcc-12.5.0
xtensa                randconfig-002-20250807    gcc-8.5.0
xtensa                         virt_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

