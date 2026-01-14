Return-Path: <linux-pci+bounces-44762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FDCD1FD65
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 666453044845
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9BE39E6DB;
	Wed, 14 Jan 2026 15:37:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7447A3939C2;
	Wed, 14 Jan 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405033; cv=none; b=ZnO1MrUC6DyWVFyTt4Hmb51duMhyo9Yh9lm9e056a4gnKIgwpLmfveNvHyH8/CVj3UOj2vfVjdvv89igZJBcrh/+450CmUFZWW+MFcL4EVkl5HtKZ9miDq6R/Jpjs83lkCHFKE+DZGAkKLCpDq6rcIO/Ic/+1qlzuc+TqJ0mhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405033; c=relaxed/simple;
	bh=W7mGjhVe2GWCXMoc3eUn7rKrCw+Zo/Pfa+mpDO8cqRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCSKAhgN18cWHZ2c4U5v42YySDu5q6EpCXmLUprCPHPT2bXOxAzR493n9hkRCXYCcUgyJ5k0D7guf3o+ywVvXdalPMeeyd7HNr64bXMZcw6LgLw45xlgaVYUqfNNAK0aR7wjh9cg1B/RZ6FSl27hNDtzyQ+imw/WpqHZjumZmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: QwdG+pJNRomX4tn70mE62g==
X-CSE-MsgGUID: xyHWtZpeT3C80lBaflD6TQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jan 2026 00:37:11 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 80EAE40078D6;
	Thu, 15 Jan 2026 00:37:05 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH 15/16] arm64: dts: renesas: r9a09g047e57-smarc: Add PCIe pincontrol
Date: Wed, 14 Jan 2026 16:33:36 +0100
Message-ID: <20260114153337.46765-16-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pincontrol configuration for PCIe on the RZ/G3E SMARC platform.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 696903dc7a63..a9e58103d496 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -167,6 +167,17 @@ rsci9_pins: rsci9 {
 		bias-pull-up;
 	};
 
+	pcie-clkreq-n {
+		gpio-hog;
+		gpios = <RZG3E_GPIO(4, 5) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "pcie_clkreq_n";
+	};
+
+	pcie_pins: pcie {
+		pinmux = <RZG3E_PORT_PINMUX(G, 7, 1)>; /* PCIE_RST_OUT# */
+	};
+
 	scif_pins: scif {
 		pins = "SCIF_TXD", "SCIF_RXD";
 		renesas,output-impedance = <1>;
-- 
2.25.1


