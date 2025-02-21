Return-Path: <linux-pci+bounces-22007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E135AA3FCB4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 18:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E2D19C5F93
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9F21764B;
	Fri, 21 Feb 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUUb7T72"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A20228C9E
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157095; cv=none; b=mUNPTcp8J3sBp5TeM6y4H+QGa+bLDEP4DI7WTSdMI5Ua3PwM1gcyMUuJGVvWHw7uJ5qhV2F6xnK//5l0lthjR/oOzDQjC1UWWn01HdAznZVZoydzd83E8vOnViJPF5IYhocb/vksB/E/8+KyXya5/f7S3u90ADbck/3fQ5ELVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157095; c=relaxed/simple;
	bh=SUuRFJhkC7+IHmgqscahYqWbTBEwLB0f4oD/P7gseYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jkJiSXN6bSjufTDTqBMRZN6ysDmlFrL70J4sCbFMLZC4DfDKRf+KfoQLgGCPfS199pqafG1Maw7a3DOWTa4Wtuh4G0G74AF9xdODXJKCj6ZfI907PANspwO4utqrkaXSbX1Ghg63/4d5kuxYbR2KQVrhUlpyeNZ7dOnXBkpkmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUUb7T72; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740157094; x=1771693094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SUuRFJhkC7+IHmgqscahYqWbTBEwLB0f4oD/P7gseYo=;
  b=GUUb7T72aCgbbij8DYoExRMeqGtkN5TBMzurS5PPKnMmVfEicUur1ggl
   dhoo9cjj9do+8SpYCO+8gmAC+NhoEC1yQrQWniC/TW9f5v+vWcb+xBBgP
   8Sh5SQkda1yjyVhWQU3HxzeQA2xT4in1F9RT5FJ39DjqmC3PVnRIpSWvr
   m8e2f+Wun+O/DAlr0+zYKzUFqAdf6T0lpD9xQhe4enSVP8gs6W2tmSeWO
   +VZIPC7TgIVmX7WfbWza9iRgH0BVoogTSiWylTRDQ3rNW+F9IAC4rTqn+
   Vgy5nyRHGsfiTFBWlyc0A2fs++BlMeTUASY8RG3E9wgEwNEMeFdkz7iNg
   Q==;
X-CSE-ConnectionGUID: nVf9UEJqRG6rwe2m7+Wa9g==
X-CSE-MsgGUID: J1fyUFssTPOn789tEy4uXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52412442"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52412442"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:58:13 -0800
X-CSE-ConnectionGUID: q0tBXWEDTgCGstGDzAPpsA==
X-CSE-MsgGUID: bgumM1NQSPiFMpA4knD4Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115923255"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 08:58:12 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlWLp-0005mC-2K;
	Fri, 21 Feb 2025 16:58:09 +0000
Date: Sat, 22 Feb 2025 00:57:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 da93733d1f8da45e764e429952f88e0a46c55ecb
Message-ID: <202502220021.xcqvhuK4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: da93733d1f8da45e764e429952f88e0a46c55ecb  PCI: brcmstb: Fix missing of_node_put() in brcm_pcie_probe()

elapsed time: 1454m

configs tested: 70
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250221    gcc-13.2.0
arc                  randconfig-002-20250221    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250221    gcc-14.2.0
arm                  randconfig-002-20250221    clang-19
arm                  randconfig-003-20250221    gcc-14.2.0
arm                  randconfig-004-20250221    clang-21
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250221    clang-15
arm64                randconfig-002-20250221    clang-21
arm64                randconfig-003-20250221    clang-21
arm64                randconfig-004-20250221    gcc-14.2.0
csky                 randconfig-001-20250221    gcc-14.2.0
csky                 randconfig-002-20250221    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250221    clang-21
hexagon              randconfig-002-20250221    clang-21
i386                             allnoconfig    gcc-12
i386       buildonly-randconfig-001-20250221    gcc-12
i386       buildonly-randconfig-002-20250221    gcc-12
i386       buildonly-randconfig-003-20250221    gcc-12
i386       buildonly-randconfig-004-20250221    gcc-12
i386       buildonly-randconfig-005-20250221    clang-19
i386       buildonly-randconfig-006-20250221    clang-19
loongarch            randconfig-001-20250221    gcc-14.2.0
loongarch            randconfig-002-20250221    gcc-14.2.0
nios2                randconfig-001-20250221    gcc-14.2.0
nios2                randconfig-002-20250221    gcc-14.2.0
parisc               randconfig-001-20250221    gcc-14.2.0
parisc               randconfig-002-20250221    gcc-14.2.0
powerpc              randconfig-001-20250221    clang-21
powerpc              randconfig-002-20250221    clang-21
powerpc              randconfig-003-20250221    clang-17
powerpc64            randconfig-001-20250221    clang-21
powerpc64            randconfig-002-20250221    clang-21
powerpc64            randconfig-003-20250221    clang-19
riscv                randconfig-001-20250221    clang-21
riscv                randconfig-002-20250221    clang-21
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250221    gcc-14.2.0
s390                 randconfig-002-20250221    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250221    gcc-14.2.0
sh                   randconfig-002-20250221    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250221    gcc-14.2.0
sparc                randconfig-002-20250221    gcc-14.2.0
sparc64              randconfig-001-20250221    gcc-14.2.0
sparc64              randconfig-002-20250221    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250221    gcc-12
um                   randconfig-002-20250221    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250221    gcc-12
x86_64     buildonly-randconfig-002-20250221    clang-19
x86_64     buildonly-randconfig-003-20250221    clang-19
x86_64     buildonly-randconfig-004-20250221    clang-19
x86_64     buildonly-randconfig-005-20250221    clang-19
x86_64     buildonly-randconfig-006-20250221    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250221    gcc-14.2.0
xtensa               randconfig-002-20250221    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

