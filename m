Return-Path: <linux-pci+bounces-18915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FB89F9904
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 19:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8904B1697E5
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AA521B18C;
	Fri, 20 Dec 2024 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0C8TISh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544621B918
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716942; cv=none; b=E185DihDJP4utwWC/dWG0pQmxLAMA2Xt+QsRNA34PEk4HF+Cj5J2/MZmYaYt+OQrCpWIJqSDTAi5R1F4/G3J6q9XxKiR5BkAIstzHHLkrK3bLY3OIqgFjDxZft+tYCxOQpsSK1aLFsn4X1gYWwgpp42rt64PTm6dU1GtMhFScvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716942; c=relaxed/simple;
	bh=Q98deHXdv0/vGZjf/PkrwGzf8ysg/b1mPlLvc/rywlA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DfjXg3F7Y49bblGj7dTJ49kevLJmUhmPEOgqCHyE3nM7Ta4mzhf3uz+LZAe3yEva+xZTpnwCXlbBZQGEljKuqZ+XhG0Wb6GL+sWcKmid4qQFtbZ2x86xIqC5nfr5I9zY90NdaMCZ/JbiviYeqLWXnMN08OjP6xo2I1R3Zr2zreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0C8TISh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734716940; x=1766252940;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q98deHXdv0/vGZjf/PkrwGzf8ysg/b1mPlLvc/rywlA=;
  b=N0C8TIShOUZ6TG+Ulp7eLGZ9Ir1XakBEeTtZtlHKqyCz/YaeNRiGj7jS
   9i75Y9ad9audIl7Xk4NgNGoAplUjG9otFRwAo4lQJkl1npUz5W+1Lkow/
   gWtXnzUuFKBXp6jNj3LyYOqJA6N66H3IeeQ42bu0NSCWi65D/AE0YYT1G
   P1JSQpX5mO5gzIO8E8uayQwn9gBn50U3QM48f5HjrUNORV/ONu1wDh3Yd
   FXpTeJjmgPm//3xPHrATXYh4pqOHf8dbP5sNWIcuzsScFdbdnnUcCWeLa
   U7trM2VLPSYmS2+ux+HOdNWKEftUZR47Cxj4jteWUcj+Vj4JAEfwG378l
   A==;
X-CSE-ConnectionGUID: tlavnDzuT1Ky0K43PLa/0w==
X-CSE-MsgGUID: X8wxhuh4QcmRRIm9riIZsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="57744377"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="57744377"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 09:48:58 -0800
X-CSE-ConnectionGUID: NsHvxiJXQWSMrzdEnMaKmg==
X-CSE-MsgGUID: wdkatEb3QGm6kZgqOFN80A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98390355"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Dec 2024 09:48:55 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOh7N-0001Us-1L;
	Fri, 20 Dec 2024 17:48:53 +0000
Date: Sat, 21 Dec 2024 01:48:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 a00ac0bc28ed17b39a094c55a5e2217ae5b42ced
Message-ID: <202412210122.B4rJrpvJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: a00ac0bc28ed17b39a094c55a5e2217ae5b42ced  misc: pci_endpoint_test: Add support for capabilities

elapsed time: 1444m

configs tested: 188
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241220    gcc-13.2.0
arc                   randconfig-002-20241220    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
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
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241220    clang-17
arm64                 randconfig-001-20241220    gcc-13.2.0
arm64                 randconfig-002-20241220    clang-19
arm64                 randconfig-002-20241220    gcc-13.2.0
arm64                 randconfig-003-20241220    clang-20
arm64                 randconfig-003-20241220    gcc-13.2.0
arm64                 randconfig-004-20241220    clang-19
arm64                 randconfig-004-20241220    gcc-13.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241220    gcc-14.2.0
csky                  randconfig-002-20241220    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
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
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241220    gcc-14.2.0
loongarch             randconfig-002-20241220    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241220    gcc-14.2.0
nios2                 randconfig-002-20241220    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241220    gcc-14.2.0
parisc                randconfig-002-20241220    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
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
riscv                             allnoconfig    clang-20
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

