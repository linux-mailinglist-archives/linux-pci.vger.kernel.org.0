Return-Path: <linux-pci+bounces-8574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C333903351
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA328B3C3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD613D8BA;
	Tue, 11 Jun 2024 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMrAV1xv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDE26AF6
	for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090460; cv=none; b=TFfRu0MN9ONNXHW+hM2jRXR5oKczi4zaIXSDMFD4Td+FFkqOMDBzmU2u3pKvIdUgWOvJoQhNJzTru5c4JGM4Mq7rP1J1HWVY7e1fQqJ9sDYWIVB8v2tE8CTjV1DsL5BSgDZfk1ZasycUYXCRbd64/Lcx6+c6vcr1lFSkP0SFAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090460; c=relaxed/simple;
	bh=dE1iJhhknF3ZkB1NMFqMfDsgatfEZsG5xe8CXCwpdKs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dXPWmVt18ENa4T1ilUqDqACJPstCusjIf8VWwtrFPqwPlJBIY1ojnOdDzX6gK29AVGL8pjsaTQidrsNmrKUNdJGVpa/1Cm6o6+3n8AMBF8jAG7WAXiCwbvluqwpaJJuyKHs29K3oyJs42m+xOvicsyd1jjRcIHKnF356YPM7+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMrAV1xv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718090459; x=1749626459;
  h=date:from:to:cc:subject:message-id;
  bh=dE1iJhhknF3ZkB1NMFqMfDsgatfEZsG5xe8CXCwpdKs=;
  b=QMrAV1xvALm96D2mi8zco00pJUGmpURPDCQz6ze7tS7yURUYMaQtW5a2
   lQyYVisvpBDlY8DOZVGr0o7q8oQboy1fDrPdcS80P+ga25/iiUAVJKmIK
   zni1pUekQf3e55e6yY9U7fAc9j5ZqZgWIDkYG8JM/a7U+ks/hrX+Cu3qW
   L/E9L4TbYohETiFl7k66T0BE419jVNSzyMT2UUJ6OJsrZhGfVKBK0cx5G
   nt+uKNJwsDJWgd89CJpNkFqF6Iyy4I58NelfUAfsON4XppZcypprRAUoS
   4XcvkN+WdVTICXGhYaLrCPNcweaRE0Rrp9Z66uHnmFR7JGqtG1wdTAai2
   A==;
X-CSE-ConnectionGUID: +1fxFctIRlGruhmujfhuYQ==
X-CSE-MsgGUID: JAcJ309LStGGFEBzYx8W3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14622630"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14622630"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 00:20:59 -0700
X-CSE-ConnectionGUID: hBH6gr56Sl+kowuQTUlgrg==
X-CSE-MsgGUID: jsRuCXMpTzeLmNrfpsSy5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="43749720"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Jun 2024 00:20:57 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGvoM-0000AU-39;
	Tue, 11 Jun 2024 07:20:54 +0000
Date: Tue, 11 Jun 2024 15:20:07 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 09f1e1b78ebf670146288d6afcfa2a8c01e9b3de
Message-ID: <202406111505.ODufELKI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 09f1e1b78ebf670146288d6afcfa2a8c01e9b3de  PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers

elapsed time: 1461m

configs tested: 168
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   alpha
allyesconfig                            alpha   defconfig
arc                               allnoconfig   arc  
defconfig                                 arc   randconfig-001-20240611
arc                   randconfig-002-20240611   arm  
allnoconfig                               arm   defconfig
arm                   randconfig-001-20240611   arm64
allnoconfig                             arm64   defconfig
arm64                 randconfig-004-20240611   csky 
allnoconfig                              csky   defconfig
csky                  randconfig-001-20240611   csky 
randconfig-002-20240611                          hexagon   allmodconfig
hexagon                           allnoconfig   hexagon
allyesconfig                          hexagon   defconfig
i386                             allmodconfig   i386 
allnoconfig                              i386   allyesconfig
i386         buildonly-randconfig-001-20240610   i386 
buildonly-randconfig-002-20240610                             i386   buildonly-randconfig-003-20240610
i386         buildonly-randconfig-003-20240611   i386 
buildonly-randconfig-004-20240610                             i386   buildonly-randconfig-005-20240610
i386         buildonly-randconfig-006-20240610   i386 
defconfig                                i386   randconfig-001-20240610
i386                  randconfig-001-20240611   i386 
randconfig-002-20240610                             i386   randconfig-003-20240610
i386                  randconfig-004-20240610   i386 
randconfig-004-20240611                             i386   randconfig-005-20240610
i386                  randconfig-006-20240610   i386 
randconfig-006-20240611                             i386   randconfig-011-20240610
i386                  randconfig-011-20240611   i386 
randconfig-012-20240610                             i386   randconfig-013-20240610
i386                  randconfig-013-20240611   i386 
randconfig-014-20240610                             i386   randconfig-015-20240610
i386                  randconfig-015-20240611   i386 
randconfig-016-20240610                             i386   randconfig-016-20240611
loongarch                        allmodconfig   loongarch
allnoconfig                         loongarch   defconfig
loongarch             randconfig-001-20240611   loongarch
randconfig-002-20240611                             m68k   allmodconfig
m68k                              allnoconfig   m68k 
allyesconfig                             m68k   defconfig
microblaze                       allmodconfig   microblaze
allnoconfig                        microblaze   allyesconfig
microblaze                          defconfig   mips 
allnoconfig                              mips   allyesconfig
nios2                            allmodconfig   nios2
allnoconfig                             nios2   allyesconfig
nios2                               defconfig   nios2
randconfig-001-20240611                            nios2   randconfig-002-20240611
openrisc                          allnoconfig   openrisc
allyesconfig                         openrisc   defconfig
parisc                           allmodconfig   parisc
allnoconfig                            parisc   allyesconfig
parisc                              defconfig   parisc
randconfig-001-20240611                           parisc   randconfig-002-20240611
parisc64                            defconfig   powerpc
allmodconfig                          powerpc   allnoconfig
powerpc                          allyesconfig   powerpc
allyesconfig                         clang-19   powerpc
randconfig-001-20240611                        powerpc64   randconfig-001-20240611
riscv                            allmodconfig   riscv
allmodconfig                         clang-19   riscv
allnoconfig                             riscv   allyesconfig
riscv                            allyesconfig   clang-19
riscv                               defconfig   riscv
randconfig-001-20240611                             s390   allmodconfig
s390                              allnoconfig   s390 
allyesconfig                             s390   defconfig
s390                  randconfig-001-20240611   s390 
randconfig-002-20240611                               sh   allmodconfig
sh                                allnoconfig   sh   
allyesconfig                               sh   defconfig
sh                    randconfig-001-20240611   sh   
randconfig-002-20240611                            sparc   allmodconfig
sparc                             allnoconfig   sparc
defconfig                             sparc64   allmodconfig
sparc64                          allyesconfig   sparc64
defconfig                             sparc64   randconfig-001-20240611
sparc64               randconfig-002-20240611   um   
allmodconfig                               um   allnoconfig
um                               allyesconfig   um   
defconfig                                  um   i386_defconfig
um                    randconfig-001-20240611   um   
randconfig-002-20240611                               um   x86_64_defconfig
x86_64                            allnoconfig   x86_64
allyesconfig                           x86_64   buildonly-randconfig-001-20240610
x86_64       buildonly-randconfig-001-20240611   x86_64
buildonly-randconfig-002-20240610                           x86_64   buildonly-randconfig-002-20240611
x86_64       buildonly-randconfig-003-20240610   x86_64
buildonly-randconfig-003-20240611                           x86_64   buildonly-randconfig-004-20240610
x86_64       buildonly-randconfig-005-20240610   x86_64
buildonly-randconfig-005-20240611                           x86_64   buildonly-randconfig-006-20240610
x86_64       buildonly-randconfig-006-20240611   x86_64
defconfig                              x86_64   randconfig-001-20240610
x86_64                randconfig-002-20240610   x86_64
randconfig-002-20240611                           x86_64   randconfig-003-20240610
x86_64                randconfig-003-20240611   x86_64
randconfig-004-20240610                           x86_64   randconfig-005-20240610
x86_64                randconfig-005-20240611   x86_64
randconfig-006-20240610                           x86_64   randconfig-011-20240610
x86_64                randconfig-012-20240610   x86_64
randconfig-012-20240611                           x86_64   randconfig-013-20240610
x86_64                randconfig-014-20240610   x86_64
randconfig-015-20240610                           x86_64   randconfig-016-20240610
x86_64                randconfig-016-20240611   x86_64
randconfig-071-20240610                           x86_64   randconfig-072-20240610
x86_64                randconfig-072-20240611   x86_64
randconfig-073-20240610                           x86_64   randconfig-074-20240610
x86_64                randconfig-074-20240611   x86_64
randconfig-075-20240610                           x86_64   randconfig-075-20240611
x86_64                randconfig-076-20240610   x86_64
randconfig-076-20240611                           x86_64   rhel-8.3-rust
xtensa                            allnoconfig   xtensa
randconfig-001-20240611                           xtensa   randconfig-002-20240611

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

