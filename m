Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028A9625C6A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiKKOGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiKKOGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:06:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C854B99311;
        Fri, 11 Nov 2022 05:59:37 -0800 (PST)
Message-ID: <20221111135205.715249181@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6sl/l9myt20lNdigYL4yWzzuJo6j8gI/Xo6NnbnNhEc=;
        b=CUXpw24Z4dNnYpWulhOHoxu2VLnVVH6Qi+7TSuHfvfE4PR9u0SVc7ys8dJtXtXCDqb0Csq
        z5cB3IaAcD2M7fDNFs9NJSMt0Jp4ABPDsynuJbb/JTMR1wWLqHO63TYc4FOfm51YMWqnJd
        9kQkxBQwInZk7vcT2A1rnPb/XtzkarrzibeQDU/ZQvXAET5BmtQHO1QBQtk+K2EMCJZIUl
        IDKpfAp+WcDnTjOJDLYmR5JCdtKVhyqnWYH2WN3CMdLtAg+UA5kzEa9BAvgIpAt2WTUfkO
        nBakLx3IZzP0i6+HrsLvCOoFUwVznrmw0vuo09Hrkoe5uQsydxTreB/NdFb9jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6sl/l9myt20lNdigYL4yWzzuJo6j8gI/Xo6NnbnNhEc=;
        b=cCgJ7SqTxK+BiY/mINACXMkjSUhgO8Wvz00QcM3lSNNA9xIx9FBZdYNxqRcSnuiJsA1eik
        QvVPdH0kHZUt/dAQ==
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
Subject: [patch 08/33] genirq/msi: Provide msi_match_device_domain()
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:23 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide an interface to match a per device domain bus token. This allows to
query which type of domain is installed for a particular domain id. Will be
used for PCI to avoid frequent create/remove cycles for the MSI resp. MSI-X
domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    3 +++
 kernel/irq/msi.c    |   25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -537,6 +537,9 @@ bool msi_create_device_irq_domain(struct
 				  void *chip_data);
 void msi_remove_device_irq_domain(struct device *dev, unsigned int domid);
 
+bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
+				 enum irq_domain_bus_token bus_token);
+
 int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1011,6 +1011,31 @@ void msi_remove_device_irq_domain(struct
 	msi_unlock_descs(dev);
 }
 
+/**
+ * msi_match_device_irq_domain - Match a device irq domain against a bus token
+ * @dev:	Pointer to the device
+ * @domid:	Domain id
+ * @bus_token:	Bus token to match against the domain bus token
+ *
+ * Return: True if device domain exists and bus tokens match.
+ */
+bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
+				 enum irq_domain_bus_token bus_token)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+	bool ret = false;
+
+	msi_lock_descs(dev);
+	domain = msi_get_device_domain(dev, domid);
+	if (domain && irq_domain_is_msi_device(domain)) {
+		info = domain->host_data;
+		ret = info->bus_token == bus_token;
+	}
+	msi_unlock_descs(dev);
+	return ret;
+}
+
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *arg)
 {

