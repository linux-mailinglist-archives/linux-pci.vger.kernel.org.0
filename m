Return-Path: <linux-pci+bounces-2521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B577E83A9C2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 13:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F373282D76
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED27E6312D;
	Wed, 24 Jan 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GrrzSW06"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00D633EA;
	Wed, 24 Jan 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099409; cv=none; b=OrEUwKsy/OHviPn79WeIWEPbuPeuDdj2RuAZVjUj0AjoT8fbzfw9yMZZz2m1vEk2LbPCAzvdmcQL0VPq2jaU8DeUfjcdM/S9/PnCKXpeeyaMTt9AzemXaEgxHLZTaFus8gmjndW2VuRVFN4SKkGJD9Mo7K4DhXiX93MOR3+0FwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099409; c=relaxed/simple;
	bh=jTWOxO1XAaoksmE8rhYXp3rHaYDWjO/isGrkm2WxrRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fEFMH2te4jXctzfzMQE47R98ZvuDdnGKWBk8KTlyLAiY2st/ZfeoMk1DJDOHirw0BlLFA7CPZSpXLZI7EJel+SQ9VkLbsUFEo/+tbaMAldxAS1xiyeM/dA+FMAXt38JXrAd62Ajcj8pebNc9e6oPjBmu7glI0kFBr9c3bIUuKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GrrzSW06; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OCTfSf119955;
	Wed, 24 Jan 2024 06:29:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706099381;
	bh=jF9L84KMv0wHb4XbV69aBeG5tl9iTIPpMYjJbs4VL3k=;
	h=From:To:CC:Subject:Date;
	b=GrrzSW06ziO+anZC1hXgZd+snymbYsxBpDvt0Y94qVq5m7Hx+n0KMGkmblGCtB9UE
	 j50eViQ5p5ulPLcvwcm2WGmvjoi6ajkXzHuACXDha4qDFo1bX1189u9YRDb6nrBkcR
	 XtB9pQZFYm/YkVrUt/cbUvEzbn8qW3YNuAOOkS10=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OCTft8051628
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 06:29:41 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 06:29:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 06:29:41 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OCTaNb127501;
	Wed, 24 Jan 2024 06:29:37 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3] dt-bindings: PCI: ti,j721e-pci-host: Add support for J722S SoC
Date: Wed, 24 Jan 2024 17:59:36 +0530
Message-ID: <20240124122936.816142-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI's J722S SoC has one instance of a Gen3 Single-Lane PCIe controller.
The controller on J722S SoC is similar to the one present on TI's AM64
SoC, with the difference being that the controller on AM64 SoC supports
up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.

Update the bindings with a new compatible for J722S SoC.

Technical Reference Manual of J722S SoC: https://www.ti.com/lit/zip/sprujb3

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240124.

v2:
https://lore.kernel.org/r/20240122064457.664542-1-s-vadapalli@ti.com/
Changes since v2:
- Added fallback compatible for "ti,j722s-pcie-host" as
  "ti,j721e-pcie-host" based on Conor's suggestion at:
  https://lore.kernel.org/r/20240122-getting-drippy-bb22a0634092@spud/#t

v1:
https://lore.kernel.org/r/20240117102526.557006-1-s-vadapalli@ti.com/
Changes since v1:
- Dropped patches 1/3 and 2/3 of the v1 series as discussed in the v1
  thread.
- Updated patch 3/3 which is the v1 for this patch by dropping the checks
  for the "num-lanes" property and "max-link-speed" property since the PCI
  driver already validates the "num-lanes" property.

Regards,
Siddharth.

 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index b7a534cef24d..ac69deeaf1ee 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -23,6 +23,10 @@ properties:
         items:
           - const: ti,j7200-pcie-host
           - const: ti,j721e-pcie-host
+      - description: PCIe controller in J722S
+        items:
+          - const: ti,j722s-pcie-host
+          - const: ti,j721e-pcie-host
 
   reg:
     maxItems: 4
-- 
2.34.1


