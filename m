Return-Path: <linux-pci+bounces-9104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A391305D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 00:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B411F212DF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756B16E872;
	Fri, 21 Jun 2024 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hF+dnW+V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDDC208C4
	for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009327; cv=none; b=jMaqVeXmItx4JlbSJhvlcSPdOZ+EhcPFWvGLmR+Ao+4xTYQi1uRS/8Cosw3GZ4nPZ/ttQcNCyhCyscYACa+9v/W4RRVzld7a6R5n6x8XtjhSofrQaGDx25wnJh+bXD5ui5uL3hFKHLojrt+Qzl9EZDUOt68H3wdvnLr/CzdZELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009327; c=relaxed/simple;
	bh=29Zy9X+q/XEvhAAm9xVW+vmvC/AxjumMY08hA2NeFCM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jHEojNgibAbzTyx/Fwx5pt/ECsp1rd+0h3sPO674fYbcBq9FtMj88+A7g2ZDtOqcVfWfJcaHjOYxtXJM5zyGM0DQzPKyJmkOvxyQ9KRlKeezO9zDFdRY/rAJGlR6ylLtcnsFowCBklIJWtEsn/1M65THREhoy9lOW6eALeUij9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hF+dnW+V; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719009326; x=1750545326;
  h=date:from:to:cc:subject:message-id;
  bh=29Zy9X+q/XEvhAAm9xVW+vmvC/AxjumMY08hA2NeFCM=;
  b=hF+dnW+VmqVm3twmr1BVb5rpGeSri/6w+ByFBCGNyYWhI1P/ZtDkl2RN
   mASQ2/JonpnqeJOssj3g5WpCUsN4FtpUHIC1gtkRwLnq2oRDozb5u4j8Y
   ShMHorwioG6lkxgU6N48iH4yaIrf6tSQM46lfVe0pPYYZmJHGY/87BgDY
   XUj29ihgdAajx62CDrnp1vf+x45UogEPrjWQdB0YbefVnhSy7MqtLnlW0
   QczpssDJRAzsrvxdx+JxcRieRz1D/KutbhDT/ZY1mHINMc/EdssrES97m
   AkQMKz0zLhwNpFIXM/bnHlDd6OiE4r0iebK4giYD1tTQ/9UP1lybVkz3Z
   w==;
X-CSE-ConnectionGUID: XKeyvMNqQjWupVQR6JEV0A==
X-CSE-MsgGUID: HhmOlOEjTLuSnaeSxCbP7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="26748090"
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="26748090"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 15:35:26 -0700
X-CSE-ConnectionGUID: ffQ38agAT6ioFLEZCYQxTQ==
X-CSE-MsgGUID: uHqh6uGbSRiTufeibWT7ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="47175776"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 21 Jun 2024 15:35:25 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKmqo-00094z-1E;
	Fri, 21 Jun 2024 22:35:22 +0000
Date: Sat, 22 Jun 2024 06:35:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 f117d19a8dc6e765092d674d36c5cbc2cc00102c
Message-ID: <202406220601.y4x3IJGw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: f117d19a8dc6e765092d674d36c5cbc2cc00102c  Merge branch 'pci/misc'

elapsed time: 3096m

configs tested: 117
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig   gcc-13.2.0
arc                   randconfig-001-20240620   gcc-13.2.0
arc                   randconfig-002-20240620   gcc-13.2.0
arm                      footbridge_defconfig   clang-19
arm                   milbeaut_m10v_defconfig   clang-16
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240620   gcc-13.2.0
arm                   randconfig-002-20240620   clang-19
arm                   randconfig-003-20240620   gcc-13.2.0
arm                   randconfig-004-20240620   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240620   gcc-13.2.0
arm64                 randconfig-002-20240620   gcc-13.2.0
arm64                 randconfig-003-20240620   gcc-13.2.0
arm64                 randconfig-004-20240620   clang-19
csky                  randconfig-001-20240620   gcc-13.2.0
csky                  randconfig-002-20240620   gcc-13.2.0
hexagon               randconfig-001-20240620   clang-19
hexagon               randconfig-002-20240620   clang-19
i386         buildonly-randconfig-001-20240620   gcc-13
i386         buildonly-randconfig-002-20240620   clang-18
i386         buildonly-randconfig-003-20240620   gcc-13
i386         buildonly-randconfig-004-20240620   gcc-10
i386         buildonly-randconfig-005-20240620   gcc-13
i386         buildonly-randconfig-006-20240620   clang-18
i386                  randconfig-001-20240620   clang-18
i386                  randconfig-002-20240620   clang-18
i386                  randconfig-003-20240620   gcc-13
i386                  randconfig-004-20240620   gcc-10
i386                  randconfig-005-20240620   clang-18
i386                  randconfig-006-20240620   gcc-10
i386                  randconfig-011-20240620   gcc-7
i386                  randconfig-012-20240620   clang-18
i386                  randconfig-013-20240620   clang-18
i386                  randconfig-014-20240620   gcc-7
i386                  randconfig-015-20240620   clang-18
i386                  randconfig-016-20240620   clang-18
loongarch             randconfig-001-20240620   gcc-13.2.0
loongarch             randconfig-002-20240620   gcc-13.2.0
mips                           ci20_defconfig   clang-19
mips                   sb1250_swarm_defconfig   gcc-13.2.0
nios2                 randconfig-001-20240620   gcc-13.2.0
nios2                 randconfig-002-20240620   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240620   gcc-13.2.0
parisc                randconfig-002-20240620   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                      bamboo_defconfig   clang-19
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                  mpc866_ads_defconfig   clang-19
powerpc                  mpc885_ads_defconfig   clang-19
powerpc               randconfig-001-20240620   gcc-13.2.0
powerpc               randconfig-002-20240620   gcc-13.2.0
powerpc               randconfig-003-20240620   clang-17
powerpc                     tqm8540_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240620   gcc-13.2.0
powerpc64             randconfig-002-20240620   gcc-13.2.0
powerpc64             randconfig-003-20240620   clang-17
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240620   clang-19
riscv                 randconfig-002-20240620   clang-14
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240620   gcc-13.2.0
s390                  randconfig-002-20240620   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240620   gcc-13.2.0
sh                    randconfig-002-20240620   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                        sh7763rdp_defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240620   gcc-13.2.0
sparc64               randconfig-002-20240620   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240620   clang-19
um                    randconfig-002-20240620   gcc-13
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240620   clang-18
x86_64       buildonly-randconfig-002-20240620   gcc-10
x86_64       buildonly-randconfig-003-20240620   clang-18
x86_64       buildonly-randconfig-004-20240620   gcc-13
x86_64       buildonly-randconfig-005-20240620   clang-18
x86_64       buildonly-randconfig-006-20240620   gcc-13
x86_64                randconfig-001-20240620   clang-18
x86_64                randconfig-002-20240620   gcc-13
x86_64                randconfig-003-20240620   clang-18
x86_64                randconfig-004-20240620   clang-18
x86_64                randconfig-005-20240620   gcc-11
x86_64                randconfig-006-20240620   clang-18
x86_64                randconfig-011-20240620   gcc-13
x86_64                randconfig-012-20240620   gcc-13
x86_64                randconfig-013-20240620   gcc-13
x86_64                randconfig-014-20240620   gcc-13
x86_64                randconfig-015-20240620   clang-18
x86_64                randconfig-016-20240620   clang-18
x86_64                randconfig-071-20240620   gcc-13
x86_64                randconfig-072-20240620   gcc-13
x86_64                randconfig-073-20240620   gcc-13
x86_64                randconfig-074-20240620   clang-18
x86_64                randconfig-075-20240620   clang-18
x86_64                randconfig-076-20240620   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240620   gcc-13.2.0
xtensa                randconfig-002-20240620   gcc-13.2.0
xtensa                    xip_kc705_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

