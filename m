Return-Path: <linux-pci+bounces-10588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8F938AF1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 10:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853C41C21288
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126316B392;
	Mon, 22 Jul 2024 08:15:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776616A938;
	Mon, 22 Jul 2024 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636119; cv=none; b=LzEARyMDDg2/kNzzVIuH7oKApsnGQvKV5xMZD3zjv2aljcmvKYWluguwYWOK3Bm1401kJc8bxH+iCv80kx9qk9suXor0BrMD8DJ+ypHdr13MJKQnz5ZJKNgnRdm1914dJlO8EkIcIzPnUMrOs4BdtmK8a2vaA7IMvHApX3pVElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636119; c=relaxed/simple;
	bh=BRLJbVEXZJorCdDDQTkBVUxc0oE6nNb+WbBIWC9yixU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FYGfpYLzMXbfZPfisbpU0+st7QZwXJTw7mXOqtHXzJAmGnD46rN0+pLPEFmUszoQNAoRc0t33m+TpZoES7LLgpkPRxK/8xYns9a09PP/OfoJmiaDKxZcI8OL78aVsHsl7wdKxCykF77bUXuCKhA2XJG+CJjKviweBh0UYCAcIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A3671A1542;
	Mon, 22 Jul 2024 10:15:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B4741A0DD7;
	Mon, 22 Jul 2024 10:15:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6FA63183ACAF;
	Mon, 22 Jul 2024 16:15:08 +0800 (+08)
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
Subject: [PATCH v1 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for i.MX8MQ PCIe EP
Date: Mon, 22 Jul 2024 15:56:17 +0800
Message-Id: <1721634979-1726-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
References: <1721634979-1726-1-git-send-email-hongxing.zhu@nxp.com>
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
index e03186bbc415..4f0fe69ef601 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1819,9 +1819,11 @@ pcie1: pcie@33c00000 {
 
 		pcie1_ep: pcie-ep@33c00000 {
 			compatible = "fsl,imx8mq-pcie-ep";
-			reg = <0x33c00000 0x000400000>,
-			      <0x20000000 0x08000000>;
-			reg-names = "dbi", "addr_space";
+			reg = <0x33c00000 0x100000>,
+			      <0x33d00000 0x100000>,
+			      <0x33f00000 0x100000>,
+			      <0x20000000 0x8000000>;
+			reg-names = "dbi", "dbi2", "atu", "addr_space";
 			num-lanes = <1>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dma";
-- 
2.37.1


