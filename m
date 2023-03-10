Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0025F6B4851
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 16:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjCJPBZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 10:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjCJPBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 10:01:04 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2DC124E9A;
        Fri, 10 Mar 2023 06:54:42 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso3026954ots.9;
        Fri, 10 Mar 2023 06:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAwxMVgEJW/diY6+z5s1oE+bbPFu7/bM9oM0FwFsxyE=;
        b=LYIFedrA/+UWubpZ0pRqo+xMWtAvlrgz/zMkq/jIt7/d0rytuTg7gUHzgBQDPUO2WH
         OzfxeqiNog7kajvMFDndgOSPDJKz+cTeBvZwez9VWcbYasV3J81OMrSlzeT61Zf/wLf/
         gQzLAso4zEeQtIovMs8tVXuqbhDfCT78CmSICSLNGgf6lvY73UHyvDzzYf922pEcya0I
         DCbGm6DPEUzedu7FaGRujP6AAty5/QXip7Pbc4rrjf6BbY6DPNJxkxASDWwZXDlzPaqm
         L6qComkzDecYIZ+4pC/bNsB3s9S/V1ml3vB1EL+5adiajitIXa69XLDeJsGqUYIazZGT
         A5Sw==
X-Gm-Message-State: AO0yUKWiYpUdYbjeRtmMdDmAjav+Ts/zVo204ypAMk3UVFwBL+MafDWX
        4sPwigrv7QgrJDQDdRonTw==
X-Google-Smtp-Source: AK7set96ixhp821kK8jijKchnvAgmkphcExUaHLLv7P6NqMK7LhdxgFUjRonphsIl2+XBIEkxGUmRQ==
X-Received: by 2002:a05:6830:248f:b0:68b:cb5c:8e1 with SMTP id u15-20020a056830248f00b0068bcb5c08e1mr13902010ots.13.1678459707649;
        Fri, 10 Mar 2023 06:48:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q19-20020a05683022d300b0068bd20cf07dsm115696otc.48.2023.03.10.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:27 -0800 (PST)
Received: (nullmailer pid 1544470 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:19 -0600
Message-Id: <20230310144719.1544443-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-tegra.c     | 4 ++--
 drivers/pci/controller/pcie-mediatek.c | 2 +-
 drivers/pci/hotplug/rpaphp_core.c      | 4 ++--
 drivers/pci/of.c                       | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 74c109f14ff0..79630885b9c8 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1375,7 +1375,7 @@ static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
 	struct tegra_pcie_port *port;
 	int err;
 
-	if (!soc->has_gen2 || of_find_property(np, "phys", NULL) != NULL)
+	if (!soc->has_gen2 || of_property_present(np, "phys"))
 		return tegra_pcie_phys_get_legacy(pcie);
 
 	list_for_each_entry(port, &pcie->ports, list) {
@@ -1944,7 +1944,7 @@ static bool of_regulator_bulk_available(struct device_node *np,
 	for (i = 0; i < num_supplies; i++) {
 		snprintf(property, 32, "%s-supply", supplies[i].supply);
 
-		if (of_find_property(np, property, NULL) == NULL)
+		if (!of_property_present(np, property))
 			return false;
 	}
 
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index ae5ad05ddc1d..31de7a29192c 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -643,7 +643,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 		return err;
 	}
 
-	if (of_find_property(dev->of_node, "interrupt-names", NULL))
+	if (of_property_present(dev->of_node, "interrupt-names"))
 		port->irq = platform_get_irq_byname(pdev, "pcie_irq");
 	else
 		port->irq = platform_get_irq(pdev, port->slot);
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 491986197c47..2316de0fd198 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -278,7 +278,7 @@ int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
 		return -EINVAL;
 	}
 
-	if (of_find_property(dn->parent, "ibm,drc-info", NULL))
+	if (of_property_present(dn->parent, "ibm,drc-info"))
 		return rpaphp_check_drc_props_v2(dn, drc_name, drc_type,
 						be32_to_cpu(*my_index));
 	else
@@ -440,7 +440,7 @@ int rpaphp_add_slot(struct device_node *dn)
 	if (!of_node_name_eq(dn, "pci"))
 		return 0;
 
-	if (of_find_property(dn, "ibm,drc-info", NULL))
+	if (of_property_present(dn, "ibm,drc-info"))
 		return rpaphp_drc_info_add_slot(dn);
 	else
 		return rpaphp_drc_add_slot(dn);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..e085f2eca372 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -447,7 +447,7 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 		return -ENODEV;
 
 	/* Local interrupt-map in the device node? Use it! */
-	if (of_get_property(dn, "interrupt-map", NULL)) {
+	if (of_property_present(dn, "interrupt-map")) {
 		pin = pci_swizzle_interrupt_pin(pdev, pin);
 		ppnode = dn;
 	}
-- 
2.39.2

