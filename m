Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686508B5BC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfHMKiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 06:38:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33482 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfHMKiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 06:38:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so772204wme.0;
        Tue, 13 Aug 2019 03:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IRI9xzFxMKHfeehDsl2GFQBy7QLiUvO6l2kHk0UQE0g=;
        b=aCI51qO34X/uPszR7lNNZE1/e1jxWIwIBk8l9oePyQwmSP0bFzbVeCDYVtMpEqNWr7
         QdMZRXwK1Oveq4ovY3DMACXY3Hzznyx3JNqpQJE+GHlaEGQ4Lo+l3A31Ru66W6ACXEUh
         NfsgAzBW43voti8rf6Zr7Zfj6jhG0petXi7SO0OQ6u9WOeKDBDB5rl9DBGb1KQCPGyYN
         8II2YfhXnNEwdmofyxEiyhIEtNJHteNFx2aVymiK64VilodcocPKIZTKrZp7FygzGQKR
         I17VuYM/66iXMfyeLqZDO2Iu9MxBe1DCL+nBMwzRFU7kDgi2H1fb4+eMjP9ThcnmSKo9
         4WKw==
X-Gm-Message-State: APjAAAVfqwwrJpQgFlZCWKstHwC+QCd1clanezcc2Lr/WNWax93i5yuZ
        icjtCMks1VPag2GMiEh/APZor7rI9LzsoQ==
X-Google-Smtp-Source: APXvYqykijlq6kdHHcALNJ7kMDqWm4cQ80tA6EmpKRsiGVizuQU+0b4coATfODqCKbQAlhZg4Rcazw==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr2408158wma.176.1565692682962;
        Tue, 13 Aug 2019 03:38:02 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id f70sm1484635wme.22.2019.08.13.03.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:38:02 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] PCIe: imx6: imx7d: add support for internal phy refclk source
Date:   Tue, 13 Aug 2019 11:37:58 +0100
Message-Id: <20190813103759.38358-1-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The i.MX7D variant of the IP can use either an external
crystal oscillator input or an internal clock input as
a reference clock input for the PCIe PHY.

Add support for an optional property 'fsl,pcie-phy-refclk-internal'
If present then the internal clock input is used as
PCIe PHY reference clock source. The previous default
of using an external ocsillator input (if the property
doesn't exist), doesn't change.

Signed-off-by: André Draszik <git@andred.net>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9b5cb5b70389..bb3700c9157c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -63,6 +63,7 @@ struct imx6_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
 	bool			gpio_active_high;
+	bool			phy_refclk_internal;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie_inbound_axi;
@@ -635,7 +636,10 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+				   imx6_pcie->phy_refclk_internal
+				   ? IMX7D_GPR12_PCIE_PHY_REFCLK_SEL
+				   : 0);
 		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -1171,6 +1175,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		imx6_pcie->link_gen = 1;
 
+	imx6_pcie->phy_refclk_internal =
+		of_property_read_bool(node, "fsl,pcie-phy-refclk-internal");
+
 	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx6_pcie->vpcie)) {
 		if (PTR_ERR(imx6_pcie->vpcie) == -EPROBE_DEFER)
-- 
2.23.0.rc1

