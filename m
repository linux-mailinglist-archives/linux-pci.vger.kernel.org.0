Return-Path: <linux-pci+bounces-9759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB8926954
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 22:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA71C258E7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 20:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D07190058;
	Wed,  3 Jul 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiPn20wN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2A190043;
	Wed,  3 Jul 2024 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037346; cv=none; b=T9FFkdGAZicaFt2ZTDmoXg6D8M05yb7rV3Y0CMKzHxV/CpFoAZS7838IpYMtBMQQ22Oe4JvyqZzwr7mknTa3L+j3i00B1kJfE+eMXA8sWUFMOVDKE6SWo1/J1WNkwYykgoIbpWifQW2kMpCMfwdGQ6zk7FqhHUZmNh2B0kpXDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037346; c=relaxed/simple;
	bh=MjyMtPaZVuD0Z6wqIHpemEK/DoVlHQzRt7puJi5S2Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDG6rhzyFOM3Nv9Jc4xuwpU6eSH/tuErOZQSIMLObqRuo325QjhfxTuFlJCOq8u+mD7jKEJ1yx3SjGBi8pluRFsVUiiOS2lsQxb0ccLV7JlJyti73/dzXBDtykSoLNl5pidrlJYHjizqrO3xF5RwS+Ep+y0nkxn3hy9TsG8aMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiPn20wN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FC8C4AF0A;
	Wed,  3 Jul 2024 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720037345;
	bh=MjyMtPaZVuD0Z6wqIHpemEK/DoVlHQzRt7puJi5S2Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiPn20wNkOe55KwdEd1SuivsqDHrthhezjwK0Nsb5Td3izYmxNAGQGFS179QvRLqo
	 /10tcMjwvfO6FcGncMC5nu3/MPjpgTr+G4eATkrhkxd3qkEx+JqiPhEZPOo1RCm+cH
	 c+7RV2EbS77Yu3B64HdMStS6LJ+eUen/c9DsP1IeAPUfwAqO0kpU4oVarmck+QzSeJ
	 /QMmO0PMiGqNldplU68Q5O3v4NYCmXgDMU9Q1tqBvXUhwrDGl/NuFjJeje9fsTzIbr
	 GUrK5ICibzXewpUXz0YlgKS0tolyFrtO/W8NvYQERqL1qfet7rZFb0KjAEkvkjRVm5
	 Ze5aWs2O7Quug==
From: Conor Dooley <conor@kernel.org>
To: linux-pci@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: PCI: microchip,pcie-host: fix reg properties
Date: Wed,  3 Jul 2024 21:08:45 +0100
Message-ID: <20240703-geometric-dripping-2ad37edc1063@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703-stand-ferocity-bac033ac70b1@spud>
References: <20240703-stand-ferocity-bac033ac70b1@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2333; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=9w7mSxB4cV+/l1aoDmuzpu040t1433c6QNWoIjuMOP4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmt669FvluitWPS8kPHmj1qz2z8kVJjbbn3p/iDL7tiD bLT9jeyd5SyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiLHwMf/h2qR+cIJAUuiBR aurq/R/9E5gmXN+WX/OlrUnidq37DydGhr2202pY25Y6fc1VDZgVpxbfLrlH9NREfqugfpH3Zfd yOQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The PCI host controller on PolarFire SoC has multiple "instances", each
with their own bridge and ctrl address spaces. The original binding has
an "apb" register region, and it is expected to be set to the base
address of the host controllers register space. Some defines in the
Linux driver were used to compute the addresses of the bridge and ctrl
address ranges corresponding to instance1. Some customers want to use
instance2 however and that requires changing the defines in the driver,
which is clearly not a portable solution.

Remove this "apb" register region from the binding and add "bridge" &
"ctrl" regions instead, that will directly communicate the address of
these regions

Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/pci/microchip,pcie-host.yaml   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 5d7aec5f54e7..45c14b6e4aa4 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -18,12 +18,13 @@ properties:
     const: microchip,pcie-host-1.0 # PolarFire
 
   reg:
-    maxItems: 2
+    maxItems: 3
 
   reg-names:
     items:
       - const: cfg
-      - const: apb
+      - const: bridge
+      - const: ctrl
 
   clocks:
     description:
@@ -115,8 +116,9 @@ examples:
             pcie0: pcie@2030000000 {
                     compatible = "microchip,pcie-host-1.0";
                     reg = <0x0 0x70000000 0x0 0x08000000>,
-                          <0x0 0x43000000 0x0 0x00010000>;
-                    reg-names = "cfg", "apb";
+                          <0x0 0x43008000 0x0 0x00002000>,
+                          <0x0 0x4300a000 0x0 0x00002000>;
+                    reg-names = "cfg", "bridge", "ctrl";
                     device_type = "pci";
                     #address-cells = <3>;
                     #size-cells = <2>;
-- 
2.43.0


