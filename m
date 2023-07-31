Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198F0769D59
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 18:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjGaQ5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 12:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjGaQ5a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 12:57:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10DC1722;
        Mon, 31 Jul 2023 09:57:28 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-210-008.ewe-ip-backbone.de [91.248.210.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2F0296607114;
        Mon, 31 Jul 2023 17:57:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690822647;
        bh=LndBn2sfnnYSo4boXhNYyWPRDUxKhkkg9Nz5WzmEHnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aI2l1FBFfcyJHLaQlHGeCipptK9LqMUcVy0e7kkKiUYUXyfwej1qMIbw1BRKkDY9v
         HMj88boZVS/DgnkK8Tg2YYuHRLgpzv8sIGCJckn9ved89NPoEjkrBpto4oCDh287+3
         ifUeZwhp2maNO6jLqVevwajRhXHTw6bSxsUcn7Bjr9Ynia5nta8yBuHwFlFSz2TD7h
         Afo2++kjTgkMSnwbrg1u1xDsFDgYdlIV6hHNQkfBxZxz2LoddBltKruSkvozE6D0eZ
         2wpuKUyNbvwhDO7SizIfdo81gHrg5XqnZ0wrNAO2l8oUocgbdqZfTPQtNKTffZjcOL
         TIlpqk8Og+C7w==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2C7214800A9; Mon, 31 Jul 2023 18:57:25 +0200 (CEST)
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
Subject: [PATCH v4 3/5] dt-bindings: PCI: dwc: rockchip: Use generic binding
Date:   Mon, 31 Jul 2023 18:57:21 +0200
Message-Id: <20230731165723.53069-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731165723.53069-1-sebastian.reichel@collabora.com>
References: <20230731165723.53069-1-sebastian.reichel@collabora.com>
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
index d2b4fb8f6dcd..8bbdeb8821f8 100644
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

