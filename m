Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAE83CEF12
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhGSV0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 17:26:47 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:38474 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388871AbhGSVXS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 17:23:18 -0400
Received: by mail-il1-f181.google.com with SMTP id s5so10418947ild.5;
        Mon, 19 Jul 2021 15:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzlQxVexFT0nXKu400I5otv1xS1kX5e7p5IFCKmC89Y=;
        b=bb9a7HluwskF/TsSO8yL6ED15xvhBp5iyeHRX2rv5wH7siOBM++Sd7xZCBNh176q0p
         IoKU9g7gG9u442xrIrLoz2lOBxe/HWbhwgq+w3PnynR+t0UJ6zPwPO6ZAJMoyt2zm3Or
         9yu7nGuKNI6lLdYdnR1+sDhOvNJKzUdU5ZahniBipggWqQlW8pUS4b+OyFckoiQ0v5wM
         UiIs3xpMblfr6wTXM5JlJv6LzSGrZLVjbZ7wpfnOSuhnp9WXKAhEA1uOA8pNHdeAY8f0
         2MBoHIhQPEfd7TslGtG5UBRsIkomVzKwH9LndZQQ+2vi4WKC0OCw2cgCfGdpi7Uzc3uO
         agdw==
X-Gm-Message-State: AOAM533EnTMqVgJb4ffrxnlTt1kRwlRJMBhW3IpkQCsyMvzkGYF7hDGA
        vRY3f4hn2oXQE8EyC8j/DwWueUEWcg==
X-Google-Smtp-Source: ABdhPJzoKMbKmAb3ccakj6Vj9GEZRfR9hVNWLZmDghEpm/GdIZYC6nPCY4IPFscWPOJFp1koKn/oAw==
X-Received: by 2002:a92:3209:: with SMTP id z9mr18796486ile.115.1626732235559;
        Mon, 19 Jul 2021 15:03:55 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id e17sm9973095ilr.51.2021.07.19.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:03:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: intel,lgm-pcie: Add reference to common schemas
Date:   Mon, 19 Jul 2021 16:03:51 -0600
Message-Id: <20210719220351.2662758-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a reference to snps,dw-pcie.yaml (and indirectly pci-bus.yaml) schemas.
With this, the common bus properties can be dropped from the schema.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dilip Kota <eswara.kota@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
This applies on top of Mauro's snps,dw-pcie.yaml series which I've 
applied to the DT tree.

 .../bindings/pci/intel-gw-pcie.yaml           | 34 +++----------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
index a1e2be737eec..e15730d31274 100644
--- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
@@ -17,21 +17,15 @@ select:
   required:
     - compatible
 
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
 properties:
   compatible:
     items:
       - const: intel,lgm-pcie
       - const: snps,dw-pcie
 
-  device_type:
-    const: pci
-
-  "#address-cells":
-    const: 3
-
-  "#size-cells":
-    const: 2
-
   reg:
     items:
       - description: Controller control and status registers.
@@ -62,30 +56,13 @@ properties:
   reset-gpios:
     maxItems: 1
 
-  linux,pci-domain: true
-
   num-lanes:
     maximum: 2
-    description: Number of lanes to use for this port.
-
-  '#interrupt-cells':
-    const: 1
-
-  interrupt-map-mask:
-    description: Standard PCI IRQ mapping properties.
-
-  interrupt-map:
-    description: Standard PCI IRQ mapping properties.
 
   max-link-speed:
-    description: Specify PCI Gen for link capability.
-    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3, 4]
     default: 1
 
-  bus-range:
-    description: Range of bus numbers associated with this controller.
-
   reset-assert-ms:
     description: |
       Delay after asserting reset to the PCIe device.
@@ -94,9 +71,6 @@ properties:
 
 required:
   - compatible
-  - device_type
-  - "#address-cells"
-  - "#size-cells"
   - reg
   - reg-names
   - ranges
@@ -109,7 +83,7 @@ required:
   - interrupt-map
   - interrupt-map-mask
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.27.0

