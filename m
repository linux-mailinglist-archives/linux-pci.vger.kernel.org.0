Return-Path: <linux-pci+bounces-12584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E3967D34
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 03:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9EA1F212E4
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 01:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0EEAD0;
	Mon,  2 Sep 2024 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBo8FNvN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EBA1388
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725239259; cv=none; b=L3WC1WQYn6QBLMJWkpgvB2D04CfwVtIJ3yq+zyKECy5QEAmtSdv/GN6sEmpNl+5GoJpPla88iQggNlk9jsfP0dxh2IZEQ4iBuoeg8I64oEbjMSzVysWUuDKs74kZlArtR0fkEpBN9Fh/syTC0aGnyJ9vuyd0RxK3tuFhqlit9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725239259; c=relaxed/simple;
	bh=hCksl6rYHObK/Vn+ymvRbTFMGhk/cm1/5PRLhQpb1NM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nShD2dPvwzLQQPqe4kdgV/GMaBS1lIMzWXOslQsxBVc1uAaBwsk5DyzUCpPDhynF1ozA40MEhowK/qqhpkja8Gldrp+BXVzrFZaql4xJ/HYz6cD9wvbfn0dCud4+zfZfJlUSTmxo6ndlyTNOBNf8nrR7ZH84aE2kL9uNftDQWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBo8FNvN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725239258; x=1756775258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hCksl6rYHObK/Vn+ymvRbTFMGhk/cm1/5PRLhQpb1NM=;
  b=CBo8FNvNjYcGQ5rvl8FTYVSp3VJ0QxV/38kPS0qDtgDGxU3YTWzKZF6M
   XOUazbk6mIznL+C65aISbKp01hiD1h9rey4gl+0xMhIJTPG6cWVO0Jofl
   abnnzmX5isK+PGz3R56/2+ioLNLiW8OOwNGSDISnQWj15zdWs5aUrnHn5
   ezMKTTgpzkX0bTFUWDGgk60QWKtd28bectesoBa27iDhc9vyeRwKfqHJ3
   j/rvPDtzDehrnx+Knuc6+PjekRGvox32eDmXYNHRKk8Ub50aieG9f2rmZ
   sLUJ9w438H2kJ7y5hBAJ7rUgWaCqTECLaRgMtdvnMqVktlFheVDfdsKyR
   A==;
X-CSE-ConnectionGUID: 2J/ReZn9Qxm3n1cLIgrPzQ==
X-CSE-MsgGUID: QIHWcQQjQ/uhUknij1dIfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="46316090"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="46316090"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 18:07:35 -0700
X-CSE-ConnectionGUID: xvTMXhn/TmaQmRtSRuMdRA==
X-CSE-MsgGUID: Lbzgr4gbSSuRflBdkuMkJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="68590011"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 01 Sep 2024 18:07:32 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skvXV-00050w-2Z;
	Mon, 02 Sep 2024 01:07:29 +0000
Date: Mon, 02 Sep 2024 09:06:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 10ba0854c5e6165b58e17bda5fb671e729fecf9e
Message-ID: <202409020953.F42hGsuP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 10ba0854c5e6165b58e17bda5fb671e729fecf9e  PCI: qcom: Disable mirroring of DBI and iATU register space in BAR region

elapsed time: 938m

configs tested: 181
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-14.1.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240901   clang-20
arc                   randconfig-002-20240901   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                       aspeed_g4_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-14.1.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                   randconfig-001-20240901   clang-20
arm                   randconfig-002-20240901   clang-20
arm                   randconfig-003-20240901   clang-20
arm                   randconfig-004-20240901   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240901   clang-20
arm64                 randconfig-002-20240901   clang-20
arm64                 randconfig-003-20240901   clang-20
arm64                 randconfig-004-20240901   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240901   clang-20
csky                  randconfig-002-20240901   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240901   clang-20
hexagon               randconfig-002-20240901   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240901   clang-18
i386         buildonly-randconfig-001-20240902   clang-18
i386         buildonly-randconfig-002-20240901   clang-18
i386         buildonly-randconfig-002-20240902   clang-18
i386         buildonly-randconfig-003-20240901   clang-18
i386         buildonly-randconfig-003-20240902   clang-18
i386         buildonly-randconfig-004-20240901   clang-18
i386         buildonly-randconfig-004-20240902   clang-18
i386         buildonly-randconfig-005-20240901   clang-18
i386         buildonly-randconfig-005-20240902   clang-18
i386         buildonly-randconfig-006-20240901   clang-18
i386         buildonly-randconfig-006-20240902   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240901   clang-18
i386                  randconfig-001-20240902   clang-18
i386                  randconfig-002-20240901   clang-18
i386                  randconfig-002-20240902   clang-18
i386                  randconfig-003-20240901   clang-18
i386                  randconfig-003-20240902   clang-18
i386                  randconfig-004-20240901   clang-18
i386                  randconfig-004-20240902   clang-18
i386                  randconfig-005-20240901   clang-18
i386                  randconfig-005-20240902   clang-18
i386                  randconfig-006-20240901   clang-18
i386                  randconfig-006-20240902   clang-18
i386                  randconfig-011-20240901   clang-18
i386                  randconfig-011-20240902   clang-18
i386                  randconfig-012-20240901   clang-18
i386                  randconfig-012-20240902   clang-18
i386                  randconfig-013-20240901   clang-18
i386                  randconfig-013-20240902   clang-18
i386                  randconfig-014-20240901   clang-18
i386                  randconfig-014-20240902   clang-18
i386                  randconfig-015-20240901   clang-18
i386                  randconfig-015-20240902   clang-18
i386                  randconfig-016-20240901   clang-18
i386                  randconfig-016-20240902   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240901   clang-20
loongarch             randconfig-002-20240901   clang-20
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                            q40_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-14.1.0
mips                        bcm63xx_defconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                        maltaup_defconfig   gcc-14.1.0
mips                           mtx1_defconfig   gcc-13.2.0
mips                        omega2p_defconfig   gcc-13.2.0
nios2                         3c120_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240901   clang-20
nios2                 randconfig-002-20240901   clang-20
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                    or1ksim_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240901   clang-20
parisc                randconfig-002-20240901   clang-20
parisc64                            defconfig   gcc-14.1.0
powerpc                    adder875_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   currituck_defconfig   gcc-14.1.0
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240901   clang-20
powerpc               randconfig-002-20240901   clang-20
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-14.1.0
powerpc                     stx_gp3_defconfig   gcc-14.1.0
powerpc                     tqm8540_defconfig   gcc-13.2.0
powerpc                     tqm8548_defconfig   gcc-14.1.0
powerpc                      tqm8xx_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240901   clang-20
powerpc64             randconfig-002-20240901   clang-20
powerpc64             randconfig-003-20240901   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240901   clang-20
riscv                 randconfig-002-20240901   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240901   clang-20
s390                  randconfig-002-20240901   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                            migor_defconfig   gcc-13.2.0
sh                    randconfig-001-20240901   clang-20
sh                    randconfig-002-20240901   clang-20
sh                           se7780_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                   sh7724_generic_defconfig   gcc-13.2.0
sh                  sh7785lcr_32bit_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240901   clang-20
sparc64               randconfig-002-20240901   clang-20
um                               alldefconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240901   clang-20
um                    randconfig-002-20240901   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240901   clang-20
xtensa                randconfig-002-20240901   clang-20
xtensa                    xip_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

