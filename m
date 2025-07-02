Return-Path: <linux-pci+bounces-31223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9ACAF0CA7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9F189D64A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEBC227B8C;
	Wed,  2 Jul 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/BiwgBg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A21D514E
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441654; cv=none; b=KKYflBpvu3EgVCUw07M7tttUFpN5By6Oc/MsiFD9m67K5xdjNTocNKwL/9Z4A+d7k4ANEudFtOnT+JP6nHDjkvwZEqonVmpZbEGaNzBUO5kGHQ1Fvr5jqB1GVHdDHfWB7OMBFPJbqHLbg4Ybk4CgMGV5KN0lAN62bVVTIrSGzk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441654; c=relaxed/simple;
	bh=9e81/Nwl6UIKgd3vyrNx0jYTFZbJ82y6MouqUYk872w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pkeQJ3tIW0d25GqwuaNTy54/go0qGtZ8dR46GZCP0eZo5WTNtpuW0w7h/XYlqE/rJLxwvRvp20fNZiLVFDAzHS0u++RVdUN2t2U8saJwmYF3mzjNj3Ge0yk6pOn/QlxIQJQPcg/xHHuHfEhAmIQLK2zk9iKZvjpXzW+N0VUeDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/BiwgBg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751441653; x=1782977653;
  h=date:from:to:cc:subject:message-id;
  bh=9e81/Nwl6UIKgd3vyrNx0jYTFZbJ82y6MouqUYk872w=;
  b=A/BiwgBgFrn3CGSnugTmlVc1ZePLYBnRja2/LZllBjMcvMwS6im5HRrm
   G78PwbcCEeFFxahPMIryrhwzHDtXlM/IssQWftnX1Po8ZYi74RJUMYoP1
   V6Cs2pdv90LTzi1ooQE4s8fHZ9q7VY3mDYTX5KJSe5WXVlBvDwZA5zmzs
   NAKCC/++CvbuMxZ1UaFcqNAebOHmnZLlTEvDPQE9HjMRiEmiRlTVFfpLF
   Pmij/UDQ33FCKT1lz9W++DJJia/73v4b8WLXaYYOqL81NzZMjYyGIWFRr
   Cg5vXTZ4/wx3VceAFhNmgNodDU6JzJaRkRo2JYGwcN220EpPxRBj3dlH6
   g==;
X-CSE-ConnectionGUID: fYpQJbljTwyrY1tLevjDOA==
X-CSE-MsgGUID: 4AgnsVx/RR2CbS70TJRogQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71291939"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="71291939"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 00:34:12 -0700
X-CSE-ConnectionGUID: TSL6cRRCQ+uO6bCCTfsV4Q==
X-CSE-MsgGUID: HzoozlGVSl2S9N13EHVsrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="191175304"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Jul 2025 00:34:10 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWryq-0000KN-1l;
	Wed, 02 Jul 2025 07:34:08 +0000
Date: Wed, 02 Jul 2025 15:33:41 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/imx6] BUILD SUCCESS
 66ee525537be816b2accf4ad28ad33cd299ea492
Message-ID: <202507021528.wvOgaJy7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/imx6
branch HEAD: 66ee525537be816b2accf4ad28ad33cd299ea492  PCI: imx6: Fix the epc_features of i.MX8M PCIe controllers

elapsed time: 986m

configs tested: 203
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250702    clang-19
arc                   randconfig-001-20250702    gcc-10.5.0
arc                   randconfig-002-20250702    clang-19
arc                   randconfig-002-20250702    gcc-14.3.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                          gemini_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250702    clang-17
arm                   randconfig-001-20250702    clang-19
arm                   randconfig-002-20250702    clang-19
arm                   randconfig-003-20250702    clang-19
arm                   randconfig-003-20250702    clang-21
arm                   randconfig-004-20250702    clang-17
arm                   randconfig-004-20250702    clang-19
arm                           u8500_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250702    clang-19
arm64                 randconfig-001-20250702    clang-21
arm64                 randconfig-002-20250702    clang-19
arm64                 randconfig-002-20250702    clang-21
arm64                 randconfig-003-20250702    clang-19
arm64                 randconfig-003-20250702    clang-21
arm64                 randconfig-004-20250702    clang-19
arm64                 randconfig-004-20250702    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250702    gcc-15.1.0
csky                  randconfig-002-20250702    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250702    clang-21
hexagon               randconfig-002-20250702    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250702    clang-20
i386        buildonly-randconfig-002-20250702    gcc-12
i386        buildonly-randconfig-003-20250702    clang-20
i386        buildonly-randconfig-004-20250702    clang-20
i386        buildonly-randconfig-005-20250702    gcc-12
i386        buildonly-randconfig-006-20250702    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250702    clang-20
i386                  randconfig-002-20250702    clang-20
i386                  randconfig-003-20250702    clang-20
i386                  randconfig-004-20250702    clang-20
i386                  randconfig-005-20250702    clang-20
i386                  randconfig-006-20250702    clang-20
i386                  randconfig-007-20250702    clang-20
i386                  randconfig-011-20250702    gcc-12
i386                  randconfig-012-20250702    gcc-12
i386                  randconfig-013-20250702    gcc-12
i386                  randconfig-014-20250702    gcc-12
i386                  randconfig-015-20250702    gcc-12
i386                  randconfig-016-20250702    gcc-12
i386                  randconfig-017-20250702    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250702    gcc-15.1.0
loongarch             randconfig-002-20250702    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250702    gcc-14.2.0
nios2                 randconfig-002-20250702    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250702    gcc-12.4.0
parisc                randconfig-002-20250702    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250702    gcc-11.5.0
powerpc               randconfig-002-20250702    gcc-11.5.0
powerpc               randconfig-003-20250702    clang-21
powerpc64             randconfig-001-20250702    clang-21
powerpc64             randconfig-002-20250702    clang-19
powerpc64             randconfig-003-20250702    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250702    clang-21
riscv                 randconfig-002-20250702    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250702    clang-21
s390                  randconfig-001-20250702    gcc-10.5.0
s390                  randconfig-002-20250702    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250702    clang-21
sh                    randconfig-001-20250702    gcc-15.1.0
sh                    randconfig-002-20250702    clang-21
sh                    randconfig-002-20250702    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250702    clang-21
sparc                 randconfig-001-20250702    gcc-12.4.0
sparc                 randconfig-002-20250702    clang-21
sparc                 randconfig-002-20250702    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250702    clang-21
sparc64               randconfig-001-20250702    gcc-9.3.0
sparc64               randconfig-002-20250702    clang-21
sparc64               randconfig-002-20250702    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250702    clang-21
um                    randconfig-002-20250702    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250702    gcc-11
x86_64      buildonly-randconfig-001-20250702    gcc-12
x86_64      buildonly-randconfig-002-20250702    gcc-11
x86_64      buildonly-randconfig-003-20250702    clang-20
x86_64      buildonly-randconfig-003-20250702    gcc-11
x86_64      buildonly-randconfig-004-20250702    clang-20
x86_64      buildonly-randconfig-004-20250702    gcc-11
x86_64      buildonly-randconfig-005-20250702    clang-20
x86_64      buildonly-randconfig-005-20250702    gcc-11
x86_64      buildonly-randconfig-006-20250702    gcc-11
x86_64      buildonly-randconfig-006-20250702    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-004-20250702    gcc-12
x86_64                randconfig-005-20250702    gcc-12
x86_64                randconfig-006-20250702    gcc-12
x86_64                randconfig-007-20250702    gcc-12
x86_64                randconfig-008-20250702    gcc-12
x86_64                randconfig-071-20250702    clang-20
x86_64                randconfig-072-20250702    clang-20
x86_64                randconfig-073-20250702    clang-20
x86_64                randconfig-074-20250702    clang-20
x86_64                randconfig-075-20250702    clang-20
x86_64                randconfig-076-20250702    clang-20
x86_64                randconfig-077-20250702    clang-20
x86_64                randconfig-078-20250702    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250702    clang-21
xtensa                randconfig-001-20250702    gcc-14.3.0
xtensa                randconfig-002-20250702    clang-21
xtensa                randconfig-002-20250702    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

