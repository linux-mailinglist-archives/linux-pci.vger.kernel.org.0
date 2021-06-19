Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54553AD833
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 08:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhFSGml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhFSGmg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Jun 2021 02:42:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7AFC061760;
        Fri, 18 Jun 2021 23:40:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso7185666pjp.2;
        Fri, 18 Jun 2021 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMdLXDhFl4H1jBrVVGBSGnbHc6XgMnjwU52Wg9vOITA=;
        b=IH+xuUGqI1f9AUP9hnelNrxh0SN+eH8L+m0MSZOUAStxDdSMizzef6SyMrsw5aaB1P
         K12IXSa4V5+3Rb1FMmX61jqbGvgIUGCni1qaqyS+TG6G6ArjERDnkQzVru2zU7xdubKC
         zkyM0QnpKfxBDnkejKI/+I25JPvNRcSSVzzg6UiX68pYUwwrclfXnoy3Ati2dbtipn91
         dWzf7R0oZq6KvSOQFZOtCQuYYz+5f6cYiTvdRnsoeB6nYDxdRi662LvnTw/0vAxPhsPc
         GUE3xNyzVxvgWE5YpZL+x/oxB5MPu5tNDnmIrWDHmlaP6KAn8stTju6PFO58p9GpiX/h
         X37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMdLXDhFl4H1jBrVVGBSGnbHc6XgMnjwU52Wg9vOITA=;
        b=k2yfy2YfS8VWcEBZEOeFV0FS2yQRb3K36kqsTSE4sgjjktgaewJe9gawVkEG5xWGfW
         jJUWMPV4dYqDz4t99a87M7V46TK75YtsUMZS8fNcS9aKAQkuhWAfVliQDVzEECBhCxov
         kUWNWbNMgQvn1s3AXBTSntcqKgDu6ZqEC0sboxp/10Nr5G7lE11dd7NqmUIktxQ8w3c8
         yIAxEuwVCAJlEK6OTJ0ti9KPEPHep4oqzUX/7k5HVH+jCmbmAnvb3KpBmeIx69cWfCig
         HbebA6fs7+WeGKj3tdW0KBx+75ueYZoTp/cnOOhIYYDRxOxN/zJIOfg6b7fM0r5I/2Rx
         hEGw==
X-Gm-Message-State: AOAM531fInBOJmH9heUYseVHH8RkUzAAFGrNEzP8YtZyAGhyt/3w7/2M
        4kEeZuJP0ZT+Sx6asJfWeEM=
X-Google-Smtp-Source: ABdhPJxsfwbnPxy93E8cwaFesNULmdimBitNo/Xif9c/y85Wm/Rca1Q+h7DW6w8IvnhnFvfgnesddw==
X-Received: by 2002:a17:90a:7401:: with SMTP id a1mr25489029pjg.57.1624084824992;
        Fri, 18 Jun 2021 23:40:24 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id r19sm9440274pfh.152.2021.06.18.23.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 23:40:24 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     yue.wang@Amlogic.com, khilman@baylibre.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 3/4] PCI: keystone move mrrs quirk to core
Date:   Sat, 19 Jun 2021 14:39:51 +0800
Message-Id: <20210619063952.2008746-4-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210619063952.2008746-1-art@khadas.com>
References: <20210619063952.2008746-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace dublicated functionality ks_pcie_quirk to mrrs_limit_quirk
from core pci quirks

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 49 -----------------------
 1 file changed, 49 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 53aa35cb3..879ae2d4f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -83,12 +83,6 @@
 #define ERR_IRQ_ALL			(ERR_AER | ERR_AXI | ERR_CORR | \
 					 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 
-/* PCIE controller device IDs */
-#define PCIE_RC_K2HK			0xb008
-#define PCIE_RC_K2E			0xb009
-#define PCIE_RC_K2L			0xb00a
-#define PCIE_RC_K2G			0xb00b
-
 #define KS_PCIE_DEV_TYPE_MASK		(0x3 << 1)
 #define KS_PCIE_DEV_TYPE(mode)		((mode) << 1)
 
@@ -521,49 +515,6 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
-static void ks_pcie_quirk(struct pci_dev *dev)
-{
-	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
-	static const struct pci_device_id rc_pci_devids[] = {
-		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
-		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
-		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2E),
-		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
-		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2L),
-		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
-		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2G),
-		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
-		{ 0, },
-	};
-
-	if (pci_is_root_bus(bus))
-		bridge = dev;
-
-	/* look for the host bridge */
-	while (!pci_is_root_bus(bus)) {
-		bridge = bus->self;
-		bus = bus->parent;
-	}
-
-	if (!bridge)
-		return;
-
-	/*
-	 * Keystone PCI controller has a h/w limitation of
-	 * 256 bytes maximum read request size.  It can't handle
-	 * anything higher than this.  So force this limit on
-	 * all downstream devices.
-	 */
-	if (pci_match_id(rc_pci_devids, bridge)) {
-		if (pcie_get_readrq(dev) > 256) {
-			dev_info(&dev->dev, "limiting MRRS to 256\n");
-			pcie_set_readrq(dev, 256);
-		}
-	}
-}
-DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
-
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = desc->irq_data.hwirq;
-- 
2.25.1

