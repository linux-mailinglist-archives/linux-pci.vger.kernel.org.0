Return-Path: <linux-pci+bounces-22315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC493A43BB5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0660426413
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A17A266F17;
	Tue, 25 Feb 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="gKhh8mrG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WPLx5pm7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70053266B42;
	Tue, 25 Feb 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479271; cv=none; b=OmHIafLL/abqItqWWAwxSaUURFgP/aGN7whNDv4QjDxlp7f4yEz81o/yqzPQaaz0xQCHt2kNgA70t2hG5EKmLm5lZPlT8Hu8qoG/2246afPkD/pX0AI+9v9J9xySDuIrT19+9VvRnqc5Yz9CrF8NxfeeaoVW391R+TveYkNGKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479271; c=relaxed/simple;
	bh=VdfQ7Yorn3irUgZ/Yn7Cd4nOTpmLJ4Zy/sLCEEak1ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUkgAHJSme0DVpoC4bXehj9O/MB9ngbJ8wa33hSPG9dLKsnRPsk6cmD13yrwVYfBa6xcSUYxfrLrpGFpua/wmtJI6OERPH1BIIOJ/tGfe1D+z34UJVC9IggMjOVeUboKznaYpXa3HEmCwD+hm761SeOMu9NrMF1Tm3qXKCLgI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=gKhh8mrG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=WPLx5pm7 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740479269; x=1772015269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lPSg6DYIbo5is+m87av+3FLHT15AQqV2IPDzqZE96f0=;
  b=gKhh8mrGUlxnhqIWtu5A4NRxHssRW8W4a8+oWlg4DsoK/x/EpaDs5F1X
   IHxXjsaewmRzOOe/ICeeg4sbybYqniBIJ1hezrsQVgmbwoXoO+D0TJBcr
   fWk/o62JUijDZirSt61dQFqUILXgsI0y0p6jrInlH9avkHKyWfrRNiaki
   ik7P2WG1oOSgRiEVQirn0ZJtgRP8LhGN6Z0GzG7rzzW+Ui4mXHSz1yS6a
   EbzTFeU+AVaUDj0hdEMgVxTrEoSsbXNWFATQkTFists6MJS1qOVfJ13L2
   nLEscurSnmaFuFDn8RTWUDgZor0TL8Btw6KhC+NrNMUsIUpUwh+eMdkWU
   A==;
X-CSE-ConnectionGUID: v326R6KsSHG/7qapPLMt3A==
X-CSE-MsgGUID: rMkZVVgATE67lMEW6J3zYA==
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="42067831"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Feb 2025 11:27:47 +0100
X-CheckPoint: {67BD9B23-31-C21CC984-D1047F1F}
X-MAIL-CPID: E8C0C7D14AB069B46AB0984605807505_5
X-Control-Analysis: str=0001.0A00211A.67BD9B22.00E2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B52BA167DD7;
	Tue, 25 Feb 2025 11:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740479263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPSg6DYIbo5is+m87av+3FLHT15AQqV2IPDzqZE96f0=;
	b=WPLx5pm7LwtPQ4R8fJGx/N9MFGaUlBKRVwYNsPk5yYS/x+EejAoMBp3u5jpsGfO4x3xqXb
	8sWY1NivLT/Uru+qtFJlCtHrVyoNARx4GI3Xh0DDBtH26ux69bSUsGoKQ3fsgkMLhD54PF
	DalpEASCCJF6L3bsfSaqZ/+gFeBjzjgBja/QyW0S6+Uje8nyvYcf7kJae7s/dvzGQ2E4r2
	15hr79s4wqxQNW+Xus04+9HNdx2ff7c8Vf2Mnr46PdrizdPtNBnepRKpjfqtGWccEs8svl
	kj/MGdeyhwl5BNziX4ZlZ8MV9j+ExX2xxX0l3JyLZfuZOMMFLwbIkhsuXR7tbw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: [PATCH 1/3] dt-bindings: PCI: fsl,imx6q-pcie: Add optional DMA interrupt
Date: Tue, 25 Feb 2025 11:27:21 +0100
Message-ID: <20250225102726.654070-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
References: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

i.MX8QM and i.MX8QXP/DXP have an additional interrupt for DMA.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 4c76cd3f98a9c..ca5f2970f217c 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -47,12 +47,16 @@ properties:
     maxItems: 5
 
   interrupts:
+    minItems: 1
     items:
       - description: builtin MSI controller.
+      - description: builtin DMA controller.
 
   interrupt-names:
+    minItems: 1
     items:
       - const: msi
+      - const: dma
 
   reset-gpio:
     description: Should specify the GPIO for controlling the PCI bus device
-- 
2.43.0


