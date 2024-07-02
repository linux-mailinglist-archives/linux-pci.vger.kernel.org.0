Return-Path: <linux-pci+bounces-9579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF7923A3C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 11:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D9A283B76
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 09:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D3E1514DA;
	Tue,  2 Jul 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YV/0/9y9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31914D703
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912983; cv=none; b=bOVoRPdl4qaB8JlkK5fQRlZyWfW2et0m40uBPbmdIuYZb5vtSxH9K4KqDT2SgJ6w2RQ7Jly84h0nYvfgJSdKuNxcXDvI564RWMnO5gZ8AAfQytl2riLT5Sp5Cbp3KHQUR9RJl4xHGQ5YrPGaTiDiIkrjEudPQ+MJcRAWUWa9Amo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912983; c=relaxed/simple;
	bh=UTTm1m1b0Rx4WhmGrb21OOjJyY9Mubc/whx+bdiONo0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sGQzVKRla25btkGa0yUVamTtX2ZJHH3ak09tj3IulYsFBh4GhlCirtqb7quv6Y3uqVakk25mtH/QZi2koz/1qhqUD5ZCbopet3F7D1/eT190wNogino1cL8quuIq6aGxPU5PGrVrEPtsIGUUfVh+6cLaePphVn/bOFkCaDwH6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YV/0/9y9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719912981; x=1751448981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UTTm1m1b0Rx4WhmGrb21OOjJyY9Mubc/whx+bdiONo0=;
  b=YV/0/9y9z0xnItcEVqH4qcC9caGDvKeZtv7f+Pkls/iTDAvdbJDPti6u
   qWZ7i9iIoiAocYiRAMfF4uVFbxdRNioQkm+VvZdGy9k2GHqO/frQ9xnsF
   x3Wci1SU3u9oy6wvzOU/mgwWpLdFl3yUn+r/9xkEF2YPpra6e11vTNH8d
   MRz0/BPWTpe8cYwpq6pjpJJocX0E1sqQTQ8bDOhAYCLEv+IQQasmEUPPT
   d/nB1ymjUwsU9RGNvP9SCiBHNwTepIM87FMfI04JbrMsfE7CAWPkxjNvq
   Y2pJrbIvG6KuRm0cIqbDr7/iqbF0KptSSe4GnoHNplW4B2Yq5Rvmd5PlX
   A==;
X-CSE-ConnectionGUID: yWJV3XK5ROGRhTvQeN1Iog==
X-CSE-MsgGUID: 6pLPTQqVTOGfxkF9d2oCtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="19976153"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="19976153"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 02:36:21 -0700
X-CSE-ConnectionGUID: gK9iMzTPTX2Y7cToQJiWeA==
X-CSE-MsgGUID: ONUXnFuqQhSLb94nNrcceA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46263184"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Jul 2024 02:36:20 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOZvt-000NyZ-0L;
	Tue, 02 Jul 2024 09:36:17 +0000
Date: Tue, 02 Jul 2024 17:35:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 868f61ed02a343c34f280c043999500d4b65fe01
Message-ID: <202407021749.7UyzSM5I-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 868f61ed02a343c34f280c043999500d4b65fe01  dt-bindings: PCI: mediatek,mt7621-pcie: Add PCIe host topology ASCII graph

elapsed time: 1458m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240702   gcc-13.2.0
arc                   randconfig-002-20240702   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240702   gcc-13.2.0
arm                   randconfig-002-20240702   gcc-13.2.0
arm                   randconfig-003-20240702   gcc-13.2.0
arm                   randconfig-004-20240702   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240702   gcc-13.2.0
arm64                 randconfig-002-20240702   gcc-13.2.0
arm64                 randconfig-003-20240702   gcc-13.2.0
arm64                 randconfig-004-20240702   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240702   gcc-13.2.0
csky                  randconfig-002-20240702   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240701   clang-18
i386         buildonly-randconfig-001-20240702   gcc-13
i386         buildonly-randconfig-002-20240701   clang-18
i386         buildonly-randconfig-002-20240702   gcc-13
i386         buildonly-randconfig-003-20240701   clang-18
i386         buildonly-randconfig-003-20240702   gcc-13
i386         buildonly-randconfig-004-20240701   clang-18
i386         buildonly-randconfig-004-20240702   gcc-13
i386         buildonly-randconfig-005-20240701   gcc-13
i386         buildonly-randconfig-005-20240702   gcc-13
i386         buildonly-randconfig-006-20240701   gcc-9
i386         buildonly-randconfig-006-20240702   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240701   clang-18
i386                  randconfig-001-20240702   gcc-13
i386                  randconfig-002-20240701   clang-18
i386                  randconfig-002-20240702   gcc-13
i386                  randconfig-003-20240701   clang-18
i386                  randconfig-003-20240702   gcc-13
i386                  randconfig-004-20240701   gcc-7
i386                  randconfig-004-20240702   gcc-13
i386                  randconfig-005-20240701   clang-18
i386                  randconfig-005-20240702   gcc-13
i386                  randconfig-006-20240701   gcc-13
i386                  randconfig-006-20240702   gcc-13
i386                  randconfig-011-20240701   gcc-13
i386                  randconfig-011-20240702   gcc-13
i386                  randconfig-012-20240701   clang-18
i386                  randconfig-012-20240702   gcc-13
i386                  randconfig-013-20240701   clang-18
i386                  randconfig-013-20240702   gcc-13
i386                  randconfig-014-20240701   gcc-8
i386                  randconfig-014-20240702   gcc-13
i386                  randconfig-015-20240701   gcc-10
i386                  randconfig-015-20240702   gcc-13
i386                  randconfig-016-20240701   clang-18
i386                  randconfig-016-20240702   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240702   gcc-13.2.0
loongarch             randconfig-002-20240702   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                          amiga_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                          multi_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         cobalt_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   gcc-13.2.0
mips                       rbtx49xx_defconfig   gcc-13.2.0
mips                          rm200_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240702   gcc-13.2.0
nios2                 randconfig-002-20240702   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240702   gcc-13.2.0
parisc                randconfig-002-20240702   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                      arches_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240702   gcc-13.2.0
powerpc               randconfig-002-20240702   gcc-13.2.0
powerpc               randconfig-003-20240702   gcc-13.2.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240702   gcc-13.2.0
powerpc64             randconfig-002-20240702   gcc-13.2.0
powerpc64             randconfig-003-20240702   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240702   gcc-13.2.0
riscv                 randconfig-002-20240702   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240702   gcc-13.2.0
s390                  randconfig-002-20240702   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                            hp6xx_defconfig   gcc-13.2.0
sh                          landisk_defconfig   gcc-13.2.0
sh                    randconfig-001-20240702   gcc-13.2.0
sh                    randconfig-002-20240702   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240702   gcc-13.2.0
sparc64               randconfig-002-20240702   gcc-13.2.0
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240702   gcc-13.2.0
um                    randconfig-002-20240702   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240702   gcc-8
x86_64       buildonly-randconfig-002-20240702   gcc-8
x86_64       buildonly-randconfig-003-20240702   gcc-8
x86_64       buildonly-randconfig-004-20240702   gcc-8
x86_64       buildonly-randconfig-005-20240702   gcc-8
x86_64       buildonly-randconfig-006-20240702   gcc-8
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240702   gcc-8
x86_64                randconfig-002-20240702   gcc-8
x86_64                randconfig-003-20240702   gcc-8
x86_64                randconfig-004-20240702   gcc-8
x86_64                randconfig-005-20240702   gcc-8
x86_64                randconfig-006-20240702   gcc-8
x86_64                randconfig-011-20240702   gcc-8
x86_64                randconfig-012-20240702   gcc-8
x86_64                randconfig-013-20240702   gcc-8
x86_64                randconfig-014-20240702   gcc-8
x86_64                randconfig-015-20240702   gcc-8
x86_64                randconfig-016-20240702   gcc-8
x86_64                randconfig-071-20240702   gcc-8
x86_64                randconfig-072-20240702   gcc-8
x86_64                randconfig-073-20240702   gcc-8
x86_64                randconfig-074-20240702   gcc-8
x86_64                randconfig-075-20240702   gcc-8
x86_64                randconfig-076-20240702   gcc-8
x86_64                           rhel-8.3-bpf   clang-18
x86_64                          rhel-8.3-func   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240702   gcc-13.2.0
xtensa                randconfig-002-20240702   gcc-13.2.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

