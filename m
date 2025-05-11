Return-Path: <linux-pci+bounces-27551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F2AB25C5
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 02:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3293A3B3D78
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF671645;
	Sun, 11 May 2025 00:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITX8gF+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C624195
	for <linux-pci@vger.kernel.org>; Sun, 11 May 2025 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746922300; cv=none; b=YhoaLzGkYXs/CflROXU7YxffBPDVgWPZ2sZl+powm1FRtoGK3kC6cSvnOcoWcYW/EhsCpNEZICZYori7gedh8wtTQBe9TgftWinTHDS2WlECDip4bUUtoIaiuyHEQiOsjgk/7fyQTRmKT8EhfZ8tcWUXhI/rUz4e6HvyrNt3+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746922300; c=relaxed/simple;
	bh=45UYO2Tq5Is8zDwT+XcU6773WdV4zcWIvRyidWzQpdM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BSbcT+Y6ExA9KwG4u4akWrjKmTtJFqtHRaREREecO/eOIB3imGlR3V779UB415fp1G27+XkRXQUYqcK2wGJfKLLyY3Gp7KgahUOUDynJyvxQQ1PXL72asy/gSSJWd9AWX9WwO/gXgzPLDtvN/iEk6AXi9A3LKhBR5yPiMcy66wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITX8gF+T; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746922298; x=1778458298;
  h=date:from:to:cc:subject:message-id;
  bh=45UYO2Tq5Is8zDwT+XcU6773WdV4zcWIvRyidWzQpdM=;
  b=ITX8gF+TK03sNWXGO0NzyWjPfEhV9YvfjldJ9dBnj25xcbVbTPBBxUgl
   saN6xOzbHtxPctWGb5csGjPMKVus9bBmmyDn4X11RnU2PjLGQgte0RH/M
   CRAxUVGbXn1k5M27DpRufommeB7t+bYiuZpy8wSzrJwakGt/BqsGANjv0
   Oy9E87CYr9157AMvh91QAfhWdamliN6tJCYF/s6LkewDZwNwsyMzBA4YF
   5RDMJMER7fJgGQDYFe397SZPFXRZojYnUbjxsOpAxNz8dNye+r4tnyqKT
   Uk0YzA8tOrEJbpfLWinrszJ+fCrBO9Ndaeg+MhIZ3Zntz+S/LUQbHYRh0
   Q==;
X-CSE-ConnectionGUID: EKcDk7WoSKGW5b3r3czPjg==
X-CSE-MsgGUID: WFHCC9zFSk+t2hpoL6Hr6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="74120668"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="74120668"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 17:11:37 -0700
X-CSE-ConnectionGUID: oEtSvqNtT2yPjKb2fWO52Q==
X-CSE-MsgGUID: ITOh7GwzRraFTH6mWWMP+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="174164990"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 May 2025 17:11:37 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDuI2-000DUJ-1P;
	Sun, 11 May 2025 00:11:34 +0000
Date: Sun, 11 May 2025 08:11:12 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-ep] BUILD SUCCESS
 2612378d442aad23448053c47f34eb17f6209e67
Message-ID: <202505110802.Qba1tDwR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-ep
branch HEAD: 2612378d442aad23448053c47f34eb17f6209e67  PCI: dwc: ep: Use FIELD_GET() where applicable

elapsed time: 1065m

configs tested: 211
configs skipped: 4

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
arc                                 defconfig    gcc-14.2.0
arc                        nsim_700_defconfig    gcc-14.2.0
arc                   randconfig-001-20250510    gcc-14.2.0
arc                   randconfig-001-20250510    gcc-7.5.0
arc                   randconfig-002-20250510    gcc-13.3.0
arc                   randconfig-002-20250510    gcc-7.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                      footbridge_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    gcc-14.2.0
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20250510    gcc-10.5.0
arm                   randconfig-001-20250510    gcc-7.5.0
arm                   randconfig-002-20250510    clang-21
arm                   randconfig-002-20250510    gcc-7.5.0
arm                   randconfig-003-20250510    gcc-10.5.0
arm                   randconfig-003-20250510    gcc-7.5.0
arm                   randconfig-004-20250510    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250510    gcc-7.5.0
arm64                 randconfig-002-20250510    gcc-5.5.0
arm64                 randconfig-002-20250510    gcc-7.5.0
arm64                 randconfig-003-20250510    clang-21
arm64                 randconfig-003-20250510    gcc-7.5.0
arm64                 randconfig-004-20250510    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250510    clang-18
csky                  randconfig-001-20250510    gcc-14.2.0
csky                  randconfig-002-20250510    clang-18
csky                  randconfig-002-20250510    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250510    clang-18
hexagon               randconfig-001-20250510    clang-21
hexagon               randconfig-002-20250510    clang-18
hexagon               randconfig-002-20250510    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250510    gcc-12
i386        buildonly-randconfig-002-20250510    gcc-12
i386        buildonly-randconfig-003-20250510    gcc-12
i386        buildonly-randconfig-004-20250510    gcc-12
i386        buildonly-randconfig-005-20250510    gcc-12
i386        buildonly-randconfig-006-20250510    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-011-20250510    clang-20
i386                  randconfig-012-20250510    clang-20
i386                  randconfig-013-20250510    clang-20
i386                  randconfig-014-20250510    clang-20
i386                  randconfig-015-20250510    clang-20
i386                  randconfig-016-20250510    clang-20
i386                  randconfig-017-20250510    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250510    clang-18
loongarch             randconfig-001-20250510    gcc-13.3.0
loongarch             randconfig-002-20250510    clang-18
loongarch             randconfig-002-20250510    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250510    clang-18
nios2                 randconfig-001-20250510    gcc-11.5.0
nios2                 randconfig-002-20250510    clang-18
nios2                 randconfig-002-20250510    gcc-7.5.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250510    clang-18
parisc                randconfig-001-20250510    gcc-6.5.0
parisc                randconfig-002-20250510    clang-18
parisc                randconfig-002-20250510    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250510    clang-18
powerpc               randconfig-001-20250510    gcc-7.5.0
powerpc               randconfig-002-20250510    clang-17
powerpc               randconfig-002-20250510    clang-18
powerpc               randconfig-003-20250510    clang-18
powerpc               randconfig-003-20250510    clang-21
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                     taishan_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250510    clang-18
powerpc64             randconfig-002-20250510    clang-18
powerpc64             randconfig-002-20250510    gcc-10.5.0
powerpc64             randconfig-003-20250510    clang-18
powerpc64             randconfig-003-20250510    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250510    gcc-14.2.0
riscv                 randconfig-002-20250510    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250510    gcc-7.5.0
s390                  randconfig-002-20250510    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.2.0
sh                    randconfig-001-20250510    gcc-9.3.0
sh                    randconfig-002-20250510    gcc-11.5.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250510    gcc-12.4.0
sparc                 randconfig-002-20250510    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250510    gcc-10.5.0
sparc64               randconfig-002-20250510    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250510    gcc-12
um                    randconfig-002-20250510    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250510    clang-20
x86_64      buildonly-randconfig-002-20250510    clang-20
x86_64      buildonly-randconfig-003-20250510    gcc-12
x86_64      buildonly-randconfig-004-20250510    gcc-11
x86_64      buildonly-randconfig-005-20250510    gcc-12
x86_64      buildonly-randconfig-006-20250510    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250510    clang-20
x86_64                randconfig-002-20250510    clang-20
x86_64                randconfig-003-20250510    clang-20
x86_64                randconfig-004-20250510    clang-20
x86_64                randconfig-005-20250510    clang-20
x86_64                randconfig-006-20250510    clang-20
x86_64                randconfig-007-20250510    clang-20
x86_64                randconfig-008-20250510    clang-20
x86_64                randconfig-071-20250510    gcc-11
x86_64                randconfig-072-20250510    gcc-11
x86_64                randconfig-073-20250510    gcc-11
x86_64                randconfig-074-20250510    gcc-11
x86_64                randconfig-075-20250510    gcc-11
x86_64                randconfig-076-20250510    gcc-11
x86_64                randconfig-077-20250510    gcc-11
x86_64                randconfig-078-20250510    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250510    gcc-8.5.0
xtensa                randconfig-002-20250510    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

