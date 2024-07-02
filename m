Return-Path: <linux-pci+bounces-9611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC7924BE8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 00:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2064B1F236CA
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 22:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9B55C08;
	Tue,  2 Jul 2024 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6M6Uvb8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D471DA301
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2024 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961015; cv=none; b=LpnzeHP/k85ZAljGJFeByOMIQmG/xAY2XNl4+r6i8xq9kKXRJ+zHqqCrnO+/P/f5pgnfLSwcCIKqrxebovJfOpnlm1CfHOGz+c8VDx1+YBW2ai9sxVUKT8JWncIN+k5xLyyjSipI+k1FEClROvMLwioFx/0GFuEfP5P0GsCw52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961015; c=relaxed/simple;
	bh=3JQZvQcPhOEZ8dcmWozl3jVtlyLicQyYTF5+PkwSG8g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eL8WMqbmQzbsMQSnxgVD+t4iN3CMeRi+a4JV1tEVujjdC++L91aYbl9yIZnjkr+caoJd9GXJXHCpvGgzmg31dO11bW08XpqXYeMgPNc0iwQm92g8vj9QijrcCP8MC26nkDAeFaYOt4HtrkN3EGwVO1YSRervZ9bD/HopVeCB9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6M6Uvb8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719961014; x=1751497014;
  h=date:from:to:cc:subject:message-id;
  bh=3JQZvQcPhOEZ8dcmWozl3jVtlyLicQyYTF5+PkwSG8g=;
  b=m6M6Uvb8rztAMQT3TU7P1wfW5QLIWBBOvaCq9X1lJVwBrA8A3loiaojl
   kW5FjsufEpCgccxUrwpEAX8x5uAUF9YysF2Wb8OLrg0PlDrqZiRJxZsIq
   N/cqsarUh5hMTfy+N/ZecS2ZZuYPd1ZwWDeRVHtOnEy63qOq4puKV6Bf4
   hVLU3J8Nt4d/o/Mh2w94qq8Rlb3yZ8b0EFZSOxh+ZpqRaMc07w8Vq5i35
   DfxuXxPo9plsseosiTdA+zau5f3DGe4/jwMtOSVVEWwXr0UiG6suwObs9
   STdvhUR2FaRLu8bE8KXJoEaCdJs9bkGmup/JMyGbFTjVcw7yrPJsm1kPE
   g==;
X-CSE-ConnectionGUID: k6dk/DMfSHmc8C6dZuwIuQ==
X-CSE-MsgGUID: qWsH3gA+QriD5AlJogN81w==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28296265"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="28296265"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:56:53 -0700
X-CSE-ConnectionGUID: gaJib2PlTuuDW0hk0RCfJQ==
X-CSE-MsgGUID: C5PjfHZ1QJy0aHqfzn9sKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="77201318"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Jul 2024 15:56:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOmQb-000Oqc-19;
	Tue, 02 Jul 2024 22:56:49 +0000
Date: Wed, 03 Jul 2024 06:56:18 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 4f491ea63b5af3715703401737ee8903f9e43d6a
Message-ID: <202407030616.bwro7bk3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: 4f491ea63b5af3715703401737ee8903f9e43d6a  drm/vboxvideo: fix mapping leaks

elapsed time: 1736m

configs tested: 104
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                          collie_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                          gemini_defconfig   gcc-13.2.0
arm                           imxrt_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                        spear3xx_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240702   gcc-13
i386         buildonly-randconfig-001-20240703   clang-18
i386         buildonly-randconfig-002-20240702   gcc-13
i386         buildonly-randconfig-002-20240703   clang-18
i386         buildonly-randconfig-003-20240702   gcc-13
i386         buildonly-randconfig-003-20240703   clang-18
i386         buildonly-randconfig-004-20240702   gcc-13
i386         buildonly-randconfig-004-20240703   clang-18
i386         buildonly-randconfig-005-20240702   gcc-13
i386         buildonly-randconfig-005-20240703   clang-18
i386         buildonly-randconfig-006-20240702   gcc-13
i386         buildonly-randconfig-006-20240703   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240702   gcc-13
i386                  randconfig-001-20240703   clang-18
i386                  randconfig-002-20240702   gcc-13
i386                  randconfig-002-20240703   clang-18
i386                  randconfig-003-20240702   gcc-13
i386                  randconfig-003-20240703   clang-18
i386                  randconfig-004-20240702   gcc-13
i386                  randconfig-004-20240703   clang-18
i386                  randconfig-005-20240702   gcc-13
i386                  randconfig-005-20240703   clang-18
i386                  randconfig-006-20240702   gcc-13
i386                  randconfig-006-20240703   clang-18
i386                  randconfig-011-20240702   gcc-13
i386                  randconfig-011-20240703   clang-18
i386                  randconfig-012-20240702   gcc-13
i386                  randconfig-012-20240703   clang-18
i386                  randconfig-013-20240702   gcc-13
i386                  randconfig-013-20240703   clang-18
i386                  randconfig-014-20240702   gcc-13
i386                  randconfig-014-20240703   clang-18
i386                  randconfig-015-20240702   gcc-13
i386                  randconfig-015-20240703   clang-18
i386                  randconfig-016-20240702   gcc-13
i386                  randconfig-016-20240703   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                   motionpro_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                              ul2_defconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                           alldefconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

