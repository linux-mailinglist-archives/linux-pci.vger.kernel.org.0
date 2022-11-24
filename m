Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2416381B5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiKXXav (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKXXaA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:30:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9A87A71;
        Thu, 24 Nov 2022 15:28:00 -0800 (PST)
Message-ID: <20221124232327.022658817@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QDMaEx7ktXTUaBjXhcwy3JcriisNhamDQjdxbqkUVcQ=;
        b=zUr0QOYxgwDD1PsVVViqo27E4EsaPMbR4ALz9TfU0GC5htAX5nGPC6kA6mGwt93eEzunFY
        SV6YNVcQFPTwSfCmcVnJLHcVKJmea/9hHBZcbkFnnBWcMWqs62jdSUBSHL4N8+ePtaCL8B
        FFaR0KtJcel6lPaAZYtNjpTGRXpt7dKubo3WLJ9W9CX6n/h3XV/bLSg1oc9TgjhDZPwb3j
        GlFZSKS9M6+gjUjkWy8BNAyRLYckcl+6G3bOpAq+nxGJOsnvl2SLurpDuWo6Cz631V9AIs
        05lrfrLGyMspEnMnsIubC+CzKiuF3CoVpv4qB6h5U1urATybLK6JYPIujJWWNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QDMaEx7ktXTUaBjXhcwy3JcriisNhamDQjdxbqkUVcQ=;
        b=e02d3EkPUlNpaELh4mxVVoCi+mQ7c03Dpuxx2rMxLiCJ+d8w3kCUnmnKMKavOjEADyVpy5
        OPe7q2W2AgbVSkBQ==
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
Subject: [patch V3 30/33] x86/apic/msi: Enable PCI/IMS
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:32 +0100 (CET)
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

