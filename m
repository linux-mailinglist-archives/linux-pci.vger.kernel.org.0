Return-Path: <linux-pci+bounces-8014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B98D34EE
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 12:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8101C21CC5
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D416EBEF;
	Wed, 29 May 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5iV+CG/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F317B4E2
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979936; cv=none; b=YTrDE7Flh2xKnm24YMSUyHHgAvfilu59bLGUngLHAxOYlpS0HwN3F4FEV69WIRUETNkqYqVEvEhvtcoYu1hyzAmsK3TYm2YCZ99LGrgoDyHRYuG6fIKF4QUgSqvRAyzi5/yIEKzlK4FXdspbEONjyRbs5bn/79i+bNDyk1nGAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979936; c=relaxed/simple;
	bh=8U9EFoWPMAjSvLcOi00NFkCP+Doe5Gt86DX5M0YP/hA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nDQLrhaDU4fkKuATIpUYTHFS0AfYSvuUxlMTy+ads/TT6K470mmiiMlRNUN76YxtBwys22T+0SaYx7XfR+JYI0mrhXVAtJ1te6qZEeZMI5HXnFc4pndhj79B7sKRBurOptTaO6ZCc45yMT27lF1lno71IxsK7NPPuqK9STEJOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5iV+CG/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716979935; x=1748515935;
  h=date:from:to:cc:subject:message-id;
  bh=8U9EFoWPMAjSvLcOi00NFkCP+Doe5Gt86DX5M0YP/hA=;
  b=R5iV+CG/AVyQwwK3CFQuoP0mvUehavPCmkdyqQNbdeR47Ci469ZPQQRj
   5U0UfMgalZ2pzvM+gOjRNCnEtisA2l41814Vx7uEbMuJcXjcRF0HZqXNO
   z/+xrk9STCdarulYPYOQqBFlWNaetyDeQp/ITHzL/WmI6rVbSsdL2Jd0z
   7isKOfYZBKLLEgVzdQXnjMMsoUE2fpMZCzRruRHC+ixqqUrQ9LFnCy4bF
   Dnc73T4QpOyIO4BTiNRSiYfLp0uYpa7ChjknAIkbJaC9ZLdveBZ7KtAOE
   YQPYTexmY+skxah6j9xmKwK1uenwK4VLNPXzJqwp2bV/zkGmcFWAeZVqj
   A==;
X-CSE-ConnectionGUID: BAIe6v+DSiGSJzmng9vX8A==
X-CSE-MsgGUID: m7eoys1JTIuxbvv2DyNgRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24789983"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24789983"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 03:52:14 -0700
X-CSE-ConnectionGUID: bEN4hkW9TSa16ox7seox6g==
X-CSE-MsgGUID: Cn0OLChCQ5uZAwqyQYrnGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="40391543"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 29 May 2024 03:52:13 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCGuh-000DWe-07;
	Wed, 29 May 2024 10:52:11 +0000
Date: Wed, 29 May 2024 18:52:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rcar] BUILD SUCCESS
 c93637e6a4c4e1d0e85ef7efac78d066bbb24d96
Message-ID: <202405291800.onG4G6t2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar
branch HEAD: c93637e6a4c4e1d0e85ef7efac78d066bbb24d96  PCI: rcar: Demote WARN() to dev_warn_ratelimited() in rcar_pcie_wakeup()

elapsed time: 1070m

configs tested: 149
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
arc                   randconfig-001-20240529   gcc  
arc                   randconfig-002-20240529   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240529   gcc  
arm                   randconfig-002-20240529   gcc  
arm                   randconfig-003-20240529   gcc  
arm                   randconfig-004-20240529   gcc  
arm                           sama7_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-003-20240529   gcc  
arm64                 randconfig-004-20240529   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240529   gcc  
csky                  randconfig-002-20240529   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240529   clang
i386         buildonly-randconfig-002-20240529   gcc  
i386         buildonly-randconfig-003-20240529   gcc  
i386         buildonly-randconfig-004-20240529   clang
i386         buildonly-randconfig-005-20240529   gcc  
i386         buildonly-randconfig-006-20240529   clang
i386                                defconfig   clang
i386                  randconfig-001-20240529   clang
i386                  randconfig-002-20240529   gcc  
i386                  randconfig-003-20240529   gcc  
i386                  randconfig-004-20240529   gcc  
i386                  randconfig-005-20240529   clang
i386                  randconfig-006-20240529   clang
i386                  randconfig-011-20240529   clang
i386                  randconfig-012-20240529   clang
i386                  randconfig-013-20240529   clang
i386                  randconfig-014-20240529   gcc  
i386                  randconfig-015-20240529   clang
i386                  randconfig-016-20240529   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240529   gcc  
loongarch             randconfig-002-20240529   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240529   gcc  
nios2                 randconfig-002-20240529   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240529   gcc  
parisc                randconfig-002-20240529   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc                       ppc64_defconfig   clang
powerpc64             randconfig-001-20240529   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240529   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240529   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240529   gcc  
sh                    randconfig-002-20240529   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240529   gcc  
sparc64               randconfig-002-20240529   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240529   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240529   clang
x86_64       buildonly-randconfig-003-20240529   clang
x86_64       buildonly-randconfig-005-20240529   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240529   clang
x86_64                randconfig-003-20240529   clang
x86_64                randconfig-004-20240529   clang
x86_64                randconfig-013-20240529   clang
x86_64                randconfig-016-20240529   clang
x86_64                randconfig-071-20240529   clang
x86_64                randconfig-074-20240529   clang
x86_64                randconfig-075-20240529   clang
x86_64                randconfig-076-20240529   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240529   gcc  
xtensa                randconfig-002-20240529   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

