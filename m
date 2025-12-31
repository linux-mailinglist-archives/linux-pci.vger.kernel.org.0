Return-Path: <linux-pci+bounces-43884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69762CEC46C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 17:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9509430024A7
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60A12820C6;
	Wed, 31 Dec 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfnJ2GrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F727280CF6
	for <linux-pci@vger.kernel.org>; Wed, 31 Dec 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767199217; cv=none; b=tCxj44Jino1sLVfnIG+jxkgYDt+sVh6gb5UWrG1LmNO5lFtQvqUEXjB816r1vv6SF4maP5WtcvpdHXNWusyuKwObP3A2Q4TGmjpirrqtXZFZ3fjc0o1EPoP7hY3XGnuFx3t29RI1AoJx+lYjb+Fq9dQIS4UNulnVntQQSKSxH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767199217; c=relaxed/simple;
	bh=FvGTyKin4jB5gfyVrbBTMoGBGkSXyOnJyFPGVlAGkHQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c8m35GcAWNG83oLB8U+zGt6Xz2V+36REoGQjjDqm6ph35nWFd9xCvvvY94DwOUObLUVhuh3obxmfC2Qh5q1THiIPE3yKeRt58payDSztD24/IEOdYDan77vtAKBAhRVHW3uQzS9qJbEKihP6QBxLK//DoD2dyO6yvXwaqTp6h1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfnJ2GrH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767199216; x=1798735216;
  h=date:from:to:cc:subject:message-id;
  bh=FvGTyKin4jB5gfyVrbBTMoGBGkSXyOnJyFPGVlAGkHQ=;
  b=bfnJ2GrH1lQcfW2SGFCBHu5nVhZ1WkxliFKJV4l/x9dk5d2V5rWaJMkd
   3a2MdxagrOBJJXQpwVOgBf/1wGOuEll/NQACXVaWVM7QjxA8GQLKfqpsK
   3imRtFJDIl7V/ARwt+6CVjR0lAp+Zn2vfXJ+dWsYVyYmobXajO/pJiAGQ
   gcLZsnF6Ot9VPapPhdBBIcZRxkXNWR7/c7k3pe38fPaMF7CiH7cXoUObb
   x3tysFr/20SNiEPSsMgoeCvp7JDawDVW8FZqRUY78vnmhsqJunUAYj+6y
   67vgzZM5nyEiW7LzqJtKElp4yx+h/loMsIQvE538bg2S/SoN/7Hq/U6mD
   A==;
X-CSE-ConnectionGUID: EQ/QypDHSumtN23rVj0/nA==
X-CSE-MsgGUID: qQaCWFTbS0ejyn6828LhTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68744836"
X-IronPort-AV: E=Sophos;i="6.21,192,1763452800"; 
   d="scan'208";a="68744836"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 08:40:16 -0800
X-CSE-ConnectionGUID: Dc2AxhV3Q96C1evU2cxvsQ==
X-CSE-MsgGUID: 5C4c02ZdRsS7YwLBC/AbwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,192,1763452800"; 
   d="scan'208";a="205994104"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Dec 2025 08:40:15 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vazF6-000000001L7-2Neo;
	Wed, 31 Dec 2025 16:40:12 +0000
Date: Thu, 01 Jan 2026 00:39:37 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:for-linus] BUILD SUCCESS
 0cc13256b60510936c34098ee7b929098eed823b
Message-ID: <202601010031.NyCsPkfj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
branch HEAD: 0cc13256b60510936c34098ee7b929098eed823b  PCI: qcom: Remove ASPM L0s support for MSM8996 SoC

elapsed time: 1388m

configs tested: 55
configs skipped: 0

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
loongarch    allmodconfig    clang-19
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
xtensa       allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

