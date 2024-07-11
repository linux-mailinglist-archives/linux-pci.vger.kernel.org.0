Return-Path: <linux-pci+bounces-10141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FAD92E059
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 08:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1004B1C21E9E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 06:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85C812EBC7;
	Thu, 11 Jul 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFhrtiL6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0612E1CD
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680913; cv=none; b=jR4HQeDhqzhnGwX+vuaM7HrzUkSkdY6JV+nTTxBsGujcvhLEYddILbCqN79S0YpnF20P8dYy7d/OBBel+uOs2LVEszJpWKZp4/4bntPGPJSxJawghUltD/p/3YpH8aokSO9khqZqG8tdLEVh6lPqIODtqWLps0Gxtan/+ElvJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680913; c=relaxed/simple;
	bh=LbsMunIbAzJSdnJr8QA7pMLVnNXZgAxZuljaF851wiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZKJFaEBM0W73vUdt07umkPBi3rGQ7XiYqUWMpvyGeSa7cHuAowReo/pgRd4noUgSmL050JKlOLXf37OjgSSt9hDW+TB7ZhlB7E9Rdx3KiaG+9HCOPSOWWPU69GSx3w3/Xs4Eew084xGpwRoXrhU0dMEzcGBNmYRmtEUmsAgwx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFhrtiL6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720680913; x=1752216913;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LbsMunIbAzJSdnJr8QA7pMLVnNXZgAxZuljaF851wiI=;
  b=HFhrtiL6PNQOU+SpGxLCBWcqn+iz+qzphMWgd/PYdihcPkIHgoUbtmFB
   jO6G4o5TPtBMrPskDNa6RAH+06AEYrITB+42DlMqz/6TSGDiAZyDv81PP
   +foIoUjNvf8b+0j+XYl3fn0mPxZrb6Bnj4+i9Whq0KxYyo2SVrXhIR3fe
   g71Cuyx9UtrkFlKFZ3zy1kHfsjcUoKovv0pgaIeeG6JI+wFEUnWTGUV0q
   5Gl2VhdY5b/qorNN8isLzo7JQWlKDbfTo4/wAhTJTHcUKz+OWbSrLjk/E
   GM0IKWrIo8kQ+v22DTX1nzP4hTwOBETuOQZDcWlPLvG5bdDHJ/wwV4LYu
   g==;
X-CSE-ConnectionGUID: dynlG694T2G9rrFArvQ7vA==
X-CSE-MsgGUID: bAAuF11vQuKn6VFPMGMTPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18177022"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="18177022"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 23:55:12 -0700
X-CSE-ConnectionGUID: yTwen8fhSd6OqhtTMd6eFw==
X-CSE-MsgGUID: OpHdWViIRuK3sC6eE218jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48457228"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Jul 2024 23:55:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRnhs-000Yuk-0g;
	Thu, 11 Jul 2024 06:55:08 +0000
Date: Thu, 11 Jul 2024 14:54:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 044b45be04cb16125a0eccba532e88dc529f64de
Message-ID: <202407111446.SHmg1zyF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 044b45be04cb16125a0eccba532e88dc529f64de  PCI: qcom: Prevent use of uninitialized data in qcom_pcie_suspend_noirq()

elapsed time: 1461m

configs tested: 314
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240710   gcc-13.2.0
arc                   randconfig-001-20240711   gcc-13.2.0
arc                   randconfig-002-20240710   gcc-13.2.0
arc                   randconfig-002-20240711   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.3.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.3.0
arm                       aspeed_g4_defconfig   gcc-13.2.0
arm                        clps711x_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                   milbeaut_m10v_defconfig   gcc-13.2.0
arm                            mmp2_defconfig   clang-19
arm                          moxart_defconfig   gcc-13.3.0
arm                            mps2_defconfig   clang-19
arm                        multi_v5_defconfig   clang-19
arm                       omap2plus_defconfig   clang-19
arm                            qcom_defconfig   clang-19
arm                   randconfig-001-20240710   gcc-13.2.0
arm                   randconfig-001-20240711   gcc-13.2.0
arm                   randconfig-002-20240710   gcc-13.2.0
arm                   randconfig-002-20240711   gcc-13.2.0
arm                   randconfig-003-20240710   gcc-13.2.0
arm                   randconfig-003-20240711   gcc-13.2.0
arm                   randconfig-004-20240710   gcc-13.2.0
arm                   randconfig-004-20240711   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-13.3.0
arm                          sp7021_defconfig   clang-19
arm                        spear3xx_defconfig   gcc-13.3.0
arm                           u8500_defconfig   gcc-13.3.0
arm                       versatile_defconfig   clang-19
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   clang-19
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240710   gcc-13.2.0
arm64                 randconfig-001-20240711   gcc-13.2.0
arm64                 randconfig-002-20240710   gcc-13.2.0
arm64                 randconfig-002-20240711   gcc-13.2.0
arm64                 randconfig-003-20240710   gcc-13.2.0
arm64                 randconfig-003-20240711   gcc-13.2.0
arm64                 randconfig-004-20240710   gcc-13.2.0
arm64                 randconfig-004-20240711   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240710   gcc-13.2.0
csky                  randconfig-001-20240711   gcc-13.2.0
csky                  randconfig-002-20240710   gcc-13.2.0
csky                  randconfig-002-20240711   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240710   clang-18
i386         buildonly-randconfig-001-20240711   gcc-13
i386         buildonly-randconfig-002-20240710   clang-18
i386         buildonly-randconfig-002-20240710   gcc-13
i386         buildonly-randconfig-002-20240711   gcc-13
i386         buildonly-randconfig-003-20240710   clang-18
i386         buildonly-randconfig-003-20240710   gcc-11
i386         buildonly-randconfig-003-20240711   gcc-13
i386         buildonly-randconfig-004-20240710   clang-18
i386         buildonly-randconfig-004-20240710   gcc-11
i386         buildonly-randconfig-004-20240711   gcc-13
i386         buildonly-randconfig-005-20240710   clang-18
i386         buildonly-randconfig-005-20240711   gcc-13
i386         buildonly-randconfig-006-20240710   clang-18
i386         buildonly-randconfig-006-20240711   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240710   clang-18
i386                  randconfig-001-20240711   gcc-13
i386                  randconfig-002-20240710   clang-18
i386                  randconfig-002-20240710   gcc-11
i386                  randconfig-002-20240711   gcc-13
i386                  randconfig-003-20240710   clang-18
i386                  randconfig-003-20240710   gcc-13
i386                  randconfig-003-20240711   gcc-13
i386                  randconfig-004-20240710   clang-18
i386                  randconfig-004-20240711   gcc-13
i386                  randconfig-005-20240710   clang-18
i386                  randconfig-005-20240711   gcc-13
i386                  randconfig-006-20240710   clang-18
i386                  randconfig-006-20240711   gcc-13
i386                  randconfig-011-20240710   clang-18
i386                  randconfig-011-20240710   gcc-13
i386                  randconfig-011-20240711   gcc-13
i386                  randconfig-012-20240710   clang-18
i386                  randconfig-012-20240710   gcc-12
i386                  randconfig-012-20240711   gcc-13
i386                  randconfig-013-20240710   clang-18
i386                  randconfig-013-20240710   gcc-12
i386                  randconfig-013-20240711   gcc-13
i386                  randconfig-014-20240710   clang-18
i386                  randconfig-014-20240710   gcc-13
i386                  randconfig-014-20240711   gcc-13
i386                  randconfig-015-20240710   clang-18
i386                  randconfig-015-20240710   gcc-8
i386                  randconfig-015-20240711   gcc-13
i386                  randconfig-016-20240710   clang-18
i386                  randconfig-016-20240711   gcc-13
loongarch                        allmodconfig   gcc-13.3.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch                 loongson3_defconfig   gcc-13.3.0
loongarch             randconfig-001-20240710   gcc-13.2.0
loongarch             randconfig-001-20240711   gcc-13.2.0
loongarch             randconfig-002-20240710   gcc-13.2.0
loongarch             randconfig-002-20240711   gcc-13.2.0
m68k                             allmodconfig   gcc-13.3.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.3.0
m68k                       bvme6000_defconfig   gcc-13.3.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.3.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.3.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                        bcm63xx_defconfig   gcc-13.3.0
mips                     cu1000-neo_defconfig   gcc-13.3.0
mips                         db1xxx_defconfig   clang-19
mips                  decstation_64_defconfig   gcc-13.3.0
mips                          eyeq5_defconfig   clang-19
mips                      malta_kvm_defconfig   clang-19
mips                malta_qemu_32r6_defconfig   gcc-13.3.0
mips                        qi_lb60_defconfig   clang-19
nios2                            allmodconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.3.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240710   gcc-13.2.0
nios2                 randconfig-001-20240711   gcc-13.2.0
nios2                 randconfig-002-20240710   gcc-13.2.0
nios2                 randconfig-002-20240711   gcc-13.2.0
openrisc                         allmodconfig   gcc-13.3.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.3.0
openrisc                         allyesconfig   gcc-13.3.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.3.0
parisc                           allyesconfig   gcc-13.3.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240710   gcc-13.2.0
parisc                randconfig-001-20240711   gcc-13.2.0
parisc                randconfig-002-20240710   gcc-13.2.0
parisc                randconfig-002-20240711   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   clang-19
powerpc                          allmodconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.3.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.3.0
powerpc                     asp8347_defconfig   clang-19
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                      chrp32_defconfig   gcc-13.3.0
powerpc                       ebony_defconfig   clang-19
powerpc                       maple_defconfig   clang-19
powerpc                   microwatt_defconfig   clang-19
powerpc                     mpc5200_defconfig   gcc-13.3.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                     powernv_defconfig   gcc-13.3.0
powerpc                         ps3_defconfig   clang-19
powerpc               randconfig-001-20240710   gcc-13.2.0
powerpc               randconfig-001-20240711   gcc-13.2.0
powerpc               randconfig-002-20240710   gcc-13.2.0
powerpc               randconfig-002-20240711   gcc-13.2.0
powerpc               randconfig-003-20240710   gcc-13.2.0
powerpc               randconfig-003-20240711   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   clang-19
powerpc                         wii_defconfig   clang-19
powerpc64             randconfig-001-20240710   gcc-13.2.0
powerpc64             randconfig-001-20240711   gcc-13.2.0
powerpc64             randconfig-002-20240710   gcc-13.2.0
powerpc64             randconfig-002-20240711   gcc-13.2.0
powerpc64             randconfig-003-20240710   gcc-13.2.0
powerpc64             randconfig-003-20240711   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.3.0
riscv                             allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.3.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.3.0
riscv                               defconfig   gcc-13.2.0
riscv             nommu_k210_sdcard_defconfig   gcc-13.2.0
riscv                 randconfig-001-20240710   gcc-13.2.0
riscv                 randconfig-001-20240711   gcc-13.2.0
riscv                 randconfig-002-20240710   gcc-13.2.0
riscv                 randconfig-002-20240711   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240710   gcc-13.2.0
s390                  randconfig-001-20240711   gcc-13.2.0
s390                  randconfig-002-20240710   gcc-13.2.0
s390                  randconfig-002-20240711   gcc-13.2.0
sh                               allmodconfig   gcc-13.3.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.3.0
sh                                  defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.3.0
sh                    randconfig-001-20240710   gcc-13.2.0
sh                    randconfig-001-20240711   gcc-13.2.0
sh                    randconfig-002-20240710   gcc-13.2.0
sh                    randconfig-002-20240711   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.3.0
sh                           se7705_defconfig   gcc-13.3.0
sh                           se7751_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.3.0
sparc                            allyesconfig   gcc-13.3.0
sparc                       sparc64_defconfig   gcc-13.3.0
sparc64                          allmodconfig   gcc-13.3.0
sparc64                          allyesconfig   gcc-13.3.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240710   gcc-13.2.0
sparc64               randconfig-001-20240711   gcc-13.2.0
sparc64               randconfig-002-20240710   gcc-13.2.0
sparc64               randconfig-002-20240711   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240710   gcc-13.2.0
um                    randconfig-001-20240711   gcc-13.2.0
um                    randconfig-002-20240710   gcc-13.2.0
um                    randconfig-002-20240711   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240710   clang-18
x86_64       buildonly-randconfig-001-20240711   clang-18
x86_64       buildonly-randconfig-002-20240710   clang-18
x86_64       buildonly-randconfig-002-20240711   clang-18
x86_64       buildonly-randconfig-003-20240710   clang-18
x86_64       buildonly-randconfig-003-20240711   clang-18
x86_64       buildonly-randconfig-004-20240710   clang-18
x86_64       buildonly-randconfig-004-20240711   clang-18
x86_64       buildonly-randconfig-005-20240710   clang-18
x86_64       buildonly-randconfig-005-20240711   clang-18
x86_64       buildonly-randconfig-006-20240710   clang-18
x86_64       buildonly-randconfig-006-20240711   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240710   clang-18
x86_64                randconfig-001-20240711   clang-18
x86_64                randconfig-002-20240710   clang-18
x86_64                randconfig-002-20240711   clang-18
x86_64                randconfig-003-20240710   clang-18
x86_64                randconfig-003-20240711   clang-18
x86_64                randconfig-004-20240710   clang-18
x86_64                randconfig-004-20240711   clang-18
x86_64                randconfig-005-20240710   clang-18
x86_64                randconfig-005-20240711   clang-18
x86_64                randconfig-006-20240710   clang-18
x86_64                randconfig-006-20240711   clang-18
x86_64                randconfig-011-20240710   clang-18
x86_64                randconfig-011-20240711   clang-18
x86_64                randconfig-012-20240710   clang-18
x86_64                randconfig-012-20240711   clang-18
x86_64                randconfig-013-20240710   clang-18
x86_64                randconfig-013-20240711   clang-18
x86_64                randconfig-014-20240710   clang-18
x86_64                randconfig-014-20240711   clang-18
x86_64                randconfig-015-20240710   clang-18
x86_64                randconfig-015-20240711   clang-18
x86_64                randconfig-016-20240710   clang-18
x86_64                randconfig-016-20240711   clang-18
x86_64                randconfig-071-20240710   clang-18
x86_64                randconfig-071-20240711   clang-18
x86_64                randconfig-072-20240710   clang-18
x86_64                randconfig-072-20240711   clang-18
x86_64                randconfig-073-20240710   clang-18
x86_64                randconfig-073-20240711   clang-18
x86_64                randconfig-074-20240710   clang-18
x86_64                randconfig-074-20240711   clang-18
x86_64                randconfig-075-20240710   clang-18
x86_64                randconfig-075-20240711   clang-18
x86_64                randconfig-076-20240710   clang-18
x86_64                randconfig-076-20240711   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                           allyesconfig   gcc-13.3.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240710   gcc-13.2.0
xtensa                randconfig-001-20240711   gcc-13.2.0
xtensa                randconfig-002-20240710   gcc-13.2.0
xtensa                randconfig-002-20240711   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

