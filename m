Return-Path: <linux-pci+bounces-11618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7694FF44
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 10:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A382855F7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26D13C3DD;
	Tue, 13 Aug 2024 08:02:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491EB136E28;
	Tue, 13 Aug 2024 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536153; cv=none; b=rQEOyLuh0eS80sSaboKnLkEGrFjhxs888EB8LQb76RNfDN3WDGK1nhUEKvzLBIV19eFgKQBAD7Zs/k0YR2lL3ZN1j2usBc+pb72FDUXobdLzevUeeGOwy/3ZGWGAGc59H/EgaDzjwBa2im4vZSS29fP04KTz3ChXxpgpAiHQpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536153; c=relaxed/simple;
	bh=ZFVhHkPTDo6FoZoGON2cwcym53yrgu8xxzROJaE3ohw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eKfSR9m4NkQXusbxwyX8xoMOi479cyuqN7qYJMIxO7emP9CPICiWOLSMojhQBz3yzP9Dj6tphb7Leenm6YmJJ2hTOm92lqEcLgCwQyISIdVXWDbKvtjTLm5WLrKt5nS/QLOPmOV7GAjJCAKyVi0mrT4lCvZp6ubL+95AE9HA7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D1041A118C;
	Tue, 13 Aug 2024 10:02:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 15A8F1A1179;
	Tue, 13 Aug 2024 10:02:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D1022181D0FD;
	Tue, 13 Aug 2024 16:02:23 +0800 (+08)
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
Subject: [PATCH v5 2/4] arm64: dts: imx8mq: Add dbi2 and atu reg for i.MX8MQ PCIe EP
Date: Tue, 13 Aug 2024 15:42:21 +0800
Message-Id: <1723534943-28499-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add dbi2 and iatu reg for i.MX8MQ PCIe EP.

For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the
driver. This method is not good.

In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
Frank suggests to fetch the dbi2 and atu from DT directly. This commit is
preparation to do that for i.MX8MQ PCIe EP.

These changes wouldn't break driver function. When "dbi2" and "atu"
properties are present, i.MX PCIe driver would fetch the according base
addresses from DT directly. If only two reg properties are provided, i.MX
PCIe driver would fall back to the old method.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index e03186bbc415..d51de8d899b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1819,9 +1819,11 @@ pcie1: pcie@33c00000 {
 
 		pcie1_ep: pcie-ep@33c00000 {
 			compatible = "fsl,imx8mq-pcie-ep";
-			reg = <0x33c00000 0x000400000>,
-			      <0x20000000 0x08000000>;
-			reg-names = "dbi", "addr_space";
+			reg = <0x33c00000 0x100000>,
+			      <0x20000000 0x8000000>,
+			      <0x33d00000 0x100000>,
+			      <0x33f00000 0x100000>;
+			reg-names = "dbi", "addr_space", "dbi2", "atu";
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dma";
-- 
2.37.1


