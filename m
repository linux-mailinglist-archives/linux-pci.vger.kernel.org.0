Return-Path: <linux-pci+bounces-35628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B91BB48315
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 06:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0AD7A8AC0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 04:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E351FBCA7;
	Mon,  8 Sep 2025 04:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="O5UCuK6c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33421CC63;
	Mon,  8 Sep 2025 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304183; cv=none; b=Kmx091f74cQgyvrfYUHch5AuKjB1LS33zIOBofly3Bd9Jy5mGCohy6NQ8OUkcPJaWQIJa2lNDbJBSbDds7IdSbA5JN2iailqvTt1tGifmYA4aicjskXIV7kzlz0efeqr9Eg7Ae+2t9zQLm31e/zaCDQCeLnGgyU1hOy8WrT3q5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304183; c=relaxed/simple;
	bh=kpMca/5dNix8RowhERmzPIAooipbVYa60Q5uc1/4vjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AN9dsN+2TXN8EMMcIeg1PlZXIXqgMG//N0mevu8K34I9XMDBnkyb/h20V+CClsF5RkEqe9fGS48rauTrOqSOh7PEsvIZD0AJM+jMQnnZyeiOjb4Ts3YnjXstFuUUUpTdrAlCytPllGz5FZcNtwyUegfppyaNaVBjRaGEJQX5f90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=O5UCuK6c; arc=none smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 5882YmTn2496278; Mon, 8 Sep 2025 11:34:48 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=
	1757298855;x=1758508455;bh=kpMca/5dNix8RowhERmzPIAooipbVYa60Q5uc1/4vjA=;b=O5U
	CuK6cOg7aMbJJ1RTc82mt1mISFZT0UVhkgGTwQYRrjBNR8EAfxvWT05kK4WQMEw5NWdApLO5p6/qw
	pRGnkGiPb8HDXI8kMtWVay4VYhUridv6q/qzL09JgNYRZpL4oCpKrzZRv6eMvtjDtfMEr2gjWUfuc
	2v6Xpev1lPTQGf38jebaTUL1wQNz4iiDSQZ/Uksydf0Q5IjeixVH/N83/jLxxkIwE82OgompvzWdV
	w73wO9FbOCUUHudpxHZAoiatOeSaEBGJEw/J6WjS/ngb9JkTcIW2hReuIolDOC1FNJDvuGDcGjpY4
	WcSzATh0L4JIn9hzqryi2+n8PeWg14w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5882YF273421850; Mon, 8 Sep 2025 11:34:15 +0900
X-Iguazu-Qid: 2yAanLGiwHAfmuanNB
X-Iguazu-QSIG: v=2; s=0; t=1757298855; q=2yAanLGiwHAfmuanNB; m=4x74FXYoyvvLCiG4tTIIRDtA5zJVdJzywQYyEanetjs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cKrch5GKRz1xnZ; Mon,  8 Sep 2025 11:34:12 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH v3 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges to reflect hardware behavior
Date: Mon,  8 Sep 2025 11:34:07 +0900
X-TSB-HOP2: ON
Message-Id: <1757298848-15154-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1757298848-15154-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1757298848-15154-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

tmpv7708 trim address bit[31:30] in tmpv7708 before passing to the PCIe
controller. Since only PCIe controller needs to convert the address range
0x40000000 - 0x80000000, add a bus definition, describe the ranges in it,
and move the PCIe definition.

Prepare for the removal of the driver’s cpu_addr_fixup().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Suggested-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

---
v3:
 Move update in drivers/pci/controller/dwc/pcie-visconti.c to patch 2.
 Update Signed-off-by address, because my company email address has changed.

v2:
  Update commit message.
  Fix range.
  Set true to use_parent_dt_ranges.
  move pcie under the dedicated sub-bus.
---
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi | 75 ++++++++++++++---------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 39806f0ae5133..b754965a76ca6 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -478,37 +478,52 @@ pwm: pwm@241c0000 {
 			status = "disabled";
 		};
 
-		pcie: pcie@28400000 {
-			compatible = "toshiba,visconti-pcie";
-			reg = <0x0 0x28400000 0x0 0x00400000>,
-			      <0x0 0x70000000 0x0 0x10000000>,
-			      <0x0 0x28050000 0x0 0x00010000>,
-			      <0x0 0x24200000 0x0 0x00002000>,
-			      <0x0 0x24162000 0x0 0x00001000>;
-			reg-names = "dbi", "config", "ulreg", "smu", "mpu";
-			device_type = "pci";
-			bus-range = <0x00 0xff>;
-			num-lanes = <2>;
-			num-viewport = <8>;
-
-			#address-cells = <3>;
+		pcie_bus: bus@24000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
 			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			ranges = <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000
-				  0x82000000 0 0x50000000 0 0x50000000 0 0x20000000>;
-			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "intr";
-			interrupt-map-mask = <0 0 0 7>;
-			interrupt-map =
-				<0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
-				 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
-				 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
-				 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
-			max-link-speed = <2>;
-			clocks = <&extclk100mhz>, <&pismu TMPV770X_CLK_PCIE_MSTR>, <&pismu TMPV770X_CLK_PCIE_AUX>;
-			clock-names = "ref", "core", "aux";
-			status = "disabled";
+			ranges = /* register 1:1 map */
+				 <0x0 0x24000000 0x0 0x24000000 0x0 0x0C000000>,
+				 /*
+				  * bus fabric mask address bit 30 and 31 to 0
+				  * before send to PCIe controller.
+				  *
+				  * PCIe map address 0 to cpu's 0x40000000
+				  */
+				 <0x0 0x00000000 0x0 0x40000000 0x0 0x40000000>;
+
+			pcie: pcie@28400000 {
+				compatible = "toshiba,visconti-pcie";
+				reg = <0x0 0x28400000 0x0 0x00400000>,
+				      <0x0 0x30000000 0x0 0x10000000>,
+				      <0x0 0x28050000 0x0 0x00010000>,
+				      <0x0 0x24200000 0x0 0x00002000>,
+				      <0x0 0x24162000 0x0 0x00001000>;
+				reg-names = "dbi", "config", "ulreg", "smu", "mpu";
+				device_type = "pci";
+				bus-range = <0x00 0xff>;
+				num-lanes = <2>;
+				num-viewport = <8>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x81000000 0 0x00000000 0 0x00000000 0 0x00010000
+					  0x82000000 0 0x10000000 0 0x10000000 0 0x20000000>;
+				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi", "intr";
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map =
+					<0 0 0 1 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+					 0 0 0 2 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+					 0 0 0 3 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH
+					 0 0 0 4 &gic GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+				max-link-speed = <2>;
+				clocks = <&extclk100mhz>, <&pismu TMPV770X_CLK_PCIE_MSTR>, <&pismu TMPV770X_CLK_PCIE_AUX>;
+				clock-names = "ref", "core", "aux";
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.51.0



