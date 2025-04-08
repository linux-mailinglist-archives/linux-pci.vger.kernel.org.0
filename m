Return-Path: <linux-pci+bounces-25513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0349A81626
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 21:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C530E3AB0AA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EB71EB3D;
	Tue,  8 Apr 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDmNTfT7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA922171B
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142282; cv=none; b=ez/TJ9qMsfYxRbBNrYP3t5YLU5V7PJNkAraeQ50v1y5ounzjAkUxPBD6SZWJ22ARToMjAy9cA6kv0vMy3JLbTITdveOp7jpY0VT+favSnho5sNLiB2bTrb3p26MF9Rz+zplcY4F5ZJJpIkUPj9sSrhR0o0EsM0spjSWVSmvi6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142282; c=relaxed/simple;
	bh=ruyPBOsLXpsryhdZPgpQXmEH7Ygr4EtEBZHvjagInzo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gWiQrnFAj++Mr+BZRd69ElzS6zn8aJoXVQnB7tg3Mu3AZOuUBgYPO3520qFOh88s6qDO8BBVzi9gzZPqJu+ld36jwo6bTsleXTRuw1GHboOIfpt7WaqAAQLBpwNozZzmrUxujmgBA7l558YCOr6fPMLUFDngyMdrS0Y6k5PRpYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDmNTfT7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744142281; x=1775678281;
  h=date:from:to:cc:subject:message-id;
  bh=ruyPBOsLXpsryhdZPgpQXmEH7Ygr4EtEBZHvjagInzo=;
  b=BDmNTfT71V/CNFyoyVRyR+Gp8pSKjpOKM7aGAEe2t2g+RB4/XtzvKf2e
   Zd0g5WgxqZE6aE7zMLjZ0wqushCOiZ/2bf1q/fQu7gR5hSHfBlS9eb5pH
   N42CAJyoN7Usrgui5LU/hOzMnamy3D2aixTLOix+kXpPAXwXsndDxe6UM
   BMoVcAwMoOVkdIEQx+mwTpWoqx36UhJiUFOZKSW7Pk8yesAEjEvWZfzMc
   wbUnCpGgYO+9nyb9ggGsM8NCwGPNWi3X2Xw3FzQnwJxl68/F8k3YOWVIN
   lXYWHQYjEIFa/3O4mGzkHa526w9zKJpLAPwg0I2zAZvdOvfTlM0aX+7Mx
   Q==;
X-CSE-ConnectionGUID: cd4w1+EMQ2O40Dk0tHWL9Q==
X-CSE-MsgGUID: LW6VonuhTNWyJtMpVQVDdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="63139670"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="63139670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 12:57:51 -0700
X-CSE-ConnectionGUID: MX/R8LxeQQum0CvDt1jxkQ==
X-CSE-MsgGUID: XcmKFjtYQpCTb3HJFCb8lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="129208553"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Apr 2025 12:57:50 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2F4t-0007wJ-0P;
	Tue, 08 Apr 2025 19:57:47 +0000
Date: Wed, 09 Apr 2025 03:57:38 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 47216638b6e748ed5dc783ead688eef37b021466
Message-ID: <202504090324.TuyDTh0C-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 47216638b6e748ed5dc783ead688eef37b021466  PCI: Run quirk_huawei_pcie_sva() before arm_smmu_probe_device()

elapsed time: 1462m

configs tested: 83
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250408    gcc-14.2.0
arc                   randconfig-002-20250408    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                   randconfig-001-20250408    clang-21
arm                   randconfig-002-20250408    gcc-10.5.0
arm                   randconfig-003-20250408    clang-17
arm                   randconfig-004-20250408    gcc-6.5.0
arm64                 randconfig-001-20250408    clang-21
arm64                 randconfig-002-20250408    gcc-9.5.0
arm64                 randconfig-003-20250408    gcc-9.5.0
arm64                 randconfig-004-20250408    clang-20
csky                  randconfig-001-20250408    gcc-14.2.0
csky                  randconfig-002-20250408    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250408    clang-21
hexagon               randconfig-002-20250408    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250408    clang-20
i386        buildonly-randconfig-002-20250408    clang-20
i386        buildonly-randconfig-003-20250408    gcc-12
i386        buildonly-randconfig-004-20250408    gcc-12
i386        buildonly-randconfig-005-20250408    gcc-12
i386        buildonly-randconfig-006-20250408    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250408    gcc-14.2.0
loongarch             randconfig-002-20250408    gcc-13.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250408    gcc-13.3.0
nios2                 randconfig-002-20250408    gcc-7.5.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250408    gcc-6.5.0
parisc                randconfig-002-20250408    gcc-8.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250408    gcc-5.5.0
powerpc               randconfig-002-20250408    gcc-9.3.0
powerpc               randconfig-003-20250408    gcc-5.5.0
powerpc64             randconfig-001-20250408    clang-21
powerpc64             randconfig-002-20250408    gcc-5.5.0
powerpc64             randconfig-003-20250408    gcc-7.5.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250408    gcc-9.3.0
riscv                 randconfig-002-20250408    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250408    gcc-8.5.0
s390                  randconfig-002-20250408    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250408    gcc-13.3.0
sh                    randconfig-002-20250408    gcc-13.3.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250408    gcc-10.3.0
sparc                 randconfig-002-20250408    gcc-6.5.0
sparc64               randconfig-001-20250408    gcc-6.5.0
sparc64               randconfig-002-20250408    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250408    clang-21
um                    randconfig-002-20250408    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250408    clang-20
x86_64      buildonly-randconfig-002-20250408    clang-20
x86_64      buildonly-randconfig-003-20250408    clang-20
x86_64      buildonly-randconfig-004-20250408    gcc-12
x86_64      buildonly-randconfig-005-20250408    clang-20
x86_64      buildonly-randconfig-006-20250408    clang-20
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250408    gcc-6.5.0
xtensa                randconfig-002-20250408    gcc-6.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

