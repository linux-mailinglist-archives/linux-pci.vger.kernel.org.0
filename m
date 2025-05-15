Return-Path: <linux-pci+bounces-27815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9293EAB8E06
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 19:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1DF500518
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 17:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1342198A08;
	Thu, 15 May 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6FmIZ4K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5398F6E
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330992; cv=none; b=OFZyIGbMAyh1s7psfLg0j1eovlpaNCOpm5L1SvUcB3Drsxkg/XY9RZqhu0X4akm7VY83ioKq865NF2oMbFrF2iFxqWoJDlGmx4KkAAHWJNdbxs5noSR7x4H8TFdzWu5M8lcoNLchqcG21YedbkP0TGVgYqpRHZULZpHSc/kfPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330992; c=relaxed/simple;
	bh=/1NaDtvszn7lx7GzP/KrjIj7ml1ASeDQ9IdgJ3Eznms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DRpXqtivdmvwqVXT4p0Ex38jKLrUqAgJNO4Az1mNwYI1h7rjuG43pYJUQI1zF9dTePaj52a8YSFDeVxkpObqgeqTMtGYgGLOcGEpUx6vVV6W+jBI8EFlS92vdVjRnIolrHGTzTPARm7n+4COoO+SfNdKUE97e8ubAZWPt1IMopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6FmIZ4K; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747330991; x=1778866991;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/1NaDtvszn7lx7GzP/KrjIj7ml1ASeDQ9IdgJ3Eznms=;
  b=Q6FmIZ4KLxIB1bTigfBWUFckidbeojqyc6vgQ+AsajGZeZqfsONEIcwV
   ITEzUPyDdyLtob849jeYQ001pT77lNhkGAi9e2FmwLBWEhb3DUhva17QP
   DvIcv1vSWOVW7jr6zVHa2Jj8wvp8jlnBIkXHS/c9CXLqpEmcnpdbPS8g8
   D4kCpAhhwtoVIrV037IH2qIqu51NIJ1WUUqc6iBEwsCo5qkypT9iaVN3J
   5hvQvQ6OcAlxK6NgfdcI92rQ3AQgkQfxctVD3SW+wviWddgEWZSwLlPD5
   3v0h7oxgSp4jMtP1JhhduEzYa2lkWmYrxRRUNXpFGN4yZ5Bo5YUSD+Mmj
   w==;
X-CSE-ConnectionGUID: RMLf9W0jS/m+EDlYL0l5PQ==
X-CSE-MsgGUID: NU1irqMNQ5KoKb0Iwe5J8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59923400"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="59923400"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:43:08 -0700
X-CSE-ConnectionGUID: 8fWLFdS1R/eCglNqjhso0Q==
X-CSE-MsgGUID: IuMES/tGTcW1yMqZBg+o0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="139328918"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2025 10:43:07 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFcbo-000Ibz-1y;
	Thu, 15 May 2025 17:43:04 +0000
Date: Fri, 16 May 2025 01:42:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 9b388104e87b679bc62d23ae1b215f12942ece95
Message-ID: <202505160143.XsJQldFB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 9b388104e87b679bc62d23ae1b215f12942ece95  PCI: Non-empty add_list/realloc_head does not warrant BUG_ON()

elapsed time: 1453m

configs tested: 193
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                   randconfig-001-20250515    gcc-12.4.0
arc                   randconfig-001-20250515    gcc-6.5.0
arc                   randconfig-002-20250515    gcc-14.2.0
arc                   randconfig-002-20250515    gcc-6.5.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                   randconfig-001-20250515    clang-21
arm                   randconfig-001-20250515    gcc-6.5.0
arm                   randconfig-002-20250515    gcc-6.5.0
arm                   randconfig-002-20250515    gcc-8.5.0
arm                   randconfig-003-20250515    gcc-6.5.0
arm                   randconfig-003-20250515    gcc-8.5.0
arm                   randconfig-004-20250515    clang-21
arm                   randconfig-004-20250515    gcc-6.5.0
arm                         vf610m4_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250515    clang-21
arm64                 randconfig-001-20250515    gcc-6.5.0
arm64                 randconfig-002-20250515    clang-21
arm64                 randconfig-002-20250515    gcc-6.5.0
arm64                 randconfig-003-20250515    clang-20
arm64                 randconfig-003-20250515    gcc-6.5.0
arm64                 randconfig-004-20250515    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250515    clang-21
csky                  randconfig-001-20250515    gcc-14.2.0
csky                  randconfig-002-20250515    clang-21
csky                  randconfig-002-20250515    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250515    clang-16
hexagon               randconfig-001-20250515    clang-21
hexagon               randconfig-002-20250515    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250515    gcc-11
i386        buildonly-randconfig-002-20250515    gcc-11
i386        buildonly-randconfig-002-20250515    gcc-12
i386        buildonly-randconfig-003-20250515    clang-20
i386        buildonly-randconfig-003-20250515    gcc-11
i386        buildonly-randconfig-004-20250515    clang-20
i386        buildonly-randconfig-004-20250515    gcc-11
i386        buildonly-randconfig-005-20250515    gcc-11
i386        buildonly-randconfig-005-20250515    gcc-12
i386        buildonly-randconfig-006-20250515    gcc-11
i386                                defconfig    clang-20
i386                  randconfig-011-20250515    gcc-12
i386                  randconfig-012-20250515    gcc-12
i386                  randconfig-013-20250515    gcc-12
i386                  randconfig-014-20250515    gcc-12
i386                  randconfig-015-20250515    gcc-12
i386                  randconfig-016-20250515    gcc-12
i386                  randconfig-017-20250515    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250515    clang-21
loongarch             randconfig-001-20250515    gcc-12.4.0
loongarch             randconfig-002-20250515    clang-21
loongarch             randconfig-002-20250515    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250515    clang-21
nios2                 randconfig-001-20250515    gcc-12.4.0
nios2                 randconfig-002-20250515    clang-21
nios2                 randconfig-002-20250515    gcc-6.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250515    clang-21
parisc                randconfig-001-20250515    gcc-13.3.0
parisc                randconfig-002-20250515    clang-21
parisc                randconfig-002-20250515    gcc-13.3.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250515    clang-21
powerpc               randconfig-001-20250515    gcc-8.5.0
powerpc               randconfig-002-20250515    clang-21
powerpc               randconfig-002-20250515    gcc-6.5.0
powerpc               randconfig-003-20250515    clang-21
powerpc64             randconfig-001-20250515    clang-21
powerpc64             randconfig-002-20250515    clang-21
powerpc64             randconfig-002-20250515    gcc-8.5.0
powerpc64             randconfig-003-20250515    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250515    gcc-8.5.0
riscv                 randconfig-001-20250515    gcc-9.3.0
riscv                 randconfig-002-20250515    gcc-14.2.0
riscv                 randconfig-002-20250515    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250515    clang-21
s390                  randconfig-001-20250515    gcc-9.3.0
s390                  randconfig-002-20250515    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250515    gcc-14.2.0
sh                    randconfig-001-20250515    gcc-9.3.0
sh                    randconfig-002-20250515    gcc-10.5.0
sh                    randconfig-002-20250515    gcc-9.3.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250515    gcc-6.5.0
sparc                 randconfig-001-20250515    gcc-9.3.0
sparc                 randconfig-002-20250515    gcc-10.3.0
sparc                 randconfig-002-20250515    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250515    gcc-9.3.0
sparc64               randconfig-002-20250515    gcc-9.3.0
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250515    gcc-12
um                    randconfig-001-20250515    gcc-9.3.0
um                    randconfig-002-20250515    clang-21
um                    randconfig-002-20250515    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250515    clang-20
x86_64      buildonly-randconfig-001-20250515    gcc-12
x86_64      buildonly-randconfig-002-20250515    clang-20
x86_64      buildonly-randconfig-002-20250515    gcc-12
x86_64      buildonly-randconfig-003-20250515    clang-20
x86_64      buildonly-randconfig-003-20250515    gcc-12
x86_64      buildonly-randconfig-004-20250515    clang-20
x86_64      buildonly-randconfig-004-20250515    gcc-12
x86_64      buildonly-randconfig-005-20250515    clang-20
x86_64      buildonly-randconfig-005-20250515    gcc-12
x86_64      buildonly-randconfig-006-20250515    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250515    gcc-12
x86_64                randconfig-002-20250515    gcc-12
x86_64                randconfig-003-20250515    gcc-12
x86_64                randconfig-004-20250515    gcc-12
x86_64                randconfig-005-20250515    gcc-12
x86_64                randconfig-006-20250515    gcc-12
x86_64                randconfig-007-20250515    gcc-12
x86_64                randconfig-008-20250515    gcc-12
x86_64                randconfig-071-20250515    clang-20
x86_64                randconfig-072-20250515    clang-20
x86_64                randconfig-073-20250515    clang-20
x86_64                randconfig-074-20250515    clang-20
x86_64                randconfig-075-20250515    clang-20
x86_64                randconfig-076-20250515    clang-20
x86_64                randconfig-077-20250515    clang-20
x86_64                randconfig-078-20250515    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-9.3.0
xtensa                randconfig-002-20250515    gcc-13.3.0
xtensa                randconfig-002-20250515    gcc-9.3.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

