Return-Path: <linux-pci+bounces-37547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE411BB7639
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 17:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E084A2731
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791B23875D;
	Fri,  3 Oct 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/1PkIzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4C2857C6
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506571; cv=none; b=AECibZ6h9xHf0cI/GEDpWneRsn/G2m5pBmuRnnVcGZEA+hW05Jet7zMQ2zNUCC+nmwhnDGMOdsXwlg9dgib9x0nnAP4vZa/BkrB/ZFolaoGzbnjFgCIpyTibIH3WINOhmnYgMKu5/YuLPIbptvPGNnCQTdfo5Z8rMWSUJHPPSRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506571; c=relaxed/simple;
	bh=YVRbYjlXif6gQT+y+d34fts9L/WA3Ks5Ixg1ytg4hJw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K+2JiVl/mbfNJIYvAOl8J1om4K7tIU7VdCVBUQQbsemZxl98SWGMUoS1lLOEOEqq1nQiR+7HWWitpGssNKTk5xiCFLcZhlz+M9lf/E9NdSCDZqpDj5UZ+83vrzuoJfXsiQMQ4PfqflSjXLoDF1Hr7Qf9o6z7rD9Q9Ln+aR8zd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/1PkIzO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759506569; x=1791042569;
  h=date:from:to:cc:subject:message-id;
  bh=YVRbYjlXif6gQT+y+d34fts9L/WA3Ks5Ixg1ytg4hJw=;
  b=a/1PkIzO1xJqfDuEcmbsUR3ME5R0lkHN3sohBgujtx+dedoqlOa6v7fd
   6JuBoJnWWSYr7uebpSlY7swW1KxmXWQrDNTFk8E6m3vAVpDEg+2YO5zwK
   ep7/V1bUGazb9sSFdZQhmhI55PRygO4OGNOwf/8x/tuSKp7MfYxLvk0J7
   4+3NwcJ2pfENsGShLFTewasAGjiYPM/pjej4AuvzP/uODuRwVz1TERBtz
   Dw/4xx/k/k/gZxXjk8BZRRnZ+jkEoAyY1Q2QP5d7N2gC6TvmxQqHnAagf
   +7sDF7l9DJaL/570S5R/j4eL3i36S1zQ8lRfZZFV6DVMrS4wRXu5c1qqT
   A==;
X-CSE-ConnectionGUID: uyD5pY6sQBaHVjjvQYrzCw==
X-CSE-MsgGUID: TDJwRF/qSuCMx/ZyfvtHTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61954571"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="61954571"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 08:49:29 -0700
X-CSE-ConnectionGUID: OmjfxDkrTPu/wmGS33vlrw==
X-CSE-MsgGUID: e+2HnSG7Qz2lM0vx7BGDsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="184507670"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 03 Oct 2025 08:49:28 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4i29-0004dP-0i;
	Fri, 03 Oct 2025 15:49:25 +0000
Date: Fri, 03 Oct 2025 23:49:00 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/keystone] BUILD SUCCESS
 e51d05f523e43ce5d2bad957943a2b14f68078cd
Message-ID: <202510032351.FuKR8g6J-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/keystone
branch HEAD: e51d05f523e43ce5d2bad957943a2b14f68078cd  PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on exit

elapsed time: 1458m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251003    gcc-11.5.0
arc                   randconfig-002-20251003    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251003    gcc-12.5.0
arm                   randconfig-002-20251003    clang-22
arm                   randconfig-003-20251003    gcc-13.4.0
arm                   randconfig-004-20251003    gcc-13.4.0
arm                        spear6xx_defconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251003    gcc-13.4.0
arm64                 randconfig-002-20251003    clang-22
arm64                 randconfig-003-20251003    gcc-10.5.0
arm64                 randconfig-004-20251003    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251003    gcc-15.1.0
csky                  randconfig-002-20251003    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251003    clang-22
hexagon               randconfig-002-20251003    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251002    clang-20
i386        buildonly-randconfig-002-20251002    gcc-14
i386        buildonly-randconfig-003-20251002    clang-20
i386        buildonly-randconfig-004-20251002    clang-20
i386        buildonly-randconfig-005-20251002    gcc-14
i386        buildonly-randconfig-006-20251002    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251003    gcc-15.1.0
loongarch             randconfig-002-20251003    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251003    gcc-8.5.0
nios2                 randconfig-002-20251003    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251003    gcc-9.5.0
parisc                randconfig-002-20251003    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251003    clang-22
powerpc               randconfig-002-20251003    gcc-8.5.0
powerpc               randconfig-003-20251003    clang-22
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20251003    gcc-12.5.0
powerpc64             randconfig-002-20251003    gcc-10.5.0
powerpc64             randconfig-003-20251003    clang-18
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251002    clang-22
riscv                 randconfig-002-20251002    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251002    gcc-14.3.0
s390                  randconfig-002-20251002    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251002    gcc-13.4.0
sh                    randconfig-002-20251002    gcc-15.1.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251002    gcc-8.5.0
sparc                 randconfig-002-20251002    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251002    clang-22
sparc64               randconfig-002-20251002    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251002    clang-22
um                    randconfig-002-20251002    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251002    gcc-13
x86_64      buildonly-randconfig-002-20251002    clang-20
x86_64      buildonly-randconfig-003-20251002    clang-20
x86_64      buildonly-randconfig-004-20251002    clang-20
x86_64      buildonly-randconfig-005-20251002    gcc-14
x86_64      buildonly-randconfig-006-20251002    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251002    gcc-8.5.0
xtensa                randconfig-002-20251002    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

