Return-Path: <linux-pci+bounces-3671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA485938B
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 00:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD1F1C20C75
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 23:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856764D13F;
	Sat, 17 Feb 2024 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n39RE/Il"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849C1E861
	for <linux-pci@vger.kernel.org>; Sat, 17 Feb 2024 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708211190; cv=none; b=LQP6RrItrgyKEiSsUz8/4tWpgVWSObMBT9LTrzGQT4u0mbfklM2iDi8IU4vO3qMxao7wRoe8qyc1MviuZQyKvIrGB4tGV/PiToI55GN9sZbuNkR5rRYdi/ZvCzMJFdfG+iP4FQWX05WpY2AObQGQwfEw2UuLCyY+0LHiwgpDwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708211190; c=relaxed/simple;
	bh=bPj9BDeO01NuFeM4Ym7cH6Ut7Be0dElqkCk0GCNpZjo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Numwe2vQvcCFkOtuCbGQKlnAgL298y/0Plavl/hu/rkBcSSERNoD6QQUZOnh6zNH+d/aWEVK8KIEhKqk5kJ5EvJ9tnbsw+rNFg+rKGt37x0aJSfuUwh6MwNrn4keciuNJbybI21yPKLezPjYJGni3Af7sR+qI0rqPza942+uMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n39RE/Il; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708211188; x=1739747188;
  h=date:from:to:cc:subject:message-id;
  bh=bPj9BDeO01NuFeM4Ym7cH6Ut7Be0dElqkCk0GCNpZjo=;
  b=n39RE/Ilt6Jxg2mzhCt346eGXiUr04arLFCqhTYOMBRca0SPYT7vTGGO
   8xNDmqNMrJf9cnd5lHe03lPtKBls4wXSQ2hVz3ZV7Vuu096rIHNhCa7fd
   aa+TJBUSKUi3sQBGgDDlFzZ20ePeCH1d6ND5IHWRT6AXuFwJAObW492ZN
   ybtn50HsLtlVYK97sa35HD4EbdKZEgFVC+h5vc1hukNDdgQkVHeXVI6K0
   FI1/ppIcuxpa4sMAhVx148ECPLtrM69M2lBMGdg/tjc15KLh0MqSiIq+y
   YSQOcQCXDxmI1PvE3VxqEN/QJVTUM5vN9zJMMAOvolQwKk+fKl6kLhWJ3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="6145229"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="6145229"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 15:06:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="8740096"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 17 Feb 2024 15:06:26 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbTlH-0002Zo-2i;
	Sat, 17 Feb 2024 23:06:23 +0000
Date: Sun, 18 Feb 2024 07:05:52 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 172c0cf519fb52860157c57067f1a58cfc0aa861
Message-ID: <202402180749.bc3ckosC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 172c0cf519fb52860157c57067f1a58cfc0aa861  MAINTAINERS: Add Siddharth Vadapalli as PCI TI DRA7XX/J721E reviewer

elapsed time: 1455m

configs tested: 214
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240217   gcc  
arc                   randconfig-001-20240218   gcc  
arc                   randconfig-002-20240217   gcc  
arc                   randconfig-002-20240218   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-002-20240217   gcc  
arm                   randconfig-003-20240217   gcc  
arm                   randconfig-003-20240218   gcc  
arm                   randconfig-004-20240217   gcc  
arm                         s5pv210_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240217   gcc  
arm64                 randconfig-003-20240217   gcc  
arm64                 randconfig-004-20240218   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240217   gcc  
csky                  randconfig-001-20240218   gcc  
csky                  randconfig-002-20240217   gcc  
csky                  randconfig-002-20240218   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240217   gcc  
i386         buildonly-randconfig-002-20240217   clang
i386         buildonly-randconfig-003-20240217   gcc  
i386         buildonly-randconfig-004-20240217   gcc  
i386         buildonly-randconfig-005-20240217   gcc  
i386         buildonly-randconfig-006-20240217   clang
i386         buildonly-randconfig-006-20240218   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240217   gcc  
i386                  randconfig-002-20240217   gcc  
i386                  randconfig-002-20240218   gcc  
i386                  randconfig-003-20240217   clang
i386                  randconfig-004-20240217   gcc  
i386                  randconfig-005-20240217   gcc  
i386                  randconfig-006-20240217   clang
i386                  randconfig-006-20240218   gcc  
i386                  randconfig-011-20240217   gcc  
i386                  randconfig-011-20240218   gcc  
i386                  randconfig-012-20240217   gcc  
i386                  randconfig-012-20240218   gcc  
i386                  randconfig-013-20240217   clang
i386                  randconfig-014-20240217   clang
i386                  randconfig-014-20240218   gcc  
i386                  randconfig-015-20240217   clang
i386                  randconfig-015-20240218   gcc  
i386                  randconfig-016-20240217   gcc  
i386                  randconfig-016-20240218   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240217   gcc  
loongarch             randconfig-001-20240218   gcc  
loongarch             randconfig-002-20240217   gcc  
loongarch             randconfig-002-20240218   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240217   gcc  
nios2                 randconfig-001-20240218   gcc  
nios2                 randconfig-002-20240217   gcc  
nios2                 randconfig-002-20240218   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240217   gcc  
parisc                randconfig-001-20240218   gcc  
parisc                randconfig-002-20240217   gcc  
parisc                randconfig-002-20240218   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20240217   gcc  
powerpc               randconfig-001-20240218   gcc  
powerpc               randconfig-002-20240217   gcc  
powerpc               randconfig-002-20240218   gcc  
powerpc               randconfig-003-20240217   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-002-20240217   gcc  
powerpc64             randconfig-002-20240218   gcc  
powerpc64             randconfig-003-20240218   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240217   gcc  
riscv                 randconfig-001-20240218   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240218   gcc  
s390                  randconfig-002-20240217   gcc  
s390                  randconfig-002-20240218   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240217   gcc  
sh                    randconfig-001-20240218   gcc  
sh                    randconfig-002-20240217   gcc  
sh                    randconfig-002-20240218   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240217   gcc  
sparc64               randconfig-001-20240218   gcc  
sparc64               randconfig-002-20240217   gcc  
sparc64               randconfig-002-20240218   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240218   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240217   gcc  
x86_64       buildonly-randconfig-003-20240217   gcc  
x86_64       buildonly-randconfig-004-20240217   gcc  
x86_64       buildonly-randconfig-006-20240217   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240217   gcc  
x86_64                randconfig-011-20240217   gcc  
x86_64                randconfig-012-20240217   gcc  
x86_64                randconfig-014-20240217   gcc  
x86_64                randconfig-015-20240217   gcc  
x86_64                randconfig-071-20240217   gcc  
x86_64                randconfig-072-20240217   gcc  
x86_64                randconfig-073-20240217   gcc  
x86_64                randconfig-075-20240217   gcc  
x86_64                randconfig-076-20240217   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240217   gcc  
xtensa                randconfig-001-20240218   gcc  
xtensa                randconfig-002-20240217   gcc  
xtensa                randconfig-002-20240218   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

