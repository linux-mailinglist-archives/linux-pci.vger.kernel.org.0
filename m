Return-Path: <linux-pci+bounces-11620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E947E94FF4B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 10:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EBA285C91
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6517084F;
	Tue, 13 Aug 2024 08:02:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0C13D50E;
	Tue, 13 Aug 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536155; cv=none; b=OLUO9yRoU2ExCmSV8YaEt9osR5cOMu40DfB4HeV2nYEfHnFAUM7auK/HJO+AE/gy1QyjVanKXlGRY/gw2qjDSj2RTWBljxYsVMB9Jy9z8xOO2oHFyfsPkJIEBnc/TsnRkaeNZpJXF/OOC8IfB2guxh8rCHMBnNhhauaC8EmBL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536155; c=relaxed/simple;
	bh=+pROoBrurakCGvGD6Blb+j4X0fhL0kJk1RxtcHF2TWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sfM/T8++H0o9ZKJLLe0xbTtlx9y7l/sqMdjHvSag+tmKI+YzbwGFQn5X55YtJRo9jk83MJsStzeCNNK0AaXO8/QwYNwblmQC+AmMn5zDNQjyOYWKeQMp7deKZc7gS1y+8Q9lKtWTfYeR5yXD7z1WMkg1xTsOA01RTlsAQiDNYtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8680B1A11AF;
	Tue, 13 Aug 2024 10:02:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F48A1A11BD;
	Tue, 13 Aug 2024 10:02:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 18113181D0FD;
	Tue, 13 Aug 2024 16:02:26 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	l.stach@pengutronix.de
Cc: hongxing.zhu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v5 4/4] arm64: dts: imx8mm: Add dbi2 and atu reg for i.MX8MM PCIe EP
Date: Tue, 13 Aug 2024 15:42:23 +0800
Message-Id: <1723534943-28499-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add dbi2 and iatu reg for i.MX8MM PCIe EP.

For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the
driver. This method is not good.

In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
Frank suggests to fetch the dbi2 and atu from DT directly. This commit is
preparation to do that for i.MX8MM PCIe EP.

These changes wouldn't break driver function. When "dbi2" and "atu"
properties are present, i.MX PCIe driver would fetch the according base
addresses from DT directly. If only two reg properties are provided, i.MX
PCIe driver would fall back to the old method.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 9535dedcef59..4de3bf22902b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1375,9 +1375,11 @@ pcie0: pcie@33800000 {
 
 		pcie0_ep: pcie-ep@33800000 {
 			compatible = "fsl,imx8mm-pcie-ep";
-			reg = <0x33800000 0x400000>,
-			      <0x18000000 0x8000000>;
-			reg-names = "dbi", "addr_space";
+			reg = <0x33800000 0x100000>,
+			      <0x18000000 0x8000000>,
+			      <0x33900000 0x100000>,
+			      <0x33b00000 0x100000>;
+			reg-names = "dbi", "addr_space", "dbi2", "atu";
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dma";
-- 
2.37.1


