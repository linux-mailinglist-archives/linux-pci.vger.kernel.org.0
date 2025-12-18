Return-Path: <linux-pci+bounces-43323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26067CCD56B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E93F3088B8D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB3830B501;
	Thu, 18 Dec 2025 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mzsr2pch"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2D3314A1
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084808; cv=none; b=Jf5W57U6Pw/R8zo2FmcDrefwbmGxc7HzOrf1ls/EUCQQC9cOw4NcBkot4KzT2rIHpZqkzU3lz9tVmq1JBa7R5tjkcmBLCQMUhg/AK/5fcknFuN/aR3IJ/kpNLLGZ6yGZ3AmHcXsZ3Y4jx3eJiyXsvElr4OLZVZLmyktkkP/Fpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084808; c=relaxed/simple;
	bh=WmNhKHxR56giJYTC+Sr5zcWuTajITgecx+NDCIWTXHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgXzOPhj0qbdISlJJ/EnUjStYQL/TCiQVdlsDg7DNoKyXPROTCbobuxTjLN0wWcA7KnU6nB+mNCSGqZj/GkuAzMwOS/gagV1IyGPaWUwXSt8qeKZtbeXxYd/9g014p6+nj9GFSe1VcJpW4fSY13NKMTINH65ZPz2mGndVTraLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mzsr2pch; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so1120190a12.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 11:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766084803; x=1766689603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yD0K3OTadJJd6t4hzFzNdpV2SBHdW94fnjzmwjH3hgg=;
        b=Mzsr2pch8LhMOh873v2hoChicTtusruY5cE3BmhNkJApzueWQZYxwQq6Zj1JXEt2z5
         KHHOZuK4iY0CHXVLxPluNHWrEUuFfGIQGZK1AzHctmHO+XJba1uCBNkASDQb0NoO+ocy
         KclkPOQOh5vkTKo2lMt1cD5XzWOUm9TAeaezt594a9ITfHe/5uO0+U5/4HbE3B9fn1Xu
         5DUNWxk5DCNadE8bK/+63JDkbWY5/Um03IjBf/9RyIxWx/Je7ybdI7LYEt28zhW0nBN6
         Ikp3cjAbWpT2miSqQZV8pDRo87swSPYqQefGpc8rYN5CjVpA4mzv1wHBXh83srrQm2GZ
         myEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766084803; x=1766689603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yD0K3OTadJJd6t4hzFzNdpV2SBHdW94fnjzmwjH3hgg=;
        b=SLljuesKqe1/oMvjWl3CBT40g6FWZxHYQ9TxZJ7/Q4HOj0KNp24PCgK6wzJ8CnSfQU
         4lUNXhbVzRPNs8thiUCI1BV3ppQr3violiAiQbbxDlheqavg8Kx0DN+JTFRsxEMmr0ZJ
         WQtp9QQE7dtsLx8+asLrijNKVBMC8MaFQxq0ZNQosa8UVs92XkqdxJYpgYF93+uHTVGF
         cC9x3ttJzR1gTfKyWMKfouSI2NHNUbsZYXtDmScm5R4sfhG3hTJhqF6rxgkwWt4FAGy/
         aPpGH99RQMv6gPxZF5p/JxB6JPzKYdGKym8Mb8YyfKoChEfyEkh5pUkfYOn+2E3tkFPI
         zaTg==
X-Forwarded-Encrypted: i=1; AJvYcCW36wMchAYNtRPehYCWuJgbVUzzlojCuzDUDp2dO1JbBnyt1/TLebpCBe/1s9TajoQI/cJM/Ha1dgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KndlIj1NBjPDqJdJbktXwpuhOtvGOrpp+7y3O7KK/axc3NYL
	C/+rddAwcZipmGGrN+jjrTKzybjPEHVuyNI7Mj7KhLt0wY01plWs5EXwXqgZBIZMkX4=
X-Gm-Gg: AY/fxX5tG2ZCpB9RA5C2KN9zj5topeDuFhTfIQ89G0fcOo8J5JMHxIyAzIKc1xEVYLp
	Z07dMx1vymJ8Jgji63cwkGSdVoVt5v3QGKHXNZG3DwaYTnr7IF+JNhkAwK7K+5/S5b1MPsbu4jp
	dX1BrVZeivPj9Ff0Z4/LgXtzI6jBYPjSmTWyjXQ5ywRdsZ0WKEtYLVp0tWktqJd/SkuXvOu/vlK
	qBY+Igl7NGBVQj8zxsZxUB3Bo70B8gpWO93WbtLBcOcfVJgRA3SH7Xj0xirJN0Z3UGsgTKJ6gN9
	1YJNQ3kgdeg2/abYCGNa+b41nG95Ayv2FPEdj5VgvRbnAnnLHXMGF3ep1cdta/NE3UdFYyu73A8
	6jJNTOwb7hUKE0ug8BQEFwy8pFvL2g6pCnUIqEWiWrR47bC0eXie75Es+lw+moAJNVYJqJVC75r
	bpdR65e8bdSiuuv4dCN49Ag2HKl0/u9UxMyS7LNYq/Mbemw6PDoiL60A==
X-Google-Smtp-Source: AGHT+IGMlzVyG7sXrFNsNeLNed/uMM7+wZEL1Cu2Qp1hC2aPgnk5qKL9w/gcFZDVh1e21Hfc/SdNQQ==
X-Received: by 2002:a17:907:868e:b0:b7a:1be1:86e6 with SMTP id a640c23a62f3a-b8037224ea0mr39939966b.62.1766084803242;
        Thu, 18 Dec 2025 11:06:43 -0800 (PST)
Received: from localhost (host-79-37-15-246.retail.telecomitalia.it. [79.37.15.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5c4dfsm18931166b.14.2025.12.18.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:06:42 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH 3/4] arm64: dts: broadcom: bcm2712: fix RP1 endpoint PCI topology
Date: Thu, 18 Dec 2025 20:09:08 +0100
Message-ID: <827b12ba48bb47bc77a0f5e5617aea961c8bc6b5.1766077285.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766077285.git.andrea.porta@suse.com>
References: <cover.1766077285.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The node describing the RP1 endpoint currently uses a specific name
('rp1_nexus') that does not correctly reflect the PCI topology.

Update the DT with the correct topology and use generic node names.

Additionally, since the driver dropped overlay support in favor of a
fully described DT, rename '...-ovl-rp1.dts' to '...-base.dtsi' for
inclusion in the board DTB, as it is no longer compiled as a
standalone DTB.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
The DTC compiler produces the following warning:

WARNING: DT compatible string vendor "pci1de4" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#91: FILE: arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts:31:
                        compatible = "pci1de4,1";

I'm not sure wheter I should add that compatible to vendor-prefixes.yaml
or change the compatible to something already recognized as a vendor,
such as 'raspberrypi,pci1de4,1'.
I'd prefer the former to be consistent to what would be filled by enabling
CONFIG_PCI_DYNAMIC_OF_NODES. Any hint will be really appreciated.
---
 arch/arm64/boot/dts/broadcom/Makefile         |  1 -
 ...-ovl-rp1.dts => bcm2712-rpi-5-b-base.dtsi} |  0
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     | 39 ++++++++++++-------
 3 files changed, 26 insertions(+), 14 deletions(-)
 rename arch/arm64/boot/dts/broadcom/{bcm2712-rpi-5-b-ovl-rp1.dts => bcm2712-rpi-5-b-base.dtsi} (100%)

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 83d45afc6588e..d43901404c955 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -7,7 +7,6 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2711-rpi-4-b.dtb \
 			      bcm2711-rpi-cm4-io.dtb \
 			      bcm2712-rpi-5-b.dtb \
-			      bcm2712-rpi-5-b-ovl-rp1.dtb \
 			      bcm2712-d-rpi-5-b.dtb \
 			      bcm2837-rpi-2-b.dtb \
 			      bcm2837-rpi-3-a-plus.dtb \
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
rename to arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 3e0319fdb93f7..2856082814462 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -1,22 +1,16 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * bcm2712-rpi-5-b-ovl-rp1.dts is the overlay-ready DT which will make
- * the RP1 driver to load the RP1 dtb overlay at runtime, while
- * bcm2712-rpi-5-b.dts (this file) is the fully defined one (i.e. it
- * already contains RP1 node, so no overlay is loaded nor needed).
- * This file is intended to host the override nodes for the RP1 peripherals,
- * e.g. to declare the phy of the ethernet interface or the custom pin setup
- * for several RP1 peripherals.
- * This in turn is due to the fact that there's no current generic
- * infrastructure to reference nodes (i.e. the nodes in rp1-common.dtsi) that
- * are not yet defined in the DT since they are loaded at runtime via overlay.
+ * As a loose attempt to separate RP1 customizations from SoC peripherals
+ * definitioni, this file is intended to host the override nodes for the RP1
+ * peripherals, e.g. to declare the phy of the ethernet interface or custom
+ * pin setup.
  * All other nodes that do not have anything to do with RP1 should be added
- * to the included bcm2712-rpi-5-b-ovl-rp1.dts instead.
+ * to the included bcm2712-rpi-5-b-base.dtsi instead.
  */
 
 /dts-v1/;
 
-#include "bcm2712-rpi-5-b-ovl-rp1.dts"
+#include "bcm2712-rpi-5-b-base.dtsi"
 
 / {
 	aliases {
@@ -25,7 +19,26 @@ aliases {
 };
 
 &pcie2 {
-	#include "rp1-nexus.dtsi"
+	pci@0,0 {
+		reg = <0x0 0x0 0x0 0x0 0x0>;
+		ranges;
+		bus-range = <0 1>;
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		dev@0,0 {
+			compatible = "pci1de4,1";
+			reg = <0x10000 0x0 0x0 0x0 0x0>;
+			ranges = <0x1 0x0 0x0 0x82010000 0x0 0x0 0x0 0x400000>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			#include "rp1-common.dtsi"
+		};
+	};
 };
 
 &rp1_eth {
-- 
2.35.3


