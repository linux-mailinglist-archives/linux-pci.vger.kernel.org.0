Return-Path: <linux-pci+bounces-10589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B74938AF3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 10:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1C5281B8E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533B716B720;
	Mon, 22 Jul 2024 08:15:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8CA16A956;
	Mon, 22 Jul 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636120; cv=none; b=s4RBF43EFIFnGBpX4LK3J00p/3WQ+anP54rpWiwDRGcCGR8iA0OR3AJ375f6rqBponLieKVw1dQK0ow3MAOqUCzM9C6iCPajQiYj3gtjO2CO30ePayQ9buMaKtYCIcY9r32JNKhe12klk5S12qYbmUMeXP9xZAmFHxfSeHwre2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636120; c=relaxed/simple;
	bh=ce6yhSwGyi+YlPw1Y9XLkYb1ijSqyofyg1GG/2pFfzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KH44SqbHHvtDhfhmn61h6IO8sRkSl7JzV0QBN07fAcp1EWvR5Y53aGvpA47aGoGw3Ww/LgnSqVbC0OdLCuRNCdDt7r8ZERjH3QMxTveqVLIGi9RkPh+85kRfY7rbZeODifUBH4gY/iCCXyfxIAxhBpWqn9UCFEHFgr0OxK283eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 854191A194A;
	Mon, 22 Jul 2024 10:15:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E4E21A0DDC;
	Mon, 22 Jul 2024 10:15:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9E65A183AD09;
	Mon, 22 Jul 2024 16:15:09 +0800 (+08)
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
Subject: [PATCH v1 3/4] dts: arm64: imx8mp: Add dbi2 and atu reg for i.MX8MP PCIe EP
Date: Mon, 22 Jul 2024 15:56:18 +0800
Message-Id: <1721634979-1726-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
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
index 603dfe80216f..062bb4a107f2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2125,8 +2125,11 @@ pcie: pcie@33800000 {
 
 		pcie_ep: pcie-ep@33800000 {
 			compatible = "fsl,imx8mp-pcie-ep";
-			reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
-			reg-names = "dbi", "addr_space";
+			reg = <0x33800000 0x100000>,
+			      <0x33900000 0x100000>,
+			      <0x33b00000 0x100000>,
+			      <0x18000000 0x8000000>;
+			reg-names = "dbi", "dbi2", "atu", "addr_space";
 			clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
 				 <&clk IMX8MP_CLK_HSIO_AXI>,
 				 <&clk IMX8MP_CLK_PCIE_ROOT>;
-- 
2.37.1


