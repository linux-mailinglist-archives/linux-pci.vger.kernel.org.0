Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8838156379C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiGAQRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 12:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiGAQRC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 12:17:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53CF53BBF9;
        Fri,  1 Jul 2022 09:17:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564EF113E;
        Fri,  1 Jul 2022 09:17:02 -0700 (PDT)
Received: from pierre123.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EE2F3F66F;
        Fri,  1 Jul 2022 09:17:00 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <Pierre.Gondois@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH RESEND v1 2/2] ACPI/PCI: Make _PRS optional for link device
Date:   Fri,  1 Jul 2022 18:16:24 +0200
Message-Id: <20220701161624.2844305-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701161624.2844305-1-pierre.gondois@arm.com>
References: <20220701161624.2844305-1-pierre.gondois@arm.com>
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
From s6.2.12 "_PRS (Possible Resource Settings)":
"This optional object evaluates [...]"

It is currently checked that the interrupt advertised in _CRS
is one of the interrupts available in _PRS.
Make this check conditional to the presence of _PRS.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215560
Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 drivers/acpi/pci_link.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 129e3e7e80ee..b5a41866f135 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -532,19 +532,10 @@ int __init acpi_irq_penalty_init(void)
 
 static int acpi_irq_balance = -1;	/* 0: static, 1: balance */
 
-static int acpi_pci_link_allocate(struct acpi_pci_link *link)
+static int select_from_possible(struct acpi_pci_link *link)
 {
-	acpi_handle handle = link->device->handle;
-	int irq;
 	int i;
 
-	if (link->irq.initialized) {
-		if (link->refcnt == 0)
-			/* This means the link is disabled but initialized */
-			acpi_pci_link_set(link, link->irq.active);
-		return 0;
-	}
-
 	/*
 	 * search for active IRQ in list of possible IRQs.
 	 */
@@ -557,8 +548,9 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 	 */
 	if (i == link->irq.possible_count) {
 		if (acpi_strict)
-			acpi_handle_warn(handle, "_CRS %d not found in _PRS\n",
-					 link->irq.active);
+			acpi_handle_warn(link->device->handle,
+					"_CRS %d not found in _PRS\n",
+					link->irq.active);
 		link->irq.active = 0;
 	}
 
@@ -566,9 +558,28 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 	 * if active found, use it; else pick entry from end of possible list.
 	 */
 	if (link->irq.active)
-		irq = link->irq.active;
+		return link->irq.active;
+	else
+		return link->irq.possible[link->irq.possible_count - 1];
+}
+
+static int acpi_pci_link_allocate(struct acpi_pci_link *link)
+{
+	acpi_handle handle = link->device->handle;
+	int irq;
+	int i;
+
+	if (link->irq.initialized) {
+		if (link->refcnt == 0)
+			/* This means the link is disabled but initialized */
+			acpi_pci_link_set(link, link->irq.active);
+		return 0;
+	}
+
+	if (link->irq.possible_count)
+		irq = select_from_possible(link);
 	else
-		irq = link->irq.possible[link->irq.possible_count - 1];
+		irq = link->irq.active;
 
 	if (acpi_irq_balance || !link->irq.active) {
 		/*
-- 
2.25.1

