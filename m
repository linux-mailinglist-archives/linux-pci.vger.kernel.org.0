Return-Path: <linux-pci+bounces-45089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A2D38DEF
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65AA030081A9
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1443009EC;
	Sat, 17 Jan 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLuebbYb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09F2FF675
	for <linux-pci@vger.kernel.org>; Sat, 17 Jan 2026 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768647596; cv=none; b=RZ2P7fHRsx/uphw+Z3YSMcBc+VnkJcV2t37tLofb+pzsYqJ1jswsSI4WqaL994WUt513ddwp0udeTJK0k17ct1t9FwFjb71A4CutE/zMh6ne16QC3akOm4FOcG+eR0+sURxFS7xr4W8r1xoSFZoil6Fv1J3A/iXV/iV1nvakGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768647596; c=relaxed/simple;
	bh=FEhUr+gg3Z/DC8N2exXwtuDfYFWLE2kjEIAh7UADZAw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ANMAZQEbePLVHs6nzvyq4FVdZfqetZW1BtbB+A6h2R75wWYsp8+vjI7Z6Ufd3kAfGGaxBd/dZQfkBsHE70yGJZAgSnRkaD0PHIGCdMpgCDaQUvogzIqUlYBxA8km1SjJFVoHSGGmBS4Zc59zTCGnq+krA86MieM4sbm0VuDtr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLuebbYb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768647595; x=1800183595;
  h=date:from:to:cc:subject:message-id;
  bh=FEhUr+gg3Z/DC8N2exXwtuDfYFWLE2kjEIAh7UADZAw=;
  b=iLuebbYbfeqibGooUjq3OydjvCC+n4dsglHnPotwJZ53/R59Fr7ZdiGq
   fmoMI4Ta9WzRR6c5rcYUbj7zmmvSFf/9z0KcJdNpwCXHt88Q6vyWMtm7N
   E9CN5kEeYS7Ll7FU1ShnY7c9ISJB2b680RrbmS6M4MkCwm/8A7nPRmWVs
   BHmrkU/8q0qqVjvk1FeDJycFvac5K9jzpj02EAENJvEcTh2XhzQKTqWXD
   miCWG92jydXFvlNmxw80q804YYt1ksOQAXuTHIuuN7+eJ4Lnnvz6f1bf+
   uDLACLGkCVffrLY1lxHNkNp/4/QaDDSR6uadGttIqW/6z8uW6AzAjjJPv
   g==;
X-CSE-ConnectionGUID: oBnVhJWCTky+6/4PTA1cXw==
X-CSE-MsgGUID: dz3sm5uxT/eZAbOQT17V4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69839214"
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="69839214"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 02:59:54 -0800
X-CSE-ConnectionGUID: mHnFqvvRQEi71ONAT/KYzA==
X-CSE-MsgGUID: jXHnCPYGQhqOoHkJqnam3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,233,1763452800"; 
   d="scan'208";a="205484258"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Jan 2026 02:59:52 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vh421-00000000LmS-3sYo;
	Sat, 17 Jan 2026 10:59:49 +0000
Date: Sat, 17 Jan 2026 18:59:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 8822f062e59a4daf070cb58666cec30b63db2d3b
Message-ID: <202601171839.uggGSzab-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: 8822f062e59a4daf070cb58666cec30b63db2d3b  PCI: qcom: Rename PERST# assert/deassert helpers for uniformity

elapsed time: 926m

configs tested: 161
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260117    gcc-8.5.0
arc                   randconfig-002-20260117    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                           imxrt_defconfig    clang-22
arm                   randconfig-001-20260117    clang-20
arm                   randconfig-002-20260117    gcc-8.5.0
arm                   randconfig-003-20260117    gcc-8.5.0
arm                   randconfig-004-20260117    gcc-12.5.0
arm64                            alldefconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260117    gcc-15.2.0
arm64                 randconfig-002-20260117    clang-22
arm64                 randconfig-003-20260117    clang-18
arm64                 randconfig-004-20260117    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260117    gcc-12.5.0
csky                  randconfig-002-20260117    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20260117    clang-22
hexagon               randconfig-002-20260117    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260117    clang-20
i386        buildonly-randconfig-002-20260117    gcc-13
i386        buildonly-randconfig-003-20260117    gcc-13
i386        buildonly-randconfig-004-20260117    clang-20
i386        buildonly-randconfig-005-20260117    gcc-13
i386        buildonly-randconfig-006-20260117    clang-20
i386                  randconfig-001-20260117    gcc-13
i386                  randconfig-002-20260117    gcc-14
i386                  randconfig-003-20260117    clang-20
i386                  randconfig-004-20260117    gcc-14
i386                  randconfig-005-20260117    clang-20
i386                  randconfig-006-20260117    clang-20
i386                  randconfig-007-20260117    clang-20
i386                  randconfig-011-20260117    clang-20
i386                  randconfig-012-20260117    gcc-14
i386                  randconfig-013-20260117    gcc-14
i386                  randconfig-014-20260117    gcc-14
i386                  randconfig-015-20260117    gcc-12
i386                  randconfig-016-20260117    clang-20
i386                  randconfig-017-20260117    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260117    clang-20
loongarch             randconfig-002-20260117    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         bigsur_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260117    gcc-8.5.0
nios2                 randconfig-002-20260117    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260117    gcc-12.5.0
parisc                randconfig-002-20260117    gcc-15.2.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260117    gcc-8.5.0
powerpc               randconfig-002-20260117    clang-22
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                     tqm8540_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260117    clang-22
powerpc64             randconfig-002-20260117    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260117    clang-22
riscv                 randconfig-002-20260117    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260117    clang-22
s390                  randconfig-002-20260117    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260117    gcc-10.5.0
sh                    randconfig-002-20260117    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260117    gcc-8.5.0
sparc                 randconfig-002-20260117    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260117    gcc-14.3.0
sparc64               randconfig-002-20260117    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260117    clang-22
um                    randconfig-002-20260117    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260117    clang-20
x86_64      buildonly-randconfig-002-20260117    clang-20
x86_64      buildonly-randconfig-003-20260117    clang-20
x86_64      buildonly-randconfig-004-20260117    clang-20
x86_64      buildonly-randconfig-005-20260117    clang-20
x86_64      buildonly-randconfig-006-20260117    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260117    clang-20
x86_64                randconfig-002-20260117    clang-20
x86_64                randconfig-003-20260117    clang-20
x86_64                randconfig-004-20260117    clang-20
x86_64                randconfig-005-20260117    gcc-12
x86_64                randconfig-006-20260117    gcc-14
x86_64                randconfig-011-20260117    clang-20
x86_64                randconfig-012-20260117    clang-20
x86_64                randconfig-013-20260117    clang-20
x86_64                randconfig-014-20260117    clang-20
x86_64                randconfig-015-20260117    gcc-14
x86_64                randconfig-016-20260117    clang-20
x86_64                randconfig-071-20260117    clang-20
x86_64                randconfig-072-20260117    gcc-13
x86_64                randconfig-073-20260117    clang-20
x86_64                randconfig-074-20260117    clang-20
x86_64                randconfig-075-20260117    clang-20
x86_64                randconfig-076-20260117    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260117    gcc-10.5.0
xtensa                randconfig-002-20260117    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

