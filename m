Return-Path: <linux-pci+bounces-7092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEAD8BBDC2
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 20:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D94328208F
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8254122C;
	Sat,  4 May 2024 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyLvBlaA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B71E51E
	for <linux-pci@vger.kernel.org>; Sat,  4 May 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714848587; cv=none; b=jADMhuT+PSfKaXUkqFcVDBYxRvyAgTKb6Z4k/Ggmds1ra2pZll/ZlaKJ4wOX0FIvwO0Q8g87+AMVmpD8b2MI3gRd01CuLErwreehV+lOBtdjR6iWrAKJBcJH6hwkvCsH6Da72/2svANOjBhATEKfHmyMURs/oerRX+ebbbvPj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714848587; c=relaxed/simple;
	bh=nPD6UHWiN1VFWr4czNwp+OXZ45w2TWff/4KoKRaG8zM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XL653IEFA+8EFRKL1Merym+sKxdKfNJzXqcRS6bCS/ulfsv4SMclwda53UqQhemFXv/7YIa/haaWW8bMLH72Dk9XeVM2H1sX8vL4YXHbURv67CpiTzJhxj2lp4VF17/DftOwy2l6BPqdNpiF6yUlsVbm+50HJPHe99QhKF6o3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyLvBlaA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714848586; x=1746384586;
  h=date:from:to:cc:subject:message-id;
  bh=nPD6UHWiN1VFWr4czNwp+OXZ45w2TWff/4KoKRaG8zM=;
  b=PyLvBlaAFmVUEakFwUpBuf4bJtN7UacYeEbsNGRF8hc4o4YGWxy+RGn/
   ecHNcBaGiJk7+w+lO8ZaFAqdBOWq0T7QqXMsSSHczb2vvuiDkPhTxmoLd
   CzjiY1I4rpffS3EeJ41SDpaWmMj+oK/i/L1nEnOAgrGILyVaz7g6J7VGL
   Dyr11AoVtBH4i/+oJy5yF2eV566QhjTtDbICa0rqfPpsgY8Hg65kdcAQB
   6Z/M/fdS+35kPC5/aXXrPoghfOPClf2j4rB1XXMuOCASIj0U0LlB8ZDcY
   0XVaoiHM+A8F7y9jKQER4zlC4sCMtyCXzgaNOERzuBnEz/UFQ1tK0fsnr
   g==;
X-CSE-ConnectionGUID: sWHL0bqfTo+C+k7gWwPIbA==
X-CSE-MsgGUID: 5castmouR4GlEedNG8n4Nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28113335"
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="28113335"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 11:49:45 -0700
X-CSE-ConnectionGUID: gvkOsDhkTqi8JgEdcoF6kw==
X-CSE-MsgGUID: DG68/ik2Qn2FKAIshr/W/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="27724591"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 May 2024 11:49:45 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3KS6-000D52-1F;
	Sat, 04 May 2024 18:49:42 +0000
Date: Sun, 05 May 2024 02:49:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 784299512a847701ad7c240bed7d3d7a69459736
Message-ID: <202405050209.zATWJPAa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 784299512a847701ad7c240bed7d3d7a69459736  PCI: Relax bridge window tail sizing rules

elapsed time: 1456m

configs tested: 152
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240504   gcc  
arc                   randconfig-002-20240504   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240504   gcc  
arm64                 randconfig-002-20240504   gcc  
arm64                 randconfig-003-20240504   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240504   gcc  
csky                  randconfig-002-20240504   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240504   clang
i386         buildonly-randconfig-004-20240504   clang
i386         buildonly-randconfig-005-20240504   clang
i386         buildonly-randconfig-006-20240504   clang
i386                                defconfig   clang
i386                  randconfig-002-20240504   clang
i386                  randconfig-004-20240504   clang
i386                  randconfig-005-20240504   clang
i386                  randconfig-012-20240504   clang
i386                  randconfig-013-20240504   clang
i386                  randconfig-016-20240504   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240504   gcc  
loongarch             randconfig-002-20240504   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240504   gcc  
nios2                 randconfig-002-20240504   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240504   gcc  
parisc                randconfig-002-20240504   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240504   gcc  
powerpc               randconfig-002-20240504   gcc  
powerpc               randconfig-003-20240504   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240504   gcc  
riscv                 randconfig-002-20240504   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240504   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240504   gcc  
sh                    randconfig-002-20240504   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240504   gcc  
sparc64               randconfig-002-20240504   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240504   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240504   gcc  
x86_64       buildonly-randconfig-003-20240504   gcc  
x86_64       buildonly-randconfig-004-20240504   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-005-20240504   gcc  
x86_64                randconfig-011-20240504   gcc  
x86_64                randconfig-013-20240504   gcc  
x86_64                randconfig-015-20240504   gcc  
x86_64                randconfig-071-20240504   gcc  
x86_64                randconfig-073-20240504   gcc  
x86_64                randconfig-074-20240504   gcc  
x86_64                randconfig-076-20240504   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240504   gcc  
xtensa                randconfig-002-20240504   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

