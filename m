Return-Path: <linux-pci+bounces-12871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2AD96E87C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84A61C22917
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 04:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74744779F;
	Fri,  6 Sep 2024 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIGQxwpx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C378481DD
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725595206; cv=none; b=gBUdmU07Ug3iSJHgXYs6nx5ukeky0jL5x8vehgyojfjoc4dQ0WwuKMdnWy5O4DR51R3MUneuHc7I9sckssqHjirGR6/QWJFiX4QEU1y1QBZOehLsWJKYXMtqoagiRQfbuLw0iZgArBW4JuZOGPqlVZG30ey5KEoVzmj9O+bhah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725595206; c=relaxed/simple;
	bh=bl9Qsseutw44/50tSrmdjkhhY8XNbIrtNhKb0tDGSnc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SDgB/iy9C5K5Y9ShyFq3Nb2K/X7mSvdiMbRQ0QauupRkuqOmOeEGeDk+CHo56u4wR5keVIYFD9UpVVlbX2dCsfrDGwoROqAHV4FUKJeBJUB/8CU7c5uJxO3tdbjvlqDOiuxCpLyqcvx7lydc4GB9v+lfkl/EGJedfVg4bHXK+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIGQxwpx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725595204; x=1757131204;
  h=date:from:to:cc:subject:message-id;
  bh=bl9Qsseutw44/50tSrmdjkhhY8XNbIrtNhKb0tDGSnc=;
  b=MIGQxwpxUXeOE0OOLYlaKF9XOLWf/Bk6SPQOuHtw7qTH0t3mx5+heIGl
   q+7uIHMHO7M/zX39926wcGst6eE228Ez7EWk14hPPjwcpDh2PcsvCwAmk
   A7uq0Uv9wTaoOWaDvleeFbRBczWQVKz+3cettkIwdqydt9M03B2MLfgGv
   lxfImiyDSznUbcZmhaox01UJo2TQI3bAjVCJjnfxfv/8wy+mwldvzH6Rh
   ybSziC0mWF6faZqPyOd+VVI0iVrt0pH+oLha+5hDA9ek5tniQCZpETcsu
   rPCy1pYVjCGHiyFVwjIk3UDQY9KEaa/wjy2C497UjqkoJqQ5dlTM2mfex
   Q==;
X-CSE-ConnectionGUID: 1upOwPpmTIqDU5YbaH35Xg==
X-CSE-MsgGUID: +tG2E5jKToC8iR5zQ7VCDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24539226"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="24539226"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 21:00:03 -0700
X-CSE-ConnectionGUID: O070hSIZSPWrWGPrEDqXjA==
X-CSE-MsgGUID: 3UazIF6JQd25ACoKRQLlOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="70631686"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Sep 2024 21:00:02 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smQ8d-000Aax-31;
	Fri, 06 Sep 2024 03:59:59 +0000
Date: Fri, 06 Sep 2024 11:59:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:npem] BUILD SUCCESS
 86490d228610361825bd2f8dee1e24cb6b61539f
Message-ID: <202409061109.SbvZ3CuM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git npem
branch HEAD: 86490d228610361825bd2f8dee1e24cb6b61539f  PCI/NPEM: Add _DSM PCIe SSD status LED management

elapsed time: 1719m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240905   clang-18
i386         buildonly-randconfig-001-20240906   gcc-12
i386         buildonly-randconfig-002-20240905   gcc-12
i386         buildonly-randconfig-002-20240906   gcc-12
i386         buildonly-randconfig-003-20240905   gcc-12
i386         buildonly-randconfig-003-20240906   gcc-12
i386         buildonly-randconfig-004-20240905   clang-18
i386         buildonly-randconfig-004-20240906   gcc-12
i386         buildonly-randconfig-005-20240905   clang-18
i386         buildonly-randconfig-005-20240906   gcc-12
i386         buildonly-randconfig-006-20240905   gcc-12
i386         buildonly-randconfig-006-20240906   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240905   gcc-12
i386                  randconfig-001-20240906   gcc-12
i386                  randconfig-002-20240905   clang-18
i386                  randconfig-002-20240906   gcc-12
i386                  randconfig-003-20240905   gcc-12
i386                  randconfig-003-20240906   gcc-12
i386                  randconfig-004-20240905   gcc-11
i386                  randconfig-004-20240906   gcc-12
i386                  randconfig-005-20240905   gcc-12
i386                  randconfig-005-20240906   gcc-12
i386                  randconfig-006-20240905   gcc-12
i386                  randconfig-006-20240906   gcc-12
i386                  randconfig-011-20240905   clang-18
i386                  randconfig-011-20240906   gcc-12
i386                  randconfig-012-20240905   clang-18
i386                  randconfig-012-20240906   gcc-12
i386                  randconfig-013-20240905   gcc-12
i386                  randconfig-013-20240906   gcc-12
i386                  randconfig-014-20240905   clang-18
i386                  randconfig-014-20240906   gcc-12
i386                  randconfig-015-20240905   clang-18
i386                  randconfig-015-20240906   gcc-12
i386                  randconfig-016-20240905   gcc-12
i386                  randconfig-016-20240906   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

