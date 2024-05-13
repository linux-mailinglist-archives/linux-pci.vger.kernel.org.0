Return-Path: <linux-pci+bounces-7407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916C28C39D5
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 03:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B771C20847
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 01:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755EA8BF6;
	Mon, 13 May 2024 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiX2DoUd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BBC7489
	for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715563498; cv=none; b=UU/OySrplMdI7Ic01hFfez1GQ3KhKc1/ZypVfrYfJbFY/EVTSGyvV23Yq24IYWkeG9L7PMiZcB7y9jIMKYiK1U/nNnCrVWfMUrI+taA2QbveC33edo7hunH3FPZlUgiLrmw+D8D+ykFl0YjWqNOjAPJZtfAPk1C24csHOAaX8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715563498; c=relaxed/simple;
	bh=RWchYdg2zAGd55ECIpXN+w3wjiaXlyF6bVTL5uTm6sI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=iYlS8b4vKUiji0/9xW+sEgg2w0DEkgdcMCPjt2aShW6SAr0GuNFq/IGk3HDE9lS2wRNLLgKooAv78VEfrvDeLCcLCJjn8a8rbX3lshRmjQxjOTokbDV8L9MZH6qW2HFoyQXuQfXMa8gL3LKG+h9EZI4MXdMQ0VIOUyUcrks2tDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiX2DoUd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715563496; x=1747099496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RWchYdg2zAGd55ECIpXN+w3wjiaXlyF6bVTL5uTm6sI=;
  b=MiX2DoUdkYlg1RT+6dvMeZNGGBx7G6WFhSvT2JpX+f3ZzKk8FboU1grO
   Vnfy6LYk0Yo/txVxvo+dWYu6Xpiom05uUQpWIeyZIxAzqev1So3rrgZ3r
   uzKxNCRzJYe+oQoc7CkjHmIRkJGRaPAnpPFNjfbp8YoaC4PhW33RIR3Zv
   WZ2tsHr4R5WC4qQMgOdqjtKRixnxO/A3BmOCh6lMeON0TLDc4RWwUVI0k
   MgA3Nv9IX4dRlDlcntkESFxlg9lL4cKAPTL2ossMI8hvbsGP4+IU/UWQ0
   F0XyLIi8VA1/3Q9IdN/zeX5k6hq5xarwQLnlAKr9UelxKxO36XuZHNlNq
   A==;
X-CSE-ConnectionGUID: g1eS+TuVTzC2uJUvIdmBNw==
X-CSE-MsgGUID: BunMZITAR5yO312IX2NLEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11492814"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="11492814"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 18:24:56 -0700
X-CSE-ConnectionGUID: qRWEhFobS1C/kBB1A3Qj7Q==
X-CSE-MsgGUID: 1yRObbQjRPe+uqhcXc4YZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="60997773"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 May 2024 18:24:54 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6KQu-0009N5-0K;
	Mon, 13 May 2024 01:24:52 +0000
Date: Mon, 13 May 2024 09:24:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:qcom] BUILD SUCCESS
 ce38ead6a0ed58608fe8b9fb8f7eaa3182dcb43a
Message-ID: <202405130924.dGyE1KrK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git qcom
branch HEAD: ce38ead6a0ed58608fe8b9fb8f7eaa3182dcb43a  PCI: qcom-ep: Override NO_SNOOP attribute for SA8775P EP

elapsed time: 726m

configs tested: 179
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
arc                   randconfig-001-20240513   gcc  
arc                   randconfig-002-20240513   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                        mvebu_v7_defconfig   clang
arm                   randconfig-001-20240513   clang
arm                   randconfig-002-20240513   gcc  
arm                   randconfig-003-20240513   clang
arm                   randconfig-004-20240513   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240513   gcc  
arm64                 randconfig-002-20240513   gcc  
arm64                 randconfig-003-20240513   clang
arm64                 randconfig-004-20240513   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240513   gcc  
csky                  randconfig-002-20240513   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240513   clang
hexagon               randconfig-002-20240513   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-002-20240512   clang
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-006-20240512   clang
i386                                defconfig   clang
i386                  randconfig-001-20240512   clang
i386                  randconfig-002-20240512   clang
i386                  randconfig-003-20240512   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-005-20240512   clang
i386                  randconfig-006-20240512   clang
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-012-20240512   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-014-20240512   clang
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240512   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240513   gcc  
loongarch             randconfig-002-20240513   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        maltaup_defconfig   clang
mips                          rb532_defconfig   clang
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240513   gcc  
nios2                 randconfig-002-20240513   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240513   gcc  
parisc                randconfig-002-20240513   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                       ppc64_defconfig   clang
powerpc               randconfig-001-20240513   gcc  
powerpc               randconfig-002-20240513   gcc  
powerpc               randconfig-003-20240513   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240513   gcc  
powerpc64             randconfig-002-20240513   clang
powerpc64             randconfig-003-20240513   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240513   gcc  
riscv                 randconfig-002-20240513   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240513   gcc  
s390                  randconfig-002-20240513   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                    randconfig-001-20240513   gcc  
sh                    randconfig-002-20240513   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240513   gcc  
sparc64               randconfig-002-20240513   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240513   clang
um                    randconfig-002-20240513   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240513   gcc  
x86_64       buildonly-randconfig-002-20240513   gcc  
x86_64       buildonly-randconfig-003-20240513   gcc  
x86_64       buildonly-randconfig-004-20240513   clang
x86_64       buildonly-randconfig-005-20240513   clang
x86_64       buildonly-randconfig-006-20240513   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240513   clang
x86_64                randconfig-002-20240513   clang
x86_64                randconfig-003-20240513   clang
x86_64                randconfig-004-20240513   gcc  
x86_64                randconfig-005-20240513   clang
x86_64                randconfig-006-20240513   clang
x86_64                randconfig-011-20240513   clang
x86_64                randconfig-012-20240513   gcc  
x86_64                randconfig-013-20240513   clang
x86_64                randconfig-014-20240513   clang
x86_64                randconfig-015-20240513   gcc  
x86_64                randconfig-016-20240513   clang
x86_64                randconfig-071-20240513   clang
x86_64                randconfig-072-20240513   clang
x86_64                randconfig-073-20240513   clang
x86_64                randconfig-074-20240513   gcc  
x86_64                randconfig-075-20240513   gcc  
x86_64                randconfig-076-20240513   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240513   gcc  
xtensa                randconfig-002-20240513   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

