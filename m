Return-Path: <linux-pci+bounces-9606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A3192470F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 20:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAA0284225
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882BD155335;
	Tue,  2 Jul 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+YSHXts"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F72F4A
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943848; cv=none; b=NqmS5elfd3NSyDBzqWQ48U/zC4JUBZc5vroaeNO67haUZuU5GVV5kJc36TkXw0TS70A3ofignaq3c0N2EIBR4iljiASAr1rnD7lnJS0/gHD0NaH0S6C/DDVzsstAz+XdtekGb82OvHERVa4Ua3zf422LEXGFY/ocGyrNFyEJvsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943848; c=relaxed/simple;
	bh=n0k7ZmcRu07tgUKad/DHkgQS2PbIzxco/QUs9MAK99U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=B+ngs21GX8lkaMTnMRjxmHZ6KG2DnTk0swabNoqOEo8kRYOgvFvLP0FFdDbx9yYdpXDQGqiIj7/0zcOvfjp/1FHu2/bP1uD+HKiwLJKLjtLO8z1V7Hse/I7uuxxC9OcEKvQh+QMxmnmEXCoQrhJ6UH3vstgMV5USSzdIFc9yugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+YSHXts; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719943847; x=1751479847;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n0k7ZmcRu07tgUKad/DHkgQS2PbIzxco/QUs9MAK99U=;
  b=k+YSHXtsZ1TZnahK5QNkcuKpVX+0B8cOc5gG3CjyUT1Uxhpg6y1BMweq
   DMVcMUg1PAWhSI4vlya/jIBo01/dt0F+KwQk+lz1Rqasx71AOcqYmdGxT
   vhzf0NccLpYUY1hnEDqyo32Hs18vbNJKZZ/7/SApxgHft6PI47mCArT2O
   j43JT8REjG4kxttMsc8TN2SX/ICOHuOGZwDi+Q06WWvnwek+6/nXz1s6I
   lGCQHQtXFbRXP+tQNedQDfA/n8NSmewGbAACZAsq7e83KfCOYTtpPyVu/
   hQrFvnf5qaPB7DlERAcHo1PAj5vLMhwjID7NEoCQw9qxBT5ZAaYlIUrvh
   A==;
X-CSE-ConnectionGUID: tr5hlN6tQyOMoSrjKMAVSQ==
X-CSE-MsgGUID: nBHDUn/YRUmQ7jS3SBrEYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17274770"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="17274770"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 11:10:47 -0700
X-CSE-ConnectionGUID: wutCLjO8QCerp/z+o0GKfw==
X-CSE-MsgGUID: 6LdfgfF7Szq/z9Oq7L0viA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76721524"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Jul 2024 11:10:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOhxj-000OVE-01;
	Tue, 02 Jul 2024 18:10:43 +0000
Date: Wed, 03 Jul 2024 02:09:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 05214340e133a777886de3486953875cfb08a57e
Message-ID: <202407030245.wET9LBjU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: 05214340e133a777886de3486953875cfb08a57e  PCI: endpoint: Fix error handling in epf_ntb_epc_cleanup()

elapsed time: 1972m

configs tested: 112
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240702   gcc-13.2.0
arc                   randconfig-002-20240702   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                        multi_v7_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   clang-19
arm                         nhk8815_defconfig   clang-19
arm                   randconfig-001-20240702   gcc-13.2.0
arm                   randconfig-002-20240702   gcc-13.2.0
arm                   randconfig-003-20240702   gcc-13.2.0
arm                   randconfig-004-20240702   gcc-13.2.0
arm                             rpc_defconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240702   gcc-13.2.0
arm64                 randconfig-002-20240702   clang-19
arm64                 randconfig-002-20240702   gcc-13.2.0
arm64                 randconfig-003-20240702   gcc-13.2.0
arm64                 randconfig-004-20240702   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240702   gcc-13.2.0
csky                  randconfig-002-20240702   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon               randconfig-001-20240702   clang-19
hexagon               randconfig-002-20240702   clang-19
i386         buildonly-randconfig-001-20240701   clang-18
i386         buildonly-randconfig-001-20240702   gcc-13
i386         buildonly-randconfig-002-20240701   clang-18
i386         buildonly-randconfig-002-20240702   gcc-13
i386         buildonly-randconfig-003-20240701   clang-18
i386         buildonly-randconfig-003-20240702   gcc-13
i386         buildonly-randconfig-004-20240701   clang-18
i386         buildonly-randconfig-004-20240702   gcc-13
i386         buildonly-randconfig-005-20240701   gcc-13
i386         buildonly-randconfig-005-20240702   gcc-13
i386         buildonly-randconfig-006-20240701   gcc-9
i386         buildonly-randconfig-006-20240702   gcc-13
i386                  randconfig-001-20240701   clang-18
i386                  randconfig-001-20240702   gcc-13
i386                  randconfig-002-20240701   clang-18
i386                  randconfig-002-20240702   gcc-13
i386                  randconfig-003-20240701   clang-18
i386                  randconfig-003-20240702   gcc-13
i386                  randconfig-004-20240701   gcc-7
i386                  randconfig-004-20240702   gcc-13
i386                  randconfig-005-20240701   clang-18
i386                  randconfig-005-20240702   gcc-13
i386                  randconfig-006-20240701   gcc-13
i386                  randconfig-006-20240702   gcc-13
i386                  randconfig-011-20240701   gcc-13
i386                  randconfig-011-20240702   gcc-13
i386                  randconfig-012-20240701   clang-18
i386                  randconfig-012-20240702   gcc-13
i386                  randconfig-013-20240701   clang-18
i386                  randconfig-013-20240702   gcc-13
i386                  randconfig-014-20240701   gcc-8
i386                  randconfig-014-20240702   gcc-13
i386                  randconfig-015-20240701   gcc-10
i386                  randconfig-015-20240702   gcc-13
i386                  randconfig-016-20240701   clang-18
i386                  randconfig-016-20240702   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240702   gcc-13.2.0
loongarch             randconfig-002-20240702   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                          amiga_defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                       lemote2f_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   clang-19
mips                          rm200_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240702   gcc-13.2.0
nios2                 randconfig-002-20240702   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                randconfig-001-20240702   gcc-13.2.0
parisc                randconfig-002-20240702   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240702   gcc-13.2.0
powerpc               randconfig-002-20240702   clang-16
powerpc               randconfig-002-20240702   gcc-13.2.0
powerpc               randconfig-003-20240702   gcc-13.2.0
powerpc64             randconfig-001-20240702   clang-19
powerpc64             randconfig-001-20240702   gcc-13.2.0
powerpc64             randconfig-002-20240702   gcc-13.2.0
powerpc64             randconfig-003-20240702   clang-19
powerpc64             randconfig-003-20240702   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                 randconfig-001-20240702   gcc-13.2.0
riscv                 randconfig-002-20240702   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                  randconfig-001-20240702   clang-19
s390                  randconfig-001-20240702   gcc-13.2.0
s390                  randconfig-002-20240702   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                    randconfig-001-20240702   gcc-13.2.0
sh                    randconfig-002-20240702   gcc-13.2.0
sparc64               randconfig-001-20240702   gcc-13.2.0
sparc64               randconfig-002-20240702   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                    randconfig-001-20240702   gcc-13.2.0
um                    randconfig-001-20240702   gcc-8
um                    randconfig-002-20240702   gcc-13
um                    randconfig-002-20240702   gcc-13.2.0
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240702   gcc-13.2.0
xtensa                randconfig-002-20240702   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

