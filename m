Return-Path: <linux-pci+bounces-13542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13A986C76
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 08:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102651F22F0D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 06:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521CC18BC11;
	Thu, 26 Sep 2024 06:30:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC5183CD6;
	Thu, 26 Sep 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332232; cv=none; b=cFijJX3lUkj7KN3nl6+BGTzIyLW8SFtzBkeEkXD4p5x4lXbZJIwhuBBHTUkOSN2b5lSvPPG6t0qP4Mf7Rb1xlZmSWUBH8E9l1xIrQeiVFC2Wt06k//NSWeUeFikmNe8LOIJSWB8AyHA0QHqeSdh6Oh4XA1skb3HWIdGQscpMYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332232; c=relaxed/simple;
	bh=2gAqmh13lRW4gCtbiZjmbuICVYnRu9n3yfY1dlQqNOU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PUjsmzb4zB0TM2khJGbCKcGI5RnZj/vOTigv33/zJwv6oZiiTXnn4Y8qbS1iAl1Ol5Hh5wyQT8rt96l9SWmeznR+6ByhdWpwzRwR4jclBBH/dvLV4vvsiT46EkPBEx/LW+wKUnaP1A/quvMUi8cs+cDVyrRS/H0G1URdq79WuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 47021200FF5;
	Thu, 26 Sep 2024 08:30:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1717020184C;
	Thu, 26 Sep 2024 08:30:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DFF15183F0C0;
	Thu, 26 Sep 2024 14:30:18 +0800 (+08)
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
	imx@lists.linux.dev
Subject: [PATCH v3 0/9] A bunch of changes to refine i.MX PCIe driver
Date: Thu, 26 Sep 2024 14:07:44 +0800
Message-Id: <1727330873-17486-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

A bunch of changes to refine i.MX PCIe driver.
- Add ref clock gate for i.MX95 PCIe by #1, #2 and #9 patches.
  The changes of clock part is here [1].
  [1] https://patchwork.kernel.org/project/linux-arm-kernel/cover/1725525535-22924-1-git-send-email-hongxing.zhu@nxp.com/
- #3 and #4 patches clean i.MX PCIe driver by removing useless codes.
  Patch #3 depends on [2].
  [2] https://patchwork.kernel.org/project/linux-arm-kernel/cover/1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com/
- Make core reset and enable_ref_clk symmetric for i.MX PCIe driver by
  #5 and #6 patches.
- Use dwc common suspend resume method, and enable i.MX8MQ, i.MX8Q and
  i.MX95 PCIe PM supports by #7 and #8 patches.

v3 changes:
- Update EP binding refer to comments provided by Krzysztof Kozlowski.
  Thanks.

v2 changes:
- Add the reasons why one more clock is added for i.MX95 PCIe in patch #1.
- Add the "Reviewed-by: Frank Li <Frank.Li@nxp.com>" into patch #2, #4, #5,
  #6, #8 and #9.

[PATCH v3 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95 PCIe
[PATCH v3 2/9] PCI: imx6: Add ref clock for i.MX95 PCIe
[PATCH v3 3/9] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
[PATCH v3 4/9] PCI: imx6: Correct controller_id generation logic for
[PATCH v3 5/9] PCI: imx6: Make core reset assertion deassertion
[PATCH v3 6/9] PCI: imx6: Make *_enable_ref_clk() function symmetric
[PATCH v3 7/9] PCI: imx6: Use dwc common suspend resume method
[PATCH v3 8/9] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM
[PATCH v3 9/9] arm64: dts: imx95: Add ref clock for i.MX95 PCIe

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |   4 +-
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     |   1 +
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        |  25 ++++++++++--
arch/arm64/boot/dts/freescale/imx95.dtsi                         |  25 ++++++++++--
drivers/pci/controller/dwc/pci-imx6.c                            | 166 +++++++++++++++++++++++++++-------------------------------------------------
5 files changed, 104 insertions(+), 117 deletions(-)


