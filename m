Return-Path: <linux-pci+bounces-9456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9F91CFA1
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 00:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31C61C20BBB
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 22:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA7739FFE;
	Sat, 29 Jun 2024 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT5t1CKQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72238DFC
	for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2024 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719701633; cv=none; b=IaCirtT3HzGx5y2ASfkNIsiR6eiu+sOQQhtA91wj6w/OUMFVO6xxcCU0xgEr/ZVdaunujqmdSEyx2IV1gF9A65x2QpiTjQV8bCs0GhDIsJILiA5GL7ntifLNarb9KsWR9BExPbjhFDDEi0O0sg7SUMnyCvrwHQyCIKrYJsUtCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719701633; c=relaxed/simple;
	bh=2jhGIRQAouYFbbrThurE/uHB8z4yY0KyOvVGWO2Xm8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dP78oRb/wF0WOCojkQmFRCFWavHp6cj3qGP70fubFniikMY5BN8tKvRdfQUk0XpIV/jr7WUqnEojNMBPDjiIleV+GXqo7t3QYzNrWTj6bbnBffX2QjUSptp1HBP3lOpDv6xmymVWtwNpvKSdmY6jE+BZbRewYRYafRuH8Q62rZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HT5t1CKQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719701632; x=1751237632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2jhGIRQAouYFbbrThurE/uHB8z4yY0KyOvVGWO2Xm8c=;
  b=HT5t1CKQ+Arcg3/5HDZJnxkIjYQPTLSMzECkiEtdAg16N2TFcy1oquBZ
   /nzkopGmI3GxgZoUSBh9bvQS8THM0YwA7M4nhfhIB+fvuwCzUy5v7eXY3
   FuYQQcoe+A9PvlQ6xio45XPGlYA0MnwFBgfu9Pm5bivDd2g9UpLr0qxaI
   EdZpXA0KtCebgoma+p4gyjpQ1N1JuD95nI6z92ZEzcBQhaxJs7qCVBhkN
   2Bs6amNpAWfx3KmrK/ups3UI298Z38OqUEyvZJQnGwUE0WAFYVutU4GU4
   xa+SVfzLezffBRSzEDBl1LjTKXxRRcT9coOa0ssszy5HI+bMNW+TSUyrX
   A==;
X-CSE-ConnectionGUID: vKH13ffzTJqG2rM4Wcr8xg==
X-CSE-MsgGUID: EA7MJoi5QPm9NceBGX9kNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="17076357"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="17076357"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 15:53:51 -0700
X-CSE-ConnectionGUID: t9+FZodOQhiOcHlKuXm47g==
X-CSE-MsgGUID: fMKaYf1ATL+8kZG2uhMChA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="45093821"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Jun 2024 15:53:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNgx1-000KNy-1R;
	Sat, 29 Jun 2024 22:53:47 +0000
Date: Sun, 30 Jun 2024 06:53:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/qcom] BUILD SUCCESS
 78b5f6f8855e86520b805b285a642aa8727e8490
Message-ID: <202406300642.9FIbFFNI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
branch HEAD: 78b5f6f8855e86520b805b285a642aa8727e8490  PCI: qcom: Add OPP support to scale performance

elapsed time: 1529m

configs tested: 229
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240629   gcc-13.2.0
arc                   randconfig-002-20240629   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                       aspeed_g4_defconfig   clang-19
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                       imx_v6_v7_defconfig   gcc-13.2.0
arm                        mvebu_v5_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                             pxa_defconfig   clang-19
arm                   randconfig-001-20240629   gcc-13.2.0
arm                   randconfig-002-20240629   gcc-13.2.0
arm                   randconfig-003-20240629   gcc-13.2.0
arm                   randconfig-004-20240629   gcc-13.2.0
arm                         s3c6400_defconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240629   gcc-13.2.0
arm64                 randconfig-002-20240629   gcc-13.2.0
arm64                 randconfig-003-20240629   gcc-13.2.0
arm64                 randconfig-004-20240629   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240629   gcc-13.2.0
csky                  randconfig-002-20240629   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240629   gcc-7
i386         buildonly-randconfig-006-20240630   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-016-20240629   gcc-7
i386                  randconfig-016-20240630   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240629   gcc-13.2.0
loongarch             randconfig-002-20240629   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                         apollo_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                           ci20_defconfig   gcc-13.2.0
mips                     decstation_defconfig   clang-19
mips                           ip32_defconfig   clang-19
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240629   gcc-13.2.0
nios2                 randconfig-002-20240629   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240629   gcc-13.2.0
parisc                randconfig-002-20240629   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                     akebono_defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                       holly_defconfig   gcc-13.2.0
powerpc                        icon_defconfig   clang-19
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                     mpc512x_defconfig   clang-19
powerpc                 mpc836x_rdk_defconfig   clang-19
powerpc                     mpc83xx_defconfig   clang-19
powerpc                      pcm030_defconfig   clang-19
powerpc                      pmac32_defconfig   clang-19
powerpc               randconfig-001-20240629   gcc-13.2.0
powerpc               randconfig-002-20240629   gcc-13.2.0
powerpc               randconfig-003-20240629   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc                         wii_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240629   gcc-13.2.0
powerpc64             randconfig-002-20240629   gcc-13.2.0
powerpc64             randconfig-003-20240629   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240629   gcc-13.2.0
riscv                 randconfig-002-20240629   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240629   gcc-13.2.0
s390                  randconfig-002-20240629   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                         apsh4a3a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                    randconfig-001-20240629   gcc-13.2.0
sh                    randconfig-002-20240629   gcc-13.2.0
sh                          rsk7203_defconfig   gcc-13.2.0
sh                   rts7751r2dplus_defconfig   gcc-13.2.0
sh                           se7343_defconfig   gcc-13.2.0
sh                           se7722_defconfig   gcc-13.2.0
sh                           se7724_defconfig   gcc-13.2.0
sh                           se7780_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240629   gcc-13.2.0
sparc64               randconfig-002-20240629   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240629   gcc-13.2.0
um                    randconfig-002-20240629   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240629   clang-18
x86_64       buildonly-randconfig-001-20240630   gcc-13
x86_64       buildonly-randconfig-002-20240629   clang-18
x86_64       buildonly-randconfig-002-20240630   gcc-13
x86_64       buildonly-randconfig-003-20240629   clang-18
x86_64       buildonly-randconfig-003-20240630   gcc-13
x86_64       buildonly-randconfig-004-20240629   clang-18
x86_64       buildonly-randconfig-004-20240630   gcc-13
x86_64       buildonly-randconfig-005-20240629   clang-18
x86_64       buildonly-randconfig-005-20240630   gcc-13
x86_64       buildonly-randconfig-006-20240629   clang-18
x86_64       buildonly-randconfig-006-20240630   gcc-13
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240629   clang-18
x86_64                randconfig-001-20240630   gcc-13
x86_64                randconfig-002-20240629   clang-18
x86_64                randconfig-002-20240630   gcc-13
x86_64                randconfig-003-20240629   clang-18
x86_64                randconfig-003-20240630   gcc-13
x86_64                randconfig-004-20240629   clang-18
x86_64                randconfig-004-20240630   gcc-13
x86_64                randconfig-005-20240629   clang-18
x86_64                randconfig-005-20240630   gcc-13
x86_64                randconfig-006-20240629   clang-18
x86_64                randconfig-006-20240630   gcc-13
x86_64                randconfig-011-20240629   clang-18
x86_64                randconfig-011-20240630   gcc-13
x86_64                randconfig-012-20240629   clang-18
x86_64                randconfig-012-20240630   gcc-13
x86_64                randconfig-013-20240629   clang-18
x86_64                randconfig-013-20240630   gcc-13
x86_64                randconfig-014-20240629   clang-18
x86_64                randconfig-014-20240630   gcc-13
x86_64                randconfig-015-20240629   clang-18
x86_64                randconfig-015-20240630   gcc-13
x86_64                randconfig-016-20240629   clang-18
x86_64                randconfig-016-20240630   gcc-13
x86_64                randconfig-071-20240629   clang-18
x86_64                randconfig-071-20240630   gcc-13
x86_64                randconfig-072-20240629   clang-18
x86_64                randconfig-072-20240630   gcc-13
x86_64                randconfig-073-20240629   clang-18
x86_64                randconfig-073-20240630   gcc-13
x86_64                randconfig-074-20240629   clang-18
x86_64                randconfig-074-20240630   gcc-13
x86_64                randconfig-075-20240629   clang-18
x86_64                randconfig-075-20240630   gcc-13
x86_64                randconfig-076-20240629   clang-18
x86_64                randconfig-076-20240630   gcc-13
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240629   gcc-13.2.0
xtensa                randconfig-002-20240629   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

