Return-Path: <linux-pci+bounces-16762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88F9C8D2D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 15:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937F9B24FB8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C83D0C5;
	Thu, 14 Nov 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HELFTVLt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF811C6BE
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595446; cv=none; b=uHMKufNzvops23kZr6CnesUGgu5VgiUV9w7QtAYYH4gUnutH6lzi1DIE/qQBVky3ljjwEt7WG0WgcwzYSL/iRhp4c8nyjsEf9pelEvSJaaMBABF4Le67hThN2q8DIKZ3++nE56YLyfBhjRoxjauLHJgBxaiKfk4j6Yg4ijP24OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595446; c=relaxed/simple;
	bh=oujAPAtZxKK8Xtzc0tiMTWiFE+FjwXSawqQuzQjsp1U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rD0W9JGRzQLYC0Cg+Tj/Jqj6CZ7vs2kQd13GTL3Pn+N3G+LAtXis31iP7m5pZsaTdX8zXe8vV4UO01H4M0+xYMS19lrop2P3jkgWDsflkbMmjjlnqkw7Bb5fgf8LHcZm/IrMqdNDTFAPyZYo74AgR80XIHbgNkIqIsU6I7qj/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HELFTVLt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731595444; x=1763131444;
  h=date:from:to:cc:subject:message-id;
  bh=oujAPAtZxKK8Xtzc0tiMTWiFE+FjwXSawqQuzQjsp1U=;
  b=HELFTVLtubm4UpFmVr3ekYCMFiMl3opQBpzhxKvunCs/bfODqMlf6gfN
   gzqBjE0APwe6he2OTE1HNdXb1jnCOqYNpVA+hOeYWrKFVwFaATMBwwB4G
   4++SiF0ePX2ONt/NEhRsTDda+IsExcGvuxc0hw9rVSOJXjwxAdvZZJ9r9
   r6zYl2LppIrOLMmwhNZa24qKBOdFzd8yuuzJDWTMQgDU6YSfyQCvurW00
   LFmMstMYXFsBrZhZ5u2ecbLotpeO1q+UbqaRumCXkytPkQHAsGiX3swoL
   EMLV+M6EuozYKsYEKtc7SrhgVshqLucLy4KmzFdebBEy0FGZCHHbewr4p
   Q==;
X-CSE-ConnectionGUID: tyqRgXSkSlW8WnN8BhUxIg==
X-CSE-MsgGUID: 7EEwAnxzQSq6HEdw5LKIlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="30926319"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="30926319"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:44:04 -0800
X-CSE-ConnectionGUID: s+TWVt2ATjC88hdZHOZM8w==
X-CSE-MsgGUID: OKGS6p4FQzKNo/TPcgk+Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="125743291"
Received: from lkp-server01.sh.intel.com (HELO c7bc087bbc55) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 06:44:03 -0800
Received: from kbuild by c7bc087bbc55 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBb4i-00006T-2R;
	Thu, 14 Nov 2024 14:44:00 +0000
Date: Thu, 14 Nov 2024 22:43:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug-octeon] BUILD SUCCESS
 e434e54d3ffcd17eeadfcf3cf434bc1dff36daff
Message-ID: <202411142242.lEj3HsXp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug-octeon
branch HEAD: e434e54d3ffcd17eeadfcf3cf434bc1dff36daff  PCI: hotplug: Add OCTEON PCI hotplug controller driver

elapsed time: 878m

configs tested: 69
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
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241114    clang-19
i386        buildonly-randconfig-002-20241114    gcc-11
i386        buildonly-randconfig-003-20241114    gcc-12
i386        buildonly-randconfig-004-20241114    gcc-12
i386        buildonly-randconfig-005-20241114    gcc-12
i386        buildonly-randconfig-006-20241114    clang-19
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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

