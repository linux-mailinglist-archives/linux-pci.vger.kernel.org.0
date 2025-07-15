Return-Path: <linux-pci+bounces-32106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F5B04F49
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 05:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32AD18955E4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 03:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91DF2D239D;
	Tue, 15 Jul 2025 03:43:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09892D12E9;
	Tue, 15 Jul 2025 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551008; cv=none; b=SLIdB1EYI1uxwJJqTKeXez6p1Ht934lSz4ENcvlXl8JQmxHaYkf+3Nn8ZtZNzDfzZjicXCQyW2OWIvTxpcycSHN/xOIVrlbRGn6nIbZvlfSsAQhQs1HLnhmRx8vLNvHBRKaQVvE3F3+dPT2d5RFLHlyVG7QGwXIAZUlZQIZYiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551008; c=relaxed/simple;
	bh=y2DhT8R0ne8NBgP2oAmQXnxUXIXvVpOb73za3zmK/uI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOiWuPKtva4xpSazr1EEbnikz0E5Qcz9NkbjcJsr+UcHrf0gLqyJeUCwxKguUchDl/xLCTfZpYGQsqAM/iFIJbQlfl5cROnYRn6z+WEXA8GveVTR87JX1eQJK7uixoxnWl0c7UUVOLZYUJcjSvKrL+yWR8CVxejO8K3MXbh/95g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 15 Jul
 2025 11:43:20 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 15 Jul 2025 11:43:20 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
	<linus.walleij@linaro.org>, <p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 01/10] dt-bindings: soc: aspeed: Add ASPEED PCIe Config support
Date: Tue, 15 Jul 2025 11:43:11 +0800
Message-ID: <20250715034320.2553837-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
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
 .../bindings/soc/aspeed/aspeed,pcie-cfg.yaml  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-cfg.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-cfg.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-cfg.yaml
new file mode 100644
index 000000000000..6b282f06b914
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-cfg.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/aspeed,pcie-cfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED PCIe Configuration
+
+maintainers:
+  - Jacky Chou <jacky_chou@aspeedtech.com>
+
+description: |
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
+          - aspeed,pcie-cfg
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
+    syscon@1e770000 {
+      compatible = "aspeed,pcie-cfg", "syscon";
+      reg = <0x1e770000 0x80>;
+    };
-- 
2.43.0


