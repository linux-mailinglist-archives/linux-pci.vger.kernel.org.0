Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D19379617
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 19:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhEJRhz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhEJRhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 13:37:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3031C0612FD
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 10:34:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r9so25764652ejj.3
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHjN4ud11W7ufGL5lDKa0FUQS8Q70dgAlNbeO28x8pE=;
        b=pfOF9s1At3PI7Y8nM1430huguxtWa0eAA2wXa4HezSgFZ+NoeDnmSFgmNWeN2DOytW
         vzD8wdTRxNRBHI6v6DyuTUiqlkPOxRhX3ei0ZxHaHf2ZZ0CsrqxpboMyFZtULNh3qMdN
         7tWIrUaGTd6UTUtwNYyCWebmIihDRZsrbiZ0TOjkfU39NOx/YpGcOhEFL2ZidERvxbyi
         sQOBPoS9a2Gn1QoPPe95j4ZiWwyOxDkCWWROrDIzXYE4lpwPpIuT4VNmjgEwsTl26f42
         ETdJHwpf02q0kv2qyr0Na/xz2J6/ZHNn6ldcUvbegRx0X0vW4HTGjGwHhVWsunw5Lyy7
         8EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHjN4ud11W7ufGL5lDKa0FUQS8Q70dgAlNbeO28x8pE=;
        b=c69xg4xXmm4ronvmb6WjAmarbc5R6S/mUJo5bZ1VRwJWP/PnTDkuH9W+w72B3rvfVU
         ps2DqtepfvL56JMQAlCQujeoGPB6oRyTw8ns8uykSAgNldinlEq/sel+O6BXhPWtwwXM
         lqcvMquHRBcIfdM6KbXWn9IABjg685dxSw+jUsPHiQbl3igxyYpl19P7/3m74MIuPewP
         1SRw0ipMu9I3mrKQK2cie5r/YWIgKKg9jG6qfjr8DnSiNAMRY98RiCYiWpSHN8Wx1vgZ
         xCWHqPg8GFozYnq7CSS02o7MwrB3Je+LiBp9PYXFA2hkHh5k+FFX2Ur0SdeKJNrEqIrh
         golQ==
X-Gm-Message-State: AOAM530a2VGsfc9DPy/Jgmw+05xLTqZhP8jm2vAIp/UC2KoI2IHf8s+Y
        reYed+1iDy4BCqyRjnjiH6i73w==
X-Google-Smtp-Source: ABdhPJy7AzUl9oCpF0fFjur0rbPIPZL8vA6cyRQdNO+lrTChZAd9PKv9aH+Sw0rPWd0x1Ks9OtEcug==
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr27368805ejc.437.1620668087757;
        Mon, 10 May 2021 10:34:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id wn14sm9845115ejb.28.2021.05.10.10.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:34:47 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bhelgaas@google.com, maz@kernel.org
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] PCI/MSI: Fix MSIs for generic hosts that use device-tree's "msi-map"
Date:   Mon, 10 May 2021 19:31:30 +0200
Message-Id: <20210510173129.750496-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 9ec37efb8783 ("PCI/MSI: Make pci_host_common_probe()
declare its reliance on MSI domains"), platforms that rely on the
"msi-map" device-tree property don't get MSIs anymore.

On the Arm Fast Model for example [1], the host bridge doesn't have a
"msi-parent" property since it doesn't itself generate MSIs, and so
doesn't get a MSI domain. It has an "msi-map" property instead to
describe MSI controllers of child devices. As a result, due to the new
msi_domain check in pci_register_host_bridge(), the whole bus gets
PCI_BUS_FLAGS_NO_MSI.

Check whether the root complex has an "msi-map" property before giving
up on MSIs.

[1] arch/arm64/boot/dts/arm/fvp-base-revc.dts

Fixes: 9ec37efb8783 ("PCI/MSI: Make pci_host_common_probe() declare its reliance on MSI domains")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci.h | 2 ++
 drivers/pci/of.c    | 7 +++++++
 drivers/pci/probe.c | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59a57..24306504226a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2344,6 +2344,7 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 struct device_node;
 struct irq_domain;
 struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
+bool pci_host_of_has_msi_map(struct device *dev);
 
 /* Arch may override this (weak) */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
@@ -2351,6 +2352,7 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
 #else	/* CONFIG_OF */
 static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
+static inline bool pci_host_of_has_msi_map(struct device *dev) { return false; }
 #endif  /* CONFIG_OF */
 
 static inline struct device_node *
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index da5b414d585a..85dcb7097da4 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -103,6 +103,13 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 #endif
 }
 
+bool pci_host_of_has_msi_map(struct device *dev)
+{
+	if (dev && dev->of_node)
+		return of_get_property(dev->of_node, "msi-map", NULL);
+	return false;
+}
+
 static inline int __of_pci_pci_compare(struct device_node *node,
 				       unsigned int data)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3a62d09b8869..275204646c68 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -925,7 +925,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
 	pci_set_bus_msi_domain(bus);
-	if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev))
+	if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
+	    !pci_host_of_has_msi_map(parent))
 		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 
 	if (!parent)
-- 
2.31.1

