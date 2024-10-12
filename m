Return-Path: <linux-pci+bounces-14382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C5499B39A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC47282295
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA9155A53;
	Sat, 12 Oct 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+bRBaFw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2AD155A43
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732425; cv=none; b=aGo5fkR4hrDqooQJVW4t1P61SjOBNloSKnueepP12IgEn/72hj/Q6DZ3uFY+Fu3Wv6vc+pmBMx+zuvSm/8f974zrsY/FEin4pbotreajjb+elWnUKbGRzQ+NJFnx6yvvDj/21YbLe3fY8zIGgAEkrIesG9o1hz7yLGue9CK0llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732425; c=relaxed/simple;
	bh=2YjmbCQZSgq+8Rdu5sT96G+pjbOQ+yh1Eua0Dw52y8k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pF6C0dPEXkA++dyevxEN6EZTqNWU/u4GPgoXSPw62CrKzTSJIwHV+ehPb6CCeJf8k4idDtb7U5Qw71hSmAIsCRchg1oF0v5vpS1lKaMlEZS1DfbbbrLUnHNLVCrvcQ0wwnwMmiKaabRj5nkmnTYJDn4Vbn86LqiliKZzNMw09AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+bRBaFw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728732423; x=1760268423;
  h=date:from:to:cc:subject:message-id;
  bh=2YjmbCQZSgq+8Rdu5sT96G+pjbOQ+yh1Eua0Dw52y8k=;
  b=a+bRBaFw9J7mhuNYQgV63DJwlylQL+W5wfbaoO6xdvxOyV0GW49RCZJJ
   XBLtJPQuBHhb8GzMYXuKBjC87gRiR9wvBHgmR4Vs52Um0Jbimzr/bCXlT
   mdgK0kwZa3wq9N3OEErvhHgH4S13MLIalUKli3p0MHq+bzK8SUU1USzyG
   vR4LzbqLKh85LWGFv5BVqc1f6fXO/2VtEVz5uinKF/V3WRbxXqBq/pHcQ
   U6xVHJc8fHkl1lAsGMj9tC5SOie6lyEZp8FPo1VcjWjSOoMPdM+2v7AIP
   HXQtIc1/SIb+wJNF+OCuI5VtsGH8oBUceWj5cOFLs/JpOzITjq5CtUyW9
   Q==;
X-CSE-ConnectionGUID: GlMS2orESiWLOhfRxbYCBQ==
X-CSE-MsgGUID: t7Piq/bSQ5Ki+eJZ1X8Bug==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28079238"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="28079238"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 04:27:03 -0700
X-CSE-ConnectionGUID: cL3HwwlORb+81u9nr+HZ+w==
X-CSE-MsgGUID: zQs+rCgIQy+Kk8dnT1wIIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="77957904"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Oct 2024 04:27:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szaGx-000DJb-2D;
	Sat, 12 Oct 2024 11:26:59 +0000
Date: Sat, 12 Oct 2024 19:26:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 afb15ca28055352101286046c1f9f01fdaa1ace1
Message-ID: <202410121931.vfO8Tzpa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: afb15ca28055352101286046c1f9f01fdaa1ace1  Merge branch 'pci/misc'

elapsed time: 2383m

configs tested: 140
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
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                        clps711x_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                          moxart_defconfig    gcc-14.1.0
arm64                            alldefconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241012    gcc-12
i386        buildonly-randconfig-002-20241012    clang-18
i386        buildonly-randconfig-003-20241012    gcc-12
i386        buildonly-randconfig-004-20241012    clang-18
i386        buildonly-randconfig-005-20241012    clang-18
i386        buildonly-randconfig-006-20241012    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241012    clang-18
i386                  randconfig-002-20241012    clang-18
i386                  randconfig-003-20241012    gcc-12
i386                  randconfig-004-20241012    gcc-12
i386                  randconfig-005-20241012    gcc-11
i386                  randconfig-006-20241012    clang-18
i386                  randconfig-011-20241012    gcc-12
i386                  randconfig-012-20241012    gcc-12
i386                  randconfig-013-20241012    gcc-12
i386                  randconfig-014-20241012    gcc-12
i386                  randconfig-015-20241012    gcc-12
i386                  randconfig-016-20241012    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         db1xxx_defconfig    gcc-14.1.0
mips                            gpr_defconfig    gcc-14.1.0
mips                           ip27_defconfig    gcc-14.1.0
mips                           mtx1_defconfig    gcc-14.1.0
mips                      pic32mzda_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.1.0
powerpc                 mpc836x_rdk_defconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                            migor_defconfig    gcc-14.1.0
sh                           sh2007_defconfig    gcc-14.1.0
sh                        sh7785lcr_defconfig    gcc-14.1.0
sh                             shx3_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241012    clang-18
x86_64      buildonly-randconfig-002-20241012    clang-18
x86_64      buildonly-randconfig-003-20241012    clang-18
x86_64      buildonly-randconfig-004-20241012    clang-18
x86_64      buildonly-randconfig-005-20241012    clang-18
x86_64      buildonly-randconfig-006-20241012    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241012    clang-18
x86_64                randconfig-002-20241012    clang-18
x86_64                randconfig-003-20241012    clang-18
x86_64                randconfig-004-20241012    clang-18
x86_64                randconfig-005-20241012    clang-18
x86_64                randconfig-006-20241012    clang-18
x86_64                randconfig-011-20241012    clang-18
x86_64                randconfig-012-20241012    clang-18
x86_64                randconfig-013-20241012    clang-18
x86_64                randconfig-014-20241012    clang-18
x86_64                randconfig-015-20241012    clang-18
x86_64                randconfig-016-20241012    clang-18
x86_64                randconfig-071-20241012    clang-18
x86_64                randconfig-072-20241012    clang-18
x86_64                randconfig-073-20241012    clang-18
x86_64                randconfig-074-20241012    clang-18
x86_64                randconfig-075-20241012    clang-18
x86_64                randconfig-076-20241012    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

