Return-Path: <linux-pci+bounces-7197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F978BEE00
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9FF1C20B90
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 20:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F3187343;
	Tue,  7 May 2024 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2PV113C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A818733D
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113252; cv=none; b=Gn18Aj0mUHKh7t0Xwygp1GlE0BMbthJptH3r3NE0J/8RiO5cP2GyvbWR60A6EEBC6YIt5zDm7h3SAVC1XCTZ1JuYFDnWr6kYcFsQnSBrNLJPyET5ybypl1BZrDduucHcyJc+4GR3Cvie5Ic1BUItJyjseX2r/hS2PN5ZYzlcBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113252; c=relaxed/simple;
	bh=Q/hqWr+JtA3qWSFnBL1JwhSci0oCErMTEDiouWEeFBk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DPSwchYXu6oY0uzqIsPt5m6J/2nDha07Ox8sShe9Hilde4aHYAiUgMTP2oJR0tTCtQ0JJdtpFesAghHGt/098tKvEuXJk5GyeDk8YTzL/x+BluERIpCtzt/dmSenj9iV7DsNMQKZ35CT9LLt/abz2EY/IEAaQZHoo00qxJuK2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2PV113C; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715113250; x=1746649250;
  h=date:from:to:cc:subject:message-id;
  bh=Q/hqWr+JtA3qWSFnBL1JwhSci0oCErMTEDiouWEeFBk=;
  b=g2PV113CdbRkNWTXES4ceaNyjlVprTTrIY1uEpDv9F5jUw4C8Oddc0uV
   DJoM80suliSVDKauBVXahwjstwqHP0BOkknfkTzUI7Se4iyZsqaqQaE8r
   5BZv8eu9/0K2XMFAhS8Qequapy61Ic7I9EizvBxsvDHpcAOvsmE4sJXC+
   +UU67KbOPmZUKaU9YRTRNZnfgBSPSuJLiYIJERQI4aefjEj8mQFu1RgG0
   +bkhzgSGRMgc3wy+fsILoN1UhTz8/0ifSCcvhpRc+SLVexQdd73AogB6x
   FyvTmz8+G6EnM5BA0tTyggroK5Eick8gpQRV+OjeL31jBtL2N5Rm+reff
   A==;
X-CSE-ConnectionGUID: yBQRE5ymT5KsGvZjOFy8Mw==
X-CSE-MsgGUID: zHeV6OwwQ4KkY0Ae4uKwUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="36319241"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="36319241"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:20:50 -0700
X-CSE-ConnectionGUID: ImuUQr+qRSaiZFq36NBZHg==
X-CSE-MsgGUID: M/IOJJ6sTP2XOsrgE1z8Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29174303"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 May 2024 13:20:48 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4RIs-0002c5-1S;
	Tue, 07 May 2024 20:20:46 +0000
Date: Wed, 08 May 2024 04:20:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 f3d049b35b01fff656d720606fcbab0b819f26d1
Message-ID: <202405080426.Hf2hTLMr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: f3d049b35b01fff656d720606fcbab0b819f26d1  PCI/ASPM: Restore parent state to parent, child state to child

elapsed time: 1444m

configs tested: 157
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
arc                   randconfig-001-20240507   gcc  
arc                   randconfig-002-20240507   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                            qcom_defconfig   clang
arm                   randconfig-001-20240507   gcc  
arm                   randconfig-003-20240507   gcc  
arm                           sama7_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240507   gcc  
csky                  randconfig-002-20240507   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240507   clang
i386         buildonly-randconfig-002-20240507   clang
i386         buildonly-randconfig-003-20240507   clang
i386         buildonly-randconfig-006-20240507   clang
i386                                defconfig   clang
i386                  randconfig-001-20240507   clang
i386                  randconfig-003-20240507   clang
i386                  randconfig-004-20240507   clang
i386                  randconfig-005-20240507   clang
i386                  randconfig-006-20240507   clang
i386                  randconfig-012-20240507   clang
i386                  randconfig-013-20240507   clang
i386                  randconfig-016-20240507   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240507   gcc  
loongarch             randconfig-002-20240507   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        vocore2_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240507   gcc  
nios2                 randconfig-002-20240507   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240507   gcc  
parisc                randconfig-002-20240507   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       holly_defconfig   clang
powerpc                      makalu_defconfig   clang
powerpc               randconfig-001-20240507   gcc  
powerpc64             randconfig-001-20240507   gcc  
powerpc64             randconfig-002-20240507   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240507   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240507   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240507   gcc  
sh                    randconfig-002-20240507   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240507   gcc  
sparc64               randconfig-002-20240507   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240507   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240507   clang
x86_64       buildonly-randconfig-002-20240507   clang
x86_64       buildonly-randconfig-003-20240507   clang
x86_64       buildonly-randconfig-004-20240507   clang
x86_64       buildonly-randconfig-005-20240507   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240507   clang
x86_64                randconfig-003-20240507   clang
x86_64                randconfig-012-20240507   clang
x86_64                randconfig-013-20240507   clang
x86_64                randconfig-014-20240507   clang
x86_64                randconfig-015-20240507   clang
x86_64                randconfig-016-20240507   clang
x86_64                randconfig-073-20240507   clang
x86_64                randconfig-074-20240507   clang
x86_64                randconfig-075-20240507   clang
x86_64                randconfig-076-20240507   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240507   gcc  
xtensa                randconfig-002-20240507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

