Return-Path: <linux-pci+bounces-32856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5E4B0FD2B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 01:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F991C815CA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 23:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D4F136349;
	Wed, 23 Jul 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hj4pP5sV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289672F872
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753311753; cv=none; b=UK4rvmN576DgxCcx7Q23n8g17QUcueNL5Gf02GGS9L+uePBIDViKhPoFPLEHrLBLY1BdPeS/OXIRwUHjojaMaSylwhvtJB+5OyNrMs+PdHQDMfTo/oG50G0HBh0FAqlERWU4J/ad8zMLkreF6Q4gi9Uw4rFwEe0XtxuKVyhXO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753311753; c=relaxed/simple;
	bh=OpCfZCI4ecKrG8NJU4xsO5XMH4Qu8+hUSH0bIowYeEU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hD3gBUmcZqV1f1Dff08NfQhdUh9w9yDWa9D+BffsQg84k87AmAdClhG0xhkWsSuQgEXrr8vGjDdR2WWo6ctrvv0x1Bbqct/IZ06R+PNChEk7XHpoGgLq0b9ZYWW4r2lP23QhaWZSUUjGu/hnQ59lO4TV7AKpDhnj2yeYy4IcDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hj4pP5sV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753311752; x=1784847752;
  h=date:from:to:cc:subject:message-id;
  bh=OpCfZCI4ecKrG8NJU4xsO5XMH4Qu8+hUSH0bIowYeEU=;
  b=Hj4pP5sVR28Xm/wGR4oVZl8IKkxfio6P100XuKO92zYHKr5m262I5sdh
   byZ2NCFgg8Tvr2mobQ7ElEFsOCkdRG5jhBwK8fSz6Dbz/IpMrU+mNUhc6
   FhPRXQWiSg/y3NSH5XmwBg6MMZJ+zYXOFgenPLE/ecg2uVHrtgWYLnz3k
   5JXI3R9cZnXB0XaDUr/EK9+zjX/I0jFRJf1/RrK6L5/Wzx/yeWVdpTjgD
   rm67RcBeE8jfbJn28pEFN6PxPguJ1yXZfRMtszUH7F9ajuy7ehumRUnN4
   KfI62WRBQHmzky51F++x1j/9co68C+QZYC8+5kEtUTVpBShGzOj1pjWdg
   w==;
X-CSE-ConnectionGUID: vsINunZhSJOEXZwJNbe4rw==
X-CSE-MsgGUID: 0+Gkz2FhR2KkbC/BLyvYQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59413342"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="59413342"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 16:02:32 -0700
X-CSE-ConnectionGUID: WU7bUfJhQLmONfBZiUmcGw==
X-CSE-MsgGUID: M8I4gGihTjqWK7yhqgOVHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="160056657"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 23 Jul 2025 16:02:30 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueiTk-000Jre-0H;
	Wed, 23 Jul 2025 23:02:28 +0000
Date: Thu, 24 Jul 2025 07:02:22 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 6fac07c899c5cf015174be8a910fff0dcddf67a0
Message-ID: <202507240709.MEIkUg7r-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 6fac07c899c5cf015174be8a910fff0dcddf67a0  PCI: Set native_pcie_hotplug up front based on pcie_ports_native

elapsed time: 1425m

configs tested: 233
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
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
arc                                 defconfig    clang-19
arc                   randconfig-001-20250723    clang-16
arc                   randconfig-001-20250723    gcc-8.5.0
arc                   randconfig-002-20250723    clang-16
arc                   randconfig-002-20250723    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          ixp4xx_defconfig    clang-22
arm                   randconfig-001-20250723    clang-16
arm                   randconfig-001-20250723    gcc-13.4.0
arm                   randconfig-002-20250723    clang-16
arm                   randconfig-002-20250723    gcc-13.4.0
arm                   randconfig-003-20250723    clang-16
arm                   randconfig-004-20250723    clang-16
arm                   randconfig-004-20250723    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250723    clang-16
arm64                 randconfig-001-20250723    clang-22
arm64                 randconfig-002-20250723    clang-16
arm64                 randconfig-003-20250723    clang-16
arm64                 randconfig-004-20250723    clang-16
arm64                 randconfig-004-20250723    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250723    gcc-12.5.0
csky                  randconfig-001-20250723    gcc-8.5.0
csky                  randconfig-002-20250723    gcc-14.3.0
csky                  randconfig-002-20250723    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250723    clang-22
hexagon               randconfig-001-20250723    gcc-8.5.0
hexagon               randconfig-002-20250723    clang-22
hexagon               randconfig-002-20250723    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250723    clang-20
i386        buildonly-randconfig-002-20250723    clang-20
i386        buildonly-randconfig-003-20250723    clang-20
i386        buildonly-randconfig-004-20250723    clang-20
i386        buildonly-randconfig-005-20250723    clang-20
i386        buildonly-randconfig-005-20250723    gcc-11
i386        buildonly-randconfig-006-20250723    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250723    clang-20
i386                  randconfig-002-20250723    clang-20
i386                  randconfig-003-20250723    clang-20
i386                  randconfig-004-20250723    clang-20
i386                  randconfig-005-20250723    clang-20
i386                  randconfig-006-20250723    clang-20
i386                  randconfig-007-20250723    clang-20
i386                  randconfig-011-20250723    clang-20
i386                  randconfig-012-20250723    clang-20
i386                  randconfig-013-20250723    clang-20
i386                  randconfig-014-20250723    clang-20
i386                  randconfig-015-20250723    clang-20
i386                  randconfig-016-20250723    clang-20
i386                  randconfig-017-20250723    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250723    gcc-15.1.0
loongarch             randconfig-001-20250723    gcc-8.5.0
loongarch             randconfig-002-20250723    clang-22
loongarch             randconfig-002-20250723    gcc-8.5.0
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
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250723    gcc-8.5.0
nios2                 randconfig-002-20250723    gcc-11.5.0
nios2                 randconfig-002-20250723    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250723    gcc-8.5.0
parisc                randconfig-002-20250723    gcc-15.1.0
parisc                randconfig-002-20250723    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-22
powerpc                       holly_defconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc                    mvme5100_defconfig    clang-22
powerpc               randconfig-001-20250723    gcc-10.5.0
powerpc               randconfig-001-20250723    gcc-8.5.0
powerpc               randconfig-002-20250723    gcc-8.5.0
powerpc               randconfig-003-20250723    gcc-12.5.0
powerpc               randconfig-003-20250723    gcc-8.5.0
powerpc64             randconfig-001-20250723    clang-22
powerpc64             randconfig-001-20250723    gcc-8.5.0
powerpc64             randconfig-002-20250723    clang-22
powerpc64             randconfig-002-20250723    gcc-8.5.0
powerpc64             randconfig-003-20250723    clang-22
powerpc64             randconfig-003-20250723    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20250723    gcc-9.5.0
riscv                 randconfig-002-20250723    clang-22
riscv                 randconfig-002-20250723    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250723    clang-22
s390                  randconfig-001-20250723    gcc-9.5.0
s390                  randconfig-002-20250723    clang-20
s390                  randconfig-002-20250723    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250723    gcc-12.5.0
sh                    randconfig-001-20250723    gcc-9.5.0
sh                    randconfig-002-20250723    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250723    gcc-8.5.0
sparc                 randconfig-001-20250723    gcc-9.5.0
sparc                 randconfig-002-20250723    gcc-8.5.0
sparc                 randconfig-002-20250723    gcc-9.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250723    gcc-12.5.0
sparc64               randconfig-001-20250723    gcc-9.5.0
sparc64               randconfig-002-20250723    gcc-14.3.0
sparc64               randconfig-002-20250723    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250723    gcc-12
um                    randconfig-001-20250723    gcc-9.5.0
um                    randconfig-002-20250723    clang-22
um                    randconfig-002-20250723    gcc-9.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250723    gcc-11
x86_64      buildonly-randconfig-001-20250723    gcc-12
x86_64      buildonly-randconfig-002-20250723    gcc-11
x86_64      buildonly-randconfig-003-20250723    gcc-11
x86_64      buildonly-randconfig-004-20250723    clang-20
x86_64      buildonly-randconfig-004-20250723    gcc-11
x86_64      buildonly-randconfig-005-20250723    gcc-11
x86_64      buildonly-randconfig-005-20250723    gcc-12
x86_64      buildonly-randconfig-006-20250723    gcc-11
x86_64      buildonly-randconfig-006-20250723    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250723    gcc-12
x86_64                randconfig-002-20250723    gcc-12
x86_64                randconfig-003-20250723    gcc-12
x86_64                randconfig-004-20250723    gcc-12
x86_64                randconfig-005-20250723    gcc-12
x86_64                randconfig-006-20250723    gcc-12
x86_64                randconfig-007-20250723    gcc-12
x86_64                randconfig-008-20250723    gcc-12
x86_64                randconfig-071-20250723    clang-20
x86_64                randconfig-072-20250723    clang-20
x86_64                randconfig-073-20250723    clang-20
x86_64                randconfig-074-20250723    clang-20
x86_64                randconfig-075-20250723    clang-20
x86_64                randconfig-076-20250723    clang-20
x86_64                randconfig-077-20250723    clang-20
x86_64                randconfig-078-20250723    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    clang-22
xtensa                randconfig-001-20250723    gcc-13.4.0
xtensa                randconfig-001-20250723    gcc-9.5.0
xtensa                randconfig-002-20250723    gcc-10.5.0
xtensa                randconfig-002-20250723    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

