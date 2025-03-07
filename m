Return-Path: <linux-pci+bounces-23107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67171A566CC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8587A7367
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9F61A9B4C;
	Fri,  7 Mar 2025 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMuDcSBs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803A149C50
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347184; cv=none; b=NFvogrS6X17Rc5Acp/9PKQ1Py5RX3TilHrqpwfZ/vfvzRWEcOBCmvDbc88Kbx8yHmEgxdQCJJkK86+x8ojrbgqOduf8hajVnv91wcqmU0x91DXLfkNUGKuaFs7jVSzqEUXeKfc2Zet8qVAemyaUX0gd6SaYCaar9ruUscjlbPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347184; c=relaxed/simple;
	bh=a9raBJTjJh72L5QdJoL80KQ6fkoEN4GZK1q6m7KeJmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cIDaJFH/i19Odn8SGZ9Zan1MQUnM1wtOrl6kqLfR2jKnOVMWWH77VHhEPWRjikPk25cBkoFja2Fo0KK99g+wqKdcfkgn3fGz1pvmuY5XXVYT0lNc8FiigwzDtKRLe+FyAsd+KATdwhffDF/n3N5iEaASRa0XECYAQDI8Ke704v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMuDcSBs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741347182; x=1772883182;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a9raBJTjJh72L5QdJoL80KQ6fkoEN4GZK1q6m7KeJmo=;
  b=jMuDcSBsymrI0e37aJvMHI7vgeomWU7/TPcs4jWSnQbht4vw7ltqW55U
   r+epU8mWfV3U76uyKUGkDXnC5wXCtjPniKQHhWAW8Ax32i9A9gZ0cRtFj
   zufNl5JJ0EXkwl/AAbq7TXG93J5IqWpNuncHGCxjmZXWsaUNlWLxw14lb
   209y5i2DEvdTRTBeM5Zolss+U3qLUpIWlniPciCEYtckPUxcF+M5ArHlv
   uRmyxgNfOX92We1gF2ilXCDi6uwOeOE+QLsfRfaKmHx3RNvtVPazgKj6x
   QTJxcTmXh5AQTX1guM0TM9yf/8bAMD0t4a7RSaQ98Zzu1ARo8MWDiDHuN
   w==;
X-CSE-ConnectionGUID: QleRwbwvQ06sFV7k/yp3Qw==
X-CSE-MsgGUID: fZMcGmYIQbSXa1iBmXxaiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52599806"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="52599806"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:33:02 -0800
X-CSE-ConnectionGUID: vuRBnFyhQNO6PlbLu2/2Gw==
X-CSE-MsgGUID: VBY90x2PToiItn/HaJdPTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="123892675"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 07 Mar 2025 03:33:00 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqVwn-0000Np-2P;
	Fri, 07 Mar 2025 11:32:57 +0000
Date: Fri, 07 Mar 2025 19:32:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/altera] BUILD SUCCESS
 60f2ee5f1472972918de7eb14c8240de176f6b8d
Message-ID: <202503071939.FXXhChxT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/altera
branch HEAD: 60f2ee5f1472972918de7eb14c8240de176f6b8d  PCI: altera: Add Agilex support

elapsed time: 1465m

configs tested: 173
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                   randconfig-001-20250306    gcc-13.2.0
arc                   randconfig-001-20250307    clang-15
arc                   randconfig-002-20250306    gcc-13.2.0
arc                   randconfig-002-20250307    clang-15
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                          exynos_defconfig    gcc-14.2.0
arm                             mxs_defconfig    clang-21
arm                   randconfig-001-20250306    gcc-14.2.0
arm                   randconfig-001-20250307    clang-15
arm                   randconfig-002-20250306    gcc-14.2.0
arm                   randconfig-002-20250307    clang-15
arm                   randconfig-003-20250306    gcc-14.2.0
arm                   randconfig-003-20250307    clang-15
arm                   randconfig-004-20250306    clang-18
arm                   randconfig-004-20250307    clang-15
arm                         wpcm450_defconfig    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250306    gcc-14.2.0
arm64                 randconfig-001-20250307    clang-15
arm64                 randconfig-002-20250306    gcc-14.2.0
arm64                 randconfig-002-20250307    clang-15
arm64                 randconfig-003-20250306    gcc-14.2.0
arm64                 randconfig-003-20250307    clang-15
arm64                 randconfig-004-20250306    gcc-14.2.0
arm64                 randconfig-004-20250307    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250307    gcc-14.2.0
csky                  randconfig-002-20250307    gcc-14.2.0
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250307    clang-21
hexagon               randconfig-002-20250307    clang-21
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250306    clang-19
i386        buildonly-randconfig-001-20250307    clang-19
i386        buildonly-randconfig-002-20250306    clang-19
i386        buildonly-randconfig-002-20250307    clang-19
i386        buildonly-randconfig-003-20250306    clang-19
i386        buildonly-randconfig-003-20250307    clang-19
i386        buildonly-randconfig-004-20250306    gcc-12
i386        buildonly-randconfig-004-20250307    clang-19
i386        buildonly-randconfig-005-20250306    gcc-12
i386        buildonly-randconfig-005-20250307    clang-19
i386        buildonly-randconfig-006-20250306    clang-19
i386        buildonly-randconfig-006-20250307    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250307    clang-19
i386                  randconfig-002-20250307    clang-19
i386                  randconfig-003-20250307    clang-19
i386                  randconfig-004-20250307    clang-19
i386                  randconfig-005-20250307    clang-19
i386                  randconfig-006-20250307    clang-19
i386                  randconfig-007-20250307    clang-19
i386                  randconfig-011-20250307    gcc-11
i386                  randconfig-012-20250307    gcc-11
i386                  randconfig-013-20250307    gcc-11
i386                  randconfig-014-20250307    gcc-11
i386                  randconfig-015-20250307    gcc-11
i386                  randconfig-016-20250307    gcc-11
i386                  randconfig-017-20250307    gcc-11
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250307    gcc-14.2.0
loongarch             randconfig-002-20250307    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip32_defconfig    gcc-14.2.0
mips                         rt305x_defconfig    clang-21
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250307    gcc-14.2.0
nios2                 randconfig-002-20250307    gcc-14.2.0
openrisc                          allnoconfig    clang-15
parisc                            allnoconfig    clang-15
parisc                randconfig-001-20250307    gcc-14.2.0
parisc                randconfig-002-20250307    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250307    gcc-14.2.0
powerpc               randconfig-002-20250307    clang-21
powerpc               randconfig-003-20250307    clang-19
powerpc64             randconfig-001-20250307    clang-21
powerpc64             randconfig-002-20250307    gcc-14.2.0
powerpc64             randconfig-003-20250307    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv             nommu_k210_sdcard_defconfig    clang-21
riscv                 randconfig-001-20250306    clang-18
riscv                 randconfig-001-20250307    gcc-14.2.0
riscv                 randconfig-002-20250306    gcc-14.2.0
riscv                 randconfig-002-20250307    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250306    gcc-14.2.0
s390                  randconfig-001-20250307    gcc-14.2.0
s390                  randconfig-002-20250306    clang-19
s390                  randconfig-002-20250307    gcc-14.2.0
sh                               alldefconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250306    gcc-14.2.0
sh                    randconfig-001-20250307    gcc-14.2.0
sh                    randconfig-002-20250306    gcc-14.2.0
sh                    randconfig-002-20250307    gcc-14.2.0
sh                   secureedge5410_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250306    gcc-14.2.0
sparc                 randconfig-001-20250307    gcc-14.2.0
sparc                 randconfig-002-20250306    gcc-14.2.0
sparc                 randconfig-002-20250307    gcc-14.2.0
sparc64               randconfig-001-20250306    gcc-14.2.0
sparc64               randconfig-001-20250307    gcc-14.2.0
sparc64               randconfig-002-20250306    gcc-14.2.0
sparc64               randconfig-002-20250307    gcc-14.2.0
um                                allnoconfig    clang-15
um                    randconfig-001-20250306    gcc-12
um                    randconfig-001-20250307    gcc-14.2.0
um                    randconfig-002-20250306    clang-16
um                    randconfig-002-20250307    gcc-14.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250306    gcc-11
x86_64      buildonly-randconfig-001-20250307    clang-19
x86_64      buildonly-randconfig-002-20250306    clang-19
x86_64      buildonly-randconfig-002-20250307    clang-19
x86_64      buildonly-randconfig-003-20250306    clang-19
x86_64      buildonly-randconfig-003-20250307    clang-19
x86_64      buildonly-randconfig-004-20250306    clang-19
x86_64      buildonly-randconfig-004-20250307    clang-19
x86_64      buildonly-randconfig-005-20250306    clang-19
x86_64      buildonly-randconfig-005-20250307    clang-19
x86_64      buildonly-randconfig-006-20250306    gcc-12
x86_64      buildonly-randconfig-006-20250307    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250307    clang-19
x86_64                randconfig-002-20250307    clang-19
x86_64                randconfig-003-20250307    clang-19
x86_64                randconfig-004-20250307    clang-19
x86_64                randconfig-005-20250307    clang-19
x86_64                randconfig-006-20250307    clang-19
x86_64                randconfig-007-20250307    clang-19
x86_64                randconfig-008-20250307    clang-19
x86_64                randconfig-071-20250307    clang-19
x86_64                randconfig-072-20250307    clang-19
x86_64                randconfig-073-20250307    clang-19
x86_64                randconfig-074-20250307    clang-19
x86_64                randconfig-075-20250307    clang-19
x86_64                randconfig-076-20250307    clang-19
x86_64                randconfig-077-20250307    clang-19
x86_64                randconfig-078-20250307    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250306    gcc-14.2.0
xtensa                randconfig-001-20250307    gcc-14.2.0
xtensa                randconfig-002-20250306    gcc-14.2.0
xtensa                randconfig-002-20250307    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

