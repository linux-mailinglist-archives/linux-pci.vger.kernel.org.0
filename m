Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3FA6E2EA1
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjDOCf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjDOCf6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C510F0
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6977661752
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D94EC433A0;
        Sat, 15 Apr 2023 02:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526155;
        bh=FpJDcnZln1I9ZPlxeszyhpBMmHgdOcfuH+S0JUm/hP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0zyOdJVXrkMr9wnDuLpa5SmooVwwmZ+Pua1L31jeBpdL2iQKhRMEaMhzE28cPrFY
         K6viMeEK5+SBr8CbuumCcpAcbf0B93XUueX8wnMhIq9lWChxobD8ruzziwddX0wO+X
         sdK/HxjBwo/S/4aF27O7N5d//IhQXHHibJr1lvlgfXAy2j8md9LUoxoUwuwhlpJK9j
         uoDBWtFmeAobFXrCRVHi+VTQFB0Rs1NhlL17uwMLoqb+yuh1rOGfbYlpxoRBrjepuR
         mHsVkPs8Sxdtw+S2ChqWmViYavbNi8eq3WRt4nNHpBoM4ydRLMyYGdw1v9TlyCFLnh
         MIfD9C1ej4Qzw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 06/17] PCI: epf-test: Simplify read/write/copy test functions
Date:   Sat, 15 Apr 2023 11:35:31 +0900
Message-Id: <20230415023542.77601-7-dlemoal@kernel.org>
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

The function pci_epf_test_cmd_handler() uses the register BAR address
as a pointer to a struct pci_epf_test_reg to determine the command sent
by the host and to execute the test function accordingly. There is no
need for doing this assignment again in each of the read, write and
copy test functions. We can simply pass the reg pointer as an argument
to the functions pci_epf_test_write(), pci_epf_test_read() and
pci_epf_test_copy().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7cdc6c915ef5..b8b178ac7cda 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -325,7 +325,8 @@ static void pci_epf_test_print_rate(const char *ops, u64 size,
 		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
 }
 
-static int pci_epf_test_copy(struct pci_epf_test *epf_test)
+static int pci_epf_test_copy(struct pci_epf_test *epf_test,
+			     struct pci_epf_test_reg *reg)
 {
 	int ret;
 	bool use_dma;
@@ -337,8 +338,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
-	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
@@ -424,7 +423,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	return ret;
 }
 
-static int pci_epf_test_read(struct pci_epf_test *epf_test)
+static int pci_epf_test_read(struct pci_epf_test *epf_test,
+			     struct pci_epf_test_reg *reg)
 {
 	int ret;
 	void __iomem *src_addr;
@@ -438,8 +438,6 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
 	struct device *dma_dev = epf->epc->dev.parent;
-	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!src_addr) {
@@ -514,7 +512,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	return ret;
 }
 
-static int pci_epf_test_write(struct pci_epf_test *epf_test)
+static int pci_epf_test_write(struct pci_epf_test *epf_test,
+			      struct pci_epf_test_reg *reg)
 {
 	int ret;
 	void __iomem *dst_addr;
@@ -527,8 +526,6 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
 	struct device *dma_dev = epf->epc->dev.parent;
-	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
-	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
 	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
 	if (!dst_addr) {
@@ -673,7 +670,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	}
 
 	if (command & COMMAND_WRITE) {
-		ret = pci_epf_test_write(epf_test);
+		ret = pci_epf_test_write(epf_test, reg);
 		if (ret)
 			reg->status |= STATUS_WRITE_FAIL;
 		else
@@ -684,7 +681,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	}
 
 	if (command & COMMAND_READ) {
-		ret = pci_epf_test_read(epf_test);
+		ret = pci_epf_test_read(epf_test, reg);
 		if (!ret)
 			reg->status |= STATUS_READ_SUCCESS;
 		else
@@ -695,7 +692,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	}
 
 	if (command & COMMAND_COPY) {
-		ret = pci_epf_test_copy(epf_test);
+		ret = pci_epf_test_copy(epf_test, reg);
 		if (!ret)
 			reg->status |= STATUS_COPY_SUCCESS;
 		else
-- 
2.39.2

