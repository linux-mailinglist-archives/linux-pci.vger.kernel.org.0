Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4652A486
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbiEQOQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiEQOQg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 10:16:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4057B853
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652796995; x=1684332995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4DqbCVdSjDYbptt+KXYrVXfB5cPq1/JE4hCg0Rx6uWQ=;
  b=Yk2c02XtGLU8BBZE2ZN6id7ntrpk1m03MV18CuoHFPoWqOkspyu6nW7b
   gryoSb8qxQUqQWlDhM+jfrK+ghnul5HOAWJP230OfnmOQR4yLL8zPEvfH
   uI6eZZ7NGdFl5cPokYlCvr7Ix/gan1U0yAa4Jm+BKBWnRUQcax4Ji3QYo
   4b4XXr1Q8y8CCivtatLpaUx6xeNxPo6WSBvPURJ/OOPQZu8MTsrlGgL6g
   R9sfuUDynoWDc+7lvJWnfVV9q0rcCbHnES9vpxxYW6aijrhxSCtDlF2HO
   q35RehxRJeZmqN7nJBhNSylkQEoFJfDP0IP8aJIf+oAGvAPk8+ljE5uPz
   w==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="96141879"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 07:16:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 07:16:29 -0700
Received: from daire-X570.school.villiers.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 17 May 2022 07:16:27 -0700
From:   <daire.mcnamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>
CC:     <conor.dooley@microchip.com>, <cyril.jean@microchip.com>,
        <bhelgaas@google.com>, <david.abdurachmanov@gmail.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <maz@kernel.org>, <robh@kernel.org>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v2] PCI: microchip: Fix potential race in interrupt handling
Date:   Tue, 17 May 2022 15:16:22 +0100
Message-ID: <20220517141622.145581-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Clear the MSI bit in ISTATUS_LOCAL register after reading it, but
before reading and handling individual MSI bits from the ISTATUS_MSI
register. This avoids a potential race where new MSI bits may be set
on the ISTATUS_MSI register after it was read and be missed when the
MSI bit in the ISTATUS_LOCAL register is cleared.

ISTATUS_LOCAL is a read/write/clear register; the register's bits
are set when the corresponding interrupt source is activated. Each
source is independent and thus multiple sources may be active
simultaneously. The local processor can monitor and clear status
bits. If one or more ISTATUS_LOCAL interrupt sources are active,
the RootPort issues an interrupt towards the Local Processor (on
the AXI domain). Bit 28 of this register reports an MSI has been
received by the RootPort.

ISTATUS_MSI is a read/write/clear register.  Bits 31-0 are asserted
when an MSI with message number 31-0 is received by the RootPort.
The local processor must monitor and clear these bits.

Effectively, Bit 28 of ISTATUS_LOCAL informs the processor that
an MSI has arrived at the RootPort and ISTATUS_MSI informs the
processor which MSI (in the range 0 - 31) needs handling.

Reported by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/linux-pci/20220127202000.GA126335@bhelgaas/
Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 329f930d17aa..fa209ad067bf 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -416,6 +416,7 @@ static void mc_handle_msi(struct irq_desc *desc)
 
 	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
 	if (status & PM_MSI_INT_MSI_MASK) {
+		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATUS_LOCAL);
 		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
 		for_each_set_bit(bit, &status, msi->num_vectors) {
 			ret = generic_handle_domain_irq(msi->dev_domain, bit);
@@ -432,13 +433,8 @@ static void mc_msi_bottom_irq_ack(struct irq_data *data)
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	u32 bitpos = data->hwirq;
-	unsigned long status;
 
 	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
-	status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
-	if (!status)
-		writel_relaxed(BIT(PM_MSI_INT_MSI_SHIFT),
-			       bridge_base_addr + ISTATUS_LOCAL);
 }
 
 static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
-- 
2.25.1

