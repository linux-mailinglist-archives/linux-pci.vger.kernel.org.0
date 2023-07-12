Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E37504E1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 12:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjGLKjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 06:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjGLKjs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 06:39:48 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C2C1BD1
        for <linux-pci@vger.kernel.org>; Wed, 12 Jul 2023 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=RMPpbL5pi3zks0WVQZWgFf7tY7RqsEyq+Epl3RqNfZ8=; b=PFs+wz
        LgOAfFQC9PHfwITrPZSfdO8mD4CcJQwwjGficl6pZH3ODtWUjB/oPzcpoYcN2SE3
        mby3n2pb02LXpJmVdaUcVGiWn35T0eZU69BFm+GY+AcCxEXhY4KTOiDyM5jbnvzL
        MOc8hYaedjlNTLg1AVnmumjnoUezuctOkYYEDDMOccrWa/O8NMQP+Ny8SFv68n5L
        paZqP+EzVvzAK0FV0ApkB4autNaEfS/PGhASeAb+OnQlH8GHCnGZf7chsQWSE2RY
        L+UmkO88uEPIQkmkh1NyhP9XHkHd7CsXCF8O6LEtMYLA6rDejRhZyGTvJ+/8epIr
        bcner/LtEuElJ8pA==
Received: (qmail 1580077 invoked from network); 12 Jul 2023 12:39:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 12:39:39 +0200
X-UD-Smtp-Session: l3s3148p1@YuIu1UcAgL8ujnvL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 RESEND 1/2] dt-bindings: PCI: rcar-pci-host: add optional regulators
Date:   Wed, 12 Jul 2023 12:39:15 +0200
Message-Id: <20230712103916.1631-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230712103916.1631-1-wsa+renesas@sang-engineering.com>
References: <20230712103916.1631-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Support regulators found on the e.g. KingFisher board for miniPCIe and
add a 12v regulator while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/rcar-pci-host.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index 8fdfbc763d70..b6a7cb32f61e 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -68,6 +68,15 @@ properties:
   phy-names:
     const: pcie
 
+  vpcie1v5-supply:
+    description: The 1.5v regulator to use for PCIe.
+
+  vpcie3v3-supply:
+    description: The 3.3v regulator to use for PCIe.
+
+  vpcie12v-supply:
+    description: The 12v regulator to use for PCIe.
+
 required:
   - compatible
   - reg
@@ -121,5 +130,7 @@ examples:
              clock-names = "pcie", "pcie_bus";
              power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
              resets = <&cpg 319>;
+             vpcie3v3-supply = <&pcie_3v3>;
+             vpcie12v-supply = <&pcie_12v>;
          };
     };
-- 
2.30.2

