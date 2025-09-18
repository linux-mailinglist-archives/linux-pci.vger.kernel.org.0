Return-Path: <linux-pci+bounces-36436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D836AB86C4D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 21:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92417AEF06
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 19:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468D12DAFD7;
	Thu, 18 Sep 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmMpmN8E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02B2DAFD2
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225056; cv=none; b=Gbxj4oM1WNncym+QT/R/tAxq3jxNxiNwl2r5PfPd6Mku44lOvbhAsoijcm58A7brgubO+0+IcVsP82/SzE61yJjWrpi2k/u9sfrEIxJ4VGlimDktDFJE68JlkSJw5MeY967SjGKM3qbQeXXW1FFkWC/eDZSpYfIo+SauQsbhUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225056; c=relaxed/simple;
	bh=udJ6Ufuu+1gqYU9CpbMazhC3JMW6VBQotYtjQRlZwb0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=plKwn+X03AwCtgBI9dKhEdVnPEX75PBENoDrTc48iz3eOHeuMefAnJTs+l/HUS8PYGNbg9gIpePVUhndUqfNmOp27okqnzvT6/lJjxmnstKbI7/z6GIWM3+/EwdTUtXGgQyVZ9UT/dS5WwCjlHYoXUq0dH96x+ne++hZiSdzxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmMpmN8E; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758225053; x=1789761053;
  h=date:from:to:cc:subject:message-id;
  bh=udJ6Ufuu+1gqYU9CpbMazhC3JMW6VBQotYtjQRlZwb0=;
  b=RmMpmN8EuqkVx2e0ENwxvLA7M3YcX58H9/LHXbxbV+poHd1WGB8wtCWU
   OFVwAdZkDx76jImEUK6+9F/Uw6ukAjtNqvVrtinC6kVGq7O3VGR7wtoXU
   sQO69fcaDRKMzqO46ZJYObI/qPxh1/s/U836YXLlVJsZvO1SYKOdqG5Dr
   B765Nq99BJ4gdcZi3GLzAMyzUgVIYYdvEv5K+XJ6SPM2IEQSCdv2rZRRF
   hPm258ED0FhROULhjLBSMJZw3M4ohky4kEZc7Cy4YPdcBhljgT0MUYKi7
   urvvF2oSFmUmt0d53FBTDvovXobmrbqNAaqtlrck6lJY7eg73QDNfU8Bm
   Q==;
X-CSE-ConnectionGUID: /ZI2Rc2uSzOzCpN1NS/WOg==
X-CSE-MsgGUID: WgZFY2X+Q6OtsT36D61ysw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60722236"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="60722236"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:50:53 -0700
X-CSE-ConnectionGUID: cCqqWVupSdmkZsnlYpzh1w==
X-CSE-MsgGUID: VRidGKZbQ7iKSVgOkxw8TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="180927002"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Sep 2025 12:50:52 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzKeX-0003ff-30;
	Thu, 18 Sep 2025 19:50:49 +0000
Date: Fri, 19 Sep 2025 03:50:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pm] BUILD SUCCESS
 ac180f42e5a831325e77d54fe5d4bf06e0c26430
Message-ID: <202509190322.wdFBRwyr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
branch HEAD: ac180f42e5a831325e77d54fe5d4bf06e0c26430  PCI/PM: Skip resuming to D0 if device is disconnected

elapsed time: 1287m

configs tested: 289
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                          axs101_defconfig    clang-22
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250918    clang-22
arc                   randconfig-001-20250918    gcc-8.5.0
arc                   randconfig-001-20250919    gcc-11.5.0
arc                   randconfig-002-20250918    clang-22
arc                   randconfig-002-20250918    gcc-8.5.0
arc                   randconfig-002-20250919    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   milbeaut_m10v_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-001-20250919    gcc-11.5.0
arm                   randconfig-002-20250918    clang-22
arm                   randconfig-002-20250918    gcc-8.5.0
arm                   randconfig-002-20250919    gcc-11.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-003-20250919    gcc-11.5.0
arm                   randconfig-004-20250918    clang-22
arm                   randconfig-004-20250918    gcc-11.5.0
arm                   randconfig-004-20250919    gcc-11.5.0
arm                         s5pv210_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-001-20250919    gcc-11.5.0
arm64                 randconfig-002-20250918    clang-22
arm64                 randconfig-002-20250918    gcc-11.5.0
arm64                 randconfig-002-20250919    gcc-11.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-003-20250919    gcc-11.5.0
arm64                 randconfig-004-20250918    clang-22
arm64                 randconfig-004-20250919    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250918    clang-22
csky                  randconfig-001-20250918    gcc-15.1.0
csky                  randconfig-001-20250919    clang-22
csky                  randconfig-002-20250918    clang-22
csky                  randconfig-002-20250918    gcc-15.1.0
csky                  randconfig-002-20250919    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-001-20250919    clang-22
hexagon               randconfig-002-20250918    clang-22
hexagon               randconfig-002-20250919    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250918    clang-20
i386        buildonly-randconfig-001-20250918    gcc-14
i386        buildonly-randconfig-001-20250919    gcc-14
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-002-20250919    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-003-20250919    gcc-14
i386        buildonly-randconfig-004-20250918    clang-20
i386        buildonly-randconfig-004-20250918    gcc-14
i386        buildonly-randconfig-004-20250919    gcc-14
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-005-20250919    gcc-14
i386        buildonly-randconfig-006-20250918    clang-20
i386        buildonly-randconfig-006-20250918    gcc-14
i386        buildonly-randconfig-006-20250919    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250918    gcc-14
i386                  randconfig-001-20250919    gcc-14
i386                  randconfig-002-20250918    gcc-14
i386                  randconfig-002-20250919    gcc-14
i386                  randconfig-003-20250918    gcc-14
i386                  randconfig-003-20250919    gcc-14
i386                  randconfig-004-20250918    gcc-14
i386                  randconfig-004-20250919    gcc-14
i386                  randconfig-005-20250918    gcc-14
i386                  randconfig-005-20250919    gcc-14
i386                  randconfig-006-20250918    gcc-14
i386                  randconfig-006-20250919    gcc-14
i386                  randconfig-007-20250918    gcc-14
i386                  randconfig-007-20250919    gcc-14
i386                  randconfig-011-20250918    gcc-14
i386                  randconfig-011-20250919    clang-20
i386                  randconfig-012-20250918    gcc-14
i386                  randconfig-012-20250919    clang-20
i386                  randconfig-013-20250918    gcc-14
i386                  randconfig-013-20250919    clang-20
i386                  randconfig-014-20250918    gcc-14
i386                  randconfig-014-20250919    clang-20
i386                  randconfig-015-20250918    gcc-14
i386                  randconfig-015-20250919    clang-20
i386                  randconfig-016-20250918    gcc-14
i386                  randconfig-016-20250919    clang-20
i386                  randconfig-017-20250918    gcc-14
i386                  randconfig-017-20250919    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250918    clang-18
loongarch             randconfig-001-20250918    clang-22
loongarch             randconfig-001-20250919    clang-22
loongarch             randconfig-002-20250918    clang-18
loongarch             randconfig-002-20250918    clang-22
loongarch             randconfig-002-20250919    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                         amcore_defconfig    clang-22
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
mips                           mtx1_defconfig    clang-22
mips                         rt305x_defconfig    clang-22
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250918    clang-22
nios2                 randconfig-001-20250918    gcc-10.5.0
nios2                 randconfig-001-20250919    clang-22
nios2                 randconfig-002-20250918    clang-22
nios2                 randconfig-002-20250918    gcc-8.5.0
nios2                 randconfig-002-20250919    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250918    clang-22
parisc                randconfig-001-20250918    gcc-12.5.0
parisc                randconfig-001-20250919    clang-22
parisc                randconfig-002-20250918    clang-22
parisc                randconfig-002-20250918    gcc-8.5.0
parisc                randconfig-002-20250919    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250918    clang-22
powerpc               randconfig-001-20250918    gcc-9.5.0
powerpc               randconfig-001-20250919    clang-22
powerpc               randconfig-002-20250918    clang-17
powerpc               randconfig-002-20250918    clang-22
powerpc               randconfig-002-20250919    clang-22
powerpc               randconfig-003-20250918    clang-19
powerpc               randconfig-003-20250918    clang-22
powerpc               randconfig-003-20250919    clang-22
powerpc64             randconfig-001-20250918    clang-22
powerpc64             randconfig-001-20250918    gcc-8.5.0
powerpc64             randconfig-001-20250919    clang-22
powerpc64             randconfig-002-20250918    clang-22
powerpc64             randconfig-002-20250918    gcc-14.3.0
powerpc64             randconfig-002-20250919    clang-22
powerpc64             randconfig-003-20250918    clang-22
powerpc64             randconfig-003-20250919    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-001-20250918    gcc-10.5.0
riscv                 randconfig-001-20250919    gcc-10.5.0
riscv                 randconfig-002-20250918    gcc-10.5.0
riscv                 randconfig-002-20250918    gcc-9.5.0
riscv                 randconfig-002-20250919    gcc-10.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250918    gcc-10.5.0
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-001-20250919    gcc-10.5.0
s390                  randconfig-002-20250918    gcc-10.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
s390                  randconfig-002-20250919    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250918    gcc-10.5.0
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-001-20250919    gcc-10.5.0
sh                    randconfig-002-20250918    gcc-10.5.0
sh                    randconfig-002-20250919    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-10.5.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-001-20250919    gcc-10.5.0
sparc                 randconfig-002-20250918    gcc-10.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc                 randconfig-002-20250919    gcc-10.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-001-20250918    gcc-10.5.0
sparc64               randconfig-001-20250919    gcc-10.5.0
sparc64               randconfig-002-20250918    gcc-10.5.0
sparc64               randconfig-002-20250918    gcc-8.5.0
sparc64               randconfig-002-20250919    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250918    clang-22
um                    randconfig-001-20250918    gcc-10.5.0
um                    randconfig-001-20250919    gcc-10.5.0
um                    randconfig-002-20250918    clang-18
um                    randconfig-002-20250918    gcc-10.5.0
um                    randconfig-002-20250919    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250918    gcc-12
x86_64                randconfig-001-20250919    clang-20
x86_64                randconfig-002-20250918    gcc-12
x86_64                randconfig-002-20250919    clang-20
x86_64                randconfig-003-20250918    gcc-12
x86_64                randconfig-003-20250919    clang-20
x86_64                randconfig-004-20250918    gcc-12
x86_64                randconfig-004-20250919    clang-20
x86_64                randconfig-005-20250918    gcc-12
x86_64                randconfig-005-20250919    clang-20
x86_64                randconfig-006-20250918    gcc-12
x86_64                randconfig-006-20250919    clang-20
x86_64                randconfig-007-20250918    gcc-12
x86_64                randconfig-007-20250919    clang-20
x86_64                randconfig-008-20250918    gcc-12
x86_64                randconfig-008-20250919    clang-20
x86_64                randconfig-071-20250918    clang-20
x86_64                randconfig-072-20250918    clang-20
x86_64                randconfig-073-20250918    clang-20
x86_64                randconfig-074-20250918    clang-20
x86_64                randconfig-075-20250918    clang-20
x86_64                randconfig-076-20250918    clang-20
x86_64                randconfig-077-20250918    clang-20
x86_64                randconfig-078-20250918    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-10.5.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-001-20250919    gcc-10.5.0
xtensa                randconfig-002-20250918    gcc-10.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0
xtensa                randconfig-002-20250919    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

