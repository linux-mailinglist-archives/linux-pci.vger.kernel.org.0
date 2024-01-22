Return-Path: <linux-pci+bounces-2409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0955835B34
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 07:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81614B25A5B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 06:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5979E3;
	Mon, 22 Jan 2024 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VxAozyKk"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BBF9C4;
	Mon, 22 Jan 2024 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905917; cv=none; b=Y3uwBgVZG4DIcP1LgPoHekRFbWPscZEMyIclkQwhulWH+7xnHO7+VbM45oq6g6xNf4rr3+MzpKg6ZGpxsoH+wEofxSJbZ/DJBOD2PS6dZkOOUbvCoUlcCYNTZVpcM26ge6l8Oau96FlJFjEMQCZq/FA7WE0JWzwsvptufTlmy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905917; c=relaxed/simple;
	bh=u4jJaaRIZOlrsFr7eaMTItXjgdXSz580j+gTB9Sm8es=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kLgV/xnSOPZzlhSNCXs78vNk2eDAG2zi/qh4mpaXh6MlV6JSF5UIWeoY1Z2CTkpae256Y2BtGZiL0LXUDxcpil7zxZV0t6TG/6aznPuWb+sItG7uorXeoIShCN/NhTj1Mm0H3bRtmJMNhTS48sW9M89jeEYiu3BdjEcVHv05Rew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VxAozyKk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40M6j3OW033655;
	Mon, 22 Jan 2024 00:45:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705905903;
	bh=Mtz0KU1wEit+CTv62UpJDF7oKSsLQo5fLRospjPQq74=;
	h=From:To:CC:Subject:Date;
	b=VxAozyKkUPgpZy4QTknPBolpPP9BBl+dTJftKnMz7jBpiHtYFb4a30T1RnjoJWfWG
	 AWmrhDZ9oydyQIUN2vbaHpDPqXRIiAiR6YXxeV1zElJu3kHV51KiMbd4eGRdbOc1co
	 XMTy/qq9FEHWHGyuT8Q7WAep9oBJBYg3bEDRCptc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40M6j2tQ012528
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 00:45:03 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 00:45:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 00:45:01 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40M6ivkB127922;
	Mon, 22 Jan 2024 00:44:58 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] dt-bindings: PCI: ti,j721e-pci-host: Add support for J722S SoC
Date: Mon, 22 Jan 2024 12:14:57 +0530
Message-ID: <20240122064457.664542-1-s-vadapalli@ti.com>
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

This patch is based on linux-next tagged next-20240122.

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

 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index b7a534cef24d..a7b5c4ce2744 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - const: ti,j721e-pcie-host
+      - const: ti,j722s-pcie-host
       - const: ti,j784s4-pcie-host
       - description: PCIe controller in AM64
         items:
-- 
2.34.1


