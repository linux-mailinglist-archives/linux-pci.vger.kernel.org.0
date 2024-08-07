Return-Path: <linux-pci+bounces-11414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0061894A1CE
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 09:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782581F281D5
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34715464E;
	Wed,  7 Aug 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frZ+fF+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C718D651
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016097; cv=none; b=T2gXZTAY7h83ZR22bwXUfvkMiFnFGMuIYJZ8stWFSW94LlCUi2zTW59VPVbMqKv5lc0qA6QktEvlKz0NDf/g9204VCJS0nhlZ0j65Dw+PqWYzQwgP6xIc126tQCqZ7+ijilo8LVSZFFHSlMhmJYKh8XwSf/XzuK79aV7IRnzyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016097; c=relaxed/simple;
	bh=zi9+Pk/CuMwmdUDa1b0/g4iRj2ZC94NjKTK/o95rXTg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q8emQnYyfsYSvqjP2VouDticJMJ9apKLKFr4il6d8MxJCqojR9+SszFO5ve0ki7F91xxCs9UUnOUeNlgH0iYEhdkHkIZ8AHHK3QBP+xI7N5p+b+7YZBRBX1JrOKKM4VdvZXZhAzMgngiRjQuZJ44TFHXpgmGiORDjc9i6K4Z224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frZ+fF+z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723016096; x=1754552096;
  h=date:from:to:cc:subject:message-id;
  bh=zi9+Pk/CuMwmdUDa1b0/g4iRj2ZC94NjKTK/o95rXTg=;
  b=frZ+fF+zWTjsu8IYhMP6iTnrcbC5t4zi9WbL4aPSp07Gqp7p20yPvxps
   yEVXkkQRWCfaNpWCY+w4JZMTwVtqzAzhX9mevnpK3f0FiO3rC+Hqo+Rcw
   MNSXWalHau8+76qu+NmpgpiePpHEQnmzKcfmD7EfwjTzrEKY6g0LER5Wn
   L5cFppyHLxxOwjVOpasBtgmWQYE0yo4W4EFK16jUvXqCdgOGcNjfZ2N7z
   G/rN72J5kGM1Lf09sOiLl7WwbN9dniw4Ks/2yjUGMJ0V06wIps4/+oozE
   runMZnrveY4j/REEoIoxbrhWQPhDulTbiG1aSICDDueEsY+yrmatccIHu
   Q==;
X-CSE-ConnectionGUID: H8yRSJbyQnqjkswxzAoA3Q==
X-CSE-MsgGUID: bEz7AvH+TLSaDcUPPuZCBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="24948936"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="24948936"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 00:34:55 -0700
X-CSE-ConnectionGUID: Ey5bFvAZQKSlmYKfCFRnag==
X-CSE-MsgGUID: RcsBLFRlQ1eRW7qI/9Cx0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61405778"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 07 Aug 2024 00:34:54 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbbC7-0005D3-33;
	Wed, 07 Aug 2024 07:34:51 +0000
Date: Wed, 07 Aug 2024 15:34:43 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 87d5403378cccc557af9e02a8a2c8587ad8b7e9a
Message-ID: <202408071541.jcGPHDQz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 87d5403378cccc557af9e02a8a2c8587ad8b7e9a  PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check config reads

elapsed time: 734m

configs tested: 174
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240807   gcc-13.2.0
arc                   randconfig-002-20240807   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240807   clang-20
arm                   randconfig-002-20240807   gcc-14.1.0
arm                   randconfig-003-20240807   gcc-14.1.0
arm                   randconfig-004-20240807   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240807   gcc-14.1.0
arm64                 randconfig-002-20240807   clang-17
arm64                 randconfig-003-20240807   clang-15
arm64                 randconfig-004-20240807   clang-20
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240807   gcc-14.1.0
csky                  randconfig-002-20240807   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240807   clang-14
hexagon               randconfig-002-20240807   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240807   clang-18
i386         buildonly-randconfig-002-20240807   clang-18
i386         buildonly-randconfig-003-20240807   clang-18
i386         buildonly-randconfig-003-20240807   gcc-12
i386         buildonly-randconfig-004-20240807   clang-18
i386         buildonly-randconfig-005-20240807   clang-18
i386         buildonly-randconfig-006-20240807   clang-18
i386         buildonly-randconfig-006-20240807   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240807   clang-18
i386                  randconfig-001-20240807   gcc-12
i386                  randconfig-002-20240807   clang-18
i386                  randconfig-003-20240807   clang-18
i386                  randconfig-004-20240807   clang-18
i386                  randconfig-004-20240807   gcc-12
i386                  randconfig-005-20240807   clang-18
i386                  randconfig-005-20240807   gcc-12
i386                  randconfig-006-20240807   clang-18
i386                  randconfig-011-20240807   clang-18
i386                  randconfig-012-20240807   clang-18
i386                  randconfig-012-20240807   gcc-11
i386                  randconfig-013-20240807   clang-18
i386                  randconfig-014-20240807   clang-18
i386                  randconfig-015-20240807   clang-18
i386                  randconfig-016-20240807   clang-18
i386                  randconfig-016-20240807   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240807   gcc-14.1.0
loongarch             randconfig-002-20240807   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240807   gcc-14.1.0
nios2                 randconfig-002-20240807   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240807   gcc-14.1.0
parisc                randconfig-002-20240807   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-001-20240807   clang-20
powerpc               randconfig-003-20240807   gcc-14.1.0
powerpc64             randconfig-001-20240807   clang-15
powerpc64             randconfig-002-20240807   gcc-14.1.0
powerpc64             randconfig-003-20240807   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240807   clang-20
riscv                 randconfig-002-20240807   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240807   gcc-14.1.0
s390                  randconfig-002-20240807   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240807   gcc-14.1.0
sh                    randconfig-002-20240807   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240807   gcc-14.1.0
sparc64               randconfig-002-20240807   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240807   gcc-12
um                    randconfig-002-20240807   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240807   clang-18
x86_64       buildonly-randconfig-002-20240807   clang-18
x86_64       buildonly-randconfig-003-20240807   clang-18
x86_64       buildonly-randconfig-004-20240807   clang-18
x86_64       buildonly-randconfig-005-20240807   clang-18
x86_64       buildonly-randconfig-006-20240807   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240807   clang-18
x86_64                randconfig-002-20240807   gcc-12
x86_64                randconfig-003-20240807   clang-18
x86_64                randconfig-004-20240807   gcc-12
x86_64                randconfig-005-20240807   gcc-12
x86_64                randconfig-006-20240807   gcc-12
x86_64                randconfig-011-20240807   clang-18
x86_64                randconfig-012-20240807   gcc-12
x86_64                randconfig-013-20240807   gcc-12
x86_64                randconfig-014-20240807   gcc-12
x86_64                randconfig-015-20240807   clang-18
x86_64                randconfig-016-20240807   clang-18
x86_64                randconfig-071-20240807   clang-18
x86_64                randconfig-072-20240807   clang-18
x86_64                randconfig-073-20240807   gcc-12
x86_64                randconfig-074-20240807   clang-18
x86_64                randconfig-075-20240807   gcc-12
x86_64                randconfig-076-20240807   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240807   gcc-14.1.0
xtensa                randconfig-002-20240807   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

