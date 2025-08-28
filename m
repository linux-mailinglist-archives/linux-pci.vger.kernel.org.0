Return-Path: <linux-pci+bounces-34977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52875B39621
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 10:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBC26805B0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 08:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38418B0A;
	Thu, 28 Aug 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lu5uG7yF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59805849C
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368221; cv=none; b=P5PQN0qWhTN3HtQAfN1h4QlM23qdv20nHVnQ2Kh6tJ6ijFBYkkfQFLcX7KXZvcZllKEM/D2r3wKvUeQ4ookTjDhAfj7RrPzdaa/1IhBTiGT7XUvX9rTQC4KJ4FpM+pG4gFKlAhduh5mpIGsYCjlGWDpAMsMOxiRMm+t+CQ7v0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368221; c=relaxed/simple;
	bh=lsTbHGlKdwz7J0QTbgdKjqMSZSSAcwjOhxnuot2uLYI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zjl738eA2ViAV2Y8rU9WiETX5vf4wg9uGR3KUw8NYvEXCMv9rFMBaVt/HsdZQr788ec4ElL9GfTxOCnELPUJ41VctOiRfgTtKfnPnE1vU4+3T5FMVd+wrKO1ArdGRKC+kR1bBHmOMeIcqguS22m1adIchrMQro5gs7ecwwau16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lu5uG7yF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756368219; x=1787904219;
  h=date:from:to:cc:subject:message-id;
  bh=lsTbHGlKdwz7J0QTbgdKjqMSZSSAcwjOhxnuot2uLYI=;
  b=lu5uG7yFl95lKsDWBU4/al5Xui0v9R1UHzG+NBjQrRf7lC9CNx+AZB/K
   4CHFnKZCgUulnA+bcxmFeWUfJ6D3m1ZS2VdQGpJzQnN5mMCQ1COa/RTzY
   sRsY/0lVoP+yV9YBhQIaYXFk+n6+6q4lP/7cDZN6WgunHnmTi+Itv1qn6
   t4Y7id4UuhNtwOjAW8maHdMRxZAOqPjhzspc04bLbKjCJfwBb9KrUut9S
   BN5CZmFIUh3sfzSl4wLivK7c49jzlr87etX6n4P9EwpKoPrLs5NrZVVy1
   vp42FgKPHtFQKo/B0lvb70tP1bPT2FPXs9CtIwqUarSGDMTIMt5mPWesw
   g==;
X-CSE-ConnectionGUID: KZ+h/QCGS/urGWllEzJCiw==
X-CSE-MsgGUID: x2Y0XmrTQ7ueUXqcqKjVHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58571413"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58571413"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:03:39 -0700
X-CSE-ConnectionGUID: alAXdE3tR5adtdkROt02Gg==
X-CSE-MsgGUID: Gro3tGerQ3CKWz7WdcpUrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="201010268"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 28 Aug 2025 01:03:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urXbW-000TTn-2g;
	Thu, 28 Aug 2025 08:03:32 +0000
Date: Thu, 28 Aug 2025 16:02:52 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-binding] BUILD SUCCESS
 6dd0ca9f2dfaab1bd15895bab16e5496632e53b6
Message-ID: <202508281642.LWRGMesq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-binding
branch HEAD: 6dd0ca9f2dfaab1bd15895bab16e5496632e53b6  dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750 compatible

elapsed time: 1028m

configs tested: 228
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250828    clang-22
arc                   randconfig-001-20250828    gcc-8.5.0
arc                   randconfig-002-20250828    clang-22
arc                   randconfig-002-20250828    gcc-14.3.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          pxa168_defconfig    gcc-15.1.0
arm                   randconfig-001-20250828    clang-22
arm                   randconfig-001-20250828    gcc-14.3.0
arm                   randconfig-002-20250828    clang-22
arm                   randconfig-002-20250828    gcc-10.5.0
arm                   randconfig-003-20250828    clang-22
arm                   randconfig-004-20250828    clang-22
arm                   randconfig-004-20250828    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250828    clang-22
arm64                 randconfig-002-20250828    clang-22
arm64                 randconfig-003-20250828    clang-22
arm64                 randconfig-003-20250828    gcc-15.1.0
arm64                 randconfig-004-20250828    clang-22
arm64                 randconfig-004-20250828    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250828    clang-22
csky                  randconfig-001-20250828    gcc-15.1.0
csky                  randconfig-002-20250828    clang-22
csky                  randconfig-002-20250828    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250828    clang-22
hexagon               randconfig-002-20250828    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250827    clang-20
i386        buildonly-randconfig-002-20250827    clang-20
i386        buildonly-randconfig-003-20250827    clang-20
i386        buildonly-randconfig-004-20250827    clang-20
i386        buildonly-randconfig-005-20250827    clang-20
i386        buildonly-randconfig-006-20250827    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250828    gcc-12
i386                  randconfig-002-20250828    gcc-12
i386                  randconfig-003-20250828    gcc-12
i386                  randconfig-004-20250828    gcc-12
i386                  randconfig-005-20250828    gcc-12
i386                  randconfig-006-20250828    gcc-12
i386                  randconfig-007-20250828    gcc-12
i386                  randconfig-011-20250828    clang-20
i386                  randconfig-012-20250828    clang-20
i386                  randconfig-013-20250828    clang-20
i386                  randconfig-014-20250828    clang-20
i386                  randconfig-015-20250828    clang-20
i386                  randconfig-016-20250828    clang-20
i386                  randconfig-017-20250828    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250828    clang-22
loongarch             randconfig-002-20250828    clang-22
loongarch             randconfig-002-20250828    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ci20_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250828    clang-22
nios2                 randconfig-001-20250828    gcc-8.5.0
nios2                 randconfig-002-20250828    clang-22
nios2                 randconfig-002-20250828    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250828    clang-22
parisc                randconfig-001-20250828    gcc-13.4.0
parisc                randconfig-002-20250828    clang-22
parisc                randconfig-002-20250828    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250828    clang-22
powerpc               randconfig-002-20250828    clang-22
powerpc               randconfig-002-20250828    gcc-8.5.0
powerpc               randconfig-003-20250828    clang-22
powerpc               randconfig-003-20250828    gcc-8.5.0
powerpc64             randconfig-001-20250828    clang-22
powerpc64             randconfig-001-20250828    gcc-10.5.0
powerpc64             randconfig-003-20250828    clang-22
powerpc64             randconfig-003-20250828    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250828    clang-19
riscv                 randconfig-001-20250828    clang-22
riscv                 randconfig-002-20250828    clang-19
riscv                 randconfig-002-20250828    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250828    clang-18
s390                  randconfig-001-20250828    clang-19
s390                  randconfig-002-20250828    clang-19
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250828    clang-19
sh                    randconfig-001-20250828    gcc-12.5.0
sh                    randconfig-002-20250828    clang-19
sh                    randconfig-002-20250828    gcc-14.3.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250828    clang-19
sparc                 randconfig-001-20250828    gcc-8.5.0
sparc                 randconfig-002-20250828    clang-19
sparc                 randconfig-002-20250828    gcc-12.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250828    clang-19
sparc64               randconfig-001-20250828    gcc-8.5.0
sparc64               randconfig-002-20250828    clang-19
sparc64               randconfig-002-20250828    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250828    clang-19
um                    randconfig-002-20250828    clang-19
um                    randconfig-002-20250828    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250828    gcc-12
x86_64      buildonly-randconfig-002-20250828    gcc-12
x86_64      buildonly-randconfig-003-20250828    clang-20
x86_64      buildonly-randconfig-003-20250828    gcc-12
x86_64      buildonly-randconfig-004-20250828    gcc-12
x86_64      buildonly-randconfig-005-20250828    gcc-12
x86_64      buildonly-randconfig-006-20250828    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250828    clang-20
x86_64                randconfig-002-20250828    clang-20
x86_64                randconfig-003-20250828    clang-20
x86_64                randconfig-004-20250828    clang-20
x86_64                randconfig-005-20250828    clang-20
x86_64                randconfig-006-20250828    clang-20
x86_64                randconfig-007-20250828    clang-20
x86_64                randconfig-008-20250828    clang-20
x86_64                randconfig-071-20250828    clang-20
x86_64                randconfig-072-20250828    clang-20
x86_64                randconfig-073-20250828    clang-20
x86_64                randconfig-074-20250828    clang-20
x86_64                randconfig-075-20250828    clang-20
x86_64                randconfig-076-20250828    clang-20
x86_64                randconfig-077-20250828    clang-20
x86_64                randconfig-078-20250828    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250828    clang-19
xtensa                randconfig-001-20250828    gcc-8.5.0
xtensa                randconfig-002-20250828    clang-19
xtensa                randconfig-002-20250828    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

