Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB72563753
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiGAQDm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiGAQDi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 12:03:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 194FD1EC6A;
        Fri,  1 Jul 2022 09:03:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A6A0113E;
        Fri,  1 Jul 2022 09:03:37 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.40.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2EEE3F66F;
        Fri,  1 Jul 2022 09:03:34 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-eng@arm.com
Cc:     Pierre Gondois <Pierre.Gondois@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ACPI/PCI: Make _SRS optional for link device
Date:   Fri,  1 Jul 2022 18:03:07 +0200
Message-Id: <20220701160309.2842180-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pierre Gondois <Pierre.Gondois@arm.com>

In ACPI 6.4, s6.2.13 "_PRT (PCI Routing Table)", PCI legacy
interrupts can be described though a link device (first model).
From s6.2.16 "_SRS (Set Resource Settings)":
"This optional control method [...]"

Make it optional to have a _SRS method for link devices.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215560
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/pci_link.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 58647051c948..129e3e7e80ee 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -288,6 +288,13 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 	if (!irq)
 		return -EINVAL;
 
+	if (!acpi_has_method(handle, METHOD_NAME__SRS)) {
+		if (link->irq.active == irq)
+			return 0;
+		acpi_handle_err(handle, "Unable to set IRQ %d: No _SRS.\n", irq);
+		return -ENODEV;
+	}
+
 	resource = kzalloc(sizeof(*resource) + 1, irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
 	if (!resource)
 		return -ENOMEM;
-- 
2.25.1

