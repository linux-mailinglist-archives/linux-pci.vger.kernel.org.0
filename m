Return-Path: <linux-pci+bounces-4308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EA986E01E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C15B1F20C22
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD54438E;
	Fri,  1 Mar 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGT3DPFW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8720300
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292307; cv=none; b=A9bQSaJg51/3MymUCA/62+uaoc4KYBZp1UG1IinR9pyOdYrKILNn6jsmoeOJewuQngBDmsz73RVu1TiLK+tB44ZjvXDE4EEKhYI6uLnnW4V5ZAH8wMLWBj0wWPr8YFDzGPPxZuS4GZ17Ippu/QTkMKG7Bc71PAdh7ucrlA1BvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292307; c=relaxed/simple;
	bh=fjW0saSjRW2pvdvkIOZFxsmychpvJ+S9TuCB6aJ4mcw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vDzz3Bls2ZX9952kRSmj5Q+U+y9vmSmoitgwrlJ55w8UJLnVdNCd1PojJOsx6Ci+5xPAr4JAI23ElbReZGDgXjDeBMFwOF7avnXv9byj6MRyEvLhHUd3JCkKh9b6p0fvYddC23BMKIPgTSeC9zAn7teyG7typW5JFEb/6SV588k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGT3DPFW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709292306; x=1740828306;
  h=date:from:to:cc:subject:message-id;
  bh=fjW0saSjRW2pvdvkIOZFxsmychpvJ+S9TuCB6aJ4mcw=;
  b=mGT3DPFWUgkF00Il3v7R9TEpJkbzg0Doiiz9YIWfcJ2wTXoa6tdI2TXN
   ODdZ015ZY4wS6b07KvcCulNCkNa9mViSmvzGmGUoDbI9398hGfJOLhhRn
   26Z/UKyFf1tf57GKy3/OOd4CNvofUnVOy54bRzbfAYMaKmJI60gNWn01F
   dZYgojakFxATpKnHYFa+zt/AUBMmoOlCTX/MfQo/MqO7cnFNzMyiwJCQJ
   u4e2csPGT8TDOZVZ+UVFZvQPR9Cugfn9oacqnOWPY3n3pUEsHEsjH7lAc
   YRxUFA/k42ZhgINvEFZl4IFPnOt6S5l3t50j2hQgsABUjQXCDHpVCRze5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3987960"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3987960"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 03:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8121363"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 01 Mar 2024 03:25:05 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rg10g-000DoN-2P;
	Fri, 01 Mar 2024 11:25:02 +0000
Date: Fri, 01 Mar 2024 19:24:25 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:virtualization] BUILD SUCCESS
 29a43dc130ce65d365a8ea9e1cc4bc51005a353e
Message-ID: <202403011921.ZzE39tsV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git virtualization
branch HEAD: 29a43dc130ce65d365a8ea9e1cc4bc51005a353e  PCI: Mark LSI FW643 to avoid bus reset

elapsed time: 724m

configs tested: 103
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240301   clang
i386         buildonly-randconfig-002-20240301   clang
i386         buildonly-randconfig-003-20240301   gcc  
i386         buildonly-randconfig-004-20240301   clang
i386         buildonly-randconfig-005-20240301   clang
i386         buildonly-randconfig-006-20240301   clang
i386                                defconfig   clang
i386                  randconfig-001-20240301   clang
i386                  randconfig-002-20240301   clang
i386                  randconfig-003-20240301   clang
i386                  randconfig-004-20240301   clang
i386                  randconfig-005-20240301   gcc  
i386                  randconfig-006-20240301   gcc  
i386                  randconfig-011-20240301   gcc  
i386                  randconfig-012-20240301   clang
i386                  randconfig-013-20240301   clang
i386                  randconfig-014-20240301   gcc  
i386                  randconfig-015-20240301   gcc  
i386                  randconfig-016-20240301   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

