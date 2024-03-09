Return-Path: <linux-pci+bounces-4689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A744D877035
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 11:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380291C203B0
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A468381C4;
	Sat,  9 Mar 2024 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWGpQWY3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D530381A4
	for <linux-pci@vger.kernel.org>; Sat,  9 Mar 2024 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709978966; cv=none; b=FhhHjDr/M22f2YfE+nmoqap2DO6QVSi1/VB5F8HbZo90AI68Wv4t0tqOM+kDPxMgDYpA7vgXAyPrg3zWRst2QYwEgDRKIEwBCK0VmvF070TZXceTbLcY9mWfSG4BCu3sjOs/94MGCNzOIuDcNz5GtoJfd2fFILG5SNnZynNcS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709978966; c=relaxed/simple;
	bh=xfAjNxfPQ+WsR6gyptdIuFXnxOyT7n6xnMVRmwiyVkE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nnzpjK1v7Ftp6FEl1UqPFrebt8b9n+lBWryFZfE0GZ5w4b1BQzpQ0KXuGUFF8eeDCqPeGCZfpWlJKrlDVS6DN4QP08aAGWJpOamxkchL+5k/l7pbnfoDcPUujFHnncjxhLbcmKK0pB/V0yUJX9rRZ3+v+xyUX31mupWfXXKgtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWGpQWY3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709978964; x=1741514964;
  h=date:from:to:cc:subject:message-id;
  bh=xfAjNxfPQ+WsR6gyptdIuFXnxOyT7n6xnMVRmwiyVkE=;
  b=TWGpQWY3NAczBU1dDDRsUN2VK6wVROBfzz32704gI7wXO7RQrlM7qPPf
   atWDhCK60Ea27iNcUrLQz/Rc/Hr4kCfX6JYsjfZYeAHefWbVADWOZy1Cn
   G1reQ27w4g4O0Ln5eT+49zsG9CnG2KrEdlm54hdJGmhQ+zpvqV4W08vz+
   5QRVt1yZ4fFdQm8odQgXE9XIrNse41AXjRRfj4ANEwNQSCRDFlNkoi+lp
   Ywr0RL6lAw01DZJjJO0jQO0Dt3xXVbrps4efx5rMniwOIvj6zS/xneqJD
   WQVwQ0DVs1vBeivLcetJRvDFCbunLL+OqlKYg5nhBpaT3JRNIejdnMJ7Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="16110417"
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="16110417"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 02:09:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="41623460"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Mar 2024 02:09:22 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ritdn-0007EN-1W;
	Sat, 09 Mar 2024 10:09:19 +0000
Date: Sat, 09 Mar 2024 18:08:22 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 0a5a46a6a61be7b63c12c18495d427f91f3662a9
Message-ID: <202403091817.58s3TNce-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: 0a5a46a6a61be7b63c12c18495d427f91f3662a9  PCI/AER: Generalize TLP Header Log reading

elapsed time: 730m

configs tested: 140
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
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                            mps2_defconfig   clang
arm                   randconfig-001-20240309   clang
arm                   randconfig-003-20240309   clang
arm                        spear6xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240309   clang
arm64                 randconfig-003-20240309   clang
arm64                 randconfig-004-20240309   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240309   clang
hexagon               randconfig-002-20240309   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240309   clang
i386         buildonly-randconfig-002-20240309   clang
i386         buildonly-randconfig-003-20240309   gcc  
i386         buildonly-randconfig-004-20240309   gcc  
i386         buildonly-randconfig-005-20240309   gcc  
i386         buildonly-randconfig-006-20240309   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240309   gcc  
i386                  randconfig-002-20240309   gcc  
i386                  randconfig-003-20240309   clang
i386                  randconfig-004-20240309   clang
i386                  randconfig-005-20240309   clang
i386                  randconfig-006-20240309   gcc  
i386                  randconfig-011-20240309   gcc  
i386                  randconfig-012-20240309   gcc  
i386                  randconfig-013-20240309   clang
i386                  randconfig-014-20240309   clang
i386                  randconfig-015-20240309   clang
i386                  randconfig-016-20240309   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                          rb532_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
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
powerpc                      makalu_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-002-20240309   clang
powerpc               randconfig-003-20240309   clang
powerpc64             randconfig-003-20240309   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240309   clang
s390                  randconfig-002-20240309   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240309   clang
um                    randconfig-002-20240309   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240309   clang
x86_64       buildonly-randconfig-003-20240309   clang
x86_64       buildonly-randconfig-006-20240309   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240309   clang
x86_64                randconfig-003-20240309   clang
x86_64                randconfig-005-20240309   clang
x86_64                randconfig-011-20240309   clang
x86_64                randconfig-012-20240309   clang
x86_64                randconfig-013-20240309   clang
x86_64                randconfig-076-20240309   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

