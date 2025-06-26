Return-Path: <linux-pci+bounces-30684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016A2AE9539
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14431C2643F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 05:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E21991DD;
	Thu, 26 Jun 2025 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JD27l66g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A62EB10
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 05:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916727; cv=none; b=angpW43lEyuH0srufyEtSa1ZdtqHBpF8s+V9Kz2CSm02vEiUmgDiTNH5B8ta7oIRRQuua0aiT71tnRbdBNbToWjgOp3FtZd/RwNSTl7uBftzDZUYezzaw02WdadFtH2YA0akIwFnh4VhjaaGYrTysU89j3OYz2BOuV10QSQM9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916727; c=relaxed/simple;
	bh=L1nbRGDAXb2WNswM+G4aPUx40Lo6Mmg7YCHPwRMz7dY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OkopnHE/HHozP/BuR7A181KEVpiymmzm/lQEtZ2LOAChNm/zUU3arzULgxuBZxGSomWDLiRevkm4gUPODe2gv3LgLv8dNnaOSyMO9COqgfykis8icn4Ux95uxC/xgpMA+umklqUN0AzpflaKL3m+T/NEZNkWyMNapsUIf1JkL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JD27l66g; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750916726; x=1782452726;
  h=date:from:to:cc:subject:message-id;
  bh=L1nbRGDAXb2WNswM+G4aPUx40Lo6Mmg7YCHPwRMz7dY=;
  b=JD27l66gKlAsYkgsrNhsVuiUuhtr1MWdJqBc+927IK2PM/c8VHd8XHqG
   qKPPLVdiJSLo4odaSvUinjTCIhVZz3DO5R4eG4YX/o8f0vGKSIflaOJAm
   Ewhdfk6n2ELlxY7hrVn4TlrXqbthdCuKq790ARi8bpNYf4dVIcsyVwESa
   PrIIBmg5CasPUXpPwV8K1J0OrR5dmKGmnAqXGZCHXCeTkppUIcO4O2h81
   CZf7JOhNdWNdSkqFmfHi+OwIPJvlwyw0maaq8qbYogzNHq65SJjUzjSX0
   shPJCXrP7y5bBa0ujoyWpH1zO2LIXNynMONsTNblSaXRl+WGkoJNkid+P
   Q==;
X-CSE-ConnectionGUID: 5zrFjYsfRWCfiBuOKSWigA==
X-CSE-MsgGUID: Hy1K+Dc7S1G4TcibaVBf1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70632649"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="70632649"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 22:45:25 -0700
X-CSE-ConnectionGUID: +ySSCWQoSn2CY/Ud82aUJg==
X-CSE-MsgGUID: KhIo1hpPRdWEP8zDcYqkDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="153142667"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2025 22:45:24 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUfQH-000TmQ-2S;
	Thu, 26 Jun 2025 05:45:21 +0000
Date: Thu, 26 Jun 2025 13:44:25 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/linkup-fix] BUILD SUCCESS
 470f10f18b482b3d46429c9e6723ff0f7854d049
Message-ID: <202506261314.QMq8LE8u-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/linkup-fix
branch HEAD: 470f10f18b482b3d46429c9e6723ff0f7854d049  PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS

elapsed time: 966m

configs tested: 102
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250625    gcc-11.5.0
arc                   randconfig-001-20250626    clang-20
arc                   randconfig-002-20250625    gcc-12.4.0
arc                   randconfig-002-20250626    clang-20
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                   randconfig-001-20250625    clang-21
arm                   randconfig-001-20250626    clang-20
arm                   randconfig-002-20250625    gcc-11.5.0
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-003-20250625    gcc-13.3.0
arm                   randconfig-003-20250626    clang-20
arm                   randconfig-004-20250625    gcc-15.1.0
arm                   randconfig-004-20250626    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250625    gcc-11.5.0
arm64                 randconfig-001-20250626    clang-20
arm64                 randconfig-002-20250625    clang-20
arm64                 randconfig-002-20250626    clang-20
arm64                 randconfig-003-20250625    gcc-12.3.0
arm64                 randconfig-003-20250626    clang-20
arm64                 randconfig-004-20250625    clang-20
arm64                 randconfig-004-20250626    clang-20
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250625    clang-20
i386        buildonly-randconfig-001-20250626    clang-20
i386        buildonly-randconfig-002-20250625    gcc-12
i386        buildonly-randconfig-002-20250626    clang-20
i386        buildonly-randconfig-003-20250625    gcc-12
i386        buildonly-randconfig-003-20250626    clang-20
i386        buildonly-randconfig-004-20250625    gcc-12
i386        buildonly-randconfig-004-20250626    clang-20
i386        buildonly-randconfig-005-20250625    clang-20
i386        buildonly-randconfig-005-20250626    clang-20
i386        buildonly-randconfig-006-20250625    clang-20
i386        buildonly-randconfig-006-20250626    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

