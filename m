Return-Path: <linux-pci+bounces-9612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91BA924C0A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 01:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA9D1C22649
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C531DA322;
	Tue,  2 Jul 2024 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJRkYUk7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B85A1DA310
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2024 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962172; cv=none; b=Q+ya6B9+Bjj0xLBz4OL8fqCbEzz721AOqPhM3wLmZCeKw1+bhfIi576O/Eb/2VM4NJFYYQRgJavppJdUnVgE1zlqjYojdhFW7rc+Ziw2MwIx9eCif5ibuV40JDmzC9zwn4abNXbrCCCfDB01WfLUkkf5deqADe0nVjbQN2GIFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962172; c=relaxed/simple;
	bh=E9dVqfmelmg8+TvuCmt6oBoBYZJ4HDM4cETEBDq7evs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CvMSPH9MGJghY2ae743BHYvjPutmAr6lK9LOZavZZ9BDt9NMy9Ve6nv69mSIhi3ByiCuVEwnxLR74jsuhgi71o7CBwx/2weUQ0Vm1RALuy3igdrdzSqoGrGzVByUqbmXiJ8JFC8FXtw0yuY/2NL2at9JQ8wvAjzlUGF+4sPI30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJRkYUk7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719962169; x=1751498169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E9dVqfmelmg8+TvuCmt6oBoBYZJ4HDM4cETEBDq7evs=;
  b=OJRkYUk7/GISqkd7t5tRzFybNgn8+SbrFWWqLkSzHUI1hO2EkGnB/7ap
   dveuuLb9+0rFjChmcOV9GQg66qB63Pd8ZqtNxrEmK3HZyZOT0RX1wZqMb
   L130e3lbxDw2JJtScQY3LvoXdD2Is4grycgc/bWE2rEyfBbDdG9bnRAvA
   OY+8wlxx6EE/Xw5wDJ2D+2ehmxOMkRapaSQuwlQuh5TQeRbdKsTjCv8Bf
   hOcR9zehfeADgOTIQFEPqAWRdFXChSr/rHnvr7jRd8Yyy4myWmgL1mk5Y
   1QpmHsi2ic/dbv7vFGWoVi23yxvo/uQhALJLgZFFFz5zpHVSM0zfJqYwX
   Q==;
X-CSE-ConnectionGUID: C9+SB2smStOYxHdLaGaBWA==
X-CSE-MsgGUID: lAXamxj5Q3uaEiDxIYDrVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16824524"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="16824524"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 16:16:08 -0700
X-CSE-ConnectionGUID: JZZ6WiYySa6oLGOf0ZrguQ==
X-CSE-MsgGUID: zpvT5KolR7KzruHZla51qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="45970023"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2024 16:16:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOmjE-000OsI-2N;
	Tue, 02 Jul 2024 23:16:04 +0000
Date: Wed, 03 Jul 2024 07:15:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rcar-gen4] BUILD SUCCESS
 faf5a975ee3b94aac7c8a8054456a85d99a1b7ad
Message-ID: <202407030749.FE41MwBE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rcar-gen4
branch HEAD: faf5a975ee3b94aac7c8a8054456a85d99a1b7ad  PCI: rcar-gen4: Add support for R-Car V4H

elapsed time: 1468m

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

