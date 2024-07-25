Return-Path: <linux-pci+bounces-10773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BD693BD97
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CC4283FD9
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBAF1741E3;
	Thu, 25 Jul 2024 08:03:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B314171678;
	Thu, 25 Jul 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894581; cv=none; b=FDLmmuHONBIBP8MmvwQAzrt/a4523mUKBgrCZSYJ4i2eMuvhwgIo73k0oDBpI7kHSKF2E1bM/qqi1NFQa6NeCgjpggfFOOis4PKw3TmhPRb/gxCFXMGajd6lVnVDkTDAIZcTZHdPuU/ht36eGllk3WwqmQEFonCLtj2cPDZLDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894581; c=relaxed/simple;
	bh=pJm0eGj47PP4sVSZ8RsbPyJ1rm5u/FVQfAgFSwim3pA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LW1OsdQkfSXTJf5zCIPHNudvg4Er+1f5OwvzbWz6Cia5/SU9isO4c5RSbjr6bvUAomyIU+ZEvkq1XRG18G+BYMOKnXRSE55e4hm1f7klVxdNiVAeq8Kk6AOs0hjYXNqUDkJyxh00QO+8xkw6sPGEGJgfZGPV08UX6F069Pqg6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 42C1820050F;
	Thu, 25 Jul 2024 09:54:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0912E200512;
	Thu, 25 Jul 2024 09:54:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5EEEC1802183;
	Thu, 25 Jul 2024 15:54:14 +0800 (+08)
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
Subject: [PATCH v3 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Date: Thu, 25 Jul 2024 15:35:12 +0800
Message-Id: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

v3 changes:
- Refine the commit descriptions.

v2 changes:
Thanks for Conor's comments.
- Place the new added properties at the end.

Ideally, dbi2 and atu base addresses should be fetched from DT.
Add dbi2 and atu base addresses for i.MX8M PCIe EP here.

[PATCH v3 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu"
[PATCH v3 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for i.MX8MQ
[PATCH v3 3/4] dts: arm64: imx8mp: Add dbi2 and atu reg for i.MX8MP
[PATCH v3 4/4] dts: arm64: imx8mm: Add dbi2 and atu reg for i.MX8MM

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 13 +++++++++----
arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  8 +++++---
arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  7 +++++--
arch/arm64/boot/dts/freescale/imx8mq.dtsi                    |  8 +++++---
4 files changed, 24 insertions(+), 12 deletions(-)

