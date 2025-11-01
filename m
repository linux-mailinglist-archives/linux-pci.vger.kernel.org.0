Return-Path: <linux-pci+bounces-40030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E51C281D3
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5021F4F1BDB
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D9CA6F;
	Sat,  1 Nov 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aufDEJbF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C341D86DC
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011908; cv=none; b=VplWBfTOIlyvLj49bu+BE6rRMdWA/2iHOzvZ3ClkzXVeV4e9Ua0FyM+xB7uxo/u2eISHfbTZVQCnpZk0ZtTuHtHcKMW2H7sfSR+LhWnol6qikDbUDGVVQs2Hv/LXQIwYmL20hz7QMN2MsAdBLcvMDVYk7Pp5Kffl27+zRGEJzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011908; c=relaxed/simple;
	bh=ljBID0PgAs5TrsxeuH1e+nuesIviD1RGokKX51SQUiw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eu2iHHv1RYe2wjdDB7PFB2iCOwDGURKxE/BTf/m5y0SkC6m5KGjPMTiTqSxgMHAe2BXMc8vmRM7Iv53X5MhhDdZVQyIhSlDkKZC/XRAKTTGRxxvBE3WeSydRsetk+ny824k7wufD/eWl5KeyC+p+INIjnP8rFF5LeBhbvM89Dp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aufDEJbF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762011907; x=1793547907;
  h=date:from:to:cc:subject:message-id;
  bh=ljBID0PgAs5TrsxeuH1e+nuesIviD1RGokKX51SQUiw=;
  b=aufDEJbFM2UnsjumSpS99HWJIYpwUuFIXj5/KepTn58XBXJC9rkoi0N3
   hAgJZfE7UY8/P/NUhaJCTq8i97bwRAi09i2d0EY0ddDx8SstOIpCICsPk
   fJWh0A1EVY+k8wGlMIqOmtB24YOGPAN/RivgM8Dg74CIpLCsHtwT3AeZZ
   QzHXX//CANIQxwEjgIJ1RUtKqNWQXd32IQOIpD7gsPfn32m9DDkSuiaHf
   x5J5PI8ybJE3yua8odpdOo1a6KeNP5V7vxk5L8Ksnr7dvpLZyslokRCm8
   p2HPrhrl6FsHZcXuHXj3cU0aYkxvUFysZ3JgE77Vgda0SM/ZzjPbFqAZb
   Q==;
X-CSE-ConnectionGUID: fN3h9b3jSPKP/DNR5HcheA==
X-CSE-MsgGUID: SgZhgNNWSxuncPTD6GYsdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="64192132"
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="64192132"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 08:45:06 -0700
X-CSE-ConnectionGUID: lOMwStT/ShSxMGhwMUS7Nw==
X-CSE-MsgGUID: RiamO816SiSMBgC36AjPng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="191628065"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 01 Nov 2025 08:45:05 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFDmk-000OPu-2L;
	Sat, 01 Nov 2025 15:45:00 +0000
Date: Sat, 01 Nov 2025 23:44:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 50433f6eeaed2117d5eee4a3dac4a3869a9c32ea
Message-ID: <202511012309.VCgJ9OlT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 50433f6eeaed2117d5eee4a3dac4a3869a9c32ea  PCI: qcom: Use frequency and level based OPP lookup

elapsed time: 1074m

configs tested: 200
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251101    gcc-8.5.0
arc                   randconfig-002-20251101    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20251101    gcc-13.4.0
arm                   randconfig-001-20251101    gcc-8.5.0
arm                   randconfig-002-20251101    clang-22
arm                   randconfig-002-20251101    gcc-8.5.0
arm                   randconfig-003-20251101    clang-18
arm                   randconfig-003-20251101    gcc-8.5.0
arm                   randconfig-004-20251101    clang-22
arm                   randconfig-004-20251101    gcc-8.5.0
arm                        spear3xx_defconfig    clang-22
arm                        spear6xx_defconfig    clang-22
arm                        vexpress_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251101    gcc-14.3.0
arm64                 randconfig-002-20251101    gcc-14.3.0
arm64                 randconfig-003-20251101    gcc-14.3.0
arm64                 randconfig-004-20251101    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251101    gcc-14.3.0
csky                  randconfig-002-20251101    gcc-14.3.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251101    clang-19
hexagon               randconfig-001-20251101    clang-22
hexagon               randconfig-002-20251101    clang-19
hexagon               randconfig-002-20251101    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251101    clang-20
i386        buildonly-randconfig-002-20251101    clang-20
i386        buildonly-randconfig-003-20251101    clang-20
i386        buildonly-randconfig-004-20251101    clang-20
i386        buildonly-randconfig-005-20251101    clang-20
i386        buildonly-randconfig-006-20251101    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251101    gcc-14
i386                  randconfig-002-20251101    gcc-14
i386                  randconfig-003-20251101    gcc-14
i386                  randconfig-004-20251101    gcc-14
i386                  randconfig-005-20251101    gcc-14
i386                  randconfig-006-20251101    gcc-14
i386                  randconfig-007-20251101    gcc-14
i386                  randconfig-011-20251101    clang-20
i386                  randconfig-012-20251101    clang-20
i386                  randconfig-013-20251101    clang-20
i386                  randconfig-014-20251101    clang-20
i386                  randconfig-015-20251101    clang-20
i386                  randconfig-016-20251101    clang-20
i386                  randconfig-017-20251101    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251101    clang-18
loongarch             randconfig-001-20251101    clang-19
loongarch             randconfig-002-20251101    clang-19
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251101    clang-19
nios2                 randconfig-001-20251101    gcc-9.5.0
nios2                 randconfig-002-20251101    clang-19
nios2                 randconfig-002-20251101    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251101    clang-20
parisc                randconfig-002-20251101    clang-20
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251101    clang-20
powerpc               randconfig-002-20251101    clang-20
powerpc                     skiroot_defconfig    clang-22
powerpc64             randconfig-001-20251101    clang-20
powerpc64             randconfig-002-20251101    clang-20
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251101    clang-17
riscv                 randconfig-001-20251101    gcc-8.5.0
riscv                 randconfig-002-20251101    clang-17
riscv                 randconfig-002-20251101    gcc-8.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251101    clang-17
s390                  randconfig-002-20251101    clang-17
s390                  randconfig-002-20251101    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251101    clang-17
sh                    randconfig-001-20251101    gcc-15.1.0
sh                    randconfig-002-20251101    clang-17
sh                    randconfig-002-20251101    gcc-15.1.0
sh                           se7206_defconfig    clang-22
sh                   secureedge5410_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251101    clang-16
sparc                 randconfig-002-20251101    clang-16
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251101    clang-16
sparc64               randconfig-002-20251101    clang-16
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251101    clang-16
um                    randconfig-002-20251101    clang-16
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251101    gcc-14
x86_64      buildonly-randconfig-002-20251101    gcc-14
x86_64      buildonly-randconfig-003-20251101    gcc-14
x86_64      buildonly-randconfig-004-20251101    gcc-14
x86_64      buildonly-randconfig-005-20251101    gcc-14
x86_64      buildonly-randconfig-006-20251101    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251101    clang-20
x86_64                randconfig-002-20251101    clang-20
x86_64                randconfig-003-20251101    clang-20
x86_64                randconfig-004-20251101    clang-20
x86_64                randconfig-005-20251101    clang-20
x86_64                randconfig-006-20251101    clang-20
x86_64                randconfig-011-20251101    gcc-14
x86_64                randconfig-012-20251101    gcc-14
x86_64                randconfig-013-20251101    gcc-14
x86_64                randconfig-014-20251101    gcc-14
x86_64                randconfig-015-20251101    gcc-14
x86_64                randconfig-016-20251101    gcc-14
x86_64                randconfig-071-20251101    clang-20
x86_64                randconfig-072-20251101    clang-20
x86_64                randconfig-073-20251101    clang-20
x86_64                randconfig-074-20251101    clang-20
x86_64                randconfig-075-20251101    clang-20
x86_64                randconfig-076-20251101    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251101    clang-16
xtensa                randconfig-002-20251101    clang-16

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

