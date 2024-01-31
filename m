Return-Path: <linux-pci+bounces-2883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0370E843E2D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 12:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824A51F23B15
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47AD6E2A0;
	Wed, 31 Jan 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQK2Q2vl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6169DFD
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700009; cv=none; b=Kvt6Ac842rYoU+/JqIO9IfRLZKuLExQckN3FAES2OsHsYNnaFYCzcB3yBy2mxGN5Yo5MUmVdKRbdZDaSBL3aHypp7sxERDOLCIp0mk2Oii5Eina6tYVS5Mah7ckliomTIIOWzBdi7NHHLm4oIOVQl2KcFlqlPxNdPK9QuTzRUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700009; c=relaxed/simple;
	bh=2WOOlCBz/TQD0tiKB8nosefwmYV9yVI1hLd2bSr3A7M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KcoY/amz8ObcqJuL2SkPMBIhkULPxvWekiVr6J/9AwGvE8RBp5h8iqfOszdvS7LPpvJjOliAaJxyNhhdSObbRgUnckZWIpeDt8Ay9b4zM2mQn8bsXo2FUmuOr2ceqceHd/xreG7+++CFErN+5MBJIy7+Fk/VTAWxuvdzrmjwrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQK2Q2vl; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706700007; x=1738236007;
  h=date:from:to:cc:subject:message-id;
  bh=2WOOlCBz/TQD0tiKB8nosefwmYV9yVI1hLd2bSr3A7M=;
  b=WQK2Q2vlYVbNBrOtEp2A3Wd1lczPb5TLfK6JmizXml6SiQ58wwGmfQJ7
   CfctmWt2LEJuFfJ4cBgSvjEd0ytZXWfqc7Xn6u+i2jBLX7MujA5+W6GbW
   W8Zqsoo4VWGE0T3RjckxeQ/u6MvIvpUMdo/Bt5+dAQA6k+kMkkqkIVAUR
   CHfXOEAwMvB12E5BxchbXpsmC0FdGw8fRg/lcITBuM0k0nmP2fzBPHtKV
   BGV8oaNebMJgx10zoSblRf5/xn5XNtj0IWwRUVXU9LEG6k6H9PpD2UHwm
   Xdx7vYAv4kIEwqMWB8sjTZAbBeUcmoRGCSxem20BCbv8o73yTElRicpYk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407288496"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407288496"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858781635"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858781635"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2024 03:20:04 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV8dO-0001VA-15;
	Wed, 31 Jan 2024 11:20:02 +0000
Date: Wed, 31 Jan 2024 19:19:06 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-pci@vger.kernel.org
Subject: [linux-next:pending-fixes] BUILD SUCCESS WITH WARNING
 60b9561aaa2811b5bff20d52b08d72bd2183f7cb
Message-ID: <202401311902.KTjhRkMc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: 60b9561aaa2811b5bff20d52b08d72bd2183f7cb  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202401310949.NbpFjuGe-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/pci/bus.c:440: warning: Function parameter or struct member 'cb' not described in 'pci_walk_bus'
drivers/pci/bus.c:440: warning: Function parameter or struct member 'top' not described in 'pci_walk_bus'
drivers/pci/bus.c:440: warning: Function parameter or struct member 'userdata' not described in 'pci_walk_bus'

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allnoconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- alpha-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- alpha-defconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arc-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arc-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arc-randconfig-001-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arm-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arm-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arm64-defconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- csky-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- csky-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- csky-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-defconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-011-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-012-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-013-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-014-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-015-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-016-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- loongarch-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- loongarch-allnoconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- loongarch-defconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- loongarch-randconfig-001-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- loongarch-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- microblaze-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- microblaze-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- microblaze-defconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- mips-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- openrisc-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- parisc-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- parisc-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- parisc-defconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- parisc-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- riscv-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- riscv-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- s390-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- s390-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- s390-randconfig-001-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- s390-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- sparc-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- sparc64-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- sparc64-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- sparc64-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-defconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-randconfig-001-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-randconfig-003-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-randconfig-004-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-randconfig-005-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-randconfig-006-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
`-- xtensa-randconfig-001-20240131
    |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
    |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
    `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
clang_recent_errors
|-- arm-defconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arm-randconfig-001-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arm-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arm-randconfig-003-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- arm64-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-buildonly-randconfig-006-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-001-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-003-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-004-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-005-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-006-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- i386-randconfig-141-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- powerpc-allmodconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- powerpc-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- powerpc-randconfig-001-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- powerpc-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- powerpc-randconfig-003-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- powerpc64-randconfig-001-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- powerpc64-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- powerpc64-randconfig-003-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- riscv-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-allyesconfig
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-buildonly-randconfig-002-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-buildonly-randconfig-003-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-buildonly-randconfig-005-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-randconfig-011-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
|-- x86_64-randconfig-012-20240131
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
|   |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
|   `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus
`-- x86_64-rhel-8.3-rust
    |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-cb-not-described-in-pci_walk_bus
    |-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-top-not-described-in-pci_walk_bus
    `-- drivers-pci-bus.c:warning:Function-parameter-or-struct-member-userdata-not-described-in-pci_walk_bus

elapsed time: 767m

configs tested: 153
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240131   gcc  
arc                   randconfig-002-20240131   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240131   clang
arm                   randconfig-002-20240131   clang
arm                   randconfig-003-20240131   clang
arm                   randconfig-004-20240131   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240131   clang
arm64                 randconfig-002-20240131   clang
arm64                 randconfig-003-20240131   clang
arm64                 randconfig-004-20240131   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240131   gcc  
csky                  randconfig-002-20240131   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240131   clang
hexagon               randconfig-002-20240131   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240131   clang
i386         buildonly-randconfig-002-20240131   clang
i386         buildonly-randconfig-003-20240131   clang
i386         buildonly-randconfig-004-20240131   clang
i386         buildonly-randconfig-005-20240131   clang
i386         buildonly-randconfig-006-20240131   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240131   clang
i386                  randconfig-002-20240131   clang
i386                  randconfig-003-20240131   clang
i386                  randconfig-004-20240131   clang
i386                  randconfig-005-20240131   clang
i386                  randconfig-006-20240131   clang
i386                  randconfig-011-20240131   gcc  
i386                  randconfig-012-20240131   gcc  
i386                  randconfig-013-20240131   gcc  
i386                  randconfig-014-20240131   gcc  
i386                  randconfig-015-20240131   gcc  
i386                  randconfig-016-20240131   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240131   gcc  
loongarch             randconfig-002-20240131   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240131   gcc  
nios2                 randconfig-002-20240131   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240131   gcc  
parisc                randconfig-002-20240131   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240131   clang
powerpc               randconfig-002-20240131   clang
powerpc               randconfig-003-20240131   clang
powerpc64             randconfig-001-20240131   clang
powerpc64             randconfig-002-20240131   clang
powerpc64             randconfig-003-20240131   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240131   clang
riscv                 randconfig-002-20240131   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240131   gcc  
s390                  randconfig-002-20240131   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240131   gcc  
sh                    randconfig-002-20240131   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240131   gcc  
sparc64               randconfig-002-20240131   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240131   clang
um                    randconfig-002-20240131   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240131   clang
x86_64       buildonly-randconfig-002-20240131   clang
x86_64       buildonly-randconfig-003-20240131   clang
x86_64       buildonly-randconfig-004-20240131   clang
x86_64       buildonly-randconfig-005-20240131   clang
x86_64       buildonly-randconfig-006-20240131   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240131   gcc  
x86_64                randconfig-002-20240131   gcc  
x86_64                randconfig-003-20240131   gcc  
x86_64                randconfig-004-20240131   gcc  
x86_64                randconfig-005-20240131   gcc  
x86_64                randconfig-006-20240131   gcc  
x86_64                randconfig-011-20240131   clang
x86_64                randconfig-012-20240131   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240131   gcc  
xtensa                randconfig-002-20240131   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

