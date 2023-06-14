Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C8730452
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245011AbjFNP4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245176AbjFNP4r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 11:56:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A2D2
        for <linux-pci@vger.kernel.org>; Wed, 14 Jun 2023 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686758204; x=1718294204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=56EU1//nUi8+2GPEi8I4JHcx+44wHat4IeyEbEwYssU=;
  b=xc6JX/PKi+CAFKzCbZQdcEJVM+Ru4qfunOMvHOppOU7gOcw1Oj6PGCJs
   XHpIn72IGWJija/kVjbW/oV640ozG3d90RuCPv29h+iS4FaQ34q8A2w6P
   GPlkUzPhI9IR9yt2rHCciuQtmaVTpZNigdHyb/Eoylg19+SxQLAGXp69x
   ExHQhxaqwZAnhH6LajbWhriOxkgrJjElAOEABL5KJYpv+KSlLX3Nji2/U
   r5bHym/XV5TITNuN9QAaNFtnQlS7y+Jl3kR1M8gyFbXxn0tKclPxRgFOd
   gGvt2M2StTed1u+cejDly8HhItfCcYVZ7BWUfrwk7fRQdN6Q1/xQKa1t4
   A==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="220290982"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2023 08:56:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 14 Jun 2023 08:56:04 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 14 Jun 2023 08:56:03 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v1 2/8] PCI: microchip: Remove cast warning for devm_add_action_or_reset() arg
Date:   Wed, 14 Jun 2023 16:55:50 +0100
Message-ID: <20230614155556.4095526-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
References: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

The kernel test robot reported that the ugly cast from
void(*)(struct clk *) to void (*)(void *) converts to incompatible
function type.  This commit adopts the common convention of creating a
trivial stub function that takes a void * and passes it to the
underlying function that expects the more specific type.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index dd5245904c87..73046bad1521 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -848,6 +848,13 @@ static const struct irq_domain_ops event_domain_ops = {
 	.map = mc_pcie_event_map,
 };
 
+static inline void mc_pcie_chip_off_action(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
 static inline struct clk *mc_pcie_init_clk(struct device *dev, const char *id)
 {
 	struct clk *clk;
@@ -863,8 +870,7 @@ static inline struct clk *mc_pcie_init_clk(struct device *dev, const char *id)
 	if (ret)
 		return ERR_PTR(ret);
 
-	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare,
-				 clk);
+	devm_add_action_or_reset(dev, mc_pcie_chip_off_action, clk);
 
 	return clk;
 }
-- 
2.25.1

