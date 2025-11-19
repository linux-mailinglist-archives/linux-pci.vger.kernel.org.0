Return-Path: <linux-pci+bounces-41583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36110C6CCE8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 06:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3D4202AF39
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 05:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D381514AD0D;
	Wed, 19 Nov 2025 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwL5fVTJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C3258ED4
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763530267; cv=none; b=jcLnwz+Nxze5gii2+s0TW/HcfWdajaUgvt+mf5gdhVkrvP5pLgOmNdjdtjGDUylU2U/cnC60xiMk/2NKAJ4et5y/roIG1YjiQv/2meWGMhmkyjhdT8lJzXVxx5p2ttVEuHq1V8kVvdPmx/w+CpeJINPDKQxSPXjmiVk0qc3uQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763530267; c=relaxed/simple;
	bh=9eSi/+NOxeDv+msu7GiLHdqfbrCFWPA/GkDUNuVABRY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gogmMQ8F9icjnkr/VUd6rba0r49MAUzMVcO8VzM000GMQYKv335tdU1PrHzgwBLrnRqLT2GurYbti2KifjrllRZtNzNXrs2zrWPAmAOcZYhaQl1QybtU6NKoX+W8juf0qy8F2XqvTywpyFdKUsRWc3H8RYnoENlOimWgyaWwqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwL5fVTJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763530267; x=1795066267;
  h=date:from:to:cc:subject:message-id;
  bh=9eSi/+NOxeDv+msu7GiLHdqfbrCFWPA/GkDUNuVABRY=;
  b=lwL5fVTJzxzlcyYyOuz4/UrA9/6zvym5n8sxWk3TDgdtDOH4S1KcJs8N
   uRMHebt68vaHh/iROZRcqxdC8HfrOKCS31AmJXnknsJTTF+xkuSTfqiuD
   r0HDPFZndJ9zkne7YQPz9cX9t/BZqwU1sBOxRQ1iSsROO9jxlfP+gYc56
   3Allkv7MafMmr86KFvJZnatklJNVrSDjgEjWh0bwnGlORWwkjNXQeXQJU
   Dpp90apwuY8hgSZTuJ/IbXZLPYTOT0J2oqOCJ3zgZ/LputJT+sHo9AZfk
   Ox2zj/BmcQHLlSyIcMJeoUwJJcB/H174CmBJ/6aCKGX5FD4nyOdaZjNue
   w==;
X-CSE-ConnectionGUID: tTzKzNWZQESGCMp/IImKRg==
X-CSE-MsgGUID: 4zS6wLUbTQaxrCyPr/i5Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="69415494"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="69415494"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 21:31:03 -0800
X-CSE-ConnectionGUID: eeB9UsR9TCa1TjHWdCPwiQ==
X-CSE-MsgGUID: mt7Sy1R0S7uBQkqxBA2h1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="195424285"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Nov 2025 21:31:02 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLamR-0002UI-2L;
	Wed, 19 Nov 2025 05:30:59 +0000
Date: Wed, 19 Nov 2025 13:30:40 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/brcmstb] BUILD SUCCESS
 8d4ec3fbb15e97b58c395398c743453012bbb93f
Message-ID: <202511191335.GQNS0QbZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/brcmstb
branch HEAD: 8d4ec3fbb15e97b58c395398c743453012bbb93f  PCI: brcmstb: Add panic/die handler to driver

elapsed time: 7890m

configs tested: 67
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-15.1.0
alpha              allyesconfig    gcc-15.1.0
arc                allmodconfig    gcc-15.1.0
arc                 allnoconfig    gcc-15.1.0
arc                allyesconfig    gcc-15.1.0
arm                allmodconfig    gcc-15.1.0
arm                 allnoconfig    clang-22
arm                allyesconfig    gcc-15.1.0
arm64              allmodconfig    clang-19
arm64               allnoconfig    gcc-15.1.0
arm64              allyesconfig    clang-22
csky               allmodconfig    gcc-15.1.0
csky                allnoconfig    gcc-15.1.0
csky               allyesconfig    gcc-15.1.0
hexagon            allmodconfig    clang-17
hexagon             allnoconfig    clang-22
hexagon            allyesconfig    clang-22
i386               allmodconfig    gcc-14
i386                allnoconfig    gcc-14
i386               allyesconfig    gcc-14
loongarch          allmodconfig    clang-19
loongarch           allnoconfig    clang-22
loongarch          allyesconfig    clang-22
m68k               allmodconfig    gcc-15.1.0
m68k                allnoconfig    gcc-15.1.0
m68k               allyesconfig    gcc-15.1.0
microblaze         allmodconfig    gcc-15.1.0
microblaze          allnoconfig    gcc-15.1.0
microblaze         allyesconfig    gcc-15.1.0
mips               allmodconfig    gcc-15.1.0
mips                allnoconfig    gcc-15.1.0
mips               allyesconfig    gcc-15.1.0
nios2               allnoconfig    gcc-11.5.0
openrisc            allnoconfig    gcc-15.1.0
openrisc           allyesconfig    gcc-15.1.0
parisc             allmodconfig    gcc-15.1.0
parisc              allnoconfig    gcc-15.1.0
parisc             allyesconfig    gcc-15.1.0
powerpc            allmodconfig    gcc-15.1.0
powerpc             allnoconfig    gcc-15.1.0
powerpc            allyesconfig    clang-22
riscv              allmodconfig    clang-22
riscv               allnoconfig    gcc-15.1.0
riscv              allyesconfig    clang-16
s390               allmodconfig    clang-18
s390                allnoconfig    clang-22
s390               allyesconfig    gcc-15.1.0
sh                 allmodconfig    gcc-15.1.0
sh                  allnoconfig    gcc-15.1.0
sh                 allyesconfig    gcc-15.1.0
sparc              allmodconfig    gcc-15.1.0
sparc               allnoconfig    gcc-15.1.0
um                 allmodconfig    clang-19
um                  allnoconfig    clang-22
um                 allyesconfig    gcc-14
x86_64             allmodconfig    clang-20
x86_64              allnoconfig    clang-20
x86_64             allyesconfig    clang-20
x86_64                    kexec    clang-20
x86_64                 rhel-9.4    clang-20
x86_64             rhel-9.4-bpf    gcc-14
x86_64            rhel-9.4-func    clang-20
x86_64      rhel-9.4-kselftests    clang-20
x86_64           rhel-9.4-kunit    gcc-14
x86_64             rhel-9.4-ltp    gcc-14
x86_64            rhel-9.4-rust    clang-20
xtensa              allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

