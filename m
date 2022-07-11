Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6C5701C3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiGKMKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiGKMKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 08:10:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07211491EF;
        Mon, 11 Jul 2022 05:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4BB4B80EBD;
        Mon, 11 Jul 2022 12:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED5AC341CD;
        Mon, 11 Jul 2022 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657541444;
        bh=s2hcWfrzOt/eRRX9Dn00HKwF/BMj8aqOvof1DioxKO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tchk8X2Ik8KgJcy+3Y30fPgbo8x29dRap611vgKQ+8IpK46gQ54jszkZisuYrYLT1
         TSTfOo7iNglhfmhlhhBzSdGnTSKPlH0pulGY3yPulajIKXLWAm5RBI0JDPRykuUzjP
         Ab5kDOQE4xZa4tH6NQKnfvyDtAWYdLsAVxvkXW1Ii4hVjdMFATkBsXarvP7uPwPN6X
         M77McHeZF9lsDpQiqvZ3WI5OcPJxVL24BjHPLUb+ycd7OOVlv4qTqkRpMu8FHWcmxz
         u4T5wtL4/tCZm5QAkkpiQxQ0ucmq6CbcPXzYp+Y8m8wL9c/SL19XBaHl14QbPSzJm8
         pYg/0t9Yr1Aiw==
Received: by pali.im (Postfix)
        id E5673276E; Mon, 11 Jul 2022 14:10:41 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: aardvark: Dispose bridge irq prior to removing bridge domain
Date:   Mon, 11 Jul 2022 14:06:25 +0200
Message-Id: <20220711120626.11492-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220711120626.11492-1-pali@kernel.org>
References: <20220711120626.11492-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Documentation for irq_domain_remove() says that all mapping within the
domain must be disposed prior to domain remove.

Currently bridge irq is not disposed in pci-aardvark.c device unbind callback
which cause that kernel crashes after unloading driver and trying to read
/sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.

Fixes: 815bc3136867 ("PCI: aardvark: Use separate INTA interrupt for emulated root bridge")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 6cb65e64859d..8bea5801d50a 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1479,6 +1479,12 @@ static int advk_pcie_init_rp_irq_domain(struct advk_pcie *pcie)
 
 static void advk_pcie_remove_rp_irq_domain(struct advk_pcie *pcie)
 {
+	int virq;
+
+	virq = irq_find_mapping(pcie->rp_irq_domain, 0);
+	if (virq > 0)
+		irq_dispose_mapping(virq);
+
 	irq_domain_remove(pcie->rp_irq_domain);
 }
 
-- 
2.20.1

