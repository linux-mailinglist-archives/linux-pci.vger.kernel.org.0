Return-Path: <linux-pci+bounces-10223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC5930166
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 23:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C831C20EF7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 21:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2D200CD;
	Fri, 12 Jul 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxTL+hQR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2C1094E
	for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818053; cv=none; b=nsZmMQ7n2QUig2uXyJ3xptOuDQAkOLizBqkHFkXq//eacAWPGJCXRS4ZII7je+PRCyQbHMtBi78GxkS4xa36bUzG2i/9gWDgOaQWRxp5y+xS6L5v+g5olTQMLpkTvsyBXd9OIYPYc79TXxgEYe8OD9gCenSHumHOGbFPC6p8QoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818053; c=relaxed/simple;
	bh=cKz9ZdBHxKpSIxsmYcX6bvLlRIPBoAs/rNeoFrwG9FY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B7U72mJP0v5NKF+njIkG66dlV+ziBYQNX7E4IsWxYRVCYnukD/5q9J2izeBgZaqbLUFobPNFevMzXdOPrbC//jzUIN22WewlCekhunTx1+ZMlvfdR+MHzD5uXIK2b4x8mdlHEhYq0O+t1YjkS+OouL4ga/ZtdjNCBrkAztVpKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxTL+hQR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720818052; x=1752354052;
  h=date:from:to:cc:subject:message-id;
  bh=cKz9ZdBHxKpSIxsmYcX6bvLlRIPBoAs/rNeoFrwG9FY=;
  b=YxTL+hQR4lWCNgYUfS2N8JYsZlUUAuQiDIgcqkVxAQdLSKwg/WFCLnvM
   mno3YAKn4v2Pmw/kkajP9U0Xz5ETD6UNIxuE+x2oIo0D8Pfhg8zm5KL0m
   D3NFmOyOcMp512T/PirhxtyCI1OM8tUOkI/nJsOLLCy6xeKeDl/aik2IZ
   Z+9084mSEd29MuGqSt8Xm626zcO/5UX4wPClG5m133DOMrPjLVQUg0PkR
   20K/7gEn0Aa9vpXkj2y8sQWepHGSme0Kwoy/yPBkeYAf1SvP/ffsBDRcA
   dbt/NgZImrkPJLWuHXbBl0XFFMTVeuBA/Id1nL6TwwYW+YLW/7f7wB8L3
   g==;
X-CSE-ConnectionGUID: vVrT+nLOSqC7U0JwWczKvA==
X-CSE-MsgGUID: E6yarLiCQYuz5QnLPJNe6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18090278"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="18090278"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 14:00:49 -0700
X-CSE-ConnectionGUID: 0vvas7cdTCKGDAXmFu7nEQ==
X-CSE-MsgGUID: wDtgCRhVQVWYmPKYUclegg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="53976949"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Jul 2024 14:00:47 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSNNl-000bHY-16;
	Fri, 12 Jul 2024 21:00:45 +0000
Date: Sat, 13 Jul 2024 04:59:50 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:reset] BUILD SUCCESS
 0708331374d618575f073a5a6d3662f4f8d0f8ce
Message-ID: <202407130448.kYwwiQwV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git reset
branch HEAD: 0708331374d618575f073a5a6d3662f4f8d0f8ce  PCI: Add missing bridge lock to pci_bus_lock()

elapsed time: 1445m

configs tested: 143
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240712   gcc-13.2.0
arc                   randconfig-002-20240712   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240712   clang-19
arm                   randconfig-002-20240712   clang-19
arm                   randconfig-003-20240712   gcc-14.1.0
arm                   randconfig-004-20240712   clang-15
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240712   gcc-14.1.0
arm64                 randconfig-002-20240712   gcc-14.1.0
arm64                 randconfig-003-20240712   clang-19
arm64                 randconfig-004-20240712   clang-17
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240712   gcc-14.1.0
csky                  randconfig-002-20240712   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240712   clang-14
hexagon               randconfig-002-20240712   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240712   gcc-9
i386         buildonly-randconfig-002-20240712   clang-18
i386         buildonly-randconfig-003-20240712   clang-18
i386         buildonly-randconfig-004-20240712   clang-18
i386         buildonly-randconfig-005-20240712   gcc-11
i386         buildonly-randconfig-006-20240712   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240712   clang-18
i386                  randconfig-002-20240712   clang-18
i386                  randconfig-003-20240712   clang-18
i386                  randconfig-004-20240712   clang-18
i386                  randconfig-005-20240712   clang-18
i386                  randconfig-006-20240712   clang-18
i386                  randconfig-011-20240712   clang-18
i386                  randconfig-012-20240712   clang-18
i386                  randconfig-013-20240712   clang-18
i386                  randconfig-014-20240712   gcc-10
i386                  randconfig-015-20240712   gcc-10
i386                  randconfig-016-20240712   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240712   gcc-14.1.0
loongarch             randconfig-002-20240712   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240712   gcc-14.1.0
nios2                 randconfig-002-20240712   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240712   gcc-14.1.0
parisc                randconfig-002-20240712   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240712   clang-15
powerpc               randconfig-002-20240712   clang-19
powerpc               randconfig-003-20240712   clang-19
powerpc64             randconfig-001-20240712   clang-19
powerpc64             randconfig-002-20240712   clang-19
powerpc64             randconfig-003-20240712   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240712   clang-19
riscv                 randconfig-002-20240712   gcc-14.1.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240712   gcc-14.1.0
s390                  randconfig-002-20240712   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240712   gcc-14.1.0
sh                    randconfig-002-20240712   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240712   gcc-14.1.0
sparc64               randconfig-002-20240712   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240712   clang-19
um                    randconfig-002-20240712   clang-15
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240712   clang-18
x86_64       buildonly-randconfig-002-20240712   clang-18
x86_64       buildonly-randconfig-003-20240712   clang-18
x86_64       buildonly-randconfig-004-20240712   clang-18
x86_64       buildonly-randconfig-005-20240712   clang-18
x86_64       buildonly-randconfig-006-20240712   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240712   gcc-12
x86_64                randconfig-002-20240712   gcc-13
x86_64                randconfig-003-20240712   gcc-12
x86_64                randconfig-004-20240712   clang-18
x86_64                randconfig-005-20240712   gcc-13
x86_64                randconfig-006-20240712   clang-18
x86_64                randconfig-011-20240712   clang-18
x86_64                randconfig-012-20240712   clang-18
x86_64                randconfig-013-20240712   clang-18
x86_64                randconfig-014-20240712   gcc-13
x86_64                randconfig-015-20240712   clang-18
x86_64                randconfig-016-20240712   clang-18
x86_64                randconfig-071-20240712   gcc-13
x86_64                randconfig-072-20240712   gcc-11
x86_64                randconfig-073-20240712   clang-18
x86_64                randconfig-074-20240712   gcc-9
x86_64                randconfig-075-20240712   clang-18
x86_64                randconfig-076-20240712   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240712   gcc-14.1.0
xtensa                randconfig-002-20240712   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

