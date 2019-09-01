Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46309A4991
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2019 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfIANaX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Sep 2019 09:30:23 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33485 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIANaX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Sep 2019 09:30:23 -0400
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 75B9B240006;
        Sun,  1 Sep 2019 13:30:20 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] PCI: amlogic: Fix reset assertion via gpio descriptor
Date:   Sun,  1 Sep 2019 15:39:15 +0200
Message-Id: <20190901133915.12899-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Normally asserting reset signal on gpio would be achieved with:
	gpiod_set_value_cansleep(reset_gpio, 1);

Meson PCI driver set reset value to '0' instead of '1' as it takes into
account the PERST# signal polarity. The polarity should be taken care
in the device tree instead.

This fixes the reset assertion meaning and moves out the polarity
configuration in DT (please note that there is no DT currently using
this driver).

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 drivers/pci/controller/dwc/pci-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index e35e9eaa50ee..541f37a6f6a5 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -287,9 +287,9 @@ static inline void meson_cfg_writel(struct meson_pcie *mp, u32 val, u32 reg)
 
 static void meson_pcie_assert_reset(struct meson_pcie *mp)
 {
-	gpiod_set_value_cansleep(mp->reset_gpio, 0);
-	udelay(500);
 	gpiod_set_value_cansleep(mp->reset_gpio, 1);
+	udelay(500);
+	gpiod_set_value_cansleep(mp->reset_gpio, 0);
 }
 
 static void meson_pcie_init_dw(struct meson_pcie *mp)
-- 
2.20.1

