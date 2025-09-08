Return-Path: <linux-pci+bounces-35685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A3B499E2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F387A0499
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B1246788;
	Mon,  8 Sep 2025 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehyPe7Gx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D51A2381
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359600; cv=none; b=M9LyBT/vhlGicYm6WLRVHznhtwBjDx+ev5rLpYsqtPKJ8tkMxxcIMu8m5Q4lxlQOK/V+3XHoYGOZZGvITwFh9VlibrjSg+o12zoWmnOkl3YB11tmDrL3BUOuvbmY9vRjcG6zNX1vcvD3Nlha6ykhnfsSlFi/DQ8XO6B6pr1DZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359600; c=relaxed/simple;
	bh=v+hmndaIQHMxHasGKm/N9X4srLA+xrPxEgBTbhk6ICI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MoU0TjGLsu9HfLKY4dHoM84rFMZYtEBNDekVjRZmvF+xHHkot6zmCGLnnw/1PQdHY2ZdfZYtpDXWMmv1NwqVD5xJ4fldtCgSL7cW/qQRXhLKjMl5dPiPUE6kR6dHiNydv3izPaulfBuOoHukGbhs9mzPaOckNUxr4TFZ0FgFrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehyPe7Gx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757359599; x=1788895599;
  h=date:from:to:cc:subject:message-id;
  bh=v+hmndaIQHMxHasGKm/N9X4srLA+xrPxEgBTbhk6ICI=;
  b=ehyPe7GxdzUB/PLJ5ies83NxD8T2km7oDeSoTH8tOdfRRs6p4wPwC9/A
   oEoFA5gpktmtqpUN/i7HD8RrfCJoAPPGui0njx20QxQTOfNTFJxXH5lMQ
   r83BDN6qrWbSmTd8iYmswASgHOxNS5ZfbxTWsMJJHekXVgapFwNAIwYF4
   nCR2E9KHM2wj/XQGSSp1aqs2HnNJ1BNRkAHK7DmIoUOFXpnD8/MpBbE8i
   sNWSLdXg9hai4PpKwDASE2aEKP2MrYneqXQZlN90S0W5ptAdHJ/Vjo61x
   e4rV0SD0e1CfWzLkjuO+IcJS+rac6B5jipR8siUVzZwNdClrFJZTBSrDG
   w==;
X-CSE-ConnectionGUID: oOAUVnJiTyew1qusDTqg/Q==
X-CSE-MsgGUID: p7Ps4SGWQ8S+bkTPAHPz3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="47202225"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="47202225"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:26:38 -0700
X-CSE-ConnectionGUID: v0TqilLTSe6+O+tFJXTkKA==
X-CSE-MsgGUID: DdklB4CNQ2S9DEt5GlfwkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="203861165"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Sep 2025 12:26:37 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvhVa-000463-36;
	Mon, 08 Sep 2025 19:26:34 +0000
Date: Tue, 09 Sep 2025 03:26:17 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/hv] BUILD SUCCESS
 ce47f81925ed73f9d27b1a01f07afdb031949c68
Message-ID: <202509090305.htbrYxCk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/hv
branch HEAD: ce47f81925ed73f9d27b1a01f07afdb031949c68  PCI: hv: Remove unused parameter of hv_msi_free()

elapsed time: 807m

configs tested: 150
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250909    clang-16
arc                   randconfig-002-20250909    clang-16
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250909    clang-16
arm                   randconfig-002-20250909    clang-16
arm                   randconfig-003-20250909    clang-16
arm                   randconfig-004-20250909    clang-16
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250909    clang-16
arm64                 randconfig-003-20250909    clang-16
arm64                 randconfig-004-20250909    clang-16
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250908    gcc-14.3.0
csky                  randconfig-002-20250908    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250908    clang-17
hexagon               randconfig-002-20250908    clang-20
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250908    gcc-13
i386        buildonly-randconfig-001-20250909    clang-20
i386        buildonly-randconfig-002-20250908    gcc-13
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-003-20250908    gcc-13
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-004-20250908    gcc-13
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-005-20250908    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-006-20250908    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20250909    gcc-14
i386                  randconfig-012-20250909    gcc-14
i386                  randconfig-013-20250909    gcc-14
i386                  randconfig-014-20250909    gcc-14
i386                  randconfig-015-20250909    gcc-14
i386                  randconfig-016-20250909    gcc-14
i386                  randconfig-017-20250909    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250908    gcc-15.1.0
loongarch             randconfig-002-20250908    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250908    gcc-8.5.0
nios2                 randconfig-002-20250908    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250908    gcc-13.4.0
parisc                randconfig-002-20250908    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                   currituck_defconfig    clang-22
powerpc                     rainier_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250908    gcc-15.1.0
powerpc               randconfig-002-20250908    clang-19
powerpc               randconfig-003-20250908    gcc-9.5.0
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20250908    gcc-8.5.0
powerpc64             randconfig-002-20250908    gcc-10.5.0
powerpc64             randconfig-003-20250908    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250908    gcc-11.5.0
riscv                 randconfig-002-20250908    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250908    clang-22
s390                  randconfig-002-20250908    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                    randconfig-001-20250908    gcc-14.3.0
sh                    randconfig-002-20250908    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250908    gcc-8.5.0
sparc                 randconfig-002-20250908    gcc-12.5.0
sparc64               randconfig-001-20250908    gcc-13.4.0
sparc64               randconfig-002-20250908    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250908    gcc-13
um                    randconfig-002-20250908    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250908    clang-20
x86_64      buildonly-randconfig-001-20250909    gcc-14
x86_64      buildonly-randconfig-002-20250908    gcc-13
x86_64      buildonly-randconfig-002-20250909    gcc-14
x86_64      buildonly-randconfig-003-20250908    gcc-13
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250908    gcc-11
x86_64      buildonly-randconfig-004-20250909    gcc-14
x86_64      buildonly-randconfig-005-20250908    gcc-13
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250908    clang-20
x86_64      buildonly-randconfig-006-20250909    gcc-14
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250908    gcc-9.5.0
xtensa                randconfig-002-20250908    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

