Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7AD6E1C4D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 08:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjDNGQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjDNGQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 02:16:34 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37B2259EE;
        Thu, 13 Apr 2023 23:16:33 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,195,1677510000"; 
   d="scan'208";a="155958228"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Apr 2023 15:16:31 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6E7424195D7C;
        Fri, 14 Apr 2023 15:16:31 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v12 02/19] PCI: Add INtx Mechanism Messages macros
Date:   Fri, 14 Apr 2023 15:16:05 +0900
Message-Id: <20230414061622.2930995-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add "Message Routing" and "INTx Mechanism Messages" macros to send
a message by a PCIe driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 include/linux/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0b57e37d8e77..ada1047035a8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1050,6 +1050,24 @@ enum {
 #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
 #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
 
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
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-- 
2.25.1

