Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FDB7E459A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 17:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjKGQOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 11:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjKGQOT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 11:14:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D372618B;
        Tue,  7 Nov 2023 07:51:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C586C433C9;
        Tue,  7 Nov 2023 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372275;
        bh=urqkR54wZ0YlPLcnqz+7MHq135Kx+QopuCyfGWru9+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DE1Pr9wqpr3DGaNs5JvowGrGxX1Q4dTFENgtG5uxtfBfVpBaBCyNF7g/q3at9W85j
         dK4IXe2R8kD0lbcoG94wAensHgXtJ9hE+Casvo/LN/oE/pfjLp/zAtwKujPgOu5bRD
         BtZTqo5LUfxyWuLLdXHzQ/jnC4JmcELXLTTzjFVwjzYJ+TZ4mhfYWb8L0fi121HBj/
         xBZ44Sdu340tgAqMV5jCyLsxY/72kMx+BGNAV7OCTbOz3GY1yYkDnDJ33nZgf46Zul
         VK0k/X4x1QmA/2eX2uWI8Ntv3CXLJCrYGLQ75NzkqjW2eLroihB89UV5DsGk7dcFXZ
         gEiKOPcR9VteQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/30] PCI: Use FIELD_GET() to extract Link Width
Date:   Tue,  7 Nov 2023 10:49:55 -0500
Message-ID: <20231107155024.3766950-21-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit d1f9b39da4a5347150246871325190018cda8cb3 ]

Use FIELD_GET() to extract PCIe Negotiated and Maximum Link Width fields
instead of custom masking and shifting.

Link: https://lore.kernel.org/r/20230919125648.1920-7-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[bhelgaas: drop duplicate include of <linux/bitfield.h>]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-sysfs.c | 5 ++---
 drivers/pci/pci.c       | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dd0d9d9bc5097..6ccd88d1bfa0f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -12,7 +12,7 @@
  * Modeled after usb's driverfs.c
  */
 
-
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
@@ -230,8 +230,7 @@ static ssize_t current_link_width_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	return sysfs_emit(buf, "%u\n",
-		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
+	return sysfs_emit(buf, "%u\n", FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat));
 }
 static DEVICE_ATTR_RO(current_link_width);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59b5c017d6c38..4f37885017200 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6138,8 +6138,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
 		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
-		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
-			PCI_EXP_LNKSTA_NLW_SHIFT;
+		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 
 		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
 
@@ -6211,7 +6210,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 	if (lnkcap)
-		return (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+		return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
 
 	return PCIE_LNK_WIDTH_UNKNOWN;
 }
-- 
2.42.0

