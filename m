Return-Path: <linux-pci+bounces-34785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF1B372FE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D126B5E6DB5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E743164D9;
	Tue, 26 Aug 2025 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RekHf3KF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654330E83B
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236194; cv=none; b=dpBXQEtdtUThzKHlGad0z+xJY6HTjHK9sCtFcPRx21qDAiyWTvaV5xJAoE9aQJPwvP+iEgih4eo1pnWuMX/tOCkPLrbimDdOgjoSma/LbJRp1+apXiE0Q9i5PLSx8xc/NdGsIQfJP5ZAaQBAGFNn9o4EsBJxCOhUdBBeNqpMA6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236194; c=relaxed/simple;
	bh=xA4yS2HmM/Fn1ckpPoBohEulyYDm3Bgsq+zS1aQPsUA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l6B2SSEWQVouUdjkEbcs6X5tiGDiofFGA0XbFJF1y0QAGWfdkYZapKZSsjSvUvUwMqkcaILv72klvisgXz3xqzKwfQT9ZQkyeUutVpUWtb45rg4M080+7TnjMNVY83XxtALL6xb2sVDA2dW35dzbnJ3CRs2jofgjRXx6iBncmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RekHf3KF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756236193; x=1787772193;
  h=date:from:to:cc:subject:message-id;
  bh=xA4yS2HmM/Fn1ckpPoBohEulyYDm3Bgsq+zS1aQPsUA=;
  b=RekHf3KFf2tzZL/oyhgiNOYZxWgCjiu7yyX2CH5REa0LkJj9X7G7Qp/7
   A8cfJam4NlNp4TXtYD/A7OumzfRQOFJ2hvMbIXV7FVD/rmGHUnpxqy769
   /Zv7sQzJXtYCJ6oOgnuAYjG7wiW5vqAPBXRoAGnFQ/dwT5JSIEzu38g1N
   kMv4hxUEtUrx83jsQ0898/BO+yFgZ9bBFpRiMPFeLcaKFVGoOogdm7mAD
   d1GS1JOJqaLE6YoykPIa5N7iQhfEdk260O68iK2r/qzrvV1Dl84RKHYPk
   AEHuI1fE8bU7XGPp8JX8rFjRD73c/pXphg8ubDhelfSQGPpnNdY9O0k8K
   A==;
X-CSE-ConnectionGUID: TFi/NgK2RR6rFJofimhc1Q==
X-CSE-MsgGUID: HabU846EQmWfNJM/w6fZQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58636219"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58636219"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 12:23:13 -0700
X-CSE-ConnectionGUID: 09qRY8mdRfqyAaQlXaj3rQ==
X-CSE-MsgGUID: 8IAGkMD9TEKXHVsr5daS0g==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 26 Aug 2025 12:23:11 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqzFz-000SKV-34;
	Tue, 26 Aug 2025 19:23:03 +0000
Date: Wed, 27 Aug 2025 03:22:57 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2508-ilpo-bridge-window-selection] BUILD SUCCESS
 e6d53deaa7925f9c2fb98c76b74788d0350111ed
Message-ID: <202508270350.xv1o1gLO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2508-ilpo-bridge-window-selection
branch HEAD: e6d53deaa7925f9c2fb98c76b74788d0350111ed  PCI: Alter misleading recursion to pci_bus_release_bridge_resources()

elapsed time: 1192m

configs tested: 257
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250826    gcc-11.5.0
arc                   randconfig-001-20250826    gcc-8.5.0
arc                   randconfig-002-20250826    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                       imx_v4_v5_defconfig    clang-22
arm                          moxart_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                   randconfig-001-20250826    gcc-12.5.0
arm                   randconfig-001-20250826    gcc-8.5.0
arm                   randconfig-002-20250826    gcc-13.4.0
arm                   randconfig-002-20250826    gcc-8.5.0
arm                   randconfig-003-20250826    gcc-8.5.0
arm                   randconfig-004-20250826    gcc-10.5.0
arm                   randconfig-004-20250826    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250826    clang-22
arm64                 randconfig-001-20250826    gcc-8.5.0
arm64                 randconfig-002-20250826    gcc-8.5.0
arm64                 randconfig-003-20250826    clang-22
arm64                 randconfig-003-20250826    gcc-8.5.0
arm64                 randconfig-004-20250826    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250826    gcc-15.1.0
csky                  randconfig-001-20250827    gcc-15.1.0
csky                  randconfig-002-20250826    gcc-11.5.0
csky                  randconfig-002-20250827    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250826    clang-19
hexagon               randconfig-001-20250827    gcc-15.1.0
hexagon               randconfig-002-20250826    clang-22
hexagon               randconfig-002-20250827    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250826    gcc-12
i386        buildonly-randconfig-002-20250826    gcc-12
i386        buildonly-randconfig-003-20250826    clang-20
i386        buildonly-randconfig-004-20250826    gcc-12
i386        buildonly-randconfig-005-20250826    clang-20
i386        buildonly-randconfig-006-20250826    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250826    gcc-11
i386                  randconfig-001-20250827    clang-20
i386                  randconfig-002-20250826    gcc-11
i386                  randconfig-002-20250827    clang-20
i386                  randconfig-003-20250826    gcc-11
i386                  randconfig-003-20250827    clang-20
i386                  randconfig-004-20250826    gcc-11
i386                  randconfig-004-20250827    clang-20
i386                  randconfig-005-20250826    gcc-11
i386                  randconfig-005-20250827    clang-20
i386                  randconfig-006-20250826    gcc-11
i386                  randconfig-006-20250827    clang-20
i386                  randconfig-007-20250826    gcc-11
i386                  randconfig-007-20250827    clang-20
i386                  randconfig-011-20250826    gcc-12
i386                  randconfig-011-20250827    clang-20
i386                  randconfig-012-20250826    gcc-12
i386                  randconfig-012-20250827    clang-20
i386                  randconfig-013-20250826    gcc-12
i386                  randconfig-013-20250827    clang-20
i386                  randconfig-014-20250826    gcc-12
i386                  randconfig-014-20250827    clang-20
i386                  randconfig-015-20250826    gcc-12
i386                  randconfig-015-20250827    clang-20
i386                  randconfig-016-20250826    gcc-12
i386                  randconfig-016-20250827    clang-20
i386                  randconfig-017-20250826    gcc-12
i386                  randconfig-017-20250827    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250826    gcc-14.3.0
loongarch             randconfig-001-20250827    gcc-15.1.0
loongarch             randconfig-002-20250826    gcc-14.3.0
loongarch             randconfig-002-20250827    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                         bigsur_defconfig    clang-22
mips                           ip22_defconfig    clang-22
mips                           ip27_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250826    gcc-8.5.0
nios2                 randconfig-001-20250827    gcc-15.1.0
nios2                 randconfig-002-20250826    gcc-10.5.0
nios2                 randconfig-002-20250827    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250826    gcc-8.5.0
parisc                randconfig-001-20250827    gcc-15.1.0
parisc                randconfig-002-20250826    gcc-15.1.0
parisc                randconfig-002-20250827    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 canyonlands_defconfig    clang-22
powerpc                          g5_defconfig    clang-22
powerpc                    ge_imp3a_defconfig    clang-22
powerpc                   lite5200b_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20250826    gcc-8.5.0
powerpc               randconfig-001-20250827    gcc-15.1.0
powerpc               randconfig-002-20250826    clang-22
powerpc               randconfig-002-20250827    gcc-15.1.0
powerpc               randconfig-003-20250826    gcc-13.4.0
powerpc               randconfig-003-20250827    gcc-15.1.0
powerpc64             randconfig-001-20250826    gcc-10.5.0
powerpc64             randconfig-001-20250827    gcc-15.1.0
powerpc64             randconfig-002-20250826    gcc-11.5.0
powerpc64             randconfig-002-20250827    gcc-15.1.0
powerpc64             randconfig-003-20250826    gcc-14.3.0
powerpc64             randconfig-003-20250827    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250826    gcc-8.5.0
riscv                 randconfig-002-20250826    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250826    clang-22
s390                  randconfig-002-20250826    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    clang-22
sh                    randconfig-001-20250826    gcc-11.5.0
sh                    randconfig-002-20250826    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250826    gcc-13.4.0
sparc                 randconfig-002-20250826    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250826    gcc-8.5.0
sparc64               randconfig-002-20250826    clang-22
um                               alldefconfig    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250826    gcc-12
um                    randconfig-002-20250826    clang-17
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250826    clang-20
x86_64      buildonly-randconfig-002-20250826    clang-20
x86_64      buildonly-randconfig-003-20250826    gcc-12
x86_64      buildonly-randconfig-004-20250826    clang-20
x86_64      buildonly-randconfig-005-20250826    gcc-12
x86_64      buildonly-randconfig-006-20250826    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250826    gcc-12
x86_64                randconfig-001-20250827    clang-20
x86_64                randconfig-002-20250826    gcc-12
x86_64                randconfig-002-20250827    clang-20
x86_64                randconfig-003-20250826    gcc-12
x86_64                randconfig-003-20250827    clang-20
x86_64                randconfig-004-20250826    gcc-12
x86_64                randconfig-004-20250827    clang-20
x86_64                randconfig-005-20250826    gcc-12
x86_64                randconfig-005-20250827    clang-20
x86_64                randconfig-006-20250826    gcc-12
x86_64                randconfig-006-20250827    clang-20
x86_64                randconfig-007-20250826    gcc-12
x86_64                randconfig-007-20250827    clang-20
x86_64                randconfig-008-20250826    gcc-12
x86_64                randconfig-008-20250827    clang-20
x86_64                randconfig-071-20250826    clang-20
x86_64                randconfig-072-20250826    clang-20
x86_64                randconfig-073-20250826    clang-20
x86_64                randconfig-074-20250826    clang-20
x86_64                randconfig-075-20250826    clang-20
x86_64                randconfig-076-20250826    clang-20
x86_64                randconfig-077-20250826    clang-20
x86_64                randconfig-078-20250826    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250826    gcc-11.5.0
xtensa                randconfig-002-20250826    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

