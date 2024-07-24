Return-Path: <linux-pci+bounces-10694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A1A93AB8E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 05:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3EE1F22090
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917983D579;
	Wed, 24 Jul 2024 03:23:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03E1CA93;
	Wed, 24 Jul 2024 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721791392; cv=none; b=C3KftLP0oDdKkIrqQreJwcSEeyvlQD/hdksWFmLI3+raPGhweHQHerAXRXsrSs28bKGcRlHy57miFeNk+w+53kwYgZyAMRjX5M+HlQ0AhaSCuUrET/awJrzGA32LR1yszGJAq/zwORDCuqeoyee3pgHy4/gFZxdwLvDY0HKK1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721791392; c=relaxed/simple;
	bh=sPwe3n0DE7blsMI4XfasIZ57pT+RVsquDg/IhVslWPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pBGYZdRsNaP5gTMi69gj3xh8YhRaHPEwKShvh5zicEOekDWNKsXT9RB+mF7Hpa4jwZU1mMn8BZ0DqVzPUD4ry7jRJsbSiqSifVzaoSzLt1m3RqXgwpMB0BKObGAbl9pRqPEsjTB0Nz7U/eSwNcvesZzNU+rob2toO3zIUS6nYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BCA9A20129A;
	Wed, 24 Jul 2024 05:23:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8478E2015B2;
	Wed, 24 Jul 2024 05:23:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 29304183487B;
	Wed, 24 Jul 2024 11:23:00 +0800 (+08)
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
Subject: [PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu" for i.MX8M PCIe Endpoint
Date: Wed, 24 Jul 2024 11:03:53 +0800
Message-Id: <1721790236-3966-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
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


