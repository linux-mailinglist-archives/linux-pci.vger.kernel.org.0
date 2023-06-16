Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E149733700
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 19:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbjFPRB2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344739AbjFPRAo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 13:00:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C37030EF;
        Fri, 16 Jun 2023 10:00:42 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-215-052.ewe-ip-backbone.de [91.248.215.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5C3ED6606F61;
        Fri, 16 Jun 2023 18:00:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686934841;
        bh=X01oy+ihteZncXuvNTLu0v0W9yQ61BoqL+FIOTAimbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjWItqyG+6JtsUQmPKLZ06/+dqMQmlncIFF+Nkc7IP23kC09kxM99c1opbDaSrV8+
         Y8/AboL6PR0kAV2/XrwdZt/97XF/WnqxWVJzXP3+4nOUq1oMHZtZ0WC0GzGzDFC3Pp
         wf5JxqyDKyCky07aT545/1JKhHyhNIIbV1Q6GbJ1nNR70N3VJlKrKszwwT49oYr+ub
         F8DNTiBQZVp56f4Dx+YMLueaP4cbePxUfoptrxy07mZGAE1I+7SIcMF238l3/p7UUS
         hbxqZCKJytCBCco+ZtLXypdq54qNpsNHMgh59eyAPXFxhC+uXVll4V2/B5D56F00tg
         8yOh3YKQ6UqGA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 14241480598; Fri, 16 Jun 2023 19:00:39 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
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
Subject: [PATCH v1 3/4] dt-bindings: PCI: dwc: rockchip: Update for RK3588
Date:   Fri, 16 Jun 2023 19:00:21 +0200
Message-Id: <20230616170022.76107-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616170022.76107-1-sebastian.reichel@collabora.com>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe 2.0 controllers on RK3588 need one additional clock,
one additional reset line and one for ranges entry.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/pci/rockchip-dw-pcie.yaml           | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index bf81d306cc80..7897af0ec297 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -41,20 +41,24 @@ properties:
       - const: config
 
   clocks:
+    minItems: 5
     items:
       - description: AHB clock for PCIe master
       - description: AHB clock for PCIe slave
       - description: AHB clock for PCIe dbi
       - description: APB clock for PCIe
       - description: Auxiliary clock for PCIe
+      - description: PIPE clock
 
   clock-names:
+    minItems: 5
     items:
       - const: aclk_mst
       - const: aclk_slv
       - const: aclk_dbi
       - const: pclk
       - const: aux
+      - const: pipe
 
   interrupts:
     maxItems: 5
@@ -97,13 +101,19 @@ properties:
     maxItems: 1
 
   ranges:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reset-names:
-    const: pipe
+    oneOf:
+      - const: pipe
+      - items:
+          - const: pwr
+          - const: pipe
 
   vpcie3v3-supply: true
 
-- 
2.39.2

