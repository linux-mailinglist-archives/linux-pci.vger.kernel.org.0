Return-Path: <linux-pci+bounces-14449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5199CA2E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 14:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C8EB24C41
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F971A0BCC;
	Mon, 14 Oct 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZifAuVaU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ECB19F434
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909067; cv=none; b=lmCvQ8znXWrz+gdi+YYS7gCoana35RrRtYkkyvYquEWx9pjuVBDFz5ecBVSGidlR5iy90WoGJRdNwxDox71ulVvS9dXqjsW2RuGN41kGsT/QEyVjx4uiyyOoVaBCfmTPNWBW1mseIf6u/rcNojcIMgmxfXbuYLMep1/ChO8XFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909067; c=relaxed/simple;
	bh=e5C5BQiHTMW/YaNjZtka+iIo+3OMjNuJzdPSfBbYvcA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l6bQr1HF+YEMK4BfITrg2K79Jaexc5SpTxFqpGQo3yock92z95YgBdwwEGGPmBe6zt2wAwXSNkCjSmnj71bBjJGdf4Tvt4S+5oiPBtwX/gzNzJuuuyX4n8zilR6jsIiKRFCCoCvDfqpYk3ZFnpbHKyQWUufdEngzzJx1YXDCK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZifAuVaU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728909066; x=1760445066;
  h=date:from:to:cc:subject:message-id;
  bh=e5C5BQiHTMW/YaNjZtka+iIo+3OMjNuJzdPSfBbYvcA=;
  b=ZifAuVaU+qqEB5FiZHiYSm6ow/apiv48gE/w9VYOX4kH8V1yvKFu4EZA
   4j8cFgui6C8TsRCb8IB9hUf0qej7SdjKIXeZx/JVp6G2qDx/J66iQdqZ+
   wJaVzpYr93VZ4tEEOoE3jYRtuVY9SlVx9nDn2bPmsQmBQ8v+EXZ/5fCDi
   ClcjBpdt8t42+EZUIm+yi5sVioewPIHcOVg0cPCNTfjtHC4b6d5DRyI4O
   ISmIIBtVtEEr3xudaR2kc09UA7eZVDPM4gvZI0xdPmqGRzkxoBkgQqBOq
   w3aeeHNDmN04h0W9WEmhOFdUwCcbCSbvICEPselydqszxvW2gNIMaBddS
   g==;
X-CSE-ConnectionGUID: +QwZdiwPQaCXNITEul97DQ==
X-CSE-MsgGUID: /p+u0bR4QoWYVZTGq5q4Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39375784"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39375784"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 05:31:05 -0700
X-CSE-ConnectionGUID: V+v9C/8pTXqgh57dtXSOJg==
X-CSE-MsgGUID: wjpAT4WJTCKjroAOi+oYBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82342945"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Oct 2024 05:31:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0KE0-000FHH-1P;
	Mon, 14 Oct 2024 12:31:00 +0000
Date: Mon, 14 Oct 2024 20:30:19 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 1d59d474e1cb7d4fdf87dfaf96f44647f13ea590
Message-ID: <202410142012.WQC747nU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 1d59d474e1cb7d4fdf87dfaf96f44647f13ea590  PCI: Hold rescan lock while adding devices during host probe

elapsed time: 2714m

configs tested: 126
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                            dove_defconfig    gcc-14.1.0
arm                            mmp2_defconfig    gcc-14.1.0
arm                        realview_defconfig    gcc-14.1.0
arm                         s5pv210_defconfig    gcc-14.1.0
arm                           stm32_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241014    clang-18
i386        buildonly-randconfig-002-20241014    clang-18
i386        buildonly-randconfig-003-20241014    clang-18
i386        buildonly-randconfig-004-20241014    clang-18
i386        buildonly-randconfig-005-20241014    clang-18
i386        buildonly-randconfig-006-20241014    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241014    clang-18
i386                  randconfig-002-20241014    clang-18
i386                  randconfig-003-20241014    clang-18
i386                  randconfig-004-20241014    clang-18
i386                  randconfig-005-20241014    clang-18
i386                  randconfig-006-20241014    clang-18
i386                  randconfig-011-20241014    clang-18
i386                  randconfig-012-20241014    clang-18
i386                  randconfig-013-20241014    clang-18
i386                  randconfig-014-20241014    clang-18
i386                  randconfig-015-20241014    clang-18
i386                  randconfig-016-20241014    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          atari_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    gcc-14.1.0
mips                           ip32_defconfig    gcc-14.1.0
mips                          malta_defconfig    gcc-14.1.0
mips                           xway_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      bamboo_defconfig    gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc                     rainier_defconfig    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc                     sequoia_defconfig    gcc-14.1.0
powerpc                     tqm8548_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             alldefconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                           se7206_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-14.1.0
sh                           se7780_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sh                        sh7763rdp_defconfig    gcc-14.1.0
sh                            shmin_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

