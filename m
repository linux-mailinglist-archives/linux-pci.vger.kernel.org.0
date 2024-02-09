Return-Path: <linux-pci+bounces-3305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DD84FF5F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 23:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D332D1C21588
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 22:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68B1A70A;
	Fri,  9 Feb 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTtgZPBi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E171B942
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516172; cv=none; b=WwFejKio4RQnigf98TUFmOwSRzKGUcvO8A0hlcc/Q6ZT6tmbSOADN0DiqGBlmUgs0Qs05J6Dwg02Hol3mcS5XQYkJVbblKC6CvXZE0tVCYnz+mYZzvbfvqeMN1olV9ofCLy2b0Q865J/ZeB4ls9+BIiH4V9QgftIvEAxUsbqPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516172; c=relaxed/simple;
	bh=310dK3DwK0RLWDpKch578WEmDQmoU1S3folWhiQgx+w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fYbQIpbuU65aoRyCp+dH133ijzL6qfjwYGzIK85a+Jq+WpErp9hlWcNIfoO8xUQlqczRP1aNjfujzLxHJrqd9HegnnCLbhthOuRf3UpijdpaVE1xcRdacYNB+Ttd0xIlfhbFkTQQ6LzOAdVWvBQvjVhPbb4hWwcrbsEwzkGL3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTtgZPBi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707516167; x=1739052167;
  h=date:from:to:cc:subject:message-id;
  bh=310dK3DwK0RLWDpKch578WEmDQmoU1S3folWhiQgx+w=;
  b=OTtgZPBiH+vURb1Ih2ptH/2yyUoThqNZGU6giWR/9ZMYZGgL34ynntTN
   VIbltC81UothanRLg9EWPpZ8HbqnAu51ovDMrdxChTwe4WsgjkA9Nw+Jb
   oYfd6qVw0LkDtNHv4a/ZtyN1uf8Th4IhVxkC3tD7dhuSFe59HbBUHYQmk
   ow1toQco1KHbMI/R0rqg/WsuR9g37i4pvQY1LFPmZpj1Mhq/iPN/GMqVR
   0T+hrUP7S9mOv6armhtZC+Edv6qvO3Rm2wIcLoWCjcPyH6Rvi8h5+HPVQ
   ClsBXDKL9gSZCGsgKX3wjk3ARIlCoDvrXyz0JNuOl0d40gzVQ76JJb8dU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1397071"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1397071"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 14:02:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6653841"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Feb 2024 14:02:43 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYYxF-00059X-25;
	Fri, 09 Feb 2024 22:02:41 +0000
Date: Sat, 10 Feb 2024 06:02:14 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:switchtec] BUILD SUCCESS
 dec529b0b0572b32f9eb91c882dd1f08ca657efb
Message-ID: <202402100611.XmooOdA3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git switchtec
branch HEAD: dec529b0b0572b32f9eb91c882dd1f08ca657efb  PCI: switchtec: Fix an error handling path in switchtec_pci_probe()

elapsed time: 1452m

configs tested: 173
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
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240209   gcc  
arc                   randconfig-002-20240209   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-002-20240209   gcc  
arm                   randconfig-003-20240209   gcc  
arm                   randconfig-004-20240209   gcc  
arm                        shmobile_defconfig   gcc  
arm                       spear13xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240209   gcc  
csky                  randconfig-002-20240209   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240209   clang
i386         buildonly-randconfig-002-20240209   clang
i386         buildonly-randconfig-003-20240209   gcc  
i386         buildonly-randconfig-004-20240209   clang
i386         buildonly-randconfig-005-20240209   clang
i386         buildonly-randconfig-006-20240209   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240209   clang
i386                  randconfig-002-20240209   gcc  
i386                  randconfig-003-20240209   clang
i386                  randconfig-004-20240209   clang
i386                  randconfig-005-20240209   clang
i386                  randconfig-006-20240209   gcc  
i386                  randconfig-011-20240209   gcc  
i386                  randconfig-012-20240209   gcc  
i386                  randconfig-013-20240209   clang
i386                  randconfig-014-20240209   gcc  
i386                  randconfig-015-20240209   gcc  
i386                  randconfig-016-20240209   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240209   gcc  
loongarch             randconfig-002-20240209   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240209   gcc  
nios2                 randconfig-002-20240209   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240209   gcc  
parisc                randconfig-002-20240209   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc               randconfig-003-20240209   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240209   gcc  
s390                  randconfig-002-20240209   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240209   gcc  
sh                    randconfig-002-20240209   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240209   gcc  
sparc64               randconfig-002-20240209   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240209   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240209   gcc  
x86_64       buildonly-randconfig-002-20240209   gcc  
x86_64       buildonly-randconfig-003-20240209   clang
x86_64       buildonly-randconfig-004-20240209   gcc  
x86_64       buildonly-randconfig-005-20240209   clang
x86_64       buildonly-randconfig-006-20240209   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240209   clang
x86_64                randconfig-002-20240209   gcc  
x86_64                randconfig-003-20240209   gcc  
x86_64                randconfig-004-20240209   clang
x86_64                randconfig-005-20240209   gcc  
x86_64                randconfig-006-20240209   gcc  
x86_64                randconfig-011-20240209   clang
x86_64                randconfig-012-20240209   clang
x86_64                randconfig-013-20240209   gcc  
x86_64                randconfig-014-20240209   clang
x86_64                randconfig-015-20240209   gcc  
x86_64                randconfig-016-20240209   clang
x86_64                randconfig-071-20240209   gcc  
x86_64                randconfig-072-20240209   clang
x86_64                randconfig-073-20240209   clang
x86_64                randconfig-074-20240209   gcc  
x86_64                randconfig-075-20240209   gcc  
x86_64                randconfig-076-20240209   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240209   gcc  
xtensa                randconfig-002-20240209   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

