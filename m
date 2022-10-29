Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0B96124C9
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 19:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ2R62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 13:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ2R6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 13:58:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF659E94;
        Sat, 29 Oct 2022 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667066289;
        bh=/287IqXU2M48jGY5dOJDRNgS48sMz8IqBXXdIAdLiD0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OEZ7vXKHFGYr5iTatp0Mwf0R/6aU69uMFAJ5ju25G6w4WNCPHeP5if4FQOOfzEtuI
         d8jZaYQ2TmMQI+mrwx5TJtNU09L6frWZy/lcvgHfb0yZEs1qbI9LSoNBYOa6OxPkQA
         toR9N3hdSMgptBhWiNZzHsJoKCllTBxDac92atC7eAm6ytGiP+hEAy7Nk8rtjPkn/E
         ycg7248ChumOo8rJv4BmNrEtxTWCoNicRgJx0pRup5M4MCL1E5FnKZtfGC7CM94Dwx
         sRuUKZlKGdcOBVGUuuJRnPC7zas7EE7FWMvv9b/q/Z+C1NrHE9HqgB8PvoS2lyXO92
         TPnvvxdJNsg8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-G5 ([217.61.156.178]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1pES5G0Iq7-011fuP; Sat, 29
 Oct 2022 19:58:09 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: add SoC based clock config
Date:   Sat, 29 Oct 2022 19:58:05 +0200
Message-Id: <20221029175806.14899-2-frank-w@public-files.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029175806.14899-1-frank-w@public-files.de>
References: <20221029175806.14899-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zso9H8enCAQo27e7CXSDU6tiEbUwr+oh4l121T5GOU6gypCw1bz
 obMOVr7UT7T61f1vuFU5NEB1PwDhAtl0hbJdW4KHDYjifaLfIG1sDYsJywK/UBTsA4ZazSv
 XuJpMUVxI+IEMFS7IctXkKz8U+ROOYwbFec9rcuQcvdiUppU9PyDASeZjjUnfjVbzt70TVu
 D+DPgSZXHbiK7s2Qcv0bw==
UI-OutboundReport: notjunk:1;M01:P0:eBhfvPLFTQo=;FLS16h8ZKYNCa1REsLbs4YmgLXd
 BxyznKfkvOrtHJ+EB/5UNKypilJICWAr5ddekbECiCLagVYLE/Sjq6nHifwKlN6gdAxExgFLu
 svW/r88bAvcTLu/Lmp/4dRce0QLr8wQufXUh7hb3RnZHwJ3R1wJnOygUDEZjgHnKWF6mgvBHm
 /xQNZu3wcRjAS0OnAOovAuARG0MYUMq4QL56mGK5SgvedV/ol1vSonm5uhLy5pPQS71BFC15g
 +A57rZRTTTJn0+YQbyN0hifyuxEA9MOcZir3vM0HJXtj6or3fNWFpK4cJOldbYw7LpvnKBFty
 CcX6Pmi4N53+kj8KYwytJQkffETIP5S6hfVKy/rTpJawAmnaHCs5c55Gfx+KRGqw85yC57ncj
 yINgUV4TAIE8Afm+3sL8LcikYIpxFLnKiNzQBnR2kc+DOshJBFVZZF4ELmTcmQN6NAwix557I
 ITI1eNc7n7HEK3XKeGx5QH0pBwM4BXJa6q+9XG9nY0pgegLCtsa5EW1zX9Ta1FKKs7qqIp/DK
 qvPSBUgxWHdlZ0kaBB1XJMDV3Db5Cg2SZ3JKy/ylx8cUKMBZhrEgMwrlc40qwL1fnhtefauI1
 lP71wjygV/9RNgrCGS54SN2t68nO1Jd5pcwcHfbTz68K+DhQzVf2rzP2hEuqdWyghHfuhuAv5
 /pqE+hRGwHlZO8Es22jmqz3IZeNrqQBxiOuFiYg4pR+NwJ07m571HSLYGMbtJ+9RfgCfZgbVf
 YECdfS/46oTaacI2q1IfuGZby8f8lELP9NyfGG9+Lmq2ssWrYQlrOMZzpdWJv6UEx6B3JER1J
 5FjfRjnOxrPHIwEhnI/emJJaRQEATY8MZsPXQMJyo8qWVsZNioOJGgOn/Fnhng1IcSLTy1u/U
 VuLUo90OVhBeEpTRSXuLZ6UtZD3tXRb3vtoeKs1g+SRE44tRwsYkY+CdyctMjA0Hib1UdtUsA
 6TGArqpqdfe6BElLVc/rBQJEo5E=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe driver covers different SOC which needing different clock
configs. Define them based on compatible.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
v2:
- fix typo in mediatek,mt8192-pcie
v3:
- remove contains to match only if compatible is no fallback
  tested with series "Add driver nodes for MT8195 SoC" and mt7986
  pcie-nodes, dtbs_check is now clean
=2D--
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 47 ++++++++++++++-----
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml=
 b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index c00be39af64e..5d7369debff2 100644
=2D-- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -43,9 +43,6 @@ description: |+
   each set has its own address for MSI message, and supports 32 MSI vecto=
rs
   to generate interrupt.

-allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -84,15 +81,7 @@ properties:
     maxItems: 6

   clock-names:
-    items:
-      - const: pl_250m
-      - const: tl_26m
-      - const: tl_96m
-      - const: tl_32k
-      - const: peri_26m
-      - enum:
-          - top_133m        # for MT8192
-          - peri_mem        # for MT8188/MT8195
+    maxItems: 6

   assigned-clocks:
     maxItems: 1
@@ -138,6 +127,40 @@ required:
   - '#interrupt-cells'
   - interrupt-controller

+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - if:
+      properties:
+        compatible:
+          const: mediatek,mt8192-pcie
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: pl_250m
+            - const: tl_26m
+            - const: tl_96m
+            - const: tl_32k
+            - const: peri_26m
+            - const: top_133m
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8188-pcie
+              - mediatek,mt8195-pcie
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: pl_250m
+            - const: tl_26m
+            - const: tl_96m
+            - const: tl_32k
+            - const: peri_26m
+            - const: peri_mem
+
 unevaluatedProperties: false

 examples:
=2D-
2.34.1

