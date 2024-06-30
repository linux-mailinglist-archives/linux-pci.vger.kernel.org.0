Return-Path: <linux-pci+bounces-9490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2C091D4AE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 00:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3771EB20D59
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3C0482CD;
	Sun, 30 Jun 2024 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIf5ZEeh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426126AC9
	for <linux-pci@vger.kernel.org>; Sun, 30 Jun 2024 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719788286; cv=none; b=hJTopIHUBkGbO8hFyIzVw6fyPlCkH8JiV4xVe+Bx7njazWiWlMfvKyQfKgZYWyq6tZG7BX+eHVDB/SNXNO1PKnvQ9NBfWOBWx0i8dr0KVUEGif+OrJhru7WfaU4CYWta8ZE8D2PbyORFOa9xi+xzYzkmKLLxyfaVkyXXvILlZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719788286; c=relaxed/simple;
	bh=1dkG0zZr/COK1WUGqNqqZPQFwsSEugUIOTTjdJkN4ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ok4EhpwG0vPHNGuaIaAAmCzQdUWWxcXhs1zOIYinmZzN11J79psjTgFsmNDCVM6MQjj4MpP2iswdxuMLlZC54NfRlLq/589DPcKOUF6ooJjCqStNvK2hX2kmv2X4jCajjGOy7mPGQUj/NBTLkMn5jig2rnsSgTD/jEV66z9KFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIf5ZEeh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719788284; x=1751324284;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1dkG0zZr/COK1WUGqNqqZPQFwsSEugUIOTTjdJkN4ZM=;
  b=QIf5ZEehVu2IMsjQ4a1+zvA7Vy4MwjkaiT58zNfvVjSM0fwNlCviQSVH
   n8XJieaXfEbNNA6tOzecSbE+QSEsM9YS0pfi3X/Edwu7bjnacylVnq2qc
   f7GbYRVk/Is/K2VK5qSiPiVNUAnBGghEnN1MOAO8XWTHn1aedz1pjGpTB
   00zxf/fSRs/XE88iJ57vHZwksLA+u4sMGCgtHLG1dPaU0W7thTn+ZvMq3
   9Jb7bNZ1qtmjEZeX1eHEIwWWppMkI1bDz5OAN1FcAV8gPZRTDC7oTev2x
   VCagPNmJJOcN4MQA1H7bOzQaox52xsh9eTOpgM/RmVn67yeoGIgyDAOBH
   g==;
X-CSE-ConnectionGUID: 8xWECutIQ3S2qcuuPbkMWQ==
X-CSE-MsgGUID: IO8XZVXAQy2OQ1rWTDE8HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="42312616"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="42312616"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 15:58:03 -0700
X-CSE-ConnectionGUID: Lrfvq4SQRDSPIdZEVwXAjg==
X-CSE-MsgGUID: zKz8CBJDT6K79tC7XseG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="49637963"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 30 Jun 2024 15:58:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sO3Ue-000M7c-20;
	Sun, 30 Jun 2024 22:58:00 +0000
Date: Mon, 01 Jul 2024 06:57:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/rockchip] BUILD SUCCESS
 aaf84072590465c1427507d874da28e5ce0a3375
Message-ID: <202407010618.6dRAUbfS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
branch HEAD: aaf84072590465c1427507d874da28e5ce0a3375  PCI: dw-rockchip: Depend on PCI_ENDPOINT if building endpoint mode support

elapsed time: 1516m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          exynos_defconfig   gcc-13.2.0
arm                          pxa168_defconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-004-20240630   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240630   clang-18
i386         buildonly-randconfig-006-20240630   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-001-20240630   gcc-13
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-002-20240630   gcc-13
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-004-20240630   gcc-13
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-011-20240630   gcc-13
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-013-20240630   gcc-8
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-014-20240630   gcc-8
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-015-20240630   gcc-10
i386                  randconfig-016-20240630   clang-18
i386                  randconfig-016-20240630   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                          hp300_defconfig   gcc-13.2.0
m68k                       m5275evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                        icon_defconfig   gcc-13.2.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv             nommu_k210_sdcard_defconfig   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240630   gcc-13
x86_64       buildonly-randconfig-002-20240630   gcc-13
x86_64       buildonly-randconfig-003-20240630   gcc-13
x86_64       buildonly-randconfig-004-20240630   gcc-13
x86_64       buildonly-randconfig-005-20240630   gcc-13
x86_64       buildonly-randconfig-006-20240630   gcc-13
x86_64                              defconfig   clang-18
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240630   gcc-13
x86_64                randconfig-002-20240630   gcc-13
x86_64                randconfig-003-20240630   gcc-13
x86_64                randconfig-004-20240630   gcc-13
x86_64                randconfig-005-20240630   gcc-13
x86_64                randconfig-006-20240630   gcc-13
x86_64                randconfig-011-20240630   gcc-13
x86_64                randconfig-012-20240630   gcc-13
x86_64                randconfig-013-20240630   gcc-13
x86_64                randconfig-014-20240630   gcc-13
x86_64                randconfig-015-20240630   gcc-13
x86_64                randconfig-016-20240630   gcc-13
x86_64                randconfig-071-20240630   gcc-13
x86_64                randconfig-072-20240630   gcc-13
x86_64                randconfig-073-20240630   gcc-13
x86_64                randconfig-074-20240630   gcc-13
x86_64                randconfig-075-20240630   gcc-13
x86_64                randconfig-076-20240630   gcc-13
x86_64                          rhel-8.3-func   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

