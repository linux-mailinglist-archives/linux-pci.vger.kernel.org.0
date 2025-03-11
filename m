Return-Path: <linux-pci+bounces-23468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75258A5D2EE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 00:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85D217A886
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6E1F4CB2;
	Tue, 11 Mar 2025 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dhk+eny9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF11EE7CB
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734310; cv=none; b=Ro9UiHDE9rCb2nPDBiE6SHMur2rC31XeyzS0bXLQCBD217Wrfqre+oUPHLSojci26bvnmjUFsZ1I1WZSIJ4Ze+9gh5kBcGjjpEN0pFvvCZEWUNFpstG+UcnQ586yvlRQWwzOUiRo2SjQ6RLw/Qh3jmdRaxj11jiSxQzxiBNqGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734310; c=relaxed/simple;
	bh=qbUaq1kzcugi1wuNUw+/pnqIQWPooWbW8+SJIijn3JM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=El7mrf2JceF+UPE1ZXHQBYt0nA8fJzftEEuE5PxptiFPBTi4nef8WFi3KTc0ZK67Yaq6SgZH5ZegjKoynqcrElsZ+2NVocreJF8AO6sze7FUKo7+ZdInUjz7856EO8/obw4bNgmqEjm9qB4+69pCwzHsRTO5EnZsvu55W2XMIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dhk+eny9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741734310; x=1773270310;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qbUaq1kzcugi1wuNUw+/pnqIQWPooWbW8+SJIijn3JM=;
  b=Dhk+eny9TR1Iu94umdZgBX2M7Y0FVy/qLlstv1AvUY+QuusHDFL/VCFM
   H/QBbuEC3/FQS/l1Hzov+f3CzGhbi9S4ASgTH8Jxz68nN7uteFCNGZGKs
   J80FcAuDEPaIgAfwFyDR2ZzAnF3PUGqG0BxJVR0uAjNT04I3jCB3GYvUg
   ZYJHGG9yF5tLWt8Ioln97cglZ/+IioyHov53uRSsgE0bThcgGvXea84+8
   QZXl5MIhSt3GEWCT8uZBV66Zhq9S4xuatjafIUpey2gN1c6QkQYOXVC8v
   jjieUW3z/758L7TWpzaNabV59GNh3vOquHPaYx+dvU7HSj3u4V0VhwGXD
   w==;
X-CSE-ConnectionGUID: TDABNcrvSHGj7gv8SqMZGA==
X-CSE-MsgGUID: /zOzVsAjQqeTY5zcc4J3YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46440532"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="46440532"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 16:05:09 -0700
X-CSE-ConnectionGUID: OB01VpelSLaAMTYqw9K1zQ==
X-CSE-MsgGUID: cmZWcFkrSlCaeUUo9zrqvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="120953789"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 11 Mar 2025 16:05:08 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts8em-0007vc-2x;
	Tue, 11 Mar 2025 23:05:04 +0000
Date: Wed, 12 Mar 2025 07:04:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 77f99d17f77f1ae99e9db2588c571ff4113370d8
Message-ID: <202503120742.XZT5bl09-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: 77f99d17f77f1ae99e9db2588c571ff4113370d8  PCI: imx6: Use devm_clk_bulk_get_all() to fetch clocks

elapsed time: 1462m

configs tested: 225
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250311    gcc-13.2.0
arc                   randconfig-001-20250312    clang-21
arc                   randconfig-002-20250311    gcc-13.2.0
arc                   randconfig-002-20250312    clang-21
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    gcc-14.2.0
arm                   randconfig-001-20250311    gcc-14.2.0
arm                   randconfig-001-20250312    clang-21
arm                   randconfig-002-20250311    clang-16
arm                   randconfig-002-20250312    clang-21
arm                   randconfig-003-20250311    gcc-14.2.0
arm                   randconfig-003-20250312    clang-21
arm                   randconfig-004-20250311    gcc-14.2.0
arm                   randconfig-004-20250312    clang-21
arm                        shmobile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250311    gcc-14.2.0
arm64                 randconfig-001-20250312    clang-21
arm64                 randconfig-002-20250311    gcc-14.2.0
arm64                 randconfig-002-20250312    clang-21
arm64                 randconfig-003-20250311    gcc-14.2.0
arm64                 randconfig-003-20250312    clang-21
arm64                 randconfig-004-20250311    gcc-14.2.0
arm64                 randconfig-004-20250312    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250311    gcc-14.2.0
csky                  randconfig-001-20250312    gcc-14.2.0
csky                  randconfig-002-20250311    gcc-14.2.0
csky                  randconfig-002-20250312    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250311    clang-21
hexagon               randconfig-001-20250312    gcc-14.2.0
hexagon               randconfig-002-20250311    clang-21
hexagon               randconfig-002-20250312    gcc-14.2.0
i386                             alldefconfig    gcc-14.2.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250311    gcc-12
i386        buildonly-randconfig-001-20250312    gcc-12
i386        buildonly-randconfig-002-20250311    clang-19
i386        buildonly-randconfig-002-20250312    gcc-12
i386        buildonly-randconfig-003-20250311    clang-19
i386        buildonly-randconfig-003-20250312    gcc-12
i386        buildonly-randconfig-004-20250311    clang-19
i386        buildonly-randconfig-004-20250312    gcc-12
i386        buildonly-randconfig-005-20250311    clang-19
i386        buildonly-randconfig-005-20250312    gcc-12
i386        buildonly-randconfig-006-20250311    gcc-11
i386        buildonly-randconfig-006-20250312    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250312    clang-19
i386                  randconfig-002-20250312    clang-19
i386                  randconfig-003-20250312    clang-19
i386                  randconfig-004-20250312    clang-19
i386                  randconfig-005-20250312    clang-19
i386                  randconfig-006-20250312    clang-19
i386                  randconfig-007-20250312    clang-19
i386                  randconfig-011-20250312    gcc-11
i386                  randconfig-012-20250312    gcc-11
i386                  randconfig-013-20250312    gcc-11
i386                  randconfig-014-20250312    gcc-11
i386                  randconfig-015-20250312    gcc-11
i386                  randconfig-016-20250312    gcc-11
i386                  randconfig-017-20250312    gcc-11
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250311    gcc-14.2.0
loongarch             randconfig-001-20250312    gcc-14.2.0
loongarch             randconfig-002-20250311    gcc-14.2.0
loongarch             randconfig-002-20250312    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250311    gcc-14.2.0
nios2                 randconfig-001-20250312    gcc-14.2.0
nios2                 randconfig-002-20250311    gcc-14.2.0
nios2                 randconfig-002-20250312    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-15
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250311    gcc-14.2.0
parisc                randconfig-001-20250312    gcc-14.2.0
parisc                randconfig-002-20250311    gcc-14.2.0
parisc                randconfig-002-20250312    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                  mpc885_ads_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250311    clang-21
powerpc               randconfig-001-20250312    gcc-14.2.0
powerpc               randconfig-002-20250311    clang-16
powerpc               randconfig-002-20250312    gcc-14.2.0
powerpc               randconfig-003-20250311    gcc-14.2.0
powerpc               randconfig-003-20250312    gcc-14.2.0
powerpc64             randconfig-001-20250311    gcc-14.2.0
powerpc64             randconfig-001-20250312    gcc-14.2.0
powerpc64             randconfig-002-20250311    clang-18
powerpc64             randconfig-002-20250312    gcc-14.2.0
powerpc64             randconfig-003-20250311    gcc-14.2.0
powerpc64             randconfig-003-20250312    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250311    gcc-14.2.0
riscv                 randconfig-001-20250312    gcc-14.2.0
riscv                 randconfig-002-20250311    gcc-14.2.0
riscv                 randconfig-002-20250312    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250311    clang-15
s390                  randconfig-001-20250312    gcc-14.2.0
s390                  randconfig-002-20250311    gcc-14.2.0
s390                  randconfig-002-20250312    gcc-14.2.0
s390                       zfcpdump_defconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250311    gcc-14.2.0
sh                    randconfig-001-20250312    gcc-14.2.0
sh                    randconfig-002-20250311    gcc-14.2.0
sh                    randconfig-002-20250312    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250311    gcc-14.2.0
sparc                 randconfig-001-20250312    gcc-14.2.0
sparc                 randconfig-002-20250311    gcc-14.2.0
sparc                 randconfig-002-20250312    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250311    gcc-14.2.0
sparc64               randconfig-001-20250312    gcc-14.2.0
sparc64               randconfig-002-20250311    gcc-14.2.0
sparc64               randconfig-002-20250312    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250311    gcc-12
um                    randconfig-001-20250312    gcc-14.2.0
um                    randconfig-002-20250311    gcc-12
um                    randconfig-002-20250312    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250311    gcc-12
x86_64      buildonly-randconfig-001-20250312    gcc-12
x86_64      buildonly-randconfig-002-20250311    gcc-12
x86_64      buildonly-randconfig-002-20250312    gcc-12
x86_64      buildonly-randconfig-003-20250311    clang-19
x86_64      buildonly-randconfig-003-20250312    gcc-12
x86_64      buildonly-randconfig-004-20250311    clang-19
x86_64      buildonly-randconfig-004-20250312    gcc-12
x86_64      buildonly-randconfig-005-20250311    gcc-12
x86_64      buildonly-randconfig-005-20250312    gcc-12
x86_64      buildonly-randconfig-006-20250311    gcc-12
x86_64      buildonly-randconfig-006-20250312    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250312    gcc-12
x86_64                randconfig-002-20250312    gcc-12
x86_64                randconfig-003-20250312    gcc-12
x86_64                randconfig-004-20250312    gcc-12
x86_64                randconfig-005-20250312    gcc-12
x86_64                randconfig-006-20250312    gcc-12
x86_64                randconfig-007-20250312    gcc-12
x86_64                randconfig-008-20250312    gcc-12
x86_64                randconfig-071-20250312    clang-19
x86_64                randconfig-072-20250312    clang-19
x86_64                randconfig-073-20250312    clang-19
x86_64                randconfig-074-20250312    clang-19
x86_64                randconfig-075-20250312    clang-19
x86_64                randconfig-076-20250312    clang-19
x86_64                randconfig-077-20250312    clang-19
x86_64                randconfig-078-20250312    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250311    gcc-14.2.0
xtensa                randconfig-001-20250312    gcc-14.2.0
xtensa                randconfig-002-20250311    gcc-14.2.0
xtensa                randconfig-002-20250312    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

