Return-Path: <linux-pci+bounces-33315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE6B187FB
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 22:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170E03AC7F6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2E1F4C96;
	Fri,  1 Aug 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJSufQXF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C82DF71;
	Fri,  1 Aug 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078942; cv=none; b=uaw0Fbuca+Hef474dHXksTrKzzclt+iNIM8JlEbo9VIRWwp0SY5OM3IlHS+lUKyFUrgoGn4TanBjMXHaYjk1Me3ZAoO9RWIJllZgCwvjqHmkzi07pwwhLJuE5h+vic5hbKDYNmDhILekpDIPxNfz1+U2A65NnZyAK6b5orauyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078942; c=relaxed/simple;
	bh=fw8F8QiVkdM8Joh95+oEe6ERIlYYV1zFhGgB51zRycI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdzP3TwxSqK/VDhbskoW8gloT9KBuODtVl/6FnDSOPmOSKTgTXS76mwmjxbeIUCvPX6X6pPVR73mfsbkirVRR4PfB9dN3GriOwkjVj4zMjXwxwIBOCsedzFfTDKfXF7OPMJCNi3uQrsxqbzMvLHriEIa8cx4fWHBRR/8MJEBCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJSufQXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014BFC4CEF4;
	Fri,  1 Aug 2025 20:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754078942;
	bh=fw8F8QiVkdM8Joh95+oEe6ERIlYYV1zFhGgB51zRycI=;
	h=From:To:Cc:Subject:Date:From;
	b=WJSufQXFoUAEZZCjWBC9UGKH+EmX5KsBppVj8N0wgJiZIlj2c0SE/B6ot+wXAzjfR
	 8c0FBs/P7OcD/RPqQVyOpmiaKgupLYB+rcf0dm4tRYo6chPIoNZzaM34Ho1yr1ojw0
	 6L6DO6oO5rZrvRV1fWzWiHWjhZ8iy/bv02S3qKSNwSsh/Pa4Q2Qg0E/b0zTOJEMZwr
	 Z6St/MYc0GkSJ/xhl1I+OPaIqFcdBBzbKKybMWRi2xo4UuWN4vHtLJWL92wJM9qUcS
	 9IRHeazBA/b2/wTc3pkdJw4SqdCMkWaez/8bTr4PIKWjFC56K6F9N38t09MjTNd2Jz
	 utKIeLrGDySuw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Add missing "#address-cells" to interrupt controllers
Date: Fri,  1 Aug 2025 15:07:27 -0500
Message-ID: <20250801200728.3252036-2-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An interrupt-controller node which is the parent provider for
"interrupt-map" needs an "#address-cells" property. This fixes
"interrupt_map" warnings in new dtc.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
PCI maintainers, Please ack, I'll take this with the dtc update for 
6.18.

 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml    | 1 +
 .../devicetree/bindings/pci/marvell,armada-3700-pcie.yaml     | 4 ++++
 .../devicetree/bindings/pci/marvell,kirkwood-pcie.yaml        | 3 +++
 .../devicetree/bindings/pci/socionext,uniphier-pcie.yaml      | 4 ++++
 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
index 5434c144d2ec..18e7981241b5 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
@@ -108,6 +108,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     gic: interrupt-controller {
+        #address-cells = <0>;
         interrupt-controller;
         #interrupt-cells = <3>;
     };
diff --git a/Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml b/Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
index 68090b3ca419..8403c79634ed 100644
--- a/Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
@@ -42,6 +42,9 @@ properties:
     additionalProperties: false
 
     properties:
+      '#address-cells':
+        const: 0
+
       interrupt-controller: true
 
       '#interrupt-cells':
@@ -92,6 +95,7 @@ examples:
             reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 
             pcie_intc: interrupt-controller {
+                #address-cells = <0>;
                 interrupt-controller;
                 #interrupt-cells = <1>;
             };
diff --git a/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml b/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
index 7be695320ddf..3d68bfbe6feb 100644
--- a/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
@@ -101,6 +101,9 @@ patternProperties:
         additionalProperties: false
 
         properties:
+          '#address-cells':
+            const: 0
+
           interrupt-controller: true
 
           '#interrupt-cells':
diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
index 638b99db0433..c07b0ed51613 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
@@ -56,6 +56,9 @@ properties:
     additionalProperties: false
 
     properties:
+      '#address-cells':
+        const: 0
+
       interrupt-controller: true
 
       '#interrupt-cells':
@@ -109,6 +112,7 @@ examples:
                         <0 0 0  4  &pcie_intc 3>;
 
         pcie_intc: interrupt-controller {
+            #address-cells = <0>;
             interrupt-controller;
             #interrupt-cells = <1>;
             interrupt-parent = <&gic>;
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 69b499c96c71..c704099f134b 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -99,6 +99,9 @@ properties:
     additionalProperties: false
 
     properties:
+      '#address-cells':
+        const: 0
+
       interrupt-controller: true
 
       '#interrupt-cells':
-- 
2.47.2


