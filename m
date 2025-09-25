Return-Path: <linux-pci+bounces-36913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0844FB9CC64
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 02:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A576A383B8E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 00:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F684CA5E;
	Thu, 25 Sep 2025 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muH7CTae"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D91397
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758552; cv=none; b=bKagHrKQu2o9Uu+9RYP7hkyS1cfmVO4h83loTy4KZPXBSAOUolapIE8xtTwy79p5T/qGIVDt1POLVBnruWZ4eNnYnE+TCkHVjo9jKbuux+ufilBM9STw8rX9Q63YUrpoeHVSVh4o1cZfs36pZtvyw59Y6La6fC+cdPIKGlgRdmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758552; c=relaxed/simple;
	bh=lPkTTmnMVA7jKvWKJn8xy5OpL7s0redlNXsAtLOWTLE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sObGTdS2CWUxZ/qFtgsiwaNYuEWcxK89McgRD5iuFrb+nSjELPGLh0eZd1WOpnWiNrFf7ejFMA53WtPDlB02xkOEP7itHn01AxhDnvWW3yhW1ZHjMlSdtNg0KI0VoNMcWh+2nUUYfXpZC0CVKJBoOjyyujxOSU1ADh9iBETUXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muH7CTae; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758758550; x=1790294550;
  h=date:from:to:cc:subject:message-id;
  bh=lPkTTmnMVA7jKvWKJn8xy5OpL7s0redlNXsAtLOWTLE=;
  b=muH7CTaeQTQt5RIK8ud8nsvipv9WxMEbNs5y7Mg8JKhKivdMyHrBsa/x
   exiX3KRBplaA7lTbs9uT6/sCeFzKKsOIZ1nwmxxul89HmCuPHgAvdEroR
   oCU5NAZ9/+bUQ5BVlhHwVoZr4nl7YS+R2WUPi65SA1NzbFjj2czrxZrMl
   4NSZuS1xna+vwyt/Pr8OiQQ0CzVlqlPNqSINWxw8LMTYfuP/JrmRW8Gvq
   bDQcfKNMph4Nx7VlGMfpABs6YboSyzqDRIUU6KPC+hbWeFNkOsUzFy2oq
   4EoKfbRe/qP4HR8Mp/+dN4tJ75Eyz1U0wWwZJcY08DUqcYrI6i65e0Q77
   A==;
X-CSE-ConnectionGUID: G4vCnRSYSQqiCkhyeQTnbw==
X-CSE-MsgGUID: 1454fRsWRCGdIgHb5k4tpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61013814"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61013814"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 17:02:30 -0700
X-CSE-ConnectionGUID: z7jlCZk+SLOHQS/g1r55Bw==
X-CSE-MsgGUID: ojTBbXazQeiwPWnWqMKzQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176769472"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2025 17:02:28 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1ZQV-0004iN-3A;
	Thu, 25 Sep 2025 00:01:58 +0000
Date: Thu, 25 Sep 2025 08:00:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 2a75658499c74cb96f05e24f6c671803f08be53c
Message-ID: <202509250807.KGZCG9kz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 2a75658499c74cb96f05e24f6c671803f08be53c  Merge branch 'pci/misc'

elapsed time: 1484m

configs tested: 107
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250924    gcc-11.5.0
arc                   randconfig-002-20250924    gcc-14.3.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250924    clang-22
arm                   randconfig-002-20250924    clang-22
arm                   randconfig-003-20250924    clang-22
arm                   randconfig-004-20250924    gcc-13.4.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250924    gcc-14.3.0
arm64                 randconfig-002-20250924    clang-18
arm64                 randconfig-003-20250924    gcc-12.5.0
arm64                 randconfig-004-20250924    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250924    gcc-14.3.0
csky                  randconfig-002-20250924    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250924    clang-22
hexagon               randconfig-002-20250924    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250924    gcc-14
i386        buildonly-randconfig-002-20250924    clang-20
i386        buildonly-randconfig-003-20250924    gcc-13
i386        buildonly-randconfig-004-20250924    gcc-14
i386        buildonly-randconfig-005-20250924    clang-20
i386        buildonly-randconfig-006-20250924    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250924    gcc-15.1.0
loongarch             randconfig-002-20250924    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250924    gcc-11.5.0
nios2                 randconfig-002-20250924    gcc-8.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250924    gcc-12.5.0
parisc                randconfig-002-20250924    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                     rainier_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250924    clang-18
powerpc               randconfig-002-20250924    clang-18
powerpc               randconfig-003-20250924    clang-22
powerpc64             randconfig-001-20250924    clang-22
powerpc64             randconfig-002-20250924    gcc-15.1.0
powerpc64             randconfig-003-20250924    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250924    gcc-8.5.0
riscv                 randconfig-002-20250924    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250924    gcc-8.5.0
s390                  randconfig-002-20250924    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250924    gcc-15.1.0
sh                    randconfig-002-20250924    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250924    gcc-15.1.0
sparc                 randconfig-002-20250924    gcc-8.5.0
sparc64               randconfig-001-20250924    gcc-8.5.0
sparc64               randconfig-002-20250924    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250924    clang-16
um                    randconfig-002-20250924    clang-19
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250924    clang-20
x86_64      buildonly-randconfig-002-20250924    clang-20
x86_64      buildonly-randconfig-003-20250924    clang-20
x86_64      buildonly-randconfig-004-20250924    gcc-14
x86_64      buildonly-randconfig-005-20250924    clang-20
x86_64      buildonly-randconfig-006-20250924    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250924    gcc-13.4.0
xtensa                randconfig-002-20250924    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

