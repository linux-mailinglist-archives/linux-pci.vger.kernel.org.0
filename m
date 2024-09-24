Return-Path: <linux-pci+bounces-13406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6C983BEC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 05:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C988CB20ED2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 03:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544B45C1C;
	Tue, 24 Sep 2024 03:57:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54FC2E859;
	Tue, 24 Sep 2024 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727150231; cv=none; b=eoCpWV5A6y5xoPVblnUjxQw4v/tnCnOV0bPRtMSLblw51yzevnpBjW5+fNrnJqs9KKmMpaQba1B7kA+VuZEZHl8rB4Pz8cQnCHcrGDGkfsmHg3+F62V8YuZ7fHVBdAoWsBH3/YC0BkYqd/OPj3KONxci0RBnmdcQwVEgQKWSJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727150231; c=relaxed/simple;
	bh=JxVsVnqk5Gl0zqzkJU/CBt1Xr8Bc/FAKu7INTUmmAJQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UmSXjiYfvt6w62MMfXcQga5kMb95plfQ1s0hqCYLkv9pGHIyJOaAWvqnpp9huXJYsYA6T3nOEWeRhfHeib/czi8uYit4sDlpFuh4B9QGiYttWusjAVHtmHnONC2v+Q8TAZO6le2bZbcRSqpCuCFU0Vlsv7KdvShxSrODM9Unvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A1E11A02D0;
	Tue, 24 Sep 2024 05:50:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1275F1A1445;
	Tue, 24 Sep 2024 05:50:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1EBF8183DC03;
	Tue, 24 Sep 2024 11:50:19 +0800 (+08)
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
Subject: [PATCH v1 0/9] A bunch of changes to refine i.MX PCIe driver
Date: Tue, 24 Sep 2024 11:27:35 +0800
Message-Id: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
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

[PATCH v1 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95 PCIe
[PATCH v1 2/9] PCI: imx6: Add ref clock for i.MX95 PCIe
[PATCH v1 3/9] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
[PATCH v1 4/9] PCI: imx6: Correct controller_id generation logic for
[PATCH v1 5/9] PCI: imx6: Make core reset assertion deassertion
[PATCH v1 6/9] PCI: imx6: Make *_enable_ref_clk() function symmetric
[PATCH v1 7/9] PCI: imx6: Use dwc common suspend resume method
[PATCH v1 8/9] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM
[PATCH v1 9/9] arm64: dts: imx95: Add ref clock for i.MX95 PCIe

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |   4 +-
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        |  25 ++++++++++--
arch/arm64/boot/dts/freescale/imx95.dtsi                         |  25 ++++++++++--
drivers/pci/controller/dwc/pci-imx6.c                            | 166 +++++++++++++++++++++++++++-------------------------------------------------
drivers/pci/controller/dwc/pcie-designware-host.c                |  31 ++++++++-------
5 files changed, 119 insertions(+), 132 deletions(-)

