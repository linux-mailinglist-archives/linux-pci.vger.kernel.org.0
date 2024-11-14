Return-Path: <linux-pci+bounces-16742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97479C8685
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 10:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EC028361C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA101F583E;
	Thu, 14 Nov 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9DpBskI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D84D14EC47
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578061; cv=none; b=KmNdOh3oV/G9o2bQYywuSfgNVmHuYQLpKUhx1C4MNN/8J+w27fejJmSUG1KN+F+SyzxTih2Lj8oCPXp8pve9xh5Up3Y3xIAWUzhRn5G3Ai3wJJDYtwsh25GI6nMzArClBkkr8jty3fBhvbcRiHvE59M8K5KekV/6WTJQAP2lku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578061; c=relaxed/simple;
	bh=GQD8nbbDsNHQsd73W+T2i089oaA4OlGK1VRcZ+yltR4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=prfeDAq5J32a0rwybDPWWt8wP+7B/7dWG2dpcM0gPP3psH2gFDJvZcQOCC0VV11x0DQylB0RAkGvL5XtXrNpciQMevmbvxpJCDIH3lOWAHmq5H2rqJHRi0Nosvel44RZPm5aSPTBn4AwJI8s4aev1x7sOl/LDfybZdwKk1lRoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9DpBskI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731578060; x=1763114060;
  h=date:from:to:cc:subject:message-id;
  bh=GQD8nbbDsNHQsd73W+T2i089oaA4OlGK1VRcZ+yltR4=;
  b=H9DpBskIVlZvLckpH1iw+wFE2fEBOotae22IxX3guZW4P2tcgQ/N35LD
   7p0/pnX/6lDzZnPzHxqKV0pb4shmRGiIZ89jXtm8ULJ4fYdUSUB+XXDPZ
   3TI0EmdoDxQ+6TiM+rM14kB/zwsqp42G6mlRhOCVpEhzxFns4YIhiKYUf
   J6m8MwEaI9bzbzdv+2UABJ8Di4udY2tiXztSGfc8GHUztHYOBC4/gxwUR
   Tr8eDj9pHMo14z+1Hxkbx5cuTdfL8awHA5Z5lnc+U2JEFFi+cMLvH7a/J
   0i1GxCPQKih1KsTt5RSAqQGxZ+RJIU3xpCX98/LSN8Ax5FkgGvzmVS4Bz
   Q==;
X-CSE-ConnectionGUID: XlevoA8FRlKS+1gPXGpkdg==
X-CSE-MsgGUID: o9xvcVC9Sqqq/SQigQc+tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="54046511"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="54046511"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 01:54:20 -0800
X-CSE-ConnectionGUID: FJU8U/YsQ9mcs92i5btG/Q==
X-CSE-MsgGUID: 0+vt01BpTjub8UEjGwODRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125653480"
Received: from lkp-server01.sh.intel.com (HELO cf353f978a24) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 01:54:19 -0800
Received: from kbuild by cf353f978a24 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBWYK-00002S-1R;
	Thu, 14 Nov 2024 09:54:16 +0000
Date: Thu, 14 Nov 2024 17:53:56 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:endpoint] BUILD SUCCESS
 f85525aaad42d60ed438542afe69f6f25597eda2
Message-ID: <202411141747.pEaOJdfq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
branch HEAD: f85525aaad42d60ed438542afe69f6f25597eda2  PCI: endpoint: Clear secondary (not primary) EPC in pci_epc_remove_epf()

elapsed time: 734m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-14.2.0
alpha                  allyesconfig    gcc-14.2.0
arc                    allmodconfig    gcc-13.2.0
arc                     allnoconfig    gcc-13.2.0
arc                    allyesconfig    gcc-13.2.0
arc         randconfig-001-20241114    gcc-13.2.0
arc         randconfig-002-20241114    gcc-13.2.0
arm                    allmodconfig    gcc-14.2.0
arm                     allnoconfig    clang-20
arm                    allyesconfig    gcc-14.2.0
arm         randconfig-001-20241114    gcc-14.2.0
arm         randconfig-002-20241114    gcc-14.2.0
arm         randconfig-003-20241114    gcc-14.2.0
arm         randconfig-004-20241114    clang-14
arm64                  allmodconfig    clang-20
arm64                   allnoconfig    gcc-14.2.0
arm64       randconfig-001-20241114    clang-20
arm64       randconfig-002-20241114    gcc-14.2.0
arm64       randconfig-003-20241114    gcc-14.2.0
arm64       randconfig-004-20241114    gcc-14.2.0
csky                    allnoconfig    gcc-14.2.0
csky        randconfig-001-20241114    gcc-14.2.0
csky        randconfig-002-20241114    gcc-14.2.0
hexagon                allmodconfig    clang-20
hexagon                 allnoconfig    clang-20
hexagon                allyesconfig    clang-20
hexagon     randconfig-001-20241114    clang-20
hexagon     randconfig-002-20241114    clang-20
i386                   allmodconfig    gcc-12
i386                    allnoconfig    gcc-12
i386                   allyesconfig    gcc-12
i386                      defconfig    clang-19
loongarch              allmodconfig    gcc-14.2.0
loongarch               allnoconfig    gcc-14.2.0
loongarch   randconfig-001-20241114    gcc-14.2.0
loongarch   randconfig-002-20241114    gcc-14.2.0
m68k                   allmodconfig    gcc-14.2.0
m68k                    allnoconfig    gcc-14.2.0
m68k                   allyesconfig    gcc-14.2.0
microblaze             allmodconfig    gcc-14.2.0
microblaze              allnoconfig    gcc-14.2.0
microblaze             allyesconfig    gcc-14.2.0
mips                    allnoconfig    gcc-14.2.0
nios2                   allnoconfig    gcc-14.2.0
nios2       randconfig-001-20241114    gcc-14.2.0
nios2       randconfig-002-20241114    gcc-14.2.0
openrisc                allnoconfig    gcc-14.2.0
openrisc               allyesconfig    gcc-14.2.0
openrisc                  defconfig    gcc-14.2.0
parisc                 allmodconfig    gcc-14.2.0
parisc                  allnoconfig    gcc-14.2.0
parisc                 allyesconfig    gcc-14.2.0
parisc                    defconfig    gcc-14.2.0
parisc      randconfig-001-20241114    gcc-14.2.0
powerpc                allmodconfig    gcc-14.2.0
powerpc                 allnoconfig    gcc-14.2.0
powerpc                allyesconfig    clang-20
riscv                  allmodconfig    clang-20
riscv                   allnoconfig    gcc-14.2.0
riscv                  allyesconfig    clang-20
riscv                     defconfig    clang-20
s390                   allmodconfig    clang-20
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.2.0
s390                      defconfig    clang-20
sh                     allmodconfig    gcc-14.2.0
sh                      allnoconfig    gcc-14.2.0
sh                     allyesconfig    gcc-14.2.0
sh                        defconfig    gcc-14.2.0
sparc                  allmodconfig    gcc-14.2.0
sparc64                   defconfig    gcc-14.2.0
um                     allmodconfig    clang-20
um                      allnoconfig    clang-17
um                     allyesconfig    gcc-12
x86_64                  allnoconfig    clang-19
x86_64                 allyesconfig    clang-19
x86_64                    defconfig    gcc-11
x86_64                        kexec    clang-19
x86_64                     rhel-8.3    gcc-12
xtensa                  allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

