Return-Path: <linux-pci+bounces-34374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF906B2DA8C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2B51C41B8F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA072D7809;
	Wed, 20 Aug 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5TmedD9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1CEEDE
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688068; cv=none; b=aLIh5WPZ8fR2vQhprV6UMxA5ctwO3LpMPasxGVGw5G43FRtD5Jmhuy6ALysh9QWrNXPC0DrzdEFXjc1AXBPIuYIOOSsEd9kRkBAXkp5ZYHBmarM2gxkiHCPEbFiCLKjvWeBMCnWU1eBIEhT4uUXNIFFYNG2CwFgalo3YChx+5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688068; c=relaxed/simple;
	bh=Pe3qzzK5t5BHCUq6eSv8CEwLMaC+IkBloDIYMJXtfEU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I29urVFUo8O6grG+tmT776tGDmK2BuHkh4E10YCPIFkEn8lYIU8+OiJKLkVjyMriYYAt9DnImhX+KaKBFa/RdgBLUuPuaG/G8jcvfXUpe4gBnmWCLv16mz15hqv9bipvOoAGWHvxd7wvZQEhUsc7vpxYUlWKS+EwDbb7CxHYsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5TmedD9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755688067; x=1787224067;
  h=date:from:to:cc:subject:message-id;
  bh=Pe3qzzK5t5BHCUq6eSv8CEwLMaC+IkBloDIYMJXtfEU=;
  b=K5TmedD9B8VBWeDGzI+Xyv90e9WWFEY5vNHM5cckt3lhB9vzOEe7kmVO
   JT/98M5LpUtCjvHM7mpfeGSZ23sjP5Z1jTWo0zRqpWUDAVjreqB2XRFYk
   9ZaebCuNpbXIPyHvsGenCaeG1fju6MCqfPdSrvV/WhJ2J6jQk0npzE+V1
   AKZ0hgc/+AaRSY7xIsFA/7pk7PZDRta5EjV4K8u8WRoTLLUbSXGsHw0p9
   /Y2gnHCZrTzU6fE7yFRZXP7y4ML390p0dARdPoMhTzhENqI+de1w21C3Z
   TQIRV7BaavAFcThPMythIdnI9O6WLtrYX2QN5542YOx2+czIlQXHj5WtP
   g==;
X-CSE-ConnectionGUID: +f1NoSyKQ526+joo3V5HhQ==
X-CSE-MsgGUID: tTbyWsAoTgifOlBt/h4zhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61765546"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61765546"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 04:07:46 -0700
X-CSE-ConnectionGUID: AjszvgrARLeoagzoORgQpQ==
X-CSE-MsgGUID: czrEkavARUKMKL85E0/x2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167606711"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 Aug 2025 04:07:44 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uogfO-000Ix2-0R;
	Wed, 20 Aug 2025 11:07:42 +0000
Date: Wed, 20 Aug 2025 19:05:31 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mediatek-gen3] BUILD SUCCESS
 81fedb39a9f0da301a11c7a3b81d91c3b9024462
Message-ID: <202508201925.65qY4Xw4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mediatek-gen3
branch HEAD: 81fedb39a9f0da301a11c7a3b81d91c3b9024462  PCI: mediatek-gen3: Add support for MediaTek MT8196 SoC

elapsed time: 1167m

configs tested: 230
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250820    gcc-14.3.0
arc                   randconfig-001-20250820    gcc-8.5.0
arc                   randconfig-002-20250820    gcc-11.5.0
arc                   randconfig-002-20250820    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            mmp2_defconfig    clang-22
arm                   randconfig-001-20250820    gcc-14.3.0
arm                   randconfig-001-20250820    gcc-8.5.0
arm                   randconfig-002-20250820    gcc-14.3.0
arm                   randconfig-002-20250820    gcc-15.1.0
arm                   randconfig-003-20250820    gcc-13.4.0
arm                   randconfig-003-20250820    gcc-14.3.0
arm                   randconfig-004-20250820    clang-22
arm                   randconfig-004-20250820    gcc-14.3.0
arm                        realview_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250820    gcc-14.3.0
arm64                 randconfig-002-20250820    gcc-14.3.0
arm64                 randconfig-003-20250820    gcc-14.3.0
arm64                 randconfig-003-20250820    gcc-8.5.0
arm64                 randconfig-004-20250820    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250820    clang-22
csky                  randconfig-001-20250820    gcc-15.1.0
csky                  randconfig-002-20250820    clang-22
csky                  randconfig-002-20250820    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250820    clang-22
hexagon               randconfig-002-20250820    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250820    clang-20
i386        buildonly-randconfig-001-20250820    gcc-12
i386        buildonly-randconfig-002-20250820    gcc-12
i386        buildonly-randconfig-003-20250820    gcc-12
i386        buildonly-randconfig-004-20250820    clang-20
i386        buildonly-randconfig-004-20250820    gcc-12
i386        buildonly-randconfig-005-20250820    gcc-12
i386        buildonly-randconfig-006-20250820    gcc-11
i386        buildonly-randconfig-006-20250820    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250820    gcc-12
i386                  randconfig-002-20250820    gcc-12
i386                  randconfig-003-20250820    gcc-12
i386                  randconfig-004-20250820    gcc-12
i386                  randconfig-005-20250820    gcc-12
i386                  randconfig-006-20250820    gcc-12
i386                  randconfig-007-20250820    gcc-12
i386                  randconfig-011-20250820    clang-20
i386                  randconfig-012-20250820    clang-20
i386                  randconfig-013-20250820    clang-20
i386                  randconfig-014-20250820    clang-20
i386                  randconfig-015-20250820    clang-20
i386                  randconfig-016-20250820    clang-20
i386                  randconfig-017-20250820    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250820    clang-18
loongarch             randconfig-001-20250820    clang-22
loongarch             randconfig-002-20250820    clang-22
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
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250820    clang-22
nios2                 randconfig-001-20250820    gcc-11.5.0
nios2                 randconfig-002-20250820    clang-22
nios2                 randconfig-002-20250820    gcc-10.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250820    clang-22
parisc                randconfig-001-20250820    gcc-8.5.0
parisc                randconfig-002-20250820    clang-22
parisc                randconfig-002-20250820    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    clang-22
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                          g5_defconfig    clang-22
powerpc               randconfig-001-20250820    clang-22
powerpc               randconfig-001-20250820    gcc-12.5.0
powerpc               randconfig-002-20250820    clang-22
powerpc               randconfig-002-20250820    gcc-8.5.0
powerpc               randconfig-003-20250820    clang-22
powerpc               randconfig-003-20250820    gcc-13.4.0
powerpc                     tqm8548_defconfig    clang-22
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20250820    clang-22
powerpc64             randconfig-002-20250820    clang-22
powerpc64             randconfig-003-20250820    clang-22
powerpc64             randconfig-003-20250820    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250820    clang-20
riscv                 randconfig-001-20250820    clang-22
riscv                 randconfig-002-20250820    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250820    clang-18
s390                  randconfig-001-20250820    clang-22
s390                  randconfig-002-20250820    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250820    clang-22
sh                    randconfig-001-20250820    gcc-15.1.0
sh                    randconfig-002-20250820    clang-22
sh                    randconfig-002-20250820    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250820    clang-22
sparc                 randconfig-001-20250820    gcc-8.5.0
sparc                 randconfig-002-20250820    clang-22
sparc                 randconfig-002-20250820    gcc-12.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250820    clang-22
sparc64               randconfig-002-20250820    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250820    clang-22
um                    randconfig-001-20250820    gcc-12
um                    randconfig-002-20250820    clang-22
um                    randconfig-002-20250820    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250820    clang-20
x86_64      buildonly-randconfig-002-20250820    clang-20
x86_64      buildonly-randconfig-002-20250820    gcc-11
x86_64      buildonly-randconfig-003-20250820    clang-20
x86_64      buildonly-randconfig-004-20250820    clang-20
x86_64      buildonly-randconfig-004-20250820    gcc-12
x86_64      buildonly-randconfig-005-20250820    clang-20
x86_64      buildonly-randconfig-006-20250820    clang-20
x86_64      buildonly-randconfig-006-20250820    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250820    gcc-12
x86_64                randconfig-002-20250820    gcc-12
x86_64                randconfig-003-20250820    gcc-12
x86_64                randconfig-004-20250820    gcc-12
x86_64                randconfig-005-20250820    gcc-12
x86_64                randconfig-006-20250820    gcc-12
x86_64                randconfig-007-20250820    gcc-12
x86_64                randconfig-008-20250820    gcc-12
x86_64                randconfig-071-20250820    gcc-12
x86_64                randconfig-072-20250820    gcc-12
x86_64                randconfig-073-20250820    gcc-12
x86_64                randconfig-074-20250820    gcc-12
x86_64                randconfig-075-20250820    gcc-12
x86_64                randconfig-076-20250820    gcc-12
x86_64                randconfig-077-20250820    gcc-12
x86_64                randconfig-078-20250820    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250820    clang-22
xtensa                randconfig-001-20250820    gcc-8.5.0
xtensa                randconfig-002-20250820    clang-22
xtensa                randconfig-002-20250820    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

