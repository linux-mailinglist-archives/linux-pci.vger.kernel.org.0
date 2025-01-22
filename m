Return-Path: <linux-pci+bounces-20243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9470A1957E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972773A1A76
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FBF1BEF79;
	Wed, 22 Jan 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTsmzOei"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551E38DC0
	for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560460; cv=none; b=eDyZQaHNgrgtaR6Y/tvxpA4XdtKnvJP7o3rPX5ahjpZYVt4dFP2DQF38KV7DIAP/w9gdqZ0p4ktUHnS/xAce0gMfmj8i2AyPnm9ffCJpKqGKs5eY1xaCkQG45vyD5hnEnVnPNu0PhROJiz9oaTe5u+nxjNI4clSdVKj+oZmqNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560460; c=relaxed/simple;
	bh=yhqgus7d/LpmFGBM4aQMY2ATdRMYE/pALCH5rqPuaLc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WdqL+LjRL7qQzeLDS/qWmx9xvNtqp2cBs8KDRSeX7QUjUb0AxSdoCY/aTAwIKgxoEUYsgEObr99AQwwQwZUudTJlI84PbtQ3jfHWeoLSR6gQw10J6yi0TysC9pLfcppyafjk7OKC4psE3oR+/9QNG/4mJREzRtnsjcaaitYYMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTsmzOei; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737560458; x=1769096458;
  h=date:from:to:cc:subject:message-id;
  bh=yhqgus7d/LpmFGBM4aQMY2ATdRMYE/pALCH5rqPuaLc=;
  b=aTsmzOeiD6IFThhonPnhouAl+u35cGkQHIk+onLxxDKco9qWgibbaw/E
   Xo6pJhAyTC5/FsFWmNRl4UrJC5ruaU2T1+HOEHCBJDqNoQlUf1PKMhC48
   Km6J5szwiM5M/lF0Rrtbv39BZJASi29XG0azus4G9qnUKNDqZKvLGWT5p
   DTcDExg40FVoH8RPSgyG0JlN9fxPNNsHJ9ieGI7Y0ybVF8+Z/bUVNZZUm
   jbfLOiPCtFfAPBbqLt1yLcDrSFHHBcl7cZ4Rs+ZxYZ50y3Q/VVKRAQCSW
   ErKxMy2cBt9RJz4mCE9vKq91+xVTsA8ctfLaq6fltUjXZGENjCWuXXNMa
   w==;
X-CSE-ConnectionGUID: uE0BTeUFQRmtD/ygMG7/2A==
X-CSE-MsgGUID: rYMpf1EIQSCqVk42k3ObRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="40843947"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="40843947"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 07:40:57 -0800
X-CSE-ConnectionGUID: 49viswfORxeHAaGLwCd8mQ==
X-CSE-MsgGUID: lBtdIb0ORFWIcHZxwYJIQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="107014503"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Jan 2025 07:40:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tacqc-000a3T-0e;
	Wed, 22 Jan 2025 15:40:54 +0000
Date: Wed, 22 Jan 2025 23:40:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 c25b978d351fae5da87794be9160d8acfa6e6823
Message-ID: <202501222358.1Q17TtNO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: c25b978d351fae5da87794be9160d8acfa6e6823  dt-bindings: PCI: qcom: Document the IPQ5424 PCIe controller

elapsed time: 1325m

configs tested: 175
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250122    gcc-13.2.0
arc                   randconfig-002-20250122    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                            hisi_defconfig    clang-20
arm                        multi_v7_defconfig    gcc-14.2.0
arm                   randconfig-001-20250122    clang-19
arm                   randconfig-002-20250122    clang-20
arm                   randconfig-003-20250122    gcc-14.2.0
arm                   randconfig-004-20250122    gcc-14.2.0
arm                          sp7021_defconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250122    clang-20
arm64                 randconfig-002-20250122    clang-15
arm64                 randconfig-003-20250122    clang-20
arm64                 randconfig-004-20250122    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250122    gcc-14.2.0
csky                  randconfig-002-20250122    gcc-14.2.0
hexagon                          alldefconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20250122    clang-20
hexagon               randconfig-001-20250122    gcc-14.2.0
hexagon               randconfig-002-20250122    clang-20
hexagon               randconfig-002-20250122    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250122    clang-19
i386        buildonly-randconfig-001-20250122    gcc-12
i386        buildonly-randconfig-002-20250122    gcc-12
i386        buildonly-randconfig-003-20250122    gcc-12
i386        buildonly-randconfig-004-20250122    clang-19
i386        buildonly-randconfig-004-20250122    gcc-12
i386        buildonly-randconfig-005-20250122    clang-19
i386        buildonly-randconfig-005-20250122    gcc-12
i386        buildonly-randconfig-006-20250122    clang-19
i386        buildonly-randconfig-006-20250122    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250122    clang-19
i386                  randconfig-002-20250122    clang-19
i386                  randconfig-003-20250122    clang-19
i386                  randconfig-004-20250122    clang-19
i386                  randconfig-005-20250122    clang-19
i386                  randconfig-006-20250122    clang-19
i386                  randconfig-007-20250122    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250122    gcc-14.2.0
loongarch             randconfig-002-20250122    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250122    gcc-14.2.0
nios2                 randconfig-002-20250122    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250122    gcc-14.2.0
parisc                randconfig-002-20250122    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-16
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    clang-20
powerpc               randconfig-001-20250122    gcc-14.2.0
powerpc               randconfig-002-20250122    clang-17
powerpc               randconfig-002-20250122    gcc-14.2.0
powerpc               randconfig-003-20250122    clang-15
powerpc               randconfig-003-20250122    gcc-14.2.0
powerpc                    sam440ep_defconfig    clang-20
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250122    clang-20
powerpc64             randconfig-001-20250122    gcc-14.2.0
powerpc64             randconfig-002-20250122    clang-19
powerpc64             randconfig-002-20250122    gcc-14.2.0
powerpc64             randconfig-003-20250122    clang-20
powerpc64             randconfig-003-20250122    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250122    clang-20
riscv                 randconfig-002-20250122    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250122    clang-18
s390                  randconfig-002-20250122    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250122    gcc-14.2.0
sh                    randconfig-002-20250122    gcc-14.2.0
sh                           se7705_defconfig    clang-20
sh                             sh03_defconfig    clang-20
sh                           sh2007_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250122    gcc-14.2.0
sparc                 randconfig-002-20250122    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250122    gcc-14.2.0
sparc64               randconfig-002-20250122    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250122    gcc-12
um                    randconfig-002-20250122    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250122    gcc-12
x86_64      buildonly-randconfig-002-20250122    clang-19
x86_64      buildonly-randconfig-003-20250122    gcc-12
x86_64      buildonly-randconfig-004-20250122    gcc-12
x86_64      buildonly-randconfig-005-20250122    gcc-12
x86_64      buildonly-randconfig-006-20250122    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250122    gcc-12
x86_64                randconfig-002-20250122    gcc-12
x86_64                randconfig-003-20250122    gcc-12
x86_64                randconfig-004-20250122    gcc-12
x86_64                randconfig-005-20250122    gcc-12
x86_64                randconfig-006-20250122    gcc-12
x86_64                randconfig-007-20250122    gcc-12
x86_64                randconfig-008-20250122    gcc-12
x86_64                randconfig-071-20250122    clang-19
x86_64                randconfig-072-20250122    clang-19
x86_64                randconfig-073-20250122    clang-19
x86_64                randconfig-074-20250122    clang-19
x86_64                randconfig-075-20250122    clang-19
x86_64                randconfig-076-20250122    clang-19
x86_64                randconfig-077-20250122    clang-19
x86_64                randconfig-078-20250122    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250122    gcc-14.2.0
xtensa                randconfig-002-20250122    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

