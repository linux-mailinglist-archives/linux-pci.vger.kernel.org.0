Return-Path: <linux-pci+bounces-27543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7589AB247A
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 17:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD4D4A2F51
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F52236F2;
	Sat, 10 May 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GgdHW93t"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A412356D0;
	Sat, 10 May 2025 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746892639; cv=none; b=uaX0a0HvrrhVPD1cSCHvwoPTktXDvOA0XlOiVV78Wa9SYF3fuoZIgwnZ73ZG/ipBNvTHYT0vf62bTtmI0gemfXw1sBRDViOODbq8WD0vWY95bLoEtae1VS0KaL618IWccGcLgz9KP14aMr7983t8hNMfaeywW5uDSa7+8R/nHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746892639; c=relaxed/simple;
	bh=Th4wjNWotwdbEtbNrNTOq3O36Clo9NwxnFQYmWYaNMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=suUDgDdW2888IGvbcdsZaAyH2mL8VOsbAe0WK3AYCYPNBh+8sf67MAm+DwH+5m4fxl0oYjEftVGmagGkinhFGYverp4G0JcKliTyvNRlFMswck9pMY9TLChYeL+nvCVwGkUAN5NdYsy5if5mVXrOaafgpRCYGIoeoyw8f9y7jQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GgdHW93t; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rt
	Q9WMCTmJv+q//MSyeDx5RtHg7RmBudAr1AhWxe120=; b=GgdHW93tUx77vORi6x
	qW3SWpBZzIQzA640G4HC/eJr+guTwrSZ56s/WKUQJ4dFtd25xbmMjYQJ8ySP9LTh
	VIZDtAi6xtj9o13MDLozc2EkxpXhOt0YipS+diVVKeKB6pHv368tH+34QX35nWXX
	LadrG+oUr7BxwmPcT4JV2lwCc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXjxsYdx9ormDlAQ--.43845S3;
	Sat, 10 May 2025 23:56:10 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	manivannan.sadhasivam@linaro.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 1/2] PCI: Configure root port MPS during host probing
Date: Sat, 10 May 2025 23:56:06 +0800
Message-Id: <20250510155607.390687-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250510155607.390687-1-18255117159@163.com>
References: <20250510155607.390687-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXjxsYdx9ormDlAQ--.43845S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4xWw4rWF4kKr48uFW5GFg_yoWruw1rpa
	y3XFWSyrZ7GF1fWan3Ja109r15trsav343trZxGw1ruw15AFy8KrWaya1rJas7GrZ7ZFyY
	vr90qry8uan5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEwZ25UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhNJo2gfbZ-YXQABsC

Current PCIe initialization logic may leave root ports operating with
non-optimal Maximum Payload Size (MPS) settings. While downstream device
configuration is handled during bus enumeration, root port MPS values
inherited from firmware or hardware defaults might not utilize the full
capabilities supported by the controller hardware. This can result is
uboptimal data transfer efficiency across the PCIe hierarchy.

During host controller probing phase, when PCIe bus tuning is enabled,
the implementation now configures root port MPS settings to their
hardware-supported maximum values. By iterating through bridge devices
under the root bus and identifying PCIe root ports, each port's MPS is
set to 128 << pcie_mpss to match the device's maximum supported payload
size. The Max Read Request Size (MRRS) is subsequently adjusted through
existing companion logic to maintain compatibility with PCIe
specifications.

Explicit initialization at host probing stage ensures consistent PCIe
topology configuration before downstream devices perform their own MPS
negotiations. This proactive approach addresses platform-specific
requirements where controller drivers depend on properly initialized
root port settings, while maintaining backward compatibility through
PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
utilized without altering existing device negotiation behaviors.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/probe.c | 72 ++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..1f67c03d170a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2149,6 +2149,37 @@ int pci_setup_device(struct pci_dev *dev)
 	return 0;
 }
 
+static void pcie_write_mps(struct pci_dev *dev, int mps)
+{
+	int rc;
+
+	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
+		mps = 128 << dev->pcie_mpss;
+
+		if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
+		    dev->bus->self)
+
+			/*
+			 * For "Performance", the assumption is made that
+			 * downstream communication will never be larger than
+			 * the MRRS.  So, the MPS only needs to be configured
+			 * for the upstream communication.  This being the case,
+			 * walk from the top down and set the MPS of the child
+			 * to that of the parent bus.
+			 *
+			 * Configure the device MPS with the smaller of the
+			 * device MPSS or the bridge MPS (which is assumed to be
+			 * properly configured at this point to the largest
+			 * allowable MPS based on its parent bus).
+			 */
+			mps = min(mps, pcie_get_mps(dev->bus->self));
+	}
+
+	rc = pcie_set_mps(dev, mps);
+	if (rc)
+		pci_err(dev, "Failed attempting to set the MPS\n");
+}
+
 static void pci_configure_mps(struct pci_dev *dev)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
@@ -2178,6 +2209,16 @@ static void pci_configure_mps(struct pci_dev *dev)
 		return;
 	}
 
+	/*
+	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
+	 * start off by setting root ports' MPS to MPSS. Depending on the MPS
+	 * strategy, and the MPSS of the devices below the root port, the MPS
+	 * of the root port might get overridden later.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
+		pcie_write_mps(dev, 128 << dev->pcie_mpss);
+
 	if (!bridge || !pci_is_pcie(bridge))
 		return;
 
@@ -2875,37 +2916,6 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static void pcie_write_mps(struct pci_dev *dev, int mps)
-{
-	int rc;
-
-	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
-		mps = 128 << dev->pcie_mpss;
-
-		if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
-		    dev->bus->self)
-
-			/*
-			 * For "Performance", the assumption is made that
-			 * downstream communication will never be larger than
-			 * the MRRS.  So, the MPS only needs to be configured
-			 * for the upstream communication.  This being the case,
-			 * walk from the top down and set the MPS of the child
-			 * to that of the parent bus.
-			 *
-			 * Configure the device MPS with the smaller of the
-			 * device MPSS or the bridge MPS (which is assumed to be
-			 * properly configured at this point to the largest
-			 * allowable MPS based on its parent bus).
-			 */
-			mps = min(mps, pcie_get_mps(dev->bus->self));
-	}
-
-	rc = pcie_set_mps(dev, mps);
-	if (rc)
-		pci_err(dev, "Failed attempting to set the MPS\n");
-}
-
 static void pcie_write_mrrs(struct pci_dev *dev)
 {
 	int rc, mrrs;
-- 
2.25.1


