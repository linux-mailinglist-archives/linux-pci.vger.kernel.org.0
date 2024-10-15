Return-Path: <linux-pci+bounces-14525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D086499E1D7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47976B22A66
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE661E2031;
	Tue, 15 Oct 2024 08:57:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311D1DAC99;
	Tue, 15 Oct 2024 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982653; cv=none; b=d7dijBq/WItUK5uOeWBJ3qBS+2hlT8m91NH8y81RnCMWHX2YgoEiJGVIpp9GLGtuf5OXjttuh58E6x2dKyRLEv1WeJ+Hz1Wm3uZVY04Lebb6YpvbQFpt0EdntMLe5pqNW2yH6NXiUOswjYSff6xc4oI6jxnGSDBDz1SjblAZgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982653; c=relaxed/simple;
	bh=7VZJSuePNOPn8PDbqMWCosD+PdcIwECdxkpE18fNKAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lmHcZ88r/vLCRFsWgZHA+1RRo8sfrIqlIBTsbkbMqYXvYkdIzYNgIB62D97gsrcgI+BqYsCOInFEvuTlTX2Zd+m5dU99j80+bKIDTqGqEsoe9XqqZ3N46dr+D2Qzjl+BMV75/8IP0zJ+WnHoLsqyKVMXycEAYnGcGp5ADV2bIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B459A201677;
	Tue, 15 Oct 2024 10:57:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 47A15201685;
	Tue, 15 Oct 2024 10:57:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 16DB9183DC05;
	Tue, 15 Oct 2024 16:57:28 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: hongxing.zhu@nxp.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v4 5/9] PCI: imx6: Make core reset assertion deassertion symmetric
Date: Tue, 15 Oct 2024 16:33:29 +0800
Message-Id: <1728981213-8771-6-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add apps_reset deassertion in the imx_pcie_deassert_core_reset(). Let it be
symmetric with imx_pcie_assert_core_reset().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ca8714c625fe..93e2bcf9aa0a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -770,6 +770,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
+	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
-- 
2.37.1


