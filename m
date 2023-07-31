Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0F769D58
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjGaQ5d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjGaQ5a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 12:57:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C031735;
        Mon, 31 Jul 2023 09:57:28 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-210-008.ewe-ip-backbone.de [91.248.210.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2AEFA660710D;
        Mon, 31 Jul 2023 17:57:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690822647;
        bh=P9l17piVJUVOMtrFDWF3XbJJjzW9YfC02cUrfUQr3Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cq4AIz0NCArSne8qWA437xRyJwNao1oyJKvMT2bmmMbJ4iIwZxwb+VqviLOVntxA1
         utncYdgkMoaPPJZXTiJ/GBP/OIoBipVdwfTmM5F+P/Gy1imdPHSmtiQW/AH5FPdvKJ
         4RipzABmbg3wFy9kImOZN0FRmSIXov1SPQ7k+5R4145i258RlXj204487wUikY9spS
         CPMpAP19BR48pETqGh4Gz1LGc2aB+tTFtPpB3NjJBHzYtvA6VZqy/0aKhL3XK0OUEL
         jsWYA+hQqJxPU3efncwYHdSFqaL7F3vI4zJ8NNRc+Sf2iWaSqmoaUZRg0RTXc2JUyw
         9q0z9aiH/VxdQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 28DFA4800A2; Mon, 31 Jul 2023 18:57:25 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 1/5] dt-bindings: PCI: dwc: improve msi handling
Date:   Mon, 31 Jul 2023 18:57:19 +0200
Message-Id: <20230731165723.53069-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731165723.53069-1-sebastian.reichel@collabora.com>
References: <20230731165723.53069-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow missing "msi" interrupt, iff the node has a "msi-map" property.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie.yaml        | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 1a83f0f65f19..d2b4fb8f6dcd 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -25,6 +25,15 @@ select:
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
+  - if:
+      not:
+        required:
+          - msi-map
+    then:
+      properties:
+        interrupt-names:
+          contains:
+            const: msi
 
 properties:
   reg:
@@ -193,9 +202,6 @@ properties:
           oneOf:
             - description: See native "app" IRQ for details
               enum: [ intr ]
-    allOf:
-      - contains:
-          const: msi
 
 additionalProperties: true
 
-- 
2.40.1

