Return-Path: <linux-pci+bounces-11905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E0959083
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 00:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96A11C203BC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669A414D444;
	Tue, 20 Aug 2024 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4dAoVC1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35E3A8D2
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193160; cv=none; b=HcZsgqLFgeLxDAZXAPho46W7agkxT/7mJobjnvAV4DTAlTGy3I7RNwbYljzzLUlYDENrlulgj8qp/KumXDRlykA/gcqLbszKrVxu8H6CGYQ0m/Hzw551hhAGn75okLYSmfN1qvKuqLkPAC0gbqSvVGici6XPz5yhE8VXtTkABYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193160; c=relaxed/simple;
	bh=UDYOU1i7bcNe5odRgJ3NWSVG90wWzQaTOI/Cyr75unA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eJThdswKjsw2MoetyhcpF4p1HwzRIdqrVRsFvVCXWEyqYP665/zlJJHZ/S7XhVIdTnfO7XWhvkwJt+hOs2QGx0RrLRC35ZFcsLis1H7b6YbgN0OErBtJliklUOPfuOAIqa/NMonhmitRge7yLVrNg7EIY0eiByW7b5Qfh+AFiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4dAoVC1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724193158; x=1755729158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UDYOU1i7bcNe5odRgJ3NWSVG90wWzQaTOI/Cyr75unA=;
  b=j4dAoVC11VtH34476uD4KmL1yRAQKO2Vmo7HtURT1ulXWsFyp4pU7TC9
   HQHNQQ82YaRFaMOb0DsPxcYDB21tVF9hIK3+OHkmRKJa+B/LOpVEH0H8O
   p9jsvsxGtQ3LeqVeATETByOc9v6dOaSwKv0dcqxcaNrT76lPaXZm92zn9
   kYT6U82aAQnIeO6Ze6oMXkevttZMgn5PtQKv8NUp1cwT5qOtPueeARa7P
   wngc7Dk0u78EvbZDV57GjEFVVzugbqJCjG4VdVuk7FKYw1FD4uIVNeFrs
   SJnGTGrc44v25i+IjXJZlO9f4zaDdejb6LjsAdfm01gzLnUP8Hu3lpJ7L
   A==;
X-CSE-ConnectionGUID: c9wiW2I0Q9un3NfWo4CdqQ==
X-CSE-MsgGUID: B4uBgTYhRamWg688jr9KTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33914409"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33914409"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 15:32:35 -0700
X-CSE-ConnectionGUID: E957gFAURr2FkcWTM7OaoQ==
X-CSE-MsgGUID: YDMdrUnxTp2lW+Omub28aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="91619982"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.45])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 15:32:35 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: <linux-pci@vger.kernel.org>,
	paul.m.stillwell.jr@intel.com
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD sub-devices
Date: Tue, 20 Aug 2024 15:32:13 -0700
Message-Id: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMD does not support INTx for devices downstream from a VMD endpoint.
So initialize the PCI_INTERRUPT_LINE to 0 for all NVMe devices under
VMD to ensure other applications don't try to set up an INTx for them.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v2->v1: Change the execution from fixup.c to vmd.c
---
 drivers/pci/controller/vmd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a726de0af011..2e9b99969b81 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -778,6 +778,18 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	return 0;
 }
 
+/*
+ * Some applications like SPDK reads PCI_INTERRUPT_LINE to decide
+ * whether INTx is enabled or not. Since VMD doesn't support INTx,
+ * write 0 to all NVMe devices under VMD.
+ */
+static int vmd_clr_int_line_reg(struct pci_dev *dev, void *userdata)
+{
+	if(dev->class == PCI_CLASS_STORAGE_EXPRESS)
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0);
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -932,6 +944,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	pci_scan_child_bus(vmd->bus);
 	vmd_domain_reset(vmd);
+	pci_walk_bus(vmd->bus, vmd_clr_int_line_reg, &features);
 
 	/* When Intel VMD is enabled, the OS does not discover the Root Ports
 	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
-- 
2.39.1


