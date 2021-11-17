Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0291454A70
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 17:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbhKQQEB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 11:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238861AbhKQQEA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 11:04:00 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50F5E61B48;
        Wed, 17 Nov 2021 16:01:02 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mnNMq-0067Me-4W; Wed, 17 Nov 2021 16:01:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Cc:     kernel-team@android.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: apple: Reset the port for 100ms on probe
Date:   Wed, 17 Nov 2021 16:00:53 +0000
Message-Id: <20211117160053.232158-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, kernel-team@android.com, alyssa@rosenzweig.io, lorenzo.pieralisi@arm.com, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While the Apple PCIe driver works correctly when directly booted
from the firmware, it fails to initialise when the kernel is booted
from a bootloader using PCIe such as u-boot.

That's beacuse we're missing a proper reset of the port (we only
clear the reset, but never assert it).

Bring the port back to life by wiggling the #PERST pin for 100ms
(as per the spec).

Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pcie-apple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 1bf4d75b61be..bbea5f6e0a68 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -543,6 +543,9 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	if (ret < 0)
 		return ret;
 
+	/* Hold #PERST for 100ms as per the spec */
+	gpiod_set_value(reset, 0);
+	msleep(100);
 	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
 	gpiod_set_value(reset, 1);
 
-- 
2.30.2

