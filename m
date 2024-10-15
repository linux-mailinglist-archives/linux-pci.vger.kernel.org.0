Return-Path: <linux-pci+bounces-14520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE699E1C5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AAFB21E1E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7821CC8B9;
	Tue, 15 Oct 2024 08:57:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63241C3F0A;
	Tue, 15 Oct 2024 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982646; cv=none; b=rdFVERkSn4oVMyWGeDq5Nypc8K1sqwRl6VIRj6HR495TTJHkHd6dRTYgfO09QYgppfPPB+Y/AJwd6s3I3FtT1Sf3UV6hJxpir88WVDIGMuGnyr4RTlPwXzXoh0P2CGflo9dhA++B+l44Z7YeBdwbwMWxbjs8nO/Nfj7B0wq7tqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982646; c=relaxed/simple;
	bh=U6yQ/f3Naq0OsRV96BmYWiqs7sstzCIDACQi/JYJ5nY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=boZHF6KREYEZZVQkcqh5+UlTU0JfpZtDkobISdLyy0+YzQrHcQK82sg9jwoCNYYEyCN+0qXubcqDfWBJPvr2FyE48dTz4pOJuLbCpIFWmYFP+r7BZWGPm3C5zYcFTAIEERGH3/WSXFrtm/hUCWzBMDOeQo4tlzatZrDDlzbsM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56AFA200CA9;
	Tue, 15 Oct 2024 10:57:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1AC7E2004C4;
	Tue, 15 Oct 2024 10:57:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DF572183DC04;
	Tue, 15 Oct 2024 16:57:19 +0800 (+08)
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
Subject: [PATCH v4 0/9] A bunch of changes to refine i.MX PCIe driver
Date: Tue, 15 Oct 2024 16:33:24 +0800
Message-Id: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

A bunch of changes to refine i.MX PCIe driver.
- Add ref clock gate for i.MX95 PCIe by #1, #2 and #9 patches.
  The changes of clock part are here [1].
  [1] https://lkml.org/lkml/2024/10/15/390
- #3 and #4 patches clean i.MX PCIe driver by removing useless codes.
  Patch #3 depends on dts changes. And the dts changes had been applied
  by Shawn, there is no dependecy now.
- Make core reset and enable_ref_clk symmetric for i.MX PCIe driver by
  #5 and #6 patches.
- Use dwc common suspend resume method, and enable i.MX8MQ, i.MX8Q and
  i.MX95 PCIe PM supports by #7 and #8 patches.

v4 changes:
It's my fault that I missing Manivanna in the reviewer list.
I'm sorry about that.
- Rebase to v6.12-rc3, and resolve the dtsi conflictions.
  Add Manivanna into reviewer list.

v3 changes:
- Update EP binding refer to comments provided by Krzysztof Kozlowski.
  Thanks.

v2 changes:
- Add the reasons why one more clock is added for i.MX95 PCIe in patch #1.
- Add the "Reviewed-by: Frank Li <Frank.Li@nxp.com>" into patch #2, #4, #5,
  #6, #8 and #9.

[PATCH v4 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95 PCIe
[PATCH v4 2/9] PCI: imx6: Add ref clock for i.MX95 PCIe
[PATCH v4 3/9] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
[PATCH v4 4/9] PCI: imx6: Correct controller_id generation logic for
[PATCH v4 5/9] PCI: imx6: Make core reset assertion deassertion
[PATCH v4 6/9] PCI: imx6: Make *_enable_ref_clk() function symmetric
[PATCH v4 7/9] PCI: imx6: Use dwc common suspend resume method
[PATCH v4 8/9] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM
[PATCH v4 9/9] arm64: dts: imx95: Add ref clock for i.MX95 PCIe

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |   4 +-
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     |   1 +
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        |  25 ++++++++++--
arch/arm64/boot/dts/freescale/imx95.dtsi                         |  18 +++++++--
drivers/pci/controller/dwc/pci-imx6.c                            | 166 +++++++++++++++++++++++++++-------------------------------------------------
5 files changed, 97 insertions(+), 117 deletions(-)


