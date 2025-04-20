Return-Path: <linux-pci+bounces-26313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BE8A948D1
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 20:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3384B18914D8
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 18:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446A1A5B93;
	Sun, 20 Apr 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkaaXfeM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F8F510
	for <linux-pci@vger.kernel.org>; Sun, 20 Apr 2025 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745173532; cv=none; b=aO94/jJT/wl1hxOcjA6WKe4b0JZR3kZYg6yI/jLW4rt+exvfEc1/gT0rAhBGDrU6VgCbu0ZrNNifVs1dk94gZSGuFqgfvpi7a6tylYKMPnSnJ+gP47uZLha10d3j3QsFlLItNFp/4HphTqUfJJsJEgwsg0qZhQpqCyb6zfokrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745173532; c=relaxed/simple;
	bh=RTYTi2YqjCjDaHYRV2n9yu2DC0Gqxm3a1mWg4d7SkzM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tOYkk4nZ+g+62lV+E3kFoq9gFhjKPol28QDrjg9GhP9a5pacKwWemAtUNOTrRekRX83954Xg1/0l05ripeUa6lkNlZxp/vV4XRIrUPRTae+PUp3NE18c+cE0ah/Yuw00A2vzFA7bjwk9/QCV9SeUufFxa4v+SZtFdKT1GloQgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkaaXfeM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745173529; x=1776709529;
  h=date:from:to:cc:subject:message-id;
  bh=RTYTi2YqjCjDaHYRV2n9yu2DC0Gqxm3a1mWg4d7SkzM=;
  b=OkaaXfeMj1uKssQgOBvaUL/EIkEnL+lgfljyE7Z5p5nc9/Kl1MSQ00Jr
   wuBEg9S3gSjJWzL8vlmODKmbvzJSX3DgkSkmiEWqG1318KRUjxGermZz1
   RyXXG10bdz/wBW3v6lZhrGmIkwETtqG0EYJq5ndmnRp/SHnx+IcHUx9bx
   ws86M7k0POrsGBKsLxgaSSpJemX17tqbdSM1nbKVIaPbdvVOaLT8TirYk
   N1WQADxls3720qIuiVNg076V6tcz7Kb/ZRaKqMwOoie+ZTL1lewGBqSN9
   n2+MmcEwskZp0B9jmzYd1aHDrsSaGXaTal8Nb+c1/SidYtMvgkhLQiDbs
   g==;
X-CSE-ConnectionGUID: 5Z/ojRMaSwW/4ZCnGXqaLw==
X-CSE-MsgGUID: XaECFXFRTCyW5P66PT5XOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="50516276"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="50516276"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 11:25:29 -0700
X-CSE-ConnectionGUID: eksQ1i7xR3uGMVfeqKl3dg==
X-CSE-MsgGUID: OrPMx1T7RPCI7m3LlkQdPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="162497250"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Apr 2025 11:25:27 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6ZM5-0004qb-24;
	Sun, 20 Apr 2025 18:25:25 +0000
Date: Mon, 21 Apr 2025 02:24:40 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cadence] BUILD SUCCESS
 f8015b6a0db95ce09aaacb236746f33b7a540a3e
Message-ID: <202504210230.DdSNwlZT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cadence
branch HEAD: f8015b6a0db95ce09aaacb236746f33b7a540a3e  PCI: cadence: Fix runtime atomic count underflow.

elapsed time: 1443m

configs tested: 235
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250420    gcc-12.4.0
arc                   randconfig-002-20250420    gcc-12.4.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-21
arm                        keystone_defconfig    gcc-14.2.0
arm                   randconfig-001-20250420    clang-21
arm                   randconfig-002-20250420    gcc-8.5.0
arm                   randconfig-003-20250420    gcc-7.5.0
arm                   randconfig-004-20250420    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250420    gcc-8.5.0
arm64                 randconfig-002-20250420    gcc-8.5.0
arm64                 randconfig-003-20250420    clang-21
arm64                 randconfig-004-20250420    gcc-6.5.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-002-20250420    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250420    clang-20
i386        buildonly-randconfig-002-20250420    clang-20
i386        buildonly-randconfig-003-20250420    clang-20
i386        buildonly-randconfig-004-20250420    clang-20
i386        buildonly-randconfig-005-20250420    clang-20
i386        buildonly-randconfig-006-20250420    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250420    gcc-12
i386                  randconfig-001-20250421    gcc-12
i386                  randconfig-002-20250420    gcc-12
i386                  randconfig-002-20250421    gcc-12
i386                  randconfig-003-20250420    gcc-12
i386                  randconfig-003-20250421    gcc-12
i386                  randconfig-004-20250420    gcc-12
i386                  randconfig-004-20250421    gcc-12
i386                  randconfig-005-20250420    gcc-12
i386                  randconfig-005-20250421    gcc-12
i386                  randconfig-006-20250420    gcc-12
i386                  randconfig-006-20250421    gcc-12
i386                  randconfig-007-20250420    gcc-12
i386                  randconfig-007-20250421    gcc-12
i386                  randconfig-011-20250420    gcc-12
i386                  randconfig-011-20250421    clang-20
i386                  randconfig-012-20250420    gcc-12
i386                  randconfig-012-20250421    clang-20
i386                  randconfig-013-20250420    gcc-12
i386                  randconfig-013-20250421    clang-20
i386                  randconfig-014-20250420    gcc-12
i386                  randconfig-014-20250421    clang-20
i386                  randconfig-015-20250420    gcc-12
i386                  randconfig-015-20250421    clang-20
i386                  randconfig-016-20250420    gcc-12
i386                  randconfig-016-20250421    clang-20
i386                  randconfig-017-20250420    gcc-12
i386                  randconfig-017-20250421    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250420    gcc-12.4.0
loongarch             randconfig-002-20250420    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                           ip32_defconfig    clang-21
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250420    gcc-14.2.0
nios2                 randconfig-002-20250420    gcc-8.5.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250420    gcc-13.3.0
parisc                randconfig-002-20250420    gcc-7.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-21
powerpc                       holly_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc               randconfig-002-20250420    gcc-6.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    clang-21
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250420    clang-21
riscv                 randconfig-002-20250420    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250420    gcc-6.5.0
s390                  randconfig-002-20250420    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250420    gcc-14.2.0
sh                    randconfig-002-20250420    gcc-14.2.0
sh                           se7206_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250420    gcc-11.5.0
sparc                 randconfig-002-20250420    gcc-7.5.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250420    gcc-9.3.0
sparc64               randconfig-002-20250420    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250420    gcc-12
um                    randconfig-002-20250420    clang-21
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250420    clang-20
x86_64      buildonly-randconfig-002-20250420    gcc-12
x86_64      buildonly-randconfig-003-20250420    gcc-12
x86_64      buildonly-randconfig-004-20250420    gcc-12
x86_64      buildonly-randconfig-005-20250420    clang-20
x86_64      buildonly-randconfig-006-20250420    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250420    gcc-12
x86_64                randconfig-001-20250421    clang-20
x86_64                randconfig-002-20250420    gcc-12
x86_64                randconfig-002-20250421    clang-20
x86_64                randconfig-003-20250420    gcc-12
x86_64                randconfig-003-20250421    clang-20
x86_64                randconfig-004-20250420    gcc-12
x86_64                randconfig-004-20250421    clang-20
x86_64                randconfig-005-20250420    gcc-12
x86_64                randconfig-005-20250421    clang-20
x86_64                randconfig-006-20250420    gcc-12
x86_64                randconfig-006-20250421    clang-20
x86_64                randconfig-007-20250420    gcc-12
x86_64                randconfig-007-20250421    clang-20
x86_64                randconfig-008-20250420    gcc-12
x86_64                randconfig-008-20250421    clang-20
x86_64                randconfig-071-20250420    clang-20
x86_64                randconfig-071-20250421    gcc-12
x86_64                randconfig-072-20250420    clang-20
x86_64                randconfig-072-20250421    gcc-12
x86_64                randconfig-073-20250420    clang-20
x86_64                randconfig-073-20250421    gcc-12
x86_64                randconfig-074-20250420    clang-20
x86_64                randconfig-074-20250421    gcc-12
x86_64                randconfig-075-20250420    clang-20
x86_64                randconfig-075-20250421    gcc-12
x86_64                randconfig-076-20250420    clang-20
x86_64                randconfig-076-20250421    gcc-12
x86_64                randconfig-077-20250420    clang-20
x86_64                randconfig-077-20250421    gcc-12
x86_64                randconfig-078-20250420    clang-20
x86_64                randconfig-078-20250421    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250420    gcc-9.3.0
xtensa                randconfig-002-20250420    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

