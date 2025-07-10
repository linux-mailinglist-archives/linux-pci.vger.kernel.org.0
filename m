Return-Path: <linux-pci+bounces-31865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C79B00AFE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 20:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6111C48115
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622FD2FC3BB;
	Thu, 10 Jul 2025 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXuxGV+5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310562253A7;
	Thu, 10 Jul 2025 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170860; cv=none; b=VxuigNIciyB9kuSDlZ55a1EM3py4N4+Tsvo7nRy5cUs+TAMCSqt+AmZqG39hmn5dOQCyWuBlfvDfsguatTQARPwMupFQqSlW8jPyiD4FBnXzn4WHw4XsD6VTxZxJiZnYPY48eKyMLA/lhe1fy1UMvay7h+L6NQ5fS149gSWYdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170860; c=relaxed/simple;
	bh=OSwLylquebJSW7tM6L39R09szO8SIzyKQdTJoe8W924=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n15FgjgSq+63wghPDKCRfG0HAI/RIESt2dhVMM/CYuWF7BGEnx02pdJZhAv5Yi0tIkMAQdwwp9NACvO+cM2pmXJtY6XJFGJsl61K818igD3jfDBG/ghP8/PmfiCf8Gk0JKsia8hUYRwb1KcO5SbApkn0Za2HrTJn1QbXh8kwEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXuxGV+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5179FC4CEE3;
	Thu, 10 Jul 2025 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752170857;
	bh=OSwLylquebJSW7tM6L39R09szO8SIzyKQdTJoe8W924=;
	h=From:To:Cc:Subject:Date:From;
	b=hXuxGV+5jvJ0pEgZGrckHAlkQ70x9tP1LPcT0Cj/vE8qc7qNlHkhQKIuoSC7resKL
	 MT6qnuo4JHRHikyp2PY2enP1+Z6qVEcosNh1E9rzbDe2FdYtggHjK2M+EhwDrj6PsP
	 ZzSrS5rEyBk75K91nyvUMnqTccHPu5yIkCWOeEXlcjwu6mqEK3n7m3sX3Qdz3qfPuT
	 IbQgy3QB/7YS/KrlPeLoKXtUGf+2BE4HSrfP36xETBkEVM6L8H6Cn46KZBlvru+9rb
	 U1oUjdmt0qpcJ9JQlpuKn/qhZsHKscZJRHX0d392GOjh39y+02Rqq7oftoJzUeJpDi
	 XKnWcd4gKNa4A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pratyush Anand <pratyush.anand@gmail.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pci: Convert st,spear1340-pcie to DT schema
Date: Thu, 10 Jul 2025 13:07:30 -0500
Message-ID: <20250710180731.2969879-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ST SPEAr1340 PCIe binding to DT schema format. It's a
straight forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/spear13xx-pcie.txt           | 14 ------
 .../bindings/pci/st,spear1340-pcie.yaml       | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/st,spear1340-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt b/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
deleted file mode 100644
index d5a14f5dad46..000000000000
--- a/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-SPEAr13XX PCIe DT detail:
-================================
-
-SPEAr13XX uses the Synopsys DesignWare PCIe controller and ST MiPHY as PHY
-controller.
-
-Required properties:
-- compatible	    : should be "st,spear1340-pcie", "snps,dw-pcie".
-- phys		    : phandle to PHY node associated with PCIe controller
-- phy-names	    : must be "pcie-phy"
-- All other definitions as per generic PCI bindings
-
- Optional properties:
-- st,pcie-is-gen1 indicates that forced gen1 initialization is needed.
diff --git a/Documentation/devicetree/bindings/pci/st,spear1340-pcie.yaml b/Documentation/devicetree/bindings/pci/st,spear1340-pcie.yaml
new file mode 100644
index 000000000000..dc6a8320d22d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/st,spear1340-pcie.yaml
@@ -0,0 +1,44 @@
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/st,spear1340-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST SPEAr1340 PCIe controller
+
+maintainers:
+  - Pratyush Anand <pratyush.anand@gmail.com>
+
+description:
+  SPEAr13XX uses the Synopsys DesignWare PCIe controller and ST MiPHY as PHY
+  controller.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: st,spear1340-pcie
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: st,spear1340-pcie
+      - const: snps,dw-pcie
+
+  phys:
+    maxItems: 1
+
+  st,pcie-is-gen1:
+    type: boolean
+    description: Indicates forced gen1 initialization is needed.
+
+required:
+  - compatible
+  - phys
+  - phy-names
+
+allOf:
+  - $ref: snps,dw-pcie.yaml#
+
+unevaluatedProperties: false
-- 
2.47.2


