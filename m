Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD276124CB
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 19:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJ2R63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJ2R60 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 13:58:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308459EB9;
        Sat, 29 Oct 2022 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667066289;
        bh=gbLUknNhYDzToI8QX7zIFAAM+RoOhWqq4U9N2tWYqrY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=J05y90sHfOuBW1dagMH1QWKbygXKo3NM4skXufIWKzOJ50SGhdfo0k3Qvs99hOT9N
         Ig0ftYRsTbhyrnlOI0x/6JsqTxYqbAVGdZ7XeE6pq+Cyh5fC19AgDDbevyRcyitnFg
         aOpdgdFJzazkN3qB8tmRb0pE7zLiPVYA3WE8zdImrOn+uxMZqRRqMzEEQWLUQc+Dss
         zaZ0tXiLE15RohZqms/Kj7p0vOVQlA4HJETmLIYrp3wE/CJyIWtWc22uuQ1V10fpD5
         5YdTGBi9fDRX7kCCDYirdRn1eCAgb46eTW3v1wclgy0YmczgTg0rq1vq6C8XAQN70w
         3COzWQo/bgSPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-G5 ([217.61.156.178]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDywu-1owVan1VqO-009zKI; Sat, 29
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
Subject: [PATCH v3 2/2] dt-bindings: PCI: mediatek-gen3: add support for mt7986
Date:   Sat, 29 Oct 2022 19:58:06 +0200
Message-Id: <20221029175806.14899-3-frank-w@public-files.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029175806.14899-1-frank-w@public-files.de>
References: <20221029175806.14899-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M/8pyPHZeBy0oSZJMA11WuM41/YmWM8SAUTdo0nAh26A+VhWuFN
 VUrLwFwRtVtMl8Lb05bPaTo6Ly7GqelfUJIRpUtyiGaeczpB914xJ1gKujlpp9R4hjAyqtz
 c66xvAbooTVN5TZQc+zo8C9BSplX8Rf0GxzI16qRaIaye2irKh7FWdHy/Oz/bzjaJAJf+Q3
 q769wPKHXM4npSkXp1F9A==
UI-OutboundReport: notjunk:1;M01:P0:sEB2PEL8bqg=;ekmgBYoYBWf9sUt1XO4Psf+cuK5
 2lyAB5EiVbpwX2rCsOIEuIY14q/9synZZ38f6UWvsLJXML4H/tjrvgZNnnDwnad5F1N1jlBum
 sW+G9WnUTgc/BtUoGuogvnH07Og0csQ10MCThKItQbD5v9sZ+oHz4WaqfXeip6L2uP/+q8bw/
 2nblADu9rtaNLkZuKOZzCJ6c7mDHmn84+BBGy79SjVImXJW20pNF0GUOy7TGVqPAWN/NWv/3A
 NYILctiWtjbHixqQSpho/XP4TNh4vSAHDQ67fuvAEal1lxrtvvCCgEOK8CS6Hq+ByKKYC8iMR
 gM4TTwEpJ/boYXmc6x+JiiewGajvO1HMT5iaQ6zOTPsARkbe9EGpeFj+RH7Mxupne32v+DGXE
 vPhpSx+WJk28T69aSzaX7WUsZ0NIdtSOYUNlocALIaR6RZwy66a35KEAvadckHtxo+y97rR1Z
 0MrKFEnHCykWPA78jKMlA4I/bPSo0TjInvq7ogGom7NuOYj/ITF/U/4tgeCMBZ124PW7lpk2P
 PptZDy1U19aLRaFg/qTz7raHccn2SaBoujH/JLtam9CPPho27gCnvclgr6j0Td0NYQcyxBuX+
 225OXpzDKElNn1w5Y1ZpQVhTgFaUPyKOKHc0lqwODdOwvu+MZ6YfVsI/16zX5714dG/AoJLT3
 YJlSMDnpw7ytqn/OyhDP8ynurM0LmPmxHbZ7xIUMv8BTQDwUWov7yAO1fhOa9ZoeKBSVIiQun
 LUcPwvFhL+jpbc5cijskbDTIBUtp+V36njUwydMdXAcKkvjOpqDAOwxXIVNSV/nZCy4tWz5Oz
 7S0lqWIWBSavjXpAxSmlzVcOg3E14e8Lcq61l4p9RXF+kimQ4knSSItoayZrCV7xj3b9t48Dm
 DV6tIHcdMYAovyj78trKZglcgWVqYTOmwz9oXoQ+PUpcc+WFd4jAuBjr5Ma0ZBtL1kG0lp83E
 ndS3I6yjgflfUOjGWeEjSnk927w=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add compatible string and clock-definition for mt7986. It needs 4 clocks
for PCIe, define them in binding.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
v2:
- squashed patch 2+3 (compatible and clock definition)
=2D--
 .../bindings/pci/mediatek-pcie-gen3.yaml        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml=
 b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 5d7369debff2..f7a02019daea 100644
=2D-- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -48,6 +48,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - mediatek,mt7986-pcie
               - mediatek,mt8188-pcie
               - mediatek,mt8195-pcie
           - const: mediatek,mt8192-pcie
@@ -78,9 +79,11 @@ properties:
       - const: mac

   clocks:
+    minItems: 4
     maxItems: 6

   clock-names:
+    minItems: 4
     maxItems: 6

   assigned-clocks:
@@ -160,6 +163,20 @@ allOf:
             - const: tl_32k
             - const: peri_26m
             - const: peri_mem
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7986-pcie
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: pl_250m
+            - const: tl_26m
+            - const: peri_26m
+            - const: top_133m

 unevaluatedProperties: false

=2D-
2.34.1

