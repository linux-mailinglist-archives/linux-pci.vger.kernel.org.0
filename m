Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539496326A6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKUOqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiKUOqV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:46:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E558D22B4;
        Mon, 21 Nov 2022 06:40:45 -0800 (PST)
Message-ID: <20221121140048.408064684@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v7+zNHMDfnt2h0cuevH6G6rdERYSvXaLiJHEl/OPzRA=;
        b=BK7De0GLyVdGt+ID5l/O8FDKaONmeeUqA1jGGC8SJis6fg6lt/hJJ1L4RE/wNxW67UPbKI
        4FQAYyqw1uNwL3wu59yoEUlBDq1c/9skFCW4hX8z6s4NEf812J+MCf+fkPCnwrgABn2qCN
        qJyWhdvCjWe28OCL7Crb2rrYqeViTYCyQFekZkPcPPYV5HHv/Nwc/BnAdTxeoC4WpgPVDM
        V8Wsr7HK9ajfXvDEnyFNAiz+AzgyZP2ez3hAwxdKds2PGmoHHxZgOdC8zBMcwuATRP9Mid
        OO0YYe0zIugwl2Lb7Jf72lPPxP/kuOSFhj5ExQs+rCDpeGAtW1KuTnuy4wYxzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v7+zNHMDfnt2h0cuevH6G6rdERYSvXaLiJHEl/OPzRA=;
        b=txp+8IF2ph3rlWD25/rWQf/qMPVnVy121ZePaP6MpxEhTz5t7liGLGi/FSqvC7A6KuwZJm
        qDuDIuLIIkbuwlCA==
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
Subject: [patch V2 02/40] ACPI/IORT: Make prototype of iort_pmsi_get_dev_id()
 always available
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:31 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W=1 build complains:

drivers/irqchip/irq-gic-v3-its-msi-parent.c:110:12: warning: no previous prototype for function 'iort_pmsi_get_dev_id' [-Wmissing-prototypes]                                                                                              
   int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)

Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 include/linux/acpi_iort.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -26,13 +26,15 @@ int iort_register_domain_token(int trans
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
+
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
+
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
 u32 iort_msi_map_id(struct device *dev, u32 id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
-int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
 void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,

