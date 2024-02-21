Return-Path: <linux-pci+bounces-3810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C099B85D58B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 11:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4C7B23166
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D23EA72;
	Wed, 21 Feb 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tn2MNKMQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A543F8C0
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511410; cv=none; b=GKrKaSLXJTXbRHcqH68XqGR1maRGt0LxVISXDbRtWtrJknNaq+QIBqYmb/GGgewml0mYjBrg+rBJTHXWecnWteg65lfYlUzYQqI8m64qItNi9fpJ4aSa/qYcIt2jjCbtkuFVoOIZNSii+/Jh0q9m+lxkA2SLNxCwnncVxSxLAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511410; c=relaxed/simple;
	bh=mfxjS3lmS0Ef6oKbRqNnfuDepLEn8DVQVP0kc65e5Uo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XKBl+UyHEBfkCh4ON++H1+0xAEqDkjFaS1bgBEmnwINZ06c/AygiTlBW9gWgArRJw8KvPRIW25qpBenYgtrk/9XkqpAeoHx5yrlEFagv1pFqYOybvm858SCyILKEkitOcplkNY7Jjgpa5dBVDREHKxBBMA4jYiR64LM5EV7UZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tn2MNKMQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708511408; x=1740047408;
  h=date:from:to:cc:subject:message-id;
  bh=mfxjS3lmS0Ef6oKbRqNnfuDepLEn8DVQVP0kc65e5Uo=;
  b=Tn2MNKMQPKQB4WNJNpygcy6yJFRi0XvyJfEosnM7ME/ijFC+p8hOcdvD
   72GKni9NE5kmW5OvYNgardzGBLnKEplVinxkG2c7UaSvdmKlpOgYRJlZH
   OafFoxlYVH7cEOk9TB2mwHRuTgitUJhvGU1Vyshb53g7qEJrC0kgS9vzn
   WeOHzwxRtfjG/8/klvlIkyEbNlsU36lxWAxDjohGb/AKohnWEuGwSDs2C
   UiypyvcHRPv+o45v8PlGWnRwq+nBwHA9NX2ge5FVnS8x3r3zFiV8CAA4f
   ECPmPr8jqxPTab4INtInIK/789xvLwDPMkW61D7zZB01EQUQDu4W8cneM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2525148"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2525148"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 02:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="28241141"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Feb 2024 02:30:06 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcjrC-0005FO-1K;
	Wed, 21 Feb 2024 10:29:49 +0000
Date: Wed, 21 Feb 2024 18:27:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 5b52c9afa3dd95ea0903b6d16225e5744f20ad5b
Message-ID: <202402211838.boBN0Iop-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 5b52c9afa3dd95ea0903b6d16225e5744f20ad5b  Merge branch 'pci/misc'

elapsed time: 1001m

configs tested: 115
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                       spear13xx_defconfig   gcc  
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
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                         wii_defconfig   gcc  
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
sh                        dreamcast_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
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
x86_64       buildonly-randconfig-002-20240221   gcc  
x86_64       buildonly-randconfig-003-20240221   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240221   gcc  
x86_64                randconfig-002-20240221   gcc  
x86_64                randconfig-003-20240221   gcc  
x86_64                randconfig-004-20240221   gcc  
x86_64                randconfig-005-20240221   gcc  
x86_64                randconfig-006-20240221   gcc  
x86_64                randconfig-012-20240221   gcc  
x86_64                randconfig-014-20240221   gcc  
x86_64                randconfig-015-20240221   gcc  
x86_64                randconfig-016-20240221   gcc  
x86_64                randconfig-071-20240221   gcc  
x86_64                randconfig-072-20240221   gcc  
x86_64                randconfig-073-20240221   gcc  
x86_64                randconfig-074-20240221   gcc  
x86_64                randconfig-076-20240221   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

