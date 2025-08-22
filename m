Return-Path: <linux-pci+bounces-34526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A8B3100F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730A77A4808
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 07:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAEC7261B;
	Fri, 22 Aug 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtP5IQTu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D719539F
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846956; cv=none; b=hw+Y+GnmBhoFmIm/ayfg+bXfrP82EifK7kGbmOhVnF69wt/DYKm5UFNgqD9xGDPyZiV9GofuABB8Z9SQZTGmxC2F2cV0KYqBldggraVxpnmdGF0YXgjmKDg4RREUQA4daydtea09YflZiiWPVMTCbt2fnvJUNbj/+3/PiHCcflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846956; c=relaxed/simple;
	bh=JMhOJ0i9Uty76ogSBfHiI6Qwh7CvaY4A7368TDtqUVg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hlBjC3DN4sC/s19SCChVwzv32Pg0kJbg/Fqrve4aXJv2ezYSjAxq8Sz78qhFpJfJgJiTF7whTsPkoOSI0fH5cSdWVNTuqnkndm0d2a45MRldNAyzSpJ+h9aUxE3WlOh61WQSmNrmzXkFmtXPY/K3MaMSuTRT8O+p1gN9r4UB9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtP5IQTu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755846955; x=1787382955;
  h=date:from:to:cc:subject:message-id;
  bh=JMhOJ0i9Uty76ogSBfHiI6Qwh7CvaY4A7368TDtqUVg=;
  b=jtP5IQTu2z/cKaCpWPwTbYJ1fB+HHFJUO2mH7b+GpDFg75ytvritDvN/
   sP2wYhTTXimD0eVWn6RMEWwtNbiGpDQXAhCQSKV1+QuOTc7WQ0/dfgIWY
   Io10KyNandFeryYRYyLSOy0a3rgAosTv/UgPFtm9mI/ZiIr4JZ2aOONHC
   yJeP9s2Uh6Ytqjj4EpIok4yrI1NPI0phycF+FKP7j+d9q0V54s+pFaqES
   9jv6AQC3uoPLEr+OMRNoYIb/pYTjj/IgG/JFedGL9o8rMASBkkRc1f/Nw
   EiIXRePBdD9hMME9resZkup2crxOJMp+E6QlaZMX2/RImg03KUq7T+N70
   g==;
X-CSE-ConnectionGUID: zshE8jcyTja8l53ggyLMUA==
X-CSE-MsgGUID: Fw2cx5LKRAGWM80nRPsupA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58217116"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58217116"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 00:15:54 -0700
X-CSE-ConnectionGUID: rI4NTThhQhWSwN67aE52lw==
X-CSE-MsgGUID: xHLM7AwQTsaE9AJeAmJl4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172830787"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Aug 2025 00:15:53 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upM06-000L0N-2M;
	Fri, 22 Aug 2025 07:15:50 +0000
Date: Fri, 22 Aug 2025 15:14:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 d153590f80a34b64d2f05291511c38319d048d7f
Message-ID: <202508221550.DFEPDVXV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: d153590f80a34b64d2f05291511c38319d048d7f  PCI: Fix failure detection during resource resize

elapsed time: 886m

configs tested: 200
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250822    clang-22
arc                   randconfig-001-20250822    gcc-8.5.0
arc                   randconfig-002-20250822    clang-22
arc                   randconfig-002-20250822    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                         mv78xx0_defconfig    gcc-15.1.0
arm                   randconfig-001-20250822    clang-22
arm                   randconfig-002-20250822    clang-22
arm                   randconfig-002-20250822    gcc-8.5.0
arm                   randconfig-003-20250822    clang-22
arm                   randconfig-004-20250822    clang-22
arm                   randconfig-004-20250822    gcc-8.5.0
arm                          sp7021_defconfig    gcc-15.1.0
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250822    clang-22
arm64                 randconfig-002-20250822    clang-22
arm64                 randconfig-003-20250822    clang-17
arm64                 randconfig-003-20250822    clang-22
arm64                 randconfig-004-20250822    clang-22
arm64                 randconfig-004-20250822    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250822    clang-22
csky                  randconfig-001-20250822    gcc-9.5.0
csky                  randconfig-002-20250822    clang-22
csky                  randconfig-002-20250822    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250822    clang-22
hexagon               randconfig-002-20250822    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250822    clang-20
i386        buildonly-randconfig-001-20250822    gcc-12
i386        buildonly-randconfig-002-20250822    clang-20
i386        buildonly-randconfig-003-20250822    clang-20
i386        buildonly-randconfig-003-20250822    gcc-12
i386        buildonly-randconfig-004-20250822    clang-20
i386        buildonly-randconfig-004-20250822    gcc-12
i386        buildonly-randconfig-005-20250822    clang-20
i386        buildonly-randconfig-005-20250822    gcc-12
i386        buildonly-randconfig-006-20250822    clang-20
i386        buildonly-randconfig-006-20250822    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250822    clang-20
i386                  randconfig-002-20250822    clang-20
i386                  randconfig-003-20250822    clang-20
i386                  randconfig-004-20250822    clang-20
i386                  randconfig-005-20250822    clang-20
i386                  randconfig-006-20250822    clang-20
i386                  randconfig-007-20250822    clang-20
i386                  randconfig-011-20250822    gcc-12
i386                  randconfig-012-20250822    gcc-12
i386                  randconfig-013-20250822    gcc-12
i386                  randconfig-014-20250822    gcc-12
i386                  randconfig-015-20250822    gcc-12
i386                  randconfig-016-20250822    gcc-12
i386                  randconfig-017-20250822    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250822    clang-22
loongarch             randconfig-002-20250822    clang-22
loongarch             randconfig-002-20250822    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250822    clang-22
nios2                 randconfig-001-20250822    gcc-11.5.0
nios2                 randconfig-002-20250822    clang-22
nios2                 randconfig-002-20250822    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250822    clang-22
parisc                randconfig-001-20250822    gcc-9.5.0
parisc                randconfig-002-20250822    clang-22
parisc                randconfig-002-20250822    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   currituck_defconfig    gcc-15.1.0
powerpc                        icon_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250822    clang-22
powerpc               randconfig-002-20250822    clang-22
powerpc               randconfig-002-20250822    gcc-11.5.0
powerpc               randconfig-003-20250822    clang-18
powerpc               randconfig-003-20250822    clang-22
powerpc64             randconfig-001-20250822    clang-22
powerpc64             randconfig-001-20250822    gcc-13.4.0
powerpc64             randconfig-002-20250822    clang-22
powerpc64             randconfig-003-20250822    clang-22
powerpc64             randconfig-003-20250822    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250822    clang-22
riscv                 randconfig-002-20250822    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250822    clang-22
s390                  randconfig-002-20250822    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250822    clang-22
sh                    randconfig-002-20250822    clang-22
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250822    clang-22
sparc                 randconfig-002-20250822    clang-22
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250822    clang-22
sparc64               randconfig-002-20250822    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250822    clang-22
um                    randconfig-002-20250822    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250822    clang-20
x86_64      buildonly-randconfig-002-20250822    gcc-12
x86_64      buildonly-randconfig-003-20250822    clang-20
x86_64      buildonly-randconfig-004-20250822    clang-20
x86_64      buildonly-randconfig-005-20250822    clang-20
x86_64      buildonly-randconfig-006-20250822    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250822    clang-20
x86_64                randconfig-002-20250822    clang-20
x86_64                randconfig-003-20250822    clang-20
x86_64                randconfig-004-20250822    clang-20
x86_64                randconfig-005-20250822    clang-20
x86_64                randconfig-006-20250822    clang-20
x86_64                randconfig-007-20250822    clang-20
x86_64                randconfig-008-20250822    clang-20
x86_64                randconfig-071-20250822    clang-20
x86_64                randconfig-072-20250822    clang-20
x86_64                randconfig-073-20250822    clang-20
x86_64                randconfig-074-20250822    clang-20
x86_64                randconfig-075-20250822    clang-20
x86_64                randconfig-076-20250822    clang-20
x86_64                randconfig-077-20250822    clang-20
x86_64                randconfig-078-20250822    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250822    clang-22
xtensa                randconfig-002-20250822    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

