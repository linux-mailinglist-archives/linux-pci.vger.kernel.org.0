Return-Path: <linux-pci+bounces-10590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD38938AF6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 10:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62A7281D73
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE016B3AE;
	Mon, 22 Jul 2024 08:15:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EBE16B3B5;
	Mon, 22 Jul 2024 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636121; cv=none; b=ax7yth24jHZSIHJlDoWbHJO2ksJe/4n3ow81mNIyqp4T19cRhLQAuR19KpQgpOGWzIr6pL8u9MINP7PiB16oiQJDCMA/y6HhKwOL7CQbdjfbBNieisGcA1CTtahpAqhFIiHQ2FSedtZdPE2WkSqCo8QUB8kH/81PXHNp1oE5DQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636121; c=relaxed/simple;
	bh=ukiJjPLR/NrVfBw6h78irshZGt6fkuKfVSdr7iZ7tyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E36MOsKkmgEWYZG2WYEDJ/95gWXFtuGwPNld7fcRLEgPB1Ru+5Nn7tvBVYmknnlz7TgwJulhUqRRWct4uw8GdJGkkfiTYNR+aSQ6cPYxzWbMzX+FsuiKtL5Fdc3SYkSNBaKmZf9CrjE9PoTfjKpjcJIpbU3hlke3qFp7psR386I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D0CEA1A1976;
	Mon, 22 Jul 2024 10:15:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BB701A193F;
	Mon, 22 Jul 2024 10:15:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D1F7A180222B;
	Mon, 22 Jul 2024 16:15:10 +0800 (+08)
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
Subject: [PATCH v1 4/4] dts: arm64: imx8mm: Add dbi2 and atu reg for i.MX8MM PCIe EP
Date: Mon, 22 Jul 2024 15:56:19 +0800
Message-Id: <1721634979-1726-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add dbi2 and iatu reg for i.MX8MM PCIe EP.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 9535dedcef59..78462b591d29 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1375,9 +1375,11 @@ pcie0: pcie@33800000 {
 
 		pcie0_ep: pcie-ep@33800000 {
 			compatible = "fsl,imx8mm-pcie-ep";
-			reg = <0x33800000 0x400000>,
+			reg = <0x33800000 0x100000>,
+			      <0x33900000 0x100000>,
+			      <0x33b00000 0x100000>,
 			      <0x18000000 0x8000000>;
-			reg-names = "dbi", "addr_space";
+			reg-names = "dbi", "dbi2", "atu", "addr_space";
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dma";
-- 
2.37.1


