Return-Path: <linux-pci+bounces-33842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D525FB21F7A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 09:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C942E7B1BF7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9150C271A7B;
	Tue, 12 Aug 2025 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7QTsC+1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6A1EA6F
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983646; cv=none; b=oieJJZZgDUkRtPpkG9ShR+wG9OSrw6/o3ItvBWpS4nD0Zn2gAiL18kGXhFOSwsaOzsr567HQ7t/kvKh6PguRznEFsslyBNOIdS9CvOyjM2x8ycoGuon+H810MBSFrDJ0o7yvgAdVEtJ69KxlvrgDxzoI5NGAFPQVdU/w3irmfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983646; c=relaxed/simple;
	bh=XD68l8k3aGFkKI6rgdZ8Deh4vqo7T8q9eVh7Uzp+9lI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gOmIL/51Mf9Y5jt+ZR4yObiWFtE8+Ho8J4dsNWLjcYASNwJGrpWcPDZzWu054HY19Ik9cxe1SXdLjtkwGd/edB0ryvzj3uXxVB0ueXNim1r6oKOR+z/Fjb1LCQzP1TiOP33bL3wZdkUDUNBiUNY3L3F2CaujQ7ImoN7mEMVTUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7QTsC+1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754983645; x=1786519645;
  h=date:from:to:cc:subject:message-id;
  bh=XD68l8k3aGFkKI6rgdZ8Deh4vqo7T8q9eVh7Uzp+9lI=;
  b=J7QTsC+1vsmk7f/iztWyJoGIC3SlLh/sFwSn5dNIzgEJ5Hf9lTVrUW6+
   6tEBor1fK73JvmzNBJAX1Yb5HyMoxg9EcW0IA3LVc/lDcac8Ad7QBVgu9
   e1cPTENM1ZDH0RFJPWW8Lb2Z1hszDZlxWCgNFwx9VFIlq30bxFhbF7Bbd
   Yl7XzTVenk3SEVZERfeIzFrD/f+UB2NpTqUYbWyIsv0IHi/rDfWuyMqSE
   u9aXmkfz4xAhftq84YblVvLqsCg0UIg60wibj/fOS+NGrB/z/012d69xj
   bAHkjD3hub9s20Ml0M7uqaV+UXyrBxoR7N8WznTnXeMg949YhAhGrM/RA
   g==;
X-CSE-ConnectionGUID: SKO05GalQbKwWgNQcU/RKw==
X-CSE-MsgGUID: XDqBHxXASAasx1Qs0ELvKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57152210"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57152210"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 00:27:24 -0700
X-CSE-ConnectionGUID: PFvO+hMrSVeGlnKFQLSj0Q==
X-CSE-MsgGUID: Ay52kR+5R2KUGJRAT+fRKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="197127582"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 12 Aug 2025 00:27:23 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uljPk-0006V6-2a;
	Tue, 12 Aug 2025 07:27:20 +0000
Date: Tue, 12 Aug 2025 15:26:07 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rcar-gen4] BUILD SUCCESS
 d96ac5bdc52b271b4f8ac0670a203913666b8758
Message-ID: <202508121501.JZCMT83L-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar-gen4
branch HEAD: d96ac5bdc52b271b4f8ac0670a203913666b8758  PCI: rcar-gen4: Fix PHY initialization

elapsed time: 1199m

configs tested: 247
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250811    gcc-8.5.0
arc                   randconfig-001-20250812    gcc-14.3.0
arc                   randconfig-002-20250811    gcc-10.5.0
arc                   randconfig-002-20250812    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           omap1_defconfig    clang-22
arm                   randconfig-001-20250811    gcc-10.5.0
arm                   randconfig-001-20250812    gcc-14.3.0
arm                   randconfig-002-20250811    gcc-13.4.0
arm                   randconfig-002-20250812    gcc-14.3.0
arm                   randconfig-003-20250811    clang-22
arm                   randconfig-003-20250812    gcc-14.3.0
arm                   randconfig-004-20250811    gcc-10.5.0
arm                   randconfig-004-20250812    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                               defconfig    clang-22
arm64                 randconfig-001-20250811    clang-22
arm64                 randconfig-001-20250812    gcc-14.3.0
arm64                 randconfig-002-20250811    clang-19
arm64                 randconfig-002-20250812    gcc-14.3.0
arm64                 randconfig-003-20250811    clang-20
arm64                 randconfig-003-20250812    gcc-14.3.0
arm64                 randconfig-004-20250811    clang-22
arm64                 randconfig-004-20250812    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250811    gcc-15.1.0
csky                  randconfig-001-20250812    gcc-12.5.0
csky                  randconfig-002-20250811    gcc-15.1.0
csky                  randconfig-002-20250812    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250811    clang-17
hexagon               randconfig-001-20250812    gcc-12.5.0
hexagon               randconfig-002-20250811    clang-16
hexagon               randconfig-002-20250812    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250811    clang-20
i386        buildonly-randconfig-001-20250812    gcc-12
i386        buildonly-randconfig-002-20250811    clang-20
i386        buildonly-randconfig-002-20250812    gcc-12
i386        buildonly-randconfig-003-20250811    gcc-12
i386        buildonly-randconfig-003-20250812    gcc-12
i386        buildonly-randconfig-004-20250811    gcc-12
i386        buildonly-randconfig-004-20250812    gcc-12
i386        buildonly-randconfig-005-20250811    gcc-12
i386        buildonly-randconfig-005-20250812    gcc-12
i386        buildonly-randconfig-006-20250811    gcc-12
i386        buildonly-randconfig-006-20250812    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250812    clang-20
i386                  randconfig-002-20250812    clang-20
i386                  randconfig-003-20250812    clang-20
i386                  randconfig-004-20250812    clang-20
i386                  randconfig-005-20250812    clang-20
i386                  randconfig-006-20250812    clang-20
i386                  randconfig-007-20250812    clang-20
i386                  randconfig-011-20250812    gcc-12
i386                  randconfig-012-20250812    gcc-12
i386                  randconfig-013-20250812    gcc-12
i386                  randconfig-014-20250812    gcc-12
i386                  randconfig-015-20250812    gcc-12
i386                  randconfig-016-20250812    gcc-12
i386                  randconfig-017-20250812    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250811    gcc-15.1.0
loongarch             randconfig-001-20250812    gcc-12.5.0
loongarch             randconfig-002-20250811    gcc-12.5.0
loongarch             randconfig-002-20250812    gcc-12.5.0
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
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250811    gcc-10.5.0
nios2                 randconfig-001-20250812    gcc-12.5.0
nios2                 randconfig-002-20250811    gcc-11.5.0
nios2                 randconfig-002-20250812    gcc-12.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250811    gcc-9.5.0
parisc                randconfig-001-20250812    gcc-12.5.0
parisc                randconfig-002-20250811    gcc-14.3.0
parisc                randconfig-002-20250812    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      katmai_defconfig    clang-22
powerpc               randconfig-001-20250811    gcc-13.4.0
powerpc               randconfig-001-20250812    gcc-12.5.0
powerpc               randconfig-002-20250811    clang-22
powerpc               randconfig-002-20250812    gcc-12.5.0
powerpc               randconfig-003-20250811    gcc-13.4.0
powerpc               randconfig-003-20250812    gcc-12.5.0
powerpc64             randconfig-001-20250811    clang-22
powerpc64             randconfig-001-20250812    gcc-12.5.0
powerpc64             randconfig-002-20250811    clang-22
powerpc64             randconfig-002-20250812    gcc-12.5.0
powerpc64             randconfig-003-20250811    gcc-14.3.0
powerpc64             randconfig-003-20250812    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250811    gcc-8.5.0
riscv                 randconfig-001-20250812    clang-18
riscv                 randconfig-002-20250811    clang-22
riscv                 randconfig-002-20250812    clang-18
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250811    gcc-8.5.0
s390                  randconfig-001-20250812    clang-18
s390                  randconfig-002-20250811    clang-17
s390                  randconfig-002-20250812    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20250811    gcc-15.1.0
sh                    randconfig-001-20250812    clang-18
sh                    randconfig-002-20250811    gcc-15.1.0
sh                    randconfig-002-20250812    clang-18
sh                             sh03_defconfig    clang-22
sh                     sh7710voipgw_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250811    gcc-8.5.0
sparc                 randconfig-001-20250812    clang-18
sparc                 randconfig-002-20250811    gcc-8.5.0
sparc                 randconfig-002-20250812    clang-18
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250811    clang-22
sparc64               randconfig-001-20250812    clang-18
sparc64               randconfig-002-20250811    gcc-14.3.0
sparc64               randconfig-002-20250812    clang-18
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250811    clang-18
um                    randconfig-001-20250812    clang-18
um                    randconfig-002-20250811    clang-22
um                    randconfig-002-20250812    clang-18
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250811    gcc-12
x86_64      buildonly-randconfig-001-20250812    gcc-12
x86_64      buildonly-randconfig-002-20250811    clang-20
x86_64      buildonly-randconfig-002-20250812    gcc-12
x86_64      buildonly-randconfig-003-20250811    clang-20
x86_64      buildonly-randconfig-003-20250812    gcc-12
x86_64      buildonly-randconfig-004-20250811    clang-20
x86_64      buildonly-randconfig-004-20250812    gcc-12
x86_64      buildonly-randconfig-005-20250811    clang-20
x86_64      buildonly-randconfig-005-20250812    gcc-12
x86_64      buildonly-randconfig-006-20250811    clang-20
x86_64      buildonly-randconfig-006-20250812    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250812    gcc-11
x86_64                randconfig-002-20250812    gcc-11
x86_64                randconfig-003-20250812    gcc-11
x86_64                randconfig-004-20250812    gcc-11
x86_64                randconfig-005-20250812    gcc-11
x86_64                randconfig-006-20250812    gcc-11
x86_64                randconfig-007-20250812    gcc-11
x86_64                randconfig-008-20250812    gcc-11
x86_64                randconfig-071-20250812    clang-20
x86_64                randconfig-072-20250812    clang-20
x86_64                randconfig-073-20250812    clang-20
x86_64                randconfig-074-20250812    clang-20
x86_64                randconfig-075-20250812    clang-20
x86_64                randconfig-076-20250812    clang-20
x86_64                randconfig-077-20250812    clang-20
x86_64                randconfig-078-20250812    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250811    gcc-9.5.0
xtensa                randconfig-001-20250812    clang-18
xtensa                randconfig-002-20250811    gcc-9.5.0
xtensa                randconfig-002-20250812    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

