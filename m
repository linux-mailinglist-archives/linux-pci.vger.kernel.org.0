Return-Path: <linux-pci+bounces-40984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D967C5222E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 12:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E411888B80
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FF813C3F2;
	Wed, 12 Nov 2025 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOCcR1BZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71427AC3A
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948434; cv=none; b=kdRJmPcwvMvEBMPJUWg3IUOGdI+vltZF99H+zKhp0ZJule61gF7rEqln9jR3AO7M5n4mfd64KtIwyJub+GM+hhEUpPei7QycatED+X+nGQ4ha+uXDgny+K+gKTEbDkG+cpqt3x2deyNH0oA89ZdK0Z+ZcLcP6Timbz5AlICUFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948434; c=relaxed/simple;
	bh=gjW0Mv9oQoGs55li9qc/3JUpClYrMm8ejwx4p2BazAY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fuJ3oTT+pIk1LZzXoDHLsbaMPFL1CweEYk7yzIDMQAF+Qt86YqxGdKIO1rd6ylRGCdGcIX1zZiC1N+rbfhNF7H/3VCLKQBL7tXls9KESsUWAoHAqB/66d4opuRwGF7YuZjHLU6s3QCa1PoT4NqrbqV3mIbHIVd49Bx7IOlUFmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOCcR1BZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762948432; x=1794484432;
  h=date:from:to:cc:subject:message-id;
  bh=gjW0Mv9oQoGs55li9qc/3JUpClYrMm8ejwx4p2BazAY=;
  b=lOCcR1BZg9/dxXrMZsP075oULI1f2DkqDxse+lCkdkNQ2QyqzNOMHhXM
   y4jnISPPBwgWNpLUOOvg9RizidGCGmmG1v4e4SY+XwKIwc9pbWJApHRZo
   Zr3sMEG0HQaPS6mYEQOvDiAUAgs8YsXA6f4wGk9rLFz4X39Dt0Obxuotx
   6aCmEOZs8hTchKy20LbL/MhRnFf6i9/2kIrfieE/wXNy47dPu0w03N5dG
   itVNS0w+jmf2SNtE0tiFiIaS6slspFMXTPNlo40jc4xPE3YDsgk2zBK8S
   tY1yy9G9Yz0Anw77m6/blhzFYizzqy6REjBzCj/o9NeWz9qeyfsvTzjjO
   w==;
X-CSE-ConnectionGUID: Jya6oqzyRAOqTZ5ffIUd5A==
X-CSE-MsgGUID: rXzOt78QTa2rKKdj7WoQqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64933786"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64933786"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 03:53:50 -0800
X-CSE-ConnectionGUID: LYSNF7p3RoOjkA2MDhtx1A==
X-CSE-MsgGUID: pcGXw4/NTbaE1nOaVdKUOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189051066"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 12 Nov 2025 03:53:49 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJ9Q3-0004CN-02;
	Wed, 12 Nov 2025 11:53:47 +0000
Date: Wed, 12 Nov 2025 19:53:18 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 0865c5946ff2b6c83a161288ba2b9d3d090d9e0d
Message-ID: <202511121913.AFTbT68c-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: 0865c5946ff2b6c83a161288ba2b9d3d090d9e0d  PCI: dwc: Check for the device presence during suspend and resume

elapsed time: 1477m

configs tested: 104
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251112    gcc-8.5.0
arc                   randconfig-002-20251112    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                         bcm2835_defconfig    clang-22
arm                   randconfig-001-20251112    gcc-8.5.0
arm                   randconfig-002-20251112    clang-22
arm                   randconfig-003-20251112    clang-22
arm                   randconfig-004-20251112    gcc-14.3.0
arm64                             allnoconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251112    clang-16
hexagon               randconfig-002-20251112    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251112    clang-20
i386        buildonly-randconfig-002-20251112    gcc-14
i386        buildonly-randconfig-003-20251112    clang-20
i386        buildonly-randconfig-004-20251112    clang-20
i386        buildonly-randconfig-005-20251112    gcc-13
i386        buildonly-randconfig-006-20251112    clang-20
i386                  randconfig-001-20251112    gcc-14
i386                  randconfig-002-20251112    gcc-14
i386                  randconfig-003-20251112    gcc-14
i386                  randconfig-004-20251112    clang-20
i386                  randconfig-005-20251112    clang-20
i386                  randconfig-006-20251112    clang-20
i386                  randconfig-007-20251112    gcc-13
i386                  randconfig-011-20251112    gcc-14
i386                  randconfig-012-20251112    gcc-14
i386                  randconfig-013-20251112    clang-20
i386                  randconfig-014-20251112    clang-20
i386                  randconfig-015-20251112    clang-20
i386                  randconfig-016-20251112    gcc-14
i386                  randconfig-017-20251112    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251112    gcc-15.1.0
loongarch             randconfig-002-20251112    gcc-13.4.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5275evb_defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip27_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251112    gcc-11.5.0
nios2                 randconfig-002-20251112    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251112    gcc-9.5.0
parisc                randconfig-002-20251112    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251112    clang-22
powerpc               randconfig-002-20251112    clang-22
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20251112    clang-22
powerpc64             randconfig-002-20251112    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251112    gcc-8.5.0
sparc                 randconfig-002-20251112    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251112    gcc-8.5.0
sparc64               randconfig-002-20251112    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251112    gcc-14
um                    randconfig-002-20251112    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           alldefconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251112    clang-20
x86_64      buildonly-randconfig-002-20251112    clang-20
x86_64      buildonly-randconfig-003-20251112    clang-20
x86_64      buildonly-randconfig-004-20251112    clang-20
x86_64      buildonly-randconfig-005-20251112    gcc-14
x86_64      buildonly-randconfig-006-20251112    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251112    clang-20
x86_64                randconfig-012-20251112    gcc-14
x86_64                randconfig-013-20251112    gcc-14
x86_64                randconfig-014-20251112    clang-20
x86_64                randconfig-015-20251112    clang-20
x86_64                randconfig-016-20251112    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251112    gcc-12.5.0
xtensa                randconfig-002-20251112    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

