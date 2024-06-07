Return-Path: <linux-pci+bounces-8486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C12900D28
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 22:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F35F1F21361
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 20:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFEB4502C;
	Fri,  7 Jun 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtrqM4LB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351218C3B
	for <linux-pci@vger.kernel.org>; Fri,  7 Jun 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793324; cv=none; b=YyaPtlBjHC5F8iHRyztm3zu8jRf73fc8qF7nbqn8pENiAutmHCZG290HUfwia/dm0DTfapGkDfcDUaxY3OlR/cZT8hxzTVbDfDsE5tPJGbu3ak75tQdx3THUcyc62a5CHR0QwHi+KSJ9S4drBbOyKka/LKUstD1DIB876XhfptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793324; c=relaxed/simple;
	bh=wZybepF4OGmyZbTZ2AsqsSG1LGbUCC+LjvvcDieqCQA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u3K8NaF/LRIYscaX4qpds+PPqtzDs9zgLux7OE4LmghZrtd9q94giPu/pb1kKuJif+aQMMk9l9oc9F8t1Xq2mlzk5pDBKDP87fyFtTDJKGYWsuPy/aoC8Wr38JJeWtF6SkF0Cg1aah/6ckTEF6WvrweDIuixId4NXfSy8GH9OqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtrqM4LB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717793324; x=1749329324;
  h=date:from:to:cc:subject:message-id;
  bh=wZybepF4OGmyZbTZ2AsqsSG1LGbUCC+LjvvcDieqCQA=;
  b=TtrqM4LBXRcS0b6T0mVcO6kTI0V5CrcareX0Pnl1LV0lB6qYtczyIO/W
   E4IFUgIpI7yoZxRwNU6k3PVdt2JVoMy5rGEe0RcTWMw0dfZhn5Wv1v66j
   lmozIMjlxZ20V2FoPxY1u+YrYC4Rimg31TxVGYVsx8NBrIMbWi3Mj6ojO
   5O3xNwdMxYKgsQ20NcAcfwXenB1pmzGRZ8uoQQgF3f1cqj6j4OoiPgWp8
   nsEN2jqbyGj5V+YDTaTZyMHgBtCCx0tyDgY0ahD5y0+1lwpjpHJ0VvdDj
   RARQROB15JSMyHHVqsNwJOqTgcVhFst/8ynVqb2WeUg/LFYALPl76Qkg/
   Q==;
X-CSE-ConnectionGUID: sjYfEjAoT+C914db6YkxcA==
X-CSE-MsgGUID: Oo0jPQvNQyKkAZuzdod3Fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14666919"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14666919"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 13:48:43 -0700
X-CSE-ConnectionGUID: Bg+M9ZGXQ86jfXIG8+t8HQ==
X-CSE-MsgGUID: nnzv0GBtQl2/S1hJP6C9JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38558301"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Jun 2024 13:48:42 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFgVr-0000VR-2g;
	Fri, 07 Jun 2024 20:48:39 +0000
Date: Sat, 08 Jun 2024 04:48:37 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/tegra194] BUILD SUCCESS
 6a6118336270f67174fb8c799c8262bfa88e97e0
Message-ID: <202406080435.QHBSCPst-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/tegra194
branch HEAD: 6a6118336270f67174fb8c799c8262bfa88e97e0  PCI: tegra: Remove unused struct 'tegra_pcie_soc'

elapsed time: 1459m

configs tested: 75
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386         buildonly-randconfig-001-20240608   gcc  
i386         buildonly-randconfig-002-20240608   clang
i386         buildonly-randconfig-003-20240608   gcc  
i386         buildonly-randconfig-004-20240608   gcc  
i386         buildonly-randconfig-005-20240608   clang
i386         buildonly-randconfig-006-20240608   gcc  
i386                  randconfig-001-20240608   clang
i386                  randconfig-002-20240608   gcc  
i386                  randconfig-003-20240608   gcc  
i386                  randconfig-004-20240608   clang
i386                  randconfig-005-20240608   gcc  
i386                  randconfig-006-20240608   gcc  
i386                  randconfig-011-20240608   clang
i386                  randconfig-012-20240608   clang
i386                  randconfig-013-20240608   clang
i386                  randconfig-014-20240608   gcc  
i386                  randconfig-015-20240608   clang
i386                  randconfig-016-20240608   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                                  kexec   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

