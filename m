Return-Path: <linux-pci+bounces-30478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B0AE5D9C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 09:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D489B3BC9A8
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 07:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81EA255E53;
	Tue, 24 Jun 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5oOtpul"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081F2512DD
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750749959; cv=none; b=eI25HbSayi2u2lPfn6GZdVws5kMCBuwUPZilKK/Da1wRmyMHBrR5/BJETGTZNTo5d60zaVBv76wuxANFSgixsD+ei3gJV9XFdEpYIcp0gScAsj9iALXIt1UPjWhTsP31+5W8iF0lTyHGjlQNoUh31tLGj3D+KoJqTpxLuvQfUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750749959; c=relaxed/simple;
	bh=wi3s7vjoNuQPDiEo8O1H4rBCJo/vw74vSxwMe0hxdio=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eJBTLBUmwdKR8TPxesQLKgH5Skesaj6dR+qZFMunqOYM0ZvCk1JZRl1DExZMZE1xJoRDHAK6Et/t1xBkdkzyLl/5H8nMpQtAqv5JPFGB1Frgr2Kyxix5LRazhg/ZeMbeM3m8QWDXIkKOxWJWga58/vNxOc2MbyG515e44eoqwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5oOtpul; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750749957; x=1782285957;
  h=date:from:to:cc:subject:message-id;
  bh=wi3s7vjoNuQPDiEo8O1H4rBCJo/vw74vSxwMe0hxdio=;
  b=P5oOtpul8EPxz05aTikWhsDGIlBeKyzN6mqEYqchlCtIe66wsAyHFqOo
   BRIDHXDpOWUMQHzR0roMu7X15TAktb6EVHC38LUEFcO2l+Ohp0gLhP7L2
   fUevyX7JvrYRav1GwlsS41jAh/4rE/DqWHKwh5cnVtcR6gLzxmHJBw8Xn
   /D8q9LTH0samPw5RJLh/3nnG0nYbfC70ALWfhVE1sd/ek1Pjwmvdq6sF6
   tfi8yL3BhCxfh9kmfYYImTqlvShIaSjnW906zsVkeCA1aZeWzKFbFAVrJ
   o4HV01U6DyyXJPNJSvTfFA6iBSQ61iDkrk7wCHfACkgUR02/m2Zeo7cGP
   g==;
X-CSE-ConnectionGUID: pnEiHaMqRm+NQmvzUYq6Gw==
X-CSE-MsgGUID: oQdFYcLoQG2D+F8bEFHjMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53111982"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53111982"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:25:50 -0700
X-CSE-ConnectionGUID: 0RWJwU21QXKrSBzS1I9qcg==
X-CSE-MsgGUID: RZwetrprRk6cI4sya3GYYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="156127146"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2025 00:25:44 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTy2I-000RrW-27;
	Tue, 24 Jun 2025 07:25:42 +0000
Date: Tue, 24 Jun 2025 15:25:24 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 a364d10ffe361fb34c3838d33604da493045de1e
Message-ID: <202506241514.rMvH9vM5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: a364d10ffe361fb34c3838d33604da493045de1e  PCI: brcmstb: Set MLW based on "num-lanes" DT property if present

elapsed time: 1153m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250623    gcc-10.5.0
arc                   randconfig-001-20250624    gcc-8.5.0
arc                   randconfig-002-20250623    gcc-8.5.0
arc                   randconfig-002-20250624    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250623    gcc-10.5.0
arm                   randconfig-001-20250624    gcc-8.5.0
arm                   randconfig-002-20250623    clang-21
arm                   randconfig-002-20250624    gcc-8.5.0
arm                   randconfig-003-20250623    gcc-8.5.0
arm                   randconfig-003-20250624    gcc-8.5.0
arm                   randconfig-004-20250623    gcc-10.5.0
arm                   randconfig-004-20250624    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250623    gcc-14.3.0
arm64                 randconfig-001-20250624    gcc-8.5.0
arm64                 randconfig-002-20250623    gcc-14.3.0
arm64                 randconfig-002-20250624    gcc-8.5.0
arm64                 randconfig-003-20250623    gcc-9.5.0
arm64                 randconfig-003-20250624    gcc-8.5.0
arm64                 randconfig-004-20250623    clang-16
arm64                 randconfig-004-20250624    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250624    clang-20
i386        buildonly-randconfig-001-20250624    gcc-12
i386        buildonly-randconfig-002-20250624    gcc-12
i386        buildonly-randconfig-003-20250624    clang-20
i386        buildonly-randconfig-003-20250624    gcc-12
i386        buildonly-randconfig-004-20250624    clang-20
i386        buildonly-randconfig-004-20250624    gcc-12
i386        buildonly-randconfig-005-20250624    clang-20
i386        buildonly-randconfig-005-20250624    gcc-12
i386        buildonly-randconfig-006-20250624    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250624    clang-20
x86_64      buildonly-randconfig-002-20250624    clang-20
x86_64      buildonly-randconfig-002-20250624    gcc-12
x86_64      buildonly-randconfig-003-20250624    clang-20
x86_64      buildonly-randconfig-004-20250624    clang-20
x86_64      buildonly-randconfig-005-20250624    clang-20
x86_64      buildonly-randconfig-006-20250624    clang-20
x86_64      buildonly-randconfig-006-20250624    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

