Return-Path: <linux-pci+bounces-23897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE80A6377C
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 22:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A990188EC53
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4C158DA3;
	Sun, 16 Mar 2025 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJfQSX+P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E03D6F
	for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2025 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742159589; cv=none; b=csR1w8BfQ9IY1srXa5Ny2QmWQDpyvhZjmwV+j1Qa4TwH8DEJTCml8dklB7iF+/WinmB4+8bihWvmPYT4fRbz6oeJ+p5LV2v5A4bGtXbb7wuHFXdpjW6vs8eXh2/2+zEwugoByaXZAO/ukL9LZpxwjcB/eg1RZgTDl9gKEXM2tXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742159589; c=relaxed/simple;
	bh=egBFpTKEq73SmK1pdh+LvGUe++7qEAztJsz6Lt/2hZc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WxPpNJtJxRew6wzayMntGMLenj7W0RXun1umGt2pf8BZoy+w94HCCDiqZ5pE8lnMzYw+BzBtrw10zpNYfOiu9cfH7blXkkqJfC0EJNPo90SPWd5CEDq4V2MJMZVhpBST95pAKyDgoWbX7XZ1zMDQtjdvivlws1epj10fXDawDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJfQSX+P; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742159587; x=1773695587;
  h=date:from:to:cc:subject:message-id;
  bh=egBFpTKEq73SmK1pdh+LvGUe++7qEAztJsz6Lt/2hZc=;
  b=LJfQSX+PK5NLsssX6X4tYnju6CwBBcDnX4uXAsBhPEbJN3wRzXA9D2Q1
   yScUYJ0vh+iqO8apzB32VIqtSp0fWJaJnVcV8A28/Xo8XSatraaf76FAr
   elyRkyTmD5zLq8qaD3+FLGQ73lKJu2dcpupxkpt6iF8a+62FhBkZWwMHc
   0W0mGLP6/nB0PcY0RWixuLisWH2xH6bqNqh2ruKoxWIGd1z3UpmQldfd4
   SzPRecxS5GrY5irVg+gmVLM8sgh1+wsoOsronPi0RyI5NggjAaAy1Cu8p
   mLZliKV74lGShBSfpHcZC1edt1W9XW4BKri+g37oolF/LqLfU0ay3Kt3Q
   Q==;
X-CSE-ConnectionGUID: 3xXpbFTITaWEedWsRA8ilg==
X-CSE-MsgGUID: LvinQNDmQYCYHS9Jl8VSaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="53909098"
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="53909098"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 14:13:07 -0700
X-CSE-ConnectionGUID: j7aBoIxKQfueLC0VicxKWA==
X-CSE-MsgGUID: 0bptkNHuQFy0r6C3wjE+oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="121577123"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 16 Mar 2025 14:13:06 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttvI7-000CFF-1Q;
	Sun, 16 Mar 2025 21:13:03 +0000
Date: Mon, 17 Mar 2025 05:12:28 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-cpu-addr-fixup] BUILD SUCCESS WITH
 WARNING 40b96cba38232460c691b52bbf9183f9e4d34914
Message-ID: <202503170520.06Jd05SF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-cpu-addr-fixup
branch HEAD: 40b96cba38232460c691b52bbf9183f9e4d34914  PCI: imx6: Remove cpu_addr_fixup()

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503160804.HTvWiBze-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202503160823.faHNdwwX-lkp@intel.com

    drivers/pci/controller/dwc/pcie-designware.c:1134:39: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
    drivers/pci/controller/dwc/pcie-designware.c:1135:6: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]

Warning ids grouped by kconfigs:

recent_errors
|-- arm-defconfig
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-specifies-type-unsigned-long-long-but-the-argument-has-type-resource_size_t-(aka-unsigned-int-)
|-- csky-randconfig-001-20250316
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- microblaze-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- microblaze-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- mips-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- mips-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- openrisc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- parisc-allmodconfig
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- parisc-allyesconfig
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- parisc-randconfig-002-20250316
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- powerpc-randconfig-002-20250316
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-llx-expects-argument-of-type-long-long-unsigned-int-but-argument-has-type-resource_size_t-aka-unsigned-int
|-- powerpc-randconfig-003-20250316
|   `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-specifies-type-unsigned-long-long-but-the-argument-has-type-resource_size_t-(aka-unsigned-int-)
`-- riscv-randconfig-001-20250316
    `-- drivers-pci-controller-dwc-pcie-designware.c:warning:format-specifies-type-unsigned-long-long-but-the-argument-has-type-resource_size_t-(aka-unsigned-int-)

elapsed time: 1443m

configs tested: 139
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                   randconfig-001-20250316    gcc-13.2.0
arc                   randconfig-002-20250316    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-14
arm                          moxart_defconfig    gcc-14.2.0
arm                        mvebu_v7_defconfig    clang-21
arm                   randconfig-001-20250316    clang-15
arm                   randconfig-002-20250316    gcc-14.2.0
arm                   randconfig-003-20250316    gcc-14.2.0
arm                   randconfig-004-20250316    clang-21
arm                        realview_defconfig    clang-16
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250316    clang-17
arm64                 randconfig-002-20250316    clang-19
arm64                 randconfig-003-20250316    clang-21
arm64                 randconfig-004-20250316    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250316    gcc-14.2.0
csky                  randconfig-002-20250316    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250316    clang-21
hexagon               randconfig-002-20250316    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250316    clang-19
i386        buildonly-randconfig-002-20250316    clang-19
i386        buildonly-randconfig-003-20250316    gcc-12
i386        buildonly-randconfig-004-20250316    clang-19
i386        buildonly-randconfig-005-20250316    clang-19
i386        buildonly-randconfig-006-20250316    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250316    gcc-14.2.0
loongarch             randconfig-002-20250316    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250316    gcc-14.2.0
nios2                 randconfig-002-20250316    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250316    gcc-14.2.0
parisc                randconfig-002-20250316    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc               randconfig-001-20250316    gcc-14.2.0
powerpc               randconfig-002-20250316    gcc-14.2.0
powerpc               randconfig-003-20250316    clang-15
powerpc64             randconfig-001-20250316    clang-21
powerpc64             randconfig-002-20250316    clang-19
powerpc64             randconfig-003-20250316    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250316    clang-21
riscv                 randconfig-002-20250316    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250316    gcc-14.2.0
s390                  randconfig-002-20250316    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250316    gcc-14.2.0
sh                    randconfig-002-20250316    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250316    gcc-14.2.0
sparc                 randconfig-002-20250316    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250316    gcc-14.2.0
sparc64               randconfig-002-20250316    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250316    clang-21
um                    randconfig-002-20250316    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250316    gcc-12
x86_64      buildonly-randconfig-002-20250316    gcc-12
x86_64      buildonly-randconfig-003-20250316    clang-19
x86_64      buildonly-randconfig-004-20250316    clang-19
x86_64      buildonly-randconfig-005-20250316    gcc-12
x86_64      buildonly-randconfig-006-20250316    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250316    gcc-14.2.0
xtensa                randconfig-002-20250316    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

