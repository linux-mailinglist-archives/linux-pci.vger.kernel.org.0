Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E2A64E093
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLOSVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 13:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLOSVv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 13:21:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E27A2A9;
        Thu, 15 Dec 2022 10:21:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20C62B81C1F;
        Thu, 15 Dec 2022 18:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AAAC433F1;
        Thu, 15 Dec 2022 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128506;
        bh=s+PVv6GIZ4aMLHqPk5y9kyCwBokOLW/kvHRGZkXn+N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thYmC6RTtVWWWosTGR+CYcZL1sp3vzrIxUmm+2zmGdtSVL67EXEmGnMm6M5No+rJW
         FHtZx/2LNKXjNTDevEYpqnQFa/QjyJM0MapWsuKpR3OezXJ1KRcHB5fmCa821o1PIr
         zBsrc3stQPLfe78/HRYj3Z2RQ4iJjieLX+eXK6j2akwDXiX7fxShIjM9NpotF1IlOx
         /9DCsU2YPc89aQA5Hspyn7UijXp8gmuykvzuzB8dMLcBocFeWOs8XPTJdUxmFq2dHE
         nZmHEAW45Ju0SaHc97v5hW2Ihm4GRiGPhf5lhEuUUk0E1slqGfQKutJ7q/E/P6JVZg
         fSuTxO2CwVlWQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI: switchtec: Simplify switchtec_dma_mrpc_isr()
Date:   Thu, 15 Dec 2022 12:21:39 -0600
Message-Id: <20221215182140.129559-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215182140.129559-1-helgaas@kernel.org>
References: <20221215182140.129559-1-helgaas@kernel.org>
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

