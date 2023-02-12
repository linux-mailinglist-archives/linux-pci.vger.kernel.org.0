Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0EE69380C
	for <lists+linux-pci@lfdr.de>; Sun, 12 Feb 2023 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBLPli (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Feb 2023 10:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjBLPlg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Feb 2023 10:41:36 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166ECC3E;
        Sun, 12 Feb 2023 07:41:34 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 8E0B726F77F;
        Sun, 12 Feb 2023 16:41:33 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 10/17] dt-bindings: pci: apple,pcie: Add t8112 support
Date:   Sun, 12 Feb 2023 16:41:20 +0100
Message-Id: <20230202-asahi-t8112-dt-v1-10-cb5442d1c229@jannau.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=j@jannau.net; h=from:subject:message-id; bh=B5Qcd4CxlxesRe0jkuQrKlKZBtIrCHBPG5zOO2R33rg=; b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuSX7Cf+3fv/8/cJ8wf5PTnnflu923ri12nNf7n/JDexp Ug+Lful3FHKwiDGwSArpsiSpP2yg2F1jWJM7YMwmDmsTCBDGLg4BWAi9+sZ/jv3J9ySmWbpJuAf FH7/UFdhRlDAnHWPTtevvsVhKWNUkMnIcH6Bxlm32z9vLrrDXdjc2Dx7iq179BHeV+EzMv9PfCw zlwMA
X-Developer-Key: i=j@jannau.net; a=openpgp; fpr=8B336A6BE4E5695E89B8532B81E806F586338419
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The block found in the Apple M2 SoC is compatible with the existing
driver, and supports 4 downstream ports like the t6000 one.

Signed-off-by: Janne Grunau <j@jannau.net>

---
This trivial dt-bindings update should be merged through the asahi-soc
tree to ensure validation of the Apple M2 (t8112) devicetrees in this
series.
---
 Documentation/devicetree/bindings/pci/apple,pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index aa38680aaaca..215ff9a9c835 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -33,6 +33,7 @@ properties:
     items:
       - enum:
           - apple,t8103-pcie
+          - apple,t8112-pcie
           - apple,t6000-pcie
       - const: apple,pcie
 

-- 
2.39.1

