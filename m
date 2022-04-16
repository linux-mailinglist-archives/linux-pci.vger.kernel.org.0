Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE59503583
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiDPJLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 05:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiDPJL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 05:11:27 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A541FBF;
        Sat, 16 Apr 2022 02:08:56 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b68so3292019qkc.4;
        Sat, 16 Apr 2022 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=MWXEQ9jODM3hyZtmPdGS10o6jlNMgjEvpfMgf9p7E+o2MKDwBEvoJk6UUS0h8ncboO
         mA4FdMn4YlL0D/N6FPYjSuODJBJWQUJryplXFCoJURCRXKMNgBTFySqGMo/XTu41c+Yj
         sOVcmr6+HYGXx9ao/oIJPlfDuX3Okmik8wG6TQX4WgHt1HZXn77XBozg0kP8rfnS1fMn
         cqlfiGLBYm4U+0DlmZfTB6VVlDwhcFfiRasXjon/JlQ39s6P5q3Qfl2KlBJYNXyp66Aj
         Uxi9SzGjggbbfS+uM2UrV72p1cbdo1bFA0wN42V6i9TjKI6ZH1nQWdD66/4FYU4BOR6k
         0iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=gblUQwbDYKqwfehIge2NznXdA+BSZjog7j+v97+2RRBnHXq/UTeIWy94h35/U8EoEb
         TRVDhQ0al1ykBoJlI6phw/GWhYcFl0FYbbfKG3obxiB5CimBesLRz0g3E+8rn1Zwc8no
         P5XtbYSegGV+oRR2cA/RwJb5LzNraO+Tu4iZiP7iJFDotxeKM4x5FwVnaH4oNtSuWiPI
         M6dKBMkeWryHebIaTF73JoEfcZYo7lqPQu++AVVqbCLAufSTR8hyVLERuT72cHNNIjwj
         1UJUJSlqW1GjRt4XpuonnivEgjvcmwrVfdqMNMfLRaohCiCOoQOFdHKsjeH6CO9YzB5c
         Hptg==
X-Gm-Message-State: AOAM5303+0KGKYKSfzgr0LFZetbPwmFTODiixUInTm2C2oekNyWFeCkR
        aoTzDzol9URwTGd990VZ7jYbzYzTqaCrccoX
X-Google-Smtp-Source: ABdhPJymvfA9CPPCM/99cI+aS1rwkZ7AzNIjDfEbRZEPTWlYFGnmRJxubbLRaiFyW4tJV9S+7nB25w==
X-Received: by 2002:a37:aacb:0:b0:69e:7821:1195 with SMTP id t194-20020a37aacb000000b0069e78211195mr533111qke.412.1650100135798;
        Sat, 16 Apr 2022 02:08:55 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85893000000b002e1afa26591sm4630394qta.52.2022.04.16.02.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 02:08:55 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: pci: remove fallback from Rockchip DesignWare binding
Date:   Sat, 16 Apr 2022 05:08:41 -0400
Message-Id: <20220416090844.597470-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416090844.597470-1-pgwipeout@gmail.com>
References: <20220416090844.597470-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The snps,dw-pcie binds to a standalone driver.
It is not fully compatible with the Rockchip implementation and causes a
hang if it binds to the device.

Remove this binding as a valid fallback.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml    | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 142bbe577763..bc0a9d1db750 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -19,20 +19,10 @@ description: |+
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
 
-# We need a select here so we don't match all nodes with 'snps,dw-pcie'
-select:
-  properties:
-    compatible:
-      contains:
-        const: rockchip,rk3568-pcie
-  required:
-    - compatible
-
 properties:
   compatible:
     items:
       - const: rockchip,rk3568-pcie
-      - const: snps,dw-pcie
 
   reg:
     items:
@@ -110,7 +100,7 @@ examples:
         #size-cells = <2>;
 
         pcie3x2: pcie@fe280000 {
-            compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
+            compatible = "rockchip,rk3568-pcie";
             reg = <0x3 0xc0800000 0x0 0x390000>,
                   <0x0 0xfe280000 0x0 0x10000>,
                   <0x3 0x80000000 0x0 0x100000>;
-- 
2.25.1

