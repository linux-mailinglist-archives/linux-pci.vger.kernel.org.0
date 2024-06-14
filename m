Return-Path: <linux-pci+bounces-8780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485D9081B3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 04:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0CB1C218F8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 02:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA0CA954;
	Fri, 14 Jun 2024 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIcGLKIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B4D1822FA
	for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332411; cv=none; b=OGdcFOYNAV5Vm9KlsfN1LrZDMuA4ZaYf5r55hR2OdtfSBCSQqXrF3SqVJd/YLjgfq2x1PyLF96i7WUD408koo94ie+E1fxDv5kDZOOC3eXTp00noBUxsw9dYW3ucZmVo2PdceY4dg9rjPz/m5O+eunqHRTWobF5GpFWob19QeJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332411; c=relaxed/simple;
	bh=Vrt/DUnuMrKoNGJCqigcoOhPMI5t3QUYZYVQ/s9FSC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=phL7RC4owownmGIfAlPbK+xUl1N/U71JXRa0iYSI7x53+a+ov5tyS8rFrtRHIhdKz6y9zK3aMZ+5kvisiUfH1EL50/lVS79ow/F4LSVfvUc/+m+GXYftSyS1PSuk3jOYdB002cDB8QWwcOzFKiVQsULyKJYXx1preCY8KQfvQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIcGLKIq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718332410; x=1749868410;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vrt/DUnuMrKoNGJCqigcoOhPMI5t3QUYZYVQ/s9FSC0=;
  b=JIcGLKIqQo+EtbDXbJYa7c6k4wNw27mSX9y39fPgZvoTfqbL1GWIvW0L
   pKWY2YbDCTyTyQYqnpRXJhIYZQowMA5AX6YfJwmXLll4q7lBIkaJyENMQ
   8VIeyAR1pwdRxNDh88YZf24QWZ5uBH+33k9u5e7ZeNTCgesv4zcd5P1uM
   3B54vHwXJ/KwK4R6lbW57wGY/CMdyFqDDCKOZtARUA8OMc1cx7U7lSWHT
   02Yrg8rpYddHC0ca33oohvOocLs8D/vrRhybd5lxEP+BnFVzmLaO6G0jB
   P7K63vFbDwHp95kpuGcFmGdXwhapQq1e5+YibEXfsCDkVpnhLYy/mc3Nv
   A==;
X-CSE-ConnectionGUID: vzOxVNbbS+qTgmyBxZjfyA==
X-CSE-MsgGUID: ADg/qcJPTF6zRtm3gakNXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15432997"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15432997"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 19:33:29 -0700
X-CSE-ConnectionGUID: Z17An+ciQVyVpiv+88YUQg==
X-CSE-MsgGUID: CMnwY0UySsSnoNmK38birg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44782715"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Jun 2024 19:33:28 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHwko-0000hv-0c;
	Fri, 14 Jun 2024 02:33:26 +0000
Date: Fri, 14 Jun 2024 10:32:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD REGRESSION
 1b2ccd0341a6124d964211bae2ec378fafd0c8b2
Message-ID: <202406141054.rqus0osg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 1b2ccd0341a6124d964211bae2ec378fafd0c8b2  PCI: endpoint: Make pci_epc_class struct constant

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- sparc-randconfig-002-20240614
    `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text

elapsed time: 1692m

configs tested: 109
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240614   gcc-13.2.0
arc                   randconfig-002-20240614   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240614   gcc-13.2.0
arm                   randconfig-002-20240614   gcc-13.2.0
arm                   randconfig-003-20240614   gcc-13.2.0
arm                   randconfig-004-20240614   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240614   gcc-13.2.0
arm64                 randconfig-002-20240614   clang-19
arm64                 randconfig-003-20240614   gcc-13.2.0
arm64                 randconfig-004-20240614   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240614   gcc-13.2.0
csky                  randconfig-002-20240614   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240614   clang-19
hexagon               randconfig-002-20240614   clang-19
i386         buildonly-randconfig-001-20240613   gcc-9
i386         buildonly-randconfig-002-20240613   clang-18
i386         buildonly-randconfig-003-20240613   clang-18
i386         buildonly-randconfig-004-20240613   clang-18
i386         buildonly-randconfig-005-20240613   gcc-7
i386         buildonly-randconfig-006-20240613   clang-18
i386                  randconfig-001-20240613   gcc-7
i386                  randconfig-002-20240613   gcc-11
i386                  randconfig-003-20240613   gcc-13
i386                  randconfig-004-20240613   clang-18
i386                  randconfig-005-20240613   gcc-13
i386                  randconfig-006-20240613   gcc-13
i386                  randconfig-011-20240613   gcc-13
i386                  randconfig-012-20240613   clang-18
i386                  randconfig-013-20240613   clang-18
i386                  randconfig-014-20240613   gcc-12
i386                  randconfig-015-20240613   gcc-8
i386                  randconfig-016-20240613   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240614   gcc-13.2.0
loongarch             randconfig-002-20240614   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240614   gcc-13.2.0
nios2                 randconfig-002-20240614   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240614   gcc-13.2.0
parisc                randconfig-002-20240614   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240614   gcc-13.2.0
powerpc               randconfig-002-20240614   clang-19
powerpc               randconfig-003-20240614   gcc-13.2.0
powerpc64             randconfig-001-20240614   clang-19
powerpc64             randconfig-002-20240614   gcc-13.2.0
powerpc64             randconfig-003-20240614   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240614   gcc-13.2.0
riscv                 randconfig-002-20240614   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240614   gcc-13.2.0
s390                  randconfig-002-20240614   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240614   gcc-13.2.0
sh                    randconfig-002-20240614   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240614   gcc-13.2.0
sparc64               randconfig-002-20240614   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240614   gcc-13
um                    randconfig-002-20240614   gcc-13
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240614   clang-18
x86_64       buildonly-randconfig-002-20240614   gcc-8
x86_64       buildonly-randconfig-003-20240614   clang-18
x86_64       buildonly-randconfig-004-20240614   gcc-8
x86_64       buildonly-randconfig-005-20240614   gcc-10
x86_64       buildonly-randconfig-006-20240614   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240614   gcc-13.2.0
xtensa                randconfig-002-20240614   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

