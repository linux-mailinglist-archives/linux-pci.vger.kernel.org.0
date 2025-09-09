Return-Path: <linux-pci+bounces-35750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A1B50449
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68A03B929B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC95131D391;
	Tue,  9 Sep 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idhYzrkw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095822CBC6
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438299; cv=none; b=I0j9vvegtLCq0qnFI4JjpQWOBXbKdBDASRjAQJXH0VBelZF0qF1ZA8mLqbyVCMsfuF7KCQSMTHgSZ/kNjXifvu1gr2NU98HX1tPCC4FI/NtemVYO2J+BiZWxJCWDKHBlFkRK9IFRRKsXXysaZLGP9XYgiw2z2p+b9+b8U47snG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438299; c=relaxed/simple;
	bh=78oVxtVdUVxzDU9WOk6/4uN505gaWET4jTjWSC6M8F8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PjrWnkBV9Rw13d0xMjMi1J1XGkoYtYolpKAOreY6Cf0D9ntE5LVKdFPbcGCRrS1+8+xa32FeN7e5Ctto4k+1NMJ1z2uavULLlg90RmPWFlZv9VIPepa6jKy0JV81jTg10/Qf+FNhHObPRZC2i54HfNQzCfrQyuh2eoMsPjEFizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idhYzrkw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757438298; x=1788974298;
  h=date:from:to:cc:subject:message-id;
  bh=78oVxtVdUVxzDU9WOk6/4uN505gaWET4jTjWSC6M8F8=;
  b=idhYzrkw8YJDxRK+QbQoFM+/5TSuLzJ4s2cLLqWdnfqkuLWe9EXuxkaV
   UvixE2dye/xauCRozuoxrt/LwaAdtR/FGO61aoWvf0PxkZTVn0NeHcnXG
   J8hk+37ncDIgMU0aFYMNNmJ/1ijtlEE/aVDqwuxE+a+o1GGwtbSDq1LI2
   yq3yFm5+HSmEnJoxGXcxoYMoNNK6MN622bXKpnQfWfjtwZkz3u1uu0m9K
   L1qGFCcfl1DiSMrSBdLRR/GdDLBU1RM+JO2T6W46NQbNLVCklfA7+V0O/
   nVqL/szrXv57+nGKxj2AeaN3apuz1sMI5LPY0yuDFBEnFE9YV5yDxRddj
   Q==;
X-CSE-ConnectionGUID: 6SKKd4+yTciwfg/t7L92Uw==
X-CSE-MsgGUID: 4kZzCKafQd2YXMoZtOag/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59795306"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59795306"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 10:18:17 -0700
X-CSE-ConnectionGUID: kBHhP/jxRhqSBWcIFQyJ+Q==
X-CSE-MsgGUID: cyp0e4EVSHyPxRHmfcLdyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="204128717"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Sep 2025 10:18:15 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uw1yv-00058e-0a;
	Tue, 09 Sep 2025 17:18:13 +0000
Date: Wed, 10 Sep 2025 01:17:48 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 b816265396daf1beb915e0ffbfd7f3906c2bf4a4
Message-ID: <202509100138.um1riMht-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: b816265396daf1beb915e0ffbfd7f3906c2bf4a4  PCI: mvebu: Fix use of for_each_of_range() iterator

elapsed time: 1234m

configs tested: 239
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
alpha                               defconfig    gcc-14
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250909    clang-16
arc                   randconfig-001-20250909    gcc-8.5.0
arc                   randconfig-002-20250909    clang-16
arc                   randconfig-002-20250909    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250909    clang-16
arm                   randconfig-001-20250909    clang-18
arm                   randconfig-002-20250909    clang-16
arm                   randconfig-002-20250909    clang-17
arm                   randconfig-003-20250909    clang-16
arm                   randconfig-003-20250909    clang-22
arm                   randconfig-004-20250909    clang-16
arm                   randconfig-004-20250909    clang-19
arm                         s3c6400_defconfig    gcc-14
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250909    clang-16
arm64                 randconfig-002-20250909    gcc-11.5.0
arm64                 randconfig-003-20250909    clang-16
arm64                 randconfig-003-20250909    gcc-11.5.0
arm64                 randconfig-004-20250909    clang-16
arm64                 randconfig-004-20250909    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250909    gcc-15.1.0
csky                  randconfig-001-20250909    gcc-8.5.0
csky                  randconfig-002-20250909    gcc-15.1.0
csky                  randconfig-002-20250909    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250909    clang-22
hexagon               randconfig-001-20250909    gcc-8.5.0
hexagon               randconfig-002-20250909    clang-22
hexagon               randconfig-002-20250909    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250909    gcc-13
i386        buildonly-randconfig-001-20250910    clang-20
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-002-20250910    clang-20
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-003-20250910    clang-20
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-004-20250910    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-005-20250910    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
i386        buildonly-randconfig-006-20250910    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250909    clang-20
i386                  randconfig-002-20250909    clang-20
i386                  randconfig-003-20250909    clang-20
i386                  randconfig-004-20250909    clang-20
i386                  randconfig-005-20250909    clang-20
i386                  randconfig-006-20250909    clang-20
i386                  randconfig-007-20250909    clang-20
i386                  randconfig-011-20250909    gcc-14
i386                  randconfig-012-20250909    gcc-14
i386                  randconfig-013-20250909    gcc-14
i386                  randconfig-014-20250909    gcc-14
i386                  randconfig-015-20250909    gcc-14
i386                  randconfig-016-20250909    gcc-14
i386                  randconfig-017-20250909    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250909    gcc-15.1.0
loongarch             randconfig-001-20250909    gcc-8.5.0
loongarch             randconfig-002-20250909    gcc-15.1.0
loongarch             randconfig-002-20250909    gcc-8.5.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250909    gcc-11.5.0
nios2                 randconfig-001-20250909    gcc-8.5.0
nios2                 randconfig-002-20250909    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-002-20250909    gcc-12.5.0
parisc                randconfig-002-20250909    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-14
powerpc               randconfig-001-20250909    clang-22
powerpc               randconfig-001-20250909    gcc-8.5.0
powerpc               randconfig-002-20250909    clang-17
powerpc               randconfig-002-20250909    gcc-8.5.0
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc                     taishan_defconfig    gcc-14
powerpc64             randconfig-001-20250909    clang-20
powerpc64             randconfig-001-20250909    gcc-8.5.0
powerpc64             randconfig-002-20250909    gcc-10.5.0
powerpc64             randconfig-002-20250909    gcc-8.5.0
powerpc64             randconfig-003-20250909    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250909    clang-22
riscv                 randconfig-001-20250909    gcc-15.1.0
riscv                 randconfig-002-20250909    clang-22
riscv                 randconfig-002-20250909    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250909    gcc-11.5.0
s390                  randconfig-001-20250909    gcc-15.1.0
s390                  randconfig-002-20250909    clang-18
s390                  randconfig-002-20250909    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250909    gcc-15.1.0
sh                    randconfig-002-20250909    gcc-15.1.0
sh                    randconfig-002-20250909    gcc-9.5.0
sh                   secureedge5410_defconfig    gcc-14
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-8.5.0
sparc                 randconfig-002-20250909    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250909    clang-22
sparc64               randconfig-001-20250909    gcc-15.1.0
sparc64               randconfig-002-20250909    gcc-15.1.0
sparc64               randconfig-002-20250909    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250909    gcc-14
um                    randconfig-001-20250909    gcc-15.1.0
um                    randconfig-002-20250909    gcc-14
um                    randconfig-002-20250909    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250909    clang-20
x86_64      buildonly-randconfig-001-20250909    gcc-14
x86_64      buildonly-randconfig-002-20250909    clang-20
x86_64      buildonly-randconfig-002-20250909    gcc-14
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250909    clang-20
x86_64      buildonly-randconfig-004-20250909    gcc-14
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250909    clang-20
x86_64      buildonly-randconfig-006-20250909    gcc-14
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250909    gcc-14
x86_64                randconfig-002-20250909    gcc-14
x86_64                randconfig-003-20250909    gcc-14
x86_64                randconfig-004-20250909    gcc-14
x86_64                randconfig-005-20250909    gcc-14
x86_64                randconfig-006-20250909    gcc-14
x86_64                randconfig-007-20250909    gcc-14
x86_64                randconfig-008-20250909    gcc-14
x86_64                randconfig-071-20250909    gcc-14
x86_64                randconfig-072-20250909    gcc-14
x86_64                randconfig-073-20250909    gcc-14
x86_64                randconfig-074-20250909    gcc-14
x86_64                randconfig-075-20250909    gcc-14
x86_64                randconfig-076-20250909    gcc-14
x86_64                randconfig-077-20250909    gcc-14
x86_64                randconfig-078-20250909    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-8.5.0
xtensa                randconfig-002-20250909    gcc-15.1.0
xtensa                    smp_lx200_defconfig    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

