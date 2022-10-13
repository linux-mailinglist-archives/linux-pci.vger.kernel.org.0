Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D05FD4F3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 08:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJMGjN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 02:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJMGjM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 02:39:12 -0400
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 23:39:11 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC28713B8C5;
        Wed, 12 Oct 2022 23:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665642436;
    s=strato-dkim-0002; d=ibv-augsburg.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Zf6K0w0MwGi6+CgAd+H4XVP5QSRyk5X8tLOscIzRNgY=;
    b=YdjxwH9ktRPpuiHNYwPIp5dw4BwRrrLNCPNbXlspgpYEx8a364IuqjNo6mwyxg6slw
    wiP0H48X9tbyLjnF9f/wP1zMEuHQcuS+SXTfhaTH1k/fAiWqCQbe5ekk2aGBRUWgxcko
    ZiBk1r+v3D8FzTRgoHxAW3+/I3crLzwozbfdmYCrDlD0I5ipJ7FfHgb4rOcKAbwcTGG9
    HMhXdhVkSbZ7t4HgrO2ah69Ap1psV4HpQojUQkGe0qNwZ63/ZoHuEqXkn5wb2vYE+Q1I
    dhHoSLkVNut7oSTbJ3/VdqDEbGK0K9FyY65iKtPUKa/WBjFNUZeh52Z27rdEBmt0z175
    ZW+w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+8odoEkA=="
X-RZG-CLASS-ID: mo01
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id R6cb4ey9D6RGC0X
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 13 Oct 2022 08:27:16 +0200 (CEST)
From:   Dominic Rath <dominic.rath@ibv-augsburg.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tjoseph@cadence.com
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Bahle <bahle@ibv-augsburg.de>,
        Dominic Rath <rath@ibv-augsburg.de>
Subject: [PATCH 1/3] dt-bindings: PCI: cdns: Add PHY latency properties
Date:   Thu, 13 Oct 2022 08:26:47 +0200
Message-Id: <20221013062649.303184-2-dominic.rath@ibv-augsburg.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
References: <20221013062649.303184-1-dominic.rath@ibv-augsburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Bahle <bahle@ibv-augsburg.de>

Add "cdns,tx-phy-latency-ps" and "cdns,rx-phy-latency-ps" DT bindings for
setting the PCIe PHY latencies.
The properties expect a list of uint32 PHY latencies in picoseconds for
every supported speed starting at PCIe Gen1, e.g.:

  max-link-speed = <2>;
  tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
  rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */

There should be a value for every supported speed.

Signed-off-by: Alexander Bahle <bahle@ibv-augsburg.de>
Signed-off-by: Dominic Rath <rath@ibv-augsburg.de>
---
 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 ++
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |  2 ++
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 20 +++++++++++++++++++
 .../bindings/pci/cdns-pcie-host.yaml          | 20 +++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index e6ef1012a580..ce239da3a592 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -45,6 +45,8 @@ examples:
                 max-functions = /bits/ 8 <8>;
                 phys = <&pcie_phy0>;
                 phy-names = "pcie-phy";
+                cdns,tx-phy-latency-ps = <138800 69400>;
+                cdns,rx-phy-latency-ps = <185200 92600>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index 293b8ec318bc..a7f4e3909c51 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -70,6 +70,8 @@ examples:
 
             phys = <&pcie_phy0>;
             phy-names = "pcie-phy";
+            cdns,tx-phy-latency-ps = <138800 69400>;
+            cdns,rx-phy-latency-ps = <185200 92600>;
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
index baeafda36ebe..95ea273372d1 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
@@ -21,4 +21,24 @@ properties:
     maximum: 32
     default: 32
 
+  cdns,tx-phy-latency-ps:
+    description:
+      The PHY latencies for the TX direction applied to the PTM timestamps. Most
+      PCIe PHYs have asynchronous latencies for their RX and TX paths. To obtain
+      accurate PTM timestamps, the PCIe PTM specification requires that the time
+      at which the first serial bit is present on the serial lines be taken.
+      Should contain picosecond latency values for each supported speed,
+      starting with Gen1 latency.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  cdns,rx-phy-latency-ps:
+    description:
+      The PHY latencies for the RX direction applied to the PTM timestamps. Most
+      PCIe PHYs have asynchronous latencies for their RX and TX paths. To obtain
+      accurate PTM timestamps, the PCIe PTM specification requires that the time
+      at which the first serial bit is present on the serial lines be taken.
+      Should contain picosecond latency values for each supported speed,
+      starting with Gen1 latency.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
index a944f9bfffff..66f5a6449e1e 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
@@ -32,6 +32,26 @@ properties:
     default: 32
     deprecated: true
 
+  cdns,tx-phy-latency-ps:
+    description:
+      The PHY latencies for the TX direction applied to the PTM timestamps. Most
+      PCIe PHYs have asynchronous latencies for their RX and TX paths. To obtain
+      accurate PTM timestamps, the PCIe PTM specification requires that the time
+      at which the first serial bit is present on the serial lines be taken.
+      Should contain picosecond latency values for each supported speed,
+      starting with Gen1 latency.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  cdns,rx-phy-latency-ps:
+    description:
+      The PHY latencies for the RX direction applied to the PTM timestamps. Most
+      PCIe PHYs have asynchronous latencies for their RX and TX paths. To obtain
+      accurate PTM timestamps, the PCIe PTM specification requires that the time
+      at which the first serial bit is present on the serial lines be taken.
+      Should contain picosecond latency values for each supported speed,
+      starting with Gen1 latency.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
   msi-parent: true
 
 additionalProperties: true
-- 
2.36.0

