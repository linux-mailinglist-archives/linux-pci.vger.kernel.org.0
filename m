Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E2503629
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 13:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiDPLHu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiDPLHr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 07:07:47 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103B3615A;
        Sat, 16 Apr 2022 04:05:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t25so277883qtc.10;
        Sat, 16 Apr 2022 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=mO+c+dgqNkgVHglcmeNkqeYKEFrbca9Mg1ereL9nAPWF+rDUhc5bExsShTgtJGU7Fq
         YnBsFlQMii8hiDBByq1Mbg04Uu+YzbVE16mL0cTHy1TQzjI7YMPODVwtC6Dvplq3jmdM
         YhSlC9j+CkJOAjRvVzQvy8rE9ed4kuu94gZMUlA/RVHyRp7PnzBTZ5S8IQGcroVUQTgM
         +hbuGk86KhafBO6pYzl38Zqr07WbTYZ+o3yivDwoqTHoUJi7n45BFRLWAEkSUirlPDTU
         MXKd2Fq214KHOcDSHUnOQDbrAxQH+9jNaxYtaM1bAuaFWzMsFLfu216YmPC1z0GRwceL
         9f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMYeeN0iZUy6EfrHqDAGGWFWHi99PGIp7rnql4YH69k=;
        b=jFElPBynM+mIkiQyOa+Y6R6O2Roc8kE5OAHNZZ5kUwTnxdaVPXW/DUjOQkn/lCqxP5
         xts2hJywJXE+KGbPBAK1It8ISc/yqPQLu3BSa3g07ToQ3sWzmcjfRV4IkULW5CdtJcHB
         wWmqrJLtDsCXZj98vfqe5u1sqi6FTsLO4+6mE5BxHSoxEcOmsXGf5Tn8BN812dq1xs3/
         +LYS//PYkNdh/9wvBNF8D3MtarwK5Zf/1dFtoPjqmBz0WLgkyQdNuE24OzDdEQm09EhD
         jm7B7NszUYl6eoBJP06WFYiIkayRYaXImVF1XVBizZWfN54j8mkaUN0WcYx/gvnWGPK5
         FgBw==
X-Gm-Message-State: AOAM531vRjTMghUQeX4TPBTJht1aW19QuFctcLzqyxJXvT65DxqKJqJE
        8Ptzp8WMMViNSIZg63VGWLg=
X-Google-Smtp-Source: ABdhPJyEAu3rtiQo0zzKoe4zKalnE3V0w3SLyN99GNkbCGHM7+Ji+PwVeroMv+GZu4jpHLnxwpdRsw==
X-Received: by 2002:ac8:1191:0:b0:2ed:bb6:ab07 with SMTP id d17-20020ac81191000000b002ed0bb6ab07mr1935995qtj.418.1650107112074;
        Sat, 16 Apr 2022 04:05:12 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id w6-20020a05622a190600b002f1f91ad3e7sm97026qtc.22.2022.04.16.04.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 04:05:11 -0700 (PDT)
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
Subject: [PATCH v7 1/4] dt-bindings: pci: remove fallback from Rockchip DesignWare binding
Date:   Sat, 16 Apr 2022 07:05:03 -0400
Message-Id: <20220416110507.642398-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416110507.642398-1-pgwipeout@gmail.com>
References: <20220416110507.642398-1-pgwipeout@gmail.com>
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

