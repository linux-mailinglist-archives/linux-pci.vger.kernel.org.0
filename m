Return-Path: <linux-pci+bounces-19916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E3DA129E7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78692163191
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14C1ADC6D;
	Wed, 15 Jan 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlSy8LDz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76141AB50C;
	Wed, 15 Jan 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962413; cv=none; b=lsACKZLYwAwBJzNwC9Bu82rALsc3RlVrUTViTqhHMVCL7RCh+JExQsw9lGbt4fM+2YYOmzhX0vmnnqG76yy6m4zopAYVNOajuhLA7009ComoEjG1L+CXMIrD99sqTYtcRGYVrWKM/Z3ZBxnkJoUujb/K0zQvkiN09owqqcX/rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962413; c=relaxed/simple;
	bh=ARIk+9NqKhtoui7VcoODdebFlMlXwR30ub418qR58tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RO4IMFWjjxThAQNv+cMPtKlWX+c4hosX6CsE4E0iqRiZU1yeH9IkpSVEfmUtGntNN4MBfd+7a56YGXEEmhhQsOKGguQ54Ua7rmjy73XjyTSvoCoNrX6n71iyZCAqozbzJSRrZEp+90mYHbEXVJMVZ+Qtqfm7DlCzUb2jN3h6ahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlSy8LDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BD4C4CED1;
	Wed, 15 Jan 2025 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736962413;
	bh=ARIk+9NqKhtoui7VcoODdebFlMlXwR30ub418qR58tU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TlSy8LDzXzOpjtwdPVFvEoFYT5N4F0Ihzwa6yNDZcOwznO6ZdICydVjtcR5R7K0rV
	 uDKvTGYd8ZabNxiBnJVuRmUtzg1WukP5y48WbmZXSRbeMhAqQmTj4jDJHfl2NNmFvq
	 VuLIOKm/3Ged7F72b4oM23o6MYD/K0oZ4r7/Y1W7HaWAJ8hREhayGbOeZmlM2KFYVw
	 WYu8IJxt7mtbXxDy60i523oY75EPjXOmA+hjWHtp5tZwG/v/GoIsnI0QJbKffWOFTl
	 +zMnA2SiScgNhSs86S+uP9/VzdVhgwL4hCNsno3PWeLhTBhz4yCOSffOE19tT/9/Mk
	 qOIt2wgF3GZJg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jan 2025 18:32:30 +0100
Subject: [PATCH 1/2] dt-bindings: arm: airoha: Add the pbus-csr node for
 EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-en7581-pcie-pbus-csr-v1-1-40d8fcb9360f@kernel.org>
References: <20250115-en7581-pcie-pbus-csr-v1-0-40d8fcb9360f@kernel.org>
In-Reply-To: <20250115-en7581-pcie-pbus-csr-v1-0-40d8fcb9360f@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

This patch adds the pbus-csr document bindings for EN7581 SoC.
The airoha pbus-csr block provides a configuration interface for the
PBUS controller used to detect if a given address is on PCIE0, PCIE1 or
PCIE2.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/arm/airoha,en7581-pbus-csr.yaml       | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-pbus-csr.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-pbus-csr.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..80b237e195cd3607645efe3fda1eb6152134481c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-pbus-csr.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/airoha,en7581-pbus-csr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Pbus CSR Controller for EN7581 SoC
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The airoha pbus-csr block provides a configuration interface for the PBUS
+  controller used to detect if a given address is on PCIE0, PCIE1 or PCIE2.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - airoha,en7581-pbus-csr
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      syscon@1fbe3400 {
+        compatible = "airoha,en7581-pbus-csr", "syscon";
+        reg = <0x0 0x1fbe3400 0x0 0xff>;
+      };
+    };

-- 
2.48.0


