Return-Path: <linux-pci+bounces-27764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEC9AB78F7
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 00:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9DD189BAEF
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 22:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DBF1F0E20;
	Wed, 14 May 2025 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Elh0VbAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0081EB189
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747261057; cv=none; b=aVV0wJA1w6eJ/uje4p9qA1dqJayt097pAjZeFSbqZHg2/2Z+a2wZ7vjWUkHbgcneN3D12AcZ+aDbcylrpltMDXdxfvQ1QeWwTJhUdVWY2H2Hg3mxb4hJG4ARxMLJhlgyp9muMU7xufyqBbNhcaOfb9QgtkBcQbfSY7jM1Z5cFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747261057; c=relaxed/simple;
	bh=FRauUdP9bZDw6Z0Rf4lBIQNBgYKgOgq0ngfZ+D/1fPU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=blFQdJJcIP06/iPfquFON2VjlrJYK4rIvz9oMMzzCgTbcCQWUmZFG5vwujEPMPvdJsyxvsrRAJrDdHE0v77oEjnBB5mJnB/P3TCT8NsjMDgM6jpq/EkTTY03NgrWUoTlXFZCdvtjLvsPwd+qGOzJ+ycwXPIKvBMqaNyxHovOiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Elh0VbAD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747261056; x=1778797056;
  h=date:from:to:cc:subject:message-id;
  bh=FRauUdP9bZDw6Z0Rf4lBIQNBgYKgOgq0ngfZ+D/1fPU=;
  b=Elh0VbADqb5eRb/W0dPdgMpQVkv/4o71j/egu+v63B7GO16klRsA/OaG
   kIUxsoxjwSfhfvK1utxEF8WaDnrsrxjFZJMNBOTAHqJjQkFWsPlF/5Dk1
   L7F4NAqW1i/jIBXZOjBRML73TlY76daaI8DkPWBd5COlZOVEBAQZwVqHR
   LIppp6/N8zw6cgC4hJXwl3JNtLxZNq24AelGDJXzvo3MIxFsCzN9Yy3mO
   cayW5mJXq47IasIy15mFsKg/CxQk1ApHgPc0dHKrmDxYrK2LJ4wBi9mrj
   OCdKsPFEsj3MtxDOw681FHTiUuUD2QufK8DYqUVVCzgOSUqqJdQ6+vKg5
   A==;
X-CSE-ConnectionGUID: hvifUe0jTvSyQbOu/rkfeA==
X-CSE-MsgGUID: XxUQLxwASmGGj51teEVshQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49253179"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="49253179"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 15:17:23 -0700
X-CSE-ConnectionGUID: HFvZFLVbSlaciM/QEAcLFA==
X-CSE-MsgGUID: sI/ODD3yRmeI5yCXoJ1D0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="137898733"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 May 2025 15:17:21 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFKPf-000Hdr-28;
	Wed, 14 May 2025 22:17:19 +0000
Date: Thu, 15 May 2025 06:17:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2505-bjorn-aer-rate-limit-v6-rework] BUILD SUCCESS
 e380af1c10a3c6ec93d5b1b97265d7de705a065d
Message-ID: <202505150655.rWbOB2Xo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2505-bjorn-aer-rate-limit-v6-rework
branch HEAD: e380af1c10a3c6ec93d5b1b97265d7de705a065d  PCI/AER: Add sysfs attributes for log ratelimits

elapsed time: 1461m

configs tested: 232
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250514    clang-21
arc                   randconfig-001-20250514    gcc-13.3.0
arc                   randconfig-002-20250514    clang-21
arc                   randconfig-002-20250514    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250514    clang-21
arm                   randconfig-002-20250514    clang-21
arm                   randconfig-003-20250514    clang-21
arm                   randconfig-003-20250514    gcc-7.5.0
arm                   randconfig-004-20250514    clang-21
arm                   randconfig-004-20250514    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250514    clang-17
arm64                 randconfig-001-20250514    clang-21
arm64                 randconfig-002-20250514    clang-21
arm64                 randconfig-002-20250514    gcc-5.5.0
arm64                 randconfig-003-20250514    clang-21
arm64                 randconfig-003-20250514    gcc-5.5.0
arm64                 randconfig-004-20250514    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250514    gcc-10.5.0
csky                  randconfig-001-20250514    gcc-13.3.0
csky                  randconfig-002-20250514    gcc-10.5.0
csky                  randconfig-002-20250514    gcc-14.2.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250514    clang-21
hexagon               randconfig-001-20250514    gcc-10.5.0
hexagon               randconfig-002-20250514    clang-21
hexagon               randconfig-002-20250514    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250514    clang-20
i386        buildonly-randconfig-002-20250514    clang-20
i386        buildonly-randconfig-002-20250514    gcc-12
i386        buildonly-randconfig-003-20250514    clang-20
i386        buildonly-randconfig-004-20250514    clang-20
i386        buildonly-randconfig-005-20250514    clang-20
i386        buildonly-randconfig-005-20250514    gcc-12
i386        buildonly-randconfig-006-20250514    clang-20
i386        buildonly-randconfig-006-20250514    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250514    clang-20
i386                  randconfig-002-20250514    clang-20
i386                  randconfig-003-20250514    clang-20
i386                  randconfig-004-20250514    clang-20
i386                  randconfig-005-20250514    clang-20
i386                  randconfig-006-20250514    clang-20
i386                  randconfig-007-20250514    clang-20
i386                  randconfig-011-20250514    clang-20
i386                  randconfig-012-20250514    clang-20
i386                  randconfig-013-20250514    clang-20
i386                  randconfig-014-20250514    clang-20
i386                  randconfig-015-20250514    clang-20
i386                  randconfig-016-20250514    clang-20
i386                  randconfig-017-20250514    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250514    gcc-10.5.0
loongarch             randconfig-001-20250514    gcc-14.2.0
loongarch             randconfig-002-20250514    gcc-10.5.0
loongarch             randconfig-002-20250514    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250514    gcc-10.5.0
nios2                 randconfig-001-20250514    gcc-7.5.0
nios2                 randconfig-002-20250514    gcc-10.5.0
nios2                 randconfig-002-20250514    gcc-11.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250514    gcc-10.5.0
parisc                randconfig-001-20250514    gcc-12.4.0
parisc                randconfig-002-20250514    gcc-10.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250514    clang-17
powerpc               randconfig-001-20250514    gcc-10.5.0
powerpc               randconfig-002-20250514    gcc-10.5.0
powerpc               randconfig-002-20250514    gcc-5.5.0
powerpc               randconfig-003-20250514    gcc-10.5.0
powerpc               randconfig-003-20250514    gcc-7.5.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250514    gcc-10.5.0
powerpc64             randconfig-002-20250514    clang-19
powerpc64             randconfig-002-20250514    gcc-10.5.0
powerpc64             randconfig-003-20250514    gcc-5.5.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250514    clang-21
riscv                 randconfig-001-20250514    gcc-7.5.0
riscv                 randconfig-002-20250514    clang-21
riscv                 randconfig-002-20250514    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250514    clang-21
s390                  randconfig-002-20250514    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250514    clang-21
sh                    randconfig-001-20250514    gcc-11.5.0
sh                    randconfig-002-20250514    clang-21
sh                    randconfig-002-20250514    gcc-9.3.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250514    clang-21
sparc                 randconfig-001-20250514    gcc-8.5.0
sparc                 randconfig-002-20250514    clang-21
sparc                 randconfig-002-20250514    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250514    clang-21
sparc64               randconfig-001-20250514    gcc-14.2.0
sparc64               randconfig-002-20250514    clang-21
sparc64               randconfig-002-20250514    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250514    clang-21
um                    randconfig-001-20250514    gcc-12
um                    randconfig-002-20250514    clang-21
um                    randconfig-002-20250514    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250514    clang-20
x86_64      buildonly-randconfig-001-20250514    gcc-12
x86_64      buildonly-randconfig-002-20250514    gcc-12
x86_64      buildonly-randconfig-003-20250514    gcc-12
x86_64      buildonly-randconfig-004-20250514    gcc-12
x86_64      buildonly-randconfig-005-20250514    clang-20
x86_64      buildonly-randconfig-005-20250514    gcc-12
x86_64      buildonly-randconfig-006-20250514    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250514    gcc-12
x86_64                randconfig-002-20250514    gcc-12
x86_64                randconfig-003-20250514    gcc-12
x86_64                randconfig-004-20250514    gcc-12
x86_64                randconfig-005-20250514    gcc-12
x86_64                randconfig-006-20250514    gcc-12
x86_64                randconfig-007-20250514    gcc-12
x86_64                randconfig-008-20250514    gcc-12
x86_64                randconfig-071-20250514    clang-20
x86_64                randconfig-072-20250514    clang-20
x86_64                randconfig-073-20250514    clang-20
x86_64                randconfig-074-20250514    clang-20
x86_64                randconfig-075-20250514    clang-20
x86_64                randconfig-076-20250514    clang-20
x86_64                randconfig-077-20250514    clang-20
x86_64                randconfig-078-20250514    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250514    clang-21
xtensa                randconfig-001-20250514    gcc-10.5.0
xtensa                randconfig-002-20250514    clang-21
xtensa                randconfig-002-20250514    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

