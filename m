Return-Path: <linux-pci+bounces-7583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0678C7DCC
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 22:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D736281DA0
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1197157A56;
	Thu, 16 May 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKu218M/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB815CB
	for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892432; cv=none; b=uqVnQQ2kDhkn+rWVeSoZ3HovoJwKCy2szecndbtzl/JtAQ/4Ph5dGLEGBjMEPHix78GYLhqZb+/SeZQ8rISPCM+Ojk+JhuYDqjM4zToTuhGIOmo9CT/dcPaAVjYHXk/uxO7eN5aZusguRienMEXqK66hM80Rqcg5ongmrIHSWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892432; c=relaxed/simple;
	bh=L0GZTah8UKFCZNxz6uAaVwSFdWFuv5hIv9rELhWYQtE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=A88sEmGu0WLVKnL6AyD3E0Elt5JlHZjwV6C7jpk/ycDFuK9LlFq5r+PkbhKaZqo2VcWx2zhQUKzE9+3crnRZfckdgE88kEbMi7W78ShEdDp/2wMKk65nmFGIbL3KYtB12UO861E/P/4aYlbwzQVwrWhd3g3dgFklr9LnLzzVGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKu218M/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715892431; x=1747428431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L0GZTah8UKFCZNxz6uAaVwSFdWFuv5hIv9rELhWYQtE=;
  b=PKu218M/MK0omV3WSa0LJ2+m6MuNRq5WZYKFZWemmPY93GaTgU47bTyj
   POqWjFo/deyC6nCb+z4m88KrBknA63/4ZF443buIL3K18u8UIsqn+KuPf
   JVLhaO5aUAWzoEBn6g03KbB2FdqfsHbfFcaQskiEVavO4JzQQcdmoqC/n
   fxlfGEG3Vs+xva2dmGYw10I5cGzX3EpG1kpbiS8f00IAjADiSPHBkj61h
   NDtl587YpJeNanXfaO9Pj+sNRI9z/dSwRqTX6OsK9WLMHOA4B9FnesW7b
   MfgXE7zgvlTLOuXHwSOW6adRB0bW6saCAhi0Pyn9GIi3n3QJMw8sd9ywa
   g==;
X-CSE-ConnectionGUID: 5Q1Duv8bQfenRsoFFNbjYA==
X-CSE-MsgGUID: MuEUwNDuRLyaqfoVj7m9fA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15868857"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="15868857"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 13:47:10 -0700
X-CSE-ConnectionGUID: v7P2l3h6TEWYdntYetSxMA==
X-CSE-MsgGUID: jnAt1queSnGqQ8Eq8zixuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="32102374"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 May 2024 13:47:08 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7i0I-000Em7-0I;
	Thu, 16 May 2024 20:47:06 +0000
Date: Fri, 17 May 2024 04:46:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 52d06636a4ae4db24ebfe23fae7a525f7e983604
Message-ID: <202405170440.aNqGiPm0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 52d06636a4ae4db24ebfe23fae7a525f7e983604  dt-bindings: PCI: rockchip,rk3399-pcie: Add missing maxItems to ep-gpios

elapsed time: 734m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240516   gcc  
arc                   randconfig-002-20240516   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                      jornada720_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-001-20240516   gcc  
arm                   randconfig-002-20240516   clang
arm                   randconfig-003-20240516   gcc  
arm                   randconfig-004-20240516   clang
arm                         s5pv210_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240516   gcc  
arm64                 randconfig-002-20240516   clang
arm64                 randconfig-003-20240516   clang
arm64                 randconfig-004-20240516   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240516   gcc  
csky                  randconfig-002-20240516   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240516   clang
hexagon               randconfig-002-20240516   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240516   clang
i386         buildonly-randconfig-002-20240516   clang
i386         buildonly-randconfig-003-20240516   clang
i386         buildonly-randconfig-004-20240516   gcc  
i386         buildonly-randconfig-005-20240516   gcc  
i386         buildonly-randconfig-006-20240516   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240516   gcc  
i386                  randconfig-002-20240516   gcc  
i386                  randconfig-003-20240516   clang
i386                  randconfig-004-20240516   clang
i386                  randconfig-005-20240516   clang
i386                  randconfig-006-20240516   clang
i386                  randconfig-011-20240516   gcc  
i386                  randconfig-012-20240516   gcc  
i386                  randconfig-013-20240516   clang
i386                  randconfig-014-20240516   gcc  
i386                  randconfig-015-20240516   gcc  
i386                  randconfig-016-20240516   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240516   gcc  
loongarch             randconfig-002-20240516   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240516   gcc  
nios2                 randconfig-002-20240516   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240516   gcc  
parisc                randconfig-002-20240516   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                      mgcoge_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc               randconfig-001-20240516   gcc  
powerpc               randconfig-002-20240516   clang
powerpc               randconfig-003-20240516   clang
powerpc64             randconfig-001-20240516   gcc  
powerpc64             randconfig-002-20240516   clang
powerpc64             randconfig-003-20240516   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240516   gcc  
riscv                 randconfig-002-20240516   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240516   gcc  
s390                  randconfig-002-20240516   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240516   gcc  
sh                    randconfig-002-20240516   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240516   gcc  
sparc64               randconfig-002-20240516   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240516   clang
um                    randconfig-002-20240516   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240516   gcc  
xtensa                randconfig-002-20240516   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

