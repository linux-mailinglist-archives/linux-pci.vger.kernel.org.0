Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F36E2EA5
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjDOCgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDOCgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025B2199B
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF48640A5
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3B7C4339E;
        Sat, 15 Apr 2023 02:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526163;
        bh=cljwCRniMK/wkn0U0i5rkIm26oxLcyZRQ09HVI78h5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZfG36PVwqR/fadg8Go7dsdz+SSs8bK+ZPjCaHPSZ7xUc/lzwMUkcQ6fmdD+kdD7I
         6N4LctQm8EUXgSUhf+vfM9ZLDhrp0afV+5SWUtTFG7cMEGUurrpR9yrkLBbHHT1Ot5
         gyJDGiqA7kxNY0/XDO4iM8n3EpA6iHRxqdFlz/K4sAUfb29QkYtvYMl21Bobw+FPTs
         EV3ZjTT9rs19ZD7QtjFaKgir/rdbOqT5frf1OKdDNV6hB5smylYRQyXbkHgFsl27MN
         gxdXJUfP3x3iBtZrU0HfT9BciWZOOWfFto2Ct9npRbBqmdLrKvVR4OxbSRf/sj/QFe
         ax2KibmgPq0uA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 10/17] PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
Date:   Sat, 15 Apr 2023 11:35:35 +0900
Message-Id: <20230415023542.77601-11-dlemoal@kernel.org>
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

Command codes are never combined together as flags into a single value.
Thus we can replace the series of "if" tests in
pci_epf_test_cmd_handler() with a cleaner switch-case statement.
This also allows checking that we got a valid command and print an error
message if we did not.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index fa48e9b3c393..7f482ec08754 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -676,41 +676,39 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		goto reset_handler;
 	}
 
-	if ((command & COMMAND_RAISE_LEGACY_IRQ) ||
-	    (command & COMMAND_RAISE_MSI_IRQ) ||
-	    (command & COMMAND_RAISE_MSIX_IRQ)) {
+	switch (command) {
+	case COMMAND_RAISE_LEGACY_IRQ:
+	case COMMAND_RAISE_MSI_IRQ:
+	case COMMAND_RAISE_MSIX_IRQ:
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_WRITE) {
+		break;
+	case COMMAND_WRITE:
 		ret = pci_epf_test_write(epf_test, reg);
 		if (ret)
 			reg->status |= STATUS_WRITE_FAIL;
 		else
 			reg->status |= STATUS_WRITE_SUCCESS;
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_READ) {
+		break;
+	case COMMAND_READ:
 		ret = pci_epf_test_read(epf_test, reg);
 		if (!ret)
 			reg->status |= STATUS_READ_SUCCESS;
 		else
 			reg->status |= STATUS_READ_FAIL;
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
-	}
-
-	if (command & COMMAND_COPY) {
+		break;
+	case COMMAND_COPY:
 		ret = pci_epf_test_copy(epf_test, reg);
 		if (!ret)
 			reg->status |= STATUS_COPY_SUCCESS;
 		else
 			reg->status |= STATUS_COPY_FAIL;
 		pci_epf_test_raise_irq(epf_test, reg);
-		goto reset_handler;
+		break;
+	default:
+		dev_err(dev, "Invalid command 0x%x\n", command);
+		break;
 	}
 
 reset_handler:
-- 
2.39.2

