Return-Path: <linux-pci+bounces-7589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425D38C80A5
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 07:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FE3B216CE
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 05:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5EDDCD;
	Fri, 17 May 2024 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQ5C16ld"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7361010A13
	for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715924416; cv=none; b=mREY612YfPac4Z9CXe9atEunVBDhrCYX+wa71ghmSvCmb25yH/mDiFNOlMj+9b3eEefstA/pf34KzNgByin9ma5tUxo0N7AeoTidk6wxSu7SlyVH85+wjSm0+n0Swm/8FyGPj18au1Up9S2O+ceKMjifNwWXRLTkj2TA+fo8xk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715924416; c=relaxed/simple;
	bh=+U3fVNuBIxrUZ9LoO26HAlXLwR27TfanIMlQuHAml1I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cDnuoDv+virMxogz3FHclJDNGsF5JSpHZAvbsz7PHi2Zr6HhG88VTRNZPq4xTWKIC4cp1mLjH+Elry12dlTp1KJHSarOIErbjyS+Hk91vXCk/lL4UbpFfPMeisb12NEAb82DAt/9AnpwqiVJ53BJPi26tiV75c6oS4EqEd7N4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQ5C16ld; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715924415; x=1747460415;
  h=date:from:to:cc:subject:message-id;
  bh=+U3fVNuBIxrUZ9LoO26HAlXLwR27TfanIMlQuHAml1I=;
  b=WQ5C16ldZGlNVMQ1z4uIMzmvNNTPajUN2lX7caMHssfVebkmukC602Cn
   DbkuV8sIPPjMFiQDUqqoTC0MPIcvvlOCdXMus54kCOoLcsu+04rpRTBOc
   0TkRMVR+b2bJDSZX6gJrpsjk3F+FRxpKaGvBj4Hzevs993rppgai3A2u4
   JqvVZU3TjlILsenWuXAqd0UKrqjjdlLSJMp5wvB4RnFLgpCe/P6kKvVK/
   B0iMeyz6YNY8qSm5KzQ34xVXE81yqJuC/DuqQ57qvnQqlnNtJeEm5Y75b
   pPHz5be45NVaUsiIkgBOTy+VR4Pe+allkBaZGbc5D6L5Z8rbzuPCgQf8F
   Q==;
X-CSE-ConnectionGUID: xrEfCMY+SgKBJnXTjzhWbA==
X-CSE-MsgGUID: 69zv+J/bRBit+AgN+udxAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23493837"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="23493837"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 22:40:14 -0700
X-CSE-ConnectionGUID: CoJwXztbQHm2j4JOIRl9wg==
X-CSE-MsgGUID: heXp4rNKTSebFCMvido1TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="31814839"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 16 May 2024 22:40:09 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7qJc-0000H8-37;
	Fri, 17 May 2024 05:39:50 +0000
Date: Fri, 17 May 2024 13:15:32 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 2dba285caba53f309d6060fca911b43d63f41697
Message-ID: <202405171330.dVl0mIq3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: 2dba285caba53f309d6060fca911b43d63f41697  PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id

elapsed time: 735m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240517   gcc  
arc                   randconfig-002-20240517   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                        mvebu_v7_defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240517   clang
arm                   randconfig-002-20240517   clang
arm                   randconfig-003-20240517   clang
arm                   randconfig-004-20240517   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240517   clang
arm64                 randconfig-002-20240517   gcc  
arm64                 randconfig-003-20240517   clang
arm64                 randconfig-004-20240517   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240517   gcc  
csky                  randconfig-002-20240517   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240517   clang
hexagon               randconfig-002-20240517   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240517   clang
i386         buildonly-randconfig-002-20240517   clang
i386         buildonly-randconfig-003-20240517   gcc  
i386         buildonly-randconfig-004-20240517   clang
i386         buildonly-randconfig-005-20240517   clang
i386         buildonly-randconfig-006-20240517   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240517   gcc  
i386                  randconfig-002-20240517   gcc  
i386                  randconfig-003-20240517   gcc  
i386                  randconfig-004-20240517   gcc  
i386                  randconfig-005-20240517   gcc  
i386                  randconfig-006-20240517   gcc  
i386                  randconfig-011-20240517   gcc  
i386                  randconfig-012-20240517   clang
i386                  randconfig-013-20240517   gcc  
i386                  randconfig-014-20240517   gcc  
i386                  randconfig-015-20240517   clang
i386                  randconfig-016-20240517   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240517   gcc  
loongarch             randconfig-002-20240517   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240517   gcc  
nios2                 randconfig-002-20240517   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240517   gcc  
parisc                randconfig-002-20240517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc               randconfig-001-20240517   clang
powerpc               randconfig-002-20240517   clang
powerpc               randconfig-003-20240517   gcc  
powerpc                     stx_gp3_defconfig   clang
powerpc                     tqm8555_defconfig   clang
powerpc64             randconfig-001-20240517   gcc  
powerpc64             randconfig-002-20240517   gcc  
powerpc64             randconfig-003-20240517   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_k210_defconfig   clang
riscv                 randconfig-001-20240517   clang
riscv                 randconfig-002-20240517   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240517   clang
s390                  randconfig-002-20240517   clang
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240517   gcc  
sh                    randconfig-002-20240517   gcc  
sh                           se7619_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240517   gcc  
sparc64               randconfig-002-20240517   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240517   clang
um                    randconfig-002-20240517   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240517   gcc  
xtensa                randconfig-002-20240517   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

