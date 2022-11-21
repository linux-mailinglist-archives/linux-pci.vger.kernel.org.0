Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72D96326F1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKUOwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiKUOvz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:51:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B3DD5A3E;
        Mon, 21 Nov 2022 06:43:15 -0800 (PST)
Message-ID: <20221121140050.832658030@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=A01rDYLdDvEdsWawPTU2MFDnHSxCHYrfBjArC+9zM5k=;
        b=3sGZwrP7BHCmXcJ+qf3v40n2omf1oHAszj/1xHl6Kg1X461MsUlsAP37AbpTnZzZouvoUH
        SUCwCld4zKmQ5+NnqhbmMS5r7ORH9dhJHGBC9c792QmlCZ7PL0AKiaENw0ydlWEvQenG6U
        xWG+PH3xFf6vpNiEcRjehjI4JHDZr0TDFr5cpsYbbHcjQH7rqBIlN9hrB5sJX9Xu8cHp2n
        AntpJfk+tMZ/ipSRozoRp/jwjZbiEA0pnfOQNn9MzEIxlRetiExSBAl7YBRlUe8OopveGd
        UMqFBpwo3VCfWcyfZHUjAhmUD/6okVqX/8ETCDP+kKA2N8sXU8HSJ8ku7EI7ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=A01rDYLdDvEdsWawPTU2MFDnHSxCHYrfBjArC+9zM5k=;
        b=cCzTM/DDirCnDp3dnaeR/HDx5fiJc1DQ5Sr9zw9+PjVfvcVUuZwpGeICQAxP3WiEryK2VH
        Rj7e1wXY1BrfSoDw==
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
Subject: [patch V2 40/40] genirq/msi: Move msi_device_data to core
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:18 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the platform MSI hack is gone, nothing needs to know about struct
msi_device_data outside of the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   22 ----------------------
 kernel/irq/msi.c    |   24 ++++++++++++++++++++++--
 2 files changed, 22 insertions(+), 24 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -21,11 +21,7 @@
 #include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
 #include <linux/msi_api.h>
-#include <linux/xarray.h>
-#include <linux/mutex.h>
-#include <linux/list.h>
 #include <linux/irq.h>
-#include <linux/bits.h>
 
 #include <asm/msi.h>
 
@@ -212,24 +208,6 @@ enum msi_desc_filter {
 	MSI_DESC_ASSOCIATED,
 };
 
-/**
- * msi_device_data - MSI per device data
- * @properties:		MSI properties which are interesting to drivers
- * @mutex:		Mutex protecting the MSI descriptor store
- * @__store:		Xarray for storing MSI descriptor pointers
- * @__iter_idx:		Index to search the next entry for iterators
- * @__iter_max:		Index to limit the search
- * @__irqdomains:	Per device interrupt domains
- */
-struct msi_device_data {
-	unsigned long			properties;
-	struct mutex			mutex;
-	struct xarray			__store;
-	unsigned long			__iter_idx;
-	unsigned long			__iter_max;
-	struct irq_domain		*__irqdomains[MSI_MAX_DEVICE_IRQDOMAINS];
-};
-
 int msi_setup_device_data(struct device *dev);
 
 void msi_lock_descs(struct device *dev);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -8,18 +8,38 @@
  * This file contains common code to support Message Signaled Interrupts for
  * PCI compatible and non PCI compatible devices.
  */
-#include <linux/types.h>
 #include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "internals.h"
 
 /**
+ * msi_device_data - MSI per device data
+ * @properties:		MSI properties which are interesting to drivers
+ * @mutex:		Mutex protecting the MSI descriptor store
+ * @__store:		Xarray for storing MSI descriptor pointers
+ * @__iter_idx:		Index to search the next entry for iterators
+ * @__iter_max:		Index to limit the search
+ * @__irqdomains:	Per device interrupt domains
+ */
+struct msi_device_data {
+	unsigned long			properties;
+	struct mutex			mutex;
+	struct xarray			__store;
+	unsigned long			__iter_idx;
+	unsigned long			__iter_max;
+	struct irq_domain		*__irqdomains[MSI_MAX_DEVICE_IRQDOMAINS];
+};
+
+/**
  * struct msi_ctrl - MSI internal management control structure
  * @domid:	ID of the domain on which management operations should be done
  * @first:	First (hardware) slot index to operate on

