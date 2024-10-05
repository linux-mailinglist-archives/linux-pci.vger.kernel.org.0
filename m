Return-Path: <linux-pci+bounces-13881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E800991427
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 05:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B96A285B0C
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 03:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B121C2BD;
	Sat,  5 Oct 2024 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJnp+Nu6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456C1CA8D
	for <linux-pci@vger.kernel.org>; Sat,  5 Oct 2024 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099897; cv=none; b=VFCIz4/lBqYq1nBy60dxdJrpMT5Q8MzteRDdz+iXyxKZOwmrWjQLWRgxybEJb5layPMe0bsUdlqb9XGqfkDIw8KI5uzx0qSp1ysu9dskGnqwhab69Hb/1TLFE9paMYHXPwGqf4PkcI7ahV0rh0LusMLAKI6jxPJlOeyYNEdh/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099897; c=relaxed/simple;
	bh=LhggOa1LL+nm7hovNeDBSgyW3WWEUrBTq3DzII0Oo8k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cDTa6f/RHAOyI9a3kCgA0sYBBf2zwgUyoNLCUytUbPyr3/4ZKycR78mn7rEI4jXP7oxFHCN+TiK8U5S9HXuI6XP7uYFDfRVhUyCzHWGnEgWY11YdERo3CWHp8E/uUL8zrsWbsIwi2hgLQKYFTRtc1F7UqkNllEjSyr0i/p0TbSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJnp+Nu6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728099895; x=1759635895;
  h=date:from:to:cc:subject:message-id;
  bh=LhggOa1LL+nm7hovNeDBSgyW3WWEUrBTq3DzII0Oo8k=;
  b=AJnp+Nu6lMchJCEnBps2P1eI0Uon+eITZK0JbSEgBFjAh1P7uc4jZN8s
   /LcwODcwcyFjn8KWrlCcWcGmX3pM+yI/W5cGuTY4Wb3Zz2tKNUQAGA9Qp
   znjgYT4C0zree1lMRt+B8pcDZY5aqHr1ojetOXb5LMJDqpvUgKvq5EuEs
   KVdI2ezLv0wYtPIuHGiXkqUXDuPx8u80LM0f68ZzGKxy1PyYD1qXaHci1
   r/KRUtdRBUaBGYoSEhxCpNEqodO703/3TBX9F7KMwPp5EgDTJxexfTmna
   Cl1aOnr8q7MxHTWQ0Vv+D9WTHMGorLQZ/2irrbQE1OGUMeM9IQdr6tP9c
   w==;
X-CSE-ConnectionGUID: X6CPGKR8S7+f7B7s7e88Ag==
X-CSE-MsgGUID: eb/qh5giRlqypNwO3m7Z8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="26796111"
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="26796111"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 20:44:55 -0700
X-CSE-ConnectionGUID: vTUEW0zGS3CWr9awMp3mOQ==
X-CSE-MsgGUID: cu7kwyATSHSnOu/TCNYHQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="105742774"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Oct 2024 20:44:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swvit-0002Ws-15;
	Sat, 05 Oct 2024 03:44:51 +0000
Date: Sat, 05 Oct 2024 11:43:55 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:driver-remove] BUILD SUCCESS
 43d6961cdf1d0621c55638ed33554027978ae1fe
Message-ID: <202410051141.7pq9Ejd8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git driver-remove
branch HEAD: 43d6961cdf1d0621c55638ed33554027978ae1fe  PCI: acpiphp_ampere_altra: Switch back to struct platform_driver::remove()

elapsed time: 1780m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                           tb10x_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      integrator_defconfig    gcc-13.2.0
arm                           omap1_defconfig    gcc-13.2.0
arm                           sama7_defconfig    gcc-13.2.0
arm                         socfpga_defconfig    gcc-13.2.0
arm                        spear3xx_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-13.2.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             alldefconfig    gcc-13.2.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241005    clang-18
i386        buildonly-randconfig-002-20241005    clang-18
i386        buildonly-randconfig-003-20241005    clang-18
i386        buildonly-randconfig-004-20241005    clang-18
i386        buildonly-randconfig-005-20241005    gcc-12
i386        buildonly-randconfig-006-20241005    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241005    gcc-11
i386                  randconfig-002-20241005    clang-18
i386                  randconfig-003-20241005    gcc-12
i386                  randconfig-004-20241005    clang-18
i386                  randconfig-005-20241005    clang-18
i386                  randconfig-006-20241005    clang-18
i386                  randconfig-011-20241005    gcc-12
i386                  randconfig-012-20241005    clang-18
i386                  randconfig-013-20241005    clang-18
i386                  randconfig-014-20241005    gcc-12
i386                  randconfig-015-20241005    gcc-12
i386                  randconfig-016-20241005    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                         3c120_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
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
powerpc                       eiger_defconfig    gcc-13.2.0
powerpc                      pasemi_defconfig    gcc-13.2.0
powerpc                     tqm8540_defconfig    gcc-13.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                   sh7724_generic_defconfig    gcc-13.2.0
sh                        sh7763rdp_defconfig    gcc-13.2.0
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
x86_64      buildonly-randconfig-001-20241005    gcc-12
x86_64      buildonly-randconfig-002-20241005    gcc-12
x86_64      buildonly-randconfig-003-20241005    gcc-12
x86_64      buildonly-randconfig-004-20241005    gcc-12
x86_64      buildonly-randconfig-005-20241005    gcc-12
x86_64      buildonly-randconfig-006-20241005    gcc-12
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                randconfig-001-20241005    gcc-12
x86_64                randconfig-002-20241005    gcc-12
x86_64                randconfig-003-20241005    gcc-12
x86_64                randconfig-004-20241005    gcc-12
x86_64                randconfig-005-20241005    gcc-12
x86_64                randconfig-006-20241005    gcc-12
x86_64                randconfig-011-20241005    gcc-12
x86_64                randconfig-012-20241005    gcc-12
x86_64                randconfig-013-20241005    gcc-12
x86_64                randconfig-014-20241005    gcc-12
x86_64                randconfig-015-20241005    gcc-12
x86_64                randconfig-016-20241005    gcc-12
x86_64                randconfig-071-20241005    gcc-12
x86_64                randconfig-072-20241005    gcc-12
x86_64                randconfig-073-20241005    gcc-12
x86_64                randconfig-074-20241005    gcc-12
x86_64                randconfig-075-20241005    gcc-12
x86_64                randconfig-076-20241005    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-func    gcc-12
x86_64                    rhel-8.3-kselftests    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

