Return-Path: <linux-pci+bounces-36054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B513B555F1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 20:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8D91D665E3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33025204F93;
	Fri, 12 Sep 2025 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUc00Ocu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4A28DC4
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700988; cv=none; b=Ui081lRTIdunxp6EHjCMen/Iupso1zKY8ZqJn8unJ/ze3k85tnIJ3eVDWP5mtWVFwsaj5Z7hghqw2ejAYIu8jHXp3OL0NfIPKpIfoVwe4qtocMU33gQDOY96Rt8nTmL1jCmye13PasXvvH5DXMCHUxjDNnSqbBuDmGZqoVJnRI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700988; c=relaxed/simple;
	bh=U6Pfj842bR02EWZSiYCFFfGuybJXF98He2F57vDzRKU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jEIrcKNHWjo8xZVmuHeTK0frQzLi8OcRcch8EY9bzQAzE+QVXnZHpkhHWKilhgQdZn30PDlzd0D8TkKwcgYAHcHjFQuwCr7tagr6QNg9/IcwSyqob7BEnwhgH99E1HlITy2pq8qhobozUUA6juUq+LKOkW3+c2lW5r6+S4eA2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUc00Ocu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757700986; x=1789236986;
  h=date:from:to:cc:subject:message-id;
  bh=U6Pfj842bR02EWZSiYCFFfGuybJXF98He2F57vDzRKU=;
  b=CUc00OcuPHqPgO36hdQYsqRJfPZFzMrbONbapdZlShhh3oRm07prZcFJ
   jVj+gXErfJaalB6UwaZFZOFf3dkiyk4OJfnobDDcLfFnNlmANPzNquFrX
   cP/nzigU1nzUijkNPlswA3PrtsS2RHhE24pU9ZSbAk5UU4xIK/sCMtE/Y
   5L7Zzm6r///YqCMov5iC+bmC0l6QTBKJa8W3BVBeW9woy4KSoqHx1h0iG
   b1HuyR6JjBxK+hooXyQ/Zqa1Ta+f+OxFugUrNUTdwDo0JsIjF/60iNGxj
   WUtGtecmDnRdeYOcV10u57Y+UbBdYJDD8E+JStk4MJmXx5FFp5lUBJpVD
   Q==;
X-CSE-ConnectionGUID: 1oLB7DHiSDWVZaw65JncfA==
X-CSE-MsgGUID: nr3Q3W+aRaahs5P/ToGsYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="77508302"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="77508302"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 11:16:26 -0700
X-CSE-ConnectionGUID: U+bIuPCqSGudHXdOHXti7Q==
X-CSE-MsgGUID: c1jVcaFzQ0+ORBhvKFDm8w==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 12 Sep 2025 11:16:24 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ux8Jp-0001AE-2z;
	Fri, 12 Sep 2025 18:16:21 +0000
Date: Sat, 13 Sep 2025 02:15:26 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc-edma] BUILD SUCCESS
 9e495c2d7f38a6e256749a8466856dc711666f05
Message-ID: <202509130216.bgF0DkFl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-edma
branch HEAD: 9e495c2d7f38a6e256749a8466856dc711666f05  PCI: qcom-ep: Remove redundant edma.nr_irqs initialization

elapsed time: 1458m

configs tested: 218
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250912    clang-19
arc                   randconfig-001-20250912    gcc-10.5.0
arc                   randconfig-002-20250912    clang-19
arc                   randconfig-002-20250912    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250912    clang-19
arm                   randconfig-001-20250912    clang-22
arm                   randconfig-002-20250912    clang-19
arm                   randconfig-002-20250912    gcc-14.3.0
arm                   randconfig-003-20250912    clang-19
arm                   randconfig-003-20250912    clang-22
arm                   randconfig-004-20250912    clang-19
arm                   randconfig-004-20250912    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250912    clang-19
arm64                 randconfig-001-20250912    clang-20
arm64                 randconfig-002-20250912    clang-16
arm64                 randconfig-002-20250912    clang-19
arm64                 randconfig-003-20250912    clang-19
arm64                 randconfig-003-20250912    clang-22
arm64                 randconfig-004-20250912    clang-19
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250912    clang-22
csky                  randconfig-001-20250912    gcc-15.1.0
csky                  randconfig-002-20250912    clang-22
csky                  randconfig-002-20250912    gcc-11.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250912    clang-22
hexagon               randconfig-002-20250912    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250912    gcc-13
i386        buildonly-randconfig-001-20250912    gcc-14
i386        buildonly-randconfig-002-20250912    clang-20
i386        buildonly-randconfig-002-20250912    gcc-13
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250912    clang-20
i386        buildonly-randconfig-004-20250912    gcc-13
i386        buildonly-randconfig-005-20250912    gcc-13
i386        buildonly-randconfig-005-20250912    gcc-14
i386        buildonly-randconfig-006-20250912    clang-20
i386        buildonly-randconfig-006-20250912    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20250912    gcc-14
i386                  randconfig-002-20250912    gcc-14
i386                  randconfig-003-20250912    gcc-14
i386                  randconfig-004-20250912    gcc-14
i386                  randconfig-005-20250912    gcc-14
i386                  randconfig-006-20250912    gcc-14
i386                  randconfig-007-20250912    gcc-14
i386                  randconfig-011-20250912    gcc-14
i386                  randconfig-012-20250912    gcc-14
i386                  randconfig-013-20250912    gcc-14
i386                  randconfig-014-20250912    gcc-14
i386                  randconfig-015-20250912    gcc-14
i386                  randconfig-016-20250912    gcc-14
i386                  randconfig-017-20250912    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250912    clang-22
loongarch             randconfig-001-20250912    gcc-15.1.0
loongarch             randconfig-002-20250912    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250912    clang-22
nios2                 randconfig-001-20250912    gcc-11.5.0
nios2                 randconfig-002-20250912    clang-22
nios2                 randconfig-002-20250912    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250912    clang-22
parisc                randconfig-001-20250912    gcc-14.3.0
parisc                randconfig-002-20250912    clang-22
parisc                randconfig-002-20250912    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250912    clang-22
powerpc               randconfig-001-20250912    gcc-8.5.0
powerpc               randconfig-002-20250912    clang-22
powerpc               randconfig-003-20250912    clang-17
powerpc               randconfig-003-20250912    clang-22
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250912    clang-22
powerpc64             randconfig-001-20250912    gcc-12.5.0
powerpc64             randconfig-002-20250912    clang-22
powerpc64             randconfig-003-20250912    clang-19
powerpc64             randconfig-003-20250912    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250912    clang-16
riscv                 randconfig-001-20250912    gcc-15.1.0
riscv                 randconfig-002-20250912    gcc-15.1.0
riscv                 randconfig-002-20250912    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250912    gcc-10.5.0
s390                  randconfig-001-20250912    gcc-15.1.0
s390                  randconfig-002-20250912    gcc-10.5.0
s390                  randconfig-002-20250912    gcc-15.1.0
s390                       zfcpdump_defconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250912    gcc-15.1.0
sh                    randconfig-002-20250912    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250912    gcc-15.1.0
sparc                 randconfig-001-20250912    gcc-8.5.0
sparc                 randconfig-002-20250912    gcc-13.4.0
sparc                 randconfig-002-20250912    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250912    gcc-15.1.0
sparc64               randconfig-001-20250912    gcc-8.5.0
sparc64               randconfig-002-20250912    clang-20
sparc64               randconfig-002-20250912    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250912    clang-22
um                    randconfig-001-20250912    gcc-15.1.0
um                    randconfig-002-20250912    gcc-14
um                    randconfig-002-20250912    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250912    gcc-14
x86_64      buildonly-randconfig-002-20250912    gcc-14
x86_64      buildonly-randconfig-003-20250912    clang-20
x86_64      buildonly-randconfig-004-20250912    clang-20
x86_64      buildonly-randconfig-005-20250912    clang-20
x86_64      buildonly-randconfig-006-20250912    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250912    gcc-14
x86_64                randconfig-002-20250912    gcc-14
x86_64                randconfig-003-20250912    gcc-14
x86_64                randconfig-004-20250912    gcc-14
x86_64                randconfig-005-20250912    gcc-14
x86_64                randconfig-006-20250912    gcc-14
x86_64                randconfig-007-20250912    gcc-14
x86_64                randconfig-008-20250912    gcc-14
x86_64                randconfig-071-20250912    clang-20
x86_64                randconfig-072-20250912    clang-20
x86_64                randconfig-073-20250912    clang-20
x86_64                randconfig-074-20250912    clang-20
x86_64                randconfig-075-20250912    clang-20
x86_64                randconfig-076-20250912    clang-20
x86_64                randconfig-077-20250912    clang-20
x86_64                randconfig-078-20250912    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250912    gcc-15.1.0
xtensa                randconfig-001-20250912    gcc-9.5.0
xtensa                randconfig-002-20250912    gcc-12.5.0
xtensa                randconfig-002-20250912    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

