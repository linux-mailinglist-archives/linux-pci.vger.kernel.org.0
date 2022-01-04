Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D024844D3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiADPii (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 10:38:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39786 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiADPig (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 10:38:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E350DCE1936;
        Tue,  4 Jan 2022 15:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C85C36AEF;
        Tue,  4 Jan 2022 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641310713;
        bh=GN5jKZEodCfeZz6pv/k5h1jk1jhWdZrxDcJsdMUC48E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SwU9uOgh4vFdXy1/SQJV/TuohYJYyzYMQ0QOjr5DIiyFWLJMyy23EIOzPcZurX+HC
         RkNfi1lO4d7KYcH41/OJpJUaLAbzM76JrCXoC8e4lBoQt1JyH4X9JiAsWTt7FJvUc5
         NA9D1RwCicjh79+MvjbraH4cWdPENQ20QD3C2zk7J4JWFunJguwzrG4fg9jhk/Of7I
         qTlfuBjLpKnjMKzyeoSIztQNClXm1OZztkZ/5LvyEoOKAv9UJB9XQxlCaaB3KYRrKt
         IAvR4B92VXwJKEzHUBMJKcMbZ5hflXnydsCmQiKHUQ1gKsF49EoaM2NJJsn3SbijAY
         SY1/JvH+/Ln+g==
Received: by pali.im (Postfix)
        id DC54A96B; Tue,  4 Jan 2022 16:38:32 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] PCI: mvebu: Fix reporting Data Link Layer Link Active on emulated bridge
Date:   Tue,  4 Jan 2022 16:35:29 +0100
Message-Id: <20220104153529.31647-12-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for reporting PCI_EXP_LNKSTA_DLLLA bit in Link Control register
on emulated bridge via PCIE_STAT_OFF reg. Function mvebu_pcie_link_up()
already parses this register and returns if Data Link is Active or not.

Also correctly indicate DLLLA capability via PCI_EXP_LNKCAP_DLLLARC bit in
Link Control Capability register which is required for reporting DLLLA bit.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index dffa330de174..a075ba26cff1 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -548,13 +548,18 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		/*
 		 * PCIe requires that the Clock Power Management capability bit
 		 * is hard-wired to zero for downstream ports but HW returns 1.
+		 * Additionally enable Data Link Layer Link Active Reporting
+		 * Capable bit as DL_Active indication is provided too.
 		 */
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP) &
-			 ~PCI_EXP_LNKCAP_CLKPM;
+		*value = (mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP) &
+			  ~PCI_EXP_LNKCAP_CLKPM) | PCI_EXP_LNKCAP_DLLLARC;
 		break;
 
 	case PCI_EXP_LNKCTL:
-		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
+		/* DL_Active indication is provided via PCIE_STAT_OFF */
+		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL) |
+			 (mvebu_pcie_link_up(port) ?
+			  (PCI_EXP_LNKSTA_DLLLA << 16) : 0);
 		break;
 
 	case PCI_EXP_SLTCTL:
-- 
2.20.1

