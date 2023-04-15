Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F4B6E2EAB
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDOCgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDOCgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5863765B7
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FFE3640A5
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FAAC433A0;
        Sat, 15 Apr 2023 02:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526173;
        bh=Ux2mNoqjhFXFx6wF6g7wcbT2X5pIm7bpvZRZPLuKCBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2fbr+l5DWI9lxnbOZ6hJMi3sqo2w9yX9ycsRALciYL2A+rFqH5WCb+bfnEJt18Vz
         S5yuEozwbwKCflYrDYoONvtHQGwUZCYe0zhUKWL/Gn0iWHbmTATDkM4hwnV6DBzI37
         G9+seRlt5/gnbNRjMMduY5VL3ch1CNtXjEhL/02DcWA2+0QvrOAG8Av+LKggWk0SvX
         fE/MpYIozolWIAoasGwihz6viFj2DNqi7K4Z3uJb6bjSpaWqyetqGv44kMNb+nnZto
         6AmznPz6ioilgbv6MEaIWo3FWnVYesarHNJ8djCLjkUJZIHoJQrJyGpkfAQ8YBKyEe
         6b8/SlvEzcudg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 16/17] misc: pci_endpoint_test: Do not write status in IRQ handler
Date:   Sat, 15 Apr 2023 11:35:41 +0900
Message-Id: <20230415023542.77601-17-dlemoal@kernel.org>
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

pci_endpoint_test_irqhandler() always rewrites the status register when
an IRQ is raised, either as-is if STATUS_IRQ_RAISED is not set, or with
STATUS_IRQ_RAISED cleared if that flag is set. The first case creates a
race window with the endpoint side, meaning that the host side test
driver may end up reading what it just wrote, thus losing the real
status as set by the endpoint side before raising the next interrupt.
This can prevent detecting that the STATUS_IRQ_RAISED flag was set by
the endpoint.

Remove this race window by not clearing the STATUS_IRQ_RAISED status
flag and not rewriting that register for every IRQ received.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 24efe3b88a1f..afd2577261f8 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -159,10 +159,7 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
 	if (reg & STATUS_IRQ_RAISED) {
 		test->last_irq = irq;
 		complete(&test->irq_raised);
-		reg &= ~STATUS_IRQ_RAISED;
 	}
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS,
-				 reg);
 
 	return IRQ_HANDLED;
 }
-- 
2.39.2

