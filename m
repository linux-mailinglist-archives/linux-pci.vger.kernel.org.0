Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B661E22C672
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGXN3r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 09:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXN3r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 09:29:47 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA03C2065F;
        Fri, 24 Jul 2020 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595597387;
        bh=yvJM5FcpUPPelkzIMDctcDI2U8az0nkLctRH80KQ/rE=;
        h=From:To:Cc:Subject:Date:From;
        b=QquUMn4wuWuGuQZB2ho0l93Z8D4J7m5WkilvDurUrvGlRX0n+bDaKiE+bbgw23NzF
         O4G0hneohbW50Hd9mTd9yXKpb0MnvkMG+3nXNUfWVsVO3dirHj++gRYgZW6tR3pq7+
         OgYvwWl0MH7fkgv5zJ1NwMr3NNc02wbcoi9mitRU=
Received: by pali.im (Postfix)
        id A394A88C; Fri, 24 Jul 2020 15:29:44 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mvebu: Check if reset gpio is defined
Date:   Fri, 24 Jul 2020 15:29:30 +0200
Message-Id: <20200724132930.7206-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reset gpio is optional and it does not have to be defined for all boards.

So in mvebu_pcie_powerdown() like in mvebu_pcie_powerup() check that reset
gpio is defined prior usage to prevent NULL pointer dereference.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 153a64676bc9..58607cbe84c8 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -947,7 +947,8 @@ static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
  */
 static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
 {
-	gpiod_set_value_cansleep(port->reset_gpio, 1);
+	if (port->reset_gpio)
+		gpiod_set_value_cansleep(port->reset_gpio, 1);
 
 	clk_disable_unprepare(port->clk);
 }
-- 
2.20.1

