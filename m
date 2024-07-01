Return-Path: <linux-pci+bounces-9508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A291DC52
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 12:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAADDB24D5A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0400013DDCC;
	Mon,  1 Jul 2024 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nie7mjI/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9413D509;
	Mon,  1 Jul 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829348; cv=none; b=qDkVSdC6kOLHyd+gdiIHpMceupiGkIu8N+mIX+rusAgmv2Qqc8w4tFwUpSljtPKHOkiz/nZ0TAA+GkvUUQ5zcvVtjKjTHkTxDbldTIjVFNVzb7pcUrCJt7PTwR2leuxvuECmmH2RQ4KgpWvCsY1hvrAYPVLf3UMmiJjpJzHfEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829348; c=relaxed/simple;
	bh=MjyMtPaZVuD0Z6wqIHpemEK/DoVlHQzRt7puJi5S2Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6GQCZouPjs5JdB4LLkeIoTqKmlqGJ9cmXLeeGz6GF27RF+zVKbzAtOILJbyVSciVEslMthiY7RlBR0EkHv5ThnUIH9zeCpuyTh16+9EWtCczj9e7nkDZHdqlc8BGuXbdOXEgVgoK6QCzK1AWdI8ilOv+hrAt++odp0zS5i5ngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nie7mjI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFCBC116B1;
	Mon,  1 Jul 2024 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829348;
	bh=MjyMtPaZVuD0Z6wqIHpemEK/DoVlHQzRt7puJi5S2Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nie7mjI/+SSf6NcLBX/iv5H1Q6+bugsxFnFQkbBIOxm3hQMLafc6pNROgH8RrknED
	 hyMtBz2aoXT041CkPCU1cS+rTjRAvARlgMOGm/0n+rniVBrDk4xk9RldXEbYCZHhi5
	 lzUPCd/I2NDYYVmbvXZa9KLiMhs7CoHhRcpLMzE2gMA+ZOZo/Qf2Rqr6A3OPN4vI07
	 wvbdHuf+eU86+2AVHSW3jUylNNLkytyNZmG7PRdNLsF/etZnKKvH/TWfiqG67Daaxh
	 QJhjs2poEyI+THsz76Ht0G6aYmPlta0vgTKKvnlae/nob1mPEqjWzYyL3M2OE1obAm
	 d4NcQO/prdsLw==
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
Subject: [PATCH v3 1/2] dt-bindings: PCI: microchip,pcie-host: fix reg properties
Date: Mon,  1 Jul 2024 11:22:11 +0100
Message-ID: <20240701-decree-throat-2238adb61acf@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701-plant-tycoon-db11909036e6@spud>
References: <20240701-plant-tycoon-db11909036e6@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2333; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=9w7mSxB4cV+/l1aoDmuzpu040t1433c6QNWoIjuMOP4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlNzSHfPod9zb2z80dEZqTUlPn7tXo/1KnLJSzILfa1T ypn/Lyno5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABOxWMvIMOv3+zPs0hPOnenj eqjNyrmqXf5r/JTDE0UjVNxWiK/csoqR4XS1/1Nlmwf3HDO25lqH8m/w2Fw89/nC3myBFR6//8k yMgAA
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


