Return-Path: <linux-pci+bounces-15861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA769BA3C4
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 04:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A209F1F214C5
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 03:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95870804;
	Sun,  3 Nov 2024 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rmd7IKXc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007BA31
	for <linux-pci@vger.kernel.org>; Sun,  3 Nov 2024 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730604554; cv=none; b=WikOBw8LKwnlGwZ1f2nBmuLDBuF+jfc+QgadJKiWlkbB/CvD10kRZuAx6LxjtlqauyelbPsSRat+79rZBsrAgyNTCMo/3k87u/F7exAzp5jPRwXTnD/XSdaDVR4G4q+SE2lkeSkSbEQ7VEocHmPLG9VMZ92MGWQZ4fG663LbwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730604554; c=relaxed/simple;
	bh=wVd9ShxhhMHoL9R6fMnFoZ4osI/lxGuFcnvKf0l+UjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dXpLmHFgBt1eRcEs5kA0xyQ65dLuAWcIoduEGiaIyfte5GxY30qUNBOxtPXFJuD+J3+8yW2eu1TERknaWDbDLkJP9jcWDKHFzVBB3tn+KN4LuFCN+Q9qkFnMsmzMctI3Iux0wWFa12DHLj7HRT7+KOkcGl8FihJL3kjQY7L5x48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rmd7IKXc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730604552; x=1762140552;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wVd9ShxhhMHoL9R6fMnFoZ4osI/lxGuFcnvKf0l+UjE=;
  b=Rmd7IKXcc9uXOColabd5Mlxka9gnEKENXjdW+bmY6BqaPTWGNMJ5XGGO
   86kquOsSOjVBeAeySRf5JgtFHRdiZWeNl0rWBrYHNSGUAdQp3E++R3VDu
   AOheFsuU2/MnNf5h0ET5jfbm8MaZb3UNNu53ORiEqzRMPRgsion8+0iA9
   PRhMUOiSLLw9NtWhC0RnLJ8LEDub54tqPiZ+1olglGavrCyDc5jo64fFM
   dCQrKzuf4E9A8eSoJFbHw/J6p/5KL60V88+Jp6yUYsggBit6W+J6V/Lqf
   muR+VQe3JPdnH8aHhe3ya0yt4oxMMm9FivrL1TwG2kKCf1TL+/RAYj0I2
   Q==;
X-CSE-ConnectionGUID: tBd5DnCET/WQcQTZfQzeaA==
X-CSE-MsgGUID: YkPMaAVKQl6M1n8t06aEZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30180120"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30180120"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 20:29:11 -0700
X-CSE-ConnectionGUID: xP8tnvj6QGq0oFHLWyzYjg==
X-CSE-MsgGUID: fer6oaBkTeSnz0OxYNLCYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="87252331"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 02 Nov 2024 20:29:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7RIZ-000jdh-2W;
	Sun, 03 Nov 2024 03:29:07 +0000
Date: Sun, 03 Nov 2024 11:28:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Krzysztof =?utf-8?Q?Wilczy=C5=84ski"?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:bwctrl] BUILD REGRESSION
 5ccc52fd1e5a9a7602b6e20ce931a7fd4f3be87b
Message-ID: <202411031100.rrMzgVjk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
branch HEAD: 5ccc52fd1e5a9a7602b6e20ce931a7fd4f3be87b  PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202411030310.MsYt3PLH-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202411030348.K5M6Sbow-lkp@intel.com

    drivers/pci/hotplug/../pci.h:833:20: warning: 'of_pci_is_supply_present' declared 'static' but never defined [-Wunused-function]
    drivers/pci/msi/../pci.h:833:20: warning: 'of_pci_is_supply_present' declared 'static' but never defined [-Wunused-function]
    drivers/pci/msi/../pci.h:834:1: error: expected identifier or '('
    drivers/pci/msi/../pci.h:834:1: error: expected identifier or '(' before '{' token
    drivers/pci/pci.h:833:20: warning: 'of_pci_is_supply_present' declared 'static' but never defined [-Wunused-function]
    drivers/pci/pci.h:833:20: warning: 'of_pci_is_supply_present' used but never defined
    drivers/pci/pcie/../pci.h:833:20: warning: 'of_pci_is_supply_present' declared 'static' but never defined [-Wunused-function]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allnoconfig
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- alpha-defconfig
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- i386-defconfig
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- i386-randconfig-012-20241103
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- i386-randconfig-013-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- i386-randconfig-014-20241103
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- i386-randconfig-016-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- i386-randconfig-052-20241103
|   |-- drivers-pci-hotplug-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- i386-randconfig-054-20241103
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- mips-ath25_defconfig
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- parisc-defconfig
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- parisc64-defconfig
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- s390-defconfig
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- s390-randconfig-002-20241103
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- x86_64-buildonly-randconfig-004-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-defconfig
|   |-- drivers-pci-hotplug-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-kexec
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- x86_64-randconfig-001-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-002-20241103
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- x86_64-randconfig-003-20241103
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- x86_64-randconfig-005-20241103
|   |-- drivers-pci-hotplug-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-006-20241103
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- x86_64-randconfig-011-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-012-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-013-20241103
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- x86_64-randconfig-015-20241103
|   |-- drivers-pci-hotplug-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-016-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-072-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-073-20241103
|   `-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(
|-- x86_64-randconfig-074-20241103
|   |-- drivers-pci-hotplug-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-103-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-104-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|-- x86_64-randconfig-161-20241103
|   |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
|   |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
|   |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
|   `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
`-- x86_64-rhel-8.3
    |-- drivers-pci-hotplug-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
    |-- drivers-pci-msi-..-pci.h:error:expected-identifier-or-(-before-token
    |-- drivers-pci-msi-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
    |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined
    |-- drivers-pci-pci.h:warning:of_pci_is_supply_present-used-but-never-defined
    `-- drivers-pci-pcie-..-pci.h:warning:of_pci_is_supply_present-declared-static-but-never-defined

elapsed time: 744m

configs tested: 148
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241103    gcc-14.1.0
arc                   randconfig-002-20241103    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                     davinci_all_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                   randconfig-001-20241103    gcc-14.1.0
arm                   randconfig-002-20241103    gcc-14.1.0
arm                   randconfig-003-20241103    gcc-14.1.0
arm                   randconfig-004-20241103    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241103    gcc-14.1.0
arm64                 randconfig-002-20241103    gcc-14.1.0
arm64                 randconfig-003-20241103    gcc-14.1.0
arm64                 randconfig-004-20241103    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241103    gcc-14.1.0
csky                  randconfig-002-20241103    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241103    gcc-14.1.0
hexagon               randconfig-002-20241103    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241103    clang-19
i386        buildonly-randconfig-002-20241103    clang-19
i386        buildonly-randconfig-003-20241103    clang-19
i386        buildonly-randconfig-004-20241103    clang-19
i386        buildonly-randconfig-005-20241103    clang-19
i386        buildonly-randconfig-006-20241103    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241103    clang-19
i386                  randconfig-002-20241103    clang-19
i386                  randconfig-003-20241103    clang-19
i386                  randconfig-004-20241103    clang-19
i386                  randconfig-005-20241103    clang-19
i386                  randconfig-006-20241103    clang-19
i386                  randconfig-011-20241103    clang-19
i386                  randconfig-012-20241103    clang-19
i386                  randconfig-013-20241103    clang-19
i386                  randconfig-014-20241103    clang-19
i386                  randconfig-015-20241103    clang-19
i386                  randconfig-016-20241103    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241103    gcc-14.1.0
loongarch             randconfig-002-20241103    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq5_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241103    gcc-14.1.0
nios2                 randconfig-002-20241103    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
openrisc                       virt_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241103    gcc-14.1.0
parisc                randconfig-002-20241103    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                    gamecube_defconfig    gcc-14.1.0
powerpc                      pasemi_defconfig    gcc-14.1.0
powerpc                      pmac32_defconfig    gcc-14.1.0
powerpc                      ppc6xx_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241103    gcc-14.1.0
powerpc               randconfig-002-20241103    gcc-14.1.0
powerpc               randconfig-003-20241103    gcc-14.1.0
powerpc                     redwood_defconfig    gcc-14.1.0
powerpc64                        alldefconfig    gcc-14.1.0
powerpc64             randconfig-001-20241103    gcc-14.1.0
powerpc64             randconfig-002-20241103    gcc-14.1.0
powerpc64             randconfig-003-20241103    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241103    gcc-14.1.0
riscv                 randconfig-002-20241103    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241103    gcc-14.1.0
s390                  randconfig-002-20241103    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241103    gcc-14.1.0
sh                    randconfig-002-20241103    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241103    gcc-14.1.0
sparc64               randconfig-002-20241103    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                    randconfig-001-20241103    gcc-14.1.0
um                    randconfig-002-20241103    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241103    gcc-14.1.0
xtensa                randconfig-002-20241103    gcc-14.1.0
xtensa                    xip_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

