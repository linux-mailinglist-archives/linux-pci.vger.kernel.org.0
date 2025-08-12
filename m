Return-Path: <linux-pci+bounces-33818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B0DB21C29
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 06:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76444189DE60
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 04:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4986B20409A;
	Tue, 12 Aug 2025 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii/oEPD5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A71FF7C5
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754973313; cv=none; b=jKLYcnpDswSwZ18d/zzHXs0BEbQ6TmFgxnQwv7YxNomDJzZXIfOWLOITQ3zXG0d3U5yWOauj+63iqrSGenczyJnpXzDsvXnoZ4pVSnFypyjmw8lewyHyy+Oj31cGoQMZLROORce3CjQbzjaivIkmsMB2FH3lnijceonkMvhMveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754973313; c=relaxed/simple;
	bh=Xdw8tMH5Cx1YD3OwlXrN6iOrpSK9gx+EKCW0Gn6WjAc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=L9xNtu5MuN9Ga4la1g7WVW7UMJD9Umr5KtPa6anDOs2jrpY4+ogCuEWfHNXDqobH1bYcnN53t+crtVy/esL5H/xPN+q0emh6FZ9kqdmyqRdDRkXrpjaItyPam0jW4RqGun8ixEeubIOwKppOKB16x+bjsHiIyyNuNf3u9I0Wn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii/oEPD5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754973311; x=1786509311;
  h=date:from:to:cc:subject:message-id;
  bh=Xdw8tMH5Cx1YD3OwlXrN6iOrpSK9gx+EKCW0Gn6WjAc=;
  b=ii/oEPD5Od6OZDTxJ7weCbtT1fuvKqasWKXM8lWvK0kLlKi7EQNu/Pnh
   pBSTvAwMXNJXFQ445goyUkotSXLBeffxVBwpitQ1v3Lo8aaHzhA9pRyS0
   Iwf7HMD5WJ2wmRbI19ucf13NR9OXTzdmy8iACxroujcWvOW4IPxXOQ5F3
   KPgaYjr84V/zQ7Ftv7sSZXqyVlV9HzG+/lWZatnD5oUZbl8+eNvvgnrMV
   XsxPRA/txzlrCgDH/IEXTlQINxVt0xIHIxzYi0RBQy4PH6J/T2/IePrK/
   EkeRq/M/llPSxbCB5V2qQjv7EoHoub4U3vUZ5JdufQv1gjnrnoTjBSlEo
   A==;
X-CSE-ConnectionGUID: WIRcAEr5QcKPEjSvgF7z6Q==
X-CSE-MsgGUID: 7Nmeca67SKK/Wiv3oTMq4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68693773"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68693773"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:35:10 -0700
X-CSE-ConnectionGUID: taJ1ifpcS5OWDG/GHSREfQ==
X-CSE-MsgGUID: 15LVdxooRrKooiuWWbR6BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165984313"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 11 Aug 2025 21:35:09 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulgj4-0006Q0-3A;
	Tue, 12 Aug 2025 04:35:06 +0000
Date: Tue, 12 Aug 2025 12:34:55 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:doc/endpoint] BUILD SUCCESS
 5f523381fdd44bcc3210ec18653eccafe4c4bf94
Message-ID: <202508121249.XGTTbVDi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git doc/endpoint
branch HEAD: 5f523381fdd44bcc3210ec18653eccafe4c4bf94  Documentation: PCI: endpoint: Document BAR assignment

elapsed time: 1028m

configs tested: 244
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250811    gcc-8.5.0
arc                   randconfig-001-20250812    gcc-14.3.0
arc                   randconfig-002-20250811    gcc-10.5.0
arc                   randconfig-002-20250812    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           omap1_defconfig    clang-22
arm                   randconfig-001-20250811    gcc-10.5.0
arm                   randconfig-001-20250812    gcc-14.3.0
arm                   randconfig-002-20250811    gcc-13.4.0
arm                   randconfig-002-20250812    gcc-14.3.0
arm                   randconfig-003-20250811    clang-22
arm                   randconfig-003-20250812    gcc-14.3.0
arm                   randconfig-004-20250811    gcc-10.5.0
arm                   randconfig-004-20250812    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                               defconfig    clang-22
arm64                 randconfig-001-20250811    clang-22
arm64                 randconfig-001-20250812    gcc-14.3.0
arm64                 randconfig-002-20250811    clang-19
arm64                 randconfig-002-20250812    gcc-14.3.0
arm64                 randconfig-003-20250811    clang-20
arm64                 randconfig-003-20250812    gcc-14.3.0
arm64                 randconfig-004-20250811    clang-22
arm64                 randconfig-004-20250812    gcc-14.3.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250811    gcc-15.1.0
csky                  randconfig-001-20250812    gcc-12.5.0
csky                  randconfig-002-20250811    gcc-15.1.0
csky                  randconfig-002-20250812    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250811    clang-17
hexagon               randconfig-001-20250812    gcc-12.5.0
hexagon               randconfig-002-20250811    clang-16
hexagon               randconfig-002-20250812    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250811    clang-20
i386        buildonly-randconfig-001-20250812    gcc-12
i386        buildonly-randconfig-002-20250811    clang-20
i386        buildonly-randconfig-002-20250812    gcc-12
i386        buildonly-randconfig-003-20250811    gcc-12
i386        buildonly-randconfig-003-20250812    gcc-12
i386        buildonly-randconfig-004-20250811    gcc-12
i386        buildonly-randconfig-004-20250812    gcc-12
i386        buildonly-randconfig-005-20250811    gcc-12
i386        buildonly-randconfig-005-20250812    gcc-12
i386        buildonly-randconfig-006-20250811    gcc-12
i386        buildonly-randconfig-006-20250812    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250812    clang-20
i386                  randconfig-002-20250812    clang-20
i386                  randconfig-003-20250812    clang-20
i386                  randconfig-004-20250812    clang-20
i386                  randconfig-005-20250812    clang-20
i386                  randconfig-006-20250812    clang-20
i386                  randconfig-007-20250812    clang-20
i386                  randconfig-011-20250812    gcc-12
i386                  randconfig-012-20250812    gcc-12
i386                  randconfig-013-20250812    gcc-12
i386                  randconfig-014-20250812    gcc-12
i386                  randconfig-015-20250812    gcc-12
i386                  randconfig-016-20250812    gcc-12
i386                  randconfig-017-20250812    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250811    gcc-15.1.0
loongarch             randconfig-001-20250812    gcc-12.5.0
loongarch             randconfig-002-20250811    gcc-12.5.0
loongarch             randconfig-002-20250812    gcc-12.5.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250811    gcc-10.5.0
nios2                 randconfig-001-20250812    gcc-12.5.0
nios2                 randconfig-002-20250811    gcc-11.5.0
nios2                 randconfig-002-20250812    gcc-12.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250811    gcc-9.5.0
parisc                randconfig-001-20250812    gcc-12.5.0
parisc                randconfig-002-20250811    gcc-14.3.0
parisc                randconfig-002-20250812    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      katmai_defconfig    clang-22
powerpc               randconfig-001-20250811    gcc-13.4.0
powerpc               randconfig-001-20250812    gcc-12.5.0
powerpc               randconfig-002-20250811    clang-22
powerpc               randconfig-002-20250812    gcc-12.5.0
powerpc               randconfig-003-20250811    gcc-13.4.0
powerpc               randconfig-003-20250812    gcc-12.5.0
powerpc64             randconfig-001-20250811    clang-22
powerpc64             randconfig-001-20250812    gcc-12.5.0
powerpc64             randconfig-002-20250811    clang-22
powerpc64             randconfig-002-20250812    gcc-12.5.0
powerpc64             randconfig-003-20250811    gcc-14.3.0
powerpc64             randconfig-003-20250812    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250811    gcc-8.5.0
riscv                 randconfig-001-20250812    clang-18
riscv                 randconfig-002-20250811    clang-22
riscv                 randconfig-002-20250812    clang-18
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250811    gcc-8.5.0
s390                  randconfig-001-20250812    clang-18
s390                  randconfig-002-20250811    clang-17
s390                  randconfig-002-20250812    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20250811    gcc-15.1.0
sh                    randconfig-001-20250812    clang-18
sh                    randconfig-002-20250811    gcc-15.1.0
sh                    randconfig-002-20250812    clang-18
sh                             sh03_defconfig    clang-22
sh                     sh7710voipgw_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250811    gcc-8.5.0
sparc                 randconfig-001-20250812    clang-18
sparc                 randconfig-002-20250811    gcc-8.5.0
sparc                 randconfig-002-20250812    clang-18
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250811    clang-22
sparc64               randconfig-001-20250812    clang-18
sparc64               randconfig-002-20250811    gcc-14.3.0
sparc64               randconfig-002-20250812    clang-18
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250811    clang-18
um                    randconfig-001-20250812    clang-18
um                    randconfig-002-20250811    clang-22
um                    randconfig-002-20250812    clang-18
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250811    gcc-12
x86_64      buildonly-randconfig-001-20250812    gcc-12
x86_64      buildonly-randconfig-002-20250811    clang-20
x86_64      buildonly-randconfig-002-20250812    gcc-12
x86_64      buildonly-randconfig-003-20250811    clang-20
x86_64      buildonly-randconfig-003-20250812    gcc-12
x86_64      buildonly-randconfig-004-20250811    clang-20
x86_64      buildonly-randconfig-004-20250812    gcc-12
x86_64      buildonly-randconfig-005-20250811    clang-20
x86_64      buildonly-randconfig-005-20250812    gcc-12
x86_64      buildonly-randconfig-006-20250811    clang-20
x86_64      buildonly-randconfig-006-20250812    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250812    gcc-11
x86_64                randconfig-002-20250812    gcc-11
x86_64                randconfig-003-20250812    gcc-11
x86_64                randconfig-004-20250812    gcc-11
x86_64                randconfig-005-20250812    gcc-11
x86_64                randconfig-006-20250812    gcc-11
x86_64                randconfig-007-20250812    gcc-11
x86_64                randconfig-008-20250812    gcc-11
x86_64                randconfig-071-20250812    clang-20
x86_64                randconfig-072-20250812    clang-20
x86_64                randconfig-073-20250812    clang-20
x86_64                randconfig-074-20250812    clang-20
x86_64                randconfig-075-20250812    clang-20
x86_64                randconfig-076-20250812    clang-20
x86_64                randconfig-077-20250812    clang-20
x86_64                randconfig-078-20250812    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250811    gcc-9.5.0
xtensa                randconfig-001-20250812    clang-18
xtensa                randconfig-002-20250811    gcc-9.5.0
xtensa                randconfig-002-20250812    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

