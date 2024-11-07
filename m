Return-Path: <linux-pci+bounces-16218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF639C02F0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 11:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECE81F2169B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694751E9068;
	Thu,  7 Nov 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsryzZsZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859D1DFE24
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976670; cv=none; b=a+Z1w4DzIN/ytJUpdS9DnOacCHqP0385p2Btji9M/PYQWNyYYGXUS1WlnwKDpmlLilfiZIiC6hBRkBJ1O9q75hZKCaTPBSAyhQlmELquDem76bgcnuCM/fa9iDtE9JOf/XPEOc6+6kQZQbBZh/H52B0uM/99a6G4J4QcL2okUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976670; c=relaxed/simple;
	bh=8eCQrtCGfIzIWvsfedKTRkJIBtZqrTzitKF6jirUlw4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UDBZDtC2xJkZ41jP240GjrctjSClusiCkmZfm7eQ/itgiTcDmR81C4/Ry99YHb89YAYtqmFaz51n5dkLY5O6Gz4O1ORweUBr4avMoIwuFvnmSueTRGjax8aBC+YXBsqAGAkHPmFrhKpqZ7ag1A6fkLIRtMtXvYbiE7EioKSbxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsryzZsZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730976668; x=1762512668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8eCQrtCGfIzIWvsfedKTRkJIBtZqrTzitKF6jirUlw4=;
  b=dsryzZsZw8ZfKfSK6sToAMuC2BjyW6nIpatXJyL5sy+z0sBEF86Dmv7j
   lkybBR3l0BNNQRJjMdt/7EOS9LZM7XASIjb4ofW89BPLPzidTwjsRVuOL
   ys6R0RUcamy9fFVYgFv1H01q0cFhTbBOkXPoXk+2pDDM7LjhyQtp9JqOr
   1EnXLNB0Zh1VJy2hSiP26rdZ7BychkTzrlRFZ2y2up/yWOZKClzr6M9JD
   h2pYsXDSjFp6tL3xrSK2ixpGNF4xSgVAhw7np1Lih350H7AskpBjxQ7AO
   y4C1SY/u/VYGk5GNQzUqUCNricTzjMtLZy5XWyIJFKZ3ytLU0YLF40mMo
   w==;
X-CSE-ConnectionGUID: ++myPwS9Sbaqfp3iU/hcEg==
X-CSE-MsgGUID: dxcZ/KORSUqdnvO72GMnLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="41430263"
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="41430263"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 02:51:07 -0800
X-CSE-ConnectionGUID: TTON6YE1T9qv1rait7p6/w==
X-CSE-MsgGUID: u+5vff1BTOmWUmTf92Pmmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="89566333"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Nov 2024 02:51:06 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t906S-000q7q-1c;
	Thu, 07 Nov 2024 10:51:04 +0000
Date: Thu, 07 Nov 2024 18:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctl] BUILD SUCCESS
 c44683dbad6535f7a8fc2f659193e831d56a8ec4
Message-ID: <202411071808.lJdT7YJ5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctl
branch HEAD: c44683dbad6535f7a8fc2f659193e831d56a8ec4  PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent

elapsed time: 724m

configs tested: 201
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    clang-20
arc                        nsimosci_defconfig    clang-20
arc                   randconfig-001-20241107    gcc-14.2.0
arc                   randconfig-002-20241107    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                            hisi_defconfig    clang-20
arm                           imxrt_defconfig    gcc-14.2.0
arm                         nhk8815_defconfig    clang-20
arm                            qcom_defconfig    clang-20
arm                   randconfig-001-20241107    gcc-14.2.0
arm                   randconfig-002-20241107    gcc-14.2.0
arm                   randconfig-003-20241107    gcc-14.2.0
arm                   randconfig-004-20241107    gcc-14.2.0
arm                             rpc_defconfig    clang-20
arm                             rpc_defconfig    gcc-14.2.0
arm                       spear13xx_defconfig    clang-20
arm                       versatile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    clang-20
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241107    gcc-14.2.0
arm64                 randconfig-002-20241107    gcc-14.2.0
arm64                 randconfig-003-20241107    gcc-14.2.0
arm64                 randconfig-004-20241107    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241107    gcc-14.2.0
csky                  randconfig-002-20241107    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241107    gcc-14.2.0
hexagon               randconfig-002-20241107    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241107    clang-19
i386        buildonly-randconfig-002-20241107    clang-19
i386        buildonly-randconfig-003-20241107    clang-19
i386        buildonly-randconfig-004-20241107    clang-19
i386        buildonly-randconfig-005-20241107    clang-19
i386        buildonly-randconfig-006-20241107    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241107    clang-19
i386                  randconfig-002-20241107    clang-19
i386                  randconfig-003-20241107    clang-19
i386                  randconfig-004-20241107    clang-19
i386                  randconfig-005-20241107    clang-19
i386                  randconfig-006-20241107    clang-19
i386                  randconfig-011-20241107    clang-19
i386                  randconfig-012-20241107    clang-19
i386                  randconfig-013-20241107    clang-19
i386                  randconfig-014-20241107    clang-19
i386                  randconfig-015-20241107    clang-19
i386                  randconfig-016-20241107    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241107    gcc-14.2.0
loongarch             randconfig-002-20241107    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    clang-20
m68k                          amiga_defconfig    clang-20
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                           sun3_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241107    gcc-14.2.0
nios2                 randconfig-002-20241107    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    clang-20
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-20
parisc                randconfig-001-20241107    gcc-14.2.0
parisc                randconfig-002-20241107    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        cell_defconfig    clang-20
powerpc                   currituck_defconfig    clang-20
powerpc                   motionpro_defconfig    clang-20
powerpc                     mpc5200_defconfig    clang-20
powerpc                 mpc834x_itx_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc                      pcm030_defconfig    clang-20
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    clang-20
powerpc               randconfig-001-20241107    gcc-14.2.0
powerpc               randconfig-002-20241107    gcc-14.2.0
powerpc               randconfig-003-20241107    gcc-14.2.0
powerpc                     sequoia_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc                     tqm8555_defconfig    clang-20
powerpc64             randconfig-003-20241107    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241107    gcc-14.2.0
riscv                 randconfig-002-20241107    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241107    gcc-14.2.0
s390                  randconfig-002-20241107    gcc-14.2.0
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    clang-20
sh                        edosk7760_defconfig    clang-20
sh                          lboxre2_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    clang-20
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241107    gcc-14.2.0
sh                    randconfig-002-20241107    gcc-14.2.0
sh                           se7712_defconfig    clang-20
sh                           se7721_defconfig    clang-20
sh                           sh2007_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241107    gcc-14.2.0
sparc64               randconfig-002-20241107    gcc-14.2.0
um                               alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241107    gcc-14.2.0
um                    randconfig-002-20241107    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241107    clang-19
x86_64      buildonly-randconfig-002-20241107    clang-19
x86_64      buildonly-randconfig-003-20241107    clang-19
x86_64      buildonly-randconfig-004-20241107    clang-19
x86_64      buildonly-randconfig-005-20241107    clang-19
x86_64      buildonly-randconfig-006-20241107    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241107    clang-19
x86_64                randconfig-002-20241107    clang-19
x86_64                randconfig-003-20241107    clang-19
x86_64                randconfig-004-20241107    clang-19
x86_64                randconfig-005-20241107    clang-19
x86_64                randconfig-006-20241107    clang-19
x86_64                randconfig-011-20241107    clang-19
x86_64                randconfig-012-20241107    clang-19
x86_64                randconfig-013-20241107    clang-19
x86_64                randconfig-014-20241107    clang-19
x86_64                randconfig-015-20241107    clang-19
x86_64                randconfig-016-20241107    clang-19
x86_64                randconfig-071-20241107    clang-19
x86_64                randconfig-072-20241107    clang-19
x86_64                randconfig-073-20241107    clang-19
x86_64                randconfig-074-20241107    clang-19
x86_64                randconfig-075-20241107    clang-19
x86_64                randconfig-076-20241107    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241107    gcc-14.2.0
xtensa                randconfig-002-20241107    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

