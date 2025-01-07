Return-Path: <linux-pci+bounces-19388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73FDA03916
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 08:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C421616D0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A314D28C;
	Tue,  7 Jan 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ULXNgOJr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m12789.qiye.163.com (mail-m12789.qiye.163.com [115.236.127.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712C1EA90;
	Tue,  7 Jan 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736236473; cv=none; b=gXLHmQYuZfSs/PmwR30l7HO/IS1VJorXYIaFqI0wapiX5Mk1JMIkXXTe/iYGX/lzYbMeQTj3CdKk/yzqBY1s5J3GPZ1xKOBvU7V+U8de1IfruE/+ddSHSgr1nPADBm2zveKSRWwRWZUaIVF39AadTfPD3p97UdtAGfSIQbP0SOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736236473; c=relaxed/simple;
	bh=pKA8jpzKaW5dKjEwQuXs4llhlt4fJHqtUFCK44fLSlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KxW6QJqP7J2U2Ko15CtzbLH4ZEgDEwPteKJAJ6eR45S9qhkBAjn2M3Dr0389Btf63Xc5sPzgc7PIgFvikhtI3QTggnJaeNvU3+jiBJajOG6Pfvfk6aICNxcRm9xcbwePFQEHc5nvynNNxlCc+x76s+C9LatWyWvOIFv3xF9hGSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ULXNgOJr; arc=none smtp.client-ip=115.236.127.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 7f3b5a7a;
	Tue, 7 Jan 2025 15:49:16 +0800 (GMT+08:00)
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
Subject: [PATCH v4 2/7] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Date: Tue,  7 Jan 2025 15:49:06 +0800
Message-Id: <20250107074911.550057-3-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250107074911.550057-1-kever.yang@rock-chips.com>
References: <20250107074911.550057-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgZT1YaS0geSRlPQ0wYGUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a943fbd47fc03afkunm7f3b5a7a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBg6Cyo6EzILORMoIi8zSAEU
	FS9PChxVSlVKTEhNSUhNSk5DSE1LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQk1JNwY+
DKIM-Signature:a=rsa-sha256;
	b=ULXNgOJr/FibT+0J2+sVLlSdQbjM7qUhkAcAdPFN6pgx11Nwgw0mDiMRcnsruEBSf08bspsf4XIdJiPbdSl5L/G5UPQz65KsfBSvSn9wtJzLQtJVWlc5RD1jvxenI8pNlb8vHba6dG92JxPF445EFIROB7V76TSob50zOBL52+Q=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=QnjYnNQ2cd6uU6QMuLion5/AeCzvzi5/5NXyDr58wf4=;
	h=date:mime-version:subject:message-id:from;

rk3576 is using dwc controller, with msi interrupt directly to gic instead
of to gic its, so
- no its support is required and the 'msi-map' is not need anymore,
- a new 'msi' interrupt is needed.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v4:
- Fix wrong indentation in dt_binding_check report by Rob

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
index cc9adfc7611c..e4fcc2dff413 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
@@ -81,7 +81,9 @@ properties:
       - const: msg
       - const: legacy
       - const: err
-      - const: dma0
+      - enum:
+          - msi
+          - dma0
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


