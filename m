Return-Path: <linux-pci+bounces-15647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7049B6AE2
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F50E1C22D0F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585292144CE;
	Wed, 30 Oct 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grr4O0yN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35182144C9
	for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308830; cv=none; b=czk3MrxeEBDj+Tw25cy9/UeeT4/5sSYxlhsvgfuDkOIzuJPCURZFcf4w4fPMZtOnZSUTf8+CTLb95Q01S2Y62Lk1s/U+qFEutDViertCRSZIpdTuXzkJYxIb+OUe8vNFGPYyktz0Yp+nZnO2vkg0fKglzWvlqocQAjc0gOce0pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308830; c=relaxed/simple;
	bh=c5uBBXmB786143VLrY0CIm+7nTN9k4oCNbJgqLrT7To=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RFcZvVlmlV8qnTUUKADLAZunYlDzP/Tw9NNbEauDrkfOJ9R0vhGaXfGcjEsg7Q3Hhz0gju4dVY6dEcItb/RnR2akcOYkmX3v2zZQlAKc4ae1zkMVwsxLX4yP9tJqpm4wfuakCZYgRUdGelyVLVK+CNKumUiwooderLEyOsw0044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grr4O0yN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730308827; x=1761844827;
  h=date:from:to:cc:subject:message-id;
  bh=c5uBBXmB786143VLrY0CIm+7nTN9k4oCNbJgqLrT7To=;
  b=grr4O0yNS9GdjAPW49gV6gfC2ehF7PeIXIzUVIZ5spAUQFcKEkwdDNvc
   0BgmXTg95HPEfwZZZ1yzJgm8W7Lxn7s52IgYByEhuJR5mUWs841oITzec
   AIYPxoXJpHOPWmECFHK/6Gp8d809gDfN+csu2f1O55ZIVl9qYopQX70h/
   w7mnBpLewbheHLfwAbbQDuB/qgzIWLO2RbQEuWIjl1s/ZCzKcWIoAaEGj
   xDmrz4bUlD07fUXmCdBW/19by50nXBxaqcuXEylBJ/82sJlQRMRfG/3If
   GERf4uLt1G2q+jlHvAQ76Cl4LAtEYq73tOmYkubXz5ABRrGBiaFjXA2Hv
   A==;
X-CSE-ConnectionGUID: +TrxcNrxQqKiBKtKCQKbtw==
X-CSE-MsgGUID: punb3H9DTxG+r8ckb/iDmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="33953019"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="33953019"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 10:20:26 -0700
X-CSE-ConnectionGUID: jQrgmj06QjCcOVWjTolfnw==
X-CSE-MsgGUID: HcW24VETQe2GXVJp7Ohzeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86927827"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Oct 2024 10:20:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6CMp-000f83-0B;
	Wed, 30 Oct 2024 17:20:23 +0000
Date: Thu, 31 Oct 2024 01:20:16 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:vpd] BUILD SUCCESS
 6ab1878a498b82561b811c5fdf68e3594788b4c7
Message-ID: <202410310103.Opti5UvH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git vpd
branch HEAD: 6ab1878a498b82561b811c5fdf68e3594788b4c7  PCI/sysfs: Make VPD readable by unprivileged users

elapsed time: 967m

configs tested: 208
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                         haps_hs_defconfig    clang-20
arc                     nsimosci_hs_defconfig    clang-20
arc                   randconfig-001-20241030    gcc-14.1.0
arc                   randconfig-002-20241030    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                     am200epdkit_defconfig    clang-20
arm                         axm55xx_defconfig    clang-20
arm                         bcm2835_defconfig    clang-20
arm                          collie_defconfig    clang-20
arm                     davinci_all_defconfig    clang-15
arm                                 defconfig    gcc-14.1.0
arm                      jornada720_defconfig    clang-20
arm                         lpc32xx_defconfig    clang-20
arm                   milbeaut_m10v_defconfig    clang-15
arm                             mxs_defconfig    clang-15
arm                       netwinder_defconfig    clang-20
arm                   randconfig-001-20241030    gcc-14.1.0
arm                   randconfig-002-20241030    gcc-14.1.0
arm                   randconfig-003-20241030    gcc-14.1.0
arm                   randconfig-004-20241030    gcc-14.1.0
arm                        realview_defconfig    clang-20
arm                             rpc_defconfig    clang-20
arm                         s3c6400_defconfig    clang-15
arm                       spear13xx_defconfig    clang-20
arm                           stm32_defconfig    clang-15
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241030    gcc-14.1.0
arm64                 randconfig-002-20241030    gcc-14.1.0
arm64                 randconfig-003-20241030    gcc-14.1.0
arm64                 randconfig-004-20241030    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241030    gcc-14.1.0
csky                  randconfig-002-20241030    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241030    gcc-14.1.0
hexagon               randconfig-002-20241030    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241030    gcc-12
i386        buildonly-randconfig-002-20241030    gcc-12
i386        buildonly-randconfig-003-20241030    gcc-12
i386        buildonly-randconfig-004-20241030    gcc-12
i386        buildonly-randconfig-005-20241030    gcc-12
i386        buildonly-randconfig-006-20241030    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241030    gcc-12
i386                  randconfig-002-20241030    gcc-12
i386                  randconfig-003-20241030    gcc-12
i386                  randconfig-004-20241030    gcc-12
i386                  randconfig-005-20241030    gcc-12
i386                  randconfig-006-20241030    gcc-12
i386                  randconfig-011-20241030    gcc-12
i386                  randconfig-012-20241030    gcc-12
i386                  randconfig-013-20241030    gcc-12
i386                  randconfig-014-20241030    gcc-12
i386                  randconfig-015-20241030    gcc-12
i386                  randconfig-016-20241030    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241030    gcc-14.1.0
loongarch             randconfig-002-20241030    gcc-14.1.0
m68k                             alldefconfig    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    clang-15
m68k                          amiga_defconfig    clang-20
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    clang-15
m68k                       m5475evb_defconfig    clang-20
m68k                        mvme16x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath25_defconfig    clang-15
mips                         db1xxx_defconfig    clang-20
mips                           ip30_defconfig    clang-20
mips                           ip32_defconfig    clang-15
mips                          rb532_defconfig    clang-20
mips                       rbtx49xx_defconfig    clang-15
mips                        vocore2_defconfig    clang-15
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241030    gcc-14.1.0
nios2                 randconfig-002-20241030    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241030    gcc-14.1.0
parisc                randconfig-002-20241030    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      arches_defconfig    clang-20
powerpc                   bluestone_defconfig    clang-20
powerpc                 canyonlands_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                     kmeter1_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    clang-15
powerpc                     mpc83xx_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-15
powerpc                     ppa8548_defconfig    clang-15
powerpc                     rainier_defconfig    clang-20
powerpc               randconfig-001-20241030    gcc-14.1.0
powerpc               randconfig-002-20241030    gcc-14.1.0
powerpc               randconfig-003-20241030    gcc-14.1.0
powerpc64             randconfig-001-20241030    gcc-14.1.0
powerpc64             randconfig-002-20241030    gcc-14.1.0
powerpc64             randconfig-003-20241030    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241030    gcc-14.1.0
riscv                 randconfig-002-20241030    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241030    gcc-14.1.0
s390                  randconfig-002-20241030    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          landisk_defconfig    clang-15
sh                            migor_defconfig    clang-20
sh                    randconfig-001-20241030    gcc-14.1.0
sh                    randconfig-002-20241030    gcc-14.1.0
sh                           se7343_defconfig    clang-20
sh                   secureedge5410_defconfig    clang-15
sh                           sh2007_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241030    gcc-14.1.0
sparc64               randconfig-002-20241030    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241030    gcc-14.1.0
um                    randconfig-002-20241030    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241030    gcc-12
x86_64      buildonly-randconfig-002-20241030    gcc-12
x86_64      buildonly-randconfig-003-20241030    gcc-12
x86_64      buildonly-randconfig-004-20241030    gcc-12
x86_64      buildonly-randconfig-005-20241030    gcc-12
x86_64      buildonly-randconfig-006-20241030    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241030    gcc-12
x86_64                randconfig-002-20241030    gcc-12
x86_64                randconfig-003-20241030    gcc-12
x86_64                randconfig-004-20241030    gcc-12
x86_64                randconfig-005-20241030    gcc-12
x86_64                randconfig-006-20241030    gcc-12
x86_64                randconfig-011-20241030    gcc-12
x86_64                randconfig-012-20241030    gcc-12
x86_64                randconfig-013-20241030    gcc-12
x86_64                randconfig-014-20241030    gcc-12
x86_64                randconfig-015-20241030    gcc-12
x86_64                randconfig-016-20241030    gcc-12
x86_64                randconfig-071-20241030    gcc-12
x86_64                randconfig-072-20241030    gcc-12
x86_64                randconfig-073-20241030    gcc-12
x86_64                randconfig-074-20241030    gcc-12
x86_64                randconfig-075-20241030    gcc-12
x86_64                randconfig-076-20241030    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    clang-15
xtensa                randconfig-001-20241030    gcc-14.1.0
xtensa                randconfig-002-20241030    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

