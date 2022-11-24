Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B76381C1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiKXXgP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKXXgC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:36:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CDC116AA8;
        Thu, 24 Nov 2022 15:32:07 -0800 (PST)
Message-ID: <20221124232325.917219885@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/ACIVj3Kux3YVP+JKXyXfLBMvNMP5EOMeimbPlaFLJQ=;
        b=BsKbsW1SxIOI3uIIk1XAIrdhEqrqbHncgrocGX9Uh2YWGWVfMlj2O+PN8VYUYNIq0qZ2Ay
        A9eUTO7Y79lWaVpR//G51TZ+CebF9CLLQuwFq12Y4ZjtHbFlI8FfU/PS1vLDzw/vr8k2yK
        R25WIFL3ItTAodR/56Sbqi5K8lBnIbuFwfcGzQKlLVEbmtKc/shnbHyruPAjOxQyEYfFNW
        aEKuw2uz9cpTeDcnyyScSx3V7GUezDsnMAf25sbvSpOt7WbVWcMTcw7JrQcGRI3xE0MfQ/
        e34GT/Wn8HrKOWDLB5KP53Qpyk9dsYEtnV9fRqv6oFUj4suIw+fmJ6hPg9gIsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/ACIVj3Kux3YVP+JKXyXfLBMvNMP5EOMeimbPlaFLJQ=;
        b=LpEqpWKsx5hfed/pW/S8H+NTS72hnkS7dFww6SXUe5jHOBr+9zaeOuaPLondJsu/P79pqN
        hKCH+lWyvnEmReDg==
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
Subject: [patch V3 11/33] genirq/msi: Provide BUS_DEVICE_PCI_MSI[X]
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:02 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide new bus tokens for the upcoming per device PCI/MSI and PCI/MSIX
interrupt domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain_defs.h |    2 ++
 kernel/irq/msi.c               |    4 ++++
 2 files changed, 6 insertions(+)

--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -21,6 +21,8 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
 	DOMAIN_BUS_WAKEUP,
 	DOMAIN_BUS_VMD_MSI,
+	DOMAIN_BUS_PCI_DEVICE_MSI,
+	DOMAIN_BUS_PCI_DEVICE_MSIX,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1122,6 +1122,8 @@ static bool msi_check_reservation_mode(s
 
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		break;
 	default:
@@ -1147,6 +1149,8 @@ static int msi_handle_pci_fail(struct ir
 {
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		if (IS_ENABLED(CONFIG_PCI_MSI))
 			break;

