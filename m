Return-Path: <linux-pci+bounces-36425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC34B85AAA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7DF1C257FE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6784C30FF1D;
	Thu, 18 Sep 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lnkAaIfZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAEB23C512;
	Thu, 18 Sep 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209495; cv=none; b=Vjl8sGoIM/sn5lDdCIUfjz425pjYT+Gndv4nbemmesj4P6BXVMGhljinyFAaWfoWlBvFOPDRlw8jEDCeAUpEyDWrs7gDy+WoDF2/2c8UDWPWXcvOXztSzQkLVRc3GjecyuTauaX6doDbh1QYQNAumUYFJ4l1K+9W1Jc7gIFqL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209495; c=relaxed/simple;
	bh=M1y4kyl7/u9ISiwORUl0PBLLRmK62BT8dpUJThLsa44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uud83C36GHySMY6qrsVQg0KTAqakNKqXL/r8e8AFEPNINlfD7AoIvSiHpfV/gs8MrD1aoqvspFU+QOHKTyyNtcRqJ1EV3UL2fNWEsD+CNefKHCVSLaCpE+1Ec4oy2RHX5nB4wdd5HqbeNXZDqA+4aNSm4AgonzpZysIOlmrUZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lnkAaIfZ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D572F25FC1;
	Thu, 18 Sep 2025 17:31:31 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZaX2TIHOkGrM; Thu, 18 Sep 2025 17:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758209491; bh=M1y4kyl7/u9ISiwORUl0PBLLRmK62BT8dpUJThLsa44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lnkAaIfZT7DKYWkRJEIOlW3ppvRJGOyH5FGe3UXQ3josx0Ye2dY+cWRyyP5/N4Rnf
	 KWcTAeiIZW3AZdUEeZWlpJuTVqxdUohKHGH4Q+0r5FD+Rib36KegUeegZCxNK/Spm3
	 NLGbiWFUNtWQ31yMktiLXIGezjP/vTp/scQnUG0bNAygUsmh14zyKnkckXWykdC0a+
	 y2BFD6pyJ4FQdZDQxP9/DdufUl5EdtUvJyCbgsfndVEyuZIVWlz1LL9sXoHQhdt3E2
	 sgJkJAaatZ/8arOwvviVaomS6vjGbOseGy/GBGJPUST1JO8eN/tLnSsSbVWOY1nX1a
	 /mPmddGUO1wDg==
From: Yao Zi <ziyao@disroot.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 1/3] dt-bindings: PCI: dwc: rockchip: Add RK3528 variant
Date: Thu, 18 Sep 2025 15:30:55 +0000
Message-ID: <20250918153057.56023-2-ziyao@disroot.org>
In-Reply-To: <20250918153057.56023-1-ziyao@disroot.org>
References: <20250918153057.56023-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3528 ships a PCIe Gen2x1 controller that operates in RC mode only.
Since the SoC has no separate MSI controller, the one integrated in the
DWC PCIe IP must be used, and thus its interrupt scheme is similar to
variants found in RK3562 and RK3576.

Older BSP code claimed its integrated MSI controller supports only 8
MSIs[1], but this has been changed in newer BSP[2] and testing proves
the controller works correctly with more than 8 MSIs allocated,
suggesting the controller should be compatible with the RK3568 variant.
Let's document its compatible string.

Link: https://github.com/rockchip-linux/kernel/blob/792a7d4273a5/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L1610-L1613 # [1]
Link: https://github.com/rockchip-linux/kernel/blob/1ba51b059f25/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L904-L906 # [2]
Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 6c6d828ce964..67f1a5502048 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -22,6 +22,7 @@ properties:
       - const: rockchip,rk3568-pcie
       - items:
           - enum:
+              - rockchip,rk3528-pcie
               - rockchip,rk3562-pcie
               - rockchip,rk3576-pcie
               - rockchip,rk3588-pcie
@@ -78,6 +79,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - rockchip,rk3528-pcie
                 - rockchip,rk3562-pcie
                 - rockchip,rk3576-pcie
     then:
@@ -89,6 +91,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - rockchip,rk3528-pcie
               - rockchip,rk3562-pcie
               - rockchip,rk3576-pcie
     then:
-- 
2.50.1


