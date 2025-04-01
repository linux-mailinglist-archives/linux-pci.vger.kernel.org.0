Return-Path: <linux-pci+bounces-25043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816E2A77769
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB747188EAA3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64EB1EE005;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enWEW/1y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC81EDA0B;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499057; cv=none; b=u/sLC2/dHdfslVq/7IfkNxBPAD5rD0v20J8SbYWNMXgs+AsdyLnFZ1QgARmSAS1a6ZO/5G7v3NImsfaCZUJDepvVG7SuagrcTWEjEcTx9kAnSgMY4YLo2PjmIo4DEH/0xPQ+hVy+ey6V3f8cxPITS9/AF0tHa0aDrmNt0wkhJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499057; c=relaxed/simple;
	bh=daJVIBM+/86CgCX2tXFh2mvwbkNwOdxzc12EaBZe6CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0qKLwo3q4nX4Y+NYG9LaTwpvb4Gboz8F2fHL/ueXSd44RT081rJKsOl/08qFV1HfaEwFNdCikWyPpWSFaqqvFLxfIIvIfFFse96i/kOoZorNu4Qz3RMl4LLrWscG6tpmx5IPtHy9fNJ5jqkxD/fpSoHfR7KwAS42tIo7CH+Nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enWEW/1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B2BC4AF0B;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499057;
	bh=daJVIBM+/86CgCX2tXFh2mvwbkNwOdxzc12EaBZe6CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enWEW/1yRcjlV2XBsMR95Rv9PoZiqV9QAukkQM2B5Vf82OvngCOzRef3NuLe2oQ9/
	 UcXWZ5q3eGZy+Jia31n1ns+uwbytU8bAx869q8pD3ub9uQuXeX48z9hX6WbO8jPzeA
	 dU8uVVdyHtsbNPOYzkMxAhT0K9+0EVC+nZ1JlxCXg68JPpyNFii5LX6OOHVM7ySd2h
	 sf8A5hLbN0k6Dyp0ohpzG6RWDDy/MKJlBaLVfQeK2v0iPXtl1oobqR6Yt/l7KaDmiT
	 5qx3LhnjwflJxqFrAIZroz/CDFShtbBRjEMuZ20jhwOdfO90TJEmMlws8oqRnrluaV
	 NZrCMGEjDNPhA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tzXkV-001GqU-7U;
	Tue, 01 Apr 2025 10:17:35 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: [PATCH v3 02/13] dt-bindings: pci: apple,pcie: Add t6020 compatible string
Date: Tue,  1 Apr 2025 10:17:02 +0100
Message-Id: <20250401091713.2765724-3-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250401091713.2765724-1-maz@kernel.org>
References: <20250401091713.2765724-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, mark.kettenis@xs4all.nl
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Alyssa Rosenzweig <alyssa@rosenzweig.io>

t6020 adds some register ranges compared to t8103, so requires
a new compatible as well as the new PHY registers.

Thanks to Mark and Rob for their helpful suggestions in updating
the binding.

Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
[maz: added PHY registers, constraints]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../devicetree/bindings/pci/apple,pcie.yaml   | 33 +++++++++++++++----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index c8775f9cb0713..c0852be04f6de 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -17,6 +17,10 @@ description: |
   implements its root ports.  But the ATU found on most DesignWare
   PCIe host bridges is absent.
 
+  On systems derived from T602x, the PHY registers are in a region
+  separate from the port registers. In that case, there is one PHY
+  register range per port register range.
+
   All root ports share a single ECAM space, but separate GPIOs are
   used to take the PCI devices on those ports out of reset.  Therefore
   the standard "reset-gpios" and "max-link-speed" properties appear on
@@ -30,16 +34,18 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-pcie
-          - apple,t8112-pcie
-          - apple,t6000-pcie
-      - const: apple,pcie
+    oneOf:
+      - items:
+          - enum:
+              - apple,t8103-pcie
+              - apple,t8112-pcie
+              - apple,t6000-pcie
+          - const: apple,pcie
+      - const: apple,t6020-pcie
 
   reg:
     minItems: 3
-    maxItems: 6
+    maxItems: 10
 
   reg-names:
     minItems: 3
@@ -50,6 +56,10 @@ properties:
       - const: port1
       - const: port2
       - const: port3
+      - const: phy0
+      - const: phy1
+      - const: phy2
+      - const: phy3
 
   ranges:
     minItems: 2
@@ -98,6 +108,15 @@ allOf:
           maxItems: 5
         interrupts:
           maxItems: 3
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: apple,t6020-pcie
+    then:
+      properties:
+        reg-names:
+          minItems: 10
 
 examples:
   - |
-- 
2.39.2


