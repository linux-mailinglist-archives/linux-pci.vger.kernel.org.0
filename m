Return-Path: <linux-pci+bounces-17013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7F19D074C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 01:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18302818EF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2B38B;
	Mon, 18 Nov 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+YRpEHh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FD4689
	for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2024 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731890500; cv=none; b=G1FCAl4/XdaaPqSHSOl2t2VRGHs3i5gQoGxJPJS6aKWTN01NzrapejmFvWgaiLl4NqH6SJ61Cyv8fqEd9BoVMIAnn7UiBDrFC1cfaYEFApvnaRqzog/pvVZMtH3wmcRf8FAJjFkaAouwXaAB56AgewLlVkgIegYvIIo7CHzRH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731890500; c=relaxed/simple;
	bh=EoTwuoM3vHALXg3wxUQSCh6TMLbRzqil+WR0vWUzoDY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O5Mc/r1HxJO4/iZwPg9TpnKcX1QgQtkdlN8N+OgFKdPWJpFSdbiShN0b2/znvvdZdl4gPBUsARpIlmvSqqpx16FPF8mz41/IkVrAN1jzKoMSJlhFNYQK9gUbX59fUphUo6rlJmnm2OK4IwTJGJkZQ7RS1NHGgdGaA8QPMUzxg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+YRpEHh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731890499; x=1763426499;
  h=date:from:to:cc:subject:message-id;
  bh=EoTwuoM3vHALXg3wxUQSCh6TMLbRzqil+WR0vWUzoDY=;
  b=a+YRpEHhow2G2BqoUnaHwfe3XgVGaFI7DXny54T1r4z5+oxzB9b/ervo
   6h/937GvqUdYPrwvfdIOdGOqI8xVKc1Ofen5RueNfEHu2+EYxcYsc2JEK
   MU+0RWooVmgXWga6ZN6SFznywd41M/l0k67loLoQU09ZiUOtwMU2egRWH
   Sb0EUvYOlS4aFczH4ZOpsPdH1GJS23FAS3dUT8ad5OqS/OktM1fgNOKF5
   LWhThXG16kM1HtnrR7pQ6/IfFyA9KP06JrtTbfTi41FJIE8ig9l6EJASY
   gdfkK4hBqi6Ia/Y5UIZ0pjqcQItz5z307WLi0D1ftbjyUe2pCdNXG8wE8
   A==;
X-CSE-ConnectionGUID: hj0QH6YMTaG5LRom50IFsA==
X-CSE-MsgGUID: DvNlONLJSLSMTqXOtMPrLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42462568"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="42462568"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 16:41:39 -0800
X-CSE-ConnectionGUID: xQ7MDPWzRHa/OFXKZCWnxQ==
X-CSE-MsgGUID: 1gPwhDixTSmdk5XUWumk/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="119922937"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Nov 2024 16:41:38 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCppf-0002A5-0E;
	Mon, 18 Nov 2024 00:41:35 +0000
Date: Mon, 18 Nov 2024 08:40:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 bf4295e9f8af4534d212a190e75e6742b00b69df
Message-ID: <202411180834.Wgo7nTtP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: bf4295e9f8af4534d212a190e75e6742b00b69df  Merge branch 'pci/typos'

elapsed time: 1977m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20241118    gcc-13.2.0
arc                   randconfig-002-20241118    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                   randconfig-001-20241118    gcc-14.2.0
arm                   randconfig-002-20241118    gcc-14.2.0
arm                   randconfig-003-20241118    gcc-14.2.0
arm                   randconfig-004-20241118    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241118    clang-14
arm64                 randconfig-002-20241118    gcc-14.2.0
arm64                 randconfig-003-20241118    gcc-14.2.0
arm64                 randconfig-004-20241118    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241118    gcc-14.2.0
csky                  randconfig-002-20241118    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241118    clang-20
hexagon               randconfig-002-20241118    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241118    gcc-12
i386        buildonly-randconfig-002-20241118    gcc-12
i386        buildonly-randconfig-003-20241118    clang-19
i386        buildonly-randconfig-004-20241118    clang-19
i386        buildonly-randconfig-005-20241118    gcc-12
i386        buildonly-randconfig-006-20241118    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241118    gcc-12
i386                  randconfig-002-20241118    gcc-12
i386                  randconfig-003-20241118    gcc-12
i386                  randconfig-004-20241118    clang-19
i386                  randconfig-005-20241118    gcc-12
i386                  randconfig-006-20241118    gcc-12
i386                  randconfig-011-20241118    clang-19
i386                  randconfig-012-20241118    gcc-12
i386                  randconfig-013-20241118    gcc-12
i386                  randconfig-014-20241118    gcc-11
i386                  randconfig-015-20241118    clang-19
i386                  randconfig-016-20241118    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241118    gcc-14.2.0
loongarch             randconfig-002-20241118    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241118    gcc-14.2.0
nios2                 randconfig-002-20241118    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241118    gcc-14.2.0
parisc                randconfig-002-20241118    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-002-20241118    gcc-14.2.0
powerpc               randconfig-003-20241118    gcc-14.2.0
powerpc64             randconfig-001-20241118    clang-14
powerpc64             randconfig-002-20241118    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241118    clang-14
riscv                 randconfig-002-20241118    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                                defconfig    clang-20
s390                  randconfig-001-20241118    gcc-14.2.0
s390                  randconfig-002-20241118    clang-20
sh                                allnoconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241118    gcc-14.2.0
sh                    randconfig-002-20241118    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241118    gcc-14.2.0
sparc64               randconfig-002-20241118    gcc-14.2.0
um                                allnoconfig    clang-17
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241118    clang-16
um                    randconfig-002-20241118    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241118    clang-19
x86_64      buildonly-randconfig-002-20241118    clang-19
x86_64      buildonly-randconfig-003-20241118    gcc-12
x86_64      buildonly-randconfig-004-20241118    clang-19
x86_64      buildonly-randconfig-005-20241118    clang-19
x86_64      buildonly-randconfig-006-20241118    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-002-20241118    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241118    gcc-14.2.0
xtensa                randconfig-002-20241118    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

