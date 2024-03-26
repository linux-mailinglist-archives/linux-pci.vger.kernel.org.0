Return-Path: <linux-pci+bounces-5192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A71E88C9BD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 17:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D28B1C641A3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2B1798A;
	Tue, 26 Mar 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPf3WMZ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9401BDE6
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471675; cv=none; b=WcEUG5TKxKfeRbkUC5d38414MPlZNBzqQUO1zPoffBk0Rm2LKDOIPxMudYgkdPMxpy5HioCQUSZO+MsW2IpMtcjzEuYj0YAD7tmpS7jYBmjLhhjVYQjTmXWyD22kvCdZXJpQYSvMa3yMSO2sneWve0q3TdhK8mgJ8i7hE3VWkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471675; c=relaxed/simple;
	bh=1zSSbpaGs4HmhrGr+EGI3cR5k/oqs5XvLI0UnJz+d3w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MspTMWA8k2cR+HlM7RE/glLY1pB7h83xPWEqjmekh/Nu6bgA/WWa9vyBBXUL9YXK+IvROjsfwYUMJ91CL8hlznW9rU80y86vDBi2IXzxAMmbky3ApDzXZzTJaEQo2RCp3XchmE5RWHpc5G86LbGybi00xwOThqQ1tYNXDLlIIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPf3WMZ6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711471675; x=1743007675;
  h=date:from:to:cc:subject:message-id;
  bh=1zSSbpaGs4HmhrGr+EGI3cR5k/oqs5XvLI0UnJz+d3w=;
  b=CPf3WMZ6orsizPmJuaUIto4GaOnk+LlU7TMTB51550N1ACmz8lEkGaV/
   Dpurz5VvzmUf0OHq9iOvHmMmYix2Eiaxcs72PrMupr2IfdPEZZICzfifq
   QepVwryfhYW0dcf6P5vW2toXvRqJ0DAZBxbXHYS6pV1bibvbRttzbsP4w
   fSlH7AC0QoodllmWpjh2f3rgYIGnEYk5wkCsaI78qzmKHFsMPTyUKMo+p
   1DS3HioRmewmshpbvg/WSM8zHKYb1j1i+YEE3Md2hhq82lg2O9Odrtb0c
   vcdCL1GTQSgxuyZk4diMI7VV7mUPCCH5tYM05Wi5DLOIVg+bY4nd+8YsV
   A==;
X-CSE-ConnectionGUID: 5Rdgi0wRRceyYRfy7P+s9Q==
X-CSE-MsgGUID: 6RwDBDVKQ3qTbyquho3zyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17679364"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17679364"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20565313"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Mar 2024 09:47:52 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp9xm-0000EW-12;
	Tue, 26 Mar 2024 16:47:50 +0000
Date: Wed, 27 Mar 2024 00:47:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD REGRESSION
 8694697a54096ae97eb38bf4144f2d96c64c68f2
Message-ID: <202403270010.txoZNhlZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 8694697a54096ae97eb38bf4144f2d96c64c68f2  PCI: Remove PCI_IRQ_LEGACY

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202403261840.1RP419n5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403261944.ObfbvQQV-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/mfd/intel-lpss-pci.c:57:42: error: use of undeclared identifier 'PCI_IRQ_LEGACY'; did you mean '__WQ_LEGACY'?
drivers/mfd/intel-lpss-pci.c:57:49: error: 'PCI_IRQ_LEGACY' undeclared (first use in this function); did you mean 'NR_IRQS_LEGACY'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- drivers-mfd-intel-lpss-pci.c:error:PCI_IRQ_LEGACY-undeclared-(first-use-in-this-function)
`-- i386-buildonly-randconfig-001-20240326
    `-- drivers-mfd-intel-lpss-pci.c:error:PCI_IRQ_LEGACY-undeclared-(first-use-in-this-function)
clang_recent_errors
|-- i386-randconfig-013-20240326
|   `-- drivers-mfd-intel-lpss-pci.c:error:use-of-undeclared-identifier-PCI_IRQ_LEGACY
`-- x86_64-rhel-8.3-rust
    `-- drivers-mfd-intel-lpss-pci.c:error:use-of-undeclared-identifier-PCI_IRQ_LEGACY

elapsed time: 1188m

configs tested: 125
configs skipped: 3

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
i386         buildonly-randconfig-001-20240326   gcc  
i386         buildonly-randconfig-002-20240326   clang
i386         buildonly-randconfig-003-20240326   clang
i386         buildonly-randconfig-004-20240326   gcc  
i386         buildonly-randconfig-005-20240326   gcc  
i386         buildonly-randconfig-006-20240326   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240326   gcc  
i386                  randconfig-002-20240326   gcc  
i386                  randconfig-003-20240326   gcc  
i386                  randconfig-004-20240326   clang
i386                  randconfig-005-20240326   gcc  
i386                  randconfig-006-20240326   clang
i386                  randconfig-011-20240326   clang
i386                  randconfig-012-20240326   gcc  
i386                  randconfig-013-20240326   clang
i386                  randconfig-014-20240326   clang
i386                  randconfig-015-20240326   clang
i386                  randconfig-016-20240326   clang
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
x86_64       buildonly-randconfig-001-20240326   clang
x86_64       buildonly-randconfig-002-20240326   gcc  
x86_64       buildonly-randconfig-003-20240326   clang
x86_64       buildonly-randconfig-004-20240326   gcc  
x86_64       buildonly-randconfig-005-20240326   gcc  
x86_64       buildonly-randconfig-006-20240326   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240326   gcc  
x86_64                randconfig-002-20240326   gcc  
x86_64                randconfig-003-20240326   gcc  
x86_64                randconfig-004-20240326   clang
x86_64                randconfig-005-20240326   gcc  
x86_64                randconfig-006-20240326   clang
x86_64                randconfig-011-20240326   gcc  
x86_64                randconfig-012-20240326   clang
x86_64                randconfig-013-20240326   gcc  
x86_64                randconfig-014-20240326   gcc  
x86_64                randconfig-015-20240326   clang
x86_64                randconfig-016-20240326   clang
x86_64                randconfig-071-20240326   clang
x86_64                randconfig-072-20240326   gcc  
x86_64                randconfig-073-20240326   gcc  
x86_64                randconfig-074-20240326   gcc  
x86_64                randconfig-075-20240326   gcc  
x86_64                randconfig-076-20240326   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

