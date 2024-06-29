Return-Path: <linux-pci+bounces-9431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A7791CAF0
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 06:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A05A1C21D68
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE21DA53;
	Sat, 29 Jun 2024 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddCivs1C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF15320F
	for <linux-pci@vger.kernel.org>; Sat, 29 Jun 2024 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719634581; cv=none; b=agUmJ4Z56Y2eBlILEcTHvkICWgDFVm03pZNX68TP1UyVpX301WMn6Jm0WCi9Ym+O9dHcPoj7mJmHPNR+/hmo21OzBVjTymrzstIob8MuoBqVt2ThTZqZLbnYlJ5m1YvsQGme/wJlRdZRvgj1/CaDoc+uUogTGEEtEDj0kQKqwJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719634581; c=relaxed/simple;
	bh=AwqbzmCKTnf0HIzPHAO/gP7e1GN2/5XpG9DDw8FJqws=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uxP+7zRQZIJ0RvB+cqs7gLDaGk4nCqNqXN3tkNeXJkjqSXEYx+PYPguULnpR7ZGSJdchbmESTPL97WikAk2IOOyDbJRIMzKeAJtUPAFj6I0WSyyarBo7ihIsd12vTEwxlTOB/2VcfmSELBbXRL5sraEwSpuWxohttrXKl/maphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddCivs1C; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719634580; x=1751170580;
  h=date:from:to:cc:subject:message-id;
  bh=AwqbzmCKTnf0HIzPHAO/gP7e1GN2/5XpG9DDw8FJqws=;
  b=ddCivs1CQIjFptmlQX0VWsbNZvjyVhNwsqvGBHOwlQl6jYwXJEUpngWB
   jdNdtpoWKpBmo9xELWxMNZBvdG5inKyxyqovm6pkoC6lN2ZmjAy7CkMFj
   kjpMB/anDiepbYqVkqHj/Dsk9C6JE62DgVINrBlG3G5G+ywWWE3gzMH91
   1ovaRs2PSjGeAYXIhokRpGsdK/nWBAVyNKVexYa+Yvt0OeFXcJD6Vmkbl
   UCHX2Bjcx8fAKMCeW12bEjR1HCckXsrbZvZ+0TzxCJx5BmTlvkBYmBIPb
   TvODUPL2KQz1qF7hoGGfvNYtF2ecjAP6cniWREBS2DWGFjUzU6Rub8aoC
   Q==;
X-CSE-ConnectionGUID: GKTLBWbfRlSx92NicJW6tw==
X-CSE-MsgGUID: XUu+gGZ4THeQEkFcJrPNIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16664095"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16664095"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 21:16:19 -0700
X-CSE-ConnectionGUID: q6RKE63IQAuWxR5fxxcqJw==
X-CSE-MsgGUID: n83Eyv/BRUWwUvBoaMzzKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="76116655"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Jun 2024 21:16:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNPVU-000Iwc-2s;
	Sat, 29 Jun 2024 04:16:12 +0000
Date: Sat, 29 Jun 2024 12:15:43 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:hotplug] BUILD SUCCESS
 618b29a346979aedcb80f19a97a3f23fa757bc7e
Message-ID: <202406291242.OZilqPv5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git hotplug
branch HEAD: 618b29a346979aedcb80f19a97a3f23fa757bc7e  PCI: acpiphp: Add missing MODULE_DESCRIPTION() macro

elapsed time: 15101m

configs tested: 47
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-005-20240619   gcc-7
i386         buildonly-randconfig-006-20240619   gcc-7
i386                                defconfig   clang-18
i386                  randconfig-001-20240619   gcc-7
i386                  randconfig-002-20240619   gcc-7
i386                  randconfig-004-20240619   gcc-7
i386                  randconfig-006-20240619   gcc-9
i386                  randconfig-013-20240619   gcc-13
i386                  randconfig-016-20240619   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

