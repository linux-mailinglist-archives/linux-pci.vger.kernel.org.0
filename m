Return-Path: <linux-pci+bounces-23858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D5A63254
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0563718971C8
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAF31DD87D;
	Sat, 15 Mar 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEjL2sg6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC01DA634;
	Sat, 15 Mar 2025 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069764; cv=none; b=Dk8tJLgYuK0gae/9SZBwn2xu9mvgDdc5liBlXD7huw9reMN5Y5nfAK8Ca0lMWITBNuhiOb3F/Us/dl1A8FKggRU/PpP/h9g+RiV5OwVswjGdG/xB3fY16UZ+8XStG1LVYw7C6Hq9/Lbx20F+93GoTG5WiHUhU7qGfoH1wHRNCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069764; c=relaxed/simple;
	bh=xB6ldgyig7nN1oawfCv8XbECiYxHY/R3QbJPHcluIDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzUmVmVZBdr6OWucBavd9WBEcTKS7IwvOH/9h7sYV4l417AfVPpr7E/6oL+i+vcWxuyKWRVoqoR7/vIibQeJFXh5u7dHvpRg8vG1owLycvsE4jjyypNtNTfifSEa7c/Kebzr0xUUmZuvZXEBmqHaUByFlscpEKEhOkhA1JkeEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEjL2sg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF49C4CEEE;
	Sat, 15 Mar 2025 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069763;
	bh=xB6ldgyig7nN1oawfCv8XbECiYxHY/R3QbJPHcluIDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEjL2sg6NL0sBUo+hdJ1COcu8uVHTNW6Xk6LjpHobFVf9FX2ljnsE2FyUu1Hz6q/P
	 HD6QapKbbHHeH7h3xE2hQIry9GVELimvZqxXUCDjW7jCZeV7hy69nK1dcOURThHpNo
	 sRq4ew3NsXblUUdC54i1mDoYxDMtmhpaPUKoob2ECHXMfWfy9M9ULcpo3EC7OnM02m
	 C65wRKrBWp5CwsL5cdsMRJ8BLv6u7DiehUeLZt+YtLYLPiKRKkuN4UMLryvLiLamH2
	 /YWoiqUaBSOzn5uRsXeMmCssNKbPEqOY6uzJJmn2fF2NuhgySFAq+4m2mDXfSq44Zn
	 Mi5Eve/5HMoYg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 05/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
Date: Sat, 15 Mar 2025 15:15:40 -0500
Message-Id: <20250315201548.858189-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

Return the offset from CPU physical address to the parent bus address of
the specified element of the devicetree 'reg' property.

[bhelgaas: return offset, split .cpu_addr_fixup() checking and debug to
separate patch]
Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 23 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d0a5f75effc..0a35e36da703 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
@@ -1105,3 +1106,25 @@ void dw_pcie_setup(struct dw_pcie *pci)
 
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
+
+resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
+					  const char *reg_name,
+					  resource_size_t cpu_phy_addr)
+{
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	int index;
+	u64 reg_addr;
+
+	/* Look up reg_name address on parent bus */
+	index = of_property_match_string(np, "reg-names", reg_name);
+
+	if (index < 0) {
+		dev_err(dev, "No %s in devicetree \"reg\" property\n", reg_name);
+		return 0;
+	}
+
+	of_property_read_reg(np, index, &reg_addr, NULL);
+
+	return cpu_phy_addr - reg_addr;
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d0d8c622a6e8..16548b01347d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -500,6 +500,9 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
+					  const char *reg_name,
+					  resource_size_t cpu_phy_addr);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-- 
2.34.1


