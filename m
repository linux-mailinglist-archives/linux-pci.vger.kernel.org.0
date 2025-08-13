Return-Path: <linux-pci+bounces-33991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 461C8B254F3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D631C82E97
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747929BD97;
	Wed, 13 Aug 2025 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/ONy5tI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0302FD7B8
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119095; cv=none; b=k7DwW3E1fNvroFC7oT1gfsn9W7pB9ZWvSjTIuUgusmZEfN3WOLUAUNiNr64SdLeTTz3Oj/1+KkMYfTA5rj3Ebe5jGMy5BhiaQG/xJN3wSSbGPRos7HNY2kWw3gNvqTv83dxYVHmopxqI5ZLUlko6fwjdv9uEWkt3zldwT5fViuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119095; c=relaxed/simple;
	bh=DkHWWSMeGr2V8lzUr1I7yiRh1PmjWpzYbB9eeRkyT5k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KevU+ovtQFh1UDcvrUBeQPPGtKlo7pPS5HjbnzsFU5Omz9euidI2iVf4UQqgBQkTUrpDJgXPmI86/Pd1w9vbu+Z2Q/lZCgxciLT87xs37Bz//xyuuuEbCMzAAT9qgArQ1Siy3/ahPno6yTRyMrGE1caV9gjj3FuX6y7IzKkeVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/ONy5tI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755119093; x=1786655093;
  h=date:from:to:cc:subject:message-id;
  bh=DkHWWSMeGr2V8lzUr1I7yiRh1PmjWpzYbB9eeRkyT5k=;
  b=U/ONy5tINQc1Ta1zXVaC2xybEmAMwV+z8dCbuCN76a5Qwbe48PRdDJC1
   FJWyKYzISybhL/JUZ/nyzM9nAaXc3CLnQu4QtDWzkvNAW/T8aE+QBchsp
   XIsNCsnP6bg7KHWNFNPwKSKr2fjnEvBikQ468OmVDQNK1ahgLded+z8h2
   82QXMswJf3ga5pjL7bfwEQt+MdtriNnYfshL/JsMP+g0hmEVIzmAeWZLe
   LICk7m/nTDE5fntQxD0bMwFP2ys2uRcE6ocgaRzm3SpGgKFleUndfIbDp
   fJQxW/7vReHGKQCbwrA7A347QfPlt+DaGv81Igv9EzFzDKqsDRvMV3MMF
   g==;
X-CSE-ConnectionGUID: f7xfkwI5TmG5hbbJle53kA==
X-CSE-MsgGUID: p1mW9MMZSfKFSdox/ncJcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68033588"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68033588"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 14:04:52 -0700
X-CSE-ConnectionGUID: C29xscD/R9uazqPyQaP8ZA==
X-CSE-MsgGUID: hDh/CorhQ+yE6Ub+STCjiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170781339"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 14:04:50 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umIeD-000AJu-37;
	Wed, 13 Aug 2025 21:04:39 +0000
Date: Thu, 14 Aug 2025 05:03:27 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 9c1fffa92f98323ef4f6f84d1705f391d7b66fff
Message-ID: <202508140518.42RaUcvS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 9c1fffa92f98323ef4f6f84d1705f391d7b66fff  Merge branch 'pci/misc-endpoint'

elapsed time: 1308m

configs tested: 245
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
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
arc                                 defconfig    clang-19
arc                   randconfig-001-20250813    clang-22
arc                   randconfig-001-20250813    gcc-11.5.0
arc                   randconfig-002-20250813    clang-22
arc                   randconfig-002-20250813    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         assabet_defconfig    clang-22
arm                                 defconfig    clang-19
arm                            mps2_defconfig    clang-22
arm                       multi_v4t_defconfig    clang-22
arm                   randconfig-001-20250813    clang-22
arm                   randconfig-002-20250813    clang-22
arm                   randconfig-002-20250813    gcc-8.5.0
arm                   randconfig-003-20250813    clang-22
arm                   randconfig-004-20250813    clang-22
arm                   randconfig-004-20250813    gcc-8.5.0
arm                    vt8500_v6_v7_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250813    clang-22
arm64                 randconfig-002-20250813    clang-22
arm64                 randconfig-002-20250813    gcc-12.5.0
arm64                 randconfig-003-20250813    clang-22
arm64                 randconfig-004-20250813    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250813    clang-20
csky                  randconfig-001-20250813    gcc-14.3.0
csky                  randconfig-002-20250813    clang-20
csky                  randconfig-002-20250813    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250813    clang-20
hexagon               randconfig-001-20250813    clang-22
hexagon               randconfig-002-20250813    clang-20
hexagon               randconfig-002-20250813    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250813    gcc-11
i386        buildonly-randconfig-001-20250814    clang-20
i386        buildonly-randconfig-002-20250813    clang-20
i386        buildonly-randconfig-002-20250813    gcc-11
i386        buildonly-randconfig-002-20250814    clang-20
i386        buildonly-randconfig-003-20250813    gcc-11
i386        buildonly-randconfig-003-20250814    clang-20
i386        buildonly-randconfig-004-20250813    clang-20
i386        buildonly-randconfig-004-20250813    gcc-11
i386        buildonly-randconfig-004-20250814    clang-20
i386        buildonly-randconfig-005-20250813    gcc-11
i386        buildonly-randconfig-005-20250813    gcc-12
i386        buildonly-randconfig-005-20250814    clang-20
i386        buildonly-randconfig-006-20250813    gcc-11
i386        buildonly-randconfig-006-20250813    gcc-12
i386        buildonly-randconfig-006-20250814    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250813    clang-20
i386                  randconfig-002-20250813    clang-20
i386                  randconfig-003-20250813    clang-20
i386                  randconfig-004-20250813    clang-20
i386                  randconfig-005-20250813    clang-20
i386                  randconfig-006-20250813    clang-20
i386                  randconfig-007-20250813    clang-20
i386                  randconfig-011-20250813    gcc-11
i386                  randconfig-012-20250813    gcc-11
i386                  randconfig-013-20250813    gcc-11
i386                  randconfig-014-20250813    gcc-11
i386                  randconfig-015-20250813    gcc-11
i386                  randconfig-016-20250813    gcc-11
i386                  randconfig-017-20250813    gcc-11
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250813    clang-19
loongarch             randconfig-001-20250813    clang-20
loongarch             randconfig-002-20250813    clang-20
loongarch             randconfig-002-20250813    gcc-15.1.0
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
nios2                 randconfig-001-20250813    clang-20
nios2                 randconfig-001-20250813    gcc-11.5.0
nios2                 randconfig-002-20250813    clang-20
nios2                 randconfig-002-20250813    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250813    clang-20
parisc                randconfig-001-20250813    gcc-14.3.0
parisc                randconfig-002-20250813    clang-20
parisc                randconfig-002-20250813    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250813    clang-18
powerpc               randconfig-001-20250813    clang-20
powerpc               randconfig-002-20250813    clang-20
powerpc               randconfig-002-20250813    clang-22
powerpc               randconfig-003-20250813    clang-20
powerpc                     tqm8540_defconfig    clang-22
powerpc                     tqm8555_defconfig    clang-22
powerpc64             randconfig-001-20250813    clang-20
powerpc64             randconfig-001-20250813    clang-22
powerpc64             randconfig-002-20250813    clang-20
powerpc64             randconfig-002-20250813    gcc-8.5.0
powerpc64             randconfig-003-20250813    clang-17
powerpc64             randconfig-003-20250813    clang-20
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250813    clang-22
riscv                 randconfig-002-20250813    clang-22
riscv                 randconfig-002-20250813    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250813    clang-22
s390                  randconfig-002-20250813    clang-18
s390                  randconfig-002-20250813    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250813    clang-22
sh                    randconfig-001-20250813    gcc-9.5.0
sh                    randconfig-002-20250813    clang-22
sh                    randconfig-002-20250813    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250813    clang-22
sparc                 randconfig-001-20250813    gcc-8.5.0
sparc                 randconfig-002-20250813    clang-22
sparc                 randconfig-002-20250813    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250813    clang-22
sparc64               randconfig-001-20250813    gcc-8.5.0
sparc64               randconfig-002-20250813    clang-20
sparc64               randconfig-002-20250813    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250813    clang-22
um                    randconfig-001-20250813    gcc-12
um                    randconfig-002-20250813    clang-22
um                    randconfig-002-20250813    gcc-11
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250813    clang-20
x86_64      buildonly-randconfig-001-20250813    gcc-12
x86_64      buildonly-randconfig-001-20250814    clang-20
x86_64      buildonly-randconfig-002-20250813    clang-20
x86_64      buildonly-randconfig-002-20250814    clang-20
x86_64      buildonly-randconfig-003-20250813    clang-20
x86_64      buildonly-randconfig-003-20250813    gcc-12
x86_64      buildonly-randconfig-003-20250814    clang-20
x86_64      buildonly-randconfig-004-20250813    clang-20
x86_64      buildonly-randconfig-004-20250814    clang-20
x86_64      buildonly-randconfig-005-20250813    clang-20
x86_64      buildonly-randconfig-005-20250814    clang-20
x86_64      buildonly-randconfig-006-20250813    clang-20
x86_64      buildonly-randconfig-006-20250813    gcc-12
x86_64      buildonly-randconfig-006-20250814    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250813    gcc-12
x86_64                randconfig-002-20250813    gcc-12
x86_64                randconfig-003-20250813    gcc-12
x86_64                randconfig-004-20250813    gcc-12
x86_64                randconfig-005-20250813    gcc-12
x86_64                randconfig-006-20250813    gcc-12
x86_64                randconfig-007-20250813    gcc-12
x86_64                randconfig-008-20250813    gcc-12
x86_64                randconfig-071-20250813    clang-20
x86_64                randconfig-072-20250813    clang-20
x86_64                randconfig-073-20250813    clang-20
x86_64                randconfig-074-20250813    clang-20
x86_64                randconfig-075-20250813    clang-20
x86_64                randconfig-076-20250813    clang-20
x86_64                randconfig-077-20250813    clang-20
x86_64                randconfig-078-20250813    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250813    clang-22
xtensa                randconfig-001-20250813    gcc-10.5.0
xtensa                randconfig-002-20250813    clang-22
xtensa                randconfig-002-20250813    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

