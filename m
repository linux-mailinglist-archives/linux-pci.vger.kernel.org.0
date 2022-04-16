Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA555035D6
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiDPKHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 06:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiDPKHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 06:07:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438DE26110;
        Sat, 16 Apr 2022 03:05:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y129so165672qkb.2;
        Sat, 16 Apr 2022 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=mOvkRR5eJ9vjx8JtRPhJIqLuhXOHNKl0zTHY8+1g55VqwGg8RzRhl7jVK+QFBBJN96
         OAiaLwoMsQt85+snNBi2HWtGsgpwdes4z36dZfPc7PwMM6L5cmY+ExBzYgQQzROOURbm
         zjCWI3+Gl7ZWd4i40j8335oFN7+UIjnSK4W+2p/wPxzt/s12i0z5RHvdhVKzG8pJdVKQ
         sauubRY1VD/0QO8Y7gJxDgixdZI93uAVviUWUVFLK8s6Zo3USyMsO1XN5FIqhGg6VYsM
         3ufyo3YPATuyYWWnjNk1sY29pvC2et5TqFn1a8Fra8HUvdmT6tnl9O1I8VC0+bJBY7o5
         mI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=V7Y/174mvsibRKg/Is1fkPD6mnr7wfSY9krsUa9oHNP84AZIPvP2QVWQLttTCQa6Nz
         j8zsFfPAf2HfBhLHVUb8449PqHucof0xlGqnrI9uRdMwi61Qusn5jDS9c79KZiVZQqOW
         yUqNQTGxl8M7yDGzMWwe/ghXFcVDtsc+ZuYwEE7b0C7GIfdacOz0sBXJ8mtaas1Qu9qW
         wiwxn6MmCVODP0BW8pvV8XxRtjnhXbwJHr8oCvYQeC25Oj5DollA3hfLifElqYIo3ce5
         KEkSeIAoxKFd6iVxUpw/p8InbAE9bNY4FhjTsTrWImAXJOiGFsz0wKT21hDN1YlZ7Rc/
         ix7g==
X-Gm-Message-State: AOAM5338gtmssT9gVkuSz30z/MpX+J8w58fT7XJEAMI87K/iGmdyUIZm
        1EmXPeX77zt4+VTITsqAc5g=
X-Google-Smtp-Source: ABdhPJwRq9n5D0f3hCXGHWGLW0h4Bo0ha8X8ZtKGx70RNTsRJvEua2poQiwJfEw5GWgJbXpFldqigw==
X-Received: by 2002:a05:620a:350:b0:69e:5a7e:7464 with SMTP id t16-20020a05620a035000b0069e5a7e7464mr1576353qkm.321.1650103505389;
        Sat, 16 Apr 2022 03:05:05 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002f1d7a2867dsm4263188qtw.67.2022.04.16.03.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 03:05:05 -0700 (PDT)
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
Subject: [PATCH v6 1/4] dt-bindings: pci: remove fallback from Rockchip DesignWare binding
Date:   Sat, 16 Apr 2022 06:04:59 -0400
Message-Id: <20220416100502.627289-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416100502.627289-1-pgwipeout@gmail.com>
References: <20220416100502.627289-1-pgwipeout@gmail.com>
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

