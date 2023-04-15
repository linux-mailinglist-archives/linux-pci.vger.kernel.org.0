Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE706E2EA2
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjDOCgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDOCf7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:35:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A3F1
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C7CD641FA
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B2EC433EF;
        Sat, 15 Apr 2023 02:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526157;
        bh=3FDUF4qc7G9ujPuaniQM6hHZ1LrGGTfU0apISt1MqQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O66VYqYXTWJIBZbZRADd+TOORP7lwZz4ngUTg5eONMscuKCNUYV9TIRhbHhwbyaZa
         UWjyyHeYvN3bNcAi81AloErfrRgWNzBheyxaO+7bAgwZfhea0uSc17DDExmptOSVTH
         ouBVPcHeQuEzBbrVNx1s1jP//eTuua9f4egU3VxNglxecN7bMTnp3H48jDvfI0WmuO
         NuFlQdk3aGJbxm6MEwFObAa7125ZS8whUBpcKOrYV2sSSyI3Y/oPnBlwkJoMnAhHkH
         GNmeB7NCF7DuX7OFQYj/YGUbKmUPqms0icOUj4kZXOyUdcecMc4Th2ALu1YNGi0/ji
         CRGgemOH+v/Ng==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 07/17] PCI: epf-test: Simplify pci_epf_test_raise_irq()
Date:   Sat, 15 Apr 2023 11:35:32 +0900
Message-Id: <20230415023542.77601-8-dlemoal@kernel.org>
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

Change the interface of the function pci_epf_test_raise_irq() to
directly pass a pointer to the struct pci_epf_test_reg defining the test
being executed. This avoids the need for grabbing this pointer using
the register BAR address and simplifies the call sites as the IRQ type
and IRQ numbers do not have to be passed as arguments.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index b8b178ac7cda..3835e558937a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -607,29 +607,27 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test,
 	return ret;
 }
 
-static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test, u8 irq_type,
-				   u16 irq)
+static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
+				   struct pci_epf_test_reg *reg)
 {
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
-	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	reg->status |= STATUS_IRQ_RAISED;
 
-	switch (irq_type) {
+	switch (reg->irq_type) {
 	case IRQ_TYPE_LEGACY:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
 				  PCI_EPC_IRQ_LEGACY, 0);
 		break;
 	case IRQ_TYPE_MSI:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSI, irq);
+				  PCI_EPC_IRQ_MSI, reg->irq_number);
 		break;
 	case IRQ_TYPE_MSIX:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_MSIX, irq);
+				  PCI_EPC_IRQ_MSIX, reg->irq_number);
 		break;
 	default:
 		dev_err(dev, "Failed to raise IRQ, unknown type\n");
@@ -675,8 +673,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			reg->status |= STATUS_WRITE_FAIL;
 		else
 			reg->status |= STATUS_WRITE_SUCCESS;
-		pci_epf_test_raise_irq(epf_test, reg->irq_type,
-				       reg->irq_number);
+		pci_epf_test_raise_irq(epf_test, reg);
 		goto reset_handler;
 	}
 
@@ -686,8 +683,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			reg->status |= STATUS_READ_SUCCESS;
 		else
 			reg->status |= STATUS_READ_FAIL;
-		pci_epf_test_raise_irq(epf_test, reg->irq_type,
-				       reg->irq_number);
+		pci_epf_test_raise_irq(epf_test, reg);
 		goto reset_handler;
 	}
 
@@ -697,8 +693,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			reg->status |= STATUS_COPY_SUCCESS;
 		else
 			reg->status |= STATUS_COPY_FAIL;
-		pci_epf_test_raise_irq(epf_test, reg->irq_type,
-				       reg->irq_number);
+		pci_epf_test_raise_irq(epf_test, reg);
 		goto reset_handler;
 	}
 
-- 
2.39.2

