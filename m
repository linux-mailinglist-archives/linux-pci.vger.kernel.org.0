Return-Path: <linux-pci+bounces-15308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646419B04D8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9589D1C20B41
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE35C21217B;
	Fri, 25 Oct 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LT/2BYst"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01D212168
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864833; cv=none; b=pBaabvwvPKa7HvYc9OFrBniVsQCyZeHCrkErSTbTeAE4MsmKjQ68jI6QuxNcsorqi8P7z22iEp4KJ9KAPSd/4kS5mGxc09pq7xqdklewNpfMmEjsIIDyJSKQDLUkv5nywHleoYvsQAdO42KZNPk9jmOAEJS7Xj32puQjR2Tus8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864833; c=relaxed/simple;
	bh=jq85rSYy0OYaAZe1ng59EUawTwKmW5sahE7Yftyn95o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M6iMEEuYibps+uJ/mFDksubsjMDgI9DGjiClJVoh1RJ6wRdS7TJmjUZsW9PoB+dQ6yBSeJElLLt9NcZ/oEetN/5trzQkneGWFZz0+YxEt24nvrRM9Ll/qc0yupRk3xbsW5bCrix4ry2YRWLpXO4Ot4zQP9YGNjioV0FrWwP+F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LT/2BYst; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864832; x=1761400832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jq85rSYy0OYaAZe1ng59EUawTwKmW5sahE7Yftyn95o=;
  b=LT/2BYst3t13FutyqY4qtJnrgda5uHhvP3/Dw+HNKI4k0lYx7n67Q1Zs
   Kd7kAhYTOxoS74OgmMJGcnIAQSVMWR8KMIcmwj7NtxXeFSCQDx2cBG05L
   XPtzSyZnJLziZh5ECuBXUaJeHeBexi3M6BrpStFfCXi/598i5jEgyrz6+
   iduePmXnms6m/MhrL0IIUwx42V4+U98vTRMTXKYA8LqEbGgvdfohypbrt
   sU8BresdEC/ASgr4bcuEvjv7Kzu1hIcXsEV/O34Sl9p6qo02cPtmwPGRc
   mU3wOVD2rdFzIxcu39j/57NsOiVD4/EpR3kHoXLqz/4vmvxzWJG7yVQfH
   Q==;
X-CSE-ConnectionGUID: 2rXkBgT7Rfm+ijNCweuDZg==
X-CSE-MsgGUID: HbY7UWwDSoCkZKVGe8TDHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29752832"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29752832"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:00:31 -0700
X-CSE-ConnectionGUID: TPEQ/WyJTia+sbcMH2i7jw==
X-CSE-MsgGUID: g7pvVteORMy9/mkiAZvrSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81232280"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:00:30 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [RFC PATCH v1 0/3] VMD add PCH rootbus support
Date: Fri, 25 Oct 2024 17:01:50 +0200
Message-Id: <20241025150153.983306-1-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements the Intel VMD PCH rootbus support inside VMD
module. Current implementation allows VMD to take ownership of devices only on
IOC (Rootbus0). Starting from Intel Arrow Lake VMD exposes PCH rootbus to
allow VMD to own devices on PCH bus (Rootbus1) as well.

Patch 3 : WA for PCH bus enumeration. VMD PCH primary bus number is 0x80 and
          it is correct value. Unfortunately, pci_scan_bridge_extend() function
          assigns setup as broken for bus primary number different than zero.
          Until VMD was limited to IOC, rootbus primary was always set to 0 and
          therfore bus->number was irrelevant. With PCH rootbus primary bus is
          different than 0 (set to 0x80) and pci_scan_bridge_extend() code marks
          setup as broken and restarts enumeration.

I don't know whether pci_scan_bridge_extend() implementation is correct and
whether it can be safety reworked. I propse WA which does not impact on PCI
stack. It updates bus->number to the same number as primary bus value which
allows to pass check for sensible setup in pci_scan_bridge_extend().
From lspci tool perspective this WA is irrelevant:

# lspci -s 10000:80:1d.4 -v
10000:80:1d.4 PCI bridge: Intel Corporation Device 7f34 (rev 10) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0, IRQ 213
    Bus: primary=80, secondary=f1, subordinate=f1, sec-latency=0

lspci tree presentation:
# lspci -tv
-+-[10000:e0]---01.0-[e2]----00.0  Sandisk Corp Western Digital WD Black SN850X NVMe SSD
 +-[10000:80]-+-1d.0  Intel Corporation RST VMD Managed Controller
 |            \-1d.4-[f1]----00.0  Sandisk Corp PC SN735 NVMe SSD (DRAM-less)
 +-[0000:80]-+-12.0  Intel Corporation Device 7f78
[...]
 |           +-1f.5  Intel Corporation Device 7f24
 |           \-1f.6  Intel Corporation Device 550d
 \-[0000:00]-+-00.0  Intel Corporation Device 7d1a
             +-01.0  Intel Corporation RST VMD Managed Controller

This workaround is a main reason it is send as RFC. To move this forward I need
to get maintainer decision whether it is acceptable or not. If not,
it would be great if you can take a look and propose a better solution.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Szymon Durawa (3):
  PCI: vmd: Clean up vmd_enable_domain function
  PCI: vmd: Add VMD PCH rootbus support
  PCI: vmd: Add WA for VMD PCH rootbus support

 drivers/pci/controller/vmd.c | 446 +++++++++++++++++++++++++++--------
 1 file changed, 343 insertions(+), 103 deletions(-)
 mode change 100644 => 100755 drivers/pci/controller/vmd.c

-- 
2.39.3


