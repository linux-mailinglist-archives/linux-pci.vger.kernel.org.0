Return-Path: <linux-pci+bounces-34987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C553B39924
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FD47AC8FE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764BE2EE61A;
	Thu, 28 Aug 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGwHm9a/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744D308F34
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375747; cv=none; b=lX+1OKNhPc0b9CmXfikI0shCqSKbTmNOCv0fguQsecjgv9JLJye0Q06lc3tNCjnG6vDkQCN3iKfuV+YhJtpK5Vj3yMJ9RA2OORYxv/IxgA0gWgqshv1LKVY0ZprG7GZeXvCPV++irZDiEEn8iVAuSHqplJ2cKcB2rTubSjr4iMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375747; c=relaxed/simple;
	bh=RDaIqbsua9+7yJ9jF5xzWq7xhDFuw8R29WJaiRYXbCY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lOFpcvSKrh8BbKuaxNClSJyDmqLpeF3H5v89RhoJ9afe2B/z8OYlTVYiw7+idaRFUGshmB+jmaEVZ/Fe4ZlkiAv2gBWY8wwfBkJV2hq03lBtd2xzafcmxTYyfvvkAQn9DHf8nH2O9lxlex7aomFiyBVDrcBILslCp/jDKhKUsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGwHm9a/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375746; x=1787911746;
  h=date:from:to:cc:subject:message-id;
  bh=RDaIqbsua9+7yJ9jF5xzWq7xhDFuw8R29WJaiRYXbCY=;
  b=MGwHm9a/K3JRf6bwABsK0qEWVZgP/Qnnxbkkj1DNTjWiR+s1AmQaoZws
   BKkpG4bRYu9b9T/NcegzqY5+kR2IOGQSe9dYTTtK8K39n08U4OrIQYFXv
   XONI8+t+0c2r4ufDbt5UIvc4xX81wj3A1CNA/V4uj3e6/rVqRTOqYBx5/
   uO0dt0Q+wWnimtmN9LCsA1SeOCC7AHxABIIFe7vNgoWdFIl6KL4cFynaG
   1NBPFfIuVK00tIddm0YQTO9o5X9zPqoaTGPKuz26EG0B0V21P8fjLtyNb
   m+ogBj7j9xtHqtJ9ycfzMjy047MyHkmHz5g9cboXRsEo5xhjl576LxIgZ
   A==;
X-CSE-ConnectionGUID: MXD4uqbjQyia6knaqBvxeA==
X-CSE-MsgGUID: KKGQC+hZSx25lhjKr516ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61274894"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61274894"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:09:05 -0700
X-CSE-ConnectionGUID: iXpvJxhXQ1iCfrmid9uLEA==
X-CSE-MsgGUID: 1rky6cB9SMyzzEq29oZgeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170244836"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 28 Aug 2025 03:09:04 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urZY9-000Tct-2v;
	Thu, 28 Aug 2025 10:08:33 +0000
Date: Thu, 28 Aug 2025 18:07:12 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrctrl] BUILD SUCCESS
 dc32e9346b26ba33e84ec3034a1e53a9733700f9
Message-ID: <202508281802.cJA7bhE1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl
branch HEAD: dc32e9346b26ba33e84ec3034a1e53a9733700f9  PCI/pwrctrl: Fix device leak at device stop

elapsed time: 862m

configs tested: 206
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250828    gcc-8.5.0
arc                   randconfig-002-20250828    gcc-14.3.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    gcc-15.1.0
arm                          pxa168_defconfig    gcc-15.1.0
arm                   randconfig-001-20250828    gcc-14.3.0
arm                   randconfig-002-20250828    gcc-10.5.0
arm                   randconfig-003-20250828    clang-22
arm                   randconfig-004-20250828    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250828    clang-22
arm64                 randconfig-002-20250828    clang-22
arm64                 randconfig-003-20250828    gcc-15.1.0
arm64                 randconfig-004-20250828    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250828    clang-22
csky                  randconfig-001-20250828    gcc-15.1.0
csky                  randconfig-002-20250828    clang-22
csky                  randconfig-002-20250828    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250828    clang-22
hexagon               randconfig-002-20250828    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250828    gcc-12
i386        buildonly-randconfig-002-20250828    gcc-12
i386        buildonly-randconfig-003-20250828    gcc-12
i386        buildonly-randconfig-004-20250828    gcc-12
i386        buildonly-randconfig-005-20250828    gcc-12
i386        buildonly-randconfig-006-20250828    clang-20
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
loongarch             randconfig-001-20250828    clang-22
loongarch             randconfig-002-20250828    clang-22
loongarch             randconfig-002-20250828    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
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
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250828    clang-22
parisc                randconfig-001-20250828    gcc-13.4.0
parisc                randconfig-002-20250828    clang-22
parisc                randconfig-002-20250828    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
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
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20250828    clang-19
riscv                 randconfig-001-20250828    clang-22
riscv                 randconfig-002-20250828    clang-19
riscv                 randconfig-002-20250828    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250828    clang-18
s390                  randconfig-001-20250828    clang-19
s390                  randconfig-002-20250828    clang-19
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
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
sparc64               randconfig-001-20250828    clang-19
sparc64               randconfig-001-20250828    gcc-8.5.0
sparc64               randconfig-002-20250828    clang-19
sparc64               randconfig-002-20250828    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250828    clang-19
um                    randconfig-002-20250828    clang-19
um                    randconfig-002-20250828    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250828    gcc-12
x86_64      buildonly-randconfig-002-20250828    gcc-12
x86_64      buildonly-randconfig-003-20250828    clang-20
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

