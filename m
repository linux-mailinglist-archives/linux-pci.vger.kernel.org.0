Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBD756A47
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGQR1O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGQR1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 13:27:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE81CC;
        Mon, 17 Jul 2023 10:26:57 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-171.ewe-ip-backbone.de [91.248.189.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D0D976606EF9;
        Mon, 17 Jul 2023 18:26:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689614816;
        bh=aWxYY6oZC42uA/u/eur15Qmr3pbggLJlNDx8VSDbYNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aI48EQQOKu9Kj29w5eqsvdzhsgtyy9wZgPf7LPM4/XqzJXxxgtCZoVaaTPFsKmwSU
         /JCne+QOQD3Ir0ALjgc7AC/38Go5wIDgTBRaCul5UNWHBsj7qGKR6070TQhsKnaOhb
         GeoP1Y8cBe2rb4uRI3XdEAxvZby47lL9Skan0H4l78Li/yFiqqE2Kd8KJa7QLeJzM/
         LojiH2Ar8sR/XmL80jeB0Xqpk/alG3pfZ+za0QpT3eWV+fRdMeD1OVj4XpsQRuLyAI
         gT97tPpOTuUqmKxlAbOsRhWXBjfAdfAf5ujWJvoZid5tUKLHmwNRtj3f7UEaGTeGXl
         oCl2cxgxGIzdA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1D6A0480C79; Mon, 17 Jul 2023 19:26:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 3/5] dt-bindings: PCI: dwc: rockchip: Use generic binding
Date:   Mon, 17 Jul 2023 19:26:49 +0200
Message-Id: <20230717172651.64324-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717172651.64324-1-sebastian.reichel@collabora.com>
References: <20230717172651.64324-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the generic binding for Rockchip. This should either be
ignored/dropped or squashed into the previous commit.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 3 +--
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml     | 6 +++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 7836b9a5547c..ad9954f7fe02 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -17,8 +17,7 @@ description: |+
   snps,dw-pcie.yaml.
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
-  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index abc1bcef13ec..95d343c75485 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -196,12 +196,16 @@ properties:
             Status register (the event is supposed to be unmasked in the
             Link Control register).
           const: bw_mg
+        - description:
+            Combined Legacy A/B/C/D interrupt signal. See "^int(a|b|c|d)$" for
+            details.
+          const: legacy
         - description:
             Vendor-specific IRQ names. Consider using the generic names above
             for new bindings.
           oneOf:
             - description: See native "app" IRQ for details
-              enum: [ intr ]
+              enum: [ intr, sys, pmc, msg, err ]
 
 additionalProperties: true
 
-- 
2.40.1

