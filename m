Return-Path: <linux-pci+bounces-7758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FE88CC4F4
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD521C21D3A
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B214198A;
	Wed, 22 May 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AM+SiwmC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39121411FF
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395833; cv=none; b=mhASgt9r0SRg/o5AqeoG060B1h0qHSZuEZMaRWI3+/aIMoW1KFNFgIgKMINL+n9fZSjBx/jyAld9R17wi+URnGWvHYxpopmDQxctjA6MN2P1mooBn797jRI3cTZ7sFalQaCQCLQBMqOqeHQCIirznydumt6AJODovKamI9KmkoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395833; c=relaxed/simple;
	bh=G+ulFsFE4esmVJPl1WlL8q7EVXNU54gkjuGGikAPeB8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oYbSbj0DOsN/q/R75hrEadL4vebDTbdpcsi8iOlYuC07LC3Sl5tUQafvYa73cDSnpNfCrbo4fNEbXwMixZIHnTCSVR8Yos5dFNbCEfxicG5BpNLqTpE06tHb1txXTDOYVVpfCs6dcGzrLVhXLyw+nG+W1BcH3zV8+Wke0OazrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AM+SiwmC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716395831; x=1747931831;
  h=date:from:to:cc:subject:message-id;
  bh=G+ulFsFE4esmVJPl1WlL8q7EVXNU54gkjuGGikAPeB8=;
  b=AM+SiwmCVOeztAEdR2+dnc/ZQVqF346VrEitfStstUc7erMLnyPkGDX7
   YzSPGzR4Ms7yMn1W7x1uwg1ZkIIuKJFz9IOVEPSgOlISJAayDMkwlbe0+
   6dPF6VwO/mxeYrRTNHY347f5fpufKCCkQfaLRM3pIiJ0diGOiU/Jg1KIx
   ibSWBo1AK8eGluhwIistjuo/hUi8Zd2rOxFBh+IziEMq3tSto8ts3zF0H
   QZ5CSTf+3Xqrk5DMLkAbkYlDuocI7rU0JGJnWcgs3/7rbFTRh/7KnDRJf
   FtCNrtRN8GQ/US2lcZHTtCA39ggFmfwiwMO3pFyU5/ABmgEDfDyockyLv
   w==;
X-CSE-ConnectionGUID: 1k2I6DOITeW86oNLa+dOxA==
X-CSE-MsgGUID: ggS9xpP1QzShnEySudmb+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12780185"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12780185"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 09:37:10 -0700
X-CSE-ConnectionGUID: OFUCllYeRDqx4V681o4eRw==
X-CSE-MsgGUID: pGCU8fzfSzqfqDmTOEuldg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33472524"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 22 May 2024 09:37:09 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9oxf-0001kw-02;
	Wed, 22 May 2024 16:37:07 +0000
Date: Thu, 23 May 2024 00:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:defer/acs] BUILD SUCCESS
 c9380b3253bd492ec3dfd4e3b6b4453223270f25
Message-ID: <202405230029.SCtBtfwe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git defer/acs
branch HEAD: c9380b3253bd492ec3dfd4e3b6b4453223270f25  PCI: Add ACS quirk for Broadcom BCM5760X NIC

elapsed time: 1194m

configs tested: 150
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
arc                   randconfig-001-20240522   gcc  
arc                   randconfig-002-20240522   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240522   clang
arm                   randconfig-002-20240522   gcc  
arm                   randconfig-003-20240522   clang
arm                   randconfig-004-20240522   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240522   clang
arm64                 randconfig-002-20240522   clang
arm64                 randconfig-003-20240522   gcc  
arm64                 randconfig-004-20240522   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240522   gcc  
csky                  randconfig-002-20240522   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240522   clang
hexagon               randconfig-002-20240522   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240522   clang
i386         buildonly-randconfig-002-20240522   clang
i386         buildonly-randconfig-003-20240522   gcc  
i386         buildonly-randconfig-004-20240522   clang
i386         buildonly-randconfig-005-20240522   clang
i386         buildonly-randconfig-006-20240522   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240522   clang
i386                  randconfig-002-20240522   clang
i386                  randconfig-003-20240522   clang
i386                  randconfig-004-20240522   clang
i386                  randconfig-005-20240522   clang
i386                  randconfig-006-20240522   clang
i386                  randconfig-011-20240522   clang
i386                  randconfig-012-20240522   gcc  
i386                  randconfig-013-20240522   gcc  
i386                  randconfig-014-20240522   gcc  
i386                  randconfig-015-20240522   gcc  
i386                  randconfig-016-20240522   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240522   gcc  
loongarch             randconfig-002-20240522   gcc  
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
nios2                 randconfig-001-20240522   gcc  
nios2                 randconfig-002-20240522   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240522   gcc  
parisc                randconfig-002-20240522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240522   gcc  
powerpc               randconfig-002-20240522   gcc  
powerpc               randconfig-003-20240522   clang
powerpc64             randconfig-001-20240522   clang
powerpc64             randconfig-002-20240522   clang
powerpc64             randconfig-003-20240522   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240522   gcc  
riscv                 randconfig-002-20240522   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240522   clang
s390                  randconfig-002-20240522   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240522   gcc  
sh                    randconfig-002-20240522   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240522   clang
x86_64       buildonly-randconfig-002-20240522   gcc  
x86_64       buildonly-randconfig-003-20240522   clang
x86_64       buildonly-randconfig-004-20240522   gcc  
x86_64       buildonly-randconfig-005-20240522   clang
x86_64       buildonly-randconfig-006-20240522   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240522   gcc  
x86_64                randconfig-002-20240522   clang
x86_64                randconfig-003-20240522   gcc  
x86_64                randconfig-004-20240522   gcc  
x86_64                randconfig-005-20240522   gcc  
x86_64                randconfig-006-20240522   clang
x86_64                randconfig-011-20240522   gcc  
x86_64                randconfig-012-20240522   clang
x86_64                randconfig-013-20240522   gcc  
x86_64                randconfig-014-20240522   clang
x86_64                randconfig-015-20240522   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

