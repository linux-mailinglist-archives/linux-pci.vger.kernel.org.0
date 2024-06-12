Return-Path: <linux-pci+bounces-8657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE359050FC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 12:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236EB1F2264D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5416F0E9;
	Wed, 12 Jun 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE7yr0fq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005516E888;
	Wed, 12 Jun 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189899; cv=none; b=K3njgxCaQ2PDh0Qo7PQIHt4fBpvIoeIMBNqDlG136US4KZl6ZYIXFp3CxOC5+cstJR2QIC5dQz/l9iKhgOEbjLKzsMPFbfJEGeN5unaweLmKMAa2dxB2dQAQTcL9d2kI/XCaICTjOZLe4ZvH837zgOjVlWYXYfEQfDt3zlytRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189899; c=relaxed/simple;
	bh=+Yi0jjqYfBbPxGRxZzY+ydtBuIsu5wJYIHZ0/rprn7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfbrulKwHHAks8Jv0GvfkNv4lZV9zKays5bgihh9jf/9bDxw/pJI1FryNlqyPs4cVx42LfjsuGtRnawSCEczXhoQaGM21NPq/KNvXuWe1Yc9yB38REth0r9R46DuSRpZUrAf7ZkIOyl/aLoMUmraRd9HttoGqnRu+Yk3Ht8+/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE7yr0fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CF8C3277B;
	Wed, 12 Jun 2024 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718189899;
	bh=+Yi0jjqYfBbPxGRxZzY+ydtBuIsu5wJYIHZ0/rprn7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QE7yr0fqlGqUra8NvcJqz8fEb05PxaxRaIiPChvuQ0zjoRbH0Ly0wgVg0mXO7Voze
	 RCH/dTrjdgsunXEXv/6wm+ImmlRt+zPh6mtOa6gvpg7hpd62DRcWpqmjK6c4wqW8sq
	 GthMj6ppfwAvSm9Gcgn961NusEuydmAUh3GtQSLRv74a7DejfqpdTiA43WQdJieLsj
	 /oYMm+Ee84hfgR/sTU3n/nHpTdNLVrlAFZUf9a1YTH1x64v3/UXhlWqsJneUVdN9Uy
	 YOH4H1+Mbuz/0AwOCKjBbRluYvDaT70/1GSikcBA5Y6plGurnAXO3cyqXYQ9igSt7g
	 q7YgFPKNplnfQ==
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
Subject: [PATCH v2 1/2] dt-bindings: PCI: microchip,pcie-host: fix reg properties
Date: Wed, 12 Jun 2024 11:57:55 +0100
Message-ID: <20240612-shrubs-liquid-95ed126a5544@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612-outfield-gummy-388a36d95100@spud>
References: <20240612-outfield-gummy-388a36d95100@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2276; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=1DNLyBuR4XfdD95GkmoKOfrX8zMMBVl6oGQVomfer1w=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmZ9cbzrr3dFpsc2LEhdN3bb1v8Ll8//v6j5MFNna+/N 8e/TzI61VHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJWIow/OH+pJGQlGF0zuIW m3USlz/v3LKpTyu3Zi+98qRjU7HM1m2MDPdWPtLiC86S6EwtEXD5er4zMfPIn/WaF9SjTqXL2OZ cYQEA
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


