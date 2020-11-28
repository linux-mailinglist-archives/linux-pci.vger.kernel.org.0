Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1193D2C72B8
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 23:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbgK1VuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 16:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732231AbgK1S7i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 13:59:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C98222EA;
        Sat, 28 Nov 2020 10:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606559870;
        bh=ElFuI/yPzYiGjePDtZkN0gYaY20kahcwihMuI8AchqM=;
        h=From:To:Cc:Subject:Date:From;
        b=EUKbch1JzQWJVAmirG5SwTwjCYttSzWvcHpW3lEKWXNw9c+yQs/nGbGquMNkNh9S9
         V1UExUe2hrGYref6vwwC/deRqluLCKbCdW/my5EHP8c80NnxkSfqaetGhoHWoO7hAe
         yWWaqLdZj7HCt7nAlg5BR/x478YrVuV7vvmGo4/0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kixbw-00EGNC-BB; Sat, 28 Nov 2020 10:37:48 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Cc:     kernel-team@android.com, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] MAINTAINERS: Move Jason Cooper to CREDITS
Date:   Sat, 28 Nov 2020 10:37:07 +0000
Message-Id: <20201128103707.332874-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, kernel-team@android.com, andrew@lunn.ch, sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com, tglx@linutronix.de, thomas.petazzoni@bootlin.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason's email address has now been bouncing for weeks, and no
reply was received when trying to reach out on other addresses.

We really hope he is OK. But until we hear of his whereabouts,
let's move him to the CREDITS file so that people stop Cc-ing
him.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 CREDITS     | 5 +++++
 MAINTAINERS | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index 8592e45e3932..cf112d3e9382 100644
--- a/CREDITS
+++ b/CREDITS
@@ -740,6 +740,11 @@ S: (ask for current address)
 S: Portland, Oregon
 S: USA
 
+N: Jason Cooper
+D: ARM/Marvell SOC co-maintainer
+D: irqchip co-maintainer
+D: MVEBU PCI DRIVER co-maintainer
+
 N: Robin Cornelius
 E: robincornelius@users.sourceforge.net
 D: Ralink rt2x00 WLAN driver
diff --git a/MAINTAINERS b/MAINTAINERS
index e451dcce054f..7ba26942a573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2012,7 +2012,6 @@ M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
 ARM/Marvell Dove/MV78xx0/Orion SOC support
-M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 M:	Gregory Clement <gregory.clement@bootlin.com>
@@ -2029,7 +2028,6 @@ F:	arch/arm/plat-orion/
 F:	drivers/soc/dove/
 
 ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
-M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Gregory Clement <gregory.clement@bootlin.com>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
@@ -9255,7 +9253,6 @@ F:	kernel/irq/
 
 IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@linutronix.de>
-M:	Jason Cooper <jason@lakedaemon.net>
 M:	Marc Zyngier <maz@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -13405,7 +13402,6 @@ F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
-M:	Jason Cooper <jason@lakedaemon.net>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.29.2

