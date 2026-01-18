Return-Path: <linux-pci+bounces-45098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F424D39487
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 12:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92291300F321
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 11:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3823AB90;
	Sun, 18 Jan 2026 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVR50OtT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DFB20C477
	for <linux-pci@vger.kernel.org>; Sun, 18 Jan 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768736319; cv=none; b=M1JtPm+bLfXdhqHz7BGXyoE/GEy1wqN47iQXKJbo9zGPZuHphyUiKc4CAClG3S3LTLNm0udzjeAd5WSFSLT9uneYr8gpY9ugD+GsIngEaH9AxHQ7wWzWnAGU5qddGvZFmdYafN1nDp2+jE/bRqMmA1MKwLFZLADoj11nvg4OZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768736319; c=relaxed/simple;
	bh=JrzOcyzhh6HYJDHyFWK8poiOkxU/odjk7HdcooPJxTs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LIhJPzNudSOG7VC+qbmnGboRaHn+sff9BrHXI/D+fMavnF7UexDH1ilATJAyKFsqBwHn9jdynuwMIiZms+zpvJv6oilpj7L00MjhtMvWPCcWlciuUEmwFOpAcW5mxWIBsmCZzwHbXkvlCy1wQy7/ilp+3FeSXgYrlsi6GvZnAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVR50OtT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768736317; x=1800272317;
  h=date:from:to:cc:subject:message-id;
  bh=JrzOcyzhh6HYJDHyFWK8poiOkxU/odjk7HdcooPJxTs=;
  b=LVR50OtT5DTALrGBe6fdFX+gIvtWiTgzYRH6SIU2ueUpAIP0cszZQ7wI
   xOKTkMDGWqJgLVOLLk5tH6mqk7lJQe852PkDhD3VoSQT/G0/PFjkcTuoH
   i15fEaDa8IsMyUacvw7PdEip85rLnd8EQNWe3Afm64c0tEJGMNPBxQAN+
   uUN87OjzDpQ74rpfLwtoX6eYsOTbm9Qp9cduoWY9scrcK3D0frJmS5V38
   EucRtNADJQSTcCAxeEP48onlQFgWar+xJ9PFcXs9FpqLUkYn6leVQAKQQ
   746XURmdeqHQkqY71ATzm1P/pv1HOLHHkxOx3x+3nE6Ulbk9haA5sUZ1Z
   Q==;
X-CSE-ConnectionGUID: MSoxk11aQoyuH3kpHAdkFw==
X-CSE-MsgGUID: KP01fPxDRSihLRJP185iUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="95448022"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="95448022"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 03:38:36 -0800
X-CSE-ConnectionGUID: l6JCPGkrRK+D1rL7TfoKKg==
X-CSE-MsgGUID: urEXdFVsTlaCgLp7FzZ6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="236907349"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jan 2026 03:38:34 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhR72-00000000Mv2-2y9n;
	Sun, 18 Jan 2026 11:38:32 +0000
Date: Sun, 18 Jan 2026 19:38:30 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 e54963e2eaf5ccad416c5e7a6e94d0ba86b5cdd3
Message-ID: <202601181925.8Kb4uW6Z-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: e54963e2eaf5ccad416c5e7a6e94d0ba86b5cdd3  Merge branch 'pci/misc'

elapsed time: 722m

configs tested: 176
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260118    gcc-13.4.0
arc                   randconfig-002-20260118    gcc-14.3.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.2.0
arm                         bcm2835_defconfig    clang-22
arm                                 defconfig    clang-22
arm                   randconfig-001-20260118    gcc-10.5.0
arm                   randconfig-002-20260118    gcc-8.5.0
arm                   randconfig-003-20260118    clang-22
arm                   randconfig-004-20260118    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260118    gcc-8.5.0
arm64                 randconfig-002-20260118    clang-17
arm64                 randconfig-003-20260118    gcc-14.3.0
arm64                 randconfig-004-20260118    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260118    gcc-10.5.0
csky                  randconfig-002-20260118    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20260118    clang-22
hexagon               randconfig-002-20260118    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260118    gcc-14
i386        buildonly-randconfig-002-20260118    clang-20
i386        buildonly-randconfig-003-20260118    gcc-14
i386        buildonly-randconfig-004-20260118    gcc-14
i386        buildonly-randconfig-005-20260118    gcc-14
i386        buildonly-randconfig-006-20260118    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260118    gcc-14
i386                  randconfig-002-20260118    gcc-14
i386                  randconfig-003-20260118    gcc-14
i386                  randconfig-004-20260118    clang-20
i386                  randconfig-005-20260118    clang-20
i386                  randconfig-006-20260118    gcc-14
i386                  randconfig-007-20260118    clang-20
i386                  randconfig-011-20260118    clang-20
i386                  randconfig-012-20260118    clang-20
i386                  randconfig-013-20260118    clang-20
i386                  randconfig-014-20260118    clang-20
i386                  randconfig-015-20260118    clang-20
i386                  randconfig-016-20260118    clang-20
i386                  randconfig-017-20260118    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260118    gcc-15.2.0
loongarch             randconfig-002-20260118    clang-22
m68k                             alldefconfig    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ip32_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260118    gcc-8.5.0
nios2                 randconfig-002-20260118    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260118    gcc-8.5.0
parisc                randconfig-002-20260118    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260118    gcc-11.5.0
powerpc               randconfig-002-20260118    gcc-8.5.0
powerpc64             randconfig-001-20260118    clang-22
powerpc64             randconfig-002-20260118    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20260118    gcc-10.5.0
riscv                 randconfig-002-20260118    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260118    gcc-15.2.0
s390                  randconfig-002-20260118    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                        edosk7705_defconfig    gcc-15.2.0
sh                    randconfig-001-20260118    gcc-15.2.0
sh                    randconfig-002-20260118    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260118    gcc-13.4.0
sparc                 randconfig-002-20260118    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260118    gcc-12.5.0
sparc64               randconfig-002-20260118    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260118    clang-22
um                    randconfig-002-20260118    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260118    gcc-14
x86_64      buildonly-randconfig-002-20260118    clang-20
x86_64      buildonly-randconfig-002-20260118    gcc-14
x86_64      buildonly-randconfig-003-20260118    gcc-14
x86_64      buildonly-randconfig-004-20260118    gcc-14
x86_64      buildonly-randconfig-005-20260118    gcc-14
x86_64      buildonly-randconfig-006-20260118    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260118    gcc-14
x86_64                randconfig-002-20260118    clang-20
x86_64                randconfig-003-20260118    clang-20
x86_64                randconfig-004-20260118    gcc-14
x86_64                randconfig-005-20260118    clang-20
x86_64                randconfig-006-20260118    clang-20
x86_64                randconfig-011-20260118    gcc-12
x86_64                randconfig-012-20260118    gcc-14
x86_64                randconfig-013-20260118    gcc-14
x86_64                randconfig-014-20260118    gcc-14
x86_64                randconfig-015-20260118    clang-20
x86_64                randconfig-016-20260118    gcc-14
x86_64                randconfig-071-20260118    clang-20
x86_64                randconfig-072-20260118    gcc-12
x86_64                randconfig-073-20260118    gcc-14
x86_64                randconfig-074-20260118    clang-20
x86_64                randconfig-075-20260118    gcc-14
x86_64                randconfig-076-20260118    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260118    gcc-8.5.0
xtensa                randconfig-002-20260118    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

