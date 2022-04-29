Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C409514995
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 14:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359347AbiD2MmE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359293AbiD2MmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 08:42:00 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8D0C8AA0;
        Fri, 29 Apr 2022 05:38:40 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id k12so5226656qvc.4;
        Fri, 29 Apr 2022 05:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCEAxF1XGQVI6TESeyTtKarjsI2DOXqFlQIji0+YAnU=;
        b=qAkxqmFcJ29UdhhIEfWnLEEY4/fefUsLLUudCZF2uPq6zZQuTtXwKhZTy2dPNaYBt4
         csWjjOGbRz40Sq2Yq5TAyRvG5Rud8P4S0oPpn84Fsr1e/rf+Rmd/l1g09mkZNg7aZfFD
         1wGlBt790JFkEOwkb7OfyuzWXmxfmelzIF+HszURttaia1JcxrqwDYYFq2ngN/z4IP5/
         AA8wQRHc/+l6O6I4zCLTPFoqb9Kf3HtcajY8ZdluFy4+6aEWJzBzyv/KL8jwEh/KPtW+
         x+PKFJJ6nCtBZM2fEC6ReXun/Imd0icK9uFZF11YPssgnnACxXPBnBsV88h6lulTNjsQ
         ozBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCEAxF1XGQVI6TESeyTtKarjsI2DOXqFlQIji0+YAnU=;
        b=BhrK9X0g9V6VklsnmwQcJTPy2Bx1Kl2NSExD4x7EqtjaJ+iVG2M7KZD+tRBC1SJ7N6
         Vb4bpBqz0WVSRkozNT3Mj4bmw6sS2aycTacn6+2DS6fKEmXi8bMMM9svVgRSdnFjLA9n
         fVkqq1tT9jOKU6qyxDwDdWW/ws7RNUY9baShtel1XoJSSk8Ok3cYvcgGBalILEWsWho/
         ZzDiYCw0BxcVBLT9iGctvPmkQC02of/HHL9pTvDxl7srurbqUD2pwRz9vRcwPGoyW3x2
         wqzlg76oblS/32PoCPYvqZf1WcaoiGfuU7bgwrstkgeo/O0nDgId44X/aS64vcwcypW/
         XdyQ==
X-Gm-Message-State: AOAM5333Ia/cfuu2q6RbAJuHNI5QewQBXMSPwsWJMp18XaOUFxEmwCYO
        LqxqqYZYqjmjAZTQ43niXB1SyiiFwiRpOHPb
X-Google-Smtp-Source: ABdhPJzo3JwBaRrRayU2eJjKNV4wT5sAuKmjJsRBD3D0SduanmReOc+dv0Hukxj42aPIC8fMQe81Zw==
X-Received: by 2002:a05:6214:2b09:b0:446:7c3a:92c0 with SMTP id jx9-20020a0562142b0900b004467c3a92c0mr27176034qvb.87.1651235919741;
        Fri, 29 Apr 2022 05:38:39 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v126-20020a37dc84000000b0069f9c375519sm1431644qki.46.2022.04.29.05.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:38:39 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 1/5] dt-bindings: PCI: Remove fallback from Rockchip DesignWare binding
Date:   Fri, 29 Apr 2022 08:38:27 -0400
Message-Id: <20220429123832.2376381-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429123832.2376381-1-pgwipeout@gmail.com>
References: <20220429123832.2376381-1-pgwipeout@gmail.com>
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

The snps,dw-pcie binds to a standalone driver. It is not fully
compatible with the Rockchip implementation and causes a hang if it
binds to the device.

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

