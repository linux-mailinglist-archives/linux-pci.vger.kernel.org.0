Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A63625C66
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiKKOGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiKKOFz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:05:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986DA8A8D0;
        Fri, 11 Nov 2022 05:59:29 -0800 (PST)
Message-ID: <20221111135205.894005975@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=3hBKls93a/oZusIKCQSu9YxAwv+FEeKpjbXGqebGohY=;
        b=adlIU4bjQ02+ZbMdWRRPr+H6SzVbhvjFVfg1F9DMtTtRGLSTJOMT2LiCGhgy19EV6HJDZu
        LIjodpiR7vzOalFi95tVMV57B2WHvI/xUKtvJEitivW3IuQlAqskjo5pCCMMsgqUMerf8c
        lT7NpHFOL7LCsNKZ1VWQjaFzSRT+Ql9m1o/8/oSV4c6ClqZ57JYCPwHCmg9Ad+JQdSt8BV
        krwWqUJrdXXsCU8YS9FPW2EutNGYUNwIGoDivhs7ncYnkeKOm6e00rVSwFVtNVgyzH4lR9
        8mDqYiP/hnTBsKGSgris0FWbBd2SzxDgg3nQnaxsyOPfVVZWx3I85fFelPw4Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=3hBKls93a/oZusIKCQSu9YxAwv+FEeKpjbXGqebGohY=;
        b=tfuw4bF7JvEpa0OcCIZ/z2kSL1cmbg+B01s/ZCAa5lqd2Eh7DG3POQBGQx9Sha8mpG1PRc
        9xrOGJt+05ILCqBA==
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
Subject: [patch 11/33] genirq/msi: Provide BUS_DEVICE_PCI_MSI[X]
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:28 +0100 (CET)
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
@@ -1137,6 +1137,8 @@ static bool msi_check_reservation_mode(s
 
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		break;
 	default:
@@ -1162,6 +1164,8 @@ static int msi_handle_pci_fail(struct ir
 {
 	switch(domain->bus_token) {
 	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 	case DOMAIN_BUS_VMD_MSI:
 		if (IS_ENABLED(CONFIG_PCI_MSI))
 			break;

