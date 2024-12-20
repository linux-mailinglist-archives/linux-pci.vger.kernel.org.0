Return-Path: <linux-pci+bounces-18912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58709F96AC
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 17:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3031188222B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014751BD9C1;
	Fri, 20 Dec 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU3nw8nu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D7218EAC
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712610; cv=none; b=L8BzTBTR4VZDiWIsMx/7E0vzkK/u4XjPZnDBs2YyqoIS9x6OqebekzcH6xflcLTVxrqgX4et3/N7GSz1Pap1xwss6YE9Pfqe1bhYLRV/Hol7O6A4fSwT/iavhok3FHIkipWrCryRDNruMe33OvyBO3ffsgfFDkxoRw9OzJIfcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712610; c=relaxed/simple;
	bh=eLphhHkxgamVDYo8RlrSxX4rk8hNzYKkvvQ2ms2GfQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mUDMdv+fabASuEpKzPZzlTg+NZrDjKfXFgaa+w8VxoKwt3+zBd5UVtxNRNgZ2bolMNbraAyP8OWSUjeicpAQw9rK2ojayBowuhNDIXERcADaB0Gzy+AVP7ctCuIffBS9y7nmGv5EmjYBRxWE3i31WW4I7KRcAsaur/5kuDpX1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU3nw8nu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734712608; x=1766248608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eLphhHkxgamVDYo8RlrSxX4rk8hNzYKkvvQ2ms2GfQo=;
  b=bU3nw8nuW5MYPZQ18XxOv0sIWs/5CNdVyEeIpacX4CRS3UDzEK5MXtB8
   26Pz5g1CoxYUl9PQO8PNMtiAcSg8EkbONVxxkUjxN4LeMyFUVG2gedonV
   zwxplLjqQqqlUOqzVxytsoSCq8ODnBmS1MLYTGyRz3BOEZVfNYcMnWnIK
   R4Kg8kMGGHYe7IJRyn3gInec+C4fH8gBevKVmya46+zs7hDopcJlHEr0w
   ak34fp56mG4poEZFiaCGwQmldy3NmVd9/i9jIbKN/fsbOBE0T1ewqdS9v
   g0zLX0vS36PtkA0LJ4zWZTurZcQvKwZLzaJV6Q5Ycy8+NZQ4m+EPOu/aV
   g==;
X-CSE-ConnectionGUID: e6qFwgNoQj2LhQO6xcFffg==
X-CSE-MsgGUID: uwBSC0OLRWyRm07rMlQ/pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="34586976"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="34586976"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 08:36:48 -0800
X-CSE-ConnectionGUID: PSx0gVgbRsuZvkuc7/2WxQ==
X-CSE-MsgGUID: Kbf7fGLzTXCIHGnIf7TbGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98371640"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Dec 2024 08:36:47 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOfzZ-0001Q3-0j;
	Fri, 20 Dec 2024 16:36:45 +0000
Date: Sat, 21 Dec 2024 00:36:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 774c71c52aa487001c7da9f93b10cedc9985c371
Message-ID: <202412210023.oGgzEZw5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 774c71c52aa487001c7da9f93b10cedc9985c371  PCI/bwctrl: Enable only if more than one speed is supported

elapsed time: 1372m

configs tested: 191
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241220    gcc-13.2.0
arc                   randconfig-002-20241220    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20241220    clang-19
arm                   randconfig-001-20241220    gcc-13.2.0
arm                   randconfig-002-20241220    gcc-13.2.0
arm                   randconfig-002-20241220    gcc-14.2.0
arm                   randconfig-003-20241220    gcc-13.2.0
arm                   randconfig-003-20241220    gcc-14.2.0
arm                   randconfig-004-20241220    clang-20
arm                   randconfig-004-20241220    gcc-13.2.0
arm                        spear3xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241220    clang-17
arm64                 randconfig-001-20241220    gcc-13.2.0
arm64                 randconfig-002-20241220    clang-19
arm64                 randconfig-002-20241220    gcc-13.2.0
arm64                 randconfig-003-20241220    clang-20
arm64                 randconfig-003-20241220    gcc-13.2.0
arm64                 randconfig-004-20241220    clang-19
arm64                 randconfig-004-20241220    gcc-13.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241220    gcc-14.2.0
csky                  randconfig-002-20241220    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241220    clang-20
hexagon               randconfig-001-20241220    gcc-14.2.0
hexagon               randconfig-002-20241220    clang-20
hexagon               randconfig-002-20241220    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241220    gcc-12
i386        buildonly-randconfig-002-20241220    gcc-12
i386        buildonly-randconfig-003-20241220    gcc-12
i386        buildonly-randconfig-004-20241220    clang-19
i386        buildonly-randconfig-004-20241220    gcc-12
i386        buildonly-randconfig-005-20241220    gcc-12
i386        buildonly-randconfig-006-20241220    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241220    clang-19
i386                  randconfig-002-20241220    clang-19
i386                  randconfig-003-20241220    clang-19
i386                  randconfig-004-20241220    clang-19
i386                  randconfig-005-20241220    clang-19
i386                  randconfig-006-20241220    clang-19
i386                  randconfig-007-20241220    clang-19
i386                  randconfig-011-20241220    gcc-12
i386                  randconfig-012-20241220    gcc-12
i386                  randconfig-013-20241220    gcc-12
i386                  randconfig-014-20241220    gcc-12
i386                  randconfig-015-20241220    gcc-12
i386                  randconfig-016-20241220    gcc-12
i386                  randconfig-017-20241220    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241220    gcc-14.2.0
loongarch             randconfig-002-20241220    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241220    gcc-14.2.0
nios2                 randconfig-002-20241220    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241220    gcc-14.2.0
parisc                randconfig-002-20241220    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                          g5_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241220    clang-15
powerpc               randconfig-001-20241220    gcc-14.2.0
powerpc               randconfig-002-20241220    gcc-14.2.0
powerpc               randconfig-003-20241220    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241220    gcc-14.2.0
powerpc64             randconfig-002-20241220    clang-19
powerpc64             randconfig-002-20241220    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241220    clang-20
riscv                 randconfig-001-20241220    gcc-14.2.0
riscv                 randconfig-002-20241220    clang-19
riscv                 randconfig-002-20241220    clang-20
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241220    clang-20
s390                  randconfig-001-20241220    gcc-14.2.0
s390                  randconfig-002-20241220    clang-20
s390                  randconfig-002-20241220    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20241220    clang-20
sh                    randconfig-001-20241220    gcc-14.2.0
sh                    randconfig-002-20241220    clang-20
sh                    randconfig-002-20241220    gcc-14.2.0
sh                           se7712_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241220    clang-20
sparc                 randconfig-001-20241220    gcc-14.2.0
sparc                 randconfig-002-20241220    clang-20
sparc                 randconfig-002-20241220    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241220    clang-20
sparc64               randconfig-001-20241220    gcc-14.2.0
sparc64               randconfig-002-20241220    clang-20
sparc64               randconfig-002-20241220    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241220    clang-20
um                    randconfig-002-20241220    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241220    clang-19
x86_64      buildonly-randconfig-001-20241220    gcc-12
x86_64      buildonly-randconfig-002-20241220    clang-19
x86_64      buildonly-randconfig-003-20241220    clang-19
x86_64      buildonly-randconfig-003-20241220    gcc-12
x86_64      buildonly-randconfig-004-20241220    clang-19
x86_64      buildonly-randconfig-004-20241220    gcc-12
x86_64      buildonly-randconfig-005-20241220    clang-19
x86_64      buildonly-randconfig-006-20241220    clang-19
x86_64      buildonly-randconfig-006-20241220    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241220    gcc-11
x86_64                randconfig-002-20241220    gcc-11
x86_64                randconfig-003-20241220    gcc-11
x86_64                randconfig-004-20241220    gcc-11
x86_64                randconfig-005-20241220    gcc-11
x86_64                randconfig-006-20241220    gcc-11
x86_64                randconfig-007-20241220    gcc-11
x86_64                randconfig-008-20241220    gcc-11
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241220    clang-20
xtensa                randconfig-001-20241220    gcc-14.2.0
xtensa                randconfig-002-20241220    clang-20
xtensa                randconfig-002-20241220    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

