Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A216326AC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKUOsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiKUOrp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:47:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED255D32A1;
        Mon, 21 Nov 2022 06:41:51 -0800 (PST)
Message-ID: <20221121140049.237988384@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+qksWd2+ccMmqLte5f9aPSVt++7qKd9jnyVMQkZ0blc=;
        b=xNNxpN26XOiNIK1Emk3fcyWh3Vb/rxCZ0KWmilAmnOPvM3r3PacwAhHwcxWLgmtpZHhkQT
        jP1VcrkI+iuvdmrHbvA47gHQfzgsy4m8umj+7PyAzo2FmgcCP1HMMMgv7T/3b08eUmVJeO
        sR4nlMurDfJwTe8mCfL51Bbz59fDcgzICgAnIdBOhAwBJW4H1hiPqpuoq3/23ArbJn7eSY
        RmHg7NUPNAeDkSD9MWAknTB0EIJXw7l5hRclFHMCrvG7uYh7odHdOGPR+T8RR0BHTYfrm9
        QKc+AlIq/03LfRAjYZg57tSNUnnCp+/OV3jYzxpxwrwPhpOZee4bgaYgzpUzOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+qksWd2+ccMmqLte5f9aPSVt++7qKd9jnyVMQkZ0blc=;
        b=Jxt9EtE53tlRD9+hwUci8tAYYQ/g44FiV1TIMRiPipyRbRpVhKUZI8JvvGxXeO5KPFtp22
        POKx8P2tmAR7O3DQ==
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
Subject: [patch V2 15/40] irqchip/gic-msi-lib: Prepare for DEVICE MSI to
 replace platform MSI
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:47 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the prerequisites for DEVICE MSI into the shared select() and child
domain init function. These domains are really trivial and just provide a
custom irq chip callback to write the MSI message.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-msi-lib.c |   13 +++++++++++++
 drivers/irqchip/irq-gic-msi-lib.h |    2 ++
 2 files changed, 15 insertions(+)

--- a/drivers/irqchip/irq-gic-msi-lib.c
+++ b/drivers/irqchip/irq-gic-msi-lib.c
@@ -55,6 +55,19 @@ bool gic_msi_lib_init_dev_msi_info(struc
 
 		pci_device_msi_mask_unmask_parent_enable();
 		break;
+	case DOMAIN_BUS_DEVICE_IMS:
+		/*
+		 * Per device IMS should never have any MSI feature bits
+		 * set. It's sole purpose is to create a dumb interrupt
+		 * chip which has a device specific irq_write_msi_msg()
+		 * callback.
+		 */
+		if (WARN_ON_ONCE(info->flags))
+			return false;
+
+		/* Core managed MSI descriptors */
+		info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
+		break;
 	default:
 		/*
 		 * This should never be reached. See
--- a/drivers/irqchip/irq-gic-msi-lib.h
+++ b/drivers/irqchip/irq-gic-msi-lib.h
@@ -15,6 +15,8 @@
 #define MATCH_PCI_MSI		(0)
 #endif
 
+#define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
+
 int gic_msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 				  enum irq_domain_bus_token bus_token);
 

