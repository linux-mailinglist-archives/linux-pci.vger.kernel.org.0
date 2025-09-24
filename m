Return-Path: <linux-pci+bounces-36912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 939CEB9CB83
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 01:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E1A163CE4
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 23:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515B626F2BE;
	Wed, 24 Sep 2025 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBpojoH6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077011185
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757967; cv=none; b=lOrblFUP86hYxp3NbAWz9nxPj+mBpE5kJGky1tAl+Yi+Xx9ASIGPpJj+M+HNTW+Wi/SrPY3f4r84nl/RlnhLF7UIRSTH06uCmgmOoUqYJ8lWeAn0MEG1ep91TJDN51XU/GrpMOODCYFBMLxPoCYGtKTqVDQCZG7bvr7IBqSxrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757967; c=relaxed/simple;
	bh=5n5K9B5NPtFiqRR+6tECKlC7ytGgna4WaeEygDuyyK0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FhN0Qp8YAuow+trJfFFzHccZLQZ3q166YhGTfSe+o6K+CSSyYtsiVS8/7fN9mz6BRA/eruvUGbgJ6iAt0HuK8d75JWZwWh4t8Ka8HlgZoCpHFFbLHP5sMDe2jc8CxrnU0twpfD8PFiPH1oyPwWav/xsXVxoQwoqtONy54lLPCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBpojoH6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758757965; x=1790293965;
  h=date:from:to:cc:subject:message-id;
  bh=5n5K9B5NPtFiqRR+6tECKlC7ytGgna4WaeEygDuyyK0=;
  b=NBpojoH6oi8G0+wy+DU/X+Qg45Vb6F6yhyRysfkv9xmekOKfKCPMHNy4
   tKRLhGDVhtZoJEcWkVG8H6hdrn9y6HY7XbULsJq61mQhFFyVcMmhX4Sa1
   QuIaB6uzI1loV1MA4BynEgk1OjWxA+vT18RB0Du+K/O4G3+WQR1mA/OTB
   v6OzUd31ADRVMZ+izI26OFfiTEBmTm69uC7hL+GHDGtrmWd+SWMbgZ98k
   LmmypEiwb2QTm7UznErz//Ajvegt+L1/cxGO2ZAfZVd7oJhW1/u2mUn+F
   OWc12jOBlJVTXt1M9jzd1r14N5MND/ngiyp98EC6ud2UyEZjJ96uYi/ui
   Q==;
X-CSE-ConnectionGUID: Tvmx66lBQyuRtL4JJP6t6g==
X-CSE-MsgGUID: GTtkB76lRg2XDsbvK8UPfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="72423851"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="72423851"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 16:52:44 -0700
X-CSE-ConnectionGUID: NuDC38D7TkuWmm9MKEFMRw==
X-CSE-MsgGUID: 2wjKasXDRQ2P8zhxerjsyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="214298426"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2025 16:52:42 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1ZHr-0004hT-37;
	Wed, 24 Sep 2025 23:52:39 +0000
Date: Thu, 25 Sep 2025 07:51:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 a729c16646198872e345bf6c48dbe540ad8a9753
Message-ID: <202509250737.M8g1x5T4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: a729c16646198872e345bf6c48dbe540ad8a9753  PCI: qcom: Remove custom ASPM enablement code

elapsed time: 1475m

configs tested: 271
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250924    gcc-11.5.0
arc                   randconfig-002-20250924    gcc-11.5.0
arc                   randconfig-002-20250924    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250924    clang-22
arm                   randconfig-001-20250924    gcc-11.5.0
arm                   randconfig-002-20250924    clang-22
arm                   randconfig-002-20250924    gcc-11.5.0
arm                   randconfig-003-20250924    clang-22
arm                   randconfig-003-20250924    gcc-11.5.0
arm                   randconfig-004-20250924    gcc-11.5.0
arm                   randconfig-004-20250924    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250924    gcc-11.5.0
arm64                 randconfig-001-20250924    gcc-14.3.0
arm64                 randconfig-002-20250924    clang-18
arm64                 randconfig-002-20250924    gcc-11.5.0
arm64                 randconfig-003-20250924    gcc-11.5.0
arm64                 randconfig-003-20250924    gcc-12.5.0
arm64                 randconfig-004-20250924    clang-22
arm64                 randconfig-004-20250924    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250924    clang-22
csky                  randconfig-001-20250924    gcc-14.3.0
csky                  randconfig-002-20250924    clang-22
csky                  randconfig-002-20250924    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250924    clang-22
hexagon               randconfig-002-20250924    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250924    gcc-14
i386        buildonly-randconfig-001-20250925    gcc-14
i386        buildonly-randconfig-002-20250924    clang-20
i386        buildonly-randconfig-002-20250924    gcc-14
i386        buildonly-randconfig-002-20250925    gcc-14
i386        buildonly-randconfig-003-20250924    gcc-13
i386        buildonly-randconfig-003-20250924    gcc-14
i386        buildonly-randconfig-003-20250925    gcc-14
i386        buildonly-randconfig-004-20250924    gcc-14
i386        buildonly-randconfig-004-20250925    gcc-14
i386        buildonly-randconfig-005-20250924    clang-20
i386        buildonly-randconfig-005-20250924    gcc-14
i386        buildonly-randconfig-005-20250925    gcc-14
i386        buildonly-randconfig-006-20250924    clang-20
i386        buildonly-randconfig-006-20250924    gcc-14
i386        buildonly-randconfig-006-20250925    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250924    clang-20
i386                  randconfig-001-20250925    gcc-14
i386                  randconfig-002-20250924    clang-20
i386                  randconfig-002-20250925    gcc-14
i386                  randconfig-003-20250924    clang-20
i386                  randconfig-003-20250925    gcc-14
i386                  randconfig-004-20250924    clang-20
i386                  randconfig-004-20250925    gcc-14
i386                  randconfig-005-20250924    clang-20
i386                  randconfig-005-20250925    gcc-14
i386                  randconfig-006-20250924    clang-20
i386                  randconfig-006-20250925    gcc-14
i386                  randconfig-007-20250924    clang-20
i386                  randconfig-007-20250925    gcc-14
i386                  randconfig-011-20250924    gcc-14
i386                  randconfig-011-20250925    clang-20
i386                  randconfig-012-20250924    gcc-14
i386                  randconfig-012-20250925    clang-20
i386                  randconfig-013-20250924    gcc-14
i386                  randconfig-013-20250925    clang-20
i386                  randconfig-014-20250924    gcc-14
i386                  randconfig-014-20250925    clang-20
i386                  randconfig-015-20250924    gcc-14
i386                  randconfig-015-20250925    clang-20
i386                  randconfig-016-20250924    gcc-14
i386                  randconfig-016-20250925    clang-20
i386                  randconfig-017-20250924    gcc-14
i386                  randconfig-017-20250925    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250924    clang-22
loongarch             randconfig-001-20250924    gcc-15.1.0
loongarch             randconfig-002-20250924    clang-22
loongarch             randconfig-002-20250924    gcc-14.3.0
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
mips                           ip30_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250924    clang-22
nios2                 randconfig-001-20250924    gcc-11.5.0
nios2                 randconfig-002-20250924    clang-22
nios2                 randconfig-002-20250924    gcc-8.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250924    clang-22
parisc                randconfig-001-20250924    gcc-12.5.0
parisc                randconfig-002-20250924    clang-22
parisc                randconfig-002-20250924    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                      pmac32_defconfig    clang-22
powerpc                     rainier_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250924    clang-18
powerpc               randconfig-001-20250924    clang-22
powerpc               randconfig-002-20250924    clang-18
powerpc               randconfig-002-20250924    clang-22
powerpc               randconfig-003-20250924    clang-22
powerpc64             randconfig-001-20250924    clang-22
powerpc64             randconfig-002-20250924    clang-22
powerpc64             randconfig-002-20250924    gcc-15.1.0
powerpc64             randconfig-003-20250924    clang-22
powerpc64             randconfig-003-20250924    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250924    gcc-8.5.0
riscv                 randconfig-002-20250924    clang-22
riscv                 randconfig-002-20250924    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250924    gcc-8.5.0
s390                  randconfig-002-20250924    clang-22
s390                  randconfig-002-20250924    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    clang-22
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250924    gcc-15.1.0
sh                    randconfig-001-20250924    gcc-8.5.0
sh                    randconfig-002-20250924    gcc-15.1.0
sh                    randconfig-002-20250924    gcc-8.5.0
sh                      rts7751r2d1_defconfig    clang-22
sh                           se7206_defconfig    clang-22
sh                   sh7724_generic_defconfig    gcc-15.1.0
sparc                            alldefconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250924    gcc-15.1.0
sparc                 randconfig-001-20250924    gcc-8.5.0
sparc                 randconfig-002-20250924    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250924    gcc-8.5.0
sparc64               randconfig-002-20250924    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250924    clang-16
um                    randconfig-001-20250924    gcc-8.5.0
um                    randconfig-002-20250924    clang-19
um                    randconfig-002-20250924    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250924    clang-20
x86_64      buildonly-randconfig-001-20250925    clang-20
x86_64      buildonly-randconfig-002-20250924    clang-20
x86_64      buildonly-randconfig-002-20250925    clang-20
x86_64      buildonly-randconfig-003-20250924    clang-20
x86_64      buildonly-randconfig-003-20250925    clang-20
x86_64      buildonly-randconfig-004-20250924    clang-20
x86_64      buildonly-randconfig-004-20250924    gcc-14
x86_64      buildonly-randconfig-004-20250925    clang-20
x86_64      buildonly-randconfig-005-20250924    clang-20
x86_64      buildonly-randconfig-005-20250925    clang-20
x86_64      buildonly-randconfig-006-20250924    clang-20
x86_64      buildonly-randconfig-006-20250925    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250924    gcc-14
x86_64                randconfig-001-20250925    gcc-14
x86_64                randconfig-002-20250924    gcc-14
x86_64                randconfig-002-20250925    gcc-14
x86_64                randconfig-003-20250924    gcc-14
x86_64                randconfig-003-20250925    gcc-14
x86_64                randconfig-004-20250924    gcc-14
x86_64                randconfig-004-20250925    gcc-14
x86_64                randconfig-005-20250924    gcc-14
x86_64                randconfig-005-20250925    gcc-14
x86_64                randconfig-006-20250924    gcc-14
x86_64                randconfig-006-20250925    gcc-14
x86_64                randconfig-007-20250924    gcc-14
x86_64                randconfig-007-20250925    gcc-14
x86_64                randconfig-008-20250924    gcc-14
x86_64                randconfig-008-20250925    gcc-14
x86_64                randconfig-071-20250924    clang-20
x86_64                randconfig-072-20250924    clang-20
x86_64                randconfig-073-20250924    clang-20
x86_64                randconfig-074-20250924    clang-20
x86_64                randconfig-075-20250924    clang-20
x86_64                randconfig-076-20250924    clang-20
x86_64                randconfig-077-20250924    clang-20
x86_64                randconfig-078-20250924    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250924    gcc-13.4.0
xtensa                randconfig-001-20250924    gcc-8.5.0
xtensa                randconfig-002-20250924    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

