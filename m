Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBF3B3FF4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 11:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFYJHf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 05:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhFYJHe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 05:07:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C74461436;
        Fri, 25 Jun 2021 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624611913;
        bh=qwjHHo7IaX3Xq/QUrlAe0vmXBBdE06HBmCIPvLbwMlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qu4yU4BSuS2PuQAeH4d9ZkwNPs4a7xLK1Lbf4Tere70haxHYndy2ZBKh+2BVIIZxs
         NvXpnVT5DymP+GBvYJHHEqLQarC/iwfSyTFYyxyfgxDcqG5gdQvpOxn+q5MrY5Uk5s
         sPVP8T/ZxSCgF57mgyfm1k5/zsItKQTtBBmyiWFGhUwsd4PsWQCclkNXg8V7LexelV
         EEGMBmMEWEeYSQc7HlE1d7mJpLMI6coQ4QuSLFj2srLYlDa82egeyriSi7HP+bMwfq
         K9yCCHWTDlZayzkfBDN/JKuIu9Vy2Wb4BrwA1JCbHRrtVOapA+bSMiSYlTSRG3GPMB
         FQ8P5TlVp2PaQ==
Received: by pali.im (Postfix)
        id 3F0F060E; Fri, 25 Jun 2021 11:05:13 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] PCI: aardvark: Don't mask irq when mapping
Date:   Fri, 25 Jun 2021 11:03:16 +0200
Message-Id: <20210625090319.10220-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625090319.10220-1-pali@kernel.org>
References: <20210625090319.10220-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

By default, all Legacy INTx interrupts are masked, so there is no need to
mask this interrupt during irq_map callback.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index bf44d6bfd0ca..c4fa64a31733 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1060,7 +1060,6 @@ static int advk_pcie_irq_map(struct irq_domain *h,
 {
 	struct advk_pcie *pcie = h->host_data;
 
-	advk_pcie_irq_mask(irq_get_irq_data(virq));
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_chip_and_handler(virq, &pcie->irq_chip,
 				 handle_level_irq);
-- 
2.20.1

