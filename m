Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0710C587C88
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 14:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiHBMjT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 08:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiHBMjS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 08:39:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C64E1FCDD;
        Tue,  2 Aug 2022 05:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A166B81EF7;
        Tue,  2 Aug 2022 12:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B945C433D6;
        Tue,  2 Aug 2022 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659443954;
        bh=czjqSbGtpIYmswV/Rh3E0u4EPRbeo8kro8V9wiWdp5k=;
        h=From:To:Cc:Subject:Date:From;
        b=GzvWjGshRogL5da+jhHTw7kSXC/ItA43Eelv5Fg5fhWHujny4CORKbWe3G8cl6dmv
         rWDUl1TZNX6WUGK3WmTrBjdB0J0lGa/AWWNQbJsBqmgHDiAMb+ULVxWfmtDnZO/NhY
         mONuZthsFIplbOHBEv6BspaNrSEQTKlZ8YXYJ+xDGL54Bmzg8tzaEpWzPFnf3cS8HH
         ykbPOMNvbi6SXS5gkp/kv/9cembG4Nk0MpWeFo3ghK6CDKZsffLJM8T7yqTmuRPLll
         oJMxIGznROtPB7+wi3zpKTh9xPVZCFnPG60O7he/CRWBUUhjNE5eioQjhGudIdGDAV
         o1uy/9X1hpKAQ==
Received: by pali.im (Postfix)
        id F224DF81; Tue,  2 Aug 2022 14:39:10 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Elad Nachman <enachman@marvell.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Subject: [PATCH v2] PCI: aardvark: Implement workaround for PCIe Completion Timeout
Date:   Tue,  2 Aug 2022 14:38:16 +0200
Message-Id: <20220802123816.21817-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marvell Armada 3700 Functional Errata, Guidelines, and Restrictions
document describes in erratum 3.12 PCIe Completion Timeout (Ref #: 251),
that PCIe IP does not support a strong-ordered model for inbound posted vs.
outbound completion.

As a workaround for this erratum, DIS_ORD_CHK flag in Debug Mux Control
register must be set. It disables the ordering check in the core between
Completions and Posted requests received from the link.

Marvell also suggests to do full memory barrier at the beginning of
aardvark summary interrupt handler before calling interrupt handlers of
endpoint drivers in order to minimize the risk for the race condition
documented in the Erratum between the DMA done status reading and the
completion of writing to the host memory.

More details about this issue and suggested workarounds are in discussion:
https://lore.kernel.org/linux-pci/BN9PR18MB425154FE5019DCAF2028A1D5DB8D9@BN9PR18MB4251.namprd18.prod.outlook.com/t/#u

It was reported that enabling this workaround fixes instability issues and
"Unhandled fault" errors when using 60 GHz WiFi 802.11ad card with Qualcomm
QCA6335 chip under significant load which were caused by interrupt status
stuck in the outbound CMPLT queue traced back to this erratum.

This workaround fixes also kernel panic triggered after some minutes of
usage 5 GHz WiFi 802.11ax card with Mediatek MT7915 chip:

    Internal error: synchronous external abort: 96000210 [#1] SMP
    Kernel panic - not syncing: Fatal exception in interrupt

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 060936ef01fe..3ae8a85ec72e 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -210,6 +210,8 @@ enum {
 };
 
 #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
+#define DEBUG_MUX_CTRL_REG			(LMI_BASE_ADDR + 0x208)
+#define     DIS_ORD_CHK				BIT(30)
 
 /* PCIe core controller registers */
 #define CTRL_CORE_BASE_ADDR			0x18000
@@ -558,6 +560,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 		PCIE_CORE_CTRL2_TD_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
+	/* Disable ordering checks, workaround for erratum 3.12 "PCIe completion timeout" */
+	reg = advk_readl(pcie, DEBUG_MUX_CTRL_REG);
+	reg |= DIS_ORD_CHK;
+	advk_writel(pcie, reg, DEBUG_MUX_CTRL_REG);
+
 	/* Set lane X1 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
 	reg &= ~LANE_CNT_MSK;
@@ -1581,6 +1588,9 @@ static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
 	struct advk_pcie *pcie = arg;
 	u32 status;
 
+	/* Full memory barrier (ARM dsb sy), workaround for erratum 3.12 "PCIe completion timeout" */
+	mb();
+
 	status = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
 	if (!(status & PCIE_IRQ_CORE_INT))
 		return IRQ_NONE;
-- 
2.20.1

