Return-Path: <linux-pci+bounces-3959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DCD8622A5
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 05:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA831C219AB
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 04:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE78C125AB;
	Sat, 24 Feb 2024 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEQ9Vpqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04D125A6
	for <linux-pci@vger.kernel.org>; Sat, 24 Feb 2024 04:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708750492; cv=none; b=kIXnTkca6aoTuRKaC7ZlnMezbSqYDE9qFnLzyGh0KpNuCO5zMgsJANF0tdTDzAyaMb7JpstaA7Iupz7WlnuYC2pJ/cbvkHCm69x0XudxyMS9K+nTVU+QlfTTF37O0rG5r1qHYubvttw6+SKRxhLHm4/qTKBkbNJyNhDRRlgZvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708750492; c=relaxed/simple;
	bh=Sp02WrCWYDgURtJ39TCUDZ+TzerE71gSnFGRxa3+L7U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=t+nvlN90g16EXVz57/U34mcfSk0GvtK9T/Me0buuU0IrC8Pehp0DWvEFIXrCMxs6vvSJQ3eVi7/2HmxaoiolciwgpO+ukVavAswX9zGjvBx2ilj8A86Q2ucwyMcjGX+VbWv0PqeaBh2eNoydlwKchZC+TlQ5hdZ1ZVCbHv+mbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEQ9Vpqw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708750490; x=1740286490;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Sp02WrCWYDgURtJ39TCUDZ+TzerE71gSnFGRxa3+L7U=;
  b=SEQ9VpqwKk4LesMkyr4UUVMqg55KYgqEr74v/46ycMQJCwxb2NPDtOK2
   b2YQKKJzLzkErz3MKO6z70CsOeHBVLymLJLv/whvMIsW+npfsyxiju9hM
   febv23yrJxu3YgZnXYQL7suLWl8REl7eF4o4rw5gjAnk9ZPexgCIjHhAT
   qEEkWUi1Wfczp6ofpJP0pDitZCVnHJYUrxj5+BlKmko6DD2MEkiuwdZCG
   GsT5HPtI9XF56TtM4S9o7Q+Zr8FMlCdo65nu8FlOpAsg2Ui56cRtZaxNM
   JjBu7erFcMMFnsi5Z7UcCI1ZNw4cj2onDPj4rZrJNgYnFbXEPNpz6SL+E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14222296"
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="14222296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 20:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,181,1705392000"; 
   d="scan'208";a="43576880"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 23 Feb 2024 20:54:48 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdk3i-0008Dg-0I;
	Sat, 24 Feb 2024 04:54:46 +0000
Date: Sat, 24 Feb 2024 12:54:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:qcom] BUILD SUCCESS
 544e8f96efc08134454e8513667f59be1f2e3c57
Message-ID: <202402241242.HV4Bi4oT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git qcom
branch HEAD: 544e8f96efc08134454e8513667f59be1f2e3c57  dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p to dedicated schema

elapsed time: 1030m

configs tested: 164
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
arc                   randconfig-001-20240224   gcc  
arc                   randconfig-002-20240224   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                   randconfig-001-20240224   gcc  
arm                   randconfig-002-20240224   gcc  
arm                   randconfig-003-20240224   gcc  
arm                   randconfig-004-20240224   gcc  
arm                          sp7021_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240224   gcc  
arm64                 randconfig-002-20240224   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240224   gcc  
csky                  randconfig-002-20240224   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240224   clang
i386         buildonly-randconfig-005-20240224   clang
i386         buildonly-randconfig-006-20240224   clang
i386                                defconfig   clang
i386                  randconfig-002-20240224   clang
i386                  randconfig-003-20240224   clang
i386                  randconfig-013-20240224   clang
i386                  randconfig-014-20240224   clang
i386                  randconfig-015-20240224   clang
i386                  randconfig-016-20240224   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240224   gcc  
loongarch             randconfig-002-20240224   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           ip28_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240224   gcc  
nios2                 randconfig-002-20240224   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240224   gcc  
parisc                randconfig-002-20240224   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ksi8560_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc64             randconfig-001-20240224   gcc  
powerpc64             randconfig-003-20240224   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240224   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240224   gcc  
s390                  randconfig-002-20240224   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240224   gcc  
sh                    randconfig-002-20240224   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240224   gcc  
sparc64               randconfig-002-20240224   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240224   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240224   clang
x86_64       buildonly-randconfig-002-20240224   clang
x86_64       buildonly-randconfig-003-20240224   clang
x86_64       buildonly-randconfig-004-20240224   clang
x86_64       buildonly-randconfig-005-20240224   clang
x86_64       buildonly-randconfig-006-20240224   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240224   clang
x86_64                randconfig-003-20240224   clang
x86_64                randconfig-006-20240224   clang
x86_64                randconfig-014-20240224   clang
x86_64                randconfig-015-20240224   clang
x86_64                randconfig-016-20240224   clang
x86_64                randconfig-072-20240224   clang
x86_64                randconfig-073-20240224   clang
x86_64                randconfig-076-20240224   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240224   gcc  
xtensa                randconfig-002-20240224   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

