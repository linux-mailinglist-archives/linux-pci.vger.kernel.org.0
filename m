Return-Path: <linux-pci+bounces-12737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B895A96B7AC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 12:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BB01C247A3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4431CF2B5;
	Wed,  4 Sep 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="CXPPA8ph"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331D1CF5F5
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444035; cv=none; b=mZsn8+9bdgERy3l3GUdjEIChV53xyoXzxsx7nlV+6ruwpFiNByKqSEldrVAg33fR/AVooYUT5pPuAvoJ4u/DMv4meVdTesCDeR/5AnTbdbrpPCt4eQanUb/RZ5NrjbWaUfWYQ3x3Gw3Kb6XKaPNbktY7JhjBtyJgmJXhohFHiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444035; c=relaxed/simple;
	bh=/fX9b/A9nXIbGFSSM7QtrSW1aqgADOgQHQnYVDzRgXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LezwuuDQmJGCVJOwaAkdRKm/cmn4Cx8ndnASmh9WiWT02LfqOhpahRdN4j/5G86N8JYzMRp3WoGTKs99TKNrh5wz52nxHhPvMwBLMEkuiSERe6B2mHM+HiizJFrKX39cvc8eMlUMe+qZ5TQo9YqarGPSa0qQnqhnKbMMD3rrjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=CXPPA8ph; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240904100029611fbcab32be113886
        for <linux-pci@vger.kernel.org>;
        Wed, 04 Sep 2024 12:00:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IMjvXkR2et0GfXj5KTooParfgTgH6azkWUIJJLU1FK8=;
 b=CXPPA8phomGv/pVwygg2mkoKMI4dKVKC0XmZ2SpQD3pbOJHFBtSBQnkfgGgP8b6I1UwGgs
 YVgGpdPU61l+pmAOBLC7Sf7Kkzj8zcUuEbtDb5oHcHx2HMA+SUlDd3ITtfEeVHloPoDoPTZG
 af7dXffQb9sHiUYYRRxGCAes86H0y/29AgDogZfzImRVYOA1Yjx6vzsHm70GWZxLk4CX2jB7
 3yLCz3AfLR4ClhK2f8C/r7yFu1YFj3rBhEFw/EfuzNeTbjNFujbCnOAduSBS7a7a8JshhYB8
 EK+xuKeA/8AwwcqgK4XVgY5TvX8nGQp6M5BYGwsvoT0tA/1J/jV4GJjQ==;
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
Subject: [PATCH v4 7/7] arm64: dts: ti: iot2050: Enforce DMA isolation for devices behind PCI RC on Advanced
Date: Wed,  4 Sep 2024 12:00:16 +0200
Message-ID: <fd15a66b19691fbd38fd8491b2622f417fc3c71a.1725444016.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725444016.git.jan.kiszka@siemens.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
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

The pool size may be adjusted via DT fixup during boot by the firmware.
The location is chosen to allow up to 512M for special needs without
causing conflicts.

Applying this isolation which is not totally free in terms of overhead
and memory consumption makes only sense for variants that support secure
booting. These are the advanced-class variants.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../ti/k3-am6548-iot2050-advanced-common.dtsi | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
index ae842b85b70d..dc75e3ea9a6b 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) Siemens AG, 2018-2021
+ * Copyright (c) Siemens AG, 2018-2024
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
@@ -20,6 +20,25 @@ memory@80000000 {
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
 	};
+
+	reserved-memory {
+		pci_restricted_dma_region: restricted-dma@c0000000 {
+			compatible = "restricted-dma-pool";
+			reg = <0 0xc0000000 0 0x4000000>;
+		};
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
 };
 
 &main_pmx0 {
-- 
2.43.0


