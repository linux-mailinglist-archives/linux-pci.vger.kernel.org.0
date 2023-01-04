Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C934E65DD9B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 21:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbjADUWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 15:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbjADUWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 15:22:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630691EAD6;
        Wed,  4 Jan 2023 12:22:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11768B818D8;
        Wed,  4 Jan 2023 20:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AACC433EF;
        Wed,  4 Jan 2023 20:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672863748;
        bh=PzuPc7E2HGZcpKuiGsxipxlDPcMLq+hLcAA6BrGvXh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFSKXJ9kDEyc3NqbOseIaHVtsNoFMHxT57nbFueGmgzpIHtc5zdhLkZkGULEJLdpl
         ck0NyG98eE0zIzMrqB6R1UV2V2hd1E7CRKVSY1rYpgw8gCsVH2yI8NaSo4cK7xDqLx
         Xhfs4jVbRWEW8fDR5IKGddIGy2ym62XLD1PFzfhUuRit4uQ4KSqUNMu0jVedEBin4/
         t5X1n6IwMJoETTR0cKEwVYNvAtIlKtNE+fdnruBLkSgPveACVfo6AA/1fwOAuITjsn
         uNvoqNCbPS8n0f4BMqcI1VwkIf9lmC7rLUIao3nLEK+VtnBvDxon7w/7ncCpl871Ug
         7moJma+9wRMNQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 1/2] PCI: switchtec: Simplify switchtec_dma_mrpc_isr()
Date:   Wed,  4 Jan 2023 14:22:22 -0600
Message-Id: <20230104202223.1091085-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104202223.1091085-1-helgaas@kernel.org>
References: <20230104202223.1091085-1-helgaas@kernel.org>
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

