Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0DB6381BF
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiKXXfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiKXXf0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:35:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24514A2883;
        Thu, 24 Nov 2022 15:31:46 -0800 (PST)
Message-ID: <20221124232325.738047902@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MxT52QfeG/NT2BA2XnRso0NWmZQGQnhH9yEiG1ZbsIM=;
        b=rzNt/s64LZ9a80Jio7t/Pir3vg0mIG5LsgimCWVrmkl7G/4ehoDgsvRxrzObYSSf3LSIGM
        yAJUTQKnsTxQZ1WF+nBpy98jUVIAg5b23gQs3ChumbfI/MV8zQh9j+RzIMIcKgPUPbwKhy
        MHEObd2TPTduz84DwpW3Dolo/j1oBJxz3CpxIcXUU8kpWj1yz7g743tVCS/cwsL9if4ZxX
        PaaGODwRhzM9l3lX8Ekjfp9EPdtui3KHKG1PgNUNwMjuL005h8krACYm9CMqbK1urEavZM
        OJWgTdmkPvXCww4Z4lUGJVYh9wuc+rlmiaDxQFbfdPIr5bZfuTnhHGARLH3goA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MxT52QfeG/NT2BA2XnRso0NWmZQGQnhH9yEiG1ZbsIM=;
        b=dPMpS7gRpstwKeMvYNv/vsLOAMsakSmDEPVkSaUgvmOTMm0QcW/fOQPttnSESjCHWwCrsN
        2l6GTCIB+RAkL9CA==
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
Subject: [patch V3 08/33] genirq/msi: Provide msi_match_device_domain()
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:25:57 +0100 (CET)
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
@@ -553,6 +553,9 @@ bool msi_create_device_irq_domain(struct
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
@@ -987,6 +987,31 @@ void msi_remove_device_irq_domain(struct
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

