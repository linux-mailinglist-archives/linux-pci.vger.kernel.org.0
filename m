Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86046E2EA3
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDOCgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDOCgB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975E73AAD
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0395E641FA
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ADEC433A0;
        Sat, 15 Apr 2023 02:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526159;
        bh=Kob2bcM5khuSL7yw+1V8Un2XnF3OjPqYRqfBVPIHvjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RU1YzkkxtW9hBgQhL5Ox0Exxi6rruaIoXI5qmX3PWDgUMuWLuu/S5eJiXDyhZqDQP
         YJfKlEuKDdA9T1ixOqemiTN9LaxlVxnpbVv46a+rKx7T+Ep8jubEgHulGfAr4HUKWy
         i61/O926MfdHqIMw3C/g6ShLMaWwMmsFB8GUy1o3AJo3ftQVPLs0ncsrlmyifSeV6P
         A3WOYlEx6PykNWy97e5eLAdsG2EoxJHoDI1ab+LgQjL345wnVJzdC9mVEvFaz8k+7V
         n0fNl6fdWdChW3OtD0wgHRAzY52s34KLkJDydTBktK5LJb7L4vqRrsy+KDq1jNJE2I
         zZ+uRWzi566ew==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 08/17] PCI: epf-test: Simplify IRQ test commands execution
Date:   Sat, 15 Apr 2023 11:35:33 +0900
Message-Id: <20230415023542.77601-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230415023542.77601-1-dlemoal@kernel.org>
References: <20230415023542.77601-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For the commands COMMAND_RAISE_LEGACY_IRQ, COMMAND_RAISE_MSI_IRQ and
COMMAND_RAISE_MSIX_IRQ, the function pci_epf_test_cmd_handler()
sets the STATUS_IRQ_RAISED status flag and calls the epc function
pci_epc_raise_irq() directly. However, this is also exactly what the
pci_epf_test_raise_irq() function does. Avoid duplicating these
operations by directly using pci_epf_test_raise_irq() for the IRQ test
commands. It is OK to do so as the host side endpoint test driver always
set the correct IRQ type for the IRQ test commands.

At the same time, the IRQ number check done for the
COMMAND_RAISE_MSI_IRQ and COMMAND_RAISE_MSIX_IRQ commands can also be
moved to pci_epf_test_raise_irq() to also check the IRQ number requested
by the host for other test commands.

Overall, this significantly simplifies the pci_epf_test_cmd_handler()
function.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 43 ++++++++-----------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 3835e558937a..ee90ba3a957b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -613,6 +613,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
+	int count;
 
 	reg->status |= STATUS_IRQ_RAISED;
 
@@ -622,10 +623,22 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 				  PCI_EPC_IRQ_LEGACY, 0);
 		break;
 	case IRQ_TYPE_MSI:
+		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
+		if (reg->irq_number > count || count <= 0) {
+			dev_err(dev, "Invalid MSI IRQ number %d / %d\n",
+				reg->irq_number, count);
+			return;
+		}
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_EPC_IRQ_MSI, reg->irq_number);
 		break;
 	case IRQ_TYPE_MSIX:
+		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
+		if (reg->irq_number > count || count <= 0) {
+			dev_err(dev, "Invalid MSIX IRQ number %d / %d\n",
+				reg->irq_number, count);
+			return;
+		}
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_EPC_IRQ_MSIX, reg->irq_number);
 		break;
@@ -638,13 +651,11 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	int ret;
-	int count;
 	u32 command;
 	struct pci_epf_test *epf_test = container_of(work, struct pci_epf_test,
 						     cmd_handler.work);
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
-	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
@@ -660,10 +671,10 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		goto reset_handler;
 	}
 
-	if (command & COMMAND_RAISE_LEGACY_IRQ) {
-		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_LEGACY, 0);
+	if ((command & COMMAND_RAISE_LEGACY_IRQ) ||
+	    (command & COMMAND_RAISE_MSI_IRQ) ||
+	    (command & COMMAND_RAISE_MSIX_IRQ)) {
+		pci_epf_test_raise_irq(epf_test, reg);
 		goto reset_handler;
 	}
 
@@ -697,26 +708,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		goto reset_handler;
 	}
 
-	if (command & COMMAND_RAISE_MSI_IRQ) {
-		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
-		if (reg->irq_number > count || count <= 0)
-			goto reset_handler;
-		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSI, reg->irq_number);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_RAISE_MSIX_IRQ) {
-		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
-		if (reg->irq_number > count || count <= 0)
-			goto reset_handler;
-		reg->status = STATUS_IRQ_RAISED;
-		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSIX, reg->irq_number);
-		goto reset_handler;
-	}
-
 reset_handler:
 	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
 			   msecs_to_jiffies(1));
-- 
2.39.2

