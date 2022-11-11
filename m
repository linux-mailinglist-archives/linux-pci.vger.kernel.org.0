Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D784B625C88
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiKKOIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiKKOHi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A681C8A01;
        Fri, 11 Nov 2022 06:00:17 -0800 (PST)
Message-ID: <20221111135206.968291651@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QDMaEx7ktXTUaBjXhcwy3JcriisNhamDQjdxbqkUVcQ=;
        b=sricQG6ooRMsz6ygQxruQv/VxuK6vhkWMWDuiTONA8ZXw2FlgXo2ZWE1hUIkihF4y/P65J
        EHUNJ/Eauopl5OEW5994cty9pAZhzyosuj7shZuQDgMEKpiRX32CS+rA73C79PazqhWkN5
        bGQQMTAr1ZaWB7PuNRmLUV+tt9cP3NweuWX7qg6ZfyWZlDHTz/Dhj7H1osMlBgwfxLjrH8
        XCe6Gv6NFLxZHJonOYgdx4o7R5EUg35jBKLiQb+Rofp275TNNZzaBy54hnwP9Lbbc6C40o
        hPz6SOq+BouwZ4O9xlKYxEs7amFYUhEAeFvUlIxlAQfqUXKZpjVfbkcAHZUEIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QDMaEx7ktXTUaBjXhcwy3JcriisNhamDQjdxbqkUVcQ=;
        b=DD3lrXY4NrLL/lfHDG55GBNZWUzoVgHtZEOigADvTQBd+Qd7djh3xcbHphia19i2KSq+9q
        RPIu8Saomss5xRDg==
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
Subject: [patch 30/33] x86/apic/msi: Enable PCI/IMS
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:59 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable IMS in the domain init and allocation mapping code, but do not
enable it on the vector domain as discussed in various threads on LKML.

The interrupt remap domains can expand this setting like they do with
PCI multi MSI.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/msi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -184,6 +184,7 @@ static int x86_msi_prepare(struct irq_do
 		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
 		return 0;
 	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+	case DOMAIN_BUS_PCI_DEVICE_IMS:
 		alloc->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 		return 0;
 	default:
@@ -230,6 +231,10 @@ static bool x86_init_dev_msi_info(struct
 	case DOMAIN_BUS_PCI_DEVICE_MSI:
 	case DOMAIN_BUS_PCI_DEVICE_MSIX:
 		break;
+	case DOMAIN_BUS_PCI_DEVICE_IMS:
+		if (!(pops->supported_flags & MSI_FLAG_PCI_IMS))
+			return false;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return false;

