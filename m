Return-Path: <linux-pci+bounces-42666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B727FCA5A01
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 23:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E65233048424
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6E29ACD8;
	Thu,  4 Dec 2025 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBWYb/r2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65E286415
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764887142; cv=none; b=m+Lc82pxP8kxJTxSu/PV6ixEDvG75UEM77fUC3h1WKQGTd3DptHbngUgIgEXUK4+zB+QSz71lhlIOp+ScwXwfyWfELeyvf7FQ8MlPfc436eo9h9hrg0MzF44EEAL8foVh8Tq6EgrQ0MnhgGdbsH6ZR3Hask/wW0wFT5EbhR5jew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764887142; c=relaxed/simple;
	bh=8Riqf0Cob3AQZCr6hbcj/jTw1aP/3Rb8A0SBom42jGc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zw5capSoXlUV7xKcdVHElAzC2vPI2wARKh7jmkrpH94FI0ai1/zeznnBEHXJU9GpFpZaXn3MOZJEZVpTAH4h/YfCl8dKm5FxDEuz08cUGbAhLKr90W7wNhZ8wJQ3J+8zF3svqGusLx8TKxdWBJJ0O5NCspQRbkKVueFRqfBCgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBWYb/r2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764887140; x=1796423140;
  h=date:from:to:cc:subject:message-id;
  bh=8Riqf0Cob3AQZCr6hbcj/jTw1aP/3Rb8A0SBom42jGc=;
  b=WBWYb/r2d/a9EjfyhhTqxIdpTLb1KsH2bPrJbQuf+r8P/jRv07ebhCqU
   nL77gP+bJNkaRFGN2ZNxx99BJDxoAx3H7OJYyY1OsAFi4afdyPFvBuUMU
   K4zw8yvjllGvej6ksJ8RTMfXH+eEmYMB4mX6/GEGqJ4G7D4l1rwdNgHSI
   pfbPsHAOjIpR+JdXo3mZCHRD1ur96R6QRdQQmHAYYAcI2eAuprYgZL83v
   mONurPXhAZCWqHLu/197MpPBhqa0K3u4IZdmCTIgvQRbnfFkQxgwJZgSG
   A1a2Vk+/49DqBHvYrBVK6dlD+7FZK+x1Ub5y8K2CSQx1YkJQD0h25284z
   Q==;
X-CSE-ConnectionGUID: VZ5h5DwFS8+iKgLjT04eNQ==
X-CSE-MsgGUID: 5+KtA/KnS1uXW7OCSHWFrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66804288"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="66804288"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 14:25:39 -0800
X-CSE-ConnectionGUID: HY16VlrIRQ6elMGgX0y1MQ==
X-CSE-MsgGUID: QXwC9qdMRAqwtanzEQQVgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="194178256"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Dec 2025 14:25:38 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRHlX-00000000EJB-3qpU;
	Thu, 04 Dec 2025 22:25:35 +0000
Date: Fri, 05 Dec 2025 06:25:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:v6.19-merge] BUILD SUCCESS
 c45913e5dc660d63d2ffd6079a65495d471548d0
Message-ID: <202512050656.mtEyS0HT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git v6.19-merge
branch HEAD: c45913e5dc660d63d2ffd6079a65495d471548d0  Merge branch 'next' into v6.19-merge

elapsed time: 1452m

configs tested: 211
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251205    gcc-13.4.0
arc                   randconfig-001-20251205    gcc-8.5.0
arc                   randconfig-002-20251205    gcc-13.4.0
arc                   randconfig-002-20251205    gcc-9.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g4_defconfig    gcc-11.5.0
arm                                 defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    gcc-11.5.0
arm                   randconfig-001-20251205    gcc-13.4.0
arm                   randconfig-001-20251205    gcc-8.5.0
arm                   randconfig-002-20251205    gcc-13.4.0
arm                   randconfig-002-20251205    gcc-8.5.0
arm                   randconfig-003-20251205    gcc-13.4.0
arm                   randconfig-004-20251205    gcc-13.4.0
arm                   randconfig-004-20251205    gcc-8.5.0
arm                         wpcm450_defconfig    gcc-11.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251205    clang-22
arm64                 randconfig-002-20251205    clang-22
arm64                 randconfig-003-20251205    clang-22
arm64                 randconfig-004-20251205    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251205    clang-22
csky                  randconfig-002-20251205    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251205    clang-22
hexagon               randconfig-002-20251205    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251204    gcc-14
i386        buildonly-randconfig-001-20251205    gcc-14
i386        buildonly-randconfig-002-20251204    clang-20
i386        buildonly-randconfig-002-20251205    gcc-14
i386        buildonly-randconfig-003-20251204    clang-20
i386        buildonly-randconfig-003-20251205    gcc-14
i386        buildonly-randconfig-004-20251204    gcc-14
i386        buildonly-randconfig-004-20251205    gcc-14
i386        buildonly-randconfig-005-20251204    clang-20
i386        buildonly-randconfig-005-20251205    gcc-14
i386        buildonly-randconfig-006-20251204    clang-20
i386        buildonly-randconfig-006-20251205    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251205    clang-20
i386                  randconfig-002-20251205    gcc-14
i386                  randconfig-003-20251205    clang-20
i386                  randconfig-004-20251205    clang-20
i386                  randconfig-005-20251205    gcc-14
i386                  randconfig-006-20251205    clang-20
i386                  randconfig-007-20251205    gcc-14
i386                  randconfig-011-20251205    clang-20
i386                  randconfig-012-20251205    clang-20
i386                  randconfig-013-20251205    clang-20
i386                  randconfig-014-20251205    clang-20
i386                  randconfig-015-20251205    clang-20
i386                  randconfig-016-20251205    clang-20
i386                  randconfig-017-20251205    clang-20
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251205    clang-22
loongarch             randconfig-002-20251205    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                      mmu_defconfig    gcc-11.5.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            alldefconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251205    clang-22
nios2                 randconfig-002-20251205    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251205    clang-22
parisc                randconfig-001-20251205    gcc-8.5.0
parisc                randconfig-002-20251205    clang-22
parisc                randconfig-002-20251205    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    gcc-11.5.0
powerpc               randconfig-001-20251205    clang-18
powerpc               randconfig-001-20251205    clang-22
powerpc               randconfig-002-20251205    clang-18
powerpc               randconfig-002-20251205    clang-22
powerpc                    sam440ep_defconfig    gcc-11.5.0
powerpc64             randconfig-001-20251205    clang-22
powerpc64             randconfig-001-20251205    gcc-15.1.0
powerpc64             randconfig-002-20251205    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251205    gcc-13.4.0
riscv                 randconfig-002-20251205    gcc-13.4.0
riscv                 randconfig-002-20251205    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251205    gcc-11.5.0
s390                  randconfig-001-20251205    gcc-13.4.0
s390                  randconfig-002-20251205    clang-22
s390                  randconfig-002-20251205    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251205    gcc-13.4.0
sh                    randconfig-002-20251205    gcc-12.5.0
sh                    randconfig-002-20251205    gcc-13.4.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251205    gcc-14
sparc                 randconfig-002-20251205    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251205    gcc-14
sparc64               randconfig-002-20251205    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251205    gcc-14
um                    randconfig-002-20251205    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251204    clang-20
x86_64      buildonly-randconfig-002-20251204    clang-20
x86_64      buildonly-randconfig-003-20251204    gcc-14
x86_64      buildonly-randconfig-004-20251204    clang-20
x86_64      buildonly-randconfig-005-20251204    clang-20
x86_64      buildonly-randconfig-006-20251204    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251205    clang-20
x86_64                randconfig-002-20251205    clang-20
x86_64                randconfig-003-20251205    clang-20
x86_64                randconfig-004-20251205    clang-20
x86_64                randconfig-005-20251205    clang-20
x86_64                randconfig-006-20251205    clang-20
x86_64                randconfig-011-20251205    clang-20
x86_64                randconfig-012-20251205    clang-20
x86_64                randconfig-013-20251205    clang-20
x86_64                randconfig-014-20251205    clang-20
x86_64                randconfig-015-20251205    clang-20
x86_64                randconfig-016-20251205    clang-20
x86_64                randconfig-071-20251205    clang-20
x86_64                randconfig-072-20251205    gcc-12
x86_64                randconfig-073-20251205    gcc-14
x86_64                randconfig-074-20251205    gcc-14
x86_64                randconfig-075-20251205    gcc-12
x86_64                randconfig-076-20251205    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-11.5.0
xtensa                randconfig-001-20251205    gcc-14
xtensa                randconfig-002-20251205    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

