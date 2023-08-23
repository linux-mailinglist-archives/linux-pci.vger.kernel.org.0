Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6891B785416
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjHWJbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjHWJYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 05:24:02 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59EDE5B9E;
        Wed, 23 Aug 2023 02:12:02 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="177395323"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Aug 2023 18:12:02 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id F01A6400856C;
        Wed, 23 Aug 2023 18:12:01 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v19 01/19] PCI: Add INTx Mechanism Messages macros
Date:   Wed, 23 Aug 2023 18:11:35 +0900
Message-Id: <20230823091153.2578417-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add "Message Routing" and "INTx Mechanism Messages" macros to enable
a PCIe driver to send messages for INTx Interrupt Signaling.

The "Message Routing" is from Table 2-17, and the "INTx Mechanism
Messages" is from Table 2-18 on the PCI Express Base Specification,
Rev. 4.0 Version 1.0.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c397434057..0b6df6c2c918 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,24 @@
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+/* Message Routing (r[2:0]) */
+#define PCI_MSG_TYPE_R_ROUTING_RC	0
+#define PCI_MSG_TYPE_R_ROUTING_ADDR	1
+#define PCI_MSG_TYPE_R_ROUTING_ID	2
+#define PCI_MSG_TYPE_R_ROUTING_BC	3
+#define PCI_MSG_TYPE_R_ROUTING_LOCAL	4
+#define PCI_MSG_TYPE_R_ROUTING_GATHER	5
+
+/* INTx Mechanism Messages */
+#define PCI_MSG_CODE_ASSERT_INTA	0x20
+#define PCI_MSG_CODE_ASSERT_INTB	0x21
+#define PCI_MSG_CODE_ASSERT_INTC	0x22
+#define PCI_MSG_CODE_ASSERT_INTD	0x23
+#define PCI_MSG_CODE_DEASSERT_INTA	0x24
+#define PCI_MSG_CODE_DEASSERT_INTB	0x25
+#define PCI_MSG_CODE_DEASSERT_INTC	0x26
+#define PCI_MSG_CODE_DEASSERT_INTD	0x27
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.25.1

