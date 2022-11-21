Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2763260B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiKUOgw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiKUOgj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7643C8440;
        Mon, 21 Nov 2022 06:36:24 -0800 (PST)
Message-ID: <20221121083325.741538017@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fX3YyaTkrRIM3kSpqK/PVSD3oj0zimiyOCtXLtrgK+M=;
        b=07AUa4iet7fSYqd60LLyVgrQcBpD/0U3skBP8nPL3Wpkw+0D/vqRQp/xYMTAAr4PQVv05e
        ThkWMW0Kaf2JuMzIapqBFhqPq+xztn2dgSZbP48V+3Qvz3KuL7TyBSijTq3L7/6r78Pn4t
        t7qadKTQtawlyO1HQbp3yT7eN3fn1fAk+Va24K3MfYggSo3RX7cL00ZBeix30pecrYH4Nh
        h+Zq7Kt9Qc0OTcv+i2QouEuRmYrHUfypKzoXaAk6DHv/JCFw6Z97faXC0jZZ/yzkBkl1PE
        K9bSvBgazsA9ORZiK/O7WxFbOJDwyVD4sMIt9PR4ItmH5qVS9Wb+ND2vxHmkVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fX3YyaTkrRIM3kSpqK/PVSD3oj0zimiyOCtXLtrgK+M=;
        b=jUUGa1+CU4hAamt7oCsjQtnY1L/HCzsi+lv3jUC0kT1+6UQuyIuTKFYPm0R5J8ud/LxxSs
        veZXWz6oc8f+/bDA==
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [patch V2 04/21] genirq/msi: Create msi_api.h
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:23 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Create a API header for MSI specific functions which are relevant to device
drivers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/msi.h     |    6 ++++--
 include/linux/msi_api.h |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -13,11 +13,14 @@
  *
  * Regular device drivers have no business with any of these functions and
  * especially storing MSI descriptor pointers in random code is considered
- * abuse. The only function which is relevant for drivers is msi_get_virq().
+ * abuse.
+ *
+ * Device driver relevant functions are available in <linux/msi_api.h>
  */
 
 #include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
+#include <linux/msi_api.h>
 #include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -188,7 +191,6 @@ struct msi_device_data {
 
 int msi_setup_device_data(struct device *dev);
 
-unsigned int msi_get_virq(struct device *dev, unsigned int index);
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
--- /dev/null
+++ b/include/linux/msi_api.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_MSI_API_H
+#define LINUX_MSI_API_H
+
+/*
+ * APIs which are relevant for device driver code for allocating and
+ * freeing MSI interrupts and querying the associations between
+ * hardware/software MSI indices and the Linux interrupt number.
+ */
+
+struct device;
+
+unsigned int msi_get_virq(struct device *dev, unsigned int index);
+
+#endif

