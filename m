Return-Path: <linux-pci+bounces-28070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D906ABD142
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6921BA185F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E764255F59;
	Tue, 20 May 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uy0Lmr4S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35902147EA
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747728011; cv=none; b=jwx4jrIq33YCiyFEXYX3Neoz1jRM+2tJE1oWtNqsCiGcycVPFlF13L4Ix7P+Ri9D/Cho3dh+tmUGxq0jSZAQ58BUKm33bqeQWSRM7KdS3KuJ+w2qHilUYkzcRg+6aycGuDfqVtLPF2Bf/G8nFcmUW9uIvYpfXOSneJOVjU4p3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747728011; c=relaxed/simple;
	bh=RrmyY2jqL3aSI/n+xc5DLEakgKA28LiL+ilpDtVjBeU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RA9wXQcER1AZm4wchAJKzrARn2vSsZQzA3y/rP1O+53CMMw+uVDpcWjRrZ0y5VZoM5mRCxF80i8F+9vg+wWXL9XUoH3tP9yh4btq6FXq6DczC2EQuh4QoKiFV4gI5YwxFMH5Nr4nc3Gx+4IR3EKAyC1EpC4GJkX4DG3Ez5EZtb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uy0Lmr4S; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747728009; x=1779264009;
  h=date:from:to:cc:subject:message-id;
  bh=RrmyY2jqL3aSI/n+xc5DLEakgKA28LiL+ilpDtVjBeU=;
  b=Uy0Lmr4SEQWlfdZYDc2e2P+UQJ5CP+3bDdlmUMr96wI7QI6CAStwU/n6
   XI7ZzXkfSxQWw3OO635uBheNS2rZ3f+71L+8VqkKh9OxmwKSfdc0fwRFc
   w6uOJKddX4KZkJjdMZgUfrZFwnoM9BDrdQcJNmBq912U7nmxZrv7P/Rxs
   ogoAqxealmwL58I5QJhvZUH/VDzaMdvFRTQQLz4tb8NhDMW1tXotj8oRB
   a7cPx7f1rGXe0Gzcd6sWyxuhBBOtoNiFQCABLlZlEHr5HQHTYj0Ml4uVv
   +9paIoykSAN38IGbozhZWE2jtKNotBFFzLzYmpsiLK+W/vBTXd/zqW/Aq
   w==;
X-CSE-ConnectionGUID: EHNTuA7UQjCMZX73ftBv5A==
X-CSE-MsgGUID: q6P3tfNARyGlmfSp6QaTaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49631752"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49631752"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 01:00:07 -0700
X-CSE-ConnectionGUID: lFGIvMT5T6uW1khacqOkkQ==
X-CSE-MsgGUID: 7S7oKUNyRNapTk9pbT2R8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140520582"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 May 2025 01:00:07 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHHtM-000MJO-1V;
	Tue, 20 May 2025 08:00:04 +0000
Date: Tue, 20 May 2025 15:59:53 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/dw-rockchip] BUILD SUCCESS
 be0b42befa87d81780aa0f003644b0ad520b0234
Message-ID: <202505201544.sLy4a2CN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dw-rockchip
branch HEAD: be0b42befa87d81780aa0f003644b0ad520b0234  PCI: qcom: Replace PERST sleep time with proper macro

elapsed time: 911m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250520    gcc-11.5.0
arc                   randconfig-002-20250520    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-18
arm                   milbeaut_m10v_defconfig    clang-19
arm                   randconfig-001-20250520    gcc-6.5.0
arm                   randconfig-002-20250520    gcc-10.5.0
arm                   randconfig-003-20250520    clang-19
arm                   randconfig-004-20250520    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250520    clang-21
arm64                 randconfig-002-20250520    gcc-9.5.0
arm64                 randconfig-003-20250520    clang-18
arm64                 randconfig-004-20250520    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250520    gcc-14.2.0
csky                  randconfig-002-20250520    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250520    clang-21
hexagon               randconfig-002-20250520    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250520    gcc-12
i386        buildonly-randconfig-002-20250520    gcc-12
i386        buildonly-randconfig-003-20250520    clang-20
i386        buildonly-randconfig-004-20250520    gcc-12
i386        buildonly-randconfig-005-20250520    clang-20
i386        buildonly-randconfig-006-20250520    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250520    gcc-14.2.0
loongarch             randconfig-002-20250520    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250520    gcc-9.3.0
nios2                 randconfig-002-20250520    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250520    gcc-10.5.0
parisc                randconfig-002-20250520    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    clang-19
powerpc                      katmai_defconfig    clang-21
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                      pcm030_defconfig    clang-21
powerpc               randconfig-001-20250520    gcc-5.5.0
powerpc               randconfig-002-20250520    clang-17
powerpc               randconfig-003-20250520    gcc-7.5.0
powerpc64             randconfig-001-20250520    clang-21
powerpc64             randconfig-002-20250520    gcc-7.5.0
powerpc64             randconfig-003-20250520    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250520    gcc-9.3.0
riscv                 randconfig-002-20250520    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250520    clang-21
s390                  randconfig-002-20250520    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250520    gcc-9.3.0
sh                    randconfig-002-20250520    gcc-9.3.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250520    gcc-8.5.0
sparc                 randconfig-002-20250520    gcc-12.4.0
sparc64               randconfig-001-20250520    gcc-8.5.0
sparc64               randconfig-002-20250520    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250520    clang-21
um                    randconfig-002-20250520    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250520    gcc-12
x86_64      buildonly-randconfig-002-20250520    gcc-12
x86_64      buildonly-randconfig-003-20250520    gcc-12
x86_64      buildonly-randconfig-004-20250520    gcc-12
x86_64      buildonly-randconfig-005-20250520    gcc-12
x86_64      buildonly-randconfig-006-20250520    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250520    gcc-6.5.0
xtensa                randconfig-002-20250520    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

