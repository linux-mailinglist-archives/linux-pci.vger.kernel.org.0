Return-Path: <linux-pci+bounces-8699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC6A906366
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BE21C2275F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 05:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FBE136647;
	Thu, 13 Jun 2024 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZzVIb7u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF004C6B
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255859; cv=none; b=u6lDKQVpMfxceg/qLqMTqGildaNGfJRdn4fyRq/AYyEdTOmfT63+Zde8uqeTm3slKXuMk3WGaiGUZ7UcbkLGtc79+sBDmooio3HNjOrG3mU527wfqvaWrPd16AiOYS2f026/MdIPHBjZ3EDSUFq/d2Aj9cvpHQMvmW/v76AsUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255859; c=relaxed/simple;
	bh=FN0FJLyRbtuc4cNZxRokQc3iMl8wLDxpnvwCMDwVZC8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tk2lvX8jsRtcKOs/3t8pl9CItoSpcPUqDvwuJAWAEXiuwIwKXHT9Rz915Vy7u7K9r8Rpz5kjLtptKVmBoBq13oiAoAhgND/7Zq0OYO9SGDuMrwk+K1EWBrLSIZeD/t/0yBOpJHkUQjymu3eQKYgf5FbXr9C7UM9IG4gIXKz03PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZzVIb7u; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718255857; x=1749791857;
  h=date:from:to:cc:subject:message-id;
  bh=FN0FJLyRbtuc4cNZxRokQc3iMl8wLDxpnvwCMDwVZC8=;
  b=nZzVIb7uZ2jZy4oHtySAIft0JfbBdQ8VwGQ5296B4e/1b/E2y7IH4fbi
   TXrGVc/77O3/ixBByAB2qcP5648pG5fjnqNDlZbmP2i00hXjUt+pyq7OI
   K5C/6zWo4qOVOdkikbw9Pe23JxDoP0f9sDqrwVnDcb1qMqn8sAunJfp92
   nGAL64bXtaI3MX5mISFQPrlWZ5lt14obUMHo9bSfF6UcyVXPGspq+vdtg
   /tQKkQdYADiUupyLGGGHRRgVLQmxpwMrtHID8x4iPXMEIIlfTN5NsUm6L
   b5gjGFhIqy9ssAdXcysdQ5ERwlM4FIZFQkXNIwewfwgFQGAZ9nCN940Ip
   g==;
X-CSE-ConnectionGUID: CC+UeizsSwWZekArB5TOYQ==
X-CSE-MsgGUID: X9w3ojr5TP+ZtzHIiPJ+6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15281870"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15281870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 22:17:36 -0700
X-CSE-ConnectionGUID: u+QMMmijQqyW0WhAJXofQQ==
X-CSE-MsgGUID: yK0w/acHRzGliGt6B4PNcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="77472864"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Jun 2024 22:17:35 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHcq5-0002Fk-0x;
	Thu, 13 Jun 2024 05:17:33 +0000
Date: Thu, 13 Jun 2024 13:16:46 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 419d57d429f6e1fbd9024d34b11eb84b3138c60e
Message-ID: <202406131344.cZP5UlEq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 419d57d429f6e1fbd9024d34b11eb84b3138c60e  CREDITS: Add Synopsys DesignWare eDMA driver for Gustavo Pimentel

elapsed time: 2246m

configs tested: 72
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

