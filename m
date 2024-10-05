Return-Path: <linux-pci+bounces-13884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E258A9918CD
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655EC1F22124
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8978C15854A;
	Sat,  5 Oct 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjS7bssS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3E1B813
	for <linux-pci@vger.kernel.org>; Sat,  5 Oct 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149005; cv=none; b=pwwMDnN2/Wv4LI62B2JXIwuK2B5mvsXEsw3bp9sU+nIAGCKnWLju6YSFY+iW8ze74r/I+xd42eLt8S7r916rUTJ9MPeYfDkLnDhjlxofCn37qGfETo8qBd2Pr5C+Q5S07AlfnfeCmY3Bj+JXgiqs4QqqFcL+Fk22Wyht2iEEC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149005; c=relaxed/simple;
	bh=rA7romAWdyMkNrAH2uSTBsvL8mvgwyC3sQIVHZfVX4k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sd/ENWcbGsx9BFbCxdaHNfXxLDkQCISqpGpd3w5AyuWevbREBimq6KSzv+tij0qTvNFswc5LSPc2LmRf7HvIiF/XxZ0EuhVFujNTu1J3zi1NzMgxdv/8aBMecN72RO6Yk/AAbMGXv7nbBNfSWzQbtLUYiqi8aJxHhg1phi/9Smw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjS7bssS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728149003; x=1759685003;
  h=date:from:to:cc:subject:message-id;
  bh=rA7romAWdyMkNrAH2uSTBsvL8mvgwyC3sQIVHZfVX4k=;
  b=LjS7bssSdRnJ/Nj4ysjtsO8DlvVoIoHAItlUcnhB24izinDYyK/sqWyX
   EvtbHKYaEdk7AvN+KjNl5erduhLLj50DhT1mEMo48GUeVQkw5KwRMiKM7
   x2buNejqJzVR7wDu6zj8uMdmCNyWaklNAI6Be5e+OYEP24R29+9cuQEqs
   Q1TaNKOqHXrrZVviCsBCbZKuS6LDi8JX79Std3SFBYV4Cd+Cy/LBgM27X
   movUvB1LMtjsFQOs3D4yrE88aAM6Ve1Pd38alwCV5QTGyc7aDFPhXf8Ic
   qFLcqfT+Udetr1oKvE3fDJt3di4nE2fdWZu2ZRaS9JocE+C4Rm8gA1Cvd
   w==;
X-CSE-ConnectionGUID: qRcaKOoUTMSyso31hzlUOw==
X-CSE-MsgGUID: 0/Rlfc1sSSqfADIIbEhr7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="31053827"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="31053827"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 10:23:23 -0700
X-CSE-ConnectionGUID: ILXRGfAeSTmbiv+nbMQJBw==
X-CSE-MsgGUID: UCHLXs2WTbKrx3XLlbahRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="74600431"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Oct 2024 10:23:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx8Ux-0003D8-29;
	Sat, 05 Oct 2024 17:23:19 +0000
Date: Sun, 06 Oct 2024 01:22:51 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:pwrseq] BUILD SUCCESS
 98cb476c98e9fb3287aa69b05baf986b7126664b
Message-ID: <202410060137.5ZuXl5rS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrseq
branch HEAD: 98cb476c98e9fb3287aa69b05baf986b7126664b  PCI/pwrctl: Use generic device_get_match_data() instead of OF version

elapsed time: 1149m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241005    clang-18
i386        buildonly-randconfig-002-20241005    clang-18
i386        buildonly-randconfig-003-20241005    clang-18
i386        buildonly-randconfig-004-20241005    clang-18
i386        buildonly-randconfig-005-20241005    clang-18
i386        buildonly-randconfig-005-20241005    gcc-12
i386        buildonly-randconfig-006-20241005    clang-18
i386        buildonly-randconfig-006-20241005    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241005    clang-18
i386                  randconfig-001-20241005    gcc-11
i386                  randconfig-002-20241005    clang-18
i386                  randconfig-003-20241005    clang-18
i386                  randconfig-003-20241005    gcc-12
i386                  randconfig-004-20241005    clang-18
i386                  randconfig-005-20241005    clang-18
i386                  randconfig-006-20241005    clang-18
i386                  randconfig-011-20241005    clang-18
i386                  randconfig-011-20241005    gcc-12
i386                  randconfig-012-20241005    clang-18
i386                  randconfig-013-20241005    clang-18
i386                  randconfig-014-20241005    clang-18
i386                  randconfig-014-20241005    gcc-12
i386                  randconfig-015-20241005    clang-18
i386                  randconfig-015-20241005    gcc-12
i386                  randconfig-016-20241005    clang-18
i386                  randconfig-016-20241005    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241005    gcc-12
x86_64      buildonly-randconfig-002-20241005    gcc-12
x86_64      buildonly-randconfig-003-20241005    gcc-12
x86_64      buildonly-randconfig-004-20241005    gcc-12
x86_64      buildonly-randconfig-005-20241005    gcc-12
x86_64      buildonly-randconfig-006-20241005    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241005    gcc-12
x86_64                randconfig-002-20241005    gcc-12
x86_64                randconfig-003-20241005    gcc-12
x86_64                randconfig-004-20241005    gcc-12
x86_64                randconfig-005-20241005    gcc-12
x86_64                randconfig-006-20241005    gcc-12
x86_64                randconfig-011-20241005    gcc-12
x86_64                randconfig-012-20241005    gcc-12
x86_64                randconfig-013-20241005    gcc-12
x86_64                randconfig-014-20241005    gcc-12
x86_64                randconfig-015-20241005    gcc-12
x86_64                randconfig-016-20241005    gcc-12
x86_64                randconfig-071-20241005    gcc-12
x86_64                randconfig-072-20241005    gcc-12
x86_64                randconfig-073-20241005    gcc-12
x86_64                randconfig-074-20241005    gcc-12
x86_64                randconfig-075-20241005    gcc-12
x86_64                randconfig-076-20241005    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

