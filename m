Return-Path: <linux-pci+bounces-13544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41605986C7C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 08:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7204D1C22552
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 06:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4BD188A0A;
	Thu, 26 Sep 2024 06:30:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88F1925B0;
	Thu, 26 Sep 2024 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332237; cv=none; b=iJMY8pEhLHcEucsFHJHZxHcjcRpuDX0ukmbNoqPObmlJIcQMI7yV4OO9mGpGgxyRN5nyPDO6+tUiILG+U5Z1ibJ3K0VENNpgdLMKTGa+Ma2yqpKibrP6JFDGJgyQcH6DUvhDo9pze6RiOyi+qlR7hxAJql18etHk4tbOU1FYReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332237; c=relaxed/simple;
	bh=4STIZlG5644NEpm8w1LIHNSX8bw4B3sgniWEiwXw4s4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=stN9PTbygrUSh3fWqwpV34un/uxt4dKcReG43mBd6t1d6weLdkQ/z/BLICcKfEOANdw7DoGinPpo8q3t3Oft9bMWDxj2e+DYBPJELl3ywNPw0AqSHO9k6qKcbx47riOP6Q0eWEsz+WSLxvXeDhlMggTXGGA3LhPeSLJJYBPR6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A2C7D1A2405;
	Thu, 26 Sep 2024 08:30:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 69EBB1A0F99;
	Thu, 26 Sep 2024 08:30:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F242B183F0C7;
	Thu, 26 Sep 2024 14:30:30 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 4/9] PCI: imx6: Correct controller_id generation logic for i.MX7D
Date: Thu, 26 Sep 2024 14:07:48 +0800
Message-Id: <1727330873-17486-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727330873-17486-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727330873-17486-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

i.MX7D only has one PCIe controller, so controller_id should always be 0.
The previous code is incorrect although yielding the correct result. Fix by
removing IMX7D from the switch case branch.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e8e401729893..d49154dbb1bd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1338,7 +1338,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx_pcie->controller_id = 1;
 		break;
-- 
2.37.1


