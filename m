Return-Path: <linux-pci+bounces-43479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58399CD35E5
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 20:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9170130011B5
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C026059D;
	Sat, 20 Dec 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XagBcsrG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD75191F98
	for <linux-pci@vger.kernel.org>; Sat, 20 Dec 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766258084; cv=none; b=NU1lZKQoBqecDPUdSt7d0882jGMbywxPDul5PLs6jIumr6UAQEkHTtw7BNnMfd5gvxIJCDV/6Rj7RStOZ3lS2SfXUijXSKd5peGOUlnlYiEynEYbRaDyGK7PTk7coBPLuGb/FQXnqnNSbSlMnMWjk84glACDx1bmvVBc/eLXIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766258084; c=relaxed/simple;
	bh=qy71ujZ3+moEd0Ekk+sURon16rSJ6U47BsszvsjTjoI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BeyqNxbSUPCmBYDmQ0cceuK1Kq+ioQQZc2B424Hb4yjYWf4FdLN3bh+Yax1Gp3+pE82pn0kOowgiw0gqpj86l132H/LmXhfz8KU4z4k4gY2QqIvPPZuI/dcglh2ERksIxWn6xuxZm+HhDFapPZInnhNJzdRM4t6wxTIsRNlANMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XagBcsrG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766258083; x=1797794083;
  h=date:from:to:cc:subject:message-id;
  bh=qy71ujZ3+moEd0Ekk+sURon16rSJ6U47BsszvsjTjoI=;
  b=XagBcsrGJ02EI3mkkuvTwFWqLGlaRGK/RdLpU4+yfbOm1xtO9EqevQ4u
   24H/RKIqZswdsn7iUEEZyYInGsPi4aEcjRVhBmACMFxGTITyd7UoPuWnc
   mr1ARD897rSGmLYWrvvS+9PhBpVceGM2CFM+t0ERSkQQnGE+8Q8jYhECe
   mhO4nKtkVd0FQ8Qez5+Hl7rfM8u+MZyHGpqNUJumBzTnA71Q58aCEt0OX
   DXI2GD0NkgMRbBhfCOg1H7vvLyfo9QKeast8w4dP9uqrGq7vvbxPmwg6s
   90lCQTqlk+QCkwlEdmEzgsLzYtWus1UsnDWEi0ayQcyFovPFjLWEOisTz
   Q==;
X-CSE-ConnectionGUID: Uz6+ONFcQmOC0PD+1a8H7A==
X-CSE-MsgGUID: HGS98id6TiWvwkzC7noNIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="70754116"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="70754116"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 11:14:42 -0800
X-CSE-ConnectionGUID: P70AP1AaQ1uzNaNDwHmHNQ==
X-CSE-MsgGUID: QdxqqF6kRjO8ubS82gDoiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="222631078"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Dec 2025 11:14:41 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX2PW-0000000053l-2s6N;
	Sat, 20 Dec 2025 19:14:38 +0000
Date: Sun, 21 Dec 2025 03:14:37 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dwc] BUILD SUCCESS
 cfd2fdfd0a8da2e5bbfdc4009b9c4b8bf164c937
Message-ID: <202512210323.uZYk3CAg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
branch HEAD: cfd2fdfd0a8da2e5bbfdc4009b9c4b8bf164c937  PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3 transition during suspend if link is not up

elapsed time: 1970m

configs tested: 76
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251220    gcc-14
i386        buildonly-randconfig-002-20251220    gcc-14
i386        buildonly-randconfig-003-20251220    gcc-14
i386        buildonly-randconfig-004-20251220    gcc-14
i386        buildonly-randconfig-005-20251220    gcc-14
i386        buildonly-randconfig-006-20251220    gcc-14
i386                                defconfig    gcc-15.1.0
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc64                          allmodconfig    clang-22
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

