Return-Path: <linux-pci+bounces-21152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1178AA30743
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53C016330F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD22D1BD9D2;
	Tue, 11 Feb 2025 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEMzYbke"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32481EE010
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266670; cv=none; b=lsnG8PX1ZFrbiF0lyIY7Ch8MmWMTC62Wj07ErluJAUuS1ndWI4kb6mMdrXlhm9Jwjhd4JAWZbG3+DFGBp1kBPT0v2OsKBWJECh+mhyXmbpOBIbMwwR18CZ2HdK94bFruvtB9yE5LGd8gGhPsTCN37JJqJnOR8HYPHg1KBd9pzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266670; c=relaxed/simple;
	bh=QSeCy4f85Rs81xsPM2Suw6DC9eGJS9HryX8kXOjyFd0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FOHdmca40J/BTd21fpg6uvkaZ6vnErmdHgyZ8BY6iMXtMGaJUQZdCYX91JbaHFY5qOLpgxFS9RKQpCbeC4fAek9nn9S1ADLr5Fq0DyZPZWdyFYPS4MKVjXgVsWNA795UfYJhrKQgYhrs7TgjsJRdIlXTpVM4vMmRWNUxcdOrw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEMzYbke; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739266669; x=1770802669;
  h=date:from:to:cc:subject:message-id;
  bh=QSeCy4f85Rs81xsPM2Suw6DC9eGJS9HryX8kXOjyFd0=;
  b=lEMzYbkeVJ5ZETNighOqGbyKMTrooLoGfIV/RVWB+v1/CgxjoxI+kVSg
   MV9FjTpQIX632VY26JFGbDtm/qBeOPxR7egGUz//dZYsh1UOE2Ygzfliw
   WinmIDSD2Q9yi5p9Bgiduzj7UsMJnKrOnzVYNgdaZAZXDYD9ntO+/oT8A
   L1+OFt3EWCQLi2MRLOJOidwkh8G/SO3516uiH5phaXFfKzaXALVar8/48
   vrO7oYN1Vq/ccR5c5oYimgz+/MruCnhAa7TZ9WAkZR9wb4j0WBgD1RgCL
   sZQAzWrTscjOVFhZ/mQS1HgptOyP/MzQ8PqoLb0g55j3PlpmqGbZ5MyQ5
   Q==;
X-CSE-ConnectionGUID: tBylJgcyTneqpFhfcCpgAg==
X-CSE-MsgGUID: p5oeMeP/SuiSzFTa7AJUXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="42714366"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="42714366"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:37:47 -0800
X-CSE-ConnectionGUID: N5oTEXCYRGmD9BKldujyOA==
X-CSE-MsgGUID: hPzUBn10TKqLJlw/zSuFjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116546053"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Feb 2025 01:37:45 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thmi7-0013yb-2W;
	Tue, 11 Feb 2025 09:37:43 +0000
Date: Tue, 11 Feb 2025 17:36:59 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 235937cb77dc3a976868cd85cdff025c777e2fc8
Message-ID: <202502111753.PhTFabCD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 235937cb77dc3a976868cd85cdff025c777e2fc8  PCI: endpoint: pci-epf-test: Handle endianness properly

elapsed time: 1219m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250210    gcc-13.2.0
arc                   randconfig-001-20250211    clang-19
arc                   randconfig-002-20250210    gcc-13.2.0
arc                   randconfig-002-20250211    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250210    clang-16
arm                   randconfig-001-20250211    clang-19
arm                   randconfig-002-20250210    gcc-14.2.0
arm                   randconfig-002-20250211    clang-19
arm                   randconfig-003-20250210    clang-16
arm                   randconfig-003-20250211    clang-19
arm                   randconfig-004-20250210    gcc-14.2.0
arm                   randconfig-004-20250211    clang-19
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250210    gcc-14.2.0
arm64                 randconfig-001-20250211    clang-19
arm64                 randconfig-002-20250210    clang-21
arm64                 randconfig-002-20250211    clang-19
arm64                 randconfig-003-20250210    clang-21
arm64                 randconfig-003-20250211    clang-19
arm64                 randconfig-004-20250210    gcc-14.2.0
arm64                 randconfig-004-20250211    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250211    gcc-14.2.0
csky                  randconfig-002-20250211    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250211    clang-18
hexagon               randconfig-002-20250211    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250210    gcc-12
i386        buildonly-randconfig-001-20250211    gcc-12
i386        buildonly-randconfig-002-20250210    gcc-12
i386        buildonly-randconfig-002-20250211    gcc-12
i386        buildonly-randconfig-003-20250210    clang-19
i386        buildonly-randconfig-003-20250211    gcc-12
i386        buildonly-randconfig-004-20250210    gcc-12
i386        buildonly-randconfig-004-20250211    gcc-12
i386        buildonly-randconfig-005-20250210    gcc-12
i386        buildonly-randconfig-005-20250211    gcc-12
i386        buildonly-randconfig-006-20250210    gcc-12
i386        buildonly-randconfig-006-20250211    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250211    gcc-14.2.0
loongarch             randconfig-002-20250211    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250211    gcc-14.2.0
nios2                 randconfig-002-20250211    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250211    gcc-14.2.0
parisc                randconfig-002-20250211    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250211    clang-15
powerpc               randconfig-002-20250211    clang-21
powerpc               randconfig-003-20250211    clang-19
powerpc64             randconfig-001-20250211    clang-21
powerpc64             randconfig-002-20250211    gcc-14.2.0
powerpc64             randconfig-003-20250211    clang-17
riscv                            allmodconfig    clang-21
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250211    clang-15
riscv                 randconfig-001-20250211    gcc-14.2.0
riscv                 randconfig-002-20250211    clang-15
riscv                 randconfig-002-20250211    clang-19
s390                             allmodconfig    clang-19
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250211    clang-15
s390                  randconfig-001-20250211    clang-21
s390                  randconfig-002-20250211    clang-15
s390                  randconfig-002-20250211    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250211    clang-15
sh                    randconfig-001-20250211    gcc-14.2.0
sh                    randconfig-002-20250211    clang-15
sh                    randconfig-002-20250211    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250211    clang-15
sparc                 randconfig-001-20250211    gcc-14.2.0
sparc                 randconfig-002-20250211    clang-15
sparc                 randconfig-002-20250211    gcc-14.2.0
sparc64               randconfig-001-20250211    clang-15
sparc64               randconfig-001-20250211    gcc-14.2.0
sparc64               randconfig-002-20250211    clang-15
sparc64               randconfig-002-20250211    gcc-14.2.0
um                               allmodconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250211    clang-15
um                    randconfig-001-20250211    clang-17
um                    randconfig-002-20250211    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250210    clang-19
x86_64      buildonly-randconfig-001-20250211    gcc-12
x86_64      buildonly-randconfig-002-20250210    gcc-12
x86_64      buildonly-randconfig-002-20250211    gcc-12
x86_64      buildonly-randconfig-003-20250210    clang-19
x86_64      buildonly-randconfig-003-20250211    gcc-12
x86_64      buildonly-randconfig-004-20250210    clang-19
x86_64      buildonly-randconfig-004-20250211    gcc-12
x86_64      buildonly-randconfig-005-20250210    clang-19
x86_64      buildonly-randconfig-005-20250211    gcc-12
x86_64      buildonly-randconfig-006-20250210    clang-19
x86_64      buildonly-randconfig-006-20250211    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250211    clang-15
xtensa                randconfig-001-20250211    gcc-14.2.0
xtensa                randconfig-002-20250211    clang-15
xtensa                randconfig-002-20250211    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

