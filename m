Return-Path: <linux-pci+bounces-26294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC99A945F5
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 00:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033653BC149
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 22:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1A2C1A2;
	Sat, 19 Apr 2025 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXkR8iWI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0E1E8824
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745103515; cv=none; b=ZXHFgEgDIBc2A22rgqPuvJxjghQVcCBSRJYA36sECkhJqoAQSjcNfXlm6s93OirtEKYg42mFqRSdQYTRGsUxzxrSrE2zos71iWaLan1bQmBnaxsfVXTiHTo5mX73bItRGP+C8+Oael1lbGH8GL14B6gR7blBeEBIHNjNgi8Lnj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745103515; c=relaxed/simple;
	bh=RMIC0z6eiRpWbl2E0hHBDs9NR6IuQMcy1Vv1t8RXMsY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DDYxD/hlK60WBO4AMgyRdilUx+HNQXr6haaWWagPc5wJmAWIyOdJZ90f0MGdAr9VcN04FIAtEhQavIJqZHeJSxWrlYsPQTimsbBEBN2H4yTiIObMBeHVN9X5F3qHwiowHgbIj0NXh+dQNN9Lw3bGfzLlyftIR6cQedYs3EfD7xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXkR8iWI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745103514; x=1776639514;
  h=date:from:to:cc:subject:message-id;
  bh=RMIC0z6eiRpWbl2E0hHBDs9NR6IuQMcy1Vv1t8RXMsY=;
  b=BXkR8iWIpjN7tsz2OHUkZ5zGy6kKnhX4kwzY43iV0qeimN5ekpYpGdoA
   ZJ7PSVQkdBdw51raovG4UwAgkCs88hE2QPaqvs6slpkOtOAe9/kHGVWYz
   kCJUen1Vm9ZqBUbNg6cgYkSLOcJiFxr6g/haLGd4wl9SmP08fX3WVbZRP
   kJT8gUFtzHXPZ694zqvMisFP6RpdxufWoWOPvMZeFmWGkrLh+y3U+ZItz
   +t14TeCVVXx83JPhYyuEbw6bZ9QGw2YpGu/kTxRoo0S60yvM/t3c8b1MR
   KZSJgbSNt7Sj8YNUFQNN65AEKmSTjKlg5RT9+P3I4zRRVS2fi9glHp+Rv
   w==;
X-CSE-ConnectionGUID: wHBkeUr9TS24ifVvkpKpBQ==
X-CSE-MsgGUID: d0C6mfQWStCfDGMQ5KTIDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="58069098"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="58069098"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 15:58:30 -0700
X-CSE-ConnectionGUID: XEz4iI7LSKaOPkYzyVdDow==
X-CSE-MsgGUID: xWYvpjH0QFSbdBjvOIBm3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="131255449"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Apr 2025 15:58:29 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6H8l-0004Eo-0d;
	Sat, 19 Apr 2025 22:58:27 +0000
Date: Sun, 20 Apr 2025 06:58:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 92713f0ea620bbe923eb4e7bda408e5c79597cd4
Message-ID: <202504200604.TpQFNCD8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 92713f0ea620bbe923eb4e7bda408e5c79597cd4  Merge branch 'pci/misc'

elapsed time: 1448m

configs tested: 201
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250419    gcc-14.2.0
arc                   randconfig-002-20250419    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                      integrator_defconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                   randconfig-001-20250419    gcc-6.5.0
arm                   randconfig-002-20250419    gcc-7.5.0
arm                   randconfig-003-20250419    clang-18
arm                   randconfig-004-20250419    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250419    gcc-7.5.0
arm64                 randconfig-002-20250419    gcc-9.5.0
arm64                 randconfig-003-20250419    gcc-5.5.0
arm64                 randconfig-004-20250419    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250419    gcc-11.5.0
csky                  randconfig-002-20250419    gcc-11.5.0
hexagon                          alldefconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250419    clang-21
hexagon               randconfig-002-20250419    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250419    gcc-11
i386        buildonly-randconfig-002-20250419    gcc-12
i386        buildonly-randconfig-003-20250419    clang-20
i386        buildonly-randconfig-004-20250419    clang-20
i386        buildonly-randconfig-005-20250419    clang-20
i386        buildonly-randconfig-006-20250419    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250420    gcc-12
i386                  randconfig-002-20250420    gcc-12
i386                  randconfig-003-20250420    gcc-12
i386                  randconfig-004-20250420    gcc-12
i386                  randconfig-005-20250420    gcc-12
i386                  randconfig-006-20250420    gcc-12
i386                  randconfig-007-20250420    gcc-12
i386                  randconfig-011-20250420    gcc-12
i386                  randconfig-012-20250420    gcc-12
i386                  randconfig-013-20250420    gcc-12
i386                  randconfig-014-20250420    gcc-12
i386                  randconfig-015-20250420    gcc-12
i386                  randconfig-016-20250420    gcc-12
i386                  randconfig-017-20250420    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250419    gcc-14.2.0
loongarch             randconfig-002-20250419    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250419    gcc-7.5.0
nios2                 randconfig-002-20250419    gcc-11.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250419    gcc-10.5.0
parisc                randconfig-002-20250419    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250419    gcc-5.5.0
powerpc               randconfig-002-20250419    gcc-9.3.0
powerpc               randconfig-003-20250419    gcc-5.5.0
powerpc64             randconfig-001-20250419    gcc-5.5.0
powerpc64             randconfig-002-20250419    gcc-10.5.0
powerpc64             randconfig-003-20250419    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    clang-21
riscv                 randconfig-001-20250419    gcc-14.2.0
riscv                 randconfig-002-20250419    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250419    clang-21
s390                  randconfig-002-20250419    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250419    gcc-5.5.0
sh                    randconfig-002-20250419    gcc-11.5.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                           se7206_defconfig    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250419    gcc-12.4.0
sparc                 randconfig-002-20250419    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250419    gcc-8.5.0
sparc64               randconfig-002-20250419    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250419    clang-19
um                    randconfig-002-20250419    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250419    gcc-12
x86_64      buildonly-randconfig-002-20250419    gcc-11
x86_64      buildonly-randconfig-003-20250419    gcc-12
x86_64      buildonly-randconfig-004-20250419    gcc-11
x86_64      buildonly-randconfig-005-20250419    gcc-12
x86_64      buildonly-randconfig-006-20250419    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250420    gcc-12
x86_64                randconfig-002-20250420    gcc-12
x86_64                randconfig-003-20250420    gcc-12
x86_64                randconfig-004-20250420    gcc-12
x86_64                randconfig-005-20250420    gcc-12
x86_64                randconfig-006-20250420    gcc-12
x86_64                randconfig-007-20250420    gcc-12
x86_64                randconfig-008-20250420    gcc-12
x86_64                randconfig-071-20250420    clang-20
x86_64                randconfig-072-20250420    clang-20
x86_64                randconfig-073-20250420    clang-20
x86_64                randconfig-074-20250420    clang-20
x86_64                randconfig-075-20250420    clang-20
x86_64                randconfig-076-20250420    clang-20
x86_64                randconfig-077-20250420    clang-20
x86_64                randconfig-078-20250420    clang-20
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250419    gcc-10.5.0
xtensa                randconfig-002-20250419    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

