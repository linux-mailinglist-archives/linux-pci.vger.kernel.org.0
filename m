Return-Path: <linux-pci+bounces-36591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21344B8CA3E
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DE85801CA
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970ED20468E;
	Sat, 20 Sep 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nhh4DZcJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38441E260D
	for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758378189; cv=none; b=LlsVhUrXMAy02b1th/XJpDg21X3WFrEHzz29LEesorrhzgmmbLd/2XyZqEKrDY6AKaa/hRIYCpq1G82Yq3MxGNhPgWWJlkB6Npg6JzXsYqEFahDBiGW+Ny09ME+piAd8ULO6ZbJEj9dNy9eV9Dj49rKYeIClvl0ZJaJhi+npXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758378189; c=relaxed/simple;
	bh=l6I36y/TjMTq6x6H6zCe1jPZdmtnX3ltL0sGikNG3XM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=D1e85H43j6d4sfEkxSszya4xzKPc70sB1+xV9nvNXsBw9ow5//NC+ChpkcLoTcosBNl+EVel3Mhb4sV9sAichMwATVlsxhzMqXDADLzLGbJ7M7t1agdWefz9DC1WkCL+pKarUK2TwAAdKT+t90nggJJAjVOA62pkvL/KmONhAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nhh4DZcJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758378188; x=1789914188;
  h=date:from:to:cc:subject:message-id;
  bh=l6I36y/TjMTq6x6H6zCe1jPZdmtnX3ltL0sGikNG3XM=;
  b=Nhh4DZcJ22hJLuNF0nmlmbs+OBNkp1yk5snbLmB4aT+KGBNw1lV3eQBQ
   YwC1g6Z3dzAxb7HrcIcwr0cgeF45BH8JXg0tyNNDElwDe56LYtd4Gsq7U
   Ah1RuRqbkfwkePLHK8UGP+ebVTQ8EWvmO9TZcTGKIKLj6bmpjz7OV78mW
   0j2g1WyeSDLgNTahZQYxMKJBpcBc4KlAN7TnlqfylJZm/Q1fbO0P7nbHF
   PlNRVatkKf50q58uKSIbLaIfQJsXWuOEDFEH4cOkAAqOsvUizdgYG/GME
   r15+ty4MYMxd7aTcdJ0XdNC4Z4XPUTVoLaX0G19+Z0TFrLjbj+SStWWai
   A==;
X-CSE-ConnectionGUID: r/LkX5+lRD2VJ7d/2oVCwg==
X-CSE-MsgGUID: +GuclB8QSj2u02WumCoDsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="64340699"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="64340699"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 07:23:07 -0700
X-CSE-ConnectionGUID: FZ0N4QJfTZy3e/zPDJtLtw==
X-CSE-MsgGUID: OAsNlXaRShmvWHw9SZpBKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; 
   d="scan'208";a="175216695"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Sep 2025 07:23:06 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzyUQ-0005NT-2Y;
	Sat, 20 Sep 2025 14:23:02 +0000
Date: Sat, 20 Sep 2025 22:22:28 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/sophgo] BUILD SUCCESS
 1c72774df028429836eec3394212f2921bb830fc
Message-ID: <202509202222.5WydsUKn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/sophgo
branch HEAD: 1c72774df028429836eec3394212f2921bb830fc  PCI: sg2042: Add Sophgo SG2042 PCIe driver

elapsed time: 1133m

configs tested: 223
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250920    gcc-9.5.0
arc                   randconfig-002-20250920    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                            mmp2_defconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250920    gcc-12.5.0
arm                   randconfig-001-20250920    gcc-9.5.0
arm                   randconfig-002-20250920    clang-22
arm                   randconfig-002-20250920    gcc-9.5.0
arm                   randconfig-003-20250920    clang-22
arm                   randconfig-003-20250920    gcc-9.5.0
arm                   randconfig-004-20250920    clang-22
arm                   randconfig-004-20250920    gcc-9.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250920    clang-20
arm64                 randconfig-001-20250920    gcc-9.5.0
arm64                 randconfig-002-20250920    clang-22
arm64                 randconfig-002-20250920    gcc-9.5.0
arm64                 randconfig-003-20250920    clang-18
arm64                 randconfig-003-20250920    gcc-9.5.0
arm64                 randconfig-004-20250920    clang-22
arm64                 randconfig-004-20250920    gcc-9.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250920    clang-16
csky                  randconfig-001-20250920    gcc-10.5.0
csky                  randconfig-002-20250920    clang-16
csky                  randconfig-002-20250920    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250920    clang-16
hexagon               randconfig-001-20250920    clang-22
hexagon               randconfig-002-20250920    clang-16
hexagon               randconfig-002-20250920    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250920    clang-20
i386        buildonly-randconfig-001-20250920    gcc-13
i386        buildonly-randconfig-002-20250920    clang-20
i386        buildonly-randconfig-002-20250920    gcc-13
i386        buildonly-randconfig-003-20250920    clang-20
i386        buildonly-randconfig-003-20250920    gcc-13
i386        buildonly-randconfig-004-20250920    gcc-13
i386        buildonly-randconfig-005-20250920    clang-20
i386        buildonly-randconfig-005-20250920    gcc-13
i386        buildonly-randconfig-006-20250920    clang-20
i386        buildonly-randconfig-006-20250920    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20250920    clang-20
i386                  randconfig-002-20250920    clang-20
i386                  randconfig-003-20250920    clang-20
i386                  randconfig-004-20250920    clang-20
i386                  randconfig-005-20250920    clang-20
i386                  randconfig-006-20250920    clang-20
i386                  randconfig-007-20250920    clang-20
i386                  randconfig-011-20250920    gcc-14
i386                  randconfig-012-20250920    gcc-14
i386                  randconfig-013-20250920    gcc-14
i386                  randconfig-014-20250920    gcc-14
i386                  randconfig-015-20250920    gcc-14
i386                  randconfig-016-20250920    gcc-14
i386                  randconfig-017-20250920    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250920    clang-16
loongarch             randconfig-001-20250920    clang-22
loongarch             randconfig-002-20250920    clang-16
loongarch             randconfig-002-20250920    gcc-12.5.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250920    clang-16
nios2                 randconfig-001-20250920    gcc-9.5.0
nios2                 randconfig-002-20250920    clang-16
nios2                 randconfig-002-20250920    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250920    clang-16
parisc                randconfig-001-20250920    gcc-8.5.0
parisc                randconfig-002-20250920    clang-16
parisc                randconfig-002-20250920    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250920    clang-16
powerpc               randconfig-001-20250920    clang-17
powerpc               randconfig-002-20250920    clang-16
powerpc               randconfig-002-20250920    clang-22
powerpc               randconfig-003-20250920    clang-16
powerpc               randconfig-003-20250920    clang-22
powerpc                     taishan_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250920    clang-16
powerpc64             randconfig-002-20250920    clang-16
powerpc64             randconfig-002-20250920    gcc-10.5.0
powerpc64             randconfig-003-20250920    clang-16
powerpc64             randconfig-003-20250920    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250920    clang-22
riscv                 randconfig-001-20250920    gcc-14.3.0
riscv                 randconfig-002-20250920    clang-22
riscv                 randconfig-002-20250920    gcc-14.3.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250920    clang-20
s390                  randconfig-001-20250920    gcc-14.3.0
s390                  randconfig-002-20250920    gcc-14.3.0
s390                  randconfig-002-20250920    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250920    gcc-14.3.0
sh                    randconfig-002-20250920    gcc-12.5.0
sh                    randconfig-002-20250920    gcc-14.3.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250920    gcc-14.3.0
sparc                 randconfig-001-20250920    gcc-8.5.0
sparc                 randconfig-002-20250920    gcc-14.3.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250920    gcc-14.3.0
sparc64               randconfig-001-20250920    gcc-8.5.0
sparc64               randconfig-002-20250920    gcc-14.3.0
sparc64               randconfig-002-20250920    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250920    clang-22
um                    randconfig-001-20250920    gcc-14.3.0
um                    randconfig-002-20250920    clang-22
um                    randconfig-002-20250920    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250920    clang-20
x86_64      buildonly-randconfig-001-20250920    gcc-14
x86_64      buildonly-randconfig-002-20250920    clang-20
x86_64      buildonly-randconfig-002-20250920    gcc-14
x86_64      buildonly-randconfig-003-20250920    clang-20
x86_64      buildonly-randconfig-003-20250920    gcc-14
x86_64      buildonly-randconfig-004-20250920    clang-20
x86_64      buildonly-randconfig-004-20250920    gcc-14
x86_64      buildonly-randconfig-005-20250920    gcc-14
x86_64      buildonly-randconfig-006-20250920    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250920    clang-20
x86_64                randconfig-002-20250920    clang-20
x86_64                randconfig-003-20250920    clang-20
x86_64                randconfig-004-20250920    clang-20
x86_64                randconfig-005-20250920    clang-20
x86_64                randconfig-006-20250920    clang-20
x86_64                randconfig-007-20250920    clang-20
x86_64                randconfig-008-20250920    clang-20
x86_64                randconfig-071-20250920    clang-20
x86_64                randconfig-072-20250920    clang-20
x86_64                randconfig-073-20250920    clang-20
x86_64                randconfig-074-20250920    clang-20
x86_64                randconfig-075-20250920    clang-20
x86_64                randconfig-076-20250920    clang-20
x86_64                randconfig-077-20250920    clang-20
x86_64                randconfig-078-20250920    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250920    gcc-14.3.0
xtensa                randconfig-001-20250920    gcc-8.5.0
xtensa                randconfig-002-20250920    gcc-14.3.0
xtensa                randconfig-002-20250920    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

