Return-Path: <linux-pci+bounces-13104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08692976814
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 13:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9619284950
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C237018E043;
	Thu, 12 Sep 2024 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m69iZzT3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5E29CF6
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141445; cv=none; b=BsrFW4jyII42yRtXkwIcrFkIhqoUroClzKwGCvo86H6pBbSQM7KfhAHmsmHLkaZdON8YqYaRbdqimDgl3jDi72HxXbhRBRCVnHlN+NFER2wC4igR9Aaj+MyaP5epWo0Ozi3LW2Gj/ZGOfPdvdaWIqXv0wwnmf7M9+lvZgx9VLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141445; c=relaxed/simple;
	bh=C1t2s/ZjYZgVGfDk7fZeEsqLk9pSaW/aY0SJRo42CwE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UaTpX5RjJh4bYWN8CN+vNpYKYoRulRdVtSaTsGcuJXaCRI2vZhAkdEDpRSdr/1gURzoNOVHoCMd5SErzF05I15BLMjNu5CDUZe5N4IZslgZrFI8yNOyd0J44MRD8UioCiNYY9IcN4Qbnjb/rRA/ETW77SJKdI7TXI+Vzy19KnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m69iZzT3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726141444; x=1757677444;
  h=date:from:to:cc:subject:message-id;
  bh=C1t2s/ZjYZgVGfDk7fZeEsqLk9pSaW/aY0SJRo42CwE=;
  b=m69iZzT3dA6Za4NbOAcohF+g4ItH308nn7vb78jABzCmbLycD0xkUIkf
   T4s3ewzBRnDU9gG41r2sFln7B+JEWrIi+f5J5Q8O0y82EuoG9frnkzZ7i
   q9u/kFngxvZRC6qhZODkZtDI1pXIqB5JecqU5mwQNVSHRqaRj9FXL1wEX
   cUxWa1vHDxT0CP8rhSL4oi4BZrRXfkzCT7qqRBUBOT1xes8GVVUtSoEC2
   yzeNLnnRT1azgkJbfEUYh9z6yfTSiD6F7I25IHJPDRcslJPmq1TrPabPW
   qS0fS4hn1By2OJcNqQKvLd/ZVP4738xzJ5Rlg91pbg9ROsfe/uEM+WsB7
   g==;
X-CSE-ConnectionGUID: dXI+axJcRqmoq3FgFls9FA==
X-CSE-MsgGUID: Nj1+i/vDRXmSIobqz+Dqsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24810934"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="24810934"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 04:43:55 -0700
X-CSE-ConnectionGUID: Py2w+h3cT2WQ1LRtGO+OgQ==
X-CSE-MsgGUID: KkhFag4mSyW1u+Lsq5EQtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="68455500"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Sep 2024 04:43:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soiEp-00055o-1R;
	Thu, 12 Sep 2024 11:43:51 +0000
Date: Thu, 12 Sep 2024 19:42:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:tools] BUILD SUCCESS
 fd163fd4e34bdfdedc6214952e115a8e677b739b
Message-ID: <202409121947.tZRrssod-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tools
branch HEAD: fd163fd4e34bdfdedc6214952e115a8e677b739b  tools: PCI: Remove unused BILLION macro

elapsed time: 1264m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20240912    gcc-13.2.0
arc                   randconfig-002-20240912    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                          moxart_defconfig    gcc-14.1.0
arm                          pxa910_defconfig    gcc-14.1.0
arm                   randconfig-001-20240912    gcc-13.2.0
arm                   randconfig-002-20240912    gcc-13.2.0
arm                   randconfig-003-20240912    gcc-13.2.0
arm                   randconfig-004-20240912    gcc-13.2.0
arm                           spitz_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                            allyesconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240912    gcc-13.2.0
arm64                 randconfig-002-20240912    gcc-13.2.0
arm64                 randconfig-003-20240912    gcc-13.2.0
arm64                 randconfig-004-20240912    gcc-13.2.0
csky                             allmodconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                             allyesconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240912    gcc-13.2.0
csky                  randconfig-002-20240912    gcc-13.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240912    gcc-13.2.0
hexagon               randconfig-002-20240912    gcc-13.2.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240912    gcc-12
i386        buildonly-randconfig-002-20240912    gcc-12
i386        buildonly-randconfig-003-20240912    gcc-12
i386        buildonly-randconfig-004-20240912    gcc-12
i386        buildonly-randconfig-005-20240912    gcc-12
i386        buildonly-randconfig-006-20240912    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240912    gcc-12
i386                  randconfig-002-20240912    gcc-12
i386                  randconfig-003-20240912    gcc-12
i386                  randconfig-004-20240912    gcc-12
i386                  randconfig-005-20240912    gcc-12
i386                  randconfig-006-20240912    gcc-12
i386                  randconfig-011-20240912    gcc-12
i386                  randconfig-012-20240912    gcc-12
i386                  randconfig-013-20240912    gcc-12
i386                  randconfig-014-20240912    gcc-12
i386                  randconfig-015-20240912    gcc-12
i386                  randconfig-016-20240912    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                        allyesconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240912    gcc-13.2.0
loongarch             randconfig-002-20240912    gcc-13.2.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                             allmodconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                             allyesconfig    gcc-14.1.0
mips                       lemote2f_defconfig    gcc-14.1.0
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240912    gcc-13.2.0
nios2                 randconfig-002-20240912    gcc-13.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240912    gcc-13.2.0
parisc                randconfig-002-20240912    gcc-13.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       eiger_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc               randconfig-001-20240912    gcc-13.2.0
powerpc               randconfig-002-20240912    gcc-13.2.0
powerpc               randconfig-003-20240912    gcc-13.2.0
powerpc                        warp_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20240912    gcc-13.2.0
powerpc64             randconfig-002-20240912    gcc-13.2.0
powerpc64             randconfig-003-20240912    gcc-13.2.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240912    gcc-13.2.0
riscv                 randconfig-002-20240912    gcc-13.2.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240912    gcc-13.2.0
s390                  randconfig-002-20240912    gcc-13.2.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20240912    gcc-13.2.0
sh                    randconfig-002-20240912    gcc-13.2.0
sh                           se7619_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240912    gcc-13.2.0
sparc64               randconfig-002-20240912    gcc-13.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240912    gcc-13.2.0
um                    randconfig-002-20240912    gcc-13.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240912    clang-18
x86_64      buildonly-randconfig-002-20240912    clang-18
x86_64      buildonly-randconfig-003-20240912    clang-18
x86_64      buildonly-randconfig-004-20240912    clang-18
x86_64      buildonly-randconfig-005-20240912    clang-18
x86_64      buildonly-randconfig-006-20240912    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240912    clang-18
x86_64                randconfig-002-20240912    clang-18
x86_64                randconfig-003-20240912    clang-18
x86_64                randconfig-004-20240912    clang-18
x86_64                randconfig-005-20240912    clang-18
x86_64                randconfig-006-20240912    clang-18
x86_64                randconfig-011-20240912    clang-18
x86_64                randconfig-012-20240912    clang-18
x86_64                randconfig-013-20240912    clang-18
x86_64                randconfig-014-20240912    clang-18
x86_64                randconfig-015-20240912    clang-18
x86_64                randconfig-016-20240912    clang-18
x86_64                randconfig-071-20240912    clang-18
x86_64                randconfig-072-20240912    clang-18
x86_64                randconfig-073-20240912    clang-18
x86_64                randconfig-074-20240912    clang-18
x86_64                randconfig-075-20240912    clang-18
x86_64                randconfig-076-20240912    clang-18
x86_64                          rhel-8.3-rust    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240912    gcc-13.2.0
xtensa                randconfig-002-20240912    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

