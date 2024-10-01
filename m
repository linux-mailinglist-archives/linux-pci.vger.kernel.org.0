Return-Path: <linux-pci+bounces-13686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF4098BFC1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B48280049
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046A1C7B71;
	Tue,  1 Oct 2024 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+gly9Oq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A301C7B76
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792423; cv=none; b=LpkhQ3zmtq/Y4lSf4fIH57FkNqOP5pB/BZhz8tqWeEyXobzGtQ7zXmWrdW9Kp2LtvWLrHNuWLarAtVsrwOltkPbXBVwfp07LcH08nd0/PUrZxGeKseD2/2gh+3XC4/9SwCrfilXaW+2Exn7sGfOVcgkH9MgywwWJV98DEXITc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792423; c=relaxed/simple;
	bh=K1JQUj7u78a74eQ5EQ9rtEFURE0/toi0yWfpYDQ0++c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E+Ws1kgka+Edr4LIo/dUL8EAS9/8PMk5fjHiKenH2ppeLUL1V1t4MdXPkV9ue4EQJNxZ8M9FMDqtwzv+GWEvkgFTG95IK28sKphJa54VE+q0PvbJ061w1buD07W/PXlUbKVX+5l+y9JKdwUtKCxc21x1/aErhf6SYg5QViC/lvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+gly9Oq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727792421; x=1759328421;
  h=date:from:to:cc:subject:message-id;
  bh=K1JQUj7u78a74eQ5EQ9rtEFURE0/toi0yWfpYDQ0++c=;
  b=G+gly9Oq+0Ub568v6wGLErDHYyAoA3FCr5KCiVjvz5p188QljBK+4Vzc
   w2flq6yN+3JBF8+5/jXEJ3m4EzZfdxV4pcanjsj3KLQnJ5U7ucy/IMt1/
   VluVKFwjJydxQ+tNA59NZUn3z+T8N8AqtWFCdy3TVoaf1w5++ayD7tv8k
   rGsVEYWUrfmRv9ZQa9m/8LP4dMYGZLLFuF2UDIiWO7Vc45xushyxjXk8n
   w7ElrQTz8HtRWMSacW/fVRpdgvKhDkzU0MJETmtXKUrIAjf2OKy7y/NrR
   cDo+tznruKzIjcOGS/6O/stb23XQB5EybYgfOPVQClmpKTDABXaA9iQ+3
   Q==;
X-CSE-ConnectionGUID: +yOp4GPcSqWkGoDhLRwPkQ==
X-CSE-MsgGUID: l7m7UMfPTBGrc6BuITtisA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37524195"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37524195"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 07:20:20 -0700
X-CSE-ConnectionGUID: Jay5gpn3TNypO38puKyPxw==
X-CSE-MsgGUID: MG1mriDDTbqM8EiISI4m8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="77725235"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 01 Oct 2024 07:20:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svdjd-000Qlp-2V;
	Tue, 01 Oct 2024 14:20:17 +0000
Date: Tue, 01 Oct 2024 22:19:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:misc] BUILD SUCCESS
 43ee11adcb940204948ac0ca3a05d6178f0e8b08
Message-ID: <202410012243.qhO8jsFq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git misc
branch HEAD: 43ee11adcb940204948ac0ca3a05d6178f0e8b08  PCI: hotplug: Remove "Returns" kerneldoc from void functions

elapsed time: 1229m

configs tested: 150
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              alldefconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                              allyesconfig    clang-20
arm                          collie_defconfig    gcc-14.1.0
arm                     davinci_all_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                         lpc18xx_defconfig    gcc-14.1.0
arm                       omap2plus_defconfig    clang-20
arm                       versatile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241001    clang-18
i386        buildonly-randconfig-002-20241001    clang-18
i386        buildonly-randconfig-002-20241001    gcc-12
i386        buildonly-randconfig-003-20241001    clang-18
i386        buildonly-randconfig-004-20241001    clang-18
i386        buildonly-randconfig-004-20241001    gcc-12
i386        buildonly-randconfig-005-20241001    clang-18
i386        buildonly-randconfig-006-20241001    clang-18
i386        buildonly-randconfig-006-20241001    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241001    clang-18
i386                  randconfig-001-20241001    gcc-12
i386                  randconfig-002-20241001    clang-18
i386                  randconfig-003-20241001    clang-18
i386                  randconfig-004-20241001    clang-18
i386                  randconfig-004-20241001    gcc-12
i386                  randconfig-005-20241001    clang-18
i386                  randconfig-006-20241001    clang-18
i386                  randconfig-011-20241001    clang-18
i386                  randconfig-011-20241001    gcc-12
i386                  randconfig-012-20241001    clang-18
i386                  randconfig-012-20241001    gcc-12
i386                  randconfig-013-20241001    clang-18
i386                  randconfig-013-20241001    gcc-12
i386                  randconfig-014-20241001    clang-18
i386                  randconfig-014-20241001    gcc-11
i386                  randconfig-015-20241001    clang-18
i386                  randconfig-015-20241001    gcc-12
i386                  randconfig-016-20241001    clang-18
i386                  randconfig-016-20241001    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    clang-20
m68k                        mvme147_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         cobalt_defconfig    clang-20
mips                         db1xxx_defconfig    gcc-14.1.0
mips                 decstation_r4k_defconfig    clang-20
mips                           ip30_defconfig    clang-20
mips                      loongson3_defconfig    clang-20
mips                        qi_lb60_defconfig    clang-20
mips                          rb532_defconfig    clang-20
mips                           rs90_defconfig    gcc-14.1.0
mips                   sb1250_swarm_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    gcc-14.1.0
powerpc                        cell_defconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                         wii_defconfig    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               alldefconfig    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                            hp6xx_defconfig    clang-20
sh                            migor_defconfig    clang-20
sh                          rsk7201_defconfig    clang-20
sh                            titan_defconfig    gcc-14.1.0
sh                              ul2_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

