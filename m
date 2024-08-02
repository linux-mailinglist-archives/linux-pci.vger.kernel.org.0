Return-Path: <linux-pci+bounces-11168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BC5945859
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 09:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E8A1C2349D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963C9158DD1;
	Fri,  2 Aug 2024 07:06:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C00158A34;
	Fri,  2 Aug 2024 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582391; cv=none; b=lnmigrZkV5EhB3q2piio3AQcOdzHbXs+brKvBlG7XxX3qS9JTSFwgIX88KOF6odQsB41kUP/zfy7FixhY8ivzTCi43LSCYfyg0pIxvrem1thQ7drqthShE2G1LW673YpgKJXeplZgKLSijMPAimR9hMhAFc5EnpCGDISHqhsOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582391; c=relaxed/simple;
	bh=t2HQr/cBW2RHqnOVkDYLX8+mp86lC2Te7TZPBSGrLBU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pO4qZQ080A5JQtrPgy0hDHaDBkAI7KGkklh7PkS6tFCK9bli7rMYkb09orUFQtM8qx+LF5KPKdcI36toSB6Rnlt8ADI8fPsrP2NHBQyDUoXGSJF2YN7EzQ0lA68CpN3Zo78+YUC2tIg/mud/83XRbMD4l8uVLAkgTfSvX6b50ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A0A61A1F3F;
	Fri,  2 Aug 2024 09:06:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B68E1A1F36;
	Fri,  2 Aug 2024 09:06:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8A269181D0FC;
	Fri,  2 Aug 2024 15:06:20 +0800 (+08)
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
Subject: [PATCH v5 0/5] Refine i.MX8QM SATA based on generic PHY callbacks
Date: Fri,  2 Aug 2024 14:46:48 +0800
Message-Id: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

V5 main changes:
Thanks for Niklas' kind help.
- Drop 32bit DMA limit commit, since the "dma-ranges" of DT can overcome
  this limitation.

V4 main changes:
Thanks for Niklas' comments.
- Update the commit message in #2 patch of v4.
- Split the clean up unrelated codes to #3 and #4 of v4.
- Remove the Cc: stable@vger.kernel.org and Fixes tag in #5 of v4.

V3 main changes:
- Use GENMASK() macro to define the _MASK.
- Refine the macro names.

V2 main changes:
- Add Rob's reviewed-by in the binding patch.
- Re-name the error out lables and new RXWM macro more descriptive.
- In #3 patch, add one fix tag, and CC stable kernel.

Based on i.MX8QM HSIO PHY driver, refine i.MX8QM SATA driver by using PHY
interface.

[PATCH v5 1/5] dt-bindings: ata: Add i.MX8QM AHCI compatible string
[PATCH v5 2/5] ata: ahci_imx: Clean up code by using i.MX8Q HSIO PHY
[PATCH v5 3/5] ata: ahci_imx: AHB clock rate setting is not required
[PATCH v5 4/5] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
[PATCH v5 5/5] ata: ahci_imx: Correct the email address

Documentation/devicetree/bindings/ata/imx-sata.yaml |  47 +++++++++++
drivers/ata/ahci_imx.c                              | 403 +++++++++++++++++++++++------------------------------------------------------------------
2 files changed, 152 insertions(+), 298 deletions(-)


