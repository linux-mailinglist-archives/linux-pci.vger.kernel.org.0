Return-Path: <linux-pci+bounces-35225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947DAB3D92A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 07:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E647AAB87
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715224BBEE;
	Mon,  1 Sep 2025 05:59:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D688E245028;
	Mon,  1 Sep 2025 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706368; cv=none; b=cwrzOjxp55vobVCoSWzrnGblPnIPnEv0R7C3sYSHXeM2e+C15mtZRFhm+onK/J7DP0fl7sDJ2HKbzKTTFmfJv/902t7u1bQqe/CVU8Wbe8tHnncz4I4wyKa1/S4PH7dPfvS+ZPJNY8/oX5wMwrg+GEOkWbZ+4gC6jHFMFqOqyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706368; c=relaxed/simple;
	bh=Sy0T29EIjJ0Zm/h/DvmXiOeLHZxY0FrkAieF793ApFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dstEFZGwowh4dlmab9TCCQ93G4L26H8Vg0LY2PY2yjVkAPBiRc3RUoC1cL+NwasFLqd5T8D1KimZ154v++JTz5oKSQkUvyIj9uDwGVWMIpLu/rOBmoYO8402JEOm9/M/qrCAN8S8o0ARMERVJK2CvLtd8MK5oFLIYyRMigf10MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 13:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 13:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <openbmc@lists.ozlabs.org>,
	<linux-gpio@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH v3 01/10] dt-bindings: soc: aspeed: Add ASPEED PCIe Config
Date: Mon, 1 Sep 2025 13:59:13 +0800
Message-ID: <20250901055922.1553550-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
References: <20250901055922.1553550-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the ASPEED PCIe configuration syscon block. This shared register
space is used by multiple PCIe-related devices to coordinate and manage
common PCIe settings. The binding describes the required compatible
strings and register space for the configuration node.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../soc/aspeed/aspeed,ast2700-pcie-cfg.yaml   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml
new file mode 100644
index 000000000000..c1a90bb6a785
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/aspeed,ast2700-pcie-cfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED PCIe Configuration
+
+maintainers:
+  - Jacky Chou <jacky_chou@aspeedtech.com>
+
+description:
+  The ASPEED PCIe configuration syscon block provides a set of registers shared
+  by multiple PCIe-related devices within the SoC. This node represents the
+  common configuration space that allows these devices to coordinate and manage
+  shared PCIe settings, including address mapping, control, and status
+  registers. The syscon interface enables for various PCIe devices to access
+  and modify these shared registers in a consistent and centralized manner.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2700-pcie-cfg
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
+    soc0 {
+      #address-cells = <2>;
+      #size-cells = <1>;
+
+      syscon@12c02a00 {
+        compatible = "aspeed,ast2700-pcie-cfg", "syscon";
+        reg = <0 0x12c02a00 0x80>;
+      };
+    };
-- 
2.43.0


