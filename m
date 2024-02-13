Return-Path: <linux-pci+bounces-3409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFF8539C8
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 19:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE54B22720
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5B605C7;
	Tue, 13 Feb 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MN1QTiqs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE67605BE
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848482; cv=none; b=DrOjvAbBRmkzMwRqRKM2ZNhnRC825TCOCqIasJr6c1eeshhCEGhhwlyvPEu7V+J4JZ2tioJivun/wTTSfZWsbh1+3mbv5m6fIsDp2RSp5WA02L4OtzT0F2CKfZB0TdZc+izDwNr2D0fQ1wppKrCDvre7PYcrpDAy9AanORHxmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848482; c=relaxed/simple;
	bh=Je15kZTz9Ibq8JZu4FgWlHxs3pQjISZdfT/Uu039OCc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dtDY3hrBaXwebooJzQrV5w//uXcgfYUt0r7Kazns9ohNL56ytmTAMqIXwD9XwHv9Eezy82pb5Bvq6m8e623V25ZbQDesNo0PO3zsGuzRXpKbzJtjwHI03WxOfeSDbh+zzFyMQOfuFyy9mrBzclk/yOfiUuKjp/zFpDFi6sNgiTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MN1QTiqs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707848480; x=1739384480;
  h=date:from:to:cc:subject:message-id;
  bh=Je15kZTz9Ibq8JZu4FgWlHxs3pQjISZdfT/Uu039OCc=;
  b=MN1QTiqsenjCTkwfIe8KftqS3pWWH9/j/J/JkdSQDWi/QoBRuhooHR8L
   K4/QKwW+oeSedpMyN/1MSOrQeFIEcb+AT34RwcgNuqef6vjtfwo8J4rKA
   WdCyK/qrOeJlY/inO3I12jnpCo2T0ovYVhmpWLw3smeD4vkhbCcXTFcoz
   K9ufuuVFWOCKpV3Eb+zqdivO+55CMtTmlAE9qEAnGO8MGBlOUWAwmXQJC
   P3R/Lkv2e5HtubcBhPO0+kcXqYFEHYo299MYwrP9Hwj12ZQsqAZDy3/I3
   tewd4z/S5xhQ1V0KH7+De8t/I5S+ulyBfxX1UpkUduz+2e70qnoGVjmqY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5645096"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5645096"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 10:21:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="826186405"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="826186405"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2024 10:21:10 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZxP2-0007yw-0M;
	Tue, 13 Feb 2024 18:21:08 +0000
Date: Wed, 14 Feb 2024 02:21:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:devres] BUILD SUCCESS
 815a3909ead7440e2827042e5ec618f4396f022c
Message-ID: <202402140201.kDtvdnHv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git devres
branch HEAD: 815a3909ead7440e2827042e5ec618f4396f022c  PCI: Move devres code from pci.c to devres.c

elapsed time: 1452m

configs tested: 177
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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240213   gcc  
arc                   randconfig-002-20240213   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                   randconfig-001-20240213   gcc  
arm                   randconfig-002-20240213   gcc  
arm                   randconfig-003-20240213   gcc  
arm                   randconfig-004-20240213   clang
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240213   gcc  
arm64                 randconfig-002-20240213   gcc  
arm64                 randconfig-003-20240213   gcc  
arm64                 randconfig-004-20240213   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240213   gcc  
csky                  randconfig-002-20240213   gcc  
hexagon                          alldefconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240213   clang
hexagon               randconfig-002-20240213   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240213   clang
i386         buildonly-randconfig-002-20240213   gcc  
i386         buildonly-randconfig-003-20240213   gcc  
i386         buildonly-randconfig-004-20240213   clang
i386         buildonly-randconfig-005-20240213   gcc  
i386         buildonly-randconfig-006-20240213   clang
i386                                defconfig   clang
i386                  randconfig-001-20240213   clang
i386                  randconfig-002-20240213   gcc  
i386                  randconfig-003-20240213   gcc  
i386                  randconfig-004-20240213   clang
i386                  randconfig-005-20240213   gcc  
i386                  randconfig-006-20240213   gcc  
i386                  randconfig-011-20240213   clang
i386                  randconfig-012-20240213   gcc  
i386                  randconfig-013-20240213   gcc  
i386                  randconfig-014-20240213   gcc  
i386                  randconfig-015-20240213   gcc  
i386                  randconfig-016-20240213   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240213   gcc  
loongarch             randconfig-002-20240213   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240213   gcc  
nios2                 randconfig-002-20240213   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240213   gcc  
parisc                randconfig-002-20240213   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc               randconfig-001-20240213   clang
powerpc               randconfig-002-20240213   gcc  
powerpc               randconfig-003-20240213   gcc  
powerpc                     tqm8541_defconfig   clang
powerpc64             randconfig-001-20240213   gcc  
powerpc64             randconfig-002-20240213   gcc  
powerpc64             randconfig-003-20240213   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240213   gcc  
riscv                 randconfig-002-20240213   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240213   gcc  
s390                  randconfig-002-20240213   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240213   gcc  
sh                    randconfig-002-20240213   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240213   gcc  
sparc64               randconfig-002-20240213   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240213   clang
um                    randconfig-002-20240213   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240213   clang
x86_64       buildonly-randconfig-002-20240213   gcc  
x86_64       buildonly-randconfig-003-20240213   clang
x86_64       buildonly-randconfig-004-20240213   gcc  
x86_64       buildonly-randconfig-005-20240213   gcc  
x86_64       buildonly-randconfig-006-20240213   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240213   gcc  
x86_64                randconfig-002-20240213   clang
x86_64                randconfig-003-20240213   clang
x86_64                randconfig-004-20240213   gcc  
x86_64                randconfig-005-20240213   clang
x86_64                randconfig-006-20240213   clang
x86_64                randconfig-011-20240213   clang
x86_64                randconfig-012-20240213   clang
x86_64                randconfig-013-20240213   clang
x86_64                randconfig-014-20240213   gcc  
x86_64                randconfig-015-20240213   clang
x86_64                randconfig-016-20240213   clang
x86_64                randconfig-071-20240213   gcc  
x86_64                randconfig-072-20240213   gcc  
x86_64                randconfig-073-20240213   clang
x86_64                randconfig-074-20240213   gcc  
x86_64                randconfig-075-20240213   gcc  
x86_64                randconfig-076-20240213   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240213   gcc  
xtensa                randconfig-002-20240213   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

