Return-Path: <linux-pci+bounces-27290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5FAAACC45
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F35F1B61ED1
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C8285416;
	Tue,  6 May 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fvyufsTQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F32853EE;
	Tue,  6 May 2025 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552953; cv=none; b=MV4XMnbsvf2ihxbmCEXJ1hCodod8T7667x3A8e/F3Oijn7V2lbZMyEHeFNluIkAG7u89YRJe70GVjWr0zgHw2ZxPNZdnIzGF92h7ON14ra0dQ8tZBiLBJJLu6mjLXpRwYKRAaI1MfHagKnS0zVXGWKWXi8M+9coANP1834HdCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552953; c=relaxed/simple;
	bh=zxzc/PmTJsrnSeo8yDdERrxe3HwZ9JgY/zcE56X7O9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZYv4v1GwDbDtNItCm6VMX1h+5HOZHfCApoyLKGDvXwHvEqCSzGvwZ8EMI0F5wXYKF9bZCC7RTxDY67IOzAHbAG0FRnV0UzbPFqU1pnO50F3Hs6Wgk2Bta2WtlORRnawHnKwG8rvSPsK+svAP05P7cTgTqXYGq53s62i7I++J8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fvyufsTQ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pjYFa
	SOXw6nvqbq4IDi+uXJUjRekOycaZIZRolfobi0=; b=fvyufsTQd2ABuLR+pk0LT
	13Dqm5uQ1Z9Oqfn4YkO7iSVzazDCH8W5MI3iIva/Kl9WrzCg9sTdWN+fFGaxy1UF
	hyGy2iebiM3D8kl6urgiyBYcem4IgVVmH50/yYnWsRBN9Q8CCECU/+L8wgMfNOzp
	nBBQspJQWe9LxXQRIiA4as=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAX_U4ySBpoVmZeEw--.15363S3;
	Wed, 07 May 2025 01:34:44 +0800 (CST)
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
Subject: [PATCH v3 1/3] PCI: Configure root port MPS during host probing
Date: Wed,  7 May 2025 01:34:37 +0800
Message-Id: <20250506173439.292460-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506173439.292460-1-18255117159@163.com>
References: <20250506173439.292460-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX_U4ySBpoVmZeEw--.15363S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4rCrW8KFWrtFy7GF43GFg_yoWrAF1rpa
	y3XFWftrZ7GF1fWanxJa109w15trsav343trZxGw1F9w15AFyUKryYya1rJas7GrZ7uFya
	vr90qry8WanYvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi2NtcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOg9Fo2gaRElteAAAs5

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
size.

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
 drivers/pci/probe.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..365d9a7dd37f 100644
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
@@ -2178,6 +2209,10 @@ static void pci_configure_mps(struct pci_dev *dev)
 		return;
 	}
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
+		pcie_write_mps(dev, 128 << dev->pcie_mpss);
+
 	if (!bridge || !pci_is_pcie(bridge))
 		return;
 
@@ -2875,37 +2910,6 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
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


