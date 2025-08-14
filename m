Return-Path: <linux-pci+bounces-34081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4518B27176
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 00:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC23317C44F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DEA259C87;
	Thu, 14 Aug 2025 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYxr4J1L"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3820A5EA
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209513; cv=none; b=XrAGXjbGywnQm+45apN6U/t1pkTgq4KCI9eEpQOJcqLTHXEFGhWUuyMrVr9ol9vKBbP8Cds+kbgd9ct3c5476l2lXU+66EofjFNfZvDG/UeJfb1lXHzOzh/30N0Gnh7CcnstjILKFJMn6l1InXV0bCWOcM576JzOUm9CnAMaou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209513; c=relaxed/simple;
	bh=2a+/9cvykQA0mI6PC5Qg1QqVpytWx+EK6UlETscJxc0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eNBEtCsbEGAVsfhItmwG3f5LmV5NOW+wLy6xgy5YaJWBWgFkukjaZpv0GqNne5nOAdY/0jm6559hhNjbSCU2SbGaurwDrg5NVXRMpDj6hTuUdhwM9AlPR+gl/spQgJTp1mxbaBWwDwpBWirQyaDPhmA0RIm0o3HMGKBI7VyPy/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYxr4J1L; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755209512; x=1786745512;
  h=date:from:to:cc:subject:message-id;
  bh=2a+/9cvykQA0mI6PC5Qg1QqVpytWx+EK6UlETscJxc0=;
  b=fYxr4J1L/BzNpLh70NGLia8Z5KHLB8JIBNPjEnBtr/7weR+t4jLNzc2J
   fIzZRXGOtnjW2uxFCZY+mgUIr/ox4nw40nMOR4RN596WsKvSWrO3OTRMy
   U4Fdow8lvQ44T2vhl/21gBY7cp9jjvkhg9uWuZlDmIrW94IOInJbN8YOD
   qRvfPVWw++E5FAoY+HAXYQnJjP/hMiAHs5Mj8m85GdheH6vk+LPRPXYf1
   JVZqGe79kNd2mZDuYI8eWkMT5mRFjCcQmZ/T5aRynxcpcRK4TroJyw2b1
   GlCWndETJXTQ/fTp1HOKGeZCmymEzEYxlRgeCnwOuv7UejHGTaZgrv4Vj
   Q==;
X-CSE-ConnectionGUID: rjp8erfkThC0VZT8LHcRJQ==
X-CSE-MsgGUID: ZWp2hmZzRWqhFiOh2FN+Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57615664"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57615664"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:11:50 -0700
X-CSE-ConnectionGUID: vo7+itAbSQ+rPIbbTlTkBw==
X-CSE-MsgGUID: t64UZW76SoiIYSfEqDtFKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167224880"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 14 Aug 2025 15:11:49 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umgAk-000BM4-2t;
	Thu, 14 Aug 2025 22:11:46 +0000
Date: Fri, 15 Aug 2025 06:11:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 5aa0b8883749f0ae3b2f80f35536aae542c3d604
Message-ID: <202508150603.6psqZ2Jr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 5aa0b8883749f0ae3b2f80f35536aae542c3d604  Merge branch 'pci/misc'

elapsed time: 1451m

configs tested: 239
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250814    gcc-12.5.0
arc                   randconfig-001-20250815    clang-22
arc                   randconfig-002-20250814    gcc-13.4.0
arc                   randconfig-002-20250815    clang-22
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                      footbridge_defconfig    gcc-15.1.0
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250814    clang-22
arm                   randconfig-001-20250815    clang-22
arm                   randconfig-002-20250814    clang-22
arm                   randconfig-002-20250815    clang-22
arm                   randconfig-003-20250814    gcc-10.5.0
arm                   randconfig-003-20250815    clang-22
arm                   randconfig-004-20250814    gcc-8.5.0
arm                   randconfig-004-20250815    clang-22
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250814    clang-17
arm64                 randconfig-001-20250815    clang-22
arm64                 randconfig-002-20250814    gcc-8.5.0
arm64                 randconfig-002-20250815    clang-22
arm64                 randconfig-003-20250814    gcc-10.5.0
arm64                 randconfig-003-20250815    clang-22
arm64                 randconfig-004-20250814    gcc-13.4.0
arm64                 randconfig-004-20250815    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250814    gcc-15.1.0
csky                  randconfig-001-20250815    gcc-11.5.0
csky                  randconfig-002-20250814    gcc-15.1.0
csky                  randconfig-002-20250815    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250814    clang-20
hexagon               randconfig-001-20250815    gcc-11.5.0
hexagon               randconfig-002-20250814    clang-22
hexagon               randconfig-002-20250815    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250814    clang-20
i386        buildonly-randconfig-001-20250815    gcc-12
i386        buildonly-randconfig-002-20250814    gcc-12
i386        buildonly-randconfig-002-20250815    gcc-12
i386        buildonly-randconfig-003-20250814    gcc-12
i386        buildonly-randconfig-003-20250815    gcc-12
i386        buildonly-randconfig-004-20250814    clang-20
i386        buildonly-randconfig-004-20250815    gcc-12
i386        buildonly-randconfig-005-20250814    gcc-12
i386        buildonly-randconfig-005-20250815    gcc-12
i386        buildonly-randconfig-006-20250814    gcc-12
i386        buildonly-randconfig-006-20250815    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250815    gcc-12
i386                  randconfig-002-20250815    gcc-12
i386                  randconfig-003-20250815    gcc-12
i386                  randconfig-004-20250815    gcc-12
i386                  randconfig-005-20250815    gcc-12
i386                  randconfig-006-20250815    gcc-12
i386                  randconfig-007-20250815    gcc-12
i386                  randconfig-011-20250815    gcc-12
i386                  randconfig-012-20250815    gcc-12
i386                  randconfig-013-20250815    gcc-12
i386                  randconfig-014-20250815    gcc-12
i386                  randconfig-015-20250815    gcc-12
i386                  randconfig-016-20250815    gcc-12
i386                  randconfig-017-20250815    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250814    clang-22
loongarch             randconfig-001-20250815    gcc-11.5.0
loongarch             randconfig-002-20250814    gcc-15.1.0
loongarch             randconfig-002-20250815    gcc-11.5.0
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
mips                        qi_lb60_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250814    gcc-10.5.0
nios2                 randconfig-001-20250815    gcc-11.5.0
nios2                 randconfig-002-20250814    gcc-9.5.0
nios2                 randconfig-002-20250815    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250814    gcc-10.5.0
parisc                randconfig-001-20250815    gcc-11.5.0
parisc                randconfig-002-20250814    gcc-13.4.0
parisc                randconfig-002-20250815    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250814    gcc-8.5.0
powerpc               randconfig-001-20250815    gcc-11.5.0
powerpc               randconfig-002-20250814    gcc-8.5.0
powerpc               randconfig-002-20250815    gcc-11.5.0
powerpc               randconfig-003-20250814    gcc-10.5.0
powerpc               randconfig-003-20250815    gcc-11.5.0
powerpc64             randconfig-001-20250814    clang-22
powerpc64             randconfig-001-20250815    gcc-11.5.0
powerpc64             randconfig-002-20250814    clang-22
powerpc64             randconfig-002-20250815    gcc-11.5.0
powerpc64             randconfig-003-20250814    clang-22
powerpc64             randconfig-003-20250815    gcc-11.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250814    clang-22
riscv                 randconfig-001-20250815    gcc-8.5.0
riscv                 randconfig-002-20250814    clang-22
riscv                 randconfig-002-20250815    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250814    clang-22
s390                  randconfig-001-20250815    gcc-8.5.0
s390                  randconfig-002-20250814    gcc-8.5.0
s390                  randconfig-002-20250815    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250814    gcc-9.5.0
sh                    randconfig-001-20250815    gcc-8.5.0
sh                    randconfig-002-20250814    gcc-15.1.0
sh                    randconfig-002-20250815    gcc-8.5.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250814    gcc-14.3.0
sparc                 randconfig-001-20250815    gcc-8.5.0
sparc                 randconfig-002-20250814    gcc-12.5.0
sparc                 randconfig-002-20250815    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250814    clang-22
sparc64               randconfig-001-20250815    gcc-8.5.0
sparc64               randconfig-002-20250814    gcc-8.5.0
sparc64               randconfig-002-20250815    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250814    clang-22
um                    randconfig-001-20250815    gcc-8.5.0
um                    randconfig-002-20250814    clang-22
um                    randconfig-002-20250815    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250814    clang-20
x86_64      buildonly-randconfig-001-20250815    gcc-12
x86_64      buildonly-randconfig-002-20250814    clang-20
x86_64      buildonly-randconfig-002-20250815    gcc-12
x86_64      buildonly-randconfig-003-20250814    gcc-12
x86_64      buildonly-randconfig-003-20250815    gcc-12
x86_64      buildonly-randconfig-004-20250814    clang-20
x86_64      buildonly-randconfig-004-20250815    gcc-12
x86_64      buildonly-randconfig-005-20250814    gcc-12
x86_64      buildonly-randconfig-005-20250815    gcc-12
x86_64      buildonly-randconfig-006-20250814    gcc-12
x86_64      buildonly-randconfig-006-20250815    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250815    gcc-12
x86_64                randconfig-002-20250815    gcc-12
x86_64                randconfig-003-20250815    gcc-12
x86_64                randconfig-004-20250815    gcc-12
x86_64                randconfig-005-20250815    gcc-12
x86_64                randconfig-006-20250815    gcc-12
x86_64                randconfig-007-20250815    gcc-12
x86_64                randconfig-008-20250815    gcc-12
x86_64                randconfig-071-20250815    clang-20
x86_64                randconfig-072-20250815    clang-20
x86_64                randconfig-073-20250815    clang-20
x86_64                randconfig-074-20250815    clang-20
x86_64                randconfig-075-20250815    clang-20
x86_64                randconfig-076-20250815    clang-20
x86_64                randconfig-077-20250815    clang-20
x86_64                randconfig-078-20250815    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250814    gcc-8.5.0
xtensa                randconfig-001-20250815    gcc-8.5.0
xtensa                randconfig-002-20250814    gcc-10.5.0
xtensa                randconfig-002-20250815    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

