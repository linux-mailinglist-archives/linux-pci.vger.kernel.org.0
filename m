Return-Path: <linux-pci+bounces-15700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC8A9B78E3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 11:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37851F25046
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB719993C;
	Thu, 31 Oct 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhyZMBug"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC631953A2
	for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371393; cv=none; b=O8Z41AKMwp6gp/E1i3f4or1R6b3R+lRHcKC4VRPqTiBavzmPOPK8ZfLCDKpsMV042vhb2t1p8nhTu2/8GvoO/UdduUCrD8koUmT8p4uFcAh7/OF81Y/QJZ4+fSYm5iyc6vG9J2xHsSPbLWWvskpTtSam1Hs16jPm3y1NHzAaGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371393; c=relaxed/simple;
	bh=iaKO07lkVHacYDcjDS+AtLCm0iagziA0Jr7M8qJ0jSA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oUD5hpnE6IFXu+bzh15Og5BA+vliJVjykX8i0T+0SXYsAs2iXm2cdsRsXroS9OVX9PmOw+7m2DifdwKrja4nijGdwsfji80IAd/ZotplIUbX/x019W6NJRAIwHUhKcoqiAUYGAU7LN+Ed+WncIU8N9oIAp/IGSXy0DiwkXluh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhyZMBug; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730371391; x=1761907391;
  h=date:from:to:cc:subject:message-id;
  bh=iaKO07lkVHacYDcjDS+AtLCm0iagziA0Jr7M8qJ0jSA=;
  b=nhyZMBugjcoGxCZCD0mwdG8UjdTg0iUh2AC3GvLOzwa/p43wJwsQ1T3H
   xtTWcfm4Z38+ZAhVZpGHMc1tYU+phKHRAoz3P9ONazT6dYOLDb6mV2Qjn
   Xs2wyv5qPmyrFZzy1088fhZbe0YIYQ9KtwFtsKec/FxxTfi4J+8DtWNeR
   p+K7YV+kB8rX4vzt64yUyGGpD7ZSw/Iav0om2bH4+RR+nzQn1gYv5k8J/
   rtYNPLoMK9+hb4pgwTzrTK8D4W9zxkrW+cp8Spq0oyX0Ojgt1AbltJQIE
   U3zuwdCdvp/d4ux8kVaW8fIovJLaohMeGDLTHEagl7uf7v+1JoaKnXeUN
   Q==;
X-CSE-ConnectionGUID: q9jth0S4R8y0dqV0RD0F1g==
X-CSE-MsgGUID: p4h4G3d9R6yv9qguiGuNeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55501208"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="55501208"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:43:10 -0700
X-CSE-ConnectionGUID: SCvrxgZdTfOi+OGbAgtvvw==
X-CSE-MsgGUID: 18lHnZyHSpWMtQfrav+lhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="83395900"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 31 Oct 2024 03:43:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Sdu-000fzQ-2C;
	Thu, 31 Oct 2024 10:43:06 +0000
Date: Thu, 31 Oct 2024 18:42:35 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devm] BUILD SUCCESS
 cd94c0b68dce4e751a51bd52fabde359842a3312
Message-ID: <202410311821.C2s3dFG0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devm
branch HEAD: cd94c0b68dce4e751a51bd52fabde359842a3312  ethernet: cavium: Replace deprecated PCI functions

elapsed time: 766m

configs tested: 134
configs skipped: 4

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
arc                 nsimosci_hs_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                        clps711x_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                         lpc18xx_defconfig    clang-20
arm                            qcom_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241031    clang-19
i386        buildonly-randconfig-002-20241031    clang-19
i386        buildonly-randconfig-003-20241031    clang-19
i386        buildonly-randconfig-004-20241031    clang-19
i386        buildonly-randconfig-005-20241031    clang-19
i386        buildonly-randconfig-006-20241031    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241031    clang-19
i386                  randconfig-002-20241031    clang-19
i386                  randconfig-003-20241031    clang-19
i386                  randconfig-004-20241031    clang-19
i386                  randconfig-005-20241031    clang-19
i386                  randconfig-006-20241031    clang-19
i386                  randconfig-011-20241031    clang-19
i386                  randconfig-012-20241031    clang-19
i386                  randconfig-013-20241031    clang-19
i386                  randconfig-014-20241031    clang-19
i386                  randconfig-015-20241031    clang-19
i386                  randconfig-016-20241031    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                            gpr_defconfig    clang-20
mips                          rb532_defconfig    clang-20
mips                         rt305x_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                     tqm8540_defconfig    clang-20
powerpc                     tqm8560_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                      rts7751r2d1_defconfig    clang-20
sh                           se7721_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241031    clang-19
x86_64      buildonly-randconfig-002-20241031    clang-19
x86_64      buildonly-randconfig-003-20241031    clang-19
x86_64      buildonly-randconfig-004-20241031    clang-19
x86_64      buildonly-randconfig-005-20241031    clang-19
x86_64      buildonly-randconfig-006-20241031    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241031    clang-19
x86_64                randconfig-002-20241031    clang-19
x86_64                randconfig-003-20241031    clang-19
x86_64                randconfig-004-20241031    clang-19
x86_64                randconfig-005-20241031    clang-19
x86_64                randconfig-006-20241031    clang-19
x86_64                randconfig-011-20241031    clang-19
x86_64                randconfig-012-20241031    clang-19
x86_64                randconfig-013-20241031    clang-19
x86_64                randconfig-014-20241031    clang-19
x86_64                randconfig-015-20241031    clang-19
x86_64                randconfig-016-20241031    clang-19
x86_64                randconfig-071-20241031    clang-19
x86_64                randconfig-072-20241031    clang-19
x86_64                randconfig-073-20241031    clang-19
x86_64                randconfig-074-20241031    clang-19
x86_64                randconfig-075-20241031    clang-19
x86_64                randconfig-076-20241031    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

