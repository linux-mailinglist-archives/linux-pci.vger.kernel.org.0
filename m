Return-Path: <linux-pci+bounces-23669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCF9A5FBF3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 17:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E08188777A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CA01487D1;
	Thu, 13 Mar 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="np98if0a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C17FBAC
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883879; cv=none; b=BvTF3/P5o2qRVxJB9bo5AZ48u95jE8d+LC5FzOQtmlTphs5Jh6hOMCFMm/ZHpvZy3h+T6ryylA43zYxT7XWYX9gwEsYiY2RQuLIGpe70T50c8f7puDTUu8JTurPxG3BUkHMOSaHX4qGGZX9/UbQoRXmgTP02g0dsb3aNo7oZXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883879; c=relaxed/simple;
	bh=qn8UOp64vAU/2htCWJFzp9Bc8UsdhXK3Y0dwiUKfOQQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sT/wuuBcggw8Or1zbGmf7a6lAozjyYDT1wCIJCVLAG43Ly5cD0ps5npGltjbaLCzK5XLbD/dMOpjsRRjODZOhIG9qzdC2QodSZQ9HNGUVZcdqtjtqPRy9HY5CsRrYWSmGcpFCsa9w5Glx8JRh1lf2B3b5gybovb7FLY8lHOCN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=np98if0a; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741883877; x=1773419877;
  h=date:from:to:cc:subject:message-id;
  bh=qn8UOp64vAU/2htCWJFzp9Bc8UsdhXK3Y0dwiUKfOQQ=;
  b=np98if0aQCM0diG8x3B+LnXq5E0pE2lJD26KY8yDDIVjMCmDo5W6mDYF
   Wwfos7FiqY0MkeJzf6zZ/8GBcvW2pIpp5mAgp1dV0qD0zl5DcWNu/56+5
   2zJ2tPrXS4/uHPrR5iIxxH2srvucUX4Gl8OZkJ+sMrNznmsIJflrTlbq9
   sxNL+oD7pEB3odA5wb58QISqpjDnDflVcHt7+GR3HWlFmvsRH5shn3E9x
   NElaYxgB2WK74MOhCq4+jFCJ9/fumMf87vJZM+s9Q48BvI9sjapmlgUxP
   gFfrRcGUZvC2FQgLrZPu9iR2zy8SHRkLnKIjeNRtmSetxRQnxnqnW0zUP
   w==;
X-CSE-ConnectionGUID: oZg2isEkTI2eBdCm2+S46Q==
X-CSE-MsgGUID: wcLkczwuTHO7uxairX7sUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="45785632"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="45785632"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:37:55 -0700
X-CSE-ConnectionGUID: 7iJYFVZ4REuyU4lXqknL0w==
X-CSE-MsgGUID: 2rXtSgywTJev+xbUSkikVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="126184308"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 13 Mar 2025 09:37:53 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tslZ8-0009fq-1m;
	Thu, 13 Mar 2025 16:37:50 +0000
Date: Fri, 14 Mar 2025 00:37:36 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 876d4518a87dc2f83ffbfa64cb773917effe94f3
Message-ID: <202503140030.ljHLTPSv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 876d4518a87dc2f83ffbfa64cb773917effe94f3  PCI: pciehp: Avoid unnecessary device replacement check

elapsed time: 1449m

configs tested: 174
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                   randconfig-001-20250313    gcc-13.2.0
arc                   randconfig-002-20250313    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250313    clang-16
arm                   randconfig-002-20250313    clang-18
arm                   randconfig-003-20250313    gcc-14.2.0
arm                   randconfig-004-20250313    clang-21
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250313    clang-18
arm64                 randconfig-002-20250313    clang-16
arm64                 randconfig-003-20250313    gcc-14.2.0
arm64                 randconfig-004-20250313    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250313    gcc-14.2.0
csky                  randconfig-002-20250313    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250313    clang-17
hexagon               randconfig-001-20250313    gcc-14.2.0
hexagon               randconfig-002-20250313    clang-21
hexagon               randconfig-002-20250313    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250313    clang-19
i386        buildonly-randconfig-001-20250313    gcc-12
i386        buildonly-randconfig-002-20250313    clang-19
i386        buildonly-randconfig-002-20250313    gcc-12
i386        buildonly-randconfig-003-20250313    clang-19
i386        buildonly-randconfig-004-20250313    clang-19
i386        buildonly-randconfig-004-20250313    gcc-12
i386        buildonly-randconfig-005-20250313    clang-19
i386        buildonly-randconfig-006-20250313    clang-19
i386        buildonly-randconfig-006-20250313    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250313    clang-19
i386                  randconfig-002-20250313    clang-19
i386                  randconfig-003-20250313    clang-19
i386                  randconfig-004-20250313    clang-19
i386                  randconfig-005-20250313    clang-19
i386                  randconfig-006-20250313    clang-19
i386                  randconfig-007-20250313    clang-19
i386                  randconfig-011-20250313    clang-19
i386                  randconfig-012-20250313    clang-19
i386                  randconfig-013-20250313    clang-19
i386                  randconfig-014-20250313    clang-19
i386                  randconfig-015-20250313    clang-19
i386                  randconfig-016-20250313    clang-19
i386                  randconfig-017-20250313    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250313    gcc-14.2.0
loongarch             randconfig-002-20250313    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250313    gcc-14.2.0
nios2                 randconfig-002-20250313    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250313    gcc-14.2.0
parisc                randconfig-002-20250313    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-16
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250313    clang-16
powerpc               randconfig-001-20250313    gcc-14.2.0
powerpc               randconfig-002-20250313    clang-18
powerpc               randconfig-002-20250313    gcc-14.2.0
powerpc               randconfig-003-20250313    gcc-14.2.0
powerpc64             randconfig-001-20250313    gcc-14.2.0
powerpc64             randconfig-002-20250313    gcc-14.2.0
powerpc64             randconfig-003-20250313    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250313    clang-21
riscv                 randconfig-001-20250313    gcc-14.2.0
riscv                 randconfig-002-20250313    clang-21
riscv                 randconfig-002-20250313    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250313    clang-15
s390                  randconfig-001-20250313    gcc-14.2.0
s390                  randconfig-002-20250313    clang-15
s390                  randconfig-002-20250313    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250313    gcc-14.2.0
sh                    randconfig-002-20250313    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250313    gcc-14.2.0
sparc                 randconfig-002-20250313    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250313    gcc-14.2.0
sparc64               randconfig-002-20250313    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250313    clang-21
um                    randconfig-001-20250313    gcc-14.2.0
um                    randconfig-002-20250313    clang-21
um                    randconfig-002-20250313    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250313    clang-19
x86_64      buildonly-randconfig-002-20250313    clang-19
x86_64      buildonly-randconfig-003-20250313    clang-19
x86_64      buildonly-randconfig-004-20250313    clang-19
x86_64      buildonly-randconfig-004-20250313    gcc-12
x86_64      buildonly-randconfig-005-20250313    clang-19
x86_64      buildonly-randconfig-006-20250313    clang-19
x86_64      buildonly-randconfig-006-20250313    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250313    gcc-12
x86_64                randconfig-002-20250313    gcc-12
x86_64                randconfig-003-20250313    gcc-12
x86_64                randconfig-004-20250313    gcc-12
x86_64                randconfig-005-20250313    gcc-12
x86_64                randconfig-006-20250313    gcc-12
x86_64                randconfig-007-20250313    gcc-12
x86_64                randconfig-008-20250313    gcc-12
x86_64                randconfig-071-20250313    gcc-12
x86_64                randconfig-072-20250313    gcc-12
x86_64                randconfig-073-20250313    gcc-12
x86_64                randconfig-074-20250313    gcc-12
x86_64                randconfig-075-20250313    gcc-12
x86_64                randconfig-076-20250313    gcc-12
x86_64                randconfig-077-20250313    gcc-12
x86_64                randconfig-078-20250313    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250313    gcc-14.2.0
xtensa                randconfig-002-20250313    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

