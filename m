Return-Path: <linux-pci+bounces-24531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC36FA6DCA6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F3016A4F8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7574625F7AC;
	Mon, 24 Mar 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9806Z6N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A22505C5
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825599; cv=none; b=vGJwVzfPX0cS9TdM9i1kBI5clSzgpCvRB2plwxpCbZ+vRKZ5IP+2a1QXINOgB07XThZDV2n3ETXPTHYX7HZz75a48mwCJeQV78+AQn+M8eGkTX10zunsuhWCDn43dvytADDOW+nABnETlMsJnXKrH99vZWjUPta48eZOPdlowtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825599; c=relaxed/simple;
	bh=6u2tVM6plizU7gHZVou5cQnVBUTG5CEW7BDwkEl0Q0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D1XlNosr21VaeIzKooTamBQWR7Y+C6lmAFnY1YGyAYPO49wEUDpiimd7K0VI4YEG9e7ahlWaLvst05UjhV5p0y6q6YKHDlvSbwNFIZjo8DnuuxIeWtwEjje64Ay1FQzzv6a2Rbxi3C2HfWlMG6gUKEJVkm533WJ9wRy8PF+nh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9806Z6N; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742825597; x=1774361597;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6u2tVM6plizU7gHZVou5cQnVBUTG5CEW7BDwkEl0Q0g=;
  b=R9806Z6NRi0aCKkLNBwdmrAOWhku3M66BdLCVxssY2VbHXSbJZL5Ugc8
   58Uo2eLoe1OEe/X3XSEqiBEZJNtmdLelUs4N6GET1aL9xLfN5Qa9q7oWo
   wcxuke7L6EMSYDUPDnVm6ESKh4OePSthfvvgdI1vo483dftXFjiQZwsa3
   n6xMwZIkB7cGIL8V8Vq82VoqjPZfpAM3ZQAc2QPdOraVHwAJ1yMDhpksC
   P9Qp5zrug+75+dkYD45YlHfL++T9rJXTTM2KiHscjM4LaTdWiD8/IkBrN
   oPuuZeP1hzkSbXUlWayBJslQvxErjdpHpmm5AhRSeqFg2PoCBJDwmGbu5
   A==;
X-CSE-ConnectionGUID: aWPF7vJMQyGd8RLN6YBdMA==
X-CSE-MsgGUID: ykvQYLomQ6y+9gK3UOLGFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="46776465"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="46776465"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:13:16 -0700
X-CSE-ConnectionGUID: gdZ3DkOcRciCPbUK4hTz/w==
X-CSE-MsgGUID: nYlsxcd/QLqR1TE7txjLMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="128751291"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 24 Mar 2025 07:13:15 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twiYC-0003ej-3A;
	Mon, 24 Mar 2025 14:13:12 +0000
Date: Mon, 24 Mar 2025 22:12:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:bwctrl] BUILD SUCCESS
 667f053b05f00a007738cd7ed6fa1901de19dc7e
Message-ID: <202503242244.ktufcNDD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
branch HEAD: 667f053b05f00a007738cd7ed6fa1901de19dc7e  PCI/bwctrl: Fix NULL pointer dereference on bus number exhaustion

elapsed time: 1441m

configs tested: 192
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20250323    gcc-11.5.0
arc                   randconfig-002-20250323    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250323    gcc-7.5.0
arm                   randconfig-002-20250323    gcc-9.3.0
arm                   randconfig-003-20250323    clang-15
arm                   randconfig-004-20250323    gcc-5.5.0
arm                        realview_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250323    clang-21
arm64                 randconfig-002-20250323    gcc-5.5.0
arm64                 randconfig-003-20250323    gcc-9.5.0
arm64                 randconfig-004-20250323    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250323    gcc-13.3.0
csky                  randconfig-002-20250323    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250323    clang-21
hexagon               randconfig-002-20250323    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250323    clang-20
i386        buildonly-randconfig-002-20250323    gcc-12
i386        buildonly-randconfig-003-20250323    clang-20
i386        buildonly-randconfig-004-20250323    clang-20
i386        buildonly-randconfig-005-20250323    gcc-12
i386        buildonly-randconfig-006-20250323    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250324    gcc-12
i386                  randconfig-002-20250324    gcc-12
i386                  randconfig-003-20250324    gcc-12
i386                  randconfig-004-20250324    gcc-12
i386                  randconfig-005-20250324    gcc-12
i386                  randconfig-006-20250324    gcc-12
i386                  randconfig-007-20250324    gcc-12
i386                  randconfig-011-20250324    clang-20
i386                  randconfig-012-20250324    clang-20
i386                  randconfig-013-20250324    clang-20
i386                  randconfig-014-20250324    clang-20
i386                  randconfig-015-20250324    clang-20
i386                  randconfig-016-20250324    clang-20
i386                  randconfig-017-20250324    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250323    gcc-14.2.0
loongarch             randconfig-002-20250323    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-21
mips                        omega2p_defconfig    clang-21
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250323    gcc-13.3.0
nios2                 randconfig-002-20250323    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250323    gcc-10.5.0
parisc                randconfig-002-20250323    gcc-6.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250323    gcc-9.3.0
powerpc               randconfig-002-20250323    gcc-7.5.0
powerpc               randconfig-003-20250323    gcc-9.3.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250323    clang-16
powerpc64             randconfig-002-20250323    gcc-9.3.0
powerpc64             randconfig-003-20250323    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250323    gcc-9.3.0
riscv                 randconfig-002-20250323    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250323    gcc-8.5.0
s390                  randconfig-002-20250323    clang-15
s390                       zfcpdump_defconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250323    gcc-5.5.0
sh                    randconfig-002-20250323    gcc-5.5.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250323    gcc-14.2.0
sparc                 randconfig-002-20250323    gcc-10.3.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250323    gcc-14.2.0
sparc64               randconfig-002-20250323    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250323    gcc-12
um                    randconfig-002-20250323    clang-17
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250323    clang-20
x86_64      buildonly-randconfig-002-20250323    clang-20
x86_64      buildonly-randconfig-003-20250323    gcc-12
x86_64      buildonly-randconfig-004-20250323    clang-20
x86_64      buildonly-randconfig-005-20250323    clang-20
x86_64      buildonly-randconfig-006-20250323    clang-20
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250324    gcc-12
x86_64                randconfig-002-20250324    gcc-12
x86_64                randconfig-003-20250324    gcc-12
x86_64                randconfig-004-20250324    gcc-12
x86_64                randconfig-005-20250324    gcc-12
x86_64                randconfig-006-20250324    gcc-12
x86_64                randconfig-007-20250324    gcc-12
x86_64                randconfig-008-20250324    gcc-12
x86_64                randconfig-071-20250324    clang-20
x86_64                randconfig-072-20250324    clang-20
x86_64                randconfig-073-20250324    clang-20
x86_64                randconfig-074-20250324    clang-20
x86_64                randconfig-075-20250324    clang-20
x86_64                randconfig-076-20250324    clang-20
x86_64                randconfig-077-20250324    clang-20
x86_64                randconfig-078-20250324    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250323    gcc-14.2.0
xtensa                randconfig-002-20250323    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

