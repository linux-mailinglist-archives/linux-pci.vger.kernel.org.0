Return-Path: <linux-pci+bounces-12927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C089D970492
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2024 02:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E801F21FA5
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2024 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485692595;
	Sun,  8 Sep 2024 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZNHKguH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804E17F7
	for <linux-pci@vger.kernel.org>; Sun,  8 Sep 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725754837; cv=none; b=On6G6cDFAFb7EwpEKe62QHCBlMpSfnNkFzK6OMV1BshukHtuCJQNcJqTKPUyTRtLlnZTWluPfD/B7uaFgAwfVOWATFJhq3SbBphAbVvrhQNSnpmw3duL91k/8ElV6/LcR+wE4DpMopZjhq+TFcboaQbB7qkUEHIjdM7ZtK3HDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725754837; c=relaxed/simple;
	bh=OvyKxVLy2ohvSLw3c/6q3EO6qX79tYRAUEetJ28Uj0w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ev96nVrOxiu+qr+TCJt4fMu/g847/0hAoxinbnDWhEQAalSMuCfuNT3Rx3sQihfXSbG9lIbw/dhM+T4Z/xbk/ngxcQ1C4xKDo0boDXB2zMc07ySWeMHgTd1vS+VPkwsVdrcMzZQilVKWZ5ipAMknkXO1nO3+4I7RN4KIMnwmfo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZNHKguH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725754835; x=1757290835;
  h=date:from:to:cc:subject:message-id;
  bh=OvyKxVLy2ohvSLw3c/6q3EO6qX79tYRAUEetJ28Uj0w=;
  b=eZNHKguHg9yjoSjPZtcxJCtVPDeD7l0lXT28uIVgtO7SLPrI+l39VJzV
   FbsbKg49gZj35z9ZouwserDB7gn5PrGm0Xc3kofK6G3cXJXqUeuD5wccD
   +90NeA+x6foScq8KokTopo2dWC0rzcLYEnkcf1zKaoLVwTszTLgh3/Ehp
   lTHaZqB8wR87Ire3Qc2UG5yyz7oOsW4KiPzT7OroXyj9NAqJ2uB/BfrVV
   LUXsj4Q55w9pIKbxgn9znSgap45l7r9QtVso4gHzPec60qjgIUf8dGtH3
   diE9tr41mY6klEEdUrESI7H1lDxW7u5kUOUAXUABwFJMNVr4LKNPQeTWy
   w==;
X-CSE-ConnectionGUID: NJZyEagOTBKbTnXWXnMy/A==
X-CSE-MsgGUID: AimbL0WHRHCXz0vF6pd0sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24673913"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24673913"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 17:20:34 -0700
X-CSE-ConnectionGUID: CEd9R2bpQi+pDdHRB6/oLg==
X-CSE-MsgGUID: c261OvYPSdmGdw15ZoDrRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="66848765"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Sep 2024 17:20:33 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn5fL-000D8h-0e;
	Sun, 08 Sep 2024 00:20:31 +0000
Date: Sun, 08 Sep 2024 08:20:20 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:npem] BUILD SUCCESS
 759ec28242894f2006a1606c1d6e9aca48cecfcf
Message-ID: <202409080818.rIFOc6lS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git npem
branch HEAD: 759ec28242894f2006a1606c1d6e9aca48cecfcf  PCI/NPEM: Add _DSM PCIe SSD status LED management

elapsed time: 1861m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240907   clang-18
i386         buildonly-randconfig-002-20240907   gcc-12
i386         buildonly-randconfig-003-20240907   gcc-12
i386         buildonly-randconfig-004-20240907   clang-18
i386         buildonly-randconfig-005-20240907   clang-18
i386         buildonly-randconfig-006-20240907   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240907   clang-18
i386                  randconfig-002-20240907   clang-18
i386                  randconfig-003-20240907   clang-18
i386                  randconfig-004-20240907   gcc-12
i386                  randconfig-005-20240907   gcc-12
i386                  randconfig-006-20240907   gcc-12
i386                  randconfig-011-20240907   clang-18
i386                  randconfig-012-20240907   gcc-12
i386                  randconfig-013-20240907   clang-18
i386                  randconfig-014-20240907   clang-18
i386                  randconfig-015-20240907   clang-18
i386                  randconfig-016-20240907   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                            defconfig   gcc-12
parisc                            allnoconfig   clang-20
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
riscv                             allnoconfig   clang-20
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240908   clang-18
x86_64       buildonly-randconfig-002-20240908   clang-18
x86_64       buildonly-randconfig-003-20240908   clang-18
x86_64       buildonly-randconfig-004-20240908   clang-18
x86_64       buildonly-randconfig-005-20240908   clang-18
x86_64       buildonly-randconfig-006-20240908   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240908   clang-18
x86_64                randconfig-002-20240908   clang-18
x86_64                randconfig-003-20240908   clang-18
x86_64                randconfig-004-20240908   clang-18
x86_64                randconfig-005-20240908   clang-18
x86_64                randconfig-006-20240908   clang-18
x86_64                randconfig-011-20240908   clang-18
x86_64                randconfig-012-20240908   clang-18
x86_64                randconfig-013-20240908   clang-18
x86_64                randconfig-014-20240908   clang-18
x86_64                randconfig-015-20240908   clang-18
x86_64                randconfig-016-20240908   clang-18
x86_64                randconfig-071-20240908   clang-18
x86_64                randconfig-072-20240908   clang-18
x86_64                randconfig-073-20240908   clang-18
x86_64                randconfig-074-20240908   clang-18
x86_64                randconfig-075-20240908   clang-18
x86_64                randconfig-076-20240908   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

