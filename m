Return-Path: <linux-pci+bounces-29818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B54AD9E7F
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 19:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1AA1893917
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9013334CDD;
	Sat, 14 Jun 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEPXKER2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836D2BB13
	for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749922278; cv=none; b=rzaHuUdmgoPaFx9o6R3Yj5xNNFzz4awRE1BkDYIyDNXtXPB3GuilYDf2B1GEjGYdOIdIqsO6GdVsPzRf5KxhzTWnPRf1k/Giw3442MZQREKHONmibntHbydUnoJJNv6k/F2TR1GmhoyQp8552Fxt6SeZhhkFXZdwbAKzHVExyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749922278; c=relaxed/simple;
	bh=tGGr2pkBBqUcV9CDjncVVl8u1lYnX5DGK2x7Do6nmxU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rJeB7lNnPIHDpZyRx3ytSuq89aHYvC0Qpw1G1jcPPuVwtQVs73wAOsPAiZvQHhhsVCHdMwSqJjkPP+hEDY33k7P19foiRd8T56bU2TrJ8JWcaPtk0wmw8dh7bm0SpYigQiZk8rj/UuXyNaMKMZMV6SkvEkYpVKzg6JISYJRIevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEPXKER2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749922276; x=1781458276;
  h=date:from:to:cc:subject:message-id;
  bh=tGGr2pkBBqUcV9CDjncVVl8u1lYnX5DGK2x7Do6nmxU=;
  b=lEPXKER2a71B90R1F2krhk5U1Bi8S/vwCOzDOX4NEBvyC6MQPBch4uco
   IHmOHM7eFR1TxCk7huFNXo19CSYKtKRW9AdRpRqadCWIOyFKkpL4QRzLm
   gObn00IZqBMeuM3zCTOKRuh6+Extr1oluLLW8Wefhpg/Z+ppP3fLicNXA
   U3r01phd4KNks3rrNX4YgmKKFiLhil1eaclJNMULNs11AU1Ii2ve2BKqt
   Fz7xPVB1aXo3B2EyNf9r5cDycokESy3D/jttbGGalgZT898aUX6mjqE04
   4OuhovlDC4cPpMz+aXJs3z7uPK9u4GUBUpRq2YlbITB7UJlI/pliWLXR5
   w==;
X-CSE-ConnectionGUID: KFhMujRwT8S0mNHPJpeIWg==
X-CSE-MsgGUID: o1jQG+qCS1GEJyygy2JAiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="55919160"
X-IronPort-AV: E=Sophos;i="6.16,237,1744095600"; 
   d="scan'208";a="55919160"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 10:31:13 -0700
X-CSE-ConnectionGUID: 9X9dR7mkTCqYi7Vj4GIyWQ==
X-CSE-MsgGUID: 6km5Y44QSne0SpmncOhJpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,237,1744095600"; 
   d="scan'208";a="147985651"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Jun 2025 10:31:12 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQUik-000Dio-1E;
	Sat, 14 Jun 2025 17:31:10 +0000
Date: Sun, 15 Jun 2025 01:30:21 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/mobiveil] BUILD SUCCESS
 296c2c7f601fca77324d17384dd548418e2eab00
Message-ID: <202506150111.h5AZsUJL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/mobiveil
branch HEAD: 296c2c7f601fca77324d17384dd548418e2eab00  PCI: mobiveil: Use dev_fwnode() for irq_domain_create_simple()

elapsed time: 1445m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250614    gcc-8.5.0
arc                   randconfig-002-20250614    gcc-12.4.0
arm                   randconfig-001-20250614    gcc-8.5.0
arm                   randconfig-002-20250614    clang-21
arm                   randconfig-003-20250614    clang-16
arm                   randconfig-004-20250614    clang-17
arm64                 randconfig-001-20250614    clang-21
arm64                 randconfig-002-20250614    gcc-15.1.0
arm64                 randconfig-003-20250614    clang-21
arm64                 randconfig-004-20250614    gcc-8.5.0
csky                  randconfig-001-20250614    gcc-13.3.0
csky                  randconfig-002-20250614    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250614    clang-21
hexagon               randconfig-002-20250614    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250614    clang-20
i386        buildonly-randconfig-002-20250614    clang-20
i386        buildonly-randconfig-003-20250614    clang-20
i386        buildonly-randconfig-004-20250614    gcc-12
i386        buildonly-randconfig-005-20250614    clang-20
i386        buildonly-randconfig-006-20250614    clang-20
i386                                defconfig    clang-20
loongarch             randconfig-001-20250614    gcc-15.1.0
loongarch             randconfig-002-20250614    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250614    gcc-13.3.0
nios2                 randconfig-002-20250614    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250614    gcc-8.5.0
parisc                randconfig-002-20250614    gcc-11.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250614    gcc-13.3.0
powerpc               randconfig-002-20250614    clang-21
powerpc               randconfig-003-20250614    gcc-12.4.0
powerpc64             randconfig-001-20250614    gcc-11.5.0
powerpc64             randconfig-002-20250614    clang-21
powerpc64             randconfig-003-20250614    gcc-12.4.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250614    clang-21
riscv                 randconfig-002-20250614    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250614    clang-21
s390                  randconfig-002-20250614    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250614    gcc-14.3.0
sh                    randconfig-002-20250614    gcc-12.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250614    gcc-15.1.0
sparc                 randconfig-002-20250614    gcc-10.3.0
sparc64               randconfig-001-20250614    gcc-8.5.0
sparc64               randconfig-002-20250614    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250614    clang-21
um                    randconfig-002-20250614    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250614    clang-20
x86_64      buildonly-randconfig-002-20250614    clang-20
x86_64      buildonly-randconfig-003-20250614    gcc-12
x86_64      buildonly-randconfig-004-20250614    clang-20
x86_64      buildonly-randconfig-005-20250614    clang-20
x86_64      buildonly-randconfig-006-20250614    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250614    gcc-9.3.0
xtensa                randconfig-002-20250614    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

