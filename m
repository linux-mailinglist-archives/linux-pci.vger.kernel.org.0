Return-Path: <linux-pci+bounces-44763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B05D1FD3B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F01203019664
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E42B39E6D6;
	Wed, 14 Jan 2026 15:37:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9095D39E6DA;
	Wed, 14 Jan 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405039; cv=none; b=XB99rbHoMMSsXQUElpZ+4EBTBEJrkz2H6SVe6nG4U/O2hDdpFkS77jwrXUNk0wo9kSm5MOC7oR6eex8EyMpaIagidpjVSNkYmjIKwLxrul3np578hEAed+hMlKFXzWxKldqqAq3F5z28aRKTx27UWHhvuaJzBd1WGRoHrgzY7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405039; c=relaxed/simple;
	bh=UGmVvuo+kXcrMhYIfPT8rt3547ejMtiRt7VvAB9MeT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAqQhes+vPu79uGhegM82PnQ3qOgOw8/XLnW7tvn7hArRvEd+oSyHwZnXXPesOfnVFW4t/3tXv5H72y2JCQYeNa41COBkzAKkJppxDWkglwdiQdznjE3gATak2dkzExxfUxsQO4dgbAF9ZYYqQ0PCNLvvzaUK2/K21Yd8DQ0okk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: WS458akEQxCyYbM0NaDL7Q==
X-CSE-MsgGUID: QhJh8AW0QqykvlJKu/pnNA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jan 2026 00:37:17 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BDF5740078D6;
	Thu, 15 Jan 2026 00:37:11 +0900 (JST)
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
Subject: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
Date: Wed, 14 Jan 2026 16:33:37 +0100
Message-ID: <20260114153337.46765-17-john.madieu.xa@bp.renesas.com>
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

The RZ Smarc Crarrier-II board has PCIe slots mounted on it.
Enable PCIe support.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index b607b5d6c259..3db7d31be2b2 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -96,6 +96,13 @@ &i2c0 {
 	clock-frequency = <400000>;
 };
 
+&pcie {
+	dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
+	pinctrl-0 = <&pcie_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &scif0 {
 	status = "okay";
 };
-- 
2.25.1


