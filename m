Return-Path: <linux-pci+bounces-10695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D619193AB90
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 05:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E96B22832
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3E45C0B;
	Wed, 24 Jul 2024 03:23:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C051219E0;
	Wed, 24 Jul 2024 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721791392; cv=none; b=bJDtrHjjD+XeP3GYYzWJtieqBno0w+qmyu3gHzxQ8ouLrH1Gl6SeJlGrzHqYKbb5xK4vubF6Mm3yP4CDZPnESAs6AetueS11Qo2tnfkXoAPH0FxjJnozSJrEqh1PkY4eo/IwVNxyG4aTRzbvAFqBU60cP+N3CbvGKgw8Pw24Aho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721791392; c=relaxed/simple;
	bh=j6DklxvMiZ03ypcAwb2yigI/pK16P4qHCy0dqWCQayo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fdhrhDcYquXG4whCJ6YI/9WYvdfoR2f1ncnp6626pCZvEuIbUkJkThbygU7N/Vmghb4GLwweUG9ZobdWU6yX64vgn43pGY+RVYcq87lHJDNacfYio7GcCGNN1nt4c0HUpGY4r1M4ORtn6EJmk0868OZEjuWT8jBk8+BN+dXeC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 866DB2012A2;
	Wed, 24 Jul 2024 05:23:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E2E92015AF;
	Wed, 24 Jul 2024 05:23:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 94C8D183ACAC;
	Wed, 24 Jul 2024 11:23:02 +0800 (+08)
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
Subject: [PATCH v2 3/4] dts: arm64: imx8mp: Add dbi2 and atu reg for i.MX8MP PCIe EP
Date: Wed, 24 Jul 2024 11:03:55 +0800
Message-Id: <1721790236-3966-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add dbi2 and iatu reg for i.MX8MP PCIe EP.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 603dfe80216f..53748227db10 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2125,8 +2125,11 @@ pcie: pcie@33800000 {
 
 		pcie_ep: pcie-ep@33800000 {
 			compatible = "fsl,imx8mp-pcie-ep";
-			reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
-			reg-names = "dbi", "addr_space";
+			reg = <0x33800000 0x100000>,
+			      <0x18000000 0x8000000>,
+			      <0x33900000 0x100000>,
+			      <0x33b00000 0x100000>;
+			reg-names = "dbi", "addr_space", "dbi2", "atu";
 			clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
 				 <&clk IMX8MP_CLK_HSIO_AXI>,
 				 <&clk IMX8MP_CLK_PCIE_ROOT>;
-- 
2.37.1


