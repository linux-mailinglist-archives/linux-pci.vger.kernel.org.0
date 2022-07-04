Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8095656C2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiGDNP2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiGDNPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 09:15:19 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B3101D5
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 06:15:11 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8LuroOc1ovNzH8LurooatG; Mon, 04 Jul 2022 15:15:09 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 04 Jul 2022 15:15:09 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: iproc: Use the bitmap API to allocate bitmaps
Date:   Mon,  4 Jul 2022 15:15:03 +0200
Message-Id: <d839a951358ceb447226dc776590a2a38f3e3f9d.1656940469.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/pcie-iproc-msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 757b7fbcdc59..fee036b07cd4 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -589,8 +589,8 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 		msi->has_inten_reg = true;
 
 	msi->nr_msi_vecs = msi->nr_irqs * EQ_LEN;
-	msi->bitmap = devm_kcalloc(pcie->dev, BITS_TO_LONGS(msi->nr_msi_vecs),
-				   sizeof(*msi->bitmap), GFP_KERNEL);
+	msi->bitmap = devm_bitmap_zalloc(pcie->dev, msi->nr_msi_vecs,
+					 GFP_KERNEL);
 	if (!msi->bitmap)
 		return -ENOMEM;
 
-- 
2.34.1

