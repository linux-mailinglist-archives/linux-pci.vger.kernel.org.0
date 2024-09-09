Return-Path: <linux-pci+bounces-12959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF72971FE8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 19:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAFAB22F93
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BEE176FAC;
	Mon,  9 Sep 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="TXp52kMx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F9170A00
	for <linux-pci@vger.kernel.org>; Mon,  9 Sep 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901449; cv=none; b=GhyVdJADufxJj7uJZ+xlaP0NFg8XG0hTsvQBnZKxeOal30paf0qaaRMrBt13PTUqs2FtnyUbOZg64UnTUnFIQY4XbGX6YzZFi7sjNjFVfJlLDDgB8VQqKbqWq0M97jS6TwTQnWL3584NN+R1OJDru1CRKiaSrkxrpH6fCbbXPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901449; c=relaxed/simple;
	bh=8DZAIx78tX09RUB958aT4rufSeZEMPqRli6/uDdiQJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9+AtKNHE3LKMtLHZ8xr2x1c6f+VS3dl7RE9Y8pavv5bRvfiKfqs4/qTzikuf5LJOjRZKorEKsizjbPj7Rml1uzpB8cDnXGWhW6mfGfZIifEEedQpefMb3VQoaBOMt+DsxiYiG3hdicQkybZ79v3IuBgdD6FNDEPeslvDMr3RFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=TXp52kMx; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240909170404e191c9bdb540234969
        for <linux-pci@vger.kernel.org>;
        Mon, 09 Sep 2024 19:04:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iFfd2t0Dq0yUbDlytZqHUfYp4qV0roKUDvsOPNNJEZ0=;
 b=TXp52kMxIC1YO4MDnCBvHdIeb/njL4BjGQHk8EDtu4UbAGNTPXRXOAAM5R5KFA5SqLs6Zu
 sr78vBctTX3nhxviJyxMHiyv/opkIKrUP3SYenrCgdAYmqK5BLVEb7s2+mZTEHo+HK0MwThG
 OAwyz4pEx9hQmf60TZZoQTL2GB+fcshrN3eIUNoGTUH1juScvaluExzuM1YTprLK7gJtqmw2
 H3GEG8p6rpLRW1aguFDjyu7kcafvPG+K8edRkFVK6VLnOeGFUqGGvA2/80N0QXoR3wX3J5M3
 WaNxJDGAktJBg79DnjT6kaVc05lHHzmAjlxhGdU3c4BWrUyklCDdyqyA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v6 7/7] arm64: dts: ti: iot2050: Add overlay for DMA isolation for devices behind PCI RC
Date: Mon,  9 Sep 2024 19:04:00 +0200
Message-ID: <6cc76d4f83e725353e9508d5b5814daec6df92e8.1725901439.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725901439.git.jan.kiszka@siemens.com>
References: <cover.1725901439.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Reserve a 64M memory region and ensure that all PCI devices do their DMA
only inside that region. This is configured via a restricted-dma-pool
and enforced with the help of the first PVU.

Applying this isolation is not totally free in terms of overhead and
memory consumption. It  makes only sense for variants that support
secure booting, and generally only when this is actually enable.
Therefore model it as overlay that can be activated on demand. The
firmware will take care of this via DT fixup during boot and will also
provide a way to adjust the pool size.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  5 +++
 ...am6548-iot2050-advanced-dma-isolation.dtso | 33 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index bcd392c3206e..b6ee943be8c6 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -74,8 +74,10 @@ k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
 k3-am654-evm-dtbs := k3-am654-base-board.dtb k3-am654-icssg2.dtbo
 k3-am654-idk-dtbs := k3-am654-evm.dtb k3-am654-idk.dtbo k3-am654-pcie-usb2.dtbo
 k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-dtbs := k3-am6548-iot2050-advanced-m2.dtb \
+	k3-am6548-iot2050-advanced-dma-isolation.dtbo \
 	k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtbo
 k3-am6548-iot2050-advanced-m2-bkey-usb3-dtbs := k3-am6548-iot2050-advanced-m2.dtb \
+	k3-am6548-iot2050-advanced-dma-isolation.dtbo \
 	k3-am6548-iot2050-advanced-m2-bkey-usb3.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
@@ -240,7 +242,10 @@ DTC_FLAGS_k3-am62p5-sk += -@
 DTC_FLAGS_k3-am642-evm += -@
 DTC_FLAGS_k3-am642-phyboard-electra-rdk += -@
 DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
+DTC_FLAGS_k3-am6548-iot2050-advanced += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-am6548-iot2050-advanced-pg2 += -@
+DTC_FLAGS_k3-am6548-iot2050-advanced-sm += -@
 DTC_FLAGS_k3-am68-sk-base-board += -@
 DTC_FLAGS_k3-am69-sk += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
new file mode 100644
index 000000000000..dfd75d2dc245
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOT2050, overlay for isolating DMA requests via PVU
+ * Copyright (c) Siemens AG, 2024
+ *
+ * Authors:
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/reserved-memory} {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	pci_restricted_dma_region: restricted-dma@c0000000 {
+		compatible = "restricted-dma-pool";
+		reg = <0 0xc0000000 0 0x4000000>;
+	};
+};
+
+&pcie0_rc {
+	memory-region = <&pci_restricted_dma_region>;
+};
+
+&pcie1_rc {
+	memory-region = <&pci_restricted_dma_region>;
+};
+
+&ti_pvu0 {
+	status = "okay";
+};
-- 
2.43.0


