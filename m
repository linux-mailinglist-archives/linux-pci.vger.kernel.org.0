Return-Path: <linux-pci+bounces-16757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9299C8A1E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 13:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB3EB22A74
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1BD1F80C5;
	Thu, 14 Nov 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4F+fa2t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3D1F9ED0
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587970; cv=none; b=lOLfxmrMalKFllyQug7mgyMBEE41NHpIB4BsAMCJqn1vVU+sU4wF1VJc59ga/u/PlklsGO5+Q5IMMy/PBHKeJuuplwQ7YtfA4w780EiOxk/9MOKNLX5oaYJUW6Owv3jcagWo0JhXoMLPAHYuR2LI2aB+d8of93L2a32bDIaz+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587970; c=relaxed/simple;
	bh=AgI1Q+CAfswG6xveY4e37GFKq3BRZ8awcGjwC87KtKs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P+SIjXit3J91hCcjORgjsplT1ZqQuiA1pNY+7837w4zryql6lORIFIEPxady+YqoWCg4zTd+qoUCK09AmTYYbxI1eAgERfdRQGgj2hwyOVNHUUDe9zXmSZKxJMHpQih69SYpk3tkKAA9WSG8yxBRMJN3aMoG1fs1I6w/aB8bwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4F+fa2t; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731587968; x=1763123968;
  h=date:from:to:cc:subject:message-id;
  bh=AgI1Q+CAfswG6xveY4e37GFKq3BRZ8awcGjwC87KtKs=;
  b=J4F+fa2tMv7vKaOf93nUhp6NLbioxr3GY9cuFLWeuLwFfpaYnsp4Kwav
   fCYOF8VvlNSTHiMUkOfcIb2qG2MmHw2yb6TBRdyaGc2u1g5hzDmUwrYll
   F1bnjV1x/Pvbr9eidppJjK6b0dT+BJYAbGsy4aapOF9yjalongEbtO82O
   wee3jhWqZHlN+aKEuRnYb9bLBpB1cHEU3rjMl5taWOHOwZrEFwTbjD0RS
   GKiYWrYzsc1NPl7xz3QXzpI85KYpvtYAOK+gEuP8mafMbZvAqDO5QSQXo
   5uLRebxzbyKtuVtGoJ6HlPX7w+BQIcrAZdmQDFe9QWXLUN8Oauv3XzDcN
   Q==;
X-CSE-ConnectionGUID: zZExGmBETZS7ozsbD4jS/A==
X-CSE-MsgGUID: yfTIxp3kQXuNWwkHCADeBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="30909573"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="30909573"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 04:38:52 -0800
X-CSE-ConnectionGUID: DAu7UVzIQoKXk0NUUQf8DQ==
X-CSE-MsgGUID: 2EEwqtE/TAm1oE/5rpZ3+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="119124698"
Received: from lkp-server01.sh.intel.com (HELO c7bc087bbc55) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Nov 2024 04:38:52 -0800
Received: from kbuild by c7bc087bbc55 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBZ7Z-000032-1m;
	Thu, 14 Nov 2024 12:38:49 +0000
Date: Thu, 14 Nov 2024 20:38:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 a3151e6daaec171b7d46ac79170ec420ad874cae
Message-ID: <202411142016.63jM6zMF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: a3151e6daaec171b7d46ac79170ec420ad874cae  PCI: Warn if a running device is unaware of reset

elapsed time: 826m

configs tested: 68
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241114    gcc-13.2.0
arc                   randconfig-002-20241114    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241114    gcc-14.2.0
arm                   randconfig-002-20241114    gcc-14.2.0
arm                   randconfig-003-20241114    gcc-14.2.0
arm                   randconfig-004-20241114    clang-14
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241114    clang-20
arm64                 randconfig-002-20241114    gcc-14.2.0
arm64                 randconfig-003-20241114    gcc-14.2.0
arm64                 randconfig-004-20241114    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241114    gcc-14.2.0
csky                  randconfig-002-20241114    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-002-20241114    gcc-11
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

