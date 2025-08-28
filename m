Return-Path: <linux-pci+bounces-34969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B2B39439
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 08:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F6D170506
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 06:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA47222575;
	Thu, 28 Aug 2025 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pz0P0XrV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFA272E75
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363867; cv=none; b=RVd9hGiAjj8zuR3kvcdpudknRODiijarrpqRFBSEAJxc5pvYzZ8q7UinhovArma3tr0YPQmUjbGkFOgeIxy9SMrCdSxGSqZsO/v3FJzUo1RUAbuBkiu6qGYHA7ZOVvLu5TT/8dtsKyXYiI+TUX27dl8fPIDW7jqzudIGF9mwXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363867; c=relaxed/simple;
	bh=5kcDbJnsJSzIvNbk4EkjlgPoqINJV3aCAo7UkT7WVM8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gjnS6+BO6DXoOFLRANb3/1X5J3jU5zRJJXPvR1IwPY0fB1nZYdEcA148M+P4OVsst4NFOBrLTxjKAo9oo2oMMZy80qNeZF3cmwPVCZA3tjMbgqnp2Wv5ueghq4lAm/Tyx3QbPZ6nukcxdYwmsbHU9KHQZzlckDpKWeOE4MEFGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pz0P0XrV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756363866; x=1787899866;
  h=date:from:to:cc:subject:message-id;
  bh=5kcDbJnsJSzIvNbk4EkjlgPoqINJV3aCAo7UkT7WVM8=;
  b=Pz0P0XrVIEwxbLtiSarRdK3r4UjXECXYBrBWYctmvirsip50aRZLJGg5
   BPSZod3KcfuEeZcIV13A7oos4hxjml3M6SHKBuy7vfzahFEO+qaXXJKSY
   a2/uVQAT3O/7k/bX1wt71nsviCLhaRV9VaGNumJ7Eoq1TNADtSthDSmuB
   ARu94KHD/CUm+buNthy+fx86hTqMEgcuEpPQl6yl6ovCXP6TT3kyE7IkG
   l4kxf94VtwYkxVuY5mBKxvZu9ZXt0Pbh10ymSUe8oRlg4QAWdO5Ftaswb
   bXNcgRlKyjP55aiMCElG4iZ0Z1ROLjLRv8O9nMJjtGIUPDtmgOhqzdHH8
   g==;
X-CSE-ConnectionGUID: jjwoEwivSEi5SCsydDAadA==
X-CSE-MsgGUID: yV2riDnvQt+pNMqJjmAGHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58689009"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58689009"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:51:05 -0700
X-CSE-ConnectionGUID: vwTC0qfkTHywtIOC6ix9hQ==
X-CSE-MsgGUID: ybtRK7GsSTqmDeL2wnW8fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169277098"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Aug 2025 23:51:05 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urWTG-000TSV-1C;
	Thu, 28 Aug 2025 06:50:58 +0000
Date: Thu, 28 Aug 2025 14:50:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2508-david-aspm-api] BUILD SUCCESS
 27831c62945ca9226d030b1f05df26994a57b52c
Message-ID: <202508281417.HXNHIXQ1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2508-david-aspm-api
branch HEAD: 27831c62945ca9226d030b1f05df26994a57b52c  PCI: vmd: Use pci_host_set_default_link_state() to set ASPM defaults

elapsed time: 955m

configs tested: 239
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
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
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250827    gcc-12.5.0
arc                   randconfig-001-20250828    clang-22
arc                   randconfig-002-20250827    gcc-8.5.0
arc                   randconfig-002-20250828    clang-22
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          pxa168_defconfig    gcc-15.1.0
arm                   randconfig-001-20250827    clang-22
arm                   randconfig-001-20250828    clang-22
arm                   randconfig-002-20250827    clang-22
arm                   randconfig-002-20250828    clang-22
arm                   randconfig-003-20250827    clang-22
arm                   randconfig-003-20250828    clang-22
arm                   randconfig-004-20250827    clang-22
arm                   randconfig-004-20250828    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250827    gcc-11.5.0
arm64                 randconfig-001-20250828    clang-22
arm64                 randconfig-002-20250827    gcc-8.5.0
arm64                 randconfig-002-20250828    clang-22
arm64                 randconfig-003-20250827    clang-22
arm64                 randconfig-003-20250828    clang-22
arm64                 randconfig-004-20250827    gcc-9.5.0
arm64                 randconfig-004-20250828    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250827    gcc-10.5.0
csky                  randconfig-001-20250828    clang-22
csky                  randconfig-002-20250827    gcc-15.1.0
csky                  randconfig-002-20250828    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250827    clang-22
hexagon               randconfig-001-20250828    clang-22
hexagon               randconfig-002-20250827    clang-22
hexagon               randconfig-002-20250828    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250827    clang-20
i386        buildonly-randconfig-002-20250827    clang-20
i386        buildonly-randconfig-003-20250827    clang-20
i386        buildonly-randconfig-004-20250827    clang-20
i386        buildonly-randconfig-005-20250827    clang-20
i386        buildonly-randconfig-006-20250827    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250828    gcc-12
i386                  randconfig-002-20250828    gcc-12
i386                  randconfig-003-20250828    gcc-12
i386                  randconfig-004-20250828    gcc-12
i386                  randconfig-005-20250828    gcc-12
i386                  randconfig-006-20250828    gcc-12
i386                  randconfig-007-20250828    gcc-12
i386                  randconfig-011-20250828    clang-20
i386                  randconfig-012-20250828    clang-20
i386                  randconfig-013-20250828    clang-20
i386                  randconfig-014-20250828    clang-20
i386                  randconfig-015-20250828    clang-20
i386                  randconfig-016-20250828    clang-20
i386                  randconfig-017-20250828    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250827    gcc-15.1.0
loongarch             randconfig-001-20250828    clang-22
loongarch             randconfig-002-20250827    clang-22
loongarch             randconfig-002-20250828    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ci20_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250827    gcc-8.5.0
nios2                 randconfig-001-20250828    clang-22
nios2                 randconfig-002-20250827    gcc-11.5.0
nios2                 randconfig-002-20250828    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250827    gcc-12.5.0
parisc                randconfig-001-20250828    clang-22
parisc                randconfig-002-20250827    gcc-8.5.0
parisc                randconfig-002-20250828    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250827    clang-22
powerpc               randconfig-001-20250828    clang-22
powerpc               randconfig-002-20250827    clang-22
powerpc               randconfig-002-20250828    clang-22
powerpc               randconfig-003-20250827    clang-22
powerpc               randconfig-003-20250828    clang-22
powerpc64             randconfig-001-20250827    gcc-11.5.0
powerpc64             randconfig-001-20250828    clang-22
powerpc64             randconfig-002-20250827    gcc-11.5.0
powerpc64             randconfig-003-20250827    gcc-13.4.0
powerpc64             randconfig-003-20250828    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250827    clang-19
riscv                 randconfig-001-20250828    clang-19
riscv                 randconfig-002-20250827    clang-22
riscv                 randconfig-002-20250828    clang-19
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250827    gcc-13.4.0
s390                  randconfig-001-20250828    clang-19
s390                  randconfig-002-20250827    gcc-8.5.0
s390                  randconfig-002-20250828    clang-19
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250827    gcc-15.1.0
sh                    randconfig-001-20250828    clang-19
sh                    randconfig-002-20250827    gcc-9.5.0
sh                    randconfig-002-20250828    clang-19
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250827    gcc-15.1.0
sparc                 randconfig-001-20250828    clang-19
sparc                 randconfig-002-20250827    gcc-15.1.0
sparc                 randconfig-002-20250828    clang-19
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250827    gcc-11.5.0
sparc64               randconfig-001-20250828    clang-19
sparc64               randconfig-002-20250827    gcc-8.5.0
sparc64               randconfig-002-20250828    clang-19
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250827    gcc-12
um                    randconfig-001-20250828    clang-19
um                    randconfig-002-20250827    clang-22
um                    randconfig-002-20250828    clang-19
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250827    clang-20
x86_64      buildonly-randconfig-001-20250828    gcc-12
x86_64      buildonly-randconfig-002-20250827    clang-20
x86_64      buildonly-randconfig-002-20250828    gcc-12
x86_64      buildonly-randconfig-003-20250827    gcc-12
x86_64      buildonly-randconfig-003-20250828    gcc-12
x86_64      buildonly-randconfig-004-20250827    gcc-12
x86_64      buildonly-randconfig-004-20250828    gcc-12
x86_64      buildonly-randconfig-005-20250827    clang-20
x86_64      buildonly-randconfig-005-20250828    gcc-12
x86_64      buildonly-randconfig-006-20250827    clang-20
x86_64      buildonly-randconfig-006-20250828    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250828    clang-20
x86_64                randconfig-002-20250828    clang-20
x86_64                randconfig-003-20250828    clang-20
x86_64                randconfig-004-20250828    clang-20
x86_64                randconfig-005-20250828    clang-20
x86_64                randconfig-006-20250828    clang-20
x86_64                randconfig-007-20250828    clang-20
x86_64                randconfig-008-20250828    clang-20
x86_64                randconfig-071-20250828    clang-20
x86_64                randconfig-072-20250828    clang-20
x86_64                randconfig-073-20250828    clang-20
x86_64                randconfig-074-20250828    clang-20
x86_64                randconfig-075-20250828    clang-20
x86_64                randconfig-076-20250828    clang-20
x86_64                randconfig-077-20250828    clang-20
x86_64                randconfig-078-20250828    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250827    gcc-10.5.0
xtensa                randconfig-001-20250828    clang-19
xtensa                randconfig-002-20250827    gcc-10.5.0
xtensa                randconfig-002-20250828    clang-19

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

