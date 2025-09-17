Return-Path: <linux-pci+bounces-36364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E48AB81213
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 19:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389251C02EF2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ADD2FC89C;
	Wed, 17 Sep 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYs6NiAm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705D34BA5E
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129055; cv=none; b=kFp3HPPfc4So0eJW/40g1Xm3O6H5X0RN2cp5J50mEXblRH5fw/uSASYOcHiHIGDuos6Vqe8JWzNz8/LoNHj37SkQsCQg/0bwtYlbZzAK78K+B4+JgdXZjs9hL+YqEzIRA+E4QPuqRGSZD8JKKpfPKqOyaGlhmPA7NTjyY5HiSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129055; c=relaxed/simple;
	bh=RpqCZyf0hZ4jUwOn70wkBzqmcoieUz33ULu9BTR5J+M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NYsDbq+btLLFWLrAigtMyLbeSBWq7G0ZRWkYjRtUu3AzYYiVGuy1GfuwrWmiaUkW4ztcYhIIdgLsU2yHYIQ8HngdgLm/saBKu50dz6ZVQkR5aPiYvpygbnOt41Eq3ajTGIiTs7FzVSC4pHN8w8yhDQPkuFOJlSYycg/fqlHv49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYs6NiAm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758129054; x=1789665054;
  h=date:from:to:cc:subject:message-id;
  bh=RpqCZyf0hZ4jUwOn70wkBzqmcoieUz33ULu9BTR5J+M=;
  b=EYs6NiAm34Y0CtCmEy/I6olBtX3Mm+Lmii4JLhyd9yF/DF1O5DzDvn9Z
   /ib/B+pGF2A3WfNx0UMk7pvCau2VbjAiyXILHELAciP9p7OpmVLqTtU7z
   WklcrJkAFmB5DPfgaHVqN57jC0rcwSESNYALxjpgVI9mUBWWG7Mr406fN
   PlVCa35gWTO8hT2BsZqPonSB4AtLkU1hhOkfWl+83wHigOeV44KbY9K71
   pKMFdnHszJHkvp000UiaODQjSNosqAf/oPPTfjtnWMpHFbmsWr0IVWmI4
   OQR2sVYv4Kp7cSpaL/INmmGLxcdw8GMUOoFJjKELDfEHwyk83NypsaO+O
   A==;
X-CSE-ConnectionGUID: 9wjwqzIwTjqaMcPy3DXzvQ==
X-CSE-MsgGUID: 4Vr/cl03Q4uoekL2b7adBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="83040055"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="83040055"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 10:10:53 -0700
X-CSE-ConnectionGUID: Eq/a+EntQIy595lOkKh+3w==
X-CSE-MsgGUID: DJoLfMTFQP+X9Q+RaIG/mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="180578293"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Sep 2025 10:10:51 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyvg9-0002Fg-24;
	Wed, 17 Sep 2025 17:10:49 +0000
Date: Thu, 18 Sep 2025 01:10:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 43b4f7cd064b2ae11742f33e2af195adae00c617
Message-ID: <202509180138.qTJn3mQP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 43b4f7cd064b2ae11742f33e2af195adae00c617  PCI: Alter misleading recursion to pci_bus_release_bridge_resources()

elapsed time: 1453m

configs tested: 109
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250917    gcc-8.5.0
arc                   randconfig-002-20250917    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20250917    clang-22
arm                   randconfig-002-20250917    gcc-12.5.0
arm                   randconfig-003-20250917    gcc-10.5.0
arm                   randconfig-004-20250917    clang-22
arm                           sunxi_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250917    clang-22
arm64                 randconfig-002-20250917    clang-19
arm64                 randconfig-003-20250917    gcc-10.5.0
arm64                 randconfig-004-20250917    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250917    gcc-12.5.0
csky                  randconfig-002-20250917    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250917    clang-22
hexagon               randconfig-002-20250917    clang-22
i386                             alldefconfig    gcc-14
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250917    gcc-14
i386        buildonly-randconfig-002-20250917    clang-20
i386        buildonly-randconfig-003-20250917    gcc-14
i386        buildonly-randconfig-004-20250917    gcc-14
i386        buildonly-randconfig-005-20250917    gcc-14
i386        buildonly-randconfig-006-20250917    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250917    gcc-15.1.0
loongarch             randconfig-002-20250917    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250917    gcc-11.5.0
nios2                 randconfig-002-20250917    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250917    gcc-14.3.0
parisc                randconfig-002-20250917    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc               randconfig-001-20250917    clang-18
powerpc               randconfig-002-20250917    clang-22
powerpc               randconfig-003-20250917    gcc-9.5.0
powerpc64             randconfig-001-20250917    clang-19
powerpc64             randconfig-002-20250917    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250917    gcc-14.3.0
riscv                 randconfig-002-20250917    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250917    clang-22
s390                  randconfig-002-20250917    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250917    gcc-14.3.0
sh                    randconfig-002-20250917    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250917    gcc-8.5.0
sparc                 randconfig-002-20250917    gcc-14.3.0
sparc64               randconfig-001-20250917    gcc-11.5.0
sparc64               randconfig-002-20250917    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250917    gcc-14
um                    randconfig-002-20250917    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250917    gcc-14
x86_64      buildonly-randconfig-002-20250917    clang-20
x86_64      buildonly-randconfig-003-20250917    clang-20
x86_64      buildonly-randconfig-004-20250917    clang-20
x86_64      buildonly-randconfig-005-20250917    clang-20
x86_64      buildonly-randconfig-006-20250917    gcc-12
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250917    gcc-8.5.0
xtensa                randconfig-002-20250917    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

