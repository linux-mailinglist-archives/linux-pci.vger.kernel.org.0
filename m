Return-Path: <linux-pci+bounces-15689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA019B76B1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 09:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78141F21C71
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1957B14901B;
	Thu, 31 Oct 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4eOjBdj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B39186E2E
	for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364310; cv=none; b=DCsz/R8GA+Bi905Ur5/hruO/oubSn6fTuoFULWsMcIJn/5Xv4CS5rF/AnP3U29tJrutZu/BMB48M/Kj8ppSICfh13W5Uf80A4dYqKkgR3dKfd729RTTsAe8OespH4DiYKI0hi3naWdE8MHuZIrF4kKUTyOsQ+agYOzVaeCbeoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364310; c=relaxed/simple;
	bh=QdqmJIhXrxsMHYXgOu4ULGeE4xuxekSkXexk6ITp6A0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SaeD7zTgDg46cTkpBpzAXVVwb0qEzk+uDfEViO2TRkK+e2Co3hneHn48QBHOb0XOK6ykPhb/FgvQmv63jFUnNP43hLOPaKpEr0u8yyoHrywaXN02AH4Cip02YEyLqViwJFLtIr+WrypBU4fBX900sWh0+3nz1LumbqMCafDkKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4eOjBdj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730364307; x=1761900307;
  h=date:from:to:cc:subject:message-id;
  bh=QdqmJIhXrxsMHYXgOu4ULGeE4xuxekSkXexk6ITp6A0=;
  b=c4eOjBdjv4LBd4yAE+gUy1eQNkGvSNL0xsfQzZEMFKYn8BejIFOx/2M/
   dBmKFDkAS7I72Vom9o+iGyjIDarPKaeuly+NRGs60J2hAIkZGUG/yetDq
   qGIGLy5mXnrMyasRhhgH1C0ZK7ED+szJA7JOOpKXp669gZWb6i1XPE/9s
   gTnyanJ/BKkYk8eo94reQbMtrcs6JTD1UnVyGy8nhaKmgLDRhHfKj7FAQ
   JQaXCnkk+OMlxGwDyBJ/zNDSkMjM84NSY2KLny6b25uVoKENoDp5ayvp8
   3lzv41UlPSFhFaLVxDIufXZH7LqCw8KgRSbh+79zNXy1GVYr2u3DBtVFD
   w==;
X-CSE-ConnectionGUID: 0Rz9sRTxSwSjbCrRtIm5Mw==
X-CSE-MsgGUID: bsIDjNAXQBq5jT5dyJL87Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55489213"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="55489213"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:45:06 -0700
X-CSE-ConnectionGUID: yd/O55PbRMmRqfRBIPB1iQ==
X-CSE-MsgGUID: ozfZngKKTDm/jYex1cjiQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113358399"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2024 01:45:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Qne-000fro-1U;
	Thu, 31 Oct 2024 08:45:02 +0000
Date: Thu, 31 Oct 2024 16:44:37 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:bwctrl] BUILD SUCCESS
 93b71d7a3f4f473c6973383c57740447f6320db1
Message-ID: <202410311623.rloOy8FY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
branch HEAD: 93b71d7a3f4f473c6973383c57740447f6320db1  selftests/pcie_bwctrl: Create selftests

elapsed time: 859m

configs tested: 170
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                            hsdk_defconfig    clang-20
arc                 nsimosci_hs_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         at91_dt_defconfig    clang-20
arm                        clps711x_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    clang-20
arm                        keystone_defconfig    clang-20
arm                         lpc18xx_defconfig    clang-20
arm                            mmp2_defconfig    gcc-14.1.0
arm                         mv78xx0_defconfig    clang-20
arm                        mvebu_v7_defconfig    gcc-14.1.0
arm                        neponset_defconfig    gcc-14.1.0
arm                       omap2plus_defconfig    clang-20
arm                             pxa_defconfig    clang-20
arm                            qcom_defconfig    clang-20
arm                         s3c6400_defconfig    gcc-14.1.0
arm                         socfpga_defconfig    gcc-14.1.0
arm                           tegra_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241031    clang-19
i386        buildonly-randconfig-002-20241031    clang-19
i386        buildonly-randconfig-003-20241031    clang-19
i386        buildonly-randconfig-004-20241031    clang-19
i386        buildonly-randconfig-005-20241031    clang-19
i386        buildonly-randconfig-006-20241031    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241031    clang-19
i386                  randconfig-002-20241031    clang-19
i386                  randconfig-003-20241031    clang-19
i386                  randconfig-004-20241031    clang-19
i386                  randconfig-005-20241031    clang-19
i386                  randconfig-006-20241031    clang-19
i386                  randconfig-011-20241031    clang-19
i386                  randconfig-012-20241031    clang-19
i386                  randconfig-013-20241031    clang-19
i386                  randconfig-014-20241031    clang-19
i386                  randconfig-015-20241031    clang-19
i386                  randconfig-016-20241031    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          amiga_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    gcc-14.1.0
mips                          eyeq5_defconfig    clang-20
mips                            gpr_defconfig    clang-20
mips                          rb532_defconfig    clang-20
mips                         rt305x_defconfig    clang-20
mips                         rt305x_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     asp8347_defconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    clang-20
powerpc                    gamecube_defconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    clang-20
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc                     tqm8540_defconfig    clang-20
powerpc                     tqm8560_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                        apsh4ad0a_defconfig    clang-20
sh                                  defconfig    gcc-12
sh                          rsk7203_defconfig    clang-20
sh                      rts7751r2d1_defconfig    clang-20
sh                           se7343_defconfig    clang-20
sh                           se7721_defconfig    clang-20
sh                   sh7724_generic_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241031    clang-19
x86_64      buildonly-randconfig-002-20241031    clang-19
x86_64      buildonly-randconfig-003-20241031    clang-19
x86_64      buildonly-randconfig-004-20241031    clang-19
x86_64      buildonly-randconfig-005-20241031    clang-19
x86_64      buildonly-randconfig-006-20241031    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241031    clang-19
x86_64                randconfig-002-20241031    clang-19
x86_64                randconfig-003-20241031    clang-19
x86_64                randconfig-004-20241031    clang-19
x86_64                randconfig-005-20241031    clang-19
x86_64                randconfig-006-20241031    clang-19
x86_64                randconfig-011-20241031    clang-19
x86_64                randconfig-012-20241031    clang-19
x86_64                randconfig-013-20241031    clang-19
x86_64                randconfig-014-20241031    clang-19
x86_64                randconfig-015-20241031    clang-19
x86_64                randconfig-016-20241031    clang-19
x86_64                randconfig-071-20241031    clang-19
x86_64                randconfig-072-20241031    clang-19
x86_64                randconfig-073-20241031    clang-19
x86_64                randconfig-074-20241031    clang-19
x86_64                randconfig-075-20241031    clang-19
x86_64                randconfig-076-20241031    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                    xip_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

