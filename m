Return-Path: <linux-pci+bounces-22118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07442A40C15
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 00:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599691899605
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74121A2397;
	Sat, 22 Feb 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2xiKTtq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A881FC0FF
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740265712; cv=none; b=sZOngNPrzwEInGUzYezzyHtMr19FqODnrb8IapXXXxhRL1uvAu6M3ww02R05sseGA/2Oc/+6h5GM1bxFVjkBTG8K2DxxpvI9Rwc6ksOrbXzK0mw/3e6sDcegw4mkBiVUjI/jqnjsTj3Tebbzq5B6Ma1Bbmz60DKuCTMiq/YQ45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740265712; c=relaxed/simple;
	bh=JtkFUSaOx3u9qB5LASh6bVenp8hwAQ08iDEZcSyvBfc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OpeGa3RhYpnYUtUQ/FmY2k4p9g6aLF/0A3GvM2rTyUx1PRDyzH5XPatQotZeg3MjmOEUhpCTm1tRP30hPcOLytJgZ2X9yFIbxoDnlpjqcMPY8lOkLLbudJ6B/UQDlII9vsKYI8RZu1Bh4ijuvzdwvD/l9EhbTDx4PIxjnTPUd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2xiKTtq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740265712; x=1771801712;
  h=date:from:to:cc:subject:message-id;
  bh=JtkFUSaOx3u9qB5LASh6bVenp8hwAQ08iDEZcSyvBfc=;
  b=a2xiKTtq/h++bVzdVk4nC3RRmtLHHufWKQ0tT13VJ0W6wMkDozVHDj+S
   Ms4tVWV+PsFW51kfk9G2m6xzf5oSv25+bxKe4PzCSbZIBGhkI4su8rLpE
   hcdC8KeTgNcynDgPWINAJlCBMx0RIJQwixc2jexO+5FrNWartojRYSTl9
   Ojoj7gf8DJVRx8b3/gwnNqiCj3dCnugE4o/SzX+GLYt6B6ImPmZOA5b4h
   yfWQBmOnJuBYXg9fCotLCdyEMAzn6Ua0bdWreIhxBDJGoka7Yg9p1jTER
   tXQ9FvUzQVn2A5FepC6IA95CaPlzQfBYoPsYH4h0tqQHQ3v/6ZqZwZnqJ
   Q==;
X-CSE-ConnectionGUID: bGeGuRl/Tw+o2qFJMifp6g==
X-CSE-MsgGUID: skCNB2b2RLC69JyCouiz6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="41177965"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="41177965"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 15:08:29 -0800
X-CSE-ConnectionGUID: m4LWVVUqT+yHQCN/rTU3zQ==
X-CSE-MsgGUID: MBierkUtRhWPqokxwsUpAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146600913"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Feb 2025 15:08:27 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlybg-0006yb-27;
	Sat, 22 Feb 2025 23:08:24 +0000
Date: Sun, 23 Feb 2025 07:08:01 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:resource] BUILD SUCCESS
 6f7da2a12f399641950510b7d79bc29839f90ef4
Message-ID: <202502230755.cqa77RDm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git resource
branch HEAD: 6f7da2a12f399641950510b7d79bc29839f90ef4  PCI: Increase Resizable BAR support from 512 GB to 128 TB

elapsed time: 1446m

configs tested: 84
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250222    gcc-13.2.0
arc                   randconfig-002-20250222    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20250222    gcc-14.2.0
arm                   randconfig-002-20250222    gcc-14.2.0
arm                   randconfig-003-20250222    clang-16
arm                   randconfig-004-20250222    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250222    gcc-14.2.0
arm64                 randconfig-002-20250222    clang-21
arm64                 randconfig-003-20250222    clang-18
arm64                 randconfig-004-20250222    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250222    gcc-14.2.0
csky                  randconfig-002-20250222    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250222    clang-17
hexagon               randconfig-002-20250222    clang-19
i386        buildonly-randconfig-001-20250222    clang-19
i386        buildonly-randconfig-002-20250222    gcc-12
i386        buildonly-randconfig-003-20250222    gcc-12
i386        buildonly-randconfig-004-20250222    clang-19
i386        buildonly-randconfig-005-20250222    gcc-12
i386        buildonly-randconfig-006-20250222    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250222    gcc-14.2.0
loongarch             randconfig-002-20250222    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250222    gcc-14.2.0
nios2                 randconfig-002-20250222    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250222    gcc-14.2.0
parisc                randconfig-002-20250222    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250222    gcc-14.2.0
powerpc               randconfig-002-20250222    gcc-14.2.0
powerpc               randconfig-003-20250222    gcc-14.2.0
powerpc64             randconfig-001-20250222    gcc-14.2.0
powerpc64             randconfig-002-20250222    clang-16
powerpc64             randconfig-003-20250222    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250222    clang-21
riscv                 randconfig-002-20250222    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250222    gcc-14.2.0
s390                  randconfig-002-20250222    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250222    gcc-14.2.0
sh                    randconfig-002-20250222    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250222    gcc-14.2.0
sparc                 randconfig-002-20250222    gcc-14.2.0
sparc64               randconfig-001-20250222    gcc-14.2.0
sparc64               randconfig-002-20250222    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250222    gcc-12
um                    randconfig-002-20250222    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250222    clang-19
x86_64      buildonly-randconfig-002-20250222    gcc-12
x86_64      buildonly-randconfig-003-20250222    gcc-12
x86_64      buildonly-randconfig-004-20250222    clang-19
x86_64      buildonly-randconfig-005-20250222    clang-19
x86_64      buildonly-randconfig-006-20250222    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250222    gcc-14.2.0
xtensa                randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

