Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE82C64EEE7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 17:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiLPQWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 11:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiLPQVi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 11:21:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBF03F070;
        Fri, 16 Dec 2022 08:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9A1FACE1D96;
        Fri, 16 Dec 2022 16:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB46C433D2;
        Fri, 16 Dec 2022 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671207693;
        bh=PzuPc7E2HGZcpKuiGsxipxlDPcMLq+hLcAA6BrGvXh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNP6sHNuqvsfLwddUOtgW00IFIbDXFC5VOfkOxvaXCmrT34Ud8SdZORryruHKnqa/
         CVZouFi3Go0zZIVhkTLo0kO8nUSEvD4ESUY5aSa8RNyOi08jsL1fnpbn51E7DKE7qs
         ioi5DNMNI6eTJ/RJW2QaY3LjEU5CbouE1UHVXoo3jg3/c5TBTP1/CyoilB4IxNfPYS
         BOpzE7lJKfrJCqgDd5LkZqBmZvjY7cy3rMCiogfntS1F8b+MdyQrTM6Md3qEq0Rm8I
         6Oc7H2eLXxHHxeBaDk/7PLV41rMUjGhCgHJDfhvdCaO0zHKgh2z+v/rCgEPhH3pi9C
         Dl/4Tc4CiXB7A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/2] PCI: switchtec: Simplify switchtec_dma_mrpc_isr()
Date:   Fri, 16 Dec 2022 10:21:25 -0600
Message-Id: <20221216162126.207863-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216162126.207863-1-helgaas@kernel.org>
References: <20221216162126.207863-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The "ret" variable in switchtec_dma_mrpc_isr() is superfluous.  Remove it
and just return the value.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 75be4fe22509..d7ae84070e29 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1480,15 +1480,13 @@ static irqreturn_t switchtec_event_isr(int irq, void *dev)
 static irqreturn_t switchtec_dma_mrpc_isr(int irq, void *dev)
 {
 	struct switchtec_dev *stdev = dev;
-	irqreturn_t ret = IRQ_NONE;
 
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
 		  SWITCHTEC_EVENT_EN_IRQ,
 		  &stdev->mmio_part_cfg->mrpc_comp_hdr);
 	schedule_work(&stdev->mrpc_work);
 
-	ret = IRQ_HANDLED;
-	return ret;
+	return IRQ_HANDLED;
 }
 
 static int switchtec_init_isr(struct switchtec_dev *stdev)
-- 
2.25.1

