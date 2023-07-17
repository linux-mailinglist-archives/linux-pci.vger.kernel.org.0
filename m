Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B3D756A4B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 19:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGQR1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjGQR1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 13:27:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42DBD;
        Mon, 17 Jul 2023 10:26:57 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-171.ewe-ip-backbone.de [91.248.189.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C95EC66028F5;
        Mon, 17 Jul 2023 18:26:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689614815;
        bh=E9QpBFx3OjWlRLEoFnsSGJDKU0c7IinxD+9ybLulYfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBd2jq4JHb9CE+ya1XOhEhR8MKtURZmk5lB5peFJDBeh0wOKk17+kgS9Nm7+Hhgcu
         qOh5mOdHVwJqaRFRLPSb2mtpgUa+weZKMTIfWhfBBUMJL1KX4zqgXU+i8nqP4Ys4ZA
         YqZ6FfDfHgAG8X+lXT+iuq+YzVtnzqGIfVVtZur9+umaXpmzUAAMSJ0oVdd/n7vcnn
         mlCT5fMjyhVTy91uj1/5o/yi1XBcgko8OTZSzbQSWmaBNERCxbnaTt6Ea5+4Xhrsvb
         QP69NWwHMMo1j1VpSErayFf4O6ZrLxo9WHyDL2CyiGpkf1/nBS++clnJnMr8ehOU7a
         b7jOZmADZrYiw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 19AC7480C77; Mon, 17 Jul 2023 19:26:53 +0200 (CEST)
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
Subject: [PATCH v3 1/5] dt-bindings: PCI: dwc: improve msi handling
Date:   Mon, 17 Jul 2023 19:26:47 +0200
Message-Id: <20230717172651.64324-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717172651.64324-1-sebastian.reichel@collabora.com>
References: <20230717172651.64324-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow missing "msi" interrupt, iff the node has a "msi-map" property.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie.yaml        | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 1a83f0f65f19..abc1bcef13ec 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -25,6 +25,15 @@ select:
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
+  - if:
+      not:
+        required:
+          - msi-map
+    then:
+      properties:
+        interrupt-names:
+          contains:
+            const: "msi"
 
 properties:
   reg:
@@ -193,9 +202,6 @@ properties:
           oneOf:
             - description: See native "app" IRQ for details
               enum: [ intr ]
-    allOf:
-      - contains:
-          const: msi
 
 additionalProperties: true
 
-- 
2.40.1

