Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C56632646
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiKUOiy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKUOh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:37:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ADC1EC;
        Mon, 21 Nov 2022 06:37:58 -0800 (PST)
Message-ID: <20221121091326.938173210@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dNla760VftgKp2xT4MRMyY8D/XKPi4S0TfNof3crvXM=;
        b=P+HYXuVqYFhqGfbPERnzjNDCBVcKkJNXxsNo4ft1ia61H91Q3hdAryUicSolv5BMOUp0UA
        JXz/7ubQ152DLVF8uJsQsbyoPug1bkilzs+gI6+dJTmbFEynVGmOtmP5sDStayCZcqfwJO
        9rsqkUGjGN1ohYfKR+E8JxsVaidNqMVDRlgw9c9VIe8uJsvNWezISe2NJQ9yC0XmGH2a2F
        iPM8XUvr9N90AtoH+eBqRSb7C1L49FUOHGvGXgS2LK/fplfSj2AiLil6PYz8v/kXt9ZtG+
        UNJNaqMKvQFfenF7eDYFhIx/TGsn97SqIhfxj/eQU33BDJuOX+55rYMyt7s/nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dNla760VftgKp2xT4MRMyY8D/XKPi4S0TfNof3crvXM=;
        b=WLGiQULCYKxQSd1OjNwNkXBQuflUzZVliowZe+kfm4peS/o+dR+N7F67JTaTt2BpCs21jg
        /NFLqHdQ54tSU6Cw==
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
Subject: [patch V2 08/33] genirq/msi: Provide msi_match_device_domain()
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:37:56 +0100 (CET)
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
@@ -542,6 +542,9 @@ bool msi_create_device_irq_domain(struct
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
@@ -1021,6 +1021,31 @@ void msi_remove_device_irq_domain(struct
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

