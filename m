Return-Path: <linux-pci+bounces-14910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC499A5070
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 21:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14077284A18
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8C156243;
	Sat, 19 Oct 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loM5DvB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0BA59
	for <linux-pci@vger.kernel.org>; Sat, 19 Oct 2024 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729365598; cv=none; b=tSTnXvYdDBugdtEr+Kbl7T2o2r5eyjSXjBcwpxlS0y/zEybXMD3qT5dTBw0AbfIfcSluKWuer0Et7u1SGfPKuDF/ioCPONeno7nsJNk4F12fRkpeq8wt2hSbOlZPNlIbOqR1Wjx5pdIRbWEUZH2rN7y0aFFqMWWWZZ3sEZxtb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729365598; c=relaxed/simple;
	bh=1nY3K7yDkufrCixV2BLmwLZm4Q+PFdDEqdgH+7UPaI4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SbkkGAyddYJL2VLs6CxbhLQy9rh6FkxIxXRe3r64WtKEtKHDlfOpHsENfbnte2pByGi5KloLoBcmCpJOyF/4NGfXdyEaarewbY7Bbs9zVJKzyEf5BWYAR9VAkrVMi2BsnCVUT2fBQmgQeFUqA7O/yc53ildRlhiVwBzQQvkVK/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loM5DvB0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729365597; x=1760901597;
  h=date:from:to:cc:subject:message-id;
  bh=1nY3K7yDkufrCixV2BLmwLZm4Q+PFdDEqdgH+7UPaI4=;
  b=loM5DvB01RKXmeyAcwEG1Xe/jn5HWLJVgYgbbYlRDHhUYTHSUuieE45l
   9IfGFdZHWAiPmYwrZXUdcC389duq6fNWJpega2dq2e4XBWgqB/T27saJF
   S5EZQBWXpScO3gfafM0V4f7D7nKK7kaAM3lo/1BAB+kVGBreINZrwmZ+c
   HYFZSzCK6snpdkyklKihGvIASdNY+8CM5bKZLF8B518xWjVldpKgrIusY
   ZXxoQhgEia9d7i+Smw4BpkKf89ayxFjeV/K/Of6mQtCEce1qkPDGK0ywm
   sa09jFise3oKtwitQ7MhffTxrXv8nW+XegIK+VKy6ta30mmSxX572at+M
   g==;
X-CSE-ConnectionGUID: X8q+MrYBTj2t1xMObmKWPg==
X-CSE-MsgGUID: 88sMwTMERGCWtI4tOWo1sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="28759264"
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="28759264"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 12:19:56 -0700
X-CSE-ConnectionGUID: PK9dcB4LTpW5zGftb596VQ==
X-CSE-MsgGUID: oFJvvi10RvOSpViOoWwdSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83975727"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Oct 2024 12:19:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2EzQ-000PSP-1b;
	Sat, 19 Oct 2024 19:19:52 +0000
Date: Sun, 20 Oct 2024 03:19:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:enumeration] BUILD SUCCESS
 32ec7b362d904c1e67f8e64524fb0b6c43d5c9c2
Message-ID: <202410200307.EwAByQoA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
branch HEAD: 32ec7b362d904c1e67f8e64524fb0b6c43d5c9c2  PCI: Simplify pci_read_bridge_bases() logic

elapsed time: 1467m

configs tested: 105
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                        vdk_hs38_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                         nhk8815_defconfig    clang-20
arm                       omap2plus_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241019    clang-18
i386        buildonly-randconfig-002-20241019    clang-18
i386        buildonly-randconfig-003-20241019    clang-18
i386        buildonly-randconfig-004-20241019    clang-18
i386        buildonly-randconfig-005-20241019    clang-18
i386        buildonly-randconfig-006-20241019    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241019    clang-18
i386                  randconfig-002-20241019    clang-18
i386                  randconfig-003-20241019    clang-18
i386                  randconfig-004-20241019    clang-18
i386                  randconfig-005-20241019    clang-18
i386                  randconfig-006-20241019    clang-18
i386                  randconfig-011-20241019    clang-18
i386                  randconfig-012-20241019    clang-18
i386                  randconfig-013-20241019    clang-18
i386                  randconfig-014-20241019    clang-18
i386                  randconfig-015-20241019    clang-18
i386                  randconfig-016-20241019    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    clang-20
m68k                          sun3x_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq5_defconfig    clang-20
mips                         rt305x_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-20
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                   currituck_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-20
powerpc                     tqm8541_defconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                      rts7751r2d1_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

