Return-Path: <linux-pci+bounces-40651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C4C43F23
	for <lists+linux-pci@lfdr.de>; Sun, 09 Nov 2025 14:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA883188C0E6
	for <lists+linux-pci@lfdr.de>; Sun,  9 Nov 2025 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F502E7BC9;
	Sun,  9 Nov 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3+nydoK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2026E715
	for <linux-pci@vger.kernel.org>; Sun,  9 Nov 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695771; cv=none; b=rh04koi6/g9/0aejGBwOFOOVjf4gGq9/yh3Vl3peQzLkqdETjdNQlftIaN4qjEdbSwa7oZ9lJzrpCaRWzVQESnIqbpE6ftCBIRiRH3VzrYsu28XyILQa7kzsoksKxZKc+vcwhYMTuAxVsbF2XsLUidVbIUS7dNtR92CiD5qCX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695771; c=relaxed/simple;
	bh=vdiRyUz2JP7aiCsI5Ie3p4Ld411xX9iSGnk2FgYYWuQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Kt3CY4T+u7PfFR4m9t6F1JaEew0zU2TYPNtf8ZyY0Am7Y7vRAH9U4ek8YtbCDqrxB/KV7GMdCXJixqAoJgXv5mR798p0KKzL8wRvoPKHNalGMmitBmfGxtEuHksqsbzuLrrhj3++UtwKmrCE7LaS+PW0j95QoU4s8IQ5VVgkd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3+nydoK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762695770; x=1794231770;
  h=date:from:to:cc:subject:message-id;
  bh=vdiRyUz2JP7aiCsI5Ie3p4Ld411xX9iSGnk2FgYYWuQ=;
  b=M3+nydoKxt/cwK/qqql9T+Mf5eT6/HeThhSQjnuUHX8KcHhVMKeshB/A
   VSgdlyjtInbrByQAYmebTsgCTk6TW2MkwnCoifdNfhdyizUUtm81gPI+Z
   OOb4owKSQbgm2m6cdqSZcnKm4NFuhQgLaYRqNwUUeEhO+WW4G+SR3hP6B
   25wxEpYFbQmHzcwlLpcLgSy0wIE+12q9ryeFSi/cn+3z5yiilM+6tKUyc
   K45+/f5sRwRiuG+TWVSiuYCOb78QDKDivWCIBgy3h8AISg0pEHaCtWaB3
   vkqpPv46WgVVZ6DIwc7di66u79EK5sFLsM1zUS7qekNONnO8AFE2dNFPy
   Q==;
X-CSE-ConnectionGUID: XkTXFucGS7yBADAlK/FC8A==
X-CSE-MsgGUID: 3Vm26Ox0QsKGXdZFinKS3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64469914"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="64469914"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 05:42:50 -0800
X-CSE-ConnectionGUID: QQKJa9E8R228iVLkys27gQ==
X-CSE-MsgGUID: 8cM+XAQ/RtOXbssn6ByOeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188413415"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Nov 2025 05:42:49 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI5gs-00022V-2q;
	Sun, 09 Nov 2025 13:42:46 +0000
Date: Sun, 09 Nov 2025 21:41:54 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 e8fe6b3413a1b92b4bc0f0182ea4b49ee369541b
Message-ID: <202511092149.c2x4BBln-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: e8fe6b3413a1b92b4bc0f0182ea4b49ee369541b  PCI: dwc: Check for the device presence during suspend and resume

elapsed time: 1614m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251109    gcc-12.5.0
arc                   randconfig-002-20251109    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20251109    clang-16
arm                   randconfig-002-20251109    clang-22
arm                   randconfig-003-20251109    clang-22
arm                   randconfig-004-20251109    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251109    gcc-15.1.0
arm64                 randconfig-002-20251109    gcc-12.5.0
arm64                 randconfig-003-20251109    clang-19
arm64                 randconfig-004-20251109    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251109    gcc-14.3.0
csky                  randconfig-002-20251109    gcc-11.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251108    clang-22
hexagon               randconfig-002-20251108    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251109    gcc-14
i386        buildonly-randconfig-002-20251109    gcc-13
i386        buildonly-randconfig-003-20251109    clang-20
i386        buildonly-randconfig-004-20251109    clang-20
i386                                defconfig    clang-20
i386                  randconfig-002-20251109    gcc-14
i386                  randconfig-003-20251109    clang-20
i386                  randconfig-004-20251109    clang-20
i386                  randconfig-005-20251109    gcc-14
i386                  randconfig-011-20251109    clang-20
i386                  randconfig-012-20251109    clang-20
i386                  randconfig-013-20251109    gcc-14
i386                  randconfig-014-20251109    gcc-14
i386                  randconfig-015-20251109    gcc-12
i386                  randconfig-016-20251109    gcc-14
i386                  randconfig-017-20251109    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251108    gcc-12.5.0
loongarch             randconfig-002-20251108    gcc-12.5.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251108    gcc-8.5.0
nios2                 randconfig-002-20251108    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251109    gcc-9.5.0
parisc                randconfig-002-20251109    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251109    clang-22
powerpc               randconfig-002-20251109    clang-22
powerpc                     redwood_defconfig    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251109    gcc-8.5.0
powerpc64             randconfig-002-20251109    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
s390                              allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251109    gcc-8.5.0
sparc                 randconfig-002-20251109    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251109    gcc-8.5.0
sparc64               randconfig-002-20251109    gcc-14.3.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251109    gcc-13
um                    randconfig-002-20251109    clang-17
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251109    clang-20
x86_64      buildonly-randconfig-002-20251109    gcc-14
x86_64      buildonly-randconfig-003-20251109    clang-20
x86_64      buildonly-randconfig-004-20251109    clang-20
x86_64      buildonly-randconfig-005-20251109    clang-20
x86_64      buildonly-randconfig-006-20251109    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251109    clang-20
x86_64                randconfig-002-20251109    clang-20
x86_64                randconfig-003-20251109    gcc-14
x86_64                randconfig-004-20251109    gcc-14
x86_64                randconfig-005-20251109    gcc-14
x86_64                randconfig-006-20251109    clang-20
x86_64                randconfig-011-20251109    gcc-14
x86_64                randconfig-012-20251109    clang-20
x86_64                randconfig-013-20251109    gcc-14
x86_64                randconfig-014-20251109    clang-20
x86_64                randconfig-015-20251109    clang-20
x86_64                randconfig-016-20251109    clang-20
x86_64                randconfig-071-20251109    clang-20
x86_64                randconfig-072-20251109    clang-20
x86_64                randconfig-073-20251109    gcc-14
x86_64                randconfig-074-20251109    clang-20
x86_64                randconfig-075-20251109    gcc-14
x86_64                randconfig-076-20251109    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251109    gcc-13.4.0
xtensa                randconfig-002-20251109    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

