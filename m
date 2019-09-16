Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C8B4217
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391485AbfIPUoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:44:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45786 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbfIPUoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:44:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so776480wrm.12;
        Mon, 16 Sep 2019 13:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gi9kNDzuHd/emIWQ69sBkpIiSLmOA3ELluXth5M4W3s=;
        b=FcKmtX4WiXdbOK2hxUpbqr4ysxnRdSjGXDj01g/3TkXQJhXpZP1B70QywuydOuL+Qu
         13msJK18W1XR/50KojUkeOA9IyiSE/fZLfeZ1cZYXskDU2lRiDgS2m8hJEha2zB3WjCE
         9DWja0AkoO+ULdWxw+n/OCUhpqWybOiusO8n33jk91x0JsMlyS/ZVHRcAM1mHCGFzKlF
         qEYR3Fo5RpXnfXEgshEMlMJdDA5SXNb80jIxMfRBzBSVA2w6seNQ0tkMRFdEvJn+QDbN
         0bqTWMccuHBfMMUS1nadVkFaXZ/HlTv5sZ8R6bu3NXOvYmx6hzFsKd71yU1/qzjATZC1
         de7g==
X-Gm-Message-State: APjAAAXskPoQTN9JEojdpnG/99/s94Dqgxw25lbutEtCaReRqRFZKxHE
        21JUNZI+M3wdGlVMKidbSb8=
X-Google-Smtp-Source: APXvYqxD8CmKKNxnq3M4FD4lAdtntmTgTM/ruEOVYXaPnVSDVDv3Ox3D5WfDzWJKyU38l/6npgrhBA==
X-Received: by 2002:a5d:6a06:: with SMTP id m6mr210072wru.190.1568666641674;
        Mon, 16 Sep 2019 13:44:01 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:44:01 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v3 03/26] PCI: dwc: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:35 +0300
Message-Id: <20190916204158.6889-4-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To iterate through all possible BARs, loop conditions refactored to the
*number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
valid BAR "i <= BAR_5". This is more idiomatic C style and allows to avoid
the fencepost error. Array definitions changed to PCI_STD_NUM_BARS where
appropriate.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c    | 2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c         | 2 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4234ddb4722f..b20651cea09f 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -353,7 +353,7 @@ static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	enum pci_barno bar;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++)
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
 
 	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index be61d96cc95e..c84218d8ffd3 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -57,7 +57,7 @@ static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++)
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index d00252bd8fae..9e2482bd7b6d 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -422,7 +422,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 	artpec6_pcie_wait_for_phy(artpec6_pcie);
 	artpec6_pcie_set_nfts(artpec6_pcie);
 
-	for (bar = BAR_0; bar <= BAR_5; bar++)
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index b58fdcbc664b..73646b677aff 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -70,7 +70,7 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++)
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ffed084a0b4f..7e0526bd71ad 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -205,7 +205,7 @@ struct dw_pcie_ep {
 	phys_addr_t		phys_base;
 	size_t			addr_size;
 	size_t			page_size;
-	u8			bar_to_atu[6];
+	u8			bar_to_atu[PCI_STD_NUM_BARS];
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
-- 
2.21.0

