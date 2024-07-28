Return-Path: <linux-pci+bounces-10895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46C93E7F1
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69FC1F20593
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D9148309;
	Sun, 28 Jul 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqLp0XfL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC461474BF;
	Sun, 28 Jul 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182867; cv=none; b=NFgrjYO1Y+K9eoE0tOBZRIJqybtFcOFXJLl3lA/J2F1UJL5uY7pScUZUQoEy5YMb2/P73f2N+WKsm6Wo3NpsngFOIs2t7Z4bWN/e5ZrPHJ+2Uos5kKN70ZzlegEdBLywgADvaXFX3lWW8f5GIqAQWX0BZSmVxtO8Nd3Wuo/A2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182867; c=relaxed/simple;
	bh=tc7Q2652ZMIEOPS5MNHx9cQPp9+1nuTGz4jxfW0TMhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV5Qfwlb+4EKP2VSBNode3Tc7mZQHMwHcbp8Z+RRMUs3d7J6mF01itEGmlJK3bxQEa4v/i6yDtVG304OKao8PLsnceknEeMaqDCj5FNoLxFHgTYpnXvBV++SYSGi+0xLgAGO0zmA1F7dFrTrrC/RnUEEc1uGWpVSF4JGHxvQA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqLp0XfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40224C116B1;
	Sun, 28 Jul 2024 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182866;
	bh=tc7Q2652ZMIEOPS5MNHx9cQPp9+1nuTGz4jxfW0TMhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqLp0XfL9rtqeJ+FLKmkNXJ3KI1IwF14If14t8VKjT0bSSEfpDiGhhDuiMkaCz1bp
	 cq673U4okkruKufVgaryFfn1sYXHHK0DIW2/6ZiX0toUituEdqybupSjDUW+Q5wZkJ
	 Bws1X4EIYsfxuqxTjfZ42u4yn8OnXoZIMq9AtNCyCtllUQHz6yYuFyTWcGiS6YQ5GG
	 ukKLQcPwUlX57T8Qg5OKmtLtzQi9zp1dBaruFAmUbW3a5tPXZBEByE3TwcdTM+Dvg3
	 DPhoyqycJqdMgNd1KuKcQFAV9v9GLv3RUkrhNelhkpZpvEcLd8KPYiEP8pRbzRWNrj
	 rXReB39F/WFYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
	Achal Verma <a-verma1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Sasha Levin <sashal@kernel.org>,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	cassel@kernel.org,
	fancer.lancer@gmail.com,
	u.kleine-koenig@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	dlemoal@kernel.org,
	amishin@t-argos.ru,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/17] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
Date: Sun, 28 Jul 2024 12:06:49 -0400
Message-ID: <20240728160709.2052627-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160709.2052627-1-sashal@kernel.org>
References: <20240728160709.2052627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 86f271f22bbb6391410a07e08d6ca3757fda01fa ]

Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
(SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
the bus may corrupt the packet payload and the corrupt data may
cause associated applications or the processor to hang.

The workaround for Errata #i2037 is to limit the maximum read
request size and maximum payload size to 128 bytes. Add workaround
for Errata #i2037 here.

The errata and workaround is applicable only to AM65x SR 1.0 and
later versions of the silicon will have this fixed.

[1] -> https://www.ti.com/lit/er/sprz452i/sprz452i.pdf

Link: https://lore.kernel.org/linux-pci/16e1fcae-1ea7-46be-b157-096e05661b15@siemens.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 44 ++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index cf3836561316d..4908666d5a95f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -34,6 +34,11 @@
 #define PCIE_DEVICEID_SHIFT	16
 
 /* Application registers */
+#define PID				0x000
+#define RTL				GENMASK(15, 11)
+#define RTL_SHIFT			11
+#define AM6_PCI_PG1_RTL_VER		0x15
+
 #define CMD_STATUS			0x004
 #define LTSSM_EN_VAL		        BIT(0)
 #define OB_XLAT_EN_VAL		        BIT(1)
@@ -104,6 +109,8 @@
 
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
+#define PCI_DEVICE_ID_TI_AM654X		0xb00c
+
 struct ks_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
@@ -527,7 +534,11 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
+	struct keystone_pcie *ks_pcie;
+	struct device *bridge_dev;
 	struct pci_dev *bridge;
+	u32 val;
+
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
 		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
@@ -539,6 +550,11 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
 		{ 0, },
 	};
+	static const struct pci_device_id am6_pci_devids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ 0, },
+	};
 
 	if (pci_is_root_bus(bus))
 		bridge = dev;
@@ -560,10 +576,36 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	 */
 	if (pci_match_id(rc_pci_devids, bridge)) {
 		if (pcie_get_readrq(dev) > 256) {
-			dev_info(&dev->dev, "limiting MRRS to 256\n");
+			dev_info(&dev->dev, "limiting MRRS to 256 bytes\n");
 			pcie_set_readrq(dev, 256);
 		}
 	}
+
+	/*
+	 * Memory transactions fail with PCI controller in AM654 PG1.0
+	 * when MRRS is set to more than 128 bytes. Force the MRRS to
+	 * 128 bytes in all downstream devices.
+	 */
+	if (pci_match_id(am6_pci_devids, bridge)) {
+		bridge_dev = pci_get_host_bridge_device(dev);
+		if (!bridge_dev && !bridge_dev->parent)
+			return;
+
+		ks_pcie = dev_get_drvdata(bridge_dev->parent);
+		if (!ks_pcie)
+			return;
+
+		val = ks_pcie_app_readl(ks_pcie, PID);
+		val &= RTL;
+		val >>= RTL_SHIFT;
+		if (val != AM6_PCI_PG1_RTL_VER)
+			return;
+
+		if (pcie_get_readrq(dev) > 128) {
+			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
+			pcie_set_readrq(dev, 128);
+		}
+	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
-- 
2.43.0


