Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106FC63269B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKUOpg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiKUOpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:45:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB7D0892;
        Mon, 21 Nov 2022 06:40:03 -0800 (PST)
Message-ID: <20221121140048.534395323@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=C+l3aMd1UpaHQsZc5/Vr1+tQOoVWd1U/GSVn/k0pohc=;
        b=WZfo13zi3BCAgNxewO+cS7nrTD8Mnhb1NbDbk3rBNcd1RI+C2jqp/ofu+uCLJ/5smPxjS2
        DdU53REQSsLDryvdSn4jWds0RIZsgIpL1h8EuGYBx8+P6E0AScjRpdJxJKOp8ITfluWs0n
        Wqj3EgGiFhwIkzgOfjZHrJ9t8VnYi5hr0qOM++fJDJqVdFe87Fx9VdC0bh1dG9AnmsFfvB
        m4Wr7uQXCngnKHpBP+qnOI7YHsfGOi5zbtcRgzP8Bq7L6IDPyi6z6NotGige2rTP5xcEdY
        bh44iFTO9VDnxoXsGMz4OnjrHb7pN5OYh6iuVIi/yZ3I7RJZ4xuodtHfkyV/vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=C+l3aMd1UpaHQsZc5/Vr1+tQOoVWd1U/GSVn/k0pohc=;
        b=RnSWq2rd3aL/RH88+Ocv83BFbW5wGXqdOpB9BP1wIJCWDFtUurrVBgdIwCoqh1hHqielUK
        tRoWzYrmwFNEw9DA==
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
Subject: [patch V2 04/40] irqchip/gic-v2m: Mark a few functions __init
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:33 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

They are all part of the init sequence.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v2m.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -263,7 +263,7 @@ static struct msi_domain_info gicv2m_pms
 	.chip	= &gicv2m_pmsi_irq_chip,
 };
 
-static void gicv2m_teardown(void)
+static void __init gicv2m_teardown(void)
 {
 	struct v2m_data *v2m, *tmp;
 
@@ -278,7 +278,7 @@ static void gicv2m_teardown(void)
 	}
 }
 
-static int gicv2m_allocate_domains(struct irq_domain *parent)
+static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
 	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
 	struct v2m_data *v2m;
@@ -405,7 +405,7 @@ static int __init gicv2m_init_one(struct
 	return ret;
 }
 
-static const struct of_device_id gicv2m_device_id[] = {
+static __initconst struct of_device_id gicv2m_device_id[] = {
 	{	.compatible	= "arm,gic-v2m-frame",	},
 	{},
 };
@@ -455,7 +455,7 @@ static int __init gicv2m_of_init(struct
 #ifdef CONFIG_ACPI
 static int acpi_num_msi;
 
-static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
+static __init struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 {
 	struct v2m_data *data;
 
@@ -470,7 +470,7 @@ static struct fwnode_handle *gicv2m_get_
 	return data->fwnode;
 }
 
-static bool acpi_check_amazon_graviton_quirks(void)
+static __init bool acpi_check_amazon_graviton_quirks(void)
 {
 	static struct acpi_table_madt *madt;
 	acpi_status status;

