Return-Path: <linux-pci+bounces-27579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48499AB3801
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 15:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9E1189672F
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7139B288507;
	Mon, 12 May 2025 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1IrQdTu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804FA2BAF7;
	Mon, 12 May 2025 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054923; cv=none; b=njFGwPuY6CXSva8QbG1tJrZeS0AtOKFgSsZ9igCui9+zj2CCYagzFrrsUov+neG9d0aARo8qxdnbvxvVK8fvadKrQ+59da92UxjsJvLjCDyvBciafJlKxEbGSZ9mft/yfzc/yVEvxAXOcjK6ubDYbikTQRhKYJfiCNDz//Sn4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054923; c=relaxed/simple;
	bh=Guz9tiPuKfkJWql/vRkCfjsZnSh3q6v5xsgsAo7twEo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DefXeyS9KQk+HC5S9MKXt/+7H36FvYBTpdJRM0duKl4CfGrMSLdlRoPFIwVUR6Lf8d3eG96ykSrPazBVse9CDGp7TU3MptJZZhVFeCG+tZOs+rTlbb4EOuXqhR7D2nnmySIKTSuaC+B+XL4oOfnpf8OBATl4AuRFJT2o7ARKR0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1IrQdTu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747054921; x=1778590921;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Guz9tiPuKfkJWql/vRkCfjsZnSh3q6v5xsgsAo7twEo=;
  b=B1IrQdTubR6hINq0Q9uenIqhkgmspN+MDgHhhOS2F8NcE50L6MO8hBLM
   Y0mVRXG7JBrM4CyMVYGMpYbhYWukY0gwxg++puY4p3+6NTB7tPyLlN1Ie
   xB9z816c6U01OyzDeP0niP/tdQ9TmFlYHe2XohIhY7J+zg3+0kj4QDOlQ
   OP8MY5VcEtkO+I7WP/WvQX7GTDuU7epNZzJepi9uoKQ1PR5hmcE6MC+Nh
   o3bv+d6KMmFOJvHtVW8OCMZYaElR1PpZVbrXg0k6FrKCpySUlw1O2sOw+
   0s+npFY/Qm+wxdXW+qa7hvArfLnXLSdjitkJs01ePPHTJ685iqNQ6Qrn+
   A==;
X-CSE-ConnectionGUID: 8kUNmGefRKCWvJzfzQ1cpQ==
X-CSE-MsgGUID: IK4FKPX2SO+tEgK7g9R2ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52662486"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="52662486"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 06:01:33 -0700
X-CSE-ConnectionGUID: bAR8iVIbRcq3XZtK8o6MRQ==
X-CSE-MsgGUID: gMbw2En3RwCZuO20MKw7VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="141417324"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 06:01:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI: Update Link Speed after retraining
Date: Mon, 12 May 2025 16:01:24 +0300
Message-Id: <20250512130125.9062-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe Link Retraining can alter Link Speed. While bwctrl listens for
Link Bandwidth Management Status (LBMS) to pick up changes in Link
Speed, there is a race between pcie_reset_lbms() clearing LBMS after
the Link Training and pcie_bwnotif_irq() reading the Link Status
register. If LBMS is already cleared when the irq handler reads the
register, the interrupt handler will return early with IRQ_NONE and
won't update the Link Speed.

When Link Speed update originates from bwctrl,
pcie_bwctrl_change_speed() ensures Link Speed is update after the
retraining. ASPM driver, however, calls pcie_retrain_link() but does
not update the Link Speed after retraining which can result in stale
Link Speed.

To ensure Link Speed is not left state after Link Training, move the
call to pcie_update_link_speed() from pcie_bwctrl_change_speed() into
pcie_retrain_link().

Suggested-by: Lukas Wunner <lukas@wunner.de>
Link: https://lore.kernel.org/linux-pci/aBCjpfyYmlkJ12AZ@wunner.de/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Based on top of pci/bwctrl.

 drivers/pci/pci.c         | 17 +++++++++++++++++
 drivers/pci/pcie/bwctrl.c | 13 +------------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d94cf33c1b6..eb0c55078d5e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4718,6 +4718,11 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
  * @pdev: Device whose link to retrain.
  * @use_lt: Use the LT bit if TRUE, or the DLLLA bit if FALSE, for status.
  *
+ * Trigger retraining of the PCIe Link and wait for the completion of the
+ * retraining. As link retraining is known to asserts LBMS and may change
+ * the Link Speed, LBMS is cleared after the retraining and the Link Speed
+ * of the subordinate bus is updated.
+ *
  * Retrain completion status is retrieved from the Link Status Register
  * according to @use_lt.  It is not verified whether the use of the DLLLA
  * bit is valid.
@@ -4758,6 +4763,18 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	 * in attempt to correct unreliable link operation.
 	 */
 	pcie_reset_lbms(pdev);
+
+	/*
+	 * Ensure the Link Speed updates after retraining in case the Link
+	 * Speed was changed because of the retraining. While the bwctrl's
+	 * IRQ handler normally picks up the new Link Speed, clearing LBMS
+	 * races with the IRQ handler reading the Link Status register and
+	 * can result in the handler returning early without updating the
+	 * Link Speed.
+	 */
+	if (pdev->subordinate)
+		pcie_update_link_speed(pdev->subordinate);
+
 	return rc;
 }
 
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index fdafa20e4587..790a935b34fd 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -125,18 +125,7 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return pcibios_err_to_errno(ret);
 
-	ret = pcie_retrain_link(port, use_lt);
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * Ensure link speed updates also with platforms that have problems
-	 * with notifications.
-	 */
-	if (port->subordinate)
-		pcie_update_link_speed(port->subordinate);
-
-	return 0;
+	return pcie_retrain_link(port, use_lt);
 }
 
 /**

base-commit: 0238f352a63a075ac1f35ea565b5bec3057ec8bd
-- 
2.39.5


