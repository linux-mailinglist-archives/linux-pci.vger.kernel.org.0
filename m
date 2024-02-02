Return-Path: <linux-pci+bounces-3020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A1847150
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 14:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCC82843EE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE4A45BF3;
	Fri,  2 Feb 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiCtJhgO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48417542;
	Fri,  2 Feb 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881279; cv=none; b=bhhJrFbXKVJVY85s0rNU6NOEZqHCNcuuhN7//X2OH/uc8RlHA1y/YZW/bCmp1YwqlDuK5ebGSovvG5NXiQcOK8krEPF+K1TU0CcLmZN1ekttKsDapZ0anp/mXxamrWlmLezHOQu2zSGbyXfYVE52Uzly4zwqDMuaxeIHS3DYUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881279; c=relaxed/simple;
	bh=LTFK+5OJJ3JAaDjXIW/81oyDqHT85WKN9Hx3itF82S8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TAImqIuFKFd9xWlO9UI7+eZneAJ1okJfgaKLL7owhs+bILbAdyHrEn+sViwtrmIX/2odC5f3Lx6NiHzIrvuebJj4o0Qbw4TnvHCrVrAYsWPpCLGGoHc6avd14T7izPLkvIhdEekWjqj6LFQwZdlaWF+720jUUQSdv8NrWOi2dH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiCtJhgO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706881278; x=1738417278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LTFK+5OJJ3JAaDjXIW/81oyDqHT85WKN9Hx3itF82S8=;
  b=DiCtJhgOb4iRBxPflDPKnRg9p70Tfg61D4tvx9m59OeNbDh5qIr+dAUn
   0r4cBKCH9j5BUORIIobG/uncTkikpPuNNlkFWDzYnWP8tl85ZSlRis1Wi
   o9p+H2YV90wXB6siqwMD1qfLBieqs0W69bIlh8+oEvX4u55m3v0D1iji+
   QRL8VZlVb2SsHz+ioV8XSvXlb7j9GeMt7FH436CKvv6rUvD5K/SfeB9gg
   SIrR+XvgsEyu1VVWLy6I/Ng84PumyOwAuk8tfnuO5onS1MnoTsYA0Y6TF
   9RHw2b/i0/ZNKivrouZCNCXa4L/acKV1Hwy2Kvv8E2i6wXfWGAUHAitJm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="338478"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="338478"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 05:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="152500"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.66])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 05:41:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Maciej W . Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Cleanup link activation wait logic
Date: Fri,  2 Feb 2024 15:41:08 +0200
Message-Id: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The combination of logic in pcie_failed_link_retrain() and
pcie_wait_for_link_delay() is hard to track and does not really make
sense in some cases.

To cleanup the logic mess:

1. Change pcie_failed_link_retrain() to return true only if link was
   retrained successfully due to the Target Speed quirk. If there is no
   LBMS set, return false instead of true because no retraining was
   even attempted. This seems correct considering expectations of both
   callers of pcie_failed_link_retrain().

2. Handle link-was-not-retrained-successfully return (false) from
   pcie_failed_link_retrain() properly in pcie_wait_for_link_delay() by
   directly returning false.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c    |  4 +---
 drivers/pci/quirks.c | 25 +++++++++++++------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..ca4159472a72 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5068,9 +5068,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 		msleep(20);
 	rc = pcie_wait_for_link_status(pdev, false, active);
 	if (active) {
-		if (rc)
-			rc = pcie_failed_link_retrain(pdev);
-		if (rc)
+		if (rc < 0 && !pcie_failed_link_retrain(pdev))
 			return false;
 
 		msleep(delay);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index efb2ddbff115..e729157be95d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -88,24 +88,25 @@ bool pcie_failed_link_retrain(struct pci_dev *dev)
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
 		return false;
 
-	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
-	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
-	    PCI_EXP_LNKSTA_LBMS) {
-		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
+	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) !=
+	    PCI_EXP_LNKSTA_LBMS)
+		return false;
 
-		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
-		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
+	pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
-		if (pcie_retrain_link(dev, false)) {
-			pci_info(dev, "retraining failed\n");
-			return false;
-		}
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
+	lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
+	lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	if (pcie_retrain_link(dev, false)) {
+		pci_info(dev, "retraining failed\n");
+		return false;
 	}
 
+	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+
 	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
 	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
 	    pci_match_id(ids, dev)) {
-- 
2.39.2


