Return-Path: <linux-pci+bounces-23690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 018C4A603DD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 23:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8117AEAEE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 22:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB051F5847;
	Thu, 13 Mar 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJU4iWr/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC471C07D9
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903318; cv=none; b=Ae3yJHDQ5ogvc1g4rvnwJ+SoizAleEBuIRgdnuNhSsxDoC20ZftguTRgRac4VOk/K7VTJRjktIWOOb6BmtBYUdtGGsNesHX0n6BJjIGOEauO6QGRm2wjNoK9h0a4+B4aK1r7DuZZh3xAT/69ZFuTcLFiXgtNGmZXNrwBzY420fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903318; c=relaxed/simple;
	bh=oLGqNT0fiQ0iHVjSD5PiiRrd5FA7k1Z5O3v+Dngaze8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DwfM+HX7u3bcSwp4D2R+riXEjnYkvfiBPOK/jgDfdfOmKSPz1tyjf0YEXR8XTmu2snVjeHDznXGa+qXqHnZHiiwHOuN/S5uJ0A+2wruHLh5XNr3BaeFBNfbU8dRs3YDmsX6g7rqlhaTrtOBw0hnofhDuunt9a5vcUqCf/+7CpYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJU4iWr/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741903316; x=1773439316;
  h=date:from:to:cc:subject:message-id;
  bh=oLGqNT0fiQ0iHVjSD5PiiRrd5FA7k1Z5O3v+Dngaze8=;
  b=NJU4iWr/LmeqefnYiG0A+Ov5uc6BYfGqZhE4CYgOCppjKwzAouJ26+bk
   CMd3A2UQYMXfXb43UIgYL69JZW99Bzh6do1WvrZKD8ZoVSCpLVqVLjpQN
   IfjRlWd0XGnAVhaE9PeDJMUxF/XjBmkomoNaHjiPvKpNhS7wLWT6FRRSr
   AUG4l0/632hDb9USWN9Nler1apv+YWxCjaIWNVzDDWDKsymdy5T/SdVNb
   n9T9TMcgCLafn01YTSI0caGLLgHDuz+3YE1MzBoM3ACjF65FRTa1UVWJJ
   O+mPc/I7+8uC4ajYN/3HrMpA1X/qnxcIHn1py5tqtQDh964qflGK0jGDb
   Q==;
X-CSE-ConnectionGUID: NdPUsBgbSC2eg4KN0CaSNQ==
X-CSE-MsgGUID: Rgg6SMeTRVqPgo/70WdVqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42929365"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42929365"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:01:55 -0700
X-CSE-ConnectionGUID: 6ut7Kk14S6+5B3rMlZ/uog==
X-CSE-MsgGUID: or82F9JaR8K7GhGKud0FfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121036002"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 13 Mar 2025 15:01:54 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsqci-0009wt-0Z;
	Thu, 13 Mar 2025 22:01:52 +0000
Date: Fri, 14 Mar 2025 06:01:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 7632495eca67ea2bbfe49aef47f02356a24cc181
Message-ID: <202503140614.acflrx65-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 7632495eca67ea2bbfe49aef47f02356a24cc181  s390/pci: Support mmap() of PCI resources except for ISM devices

elapsed time: 1449m

configs tested: 205
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250313    clang-18
arc                   randconfig-001-20250313    gcc-13.2.0
arc                   randconfig-002-20250313    clang-18
arc                   randconfig-002-20250313    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250313    clang-16
arm                   randconfig-001-20250313    clang-18
arm                   randconfig-002-20250313    clang-18
arm                   randconfig-003-20250313    clang-18
arm                   randconfig-003-20250313    gcc-14.2.0
arm                   randconfig-004-20250313    clang-18
arm                   randconfig-004-20250313    clang-21
arm                           sama5_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250313    clang-18
arm64                 randconfig-002-20250313    clang-16
arm64                 randconfig-002-20250313    clang-18
arm64                 randconfig-003-20250313    clang-18
arm64                 randconfig-003-20250313    gcc-14.2.0
arm64                 randconfig-004-20250313    clang-18
arm64                 randconfig-004-20250313    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250313    gcc-14.2.0
csky                  randconfig-002-20250313    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250313    clang-17
hexagon               randconfig-001-20250313    gcc-14.2.0
hexagon               randconfig-002-20250313    clang-21
hexagon               randconfig-002-20250313    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250313    clang-19
i386        buildonly-randconfig-001-20250313    gcc-12
i386        buildonly-randconfig-002-20250313    clang-19
i386        buildonly-randconfig-002-20250313    gcc-12
i386        buildonly-randconfig-003-20250313    clang-19
i386        buildonly-randconfig-004-20250313    clang-19
i386        buildonly-randconfig-004-20250313    gcc-12
i386        buildonly-randconfig-005-20250313    clang-19
i386        buildonly-randconfig-006-20250313    clang-19
i386        buildonly-randconfig-006-20250313    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250313    clang-19
i386                  randconfig-002-20250313    clang-19
i386                  randconfig-003-20250313    clang-19
i386                  randconfig-004-20250313    clang-19
i386                  randconfig-005-20250313    clang-19
i386                  randconfig-006-20250313    clang-19
i386                  randconfig-007-20250313    clang-19
i386                  randconfig-011-20250313    clang-19
i386                  randconfig-012-20250313    clang-19
i386                  randconfig-013-20250313    clang-19
i386                  randconfig-014-20250313    clang-19
i386                  randconfig-015-20250313    clang-19
i386                  randconfig-016-20250313    clang-19
i386                  randconfig-017-20250313    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250313    gcc-14.2.0
loongarch             randconfig-002-20250313    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250313    gcc-14.2.0
nios2                 randconfig-002-20250313    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250313    gcc-14.2.0
parisc                randconfig-002-20250313    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250313    clang-16
powerpc               randconfig-001-20250313    gcc-14.2.0
powerpc               randconfig-002-20250313    clang-18
powerpc               randconfig-002-20250313    gcc-14.2.0
powerpc               randconfig-003-20250313    gcc-14.2.0
powerpc64             randconfig-001-20250313    gcc-14.2.0
powerpc64             randconfig-002-20250313    gcc-14.2.0
powerpc64             randconfig-003-20250313    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250313    clang-21
riscv                 randconfig-001-20250313    gcc-14.2.0
riscv                 randconfig-002-20250313    clang-21
riscv                 randconfig-002-20250313    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250313    clang-15
s390                  randconfig-001-20250313    gcc-14.2.0
s390                  randconfig-002-20250313    clang-15
s390                  randconfig-002-20250313    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250313    gcc-14.2.0
sh                    randconfig-002-20250313    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250313    gcc-14.2.0
sparc                 randconfig-002-20250313    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250313    gcc-14.2.0
sparc64               randconfig-002-20250313    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250313    clang-21
um                    randconfig-001-20250313    gcc-14.2.0
um                    randconfig-002-20250313    clang-21
um                    randconfig-002-20250313    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250313    clang-19
x86_64      buildonly-randconfig-002-20250313    clang-19
x86_64      buildonly-randconfig-003-20250313    clang-19
x86_64      buildonly-randconfig-004-20250313    clang-19
x86_64      buildonly-randconfig-004-20250313    gcc-12
x86_64      buildonly-randconfig-005-20250313    clang-19
x86_64      buildonly-randconfig-006-20250313    clang-19
x86_64      buildonly-randconfig-006-20250313    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250313    gcc-12
x86_64                randconfig-002-20250313    gcc-12
x86_64                randconfig-003-20250313    gcc-12
x86_64                randconfig-004-20250313    gcc-12
x86_64                randconfig-005-20250313    gcc-12
x86_64                randconfig-006-20250313    gcc-12
x86_64                randconfig-007-20250313    gcc-12
x86_64                randconfig-008-20250313    gcc-12
x86_64                randconfig-071-20250313    gcc-12
x86_64                randconfig-072-20250313    gcc-12
x86_64                randconfig-073-20250313    gcc-12
x86_64                randconfig-074-20250313    gcc-12
x86_64                randconfig-075-20250313    gcc-12
x86_64                randconfig-076-20250313    gcc-12
x86_64                randconfig-077-20250313    gcc-12
x86_64                randconfig-078-20250313    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250313    gcc-14.2.0
xtensa                randconfig-002-20250313    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

