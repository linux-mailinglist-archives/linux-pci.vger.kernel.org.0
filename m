Return-Path: <linux-pci+bounces-7061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D27F8BB68C
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 00:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43ABB224F1
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167A64CDE0;
	Fri,  3 May 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDtN2NNm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA233398A
	for <linux-pci@vger.kernel.org>; Fri,  3 May 2024 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773604; cv=none; b=jkWkf+t3TtcN52gqZC79rUdVhqwdlqkHlmmYPazP2ZGVq6lXH9ZeuRoCQe8qSdK91M1WbG5pxKjoKNt29jz0DySqCJjrvzzinxUMMzbS760kTC1A7iV4jzLNLeX0J2k/VwRvMMWRdJfBrVZowHO2SH6iK5nW8c+PO01LVDbxWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773604; c=relaxed/simple;
	bh=H1nlTPd4Kwta8q1HnWQF8LcgmtOTzLbTvXdZYk4q65s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pcwd0WVqVTgBFPtS7hdIOj+cSlgm8jdKgyH7YaADElnRgCsD9HUaMUBiKVDtD3Uj/oxTX9A0L18/cqvDz2idKzprRriUcUlEX+IaJ7XPYlEec3eA1oJfc8B1oKqFdDddq+upJ624etbtn0vmm2TdtU8JpwS64PQgQbqEY7DyBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDtN2NNm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714773602; x=1746309602;
  h=date:from:to:cc:subject:message-id;
  bh=H1nlTPd4Kwta8q1HnWQF8LcgmtOTzLbTvXdZYk4q65s=;
  b=UDtN2NNmaK3sQb5FKj7Lbp3MalczDH7ZYZNhDI8Tp3k1K289zVBan10W
   aCy1DK9HdyP1stgYvHhJLje5G0Iz0xVHsRrybwIZySOUAGcfgUQKuc1eJ
   yQmezoHyLn8+Hi3wQL4Vw7eJshfd516jzoJpKy/14Wo2YEa3UxjtOEon1
   SE0fDUGlaExkXZgOnc3MHzp5THW9LXkGr4EKl1OL0q5zXwHWFsUEdCQoC
   1H2nkGrn4lwbLfY2OpeK6u564JaLJRBn/PVl68dBnrrSGMGKWpLO8npdQ
   s/vAJvwJZ4jBvanaUt7npgiZW+h+g/tDYC/IAiA7CJgtyxQPpLj5Sn7zB
   g==;
X-CSE-ConnectionGUID: qpaqMz0uSP2McTA4XFPF5g==
X-CSE-MsgGUID: zn6m+zhiQCqKxoiHo2Re4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28128293"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28128293"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 15:00:02 -0700
X-CSE-ConnectionGUID: RdSmEOwrROWgraBSpLn+Zw==
X-CSE-MsgGUID: Tp4ISScCSuagNgrqUsxsaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27662667"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 03 May 2024 15:00:00 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s30wg-000C8L-0K;
	Fri, 03 May 2024 21:59:58 +0000
Date: Sat, 04 May 2024 05:59:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 27ea83c5fbf97fd451fe3d8a5840ea98f224f1d2
Message-ID: <202405040536.hnfcnais-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 27ea83c5fbf97fd451fe3d8a5840ea98f224f1d2  x86/pci: Skip early E820 check for ECAM region

elapsed time: 1451m

configs tested: 166
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
arc                   randconfig-001-20240503   gcc  
arc                   randconfig-002-20240503   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240503   clang
arm                   randconfig-002-20240503   clang
arm                   randconfig-003-20240503   clang
arm                   randconfig-004-20240503   gcc  
arm                           sama7_defconfig   clang
arm                        vexpress_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240503   clang
arm64                 randconfig-002-20240503   gcc  
arm64                 randconfig-003-20240503   clang
arm64                 randconfig-004-20240503   clang
csky                             alldefconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240503   gcc  
csky                  randconfig-002-20240503   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240503   clang
hexagon               randconfig-002-20240503   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240503   clang
i386         buildonly-randconfig-002-20240503   clang
i386         buildonly-randconfig-003-20240503   gcc  
i386         buildonly-randconfig-004-20240503   gcc  
i386         buildonly-randconfig-005-20240503   gcc  
i386         buildonly-randconfig-006-20240503   clang
i386                                defconfig   clang
i386                  randconfig-001-20240503   gcc  
i386                  randconfig-002-20240503   clang
i386                  randconfig-003-20240503   clang
i386                  randconfig-004-20240503   gcc  
i386                  randconfig-005-20240503   clang
i386                  randconfig-006-20240503   clang
i386                  randconfig-011-20240503   clang
i386                  randconfig-012-20240503   gcc  
i386                  randconfig-013-20240503   gcc  
i386                  randconfig-014-20240503   gcc  
i386                  randconfig-015-20240503   gcc  
i386                  randconfig-016-20240503   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240503   gcc  
loongarch             randconfig-002-20240503   gcc  
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
mips                        bcm47xx_defconfig   clang
mips                     decstation_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240503   gcc  
nios2                 randconfig-002-20240503   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240503   gcc  
parisc                randconfig-002-20240503   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                        icon_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc                       ppc64_defconfig   clang
powerpc               randconfig-001-20240503   clang
powerpc               randconfig-002-20240503   clang
powerpc               randconfig-003-20240503   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240503   clang
powerpc64             randconfig-002-20240503   clang
powerpc64             randconfig-003-20240503   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240503   gcc  
riscv                 randconfig-002-20240503   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240503   gcc  
s390                  randconfig-002-20240503   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240503   gcc  
sh                    randconfig-002-20240503   gcc  
sh                          rsk7269_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240503   gcc  
sparc64               randconfig-002-20240503   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240503   clang
um                    randconfig-002-20240503   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240504   gcc  
x86_64       buildonly-randconfig-002-20240504   clang
x86_64       buildonly-randconfig-003-20240504   gcc  
x86_64       buildonly-randconfig-004-20240504   gcc  
x86_64       buildonly-randconfig-005-20240504   clang
x86_64       buildonly-randconfig-006-20240504   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240504   clang
x86_64                randconfig-002-20240504   clang
x86_64                randconfig-003-20240504   clang
x86_64                randconfig-004-20240504   clang
x86_64                randconfig-005-20240504   gcc  
x86_64                randconfig-006-20240504   clang
x86_64                randconfig-011-20240504   gcc  
x86_64                randconfig-012-20240504   clang
x86_64                randconfig-013-20240504   gcc  
x86_64                randconfig-014-20240504   clang
x86_64                randconfig-015-20240504   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240503   gcc  
xtensa                randconfig-002-20240503   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

