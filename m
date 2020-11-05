Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AD62A88B4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 22:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbgKEVM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 16:12:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44330 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732250AbgKEVM0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 16:12:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id t16so3146956oie.11
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 13:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ALIymgzZ5CvzwYOHXop16gSikOOrTJTNpu72Aj6Xuc=;
        b=cyTx2OlfY8BjhY2QpbS7HxcgP79br9EVjWtxqclf81GIvYjBBjVtlwU7gCzIY27SaJ
         Kie8QkD6+aQQ2UdLH7fde8ErTue2zcVJ1yXYoWRLzgkEGTvFJaGjorY2qpzbEEQC1Zwr
         7zZmoQFfECHlTqZIwbHyCRgdE0oNjwZR09qC2mW0go0iYo8ig1Mb0HhmwylT4/oaHK/M
         rTy4RzBgXaF13Zgu8Wtn5B5R2YU3J5BSnrxV0cy1nLZbo4/822tpOdb5LpWLEYk3YWEn
         OxmhxI9/oHuEA3nvbpXFptBFCCDFc/SU3CtecJzWzFTAZRqgBPvHoUwMDZ9j+U2phY+G
         CLTA==
X-Gm-Message-State: AOAM530nVOAwoOxP4TSP3cMA9lUvNvQQ+lcJ/DwLzL2wwG0gB4F5JGwN
        UTqfsjMDwJ0nVkO6hkjIQbEE5IKzyzuv
X-Google-Smtp-Source: ABdhPJzE4N+GyPE1rBfJBgcLJ5uOt6Sw+xPdx29XKBxGa1d4tZD//KJLosmK+njVjxcjJNwvWfETiQ==
X-Received: by 2002:aca:a842:: with SMTP id r63mr887050oie.57.1604610745448;
        Thu, 05 Nov 2020 13:12:25 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:12:24 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 14/16] Revert "PCI: dwc/keystone: Drop duplicated 'num-viewport'"
Date:   Thu,  5 Nov 2020 15:11:57 -0600
Message-Id: <20201105211159.1814485-15-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 421063efaf1e8f2ac6248cca0064e5877e375f87.

In preparation to detect the number of iATU regions instead of using DT
properties, we need to keep reading 'num-viewport' for the Keystone
driver which doesn't use the iATU in older versions of the IP.

However, note that Keystone has been broken for some time with upstream
dts files which don't set 'num-viewports'. The reverted commit did
make the property optional, but now it's mandatory again.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - new patch

 drivers/pci/controller/dwc/pci-keystone.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 719756160821..53aa35cb3a49 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -121,6 +121,7 @@ struct keystone_pcie {

 	int			msi_host_irq;
 	int			num_lanes;
+	u32			num_viewport;
 	struct phy		**phy;
 	struct device_link	**link;
 	struct			device_node *msi_intc_np;
@@ -386,9 +387,9 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
+	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
-	u32 num_viewport = pci->num_viewport;
 	u64 start, end;
 	struct resource *mem;
 	int i;
@@ -1093,6 +1094,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct resource *res;
 	unsigned int version;
 	void __iomem *base;
+	u32 num_viewport;
 	struct phy **phy;
 	u32 num_lanes;
 	char name[10];
@@ -1224,6 +1226,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}

+		ret = of_property_read_u32(np, "num-viewport", &num_viewport);
+		if (ret < 0) {
+			dev_err(dev, "unable to read *num-viewport* property\n");
+			goto err_get_sync;
+		}
+
 		/*
 		 * "Power Sequencing and Reset Signal Timings" table in
 		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 2.0
@@ -1237,6 +1245,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 			gpiod_set_value_cansleep(gpiod, 1);
 		}

+		ks_pcie->num_viewport = num_viewport;
 		pci->pp.ops = host_ops;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
--
2.25.1
