Return-Path: <linux-pci+bounces-22124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A20A40D7A
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 09:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D812A189A381
	for <lists+linux-pci@lfdr.de>; Sun, 23 Feb 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A61FCD0C;
	Sun, 23 Feb 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMH8nzdU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C81FC7CE
	for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740300698; cv=none; b=GyhiG5Af6zUo792PWMgQSb+9oMUj1zXqD8WgC4dbuHp/JqpP8Boebldua2VsB2z+GXixWtmVDS/Jiu5orRkMmfeSShfe0CTePihBrQ9ZzdOUx2XM4GenZYxMyY5C1kkI3eNDEenJ+byJyMoWr7py3sY1ZIFBZinGDIp+saFkr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740300698; c=relaxed/simple;
	bh=vR4zBBxGkT0B06lkSNkMJmdXWx+YQRf8sNlkQ8bblsg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SEeyAkgfb7YpEZrQo4O6PpBR7vW69Knsw+xdE32p/r+GLWVZcoBsp9tavNsZliO/tZ+OE5UNlkQ7i+FN6N/Nn/+SASkNuK8y3PGGxFxYp9F2gCSj4nlCd9jMLfEHwkP0a2Y08VP1CLf1hMCsxc9s+tZGFTiFtOGl3L025SAGZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMH8nzdU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740300697; x=1771836697;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vR4zBBxGkT0B06lkSNkMJmdXWx+YQRf8sNlkQ8bblsg=;
  b=VMH8nzdUi4QDm7b11wvMRtAGRtFd+2ej9Ob+LorFUwUAn2gdBuIzThYT
   3+IRkCUzJY8WsHxwhVE5wGp8ypAagCFH2QmBJlnwOEHUxorB4YfkUtk+K
   EdnsFJLPTXDHwvewYqHufhag4gDtzjYvCMJejJRAQh15BQ5PFojqWCAsS
   5wgMMrCG2Mj7BGyfAmSciwSvKJMJ6gM9oOQi4eHMKHi4+CSTsaNDkFi2V
   P9wOhrpIPcdwgN+WIL6IXPpKrm/yaso2Czs80FY+RUfOjijDVe8Dju3Ch
   06Q028Ui9tnFZyyBaCRKaVoaihNoI+DbGjLkO/e0AVzKJ/fI2mFgXz0ZM
   A==;
X-CSE-ConnectionGUID: x7v3+/NbROydoyxJ2YQtxQ==
X-CSE-MsgGUID: AAE+zjvfT7irTRQEFKSINg==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="51284691"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="51284691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 00:51:36 -0800
X-CSE-ConnectionGUID: kkf1OLHkRfm78e5zGBj6gA==
X-CSE-MsgGUID: eoH5LFNWQzG9e7Sf+vGi2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115741266"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2025 00:51:35 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tm7i0-0007E3-23;
	Sun, 23 Feb 2025 08:51:32 +0000
Date: Sun, 23 Feb 2025 16:51:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:dt-bindings] BUILD SUCCESS
 396ecc1626d45496e283fe139afd0ed89b9f02cd
Message-ID: <202502231654.hRj5IynI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git dt-bindings
branch HEAD: 396ecc1626d45496e283fe139afd0ed89b9f02cd  dt-bindings: PCI: Convert fsl,mpc83xx-pcie to YAML

Unverified Warning (likely false positive, kindly check if interested):

    arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: pci@28000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: pci@28000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: pci@28000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: pci@28000000: reg-names:3: 'atu' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: pcie@10000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: pcie@10000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: pcie@10000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp418.dtb: pcie@10000000: reg-names:3: 'atu' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: pci@28000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: pci@28000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: pci@28000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: pci@28000000: reg-names:3: 'atu' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: pcie@10000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: pcie@10000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: pcie@10000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: pcie@10000000: reg-names:3: 'atu' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pci@28000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pci@28000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pci@28000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pci@28000000: reg-names:3: 'atu' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pcie@10000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pcie@10000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pcie@10000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp449.dtb: pcie@10000000: reg-names:3: 'atu' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: pci@28000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: pci@28000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: pci@28000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: pci@28000000: reg-names:3: 'atu' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: pcie@10000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: pcie@10000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: pcie@10000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp453.dtb: pcie@10000000: reg-names:3: 'atu' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: pci@28000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: pci@28000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: pci@28000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: pci@28000000: reg-names:3: 'atu' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: pcie@10000000: reg-names:0: 'parf' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: pcie@10000000: reg-names:1: 'dbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: pcie@10000000: reg-names:2: 'elbi' was expected
    arch/arm64/boot/dts/qcom/ipq9574-rdp454.dtb: pcie@10000000: reg-names:3: 'atu' was expected

Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-051-20250222
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp418.dtb:pci:reg-names:atu-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp418.dtb:pci:reg-names:elbi-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp418.dtb:pci:reg-names:parf-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp418.dtb:pcie:reg-names:atu-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp418.dtb:pcie:reg-names:dbi-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp418.dtb:pcie:reg-names:parf-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp433.dtb:pci:reg-names:elbi-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp433.dtb:pcie:reg-names:elbi-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp433.dtb:pcie:reg-names:parf-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp449.dtb:pci:reg-names:dbi-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp449.dtb:pcie:reg-names:atu-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp449.dtb:pcie:reg-names:dbi-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp449.dtb:pcie:reg-names:parf-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp453.dtb:pci:reg-names:elbi-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp453.dtb:pcie:reg-names:atu-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp453.dtb:pcie:reg-names:elbi-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp453.dtb:pcie:reg-names:parf-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp454.dtb:pci:reg-names:dbi-was-expected
|   |-- arch-arm64-boot-dts-qcom-ipq9574-rdp454.dtb:pci:reg-names:parf-was-expected
|   `-- arch-arm64-boot-dts-qcom-ipq9574-rdp454.dtb:pcie:reg-names:dbi-was-expected
`-- arm64-randconfig-052-20250222
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp418.dtb:pci:reg-names:dbi-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp418.dtb:pcie:reg-names:elbi-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp433.dtb:pci:reg-names:atu-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp433.dtb:pci:reg-names:dbi-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp433.dtb:pci:reg-names:parf-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp433.dtb:pcie:reg-names:atu-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp433.dtb:pcie:reg-names:dbi-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp449.dtb:pci:reg-names:atu-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp449.dtb:pci:reg-names:elbi-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp449.dtb:pci:reg-names:parf-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp449.dtb:pcie:reg-names:elbi-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp453.dtb:pci:reg-names:atu-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp453.dtb:pci:reg-names:dbi-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp453.dtb:pci:reg-names:parf-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp453.dtb:pcie:reg-names:dbi-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp454.dtb:pci:reg-names:atu-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp454.dtb:pci:reg-names:elbi-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp454.dtb:pcie:reg-names:atu-was-expected
    |-- arch-arm64-boot-dts-qcom-ipq9574-rdp454.dtb:pcie:reg-names:elbi-was-expected
    `-- arch-arm64-boot-dts-qcom-ipq9574-rdp454.dtb:pcie:reg-names:parf-was-expected

elapsed time: 1451m

configs tested: 128
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20250222    gcc-13.2.0
arc                   randconfig-002-20250222    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-21
arm                            hisi_defconfig    gcc-14.2.0
arm                         nhk8815_defconfig    clang-21
arm                   randconfig-001-20250222    gcc-14.2.0
arm                   randconfig-002-20250222    gcc-14.2.0
arm                   randconfig-003-20250222    clang-16
arm                   randconfig-004-20250222    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250222    gcc-14.2.0
arm64                 randconfig-002-20250222    clang-21
arm64                 randconfig-003-20250222    clang-18
arm64                 randconfig-004-20250222    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250222    gcc-14.2.0
csky                  randconfig-002-20250222    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250222    clang-17
hexagon               randconfig-002-20250222    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250222    clang-19
i386        buildonly-randconfig-002-20250222    gcc-12
i386        buildonly-randconfig-003-20250222    gcc-12
i386        buildonly-randconfig-004-20250222    clang-19
i386        buildonly-randconfig-005-20250222    gcc-12
i386        buildonly-randconfig-006-20250222    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250222    gcc-14.2.0
loongarch             randconfig-002-20250222    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-19
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250222    gcc-14.2.0
nios2                 randconfig-002-20250222    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250222    gcc-14.2.0
parisc                randconfig-002-20250222    gcc-14.2.0
parisc64                         alldefconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc               mpc834x_itxgp_defconfig    clang-18
powerpc               randconfig-001-20250222    gcc-14.2.0
powerpc               randconfig-002-20250222    gcc-14.2.0
powerpc               randconfig-003-20250222    gcc-14.2.0
powerpc64             randconfig-001-20250222    gcc-14.2.0
powerpc64             randconfig-002-20250222    clang-16
powerpc64             randconfig-003-20250222    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250222    clang-21
riscv                 randconfig-002-20250222    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250222    gcc-14.2.0
s390                  randconfig-002-20250222    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250222    gcc-14.2.0
sh                    randconfig-002-20250222    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250222    gcc-14.2.0
sparc                 randconfig-002-20250222    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250222    gcc-14.2.0
sparc64               randconfig-002-20250222    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250222    gcc-12
um                    randconfig-002-20250222    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250222    clang-19
x86_64      buildonly-randconfig-002-20250222    gcc-12
x86_64      buildonly-randconfig-003-20250222    gcc-12
x86_64      buildonly-randconfig-004-20250222    clang-19
x86_64      buildonly-randconfig-005-20250222    clang-19
x86_64      buildonly-randconfig-006-20250222    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250222    gcc-14.2.0
xtensa                randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

