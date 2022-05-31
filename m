Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D2539929
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 23:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbiEaV6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 17:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiEaV6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 17:58:24 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0A153A7C;
        Tue, 31 May 2022 14:58:22 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id e11-20020a9d6e0b000000b0060afcbafa80so10530219otr.3;
        Tue, 31 May 2022 14:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/Zs+8PIbCd/OMJutphmUsMKeeLJ1n44XiDHBlBx9SE=;
        b=R0Seg0l2OFv8MARmP0PX/6xzQqW1XiJnLxKYkFptg3gTUno2ySTL+XgI+J2tjnx7oK
         yRoH4UjMikAgX3Qxevr9pVWdQeey0URK2sQW/FQhhDo6+XpewHL4PLhojS6rJXANJdvK
         bDMeGkE6q2u1DtU/Mgy+VR1L2x/ithOgAnlVVsCAYcC+hAGb5mUIBpp9pou4n33+jddG
         /nk0ddN4diP55q0QU16muPHz8HbuBGyHGm88lYWwyAXOxBLjfgDtyDUblx6efdhdtp39
         +FIsBgZHPHA+geR+TjOBeqSbPbHIIrOazle8am2sIVf6UPHbPBglYwUZp6MLtWGZ7oyB
         50yA==
X-Gm-Message-State: AOAM531lXoCYtS3fXMFiQ0Pq9rnCDxQRIl+tjSfm5gPQpndAPkcdDaP8
        1PKsve78mnyMU6noEcXc4g==
X-Google-Smtp-Source: ABdhPJxyeE7fGrYd+mpu5nb8RXc+XXbSg7BvgtMO8yEOeQgTDcq7iq1QrsdD1Vs9boKb23ES8TGGxw==
X-Received: by 2002:a9d:7093:0:b0:60b:6e32:d13a with SMTP id l19-20020a9d7093000000b0060b6e32d13amr6522046otj.85.1654034301727;
        Tue, 31 May 2022 14:58:21 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id nx18-20020a056870be9200b000f2455e26acsm4029369oab.48.2022.05.31.14.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 14:58:21 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: PCI: apple: Add missing 'power-domains' property
Date:   Tue, 31 May 2022 16:58:14 -0500
Message-Id: <20220531215815.2408477-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The 'unevaluatedProperties' schema checks is not fully working and doesn't
catch some cases where there's a $ref to another schema. A fix is pending,
but results in new warnings in examples.

The Apple PCIe host schema is missing 'power-domains' in the schema.
The example has 3 power domains. However, this is wrong too as actual
dts files have a single power domain and Sven confirmed 1 is correct.

Cc: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Correct the power-domains to be 1 and update the example
---
 Documentation/devicetree/bindings/pci/apple,pcie.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index daf602ac0d0f..aa38680aaaca 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -68,6 +68,9 @@ properties:
   iommu-map: true
   iommu-map-mask: true
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -134,7 +137,7 @@ examples:
         ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
                  <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
 
-        power-domains = <&ps_apcie>, <&ps_apcie_gp>, <&ps_pcie_ref>;
+        power-domains = <&ps_apcie_gp>;
         pinctrl-0 = <&pcie_pins>;
         pinctrl-names = "default";
 
-- 
2.34.1

