Return-Path: <linux-pci+bounces-22716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7CA4B1F5
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 14:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B6E188E2D3
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8701E7C2E;
	Sun,  2 Mar 2025 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRIjtDjB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA51DE8A8
	for <linux-pci@vger.kernel.org>; Sun,  2 Mar 2025 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740923159; cv=none; b=e3O9rEPV7QALja70l1A6SgjanohlsDKtNqZPysh6uJ0Igb0x6YdYqqybFPKsnFdQ6nlvoKM40jLyJ5/G/RSpSuCqBCD0IAmdikE9+QOTA0iBXXv9GLR1CY+yyc/8ie34NeSpgJvF+ejegWzxbjSYn81XvrgKX1AUhs+RcaUSKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740923159; c=relaxed/simple;
	bh=p+tNe+sI5hzS6/r6NceGL1GNrU0pSLkB+UctCuTbB6M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Dv9v7AJ4TEPk/0vpj7TUNYazUssTRUMlM+SLrUkk0dIms7cYzAaYlXNNymHFolFErGemrQKF6zQA0FrUWfNlOVbM/+FEFWEOV5og7aXS5eNpGA2wpp5Tk9B5HxVdAPcJ7tAUiTVI5y7zTOkcLVqZHGhDgYXqFGHRI2Wy6XKEcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRIjtDjB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740923158; x=1772459158;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p+tNe+sI5hzS6/r6NceGL1GNrU0pSLkB+UctCuTbB6M=;
  b=BRIjtDjBmf/5bdYd7hv6Wbmn4iP77AaBupylWubtvUoTyvk1lTF6d/Ar
   Oh/YlqaZTiv+U6jaxj2p6gSO84Vvvp2LWtx4d9KTRybm+6PnSGPmSG735
   gwtNZUhLFaGMyxn9Dx7C+FZlpxfK5LQ1kjWtRhTSbY+6OtvWRisy8gPBc
   zKhvspqt+IPUBMhOub6+P4kvgYLDpWSnfF/+klF5jx13Jut94XFGhbl+R
   UgxJA1Obg8k7sb+IIoPSh2dNbGrG9UXz00qfR1yQOH+ZO+de0UyKr0UvD
   xUJwzxzokm0bFgcULb1uo6aS98n8tAl954gCRlfseU5elNq5F3I8bB7OP
   g==;
X-CSE-ConnectionGUID: 0nJNkAPSSse2+irNAj63cA==
X-CSE-MsgGUID: nfcCRYabSJ65hL9/yWyGTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41831377"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="41831377"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 05:45:57 -0800
X-CSE-ConnectionGUID: xdmG3bSWQkCuvkQcr5uIUw==
X-CSE-MsgGUID: joaN2+J1QI6QATenv4tphg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117630189"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Mar 2025 05:45:55 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tojdh-000HLk-1Q;
	Sun, 02 Mar 2025 13:45:53 +0000
Date: Sun, 02 Mar 2025 21:45:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 f54bd90ed21b4511c98a9d6ba234ddfe5dc540f3
Message-ID: <202503022140.8KjdBqN1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: f54bd90ed21b4511c98a9d6ba234ddfe5dc540f3  PCI: dwc: Add Rockchip to the RAS DES allowed vendor list

elapsed time: 1443m

configs tested: 124
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250301    gcc-13.2.0
arc                   randconfig-002-20250301    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-15
arm                          pxa168_defconfig    clang-16
arm                   randconfig-001-20250301    gcc-14.2.0
arm                   randconfig-002-20250301    gcc-14.2.0
arm                   randconfig-003-20250301    clang-21
arm                   randconfig-004-20250301    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250301    gcc-14.2.0
arm64                 randconfig-002-20250301    clang-21
arm64                 randconfig-003-20250301    clang-15
arm64                 randconfig-004-20250301    clang-17
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250301    gcc-14.2.0
csky                  randconfig-002-20250301    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250301    clang-21
hexagon               randconfig-002-20250301    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250301    clang-19
i386        buildonly-randconfig-002-20250301    clang-19
i386        buildonly-randconfig-003-20250301    clang-19
i386        buildonly-randconfig-004-20250301    clang-19
i386        buildonly-randconfig-005-20250301    gcc-12
i386        buildonly-randconfig-006-20250301    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250301    gcc-14.2.0
loongarch             randconfig-002-20250301    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-21
mips                         bigsur_defconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250301    gcc-14.2.0
nios2                 randconfig-002-20250301    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250301    gcc-14.2.0
parisc                randconfig-002-20250301    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      cm5200_defconfig    clang-21
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    clang-16
powerpc               mpc834x_itxgp_defconfig    clang-18
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250301    clang-17
powerpc               randconfig-002-20250301    clang-19
powerpc               randconfig-003-20250301    clang-21
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250301    gcc-14.2.0
powerpc64             randconfig-002-20250301    clang-21
powerpc64             randconfig-003-20250301    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250301    gcc-14.2.0
riscv                 randconfig-002-20250301    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250301    clang-15
s390                  randconfig-002-20250301    gcc-14.2.0
sh                               alldefconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250301    gcc-14.2.0
sh                    randconfig-002-20250301    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250301    gcc-14.2.0
sparc                 randconfig-002-20250301    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250301    gcc-14.2.0
sparc64               randconfig-002-20250301    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250301    gcc-12
um                    randconfig-002-20250301    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250301    clang-19
x86_64      buildonly-randconfig-002-20250301    clang-19
x86_64      buildonly-randconfig-003-20250301    gcc-11
x86_64      buildonly-randconfig-004-20250301    gcc-12
x86_64      buildonly-randconfig-005-20250301    gcc-12
x86_64      buildonly-randconfig-006-20250301    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250301    gcc-14.2.0
xtensa                randconfig-002-20250301    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

