Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD4946CD98
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhLHGWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbhLHGWb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253CBC061574
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 22:19:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEA34B81FB9
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EBFC341CA;
        Wed,  8 Dec 2021 06:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944337;
        bh=+b7L5EETXeoW+uqi9u1WvCAYx9UhqnInb+Pjki20zsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qII1ruYyfNlrcUr7DhzoWiKYTHKic58OeP8+euL31EjUkNiQrT9B7RCBwkV4UbCOh
         CKt5/p8sQCDQWdO/XnQNNepGEJ/p60GmzEH4cgCLoKWbYjDWda3Ru6hUirJsE14zvR
         bOE2HtIWG15bV+V5vvviWWuwA1laXjVxlbc6cUeo27NnWQ/BD1vEvQHhkl0De0fciS
         mKvkSiI9c/WRmMvy6BohqVeS9Ejeh0uXK/AF9rUJBDLAdvrToJ6qXibn/DKgvFr8Sl
         yHMNXbxdDRvEVpsAb2riX6CxXAsaVokQ2YpLiMxT5UFl57GdZ6MpDPQY3b0VFaLe/5
         dZh+jPEvB446A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 01/17] PCI: aardvark: Drop __maybe_unused from advk_pcie_disable_phy()
Date:   Wed,  8 Dec 2021 07:18:35 +0100
Message-Id: <20211208061851.31867-2-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This function is now always used in driver remove method, drop the
__maybe_unused attribute.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b654d06b64df..e2ab23f0837f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1467,7 +1467,7 @@ static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void __maybe_unused advk_pcie_disable_phy(struct advk_pcie *pcie)
+static void advk_pcie_disable_phy(struct advk_pcie *pcie)
 {
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
-- 
2.32.0

