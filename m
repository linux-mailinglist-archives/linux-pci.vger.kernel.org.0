Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ABD53457C
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 23:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbiEYVB2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344387AbiEYVB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 17:01:26 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2CE35DC7;
        Wed, 25 May 2022 14:01:25 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id v9so209oie.5;
        Wed, 25 May 2022 14:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NERPmbwTzBChrPsowWF6RmFptD7+Ry/DNfWY86KTjjU=;
        b=z/1dQUVzwtzYw/ORW5MI1uz4k4fK8OywHfQmLMv02MoLiVrZN/Ag+gohnxuitPPZBP
         I84zVMNLtCjTvAv510oYNXwSDt+WD5Qpr8L++my8ZRKwb+TeBBXPNGdJlYcZSeOStP42
         gD/4LCOygcKb5ru6NQYgMOiONy8IV4jdC7RdHUaJpppmTGk+4WfydfR62qbM7dG+Kboj
         W4XanN+LsfmW5OKmG9PxgVZWPGXXAHf05t9NAAQqdHBeibxI8mlSfOZ3wPdBXgP4qMln
         idKki0iIKIfaIwYzjMokJQMJVY4yoIlSWswSTpcQtkPAIDKCPR2eqcIO8aPu/fjDBlXF
         KSdw==
X-Gm-Message-State: AOAM530NEXV4wvOaiC4avSJKgDGkw7B7xr/98oy/KdKFF3vwQ+7fnVoE
        JG9JXjoamisAwliY58A8WQ==
X-Google-Smtp-Source: ABdhPJxaVFL7Fsh+968JB8tK+h2m4gzaufKRBXVWxvM+S6/Z8jChESAgY1ZPw1Ue0VOYEUpSj1zuVA==
X-Received: by 2002:a05:6808:1a1e:b0:326:3846:c4a1 with SMTP id bk30-20020a0568081a1e00b003263846c4a1mr6597279oib.80.1653512484496;
        Wed, 25 May 2022 14:01:24 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t16-20020a9d5910000000b00606aa4d5fcfsm6508340oth.29.2022.05.25.14.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:01:23 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Add missing child interrupt controller
Date:   Wed, 25 May 2022 16:01:16 -0500
Message-Id: <20220525210117.2489333-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Socionext interrupt controller internal to the the PCI block isn't
documented which causes warnings when unevaluatedProperties check is
also fixed. Add the 'interrupt-controller' child node and properties and
fixup the example so that interrupt properties can be parsed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/socionext,uniphier-pcie.yaml | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
index f5926d0fb085..638b99db0433 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
@@ -51,6 +51,19 @@ properties:
   phy-names:
     const: pcie-phy
 
+  interrupt-controller:
+    type: object
+    additionalProperties: false
+
+    properties:
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 1
+
+      interrupts:
+        maxItems: 1
+
 required:
   - compatible
   - reg
@@ -62,6 +75,13 @@ unevaluatedProperties: false
 
 examples:
   - |
+    bus {
+        gic: interrupt-controller {
+            interrupt-controller;
+            #interrupt-cells = <3>;
+        };
+    };
+
     pcie: pcie@66000000 {
         compatible = "socionext,uniphier-pcie";
         reg-names = "dbi", "link", "config";
@@ -80,6 +100,7 @@ examples:
         phys = <&pcie_phy>;
         #interrupt-cells = <1>;
         interrupt-names = "dma", "msi";
+        interrupt-parent = <&gic>;
         interrupts = <0 224 4>, <0 225 4>;
         interrupt-map-mask = <0 0 0  7>;
         interrupt-map = <0 0 0  1  &pcie_intc 0>,
@@ -87,7 +108,7 @@ examples:
                         <0 0 0  3  &pcie_intc 2>,
                         <0 0 0  4  &pcie_intc 3>;
 
-        pcie_intc: legacy-interrupt-controller {
+        pcie_intc: interrupt-controller {
             interrupt-controller;
             #interrupt-cells = <1>;
             interrupt-parent = <&gic>;
-- 
2.34.1

