Return-Path: <linux-pci+bounces-38992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1546BBFB7A0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E7D5646B9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A5350A0F;
	Wed, 22 Oct 2025 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPxZ+rUt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED4328625
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130420; cv=none; b=VUcA3fak5JJTtQ6QWrwbDPKxKfi4UObnAEgvfPZvK++MbcK5c47ftqA92iEMDXtobttMoXAPb3r+Ubhap94gp/ZIoCUWE3TmbYMj6LqhJja1Ex+WulMd3kiLT5diAj8vBGXsefJ7CvRkRBerF696/7hHxGYQd2Mk1156mHlpM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130420; c=relaxed/simple;
	bh=9tFgghSYzOHbh5LBOca4DCQs3iC7uCipXJTcIUzsBRY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bB0OvmwHp3un6zQbQ4bO8iklVlPR0c+ljbZd1lRuRFzamFpAhaBO92h4hlgLqxsVo0FVFeAHBN3H00uZAIRaJp2gvEcXRhhW+/VoEagVXoprDMJr31ED+OVu79M0v0NRIBPn8e6WwSlbVBysicy3AgiYX9rY6sSTHt8Ga320qcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPxZ+rUt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761130418; x=1792666418;
  h=date:from:to:cc:subject:message-id;
  bh=9tFgghSYzOHbh5LBOca4DCQs3iC7uCipXJTcIUzsBRY=;
  b=cPxZ+rUtJHTAy72LsygJR+zGNQUjKx01gfs1McmY5A1LXx795IZNMnU7
   bwCClsf6GTha5WlR7jZGEdcUg7iH7y6JvshfAUK3ZEvsznidk02xW7cLz
   npE9zNOtsLZs0+MN0D8+Otn0Z5c9AhVRTa9NDaQLJ0aTrT10vyfKi+UsH
   xifWKPdraFtAgXHox7imR8k+8OeAlfbEeCk+7A3JqsnKdvk58/9FGdoTo
   pDTh4LvE+V831WDi/Lemqo3eIN5ZlD7m8yNTWKuaPt01R4HsGdtW+tbw5
   byzqg7X0l5qaNUFq4ID/GPem31QG7FNZBJ47y/y23kr5gqsI655LNBZo+
   w==;
X-CSE-ConnectionGUID: JApGOmQVTSyGRz1xpcdhSw==
X-CSE-MsgGUID: zMTvdz1FThaaClXF7WpKUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63310792"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="63310792"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 03:53:38 -0700
X-CSE-ConnectionGUID: NyiGDe8uQ3uzZn9rMmaaLg==
X-CSE-MsgGUID: gdGGNqZ2RLyxQ+DSNaqDWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="214784216"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Oct 2025 03:53:36 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBWTF-000CGu-06;
	Wed, 22 Oct 2025 10:53:33 +0000
Date: Wed, 22 Oct 2025 18:53:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dw-rockchip] BUILD SUCCESS
 7ad31f88429369ada44710176e176256a2812c3f
Message-ID: <202510221810.YRAiUrFo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dw-rockchip
branch HEAD: 7ad31f88429369ada44710176e176256a2812c3f  PCI: dw-rockchip: Prevent advertising L1 Substates support

elapsed time: 880m

configs tested: 211
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20251022    clang-22
arc                   randconfig-001-20251022    gcc-13.4.0
arc                   randconfig-002-20251022    clang-22
arc                   randconfig-002-20251022    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20251022    clang-22
arm                   randconfig-001-20251022    gcc-11.5.0
arm                   randconfig-002-20251022    clang-22
arm                   randconfig-002-20251022    gcc-10.5.0
arm                   randconfig-003-20251022    clang-22
arm                   randconfig-003-20251022    gcc-10.5.0
arm                   randconfig-004-20251022    clang-22
arm                        spear6xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251022    clang-22
arm64                 randconfig-001-20251022    gcc-9.5.0
arm64                 randconfig-002-20251022    clang-18
arm64                 randconfig-002-20251022    clang-22
arm64                 randconfig-003-20251022    clang-22
arm64                 randconfig-003-20251022    gcc-10.5.0
arm64                 randconfig-004-20251022    clang-22
arm64                 randconfig-004-20251022    gcc-12.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251022    clang-22
csky                  randconfig-001-20251022    gcc-15.1.0
csky                  randconfig-002-20251022    clang-22
csky                  randconfig-002-20251022    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251022    clang-22
hexagon               randconfig-002-20251022    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251022    clang-20
i386        buildonly-randconfig-001-20251022    gcc-14
i386        buildonly-randconfig-002-20251022    clang-20
i386        buildonly-randconfig-002-20251022    gcc-14
i386        buildonly-randconfig-003-20251022    gcc-14
i386        buildonly-randconfig-004-20251022    clang-20
i386        buildonly-randconfig-004-20251022    gcc-14
i386        buildonly-randconfig-005-20251022    gcc-12
i386        buildonly-randconfig-005-20251022    gcc-14
i386        buildonly-randconfig-006-20251022    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251022    gcc-14
i386                  randconfig-002-20251022    gcc-14
i386                  randconfig-003-20251022    gcc-14
i386                  randconfig-004-20251022    gcc-14
i386                  randconfig-005-20251022    gcc-14
i386                  randconfig-006-20251022    gcc-14
i386                  randconfig-007-20251022    gcc-14
i386                  randconfig-011-20251022    gcc-13
i386                  randconfig-012-20251022    gcc-13
i386                  randconfig-013-20251022    gcc-13
i386                  randconfig-014-20251022    gcc-13
i386                  randconfig-015-20251022    gcc-13
i386                  randconfig-016-20251022    gcc-13
i386                  randconfig-017-20251022    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251022    clang-22
loongarch             randconfig-001-20251022    gcc-12.5.0
loongarch             randconfig-002-20251022    clang-22
loongarch             randconfig-002-20251022    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251022    clang-22
nios2                 randconfig-001-20251022    gcc-8.5.0
nios2                 randconfig-002-20251022    clang-22
nios2                 randconfig-002-20251022    gcc-10.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251022    clang-22
parisc                randconfig-001-20251022    gcc-13.4.0
parisc                randconfig-002-20251022    clang-22
parisc                randconfig-002-20251022    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251022    clang-22
powerpc               randconfig-001-20251022    gcc-8.5.0
powerpc               randconfig-002-20251022    clang-22
powerpc               randconfig-002-20251022    gcc-8.5.0
powerpc               randconfig-003-20251022    clang-22
powerpc               randconfig-003-20251022    gcc-8.5.0
powerpc64             randconfig-001-20251022    clang-22
powerpc64             randconfig-001-20251022    gcc-8.5.0
powerpc64             randconfig-002-20251022    clang-22
powerpc64             randconfig-002-20251022    gcc-8.5.0
powerpc64             randconfig-003-20251022    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251022    gcc-14.3.0
riscv                 randconfig-002-20251022    gcc-14.3.0
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251022    gcc-14.3.0
s390                  randconfig-002-20251022    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251022    gcc-14.3.0
sh                    randconfig-002-20251022    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251022    gcc-14.3.0
sparc                 randconfig-002-20251022    gcc-14.3.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251022    gcc-14.3.0
sparc64               randconfig-002-20251022    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251022    gcc-14.3.0
um                    randconfig-002-20251022    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251022    clang-20
x86_64      buildonly-randconfig-002-20251022    clang-20
x86_64      buildonly-randconfig-002-20251022    gcc-14
x86_64      buildonly-randconfig-003-20251022    clang-20
x86_64      buildonly-randconfig-003-20251022    gcc-14
x86_64      buildonly-randconfig-004-20251022    clang-20
x86_64      buildonly-randconfig-005-20251022    clang-20
x86_64      buildonly-randconfig-005-20251022    gcc-14
x86_64      buildonly-randconfig-006-20251022    clang-20
x86_64      buildonly-randconfig-006-20251022    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251022    clang-20
x86_64                randconfig-002-20251022    clang-20
x86_64                randconfig-003-20251022    clang-20
x86_64                randconfig-004-20251022    clang-20
x86_64                randconfig-005-20251022    clang-20
x86_64                randconfig-006-20251022    clang-20
x86_64                randconfig-007-20251022    clang-20
x86_64                randconfig-008-20251022    clang-20
x86_64                randconfig-071-20251022    clang-20
x86_64                randconfig-072-20251022    clang-20
x86_64                randconfig-073-20251022    clang-20
x86_64                randconfig-074-20251022    clang-20
x86_64                randconfig-075-20251022    clang-20
x86_64                randconfig-076-20251022    clang-20
x86_64                randconfig-077-20251022    clang-20
x86_64                randconfig-078-20251022    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251022    gcc-14.3.0
xtensa                randconfig-002-20251022    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

