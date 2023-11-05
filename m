Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E479E7E12C7
	for <lists+linux-pci@lfdr.de>; Sun,  5 Nov 2023 10:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjKEJ3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Nov 2023 04:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKEJ3V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Nov 2023 04:29:21 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F766FF
        for <linux-pci@vger.kernel.org>; Sun,  5 Nov 2023 01:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=km1S8zZEcbuRQRFhnQ+j9vTvoJEJFWsqJkELKGUX9fM=; b=kSpmB+
        WjJUUQlaH8pW9NUeMMQm6llUyaZnex187z5aCpAz8XimaWIUo3ezDAUzZYY7u/4I
        wrvw9LUQs00afzc79wJHC6TH23rbkScdZermgZa0/xlvbBVXCPuVXFtGY2gB9SoD
        Ov86eaL1/VbOkqUyZtqF1khqFowpv9fKBZuj5qhHZt3ziIC5NEn7G2Bi1g4nI9fC
        bIlWrtggx407/p5tW4vCVuTzC1kUoccYJB7lUPnl6CtdROUNeKpfspcTZYHb0Of2
        i7YOn1ve5jrpJ8qdbQxxCUvcLUx3tZIWfsJfWXwo1QBV1fv0PZVomKUlVAbKo0e/
        dnzkzutH9f0s/veQ==
Received: (qmail 1670102 invoked from network); 5 Nov 2023 10:29:16 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Nov 2023 10:29:16 +0100
X-UD-Smtp-Session: l3s3148p1@wFMDX2QJasQgAQnoAFPQANY41GnTzLIh
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
Subject: [PATCH v5 RESEND 1/2] dt-bindings: PCI: rcar-pci-host: add optional regulators
Date:   Sun,  5 Nov 2023 10:29:07 +0100
Message-Id: <20231105092908.3792-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
References: <20231105092908.3792-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Support regulators found on the KingFisher board for miniPCIe (1.5 and
3.3v). For completeness, describe a 12v regulator while we are here.

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
2.35.1

