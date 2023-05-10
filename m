Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5212A6FD6B7
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 08:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjEJGWm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 02:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjEJGWk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 02:22:40 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FDC730E4;
        Tue,  9 May 2023 23:22:39 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,263,1677510000"; 
   d="scan'208";a="162314821"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 May 2023 15:22:36 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4B6684010E3C;
        Wed, 10 May 2023 15:22:36 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v16 03/22] PCI: Add INTx Mechanism Messages macros
Date:   Wed, 10 May 2023 15:22:15 +0900
Message-Id: <20230510062234.201499-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
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
 drivers/pci/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2475098f6518..67badc40e90b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -11,6 +11,24 @@
 
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
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.25.1

