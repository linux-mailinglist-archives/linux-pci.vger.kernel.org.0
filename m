Return-Path: <linux-pci+bounces-1150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050F081803B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 04:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2101285D52
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 03:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A99D46A6;
	Tue, 19 Dec 2023 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="if/aw5eO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40E125A8
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702956778; x=1734492778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BRxDknh1bV8UUuwiP2ip3q+mCNoFUK/yPfLDrkEGLdE=;
  b=if/aw5eOoZSSh50SgaeSBynIq13W0yoJqiQX1/azNFrAnbUJOl9hacFo
   OdbKWxmZFVg8V0Q+Lf0XcEdXHQKcF+9V0tKzk5LPE/mLoMujtKwpksS46
   7bMt1oQ/OXwZeyR4M7rccRFluUurFuNP0lypPg7zp6K/iPQwzwHmTUtZj
   +jkoXawPr8cMO3wEqsqN3SJ6Hc28sTBrzHq0l3HbuE8AFBl87JPk5OlnT
   0HJiEJHLjbqI+AB0+SdnKTu73PJgSQpsGW8GpbeqB2SUgYSGWH7sr2WGu
   vl3uFeK+hT2EK1o0tbJlu2I28INSSpQWmNoItFLO1pwa/0pw1SNOW65bf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394480524"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="394480524"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="804746341"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="804746341"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Dec 2023 19:32:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFQqj-0004os-13;
	Tue, 19 Dec 2023 03:32:53 +0000
Date: Tue, 19 Dec 2023 11:32:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/xilinx] BUILD SUCCESS
 b642e081f46cc95c7f1468cab1ea3c2d5e11fdab
Message-ID: <202312191124.GGl5JZfF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/xilinx
branch HEAD: b642e081f46cc95c7f1468cab1ea3c2d5e11fdab  PCI: xilinx-xdma: Remove redundant dev_err()

elapsed time: 1467m

configs tested: 200
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231218   gcc  
arc                   randconfig-002-20231218   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20231218   gcc  
arm                   randconfig-002-20231218   gcc  
arm                   randconfig-003-20231218   gcc  
arm                   randconfig-004-20231218   gcc  
arm                             rpc_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231218   gcc  
arm64                 randconfig-002-20231218   gcc  
arm64                 randconfig-003-20231218   gcc  
arm64                 randconfig-004-20231218   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231218   gcc  
csky                  randconfig-002-20231218   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231218   gcc  
i386         buildonly-randconfig-002-20231218   gcc  
i386         buildonly-randconfig-003-20231218   gcc  
i386         buildonly-randconfig-004-20231218   gcc  
i386         buildonly-randconfig-005-20231218   gcc  
i386         buildonly-randconfig-006-20231218   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231218   gcc  
i386                  randconfig-002-20231218   gcc  
i386                  randconfig-003-20231218   gcc  
i386                  randconfig-004-20231218   gcc  
i386                  randconfig-005-20231218   gcc  
i386                  randconfig-006-20231218   gcc  
i386                  randconfig-011-20231218   clang
i386                  randconfig-011-20231219   gcc  
i386                  randconfig-012-20231218   clang
i386                  randconfig-012-20231219   gcc  
i386                  randconfig-013-20231218   clang
i386                  randconfig-013-20231219   gcc  
i386                  randconfig-014-20231218   clang
i386                  randconfig-014-20231219   gcc  
i386                  randconfig-015-20231218   clang
i386                  randconfig-015-20231219   gcc  
i386                  randconfig-016-20231218   clang
i386                  randconfig-016-20231219   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231218   gcc  
loongarch             randconfig-002-20231218   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                          rb532_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231218   gcc  
nios2                 randconfig-002-20231218   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231218   gcc  
parisc                randconfig-002-20231218   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231218   gcc  
powerpc               randconfig-002-20231218   gcc  
powerpc               randconfig-003-20231218   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20231218   gcc  
powerpc64             randconfig-002-20231218   gcc  
powerpc64             randconfig-003-20231218   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231218   gcc  
riscv                 randconfig-002-20231218   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20231218   gcc  
sh                    randconfig-002-20231218   gcc  
sh                          rsk7203_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231218   gcc  
sparc64               randconfig-002-20231218   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231218   gcc  
um                    randconfig-002-20231218   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231218   gcc  
x86_64       buildonly-randconfig-001-20231219   clang
x86_64       buildonly-randconfig-002-20231218   gcc  
x86_64       buildonly-randconfig-002-20231219   clang
x86_64       buildonly-randconfig-003-20231218   gcc  
x86_64       buildonly-randconfig-003-20231219   clang
x86_64       buildonly-randconfig-004-20231218   gcc  
x86_64       buildonly-randconfig-004-20231219   clang
x86_64       buildonly-randconfig-005-20231218   gcc  
x86_64       buildonly-randconfig-005-20231219   clang
x86_64       buildonly-randconfig-006-20231218   gcc  
x86_64       buildonly-randconfig-006-20231219   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231218   gcc  
x86_64                randconfig-011-20231219   clang
x86_64                randconfig-012-20231218   gcc  
x86_64                randconfig-012-20231219   clang
x86_64                randconfig-013-20231218   gcc  
x86_64                randconfig-013-20231219   clang
x86_64                randconfig-014-20231218   gcc  
x86_64                randconfig-014-20231219   clang
x86_64                randconfig-015-20231218   gcc  
x86_64                randconfig-015-20231219   clang
x86_64                randconfig-016-20231218   gcc  
x86_64                randconfig-016-20231219   clang
x86_64                randconfig-071-20231218   gcc  
x86_64                randconfig-071-20231219   clang
x86_64                randconfig-072-20231218   gcc  
x86_64                randconfig-072-20231219   clang
x86_64                randconfig-073-20231218   gcc  
x86_64                randconfig-073-20231219   clang
x86_64                randconfig-074-20231218   gcc  
x86_64                randconfig-074-20231219   clang
x86_64                randconfig-075-20231218   gcc  
x86_64                randconfig-075-20231219   clang
x86_64                randconfig-076-20231218   gcc  
x86_64                randconfig-076-20231219   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231218   gcc  
xtensa                randconfig-002-20231218   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

