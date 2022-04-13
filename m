Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEC04FF7D2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiDMNkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiDMNkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 09:40:21 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B065F240;
        Wed, 13 Apr 2022 06:38:00 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y23so1069990qtv.4;
        Wed, 13 Apr 2022 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQeNukA9v0sAIjhr8IxlYmsIPikuBlNT7ZSLuaA7VkQ=;
        b=Mq+7g8tDrDPA6Y/smYyEuWeRwuMTPNbg3IMRnuvDOosjH8z0Zf+X7Gkaehqfa9AmZ1
         8516oOb/LDbE259AqGWP5+8lPidr+YSZG5WUkDPrdv5sgJgxW7UG6CBrB89ammJc5uRm
         Y5WN/HHXs/Opp7EHbPCi5nF3VhS7JMxEDuiKTf4yaTT1m2KFTDiKC/DsKDkLnBt0iHC6
         QQFpuubKKXo3WXIp3cPhWTxo0+yw936ltO8p23CHKgMrnQtHBvlFv1NfAARppwFAr8jL
         eJSqLI5YPmDL8+OcOZv1wDsJ2gr+eUa1/m6iODUV6e9sHgQet5IyQ3AezWTIME28KItg
         2AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQeNukA9v0sAIjhr8IxlYmsIPikuBlNT7ZSLuaA7VkQ=;
        b=JJoROrPGUP2f/G/QOwC9h0O4HQnYviKYdhJLy77+ATMeqts5FPXPk0b8+Bj+hNajGM
         vIbDINBTsAScqlJBzq68mwAdik7UU/thaUIqIOk1b9qppehBrhMZHHwTFrAbWWpWrdU8
         ky//ZhvQrY1zt/XGpqYHy+aZX/5YbPCvN74pqEqbmmrUqsFUh2N9U78GjWy+4S9n5hUe
         2/yds3/XVdhU0WqIElKFQhamzzYctT1fthbqU9GtEUFwoE1pC4cu+IFrbp1gdvzqUIwg
         FQlaS0o8NLFZLt/e4j7kjGnLQeFuloxVa0vmOukA+mmTXXlUZK0WlGPq4QmbGlMGOCeN
         R5aA==
X-Gm-Message-State: AOAM530U1S0GJvJZmcRHVauZVR3Gwl9mgGlI6KnxVrhxJeNWIZ9AgoYe
        zgLFwJ9P/w5/53H/P6ORHieqSXzw99yR45Qd
X-Google-Smtp-Source: ABdhPJztXwfsW7BO3NnHC4u35LCaJUWDbkRdjMvL4IMH4HQyGKDsbj3JDw6N+KqRSIddpXjLqjkv9w==
X-Received: by 2002:ac8:6903:0:b0:2f1:af14:a01c with SMTP id bt3-20020ac86903000000b002f1af14a01cmr2954735qtb.45.1649857079608;
        Wed, 13 Apr 2022 06:37:59 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 143-20020a370795000000b0069c59e1b8eesm790584qkh.10.2022.04.13.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:37:59 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: pci: remove fallback from Rockchip DesignWare binding
Date:   Wed, 13 Apr 2022 09:37:28 -0400
Message-Id: <20220413133731.242870-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413133731.242870-1-pgwipeout@gmail.com>
References: <20220413133731.242870-1-pgwipeout@gmail.com>
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
 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 142bbe577763..8dc11fed8a3c 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -32,7 +32,6 @@ properties:
   compatible:
     items:
       - const: rockchip,rk3568-pcie
-      - const: snps,dw-pcie
 
   reg:
     items:
@@ -110,7 +109,7 @@ examples:
         #size-cells = <2>;
 
         pcie3x2: pcie@fe280000 {
-            compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
+            compatible = "rockchip,rk3568-pcie";
             reg = <0x3 0xc0800000 0x0 0x390000>,
                   <0x0 0xfe280000 0x0 0x10000>,
                   <0x3 0x80000000 0x0 0x100000>;
-- 
2.25.1

