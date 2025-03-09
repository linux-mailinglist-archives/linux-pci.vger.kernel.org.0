Return-Path: <linux-pci+bounces-23251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E2A585B8
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B916AFC0
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D617A316;
	Sun,  9 Mar 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcQnJFUd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F92F2A
	for <linux-pci@vger.kernel.org>; Sun,  9 Mar 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536647; cv=none; b=JBOCPT3tPXaA0YX62+WeGSpxoYzV0Hyvl9H6p7GT+WiKZWlbiFNgBq6zgVLCBjAwlgMZ2B/YPmv1h4p3+i9JLfLwsUA0O3JpHoBi2XR60WIJ+P8zW7n21I6YA0bYodCHVlLtRGprfEeUeMS/Llc9mO2Ilqka0t9hxKCaeo9hgG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536647; c=relaxed/simple;
	bh=U8an+QBQmxtiUV+cWkFh5PB2JrxYhlA+J6J1e7lN4xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oWjxczVbnKbY1DyJMm1rhRsNBGOLvqFYhLssjkJVjoR5ixHP8ohFMw6y+K+LMhLXHaFIWvV0FIPuJFHBwHehCH5hNc8NsQubJvIcc+N41ENrY71at7Ylao80QLdS5azaB2j2mZGR3hGLfRtWYhQsQGSmnXD+TsQbI7k6JPDsHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcQnJFUd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741536646; x=1773072646;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U8an+QBQmxtiUV+cWkFh5PB2JrxYhlA+J6J1e7lN4xQ=;
  b=kcQnJFUdzizfGANnYzkWyn3lAKQ01ZuKVNGNoKZlsJ0FXa3vvXz8HqY1
   Rji/M1rUs6ByBeVuyb0ySS0o6JBmZXKTDjmOrWucnXVbB6fOwQ9/MyPdk
   +YmOUtiyFeeI3HvICuZU9hla2sE3Ip+ScYQGrxYDFbxgzdk7DnAewYt50
   su9Lr7Wex1utqSVPpj79w2q+WMvLAjhopZA2fAnCb1zbzpvn/O2j+xTf6
   rAM+cMA0VYWzw+qDo9dPxrcXPMFWbuTgNSlQ6RWVpz9SiF6I20h8tea+Y
   FzHApH2q2s7967sYPEN4UIA2CiFyDFdJDDkyFcp852H2wi9a1QTo29zqI
   Q==;
X-CSE-ConnectionGUID: MIfvB/qFSqKkVZ5OiZWC8g==
X-CSE-MsgGUID: /gpSaUVyR+uiyh54wKa4EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42240088"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42240088"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 09:10:43 -0700
X-CSE-ConnectionGUID: WuNT9TZySyq0LypivcKOvw==
X-CSE-MsgGUID: gfUXUlx2RL6DpFNwilQhHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="124786477"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 09 Mar 2025 09:10:42 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trJEd-0003Ga-1U;
	Sun, 09 Mar 2025 16:10:39 +0000
Date: Mon, 10 Mar 2025 00:10:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 a60a7084200591f57ad7e90a0497130d1c685670
Message-ID: <202503100019.w4oZdtH3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: a60a7084200591f57ad7e90a0497130d1c685670  PCI: dwc: ep: Remove superfluous function dw_pcie_ep_find_ext_capability()

elapsed time: 1448m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250309    gcc-13.2.0
arc                   randconfig-002-20250309    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                       multi_v4t_defconfig    clang-21
arm                         nhk8815_defconfig    clang-21
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20250309    clang-21
arm                   randconfig-002-20250309    gcc-14.2.0
arm                   randconfig-003-20250309    clang-21
arm                   randconfig-004-20250309    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250309    clang-15
arm64                 randconfig-002-20250309    clang-17
arm64                 randconfig-003-20250309    clang-15
arm64                 randconfig-004-20250309    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250309    gcc-14.2.0
csky                  randconfig-002-20250309    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250309    clang-21
hexagon               randconfig-002-20250309    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250309    clang-19
i386        buildonly-randconfig-002-20250309    clang-19
i386        buildonly-randconfig-003-20250309    gcc-11
i386        buildonly-randconfig-004-20250309    gcc-12
i386        buildonly-randconfig-005-20250309    clang-19
i386        buildonly-randconfig-006-20250309    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250309    gcc-14.2.0
loongarch             randconfig-002-20250309    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250309    gcc-14.2.0
nios2                 randconfig-002-20250309    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250309    gcc-14.2.0
parisc                randconfig-002-20250309    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc               randconfig-001-20250309    gcc-14.2.0
powerpc               randconfig-002-20250309    clang-21
powerpc               randconfig-003-20250309    clang-21
powerpc64             randconfig-001-20250309    clang-15
powerpc64             randconfig-002-20250309    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250309    clang-15
riscv                 randconfig-002-20250309    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250309    clang-16
s390                  randconfig-002-20250309    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250309    gcc-14.2.0
sh                    randconfig-002-20250309    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250309    gcc-14.2.0
sparc                 randconfig-002-20250309    gcc-14.2.0
sparc64               randconfig-001-20250309    gcc-14.2.0
sparc64               randconfig-002-20250309    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250309    clang-21
um                    randconfig-002-20250309    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250309    gcc-14.2.0
xtensa                randconfig-002-20250309    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

