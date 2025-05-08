Return-Path: <linux-pci+bounces-27418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB071AAF318
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 07:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F931C05028
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 05:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DCB13C3F2;
	Thu,  8 May 2025 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbg9q/lo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D461D5AB7
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746683292; cv=none; b=aCaB4cqMT11zkiTuF6ZFlvN//dbnaZexdpe76Rzld3kpnQ9P6douz+3YxxFwSR5r+/Qpce3Sgqq2CabP4AbzGKlYQAkscdvmz5JjIhnTA2pfnBz2ghMSv0XHCErGEM6aO0qtl+yy23hT0Pr0bkJDFUaGyYSwrLOoU2QJcQPwMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746683292; c=relaxed/simple;
	bh=smEsDZzUktfU7Jd50zX0cjpAkZN8FaBsEglYxcC8FX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=F2QSOTZLQlGgHkFVI3g1l0x9bbF5+WiLFu/SDpq2+oxjJf0g/x96+Cr0W8Py4CgFvbFLZKcbR2/phKRGUqWJNG+34Ui9HVREZJhGT+X6QS0AgXq0k7gIsXxy26b4z0INtkQ4GPuarmZe5AsiIZZRCDRc9vGr1NxZw7VcL5pZdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbg9q/lo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746683291; x=1778219291;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=smEsDZzUktfU7Jd50zX0cjpAkZN8FaBsEglYxcC8FX4=;
  b=jbg9q/loBkEGzOnXJtqfk3P6xxcAGXyaJHxA2XCBdhIW6fZ2ogxuoJ3p
   6NxWmgbtI5OWfKXNMeEtWZr4+kHN8U9eJgrEQaeabb5mTnuzmbXffRYN9
   pGS9Zdqpka0YHZliEEDoO/j6OiFkpKW4C93tfkC4F2jACHfy3B593mu5K
   f8TCrNegVQpRbMzrDc3vCEuRMv4S3AcLm9KoA4IoFY00vEjcBwzQzOQle
   Ro+WdCNOZQzfA8nLIbH60wZ32LXoYO37a8My83ExNKENlO21EpcYUrrXr
   Tyu4v06owttbqRjEEjz684wFQtJgbs/OQgVNV/jn658z67JoBm9MUcXXm
   A==;
X-CSE-ConnectionGUID: BoqmWA4FTa+KQo3W28+P0g==
X-CSE-MsgGUID: NW3SvfbjRh2BAVnvZPeDbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="70953265"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="70953265"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 22:48:10 -0700
X-CSE-ConnectionGUID: qaJTeQYbSh2VwxOmKpWm9g==
X-CSE-MsgGUID: FKQXHFCMRfK2NAy2bnvkGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136199910"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2025 22:48:09 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCu74-000ASz-2i;
	Thu, 08 May 2025 05:48:06 +0000
Date: Thu, 08 May 2025 13:47:55 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 69dcbfec5f020b7be09cbcb5f05b9f295c285f49
Message-ID: <202505081349.8ebCHozM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git fo=
r-linus
branch HEAD: 69dcbfec5f020b7be09cbcb5f05b9f295c285f49  MAINTAINERS: Update =
Krzysztof Wilczy=C5=84ski email address

elapsed time: 8032m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250503    gcc-14.2.0
arc                   randconfig-002-20250503    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250503    gcc-6.5.0
arm                   randconfig-002-20250503    clang-21
arm                   randconfig-003-20250503    gcc-6.5.0
arm                   randconfig-004-20250503    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250503    gcc-9.5.0
arm64                 randconfig-002-20250503    clang-21
arm64                 randconfig-003-20250503    clang-21
arm64                 randconfig-004-20250503    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250503    gcc-14.2.0
csky                  randconfig-002-20250503    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250503    clang-21
hexagon               randconfig-002-20250503    clang-16
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250503    gcc-12
i386        buildonly-randconfig-002-20250503    gcc-12
i386        buildonly-randconfig-003-20250503    gcc-12
i386        buildonly-randconfig-004-20250503    clang-20
i386        buildonly-randconfig-005-20250503    gcc-12
i386        buildonly-randconfig-006-20250503    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250503    gcc-14.2.0
loongarch             randconfig-002-20250503    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250503    gcc-11.5.0
nios2                 randconfig-002-20250503    gcc-7.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250503    gcc-8.5.0
parisc                randconfig-002-20250503    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc               randconfig-001-20250503    gcc-5.5.0
powerpc               randconfig-002-20250503    gcc-9.3.0
powerpc               randconfig-003-20250503    clang-21
powerpc64             randconfig-001-20250503    gcc-7.5.0
powerpc64             randconfig-002-20250503    gcc-10.5.0
powerpc64             randconfig-003-20250503    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                 randconfig-001-20250503    clang-20
riscv                 randconfig-002-20250503    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250503    gcc-7.5.0
s390                  randconfig-002-20250503    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250503    gcc-5.5.0
sh                    randconfig-002-20250503    gcc-5.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250503    gcc-8.5.0
sparc                 randconfig-002-20250503    gcc-14.2.0
sparc64               randconfig-001-20250503    gcc-10.5.0
sparc64               randconfig-002-20250503    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250503    clang-21
um                    randconfig-002-20250503    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250503    gcc-12
x86_64      buildonly-randconfig-002-20250503    gcc-12
x86_64      buildonly-randconfig-003-20250503    gcc-12
x86_64      buildonly-randconfig-004-20250503    gcc-12
x86_64      buildonly-randconfig-005-20250503    clang-20
x86_64      buildonly-randconfig-006-20250503    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250503    gcc-10.5.0
xtensa                randconfig-002-20250503    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

