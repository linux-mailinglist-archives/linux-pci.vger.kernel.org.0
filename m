Return-Path: <linux-pci+bounces-7746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8645E8CC2B9
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B70D281DDF
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9CAD2D;
	Wed, 22 May 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5x2Liu3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FC6AB9
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386502; cv=none; b=MyHEm5NLJCcSvw6k/dCQYBN3hzUuJetZvadxXwcUh54u5MKzSmsRDMdSfY36ULTTz47ghIKDvTKLzwks95zysqfZj/nosoyaycV9gBVmkv3PMXKjY71yuwUC2rZK7B7FOaDtn+EbBO9nLBV2R4N0D0IE3CffarAiKe7O/WhAb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386502; c=relaxed/simple;
	bh=zhrKFH70tanWXZyOdzRD8sS3w4ncffbj6iKAlDURHzA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QGwNnt29zk3KT7EB3fKAjLq8CRV8N4FxXydjbms7f+ABEO49wzFVUBK0HjiWtbIMJTXIlQWsdfzEVyH0L3bkYDz67PsVeosJvvL9xxMigjv8J/F1sTgicM8VD1fTUaHM55NrZ04ql3dKZrdSuzrCvR09OGHA4mNYMr7zhHESra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5x2Liu3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716386500; x=1747922500;
  h=date:from:to:cc:subject:message-id;
  bh=zhrKFH70tanWXZyOdzRD8sS3w4ncffbj6iKAlDURHzA=;
  b=X5x2Liu3dYuGvJGSFEGPyvTRx/9mit/Bdcytff3kXn5UtlEQDYK5CA8C
   21GP7sPfxk1OkTN5bCMCBoXj+OEAOTMXz77n9RqsNFm8YJSWwdV0OrurC
   Wt8oxtfPxYo3JL2C83UzrlE6re0mI2xzbHZ736kE7xy6uYNwyK5A5+kwt
   VDAmVokuxmYaAGBU4qQw0g2DBfkHxgXzSDrHcC58xaxu1vC/kV9EYXp/R
   HuNnSUY/f0c2GN59z5r+CYMPcU/R/PCn/cOSP0jtt7EJkuoEDiGcGTzHO
   EsI/v505XKcPSphD/mCCW9KLOOpTEqOK/UYyYpkbhk6VV3X5eWEtvfQEK
   g==;
X-CSE-ConnectionGUID: +WpH1aR+R5eOOjFjKf5UiQ==
X-CSE-MsgGUID: Pzru3wBcSueeYMcUCxfyyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12870476"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12870476"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 07:01:40 -0700
X-CSE-ConnectionGUID: vt9/hBxdRrK5Ph8EefeFDQ==
X-CSE-MsgGUID: Sdgl0daCRPerav5DUak0QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37691370"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 May 2024 07:01:39 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9mX7-0001cY-0c;
	Wed, 22 May 2024 14:01:34 +0000
Date: Wed, 22 May 2024 22:01:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:defer/resource] BUILD SUCCESS
 7dfb342736c447eeb602642e57bbaf907fc1b465
Message-ID: <202405222203.wkfsEyC6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git defer/resource
branch HEAD: 7dfb342736c447eeb602642e57bbaf907fc1b465  PCI: Relax bridge window tail sizing rules

elapsed time: 1039m

configs tested: 96
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
i386                                defconfig   clang
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
x86_64       buildonly-randconfig-001-20240522   clang
x86_64       buildonly-randconfig-003-20240522   clang
x86_64       buildonly-randconfig-005-20240522   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240522   clang
x86_64                randconfig-006-20240522   clang
x86_64                randconfig-012-20240522   clang
x86_64                randconfig-014-20240522   clang
x86_64                randconfig-071-20240522   clang
x86_64                randconfig-072-20240522   clang
x86_64                randconfig-074-20240522   clang
x86_64                randconfig-075-20240522   clang
x86_64                randconfig-076-20240522   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

