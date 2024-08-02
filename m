Return-Path: <linux-pci+bounces-11170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBBE94585F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 09:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F4B1F22292
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF6E15E5B8;
	Fri,  2 Aug 2024 07:06:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885E15B11E;
	Fri,  2 Aug 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582393; cv=none; b=Rac88OtVukypT5zOOZ8EOdGG2dSYp0QLpcS3lIFSxASrlLR212dfwujFjCgAr4EdAxAG8XiV61ca1XySIToIReyURbWkVedZ/w4aelu04pFLohQ6QYnuxwhPm99F1gMjp8gPV5OFckT6kLLXF4tXtBwxMZi3GUfQd3JVIj2I/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582393; c=relaxed/simple;
	bh=Gr8+mXeLuBDi0OdSSafQ/DqKDAA6GesSAzY60FVEdLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=S+tioS5sXvQc8yBNT7MQF4NMj/ObEypabcG97o9Esh6HTmmfRHOCH7RTrLZ7Ur73nBDlqF74LErvUzhLMroQAe+x1feQ0+k06jITfDiCaGK5Im1ekjPaKPAP7kSMeVpxqz4qzMqWFEnM69vc1+XanIEuzgIpNIhOYcJctio3eZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EAF1120156A;
	Fri,  2 Aug 2024 09:06:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B0E1A20108D;
	Fri,  2 Aug 2024 09:06:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2B49B181D0FC;
	Fri,  2 Aug 2024 15:06:27 +0800 (+08)
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
Subject: [PATCH v5 4/5] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
Date: Fri,  2 Aug 2024 14:46:52 +0800
Message-Id: <1722581213-15221-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The RXWM(RxWaterMark) sets the minimum number of free location within
the RX FIFO before the watermark is exceeded which in turn will cause
the Transport Layer to instruct the Link Layer to transmit HOLDS to
the transmitting end.

Based on the default RXWM value 0x20, RX FIFO overflow might be
observed on i.MX8QM MEK board, when some Gen3 SATA disks are used.

The FIFO overflow will result in CRC error, internal error and protocol
error, then the SATA link is not stable anymore.

To fix this issue, enlarge RX water mark setting from 0x20 to 0x29.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 4dd98368f8562..627b36cc4b5c1 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -45,6 +45,10 @@ enum {
 	/* Clock Reset Register */
 	IMX_CLOCK_RESET				= 0x7f3f,
 	IMX_CLOCK_RESET_RESET			= 1 << 0,
+	/* IMX8QM SATA specific control registers */
+	IMX8QM_SATA_AHCI_PTC			= 0xc8,
+	IMX8QM_SATA_AHCI_PTC_RXWM_MASK		= GENMASK(6, 0),
+	IMX8QM_SATA_AHCI_PTC_RXWM		= 0x29,
 };
 
 enum ahci_imx_type {
@@ -466,6 +470,12 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 	phy_power_off(imxpriv->cali_phy0);
 	phy_exit(imxpriv->cali_phy0);
 
+	/* RxWaterMark setting */
+	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
+	val &= ~IMX8QM_SATA_AHCI_PTC_RXWM_MASK;
+	val |= IMX8QM_SATA_AHCI_PTC_RXWM;
+	writel(val, hpriv->mmio + IMX8QM_SATA_AHCI_PTC);
+
 	return 0;
 
 err_sata_phy_exit:
-- 
2.37.1


