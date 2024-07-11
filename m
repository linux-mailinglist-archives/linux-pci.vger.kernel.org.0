Return-Path: <linux-pci+bounces-10130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B3592DD5A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 02:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B45AB21A16
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 00:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503B317FD;
	Thu, 11 Jul 2024 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZILHCO0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE610E4
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720657318; cv=none; b=bdhWUZEp6e4walqATZN3boz6QQYmp/JGoRKS9QqGumMd+J0VBUuYxWF7aYjBzx3YdW+uf/DY+0om986knFDE3JgvdYs7EGJbxM92wJjQNAthNY52ojQqDIuduO9sHD/0UuJ7jc8noDsEl2viGTX9Ahf9lrAJZmnzKKETvq9oC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720657318; c=relaxed/simple;
	bh=ytPy6dDVcZQFl1E6Q4tRaYBFrY8+7jK+TkFPC3Hr8h0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aYlDpZxM0eD3/cMhkDepXd3xOFJi5kBteMFs+5KyQXADsVw2FW/fb/PTmP9dWD5IiM1XA2m4/Bn2eMxrW49rP0bbBfzX5/qCmd0YiMIFNLzzsvAhc8R89UvqCTFz6QcBXc3BiUqu8Jhf0L+JmcuUyxWmLSx+h89gwNSjbJshbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZILHCO0c; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720657317; x=1752193317;
  h=date:from:to:cc:subject:message-id;
  bh=ytPy6dDVcZQFl1E6Q4tRaYBFrY8+7jK+TkFPC3Hr8h0=;
  b=ZILHCO0clwhTjvfyMQXaSJlek6sZvP82AlDP9xM4cWwUoMbkjkQkBUDg
   vTbteB9gubeeQrDSor1YTJISGB+KaE3XzGmJDetXh/V3A1BKOh3QRRvU8
   mDNkqY/sy1yeE+n6mGtGLmLD+QXOmt92whU//V1fscIB6n8WGxx7CXE8M
   ER4TUQPe7HKUC3vq7X6XtegOUg/9jrtIlkDSKQmu1NN9AVIvWNb4vbOi6
   BUpOqlGziU5q0VSsWQvGOQKlbOq6rJ2ZwKhrO7bpGLTO2VrmOVTtWkYx8
   dwsUhTdh4C66uz68947WeqGfWVuGePHvZCk20xmUevkYOo29V3ejrNItS
   g==;
X-CSE-ConnectionGUID: 9ktbN4YcRbCwZjkcMpYjsQ==
X-CSE-MsgGUID: pRrLRpULRnKTnFMFCicGvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29408459"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29408459"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:21:56 -0700
X-CSE-ConnectionGUID: A3b09pTITNGdfvnIHy4cwA==
X-CSE-MsgGUID: xXaCOKUZQ9+5HR9swI0Dfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53554667"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Jul 2024 17:21:55 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRhZI-000YVE-0n;
	Thu, 11 Jul 2024 00:21:52 +0000
Date: Thu, 11 Jul 2024 08:20:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 d9dcb950e926c4c27c599b7b906c8d1bb338b5ae
Message-ID: <202407110852.cN0dT5HC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: d9dcb950e926c4c27c599b7b906c8d1bb338b5ae  Merge branch 'pci/misc'

elapsed time: 1455m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240710   gcc-13.2.0
arc                   randconfig-002-20240710   gcc-13.2.0
arm                              allmodconfig   gcc-13.3.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.3.0
arm                   randconfig-001-20240710   clang-19
arm                   randconfig-002-20240710   gcc-13.3.0
arm                   randconfig-003-20240710   clang-19
arm                   randconfig-004-20240710   gcc-13.3.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240710   clang-19
arm64                 randconfig-002-20240710   clang-19
arm64                 randconfig-003-20240710   clang-17
arm64                 randconfig-004-20240710   gcc-13.2.0
csky                              allnoconfig   gcc-13.3.0
csky                  randconfig-001-20240710   gcc-13.3.0
csky                  randconfig-002-20240710   gcc-13.3.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240710   clang-19
hexagon               randconfig-002-20240710   clang-19
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240710   clang-18
i386         buildonly-randconfig-002-20240710   gcc-13
i386         buildonly-randconfig-003-20240710   gcc-11
i386         buildonly-randconfig-004-20240710   gcc-11
i386         buildonly-randconfig-005-20240710   clang-18
i386         buildonly-randconfig-006-20240710   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240710   clang-18
i386                  randconfig-002-20240710   gcc-11
i386                  randconfig-003-20240710   gcc-13
i386                  randconfig-004-20240710   clang-18
i386                  randconfig-005-20240710   clang-18
i386                  randconfig-006-20240710   clang-18
i386                  randconfig-011-20240710   gcc-13
i386                  randconfig-012-20240710   gcc-12
i386                  randconfig-013-20240710   gcc-12
i386                  randconfig-014-20240710   gcc-13
i386                  randconfig-015-20240710   gcc-8
i386                  randconfig-016-20240710   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.3.0
loongarch             randconfig-001-20240710   gcc-13.3.0
loongarch             randconfig-002-20240710   gcc-13.3.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.3.0
m68k                             allyesconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.3.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.3.0
nios2                 randconfig-001-20240710   gcc-13.3.0
nios2                 randconfig-002-20240710   gcc-13.3.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.3.0
parisc                           allmodconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.3.0
parisc                randconfig-001-20240710   gcc-13.3.0
parisc                randconfig-002-20240710   gcc-13.3.0
powerpc                          allmodconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240710   gcc-13.3.0
powerpc               randconfig-002-20240710   clang-19
powerpc               randconfig-003-20240710   gcc-13.3.0
powerpc64             randconfig-001-20240710   gcc-13.3.0
powerpc64             randconfig-002-20240710   clang-15
powerpc64             randconfig-003-20240710   clang-19
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                 randconfig-001-20240710   clang-19
riscv                 randconfig-002-20240710   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                  randconfig-001-20240710   gcc-13.2.0
s390                  randconfig-002-20240710   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.3.0
sh                               allyesconfig   gcc-13.2.0
sh                    randconfig-001-20240710   gcc-13.3.0
sh                    randconfig-002-20240710   gcc-13.3.0
sparc                            allmodconfig   gcc-13.2.0
sparc64               randconfig-001-20240710   gcc-13.3.0
sparc64               randconfig-002-20240710   gcc-13.3.0
um                                allnoconfig   clang-17
um                    randconfig-001-20240710   gcc-13
um                    randconfig-002-20240710   clang-19
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240710   clang-18
x86_64       buildonly-randconfig-002-20240710   clang-18
x86_64       buildonly-randconfig-003-20240710   clang-18
x86_64       buildonly-randconfig-004-20240710   clang-18
x86_64       buildonly-randconfig-005-20240710   gcc-13
x86_64       buildonly-randconfig-006-20240710   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240710   gcc-13
x86_64                randconfig-002-20240710   clang-18
x86_64                randconfig-003-20240710   gcc-12
x86_64                randconfig-004-20240710   clang-18
x86_64                randconfig-005-20240710   clang-18
x86_64                randconfig-006-20240710   gcc-13
x86_64                randconfig-011-20240710   clang-18
x86_64                randconfig-012-20240710   clang-18
x86_64                randconfig-013-20240710   clang-18
x86_64                randconfig-014-20240710   clang-18
x86_64                randconfig-015-20240710   clang-18
x86_64                randconfig-016-20240710   gcc-13
x86_64                randconfig-071-20240710   gcc-13
x86_64                randconfig-072-20240710   clang-18
x86_64                randconfig-073-20240710   clang-18
x86_64                randconfig-074-20240710   gcc-7
x86_64                randconfig-075-20240710   clang-18
x86_64                randconfig-076-20240710   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.3.0
xtensa                randconfig-001-20240710   gcc-13.3.0
xtensa                randconfig-002-20240710   gcc-13.3.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

