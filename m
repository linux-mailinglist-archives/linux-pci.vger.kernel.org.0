Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6046CDA7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhLHGWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:55 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48964 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhLHGWy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6665BCE2039
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694E1C341CA;
        Wed,  8 Dec 2021 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944360;
        bh=KNofqEKlVzoGb2YHaM9mMSfuN+Jgb7ag1fu7dCWCv9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PtAYoypvn5FmX9Qxqbx+mQq9jPwf6/rBTrkFyb9jhY2GBAxfdzGw+l+yjQOEoGVrE
         McjpEwT8WTqDLbbhZsKmsEzmPtk/k+HlD4kBblDG7PkAlgDOK38NRg4OAGiW+NTo8x
         ujSFuv7+fQeNO/eOGM4jV7d2B9kVrYYeAw293ZhOqdgdZs4LTq0CMB8qq7cQFSSijf
         Wt9TEfjRoNynCI8wsrWk9lZE81TaS+wBXn+3gpYfC8VAo8J+FZIlTPcuHncO3Ks/Ez
         ZmYsAtQ3khpRvhJHx48fNCCETIWYrvdOIK5PbbExcorXYVeHhsz51SAOmM1bAKLDUS
         PdAi0Fu0IcAUQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 15/17] PCI: aardvark: Check return value of generic_handle_domain_irq() when processing INTx IRQ
Date:   Wed,  8 Dec 2021 07:18:49 +0100
Message-Id: <20211208061851.31867-16-kabel@kernel.org>
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

It is possible that we receive spurious INTx interrupt. Check for the
return value of generic_handle_domain_irq() when processing INTx IRQ.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b3e64ae8c438..3cde3f761696 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1575,7 +1575,9 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
 		advk_writel(pcie, PCIE_ISR1_INTX_ASSERT(i),
 			    PCIE_ISR1_REG);
 
-		generic_handle_domain_irq(pcie->irq_domain, i);
+		if (generic_handle_domain_irq(pcie->irq_domain, i) == -EINVAL)
+			dev_err_ratelimited(&pcie->pdev->dev, "unexpected INT%c IRQ\n",
+					    (char)i + 'A');
 	}
 }
 
-- 
2.32.0

