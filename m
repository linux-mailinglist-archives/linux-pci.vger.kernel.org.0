Return-Path: <linux-pci+bounces-31733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA0BAFDBDD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 01:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7224A6D08
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 23:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C69322D7B1;
	Tue,  8 Jul 2025 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnpyLUo4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDD01FF1A1
	for <linux-pci@vger.kernel.org>; Tue,  8 Jul 2025 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752017473; cv=none; b=u45PwjYQp+OvN78IpHPEj7aB6JUkkgHmG7vPKuDT/3aUBpNOivaLZxu40l/nhZJBN5O/L0QQApOryhtKc+2p9Isu+hIViCSEluMfMMDd9jIPzL87JeXGlaZGukSPltQ4vG1fzTbVGK9+KdLIYH01ySCWdVRC68xJjg9pBnxxWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752017473; c=relaxed/simple;
	bh=grwZHACQSA0iGnuNh9Dv9rboGDvlhU0HPG/9hYyiqv0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TgRFhxaMGtDWQS03s/Lo9QZ0++1CF1U8rjLzDb1678TaSMraWt1/uEPGzDgDe7LtQG/YkwH+bcsZmdVWsUr0+wLG7EjEoSvEhjg5zG6M/4PucwzyDyG2EE2X0Hb889LslGfl5lIDeRFZ3iKcbiOMRHI4gdUSWcSRr/zictiWtak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnpyLUo4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752017472; x=1783553472;
  h=date:from:to:cc:subject:message-id;
  bh=grwZHACQSA0iGnuNh9Dv9rboGDvlhU0HPG/9hYyiqv0=;
  b=QnpyLUo4jszJ/NzoP9XJfGGUr0taG9gNCbEQ/RPnTG8rfagwPnAYPc9s
   JCSDZCxUK4outrecGOAEk39Ym+Xe3+HQblX2rcAFrzbpH1XB98HRiif2j
   o1NtoKX9OgiJppPRlR4bN4pNkdaBuuaVBaYyb9RHvo4HAJCBLDIg+wweL
   RyvK73rY76vokND/GJU8NgnzIc+qMqRbLjC3esqR1T3qa0GlK3PHCd92q
   +fQ+gj+ZF/W+m9VafPPbUX/0BAa82VBhz357XZrbcLLGQ//9NDC1GGEdQ
   +hgyxbTWHbkELyJ53PCJm7NFPd4qdfj7Ja69u6OC9bXBsaVKKPRI/vCAO
   w==;
X-CSE-ConnectionGUID: QObZxVKeTXiQhoRJVFafLA==
X-CSE-MsgGUID: cWuz1O3qSyaNrKgSnC5VLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54200401"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54200401"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:31:11 -0700
X-CSE-ConnectionGUID: tZebCWFyTNW5swOXN2Ugzg==
X-CSE-MsgGUID: y9f8mbbUSQ6L7tlChKtjBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192805033"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2025 16:31:10 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZHmF-0002ru-1I;
	Tue, 08 Jul 2025 23:31:07 +0000
Date: Wed, 09 Jul 2025 07:30:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 114b06ee108cabc82b995fbac6672230a9776936
Message-ID: <202507090712.TBuEbPO9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: 114b06ee108cabc82b995fbac6672230a9776936  PCI: rockchip: Set Target Link Speed to 5.0 GT/s before retraining

elapsed time: 1454m

configs tested: 221
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                               allnoconfig    clang-21
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250708    gcc-13.4.0
arc                   randconfig-001-20250709    gcc-10.5.0
arc                   randconfig-002-20250708    gcc-8.5.0
arc                   randconfig-002-20250709    gcc-10.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                                 defconfig    clang-19
arm                           imxrt_defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250708    clang-21
arm                   randconfig-001-20250709    gcc-10.5.0
arm                   randconfig-002-20250708    clang-17
arm                   randconfig-002-20250709    gcc-10.5.0
arm                   randconfig-003-20250708    gcc-10.5.0
arm                   randconfig-003-20250709    gcc-10.5.0
arm                   randconfig-004-20250708    clang-21
arm                   randconfig-004-20250709    gcc-10.5.0
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250708    gcc-9.5.0
arm64                 randconfig-001-20250709    gcc-10.5.0
arm64                 randconfig-002-20250708    clang-19
arm64                 randconfig-002-20250709    gcc-10.5.0
arm64                 randconfig-003-20250708    clang-21
arm64                 randconfig-003-20250709    gcc-10.5.0
arm64                 randconfig-004-20250708    gcc-8.5.0
arm64                 randconfig-004-20250709    gcc-10.5.0
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250708    gcc-13.4.0
csky                  randconfig-001-20250709    gcc-14.2.0
csky                  randconfig-002-20250708    gcc-15.1.0
csky                  randconfig-002-20250709    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250708    clang-21
hexagon               randconfig-001-20250709    gcc-14.2.0
hexagon               randconfig-002-20250708    clang-21
hexagon               randconfig-002-20250709    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250708    clang-20
i386        buildonly-randconfig-001-20250709    clang-20
i386        buildonly-randconfig-002-20250708    clang-20
i386        buildonly-randconfig-002-20250709    clang-20
i386        buildonly-randconfig-003-20250708    clang-20
i386        buildonly-randconfig-003-20250709    clang-20
i386        buildonly-randconfig-004-20250708    gcc-12
i386        buildonly-randconfig-004-20250709    clang-20
i386        buildonly-randconfig-005-20250708    clang-20
i386        buildonly-randconfig-005-20250709    clang-20
i386        buildonly-randconfig-006-20250708    clang-20
i386        buildonly-randconfig-006-20250709    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250709    clang-20
i386                  randconfig-002-20250709    clang-20
i386                  randconfig-003-20250709    clang-20
i386                  randconfig-004-20250709    clang-20
i386                  randconfig-005-20250709    clang-20
i386                  randconfig-006-20250709    clang-20
i386                  randconfig-007-20250709    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250708    clang-21
loongarch             randconfig-001-20250709    gcc-14.2.0
loongarch             randconfig-002-20250708    clang-21
loongarch             randconfig-002-20250709    gcc-14.2.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250708    gcc-8.5.0
nios2                 randconfig-001-20250709    gcc-14.2.0
nios2                 randconfig-002-20250708    gcc-8.5.0
nios2                 randconfig-002-20250709    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250708    gcc-9.3.0
parisc                randconfig-001-20250709    gcc-14.2.0
parisc                randconfig-002-20250708    gcc-14.3.0
parisc                randconfig-002-20250709    gcc-14.2.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250708    gcc-8.5.0
powerpc               randconfig-001-20250709    gcc-14.2.0
powerpc               randconfig-002-20250708    clang-19
powerpc               randconfig-002-20250709    gcc-14.2.0
powerpc               randconfig-003-20250708    clang-21
powerpc               randconfig-003-20250709    gcc-14.2.0
powerpc64             randconfig-001-20250708    clang-21
powerpc64             randconfig-001-20250709    gcc-14.2.0
powerpc64             randconfig-002-20250708    clang-21
powerpc64             randconfig-002-20250709    gcc-14.2.0
powerpc64             randconfig-003-20250708    clang-21
powerpc64             randconfig-003-20250709    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250708    clang-16
riscv                 randconfig-001-20250709    gcc-12
riscv                 randconfig-002-20250708    gcc-11.5.0
riscv                 randconfig-002-20250709    gcc-12
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250708    gcc-14.3.0
s390                  randconfig-001-20250709    gcc-12
s390                  randconfig-002-20250708    gcc-9.3.0
s390                  randconfig-002-20250709    gcc-12
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250708    gcc-11.5.0
sh                    randconfig-001-20250709    gcc-12
sh                    randconfig-002-20250708    gcc-15.1.0
sh                    randconfig-002-20250709    gcc-12
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250708    gcc-13.4.0
sparc                 randconfig-001-20250709    gcc-12
sparc                 randconfig-002-20250708    gcc-13.4.0
sparc                 randconfig-002-20250709    gcc-12
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250708    clang-21
sparc64               randconfig-001-20250709    gcc-12
sparc64               randconfig-002-20250708    gcc-15.1.0
sparc64               randconfig-002-20250709    gcc-12
um                               alldefconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250708    clang-21
um                    randconfig-001-20250709    gcc-12
um                    randconfig-002-20250708    clang-17
um                    randconfig-002-20250709    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250708    gcc-12
x86_64      buildonly-randconfig-001-20250709    clang-20
x86_64      buildonly-randconfig-002-20250708    gcc-12
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-003-20250708    clang-20
x86_64      buildonly-randconfig-003-20250709    clang-20
x86_64      buildonly-randconfig-004-20250708    gcc-12
x86_64      buildonly-randconfig-004-20250709    clang-20
x86_64      buildonly-randconfig-005-20250708    clang-20
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-006-20250708    clang-20
x86_64      buildonly-randconfig-006-20250709    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250709    clang-20
x86_64                randconfig-002-20250709    clang-20
x86_64                randconfig-003-20250709    clang-20
x86_64                randconfig-004-20250709    clang-20
x86_64                randconfig-005-20250709    clang-20
x86_64                randconfig-006-20250709    clang-20
x86_64                randconfig-007-20250709    clang-20
x86_64                randconfig-008-20250709    clang-20
x86_64                randconfig-071-20250709    gcc-12
x86_64                randconfig-072-20250709    gcc-12
x86_64                randconfig-073-20250709    gcc-12
x86_64                randconfig-074-20250709    gcc-12
x86_64                randconfig-075-20250709    gcc-12
x86_64                randconfig-076-20250709    gcc-12
x86_64                randconfig-077-20250709    gcc-12
x86_64                randconfig-078-20250709    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250708    gcc-8.5.0
xtensa                randconfig-001-20250709    gcc-12
xtensa                randconfig-002-20250708    gcc-9.3.0
xtensa                randconfig-002-20250709    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

