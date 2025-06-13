Return-Path: <linux-pci+bounces-29694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB02AD8D0E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755BF166E69
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA6B54654;
	Fri, 13 Jun 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYfKOubw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066151E50E
	for <linux-pci@vger.kernel.org>; Fri, 13 Jun 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821081; cv=none; b=U90lYy1Xg5SMoRwNbk5pRMWU8vC0pmXrOtB34Bg8KRFcOqLfRG+zkfg+0EfgY2R3VUoe9NYIyeCFxMylhIAdeEbG1HeXTm37Y3uCffhJVlJtAKfXRvOM8ZyI4Rfdf3VUVWlQ6b6yJHstFcNqGueCpKZfrnV/8QYvl3lGols9kiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821081; c=relaxed/simple;
	bh=5F9uxFKzlID2cMHx/+UDmsWspn0VeBmvIzOMpWK0qlY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z915HprojkX2l4O9aJ6rj4VzRxesoYVy/pDUbZxHuQqMfFqlAVXDMCQ/xmq4xcq6Glf2+5CB9yvVsZXhnzS4nbdMcUQYTnCbPn4iSlxSlRtR570DCFAZ2VaxgRY3JVjPX7iJ09yCjQeWZK+ZnHV+32VVsyCV3IddD+QIaY9lJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYfKOubw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749821080; x=1781357080;
  h=date:from:to:cc:subject:message-id;
  bh=5F9uxFKzlID2cMHx/+UDmsWspn0VeBmvIzOMpWK0qlY=;
  b=EYfKOubww+akaZykFRDvg78YBlpUdURIH1m4GUG1lWEL29kfA+iaqnI5
   qTtUBBpLkz4a5GzD036qGfSaPX+VRQtdFGbHMj5+cHrp9zw3DclgP95el
   IQhghMd1lL6igOciCF9auBf5buuetPwLf4fhQCHxYb4iX5Iqoz4MtqmVb
   RjeFuA5tJcCVaM2PebfDVGqLhd9lRK6m6pcyE/Y3yyZzZiTXZ8sgtG/zE
   darRS9nqxZN3Xl1Mtm/Ygvbu6rrrRp99Pt2iJSAuT09+k5WeD7P13GVP7
   lQTWARLWDZRPWJvGTJO7h1piUzXhE1ZPyAQNuXuKa0CbwqW3ap8NsB8JZ
   Q==;
X-CSE-ConnectionGUID: ldM7e92RSnGnpJ0b4cO3pg==
X-CSE-MsgGUID: YOSKhS1DTEGMOF+wzMOWHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="62313712"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="62313712"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 06:24:39 -0700
X-CSE-ConnectionGUID: YQxd2ULbSFC17jWG2165hg==
X-CSE-MsgGUID: zBaWkM6hTxOKxBiPphM1PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="153118550"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Jun 2025 06:24:38 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQ4OZ-000CeE-34;
	Fri, 13 Jun 2025 13:24:35 +0000
Date: Fri, 13 Jun 2025 21:24:23 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip-host] BUILD SUCCESS
 1fdb13f92388dfc936624b0a0d6abae362b0ace3
Message-ID: <202506132113.024I4h5Q-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip-host
branch HEAD: 1fdb13f92388dfc936624b0a0d6abae362b0ace3  PCI: rockchip-host: Remove unused header includes

elapsed time: 1446m

configs tested: 229
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250613    gcc-12.4.0
arc                   randconfig-002-20250613    gcc-12.4.0
arm                               allnoconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-21
arm                        clps711x_defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20250613    clang-21
arm                   randconfig-001-20250613    gcc-12.4.0
arm                   randconfig-002-20250613    clang-20
arm                   randconfig-002-20250613    gcc-12.4.0
arm                   randconfig-003-20250613    gcc-12.4.0
arm                   randconfig-003-20250613    gcc-8.5.0
arm                   randconfig-004-20250613    clang-21
arm                   randconfig-004-20250613    gcc-12.4.0
arm                           u8500_defconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250613    gcc-12.4.0
arm64                 randconfig-001-20250613    gcc-15.1.0
arm64                 randconfig-002-20250613    clang-21
arm64                 randconfig-002-20250613    gcc-12.4.0
arm64                 randconfig-003-20250613    clang-21
arm64                 randconfig-003-20250613    gcc-12.4.0
arm64                 randconfig-004-20250613    gcc-12.4.0
arm64                 randconfig-004-20250613    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250613    gcc-13.3.0
csky                  randconfig-001-20250613    gcc-15.1.0
csky                  randconfig-002-20250613    gcc-13.3.0
csky                  randconfig-002-20250613    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250613    clang-21
hexagon               randconfig-001-20250613    gcc-13.3.0
hexagon               randconfig-002-20250613    clang-21
hexagon               randconfig-002-20250613    gcc-13.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250612    clang-20
i386        buildonly-randconfig-001-20250613    gcc-12
i386        buildonly-randconfig-002-20250612    gcc-12
i386        buildonly-randconfig-002-20250613    gcc-12
i386        buildonly-randconfig-003-20250612    clang-20
i386        buildonly-randconfig-003-20250613    gcc-12
i386        buildonly-randconfig-004-20250612    clang-20
i386        buildonly-randconfig-004-20250613    gcc-12
i386        buildonly-randconfig-005-20250612    clang-20
i386        buildonly-randconfig-005-20250613    gcc-12
i386        buildonly-randconfig-006-20250612    clang-20
i386        buildonly-randconfig-006-20250613    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250613    clang-20
i386                  randconfig-002-20250613    clang-20
i386                  randconfig-003-20250613    clang-20
i386                  randconfig-004-20250613    clang-20
i386                  randconfig-005-20250613    clang-20
i386                  randconfig-006-20250613    clang-20
i386                  randconfig-007-20250613    clang-20
i386                  randconfig-011-20250613    clang-20
i386                  randconfig-012-20250613    clang-20
i386                  randconfig-013-20250613    clang-20
i386                  randconfig-014-20250613    clang-20
i386                  randconfig-015-20250613    clang-20
i386                  randconfig-016-20250613    clang-20
i386                  randconfig-017-20250613    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250613    gcc-13.3.0
loongarch             randconfig-001-20250613    gcc-15.1.0
loongarch             randconfig-002-20250613    gcc-13.3.0
loongarch             randconfig-002-20250613    gcc-15.1.0
m68k                             alldefconfig    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    gcc-15.1.0
mips                        omega2p_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250613    gcc-11.5.0
nios2                 randconfig-001-20250613    gcc-13.3.0
nios2                 randconfig-002-20250613    gcc-11.5.0
nios2                 randconfig-002-20250613    gcc-13.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250613    gcc-13.3.0
parisc                randconfig-001-20250613    gcc-8.5.0
parisc                randconfig-002-20250613    gcc-13.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250613    clang-21
powerpc               randconfig-001-20250613    gcc-13.3.0
powerpc               randconfig-002-20250613    gcc-13.3.0
powerpc               randconfig-002-20250613    gcc-8.5.0
powerpc               randconfig-003-20250613    gcc-13.3.0
powerpc               randconfig-003-20250613    gcc-9.3.0
powerpc64             randconfig-001-20250613    gcc-13.3.0
powerpc64             randconfig-001-20250613    gcc-8.5.0
powerpc64             randconfig-002-20250613    gcc-13.3.0
powerpc64             randconfig-002-20250613    gcc-8.5.0
powerpc64             randconfig-003-20250613    gcc-10.5.0
powerpc64             randconfig-003-20250613    gcc-13.3.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250612    clang-21
riscv                 randconfig-001-20250613    gcc-15.1.0
riscv                 randconfig-002-20250612    clang-21
riscv                 randconfig-002-20250613    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250612    clang-21
s390                  randconfig-001-20250613    gcc-15.1.0
s390                  randconfig-002-20250612    gcc-11.5.0
s390                  randconfig-002-20250613    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    clang-21
sh                    randconfig-001-20250612    gcc-12.4.0
sh                    randconfig-001-20250613    gcc-15.1.0
sh                    randconfig-002-20250612    gcc-15.1.0
sh                    randconfig-002-20250613    gcc-15.1.0
sh                          sdk7780_defconfig    clang-21
sh                          sdk7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250612    gcc-14.3.0
sparc                 randconfig-001-20250613    gcc-15.1.0
sparc                 randconfig-002-20250612    gcc-10.3.0
sparc                 randconfig-002-20250613    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250612    gcc-13.3.0
sparc64               randconfig-001-20250613    gcc-15.1.0
sparc64               randconfig-002-20250612    gcc-8.5.0
sparc64               randconfig-002-20250613    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250612    clang-17
um                    randconfig-001-20250613    gcc-15.1.0
um                    randconfig-002-20250612    clang-21
um                    randconfig-002-20250613    gcc-15.1.0
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250613    clang-20
x86_64      buildonly-randconfig-001-20250613    gcc-12
x86_64      buildonly-randconfig-002-20250613    gcc-12
x86_64      buildonly-randconfig-003-20250613    gcc-12
x86_64      buildonly-randconfig-004-20250613    gcc-12
x86_64      buildonly-randconfig-005-20250613    clang-20
x86_64      buildonly-randconfig-005-20250613    gcc-12
x86_64      buildonly-randconfig-006-20250613    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250613    gcc-12
x86_64                randconfig-002-20250613    gcc-12
x86_64                randconfig-003-20250613    gcc-12
x86_64                randconfig-004-20250613    gcc-12
x86_64                randconfig-005-20250613    gcc-12
x86_64                randconfig-006-20250613    gcc-12
x86_64                randconfig-007-20250613    gcc-12
x86_64                randconfig-008-20250613    gcc-12
x86_64                randconfig-071-20250613    gcc-12
x86_64                randconfig-072-20250613    gcc-12
x86_64                randconfig-073-20250613    gcc-12
x86_64                randconfig-074-20250613    gcc-12
x86_64                randconfig-075-20250613    gcc-12
x86_64                randconfig-076-20250613    gcc-12
x86_64                randconfig-077-20250613    gcc-12
x86_64                randconfig-078-20250613    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250612    gcc-10.5.0
xtensa                randconfig-001-20250613    gcc-15.1.0
xtensa                randconfig-002-20250612    gcc-12.4.0
xtensa                randconfig-002-20250613    gcc-15.1.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

