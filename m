Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF550CBB8
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiDWP1G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiDWP1F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 11:27:05 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790B35AA0;
        Sat, 23 Apr 2022 08:24:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id fu34so7552340qtb.8;
        Sat, 23 Apr 2022 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qApPth3uca4YCOXE8IxpOrj2EUsmdDr5GnAY2ojHbqA=;
        b=jT5T19XUlZImZsxepXMQHfoKPuZVtaOZC/R5qD2iqW3XVATpJ9hsq6eIygV3lhEhgq
         xAmYd4uuERjXV9meMpHb1qL2ng2BQlK4VX6mhACH8fOp/d0sv5BN7VUusVSdWv7OPkb/
         b5kwiCVUq+dxY9757TW6UYXDFaBG9Mxaq2pHanAdp2l0NbJrOb8VKCv8K/KZOmI+pS6V
         tM/ESZFs7eMoOLii5BwCk0eZmYFyOl7GOl5KjFBgkCPJDBmoD3U5U8Q4Dos7QDHPZ9Fv
         klLZkg8oXEQ9WQeQfFuib8PnyY6J6BKsSK2+ibHx+BdDWVLZpN2HTIe/cukwchmImI//
         vMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qApPth3uca4YCOXE8IxpOrj2EUsmdDr5GnAY2ojHbqA=;
        b=omhrPJXrUbz67sIWN9RzzTjJVDaCdM0ezDAlu3fD9c1RJb5d7kaM0o5VmDoxInJ7VC
         hztcMcD6JcJsB6Zw6TCOysuuFwDBJ1i9ilw8ZCm/Z5zRyGK78IY3JQuch6vwhdPoo/64
         E+oOJQImJQ/XbYAj/ExPPov5woau6ZlFNsOU02m1HBL8eQ9vKFDC3JqqvROpDkWh+b3E
         FoMUU2vsw3rAYpRR4CnC8Yj+dN5VCx0QOGf3LIBEV53vOix7CuiRVtYewoKwsfzAuxm3
         pQ117ymRF1Q+Y3JHTd6WQxxTF/2yoLKjkBbITdY7NbW/oSVBMfjUjx6X8s0+GtHu033T
         L0Jw==
X-Gm-Message-State: AOAM5330nbD1fvgB/Wx2OpPfRUIw200/JN/IkcFtRYAJOKK1RpEKD8KW
        OgKqryPNPzg93qbt7ojypPs=
X-Google-Smtp-Source: ABdhPJysNVDryTlHRk1oqkOTgUVFuZHGVHZHhjbXCXeLJ74+14HrNmnrWXj5OMA7eI7vuyYCsyd9RQ==
X-Received: by 2002:ac8:5fd5:0:b0:2f3:610c:ca02 with SMTP id k21-20020ac85fd5000000b002f3610cca02mr1943412qta.74.1650727447713;
        Sat, 23 Apr 2022 08:24:07 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id y6-20020a05622a004600b002f33ba280cbsm3184165qtw.8.2022.04.23.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:24:07 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/5] dt-bindings: pci: remove fallback from Rockchip DesignWare binding
Date:   Sat, 23 Apr 2022 11:23:59 -0400
Message-Id: <20220423152403.1681222-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423152403.1681222-1-pgwipeout@gmail.com>
References: <20220423152403.1681222-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

