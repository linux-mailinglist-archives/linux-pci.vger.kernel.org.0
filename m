Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1089125AD91
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIBOpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 10:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgIBOo2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 10:44:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9722083B;
        Wed,  2 Sep 2020 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599057848;
        bh=EcQ+ex7Lr+tapMUpbMG4dyA5GZ37BcgwgwzhLMOf6ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTRZFZrhB6umHi8+1T6wc4Zvg6/zC6Icd5Fapwwh+5PPlSQIeEdQhMrRxc+648Ydr
         MOo4HYwPdP0694R6iZW1dybxkxnzIRAcglDk2MXL7gRVmYZx/OuUgwTylMR/35RTW6
         S3LyKL0mcwF7Hpp3WHmKjVk7rHPiwNQ3ddVNhYpU=
Received: by pali.im (Postfix)
        id 20D8BEF5; Wed,  2 Sep 2020 16:44:06 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] phy: marvell: comphy: Convert internal SMCC firmware return codes to errno
Date:   Wed,  2 Sep 2020 16:43:43 +0200
Message-Id: <20200902144344.16684-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200902144344.16684-1-pali@kernel.org>
References: <20200902144344.16684-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Driver ->power_on and ->power_off callbacks leaks internal SMCC firmware
return codes to phy caller. This patch converts SMCC error codes to
standard linux errno codes. Include file linux/arm-smccc.h already provides
defines for SMCC error codes, so use them instead of custom driver defines.
Note that return value is signed 32bit, but stored in unsigned long type
with zero padding.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index 1a138be8bd6a..810f25a47632 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -26,7 +26,6 @@
 #define COMPHY_SIP_POWER_ON			0x82000001
 #define COMPHY_SIP_POWER_OFF			0x82000002
 #define COMPHY_SIP_PLL_LOCK			0x82000003
-#define COMPHY_FW_NOT_SUPPORTED			(-1)
 
 #define COMPHY_FW_MODE_SATA			0x1
 #define COMPHY_FW_MODE_SGMII			0x2
@@ -112,10 +111,19 @@ static int mvebu_a3700_comphy_smc(unsigned long function, unsigned long lane,
 				  unsigned long mode)
 {
 	struct arm_smccc_res res;
+	s32 ret;
 
 	arm_smccc_smc(function, lane, mode, 0, 0, 0, 0, 0, &res);
+	ret = res.a0;
 
-	return res.a0;
+	switch (ret) {
+	case SMCCC_RET_SUCCESS:
+		return 0;
+	case SMCCC_RET_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int mvebu_a3700_comphy_get_fw_mode(int lane, int port,
@@ -220,7 +228,7 @@ static int mvebu_a3700_comphy_power_on(struct phy *phy)
 	}
 
 	ret = mvebu_a3700_comphy_smc(COMPHY_SIP_POWER_ON, lane->id, fw_param);
-	if (ret == COMPHY_FW_NOT_SUPPORTED)
+	if (ret == -EOPNOTSUPP)
 		dev_err(lane->dev,
 			"unsupported SMC call, try updating your firmware\n");
 
diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index e41367f36ee1..53ad127b100f 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -123,7 +123,6 @@
 
 #define COMPHY_SIP_POWER_ON	0x82000001
 #define COMPHY_SIP_POWER_OFF	0x82000002
-#define COMPHY_FW_NOT_SUPPORTED	(-1)
 
 /*
  * A lane is described by the following bitfields:
@@ -273,10 +272,19 @@ static int mvebu_comphy_smc(unsigned long function, unsigned long phys,
 			    unsigned long lane, unsigned long mode)
 {
 	struct arm_smccc_res res;
+	s32 ret;
 
 	arm_smccc_smc(function, phys, lane, mode, 0, 0, 0, 0, &res);
+	ret = res.a0;
 
-	return res.a0;
+	switch (ret) {
+	case SMCCC_RET_SUCCESS:
+		return 0;
+	case SMCCC_RET_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int mvebu_comphy_get_mode(bool fw_mode, int lane, int port,
@@ -819,7 +827,7 @@ static int mvebu_comphy_power_on(struct phy *phy)
 	if (!ret)
 		return ret;
 
-	if (ret == COMPHY_FW_NOT_SUPPORTED)
+	if (ret == -EOPNOTSUPP)
 		dev_err(priv->dev,
 			"unsupported SMC call, try updating your firmware\n");
 
-- 
2.20.1

