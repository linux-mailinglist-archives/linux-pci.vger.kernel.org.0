Return-Path: <linux-pci+bounces-15230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27C9AEF28
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131FC1C21DCE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B321F8196;
	Thu, 24 Oct 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgkmdbP9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB21F76DC
	for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793114; cv=none; b=DqOQVpzYiei6zSslKb6tjpAbX1hwZUCkdrp+pm8E1Jevo9uivQO1FAXmEu9UkzJg6dlYrVbtczmn2nmeoeifg2ZEJTJq5UvHORhTEx6+IdJNyuO22tcbqswenJe0MEv4S6Vv0JiaTCdo1M1YMGTattGVfNn8OX6npRhz9JfTCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793114; c=relaxed/simple;
	bh=zFaNN0kA0O+fRfMoHHPBAI/70f9dW49fMPtL+2bd7O0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s6akhVDsAye/hLfDFm7qsDmyME527dWeBBC6mMtIs6+ivpmjOzRoY0wuj7i6YpO6wQcpTJ6kLOCNHqcvinv95r6YUuo4z70hBQdUyDqll/mUuw/nuZyoHAa1/ihWJkG8TqDwFq3jN5BIIl+L6/0B5BH9MzDWNCmrpBlQn92XNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgkmdbP9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729793112; x=1761329112;
  h=date:from:to:cc:subject:message-id;
  bh=zFaNN0kA0O+fRfMoHHPBAI/70f9dW49fMPtL+2bd7O0=;
  b=RgkmdbP9jj68RJBpA3ADuFmbesnQ1jiONcCL0OkePsHyeUvn9f0uj+Ju
   jP7qual7/EXn65uPYguo+L61S+GE2/RO6nM1E932w019KUlmv7wIxksKl
   wOot4alAUV8TwBzlGKNVtfwVuZEREz5WDihGl2rTyrWr4z3ZP/xRRFc0O
   s6b2lavu8prsAfZn4/ONAOEq5NfFWUwdacUFHTR3C2IwebgojvM7uZCVJ
   TaDwolEZnDoh+b7WQK6g5THRaT87JnS1UTBJ30aATD9lagvxtdSiTRAHI
   GANKH6ESoM6J7FV1F7RlZB+Ndqi7B7oJQX1vRR6gtUhowzS1YJUJPtsmT
   A==;
X-CSE-ConnectionGUID: QPZz471ZSPOTrTJC4kvNnw==
X-CSE-MsgGUID: SoncHMO8TFetfU+/Ym7SyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40839935"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40839935"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 11:05:12 -0700
X-CSE-ConnectionGUID: P/MHh4zCSKCdQuqW3mP2jA==
X-CSE-MsgGUID: Mo3bgOeGTpu52vR1RvIedA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80589192"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 Oct 2024 11:05:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t42Cq-000WpU-10;
	Thu, 24 Oct 2024 18:05:08 +0000
Date: Fri, 25 Oct 2024 02:04:42 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:locking] BUILD SUCCESS
 ab679834c47572542b8f9f42dd0839aace152fae
Message-ID: <202410250234.BPRpytaV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git locking
branch HEAD: ab679834c47572542b8f9f42dd0839aace152fae  PCI: Unexport pci_walk_bus_locked()

elapsed time: 1171m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241024    gcc-14.1.0
arc                   randconfig-002-20241024    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                           omap1_defconfig    gcc-14.1.0
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20241024    gcc-14.1.0
arm                   randconfig-002-20241024    gcc-14.1.0
arm                   randconfig-003-20241024    gcc-14.1.0
arm                   randconfig-004-20241024    gcc-14.1.0
arm                        realview_defconfig    clang-20
arm                           spitz_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    clang-20
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241024    gcc-14.1.0
arm64                 randconfig-002-20241024    gcc-14.1.0
arm64                 randconfig-003-20241024    gcc-14.1.0
arm64                 randconfig-004-20241024    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241024    gcc-14.1.0
csky                  randconfig-002-20241024    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241024    gcc-14.1.0
hexagon               randconfig-002-20241024    gcc-14.1.0
i386                             alldefconfig    clang-20
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241024    clang-19
i386        buildonly-randconfig-002-20241024    clang-19
i386        buildonly-randconfig-003-20241024    clang-19
i386        buildonly-randconfig-004-20241024    clang-19
i386        buildonly-randconfig-005-20241024    clang-19
i386        buildonly-randconfig-006-20241024    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241024    clang-19
i386                  randconfig-002-20241024    clang-19
i386                  randconfig-003-20241024    clang-19
i386                  randconfig-004-20241024    clang-19
i386                  randconfig-005-20241024    clang-19
i386                  randconfig-006-20241024    clang-19
i386                  randconfig-011-20241024    clang-19
i386                  randconfig-012-20241024    clang-19
i386                  randconfig-013-20241024    clang-19
i386                  randconfig-014-20241024    clang-19
i386                  randconfig-015-20241024    clang-19
i386                  randconfig-016-20241024    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241024    gcc-14.1.0
loongarch             randconfig-002-20241024    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    clang-20
m68k                       bvme6000_defconfig    clang-20
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq5_defconfig    gcc-14.1.0
mips                            gpr_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241024    gcc-14.1.0
nios2                 randconfig-002-20241024    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241024    gcc-14.1.0
parisc                randconfig-002-20241024    gcc-14.1.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    clang-20
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       ebony_defconfig    gcc-14.1.0
powerpc                     ep8248e_defconfig    clang-20
powerpc                      ep88xc_defconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    clang-20
powerpc                     mpc83xx_defconfig    clang-20
powerpc               randconfig-001-20241024    gcc-14.1.0
powerpc               randconfig-002-20241024    gcc-14.1.0
powerpc               randconfig-003-20241024    gcc-14.1.0
powerpc                     redwood_defconfig    clang-20
powerpc                     tqm8540_defconfig    gcc-14.1.0
powerpc                     tqm8548_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241024    gcc-14.1.0
powerpc64             randconfig-002-20241024    gcc-14.1.0
powerpc64             randconfig-003-20241024    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241024    gcc-14.1.0
riscv                 randconfig-002-20241024    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241024    gcc-14.1.0
s390                  randconfig-002-20241024    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    clang-20
sh                          r7780mp_defconfig    clang-20
sh                    randconfig-001-20241024    gcc-14.1.0
sh                    randconfig-002-20241024    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                           se7712_defconfig    clang-20
sh                           se7750_defconfig    gcc-14.1.0
sh                             shx3_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241024    gcc-14.1.0
sparc64               randconfig-002-20241024    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241024    gcc-14.1.0
um                    randconfig-002-20241024    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241024    gcc-12
x86_64      buildonly-randconfig-002-20241024    gcc-12
x86_64      buildonly-randconfig-003-20241024    gcc-12
x86_64      buildonly-randconfig-004-20241024    gcc-12
x86_64      buildonly-randconfig-005-20241024    gcc-12
x86_64      buildonly-randconfig-006-20241024    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241024    gcc-12
x86_64                randconfig-002-20241024    gcc-12
x86_64                randconfig-003-20241024    gcc-12
x86_64                randconfig-004-20241024    gcc-12
x86_64                randconfig-005-20241024    gcc-12
x86_64                randconfig-006-20241024    gcc-12
x86_64                randconfig-011-20241024    gcc-12
x86_64                randconfig-012-20241024    gcc-12
x86_64                randconfig-013-20241024    gcc-12
x86_64                randconfig-014-20241024    gcc-12
x86_64                randconfig-015-20241024    gcc-12
x86_64                randconfig-016-20241024    gcc-12
x86_64                randconfig-071-20241024    gcc-12
x86_64                randconfig-072-20241024    gcc-12
x86_64                randconfig-073-20241024    gcc-12
x86_64                randconfig-074-20241024    gcc-12
x86_64                randconfig-075-20241024    gcc-12
x86_64                randconfig-076-20241024    gcc-12
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241024    gcc-14.1.0
xtensa                randconfig-002-20241024    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

