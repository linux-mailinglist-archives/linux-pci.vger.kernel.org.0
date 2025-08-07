Return-Path: <linux-pci+bounces-33551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B27EB1D8C9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 15:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F3B7ABF32
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFBE13C8E8;
	Thu,  7 Aug 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvAoUbON"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B144A0C
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572663; cv=none; b=DDPz8qhk7lILB/0QH5SQsYg7EACp42ltRv+T3soeKcGklQ1tuJwqQ9ZFQhZkfwvKLddv3YWOa3gYjYZV+5qxhHisB7gNRyNpXZ4BRctVFnP5GrArhMuoiDWDoK0A5HBJYcc9Zzi3Yz5/k7v9iJPdNsVS9vB6URYc3O/47NJXGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572663; c=relaxed/simple;
	bh=IBdomscIZAVDbxuPs+j5XL++tfqeyL12KQ7VJrVBAPA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jizxBZapDbYaIVpcDg00PADctt2s1Q67xmKXQoKRnEhJuQxRJsSmz/W33Q8yfT4ySp/w3ukbCGDLNLXauZelv78GV/kCkcWWRyMQKpffV6t4YdIV/LM5WYPKxGlBLffc2MgAmtjRwHGKvoLXmUtv/1mqXrMQL/PvMnKSWDWciMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvAoUbON; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754572662; x=1786108662;
  h=date:from:to:cc:subject:message-id;
  bh=IBdomscIZAVDbxuPs+j5XL++tfqeyL12KQ7VJrVBAPA=;
  b=cvAoUbON9MyWAgza1Cc+wCBpbKHp3RRlTgX0AZ5RsiAJMAS4RlF3qJlY
   EloowWP+x5/xOmEdR5nmKJ+7ALqPd4Q1d37soVRuENr29KaHGmiadAIwJ
   byLZHHI1jtXmQqyk3MrwOvqUeWOSJ4izNiWpzDS7IBVDBTRnp638oTv8K
   OEnTvsiyblCmMzs5+KBeV7yeXAFRLWeJ4H0OOzkMV7D6MH8fvW5mVO7fz
   rtJcinn3TxXhSqrbo4qlbRZQrhcPlkr1sagJ8bQmkdxcmvuHSKLvVNoHI
   a8ZsuTDePnJycgkIHUuPXMIus4TJ+04PDNBd4aoTwZe06wipiKSVBGSFw
   Q==;
X-CSE-ConnectionGUID: /HgFt6LNRdSYyHuj9P/QpA==
X-CSE-MsgGUID: +asP2FCIRlC8hBOt6onuCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56620444"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56620444"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 06:17:42 -0700
X-CSE-ConnectionGUID: cEQ/ghfJR0COUS84jWwXGA==
X-CSE-MsgGUID: vtCDMrYlRkaXd8BJZbUMww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169182810"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 07 Aug 2025 06:17:40 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uk0Ux-0002ov-0T;
	Thu, 07 Aug 2025 13:17:36 +0000
Date: Thu, 07 Aug 2025 21:17:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 6e1be0c6d0032a5815729c75c1e7ad7ea5542612
Message-ID: <202508072102.Cf6kK70L-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 6e1be0c6d0032a5815729c75c1e7ad7ea5542612  PCI: hotplug: Clean up spaces in messages

elapsed time: 964m

configs tested: 197
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250807    clang-22
arc                   randconfig-001-20250807    gcc-13.4.0
arc                   randconfig-002-20250807    clang-22
arc                   randconfig-002-20250807    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20250807    clang-22
arm                   randconfig-002-20250807    clang-22
arm                   randconfig-002-20250807    gcc-10.5.0
arm                   randconfig-003-20250807    clang-22
arm                   randconfig-004-20250807    clang-22
arm                   randconfig-004-20250807    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250807    clang-22
arm64                 randconfig-001-20250807    gcc-8.5.0
arm64                 randconfig-002-20250807    clang-22
arm64                 randconfig-002-20250807    gcc-8.5.0
arm64                 randconfig-003-20250807    clang-22
arm64                 randconfig-004-20250807    clang-22
arm64                 randconfig-004-20250807    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-22
csky                  randconfig-001-20250807    gcc-15.1.0
csky                  randconfig-002-20250807    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250807    clang-22
hexagon               randconfig-002-20250807    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250807    clang-20
i386        buildonly-randconfig-001-20250807    gcc-12
i386        buildonly-randconfig-002-20250807    clang-20
i386        buildonly-randconfig-002-20250807    gcc-12
i386        buildonly-randconfig-003-20250807    gcc-12
i386        buildonly-randconfig-004-20250807    gcc-11
i386        buildonly-randconfig-004-20250807    gcc-12
i386        buildonly-randconfig-005-20250807    gcc-12
i386        buildonly-randconfig-006-20250807    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250807    gcc-12
i386                  randconfig-002-20250807    gcc-12
i386                  randconfig-003-20250807    gcc-12
i386                  randconfig-004-20250807    gcc-12
i386                  randconfig-005-20250807    gcc-12
i386                  randconfig-006-20250807    gcc-12
i386                  randconfig-007-20250807    gcc-12
i386                  randconfig-011-20250807    clang-20
i386                  randconfig-012-20250807    clang-20
i386                  randconfig-013-20250807    clang-20
i386                  randconfig-014-20250807    clang-20
i386                  randconfig-015-20250807    clang-20
i386                  randconfig-016-20250807    clang-20
i386                  randconfig-017-20250807    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250807    clang-22
loongarch             randconfig-002-20250807    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250807    gcc-11.5.0
nios2                 randconfig-002-20250807    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250807    gcc-8.5.0
parisc                randconfig-002-20250807    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                    amigaone_defconfig    clang-22
powerpc                       ppc64_defconfig    clang-22
powerpc               randconfig-001-20250807    gcc-12.5.0
powerpc               randconfig-002-20250807    gcc-10.5.0
powerpc               randconfig-003-20250807    gcc-11.5.0
powerpc64             randconfig-001-20250807    gcc-11.5.0
powerpc64             randconfig-002-20250807    clang-22
powerpc64             randconfig-003-20250807    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20250807    gcc-12.5.0
riscv                 randconfig-002-20250807    gcc-12.5.0
riscv                 randconfig-002-20250807    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    gcc-12
s390                  randconfig-001-20250807    clang-22
s390                  randconfig-001-20250807    gcc-12.5.0
s390                  randconfig-002-20250807    clang-22
s390                  randconfig-002-20250807    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250807    gcc-12.5.0
sh                    randconfig-001-20250807    gcc-14.3.0
sh                    randconfig-002-20250807    gcc-12.5.0
sh                    randconfig-002-20250807    gcc-9.5.0
sh                           se7721_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250807    gcc-12.5.0
sparc                 randconfig-001-20250807    gcc-14.3.0
sparc                 randconfig-002-20250807    gcc-12.5.0
sparc                 randconfig-002-20250807    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250807    clang-22
sparc64               randconfig-001-20250807    gcc-12.5.0
sparc64               randconfig-002-20250807    clang-22
sparc64               randconfig-002-20250807    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250807    gcc-12
um                    randconfig-001-20250807    gcc-12.5.0
um                    randconfig-002-20250807    gcc-11
um                    randconfig-002-20250807    gcc-12.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250807    clang-20
x86_64      buildonly-randconfig-001-20250807    gcc-11
x86_64      buildonly-randconfig-002-20250807    gcc-11
x86_64      buildonly-randconfig-002-20250807    gcc-12
x86_64      buildonly-randconfig-003-20250807    clang-20
x86_64      buildonly-randconfig-003-20250807    gcc-11
x86_64      buildonly-randconfig-004-20250807    clang-20
x86_64      buildonly-randconfig-004-20250807    gcc-11
x86_64      buildonly-randconfig-005-20250807    gcc-11
x86_64      buildonly-randconfig-006-20250807    gcc-11
x86_64      buildonly-randconfig-006-20250807    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250807    gcc-12
x86_64                randconfig-002-20250807    gcc-12
x86_64                randconfig-003-20250807    gcc-12
x86_64                randconfig-004-20250807    gcc-12
x86_64                randconfig-005-20250807    gcc-12
x86_64                randconfig-006-20250807    gcc-12
x86_64                randconfig-007-20250807    gcc-12
x86_64                randconfig-008-20250807    gcc-12
x86_64                randconfig-071-20250807    clang-20
x86_64                randconfig-072-20250807    clang-20
x86_64                randconfig-073-20250807    clang-20
x86_64                randconfig-074-20250807    clang-20
x86_64                randconfig-075-20250807    clang-20
x86_64                randconfig-076-20250807    clang-20
x86_64                randconfig-077-20250807    clang-20
x86_64                randconfig-078-20250807    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250807    gcc-12.5.0
xtensa                randconfig-001-20250807    gcc-15.1.0
xtensa                randconfig-002-20250807    gcc-12.5.0
xtensa                randconfig-002-20250807    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

