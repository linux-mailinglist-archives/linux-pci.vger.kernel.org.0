Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81D638189
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKXX1v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKXX1Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:27:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00818B11A;
        Thu, 24 Nov 2022 15:26:16 -0800 (PST)
Message-ID: <20221124232325.501144862@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KKwu6EVH8ruKNrQNXAsaHWUDYRK2+tT7uRCo5fxd1Vs=;
        b=zBLb/Ox7OJ0VV/3WNc7cfyfHZRZ9kH0LXxBr9yvermW/Cdpi8j9vMj4pORxOMop+qv+3ul
        M3AvejZVya/4s3APJ5vXtUlaJcaOCznMcq98LQlTnrztPkg7iPWCmwtABH316vm/9aC1fC
        ks8b27Ofl/d9YGQMDbfUXGZvyGv4kNz+92aLF6Pufvcw1JP+GlRb+eLDaGiyy5/XlBY9UX
        zLb7mUcRS+p6qPgYkrHpBqO9htQGC889H1qiM8jIbPYu4WH2G9ouMebAgnAwc4evmStG79
        Ykn//ds95V5V1BUEPoKLhHNj65WBzT9Zd4Losv9sn6OxOZipDmatJuJbWy+N5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KKwu6EVH8ruKNrQNXAsaHWUDYRK2+tT7uRCo5fxd1Vs=;
        b=U714pILZM40FuHR0FKCS8MjRY15jpHxDIzBby9AK0wRMzB+f2fhZeyenVKgAS965j0wNDK
        FLef1Gx9MlMtcsBA==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V3 04/33] genirq/msi: Add size info to struct msi_domain_info
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:25:51 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To allow proper range checking especially for dynamic allocations add a
size field to struct msi_domain_info. If the field is 0 then the size is
unknown or unlimited (up to MSI_MAX_INDEX) to provide backwards
compability.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Move the initialization into the common domain creation code
---
 include/linux/msi.h |    5 +++++
 kernel/irq/msi.c    |   11 +++++++++++
 2 files changed, 16 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -422,6 +422,10 @@ struct msi_domain_ops {
  * struct msi_domain_info - MSI interrupt domain data
  * @flags:		Flags to decribe features and capabilities
  * @bus_token:		The domain bus token
+ * @hwsize:		The hardware table size or the software index limit.
+ *			If 0 then the size is considered unlimited and
+ *			gets initialized to the maximum software index limit
+ *			by the domain creation code.
  * @ops:		The callback data structure
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
@@ -433,6 +437,7 @@ struct msi_domain_ops {
 struct msi_domain_info {
 	u32				flags;
 	enum irq_domain_bus_token	bus_token;
+	unsigned int			hwsize;
 	struct msi_domain_ops		*ops;
 	struct irq_chip			*chip;
 	void				*chip_data;
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -773,6 +773,17 @@ struct irq_domain *msi_create_irq_domain
 {
 	struct irq_domain *domain;
 
+	if (info->hwsize > MSI_XA_DOMAIN_SIZE)
+		return NULL;
+
+	/*
+	 * Hardware size 0 is valid for backwards compatibility and for
+	 * domains which are not backed by a hardware table. Grant the
+	 * maximum index space.
+	 */
+	if (!info->hwsize)
+		info->hwsize = MSI_XA_DOMAIN_SIZE;
+
 	msi_domain_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);

