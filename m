Return-Path: <linux-pci+bounces-31562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF990AF9FBD
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 12:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDA65660DD
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B262AD25;
	Sat,  5 Jul 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpTwEvZ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834622E371C
	for <linux-pci@vger.kernel.org>; Sat,  5 Jul 2025 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751712409; cv=none; b=WNusO+ASho4xHE53TquG4RruG3gUaRvFTgJrS4KdugSmqrmuOKDCKQ87GR2N2Y3cKhV/2Ay1xecwKxRU8u6Qy4cUzJVFkawV1AZAR7lDF7HHSzK3jGHKWDx51h0s+VJlNYE//YQCS8cKOKEeipGgx56M4AdbAdF/o5pb49U3dVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751712409; c=relaxed/simple;
	bh=/mlzTgt5HFBYsdSPwjq26qi3lD88sga00Fs9s3730Uw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZKh6cW4LANBnfrfNxMLv2xoT2vu3mHblSIhMc4SbA/NhTHkyV+B99mCSrX8XekwzosxxRgoicAjkveHfn4GBqJiQNqpAQO/Jlq45W4SWK7pU3E9w91SX94gO628Kv3y9NDnsqenF/BBdFqturQhnNU/pBFdkVitG19IvgHRlm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpTwEvZ+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751712408; x=1783248408;
  h=date:from:to:cc:subject:message-id;
  bh=/mlzTgt5HFBYsdSPwjq26qi3lD88sga00Fs9s3730Uw=;
  b=XpTwEvZ+qPq4D26O0AzyRS+uMSxPsKfkb/t/aHYQQ2I6gW3pGQpgHzu5
   wxAL7XHe8NEiG4+44690sGfvvUtZhhLAo/WQPHheRDEwIEGRTgUj13sDd
   5WxFKA8Is/P9awQzyfwvEpIzIYEIdEJV1FSFI8ALfoNKboIdveK77oRXC
   o4Z1PVftCMMwIns3A77uIFqh83WQ4ehNxM4El8HFx+jWt794NL56pjt1L
   zk2fJbXhk2eNk54pNc+TX8Df2jRR6nZObA66ambUswn6VxjUooTw3et1w
   kbaXz8i6+HBUFkuLTvNUrNzM3Af+7CJOLgwV3h3znxA6ePOnDXkh0p+xu
   g==;
X-CSE-ConnectionGUID: H1XV/GFJTxqv+cX9DMl6EA==
X-CSE-MsgGUID: ZU6aUW3wSsK9t9iMZxmoGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53138729"
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="53138729"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 03:46:47 -0700
X-CSE-ConnectionGUID: t1+hnJ8ySgW9C4745GiX5g==
X-CSE-MsgGUID: xycE4VOkTGCdyRGllmikcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="155558014"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Jul 2025 03:46:46 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uY0Ps-0004Rx-04;
	Sat, 05 Jul 2025 10:46:44 +0000
Date: Sat, 05 Jul 2025 18:45:51 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 f3bdfa1d721739058ffb66c6948f8335d3a2ac55
Message-ID: <202507051839.KnCtbjFm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: f3bdfa1d721739058ffb66c6948f8335d3a2ac55  PCI: qcom: Add support for parsing the new Root Port binding

elapsed time: 1063m

configs tested: 128
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250705    gcc-8.5.0
arc                   randconfig-002-20250705    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250705    gcc-12.4.0
arm                   randconfig-002-20250705    clang-21
arm                   randconfig-003-20250705    gcc-8.5.0
arm                   randconfig-004-20250705    gcc-8.5.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250705    gcc-10.5.0
arm64                 randconfig-002-20250705    clang-17
arm64                 randconfig-003-20250705    gcc-11.5.0
arm64                 randconfig-004-20250705    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250705    gcc-10.5.0
csky                  randconfig-002-20250705    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250705    clang-19
hexagon               randconfig-002-20250705    clang-21
i386                             alldefconfig    gcc-12
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250705    gcc-11
i386        buildonly-randconfig-002-20250705    clang-20
i386        buildonly-randconfig-003-20250705    gcc-12
i386        buildonly-randconfig-004-20250705    gcc-12
i386        buildonly-randconfig-005-20250705    gcc-12
i386        buildonly-randconfig-006-20250705    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250705    gcc-15.1.0
loongarch             randconfig-002-20250705    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250705    gcc-8.5.0
nios2                 randconfig-002-20250705    gcc-9.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250705    gcc-9.3.0
parisc                randconfig-002-20250705    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250705    gcc-11.5.0
powerpc               randconfig-002-20250705    gcc-9.3.0
powerpc               randconfig-003-20250705    gcc-12.4.0
powerpc64             randconfig-001-20250705    clang-21
powerpc64             randconfig-002-20250705    clang-21
powerpc64             randconfig-003-20250705    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250705    clang-21
riscv                 randconfig-002-20250705    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250705    clang-21
s390                  randconfig-002-20250705    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250705    gcc-15.1.0
sh                    randconfig-002-20250705    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250705    gcc-13.4.0
sparc                 randconfig-002-20250705    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250705    gcc-8.5.0
sparc64               randconfig-002-20250705    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250705    gcc-12
um                    randconfig-002-20250705    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250705    gcc-12
x86_64      buildonly-randconfig-002-20250705    gcc-12
x86_64      buildonly-randconfig-003-20250705    clang-20
x86_64      buildonly-randconfig-004-20250705    gcc-12
x86_64      buildonly-randconfig-005-20250705    gcc-12
x86_64      buildonly-randconfig-006-20250705    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250705    gcc-12.4.0
xtensa                randconfig-002-20250705    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

