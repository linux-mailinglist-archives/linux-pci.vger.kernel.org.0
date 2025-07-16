Return-Path: <linux-pci+bounces-32258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329AEB07551
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3119E3BBDDF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8DE235072;
	Wed, 16 Jul 2025 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhL8mYo7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B69F221F38
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667757; cv=none; b=LzLvBuRlN0LW0EIr8LDbqX/IpgYku3NhGU9ZvrDz7JiV+plRytFxmZWmPFRaZMeAIvmHX+QAsJBcjOmNqLO/JepE5XksQRngphSwQh/kLLxovdtgHv5VoVMv3bLuCP+ZDfrefqmc/ma4d/ygb90iGU6jyTg3rB7Z7iy/5i8ESv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667757; c=relaxed/simple;
	bh=ojzw/srAMIFbH9Gfejbv+OJ/k8M4PxPZguxbieYLI+g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Lyj5JErY/q4uphKYb/UE+EUSoEslysmJvs9K1+5LMEWp+5zR+q6DXijWspbHuGZrXszWY99hSpUxGfxq5u9+0PP7LjAvsDVhHhVD2X9CtTXT/bfc6CLmXSt96aAKxPDX8wl0x93gCSQef8V67avkcKXhm5gmWW9nbnEfKFZwxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhL8mYo7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752667756; x=1784203756;
  h=date:from:to:cc:subject:message-id;
  bh=ojzw/srAMIFbH9Gfejbv+OJ/k8M4PxPZguxbieYLI+g=;
  b=OhL8mYo7OctN4mKlDL3Zv+kf5UQfA5RQNniofYvlfSsDdOB0ixRliOqC
   DnyBGPbP6RcQTOOXZlCWhC8kYw6Aj8NJiM2aKZjXy0x3D6YrJokSXDqHG
   KriEuUBQTh+AXA3aN8z+JDyCJUM2xrxVuqMoULtIiJattv8/lilaAwzkK
   qQrw7ThQkqJYWSx/eQUQjsd+ZVB+tBeCWp0A/m7dvbZRuTzARugVq3EuH
   skCFpsIiJy8benenG+PHyk28qVx7PlpmZmfIkFMPM30pFynGdk93YioRk
   8RIfukPYAt/Cfs6+Fyz1/xOwNXzC1b/A1aLbDywgaMBpe7Wmm7VKS3ugx
   A==;
X-CSE-ConnectionGUID: dLB+fzloQ6G/2d5C3CrbNg==
X-CSE-MsgGUID: /XaB76gBQA+XjoASmj3u5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65974915"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="65974915"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 05:09:15 -0700
X-CSE-ConnectionGUID: kdnQrTBpSJ+tobHSboLseQ==
X-CSE-MsgGUID: zRjG6O1TQtGC82Lrt/QbsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="161816418"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Jul 2025 05:09:14 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc0wh-000CL5-1y;
	Wed, 16 Jul 2025 12:09:11 +0000
Date: Wed, 16 Jul 2025 20:08:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 399444a87acdea5d21c218bc8e9b621fea1cd218
Message-ID: <202507162014.xTGcCaUd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: 399444a87acdea5d21c218bc8e9b621fea1cd218  PCI: imx6: Add IMX8MM_EP and IMX8MP_EP fixed 256-byte BAR 4 in epc_features

elapsed time: 1103m

configs tested: 223
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
arc                          axs103_defconfig    clang-21
arc                      axs103_smp_defconfig    clang-21
arc                                 defconfig    clang-19
arc                   randconfig-001-20250716    clang-21
arc                   randconfig-001-20250716    gcc-13.4.0
arc                   randconfig-002-20250716    clang-21
arc                   randconfig-002-20250716    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250716    clang-20
arm                   randconfig-001-20250716    clang-21
arm                   randconfig-002-20250716    clang-21
arm                   randconfig-002-20250716    gcc-12.4.0
arm                   randconfig-003-20250716    clang-21
arm                   randconfig-003-20250716    gcc-8.5.0
arm                   randconfig-004-20250716    clang-21
arm                   randconfig-004-20250716    gcc-8.5.0
arm                         s3c6400_defconfig    clang-21
arm64                            alldefconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250716    clang-21
arm64                 randconfig-001-20250716    gcc-9.5.0
arm64                 randconfig-002-20250716    clang-21
arm64                 randconfig-002-20250716    gcc-8.5.0
arm64                 randconfig-003-20250716    clang-21
arm64                 randconfig-003-20250716    gcc-8.5.0
arm64                 randconfig-004-20250716    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250716    gcc-14.3.0
csky                  randconfig-001-20250716    gcc-15.1.0
csky                  randconfig-002-20250716    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250716    clang-21
hexagon               randconfig-001-20250716    gcc-15.1.0
hexagon               randconfig-002-20250716    clang-21
hexagon               randconfig-002-20250716    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-002-20250716    clang-20
i386        buildonly-randconfig-002-20250716    gcc-12
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-004-20250716    gcc-11
i386        buildonly-randconfig-004-20250716    gcc-12
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-006-20250716    clang-20
i386        buildonly-randconfig-006-20250716    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250716    clang-20
i386                  randconfig-002-20250716    clang-20
i386                  randconfig-003-20250716    clang-20
i386                  randconfig-004-20250716    clang-20
i386                  randconfig-005-20250716    clang-20
i386                  randconfig-006-20250716    clang-20
i386                  randconfig-007-20250716    clang-20
i386                  randconfig-011-20250716    gcc-12
i386                  randconfig-012-20250716    gcc-12
i386                  randconfig-013-20250716    gcc-12
i386                  randconfig-014-20250716    gcc-12
i386                  randconfig-015-20250716    gcc-12
i386                  randconfig-016-20250716    gcc-12
i386                  randconfig-017-20250716    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250716    clang-18
loongarch             randconfig-001-20250716    gcc-15.1.0
loongarch             randconfig-002-20250716    clang-21
loongarch             randconfig-002-20250716    gcc-15.1.0
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
nios2                 randconfig-001-20250716    gcc-14.2.0
nios2                 randconfig-001-20250716    gcc-15.1.0
nios2                 randconfig-002-20250716    gcc-11.5.0
nios2                 randconfig-002-20250716    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250716    gcc-15.1.0
parisc                randconfig-001-20250716    gcc-8.5.0
parisc                randconfig-002-20250716    gcc-15.1.0
parisc                randconfig-002-20250716    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-21
powerpc               randconfig-001-20250716    gcc-15.1.0
powerpc               randconfig-001-20250716    gcc-8.5.0
powerpc               randconfig-002-20250716    clang-21
powerpc               randconfig-002-20250716    gcc-15.1.0
powerpc               randconfig-003-20250716    gcc-14.3.0
powerpc               randconfig-003-20250716    gcc-15.1.0
powerpc64             randconfig-001-20250716    gcc-10.5.0
powerpc64             randconfig-001-20250716    gcc-15.1.0
powerpc64             randconfig-003-20250716    gcc-13.4.0
powerpc64             randconfig-003-20250716    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250716    gcc-8.5.0
riscv                 randconfig-001-20250716    gcc-9.3.0
riscv                 randconfig-002-20250716    gcc-11.5.0
riscv                 randconfig-002-20250716    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250716    gcc-11.5.0
s390                  randconfig-001-20250716    gcc-9.3.0
s390                  randconfig-002-20250716    gcc-11.5.0
s390                  randconfig-002-20250716    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    clang-21
sh                    randconfig-001-20250716    gcc-15.1.0
sh                    randconfig-001-20250716    gcc-9.3.0
sh                    randconfig-002-20250716    gcc-14.3.0
sh                    randconfig-002-20250716    gcc-9.3.0
sh                  sh7785lcr_32bit_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250716    gcc-8.5.0
sparc                 randconfig-001-20250716    gcc-9.3.0
sparc                 randconfig-002-20250716    gcc-14.3.0
sparc                 randconfig-002-20250716    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250716    clang-20
sparc64               randconfig-001-20250716    gcc-9.3.0
sparc64               randconfig-002-20250716    clang-21
sparc64               randconfig-002-20250716    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250716    gcc-11
um                    randconfig-001-20250716    gcc-9.3.0
um                    randconfig-002-20250716    gcc-12
um                    randconfig-002-20250716    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250716    clang-20
x86_64      buildonly-randconfig-001-20250716    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-006-20250716    clang-20
x86_64      buildonly-randconfig-006-20250716    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250716    clang-20
x86_64                randconfig-002-20250716    clang-20
x86_64                randconfig-003-20250716    clang-20
x86_64                randconfig-004-20250716    clang-20
x86_64                randconfig-005-20250716    clang-20
x86_64                randconfig-006-20250716    clang-20
x86_64                randconfig-007-20250716    clang-20
x86_64                randconfig-008-20250716    clang-20
x86_64                randconfig-071-20250716    gcc-12
x86_64                randconfig-072-20250716    gcc-12
x86_64                randconfig-073-20250716    gcc-12
x86_64                randconfig-074-20250716    gcc-12
x86_64                randconfig-075-20250716    gcc-12
x86_64                randconfig-076-20250716    gcc-12
x86_64                randconfig-077-20250716    gcc-12
x86_64                randconfig-078-20250716    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250716    gcc-13.4.0
xtensa                randconfig-002-20250716    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

