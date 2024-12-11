Return-Path: <linux-pci+bounces-18162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEABE9ED2A8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A2E1881899
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453F1DDC19;
	Wed, 11 Dec 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ivkm9B5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E11DDC13
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935823; cv=none; b=aIDMnMYbB0r9kXxYDjGgotK9dATPoXhsj928GKcMlrcffdaik0vPJDb3RbzRC4eECzL/4P298RZI2lNeh2XiCOwqgx8K0VBmAxFQUDVClqR2pmjE9xv0iPjjMoJJUDtMU5KQQOoQgT6W0ARFxNkoOboW3Ziz8fcoMzYvTzYYLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935823; c=relaxed/simple;
	bh=PlScYcND9LMBy3lFEUH7PLM7O29zzH7La9Zj2Mus/cA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ir4iDkjqcVAaYZ+Wf5N3W1JupvREaCkkvqfjvMZdkUryhirHDGGWj9L1yGFCkxw49dRcVh/1Y+dUP5Q48OIw4lrEkwdXQWCrNrcJVwkyw3fP9GoF186sbEagHswLcAKjdqlfS/pdMuT/zyqnd+cswF+zkIV6PPF9/oCbrxD8kEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ivkm9B5a; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733935822; x=1765471822;
  h=date:from:to:cc:subject:message-id;
  bh=PlScYcND9LMBy3lFEUH7PLM7O29zzH7La9Zj2Mus/cA=;
  b=Ivkm9B5ad+kB8sLfyi4FfeqiySdQqx1gUmm9CSHJg2mSMs//u5NLMf+c
   viewb9N0aLDWAv4s2hFzwX/XpaV4ZTAJqkcQ3800sotIwEJ84yZohWovI
   NiJX9jVNR6l8FZX+vmenUaz8g22cN2Lq9VaKu1AsBvaGDgQU6cW+4HdtH
   kxewkE5Wgix8/cHHEJQ2hfyKBuD6qd1rIHU5J+nMUY5vw4HGJzQFA+fBc
   aD/7kcs9N1eRtzKEmQDwiOcnVup4U9QaIuyM1By9C6FcU8hjIUFyJkfac
   3jUXvJIfQuRIRnFBM4liy8QRojqrFJ+lGHnBkdkrpudoO1LMHuXyFywz2
   A==;
X-CSE-ConnectionGUID: ZJUOuKV1SQ+6LWDO7hqC3g==
X-CSE-MsgGUID: By9oMTmJRy2Df3jcFgeKiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="38011210"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="38011210"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 08:50:22 -0800
X-CSE-ConnectionGUID: 65zXIg/fSSikYYHxE72xKA==
X-CSE-MsgGUID: 6kBuumgdR+mKDfobxjJVFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="126697779"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Dec 2024 08:50:20 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLPuj-0006tt-2R;
	Wed, 11 Dec 2024 16:50:17 +0000
Date: Thu, 12 Dec 2024 00:49:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:constify] BUILD SUCCESS
 d5bdde0b38c1d17f39ad6d41d16af33357b329b2
Message-ID: <202412120032.pLxkjQ4T-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git constify
branch HEAD: d5bdde0b38c1d17f39ad6d41d16af33357b329b2  PCI/ACPI: Constify 'struct bin_attribute'

elapsed time: 1259m

configs tested: 211
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241211    gcc-13.2.0
arc                   randconfig-001-20241211    gcc-14.2.0
arc                   randconfig-002-20241211    gcc-13.2.0
arc                   randconfig-002-20241211    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    clang-20
arm                   randconfig-001-20241211    clang-18
arm                   randconfig-001-20241211    gcc-14.2.0
arm                   randconfig-002-20241211    gcc-14.2.0
arm                   randconfig-003-20241211    clang-20
arm                   randconfig-003-20241211    gcc-14.2.0
arm                   randconfig-004-20241211    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241211    gcc-14.2.0
arm64                 randconfig-002-20241211    clang-18
arm64                 randconfig-002-20241211    gcc-14.2.0
arm64                 randconfig-003-20241211    gcc-14.2.0
arm64                 randconfig-004-20241211    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241211    gcc-14.2.0
csky                  randconfig-002-20241211    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241211    clang-20
hexagon               randconfig-001-20241211    gcc-14.2.0
hexagon               randconfig-002-20241211    clang-17
hexagon               randconfig-002-20241211    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241211    clang-19
i386        buildonly-randconfig-002-20241211    clang-19
i386        buildonly-randconfig-002-20241211    gcc-11
i386        buildonly-randconfig-003-20241211    clang-19
i386        buildonly-randconfig-004-20241211    clang-19
i386        buildonly-randconfig-004-20241211    gcc-11
i386        buildonly-randconfig-005-20241211    clang-19
i386        buildonly-randconfig-005-20241211    gcc-12
i386        buildonly-randconfig-006-20241211    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241211    gcc-12
i386                  randconfig-002-20241211    gcc-12
i386                  randconfig-003-20241211    gcc-12
i386                  randconfig-004-20241211    gcc-12
i386                  randconfig-005-20241211    gcc-12
i386                  randconfig-006-20241211    gcc-12
i386                  randconfig-007-20241211    gcc-12
i386                  randconfig-011-20241211    gcc-12
i386                  randconfig-012-20241211    gcc-12
i386                  randconfig-013-20241211    gcc-12
i386                  randconfig-014-20241211    gcc-12
i386                  randconfig-015-20241211    gcc-12
i386                  randconfig-016-20241211    gcc-12
i386                  randconfig-017-20241211    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241211    gcc-14.2.0
loongarch             randconfig-002-20241211    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241211    gcc-14.2.0
nios2                 randconfig-002-20241211    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241211    gcc-14.2.0
parisc                randconfig-002-20241211    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241211    clang-18
powerpc               randconfig-001-20241211    gcc-14.2.0
powerpc               randconfig-002-20241211    clang-16
powerpc               randconfig-002-20241211    gcc-14.2.0
powerpc               randconfig-003-20241211    gcc-14.2.0
powerpc                     skiroot_defconfig    clang-20
powerpc                         wii_defconfig    clang-20
powerpc64             randconfig-001-20241211    gcc-14.2.0
powerpc64             randconfig-002-20241211    clang-20
powerpc64             randconfig-002-20241211    gcc-14.2.0
powerpc64             randconfig-003-20241211    clang-20
powerpc64             randconfig-003-20241211    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-20
riscv                 randconfig-001-20241211    clang-20
riscv                 randconfig-001-20241211    gcc-14.2.0
riscv                 randconfig-002-20241211    clang-20
riscv                 randconfig-002-20241211    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241211    clang-20
s390                  randconfig-002-20241211    clang-20
s390                  randconfig-002-20241211    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-20
sh                    randconfig-001-20241211    clang-20
sh                    randconfig-001-20241211    gcc-14.2.0
sh                    randconfig-002-20241211    clang-20
sh                    randconfig-002-20241211    gcc-14.2.0
sh                   sh7770_generic_defconfig    clang-20
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241211    clang-20
sparc                 randconfig-001-20241211    gcc-14.2.0
sparc                 randconfig-002-20241211    clang-20
sparc                 randconfig-002-20241211    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241211    clang-20
sparc64               randconfig-001-20241211    gcc-14.2.0
sparc64               randconfig-002-20241211    clang-20
sparc64               randconfig-002-20241211    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241211    clang-20
um                    randconfig-001-20241211    gcc-12
um                    randconfig-002-20241211    clang-20
um                    randconfig-002-20241211    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241211    gcc-12
x86_64      buildonly-randconfig-002-20241211    gcc-11
x86_64      buildonly-randconfig-002-20241211    gcc-12
x86_64      buildonly-randconfig-003-20241211    gcc-12
x86_64      buildonly-randconfig-004-20241211    gcc-12
x86_64      buildonly-randconfig-005-20241211    gcc-12
x86_64      buildonly-randconfig-006-20241211    clang-19
x86_64      buildonly-randconfig-006-20241211    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241211    clang-19
x86_64                randconfig-002-20241211    clang-19
x86_64                randconfig-003-20241211    clang-19
x86_64                randconfig-004-20241211    clang-19
x86_64                randconfig-005-20241211    clang-19
x86_64                randconfig-006-20241211    clang-19
x86_64                randconfig-007-20241211    clang-19
x86_64                randconfig-008-20241211    clang-19
x86_64                randconfig-071-20241211    clang-19
x86_64                randconfig-072-20241211    clang-19
x86_64                randconfig-073-20241211    clang-19
x86_64                randconfig-074-20241211    clang-19
x86_64                randconfig-075-20241211    clang-19
x86_64                randconfig-076-20241211    clang-19
x86_64                randconfig-077-20241211    clang-19
x86_64                randconfig-078-20241211    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241211    clang-20
xtensa                randconfig-001-20241211    gcc-14.2.0
xtensa                randconfig-002-20241211    clang-20
xtensa                randconfig-002-20241211    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

