Return-Path: <linux-pci+bounces-10924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F254C93EB08
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 04:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F0E1F220C5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 02:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC57CF25;
	Mon, 29 Jul 2024 02:16:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA842B2CC;
	Mon, 29 Jul 2024 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219360; cv=none; b=MXmY2X2udvXFfHSk4wXJNDwkQPnjjCXa2TZNmrYMKZpB3pV14euDsN//wocPdDKc1OJxjQO2MSiL4lpVFQbEytTlDy1qveQDkhCFtKqUgQQThNqQa43aXvMEYKw4Cj9phH3Jc5u0DwFzCAbTrN3aLkxhFxGgWurzH7ckyuDU1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219360; c=relaxed/simple;
	bh=PBVxTpmzAj3S5x0cRCD2X+EpBUj60QIbx/qURLaqUjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TyONLbf3pks+/e3JWRdOUMVwfz+L3SWTIOrLwQMNuGrliPgECjr8etTq0Rmu+vwpwOZF8qgJDukb77tySEd6HwBSFSZJWKGoQvuQiDz3FLeIahAn3cKmICL4nWogF6twuB+sN7Tyjj26JXevAu6uMHk9W+oJHaMDFhWFwH9lQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5E032000FC;
	Mon, 29 Jul 2024 04:15:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AC0FA2000C6;
	Mon, 29 Jul 2024 04:15:56 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0AFDD183AD45;
	Mon, 29 Jul 2024 10:15:54 +0800 (+08)
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
Subject: [PATCH v4 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu" for i.MX8M PCIe Endpoint
Date: Mon, 29 Jul 2024 09:56:42 +0800
Message-Id: <1722218205-10683-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722218205-10683-1-git-send-email-hongxing.zhu@nxp.com>
References: <1722218205-10683-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.

For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the
driver. This method is not good.

In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
Frank suggests to fetch the dbi2 and atu from DT directly. This commit is
preparation to do that for i.MX8M PCIe EP.

These changes wouldn't break driver function. When "dbi2" and "atu"
properties are present, i.MX PCIe driver would fetch the according base
addresses from DT directly. If only two reg properties are provided, i.MX
PCIe driver would fall back to the old method.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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


