Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E19B45DA63
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbhKYMxT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353484AbhKYMvp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B93EA610D2;
        Thu, 25 Nov 2021 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844399;
        bh=HAwmzdzGbp3IRdqXEag5++Pgk0BJ9we/P6AQ8qPIyTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRIycqlRwe0l1Cpe9qadszwuU8qNRH+vVX/HsiQnK7rhxqghhwTZ4uy32NGKbh8qs
         GR2RQ3Bj2IMZqTezqHB0X0pVrbnqDMrQLzK9n+jfePCfgRp69th2x1ML2jOzYp44aW
         MecvdFbDzJtyGiz4VtNejtEViTY3tOAZO2TMGG9a3vda7x/8nKQ4ELUBtddz1ViJUi
         xk6xMwAgeB8z7GXWgXZGGHwieC02Vop7XQsMvq3Y+GHIwZTj8VB7TDhMnx8ReGIYeo
         kcCSX8WmUcKVL7CsKG7iwU9yt18Low8+yJW9nVnsTTHTRV3eKeBmUAa638kq2n6B5w
         /viQaVb0SXsLA==
Received: by pali.im (Postfix)
        id 77E46EDE; Thu, 25 Nov 2021 13:46:39 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] PCI: mvebu: Setup PCIe controller to Root Complex mode
Date:   Thu, 25 Nov 2021 13:45:59 +0100
Message-Id: <20211125124605.25915-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This driver operates only in Root Complex mode, so ensure that hardware is
properly configured in Root Complex mode.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 12afa565bfcf..017ae9f869ac 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -56,6 +56,7 @@
 #define  PCIE_MASK_ENABLE_INTS          0x0f000000
 #define PCIE_CTRL_OFF		0x1a00
 #define  PCIE_CTRL_X1_MODE		0x0001
+#define  PCIE_CTRL_RC_MODE		BIT(1)
 #define PCIE_STAT_OFF		0x1a04
 #define  PCIE_STAT_BUS                  0xff00
 #define  PCIE_STAT_DEV                  0x1f0000
@@ -224,7 +225,12 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u32 cmd, mask;
+	u32 ctrl, cmd, mask;
+
+	/* Setup PCIe controller to Root Complex mode. */
+	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
+	ctrl |= PCIE_CTRL_RC_MODE;
+	mvebu_writel(port, ctrl, PCIE_CTRL_OFF);
 
 	/* Disable Root Bridge I/O space, memory space and bus mastering. */
 	cmd = mvebu_readl(port, PCIE_CMD_OFF);
-- 
2.20.1

