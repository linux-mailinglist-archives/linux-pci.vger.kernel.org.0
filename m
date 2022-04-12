Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DC4FE850
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358797AbiDLTAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 15:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346451AbiDLTAT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 15:00:19 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A477740E48;
        Tue, 12 Apr 2022 11:58:01 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c1so7436328qvl.3;
        Tue, 12 Apr 2022 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQeNukA9v0sAIjhr8IxlYmsIPikuBlNT7ZSLuaA7VkQ=;
        b=JZvxN4mPsfnmiG5M5FNESw8LyxB8P8335VSGyMh2aBqfkwfTU3nXAagfdAxoOfZ19b
         M0Ap25k+3+APXLuufjsZgwHKjMNabZkaM+L9pa71CVbyVmxG2KT0NKnDPNf4D4n159Q6
         DtNJnl4pLxOHvnwc28igIX1HJJT2xef9d+kRQXT6QplUzxLRuBDfkoVHxiwNNK2ghB0e
         7FvlZPe7DpRQAaQH5X6y69mU/tzJgGpf6emMotUifzyLtXSNDDJ1pAsCtQh3OQ1kNWXR
         CwUEoDu+DwE/zoUn6s/00mJk+2Fzkkh3haO2o4XcU75zceGv8q3O9QZWwCmGnMhIz0O3
         CHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQeNukA9v0sAIjhr8IxlYmsIPikuBlNT7ZSLuaA7VkQ=;
        b=m/27XUtA0mHLeVJDCq+191zA9OOgbfSMMcIxB2Bppukxp6+CDXXX1paK2ZCmwV6tfi
         yqH94oTYUvuPodR/t5HvqrZcS8HY10ShQNMloAW17IpkbMDgdocuWveLxZxVL2akw8qq
         p+tXwX0//CvYRh6kWmbphWWWbYWZVZzqbuq9KL0O0KOroNciECZPjej+XTo329CeLxit
         z7jPM14kIz8vyFYNeUB0lSEOMgM8YenNRzpv8IOe2Cxhm3kmXOlMTNzhokpAbasyNUje
         66xwfTF9BM0RaFN63YIy0bSPKsZP0ohmQinVMYR6v33z5WTcgUNqVq5PLNrLI2qxYwYA
         VRCQ==
X-Gm-Message-State: AOAM5334BGFkaqCkxIVV0r28xsx/alC0q7+XSy99cE/drL4SDbCcHx6Y
        4ENzETJB9Okid0WMFZMdtRA=
X-Google-Smtp-Source: ABdhPJysK6WBKHFeXwuor8e59pMVwwACHYk61L2WmbC/NdngGu3X0z1pxc3BdsBfNS2XwEHApuqyrw==
X-Received: by 2002:a05:6214:d88:b0:443:e626:40e0 with SMTP id e8-20020a0562140d8800b00443e62640e0mr32677438qve.112.1649789880743;
        Tue, 12 Apr 2022 11:58:00 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d18-20020a05622a05d200b002f07ed88a54sm1820610qtb.46.2022.04.12.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:00 -0700 (PDT)
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
Subject: [PATCH v1 1/4] dt-bindings: pci: remove fallback from Rockchip DesignWare binding
Date:   Tue, 12 Apr 2022 14:57:48 -0400
Message-Id: <20220412185751.124783-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412185751.124783-1-pgwipeout@gmail.com>
References: <20220412185751.124783-1-pgwipeout@gmail.com>
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

