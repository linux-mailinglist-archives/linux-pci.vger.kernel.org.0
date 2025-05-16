Return-Path: <linux-pci+bounces-27875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0D7ABA100
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA00E16D69A
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299AA2CCC1;
	Fri, 16 May 2025 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gw+0rfgE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF3224F6
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414089; cv=none; b=uijGPaYsG1AQSfvLmWsHSnasxK0Zhu7U4ECwe0EZYQpYpiTF5IkgEAQhuPGx2cZLkk1Tc/FRmnnEBR7aBDhj77zUpoh4SQNXVZD9NL4g9kt5LQgTSA/Ghi+eaqYMNo3YKec5hwA/NlZQ+KuG7BiNyX5aTj9o0vrztOoDRAfVKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414089; c=relaxed/simple;
	bh=Z3xzjPhwumDOSy9spGc6hdt3+RBotBFQTGnQCVMOhqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=T+egUZWUcH7V2lLzlVH3Mo4qU72kihXLJN1nRE/FVJJ1L9HdGAJLv3HydYXph4GGTZ6R42ipFyskMc+AMnEvE8o58rhuE9GBJOLne2Uebga25whMLbFOp/8pIqBleTjRg6QV5p0NBL1G8F4mD3kiCZthGmkk1lLBUvXF+45d0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gw+0rfgE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747414087; x=1778950087;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z3xzjPhwumDOSy9spGc6hdt3+RBotBFQTGnQCVMOhqQ=;
  b=Gw+0rfgE5gCnjYtz0aBeRjnNR3BdGSk7EjlMwAQ7voH0VkClH77SGhuE
   YpsKep8DFhuwglXw1XXHuyXJdl6va7RxNOmjX3Y0TtZBKybdXyGVQ+1hX
   4aPJMmwHqccHuLrGbyZA1/qeQZmFtAaDeTiLvjFOmvfmwjSBnIGDpiSGU
   W7lEyrUqj/aPQK7dHt46g68/FMBnxorMeCIpIu0v7wuFgFXiA4y9JwAWx
   2MTN5eK6CoBBm1XdX/vf/u06h6FzfL9iB9XSWIIPSrJEHXBVoE6/eoS57
   zSSb/zZ2BC/gIzDUxzOogE69Bu2mnOQiia26HNbVKK89OVMwQNcEwKwJE
   g==;
X-CSE-ConnectionGUID: LsD6s123TfaIPYNFHjMBSg==
X-CSE-MsgGUID: MInZDtfwTr2eynOsK4Gp+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49268135"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49268135"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 09:48:06 -0700
X-CSE-ConnectionGUID: QyU+TbQOSU++b7tC8G62uA==
X-CSE-MsgGUID: ur0TLRNdT6uxX2QVj/uGvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="143862443"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 May 2025 09:48:06 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFyE7-000JXI-1y;
	Fri, 16 May 2025 16:48:03 +0000
Date: Sat, 17 May 2025 00:47:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:bwctrl] BUILD SUCCESS
 6ade6e81f898f7f533207b23849ac8cc0ea8c755
Message-ID: <202505170005.2rmTRT6N-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
branch HEAD: 6ade6e81f898f7f533207b23849ac8cc0ea8c755  PCI: Update Link Speed after retraining

elapsed time: 1443m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250516    gcc-13.3.0
arc                   randconfig-002-20250516    gcc-13.3.0
arm                               allnoconfig    clang-21
arm                          gemini_defconfig    clang-20
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250516    gcc-7.5.0
arm                   randconfig-002-20250516    clang-21
arm                   randconfig-003-20250516    clang-21
arm                   randconfig-004-20250516    clang-21
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250516    gcc-9.5.0
arm64                 randconfig-002-20250516    gcc-9.5.0
arm64                 randconfig-003-20250516    gcc-5.5.0
arm64                 randconfig-004-20250516    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250516    gcc-14.2.0
csky                  randconfig-002-20250516    gcc-14.2.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250516    clang-19
hexagon               randconfig-002-20250516    clang-21
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250516    clang-20
i386        buildonly-randconfig-002-20250516    gcc-12
i386        buildonly-randconfig-003-20250516    clang-20
i386        buildonly-randconfig-004-20250516    clang-20
i386        buildonly-randconfig-005-20250516    clang-20
i386        buildonly-randconfig-006-20250516    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250516    gcc-14.2.0
loongarch             randconfig-002-20250516    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250516    gcc-13.3.0
nios2                 randconfig-002-20250516    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250516    gcc-10.5.0
parisc                randconfig-002-20250516    gcc-12.4.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250516    gcc-5.5.0
powerpc               randconfig-002-20250516    gcc-5.5.0
powerpc               randconfig-003-20250516    clang-17
powerpc                     sequoia_defconfig    clang-17
powerpc                     skiroot_defconfig    clang-21
powerpc64             randconfig-001-20250516    clang-21
powerpc64             randconfig-002-20250516    clang-21
powerpc64             randconfig-003-20250516    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250516    gcc-7.5.0
riscv                 randconfig-002-20250516    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250516    gcc-7.5.0
s390                  randconfig-002-20250516    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250516    gcc-7.5.0
sh                    randconfig-002-20250516    gcc-9.3.0
sh                            shmin_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250516    gcc-8.5.0
sparc                 randconfig-002-20250516    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64               randconfig-001-20250516    gcc-12.4.0
sparc64               randconfig-002-20250516    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250516    clang-21
um                    randconfig-002-20250516    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250516    clang-20
x86_64      buildonly-randconfig-002-20250516    gcc-12
x86_64      buildonly-randconfig-003-20250516    clang-20
x86_64      buildonly-randconfig-004-20250516    clang-20
x86_64      buildonly-randconfig-005-20250516    gcc-12
x86_64      buildonly-randconfig-006-20250516    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250516    gcc-10.5.0
xtensa                randconfig-002-20250516    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

