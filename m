Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2FD185966
	for <lists+linux-pci@lfdr.de>; Sun, 15 Mar 2020 03:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCOCuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Mar 2020 22:50:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34072 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgCOCuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Mar 2020 22:50:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id i24so13568793eds.1;
        Sat, 14 Mar 2020 19:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNTutDatIyamABRgsUsb8sk6DSaZsRp1ZwzD27tUqEw=;
        b=mFD+ypkJ14t6G4efGOZwoxhqG2z6SjBBJITKzzEUyLxv0i0e27bypmj8hPjf5mXQ15
         XVkT+rcX7/A2xlEC0iqhlsEsWhGBx86VITnhzT3yWnLQdh1m5XC4DScF3RnK4U1SNeFW
         5J7bNho0GhgQ0JJZRoTOtM6IaF0bH31RaiLMThbh/UVWVFuIgKBwxar5U6YjFwHY24h8
         O2zybnhXHGAouGlKDJOg50Z2vtPobcDt3yrfgH5o7vHI/QFtqLN6ZT0r3snmHCFyzPb6
         JBOtRUYiEgsTBXAx0IIH58cIjywyvQgaLRmUnhsoL2SW7/zdlqwXDxnnwRja215C0TNJ
         C+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNTutDatIyamABRgsUsb8sk6DSaZsRp1ZwzD27tUqEw=;
        b=Huy9YHEzXJ373CKaoxOgVm08eWBtBmf0I+ZI+4o/nNBVSRI1RpS5jpYPtVpcaRb7uq
         ECPGogUAo6uzARAqtQfrY6gBNRHaDpv/tYW+OtP46PszsZ6ByaDSug172VrRO4qJS4VA
         6jRu6m5Eux+OzqpDoYpjakK/FO2CMkvxv4GTOPIzCrlc9B9MAS7WwTSqvm0KQkE2D994
         m86jnHNrdLFROHq2AH93wr+1IkmehZx9ez52nB7EPf71kO9K/JHmbm1RoZqLZaLIWZHe
         LbHt50FDW8atY9QLUaWAaA0jXBduOBV4ZoWi94UEtkkB5+57QelCAjpRLFU1vADwfkEl
         5tbw==
X-Gm-Message-State: ANhLgQ3wcZNhROBuRNPldE11K8dkmk/HJR4aHq26qsq4hfIY01ewrg/2
        LSfRw0q09QzqQI2BOhCqEO4cxRrC
X-Google-Smtp-Source: ADFU+vuiX02lKc4DiZTnb8mFkAx7YhZTNHTtVgybEneuQZdVlnUzmO6DIazSjGs5VjCAajtrHnp1aA==
X-Received: by 2002:adf:a555:: with SMTP id j21mr25824917wrb.409.1584213166723;
        Sat, 14 Mar 2020 12:12:46 -0700 (PDT)
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id k3sm9469881wro.59.2020.03.14.12.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 12:12:45 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
Date:   Sat, 14 Mar 2020 20:12:32 +0100
Message-Id: <20200314191232.3122290-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>

This adds the suspend/resume supports for pcie-rcar. The resume handler
reprograms the hardware based on the software state kept in specific
device structures. Also it doesn't need to save any registers.

Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Change return type of rcar_pcie_hw_enable() to void
    - Drop default: case in switch statement in rcar_pcie_hw_enable()
    - Sort variables in rcar_pcie_resume()
V3: - Update on top of next-20200313
---
 drivers/pci/controller/pcie-rcar.c | 86 +++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 759c6542c5c8..f86513638b8a 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -452,6 +452,32 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
 }
 
+static void rcar_pcie_hw_enable(struct rcar_pcie *pci)
+{
+	struct resource_entry *win;
+	LIST_HEAD(res);
+	int i = 0;
+
+	/* Try setting 5 GT/s link speed */
+	rcar_pcie_force_speedup(pci);
+
+	/* Setup PCI resources */
+	resource_list_for_each_entry(win, &pci->resources) {
+		struct resource *res = win->res;
+
+		if (!res->flags)
+			continue;
+
+		switch (resource_type(res)) {
+		case IORESOURCE_IO:
+		case IORESOURCE_MEM:
+			rcar_pcie_setup_window(i, pci, win);
+			i++;
+			break;
+		}
+	}
+}
+
 static int rcar_pcie_enable(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -891,11 +917,25 @@ static void rcar_pcie_unmap_msi(struct rcar_pcie *pcie)
 	irq_domain_remove(msi->domain);
 }
 
+static void rcar_pcie_hw_enable_msi(struct rcar_pcie *pcie)
+{
+	struct rcar_msi *msi = &pcie->msi;
+	unsigned long base;
+
+	/* setup MSI data target */
+	base = virt_to_phys((void *)msi->pages);
+
+	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
+	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
+
+	/* enable all MSI interrupts */
+	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
+}
+
 static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct rcar_msi *msi = &pcie->msi;
-	phys_addr_t base;
 	int err, i;
 
 	mutex_init(&msi->lock);
@@ -934,17 +974,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	/* setup MSI data target */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
-	if (!msi->pages) {
-		err = -ENOMEM;
-		goto err;
-	}
-	base = virt_to_phys((void *)msi->pages);
-
-	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
-
-	/* enable all MSI interrupts */
-	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
+	rcar_pcie_hw_enable_msi(pcie);
 
 	return 0;
 
@@ -1219,6 +1249,37 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int rcar_pcie_resume(struct device *dev)
+{
+	struct rcar_pcie *pcie = dev_get_drvdata(dev);
+	int (*hw_init_fn)(struct rcar_pcie *);
+	unsigned int data;
+	int err;
+
+	err = rcar_pcie_parse_map_dma_ranges(pcie);
+	if (err)
+		return 0;
+
+	/* Failure to get a link might just be that no cards are inserted */
+	hw_init_fn = of_device_get_match_data(dev);
+	err = hw_init_fn(pcie);
+	if (err) {
+		dev_info(dev, "PCIe link down\n");
+		return 0;
+	}
+
+	data = rcar_pci_read_reg(pcie, MACSR);
+	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
+
+	/* Enable MSI */
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		rcar_pcie_hw_enable_msi(pcie);
+
+	rcar_pcie_hw_enable(pcie);
+
+	return 0;
+}
+
 static int rcar_pcie_resume_noirq(struct device *dev)
 {
 	struct rcar_pcie *pcie = dev_get_drvdata(dev);
@@ -1234,6 +1295,7 @@ static int rcar_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops rcar_pcie_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, rcar_pcie_resume)
 	.resume_noirq = rcar_pcie_resume_noirq,
 };
 
-- 
2.25.0

