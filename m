Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF13A6E2EAC
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjDOCg3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDOCgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D357DAA
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC514640B7
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06F1C433D2;
        Sat, 15 Apr 2023 02:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526175;
        bh=cj9F7YjPaqSCHyV3T+0AIzR+XeUY/aNA102SsR5duuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtABFsgi52p5uvitKqIXKB7w0d7YX4jGy/zkI/SBU6xQyU5zNVVVxZP1INgR8A/ML
         STT1uYHtKTdrsWPdBcV25wWhIo+cyZJYpN1wPBGHhGIt5Vqz6yOQ1DLlC7KEWu1UQc
         ZU0XcTvUfPkyI9yytfLAxqCpD682vgzIce6dp52CiBLfowiZ0ic/jaU/6lygEJo1r5
         mBRJDz/Gi+9qUPsd6Y1QTNRaCyyjoB97GnXotoiOl7vbXAXcSdvPKfIvsxJRm7GlaY
         Fh3P07MLpSssz0D3M+CKOavXJoffKi/fXw0dHQ7Ab71UDfVyEBKCt+xX0ZQgCqHId6
         hYSOhOXxV7INQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 17/17] misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()
Date:   Sat, 15 Apr 2023 11:35:42 +0900
Message-Id: <20230415023542.77601-18-dlemoal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230415023542.77601-1-dlemoal@kernel.org>
References: <20230415023542.77601-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify the code of pci_endpoint_test_msi_irq() by correctly using
booleans: remove the msix comparison to false as that variable is
already a boolean, and directly return the result of the comparison of
the raised interrupt number.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index afd2577261f8..ed4d0ef5e5c3 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -313,21 +313,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	struct pci_dev *pdev = test->pdev;
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 msix == false ? IRQ_TYPE_MSI :
-				 IRQ_TYPE_MSIX);
+				 msix ? IRQ_TYPE_MSIX : IRQ_TYPE_MSI);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, msi_num);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 msix == false ? COMMAND_RAISE_MSI_IRQ :
-				 COMMAND_RAISE_MSIX_IRQ);
+				 msix ? COMMAND_RAISE_MSIX_IRQ :
+				 COMMAND_RAISE_MSI_IRQ);
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
 		return false;
 
-	if (pci_irq_vector(pdev, msi_num - 1) == test->last_irq)
-		return true;
-
-	return false;
+	return pci_irq_vector(pdev, msi_num - 1) == test->last_irq;
 }
 
 static int pci_endpoint_test_validate_xfer_params(struct device *dev,
-- 
2.39.2

