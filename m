Return-Path: <linux-pci+bounces-10693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85093AB8B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 05:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8F91F234FF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 03:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8102421D;
	Wed, 24 Jul 2024 03:23:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D21CD02;
	Wed, 24 Jul 2024 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721791391; cv=none; b=ZPqOMOENsA5BSBWQH1zZFfGoogi7VRI0nHFeVEd7OE6lWooZl6yaeP2aORfZuFFAOWd8uowV1XhHR7zWGfuqCAxE8Wd+tDmnZnTR0Gec+8Llit2LAPsaoGV83Y81rWKW6SQY6DXoR/d/8PuJsy/yMTwCGn2p4UzqdiWp4QJiNwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721791391; c=relaxed/simple;
	bh=2sMvJ/rquvooy4tQZd6f1YW85ty2/iFjF/11zJ6Fzh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o0QOpJ2wBYIre8DvW/KVkb86ASCu0zYUof5h+1LIfaA8ETibDTouY5qQYuO3+OpWMP61hzo1Z2prne3tmIAGlZ6tbE/Qt8aQvPHXupE73q97lW9RJ5YdfpxrB6TqofuBVD5j9cSLLX4FmPiG+zD+qEyVhtDjMU6i9L7La+IbjKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EBEF12015B3;
	Wed, 24 Jul 2024 05:23:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B3B732015AF;
	Wed, 24 Jul 2024 05:23:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 63A99183AD0A;
	Wed, 24 Jul 2024 11:23:01 +0800 (+08)
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
Subject: [PATCH v2 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for i.MX8MQ PCIe EP
Date: Wed, 24 Jul 2024 11:03:54 +0800
Message-Id: <1721790236-3966-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add dbi2 and iatu reg for i.MX8MQ PCIe EP.

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


