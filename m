Return-Path: <linux-pci+bounces-15311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696A9B04E0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B716283A61
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6462AD31;
	Fri, 25 Oct 2024 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrUIqS5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572A143744
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864858; cv=none; b=S6Mqrq2BPgl8O34i/TUIKFa3WnG3c/wlzkby3XubmPrQqkWMP7ArtYI1ZkdL1c2o4I/HT4ACAjJ2dWJWM46wixntYBxC4HD8dvfHDa4vCJSUQhMdQcKA1HXeB4lOqxXOgK11Db178pX98wd8EivdSbdhrE81hSqfBIIW7PTWVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864858; c=relaxed/simple;
	bh=sfeMvxnsKa610l3g0XtcCqYynCw85W+htMeF3y49fBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnRUMuSwt7uE3Cl7CZpCeMAW4cQ9NyiVGZWhMp1RGxpvPSz+/zldSQBvyWilKQYdrl+rB/xaBB1wxS/g4oc+P9yFq8HRnO1YfeIHBvZp+i2YeSOH2jLuI4SQ9SVZBtoC+U3S4bgGMOKXnfj9xH8tthtxXtis5bGHniJJghTpi4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrUIqS5a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864857; x=1761400857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sfeMvxnsKa610l3g0XtcCqYynCw85W+htMeF3y49fBk=;
  b=KrUIqS5a/+f7ty9lNVPjEwFgVgUMAcWg9uJlP5zIwWDH/eRD7q3PTFI2
   G5rLY0pP/Y14gnYIPNOulDiRBZswUEo+/kaMio9nFLgb4TbMlp564YoqG
   +o+LYlYrJp0wk7aLH8gtemdabFXYlx5KzCF3ej06VeeXF/3q816smIBpM
   8r/6e0k/LUZMdMkzRZK3BBbPZsYnG87pwOmDm/HaVskTyUM5BlqZvQK3X
   +rPn+lTiu2JDIK4XKEhrYm7MtnG4cn65E2VY4IoR+6EsyIzFTE20b48UV
   j3MwxWyI++pxjkoDZ79KhS41K0OcVT18yNtMPogvhwX5Trz2Lgpa9WV8Z
   w==;
X-CSE-ConnectionGUID: Aj+DE7MBSGukLCAX9OwNjg==
X-CSE-MsgGUID: ujME5DWuQxaOWsvdTnqgEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29752865"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29752865"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:00:57 -0700
X-CSE-ConnectionGUID: eqvnk4ZLSZaIvmMwjt4bvA==
X-CSE-MsgGUID: j4hfAorlSRizJL5KyhWycA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81232310"
Received: from arl-s-03.igk.intel.com ([10.91.111.103])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:00:55 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [RFC PATCH v1 3/3] PCI: vmd: Add WA for VMD PCH rootbus support
Date: Fri, 25 Oct 2024 17:01:53 +0200
Message-Id: <20241025150153.983306-4-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241025150153.983306-1-szymon.durawa@linux.intel.com>
References: <20241025150153.983306-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMD PCH rootbus primary number is 0x80 and pci_scan_bridge_extend()
cannot assign it as "hard-wired to 0" and marks setup as broken. To
avoid this, PCH bus number has to be the same as PCH primary number.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 842b70a21325..bb47e0a76c89 100755
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -404,8 +404,22 @@ static inline u8 vmd_has_pch_rootbus(struct vmd_dev *vmd)
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
-	unsigned int busnr_ecam = bus->number - vmd->busn_start[VMD_BUS_0];
-	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
+	unsigned char bus_number;
+	unsigned int busnr_ecam;
+	u32 offset;
+
+	/*
+	 * VMD WA: for PCH rootbus, bus number is set to VMD_PRIMARY_PCH_BUS
+	 * (see comment in vmd_create_pch_bus()) but original value is 0xE1
+	 * which is stored in vmd->busn_start[VMD_BUS_1].
+	 */
+	if (vmd_has_pch_rootbus(vmd) && bus->number == VMD_PRIMARY_PCH_BUS)
+		bus_number = vmd->busn_start[VMD_BUS_1];
+	else
+		bus_number = bus->number;
+
+	busnr_ecam = bus_number - vmd->busn_start[VMD_BUS_0];
+	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
 
 	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
 		return NULL;
@@ -1023,6 +1037,14 @@ static int vmd_create_pch_bus(struct vmd_dev *vmd, struct pci_sysdata *sd,
 	 */
 	vmd->bus[VMD_BUS_1]->primary = VMD_PRIMARY_PCH_BUS;
 
+	/* This is a workaround for pci_scan_bridge_extend() code.
+	 * It assigns setup as broken when primary != bus->number and
+	 * for PCH rootbus primary is not "hard-wired to 0".
+	 * To avoid this, vmd->bus[VMD_BUS_1]->number and
+	 * vmd->bus[VMD_BUS_1]->primary are updated to the same value.
+	 */
+	vmd->bus[VMD_BUS_1]->number = VMD_PRIMARY_PCH_BUS;
+
 	vmd_copy_host_bridge_flags(
 		pci_find_host_bridge(vmd->dev->bus),
 		to_pci_host_bridge(vmd->bus[VMD_BUS_1]->bridge));
-- 
2.39.3


