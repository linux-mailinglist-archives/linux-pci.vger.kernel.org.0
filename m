Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE2550073A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 09:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbiDNHnH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbiDNHnE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 03:43:04 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB140931;
        Thu, 14 Apr 2022 00:40:40 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id A195C1C0003;
        Thu, 14 Apr 2022 07:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649922038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxV60ButKA2NawyTYXLzIPMVoZv4uWDKTUkJc1VuWn0=;
        b=WowDZhZsCK4EMdPcaf42nqjkdPsgclAhZBLd+QF55X+6o/hkYzymPVSDthfkMij6hgG8Tn
        y5f8zurmSoYQulR1XQ+Nndj06LgPleNho6SVYb9RGM3mY2ExtrjfhEx2vbdF1sIer8bsVH
        RC0g4gWKk+nnjpjprN370thW/0Wsdpo8R5dYZM339PVxymRqHuwV7cFfOlpxBwE023JAbM
        MbjwSCcTIf2FbcA5SLa72J4d+F3F0wu9Vjxjw54K8Y47X6uAaqvF7UbIqNYeu5dJQ1u5ov
        pGzY/AxjvBIjc+/ol89mhWcont10BKRzx4YV+ipkh1O6EAbSJrHH8qGedI4tUQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 4/8] dt-bindings: PCI: renesas-pci-usb: Add device tree support for r9a06g032
Date:   Thu, 14 Apr 2022 09:40:07 +0200
Message-Id: <20220414074011.500533-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414074011.500533-1-herve.codina@bootlin.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add internal PCI bridge support for the r9a06g032 SoC. The Renesas
RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
present in the R-Car Gen2 family.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
index 5b85be751b88..5637f5d7cf05 100644
--- a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
@@ -32,6 +32,10 @@ properties:
               - renesas,pci-r8a7793      # R-Car M2-N
               - renesas,pci-r8a7794      # R-Car E2
           - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
+      - items:
+          - enum:
+              - renesas,pci-r9a06g032     # RZ/N1D
+          - const: renesas,pci-rzn1       # RZ/N1
 
   reg:
     description: |
-- 
2.35.1

