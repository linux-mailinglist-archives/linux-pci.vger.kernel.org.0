Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D346F632708
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiKUO4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiKUOz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:55:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E135D0DCC;
        Mon, 21 Nov 2022 06:45:57 -0800 (PST)
Message-ID: <20221121140049.038269899@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LWZzkLvZ5gHjlFpFBFxZZ1jfolwvE2BdWztZvI0p9OM=;
        b=sd7rSg2kigN5NlHza6Cga+tuw6V9g85Jshy3OJDjK1D5b+qUcdz91t0O3Qb7ZR3SW3lewI
        DfbjxwYyurnLIoogWDByWH0NlutYf0V9VkIgvV++7jY+zYa2EGu6EI+IFMEIRtc7la0rzE
        WH2IxOydVABXRQ06Sao4uSzlRihp9Tikofgzb6iL/mTFJaNuvRHqVrlxRDhFWQbqjxfnwK
        igW9I5XFFuEXC8Yb8YimZO73/2RCiXQFbZQ3E87PAo1mabN/cafe+5XcUS3S6syHFoA8dp
        uv6aXrfvYzLHbEOGm8lueongK4ZyUOIXhPaYWp2MYcMNNmNeyME8yfFFDVpvzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LWZzkLvZ5gHjlFpFBFxZZ1jfolwvE2BdWztZvI0p9OM=;
        b=1LwGc7zMWirV3udF+2ZM+b/fwdVY8bzXmFqARcd7mOXQ0aeXbaK0OWc4jNKdf3PHPi8Z1H
        paC0VXkW6C9Kn5Aw==
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
Subject: [patch V2 12/40] irqchip/gic-msi-lib: Prepare for PCI MSI/MSIX
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:43 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the bus tokens for DOMAIN_BUS_PCI_DEVICE_MSI and
DOMAIN_BUS_PCI_DEVICE_MSIX to the common child init
function and enable the parent mask/unmask static key
in the PCI/MSI core.

Provide the match mask which can be used by parent domain
implementation so the bitmask based child bus token match
works.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-msi-lib.c |    7 +++++++
 drivers/irqchip/irq-gic-msi-lib.h |    6 ++++++
 2 files changed, 13 insertions(+)

--- a/drivers/irqchip/irq-gic-msi-lib.c
+++ b/drivers/irqchip/irq-gic-msi-lib.c
@@ -48,6 +48,13 @@ bool gic_msi_lib_init_dev_msi_info(struc
 
 	/* Is the target domain bus token supported ? */
 	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
+			return false;
+
+		pci_device_msi_mask_unmask_parent_enable();
+		break;
 	default:
 		/*
 		 * This should never be reached. See
--- a/drivers/irqchip/irq-gic-msi-lib.h
+++ b/drivers/irqchip/irq-gic-msi-lib.h
@@ -9,6 +9,12 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 
+#ifdef CONFIG_PCI_MSI
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+#else
+#define MATCH_PCI_MSI		(0)
+#endif
+
 int gic_msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 				  enum irq_domain_bus_token bus_token);
 

