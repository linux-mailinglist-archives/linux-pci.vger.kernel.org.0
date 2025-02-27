Return-Path: <linux-pci+bounces-22535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3CAA47C15
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231333A3E61
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 11:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6AA225761;
	Thu, 27 Feb 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OIGdv/oj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m155110.qiye.163.com (mail-m155110.qiye.163.com [101.71.155.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2F215F45;
	Thu, 27 Feb 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655482; cv=none; b=IyOpOOlGBryIy9kwnBuNAfOh/jHQQdwYNcDhua0lt+FPutqjniBphZyBEYxT2Q73sWv55Fr16yhF8xWUC1OdnasPO9bFhvjmmDzNrvJlwjQrFsw83OFp6xuqY12k4Nlx2HaSq99/6HAklH9KtiLzT5aMsZedh/8hXQE/91Ldikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655482; c=relaxed/simple;
	bh=DD7zYgu4Kti1fkUmflbroxB2ogPWjoiC4JlhvhPr+ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AhgMzItw2Cp5Gmw/76VLTGTMShKbihEOMZW4eUW/FTl1309ZSKHn27hVhVaCI4sIoU/elw+kq+IaHnaqOR/Y8HyT7T55z8pTk1J+JWM8DVhLnWVjskRmHU6lT5XrL1Cv+JcHEfGb8KM/Dh0eO7zdNp3GOqIlHW5weZm8G098wKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OIGdv/oj; arc=none smtp.client-ip=101.71.155.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97c8;
	Thu, 27 Feb 2025 19:19:21 +0800 (GMT+08:00)
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
Subject: [PATCH v3 01/15] dt-bindings: PCI: dwc: rockchip: Add rk3562 support
Date: Thu, 27 Feb 2025 19:18:59 +0800
Message-Id: <20250227111913.2344207-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5KT1YaShhCTBpOTEofTB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954721efb403afkunmc65f97c8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6PCo4TzIXMw0SEkwMHkoY
	AiwwCyxVSlVKTE9LTU5OSk1JQ05LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTktLNwY+
DKIM-Signature:a=rsa-sha256;
	b=OIGdv/ojTp7MJl1BAr7LjG4Z/nf+7P2XerwncGNwK/5TZxKKMeTLCfglQknD0FijyGmyrN4sP0577pRh8SeGDYvIYHoS1SkvkoL9VhG/QqqoZAPRmKp18OIypqITL9J3rShgCUsMJrPfkRwTvVFmKYNfiR62iGJk/lk30XwkH3c=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=dtE/yQzTKTSTRJnHoa013KVsjd6UVbm1wGhrzOmi5Hg=;
	h=date:mime-version:subject:message-id:from;

rk3562 is using the same dwc controller as rk3576.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- Rebase the change base on rk3576 pcie patches

Changes in v2: None

 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml        | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 4764a0173ae4..6c6d828ce964 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -22,6 +22,7 @@ properties:
       - const: rockchip,rk3568-pcie
       - items:
           - enum:
+              - rockchip,rk3562-pcie
               - rockchip,rk3576-pcie
               - rockchip,rk3588-pcie
           - const: rockchip,rk3568-pcie
@@ -76,7 +77,9 @@ allOf:
         properties:
           compatible:
             contains:
-              const: rockchip,rk3576-pcie
+              enum:
+                - rockchip,rk3562-pcie
+                - rockchip,rk3576-pcie
     then:
       required:
         - msi-map
@@ -85,7 +88,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: rockchip,rk3576-pcie
+            enum:
+              - rockchip,rk3562-pcie
+              - rockchip,rk3576-pcie
     then:
       properties:
         interrupts:
-- 
2.25.1


