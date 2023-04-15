Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE096E2EA6
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjDOCgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjDOCgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24065B8D
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 590D964B4B
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54069C433A0;
        Sat, 15 Apr 2023 02:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526164;
        bh=YYJHZeD6tS0XdBwd/PW+/MPA+LxHJ36xsB42mpfSO5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3lsP0rnTtGY/cTvnMFZHod0c4m04CWgE2Q+2/1WGGFLuCF7Xf2x1nxaRFTeXztMR
         MixqEj6u5iU0NpyMnY+mPCEVW2sUndBT4p1P3C218urG0GGF7QXfQxbzI2fvzFu/rd
         nbdAOkkHtsI7dxkX5sXZGA9MPINoiw9VEq5TKbf4C/JLOzHmkk0bwWS4HbCZb3FEEQ
         wUuN50fF2rQkpTT5FlDrbAHRQnVj0IuUfXa2Em/qi3zlhqikvRvo74vsuwmzriJlf/
         ObOjdh1lXWPdGOrOMVdsqJcHsTqZfg87BNUBWnR546JUX8YTmHLgExZRQOK4S/eYZG
         6/t7gDRvhy9IA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 11/17] PCI: epf-test: Cleanup request result handling
Date:   Sat, 15 Apr 2023 11:35:36 +0900
Message-Id: <20230415023542.77601-12-dlemoal@kernel.org>
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

Each of the test functions pci_epf_test_write(), pci_epf_test_read() and
pci_epf_test_copy() return an int result which is used by
pci_epf_test_cmd_handler() to set a success or error bit in the request
status.

In the spirit of keeping the processing of each test case self-contained
within its own test function, move the request status field update from
pci_epf_test_cmd_handler() to each of these test functions and change
these functions declaration to returning void.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 46 +++++++++----------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7f482ec08754..e528b0915444 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -325,8 +325,8 @@ static void pci_epf_test_print_rate(const char *ops, u64 size,
 		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
 }
 
-static int pci_epf_test_copy(struct pci_epf_test *epf_test,
-			     struct pci_epf_test_reg *reg)
+static void pci_epf_test_copy(struct pci_epf_test *epf_test,
+			      struct pci_epf_test_reg *reg)
 {
 	int ret;
 	bool use_dma;
@@ -420,11 +420,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test,
 	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
 
 err:
-	return ret;
+	if (!ret)
+		reg->status |= STATUS_COPY_SUCCESS;
+	else
+		reg->status |= STATUS_COPY_FAIL;
 }
 
-static int pci_epf_test_read(struct pci_epf_test *epf_test,
-			     struct pci_epf_test_reg *reg)
+static void pci_epf_test_read(struct pci_epf_test *epf_test,
+			      struct pci_epf_test_reg *reg)
 {
 	int ret;
 	void __iomem *src_addr;
@@ -509,11 +512,14 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test,
 	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
 
 err:
-	return ret;
+	if (!ret)
+		reg->status |= STATUS_READ_SUCCESS;
+	else
+		reg->status |= STATUS_READ_FAIL;
 }
 
-static int pci_epf_test_write(struct pci_epf_test *epf_test,
-			      struct pci_epf_test_reg *reg)
+static void pci_epf_test_write(struct pci_epf_test *epf_test,
+			       struct pci_epf_test_reg *reg)
 {
 	int ret;
 	void __iomem *dst_addr;
@@ -604,7 +610,10 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test,
 	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
 
 err:
-	return ret;
+	if (!ret)
+		reg->status |= STATUS_WRITE_SUCCESS;
+	else
+		reg->status |= STATUS_WRITE_FAIL;
 }
 
 static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
@@ -655,7 +664,6 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
-	int ret;
 	u32 command;
 	struct pci_epf_test *epf_test = container_of(work, struct pci_epf_test,
 						     cmd_handler.work);
@@ -683,27 +691,15 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
 	case COMMAND_WRITE:
-		ret = pci_epf_test_write(epf_test, reg);
-		if (ret)
-			reg->status |= STATUS_WRITE_FAIL;
-		else
-			reg->status |= STATUS_WRITE_SUCCESS;
+		pci_epf_test_write(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
 	case COMMAND_READ:
-		ret = pci_epf_test_read(epf_test, reg);
-		if (!ret)
-			reg->status |= STATUS_READ_SUCCESS;
-		else
-			reg->status |= STATUS_READ_FAIL;
+		pci_epf_test_read(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
 	case COMMAND_COPY:
-		ret = pci_epf_test_copy(epf_test, reg);
-		if (!ret)
-			reg->status |= STATUS_COPY_SUCCESS;
-		else
-			reg->status |= STATUS_COPY_FAIL;
+		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
 	default:
-- 
2.39.2

