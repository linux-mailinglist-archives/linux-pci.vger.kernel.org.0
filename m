Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B0A166DCF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 04:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgBUDg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 22:36:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40672 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgBUDg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2020 22:36:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id b185so474135pfb.7;
        Thu, 20 Feb 2020 19:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ix9Y2nFQkgNaD5RyzKlb0GalKo293yFxFO24g2Hr7BE=;
        b=cSv8qlub9fbpZ3p/6Hvn1F3xU7QIFUacsg2CgrAfvXwZQj/D6PZ620DrFibo38PxUJ
         J34fRp6oUTIXSibPUTAXaD8rgQ7zU3sOFnI5a9/5QdNsWgWIlFUD8CyiFPWwyNV5ABgm
         L+DlPtVj5MSjZ+mutI1SAySDC+ABp7/8kiTbGKkNPreuEiq4de7HGCn/DKR3mePmeowp
         FHNAZTPjBdjOF/AhNahU+MjlivUYcIqEOWQxI7axsuEnlQ9q1Iur7aEl31PCQsVtaT+g
         ncFzZWNNx0X6Ld+S2aUdXJnoqzPnEsSVr7PbY8yBFhP5BJt5A2YtGuD47bG5p3GNlUUj
         MZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ix9Y2nFQkgNaD5RyzKlb0GalKo293yFxFO24g2Hr7BE=;
        b=k8ucfvZeLjlewPR9+Wa342mIftQlA4qk3DFRNdnHzE3MnAP9idYpjcE5iEQ8zi3ANv
         8A4DbdLL9tqNAkYieVvVERn7U3tXksfzeG2qJa4PWnICc9yC0hcoIE2hNp4EENl8UJfT
         DkJWR2gJiHTx2Tqy1ZP9dR6Un6oYX2Hm2Wt0LUaaHmX5mS4Xe7QQpSNkfPR/MsbBeM87
         vEPIiQUe859688hhvH0xRQoY1y+GDwQNJA4IKRUqmmXXGUFbZauiDMVtCTIoDxtEWtL7
         73zRwuUiYW/i9UqBoANfHT3OML7xbQUNHUXUxW9nx5Mf+2543ENXPb0zYGYJLOiVIJie
         ATYQ==
X-Gm-Message-State: APjAAAXGs/8Lc9uVWCBn4ZPRvp9Phhn/wiXr5QgNCr1VSqSy9vjhD8PB
        AkvGELi28ek28k8nE9cVhAA=
X-Google-Smtp-Source: APXvYqyWhRoVOloNoo9kNtSguiV4jK6MA9XFVaDLEVL3Di0Yq0mE5Kxtw6jjVq1rdjQwBwZJA7LT2Q==
X-Received: by 2002:a63:4823:: with SMTP id v35mr35446928pga.177.1582256218382;
        Thu, 20 Feb 2020 19:36:58 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id d4sm781340pjz.12.2020.02.20.19.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 19:36:58 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH v2 1/2] PCI: brcmstb: Add regulator support
Date:   Fri, 21 Feb 2020 12:36:39 +0900
Message-Id: <20200221033640.55163-2-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200221033640.55163-1-jaedon.shin@gmail.com>
References: <20200221033640.55163-1-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ARM-based Broadcom STB SoCs have GPIO-based voltage regulator for PCIe
turning off/on power supplies.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 .../bindings/pci/brcm,stb-pcie.yaml           |  3 ++
 drivers/pci/controller/pcie-brcmstb.c         | 36 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 77d3e81a437b..efa5c885724b 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -56,6 +56,9 @@ properties:
     description: Indicates usage of spread-spectrum clocking.
     type: boolean
 
+  supply-names:
+    description: List of regulator supplies to use for PCIe
+
 required:
   - reg
   - dma-ranges
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index d20aabc26273..8968ef7fa55d 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -23,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -173,6 +174,8 @@ struct brcm_pcie {
 	int			gen;
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
+	struct regulator_bulk_data *vreg_bulk;
+	int			num_vregs;
 };
 
 /*
@@ -898,6 +901,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 {
 	brcm_msi_remove(pcie);
 	brcm_pcie_turn_off(pcie);
+	regulator_bulk_disable(pcie->num_vregs, pcie->vreg_bulk);
 	clk_disable_unprepare(pcie->clk);
 	clk_put(pcie->clk);
 }
@@ -920,6 +924,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	struct brcm_pcie *pcie;
 	struct pci_bus *child;
 	struct resource *res;
+	struct regulator_bulk_data *bulk;
+	int i;
 	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
@@ -955,6 +961,36 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = of_property_count_strings(np, "supply-names");
+	pcie->num_vregs = (ret < 0) ? 0 : ret;
+
+	if (pcie->num_vregs) {
+		bulk = devm_kcalloc(pcie->dev, pcie->num_vregs, sizeof(*bulk),
+				    GFP_KERNEL);
+		if (!bulk) {
+			clk_disable_unprepare(pcie->clk);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < pcie->num_vregs; i++)
+			of_property_read_string_index(np, "supply-names", i,
+						      &bulk[i].supply);
+
+		ret = devm_regulator_bulk_get(pcie->dev, pcie->num_vregs, bulk);
+		if (ret < 0) {
+			clk_disable_unprepare(pcie->clk);
+			return ret;
+		}
+
+		pcie->vreg_bulk = bulk;
+	}
+
+	ret = regulator_bulk_enable(pcie->num_vregs, pcie->vreg_bulk);
+	if (ret) {
+		clk_disable_unprepare(pcie->clk);
+		return ret;
+	}
+
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
 		goto fail;
-- 
2.21.0

