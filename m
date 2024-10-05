Return-Path: <linux-pci+bounces-13880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C7991424
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 05:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FCE1C21E8D
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 03:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868BC211C;
	Sat,  5 Oct 2024 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlYsBIe3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE29231C96
	for <linux-pci@vger.kernel.org>; Sat,  5 Oct 2024 03:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099776; cv=none; b=ErR6ogglDBImo+qPixjsrKQE8P7NkI7jzd8z5+43raBIjdMHnOqDxnQpe5g4jLLteBfVVtSbSAGlzHnYzz1WRLLn8I1V6trNGOUyn9rUPBSBPHOjgEtbdBo5+jMjtz+kO3u8AmCeE60KAEcpt1O2krKDVCR4k1DbXlnWjwBSuF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099776; c=relaxed/simple;
	bh=sQ4QvubPfcFAh9hKCQWimvNQJ9ADfGi3DQ+bgw6svsY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BO107PozvPO5N3cBN5nW1YjHnldXIDPY5SPEgYWdax/G6KpWs8Fhp9+osYkruEBvqqu3fXpLIoqthXjcwll/87TH9QvG+t0sKVCCtaoMOAaiXvvzKxmZVhfELoaDnJxVvsWrd/S7YPI3QOBJiaYWHgmTzatOzpBLQlxFboPLJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlYsBIe3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728099775; x=1759635775;
  h=date:from:to:cc:subject:message-id;
  bh=sQ4QvubPfcFAh9hKCQWimvNQJ9ADfGi3DQ+bgw6svsY=;
  b=nlYsBIe3eqrLeDlLBWZnCZIGo5ZLYNVj3h8pBAUX8azb/ESC9Qkp+ndH
   v51dn2wJ0KwZtYlIokQtaGLDJILy4ZfUv8DLaB4mq/nq6E530+6P+y5V5
   UfYmjhJ23eXFtx0jDZ3Rtcrgo8zwFyavF+LV/ZjRqINFe0h64doU3YmN6
   wGtjUbwLXkR2kJOJHS9r2/VLkLuBbKdDg0nV1HW5p2rYcITOGECQjJJIb
   8OC4xpssvCUUOm5LyeuNncOZGnKM3dPM6bahJ2DpyBXhQJaQVXE0qvbcK
   qNmtTIoU9UxIFpDBsLro1iAJ28DId4z5k5Lwc5q8YmNWS1IzuL2MnYzuB
   A==;
X-CSE-ConnectionGUID: PpQ/KzH6QZe7bKxeIyE+HQ==
X-CSE-MsgGUID: UJltJqVES96eRPdLTWlsIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27463252"
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="27463252"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 20:42:54 -0700
X-CSE-ConnectionGUID: gfVzT9HbQXeUN1g5yTB4AA==
X-CSE-MsgGUID: 9xBiLd9dRbGvtYNtNv93Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="79664593"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Oct 2024 20:42:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swvgx-0002Wc-0i;
	Sat, 05 Oct 2024 03:42:51 +0000
Date: Sat, 05 Oct 2024 11:41:58 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 d219adbfc83a711c2d51c82dda79e22cc51dcfac
Message-ID: <202410051145.ITPEh7hC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: d219adbfc83a711c2d51c82dda79e22cc51dcfac  Merge branch 'pci/misc'

elapsed time: 1778m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                           tb10x_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      integrator_defconfig    gcc-13.2.0
arm                           omap1_defconfig    gcc-13.2.0
arm                           sama7_defconfig    gcc-13.2.0
arm                         socfpga_defconfig    gcc-13.2.0
arm                        spear3xx_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-13.2.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             alldefconfig    gcc-13.2.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241005    clang-18
i386        buildonly-randconfig-002-20241005    clang-18
i386        buildonly-randconfig-003-20241005    clang-18
i386        buildonly-randconfig-004-20241005    clang-18
i386        buildonly-randconfig-005-20241005    gcc-12
i386        buildonly-randconfig-006-20241005    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241005    gcc-11
i386                  randconfig-002-20241005    clang-18
i386                  randconfig-003-20241005    gcc-12
i386                  randconfig-004-20241005    clang-18
i386                  randconfig-005-20241005    clang-18
i386                  randconfig-006-20241005    clang-18
i386                  randconfig-011-20241005    gcc-12
i386                  randconfig-012-20241005    clang-18
i386                  randconfig-013-20241005    clang-18
i386                  randconfig-014-20241005    gcc-12
i386                  randconfig-015-20241005    gcc-12
i386                  randconfig-016-20241005    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                         3c120_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       eiger_defconfig    gcc-13.2.0
powerpc                      pasemi_defconfig    gcc-13.2.0
powerpc                     tqm8540_defconfig    gcc-13.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                   sh7724_generic_defconfig    gcc-13.2.0
sh                        sh7763rdp_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241005    gcc-12
x86_64      buildonly-randconfig-002-20241005    gcc-12
x86_64      buildonly-randconfig-003-20241005    gcc-12
x86_64      buildonly-randconfig-004-20241005    gcc-12
x86_64      buildonly-randconfig-005-20241005    gcc-12
x86_64      buildonly-randconfig-006-20241005    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241005    gcc-12
x86_64                randconfig-002-20241005    gcc-12
x86_64                randconfig-003-20241005    gcc-12
x86_64                randconfig-004-20241005    gcc-12
x86_64                randconfig-005-20241005    gcc-12
x86_64                randconfig-006-20241005    gcc-12
x86_64                randconfig-011-20241005    gcc-12
x86_64                randconfig-012-20241005    gcc-12
x86_64                randconfig-013-20241005    gcc-12
x86_64                randconfig-014-20241005    gcc-12
x86_64                randconfig-015-20241005    gcc-12
x86_64                randconfig-016-20241005    gcc-12
x86_64                randconfig-071-20241005    gcc-12
x86_64                randconfig-072-20241005    gcc-12
x86_64                randconfig-073-20241005    gcc-12
x86_64                randconfig-074-20241005    gcc-12
x86_64                randconfig-075-20241005    gcc-12
x86_64                randconfig-076-20241005    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

