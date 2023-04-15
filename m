Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E863B6E2E9E
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDOCfy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjDOCfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9CCF1
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B44B60C54
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4A0C4339C;
        Sat, 15 Apr 2023 02:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526150;
        bh=aQDV2JW3UQIZCwlOCcaEMojpX+6j4yj30/CeoQBDQ24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Es5T7ix2F99Z2zYkgTMbAftph3lJq5UqYh1oeas5VATWWJ0q9XbApCQRj1QCgK5XX
         NM66t/quckb2VN3RQTdy81tUKidRxfsUxxuW/RBNGTOK7Wjv7Rof5HZtXmoLNV2ZEa
         5NWO94VNxlY6iuZQ9HNIu4h96FO47Lz+219C+Jk5yn9sohIwzQPuugYHR9yRvmOKAo
         wmY0LS9BQ8uQ2yhtJwV/Nkb/5Rd/qJvzmUtULDhp4Gkm8ZsvOKkhMqaij/gSfQVnWT
         besUJaSvTCJdwL9cneFkW1FzBMLvI/Eg/LfV+YDmgUeLVyBv4pcZIYTqA2b8wLGASY
         DevB36U9GQgTw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 03/17] PCI: epf-test: Fix DMA transfer completion initialization
Date:   Sat, 15 Apr 2023 11:35:28 +0900
Message-Id: <20230415023542.77601-4-dlemoal@kernel.org>
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

Re-initialize the transfer_complete DMA transfer completion before
calling tx_submit(), to avoid seeing the DMA transfer complete before
the completion is initialized, thus potentially losing the completion
notification.

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0f9d2ec822ac..d65419735d2e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -151,10 +151,10 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EIO;
 	}
 
+	reinit_completion(&epf_test->transfer_complete);
 	tx->callback = pci_epf_test_dma_callback;
 	tx->callback_param = epf_test;
 	cookie = tx->tx_submit(tx);
-	reinit_completion(&epf_test->transfer_complete);
 
 	ret = dma_submit_error(cookie);
 	if (ret) {
-- 
2.39.2

