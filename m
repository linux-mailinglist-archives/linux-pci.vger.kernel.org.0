Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A586E2EA9
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDOCgR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjDOCgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B5D19A2
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A421F64B4B
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D4EC4339B;
        Sat, 15 Apr 2023 02:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526170;
        bh=XtZGLCorVqq2jk0JppEXghjMlcoHKCBAapRT2bmupys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJEoICe8Z46JIPKkXahfByKRtt2LGw+2xJc8jRbx2iMTtz+j/1slM8hl1HVbQH/rq
         U9iruSbkKSgrap6fWspFryEatDOd7jDXe3I5MvqKUJjINqQqSVRZpf7b3H3tHBanqP
         OYi85hC4LvLjEWILSg+TpdYWJ7cuyRERUKrFvx1kIzraTyqSrmlUyx33SmX+Yly+NQ
         YSpK5GlST+DfctdtLh1PqO0XOfhdHTOW7oyi6BlTIP1/cLIAUyzw1cz5mwrIorKHFl
         D6xb02yW5qddI/+qY2yEckDC5j3rmVDoUsdFOZr8CUhaIQn9DJHUMjxFDbd+U4Sm62
         RIXypaxU8mdHQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 14/17] misc: pci_endpoint_test: Free IRQs before removing the device
Date:   Sat, 15 Apr 2023 11:35:39 +0900
Message-Id: <20230415023542.77601-15-dlemoal@kernel.org>
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

In pci_endpoint_test_remove(), freeing the IRQs after removing the
device creates a small race window for IRQs to be received with the test
device memory already released, causing the IRQ handler to access
invalid memory, resulting in an oops.

Free the device IRQs before removing the device to avoid this issue.

Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a7244de081ec..01235236e9bc 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -938,6 +938,9 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	if (id < 0)
 		return;
 
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
@@ -947,9 +950,6 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
-	pci_endpoint_test_release_irq(test);
-	pci_endpoint_test_free_irq_vectors(test);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
-- 
2.39.2

