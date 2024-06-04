Return-Path: <linux-pci+bounces-8270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F68FBF90
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C43B27552
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 23:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293B14D42C;
	Tue,  4 Jun 2024 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSm98BHz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E47143872
	for <linux-pci@vger.kernel.org>; Tue,  4 Jun 2024 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542329; cv=none; b=iwwttXFPeDEtPd8uNgydawBE6aUmqajwueeBnIMpHcyvyTiICBqjsN6LI05O4sQJtnHTAMWaEMD7y45Sus+00WW+jyO8UdB1iql7EOXsbTClMDFI4KY7mgeLQn+ARN2uzWv/ZVtM9IrWOdAXAnDdHOjRhXQ2HyK2VAx0DJKaIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542329; c=relaxed/simple;
	bh=arjeDdS+2W9Bza0++P0LrRQ4y6a/khuLIwZuMy6OByY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vxdk96+a+Lb2iG3kokYVS+4TK0WYzdW8j3NF+JIgzXh8dJ7s1nxpaZPYlUGnAHO5Llf/hLUNWMESakkbE1qFATn4fVvT1mJ1ixjtosH5YVW3J0OJkzNWZkYUxLW9bsZ2xUBPnvOoZzu7r3xxiybrf5rKQpo9pEEDlucnsxZNoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSm98BHz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717542327; x=1749078327;
  h=date:from:to:cc:subject:message-id;
  bh=arjeDdS+2W9Bza0++P0LrRQ4y6a/khuLIwZuMy6OByY=;
  b=MSm98BHz4ld4+kLBD8D3bLjQD9t5+8actn7cKEAktbX582Oc/HqBfufQ
   bXcmU/WyWqErOQmUAj7THyZhNQa67YnaNB2t+oRf83/lwF34IXepF8ilD
   ul/4nb6pDNzDEAS50VkcW6jRIF0xkRil58ThSteWw5d2buFZ9sJIhSMyf
   bP2urhJzNs7uLCcKgEE3IDgHDpDBFDJJANMHLFKlBNgrn8W3R0eJMphrE
   0yyWpid6Mw36BvIm3w1xVkECR3LisWGUShPcG3zfzuUqh79OGGxcNmYpa
   p+N586OUnIxOTEC/5ebKR9/yLPDlx7S7pcNJMizb8gq15ZJ1XOK+MpyDV
   g==;
X-CSE-ConnectionGUID: 5tCgHRXtS7a+QHmS3GjtBA==
X-CSE-MsgGUID: Of7RwFn1SyWhmkNk46tdDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24751128"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="24751128"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:05:27 -0700
X-CSE-ConnectionGUID: IKp0O+b9T9GSvjDqIeRlqg==
X-CSE-MsgGUID: u9MkRY9dTGGmZFlrrXfuTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37959602"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Jun 2024 16:05:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEdDX-0000eB-0W;
	Tue, 04 Jun 2024 23:05:23 +0000
Date: Wed, 05 Jun 2024 07:05:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 7246a4520b4bf1494d7d030166a11b5226f6d508
Message-ID: <202406050710.Vg9FPcmc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 7246a4520b4bf1494d7d030166a11b5226f6d508  PCI: Use preserve_config in place of pci_flags

elapsed time: 1481m

configs tested: 193
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240604   gcc  
arc                   randconfig-001-20240605   gcc  
arc                   randconfig-002-20240604   gcc  
arc                   randconfig-002-20240605   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-002-20240604   gcc  
arm                   randconfig-004-20240604   gcc  
arm                   randconfig-004-20240605   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240605   gcc  
arm64                 randconfig-002-20240604   gcc  
arm64                 randconfig-003-20240604   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240604   gcc  
csky                  randconfig-001-20240605   gcc  
csky                  randconfig-002-20240604   gcc  
csky                  randconfig-002-20240605   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240604   clang
i386         buildonly-randconfig-003-20240604   clang
i386         buildonly-randconfig-005-20240604   clang
i386         buildonly-randconfig-006-20240604   clang
i386                                defconfig   clang
i386                  randconfig-001-20240604   clang
i386                  randconfig-002-20240604   clang
i386                  randconfig-003-20240604   clang
i386                  randconfig-004-20240604   clang
i386                  randconfig-011-20240604   clang
i386                  randconfig-014-20240604   clang
i386                  randconfig-015-20240604   clang
i386                  randconfig-016-20240604   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240604   gcc  
loongarch             randconfig-001-20240605   gcc  
loongarch             randconfig-002-20240604   gcc  
loongarch             randconfig-002-20240605   gcc  
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
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240604   gcc  
nios2                 randconfig-001-20240605   gcc  
nios2                 randconfig-002-20240604   gcc  
nios2                 randconfig-002-20240605   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240604   gcc  
parisc                randconfig-001-20240605   gcc  
parisc                randconfig-002-20240604   gcc  
parisc                randconfig-002-20240605   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240604   gcc  
powerpc               randconfig-001-20240605   gcc  
powerpc               randconfig-002-20240604   gcc  
powerpc               randconfig-002-20240605   gcc  
powerpc               randconfig-003-20240604   gcc  
powerpc               randconfig-003-20240605   gcc  
powerpc64             randconfig-001-20240604   gcc  
powerpc64             randconfig-001-20240605   gcc  
powerpc64             randconfig-002-20240604   gcc  
powerpc64             randconfig-003-20240605   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240605   gcc  
riscv                 randconfig-002-20240604   gcc  
riscv                 randconfig-002-20240605   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240605   gcc  
s390                  randconfig-002-20240604   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240604   gcc  
sh                    randconfig-001-20240605   gcc  
sh                    randconfig-002-20240604   gcc  
sh                    randconfig-002-20240605   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240604   gcc  
sparc64               randconfig-001-20240605   gcc  
sparc64               randconfig-002-20240604   gcc  
sparc64               randconfig-002-20240605   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240605   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240604   clang
x86_64       buildonly-randconfig-001-20240605   gcc  
x86_64       buildonly-randconfig-002-20240604   clang
x86_64       buildonly-randconfig-002-20240605   gcc  
x86_64       buildonly-randconfig-003-20240605   gcc  
x86_64       buildonly-randconfig-004-20240604   clang
x86_64       buildonly-randconfig-006-20240604   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240604   clang
x86_64                randconfig-003-20240605   gcc  
x86_64                randconfig-006-20240605   gcc  
x86_64                randconfig-011-20240604   clang
x86_64                randconfig-012-20240604   clang
x86_64                randconfig-012-20240605   gcc  
x86_64                randconfig-013-20240604   clang
x86_64                randconfig-014-20240604   clang
x86_64                randconfig-014-20240605   gcc  
x86_64                randconfig-015-20240604   clang
x86_64                randconfig-016-20240604   clang
x86_64                randconfig-016-20240605   gcc  
x86_64                randconfig-071-20240604   clang
x86_64                randconfig-071-20240605   gcc  
x86_64                randconfig-073-20240605   gcc  
x86_64                randconfig-074-20240604   clang
x86_64                randconfig-074-20240605   gcc  
x86_64                randconfig-075-20240604   clang
x86_64                randconfig-075-20240605   gcc  
x86_64                randconfig-076-20240604   clang
x86_64                randconfig-076-20240605   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240604   gcc  
xtensa                randconfig-001-20240605   gcc  
xtensa                randconfig-002-20240604   gcc  
xtensa                randconfig-002-20240605   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

