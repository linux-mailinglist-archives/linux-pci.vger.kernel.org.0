Return-Path: <linux-pci+bounces-13735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2898E5C5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 00:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9765284294
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264012C49C;
	Wed,  2 Oct 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix2puMxr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685B2F22
	for <linux-pci@vger.kernel.org>; Wed,  2 Oct 2024 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906864; cv=none; b=FQhJrySuJM1S85SUB9hP1TA6m7j5bR3AdyV9jfIhOkxlKfH9mFuNqST/oiXqt7Y+4k4RouJ6CwKnex7fIbLbe1urDfiFFwE1bXxIhhfhueHxCH+LUMlfKS2cDNFbEA9ONmuzQgaek+pdENsURxvkegYNgnacEqK9DcRHt3eNEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906864; c=relaxed/simple;
	bh=SsuKJU5gx9TwwuGpEB2ugEOuM/FyaECZkWk5IV367LU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AKzJdGdVmcDIBAJHLl6pjNQvMM47XDlYtkcIeZtuv4G7GjJgBo0lmafyAPdVCPHGgqDUPKydNFXYJr7yzFeTmIqZP7GU788R8FXABJQaywF7GlILIPirt6erwrGvdfi4BUBBzfq0BQvihmBYFgbzIHuO+5DA5NcZnEKlSSky34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix2puMxr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727906862; x=1759442862;
  h=date:from:to:cc:subject:message-id;
  bh=SsuKJU5gx9TwwuGpEB2ugEOuM/FyaECZkWk5IV367LU=;
  b=Ix2puMxrPPbPvojprlxGJLMPRowialwv9gxTZPITsNJeZb083dgO/SOP
   XvFpuVzX8/3BTBC4g4z0prPtH5GxcIjbFD09V1n+p6s/qw0aviZl5f7sa
   q5mxShTlLxdxUgAeah67EeYom8xcmg3MYT8PNkJYuNqm+5oQvStz4ze/X
   l9hLz5qGP2Rs6t/4yZ0gjwuTWMlMoLHLAzY7wpzblJVTY2HXdhRqhiqvj
   GT6X3rt9me6GrJLT69+1mAwSYCFcTCzuL3m9Nl5oJRtSZm6ECV4s9TAt1
   DK1RVI6HYM1exe3oZVeM0zYNG0OR7xDnjL58B/5o0bZOppzRmqsd5Aiss
   g==;
X-CSE-ConnectionGUID: xnlfXW1+T3uZG29gr5WZKQ==
X-CSE-MsgGUID: l1WoICJCRACMNfXzRzW5Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="26596861"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="26596861"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:07:42 -0700
X-CSE-ConnectionGUID: DWUyt3+bSXSZtxlkrcWvFA==
X-CSE-MsgGUID: KReBTMc1S2OrzpYTsrhGfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78991304"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Oct 2024 15:07:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sw7VS-000Ucl-0Z;
	Wed, 02 Oct 2024 22:07:38 +0000
Date: Thu, 03 Oct 2024 06:07:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:driver-remove] BUILD SUCCESS
 d64b83a4b1158e8e560a26629c1a409a8b798ff3
Message-ID: <202410030652.1I20bJfQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git driver-remove
branch HEAD: d64b83a4b1158e8e560a26629c1a409a8b798ff3  PCI: acpiphp_ampere_altra: Switch back to struct platform_driver::remove()

elapsed time: 1469m

configs tested: 222
configs skipped: 4

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
arc                   randconfig-001-20241002    gcc-13.2.0
arc                   randconfig-001-20241002    gcc-14.1.0
arc                   randconfig-002-20241002    gcc-13.2.0
arc                   randconfig-002-20241002    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                            mmp2_defconfig    gcc-14.1.0
arm                   randconfig-001-20241002    gcc-14.1.0
arm                   randconfig-002-20241002    clang-20
arm                   randconfig-002-20241002    gcc-14.1.0
arm                   randconfig-003-20241002    clang-14
arm                   randconfig-003-20241002    gcc-14.1.0
arm                   randconfig-004-20241002    gcc-14.1.0
arm                           stm32_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241002    clang-20
arm64                 randconfig-001-20241002    gcc-14.1.0
arm64                 randconfig-002-20241002    clang-20
arm64                 randconfig-002-20241002    gcc-14.1.0
arm64                 randconfig-003-20241002    gcc-14.1.0
arm64                 randconfig-004-20241002    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241002    gcc-14.1.0
csky                  randconfig-002-20241002    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241002    clang-20
hexagon               randconfig-001-20241002    gcc-14.1.0
hexagon               randconfig-002-20241002    clang-20
hexagon               randconfig-002-20241002    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241002    clang-18
i386        buildonly-randconfig-002-20241002    clang-18
i386        buildonly-randconfig-003-20241002    clang-18
i386        buildonly-randconfig-003-20241002    gcc-12
i386        buildonly-randconfig-004-20241002    clang-18
i386        buildonly-randconfig-004-20241002    gcc-12
i386        buildonly-randconfig-005-20241002    clang-18
i386        buildonly-randconfig-005-20241002    gcc-12
i386        buildonly-randconfig-006-20241002    clang-18
i386        buildonly-randconfig-006-20241002    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241002    clang-18
i386                  randconfig-001-20241002    gcc-12
i386                  randconfig-002-20241002    clang-18
i386                  randconfig-002-20241002    gcc-12
i386                  randconfig-003-20241002    clang-18
i386                  randconfig-004-20241002    clang-18
i386                  randconfig-005-20241002    clang-18
i386                  randconfig-006-20241002    clang-18
i386                  randconfig-006-20241002    gcc-12
i386                  randconfig-011-20241002    clang-18
i386                  randconfig-012-20241002    clang-18
i386                  randconfig-013-20241002    clang-18
i386                  randconfig-013-20241002    gcc-12
i386                  randconfig-014-20241002    clang-18
i386                  randconfig-015-20241002    clang-18
i386                  randconfig-016-20241002    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241002    gcc-14.1.0
loongarch             randconfig-002-20241002    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5272c3_defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           jazz_defconfig    gcc-14.1.0
mips                          rm200_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241002    gcc-14.1.0
nios2                 randconfig-002-20241002    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-14.1.0
parisc                randconfig-001-20241002    gcc-14.1.0
parisc                randconfig-002-20241002    gcc-14.1.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc               randconfig-001-20241002    gcc-14.1.0
powerpc               randconfig-002-20241002    clang-20
powerpc               randconfig-002-20241002    gcc-14.1.0
powerpc               randconfig-003-20241002    clang-20
powerpc               randconfig-003-20241002    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc                        warp_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241002    gcc-14.1.0
powerpc64             randconfig-002-20241002    gcc-14.1.0
powerpc64             randconfig-003-20241002    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241002    clang-14
riscv                 randconfig-001-20241002    gcc-14.1.0
riscv                 randconfig-002-20241002    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                          debug_defconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241002    gcc-14.1.0
s390                  randconfig-002-20241002    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    gcc-14.1.0
sh                          r7780mp_defconfig    gcc-14.1.0
sh                          r7785rp_defconfig    gcc-14.1.0
sh                    randconfig-001-20241002    gcc-14.1.0
sh                    randconfig-002-20241002    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241002    gcc-14.1.0
sparc64               randconfig-002-20241002    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241002    gcc-12
um                    randconfig-001-20241002    gcc-14.1.0
um                    randconfig-002-20241002    gcc-12
um                    randconfig-002-20241002    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241002    gcc-12
x86_64      buildonly-randconfig-002-20241002    gcc-12
x86_64      buildonly-randconfig-003-20241002    gcc-12
x86_64      buildonly-randconfig-004-20241002    gcc-12
x86_64      buildonly-randconfig-005-20241002    gcc-12
x86_64      buildonly-randconfig-006-20241002    clang-18
x86_64      buildonly-randconfig-006-20241002    gcc-12
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241002    clang-18
x86_64                randconfig-001-20241002    gcc-12
x86_64                randconfig-002-20241002    gcc-12
x86_64                randconfig-003-20241002    clang-18
x86_64                randconfig-003-20241002    gcc-12
x86_64                randconfig-004-20241002    gcc-11
x86_64                randconfig-004-20241002    gcc-12
x86_64                randconfig-005-20241002    gcc-11
x86_64                randconfig-005-20241002    gcc-12
x86_64                randconfig-006-20241002    clang-18
x86_64                randconfig-006-20241002    gcc-12
x86_64                randconfig-011-20241002    clang-18
x86_64                randconfig-011-20241002    gcc-12
x86_64                randconfig-012-20241002    gcc-12
x86_64                randconfig-013-20241002    gcc-12
x86_64                randconfig-014-20241002    gcc-12
x86_64                randconfig-015-20241002    clang-18
x86_64                randconfig-015-20241002    gcc-12
x86_64                randconfig-016-20241002    clang-18
x86_64                randconfig-016-20241002    gcc-12
x86_64                randconfig-071-20241002    clang-18
x86_64                randconfig-071-20241002    gcc-12
x86_64                randconfig-072-20241002    gcc-12
x86_64                randconfig-073-20241002    gcc-12
x86_64                randconfig-074-20241002    gcc-12
x86_64                randconfig-075-20241002    clang-18
x86_64                randconfig-075-20241002    gcc-12
x86_64                randconfig-076-20241002    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  nommu_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241002    gcc-14.1.0
xtensa                randconfig-002-20241002    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

