Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DE764FAB4
	for <lists+linux-pci@lfdr.de>; Sat, 17 Dec 2022 16:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiLQPiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Dec 2022 10:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiLQPf4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Dec 2022 10:35:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2DB1FFAE;
        Sat, 17 Dec 2022 07:30:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50917B80315;
        Sat, 17 Dec 2022 15:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E0DC43398;
        Sat, 17 Dec 2022 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671291003;
        bh=Sz7l4xKYsp8/UzC1w0mGcroM+1Sam1cNhuZ7a6E95M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzBE30nu/aAwTXmrWnmuuKu2+u6qaqlaWbTQ/77/cUzv4h9b55oCnHRl4MOv9epYk
         qgys4xitfnmAayJU4BPM9ZE6nuSQ1T7fJeFCQHcxDNir7g1F2GPUeZan/eozAJ+xx/
         rhJYiPQlEPuzDRZpqjLGC5nY2dxX1Mjf27163A23gzAB8jMn5UDbLJ903VRwTSYxc3
         o/jXWB7RjzF1Bqij5bbXK9liSk+7H33VYwgi7Txy7g0WHBkuXLxhvec9CDiccri+cF
         QJzpCJu3NZ2c/uLMXz7fAU+yDWef0rX6CAsZDw7RqLMFCAQhu+5+iwM5r6bb5pVZnM
         brZ1lgJLo48bw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        bhelgaas@google.com, rafael@kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 7/9] ACPI / PCI: fix LPIC IRQ model default PCI IRQ polarity
Date:   Sat, 17 Dec 2022 10:29:45 -0500
Message-Id: <20221217152949.99146-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221217152949.99146-1-sashal@kernel.org>
References: <20221217152949.99146-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jianmin Lv <lvjianmin@loongson.cn>

[ Upstream commit d0c50cc4b957b2cf6e43cec4998d212b5abe9220 ]

On LoongArch based systems, the PCI devices (e.g. SATA controllers and
PCI-to-PCI bridge controllers) in Loongson chipsets output high-level
interrupt signal to the interrupt controller they are connected (see
Loongson 7A1000 Bridge User Manual v2.00, sec 5.3, "For the bridge chip,
AC97 DMA interrupts are edge triggered, gpio interrupts can be configured
to be level triggered or edge triggered as needed, and the rest of the
interrupts are level triggered and active high."), while the IRQs are
active low from the perspective of PCI (see Conventional PCI spec r3.0,
sec 2.2.6, "Interrupts on PCI are optional and defined as level sensitive,
asserted low."), which means that the interrupt output of PCI devices plugged
into PCI-to-PCI bridges of Loongson chipset will be also converted to high-level.
So high level triggered type is required to be passed to acpi_register_gsi()
when creating mappings for PCI devices.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221022075955.11726-2-lvjianmin@loongson.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/pci_irq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index dea8a60e18a4..7b843a70f33d 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -399,13 +399,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	u8 pin;
 	int triggering = ACPI_LEVEL_SENSITIVE;
 	/*
-	 * On ARM systems with the GIC interrupt model, level interrupts
+	 * On ARM systems with the GIC interrupt model, or LoongArch
+	 * systems with the LPIC interrupt model, level interrupts
 	 * are always polarity high by specification; PCI legacy
 	 * IRQs lines are inverted before reaching the interrupt
 	 * controller and must therefore be considered active high
 	 * as default.
 	 */
-	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
+	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ||
+		       acpi_irq_model == ACPI_IRQ_MODEL_LPIC ?
 				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
 	char *link = NULL;
 	char link_desc[16];
-- 
2.35.1

