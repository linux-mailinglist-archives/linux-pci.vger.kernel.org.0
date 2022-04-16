Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7EB50356E
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiDPJEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 05:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiDPJEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 05:04:37 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B691066E3;
        Sat, 16 Apr 2022 02:02:05 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c1so7843543qvl.3;
        Sat, 16 Apr 2022 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=SHRbg8x/2JHNnkBOV6/ilD2huqCqpDRTm3pEUP94q1dA2HF25/mbncfBO60ybBMK9J
         CTgU1fn0th7wGA2m5qEt63IR+sdTKmR4Fz64scgnCymkfwelCNkxCGaf5V4GdM53zd09
         FgGi/n1PomtpcTp4G5bYD6ssSTtgTdaBR1mN/Z6ZS8ECfqArA2cGVwnka/i5L7wKkkkK
         nH1vc/EKfUo4oGpb9IdY++dxNtjznIvlxxy278jYriy2nKyQoXdZPsZjDDCrRXYcW7oB
         PSySnvRbq96IZAGYk8zk22UMuFv3UU59NMJ+byluQF2trHHAShQ4twdxkcA3Axl1afk/
         gJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=ltx2Ji2DhRTGIdOOx2oes2Um7qg3YD3x/j2DmZhYue0zqMX9sKoeV776H8nGjJqK+f
         0xKNBcRmQUpO/YBVNTntqAtBzPw+rvGZq4HE4yy5mjCO+gF0v1xbxAh1+IVd1Zks7Fxz
         n8DSDJZRB9hbkSWb+53qMVO3MuLOcg1HZP/adWnmvOJrLfO/nrJFYEG+aThRyxm61PcE
         e3yYhaEGvJ1oiOGwH4kzvYLexKwi3MvvTOCN+n8ymE+6VwmxAtSy6tHcQQ+SRxPUbYw3
         lbG7/+/pKv52L1g07UlHxM4JJrj+ZDchEVZtx5D9/sA93B91DPDvva1kwrqvrCu9sAyQ
         I7Nw==
X-Gm-Message-State: AOAM5320vmdXEuoln2Zc0+U0dFzEfcsUzrSbQc3YppXWSWTbEdxajdfQ
        jfCWGtLODQy675m0iO9guCs=
X-Google-Smtp-Source: ABdhPJx1fx5x1PI6xkhKtntIgNXtV21Yyi5CtpacqQpU+GXOKX3ivUyESARsPbkaWqdHt7I0HguTlg==
X-Received: by 2002:a0c:d688:0:b0:42c:3cb0:3923 with SMTP id k8-20020a0cd688000000b0042c3cb03923mr1713298qvi.69.1650099725053;
        Sat, 16 Apr 2022 02:02:05 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a044600b002e1b9be8e6fsm4258085qtx.36.2022.04.16.02.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 02:02:04 -0700 (PDT)
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
Subject: [PATCH v4 2/4] dt-bindings: pci: remove fallback from Rockchip DesignWare binding
Date:   Sat, 16 Apr 2022 05:01:57 -0400
Message-Id: <20220416090159.596930-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416090159.596930-1-pgwipeout@gmail.com>
References: <20220416090159.596930-1-pgwipeout@gmail.com>
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

