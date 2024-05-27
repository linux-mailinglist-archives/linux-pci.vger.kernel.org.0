Return-Path: <linux-pci+bounces-7841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C978CFD27
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8D71F25DD0
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66913AD09;
	Mon, 27 May 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tZ2tHT25"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301513A87E;
	Mon, 27 May 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802686; cv=none; b=ul3mFl8t8lvrSZcNPOh8/+6nzotv1Pwx/SYT4ADnC/TnBaZfXnkU2EcnA8dHagXseDrSFGOhd7NWg7eRSVeaXja6hh0PRof20ydCMJqdcAZ8/F554TluWBN0Ou6BAwNgCn5EBS5WQVM28rTlRK3FHlw4JJO+7YgZGhCVZHn63jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802686; c=relaxed/simple;
	bh=jLxBnH+agZ/3F1Kw1anar+d5wkAwz2H+nxCeoMbZaQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDQzOmKBMvEqEPjSsafBBeC16tUI0bR/mbDLJ+c7IBKCUl41CcYjwAyprl9H9HKuK08iE7H5j5g4szqcApeDD41geQrcbN2PRNH730JUHID8Y7d7D43QdHQ5BeASgl8LIpxjYJaiEHl1COAJRF9q6GMbigGbV5hO29CV3JXtevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tZ2tHT25; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716802684; x=1748338684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jLxBnH+agZ/3F1Kw1anar+d5wkAwz2H+nxCeoMbZaQk=;
  b=tZ2tHT25YsrT22/VeCxau/sTRbt/4WyWb42jVr0Pm+4dpucbown5AglO
   g7orTZVrPrZwZyyvecJukebahePehUmNgNYXO4ygbULq15y96OQsjaGKx
   OIeqAxdEN3wwm19qK5UO8KI7v5bFUJzFPc3rRJ+32X7jJyVFeQTQvAr6d
   XeBe101eUDNJEzJQBoNQ8Bgx8tV7i/glvUUqOSv+207e5+IZl/zMWXsZS
   4NHOaZz1qBYQzGXOeOzk+0nr7SYMGCOYhRcgiXP+ec0SaQaSN0NaNTpm1
   QL6R/ZGaVULiwCj4APa43ctAa8yBdhYK1FBC7XL8UZcYXrDgSDT+1lAXB
   g==;
X-CSE-ConnectionGUID: AcSvwgxcR7OHBHrk8NTkiw==
X-CSE-MsgGUID: GoNqUEWFRCyewbpdoWyf3g==
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="193774877"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2024 02:37:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 May 2024 02:37:50 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 27 May 2024 02:37:48 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To:
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v1 1/2] dt-bindings: PCI: microchip,pcie-host: fix reg properties
Date: Mon, 27 May 2024 10:37:15 +0100
Message-ID: <20240527-algebra-pencil-c12962d62468@wendy>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240527-slather-backfire-db4605ae7cd7@wendy>
References: <20240527-slather-backfire-db4605ae7cd7@wendy>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2214; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=jLxBnH+agZ/3F1Kw1anar+d5wkAwz2H+nxCeoMbZaQk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkhId5rFl7rj1DlMDmXwiPHdV7lwN79ahr/jjs7Gtkc1LqZ 91avo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNJyWVk2PokpSn/VlUO36XrwnFqm6 aw/S2MWiX2SPFiWN+MgrMSRgz/c4RLlV7s2LeQ9e3dbyfanE6c8WXq41WtqbBw3Ht4+RMWRgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/pci/microchip,pcie-host.yaml   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 5d7aec5f54e71..45c14b6e4aa41 100644
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
2.43.2


