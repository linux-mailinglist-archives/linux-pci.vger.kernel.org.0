Return-Path: <linux-pci+bounces-7314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225328C1C57
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 04:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B02282AF3
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2C13BAFF;
	Fri, 10 May 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1ZsetHw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEE13B7BC
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307466; cv=none; b=IVBKF9hP5m8Jl0LXjlmnsim/1TDAYaQYK8CDrAjE/BX6jUN0H3jko4QEahuRgzubbc0T/0v41wseg6SPO63C6qAv1BJnuq8JFg+gSko/fFUtc1F38v4uHa60iRN+RBm2XypwmFN4FUZ5ZUT+d++LX63UgAZH3QBNMUdL7Wz7VPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307466; c=relaxed/simple;
	bh=M09zyyAC49oqk6DYVjLNqXbzPMg/FU3kwHYtHWdgPhQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JyDIoD+LS4gKBiQsSXQVwjJu2tmPAsMFoH4M4HyMYoUnMSUhq05yy5fVbDytekgQPqFxnPSH2dkyp35OcwmcHxtO3Wqs/nO31OONaSCAVHu77jEZn7EIie/KkmRkqhIIOuFZW6kFYAOokdEGDmj3nLaLA6tglXzelY9Jew2+Ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1ZsetHw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715307461; x=1746843461;
  h=date:from:to:cc:subject:message-id;
  bh=M09zyyAC49oqk6DYVjLNqXbzPMg/FU3kwHYtHWdgPhQ=;
  b=a1ZsetHwo/co0Rext6AFljNdRTD2chtU6wkwwt2Z3qhgH1FUAId7fqmZ
   wDq0fgPhHq7dTk/5zZ/NkD9nrRP1hihobXNiv1zt/oq6rUFmiSVIc1UFh
   iiaYIGZ2kyDK1oLejNBzBTLyThtNf7TqtSzq4PY4loCsRLRjJIttCU7CE
   ymkeVVZK3wgcCfnQNbKpF14gjfOBtAhA9PcLwtdvhUiXTK40/qKDJ8scc
   GfuX+Bbgp5OiaWNOZKV59oqD7nKKo2CGIIEkdmA7wesNYFrGA2ERhk9Af
   SkTWHZqngaRhB713NL9BOqC7MeWDG1ncvYbUQ9nor1x1jlCYe+BGhJKw9
   w==;
X-CSE-ConnectionGUID: /H0IUn3KSg69FHGbNyhFbQ==
X-CSE-MsgGUID: kGsmMvg1RXiCvb6SXsUo3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11146366"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11146366"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 19:17:41 -0700
X-CSE-ConnectionGUID: eiDarMmcSgeJw8fcguUK+Q==
X-CSE-MsgGUID: lDiOCZYYSgmPsKVuDVWh6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="33975329"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 May 2024 19:17:40 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5FpK-0005ch-07;
	Fri, 10 May 2024 02:17:38 +0000
Date: Fri, 10 May 2024 10:17:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 484af35f7e65a78c76b74e8ec71fe6265552a51b
Message-ID: <202405101027.CZLXwwBD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 484af35f7e65a78c76b74e8ec71fe6265552a51b  Merge branch 'pci/misc'

elapsed time: 1462m

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
arc                   randconfig-001-20240510   gcc  
arc                   randconfig-002-20240510   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   clang
arm                   randconfig-001-20240510   gcc  
arm                   randconfig-002-20240510   clang
arm                   randconfig-003-20240510   gcc  
arm                   randconfig-004-20240510   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240510   clang
arm64                 randconfig-002-20240510   gcc  
arm64                 randconfig-003-20240510   clang
arm64                 randconfig-004-20240510   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240510   gcc  
csky                  randconfig-002-20240510   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240510   clang
hexagon               randconfig-002-20240510   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240509   gcc  
i386         buildonly-randconfig-002-20240509   gcc  
i386         buildonly-randconfig-003-20240509   clang
i386         buildonly-randconfig-004-20240509   clang
i386         buildonly-randconfig-005-20240509   gcc  
i386         buildonly-randconfig-006-20240509   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240509   clang
i386                  randconfig-002-20240509   clang
i386                  randconfig-003-20240509   clang
i386                  randconfig-004-20240509   gcc  
i386                  randconfig-005-20240509   clang
i386                  randconfig-006-20240509   gcc  
i386                  randconfig-011-20240509   clang
i386                  randconfig-012-20240509   gcc  
i386                  randconfig-013-20240509   clang
i386                  randconfig-014-20240509   gcc  
i386                  randconfig-015-20240509   gcc  
i386                  randconfig-016-20240509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240510   gcc  
loongarch             randconfig-002-20240510   gcc  
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
nios2                 randconfig-001-20240510   gcc  
nios2                 randconfig-002-20240510   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240510   gcc  
parisc                randconfig-002-20240510   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240510   gcc  
powerpc               randconfig-002-20240510   gcc  
powerpc               randconfig-003-20240510   clang
powerpc64             randconfig-001-20240510   clang
powerpc64             randconfig-002-20240510   clang
powerpc64             randconfig-003-20240510   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240510   clang
riscv                 randconfig-002-20240510   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240510   gcc  
s390                  randconfig-002-20240510   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240510   gcc  
sh                    randconfig-002-20240510   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240510   gcc  
sparc64               randconfig-002-20240510   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240510   gcc  
um                    randconfig-002-20240510   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240510   gcc  
x86_64       buildonly-randconfig-002-20240510   clang
x86_64       buildonly-randconfig-003-20240510   gcc  
x86_64       buildonly-randconfig-004-20240510   clang
x86_64       buildonly-randconfig-005-20240510   gcc  
x86_64       buildonly-randconfig-006-20240510   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240510   gcc  
x86_64                randconfig-002-20240510   clang
x86_64                randconfig-003-20240510   clang
x86_64                randconfig-004-20240510   gcc  
x86_64                randconfig-005-20240510   gcc  
x86_64                randconfig-006-20240510   gcc  
x86_64                randconfig-011-20240510   clang
x86_64                randconfig-012-20240510   clang
x86_64                randconfig-013-20240510   clang
x86_64                randconfig-014-20240510   clang
x86_64                randconfig-015-20240510   clang
x86_64                randconfig-016-20240510   gcc  
x86_64                randconfig-071-20240510   clang
x86_64                randconfig-072-20240510   clang
x86_64                randconfig-073-20240510   clang
x86_64                randconfig-074-20240510   gcc  
x86_64                randconfig-075-20240510   clang
x86_64                randconfig-076-20240510   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240510   gcc  
xtensa                randconfig-002-20240510   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

