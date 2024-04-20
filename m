Return-Path: <linux-pci+bounces-6497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949518ABBA8
	for <lists+linux-pci@lfdr.de>; Sat, 20 Apr 2024 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DD61F21274
	for <lists+linux-pci@lfdr.de>; Sat, 20 Apr 2024 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500D1427B;
	Sat, 20 Apr 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJZ0lCe2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E22625
	for <linux-pci@vger.kernel.org>; Sat, 20 Apr 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713618396; cv=none; b=Eyj9xYVn+VSJG3jq+FYovO63J2edG5BZ1k1CCU//REIGHMXtCwncrgKIOrMh0i2BUhMXM3K7WoJ+CTgCGqvmSWbL8119kSEGVyAMgdgQSY1Q/b2G84bBtJpxDU80uCBwg1L7w3ReNyZ4Mi53sSjbbjwFoQCpFwVbJzNQCkz9tSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713618396; c=relaxed/simple;
	bh=0EiHxFEj57Yz6BSDcBteejDlB8qIetKPDDcd3DcWmvk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tJ10h19VplbWk0gTSVLNMoieVjVynjhQAkbBOBn1dSvmLX7HfCXo6f35e0+a6nTMflOdLqMxbxcHBa0dFbljWAgAbcXx1RMvTdxswY5sn351/fpitQ8y2h4tNviVHuseOjWIQskP9b0c9x8CjQmjJo6/9lUGD4eMrjqQvWDFioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJZ0lCe2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713618395; x=1745154395;
  h=date:from:to:cc:subject:message-id;
  bh=0EiHxFEj57Yz6BSDcBteejDlB8qIetKPDDcd3DcWmvk=;
  b=gJZ0lCe2vdLVH2hZzD/WP/IhzcJHNL7ap6Mxf5KLcThgXZkrxtJ+h5mC
   Gc8Wz0IYrxNIC11Gg9yypcq25kRCa7dDzjTgxafU89vZMDv5lGkcGlN00
   6NY3GUk/Wr/8svtPbZ0jziDCO9WHSRa3wclHA2SgWJZKGahz3gRnqQP/0
   M9H7riPDWN3rnoWiKIp3cXKKubTM9Cvw9Jzc4O6phdbkBOBCT7MXZ5Jqq
   mtwskyDh29awxov483eM4Fc/AdNDKDfxFWfwS0lNrFWWiwklNu1uvEMgM
   pOVDtz2wglS6c++VGvUUQJYo2MzVADpWXGUA0W2fXfpaBFqrf8qLzA9CA
   Q==;
X-CSE-ConnectionGUID: RoLEsX2HS72DqjefPcVtwQ==
X-CSE-MsgGUID: RcmVXpfPS/StYM/v2q4Ldg==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="19767834"
X-IronPort-AV: E=Sophos;i="6.07,216,1708416000"; 
   d="scan'208";a="19767834"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 06:06:34 -0700
X-CSE-ConnectionGUID: cU7H4ML6S9CR6Yx5QI2Hpw==
X-CSE-MsgGUID: Z+eJBKCoS5O6hDcG6w/9ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,216,1708416000"; 
   d="scan'208";a="23652998"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 Apr 2024 06:06:32 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryAQI-000B6E-0S;
	Sat, 20 Apr 2024 13:06:30 +0000
Date: Sat, 20 Apr 2024 21:06:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 ccd0bdb57e31798f43ac30bce7805197bcfcd3dd
Message-ID: <202404202100.Wa4dShSV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: ccd0bdb57e31798f43ac30bce7805197bcfcd3dd  Merge branch 'pci/misc'

elapsed time: 920m

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
arc                   randconfig-001-20240420   gcc  
arc                   randconfig-002-20240420   gcc  
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
i386         buildonly-randconfig-001-20240420   gcc  
i386         buildonly-randconfig-002-20240420   clang
i386         buildonly-randconfig-003-20240420   gcc  
i386         buildonly-randconfig-004-20240420   gcc  
i386         buildonly-randconfig-005-20240420   gcc  
i386         buildonly-randconfig-006-20240420   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240420   clang
i386                  randconfig-002-20240420   gcc  
i386                  randconfig-003-20240420   gcc  
i386                  randconfig-004-20240420   gcc  
i386                  randconfig-005-20240420   clang
i386                  randconfig-006-20240420   gcc  
i386                  randconfig-011-20240420   clang
i386                  randconfig-012-20240420   clang
i386                  randconfig-013-20240420   clang
i386                  randconfig-014-20240420   clang
i386                  randconfig-015-20240420   clang
i386                  randconfig-016-20240420   clang
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
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

