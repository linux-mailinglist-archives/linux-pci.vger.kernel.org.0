Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08963AD835
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 08:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhFSGmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 02:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbhFSGmk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Jun 2021 02:42:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF132C061574;
        Fri, 18 Jun 2021 23:40:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so9446701pjs.2;
        Fri, 18 Jun 2021 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1glDM6oLeTVKmgkuXKty5D8QEB/JX/Xhu+0hRlzxY50=;
        b=ck0SbqtDwvvUv3IUYad5DJbmdangdvOau/iCF9srKXiWZ2fV80yAO2xqVqvTZbOUr9
         vdKxDq+MfnRmzW9JqCyZB1oifJpXKLJmsUwXsLWYe/3xwCLFI5hGK3iblNeQshsIKBSC
         9mGrHWq8CmakB5U9A9am3FED/Z3S5wE8bNGopHZBPT7LC1c0dBS/IKteyzryggtIFaDk
         7uqtxXmvinZCZFHYD8aN15OmZh30c3RoLTmCWxG1AYpJ9LRvGREa+13OCPYMDw2aWmQo
         neQtOvKO1FYfVV4w7ChdXNMecl6yc9UiQhLFAcGCIjpgM1w571u+qSHdkSyV+GIC6HsM
         MM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1glDM6oLeTVKmgkuXKty5D8QEB/JX/Xhu+0hRlzxY50=;
        b=mS2pVimPN5mvwsc7Z84ryFC2vQYgN3eISlVWTRbK3WkTFBNrM+9icUp0fqhioEou4d
         uaX+AJGd9OhfJLh8U85vYkeli6bSJGf9/lwlUPbImT3Gb6W2Qv1AE7d9DdsHheys/ae/
         imbtms5TZEpeX8QXK2YplVXBrwTNqMxgUb/K4Bjvvr92DSZBLbLvRlJOaZU1GmSM4ath
         iSZ30dbqMMk+mgL4AoTglaSgOrGAqsUE1bRfEkYZr4hjnJWce4LlWcPqjdh7caVeliM+
         tcw92dIMfLYvw9p4bSJ/ysNJpQ0zP0bvaOsunH+usqOjuAGu1ENgpxkUbbWIoc1XsutD
         /lAQ==
X-Gm-Message-State: AOAM532A2z5QDSv6TyOIXQoE4i1XD8Egf4B5xXnlPDT8isqHtfFA6CD8
        CgP8egn4btzPmBbut2clqwg=
X-Google-Smtp-Source: ABdhPJxylxUb3CRVvUOB7sWREsvDlUHSsbGKGDdn2Z/cAkCOJOGn25zImPk4XDriCcBsagFUQaG9lA==
X-Received: by 2002:a17:90a:5907:: with SMTP id k7mr14518747pji.46.1624084829359;
        Fri, 18 Jun 2021 23:40:29 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id r19sm9440274pfh.152.2021.06.18.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 23:40:29 -0700 (PDT)
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
Subject: [PATCH 4/4] PCI: loongson move mrrs quirk to core
Date:   Sat, 19 Jun 2021 14:39:52 +0800
Message-Id: <20210619063952.2008746-5-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210619063952.2008746-1-art@khadas.com>
References: <20210619063952.2008746-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace dublicated functionality loongson_mrrs_quirk to mrrs_limit_quirk
from core pci quirks

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 drivers/pci/controller/pci-loongson.c | 42 ++-------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 48169b1e3..5a54faf10 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -13,10 +13,6 @@
 #include "../pci.h"
 
 /* Device IDs */
-#define DEV_PCIE_PORT_0	0x7a09
-#define DEV_PCIE_PORT_1	0x7a19
-#define DEV_PCIE_PORT_2	0x7a29
-
 #define DEV_LS2K_APB	0x7a02
 #define DEV_LS7A_CONF	0x7a10
 #define DEV_LS7A_LPC	0x7a0c
@@ -38,11 +34,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_0, bridge_class_quirk);
+			PCI_DEVICE_ID_LOONGSON_PCIE_PORT_0, bridge_class_quirk);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_1, bridge_class_quirk);
+			PCI_DEVICE_ID_LOONGSON_PCIE_PORT_1, bridge_class_quirk);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_2, bridge_class_quirk);
+			PCI_DEVICE_ID_LOONGSON_PCIE_PORT_2, bridge_class_quirk);
 
 static void system_bus_quirk(struct pci_dev *pdev)
 {
@@ -60,38 +56,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, system_bus_quirk);
 
-static void loongson_mrrs_quirk(struct pci_dev *dev)
-{
-	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
-	static const struct pci_device_id bridge_devids[] = {
-		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
-		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
-		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
-		{ 0, },
-	};
-
-	/* look for the matching bridge */
-	while (!pci_is_root_bus(bus)) {
-		bridge = bus->self;
-		bus = bus->parent;
-		/*
-		 * Some Loongson PCIe ports have a h/w limitation of
-		 * 256 bytes maximum read request size. They can't handle
-		 * anything larger than this. So force this limit on
-		 * any devices attached under these ports.
-		 */
-		if (pci_match_id(bridge_devids, bridge)) {
-			if (pcie_get_readrq(dev) > 256) {
-				pci_info(dev, "limiting MRRS to 256\n");
-				pcie_set_readrq(dev, 256);
-			}
-			break;
-		}
-	}
-}
-DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
-
 static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
 				unsigned int devfn, int where)
 {
-- 
2.25.1

