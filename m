Return-Path: <linux-pci+bounces-2260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE8C83037D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53EA1C2082A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378714AA7;
	Wed, 17 Jan 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gkm45FAU"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA131426B;
	Wed, 17 Jan 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487157; cv=none; b=eN22C6qVoeFgdXRLPW79SPWGfxoysRKw4AJv4+y+uieqEYfe9Gw5/DZSbRqyA24Ls36qnveuLQZDQotZmwxDON/glYOEjVtAw7mZfd5uA5AGS5zFqOBH6NRnFgKiFZMDCIAdH6SvxNQiq2c9vI/65Ug9eTXhkaGWXedCAccazmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487157; c=relaxed/simple;
	bh=zEq/Rqwzz58yugJ7O6HFCLNcp/L546wF05MutcUd85w=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EXCLAIMER-MD-CONFIG; b=qQxNJF7kdNLlhPWe96DsCKlZ7ncy4ix9mHOpAuB1YG2Wkmvp76a0Q9q9qjpG4os58uhiINQ/J8lTKAyP2+bJvNkHt13LTJ03IM0ZEML8wP1N6CfXq9oj0DVZSAFPkTdqkyN7TjFhOlvmUZTfRg5jd9j5ORlkMVkwG28AzrhBIQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gkm45FAU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HAPePa114425;
	Wed, 17 Jan 2024 04:25:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705487140;
	bh=5ebXy5GPqux5fMHU7cuSKJ1s77z14M6gC1nB/S0E6pA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gkm45FAU84k14nOb8OKdn8czXYJz7CWNcFkP0hsUe1oGo9EIfeyLWttDl5hXOjpZh
	 vROkeg940FPWf7C/MvhxAdrh/S49MRQZ+QnKTbz4U6GSJX5Dj32GiBsYDfrJInuGKC
	 Js4c89rPn5Y418HgR2ffL/WU/F4CpciwXXxvu3n8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HAPexv035508
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 04:25:40 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 04:25:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 04:25:40 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HAPQIh042834;
	Wed, 17 Jan 2024 04:25:36 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 2/3] dt-bindings: PCI: ti,j721e-pci-*: Add checks for max-link-speed
Date: Wed, 17 Jan 2024 15:55:25 +0530
Message-ID: <20240117102526.557006-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117102526.557006-1-s-vadapalli@ti.com>
References: <20240117102526.557006-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Extend the existing compatible based checks for validating and enforcing
the "max-link-speed" property.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml          | 8 ++++++++
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml        | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 278e0892f8ac..4839a9574e20 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -73,6 +73,8 @@ allOf:
             - const: ti,j721e-pcie-ep
     then:
       properties:
+        max-link-speed:
+          const: 2
         num-lanes:
           const: 1
 
@@ -84,6 +86,8 @@ allOf:
             - const: ti,j721e-pcie-ep
     then:
       properties:
+        max-link-speed:
+          const: 3
         num-lanes:
           minimum: 1
           maximum: 2
@@ -95,6 +99,8 @@ allOf:
             - const: ti,j721e-pcie-ep
     then:
       properties:
+        max-link-speed:
+          const: 3
         num-lanes:
           minimum: 1
           maximum: 4
@@ -106,6 +112,8 @@ allOf:
             - const: ti,j784s4-pcie-ep
     then:
       properties:
+        max-link-speed:
+          const: 3
         num-lanes:
           minimum: 1
           maximum: 4
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 36bcc8cb7896..005546dc8bd4 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -102,6 +102,8 @@ allOf:
             - const: ti,j721e-pcie-host
     then:
       properties:
+        max-link-speed:
+          const: 2
         num-lanes:
           const: 1
 
@@ -113,6 +115,8 @@ allOf:
             - const: ti,j721e-pcie-host
     then:
       properties:
+        max-link-speed:
+          const: 3
         num-lanes:
           minimum: 1
           maximum: 2
@@ -124,6 +128,8 @@ allOf:
             - const: ti,j721e-pcie-host
     then:
       properties:
+        max-link-speed:
+          const: 3
         num-lanes:
           minimum: 1
           maximum: 4
@@ -135,6 +141,8 @@ allOf:
             - const: ti,j784s4-pcie-host
     then:
       properties:
+        max-link-speed:
+          const: 3
         num-lanes:
           minimum: 1
           maximum: 4
-- 
2.34.1


