Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80831503187
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 01:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354242AbiDOVJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354199AbiDOVI6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 17:08:58 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E319716D4;
        Fri, 15 Apr 2022 14:06:28 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id c1so7179235qvl.3;
        Fri, 15 Apr 2022 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=jVy4wLQXJ5Xiw1bj4CpGcPN5pnCX6r59sOQO66Jz2Vvt9y4Tzwih3hlFcvyeCRD4Hr
         LG25pmwmM7+PyhWhkrHsXBYgNA8egqCTX/GQpcuiu6Z3xr6hQaQ674okap8z7lUy6jWH
         cI/MZpMTQQiQEtnnhPPF3nS2ALkqeJB3ADFpyVw3h1HJRB32It3hjvY5e+/WxOe6LS9p
         ZArv72BnSZ4UFPQCo6s86Gyg39ezv/dxU+L7EUHvsIKugHNqdCRkYJ+3Ut1aZ4aXxcsg
         YsXNTagZdOsdTXEW82dZ0JfC00y5Xlc3ZGqxfiowc/pXWOgMcQN9oy4bonSI9KD2lUHy
         eLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=RcPyowM++aUzcItkjHClM99r3cz5ZHL7xWaSpH9m2whrBoYaolL32YEaXva+2zfxdS
         Su+9j7+zgaCyjTmOeGCcBjO/nFeiZUlJs3/j1xPxwSlAghDKvdHpgMze1tT/7kiPzav7
         3zyI/A/T61m3yuE0fgFNYhdO4Rf459sSAipWVSz71OgSUOP4K5ADQYCkyQut2TZTGIOI
         3tEffpKr9xy+L/zoO/IQm7l3MAnwYq1MbDCL28sz3KQ4gy4DFmjwq/NAuoT1HEgC6kxW
         zlThGO3LAopczSNdFyHTMdBokvZKAScDUNMqRql1GDTWhfXtkoGG9P62pUZLRzKD8CPw
         fIxQ==
X-Gm-Message-State: AOAM530IzjX+0BvzMNeNiuTWOmLIH6ZgIc+e6EeYnfVSk6r3NMAA++kw
        b8nShnyrRe9CDIqCit6jTJvXaueLnaDEz6Gs
X-Google-Smtp-Source: ABdhPJxbrMCYX9pst0yUUj30dL5YGetX2lKuySfQVgVFm/cqlONSsHjg0w3yNcEDpoX2+Hn5wU7qSw==
X-Received: by 2002:a05:6214:2aa5:b0:446:3a3d:bdf with SMTP id js5-20020a0562142aa500b004463a3d0bdfmr499333qvb.55.1650056787492;
        Fri, 15 Apr 2022 14:06:27 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a148800b0069c4884c990sm2838664qkj.108.2022.04.15.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 14:06:27 -0700 (PDT)
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
Subject: [PATCH v3 1/4] dt-bindings: pci: remove fallback from Rockchip DesignWare binding
Date:   Fri, 15 Apr 2022 17:06:18 -0400
Message-Id: <20220415210621.538109-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415210621.538109-1-pgwipeout@gmail.com>
References: <20220415210621.538109-1-pgwipeout@gmail.com>
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

