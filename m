Return-Path: <linux-pci+bounces-27722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DD0AB6CB3
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92ACC19E8E07
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA628030F;
	Wed, 14 May 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hky07Zrk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E727E7EF;
	Wed, 14 May 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229312; cv=none; b=U906wdIS6nu0n/NS5f6E+g63fzwRAJSqD5AOdS8BB2xyYEGDsS0D8MrwoajGgQFCS0qdpVhHrFJSlIOTLR4cclBhV6g+/aIOwrvMPopgaTGR/KIWfjgGz+h5o9Yp7cdjPwLY5nm4+YBhklYR5XIRnJEYUPV6V515ywc2/SVkoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229312; c=relaxed/simple;
	bh=j3MZd2/yogImZ8gk7Px6VAzusHeLLA90aFukcxAXcFY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gdoI9VDUDJaaZ5AYWYQMG8OyqhwN4s9ThfedTGgTajOWlcsn5lV4DFLb43pIpkR7fIuBaJcrbhNXORHA7k2IlgdiEsINOtu0R1duCDkOqH1SUryYaitWvURktgi8Tz2LEIW1V9zxLxhgyDXlA0W+GYVX01UPiwA5M9NYeHQz2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hky07Zrk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747229311; x=1778765311;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j3MZd2/yogImZ8gk7Px6VAzusHeLLA90aFukcxAXcFY=;
  b=hky07Zrk2R5d/FFDAdegZVXI+IfhL+77DljHfR+5pw6T5eWECEuegWBu
   7tLRQiv9ds2+/d0LdjC3oUiunaIf+LGozekCZyftEn5dBBJunRmL3gLQd
   pG8YNJgm6HbFVko82r+gAj/7XxhzvyuoLOAUh3cZIA6OCBIeIuoFYlEog
   H7BQ7/n75F2TDtKTj0ZAuZgrjThn2EGx3z+OblNpLfnQ0HX6b5E7ZXVsA
   4M+BPyOkbpI3KrNPzeGAd2FztbZof3lkyk8D9qGaTysk2+k/t3XFVijpO
   d4d8H+H/VlpWIfX9I09DiS19+Q4XP35pT/JUhCRIJbGImOrVuRhkkaT03
   Q==;
X-CSE-ConnectionGUID: xc+s9fzPSa2q8SBKCGdFxw==
X-CSE-MsgGUID: MnQo14RNQI+elGXPk7YWhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48236460"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="48236460"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 06:28:30 -0700
X-CSE-ConnectionGUID: krHXXo5DQq+V9qMniP2mCw==
X-CSE-MsgGUID: aOOLb1DiSXKCzXbPbvm/SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="137917766"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.231])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 06:28:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] PCI: Update Link Speed after retraining
Date: Wed, 14 May 2025 16:28:21 +0300
Message-Id: <20250514132821.15705-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe Link Retraining can alter Link Speed. pcie_retrain_link() that
performs the Link Training is called from bwctrl and ASPM driver.

While bwctrl listens for Link Bandwidth Management Status (LBMS) to
pick up changes in Link Speed, there is a race between
pcie_reset_lbms() clearing LBMS after the Link Training and
pcie_bwnotif_irq() reading the Link Status register. If LBMS is already
cleared when the irq handler reads the register, the interrupt handler
will return early with IRQ_NONE and won't update the Link Speed.

When Link Speed update originates from bwctrl,
pcie_bwctrl_change_speed() ensures Link Speed is updated after the
retraining. ASPM driver, however, calls pcie_retrain_link() but does
not update the Link Speed after retraining which can result in stale
Link Speed. Also, it is possible to have ASPM support with
CONFIG_PCIEPORTBUS=n in which case bwctrl will not be built in (and
thus won't update the Link Speed at all).

To ensure Link Speed is not left stale after Link Training, move the
call to pcie_update_link_speed() from pcie_bwctrl_change_speed() into
pcie_retrain_link().

Suggested-by: Lukas Wunner <lukas@wunner.de>
Link: https://lore.kernel.org/linux-pci/aBCjpfyYmlkJ12AZ@wunner.de/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---

Based on top of pci/bwctrl.

v2:
- Fix changelog typos.
- Reworded changelog to cover retraining from ASPM when
  CONFIG_PCIEPORTBUS=n.

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


