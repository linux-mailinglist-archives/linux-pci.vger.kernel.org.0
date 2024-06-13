Return-Path: <linux-pci+bounces-8700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF035906367
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E7E282C5E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF4132131;
	Thu, 13 Jun 2024 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvSYix6a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327113210A
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255918; cv=none; b=gCPRLG4uhVSFddjranCdNXWz3h2COmtVQ6RJY4+NALro2xVrXy9ufONpIzJJYlMMGJrXSEvYBJBdn0hsbJKsTy0PK58cJKjXlPPP+dtc0ba0/OP5qoWVvle+BOB18iQWbrDOHYGc2H9vVyZhzzjIjnMXilj5S/jMuEZxoSla/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255918; c=relaxed/simple;
	bh=i4YgdSp0vkBzLK3lZIhnTzXrjeYCYZacWjk6viYI8L0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g3xCDxx8AsQcS08Ee99+IbQX2l3l38p68OXJtJHW6aSU8gVgGtva7Txl1Fd93AveSORYJARKf4ibq/r+xdSGuE7U6Cccq8p4VkBEgtIP+A+5d55D4GWxzYlDd50PzwN+/w7+Hjj4g60WjecGYVCbCxtSttYf0J49oHhipa9swr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvSYix6a; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718255917; x=1749791917;
  h=date:from:to:cc:subject:message-id;
  bh=i4YgdSp0vkBzLK3lZIhnTzXrjeYCYZacWjk6viYI8L0=;
  b=dvSYix6aQNwyGk7DISDQmdSCCKas7bI3y7MlD4HIWGxu3P/chBM0nDoc
   wFNnVp5kFnk3J4yP1fynmsoZZXBpjcPBGo6jiCsoDnJNVQekv/kqGWARs
   MiTV/n4CtVygEpjA8J5zAeQlq82szlgCZREd2SnRV8Qg5Fj18oMdpFDQt
   YO88ovbnBRHXSg15fnVuD1qr5KbM6LLigXn9707D/X+kmEYYicrV4mUAz
   wsn5AVFJnV9wTO1xROhknvWhe1U9CBTIVMsjZxA7NOCl6nuQIa7GuYanB
   8McQtX361YFT+kNPwfyG+Hwrbjf6M7pbd3vPTPxWBrYa3ystR4ETvx0AK
   g==;
X-CSE-ConnectionGUID: X8E1V5HNQ56GBj5103oKqw==
X-CSE-MsgGUID: clZoLOcQS7yb82lIXR3i3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15179788"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15179788"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 22:18:37 -0700
X-CSE-ConnectionGUID: cma18YIoRLGp3kEP+4J/Bw==
X-CSE-MsgGUID: J+4p9eQORlq//E0UE2V0BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40127117"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 12 Jun 2024 22:18:36 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHcr3-0002Fw-1f;
	Thu, 13 Jun 2024 05:18:33 +0000
Date: Thu, 13 Jun 2024 13:17:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:next] BUILD SUCCESS
 3bf9044d466637eaa28b87c4d6491dbfbe1b14ea
Message-ID: <202406131348.hC6GbVFw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
branch HEAD: 3bf9044d466637eaa28b87c4d6491dbfbe1b14ea  Merge branch 'pci/misc'

elapsed time: 1812m

configs tested: 89
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
i386         buildonly-randconfig-001-20240612   gcc-13
i386         buildonly-randconfig-002-20240612   gcc-8
i386         buildonly-randconfig-003-20240612   gcc-13
i386         buildonly-randconfig-004-20240612   clang-18
i386         buildonly-randconfig-005-20240612   gcc-13
i386         buildonly-randconfig-006-20240612   clang-18
i386                  randconfig-001-20240612   gcc-8
i386                  randconfig-002-20240612   clang-18
i386                  randconfig-003-20240612   clang-18
i386                  randconfig-004-20240612   clang-18
i386                  randconfig-005-20240612   gcc-13
i386                  randconfig-006-20240612   clang-18
i386                  randconfig-011-20240612   clang-18
i386                  randconfig-012-20240612   clang-18
i386                  randconfig-013-20240612   clang-18
i386                  randconfig-014-20240612   gcc-7
i386                  randconfig-015-20240612   gcc-13
i386                  randconfig-016-20240612   gcc-7
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240613   gcc-13
x86_64       buildonly-randconfig-002-20240613   gcc-9
x86_64       buildonly-randconfig-003-20240613   clang-18
x86_64       buildonly-randconfig-004-20240613   clang-18
x86_64       buildonly-randconfig-005-20240613   clang-18
x86_64       buildonly-randconfig-006-20240613   clang-18
x86_64                randconfig-001-20240613   gcc-13
x86_64                randconfig-002-20240613   clang-18
x86_64                randconfig-003-20240613   gcc-13
x86_64                randconfig-004-20240613   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

