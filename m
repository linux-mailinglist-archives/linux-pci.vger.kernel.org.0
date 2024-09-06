Return-Path: <linux-pci+bounces-12873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5596E938
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 07:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7984A2863C5
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 05:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590C46447;
	Fri,  6 Sep 2024 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+QQ/KvH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0E182C3
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725600319; cv=none; b=Mz3UoacW8J3/YS0d8c/Op1iTtXSLSxejW49EwAd7UGwG8J0AW6SW2yUFYM1aMc73TarImbLT+vcAFfG/Nzgq0DpvEk1o5PmoZMkJMM0zYihJQPPTzqlXWrVJ/B7a/AQtkcIxIts2LM+EaLvZcRFs6tdZNesgLAFUl8qZaufcaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725600319; c=relaxed/simple;
	bh=2EPJNo0Zz47oyoPnae3aD0wlgDV88adtsXwEoMZMjIY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t8DviderW4boCLbGRHM/NO2P1NOu7F/W0i95b/5HxC83mD+i1qFF1e7tZpZ6CoXH9vVGQavESZA81UpM6VnhgWy/Z2kLel3/AuQ6NcPxeLv7Ev8Sj2actbWSLuQLebwxiQrEARXiErZxTyJgo7wPv+MNp7JNMUuZzIyYEjbvIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+QQ/KvH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725600318; x=1757136318;
  h=date:from:to:cc:subject:message-id;
  bh=2EPJNo0Zz47oyoPnae3aD0wlgDV88adtsXwEoMZMjIY=;
  b=O+QQ/KvH/moA0RQ3baC2EAAOwLuGefKVcSAyF1nS7KxfcGUtXbtqOVp8
   kVuWmoOFfzXJf+zZjma3UAtpYxr4OVx5Bt70Ap7XZL5IMbTlRoWNTTIpG
   1F8QBuIVTQO4n0cCzlGdXC2CpXW8XisLoSr4cSsBuZu3bvoAtW2w6Rsnc
   1OfzkJwXS29+pSXeHx5SOYXqy2NyEjU0irYn+NGwu7c9GH3hWwfhYHGch
   hECy6QAQ0umYX8LX8oBkKxP7ADpfAWyiCe1IwnuXF0DjGY144brCdPvMZ
   QkMpSY+XyzgqdjCJRoSsnwE+PJjvc6XwoCzILq7LsHfNNs1o5+qUuQKCO
   w==;
X-CSE-ConnectionGUID: xxQet+zfQHiK6tqnDlCg8Q==
X-CSE-MsgGUID: TaaQEQFwSL+r8P/dpGwsZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="41829737"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="41829737"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 22:25:17 -0700
X-CSE-ConnectionGUID: U7kDH60PR8+qXWR/zC50xQ==
X-CSE-MsgGUID: /lIqpkAmS/eIbfAcWbNuAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="70421269"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Sep 2024 22:25:15 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smRT7-000Ahv-0V;
	Fri, 06 Sep 2024 05:25:13 +0000
Date: Fri, 06 Sep 2024 13:24:55 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 4aefeda2a4fcfef18e3215cbaa9884ec37624096
Message-ID: <202409061353.JG5j5Xx9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 4aefeda2a4fcfef18e3215cbaa9884ec37624096  Merge branch 'pci/misc'

elapsed time: 1805m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240905   clang-18
i386         buildonly-randconfig-001-20240906   gcc-12
i386         buildonly-randconfig-002-20240905   gcc-12
i386         buildonly-randconfig-002-20240906   gcc-12
i386         buildonly-randconfig-003-20240905   gcc-12
i386         buildonly-randconfig-003-20240906   gcc-12
i386         buildonly-randconfig-004-20240905   clang-18
i386         buildonly-randconfig-004-20240906   gcc-12
i386         buildonly-randconfig-005-20240905   clang-18
i386         buildonly-randconfig-005-20240906   gcc-12
i386         buildonly-randconfig-006-20240905   gcc-12
i386         buildonly-randconfig-006-20240906   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240905   gcc-12
i386                  randconfig-001-20240906   gcc-12
i386                  randconfig-002-20240905   clang-18
i386                  randconfig-002-20240906   gcc-12
i386                  randconfig-003-20240905   gcc-12
i386                  randconfig-003-20240906   gcc-12
i386                  randconfig-004-20240905   gcc-11
i386                  randconfig-004-20240906   gcc-12
i386                  randconfig-005-20240905   gcc-12
i386                  randconfig-005-20240906   gcc-12
i386                  randconfig-006-20240905   gcc-12
i386                  randconfig-006-20240906   gcc-12
i386                  randconfig-011-20240905   clang-18
i386                  randconfig-011-20240906   gcc-12
i386                  randconfig-012-20240905   clang-18
i386                  randconfig-012-20240906   gcc-12
i386                  randconfig-013-20240905   gcc-12
i386                  randconfig-013-20240906   gcc-12
i386                  randconfig-014-20240905   clang-18
i386                  randconfig-014-20240906   gcc-12
i386                  randconfig-015-20240905   clang-18
i386                  randconfig-015-20240906   gcc-12
i386                  randconfig-016-20240905   gcc-12
i386                  randconfig-016-20240906   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

