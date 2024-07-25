Return-Path: <linux-pci+bounces-10771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BDF93BD90
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B921C21950
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F412172BB2;
	Thu, 25 Jul 2024 08:02:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7B5249ED;
	Thu, 25 Jul 2024 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894579; cv=none; b=pQaso44lTVQoquZbqbppvvllBX2ll4LDAUtz0aO6+zJlHgIrQkEh4sfSmq2swnrtb76nySQN1X1PmDE0ktiYYmecYno1XMWZrZ1TNIKwNlQ4vnUgqBhzMMzLmk+dEXa0sW6bemqoKKJpbTBK3exP/Z9bIPnbjR/cPRrtIkonwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894579; c=relaxed/simple;
	bh=Zq8CvVuEgjr1iz5I/ExTd2Yb2Q/SmusCVEoA9fDZH1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jIppdq4SqSKy+1WQ7dL+jMZW4MAGtNWEIP6R7sLg6OGNRLgaVobumXqXjOcUHE1Skq3oMG8NQA2qKtTzA8EpXnDBaSLB88E1KwAFXMB9kw/eNKh9d+97kBpiABHJA1wylkY7BJRb7SwP3S4rhhWLAgbQ8GE4HUwWOyQ6zVTYDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C9752004DC;
	Thu, 25 Jul 2024 09:54:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 445EF2004FE;
	Thu, 25 Jul 2024 09:54:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A3C8A1802183;
	Thu, 25 Jul 2024 15:54:16 +0800 (+08)
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
Subject: [PATCH v3 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for i.MX8MQ PCIe EP
Date: Thu, 25 Jul 2024 15:35:14 +0800
Message-Id: <1721892916-5782-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add dbi2 and iatu reg for i.MX8MQ PCIe EP.

For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the driver.
This method is not good.

In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
Frank suggests to fetch the dbi2 and atu from DT directly.
This commit is preparation to do that for i.MX8MQ PCIe EP.

These changes wouldn't break driver function.
When "dbi2" and "atu" properties are present, i.MX PCIe driver would
fetch the according base address from DT directly.
If only two reg properties are provided, i.MX PCIe driver would falls
back to the old method.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
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


