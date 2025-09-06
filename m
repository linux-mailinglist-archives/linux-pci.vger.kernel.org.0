Return-Path: <linux-pci+bounces-35596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A89FB46F10
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 15:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0F91B2519E
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490E72EDD41;
	Sat,  6 Sep 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="UzK5gLBW"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAE2F0C79;
	Sat,  6 Sep 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757166794; cv=none; b=kvNtbeVXp5VfgVQG9kQzDFYhNVr/FgHSjb2Td3i6EEl0e0tgH+2KLYAJljRvUpezFk4e0MYs5ENeDT88yr6GQTyf9ObrgjawrhEn1fR99Fc4VKeUEdq6duD4Prx9+6UNh+KaZumc+95D0m0M5lPDv8kmzE49wVUdLvmWyzynp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757166794; c=relaxed/simple;
	bh=QsGy+bBU+9Umuk9tcBxgAcdBm7R9LKoAcjgjg3FRuWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft8z9o2NDNr9EXiNZqi8uYVJPl2NbTVYy8B2lCyC1uyEi83NWlbuzZLpHG1l/N0Ze8+XPTjkFASosePzDwxBDiqAmW8aQ44y36KBdp6G3ApgvjAnjVreUTk6qLMT1HbrK2NxvQEyWBBRIBmnSfyHkk87ilhaYtnXcDIo0JbhGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=UzK5gLBW; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 87B2622C21;
	Sat,  6 Sep 2025 15:53:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LJOJ-S12NzCP; Sat,  6 Sep 2025 15:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757166789; bh=QsGy+bBU+9Umuk9tcBxgAcdBm7R9LKoAcjgjg3FRuWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UzK5gLBWNBPdd9zctSe6HF0agow0S4Irkj2epjEJqsqRj4003Fmpudn2OlKRQnyi8
	 sXmXz7a93HDo5An8XFbr0TunmzNsDxqiXbPsvWzj9rJX+6C2RB6PQvoRyZdAvvjFHp
	 2HWOwFLeP6UboKGnpxAZLObUGhnByw+pW0X98DL38OdLFEvXz4lQfoy9bmIebYaUZI
	 Peq65SYdeX/rUOAJG/gY3XfDxRQ/UbfqOxZWacohCuQosftoA41YgUkPmvy43NGHZq
	 6hXDdV9q4g5kFrVFgbB7/6+nEAGCFuBWwPIRYqQYTLihNBJhJANUNKv9o6KDs8zxRJ
	 lvsEEoof/L6nw==
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
Subject: [PATCH 1/3] dt-bindings: PCI: dwc: rockchip: Add RK3528 variant
Date: Sat,  6 Sep 2025 13:52:44 +0000
Message-ID: <20250906135246.19398-2-ziyao@disroot.org>
In-Reply-To: <20250906135246.19398-1-ziyao@disroot.org>
References: <20250906135246.19398-1-ziyao@disroot.org>
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


