Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D147D46CDA9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbhLHGW6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhLHGW5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F1C061574
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 22:19:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F25B81FB9
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA66C341C6;
        Wed,  8 Dec 2021 06:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944364;
        bh=p83dddMGT4bJihiZzPmp6yGCgIidTvLFxJGa1aAZGrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+cFq1mU1k3vy5AI4tRGK8Sso6qnhJIFNY58rmqiuMCOwL/eRscckpAARivX7L0ki
         0LKoDpC9UtV/NWfJQ0aGK/4rIkta9o3+KBasVqHeLm6EBtcqbKrlyCXEFw+mjNGmNk
         hgsVHc0hfZPbLEKoZ5uH73g2AP+v7xvZKFUC1509DhStDpwp/RXrUTkNaMO2FQwIBB
         7Tjtq3ZPSgK91c9YoJfDDntOexzTsqNCOAS6oMh5piKFx1ZPViAPEUnTkqFT/6rysE
         NZCZ9F43SbFJtrOI+qVnob5OvyJibChCB0eWqeKwdXpRblkmqNAryr+KwKpptkbl5O
         cpuPkU338pRIA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 17/17] PCI: aardvark: Don't mask irq when mapping
Date:   Wed,  8 Dec 2021 07:18:51 +0100
Message-Id: <20211208061851.31867-18-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

By default, all Legacy INTx interrupts are masked, so there is no need to
mask this interrupt during irq_map callback.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 4a21387a4693..b1b6620b1d9a 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1339,7 +1339,6 @@ static int advk_pcie_irq_map(struct irq_domain *h,
 {
 	struct advk_pcie *pcie = h->host_data;
 
-	advk_pcie_irq_mask(irq_get_irq_data(virq));
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_chip_and_handler(virq, &pcie->irq_chip,
 				 handle_level_irq);
-- 
2.32.0

