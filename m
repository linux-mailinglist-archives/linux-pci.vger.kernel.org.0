Return-Path: <linux-pci+bounces-21516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A1A364FC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8D5171AE1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BC5267711;
	Fri, 14 Feb 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7Qln3Zg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A0267AEF
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555398; cv=none; b=ZuFCiseMy0QOLCL5agbFCNCkq6f5JY7k06y29Hldn2cBbjInaT44b+RvWujy4X2zatniHQ6aTqnb3LITTHEE6Zv/WX6VRNzbvalKppUkprCHg6MUNPC8P3xFsisBpKNya70zVAx3ySZNDrLg4yAXhaeN+fIP3hlznt3UbNgK+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555398; c=relaxed/simple;
	bh=CL+SxOSWvseoKtNPhfapq8awK5WiJpGeyYdyYaqQGDk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JP8lc02pDIc8y9BG6raTtRiNk56gzBXlWOo4mvqSa72XySMo5UxR0PCMzrv/3bgo5nqKWVNl/JUfBinMZS5QOYtmq5FLdbJQcH4jCLDbQTJFiTke17qbk0L3alKsuOsaRQy/bkVmlFQPAF8xfPbf2MMkSpoVAtuRQY9T+h3cgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7Qln3Zg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739555396; x=1771091396;
  h=date:from:to:cc:subject:message-id;
  bh=CL+SxOSWvseoKtNPhfapq8awK5WiJpGeyYdyYaqQGDk=;
  b=m7Qln3ZgtVTxFe0Cacng+ormDTcILmFlXyUsF/UFIdOqK2ZAQFSajuR+
   h4VIAX48gYKOh7Ai4ULpawlPCGdcHSSj7FGp6tW0e/L1fWbDeaOBU/wwE
   cBOUBtr4sGA6vsypW1osNCMpzBIWPDFVWBGyBSAaSnLknTdfE1j17jhpr
   mgaE8IkqYkmZiQPFpQdydc5yMx1WYyWIcl5FwryKPBYAazLH6YM/7GkMw
   NRhlPcuVkTEbM35FGLWM6kEkdc3DN538RcXXJDt9+d1SjRc7lL948Z0vS
   rQIo79wptECh3cGxw1JioSqpSTJLVYjebB48QXjsnH3xvnxOaKWHqvNAY
   Q==;
X-CSE-ConnectionGUID: zd+vlN5IQjKInS+79OEnAQ==
X-CSE-MsgGUID: bDqzeu2NR9qfziNz+JQ+pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40184209"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40184209"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:49:54 -0800
X-CSE-ConnectionGUID: BAOHPkNoReyuFfr+yumqrw==
X-CSE-MsgGUID: 5Z2DvoVVS0uES7j896i3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113492805"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Feb 2025 09:49:52 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tizp0-0019z2-0l;
	Fri, 14 Feb 2025 17:49:50 +0000
Date: Sat, 15 Feb 2025 01:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [pci:aer] BUILD REGRESSION
 c928d117f57c9ca1801c0e37019a357f86eb96f1
Message-ID: <202502150156.ICLGJ6dY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
branch HEAD: c928d117f57c9ca1801c0e37019a357f86eb96f1  PCI: Descope pci_printk() to aer_printk()

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202502141005.inOeb0pP-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202502141105.6eIoURaG-lkp@intel.com

    drivers/pci/hotplug/shpchp.h:256:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/pci/hotplug/shpchp.h:51:25: error: implicit declaration of function 'pci_printk'; did you mean 'pci_intx'? [-Werror=implicit-function-declaration]
    drivers/pci/hotplug/shpchp_core.c:99:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/pci/hotplug/shpchp_ctrl.c:51:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/pci/hotplug/shpchp_hpc.c:305:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/pci/hotplug/shpchp_pci.c:70:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- arc-allmodconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- arc-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- arc-randconfig-002-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- arm-allmodconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- arm-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- arm64-allmodconfig
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- arm64-randconfig-001-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- arm64-randconfig-004-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- csky-randconfig-r122-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- i386-allmodconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- i386-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- i386-buildonly-randconfig-004-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- i386-buildonly-randconfig-005-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- i386-randconfig-003-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- i386-randconfig-007-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- i386-randconfig-013-20250214
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-061-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- i386-randconfig-063-20250214
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- i386-randconfig-141-20250214
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- loongarch-allmodconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- loongarch-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- loongarch-defconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- loongarch-randconfig-001-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- microblaze-allmodconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- microblaze-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- mips-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- openrisc-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- openrisc-randconfig-r073-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- parisc-allmodconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- parisc-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- powerpc-allmodconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- powerpc-allyesconfig
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- powerpc-randconfig-002-20250214
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- powerpc64-randconfig-001-20250214
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-allmodconfig
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-allyesconfig
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-allmodconfig
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- s390-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- s390-randconfig-001-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- sparc-allmodconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- um-allmodconfig
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- um-allyesconfig
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- um-randconfig-001-20250214
|   `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk
|-- x86_64-allyesconfig
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-buildonly-randconfig-001-20250214
|   |-- drivers-pci-hotplug-shpchp.h:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_core.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_ctrl.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-pci-hotplug-shpchp_hpc.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-pci-hotplug-shpchp_pci.c:error:call-to-undeclared-function-pci_printk-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- xtensa-allyesconfig
    `-- drivers-pci-hotplug-shpchp.h:error:implicit-declaration-of-function-pci_printk

elapsed time: 1171m

configs tested: 212
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20250214    gcc-13.2.0
arc                   randconfig-001-20250214    gcc-14.2.0
arc                   randconfig-002-20250214    gcc-13.2.0
arc                   randconfig-002-20250214    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250214    clang-16
arm                   randconfig-001-20250214    gcc-14.2.0
arm                   randconfig-002-20250214    gcc-14.2.0
arm                   randconfig-003-20250214    clang-21
arm                   randconfig-003-20250214    gcc-14.2.0
arm                   randconfig-004-20250214    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250214    gcc-14.2.0
arm64                 randconfig-002-20250214    gcc-14.2.0
arm64                 randconfig-003-20250214    gcc-14.2.0
arm64                 randconfig-004-20250214    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250214    clang-21
csky                  randconfig-001-20250214    gcc-14.2.0
csky                  randconfig-002-20250214    clang-21
csky                  randconfig-002-20250214    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250214    clang-21
hexagon               randconfig-002-20250214    clang-15
hexagon               randconfig-002-20250214    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250214    gcc-12
i386        buildonly-randconfig-002-20250214    gcc-12
i386        buildonly-randconfig-003-20250214    clang-19
i386        buildonly-randconfig-003-20250214    gcc-12
i386        buildonly-randconfig-004-20250214    gcc-12
i386        buildonly-randconfig-005-20250214    gcc-12
i386        buildonly-randconfig-006-20250214    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250214    gcc-12
i386                  randconfig-002-20250214    gcc-12
i386                  randconfig-003-20250214    gcc-12
i386                  randconfig-004-20250214    gcc-12
i386                  randconfig-005-20250214    gcc-12
i386                  randconfig-006-20250214    gcc-12
i386                  randconfig-007-20250214    gcc-12
i386                  randconfig-011-20250214    clang-19
i386                  randconfig-012-20250214    clang-19
i386                  randconfig-013-20250214    clang-19
i386                  randconfig-014-20250214    clang-19
i386                  randconfig-015-20250214    clang-19
i386                  randconfig-016-20250214    clang-19
i386                  randconfig-017-20250214    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250214    clang-21
loongarch             randconfig-001-20250214    gcc-14.2.0
loongarch             randconfig-002-20250214    clang-21
loongarch             randconfig-002-20250214    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250214    clang-21
nios2                 randconfig-001-20250214    gcc-14.2.0
nios2                 randconfig-002-20250214    clang-21
nios2                 randconfig-002-20250214    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250214    clang-21
parisc                randconfig-001-20250214    gcc-14.2.0
parisc                randconfig-002-20250214    clang-21
parisc                randconfig-002-20250214    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250214    clang-21
powerpc               randconfig-001-20250214    gcc-14.2.0
powerpc               randconfig-002-20250214    clang-18
powerpc               randconfig-002-20250214    clang-21
powerpc               randconfig-003-20250214    clang-21
powerpc64             randconfig-001-20250214    clang-18
powerpc64             randconfig-001-20250214    clang-21
powerpc64             randconfig-002-20250214    clang-21
powerpc64             randconfig-002-20250214    gcc-14.2.0
powerpc64             randconfig-003-20250214    clang-21
powerpc64             randconfig-003-20250214    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250214    clang-16
riscv                 randconfig-001-20250214    clang-18
riscv                 randconfig-002-20250214    clang-16
riscv                 randconfig-002-20250214    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250214    clang-16
s390                  randconfig-001-20250214    gcc-14.2.0
s390                  randconfig-002-20250214    clang-16
s390                  randconfig-002-20250214    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250214    clang-16
sh                    randconfig-001-20250214    gcc-14.2.0
sh                    randconfig-002-20250214    clang-16
sh                    randconfig-002-20250214    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250214    clang-16
sparc                 randconfig-001-20250214    gcc-14.2.0
sparc                 randconfig-002-20250214    clang-16
sparc                 randconfig-002-20250214    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250214    clang-16
sparc64               randconfig-001-20250214    gcc-14.2.0
sparc64               randconfig-002-20250214    clang-16
sparc64               randconfig-002-20250214    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250214    clang-16
um                    randconfig-001-20250214    gcc-12
um                    randconfig-002-20250214    clang-16
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250214    clang-19
x86_64      buildonly-randconfig-001-20250214    gcc-12
x86_64      buildonly-randconfig-002-20250214    clang-19
x86_64      buildonly-randconfig-002-20250214    gcc-12
x86_64      buildonly-randconfig-003-20250214    gcc-12
x86_64      buildonly-randconfig-004-20250214    clang-19
x86_64      buildonly-randconfig-004-20250214    gcc-12
x86_64      buildonly-randconfig-005-20250214    gcc-12
x86_64      buildonly-randconfig-006-20250214    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250214    clang-19
x86_64                randconfig-002-20250214    clang-19
x86_64                randconfig-003-20250214    clang-19
x86_64                randconfig-004-20250214    clang-19
x86_64                randconfig-005-20250214    clang-19
x86_64                randconfig-006-20250214    clang-19
x86_64                randconfig-007-20250214    clang-19
x86_64                randconfig-008-20250214    clang-19
x86_64                randconfig-071-20250214    gcc-12
x86_64                randconfig-072-20250214    gcc-12
x86_64                randconfig-073-20250214    gcc-12
x86_64                randconfig-074-20250214    gcc-12
x86_64                randconfig-075-20250214    gcc-12
x86_64                randconfig-076-20250214    gcc-12
x86_64                randconfig-077-20250214    gcc-12
x86_64                randconfig-078-20250214    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250214    clang-16
xtensa                randconfig-001-20250214    gcc-14.2.0
xtensa                randconfig-002-20250214    clang-16
xtensa                randconfig-002-20250214    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

