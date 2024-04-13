Return-Path: <linux-pci+bounces-6216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5789B8A3DB1
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F52821EE
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E94C637;
	Sat, 13 Apr 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myLm0rHB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D26495FD
	for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713025418; cv=none; b=EsxGzgPPdNuHBfMJPOx5bTxow1CZBRyHulwQX0oGeupLgCzsmsqYzBZR/mtYw1EwzVFZsTFd7m+5jMth13nh/TsPhrw25L8Fx3t/2mM/7Im9h0EA8voNC8MHs5Bia4TVy6fBU9RW+0BVnglje0T43/DnBUgc3xIkV0KOGUQSNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713025418; c=relaxed/simple;
	bh=pBMs0o9qa+/9WEtQCtYDmN/6sp+EDNK5gBfxymPj+ME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EfzyFb3KWbODCRReEOP2Uiymysnh+qV+88O1Cs2bVGLz+3Z4YyNgc1E/C1+TDflHK8q6rgUUT3vBGDonJNk7ddozIqKanBDEJsQPLsgCw7whidNAk86DrT7kwSadJQK4Sxa5HPm6LVPlg2FquwBCBhNyWJCUPDT+NpjphjfCMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myLm0rHB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713025416; x=1744561416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pBMs0o9qa+/9WEtQCtYDmN/6sp+EDNK5gBfxymPj+ME=;
  b=myLm0rHBL3aU4P6X6jkXmMIuf4eWxjMeYgfwz81F6nO5qRsTZyNIvW7j
   xROoeD3k2/TwpCk8dRECxfwtDNkYeQ39cmOqJ3AvEN+FCLQlMHSUCnQK2
   qy5Mu3exTAlZmo8zGYtcwmGBi6+RAWipPIuB1Djhps/DJ5THpl3fep51x
   wCciESb7Dgyp/NXVUqy64YljwN+SFhIhIOsOblwSINBRnE1NDWGBsNRgh
   t2j4mx56u3X4ZStDBTmJ5LjlR4obOtXvQkI6m5s2qaTmuWPmgJwtfQyLi
   YimEMBEuYsq6ro2lv7dOW6eG9ftiTZ/BAuo3vvs7NgMzJpOiR7cyNGPDq
   Q==;
X-CSE-ConnectionGUID: Q9LhJmjiTRed01M7Yes64A==
X-CSE-MsgGUID: J2LiQVQ0Rtulsk++2p47WA==
X-IronPort-AV: E=McAfee;i="6600,9927,11043"; a="12245069"
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="12245069"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 09:23:36 -0700
X-CSE-ConnectionGUID: bqgIAxP/TAS3Iy9wsHamMg==
X-CSE-MsgGUID: CJj0c6TWSeGzkUvUZErTIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,199,1708416000"; 
   d="scan'208";a="22076838"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 13 Apr 2024 09:23:34 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvgA8-0002tW-18;
	Sat, 13 Apr 2024 16:23:32 +0000
Date: Sun, 14 Apr 2024 00:22:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 01fec70206d48891b76ee8a3a4bfbd331543c18a
Message-ID: <202404140041.1rJw2Q9E-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 01fec70206d48891b76ee8a3a4bfbd331543c18a  dt-bindings: PCI: ti,j721e-pci-host: Add support for J722S SoC

elapsed time: 1453m

configs tested: 124
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
arc                     nsimosci_hs_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240413   gcc  
i386         buildonly-randconfig-002-20240413   gcc  
i386         buildonly-randconfig-003-20240413   clang
i386         buildonly-randconfig-004-20240413   clang
i386         buildonly-randconfig-005-20240413   clang
i386         buildonly-randconfig-006-20240413   clang
i386                                defconfig   clang
i386                  randconfig-001-20240413   clang
i386                  randconfig-002-20240413   gcc  
i386                  randconfig-003-20240413   clang
i386                  randconfig-004-20240413   gcc  
i386                  randconfig-005-20240413   clang
i386                  randconfig-006-20240413   clang
i386                  randconfig-011-20240413   gcc  
i386                  randconfig-012-20240413   clang
i386                  randconfig-013-20240413   gcc  
i386                  randconfig-014-20240413   gcc  
i386                  randconfig-015-20240413   clang
i386                  randconfig-016-20240413   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

