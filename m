Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398606E2EAA
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDOCgU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDOCgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4483199B
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DD17641FA
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C50FC433EF;
        Sat, 15 Apr 2023 02:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526171;
        bh=u1ezdPRrHzvtnAwZGpavSpRIrY/aHgPs0XZn5RTbmb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VH4esIv3z240htn9P/1m/S53CzygkAvZkrjXlisqjag3gI12hF/ywbslMV+NhREIn
         2AGeaGlmXy29o5mS1W+6aTn6jyCtUIkNy9a+9k6rq9qedMpb87Kr3pmqKcnDsMvNGD
         Y7Y3xgzJd0APHWTzbhFj6mekdCy+G3+XxxDQkjN6FXI7GkxcAzeLugT2YXc2vX7Uh3
         q0l5YuhwbgnK4PNux00z6JE11KxI7r7vZNeN8zGI0RL1z+pjLo3o9ngSvOIkDiZm/X
         jDbkZixwM99u1rJV7+FWNecUfvQtgFfa6eLlu7yCcAKflmwISNyr63xfKVraWP+JBI
         tMwrhwjpgtCrw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 15/17] misc: pci_endpoint_test: Re-init completion for every test
Date:   Sat, 15 Apr 2023 11:35:40 +0900
Message-Id: <20230415023542.77601-16-dlemoal@kernel.org>
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

The irq_raised completion used to detect the end of a test case is
initialized when the test device is probed, but never reinitialized
again before a test case. As a result, the irq_raised completion
synchronization is effective only for the first ioctl test case
executed. Any subsequent call to wait_for_completion() by another
ioctl() call will immediately return, potentially too early, leading to
false positive failures.

Fix this by reinitializing the irq_raised completion before starting a
new ioctl() test command.

Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 01235236e9bc..24efe3b88a1f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -729,6 +729,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	struct pci_dev *pdev = test->pdev;
 
 	mutex_lock(&test->mutex);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq = -ENODATA;
+
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
-- 
2.39.2

