Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB44454809
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 15:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbhKQOEJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 09:04:09 -0500
Received: from marcansoft.com ([212.63.210.85]:43344 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238121AbhKQODx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 09:03:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id F2F6D419B4;
        Wed, 17 Nov 2021 14:00:50 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH] PCI: apple: Fix REFCLK1 enable/poll logic
Date:   Wed, 17 Nov 2021 23:00:44 +0900
Message-Id: <20211117140044.193865-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

REFCLK1 has req/ack bits just like REFCLK0

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/pci/controller/pcie-apple.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index b665d29af77a..420c291a5c68 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -42,8 +42,9 @@
 #define   CORE_FABRIC_STAT_MASK		0x001F001F
 #define CORE_LANE_CFG(port)		(0x84000 + 0x4000 * (port))
 #define   CORE_LANE_CFG_REFCLK0REQ	BIT(0)
-#define   CORE_LANE_CFG_REFCLK1		BIT(1)
+#define   CORE_LANE_CFG_REFCLK1REQ	BIT(1)
 #define   CORE_LANE_CFG_REFCLK0ACK	BIT(2)
+#define   CORE_LANE_CFG_REFCLK1ACK	BIT(3)
 #define   CORE_LANE_CFG_REFCLKEN	(BIT(9) | BIT(10))
 #define CORE_LANE_CTL(port)		(0x84004 + 0x4000 * (port))
 #define   CORE_LANE_CTL_CFGACC		BIT(15)
@@ -481,9 +482,9 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 	if (res < 0)
 		return res;
 
-	rmw_set(CORE_LANE_CFG_REFCLK1, pcie->base + CORE_LANE_CFG(port->idx));
+	rmw_set(CORE_LANE_CFG_REFCLK1REQ, pcie->base + CORE_LANE_CFG(port->idx));
 	res = readl_relaxed_poll_timeout(pcie->base + CORE_LANE_CFG(port->idx),
-					 stat, stat & CORE_LANE_CFG_REFCLK1,
+					 stat, stat & CORE_LANE_CFG_REFCLK1ACK,
 					 100, 50000);
 
 	if (res < 0)
-- 
2.33.0

