Return-Path: <linux-pci+bounces-36090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED930B562F9
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 22:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346A11B23E5B
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 20:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EE5251791;
	Sat, 13 Sep 2025 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlTpQ7ts"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3E81749
	for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796744; cv=none; b=SAEavrCnvSTRotV83ZszYDmzJoan9Ldr1ngh0rUjfOVAF/s8X5RMERi0l1zF21AGcGXZmJ4+FZKOab1WtXTM16vNiJT48W/ebLgtLDVeTS7U0WJ3EDr8WXMYQ0dcZljvapJHN+YYuBpRxLt/a+LooHdm4JuyJ3cm/dTFlUR7koc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796744; c=relaxed/simple;
	bh=2zJHYmugub1Pp0w8Fci7JknrTFp82ci6BHe7R672vMk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ixTXALVj2z08jys9rnXOODYtDw4FXXuBWwlOkQQj2RQkSTJ2G99+9P8N9msnbbsXqDdgJgdG0yKqV2rfNFvp4+JbgcD0AtkOgMzS1II9qD6MItGxP/G4Uk/5DQ1iGA9fIW5a29vrGik3iJ5XZbLWjQOsqK76vDsC23F5tM463PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlTpQ7ts; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757796743; x=1789332743;
  h=date:from:to:cc:subject:message-id;
  bh=2zJHYmugub1Pp0w8Fci7JknrTFp82ci6BHe7R672vMk=;
  b=MlTpQ7tsVQy0Q424HZyLCkBrO/cTsWm+XfUrLtHkr5Ycouw4vDpcOV1g
   g8NFtZ3HaZTKOQ2bw4Lraqc/12OZhLz0yx//FBSGRuMUFmAcJ/qX+WP32
   IsXOYZqi5mDelakawAQKzIn33UhZE2KNarComvcmaWLcje3csN7+S1f0s
   nnnimeoSqluDxyttLIcWfrM7y5AxpGZSkImJE0G+ksxiaJYl2IFyCw0AJ
   WndTUAmlOiEg1l8lAgKibN3kaUVbpM17hSGIbI5CsFDHSdY61JZDsLAUy
   HrlmraIclUp1LQ/cJFUfXu02SStX6Ic5UAjMiCjIRlOcplFzsyBQ9TkLY
   w==;
X-CSE-ConnectionGUID: PpIWLiu/TA6SZuduqoxpAg==
X-CSE-MsgGUID: vCkVuvIhT22JRQ75848SNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="59145476"
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="59145476"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 13:52:22 -0700
X-CSE-ConnectionGUID: 53u6aJCKS2eu0JM1fDi9tQ==
X-CSE-MsgGUID: GI/OrHsESkqAKlWBUx4Hfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="173808945"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 13 Sep 2025 13:52:21 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxXEI-0001qp-0d;
	Sat, 13 Sep 2025 20:52:18 +0000
Date: Sun, 14 Sep 2025 04:52:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:of] BUILD SUCCESS
 fad8e97854504bcd2dc108703fc7d25749945097
Message-ID: <202509140454.gRk4rkFe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git of
branch HEAD: fad8e97854504bcd2dc108703fc7d25749945097  PCI: of: Update parent unit address generation in of_pci_prop_intr_map()

elapsed time: 1443m

configs tested: 209
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250913    gcc-10.5.0
arc                   randconfig-002-20250913    gcc-11.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                       netwinder_defconfig    clang-18
arm                   randconfig-001-20250913    clang-20
arm                   randconfig-002-20250913    clang-22
arm                   randconfig-003-20250913    clang-22
arm                   randconfig-004-20250913    gcc-14.3.0
arm                         s3c6400_defconfig    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250913    clang-22
arm64                 randconfig-002-20250913    gcc-14.3.0
arm64                 randconfig-003-20250913    clang-22
arm64                 randconfig-004-20250913    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250913    gcc-11.5.0
csky                  randconfig-002-20250913    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250913    clang-16
hexagon               randconfig-002-20250913    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250913    gcc-14
i386        buildonly-randconfig-002-20250913    clang-20
i386        buildonly-randconfig-003-20250913    clang-20
i386        buildonly-randconfig-004-20250913    clang-20
i386        buildonly-randconfig-005-20250913    clang-20
i386        buildonly-randconfig-006-20250913    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250913    gcc-14
i386                  randconfig-001-20250914    gcc-14
i386                  randconfig-002-20250913    gcc-14
i386                  randconfig-002-20250914    gcc-14
i386                  randconfig-003-20250913    gcc-14
i386                  randconfig-003-20250914    gcc-14
i386                  randconfig-004-20250913    gcc-14
i386                  randconfig-004-20250914    gcc-14
i386                  randconfig-005-20250913    gcc-14
i386                  randconfig-005-20250914    gcc-14
i386                  randconfig-006-20250913    gcc-14
i386                  randconfig-006-20250914    gcc-14
i386                  randconfig-007-20250913    gcc-14
i386                  randconfig-007-20250914    gcc-14
i386                  randconfig-011-20250913    clang-20
i386                  randconfig-012-20250913    clang-20
i386                  randconfig-013-20250913    clang-20
i386                  randconfig-014-20250913    clang-20
i386                  randconfig-015-20250913    clang-20
i386                  randconfig-016-20250913    clang-20
i386                  randconfig-017-20250913    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250913    clang-18
loongarch             randconfig-002-20250913    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250913    gcc-8.5.0
nios2                 randconfig-002-20250913    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250913    gcc-12.5.0
parisc                randconfig-002-20250913    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc                       ppc64_defconfig    clang-18
powerpc               randconfig-001-20250913    gcc-8.5.0
powerpc               randconfig-002-20250913    clang-22
powerpc               randconfig-003-20250913    gcc-10.5.0
powerpc                     sequoia_defconfig    clang-18
powerpc                     skiroot_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250913    gcc-10.5.0
powerpc64             randconfig-002-20250913    clang-22
powerpc64             randconfig-003-20250913    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250913    gcc-13.4.0
riscv                 randconfig-002-20250913    clang-20
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250913    clang-22
s390                  randconfig-002-20250913    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.1.0
sh                             espt_defconfig    clang-18
sh                    randconfig-001-20250913    gcc-9.5.0
sh                    randconfig-002-20250913    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250913    gcc-15.1.0
sparc                 randconfig-002-20250913    gcc-8.5.0
sparc                       sparc32_defconfig    clang-18
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250913    gcc-8.5.0
sparc64               randconfig-002-20250913    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250913    gcc-14
um                    randconfig-002-20250913    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250913    clang-20
x86_64      buildonly-randconfig-002-20250913    gcc-14
x86_64      buildonly-randconfig-003-20250913    gcc-12
x86_64      buildonly-randconfig-004-20250913    gcc-14
x86_64      buildonly-randconfig-005-20250913    clang-20
x86_64      buildonly-randconfig-006-20250913    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250913    clang-20
x86_64                randconfig-002-20250913    clang-20
x86_64                randconfig-003-20250913    clang-20
x86_64                randconfig-004-20250913    clang-20
x86_64                randconfig-005-20250913    clang-20
x86_64                randconfig-006-20250913    clang-20
x86_64                randconfig-007-20250913    clang-20
x86_64                randconfig-008-20250913    clang-20
x86_64                randconfig-071-20250913    gcc-14
x86_64                randconfig-071-20250914    gcc-14
x86_64                randconfig-072-20250913    gcc-14
x86_64                randconfig-072-20250914    gcc-14
x86_64                randconfig-073-20250913    gcc-14
x86_64                randconfig-073-20250914    gcc-14
x86_64                randconfig-074-20250913    gcc-14
x86_64                randconfig-074-20250914    gcc-14
x86_64                randconfig-075-20250913    gcc-14
x86_64                randconfig-075-20250914    gcc-14
x86_64                randconfig-076-20250913    gcc-14
x86_64                randconfig-076-20250914    gcc-14
x86_64                randconfig-077-20250913    gcc-14
x86_64                randconfig-077-20250914    gcc-14
x86_64                randconfig-078-20250913    gcc-14
x86_64                randconfig-078-20250914    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250913    gcc-14.3.0
xtensa                randconfig-002-20250913    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

