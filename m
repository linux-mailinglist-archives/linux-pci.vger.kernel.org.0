Return-Path: <linux-pci+bounces-36476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B360B89A25
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 15:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F10318909B5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8A521FF3F;
	Fri, 19 Sep 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh2VgatM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5F1B21BD;
	Fri, 19 Sep 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287817; cv=none; b=UHQxv+IikDyOEaqQrjLHfW+7gsaoT0Fro/J1nm5V4blp/XWTy6jp6ZGZFkcSzfjnvY2eVyKraerqmkbr8CglPbxuxVE5Wu/TThvM0LLQchfhnR4skKjNyIOFvQyfAbr6BXIH2wyxr5Y5ExcuVU0qqTnqRv4SB8lAAeyIzV2iM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287817; c=relaxed/simple;
	bh=/eFfU0hGF05pJwVzBmAFJn19mo9Ahj7F3snFSc4GoGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K9fQHSlzOfWoAFTkmkL0Wlud455lGEEpIa4/IESvNyZ0zZJtzQWyVRkaGo66MDaGYA/a9hcxWUO2DR/9hfHdZXxrEW2fdSCg9jQCVR+y6mLcc3qi6mBlrcrDWmhv8JAEe+yD71pxNh9A9qmog+LVzPaTku+O2kdzUBWRe43Ivwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh2VgatM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5261DC4CEF1;
	Fri, 19 Sep 2025 13:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758287817;
	bh=/eFfU0hGF05pJwVzBmAFJn19mo9Ahj7F3snFSc4GoGY=;
	h=From:To:Cc:Subject:Date:From;
	b=kh2VgatMzWfOelfU2ZMCvt98U4+EHk3aSAViqAknGtfmeRT0URRNu9lgklvKlSqcO
	 3ZwISDxedTOEKYdkJ5t5RtkMsMeI28fbHfvfEjcy7pTvkRecEUO4jeBdS26juaHlFH
	 /I/3/sYVUCdyUpsEO6EWGaZL+o2I1oey7SY6TRZbRUiYz2v6lf/2swytaefi0Tm4d7
	 NE4JAOKEhRdhV1/T1sLri16MNy17f5emoIQzud/Gb8a06vSFRnSoL8Zd0vS4kNQlis
	 2ZZxmpo9zTQ+l6eDZVHYGz1WYkMQEgQjYCIU81wN8kw85FMltu3M5QWWLP6pKxxvuN
	 E3jcdp1Gdzvtw==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: tegra194: Reset BARs when running in PCIe endpoint mode
Date: Fri, 19 Sep 2025 15:16:47 +0200
Message-ID: <20250919131646.167330-2-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=cassel@kernel.org; h=from:subject; bh=/eFfU0hGF05pJwVzBmAFJn19mo9Ahj7F3snFSc4GoGY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLOhu9rb4nV3L7cqqTjpFz+CjN1Lg6bR+Vb3pjnzHGae VflSn9ERykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYyfT/DH/7LCoHX1x1xcVpw IvW8TPTtOMvfcccyZGY+S+Apnbt4dzHDP63HtVPPdR11bTnHf0tC5/zD+FWma9a9siqcwCS3zJf FgQ8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Tegra already defines all BARs expect for BAR0 as BAR_RESERVED.
This is sufficient for pci-epf-test to not allocate backing memory and to
not call set_bar() for those BARs.

However, the host side driver, pci_endpoint_test, simply does an ioremap
for all enabled BARs, and will run tests against all enabled BARs.

After running the BARs tests (which will write to all enabled BARs), the
inbound address translation is broken.
This is because the tegra controller exposes the ATU Port Logic Structure
in BAR4. So when BAR4 is written, the inbound address translation settings
get overwritten.

To avoid this, implement the dw_pcie_ep_ops .init() callback and start off
by disabling all BARs (pci-epf-test will later enable/configure BARs that
are not defined as BAR_RESERVED).

This matches the behavior of other PCIe endpoint drivers:
dra7xx, imx6, layerscape-ep, artpec6, dw-rockchip, qcom-ep, rcar-gen4, and
uniphier-ep.

With this, the PCI endpoint kselftest test case CONSECUTIVE_BAR_TEST
(which was specifically made to detect address translation issues) passes.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4f26086f25daf..9488805ecf608 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1941,6 +1941,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+};
+
 static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
@@ -2017,6 +2026,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.init = tegra_pcie_ep_init,
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };
-- 
2.51.0


