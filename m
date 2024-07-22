Return-Path: <linux-pci+bounces-10587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD5938AED
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 10:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C01C21244
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA4716A382;
	Mon, 22 Jul 2024 08:15:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6D1684A3;
	Mon, 22 Jul 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636117; cv=none; b=Qpbu63c5RhfRgDAw3bkCMBRUfI3+uI5/41oQfACyaXk4fNOAYgU5W9qyzwNY+GI+b8o1bG9SqZOtnS/VqAYisY25TBkPTm/bbQK1cq882yC9rO7yfYtvlvUuv4ZJ1E/33mutUnZo0a19vJsnE0EuhU8YmkDArZE37gZpEmkon+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636117; c=relaxed/simple;
	bh=jYmqzkJ7WoNP/Cm7uMKwPBoSGj3e40cL8GduYgXH++s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nzEsY1pV1FmKfZqPs2XTjQQHkZsDW+L51YWz4QFK0BfxAqNT1/j815m+MGeVOBvYr35c3d9fLSZpeFrruBakuc7b1cq6QgnlpBom2LrI4P1ZXk8Hrjrrwncv70YKiNDruHc13wCALawfYDUWHHU9W7QzkuJPmdi2Obsh3GsvEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C8D81A1550;
	Mon, 22 Jul 2024 10:15:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E09671A1551;
	Mon, 22 Jul 2024 10:15:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4D9F2183AD09;
	Mon, 22 Jul 2024 16:15:07 +0800 (+08)
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
Subject: [PATCH v1 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu" for i.MX8M PCIe Endpoint
Date: Mon, 22 Jul 2024 15:56:16 +0800
Message-Id: <1721634979-1726-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index a06f75df8458..309e8953dc91 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -65,11 +65,13 @@ allOf:
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
+            - const: dbi2
+            - const: atu
             - const: addr_space
 
   - if:
@@ -129,8 +131,11 @@ examples:
 
     pcie_ep: pcie-ep@33800000 {
       compatible = "fsl,imx8mp-pcie-ep";
-      reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
-      reg-names = "dbi", "addr_space";
+      reg = <0x33800000 0x100000>,
+            <0x33900000 0x100000>,
+            <0x33b00000 0x100000>,
+            <0x18000000 0x8000000>;
+      reg-names = "dbi", "dbi2", "atu", "addr_space";
       clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
                <&clk IMX8MP_CLK_HSIO_AXI>,
                <&clk IMX8MP_CLK_PCIE_ROOT>;
-- 
2.37.1


