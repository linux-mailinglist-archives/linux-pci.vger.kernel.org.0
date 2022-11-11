Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E9625C25
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiKKOBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiKKOAf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:00:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E737F814FD;
        Fri, 11 Nov 2022 05:56:48 -0800 (PST)
Message-ID: <20221111132706.332816984@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+CkTPHTMXOvRSl4YB673TzHqsVFLjHUDowE8deLkwuw=;
        b=gNnRb6mrbonmhBd8GR2CBf2YUwkoKxyhGHRH2Vew6IAJ1aoaNsG72PZxdV2iXRLVZ4Uh4q
        vxD/3XMxd+I5f2oUt+iysBur2W5wdQun2frxS2K99K1IFc5OKycKQeMjQYt7e9hv5AxA3u
        vrzWBUYAkXPOwUVn+/Dj6HyJ1sDgCECZwBQux++n0bUmd7CaQpT8KAjQqNibNkNZWNJQpH
        YEPnK+UtxPITgqJ01xgYSVgI9NG6OgyLq5KJC6oqZ4yg7eluvoKEdu7FmdNcUX0xtFRfiF
        amonQVthSLuzmJlWs5l55YkXYmKz3ayecVpRHTlqjQi1j4jfj1Kd5BFoWnXRCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+CkTPHTMXOvRSl4YB673TzHqsVFLjHUDowE8deLkwuw=;
        b=8IPFVf2Sz/jfFvdgpzjQUfkbUjKJhpZNKH+G9byBcUzBkUSLl+f2JohdhaKYFUMabfMsNd
        JRIcUopJmj64EPCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 05/20] genirq/irqdomain: Provide IRQ_DOMAIN_FLAG_MSI_DEVICE
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:45 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to marking parent MSI domains it's required to identify per device
domains. Add flag and helpers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -192,6 +192,9 @@ enum {
 	/* Irq domain is a MSI parent domain */
 	IRQ_DOMAIN_FLAG_MSI_PARENT	= (1 << 8),
 
+	/* Irq domain is a MSI device domain */
+	IRQ_DOMAIN_FLAG_MSI_DEVICE	= (1 << 9),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -559,6 +562,11 @@ static inline bool irq_domain_is_msi_par
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_PARENT;
 }
 
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
+}
+
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
@@ -609,6 +617,11 @@ static inline bool irq_domain_is_msi_par
 {
 	return false;
 }
+
+static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
+{
+	return false;
+}
 
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 

