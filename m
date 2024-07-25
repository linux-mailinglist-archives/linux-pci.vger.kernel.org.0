Return-Path: <linux-pci+bounces-10772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9045893BD94
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC6AB21D11
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCA173344;
	Thu, 25 Jul 2024 08:02:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CD16F84C;
	Thu, 25 Jul 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894579; cv=none; b=n1ElQayH8KGxEMaKu94O2pi8nbvr2Ggk99VjKk5+yzaDdewIhyRlsgX7qRlu8+/7t6EWhfwXeuxgx+PQQo82fiJiPDt2/S3wz5fkU7RmvwAx/rRbp3vja5BXzVU0RsMicet3ZUKcabKo9MZ9towu2tQWO66tqWbTlEYWhuarmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894579; c=relaxed/simple;
	bh=DG2PMLrEpeKubb6dFu3Q1gHSgLKjjwKlFmQKFMY+UYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iDfJeihgyMw69OuO4QqdZ60yKcjY31hU66GFepfVRVPWNYq3DKsx4I94xm7CxOyWGjBCO5ixSunKjBfPa6IT7EtXHvawtoa88Wp32ipidnOWI3T17zUsCbfhHm9+g4aMKFzZjSivgNVemiKCw1m5RnxZcb5RbNIieqB45QrR8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BC0DC2004FE;
	Thu, 25 Jul 2024 09:54:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8357B200515;
	Thu, 25 Jul 2024 09:54:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E094A1802183;
	Thu, 25 Jul 2024 15:54:18 +0800 (+08)
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
Subject: [PATCH v3 4/4] dts: arm64: imx8mm: Add dbi2 and atu reg for i.MX8MM PCIe EP
Date: Thu, 25 Jul 2024 15:35:16 +0800
Message-Id: <1721892916-5782-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add dbi2 and iatu reg for i.MX8MM PCIe EP.

For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the driver.
This method is not good.

In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
Frank suggests to fetch the dbi2 and atu from DT directly.
This commit is preparation to do that for i.MX8MM PCIe EP.

These changes wouldn't break driver function.
When "dbi2" and "atu" properties are present, i.MX PCIe driver would
fetch the according base address from DT directly.
If only two reg properties are provided, i.MX PCIe driver would falls
back to the old method.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
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


