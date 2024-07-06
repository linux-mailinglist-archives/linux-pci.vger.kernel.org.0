Return-Path: <linux-pci+bounces-9885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0F9929538
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 22:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E131C20AB8
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC9F1C6A1;
	Sat,  6 Jul 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YL1LpGrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05B1367
	for <linux-pci@vger.kernel.org>; Sat,  6 Jul 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720298114; cv=none; b=ZW6ZsOqGw7ZMHY3P1V73JjCQzBbNAaCGrGjqzRJZ7lLQj7Hx6VqQoKKu7/xy/gaYK+k43cGj/cCzdIYldit3PP8oDjSKIIXTdFw3p0+8b5iY/QOCEHJpL+HIu+2Q5Yhk04YB/gW13mIvQdFCFSBD3WHTtt+yeJGN90ztXuTcXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720298114; c=relaxed/simple;
	bh=60G1X+e/vF0i8Gg+x7IhvW0+SD7R+wOF0dmgH2vlf10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VW3Fiq1B/4lDHK2niRKc4kA75x3kAmYCyXjMsb3v7GfwvFn3kVeDywxGUrMVmM8w+eBONPeQPglb5pLXzQQeIiR/S6wCsbeJlXGYKY7fw8T/1Jb8Og8p014GER4BtqUYwRJKhFm+XwuW2/AS895faoKxkn/sXtUL1BpmyW9htUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YL1LpGrA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720298113; x=1751834113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=60G1X+e/vF0i8Gg+x7IhvW0+SD7R+wOF0dmgH2vlf10=;
  b=YL1LpGrAlsa4/nt6U9+UGH4fT8oZXCbGcwG5X8owF1dClyZlQyU+TfJW
   EYfkdsp09rRK6PSvfKaHTyW0V4c0SFiID3YBkXwsOxHQtQ2mo40Ksg8Ok
   XML55IPhwTNSbKBIMWFonOy7ltmB5NjTrdTemkdyIQqqk+LntYMdCvZcX
   2azB1L3jr07/+Q+caG8da7LY9t9UY/NtbZS+kRkVSWTxO1TXRpCc52ycM
   84cgcZ/6X6uUaXHH5DmFy66tHOeCjUMYHawzfqQly5ka+E4U6ESqPh6bY
   j9Or5V7d8zHGp7COWTNeBEI/DYTMHDIc3XGYKtDPN3hbFMNDa99p1mEoK
   w==;
X-CSE-ConnectionGUID: BvcbQd1lTK2AOW6FSL+fdw==
X-CSE-MsgGUID: UkBcEbqpRaW6N2nEc3sCNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="20447775"
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="20447775"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 13:35:12 -0700
X-CSE-ConnectionGUID: whDDg4XYSQSxR19tuzMgkg==
X-CSE-MsgGUID: fyuo6wG+R7O7O1RhMzc1JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="52086275"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Jul 2024 13:35:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQC7g-000UEi-2F;
	Sat, 06 Jul 2024 20:35:08 +0000
Date: Sun, 07 Jul 2024 04:34:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 412d6f897b7a494b373986e63a14a94d0fbd0fdb
Message-ID: <202407070438.o2XNuR1G-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 412d6f897b7a494b373986e63a14a94d0fbd0fdb  Merge branch 'controller/tegra194' into next

elapsed time: 964m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240706   gcc-13.2.0
arc                   randconfig-002-20240706   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                          ep93xx_defconfig   clang-14
arm                         lpc32xx_defconfig   clang-19
arm                        multi_v5_defconfig   gcc-13.2.0
arm                   randconfig-001-20240706   gcc-13.2.0
arm                   randconfig-002-20240706   gcc-13.2.0
arm                   randconfig-003-20240706   gcc-13.2.0
arm                   randconfig-004-20240706   gcc-13.2.0
arm                        spear3xx_defconfig   clang-16
arm                           tegra_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240706   gcc-13.2.0
arm64                 randconfig-002-20240706   gcc-13.2.0
arm64                 randconfig-003-20240706   clang-16
arm64                 randconfig-004-20240706   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240706   gcc-13.2.0
csky                  randconfig-002-20240706   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240706   clang-19
hexagon               randconfig-002-20240706   clang-15
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240706   clang-18
i386         buildonly-randconfig-002-20240706   gcc-13
i386         buildonly-randconfig-003-20240706   clang-18
i386         buildonly-randconfig-004-20240706   gcc-13
i386         buildonly-randconfig-005-20240706   gcc-10
i386         buildonly-randconfig-006-20240706   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240706   gcc-13
i386                  randconfig-002-20240706   clang-18
i386                  randconfig-003-20240706   gcc-13
i386                  randconfig-004-20240706   clang-18
i386                  randconfig-005-20240706   clang-18
i386                  randconfig-006-20240706   gcc-12
i386                  randconfig-011-20240706   gcc-11
i386                  randconfig-012-20240706   clang-18
i386                  randconfig-013-20240706   clang-18
i386                  randconfig-014-20240706   clang-18
i386                  randconfig-015-20240706   gcc-7
i386                  randconfig-016-20240706   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240706   gcc-13.2.0
loongarch             randconfig-002-20240706   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          rb532_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240706   gcc-13.2.0
nios2                 randconfig-002-20240706   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240706   gcc-13.2.0
parisc                randconfig-002-20240706   gcc-13.2.0
powerpc                     akebono_defconfig   clang-19
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                 canyonlands_defconfig   clang-19
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   clang-19
powerpc               randconfig-001-20240706   gcc-13.2.0
powerpc               randconfig-002-20240706   gcc-13.2.0
powerpc                         wii_defconfig   gcc-13.2.0
riscv                            alldefconfig   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv             nommu_k210_sdcard_defconfig   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                         apsh4a3a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240706   clang-18
x86_64       buildonly-randconfig-002-20240706   clang-18
x86_64       buildonly-randconfig-003-20240706   clang-18
x86_64       buildonly-randconfig-004-20240706   clang-18
x86_64       buildonly-randconfig-005-20240706   gcc-13
x86_64       buildonly-randconfig-006-20240706   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240706   gcc-9
x86_64                randconfig-002-20240706   clang-18
x86_64                randconfig-003-20240706   clang-18
x86_64                randconfig-004-20240706   clang-18
x86_64                randconfig-005-20240706   clang-18
x86_64                randconfig-006-20240706   clang-18
x86_64                randconfig-011-20240706   gcc-12
x86_64                randconfig-012-20240706   gcc-12
x86_64                randconfig-013-20240706   clang-18
x86_64                randconfig-014-20240706   gcc-13
x86_64                randconfig-015-20240706   gcc-13
x86_64                randconfig-016-20240706   gcc-13
x86_64                randconfig-071-20240706   gcc-12
x86_64                randconfig-072-20240706   gcc-13
x86_64                randconfig-073-20240706   gcc-12
x86_64                randconfig-074-20240706   gcc-13
x86_64                randconfig-075-20240706   clang-18
x86_64                randconfig-076-20240706   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

