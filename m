Return-Path: <linux-pci+bounces-43876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D9CEC0AC
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B75DE300D178
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C5263F5E;
	Wed, 31 Dec 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3U3wb1k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9EF1C84D0
	for <linux-pci@vger.kernel.org>; Wed, 31 Dec 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767188985; cv=none; b=IVDZ8J14EJejMIxSRyiOk3SYR1VP9xub2YIJ1IC3UR4+QHhZ7keNtde9TMCcu0oxH0Te3RtmYOftXfuxsUxcNpyQypp0Cmuqzu3A0Ys42+ciSgn4RWszTf8ztS4FlT+l+MdW5f5BK0eD73uk9+8rBEVvzOevJIqOV0yHdOU0DUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767188985; c=relaxed/simple;
	bh=jd02B+CKbNlsnRR1QiaxO5/cIaVzND9HxDs7LXQol8k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PIxWS0bdr+mrDDYJl6ZQ5EAPNzXpEB5XlgWw63ee1mDT3EjH6qT1QXyGFMeFwuWmlQ6uEjkWCdLRudjg8jSqyoZFn0FgWYoNo++IDWhpyn35wJ5qHkYw/wlAnhGCXjFT2nKwsJE9ZjX1N6A/1NI1eY87C35L900k39D6eN7NKn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3U3wb1k; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767188984; x=1798724984;
  h=date:from:to:cc:subject:message-id;
  bh=jd02B+CKbNlsnRR1QiaxO5/cIaVzND9HxDs7LXQol8k=;
  b=E3U3wb1kvM2Popl+bBrSQnGuRx581xCeaZ06Y4P3p65eWluBQzd3dcrG
   XMx9NstWabAJlARzPNxQpadfqx4SqF9kEAT4jWu/2I7kUBclbdqdJ4wQ5
   ES/b6c2L8g4KmPdyP2+vrxD1ILlLrDp7n8dUtnr/fT7rH3MAYhaC7Nc/Y
   ftl5YS4+KGscH0vYOm0i4g9V2DJXLIJ/SljKdulGCGk+jB0GXSuQXD5qs
   3uyt3yS56go3HwlG6kE90LTEuqSPFBjq6QS4LFlmdVGGhtRSwaWlJX5xD
   pb/fFsWIOuAiA1A102fza+dgaPhBYVqI3cDsTqhKAQofALJKbcUwvZxIY
   A==;
X-CSE-ConnectionGUID: pfuKvl+pTru7JoXQH+dmzA==
X-CSE-MsgGUID: EoMvezCWT/m/n4r5U3ck8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="86333317"
X-IronPort-AV: E=Sophos;i="6.21,191,1763452800"; 
   d="scan'208";a="86333317"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 05:49:43 -0800
X-CSE-ConnectionGUID: KYfZPYzCRQaj+02tWp0DxQ==
X-CSE-MsgGUID: DPMQMFooTri8ZFRGQBbC1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,191,1763452800"; 
   d="scan'208";a="206495975"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 31 Dec 2025 05:49:42 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vawa3-000000001Ez-1hMb;
	Wed, 31 Dec 2025 13:49:39 +0000
Date: Wed, 31 Dec 2025 21:49:31 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 2cca8d79709e1debd27da5dcae2abc859f41db70
Message-ID: <202512312126.6gfGTnGO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 2cca8d79709e1debd27da5dcae2abc859f41db70  dt-bindings: PCI: socionext,uniphier-pcie: Fix interrupt controller node name

elapsed time: 1242m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.1.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.1.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
mips         allmodconfig    gcc-15.1.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.1.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc         allnoconfig    gcc-15.1.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

