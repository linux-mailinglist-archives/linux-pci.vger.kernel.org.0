Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0646CDA3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhLHGWu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:22:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48886 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbhLHGWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:22:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53F1FCE19BA
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4C5C341CA;
        Wed,  8 Dec 2021 06:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944354;
        bh=eHfLtO/Rgu6wnop7ipAsBHKLeL/SXaSN3lFDX1Q88WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nausHCECgACrLI7iPZeWm7Uvq6UxC1l6AzoieqR8Jdt6LLOjoVoG2cOFyHc7cjD5k
         dk3USUG0AM9tpHFf/9HlpCllvDslwfMixaiL8Ra6hU5uAXjD/2j033uB+gGxXuEkbR
         Bi8lwAJsKqSsmAqGhgT8mnfuNe5MVDHLv5QxfcUQ70lVheofInlW+dbym60G5d+Bxk
         5ODaO5GQ3gyInJ2MvLWceJcbSZu4+rSj9Mfq9qYqTAPkViJNmRWFLxwyeQIa0xPtMy
         OG30uHmkiEhUmfGLsmLj/aB8OQ/el4kUKvPxm1DAgb5fTJgV1QfdioRF7Lh8q4u8hU
         Q3XOFK/gSXhbg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 11/17] PCI: aardvark: Optimize writing PCI_EXP_RTCTL_PMEIE and PCI_EXP_RTSTA_PME on emulated bridge
Date:   Wed,  8 Dec 2021 07:18:45 +0100
Message-Id: <20211208061851.31867-12-kabel@kernel.org>
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

To optimize advk_pci_bridge_emul_pcie_conf_write() code, touch
PCIE_ISR0_REG and PCIE_ISR0_MASK_REG registers only when it is really
needed, when processing PCI_EXP_RTCTL_PMEIE and PCI_EXP_RTSTA_PME bits.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index f7d553a63f06..1c7485489632 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -942,19 +942,21 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 			advk_pcie_wait_for_retrain(pcie);
 		break;
 
-	case PCI_EXP_RTCTL: {
+	case PCI_EXP_RTCTL:
 		/* Only mask/unmask PME interrupt */
-		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG) &
-			~PCIE_MSG_PM_PME_MASK;
-		if ((new & PCI_EXP_RTCTL_PMEIE) == 0)
-			val |= PCIE_MSG_PM_PME_MASK;
-		advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
+		if (mask & PCI_EXP_RTCTL_PMEIE) {
+			u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG);
+			if (new & PCI_EXP_RTCTL_PMEIE)
+				val &= ~PCIE_MSG_PM_PME_MASK;
+			else
+				val |= PCIE_MSG_PM_PME_MASK;
+			advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
+		}
 		break;
-	}
 
 	case PCI_EXP_RTSTA:
-		new = (new & PCI_EXP_RTSTA_PME) >> 9;
-		advk_writel(pcie, new, PCIE_ISR0_REG);
+		if (new & PCI_EXP_RTSTA_PME)
+			advk_writel(pcie, PCIE_MSG_PM_PME_MASK, PCIE_ISR0_REG);
 		break;
 
 	case PCI_EXP_DEVCTL:
-- 
2.32.0

