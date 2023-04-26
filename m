Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98A16EED2C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 06:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbjDZE4S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 00:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbjDZE4N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 00:56:13 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12835270B;
        Tue, 25 Apr 2023 21:56:07 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,227,1677510000"; 
   d="scan'208";a="157312773"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Apr 2023 13:56:05 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 44C8241763FC;
        Wed, 26 Apr 2023 13:56:05 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v14 03/21] PCI: Add INTx Mechanism Messages macros
Date:   Wed, 26 Apr 2023 13:55:39 +0900
Message-Id: <20230426045557.3613826-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add "Message Routing" and "INTx Mechanism Messages" macros to send
a message by a PCIe driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
 drivers/pci/pci.h                             | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8d552f..205bbcc6af27 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2475098f6518..4be376c121a4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -11,6 +11,25 @@
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
+/* Message Routing */
+#define PCI_MSG_ROUTING_RC	0
+#define PCI_MSG_ROUTING_ADDR	1
+#define PCI_MSG_ROUTING_ID	2
+#define PCI_MSG_ROUTING_BC	3
+#define PCI_MSG_ROUTING_LOCAL	4
+#define PCI_MSG_ROUTING_GATHER	5
+
+/* INTx Mechanism Messages */
+#define PCI_CODE_ASSERT_INTA	0x20
+#define PCI_CODE_ASSERT_INTB	0x21
+#define PCI_CODE_ASSERT_INTC	0x22
+#define PCI_CODE_ASSERT_INTD	0x23
+#define PCI_CODE_DEASSERT_INTA	0x24
+#define PCI_CODE_DEASSERT_INTB	0x25
+#define PCI_CODE_DEASSERT_INTC	0x26
+#define PCI_CODE_DEASSERT_INTD	0x27
+
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.25.1

