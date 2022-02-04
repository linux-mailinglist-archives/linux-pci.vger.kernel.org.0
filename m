Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFF54A9311
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 05:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356949AbiBDEZq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 23:25:46 -0500
Received: from mx.socionext.com ([202.248.49.38]:45580 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356935AbiBDEZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 23:25:45 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Feb 2022 13:25:43 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 9ABD52006F53;
        Fri,  4 Feb 2022 13:25:43 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 4 Feb 2022 13:25:43 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id F3629C1E23;
        Fri,  4 Feb 2022 13:25:42 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 3/3] PCI: uniphier-ep: Add compatible string and SoC-dependent data for NX1 SoC
Date:   Fri,  4 Feb 2022 13:25:39 +0900
Message-Id: <1643948739-14889-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643948739-14889-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1643948739-14889-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add basic support for UniPhier NX1 SoC as non-legacy SoC. This includes
a compatible string and SoC-dependent data.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 073bdf7fcee3..6e522724f7ed 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -418,11 +418,26 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
 	},
 };
 
+static const struct uniphier_pcie_ep_soc_data uniphier_nx1_data = {
+	.is_legacy = false,
+	.features = {
+		.linkup_notifier = false,
+		.msi_capable = true,
+		.msix_capable = false,
+		.align = 1 << 12,
+		.bar_fixed_64bit = BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
+	},
+};
+
 static const struct of_device_id uniphier_pcie_ep_match[] = {
 	{
 		.compatible = "socionext,uniphier-pro5-pcie-ep",
 		.data = &uniphier_pro5_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-pcie-ep",
+		.data = &uniphier_nx1_data,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.7.4

