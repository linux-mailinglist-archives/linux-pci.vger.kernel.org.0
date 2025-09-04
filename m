Return-Path: <linux-pci+bounces-35475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41497B4468D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 21:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A781C83E36
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B02690D9;
	Thu,  4 Sep 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWoVjH4+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288125E469
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014754; cv=none; b=Ixsadb28yOD9ldP1KMU1glZvTLh23/3rxo15QDono+Om2OT5RRO4U0CqJjgXphjv7EgrVKYODJH9ae97eCHdvvwIJeeoinatC9nCzwznEgvewZzxJPESsrtYy/3hQJcaW0EKFsRGQdEmn2WpAH/jXlRpaGiMAk9JaRE3r04Nfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014754; c=relaxed/simple;
	bh=jHsVbW7e/CQ9h4rP1AT5900yVaFrzdib6IGC7VceCEE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Rjg4Rp/X1CDytRj9r5oCuMxUbG8ZajSbE621RqmyyutpCI3Po8yQ2bph5Is1UKeEDjZdTYK2smO5XZj+m9eVKaw9DL+2kQNK0u9TjICN2efWcBBDic7zey1HImyheaDpnigQTIJ2flrhXAOL//Vjg86qQYLjYz6gS1JhNct65aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWoVjH4+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757014752; x=1788550752;
  h=date:from:to:cc:subject:message-id;
  bh=jHsVbW7e/CQ9h4rP1AT5900yVaFrzdib6IGC7VceCEE=;
  b=ZWoVjH4+mr5YOt3zY8Gomo+tMEagD2uONBeIFd4Y8G2IYOsfFcQZT8Kg
   7C3oV+XZgk4nQQFTI03xf5e7LbHxBEn50EZvX/7XYnyZMcVeLK7IEwTvS
   gXgwOqFtooImyCP5rcge5fBqbDv8rFxpnwLQX4z5qqK0TH9NViWVIvNCT
   Se0YYra+yS8UnkwV2oxO+jmM3qEsGYlttEnr/5vwojxpH5Zkm0VlsF0ZH
   8GwV77YvAzXA71cKyXNue2p7vF0TXm9ouJS4dec7uWxcIgM/dVYV01+HF
   JSa4e+IoVkjnnegCLjZYG9bPnAvGja/jPd5rGEEDWOt/iwZAmbh/x9sb/
   w==;
X-CSE-ConnectionGUID: y4qGVo6XR4O82i10JZHWCA==
X-CSE-MsgGUID: 8v4fhuX6SM+j/Zry4whvbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59476108"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="59476108"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 12:39:11 -0700
X-CSE-ConnectionGUID: Ib6/mJLJSqCCZugGkQqvZQ==
X-CSE-MsgGUID: bOHurf5TRWih6Vv+8mKIdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="202822817"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 04 Sep 2025 12:39:09 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuFnX-0005ir-1E;
	Thu, 04 Sep 2025 19:39:07 +0000
Date: Fri, 05 Sep 2025 03:37:26 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra] BUILD SUCCESS
 e1a8805e5d263453ad76a4f50ab3b1c18ea07560
Message-ID: <202509050320.bGWmAdKH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra
branch HEAD: e1a8805e5d263453ad76a4f50ab3b1c18ea07560  PCI: tegra: Fix devm_kcalloc() argument order for port->phys allocation

elapsed time: 1363m

configs tested: 285
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250904    gcc-8.5.0
arc                   randconfig-001-20250904    gcc-9.5.0
arc                   randconfig-001-20250905    clang-22
arc                   randconfig-002-20250904    gcc-11.5.0
arc                   randconfig-002-20250904    gcc-8.5.0
arc                   randconfig-002-20250905    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                        keystone_defconfig    gcc-15.1.0
arm                        multi_v5_defconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250904    gcc-10.5.0
arm                   randconfig-001-20250904    gcc-8.5.0
arm                   randconfig-001-20250905    clang-22
arm                   randconfig-002-20250904    gcc-13.4.0
arm                   randconfig-002-20250904    gcc-8.5.0
arm                   randconfig-002-20250905    clang-22
arm                   randconfig-003-20250904    gcc-8.5.0
arm                   randconfig-003-20250905    clang-22
arm                   randconfig-004-20250904    gcc-13.4.0
arm                   randconfig-004-20250904    gcc-8.5.0
arm                   randconfig-004-20250905    clang-22
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250904    gcc-8.5.0
arm64                 randconfig-001-20250905    clang-22
arm64                 randconfig-002-20250904    gcc-8.5.0
arm64                 randconfig-002-20250905    clang-22
arm64                 randconfig-003-20250904    clang-22
arm64                 randconfig-003-20250904    gcc-8.5.0
arm64                 randconfig-003-20250905    clang-22
arm64                 randconfig-004-20250904    gcc-8.5.0
arm64                 randconfig-004-20250905    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250904    gcc-11.5.0
csky                  randconfig-001-20250904    gcc-15.1.0
csky                  randconfig-001-20250905    gcc-11.5.0
csky                  randconfig-002-20250904    gcc-10.5.0
csky                  randconfig-002-20250904    gcc-11.5.0
csky                  randconfig-002-20250905    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250904    clang-22
hexagon               randconfig-001-20250904    gcc-11.5.0
hexagon               randconfig-001-20250905    gcc-11.5.0
hexagon               randconfig-002-20250904    clang-20
hexagon               randconfig-002-20250904    gcc-11.5.0
hexagon               randconfig-002-20250905    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250904    clang-20
i386        buildonly-randconfig-001-20250905    clang-20
i386        buildonly-randconfig-002-20250904    clang-20
i386        buildonly-randconfig-002-20250904    gcc-12
i386        buildonly-randconfig-002-20250905    clang-20
i386        buildonly-randconfig-003-20250904    clang-20
i386        buildonly-randconfig-003-20250904    gcc-13
i386        buildonly-randconfig-003-20250905    clang-20
i386        buildonly-randconfig-004-20250904    clang-20
i386        buildonly-randconfig-004-20250904    gcc-13
i386        buildonly-randconfig-004-20250905    clang-20
i386        buildonly-randconfig-005-20250904    clang-20
i386        buildonly-randconfig-005-20250905    clang-20
i386        buildonly-randconfig-006-20250904    clang-20
i386        buildonly-randconfig-006-20250905    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250904    gcc-11
i386                  randconfig-001-20250905    gcc-13
i386                  randconfig-002-20250904    gcc-11
i386                  randconfig-002-20250905    gcc-13
i386                  randconfig-003-20250904    gcc-11
i386                  randconfig-003-20250905    gcc-13
i386                  randconfig-004-20250904    gcc-11
i386                  randconfig-004-20250905    gcc-13
i386                  randconfig-005-20250904    gcc-11
i386                  randconfig-005-20250905    gcc-13
i386                  randconfig-006-20250904    gcc-11
i386                  randconfig-006-20250905    gcc-13
i386                  randconfig-007-20250904    gcc-11
i386                  randconfig-007-20250905    gcc-13
i386                  randconfig-011-20250904    gcc-13
i386                  randconfig-011-20250905    clang-20
i386                  randconfig-012-20250904    gcc-13
i386                  randconfig-012-20250905    clang-20
i386                  randconfig-013-20250904    gcc-13
i386                  randconfig-013-20250905    clang-20
i386                  randconfig-014-20250904    gcc-13
i386                  randconfig-014-20250905    clang-20
i386                  randconfig-015-20250904    gcc-13
i386                  randconfig-015-20250905    clang-20
i386                  randconfig-016-20250904    gcc-13
i386                  randconfig-016-20250905    clang-20
i386                  randconfig-017-20250904    gcc-13
i386                  randconfig-017-20250905    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250904    gcc-11.5.0
loongarch             randconfig-001-20250904    gcc-15.1.0
loongarch             randconfig-001-20250905    gcc-11.5.0
loongarch             randconfig-002-20250904    clang-22
loongarch             randconfig-002-20250904    gcc-11.5.0
loongarch             randconfig-002-20250905    gcc-11.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250904    gcc-11.5.0
nios2                 randconfig-001-20250905    gcc-11.5.0
nios2                 randconfig-002-20250904    gcc-11.5.0
nios2                 randconfig-002-20250905    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-13
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250904    gcc-11.5.0
parisc                randconfig-001-20250904    gcc-8.5.0
parisc                randconfig-001-20250905    gcc-11.5.0
parisc                randconfig-002-20250904    gcc-11.5.0
parisc                randconfig-002-20250905    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250904    clang-19
powerpc               randconfig-001-20250904    gcc-11.5.0
powerpc               randconfig-001-20250905    gcc-11.5.0
powerpc               randconfig-002-20250904    gcc-11.5.0
powerpc               randconfig-002-20250904    gcc-13.4.0
powerpc               randconfig-002-20250905    gcc-11.5.0
powerpc               randconfig-003-20250904    clang-22
powerpc               randconfig-003-20250904    gcc-11.5.0
powerpc               randconfig-003-20250905    gcc-11.5.0
powerpc                     redwood_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250904    gcc-11.5.0
powerpc64             randconfig-001-20250904    gcc-15.1.0
powerpc64             randconfig-001-20250905    gcc-11.5.0
powerpc64             randconfig-002-20250904    clang-22
powerpc64             randconfig-002-20250904    gcc-11.5.0
powerpc64             randconfig-002-20250905    gcc-11.5.0
powerpc64             randconfig-003-20250904    gcc-11.5.0
powerpc64             randconfig-003-20250904    gcc-8.5.0
powerpc64             randconfig-003-20250905    gcc-11.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-13
riscv                 randconfig-001-20250904    gcc-12.5.0
riscv                 randconfig-001-20250904    gcc-8.5.0
riscv                 randconfig-002-20250904    clang-22
riscv                 randconfig-002-20250904    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-13
s390                  randconfig-001-20250904    gcc-10.5.0
s390                  randconfig-001-20250904    gcc-12.5.0
s390                  randconfig-002-20250904    gcc-12.5.0
s390                  randconfig-002-20250904    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-13
sh                               j2_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250904    gcc-12.5.0
sh                    randconfig-002-20250904    gcc-10.5.0
sh                    randconfig-002-20250904    gcc-12.5.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250904    gcc-11.5.0
sparc                 randconfig-001-20250904    gcc-12.5.0
sparc                 randconfig-002-20250904    gcc-12.5.0
sparc                 randconfig-002-20250904    gcc-15.1.0
sparc64                             defconfig    gcc-13
sparc64               randconfig-001-20250904    gcc-12.5.0
sparc64               randconfig-002-20250904    clang-20
sparc64               randconfig-002-20250904    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-13
um                                  defconfig    gcc-13
um                             i386_defconfig    gcc-13
um                    randconfig-001-20250904    gcc-12.5.0
um                    randconfig-001-20250904    gcc-13
um                    randconfig-002-20250904    clang-22
um                    randconfig-002-20250904    gcc-12.5.0
um                           x86_64_defconfig    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250904    gcc-12
x86_64      buildonly-randconfig-001-20250904    gcc-13
x86_64      buildonly-randconfig-001-20250905    gcc-13
x86_64      buildonly-randconfig-002-20250904    clang-20
x86_64      buildonly-randconfig-002-20250904    gcc-13
x86_64      buildonly-randconfig-002-20250905    gcc-13
x86_64      buildonly-randconfig-003-20250904    gcc-13
x86_64      buildonly-randconfig-003-20250905    gcc-13
x86_64      buildonly-randconfig-004-20250904    gcc-13
x86_64      buildonly-randconfig-004-20250905    gcc-13
x86_64      buildonly-randconfig-005-20250904    gcc-13
x86_64      buildonly-randconfig-005-20250905    gcc-13
x86_64      buildonly-randconfig-006-20250904    clang-20
x86_64      buildonly-randconfig-006-20250904    gcc-13
x86_64      buildonly-randconfig-006-20250905    gcc-13
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250904    clang-20
x86_64                randconfig-001-20250905    clang-20
x86_64                randconfig-002-20250904    clang-20
x86_64                randconfig-002-20250905    clang-20
x86_64                randconfig-003-20250904    clang-20
x86_64                randconfig-003-20250905    clang-20
x86_64                randconfig-004-20250904    clang-20
x86_64                randconfig-004-20250905    clang-20
x86_64                randconfig-005-20250904    clang-20
x86_64                randconfig-005-20250905    clang-20
x86_64                randconfig-006-20250904    clang-20
x86_64                randconfig-006-20250905    clang-20
x86_64                randconfig-007-20250904    clang-20
x86_64                randconfig-007-20250905    clang-20
x86_64                randconfig-008-20250904    clang-20
x86_64                randconfig-008-20250905    clang-20
x86_64                randconfig-071-20250904    clang-20
x86_64                randconfig-072-20250904    clang-20
x86_64                randconfig-073-20250904    clang-20
x86_64                randconfig-074-20250904    clang-20
x86_64                randconfig-075-20250904    clang-20
x86_64                randconfig-076-20250904    clang-20
x86_64                randconfig-077-20250904    clang-20
x86_64                randconfig-078-20250904    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-13
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-13
x86_64                           rhel-9.4-ltp    gcc-13
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250904    gcc-10.5.0
xtensa                randconfig-001-20250904    gcc-12.5.0
xtensa                randconfig-002-20250904    gcc-11.5.0
xtensa                randconfig-002-20250904    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

