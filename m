Return-Path: <linux-pci+bounces-41684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7695CC71221
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5335828D08
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AFB2D97BF;
	Wed, 19 Nov 2025 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgdsDaps"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126022F12A5
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587123; cv=none; b=JHDYsVE8HR4ENJYzKTfoKBarw4N6x6T3VnQidDkmKJlERy71Nx5WwUAGYbSed9C4QJ4PGp5aMw55GJAJsjfBd0fqag5QkiayPKWYyIQ2JMUjZf+1Zynps3A+EYGb/zN/yL8ryDBY+dXkyRgnvB3bnlKSH1EFxfDPtFCF4xzlTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587123; c=relaxed/simple;
	bh=NsmOV/Ul1x2Clj6+hJBeqEjVEEuudWZBPaLvz2WadLo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LCL3grL6QjjjzlvGQucDJWjsxPv1V7175Tu4msp2tKcCKoaGGi5Zn3l4j0GJQK2UrvgjkBZfZYESC0Fdngddij7n1Uf8cPY11tQz1+1hH/wQCQGoALQqosTyDrzn5xlUJ/XWbSWcg3Fw1uZoFTYDFjK3YL8lOR74V99AfwQ6Wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgdsDaps; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763587122; x=1795123122;
  h=date:from:to:cc:subject:message-id;
  bh=NsmOV/Ul1x2Clj6+hJBeqEjVEEuudWZBPaLvz2WadLo=;
  b=MgdsDapsP6UCm1ZdFo2UxvYXOrWFOq/d8dJwtht7JHLUe0xj1/ckpFOk
   VsZ+EQuBgyrbJLwLo5oXA9N8PdOzvJjtGX1xpwAWOlhNBZvogNW26gsY9
   R1RcSaq6U/Mky+Hf/jjcoA3TH6XUTYAPNU3rMM+sodGe6EYa0uUw9BF3K
   sv45LvJ7iXgnYOzGxUKdoblYbQE68uVwgS1lrNNtijmEPuPq4rvImV9OG
   BPpywcxalVo6zRLGzcyth6it09MREqEKqQBM2002V5OukrvpJ6q+BRT3r
   GXo7tC6MpebcOQtAcOuawZaEfZZVDUj+1aHJim7cX29t/qqUAQCOgFXMu
   A==;
X-CSE-ConnectionGUID: 3zj8rnlwSbyT4lNRhH9Z0w==
X-CSE-MsgGUID: +ja06QonT3CEtCLbWFJoaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65802653"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65802653"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:18:42 -0800
X-CSE-ConnectionGUID: 2utehAqrT5qKSumVlVdIqA==
X-CSE-MsgGUID: fYU1qkkuRwylELqCNiJmNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="195473381"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 19 Nov 2025 13:18:40 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLpZW-0003Kp-1V;
	Wed, 19 Nov 2025 21:18:38 +0000
Date: Thu, 20 Nov 2025 05:18:34 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/cix] BUILD SUCCESS
 7bdb5b229c552ea69962aa33f508a72f2789543b
Message-ID: <202511200529.nY7YZjzi-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/cix
branch HEAD: 7bdb5b229c552ea69962aa33f508a72f2789543b  MAINTAINERS: Add entry for CIX Sky1 PCIe driver

elapsed time: 7386m

configs tested: 66
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251115    gcc-13.4.0
arc         randconfig-001-20251118    gcc-14.3.0
arc         randconfig-002-20251115    gcc-11.5.0
arc         randconfig-002-20251118    gcc-15.1.0
arm                     allnoconfig    clang-22
arm         randconfig-001-20251115    clang-22
arm         randconfig-001-20251118    gcc-8.5.0
arm         randconfig-002-20251115    gcc-8.5.0
arm         randconfig-002-20251118    gcc-10.5.0
arm         randconfig-003-20251115    gcc-10.5.0
arm         randconfig-003-20251118    clang-22
arm         randconfig-004-20251115    clang-22
arm         randconfig-004-20251118    clang-22
arm64                   allnoconfig    gcc-15.1.0
arm64       randconfig-001-20251118    clang-20
arm64       randconfig-002-20251118    clang-22
arm64       randconfig-003-20251118    clang-19
arm64       randconfig-004-20251118    clang-17
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky        randconfig-001-20251118    gcc-10.5.0
csky        randconfig-002-20251118    gcc-15.1.0
hexagon                 allnoconfig    clang-22
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251117    gcc-12.5.0
riscv       randconfig-002-20251117    gcc-15.1.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390        randconfig-001-20251117    gcc-14.3.0
s390        randconfig-002-20251117    clang-22
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh          randconfig-001-20251117    gcc-15.1.0
sh          randconfig-002-20251117    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                      allnoconfig    clang-22
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

