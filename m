Return-Path: <linux-pci+bounces-10696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3E93AB93
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 05:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505251C2237D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 03:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDF24D8D1;
	Wed, 24 Jul 2024 03:23:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9A364D6;
	Wed, 24 Jul 2024 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721791393; cv=none; b=eLj9essFV32apFFPiTKraUrdrxlcBK6aImcmkIEdApViwdm3d75K++wogy9tIeDWyUs/NIgHM7ss7NNLLItgdbMicqD2hyI2/rxCUsiRZzYDSXKhC5DnznEKGlqZUVfMCylvTTEorgHZgMmDwILbx2MaBTOA6SfUNDjRqDTODSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721791393; c=relaxed/simple;
	bh=j3Kl8Sv7VJyGs5dZGEhFIOfTiItQE8Cq1+OH1qXcJuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p3gUr2oZInBLBb8bXklNIzVd9IYzePraqlanGvC+cxxz1+wC2Dz8U7uyeFSgNVT+2ZUhIBeTyAIduB+vUaEx0SjpZCOsUjv+V0CrXno1wUfwNmLBm9vlSijSUPnVYE+jgFWnyx/ESkXq7ZiedI42CuHLP2YWuY1DDmo86/jUlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 61E762012A8;
	Wed, 24 Jul 2024 05:23:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2958620129D;
	Wed, 24 Jul 2024 05:23:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CC892180222B;
	Wed, 24 Jul 2024 11:23:03 +0800 (+08)
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
Subject: [PATCH v2 4/4] dts: arm64: imx8mm: Add dbi2 and atu reg for i.MX8MM PCIe EP
Date: Wed, 24 Jul 2024 11:03:56 +0800
Message-Id: <1721790236-3966-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add dbi2 and iatu reg for i.MX8MM PCIe EP.

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


