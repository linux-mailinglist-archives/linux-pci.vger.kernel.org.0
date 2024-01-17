Return-Path: <linux-pci+bounces-2247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCC08300E8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 09:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DBF1C227A9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015CCBE76;
	Wed, 17 Jan 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfUcmCHq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35AC121
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478455; cv=none; b=DV7TMiIIfddU0KwPc0aq5X/8NGCTyi06Q7teUkLZkWj+Q5TGKc8Z2fgXfTnA7deY/JR03Xo2Eh0p/x3FKrzU/4S4EETA05Dds4tOFaczn9tVP2n13nFbyUoqXH0M3LZ4PuR9rUoOoXnQEqjn3LhciBBiFsO9jGnFA2PkgQozUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478455; c=relaxed/simple;
	bh=z7vvHeCuBUTJTMqJWUZ//qz0mci78vDvo/o9bdS+tEs=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:User-Agent; b=P7QkKPJ3ziSyanMQm8/cbGfsv9jscW3wmOmrxiuigT+ixyVkKu/UDcDLybOAQ4j1CrNthvA+q4sd5QUyWknVzdJ6VmxxV/UOazsP7iiqQnjti2Pzvh55k36Rog/MKfu04jhnQeoTydVK/7SjGaHe8nvlxIjymmxoFaVdMTTL9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfUcmCHq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705478454; x=1737014454;
  h=date:from:to:cc:subject:message-id;
  bh=z7vvHeCuBUTJTMqJWUZ//qz0mci78vDvo/o9bdS+tEs=;
  b=GfUcmCHq4dI/G5D3Zeur4AzchXn8PoGjhJNXSF0cZMIekmzHiMJyTIFO
   F/5oNuiSy3rv3GVuw05mvdtT8uk1ma4R3QVsbqN9Dtb1XKLpjJWxjw7Ug
   kFF+2Msn8o66LfnmJLBxDOxYj5/2XSCflPCj53W34wbhDRbxWd03Lgjlw
   SEGBlCm6iHh5NAEnpZJEoODCcrsvgayEr7LwvlLJb1DK567uPDhOt99zQ
   BTu1IVfPjdiSy5sPmlOu/NihN9423F8i2DyNq4iv/sSQsbGbaWp2sSU2I
   +2SYj74SjuQYgFLHwKz1uIZXPQY4/ufMvITEZsKxVabOht22SCMPpHhlb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6858555"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6858555"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 00:00:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="733897352"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="733897352"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2024 00:00:51 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQ0qu-0001lQ-2Q;
	Wed, 17 Jan 2024 08:00:48 +0000
Date: Wed, 17 Jan 2024 16:00:19 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 7119ca35ee4a0129ae86ae9d36f357edc55aab2f
Message-ID: <202401171617.WmkXMb5d-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 7119ca35ee4a0129ae86ae9d36f357edc55aab2f  Merge branch 'pci/misc'

elapsed time: 2209m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240117   gcc  
arc                   randconfig-002-20240117   gcc  
arm                               allnoconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                   randconfig-001-20240117   gcc  
arm                   randconfig-002-20240117   gcc  
arm                   randconfig-003-20240117   gcc  
arm                   randconfig-004-20240117   gcc  
arm                           tegra_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240116   clang
i386         buildonly-randconfig-002-20240116   clang
i386         buildonly-randconfig-003-20240116   clang
i386         buildonly-randconfig-004-20240116   clang
i386         buildonly-randconfig-005-20240116   clang
i386         buildonly-randconfig-006-20240116   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240116   clang
i386                  randconfig-002-20240116   clang
i386                  randconfig-003-20240116   clang
i386                  randconfig-004-20240116   clang
i386                  randconfig-005-20240116   clang
i386                  randconfig-006-20240116   clang
i386                  randconfig-011-20240116   gcc  
i386                  randconfig-012-20240116   gcc  
i386                  randconfig-013-20240116   gcc  
i386                  randconfig-014-20240116   gcc  
i386                  randconfig-015-20240116   gcc  
i386                  randconfig-016-20240116   gcc  
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
mips                              allnoconfig   clang
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
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sparc                            allmodconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240117   gcc  
x86_64       buildonly-randconfig-002-20240117   gcc  
x86_64       buildonly-randconfig-003-20240117   gcc  
x86_64       buildonly-randconfig-004-20240117   gcc  
x86_64       buildonly-randconfig-005-20240117   gcc  
x86_64       buildonly-randconfig-006-20240117   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240117   clang
x86_64                randconfig-002-20240117   clang
x86_64                randconfig-003-20240117   clang
x86_64                randconfig-004-20240117   clang
x86_64                randconfig-005-20240117   clang
x86_64                randconfig-006-20240117   clang
x86_64                randconfig-011-20240117   gcc  
x86_64                randconfig-012-20240117   gcc  
x86_64                randconfig-013-20240117   gcc  
x86_64                randconfig-014-20240117   gcc  
x86_64                randconfig-015-20240117   gcc  
x86_64                randconfig-016-20240117   gcc  
x86_64                randconfig-071-20240117   gcc  
x86_64                randconfig-072-20240117   gcc  
x86_64                randconfig-073-20240117   gcc  
x86_64                randconfig-074-20240117   gcc  
x86_64                randconfig-075-20240117   gcc  
x86_64                randconfig-076-20240117   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

