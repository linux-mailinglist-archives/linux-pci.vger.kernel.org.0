Return-Path: <linux-pci+bounces-10770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4B93BD65
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 09:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B8B1F21CD3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 07:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F26171E65;
	Thu, 25 Jul 2024 07:54:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06515FA72;
	Thu, 25 Jul 2024 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894060; cv=none; b=F45Mc4RrTApMGqTOmpatYTYchafMMJ4asHE3+ei+nmnQSjWMEOSsRqRN2UdIThhpUlfR/HyuiDvBd3fMiZskxmCses3/+MsWtysnPM/piirqc8sms68WDzaFmmGd8/mCO51jiYFOj88GY3+8Nscw2lnSQ7eLGCxfGEPf/17cn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894060; c=relaxed/simple;
	bh=EPdastX4Pmv8sg9UqJ3RyMbjyesT9Ro7GxDeZTVWZfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MqwblWxDIGeoEz6Nw8N4TroyTq6E1z+VrF8h6J8qqPzoEWvsQGYkaTABCuxa5aszepEsU1v8/mY2a/vNCvQmkoD1m9Qh3gre1PYed2UrzP4cttjCY89cn7FDEiEPvXP7VJplwPkJoY0id+tFdynm2fKBEG66PdSn9zS+LH1kxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 584C61A04CD;
	Thu, 25 Jul 2024 09:54:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 216011A04D6;
	Thu, 25 Jul 2024 09:54:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 860E3180222B;
	Thu, 25 Jul 2024 15:54:15 +0800 (+08)
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
Subject: [PATCH v3 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu" for i.MX8M PCIe Endpoint
Date: Thu, 25 Jul 2024 15:35:13 +0800
Message-Id: <1721892916-5782-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.

For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the driver.
This method is not good.

In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
Frank suggests to fetch the dbi2 and atu from DT directly.
This commit is preparation to do that for i.MX8M PCIe EP.

These changes wouldn't break driver function.
When "dbi2" and "atu" properties are present, i.MX PCIe driver would
fetch the according base address from DT directly.
If only two reg properties are provided, i.MX PCIe driver would falls
back to the old method.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index a06f75df8458..84ca12e8b25b 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -65,12 +65,14 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 2
-          maxItems: 2
+          minItems: 4
+          maxItems: 4
         reg-names:
           items:
             - const: dbi
             - const: addr_space
+            - const: dbi2
+            - const: atu
 
   - if:
       properties:
@@ -129,8 +131,11 @@ examples:
 
     pcie_ep: pcie-ep@33800000 {
       compatible = "fsl,imx8mp-pcie-ep";
-      reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
-      reg-names = "dbi", "addr_space";
+      reg = <0x33800000 0x100000>,
+            <0x18000000 0x8000000>,
+            <0x33900000 0x100000>,
+            <0x33b00000 0x100000>;
+      reg-names = "dbi", "addr_space", "dbi2", "atu";
       clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
                <&clk IMX8MP_CLK_HSIO_AXI>,
                <&clk IMX8MP_CLK_PCIE_ROOT>;
-- 
2.37.1


