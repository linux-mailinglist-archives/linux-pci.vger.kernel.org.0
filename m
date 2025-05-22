Return-Path: <linux-pci+bounces-28275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F89EAC10AE
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082D816620A
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AB728DB74;
	Thu, 22 May 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hy9ELgnG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0B80B
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929906; cv=none; b=BzQQwBS4OcX3ko3yuI66jJnESaomCAjkabFrWbU0KCZikhMxxHFiiH4WWYKrkjrnipIZX5u9CD2pTHM6wZ7RpAvYVa6mvpFAppbvf4V9WYLMF8Kxa1xYqq9lU6k93fL1ZxExi6F2ndfkFP/kEo+eJgEKMJLbXCIwhR1+xAdaSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929906; c=relaxed/simple;
	bh=dRP1zXb22N7FIEO9FeYvP9wRV2BHFVIFGsebGdSMP/I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mlx7ULXeB7GsJGS/F49A6u2inFNm3K35PIQ9oBgnw9MFtk1bbde8FtjR/OXkqLH6XFuTUpVWpzCDWp+9lKcjc+Y9RaZV1pLPEBLuNEypejlGXXkAgao1OcEk1wvocif44IkG8Z+rszzPLmFOaohY3/SD/IxkgXX3rcdbhGe3PE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hy9ELgnG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747929905; x=1779465905;
  h=date:from:to:cc:subject:message-id;
  bh=dRP1zXb22N7FIEO9FeYvP9wRV2BHFVIFGsebGdSMP/I=;
  b=hy9ELgnGT7USsUU3JinWjhOya+UsMYDRBkTp9oNK5qqQTBBRrieb4guZ
   ELxOI4wWdoJ23MAYZwkzogcQSs2b/E9+h6msP9abwsPyNQ+dfJEgJ6RGu
   OYSmBz/0X614y0naMKJblMCuN4tCU3UIkksqBlyZTuCBsOCkzQX+YMDEO
   32gcNgwiZdF1vQdzaZBx+RmIwcymxbAu+ulD6bR8pI47YiKuZg1EBqU5E
   /OpdV+tGee+it2ywztbFS1OFmhgXKhImGo/hZiPivEyjscHJcpSDhb+i8
   okkynJsZp3Lyu3z6QeHr4uQ/wMZrX3jfaFJ/SeMH1Dm3DhCEalT4Mpbn1
   A==;
X-CSE-ConnectionGUID: r2nsn2n4SSqW2hUz8T8coQ==
X-CSE-MsgGUID: PaMJsJb0SOqYLRAVqL03tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53760161"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="53760161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 09:05:04 -0700
X-CSE-ConnectionGUID: W8oOvGZsQtGsBSTidOYY8Q==
X-CSE-MsgGUID: 5/wljAeDRbWog0IFdDefFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145825543"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 May 2025 09:05:03 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI8Pj-000PUW-2o;
	Thu, 22 May 2025 16:04:59 +0000
Date: Fri, 23 May 2025 00:04:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD SUCCESS
 d41e0decb7d7d98bc41b16fb2dd3174fe034364e
Message-ID: <202505230005.qW733Mwv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: d41e0decb7d7d98bc41b16fb2dd3174fe034364e  PCI/AER: Add sysfs attributes for log ratelimits

elapsed time: 947m

configs tested: 220
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250522    clang-21
arc                   randconfig-001-20250522    gcc-15.1.0
arc                   randconfig-002-20250522    clang-21
arc                   randconfig-002-20250522    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                         bcm2835_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          moxart_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                            mps2_defconfig    gcc-14.2.0
arm                   randconfig-001-20250522    clang-21
arm                   randconfig-002-20250522    clang-21
arm                   randconfig-003-20250522    clang-18
arm                   randconfig-003-20250522    clang-21
arm                   randconfig-004-20250522    clang-21
arm                   randconfig-004-20250522    gcc-7.5.0
arm                         socfpga_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250522    clang-21
arm64                 randconfig-002-20250522    clang-21
arm64                 randconfig-002-20250522    gcc-7.5.0
arm64                 randconfig-003-20250522    clang-21
arm64                 randconfig-004-20250522    clang-21
arm64                 randconfig-004-20250522    gcc-5.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250522    gcc-15.1.0
csky                  randconfig-001-20250522    gcc-9.3.0
csky                  randconfig-002-20250522    gcc-15.1.0
csky                  randconfig-002-20250522    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250522    clang-17
hexagon               randconfig-001-20250522    gcc-9.3.0
hexagon               randconfig-002-20250522    clang-21
hexagon               randconfig-002-20250522    gcc-9.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250522    clang-20
i386        buildonly-randconfig-001-20250522    gcc-12
i386        buildonly-randconfig-002-20250522    gcc-12
i386        buildonly-randconfig-003-20250522    gcc-12
i386        buildonly-randconfig-004-20250522    gcc-12
i386        buildonly-randconfig-005-20250522    gcc-12
i386        buildonly-randconfig-006-20250522    clang-20
i386        buildonly-randconfig-006-20250522    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250522    clang-20
i386                  randconfig-002-20250522    clang-20
i386                  randconfig-003-20250522    clang-20
i386                  randconfig-004-20250522    clang-20
i386                  randconfig-005-20250522    clang-20
i386                  randconfig-006-20250522    clang-20
i386                  randconfig-007-20250522    clang-20
i386                  randconfig-011-20250522    gcc-12
i386                  randconfig-012-20250522    gcc-12
i386                  randconfig-013-20250522    gcc-12
i386                  randconfig-014-20250522    gcc-12
i386                  randconfig-015-20250522    gcc-12
i386                  randconfig-016-20250522    gcc-12
i386                  randconfig-017-20250522    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250522    gcc-15.1.0
loongarch             randconfig-001-20250522    gcc-9.3.0
loongarch             randconfig-002-20250522    gcc-15.1.0
loongarch             randconfig-002-20250522    gcc-9.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
mips                         rt305x_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250522    gcc-9.3.0
nios2                 randconfig-002-20250522    gcc-9.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250522    gcc-6.5.0
parisc                randconfig-001-20250522    gcc-9.3.0
parisc                randconfig-002-20250522    gcc-12.4.0
parisc                randconfig-002-20250522    gcc-9.3.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 canyonlands_defconfig    clang-21
powerpc                        fsp2_defconfig    clang-21
powerpc                      ppc64e_defconfig    clang-21
powerpc               randconfig-001-20250522    gcc-9.3.0
powerpc               randconfig-002-20250522    clang-21
powerpc               randconfig-002-20250522    gcc-9.3.0
powerpc               randconfig-003-20250522    gcc-7.5.0
powerpc               randconfig-003-20250522    gcc-9.3.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250522    clang-21
powerpc64             randconfig-001-20250522    gcc-9.3.0
powerpc64             randconfig-002-20250522    gcc-10.5.0
powerpc64             randconfig-002-20250522    gcc-9.3.0
powerpc64             randconfig-003-20250522    gcc-7.5.0
powerpc64             randconfig-003-20250522    gcc-9.3.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250522    gcc-10.5.0
riscv                 randconfig-001-20250522    gcc-9.3.0
riscv                 randconfig-002-20250522    clang-18
riscv                 randconfig-002-20250522    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250522    clang-19
s390                  randconfig-001-20250522    gcc-10.5.0
s390                  randconfig-002-20250522    clang-18
s390                  randconfig-002-20250522    gcc-10.5.0
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250522    gcc-10.5.0
sh                    randconfig-001-20250522    gcc-13.3.0
sh                    randconfig-002-20250522    gcc-10.5.0
sh                    randconfig-002-20250522    gcc-13.3.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250522    gcc-10.5.0
sparc                 randconfig-001-20250522    gcc-14.2.0
sparc                 randconfig-002-20250522    gcc-10.5.0
sparc                 randconfig-002-20250522    gcc-6.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250522    gcc-10.5.0
sparc64               randconfig-001-20250522    gcc-14.2.0
sparc64               randconfig-002-20250522    gcc-10.5.0
sparc64               randconfig-002-20250522    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250522    gcc-10.5.0
um                    randconfig-001-20250522    gcc-12
um                    randconfig-002-20250522    gcc-10.5.0
um                    randconfig-002-20250522    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250522    clang-20
x86_64      buildonly-randconfig-002-20250522    gcc-12
x86_64      buildonly-randconfig-003-20250522    gcc-12
x86_64      buildonly-randconfig-004-20250522    gcc-12
x86_64      buildonly-randconfig-005-20250522    gcc-12
x86_64      buildonly-randconfig-006-20250522    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250522    clang-20
x86_64                randconfig-002-20250522    clang-20
x86_64                randconfig-003-20250522    clang-20
x86_64                randconfig-004-20250522    clang-20
x86_64                randconfig-005-20250522    clang-20
x86_64                randconfig-006-20250522    clang-20
x86_64                randconfig-007-20250522    clang-20
x86_64                randconfig-008-20250522    clang-20
x86_64                randconfig-071-20250522    gcc-12
x86_64                randconfig-072-20250522    gcc-12
x86_64                randconfig-073-20250522    gcc-12
x86_64                randconfig-074-20250522    gcc-12
x86_64                randconfig-075-20250522    gcc-12
x86_64                randconfig-076-20250522    gcc-12
x86_64                randconfig-077-20250522    gcc-12
x86_64                randconfig-078-20250522    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250522    gcc-10.5.0
xtensa                randconfig-001-20250522    gcc-14.2.0
xtensa                randconfig-002-20250522    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

