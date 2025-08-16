Return-Path: <linux-pci+bounces-34133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6776B29067
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 21:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17819AE7381
	for <lists+linux-pci@lfdr.de>; Sat, 16 Aug 2025 19:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1096215F42;
	Sat, 16 Aug 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXosR1lm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241521579F
	for <linux-pci@vger.kernel.org>; Sat, 16 Aug 2025 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374064; cv=none; b=pSdrxhjyLkihFqLKkng/v4ffy8kKki75iWwQbyIVgZztLwaySDnbxGZcHp13NH2C3so3wyXnfYmwqtRDkQhCNExe8NrpAzpZhjfeY/n+48Fsj4h01kf46VXf1EstfbCEzL9Q3zvqbaPUT9NbqGB3zaF2vumUFprDivCR61TfzEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374064; c=relaxed/simple;
	bh=FlesnPxtEjxVLwy5S4N9bNzzLcNMKFfCZOkxHQsEB/g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DgyhRMG4f/v0FhdJ6IMU8tK5SQL+btK2KAtYoQgPM0aX7W38pMCmpPmAWnNqGA85LaBUqYwGksTCI0FWFIlTYRKcd9atLViyallh1qDZobYmAUHLu0GZ6xzrPAwR4p3Ci9+CcQHUk0BHAXx6u4qb+WbAxlbKPBrXFtNqtOZ2h+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXosR1lm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755374063; x=1786910063;
  h=date:from:to:cc:subject:message-id;
  bh=FlesnPxtEjxVLwy5S4N9bNzzLcNMKFfCZOkxHQsEB/g=;
  b=VXosR1lmTEnGGwhjswfddN5scnEk+DuEFo/6LoKsbHrCIiT1sHIfuhFk
   sbLI/drCvVxLB5H1hKH66ggdzqY3BJaHdRqrozQCZHvnXQs9NeI3ZLyl8
   zAT1Rtpwdt2SsJOVl6xoqTA6OQDPMd9GyvPfx4dYXG0Lvm2KSMOkQsRvQ
   BgpYEx2zw+DttmMabrMsE3FhVbEZnodXCUCl9lQnii1+XlV1xVRP5OdVy
   A2hOYuK0VZhcilKra4C1HVVKyk4mo2Hyf2gECon0PAtDe15ar1moHZ375
   y06dn/9EgODRdIZ0/Uaqyd9n2WjnIooJuPddwTgtgfVVH6RnQgJ/eyMJ3
   w==;
X-CSE-ConnectionGUID: SXys/vvlQY+EhDoUgrzfsA==
X-CSE-MsgGUID: sDTnB6tLRJua9vfn15dRxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="80235601"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="80235601"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 12:54:22 -0700
X-CSE-ConnectionGUID: upwI6GaZReWh1NG5HcjWBA==
X-CSE-MsgGUID: Y2KLsqR9RRW2ffyhOwHPgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166872261"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 16 Aug 2025 12:54:22 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unMyp-000D9M-1m;
	Sat, 16 Aug 2025 19:54:19 +0000
Date: Sun, 17 Aug 2025 03:53:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 b98611d72db44eacb75d436a967823ea6d1b55f6
Message-ID: <202508170347.oS0hMlqy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: b98611d72db44eacb75d436a967823ea6d1b55f6  Merge branch 'pci/misc'

elapsed time: 1303m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250816    gcc-8.5.0
arc                   randconfig-002-20250816    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250816    gcc-12.5.0
arm                   randconfig-002-20250816    gcc-10.5.0
arm                   randconfig-003-20250816    gcc-10.5.0
arm                   randconfig-004-20250816    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250816    clang-22
arm64                 randconfig-002-20250816    clang-22
arm64                 randconfig-003-20250816    gcc-8.5.0
arm64                 randconfig-004-20250816    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250816    gcc-15.1.0
csky                  randconfig-002-20250816    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250816    clang-19
hexagon               randconfig-002-20250816    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250816    clang-20
i386        buildonly-randconfig-002-20250816    gcc-12
i386        buildonly-randconfig-003-20250816    gcc-12
i386        buildonly-randconfig-004-20250816    gcc-12
i386        buildonly-randconfig-005-20250816    gcc-12
i386        buildonly-randconfig-006-20250816    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250816    gcc-15.1.0
loongarch             randconfig-002-20250816    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250816    gcc-10.5.0
nios2                 randconfig-002-20250816    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250816    gcc-10.5.0
parisc                randconfig-002-20250816    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20250816    clang-20
powerpc               randconfig-002-20250816    clang-22
powerpc               randconfig-003-20250816    clang-22
powerpc                    socrates_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250816    gcc-8.5.0
powerpc64             randconfig-002-20250816    clang-22
powerpc64             randconfig-003-20250816    clang-16
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250816    clang-22
riscv                 randconfig-002-20250816    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250816    clang-22
s390                  randconfig-002-20250816    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20250816    gcc-15.1.0
sh                    randconfig-002-20250816    gcc-12.5.0
sh                          sdk7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250816    gcc-15.1.0
sparc                 randconfig-002-20250816    gcc-15.1.0
sparc64               randconfig-001-20250816    gcc-11.5.0
sparc64               randconfig-002-20250816    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250816    gcc-12
um                    randconfig-002-20250816    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250816    gcc-12
x86_64      buildonly-randconfig-002-20250816    gcc-12
x86_64      buildonly-randconfig-003-20250816    gcc-12
x86_64      buildonly-randconfig-004-20250816    clang-20
x86_64      buildonly-randconfig-005-20250816    clang-20
x86_64      buildonly-randconfig-006-20250816    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250816    gcc-10.5.0
xtensa                randconfig-002-20250816    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

