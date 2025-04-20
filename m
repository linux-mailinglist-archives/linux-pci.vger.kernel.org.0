Return-Path: <linux-pci+bounces-26308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE2A9484D
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F141884819
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490BA1E4A4;
	Sun, 20 Apr 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkmJ7WK6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413DF367
	for <linux-pci@vger.kernel.org>; Sun, 20 Apr 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745167341; cv=none; b=H7IaNGuZBgeokb3lqE87NGjOkOqv14y4CMEnX5ttSFWfOce5rzCR+EfOfJC1FvRHjHFd34Nyp9WsG//wAouTcaI16pQZYImF9Ys/AnmmIL0sHehPAIK3DBDCbBu7V7ZZQDu55rmupT7Uwed4VLEbj32YT0nnxFanJF0mG8olL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745167341; c=relaxed/simple;
	bh=GAivwIMc800YHFd+69C4Bsaw7p5R4Ss0voB4CJgB5qQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k6Yzo6gh7x6HOlbOPHDti3SiUNWHBA/a2Xd6b/LYsial2fcpGrCAJGc6QCNG86DgL9rcJsgOtNCN0UINPXhPhCaMjvdgvMW6sTRmynrVxRyBYAPQyyNA1OcSzBsJ2EePwp2wvBWyMEFa25K75lc/lDO8SOxVtqyKU8U0iwmOU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkmJ7WK6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745167340; x=1776703340;
  h=date:from:to:cc:subject:message-id;
  bh=GAivwIMc800YHFd+69C4Bsaw7p5R4Ss0voB4CJgB5qQ=;
  b=AkmJ7WK6zKCasbWwcnMderE0j2bdRm/brhGS00zeaH1O1f2B0B5R0AKj
   rnmwkhW6FGdopcfiVBrUpg0KXErK4cXB4fVFWDyii99RhBC/rEq5mDInI
   9ni2Om+5QEI9qDu8k8vBsQe+7e2qFfHYHNi9bsrmJL3xP4bGVoUFJiUUC
   yxeqlkphQLJGnxDCO9uPiEI8S+90UTpeFzHdsVEjpCTpE5UGapDHlI5rt
   ++mdj5k/C9TG1Do10GS470wTyeA/YlGkNnMt16iH+rKba+mEEzyERch0H
   jSOPtxWEPYRVv16xlutbORXLP7TQQ3tvbOZzn0Wl886Rykegmt8AJXRXx
   Q==;
X-CSE-ConnectionGUID: CVYRl+NhTyOFwfk4a/6I9A==
X-CSE-MsgGUID: kfZiN7VfQtepQN8SgbRX1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46844989"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46844989"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 09:42:19 -0700
X-CSE-ConnectionGUID: KD1duSovSO+Su9v2UDvX4A==
X-CSE-MsgGUID: aZpRJvTLQFK2aNSyfieQXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="131460074"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Apr 2025 09:42:17 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6XkF-0004m6-1S;
	Sun, 20 Apr 2025 16:42:15 +0000
Date: Mon, 21 Apr 2025 00:41:30 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/apple] BUILD SUCCESS
 f80bfbf4f11758c9e1817f543cd97e66c449d1b4
Message-ID: <202504210020.TU0e1VHB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/apple
branch HEAD: f80bfbf4f11758c9e1817f543cd97e66c449d1b4  PCI: apple: Add T602x PCIe support

elapsed time: 1447m

configs tested: 248
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250420    gcc-12.4.0
arc                   randconfig-002-20250420    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-21
arm                                 defconfig    clang-21
arm                      footbridge_defconfig    clang-17
arm                        keystone_defconfig    gcc-14.2.0
arm                   randconfig-001-20250420    clang-21
arm                   randconfig-002-20250420    gcc-8.5.0
arm                   randconfig-003-20250420    gcc-7.5.0
arm                   randconfig-004-20250420    gcc-8.5.0
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250420    gcc-8.5.0
arm64                 randconfig-002-20250420    gcc-8.5.0
arm64                 randconfig-003-20250420    clang-21
arm64                 randconfig-004-20250420    gcc-6.5.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250420    gcc-14.2.0
csky                  randconfig-002-20250420    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250420    clang-21
hexagon               randconfig-002-20250420    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250420    clang-20
i386        buildonly-randconfig-002-20250420    clang-20
i386        buildonly-randconfig-003-20250420    clang-20
i386        buildonly-randconfig-004-20250420    clang-20
i386        buildonly-randconfig-005-20250420    clang-20
i386        buildonly-randconfig-006-20250420    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250420    gcc-12
i386                  randconfig-001-20250421    gcc-12
i386                  randconfig-002-20250420    gcc-12
i386                  randconfig-002-20250421    gcc-12
i386                  randconfig-003-20250420    gcc-12
i386                  randconfig-003-20250421    gcc-12
i386                  randconfig-004-20250420    gcc-12
i386                  randconfig-004-20250421    gcc-12
i386                  randconfig-005-20250420    gcc-12
i386                  randconfig-005-20250421    gcc-12
i386                  randconfig-006-20250420    gcc-12
i386                  randconfig-006-20250421    gcc-12
i386                  randconfig-007-20250420    gcc-12
i386                  randconfig-007-20250421    gcc-12
i386                  randconfig-011-20250420    gcc-12
i386                  randconfig-011-20250421    clang-20
i386                  randconfig-012-20250420    gcc-12
i386                  randconfig-012-20250421    clang-20
i386                  randconfig-013-20250420    gcc-12
i386                  randconfig-013-20250421    clang-20
i386                  randconfig-014-20250420    gcc-12
i386                  randconfig-014-20250421    clang-20
i386                  randconfig-015-20250420    gcc-12
i386                  randconfig-015-20250421    clang-20
i386                  randconfig-016-20250420    gcc-12
i386                  randconfig-016-20250421    clang-20
i386                  randconfig-017-20250420    gcc-12
i386                  randconfig-017-20250421    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250420    gcc-12.4.0
loongarch             randconfig-002-20250420    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250420    gcc-14.2.0
nios2                 randconfig-002-20250420    gcc-8.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250420    gcc-13.3.0
parisc                randconfig-002-20250420    gcc-7.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-21
powerpc                   currituck_defconfig    clang-21
powerpc                    gamecube_defconfig    clang-21
powerpc                       holly_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250420    clang-21
powerpc               randconfig-002-20250420    gcc-6.5.0
powerpc               randconfig-003-20250420    clang-21
powerpc                     tqm8541_defconfig    clang-21
powerpc64             randconfig-001-20250420    gcc-8.5.0
powerpc64             randconfig-002-20250420    clang-21
powerpc64             randconfig-003-20250420    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250420    clang-21
riscv                 randconfig-002-20250420    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250420    gcc-6.5.0
s390                  randconfig-002-20250420    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250420    gcc-14.2.0
sh                    randconfig-002-20250420    gcc-14.2.0
sh                           se7206_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250420    gcc-11.5.0
sparc                 randconfig-002-20250420    gcc-7.5.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250420    gcc-9.3.0
sparc64               randconfig-002-20250420    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250420    gcc-12
um                    randconfig-002-20250420    clang-21
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250420    clang-20
x86_64      buildonly-randconfig-002-20250420    gcc-12
x86_64      buildonly-randconfig-003-20250420    gcc-12
x86_64      buildonly-randconfig-004-20250420    gcc-12
x86_64      buildonly-randconfig-005-20250420    clang-20
x86_64      buildonly-randconfig-006-20250420    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250420    gcc-12
x86_64                randconfig-001-20250421    clang-20
x86_64                randconfig-002-20250420    gcc-12
x86_64                randconfig-002-20250421    clang-20
x86_64                randconfig-003-20250420    gcc-12
x86_64                randconfig-003-20250421    clang-20
x86_64                randconfig-004-20250420    gcc-12
x86_64                randconfig-004-20250421    clang-20
x86_64                randconfig-005-20250420    gcc-12
x86_64                randconfig-005-20250421    clang-20
x86_64                randconfig-006-20250420    gcc-12
x86_64                randconfig-006-20250421    clang-20
x86_64                randconfig-007-20250420    gcc-12
x86_64                randconfig-007-20250421    clang-20
x86_64                randconfig-008-20250420    gcc-12
x86_64                randconfig-008-20250421    clang-20
x86_64                randconfig-071-20250420    clang-20
x86_64                randconfig-071-20250421    gcc-12
x86_64                randconfig-072-20250420    clang-20
x86_64                randconfig-072-20250421    gcc-12
x86_64                randconfig-073-20250420    clang-20
x86_64                randconfig-073-20250421    gcc-12
x86_64                randconfig-074-20250420    clang-20
x86_64                randconfig-074-20250421    gcc-12
x86_64                randconfig-075-20250420    clang-20
x86_64                randconfig-075-20250421    gcc-12
x86_64                randconfig-076-20250420    clang-20
x86_64                randconfig-076-20250421    gcc-12
x86_64                randconfig-077-20250420    clang-20
x86_64                randconfig-077-20250421    gcc-12
x86_64                randconfig-078-20250420    clang-20
x86_64                randconfig-078-20250421    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250420    gcc-9.3.0
xtensa                randconfig-002-20250420    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

