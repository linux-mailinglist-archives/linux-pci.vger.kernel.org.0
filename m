Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97763638185
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiKXX1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiKXX1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:27:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A55CFA6A;
        Thu, 24 Nov 2022 15:26:13 -0800 (PST)
Message-ID: <20221124232325.442499757@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qV//gzPmOqH3W5duAbtHBZqaagM7sPrAqRRWld0OnjU=;
        b=HEs+D51n1rtP2vHE8zTlVoE+bOEuK2V6v930W5rI9u4JP69P6fXmSVDnDQ1OHvh8M447Sn
        HIlQFnvYDrdPoJcHKUF9zWPOzTFdotIaDJeP4PmQt47rpPs5JkVCmNFfPamCp6ElalPaoe
        GsMsWwhrkK0Xk94tKAGIT7UlJ+i4IEFczaZR3txMYlivHdJ431STot8EbTkltcYS0wEGao
        et9k4iKua0uRgP7tqps8ulngmt5DqTRm38bPI+asJObtPINw0VLpRZKqWInlIQ4nji5CYU
        fUFGNYViSoRtRnRwtLtY2osg/SfBArVb8hmj3MCn8fuKZIukKgQmUAyDMQfRlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qV//gzPmOqH3W5duAbtHBZqaagM7sPrAqRRWld0OnjU=;
        b=oMDZPkI4sNS0Y6FEh3qMJ6jAioLVyTTklUXpF0S2QnDYthHjgNU62jXoYHjPYaGX3cqY2M
        Bz+7VnU1G1xZI4AQ==
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
Subject: [patch V3 03/33] genirq/msi: Provide data structs for per device domains
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:25:49 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide struct msi_domain_template which contains a bundle of struct
irq_chip, struct msi_domain_ops and struct msi_domain_info and a name
field.

This template is used by MSI device domain implementations to provide the
domain specific functionality, feature bits etc.

When a MSI domain is created the template is duplicated in the core code
so that it can be modified per instance. That means templates can be
marked const at the MSI device domain code.

The template is a bundle to avoid several allocations and duplications
of the involved structures.

The name field is used to construct the final domain and chip name via:

    $PREFIX$NAME-$DEVNAME

where prefix is the optional prefix of the MSI parent domain, $NAME is the
provided name in template::chip and the device name so that the domain
is properly identified. On x86 this results for PCI/MSI in:

   PCI-MSI-0000:3d:00.1 or IR-PCI-MSIX-0000:3d:00.1

depending on the domain type and the availability of remapping.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Correct changelog (Kevin)
---
 include/linux/msi.h |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -24,6 +24,7 @@
 #include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/irq.h>
 #include <linux/bits.h>
 
 #include <asm/msi.h>
@@ -74,7 +75,6 @@ struct msi_msg {
 
 extern int pci_msi_ignore_mask;
 /* Helper functions */
-struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
@@ -442,6 +442,20 @@ struct msi_domain_info {
 	void				*data;
 };
 
+/**
+ * struct msi_domain_template - Template for MSI device domains
+ * @name:	Storage for the resulting name. Filled in by the core.
+ * @chip:	Interrupt chip for this domain
+ * @ops:	MSI domain ops
+ * @info:	MSI domain info data
+ */
+struct msi_domain_template {
+	char			name[48];
+	struct irq_chip		chip;
+	struct msi_domain_ops	ops;
+	struct msi_domain_info	info;
+};
+
 /*
  * Flags for msi_domain_info
  *

