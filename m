Return-Path: <linux-pci+bounces-21395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EC9A351B4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E16557A3C2A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13852753E4;
	Thu, 13 Feb 2025 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uw3LhT2A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B142753E1
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487463; cv=none; b=A5ROIQM50WNADLseQdQRIetsLYWcVW2fSH65TCD11fVZRM4anYhi3lo5q6T9vRhnL/L9ZX9hjXIKGGz8EpeJSPST0plyDC+iLWZv/XNd7DDUIwFTMb9Y0DqDuwTwn0v3OSPYSGKyrJeLaMPvnk08Usbq4PykEMFBJ+Hk6UoZkOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487463; c=relaxed/simple;
	bh=HdiB1bCELRmpq5tTmvDt4vX4Zjv2S0Ocxz/NuL21QYU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=swxL4ZJtpmVKgjx6deRNijkYDLse+Lja03IRrjNivKK5niY/kTjgX7duM17gnW0W4g00U/S9JGQYs4z+yy5Pn8M6CEa/qYSiPI9lnVKLAMuCOgqvSdVucdpR/aUvkUJGSUIHnZ9E/EG7HyrkilTq3Vz4IVA0mzHTcqEow0uBBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uw3LhT2A; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739487462; x=1771023462;
  h=date:from:to:cc:subject:message-id;
  bh=HdiB1bCELRmpq5tTmvDt4vX4Zjv2S0Ocxz/NuL21QYU=;
  b=Uw3LhT2AMH3pYg7QZHlSjDSAsDwsF5VhHn9641PHe8+FCPiCaAC+DfFJ
   lSOZ0bZmhYB85AeNTxVqsvSbtF3KVscsXIb0JtG1+9sUcT33TVOPUJmvV
   HsTaIWIurnN0yTPfuGBVL1+LNdMt/zwH0iC6fQjt52snPochgIc4DG8fa
   I9F7oPh4YdkbwreAG5xxJ67YzdnmXDnuucoAXxLoEZWfHxXFx0xRMeiyu
   9mkrfHbBRAQ5ticUU0Nd/J5jrijj75u891TPnCc0wceqMvsTxoYnCYtWT
   QznK7VEefT6DqeQr2Nm9A/xYZaWxwAyKGlgY9Ftby4IBq2iT2P60L3rXK
   g==;
X-CSE-ConnectionGUID: jOzFGz2iTa6B2q2hlekEUQ==
X-CSE-MsgGUID: N/xrh6ZPSkux73HF5RVBFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39924312"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="39924312"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:57:41 -0800
X-CSE-ConnectionGUID: Tc4kBGcjR0yCS219ryVQUw==
X-CSE-MsgGUID: x9g/cTAITjClFG7hhwebnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118379146"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Feb 2025 14:57:39 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tii9J-0018nH-1m;
	Thu, 13 Feb 2025 22:57:37 +0000
Date: Fri, 14 Feb 2025 06:56:39 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 2ff0f334df8dda3788dd3fefb730cdcb4659f1c8
Message-ID: <202502140633.QFhoINNC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 2ff0f334df8dda3788dd3fefb730cdcb4659f1c8  PCI: Cache offset of Resizable BAR capability

elapsed time: 1446m

configs tested: 296
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    clang-15
arc                            hsdk_defconfig    clang-15
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20250213    gcc-13.2.0
arc                   randconfig-001-20250213    gcc-14.2.0
arc                   randconfig-001-20250214    gcc-14.2.0
arc                   randconfig-002-20250213    gcc-13.2.0
arc                   randconfig-002-20250213    gcc-14.2.0
arc                   randconfig-002-20250214    gcc-14.2.0
arc                        vdk_hs38_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250213    clang-17
arm                   randconfig-001-20250213    gcc-14.2.0
arm                   randconfig-001-20250214    gcc-14.2.0
arm                   randconfig-002-20250213    clang-15
arm                   randconfig-002-20250213    gcc-14.2.0
arm                   randconfig-002-20250214    gcc-14.2.0
arm                   randconfig-003-20250213    clang-21
arm                   randconfig-003-20250213    gcc-14.2.0
arm                   randconfig-003-20250214    gcc-14.2.0
arm                   randconfig-004-20250213    gcc-14.2.0
arm                   randconfig-004-20250214    gcc-14.2.0
arm                             rpc_defconfig    gcc-14.2.0
arm                           sama5_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250213    clang-19
arm64                 randconfig-001-20250213    gcc-14.2.0
arm64                 randconfig-001-20250214    gcc-14.2.0
arm64                 randconfig-002-20250213    gcc-14.2.0
arm64                 randconfig-002-20250214    gcc-14.2.0
arm64                 randconfig-003-20250213    gcc-14.2.0
arm64                 randconfig-003-20250214    gcc-14.2.0
arm64                 randconfig-004-20250213    clang-21
arm64                 randconfig-004-20250213    gcc-14.2.0
arm64                 randconfig-004-20250214    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250213    clang-21
csky                  randconfig-001-20250213    gcc-14.2.0
csky                  randconfig-001-20250214    clang-21
csky                  randconfig-002-20250213    clang-21
csky                  randconfig-002-20250213    gcc-14.2.0
csky                  randconfig-002-20250214    clang-21
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250213    clang-21
hexagon               randconfig-001-20250214    clang-21
hexagon               randconfig-002-20250213    clang-18
hexagon               randconfig-002-20250213    clang-21
hexagon               randconfig-002-20250214    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250213    clang-19
i386        buildonly-randconfig-001-20250213    gcc-12
i386        buildonly-randconfig-001-20250214    gcc-12
i386        buildonly-randconfig-002-20250213    clang-19
i386        buildonly-randconfig-002-20250214    gcc-12
i386        buildonly-randconfig-003-20250213    clang-19
i386        buildonly-randconfig-003-20250214    gcc-12
i386        buildonly-randconfig-004-20250213    clang-19
i386        buildonly-randconfig-004-20250214    gcc-12
i386        buildonly-randconfig-005-20250213    clang-19
i386        buildonly-randconfig-005-20250214    gcc-12
i386        buildonly-randconfig-006-20250213    clang-19
i386        buildonly-randconfig-006-20250214    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250213    clang-19
i386                  randconfig-001-20250214    gcc-12
i386                  randconfig-002-20250213    clang-19
i386                  randconfig-002-20250214    gcc-12
i386                  randconfig-003-20250213    clang-19
i386                  randconfig-003-20250214    gcc-12
i386                  randconfig-004-20250213    clang-19
i386                  randconfig-004-20250214    gcc-12
i386                  randconfig-005-20250213    clang-19
i386                  randconfig-005-20250214    gcc-12
i386                  randconfig-006-20250213    clang-19
i386                  randconfig-006-20250214    gcc-12
i386                  randconfig-007-20250213    clang-19
i386                  randconfig-007-20250214    gcc-12
i386                  randconfig-011-20250213    gcc-12
i386                  randconfig-011-20250214    clang-19
i386                  randconfig-012-20250213    gcc-12
i386                  randconfig-012-20250214    clang-19
i386                  randconfig-013-20250213    gcc-12
i386                  randconfig-013-20250214    clang-19
i386                  randconfig-014-20250213    gcc-12
i386                  randconfig-014-20250214    clang-19
i386                  randconfig-015-20250213    gcc-12
i386                  randconfig-015-20250214    clang-19
i386                  randconfig-016-20250213    gcc-12
i386                  randconfig-016-20250214    clang-19
i386                  randconfig-017-20250213    gcc-12
i386                  randconfig-017-20250214    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250213    clang-21
loongarch             randconfig-001-20250213    gcc-14.2.0
loongarch             randconfig-001-20250214    clang-21
loongarch             randconfig-002-20250213    clang-21
loongarch             randconfig-002-20250213    gcc-14.2.0
loongarch             randconfig-002-20250214    clang-21
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                          multi_defconfig    clang-15
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    gcc-14.2.0
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250213    clang-21
nios2                 randconfig-001-20250213    gcc-14.2.0
nios2                 randconfig-001-20250214    clang-21
nios2                 randconfig-002-20250213    clang-21
nios2                 randconfig-002-20250213    gcc-14.2.0
nios2                 randconfig-002-20250214    clang-21
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250213    clang-21
parisc                randconfig-001-20250213    gcc-14.2.0
parisc                randconfig-001-20250214    clang-21
parisc                randconfig-002-20250213    clang-21
parisc                randconfig-002-20250213    gcc-14.2.0
parisc                randconfig-002-20250214    clang-21
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 canyonlands_defconfig    clang-15
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250213    clang-17
powerpc               randconfig-001-20250213    clang-21
powerpc               randconfig-001-20250214    clang-21
powerpc               randconfig-002-20250213    clang-21
powerpc               randconfig-002-20250213    gcc-14.2.0
powerpc               randconfig-002-20250214    clang-21
powerpc               randconfig-003-20250213    clang-21
powerpc               randconfig-003-20250213    gcc-14.2.0
powerpc               randconfig-003-20250214    clang-21
powerpc64             randconfig-001-20250213    clang-19
powerpc64             randconfig-001-20250213    clang-21
powerpc64             randconfig-001-20250214    clang-21
powerpc64             randconfig-002-20250213    clang-21
powerpc64             randconfig-002-20250214    clang-21
powerpc64             randconfig-003-20250213    clang-21
powerpc64             randconfig-003-20250213    gcc-14.2.0
powerpc64             randconfig-003-20250214    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250213    clang-19
riscv                 randconfig-001-20250213    clang-21
riscv                 randconfig-002-20250213    clang-17
riscv                 randconfig-002-20250213    clang-21
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250213    clang-21
s390                  randconfig-001-20250213    gcc-14.2.0
s390                  randconfig-002-20250213    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    clang-15
sh                          lboxre2_defconfig    gcc-14.2.0
sh                          r7785rp_defconfig    clang-15
sh                    randconfig-001-20250213    clang-21
sh                    randconfig-001-20250213    gcc-14.2.0
sh                    randconfig-002-20250213    clang-21
sh                    randconfig-002-20250213    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250213    clang-21
sparc                 randconfig-001-20250213    gcc-14.2.0
sparc                 randconfig-002-20250213    clang-21
sparc                 randconfig-002-20250213    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250213    clang-21
sparc64               randconfig-001-20250213    gcc-14.2.0
sparc64               randconfig-002-20250213    clang-21
sparc64               randconfig-002-20250213    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-15
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250213    clang-19
um                    randconfig-001-20250213    clang-21
um                    randconfig-002-20250213    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250213    gcc-11
x86_64      buildonly-randconfig-001-20250213    gcc-12
x86_64      buildonly-randconfig-001-20250214    gcc-12
x86_64      buildonly-randconfig-002-20250213    gcc-12
x86_64      buildonly-randconfig-002-20250214    gcc-12
x86_64      buildonly-randconfig-003-20250213    clang-19
x86_64      buildonly-randconfig-003-20250213    gcc-12
x86_64      buildonly-randconfig-003-20250214    gcc-12
x86_64      buildonly-randconfig-004-20250213    gcc-12
x86_64      buildonly-randconfig-004-20250214    gcc-12
x86_64      buildonly-randconfig-005-20250213    gcc-12
x86_64      buildonly-randconfig-005-20250214    gcc-12
x86_64      buildonly-randconfig-006-20250213    gcc-12
x86_64      buildonly-randconfig-006-20250214    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250213    clang-19
x86_64                randconfig-001-20250214    clang-19
x86_64                randconfig-002-20250213    clang-19
x86_64                randconfig-002-20250214    clang-19
x86_64                randconfig-003-20250213    clang-19
x86_64                randconfig-003-20250214    clang-19
x86_64                randconfig-004-20250213    clang-19
x86_64                randconfig-004-20250214    clang-19
x86_64                randconfig-005-20250213    clang-19
x86_64                randconfig-005-20250214    clang-19
x86_64                randconfig-006-20250213    clang-19
x86_64                randconfig-006-20250214    clang-19
x86_64                randconfig-007-20250213    clang-19
x86_64                randconfig-007-20250214    clang-19
x86_64                randconfig-008-20250213    clang-19
x86_64                randconfig-008-20250214    clang-19
x86_64                randconfig-071-20250213    gcc-12
x86_64                randconfig-072-20250213    gcc-12
x86_64                randconfig-073-20250213    gcc-12
x86_64                randconfig-074-20250213    gcc-12
x86_64                randconfig-075-20250213    gcc-12
x86_64                randconfig-076-20250213    gcc-12
x86_64                randconfig-077-20250213    gcc-12
x86_64                randconfig-078-20250213    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250213    clang-21
xtensa                randconfig-001-20250213    gcc-14.2.0
xtensa                randconfig-002-20250213    clang-21
xtensa                randconfig-002-20250213    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

