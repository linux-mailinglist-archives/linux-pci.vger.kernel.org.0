Return-Path: <linux-pci+bounces-5398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECB289188E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 13:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D990F285716
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9685620;
	Fri, 29 Mar 2024 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeuZ/XsB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA32F9E9
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714732; cv=none; b=HRd3xE2W/EI3qN0MsnN/boNDvBAvkdUrqUCQE3zhw3jXa3WZMeOJLEVA59me/NewpxCVZv9puydqgtN1PSJ0qEfMvfeAzCaytbhYXTCjyKqf95HkRr/ilClsklzoDNPaAcKrMYSIZ3Mq93OTZSBZcLZ1ioIMH1ZH5Z94FGgFjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714732; c=relaxed/simple;
	bh=Q8B/eGfpxrxPX7OG6VU2Sp4pHEeS3UkjnSICM6ch3g4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=duOUaEaWV6rOmAflNXBBt8T6EVxBnwpCb9eFsz+TY5bPBYveA+5PFuAUcw8+bWtZG9viBUqvj4Qe6Nq4CYhBrxHIvE+sHL1tV0DXg/eoOW5QbnVYcRacYhmTZiiztt753dFYvGf6LXxhHaYJSVjQqCv93bhg7k8nmQARsVst19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeuZ/XsB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711714731; x=1743250731;
  h=date:from:to:cc:subject:message-id;
  bh=Q8B/eGfpxrxPX7OG6VU2Sp4pHEeS3UkjnSICM6ch3g4=;
  b=DeuZ/XsB+r3T7TxJtmjMyWtEarnrsNrwYJjflx2wTfD+lotN97jJwfhM
   MZM0i7cHJHkEZTngwEiJHrRQp/3aTHFq9Hir/yY+E6R0+/ecZ+1tqlk+d
   NzZEa4SgtLGSN1QtDukJXmDu9wUfeprQB159mDyntn8tivuqyZ/LSCyg2
   2l5CtM3zcM361Jmsu/Gr9La9zd5DYFpnCW/9mmtsZ5qb7JCGTtvGkI6Ti
   UjvAjdjQ9xS3pbW4ZlczZutGNh3Ks9CDkiqtKA4nOe5fG3fpnrLE+C1Mh
   R6o43WSijPET7l+JY2yUdOY8BLFqckj+Hp1W4+FBIg9HMb2FTdx3rwFs6
   A==;
X-CSE-ConnectionGUID: OGQYQ/MoR46Zbb595f5IsQ==
X-CSE-MsgGUID: IjsbJq0US8+OyS7WMV5KIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6735282"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="6735282"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 05:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="17024643"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Mar 2024 05:18:49 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqBC3-0003Ae-0R;
	Fri, 29 Mar 2024 12:18:47 +0000
Date: Fri, 29 Mar 2024 20:18:34 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 fdd3f7a8ef57af55c1c8859703ffd17dcad5329b
Message-ID: <202403292032.NlfHc7cs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: fdd3f7a8ef57af55c1c8859703ffd17dcad5329b  PCI: Remove unused pci_enable_device_io()

elapsed time: 803m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240329   gcc  
arc                   randconfig-002-20240329   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240329   gcc  
arm                   randconfig-002-20240329   clang
arm                   randconfig-003-20240329   clang
arm                   randconfig-004-20240329   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240329   gcc  
arm64                 randconfig-002-20240329   clang
arm64                 randconfig-003-20240329   clang
arm64                 randconfig-004-20240329   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240329   gcc  
csky                  randconfig-002-20240329   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240329   clang
hexagon               randconfig-002-20240329   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240329   gcc  
i386         buildonly-randconfig-002-20240329   clang
i386         buildonly-randconfig-003-20240329   clang
i386         buildonly-randconfig-004-20240329   clang
i386         buildonly-randconfig-005-20240329   clang
i386         buildonly-randconfig-006-20240329   clang
i386                                defconfig   clang
i386                  randconfig-001-20240329   clang
i386                  randconfig-002-20240329   clang
i386                  randconfig-003-20240329   clang
i386                  randconfig-004-20240329   clang
i386                  randconfig-005-20240329   clang
i386                  randconfig-006-20240329   clang
i386                  randconfig-011-20240329   clang
i386                  randconfig-012-20240329   clang
i386                  randconfig-013-20240329   gcc  
i386                  randconfig-014-20240329   gcc  
i386                  randconfig-015-20240329   gcc  
i386                  randconfig-016-20240329   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240329   gcc  
loongarch             randconfig-002-20240329   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240329   gcc  
nios2                 randconfig-002-20240329   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240329   gcc  
parisc                randconfig-002-20240329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240329   clang
powerpc               randconfig-002-20240329   gcc  
powerpc               randconfig-003-20240329   clang
powerpc64             randconfig-001-20240329   gcc  
powerpc64             randconfig-002-20240329   clang
powerpc64             randconfig-003-20240329   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240329   gcc  
riscv                 randconfig-002-20240329   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240329   clang
s390                  randconfig-002-20240329   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240329   gcc  
sh                    randconfig-002-20240329   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240329   gcc  
sparc64               randconfig-002-20240329   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240329   clang
um                    randconfig-002-20240329   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240329   clang
x86_64       buildonly-randconfig-002-20240329   gcc  
x86_64       buildonly-randconfig-003-20240329   gcc  
x86_64       buildonly-randconfig-004-20240329   clang
x86_64       buildonly-randconfig-005-20240329   gcc  
x86_64       buildonly-randconfig-006-20240329   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240329   gcc  
x86_64                randconfig-002-20240329   gcc  
x86_64                randconfig-003-20240329   clang
x86_64                randconfig-004-20240329   gcc  
x86_64                randconfig-005-20240329   clang
x86_64                randconfig-006-20240329   gcc  
x86_64                randconfig-011-20240329   clang
x86_64                randconfig-012-20240329   gcc  
x86_64                randconfig-013-20240329   clang
x86_64                randconfig-014-20240329   clang
x86_64                randconfig-015-20240329   gcc  
x86_64                randconfig-016-20240329   clang
x86_64                randconfig-071-20240329   gcc  
x86_64                randconfig-072-20240329   gcc  
x86_64                randconfig-074-20240329   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240329   gcc  
xtensa                randconfig-002-20240329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

