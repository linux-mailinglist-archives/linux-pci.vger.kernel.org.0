Return-Path: <linux-pci+bounces-44411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61856D0CAD0
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 02:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B86330053C2
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 01:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04CC2066DE;
	Sat, 10 Jan 2026 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9Gxp1kf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D817B50F
	for <linux-pci@vger.kernel.org>; Sat, 10 Jan 2026 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768007044; cv=none; b=tjplNCFzKVe3WgsDC53SuABR81a25w08lQRWfxX9/O5+KLLLNU4DtF9MXfW4ZrS2Gn0eBd+poAyxM263JUcYy0K9uLwZbdWypLbVx2R16ma9++h0Ppy/gMxKNODFIJ41XleGbp56RDxrgCR5SJ15Ri+vdmKnhJI58CcroaaTlbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768007044; c=relaxed/simple;
	bh=dn3aG37VNuW1K4N1Ogdk4S6zJlWuGbT3QTthIZAQLVw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ShQ+5OIkHwI3GmwltZGTu5DGBTNrQTINx7bDxaTrlgKaOZvU8N8xbOIJkDwMl8vbKi62Qlmrm1elogd/Gzwse8m7G+47CBpMBVi0F/kGDXqIOneBDPQX17RMWZ6ZyrOYDOXpxA3o2q3c9PpCPGSM1uIrNHg4whvhliLHP/jQV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9Gxp1kf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768007043; x=1799543043;
  h=date:from:to:cc:subject:message-id;
  bh=dn3aG37VNuW1K4N1Ogdk4S6zJlWuGbT3QTthIZAQLVw=;
  b=k9Gxp1kfgRyUyaPUEUoguwVvpJjfTw3nY+BZQ5yJLyO3vfHZZmWcXGmG
   BaSebdWfL+4qrVuK4MBsUpWjdUjuamDFEKfWLH40eMYKgm4ux9QKh+eiN
   Nq3bSCVIwdIRK+E5/vylfGYcKlzazrcaLvx4gjoYTiR0K/bLQQO5xPdvO
   Y4rEQ15HTEuVEXBtxq3VdSw4/b8kYMGXOsjUXb3puojB3BC1HRAtHijJG
   FG7uTeq0pZGosO7EboCzZ0KgjAuil6olCxOCrQq5XsfgpgxYWe92BTtmt
   69AG+3+oLN72eiW4Kw5A5P3JsafmFt716lucMF9ElywG76WCbe5QU5JcP
   Q==;
X-CSE-ConnectionGUID: +/SO3Z3cSCKVZ60F1f9oZQ==
X-CSE-MsgGUID: epSjsAXmSgebBcXxflHIQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="73244100"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="73244100"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 17:04:02 -0800
X-CSE-ConnectionGUID: 0DXgkI+hQg6DeP6Hq+BhQg==
X-CSE-MsgGUID: hPT4xxe4SAGDN7XNYtgDHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="203391749"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Jan 2026 17:04:02 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veNOZ-000000007uJ-0MQ9;
	Sat, 10 Jan 2026 01:03:59 +0000
Date: Sat, 10 Jan 2026 09:03:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 15a80caa4399d92b4c3ad6582b4c37aa312dc5de
Message-ID: <202601100944.PIGNUmKf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 15a80caa4399d92b4c3ad6582b4c37aa312dc5de  Merge branch 'pci/misc'

elapsed time: 1589m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260109    gcc-13.4.0
arc                   randconfig-002-20260109    gcc-13.4.0
arm                               allnoconfig    gcc-15.2.0
arm                       aspeed_g4_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260109    gcc-13.4.0
arm                   randconfig-002-20260109    gcc-13.4.0
arm                   randconfig-003-20260109    gcc-13.4.0
arm                   randconfig-004-20260109    gcc-13.4.0
arm                           spitz_defconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260109    gcc-8.5.0
arm64                 randconfig-002-20260109    gcc-8.5.0
arm64                 randconfig-003-20260109    gcc-8.5.0
arm64                 randconfig-004-20260109    gcc-8.5.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260109    gcc-8.5.0
csky                  randconfig-002-20260109    gcc-8.5.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260109    gcc-8.5.0
hexagon               randconfig-002-20260109    gcc-8.5.0
i386                              allnoconfig    gcc-15.2.0
i386        buildonly-randconfig-001-20260109    clang-20
i386        buildonly-randconfig-002-20260109    clang-20
i386        buildonly-randconfig-003-20260109    clang-20
i386        buildonly-randconfig-004-20260109    clang-20
i386        buildonly-randconfig-005-20260109    clang-20
i386        buildonly-randconfig-006-20260109    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260109    gcc-14
i386                  randconfig-002-20260109    gcc-14
i386                  randconfig-003-20260109    gcc-14
i386                  randconfig-004-20260109    gcc-14
i386                  randconfig-005-20260109    gcc-14
i386                  randconfig-006-20260109    gcc-14
i386                  randconfig-007-20260109    gcc-14
i386                  randconfig-011-20260109    clang-20
i386                  randconfig-012-20260109    clang-20
i386                  randconfig-013-20260109    clang-20
i386                  randconfig-014-20260109    clang-20
i386                  randconfig-015-20260109    clang-20
i386                  randconfig-016-20260109    clang-20
i386                  randconfig-017-20260109    clang-20
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260109    gcc-8.5.0
loongarch             randconfig-002-20260109    gcc-8.5.0
m68k                              allnoconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                           sun3_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                              allnoconfig    gcc-15.2.0
mips                     decstation_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260109    gcc-8.5.0
nios2                 randconfig-002-20260109    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260109    gcc-8.5.0
parisc                randconfig-002-20260109    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20260109    gcc-8.5.0
powerpc               randconfig-002-20260109    gcc-8.5.0
powerpc                      tqm8xx_defconfig    clang-22
powerpc64             randconfig-001-20260109    gcc-8.5.0
powerpc64             randconfig-002-20260109    gcc-8.5.0
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260109    clang-22
riscv                 randconfig-002-20260109    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260109    clang-22
s390                  randconfig-002-20260109    clang-22
s390                       zfcpdump_defconfig    clang-22
sh                                allnoconfig    clang-22
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    clang-22
sh                    randconfig-001-20260109    clang-22
sh                    randconfig-002-20260109    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260109    gcc-14.3.0
sparc                 randconfig-002-20260109    gcc-14.3.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260109    gcc-14.3.0
sparc64               randconfig-002-20260109    gcc-14.3.0
um                                allnoconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260109    gcc-14.3.0
um                    randconfig-002-20260109    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20260109    gcc-14
x86_64      buildonly-randconfig-002-20260109    gcc-14
x86_64      buildonly-randconfig-003-20260109    gcc-14
x86_64      buildonly-randconfig-004-20260109    gcc-14
x86_64      buildonly-randconfig-005-20260109    gcc-14
x86_64      buildonly-randconfig-006-20260109    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260109    gcc-14
x86_64                randconfig-002-20260109    gcc-14
x86_64                randconfig-003-20260109    gcc-14
x86_64                randconfig-004-20260109    gcc-14
x86_64                randconfig-005-20260109    gcc-14
x86_64                randconfig-006-20260109    gcc-14
x86_64                randconfig-011-20260109    gcc-14
x86_64                randconfig-012-20260109    gcc-14
x86_64                randconfig-013-20260109    gcc-14
x86_64                randconfig-014-20260109    gcc-14
x86_64                randconfig-015-20260109    gcc-14
x86_64                randconfig-016-20260109    gcc-14
x86_64                randconfig-071-20260109    clang-20
x86_64                randconfig-072-20260109    clang-20
x86_64                randconfig-073-20260109    clang-20
x86_64                randconfig-074-20260109    clang-20
x86_64                randconfig-075-20260109    clang-20
x86_64                randconfig-076-20260109    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
xtensa                            allnoconfig    clang-22
xtensa                randconfig-001-20260109    gcc-14.3.0
xtensa                randconfig-002-20260109    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

