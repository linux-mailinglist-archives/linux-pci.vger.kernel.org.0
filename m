Return-Path: <linux-pci+bounces-27407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DDCAAF186
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 05:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84F24E0FBA
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 03:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2D14D29B;
	Thu,  8 May 2025 03:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBn12xtw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B454B1E5E
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 03:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674484; cv=none; b=XTXWQ1Lc9IfhkyzLb34rJ1/iBExfKQtRTWMKXqTcZK5aiFiC6EUUWMS2iwvG4VMkSje9gJFhZe3H4HpmQ40gx+VJR3woLwjrRIXlx3UW6gIG9q4MFLnq/M4JqlfOhItIkpXrXEowEP/gb774UcwOp8IBzUKmq6hGAOool8LWcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674484; c=relaxed/simple;
	bh=dhwkoZHA7yRt0sgJBCInmlpJDTapDw2TAJkH3WZ9oE8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qZSfTnDRT9iVg8PwzjfDVxwsYsjc51c6QH2xuDOY5K3U2w7PI+RjLhd+Q8adaMtjCOztdpyHQQKoljW9TOiHrQuBgHChMIy11wQAlxsPhbmFZ9wzJpYO45RT2vUVCmVs0Ta4/R+qgIAwh4MjJJ/fSjqIIc1PGs7KFon+Dj50/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBn12xtw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746674482; x=1778210482;
  h=date:from:to:cc:subject:message-id;
  bh=dhwkoZHA7yRt0sgJBCInmlpJDTapDw2TAJkH3WZ9oE8=;
  b=VBn12xtwq3vHAzydBMsmlnoguCVll1wjBhyzfqlB8ZOE0CrW8LU2rOZb
   bR8xWDpmga4o9AT3LSfzB/iaup44kqaoh5LAufFLntxF477rjG6bidJg8
   gY0YkqYsbylTu0SQAhw50e/+AggT7we0cZCe7PCNV6+vSG9HZ2fAddwJo
   pbSzZY2g3aRSUcjbdoZoElDr142Mm6gxxLEqH7n1lA63ssXRD//oBpaCz
   Rhgs0Q3zTB2HDM605BqKb12rgexUvqO2b5mNhmimcZT5aXuf6ASb1Ubif
   qpXD+WHwG8NhMz44Ju5QrVuko3t5l249VbM8lfpBzHDqqPfrxHa2f/7J+
   A==;
X-CSE-ConnectionGUID: Jj+JnZCfRAaiaTTCdoydfQ==
X-CSE-MsgGUID: Q2X8d+/vTDydTIW6FS9eeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="51093431"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="51093431"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 20:21:21 -0700
X-CSE-ConnectionGUID: 0nrP+H1hTXuSxFRZCd/iFQ==
X-CSE-MsgGUID: uK5xCrO5QT6xcWTl4V5/IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136173858"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2025 20:21:20 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCrp0-0009gy-0c;
	Thu, 08 May 2025 03:21:18 +0000
Date: Thu, 08 May 2025 11:21:00 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mobiveil] BUILD SUCCESS
 5e2664f9e108f66046869ed4990043421919465f
Message-ID: <202505081151.h2vA8jOx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mobiveil
branch HEAD: 5e2664f9e108f66046869ed4990043421919465f  PCI: ls-gen4: Use to_delayed_work()

elapsed time: 13628m

configs tested: 633
configs skipped: 27

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    clang-21
arc                   randconfig-001-20250429    gcc-13.3.0
arc                   randconfig-001-20250429    gcc-14.2.0
arc                   randconfig-001-20250501    clang-21
arc                   randconfig-001-20250502    gcc-8.5.0
arc                   randconfig-002-20250429    gcc-14.2.0
arc                   randconfig-002-20250501    clang-21
arc                   randconfig-002-20250502    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-21
arm                          collie_defconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                            hisi_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-21
arm                        keystone_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-16
arm                          moxart_defconfig    clang-21
arm                        multi_v5_defconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                           omap1_defconfig    gcc-14.2.0
arm                          pxa168_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    clang-21
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250429    gcc-14.2.0
arm                   randconfig-001-20250429    gcc-7.5.0
arm                   randconfig-001-20250501    clang-21
arm                   randconfig-001-20250502    gcc-8.5.0
arm                   randconfig-002-20250429    clang-20
arm                   randconfig-002-20250429    gcc-14.2.0
arm                   randconfig-002-20250501    clang-21
arm                   randconfig-002-20250502    gcc-8.5.0
arm                   randconfig-003-20250429    gcc-10.5.0
arm                   randconfig-003-20250429    gcc-14.2.0
arm                   randconfig-003-20250501    clang-21
arm                   randconfig-003-20250502    gcc-8.5.0
arm                   randconfig-004-20250429    clang-21
arm                   randconfig-004-20250429    gcc-14.2.0
arm                   randconfig-004-20250501    clang-21
arm                   randconfig-004-20250502    gcc-8.5.0
arm                         s5pv210_defconfig    clang-21
arm                        spear6xx_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    clang-21
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250429    gcc-14.2.0
arm64                 randconfig-001-20250429    gcc-7.5.0
arm64                 randconfig-001-20250501    clang-21
arm64                 randconfig-001-20250502    gcc-8.5.0
arm64                 randconfig-002-20250429    clang-21
arm64                 randconfig-002-20250429    gcc-14.2.0
arm64                 randconfig-002-20250501    clang-21
arm64                 randconfig-002-20250502    gcc-8.5.0
arm64                 randconfig-003-20250429    gcc-14.2.0
arm64                 randconfig-003-20250429    gcc-9.5.0
arm64                 randconfig-003-20250501    clang-21
arm64                 randconfig-003-20250502    gcc-8.5.0
arm64                 randconfig-004-20250429    gcc-14.2.0
arm64                 randconfig-004-20250429    gcc-9.5.0
arm64                 randconfig-004-20250501    clang-21
arm64                 randconfig-004-20250502    gcc-8.5.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250429    clang-21
csky                  randconfig-001-20250429    gcc-14.2.0
csky                  randconfig-001-20250501    gcc-7.5.0
csky                  randconfig-001-20250501    gcc-8.5.0
csky                  randconfig-001-20250502    gcc-8.5.0
csky                  randconfig-001-20250503    gcc-8.5.0
csky                  randconfig-002-20250429    clang-21
csky                  randconfig-002-20250429    gcc-14.2.0
csky                  randconfig-002-20250501    gcc-7.5.0
csky                  randconfig-002-20250501    gcc-8.5.0
csky                  randconfig-002-20250502    gcc-8.5.0
csky                  randconfig-002-20250503    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250429    clang-21
hexagon               randconfig-001-20250501    gcc-7.5.0
hexagon               randconfig-001-20250501    gcc-8.5.0
hexagon               randconfig-001-20250502    gcc-8.5.0
hexagon               randconfig-001-20250503    gcc-8.5.0
hexagon               randconfig-002-20250429    clang-21
hexagon               randconfig-002-20250501    gcc-7.5.0
hexagon               randconfig-002-20250501    gcc-8.5.0
hexagon               randconfig-002-20250502    gcc-8.5.0
hexagon               randconfig-002-20250503    gcc-8.5.0
i386                             alldefconfig    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250429    clang-20
i386        buildonly-randconfig-001-20250429    gcc-12
i386        buildonly-randconfig-001-20250501    clang-20
i386        buildonly-randconfig-001-20250502    clang-20
i386        buildonly-randconfig-001-20250503    clang-20
i386        buildonly-randconfig-001-20250506    gcc-12
i386        buildonly-randconfig-002-20250429    clang-20
i386        buildonly-randconfig-002-20250429    gcc-11
i386        buildonly-randconfig-002-20250501    clang-20
i386        buildonly-randconfig-002-20250502    clang-20
i386        buildonly-randconfig-002-20250503    clang-20
i386        buildonly-randconfig-002-20250506    gcc-12
i386        buildonly-randconfig-003-20250429    clang-20
i386        buildonly-randconfig-003-20250429    gcc-12
i386        buildonly-randconfig-003-20250501    clang-20
i386        buildonly-randconfig-003-20250502    clang-20
i386        buildonly-randconfig-003-20250503    clang-20
i386        buildonly-randconfig-003-20250506    gcc-12
i386        buildonly-randconfig-004-20250429    clang-20
i386        buildonly-randconfig-004-20250429    gcc-12
i386        buildonly-randconfig-004-20250501    clang-20
i386        buildonly-randconfig-004-20250502    clang-20
i386        buildonly-randconfig-004-20250503    clang-20
i386        buildonly-randconfig-004-20250506    gcc-12
i386        buildonly-randconfig-005-20250429    clang-20
i386        buildonly-randconfig-005-20250501    clang-20
i386        buildonly-randconfig-005-20250502    clang-20
i386        buildonly-randconfig-005-20250503    clang-20
i386        buildonly-randconfig-005-20250506    gcc-12
i386        buildonly-randconfig-006-20250429    clang-20
i386        buildonly-randconfig-006-20250429    gcc-12
i386        buildonly-randconfig-006-20250501    clang-20
i386        buildonly-randconfig-006-20250502    clang-20
i386        buildonly-randconfig-006-20250503    clang-20
i386        buildonly-randconfig-006-20250506    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250429    gcc-12
i386                  randconfig-001-20250501    gcc-12
i386                  randconfig-001-20250502    clang-20
i386                  randconfig-001-20250503    clang-20
i386                  randconfig-001-20250506    gcc-12
i386                  randconfig-002-20250429    gcc-12
i386                  randconfig-002-20250501    gcc-12
i386                  randconfig-002-20250502    clang-20
i386                  randconfig-002-20250503    clang-20
i386                  randconfig-002-20250506    gcc-12
i386                  randconfig-003-20250429    gcc-12
i386                  randconfig-003-20250501    gcc-12
i386                  randconfig-003-20250502    clang-20
i386                  randconfig-003-20250503    clang-20
i386                  randconfig-003-20250506    gcc-12
i386                  randconfig-004-20250429    gcc-12
i386                  randconfig-004-20250501    gcc-12
i386                  randconfig-004-20250502    clang-20
i386                  randconfig-004-20250503    clang-20
i386                  randconfig-004-20250506    gcc-12
i386                  randconfig-005-20250429    gcc-12
i386                  randconfig-005-20250501    gcc-12
i386                  randconfig-005-20250502    clang-20
i386                  randconfig-005-20250503    clang-20
i386                  randconfig-005-20250506    gcc-12
i386                  randconfig-006-20250429    gcc-12
i386                  randconfig-006-20250501    gcc-12
i386                  randconfig-006-20250502    clang-20
i386                  randconfig-006-20250503    clang-20
i386                  randconfig-006-20250506    gcc-12
i386                  randconfig-007-20250429    gcc-12
i386                  randconfig-007-20250501    gcc-12
i386                  randconfig-007-20250502    clang-20
i386                  randconfig-007-20250503    clang-20
i386                  randconfig-007-20250506    gcc-12
i386                  randconfig-011-20250429    clang-20
i386                  randconfig-011-20250501    clang-20
i386                  randconfig-011-20250502    gcc-12
i386                  randconfig-011-20250503    clang-20
i386                  randconfig-011-20250505    clang-20
i386                  randconfig-011-20250506    gcc-12
i386                  randconfig-012-20250429    clang-20
i386                  randconfig-012-20250501    clang-20
i386                  randconfig-012-20250502    gcc-12
i386                  randconfig-012-20250503    clang-20
i386                  randconfig-012-20250505    clang-20
i386                  randconfig-012-20250506    gcc-12
i386                  randconfig-013-20250429    clang-20
i386                  randconfig-013-20250501    clang-20
i386                  randconfig-013-20250502    gcc-12
i386                  randconfig-013-20250503    clang-20
i386                  randconfig-013-20250505    clang-20
i386                  randconfig-013-20250506    gcc-12
i386                  randconfig-014-20250429    clang-20
i386                  randconfig-014-20250501    clang-20
i386                  randconfig-014-20250502    gcc-12
i386                  randconfig-014-20250503    clang-20
i386                  randconfig-014-20250505    clang-20
i386                  randconfig-014-20250506    gcc-12
i386                  randconfig-015-20250429    clang-20
i386                  randconfig-015-20250501    clang-20
i386                  randconfig-015-20250502    gcc-12
i386                  randconfig-015-20250503    clang-20
i386                  randconfig-015-20250505    clang-20
i386                  randconfig-015-20250506    gcc-12
i386                  randconfig-016-20250429    clang-20
i386                  randconfig-016-20250501    clang-20
i386                  randconfig-016-20250502    gcc-12
i386                  randconfig-016-20250503    clang-20
i386                  randconfig-016-20250505    clang-20
i386                  randconfig-016-20250506    gcc-12
i386                  randconfig-017-20250429    clang-20
i386                  randconfig-017-20250501    clang-20
i386                  randconfig-017-20250502    gcc-12
i386                  randconfig-017-20250503    clang-20
i386                  randconfig-017-20250505    clang-20
i386                  randconfig-017-20250506    gcc-12
loongarch                        alldefconfig    clang-16
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250429    clang-21
loongarch             randconfig-001-20250429    gcc-14.2.0
loongarch             randconfig-001-20250501    gcc-7.5.0
loongarch             randconfig-001-20250501    gcc-8.5.0
loongarch             randconfig-001-20250502    gcc-8.5.0
loongarch             randconfig-001-20250503    gcc-8.5.0
loongarch             randconfig-002-20250429    clang-21
loongarch             randconfig-002-20250429    gcc-13.3.0
loongarch             randconfig-002-20250501    gcc-7.5.0
loongarch             randconfig-002-20250501    gcc-8.5.0
loongarch             randconfig-002-20250502    gcc-8.5.0
loongarch             randconfig-002-20250503    gcc-8.5.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-21
mips                  cavium_octeon_defconfig    clang-21
mips                          eyeq6_defconfig    clang-21
mips                           ip28_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
mips                        maltaup_defconfig    clang-16
mips                         rt305x_defconfig    clang-21
mips                         rt305x_defconfig    gcc-14.2.0
mips                        vocore2_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250429    clang-21
nios2                 randconfig-001-20250429    gcc-11.5.0
nios2                 randconfig-001-20250501    gcc-7.5.0
nios2                 randconfig-001-20250501    gcc-8.5.0
nios2                 randconfig-001-20250502    gcc-8.5.0
nios2                 randconfig-001-20250503    gcc-8.5.0
nios2                 randconfig-002-20250429    clang-21
nios2                 randconfig-002-20250429    gcc-7.5.0
nios2                 randconfig-002-20250501    gcc-7.5.0
nios2                 randconfig-002-20250501    gcc-8.5.0
nios2                 randconfig-002-20250502    gcc-8.5.0
nios2                 randconfig-002-20250503    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           alldefconfig    clang-21
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250429    clang-21
parisc                randconfig-001-20250429    gcc-14.2.0
parisc                randconfig-001-20250501    gcc-7.5.0
parisc                randconfig-001-20250501    gcc-8.5.0
parisc                randconfig-001-20250502    gcc-8.5.0
parisc                randconfig-001-20250503    gcc-8.5.0
parisc                randconfig-002-20250429    clang-21
parisc                randconfig-002-20250429    gcc-10.5.0
parisc                randconfig-002-20250501    gcc-7.5.0
parisc                randconfig-002-20250501    gcc-8.5.0
parisc                randconfig-002-20250502    gcc-8.5.0
parisc                randconfig-002-20250503    gcc-8.5.0
parisc64                         alldefconfig    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    clang-21
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                       ebony_defconfig    gcc-14.2.0
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    gcc-14.2.0
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-16
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    clang-16
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                 mpc836x_rdk_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-21
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc                  mpc885_ads_defconfig    clang-21
powerpc                      pasemi_defconfig    clang-21
powerpc                      pcm030_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250429    clang-21
powerpc               randconfig-001-20250501    gcc-7.5.0
powerpc               randconfig-001-20250501    gcc-8.5.0
powerpc               randconfig-001-20250502    gcc-8.5.0
powerpc               randconfig-001-20250503    gcc-8.5.0
powerpc               randconfig-002-20250429    clang-21
powerpc               randconfig-002-20250501    gcc-7.5.0
powerpc               randconfig-002-20250501    gcc-8.5.0
powerpc               randconfig-002-20250502    gcc-8.5.0
powerpc               randconfig-002-20250503    gcc-8.5.0
powerpc               randconfig-003-20250429    clang-21
powerpc               randconfig-003-20250501    gcc-7.5.0
powerpc               randconfig-003-20250501    gcc-8.5.0
powerpc               randconfig-003-20250502    gcc-8.5.0
powerpc               randconfig-003-20250503    gcc-8.5.0
powerpc                     sequoia_defconfig    gcc-14.2.0
powerpc                    socrates_defconfig    clang-21
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                     taishan_defconfig    clang-21
powerpc                     tqm8560_defconfig    clang-16
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250429    clang-21
powerpc64             randconfig-001-20250501    gcc-7.5.0
powerpc64             randconfig-001-20250501    gcc-8.5.0
powerpc64             randconfig-001-20250502    gcc-8.5.0
powerpc64             randconfig-001-20250503    gcc-8.5.0
powerpc64             randconfig-002-20250429    clang-21
powerpc64             randconfig-002-20250501    gcc-7.5.0
powerpc64             randconfig-002-20250501    gcc-8.5.0
powerpc64             randconfig-002-20250502    gcc-8.5.0
powerpc64             randconfig-002-20250503    gcc-8.5.0
powerpc64             randconfig-003-20250429    clang-21
powerpc64             randconfig-003-20250429    gcc-7.5.0
powerpc64             randconfig-003-20250501    gcc-7.5.0
powerpc64             randconfig-003-20250501    gcc-8.5.0
powerpc64             randconfig-003-20250502    gcc-8.5.0
powerpc64             randconfig-003-20250503    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250429    gcc-12
riscv                 randconfig-001-20250429    gcc-14.2.0
riscv                 randconfig-001-20250501    gcc-14.2.0
riscv                 randconfig-001-20250502    gcc-13.3.0
riscv                 randconfig-001-20250503    gcc-10.5.0
riscv                 randconfig-002-20250429    clang-18
riscv                 randconfig-002-20250429    gcc-12
riscv                 randconfig-002-20250501    gcc-14.2.0
riscv                 randconfig-002-20250502    gcc-13.3.0
riscv                 randconfig-002-20250503    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250429    clang-21
s390                  randconfig-001-20250429    gcc-12
s390                  randconfig-001-20250501    gcc-14.2.0
s390                  randconfig-001-20250502    gcc-13.3.0
s390                  randconfig-001-20250503    gcc-10.5.0
s390                  randconfig-002-20250429    clang-17
s390                  randconfig-002-20250429    gcc-12
s390                  randconfig-002-20250501    gcc-14.2.0
s390                  randconfig-002-20250502    gcc-13.3.0
s390                  randconfig-002-20250503    gcc-10.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    clang-21
sh                 kfr2r09-romimage_defconfig    clang-21
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250429    gcc-12
sh                    randconfig-001-20250429    gcc-5.5.0
sh                    randconfig-001-20250501    gcc-14.2.0
sh                    randconfig-001-20250502    gcc-13.3.0
sh                    randconfig-001-20250503    gcc-10.5.0
sh                    randconfig-002-20250429    gcc-12
sh                    randconfig-002-20250429    gcc-13.3.0
sh                    randconfig-002-20250501    gcc-14.2.0
sh                    randconfig-002-20250502    gcc-13.3.0
sh                    randconfig-002-20250503    gcc-10.5.0
sh                          rsk7201_defconfig    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                          rsk7269_defconfig    clang-21
sh                   rts7751r2dplus_defconfig    clang-16
sh                          sdk7780_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sh                           se7721_defconfig    clang-21
sh                           se7780_defconfig    clang-21
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20250429    gcc-12
sparc                 randconfig-001-20250429    gcc-12.4.0
sparc                 randconfig-001-20250501    gcc-14.2.0
sparc                 randconfig-001-20250502    gcc-13.3.0
sparc                 randconfig-001-20250503    gcc-10.5.0
sparc                 randconfig-002-20250429    gcc-10.3.0
sparc                 randconfig-002-20250429    gcc-12
sparc                 randconfig-002-20250501    gcc-14.2.0
sparc                 randconfig-002-20250502    gcc-13.3.0
sparc                 randconfig-002-20250503    gcc-10.5.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250429    gcc-12
sparc64               randconfig-001-20250429    gcc-12.4.0
sparc64               randconfig-001-20250501    gcc-14.2.0
sparc64               randconfig-001-20250502    gcc-13.3.0
sparc64               randconfig-001-20250503    gcc-10.5.0
sparc64               randconfig-002-20250429    gcc-12
sparc64               randconfig-002-20250429    gcc-8.5.0
sparc64               randconfig-002-20250501    gcc-14.2.0
sparc64               randconfig-002-20250502    gcc-13.3.0
sparc64               randconfig-002-20250503    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250429    clang-18
um                    randconfig-001-20250429    gcc-12
um                    randconfig-001-20250501    gcc-14.2.0
um                    randconfig-001-20250502    gcc-13.3.0
um                    randconfig-001-20250503    gcc-10.5.0
um                    randconfig-002-20250429    gcc-12
um                    randconfig-002-20250501    gcc-14.2.0
um                    randconfig-002-20250502    gcc-13.3.0
um                    randconfig-002-20250503    gcc-10.5.0
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250429    clang-20
x86_64      buildonly-randconfig-001-20250429    gcc-12
x86_64      buildonly-randconfig-001-20250501    gcc-12
x86_64      buildonly-randconfig-001-20250502    clang-20
x86_64      buildonly-randconfig-001-20250503    gcc-12
x86_64      buildonly-randconfig-002-20250429    clang-20
x86_64      buildonly-randconfig-002-20250429    gcc-12
x86_64      buildonly-randconfig-002-20250501    gcc-12
x86_64      buildonly-randconfig-002-20250502    clang-20
x86_64      buildonly-randconfig-002-20250503    gcc-12
x86_64      buildonly-randconfig-003-20250429    clang-20
x86_64      buildonly-randconfig-003-20250501    gcc-12
x86_64      buildonly-randconfig-003-20250502    clang-20
x86_64      buildonly-randconfig-003-20250503    gcc-12
x86_64      buildonly-randconfig-004-20250429    clang-20
x86_64      buildonly-randconfig-004-20250429    gcc-12
x86_64      buildonly-randconfig-004-20250501    gcc-12
x86_64      buildonly-randconfig-004-20250502    clang-20
x86_64      buildonly-randconfig-004-20250503    gcc-12
x86_64      buildonly-randconfig-005-20250429    clang-20
x86_64      buildonly-randconfig-005-20250501    gcc-12
x86_64      buildonly-randconfig-005-20250502    clang-20
x86_64      buildonly-randconfig-005-20250503    gcc-12
x86_64      buildonly-randconfig-006-20250429    clang-20
x86_64      buildonly-randconfig-006-20250429    gcc-12
x86_64      buildonly-randconfig-006-20250501    gcc-12
x86_64      buildonly-randconfig-006-20250502    clang-20
x86_64      buildonly-randconfig-006-20250503    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250429    clang-20
x86_64                randconfig-001-20250501    clang-20
x86_64                randconfig-001-20250502    clang-20
x86_64                randconfig-001-20250503    clang-20
x86_64                randconfig-001-20250506    clang-20
x86_64                randconfig-002-20250429    clang-20
x86_64                randconfig-002-20250501    clang-20
x86_64                randconfig-002-20250502    clang-20
x86_64                randconfig-002-20250503    clang-20
x86_64                randconfig-002-20250506    clang-20
x86_64                randconfig-003-20250429    clang-20
x86_64                randconfig-003-20250501    clang-20
x86_64                randconfig-003-20250502    clang-20
x86_64                randconfig-003-20250503    clang-20
x86_64                randconfig-003-20250506    clang-20
x86_64                randconfig-004-20250429    clang-20
x86_64                randconfig-004-20250501    clang-20
x86_64                randconfig-004-20250502    clang-20
x86_64                randconfig-004-20250503    clang-20
x86_64                randconfig-004-20250506    clang-20
x86_64                randconfig-005-20250429    clang-20
x86_64                randconfig-005-20250501    clang-20
x86_64                randconfig-005-20250502    clang-20
x86_64                randconfig-005-20250503    clang-20
x86_64                randconfig-005-20250506    clang-20
x86_64                randconfig-006-20250429    clang-20
x86_64                randconfig-006-20250501    clang-20
x86_64                randconfig-006-20250502    clang-20
x86_64                randconfig-006-20250503    clang-20
x86_64                randconfig-006-20250506    clang-20
x86_64                randconfig-007-20250429    clang-20
x86_64                randconfig-007-20250501    clang-20
x86_64                randconfig-007-20250502    clang-20
x86_64                randconfig-007-20250503    clang-20
x86_64                randconfig-007-20250506    clang-20
x86_64                randconfig-008-20250429    clang-20
x86_64                randconfig-008-20250501    clang-20
x86_64                randconfig-008-20250502    clang-20
x86_64                randconfig-008-20250503    clang-20
x86_64                randconfig-008-20250506    clang-20
x86_64                randconfig-071-20250429    gcc-12
x86_64                randconfig-071-20250501    gcc-12
x86_64                randconfig-071-20250502    clang-20
x86_64                randconfig-071-20250503    clang-20
x86_64                randconfig-071-20250506    clang-20
x86_64                randconfig-072-20250429    gcc-12
x86_64                randconfig-072-20250501    gcc-12
x86_64                randconfig-072-20250502    clang-20
x86_64                randconfig-072-20250503    clang-20
x86_64                randconfig-072-20250506    clang-20
x86_64                randconfig-073-20250429    gcc-12
x86_64                randconfig-073-20250501    gcc-12
x86_64                randconfig-073-20250502    clang-20
x86_64                randconfig-073-20250503    clang-20
x86_64                randconfig-073-20250506    clang-20
x86_64                randconfig-074-20250429    gcc-12
x86_64                randconfig-074-20250501    gcc-12
x86_64                randconfig-074-20250502    clang-20
x86_64                randconfig-074-20250503    clang-20
x86_64                randconfig-074-20250506    clang-20
x86_64                randconfig-075-20250429    gcc-12
x86_64                randconfig-075-20250501    gcc-12
x86_64                randconfig-075-20250502    clang-20
x86_64                randconfig-075-20250503    clang-20
x86_64                randconfig-075-20250506    clang-20
x86_64                randconfig-076-20250429    gcc-12
x86_64                randconfig-076-20250501    gcc-12
x86_64                randconfig-076-20250502    clang-20
x86_64                randconfig-076-20250503    clang-20
x86_64                randconfig-076-20250506    clang-20
x86_64                randconfig-077-20250429    gcc-12
x86_64                randconfig-077-20250501    gcc-12
x86_64                randconfig-077-20250502    clang-20
x86_64                randconfig-077-20250503    clang-20
x86_64                randconfig-077-20250506    clang-20
x86_64                randconfig-078-20250429    gcc-12
x86_64                randconfig-078-20250501    gcc-12
x86_64                randconfig-078-20250502    clang-20
x86_64                randconfig-078-20250503    clang-20
x86_64                randconfig-078-20250506    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                          rhel-9.4-func    clang-20
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250429    gcc-12
xtensa                randconfig-001-20250429    gcc-14.2.0
xtensa                randconfig-001-20250501    gcc-14.2.0
xtensa                randconfig-001-20250502    gcc-13.3.0
xtensa                randconfig-001-20250503    gcc-10.5.0
xtensa                randconfig-002-20250429    gcc-12
xtensa                randconfig-002-20250429    gcc-8.5.0
xtensa                randconfig-002-20250501    gcc-14.2.0
xtensa                randconfig-002-20250502    gcc-13.3.0
xtensa                randconfig-002-20250503    gcc-10.5.0
xtensa                         virt_defconfig    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

