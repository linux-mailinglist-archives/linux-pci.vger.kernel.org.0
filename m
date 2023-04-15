Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEFF6E2EA4
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDOCgE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDOCgD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338902108
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0FE0640B7
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C162DC433A4;
        Sat, 15 Apr 2023 02:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526161;
        bh=cnPvIe3DUATYCmiPG5AodQ3TLNnmT+c4xQzPqpxWVjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YiktEOdL+ohS0tAs/yNcZ0wqbssj+ydrWy8r2nY5keY1uvotEbI1bAlcl9S882WZP
         dwtutS6HucV9t37aDVnvTqb3zwsMDQldg5HdGXGozJH1Cxi0WdSag4t4UsgtS7pLJ2
         4cp7H6SmuEVuEByhcJaFXo27lzaPZISWhpkOB7Od15q1pWmvJxQWUXlnkkPC2hWVsR
         cPVrnccwUGGPgXAyHxCSPXI12l6kyJyYVuSqF49ajxdSphxJrDOZ0F4PG4zVrYexa9
         twVZ2N6FMqy1NY2q64l9b+8c97GCbwCIdhrBeRBc/u53KLDdPgt4IlMUT7ttuTqo9B
         J9hAmtG8ShKOg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 09/17] PCI: epf-test: Improve handling of command and status registers
Date:   Sat, 15 Apr 2023 11:35:34 +0900
Message-Id: <20230415023542.77601-10-dlemoal@kernel.org>
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

The pci-epf-test driver uses the test register BAR memory directly
to get and execute a test registers set by the RC side and defined
using a struct pci_epf_test_reg. This direct use relies on using the
register BAR address as a pointer to a struct pci_epf_test_reg to
execute the test case and to send back the test result through the
status field of struct pci_epf_test_reg. In practice, the status field
is always updated before an interrupt is raised in
pci_epf_test_raise_irq(), to ensure that the RC side sees the updated
status when receiving an interrupt.

However, such assignment direct access does not ensure that changes to
the status register make it to memory, and so visible to the host,
before an interrupt is raised, thus potentially resulting in the RC
host not seeing the correct status result for a test.

Avoid this potential problem by using READ_ONCE()/WRITE_ONCE() when
accessing the command and status fields of a pci_epf_test_reg structure.
This ensure that a test start (pci_epf_test_cmd_handler() function) and
completion (with the function pci_epf_test_raise_irq()) achieve a correct
synchronization with the MMIO register accesses on the RC host.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ee90ba3a957b..fa48e9b3c393 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -613,9 +613,14 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
+	u32 status = reg->status | STATUS_IRQ_RAISED;
 	int count;
 
-	reg->status |= STATUS_IRQ_RAISED;
+	/*
+	 * Set the status before raising the IRQ to ensure that the host sees
+	 * the updated value when it gets the IRQ.
+	 */
+	WRITE_ONCE(reg->status, status);
 
 	switch (reg->irq_type) {
 	case IRQ_TYPE_LEGACY:
@@ -659,12 +664,12 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
-	command = reg->command;
+	command = READ_ONCE(reg->command);
 	if (!command)
 		goto reset_handler;
 
-	reg->command = 0;
-	reg->status = 0;
+	WRITE_ONCE(reg->command, 0);
+	WRITE_ONCE(reg->status, 0);
 
 	if (reg->irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Failed to detect IRQ type\n");
-- 
2.39.2

