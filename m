Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3135701C1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 14:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiGKMKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiGKMKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 08:10:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2783348EB9;
        Mon, 11 Jul 2022 05:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94478611F1;
        Mon, 11 Jul 2022 12:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09B6C34115;
        Mon, 11 Jul 2022 12:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657541444;
        bh=UhBDGGujuZLS3CJAhdKmbeMA357lNLuZ6bu22I/qh4A=;
        h=From:To:Cc:Subject:Date:From;
        b=glwCOyvV3axdfL+tWz2pua8rdElVCMNOlQzDZgTqkg6bkBUQflkGYTDBloo5+qn34
         YAWULHW98zKKiF+4HtfR22GfgSW63DJSJwtRfOiWKEkf59aofgKHR/OPoXQ2SBYBNI
         lPzNRvJLM/njn7/ReVj17yBf6IAE2qBNEZGQCpy0z9uotk7wDlzWy4P2G5rZl+IEA1
         wKv65EdTpqCL56+cSM8+plBiBmTLKo6xJEdlrJuVOtWzthZ5uoMGQqvaNMEkoRgPgs
         KlQph1Y+1tpHtU+wJiMz3B6ap7tNcHJZyJO022mFBvvkJA/wpGdQi4ELsnrDaqTIPL
         W8zflwMU86cyg==
Received: by pali.im (Postfix)
        id 874E09D7; Mon, 11 Jul 2022 14:10:41 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: aardvark: Dispose INTx irqs prior to removing INTx domain
Date:   Mon, 11 Jul 2022 14:06:24 +0200
Message-Id: <20220711120626.11492-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Currently INTx irqs are not disposed in pci-aardvark.c device unbind callback
which cause that kernel crashes after unloading driver and trying to read
/sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.

Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ffec82c8a523..6cb65e64859d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1433,6 +1433,14 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 
 static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 {
+	int virq, i;
+
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		virq = irq_find_mapping(pcie->irq_domain, i);
+		if (virq > 0)
+			irq_dispose_mapping(virq);
+	}
+
 	irq_domain_remove(pcie->irq_domain);
 }
 
-- 
2.20.1

