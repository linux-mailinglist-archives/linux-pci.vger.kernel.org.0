Return-Path: <linux-pci+bounces-15863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B129BA3EC
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 05:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDDE1C20A60
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 04:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD80D433AB;
	Sun,  3 Nov 2024 04:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaTnz2ue"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0FF50F
	for <linux-pci@vger.kernel.org>; Sun,  3 Nov 2024 04:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730607794; cv=none; b=d/izNrOCkk2pSK3LvlxS6fEnkcdKC209YN5Fn9GY3QXhfQnDJ9eW6xyfrGSTWtHoMD+DaAZi4WEDNhwhBN2U3sJ+kZw44uuX9C5E2bwHblqKTU0ljF1WR7VGKqfL58YFtzFJB7eSCYLwcYb0mKBHEFcgVlnENPej8vL0di1jMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730607794; c=relaxed/simple;
	bh=MIBpsqRGYOt35iddOOE24wyiDIqq8TtCm4Tt77bgz0s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=t76jqKu6OeDRMXIYX1N8K9omxx89zMFjEeiA/pq6Mbmt32/MdPX+zCoLONR5qHEn4KAaFuaQrOWc5tTJEo3ywpOjf91YbeoDoUqYLoZZnvvh/IqMK8s17YkJWG/YykZJg+50HtGhJSmqgbH5zhdg6VvYD4qm2/P5Cu0yy0AjodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaTnz2ue; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730607793; x=1762143793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MIBpsqRGYOt35iddOOE24wyiDIqq8TtCm4Tt77bgz0s=;
  b=kaTnz2ueZg97gs4J9IiB+nMwb8laK/kAV3J1O2Drlb/OnCz21/Hojr4Q
   h63pr1aRcA2EiD5h7+mv2W2+MS56AEATn8nQXwk64Y/+76weLu4JLFnsp
   qGWsFkNVhZLUdaa8uPvwe4ylgyPz4ls+yD40MfZAJjgsw/B6xsdUaTUV1
   Lvms6gteKWaTOvrTomJVwDkmRgyk0af1zIX5a5XeLDtBcX/AAkZyxdZXP
   9OpLpI2i2yGnH7Lpd5u4FiGRTJ6Uj77gMTCUVzByJ+Egp9dEtVskjnuCU
   21kqvJn/meoJxalFK52VS1uRZBTMChaWDVeMHWewRAPwCxnBqIRQF4wtF
   Q==;
X-CSE-ConnectionGUID: 8OKUocK/TNqFyTwAFOfG3Q==
X-CSE-MsgGUID: jVkm2bqlQxyjYpC/pV6Qdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="40904424"
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="40904424"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 21:23:12 -0700
X-CSE-ConnectionGUID: 4EERaNN+QKKVj9QIj8pVNw==
X-CSE-MsgGUID: rihOLbC/TmasZPhtVmakVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="82853674"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Nov 2024 21:23:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7S8r-000jgN-15;
	Sun, 03 Nov 2024 04:23:09 +0000
Date: Sun, 03 Nov 2024 12:22:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aspm] BUILD SUCCESS
 1f37e72d586f280049e7c177bd47d6350cfbd494
Message-ID: <202411031203.obrfz6j7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aspm
branch HEAD: 1f37e72d586f280049e7c177bd47d6350cfbd494  PCI/ASPM: Make pci_save_aspm_l1ss_state save both child and parent's L1SS configuration

elapsed time: 725m

configs tested: 200
configs skipped: 7

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
arc                   randconfig-001-20241103    gcc-14.1.0
arc                   randconfig-002-20241103    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    gcc-14.1.0
arm                         bcm2835_defconfig    gcc-14.1.0
arm                     davinci_all_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                   milbeaut_m10v_defconfig    gcc-14.1.0
arm                        multi_v5_defconfig    gcc-14.1.0
arm                       netwinder_defconfig    gcc-14.1.0
arm                          pxa168_defconfig    gcc-14.1.0
arm                   randconfig-001-20241103    gcc-14.1.0
arm                   randconfig-002-20241103    gcc-14.1.0
arm                   randconfig-003-20241103    gcc-14.1.0
arm                   randconfig-004-20241103    gcc-14.1.0
arm                         s3c6400_defconfig    gcc-14.1.0
arm                        spear6xx_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241103    gcc-14.1.0
arm64                 randconfig-002-20241103    gcc-14.1.0
arm64                 randconfig-003-20241103    gcc-14.1.0
arm64                 randconfig-004-20241103    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241103    gcc-14.1.0
csky                  randconfig-002-20241103    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241103    gcc-14.1.0
hexagon               randconfig-002-20241103    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241103    clang-19
i386        buildonly-randconfig-002-20241103    clang-19
i386        buildonly-randconfig-003-20241103    clang-19
i386        buildonly-randconfig-004-20241103    clang-19
i386        buildonly-randconfig-005-20241103    clang-19
i386        buildonly-randconfig-006-20241103    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241103    clang-19
i386                  randconfig-002-20241103    clang-19
i386                  randconfig-003-20241103    clang-19
i386                  randconfig-004-20241103    clang-19
i386                  randconfig-005-20241103    clang-19
i386                  randconfig-006-20241103    clang-19
i386                  randconfig-011-20241103    clang-19
i386                  randconfig-012-20241103    clang-19
i386                  randconfig-013-20241103    clang-19
i386                  randconfig-014-20241103    clang-19
i386                  randconfig-015-20241103    clang-19
i386                  randconfig-016-20241103    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241103    gcc-14.1.0
loongarch             randconfig-002-20241103    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                       bvme6000_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath25_defconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    gcc-14.1.0
mips                          eyeq5_defconfig    gcc-14.1.0
mips                           gcw0_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241103    gcc-14.1.0
nios2                 randconfig-002-20241103    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
openrisc                       virt_defconfig    gcc-14.1.0
parisc                           alldefconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241103    gcc-14.1.0
parisc                randconfig-002-20241103    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                          g5_defconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    gcc-14.1.0
powerpc                   motionpro_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                      pmac32_defconfig    gcc-14.1.0
powerpc                       ppc64_defconfig    gcc-14.1.0
powerpc                      ppc6xx_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241103    gcc-14.1.0
powerpc               randconfig-002-20241103    gcc-14.1.0
powerpc               randconfig-003-20241103    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc                     tqm8541_defconfig    gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.1.0
powerpc64                        alldefconfig    gcc-14.1.0
powerpc64             randconfig-001-20241103    gcc-14.1.0
powerpc64             randconfig-002-20241103    gcc-14.1.0
powerpc64             randconfig-003-20241103    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241103    gcc-14.1.0
riscv                 randconfig-002-20241103    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241103    gcc-14.1.0
s390                  randconfig-002-20241103    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                    randconfig-001-20241103    gcc-14.1.0
sh                    randconfig-002-20241103    gcc-14.1.0
sh                          rsk7269_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-14.1.0
sh                     sh7710voipgw_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241103    gcc-14.1.0
sparc64               randconfig-002-20241103    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                    randconfig-001-20241103    gcc-14.1.0
um                    randconfig-002-20241103    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241103    clang-19
x86_64      buildonly-randconfig-002-20241103    clang-19
x86_64      buildonly-randconfig-003-20241103    clang-19
x86_64      buildonly-randconfig-004-20241103    clang-19
x86_64      buildonly-randconfig-005-20241103    clang-19
x86_64      buildonly-randconfig-006-20241103    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241103    clang-19
x86_64                randconfig-002-20241103    clang-19
x86_64                randconfig-003-20241103    clang-19
x86_64                randconfig-004-20241103    clang-19
x86_64                randconfig-005-20241103    clang-19
x86_64                randconfig-006-20241103    clang-19
x86_64                randconfig-011-20241103    clang-19
x86_64                randconfig-012-20241103    clang-19
x86_64                randconfig-013-20241103    clang-19
x86_64                randconfig-014-20241103    clang-19
x86_64                randconfig-015-20241103    clang-19
x86_64                randconfig-016-20241103    clang-19
x86_64                randconfig-071-20241103    clang-19
x86_64                randconfig-072-20241103    clang-19
x86_64                randconfig-073-20241103    clang-19
x86_64                randconfig-074-20241103    clang-19
x86_64                randconfig-075-20241103    clang-19
x86_64                randconfig-076-20241103    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241103    gcc-14.1.0
xtensa                randconfig-002-20241103    gcc-14.1.0
xtensa                    smp_lx200_defconfig    gcc-14.1.0
xtensa                    xip_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

