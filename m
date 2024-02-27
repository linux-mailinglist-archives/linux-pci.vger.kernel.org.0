Return-Path: <linux-pci+bounces-4093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC5868CD7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606852840E4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417456458;
	Tue, 27 Feb 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJaudAhu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E013849E
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028145; cv=none; b=bekRYOWdRmn+7YygaVuLo2jQ512ZRQcsQwAi6yKPOHXSxl2F2TXLMA4QMa4RzPksXYNYuwny2J1/blQMQAPOaX5NqRvZufkTzLVT5dMpg6vJkxoADxs5bAeUspq2IvzIfJ+phHuC5epI8qvj8LH0aQnS0sr7o8kmAnZV3F1BSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028145; c=relaxed/simple;
	bh=YJ5emTLtSNhtr0NO1gtqgQuMmf30v5YYw6L2I5MlAco=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o9Ao7tUQqQGyZgSExjZOR0qU552P1U0c58FJF+5Io2y4Y59dNiOpGOF0QET25hBybtJjyViEi9WpAdEv0cKjrrp4UhVeD49ZqXOn/u3O/glntQ7/nlqKZjQAM3nqZekjbrwZpkXtbJUgni2q254q2xnK8nH0/dzQBqlmh8+nouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJaudAhu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709028143; x=1740564143;
  h=date:from:to:cc:subject:message-id;
  bh=YJ5emTLtSNhtr0NO1gtqgQuMmf30v5YYw6L2I5MlAco=;
  b=AJaudAhu0Be65myF36JEKr5X3TtOGt3r1rvp5Xf2zrTsWGZUHyOEDMPP
   uqfpyF4Fphg8Je1GZHiGfAIzLi9u4+8obfyXOAEjYw829M9DaQxgAa+MD
   She4k1Jvmha9UaJWJiZU2YoeQNECXpsesjoODBa7X6BkHYjOMjqFX/aZ+
   d6sOoR8o5rmav4DRM9TDPdXpm7Ca9WWby1aUT3FKR6ezgOqjR4ta2C981
   n73+YB4Ghm06doWo20XHXLyatrDeg+Y0Ejwkhvc8xvTW/gBAi5+XzPppJ
   6vYMaU2GQPdZb5WI69yT+zvRVwVCEsV1pAhYr8cECXY024GSBDZUxV6Ff
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3477595"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3477595"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:02:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6923659"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2024 02:02:21 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reuHz-000B7X-2S;
	Tue, 27 Feb 2024 10:02:19 +0000
Date: Tue, 27 Feb 2024 18:02:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:wip/2402-bjorn-osc-dpc] BUILD REGRESSION
 f76758eebe9e2f81b37e41d2bdc70825cdb879d7
Message-ID: <202402271808.1Kg5NqNb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2402-bjorn-osc-dpc
branch HEAD: f76758eebe9e2f81b37e41d2bdc70825cdb879d7  PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402271755.7yCmolZa-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/pci/pci-acpi.c:1424:2: error: call to undeclared function 'pci_acpi_add_edr_notifier'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/pci/pci-acpi.c:1451:2: error: call to undeclared function 'pci_acpi_remove_edr_notifier'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-defconfig
|   |-- drivers-pci-pci-acpi.c:error:call-to-undeclared-function-pci_acpi_add_edr_notifier-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-pci-acpi.c:error:call-to-undeclared-function-pci_acpi_remove_edr_notifier-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- x86_64-kexec
    |-- drivers-pci-pci-acpi.c:error:call-to-undeclared-function-pci_acpi_add_edr_notifier-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- drivers-pci-pci-acpi.c:error:call-to-undeclared-function-pci_acpi_remove_edr_notifier-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 945m

configs tested: 171
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240227   gcc  
arc                   randconfig-002-20240227   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240227   gcc  
arm                   randconfig-002-20240227   gcc  
arm                   randconfig-003-20240227   gcc  
arm                   randconfig-004-20240227   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240227   gcc  
arm64                 randconfig-003-20240227   gcc  
arm64                 randconfig-004-20240227   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240227   gcc  
csky                  randconfig-002-20240227   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240227   gcc  
i386         buildonly-randconfig-002-20240227   gcc  
i386         buildonly-randconfig-003-20240227   clang
i386         buildonly-randconfig-004-20240227   gcc  
i386         buildonly-randconfig-005-20240227   gcc  
i386         buildonly-randconfig-006-20240227   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240227   gcc  
i386                  randconfig-002-20240227   gcc  
i386                  randconfig-003-20240227   clang
i386                  randconfig-004-20240227   clang
i386                  randconfig-005-20240227   clang
i386                  randconfig-006-20240227   gcc  
i386                  randconfig-011-20240227   clang
i386                  randconfig-012-20240227   clang
i386                  randconfig-013-20240227   clang
i386                  randconfig-014-20240227   clang
i386                  randconfig-015-20240227   clang
i386                  randconfig-016-20240227   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240227   gcc  
loongarch             randconfig-002-20240227   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240227   gcc  
nios2                 randconfig-002-20240227   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240227   gcc  
parisc                randconfig-002-20240227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc               randconfig-002-20240227   gcc  
powerpc64             randconfig-002-20240227   gcc  
powerpc64             randconfig-003-20240227   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240227   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240227   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240227   gcc  
sh                    randconfig-002-20240227   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240227   gcc  
sparc64               randconfig-002-20240227   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240227   clang
x86_64       buildonly-randconfig-003-20240227   clang
x86_64       buildonly-randconfig-004-20240227   clang
x86_64       buildonly-randconfig-005-20240227   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240227   clang
x86_64                randconfig-002-20240227   clang
x86_64                randconfig-013-20240227   clang
x86_64                randconfig-072-20240227   clang
x86_64                randconfig-074-20240227   clang
x86_64                randconfig-075-20240227   clang
x86_64                randconfig-076-20240227   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240227   gcc  
xtensa                randconfig-002-20240227   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

