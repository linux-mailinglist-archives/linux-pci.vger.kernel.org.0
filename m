Return-Path: <linux-pci+bounces-10917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C17693E881
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD071C21668
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26DB19047A;
	Sun, 28 Jul 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp6ionHg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3079B96;
	Sun, 28 Jul 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183047; cv=none; b=Cpyc6NekbKvXZq68+Ko2RIhWnPfAEZcHq+WhqE/nQUbZNcB+jMKffH6yqdw4bRZJq3NyHbN/KaHJYQwf3JtpoHBjSDLmByIShjcVURBSopQKYQO6pR4bnOxJQT7sudv1HF6j0LcUVW6OAOCdz0LK1lmbA8UVhqkG3btzs7CwEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183047; c=relaxed/simple;
	bh=an/LViASX7ul3G0a6kqSnWxk5CUgWpiekVAXQYljTEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xar+JVdSQFflqlk5HOt2s67pdM4A/8MQ6Ewg7P9HwyYVX2277qEuLVuZo9nZraAmTPM8tv2dTRrvWivIn10cl4hH61/HnVej+6J1mnt9ddSJ3OWyg527AV4AzYGPUe6e2BSd6193Tvd/rSKWPLH9DrzzSdxa50RIVOw+KgW3ccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp6ionHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C630C4AF0B;
	Sun, 28 Jul 2024 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183047;
	bh=an/LViASX7ul3G0a6kqSnWxk5CUgWpiekVAXQYljTEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pp6ionHgnbXZUMX4UkNhFK46LVQk/WhDb9CklRA2Xjrnjp9M9W8RCPXKc9zwBfuiT
	 oM4Nl77pXYo3xE/jkx+xm4bK/lP+wCY7D+6t3XTBan4bWTqI0+mRihWQAsHFus1pBN
	 wPAPlNq4svY9OWGjsuL7kDvLVWSwOnRQ25yvTdWAFWJktlYQLLt7doaHOtG8wz3kHJ
	 3GP9QKyXC9xQUzVxHUh20TmPdZmxjGzo/nb8IA6y7yX0PddywEMMqhf15MHd6LFmvr
	 et4WCd7pzodDKxHq6wahbycngte5CtNTIK0hSr00thVbvGFtX0ZCM/Y6IpEvPNgjyo
	 RHgamlgcFzJfQ==
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
	u.kleine-koenig@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	dlemoal@kernel.org,
	amishin@t-argos.ru,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/7] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
Date: Sun, 28 Jul 2024 12:10:25 -0400
Message-ID: <20240728161033.2054341-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728161033.2054341-1-sashal@kernel.org>
References: <20240728161033.2054341-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index b18ddb2b9ef8b..a16fe2a558c7a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -35,6 +35,11 @@
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
@@ -107,6 +112,8 @@
 
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
+#define PCI_DEVICE_ID_TI_AM654X		0xb00c
+
 struct ks_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
@@ -534,7 +541,11 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
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
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
@@ -546,6 +557,11 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
 		{ 0, },
 	};
+	static const struct pci_device_id am6_pci_devids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ 0, },
+	};
 
 	if (pci_is_root_bus(bus))
 		bridge = dev;
@@ -567,10 +583,36 @@ static void ks_pcie_quirk(struct pci_dev *dev)
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


