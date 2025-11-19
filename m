Return-Path: <linux-pci+bounces-41585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2FAC6CF3E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 07:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 083282A65B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E4272E63;
	Wed, 19 Nov 2025 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuEvjkqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFC2EAB83
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533930; cv=none; b=DDcVK/g7MuW6T9sMqz+3Mlyq0m9qXya3k1islnaVTYqi/XlntsN7MNKHbgY9BOwPBOnMhMo7SwZudng1Sau3DLpjwaEAjs6ybI+oy6e/X9qjXoh6emoePH2suzpaA9ugBttxJDg6/SXV0RbL2SDEDLZThEKB3MBaz3fCqQ+lLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533930; c=relaxed/simple;
	bh=zahyRSV0HjESIN2TpGoabmUIbi9fq/znzDeQK7tjwKE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aHtBvR+Cl40VNP/V7WyDCNeoGYxuBGTyGnHhcFcI3HAuxprgrvJtfq+Y86HnPGwAQjHvoNvTBtfYHH41Gl0WCprMj2rXepDFGUVhOSEHIEnXnEFtaQuQC2GB2OdJxq6+JbiqQFuiiomB6Cb8+cqS3PQKFr7j7O0yIymVK4COr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuEvjkqh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763533930; x=1795069930;
  h=date:from:to:cc:subject:message-id;
  bh=zahyRSV0HjESIN2TpGoabmUIbi9fq/znzDeQK7tjwKE=;
  b=RuEvjkqhPgTKaP74zzaaNLAZzlfqlovrX3VgqmQJ3iI6zVGikR2SpMNE
   vL4a6IQmgks9LlCI2+FzX4sAoodzc2166TA+LI+Hc4xl/ZhT2/EuNi+NY
   OxNxiOMJytFru/mf6iD6gETJE5rbribmY/BU9uUly6IFlM3W+Gf51s9iY
   Hd2c7wlKDVDkHs3AjWdq8uSRsmshTEc0xPqOYsA22d2BRQbCilIDVtO19
   SKmU2k+5Bc9FFmc8avdpA7NlW0XvTQeMjicuDAqxgpOPmy69nt9Un5v+R
   Agx2AZbr+3pbYWc9MMSDLg4s8yE1Bafxrd1aefYBtki50ryvNpUCwPhXe
   Q==;
X-CSE-ConnectionGUID: 8E+82K5kTqiDB2ZA3p+wwg==
X-CSE-MsgGUID: pbuiPCSgS0GmybWQQOLYsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="75892865"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="75892865"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 22:32:09 -0800
X-CSE-ConnectionGUID: jMGrAnP3QY6x1kZr2YuJFw==
X-CSE-MsgGUID: Z0mfkSuMQ7yrNEpg25N0KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="191105357"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 18 Nov 2025 22:32:08 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLbjZ-0002XG-2W;
	Wed, 19 Nov 2025 06:32:05 +0000
Date: Wed, 19 Nov 2025 14:31:53 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:controller/keystone] BUILD SUCCESS
 bc10d0ad540df599a3ab154f0255d901d3c2b030
Message-ID: <202511191447.iACmsPbV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/keystone
branch HEAD: bc10d0ad540df599a3ab154f0255d901d3c2b030  PCI: keystone: Add support to build as a loadable module

elapsed time: 7878m

configs tested: 63
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-15.1.0
alpha              allyesconfig    gcc-15.1.0
arc                 allnoconfig    gcc-15.1.0
arm                allmodconfig    gcc-15.1.0
arm                 allnoconfig    clang-22
arm64               allnoconfig    gcc-15.1.0
arm64              allyesconfig    clang-22
csky               allmodconfig    gcc-15.1.0
csky                allnoconfig    gcc-15.1.0
csky               allyesconfig    gcc-15.1.0
hexagon            allmodconfig    clang-17
hexagon             allnoconfig    clang-22
hexagon            allyesconfig    clang-22
i386                allnoconfig    gcc-14
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
nios2              allmodconfig    gcc-11.5.0
nios2               allnoconfig    gcc-11.5.0
nios2              allyesconfig    gcc-11.5.0
openrisc           allmodconfig    gcc-15.1.0
openrisc            allnoconfig    gcc-15.1.0
openrisc           allyesconfig    gcc-15.1.0
parisc             allmodconfig    gcc-15.1.0
parisc              allnoconfig    gcc-15.1.0
parisc             allyesconfig    gcc-15.1.0
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
sparc              allyesconfig    gcc-15.1.0
sparc64            allyesconfig    gcc-15.1.0
um                 allmodconfig    clang-19
um                  allnoconfig    clang-22
um                 allyesconfig    gcc-14
x86_64              allnoconfig    clang-20
x86_64                    kexec    clang-20
x86_64                 rhel-9.4    clang-20
x86_64             rhel-9.4-bpf    gcc-14
x86_64            rhel-9.4-func    clang-20
x86_64      rhel-9.4-kselftests    clang-20
x86_64           rhel-9.4-kunit    gcc-14
x86_64             rhel-9.4-ltp    gcc-14
xtensa              allnoconfig    gcc-15.1.0
xtensa             allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

