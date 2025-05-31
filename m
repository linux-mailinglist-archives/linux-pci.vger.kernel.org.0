Return-Path: <linux-pci+bounces-28764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEFEAC9AE4
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 14:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E55617EBA9
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288E23815B;
	Sat, 31 May 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJZT7MW6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B9E12B63
	for <linux-pci@vger.kernel.org>; Sat, 31 May 2025 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748694130; cv=none; b=Dygo9F0YK4S7CE6NCgqgsJfLsVrF8n1vX1+HIcP6ZVwoEd+sCvRwlvaMmjxzISR+vEw/CFGq7JA4Dk67BuhYbm4+k2EysrHELdkY0CaYWl4281SHDsgwNBaJtML86cv9DrD3m4qFRfPFphBltNI6GGLPpgve6jSBqlmWscFh0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748694130; c=relaxed/simple;
	bh=iAeh/KsAuqr11dxInI5+i/Qgib3qaQoGv17fZof6pA0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Nc+SzIpV4jMxVwRv5M+spcih+ZueQhzFlF8Ul5UKYc8cepxdPSajRFhBocf2Y9rNHsls8TPatGRhxqakY4HXREmE5Gb/5HiflVq8FHA5KfKUZ36mEjHv2NpfO0H4dLVklr1Gmm7CaY0DTVHbeRbTt1UCLNVRScMdqjcsSWgEEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJZT7MW6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748694129; x=1780230129;
  h=date:from:to:cc:subject:message-id;
  bh=iAeh/KsAuqr11dxInI5+i/Qgib3qaQoGv17fZof6pA0=;
  b=DJZT7MW6Yy72l69rEkQXI7UDQ4MbplZEwX2xtGwlPze3LOBbv9bjmsxp
   QKujpfnOShgtmz8Zn+jAgbAxXI9LFvnw9JK6Yzlf9efXqD2D6cZ7lIy+J
   p5n4ge++bIvyBqRrGctaU6iV+DWivisUqR/HkCzYHvLKM4orqgQSHhlnA
   VHBZxX9tLG2WlEVF2391WoyLHs5xc25VUgvPYDFPKDFeBQUeJCqr8uRky
   SwSzdPJY7gVTrczSLBtekdKrNV5k8Fk94s0ReOGKTjUMMvlhrXPqLszQ5
   YodAdfKzh2I3LzMjY98KSZJIKumSV7lAPngayvcaNvHQ4bpro2rb9ZFVg
   w==;
X-CSE-ConnectionGUID: inIgsj0dTbSBvQ1GOQVeoQ==
X-CSE-MsgGUID: 4suKeAO8QKuM/YH+e2eJwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50652743"
X-IronPort-AV: E=Sophos;i="6.16,198,1744095600"; 
   d="scan'208";a="50652743"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 05:22:08 -0700
X-CSE-ConnectionGUID: Dox6kIv2SYGoVB0sUj3G+Q==
X-CSE-MsgGUID: EjuEkfIOQYSbdLJF9HSYnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,198,1744095600"; 
   d="scan'208";a="175124048"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 May 2025 05:22:08 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uLLDx-000YOO-0g;
	Sat, 31 May 2025 12:22:05 +0000
Date: Sat, 31 May 2025 20:21:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dw-rockchip] BUILD SUCCESS
 ec49e253322bf29e721c6153d9e7be95eef33b33
Message-ID: <202505312012.EkXtRPpu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dw-rockchip
branch HEAD: ec49e253322bf29e721c6153d9e7be95eef33b33  PCI: qcom: Replace PERST# sleep time with proper macro

elapsed time: 846m

configs tested: 121
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250531    gcc-15.1.0
arc                   randconfig-002-20250531    gcc-15.1.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-21
arm                     davinci_all_defconfig    clang-19
arm                          ep93xx_defconfig    clang-21
arm                           h3600_defconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                      integrator_defconfig    clang-21
arm                   randconfig-001-20250531    gcc-13.3.0
arm                   randconfig-002-20250531    gcc-13.3.0
arm                   randconfig-003-20250531    gcc-7.5.0
arm                   randconfig-004-20250531    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250531    gcc-10.5.0
arm64                 randconfig-002-20250531    clang-20
arm64                 randconfig-003-20250531    clang-21
arm64                 randconfig-004-20250531    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250531    gcc-12.4.0
csky                  randconfig-002-20250531    gcc-15.1.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250531    clang-21
hexagon               randconfig-002-20250531    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250531    gcc-12
i386        buildonly-randconfig-002-20250531    gcc-12
i386        buildonly-randconfig-003-20250531    gcc-12
i386        buildonly-randconfig-004-20250531    clang-20
i386        buildonly-randconfig-005-20250531    clang-20
i386        buildonly-randconfig-006-20250531    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250531    gcc-15.1.0
loongarch             randconfig-002-20250531    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250531    gcc-10.5.0
nios2                 randconfig-002-20250531    gcc-5.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250531    gcc-7.5.0
parisc                randconfig-002-20250531    gcc-10.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      bamboo_defconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                      pasemi_defconfig    clang-21
powerpc                      ppc64e_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250531    gcc-11.5.0
powerpc               randconfig-002-20250531    gcc-5.5.0
powerpc               randconfig-003-20250531    gcc-8.5.0
powerpc64             randconfig-001-20250531    clang-21
powerpc64             randconfig-003-20250531    clang-17
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250531    gcc-15.1.0
riscv                 randconfig-002-20250531    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250531    gcc-9.3.0
s390                  randconfig-002-20250531    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                    randconfig-001-20250531    gcc-15.1.0
sh                    randconfig-002-20250531    gcc-10.5.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250531    gcc-8.5.0
sparc                 randconfig-002-20250531    gcc-6.5.0
sparc64               randconfig-001-20250531    gcc-12.4.0
sparc64               randconfig-002-20250531    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250531    gcc-12
um                    randconfig-002-20250531    gcc-11
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250531    clang-20
x86_64      buildonly-randconfig-002-20250531    gcc-12
x86_64      buildonly-randconfig-003-20250531    gcc-12
x86_64      buildonly-randconfig-004-20250531    gcc-12
x86_64      buildonly-randconfig-005-20250531    clang-20
x86_64      buildonly-randconfig-006-20250531    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250531    gcc-9.3.0
xtensa                randconfig-002-20250531    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

