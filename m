Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88823AD830
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 08:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhFSGmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 02:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbhFSGmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Jun 2021 02:42:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2228C061767;
        Fri, 18 Jun 2021 23:40:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i4so2092591plt.12;
        Fri, 18 Jun 2021 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBC2jKS0EXBhnjYqqHmBsLNtpsQFO2BHm+Xp1hgeFE8=;
        b=SPMP2ltRGwzcECcsH2aLjunU8fcC8kYzSGXILxhE5YWPRR/jrZyv6tRZvCTvPbMaOw
         y0E5fhpE22+hMyNXfOKTYDDwxPXZALCk/nKcZrS4w2iXpMYqj3LMZyX8XxOqvHwKFWMX
         UVLaCTxLOxKdpM3diOdhIiLSywvIEk7eVYo5bdavd89yMDfdHbs2kYzzk7b7PrXjw3B7
         mNH6V7s8xF3tjIn8fHJBWMrwUXvMxDohYBNHqLLLg3mxnMLs2eh6tpcIn7wIyosIePsX
         3U14w+zRFAKo/lxybtoKMlj+aYqAsMyOWTX9tQLJz7udmNDa6BEbUIJWem1W6TDSJZD2
         v0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBC2jKS0EXBhnjYqqHmBsLNtpsQFO2BHm+Xp1hgeFE8=;
        b=rqdfQyYxIEk9PEi0O3QnsjOy6Qdsesk7EBVIwHzVvzyfHI73eTW5TOKvxTYazkWQGb
         DMZ4BaqW/sRolRTQ4H0lDuPwXwgmwffttvY6CyUeX10uFMFRI/mCiCBHcNvEJipk/8IG
         kXfXWEhPhGs3bolWPVwaPS3XvaCjqYHYnPx4iH3O4V/8UikjLmsovs4E8ujuEy+fm1PM
         gX4pTAZvzHYwcDEtz4Nfy19lm3tbl9oIc9AetWSOUz5RDTipONQ9CY84a7oTpVJ1gkYA
         frRjQyxPmdABxJlLH0WP1P+uO3auGVyYzvUQtO2GCD6+rrj8IYKqmdTeOb1GxIaXebtF
         hRLw==
X-Gm-Message-State: AOAM532nYgNtCx8RaZF4aHOD5NXvL5MzZV8Imfh98xu/DIBBABWCVsGy
        QTUtP2Y0B8w2eIfaTEbR9CU=
X-Google-Smtp-Source: ABdhPJyZAYPMcraY9oFytwbhDkAJuPkVaHQ2RiogYWEkWAm4fQF4c6JEkpP16vIoLpBXYob7YkRzYw==
X-Received: by 2002:a17:90a:3c8d:: with SMTP id g13mr8231545pjc.229.1624084820400;
        Fri, 18 Jun 2021 23:40:20 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id r19sm9440274pfh.152.2021.06.18.23.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 23:40:20 -0700 (PDT)
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
Subject: [PATCH 2/4] PCI: core: quirks: add mrrs_limit_quirk
Date:   Sat, 19 Jun 2021 14:39:50 +0800
Message-Id: <20210619063952.2008746-3-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210619063952.2008746-1-art@khadas.com>
References: <20210619063952.2008746-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prepare new MRRS limit quirk which can replace dublicated functionality
for some controllers from Loongson, Keystone, DesignWare

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 drivers/pci/quirks.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3b..73344ec71 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5612,3 +5612,57 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+/*
+ * Some Loongson PCIe ports have a h/w limitation of
+ * 256 bytes maximum read request size...
+ *
+ * Keystone PCI controller has a h/w limitation of
+ * 256 bytes maximum read request size.
+ *
+ * Amlogic DesignWare PCI controller on Khadas VIM3/VIM3L have some
+ * issue with HDMI scrambled picture and nvme devices
+ * at intensive writing...
+ */
+static void mrrs_limit_quirk(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct pci_dev *bridge;
+	int mrrs;
+	int mrrs_limit = 256;
+	static const struct pci_device_id bridge_devids[] = {
+		{ PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_PCIE_PORT_0) },
+		{ PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_PCIE_PORT_1) },
+		{ PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_PCIE_PORT_2) },
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_RC_K2HK),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_RC_K2E),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_RC_K2L),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_RC_K2G),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3) },
+		{ 0, },
+	};
+
+	/* look for the matching bridge */
+	while (!pci_is_root_bus(bus)) {
+		bridge = bus->self;
+		bus = bus->parent;
+		/*
+		 * 256 bytes maximum read request size. They can't handle
+		 * anything larger than this. So force this limit on
+		 * any devices attached under these ports.
+		 */
+		if (pci_match_id(bridge_devids, bridge)) {
+			mrrs = pcie_get_readrq(dev);
+			if (mrrs > mrrs_limit) {
+				pci_info(dev, "limiting MRRS %d to %d\n", mrrs, mrrs_limit);
+				pcie_set_readrq(dev, mrrs_limit);
+			}
+			break;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, mrrs_limit_quirk);
-- 
2.25.1

