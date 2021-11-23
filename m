Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF7245AACD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 19:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhKWSJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 13:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239633AbhKWSJv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 13:09:51 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA94860FD8;
        Tue, 23 Nov 2021 18:06:42 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mpaBk-007LjH-Ts; Tue, 23 Nov 2021 18:06:40 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>, kernel-team@android.com
Subject: [PATCH v3 3/3] PCI: apple: Fix #PERST polarity
Date:   Tue, 23 Nov 2021 18:06:36 +0000
Message-Id: <20211123180636.80558-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123180636.80558-1-maz@kernel.org>
References: <20211123180636.80558-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, pali@kernel.org, alyssa@rosenzweig.io, lorenzo.pieralisi@arm.com, bhelgaas@google.com, mark.kettenis@xs4all.nl, luca@lucaceresoli.net, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that #PERST is properly defined as active-low in the device tree,
fix the driver to correctly drive the line indemendently of the
implied polarity.

Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Suggested-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 957960a733c4..03bc56f39be5 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -540,7 +540,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
 
 	/* Engage #PERST before setting up the clock */
-	gpiod_set_value(reset, 0);
+	gpiod_set_value(reset, 1);
 
 	ret = apple_pcie_setup_refclk(pcie, port);
 	if (ret < 0)
@@ -551,7 +551,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 
 	/* Deassert #PERST */
 	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
-	gpiod_set_value(reset, 1);
+	gpiod_set_value(reset, 0);
 
 	/* Wait for 100ms after #PERST deassertion (PCIe r2.0, 6.6.1) */
 	msleep(100);
-- 
2.30.2

