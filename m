Return-Path: <linux-pci+bounces-18961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94359FAD73
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64B0164629
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 11:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8414D19A2A3;
	Mon, 23 Dec 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HSYoV1RJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49228.qiye.163.com (mail-m49228.qiye.163.com [45.254.49.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793719342E;
	Mon, 23 Dec 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952015; cv=none; b=jWX+IIgHHi5uf8VHEsOhKsTwu2ML+5s+jF8xk8pgKOeQcDdYts6PP0xS4VNnMMZkvdpPUig1W05OvNVDRD6vVPXkr4pvQOnmWrYW6w9jjZWrBe063Y5nxKepq3aksymfb1vmY+CmNB8UDCk6Ktnc0kK5ZlOVc2PF6C3HQCfRiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952015; c=relaxed/simple;
	bh=TlYdpWDjNeOZidVoGYHC3iuX3kBJTwAy5uf8Mt7vMyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRrSr/5UVM93l41MS3GYy56E6SJjRChG48+WqZ14tu+2uWOIAkyg0gI1ySCv+sHnpurIkLwkGaoK3pFuKuMQeIJjrmO2yDHyxqqVL20d7MNFFfps4poDEOdhx30dAGoIdX/N4r0bW3Oe2XDMK2kTdVA+QBPAncDohAztaC0QPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HSYoV1RJ; arc=none smtp.client-ip=45.254.49.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 68ea013d;
	Mon, 23 Dec 2024 19:06:42 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/7] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Date: Mon, 23 Dec 2024 19:06:32 +0800
Message-Id: <20241223110637.3697974-3-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241223110637.3697974-1-kever.yang@rock-chips.com>
References: <20241223110637.3697974-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8YH1YYSExOQkodHR8aS0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f332a33703afkunm68ea013d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6Hxw6HDIVPgEtGU8PGQ0h
	GTwKCjxVSlVKTEhPQk5JS0tITE5KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0NLNwY+
DKIM-Signature:a=rsa-sha256;
	b=HSYoV1RJhnHZzyvFNGhga9PZNFSTSdHAistilVb8i7BlNQ+dJXjJ4mis2JPttYKrEQX3WPf8s0zHUV8qEw1pe+EDSDtxBNeAVD9KSjbQ8aGLlZPL242U5omYovQdeUhkX2LfPQlfX7XAC+dhm1F5kH+cbgLv/n1BESd4BKV/9E4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=u2SA3IELLyPbbXVQ5aM6sQkCVX0rg3Gm0u9KUQqgd1w=;
	h=date:mime-version:subject:message-id:from;

rk3576 is using dwc controller, with msi interrupt directly to gic instead
of to gic its, so
- no its suport is required and the 'msi-map' is not need anymore,
- a new 'msi' interrupt is needed.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- Fix dtb check broken on rk3588
- Update commit message

Changes in v2:
- remove required 'msi-map'
- add interrupt name 'msi'

 .../devicetree/bindings/pci/rockchip-dw-pcie-common.yaml      | 4 +++-
 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml   | 4 +---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
index cc9adfc7611c..3762f3dd6de3 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
@@ -81,7 +81,9 @@ properties:
       - const: msg
       - const: legacy
       - const: err
-      - const: dma0
+      - enum:
+        - msi
+        - dma0
       - const: dma1
       - const: dma2
       - const: dma3
diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 550d8a684af3..9a464731fa4a 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -26,6 +26,7 @@ properties:
       - const: rockchip,rk3568-pcie
       - items:
           - enum:
+              - rockchip,rk3576-pcie
               - rockchip,rk3588-pcie
           - const: rockchip,rk3568-pcie
 
@@ -71,9 +72,6 @@ properties:
 
   vpcie3v3-supply: true
 
-required:
-  - msi-map
-
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1


