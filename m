Return-Path: <linux-pci+bounces-37289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEC3BAE3F5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 19:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7AC7A8BD1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F202594BE;
	Tue, 30 Sep 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLPeF0c3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C71E868
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759254808; cv=none; b=UoQTYaaLhv/QWjMgbG+mVn6F6MHBSIOSs4qEEiFZ6ywm1OrkOnP3F1Lb8k2kM27KTw3qLFvRHyeTKN6gR7IWb5OEJBnNO+6Bu+veHC7OyA/aflC5iaz37ZedkTglf1liAoNqcHDei41orUTR0BI8ALeYIg376ZKVgIUBZ+xYYpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759254808; c=relaxed/simple;
	bh=k48E7I060zc9A99bweO50GcAZGxfEeuNl4VG6LaVnIQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AjMdsH50rvTEdo1g8mz2Z5wnL/M8h4FQLBvXe9ScEu1ECDIxl75pLOm7yriI7YYEsoMSBYY82MTbiIk34Tikpgr/QZHUc0c7/+8VJ0TofmPBlERUu3sUSPJgnII0dqnqaWEfF/VoH/21peRkBIHOFSdXxlg06P+Z9yK4gjGaNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLPeF0c3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759254807; x=1790790807;
  h=date:from:to:cc:subject:message-id;
  bh=k48E7I060zc9A99bweO50GcAZGxfEeuNl4VG6LaVnIQ=;
  b=GLPeF0c3GbdjTxhNrx+NG2LBXe4N8z7Dt3c5H0UkBZqg9L2M4yFYSZxD
   acPNnbbF78c7zNJ2Dpr/5Ax3UF+IPv5uDAFAyoy13/dUK1jc5JE3bCQVv
   imyD75v6MBS8Liuo87Tq71QFv9NFtFSX28nj+ki4KlZSmyevg9F+fWsRq
   1dXLoGCvXRSwq2MhgLq6gP1BBRqi0eWZa5BDY89QU/CpqCfNVjqQcVDVw
   WzBV+IKo+bJMEQ3BvvdNwdi+avti4NtANBEb13sub50uRhIvmMFZqfYwv
   PMpfQ9GIT530CaeGfHikCa9l+VIIEyArgIeIYW3i/nHcHhCbT09aXHZmo
   w==;
X-CSE-ConnectionGUID: BW5Yu2GmR8ynuG6uKUFB9w==
X-CSE-MsgGUID: pWiL9G+XQ5SGONGbBasJmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="78942203"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="78942203"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 10:53:26 -0700
X-CSE-ConnectionGUID: UwXR+Ko3ToedoFV6mBcymQ==
X-CSE-MsgGUID: qPsf+8EyQ6qWGEUYeay+0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="178627290"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Sep 2025 10:53:25 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3eXS-0002OL-0I;
	Tue, 30 Sep 2025 17:53:22 +0000
Date: Wed, 01 Oct 2025 01:52:34 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/keystone] BUILD SUCCESS
 860daf4ba3c034995bafa4c3756942262a9cd32d
Message-ID: <202510010125.9WL9RpNS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/keystone
branch HEAD: 860daf4ba3c034995bafa4c3756942262a9cd32d  PCI: keystone: Remove the __init macro from non-initialization functions

elapsed time: 1463m

configs tested: 228
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250930    gcc-10.5.0
arc                   randconfig-001-20250930    gcc-9.5.0
arc                   randconfig-002-20250930    gcc-10.5.0
arc                   randconfig-002-20250930    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                          collie_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                         orion5x_defconfig    gcc-15.1.0
arm                   randconfig-001-20250930    gcc-10.5.0
arm                   randconfig-001-20250930    gcc-13.4.0
arm                   randconfig-002-20250930    gcc-10.5.0
arm                   randconfig-002-20250930    gcc-8.5.0
arm                   randconfig-003-20250930    gcc-10.5.0
arm                   randconfig-003-20250930    gcc-8.5.0
arm                   randconfig-004-20250930    gcc-10.5.0
arm                           sama5_defconfig    gcc-15.1.0
arm                          sp7021_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250930    clang-18
arm64                 randconfig-001-20250930    gcc-10.5.0
arm64                 randconfig-002-20250930    clang-22
arm64                 randconfig-002-20250930    gcc-10.5.0
arm64                 randconfig-003-20250930    clang-18
arm64                 randconfig-003-20250930    gcc-10.5.0
arm64                 randconfig-004-20250930    gcc-10.5.0
arm64                 randconfig-004-20250930    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250930    gcc-13.4.0
csky                  randconfig-002-20250930    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250930    clang-22
hexagon               randconfig-002-20250930    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250930    clang-20
i386        buildonly-randconfig-001-20250930    gcc-12
i386        buildonly-randconfig-002-20250930    clang-20
i386        buildonly-randconfig-002-20250930    gcc-14
i386        buildonly-randconfig-003-20250930    clang-20
i386        buildonly-randconfig-004-20250930    clang-20
i386        buildonly-randconfig-004-20250930    gcc-14
i386        buildonly-randconfig-005-20250930    clang-20
i386        buildonly-randconfig-006-20250930    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250930    gcc-14
i386                  randconfig-002-20250930    gcc-14
i386                  randconfig-003-20250930    gcc-14
i386                  randconfig-004-20250930    gcc-14
i386                  randconfig-005-20250930    gcc-14
i386                  randconfig-006-20250930    gcc-14
i386                  randconfig-007-20250930    gcc-14
i386                  randconfig-011-20250930    gcc-14
i386                  randconfig-012-20250930    gcc-14
i386                  randconfig-013-20250930    gcc-14
i386                  randconfig-014-20250930    gcc-14
i386                  randconfig-015-20250930    gcc-14
i386                  randconfig-016-20250930    gcc-14
i386                  randconfig-017-20250930    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch                 loongson3_defconfig    gcc-15.1.0
loongarch             randconfig-001-20250930    clang-22
loongarch             randconfig-002-20250930    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250930    gcc-8.5.0
nios2                 randconfig-002-20250930    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250930    gcc-12.5.0
parisc                randconfig-002-20250930    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    gcc-15.1.0
powerpc                       eiger_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250930    gcc-8.5.0
powerpc               randconfig-002-20250930    gcc-14.3.0
powerpc               randconfig-003-20250930    gcc-15.1.0
powerpc64             randconfig-001-20250930    gcc-14.3.0
powerpc64             randconfig-002-20250930    gcc-12.5.0
powerpc64             randconfig-003-20250930    gcc-11.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250930    gcc-10.5.0
riscv                 randconfig-001-20250930    gcc-12
riscv                 randconfig-002-20250930    clang-22
riscv                 randconfig-002-20250930    gcc-12
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250930    gcc-12
s390                  randconfig-001-20250930    gcc-12.5.0
s390                  randconfig-002-20250930    clang-22
s390                  randconfig-002-20250930    gcc-12
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20250930    gcc-12
sh                    randconfig-001-20250930    gcc-15.1.0
sh                    randconfig-002-20250930    gcc-12
sh                    randconfig-002-20250930    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250930    gcc-11.5.0
sparc                 randconfig-001-20250930    gcc-12
sparc                 randconfig-002-20250930    gcc-12
sparc                 randconfig-002-20250930    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250930    clang-22
sparc64               randconfig-001-20250930    gcc-12
sparc64               randconfig-002-20250930    gcc-12
sparc64               randconfig-002-20250930    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250930    gcc-12
um                    randconfig-001-20250930    gcc-14
um                    randconfig-002-20250930    gcc-12
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250930    clang-20
x86_64      buildonly-randconfig-001-20250930    gcc-14
x86_64      buildonly-randconfig-002-20250930    gcc-14
x86_64      buildonly-randconfig-003-20250930    gcc-14
x86_64      buildonly-randconfig-004-20250930    clang-20
x86_64      buildonly-randconfig-004-20250930    gcc-14
x86_64      buildonly-randconfig-005-20250930    gcc-14
x86_64      buildonly-randconfig-006-20250930    clang-20
x86_64      buildonly-randconfig-006-20250930    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250930    clang-20
x86_64                randconfig-002-20250930    clang-20
x86_64                randconfig-003-20250930    clang-20
x86_64                randconfig-004-20250930    clang-20
x86_64                randconfig-005-20250930    clang-20
x86_64                randconfig-006-20250930    clang-20
x86_64                randconfig-007-20250930    clang-20
x86_64                randconfig-008-20250930    clang-20
x86_64                randconfig-071-20250930    gcc-12
x86_64                randconfig-072-20250930    gcc-12
x86_64                randconfig-073-20250930    gcc-12
x86_64                randconfig-074-20250930    gcc-12
x86_64                randconfig-075-20250930    gcc-12
x86_64                randconfig-076-20250930    gcc-12
x86_64                randconfig-077-20250930    gcc-12
x86_64                randconfig-078-20250930    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250930    gcc-12
xtensa                randconfig-001-20250930    gcc-12.5.0
xtensa                randconfig-002-20250930    gcc-11.5.0
xtensa                randconfig-002-20250930    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

