Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488F22DB49E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 20:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgLOTmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 14:42:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45601 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgLOTmc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2020 14:42:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id f132so24628861oib.12
        for <linux-pci@vger.kernel.org>; Tue, 15 Dec 2020 11:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1m/0CUX1TNRahyWO/BeWDCvKvpo7spQMK/OpMknzTd8=;
        b=jMJ5bzjTp0ldRHOQjD6U+pteo8jUc0cMgEbU4tkWhWJID+9TvB2o4+nWzUOokKGEpO
         k6BGi6snrvEzGzcmAiKISFPiP3edn5hyk1TZoQw3SRita0fwNkM6pRlt/IiPJ1gCe7Kg
         HDyWhw9N5/VpgIcX+pALg2KczuXBpe6I949B46CVdkF7tEGfQWHjPRigeDCKCLE4UZnn
         eBmFer7sAscYbMyztDrAiFHByuCwg8ajY0cXusG9DWsLEFM+ByjsInpusHkGA37+TyPh
         2DLgLIFkhSb+w5/UzfNFkBkXmP3BGQpCafmmGXqxwRtAjRZTBjPr5oPYU5udnB2vpB6T
         hbBw==
X-Gm-Message-State: AOAM5302NIwqiONGoVt3YDsTybpIS1qTiC+Ji+aDnf9fkvkKyEtWFzdG
        hw2olDalBrLHfFBKIJ4LbQ==
X-Google-Smtp-Source: ABdhPJz9wiULsHc1ujIhHepvRKEsx/LrBaVJrLpl7TgtEZNnK7+j/irunXLtYnQQiu84fyvRWE8F/g==
X-Received: by 2002:aca:eb44:: with SMTP id j65mr302538oih.19.1608061311207;
        Tue, 15 Dec 2020 11:41:51 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r204sm5017800oif.0.2020.12.15.11.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 11:41:50 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] PCI: dwc: Drop support for config space in 'ranges'
Date:   Tue, 15 Dec 2020 13:41:49 -0600
Message-Id: <20201215194149.86831-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and
"addr_space" resource setup into common code"), the code
setting dbi_base when the config space is defined in 'ranges' property
instead of 'reg' is dead code as dbi_base is never NULL.

Rather than fix this, let's just drop the code. Using ranges has been
deprecated since 2014. The only platforms using this were exynos5440,
i.MX6 and Spear13xx. Exynos5440 is dead and has been removed. i.MX6 and
Spear13xx had PCIe support added just before this was deprecated and
were fixed within a kernel release or 2.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 45 +++++--------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 516b151e0ef3..74661afdcf56 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -305,8 +305,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (cfg_res) {
 		pp->cfg0_size = resource_size(cfg_res);
 		pp->cfg0_base = cfg_res->start;
-	} else if (!pp->va_cfg0_base) {
+
+		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, cfg_res);
+		if (IS_ERR(pp->va_cfg0_base))
+			return PTR_ERR(pp->va_cfg0_base);
+	} else {
 		dev_err(dev, "Missing *config* reg space\n");
+		return -ENODEV;
 	}
 
 	if (!pci->dbi_base) {
@@ -322,38 +327,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	pp->bridge = bridge;
 
-	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &bridge->windows) {
-		switch (resource_type(win->res)) {
-		case IORESOURCE_IO:
-			pp->io_size = resource_size(win->res);
-			pp->io_bus_addr = win->res->start - win->offset;
-			pp->io_base = pci_pio_to_address(win->res->start);
-			break;
-		case 0:
-			dev_err(dev, "Missing *config* reg space\n");
-			pp->cfg0_size = resource_size(win->res);
-			pp->cfg0_base = win->res->start;
-			if (!pci->dbi_base) {
-				pci->dbi_base = devm_pci_remap_cfgspace(dev,
-								pp->cfg0_base,
-								pp->cfg0_size);
-				if (!pci->dbi_base) {
-					dev_err(dev, "Error with ioremap\n");
-					return -ENOMEM;
-				}
-			}
-			break;
-		}
-	}
-
-	if (!pp->va_cfg0_base) {
-		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
-					pp->cfg0_base, pp->cfg0_size);
-		if (!pp->va_cfg0_base) {
-			dev_err(dev, "Error with ioremap in function\n");
-			return -ENOMEM;
-		}
+	/* Get the I/O range from DT */
+	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
+	if (win) {
+		pp->io_size = resource_size(win->res);
+		pp->io_bus_addr = win->res->start - win->offset;
+		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
 	if (pci->link_gen < 1)
-- 
2.25.1

