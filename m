Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676276326F3
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiKUOwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKUOvx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:51:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8267D53B8;
        Mon, 21 Nov 2022 06:43:15 -0800 (PST)
Message-ID: <20221121140050.133104126@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qmJiB7lB+dvr1o+yo/genv3gkUodKqwbvfDSuvcwh7M=;
        b=SewWDnqoysUZwY2PAvCoRCcC1OPvN+pqfOVStFETafSX77gkq09/4wDnr9H9cDKGCHfBrl
        /Sji0uokjKN8s8bpnt1/I2cbg/Xs6pYcvCSZudNEstb4J6E//K4Jwnin9Hpbuczfjcod3T
        rIoZgZOrTROfoy+FioxNT5MpzPjafM3ZuR4h7IzC0tKFk59/u1xX1T2/zvMNgEpwtCDiE9
        ZSBaokGfsXo7SJu8yjfQ6n2coE4m9y6fKcHazxADAvHXEnF/mvq3b+M7EQoXkPw503DFol
        4BAF47XsCSGFmAl2V6PvLRYqNeZQ9px82wxNpZzz4aSyQA+k84pX/pNV3Yledg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qmJiB7lB+dvr1o+yo/genv3gkUodKqwbvfDSuvcwh7M=;
        b=kstALqzR6emQvai0k5knVo/BHPAWBt3K2qykTwvCvy+d5gAK1yJ7IgMLcRd2xQ9R5qVKFq
        UsktR2VG8sf4XuBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 29/40] genirq/gic-v3-mbi: Remove unused wired MSI mechanics
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:04 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nothing builds a platform_device MSI domain for wire to MSI on top of
this. The "regular" users of the platform MSI domain just provide their own
irq_write_msi_msg() callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-mbi.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -199,31 +199,16 @@ static int mbi_allocate_pci_domain(struc
 }
 #endif
 
-static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	mbi_compose_msi_msg(data, msg);
-
-	msg[1].address_hi = upper_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
-	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
-	msg[1].data = data->parent_data->hwirq;
-
-	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
-}
-
 /* Platform-MSI specific irqchip */
 static struct irq_chip mbi_pmsi_irq_chip = {
 	.name			= "pMSI",
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_compose_msi_msg	= mbi_compose_mbi_msg,
-	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
 };
 
 static struct msi_domain_ops mbi_pmsi_ops = {
 };
 
 static struct msi_domain_info mbi_pmsi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
 	.ops	= &mbi_pmsi_ops,
 	.chip	= &mbi_pmsi_irq_chip,
 };

