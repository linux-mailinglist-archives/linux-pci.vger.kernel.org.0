Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DFC500743
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 09:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiDNHnI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 03:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbiDNHm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 03:42:58 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576B540931;
        Thu, 14 Apr 2022 00:40:33 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 8E5581C0014;
        Thu, 14 Apr 2022 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649922031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jS+PmEe67ZVUOMWY42bQ+yym/wpbxNw3llVW9z5Zvxw=;
        b=KVnXTTE22AbVbwbeB0FbqQg3/x3nd6RBedmXmH9vAqrks3IFm+BAC4f9AxuD0ashSUP7EY
        M9eYJM0mtTIlPG/wYH4lvt+5vUPnl0e7Stmzbe74qF34+Jk4y5VgxtKW/AiuMQU9hzTKV0
        nnzrDpbcx4dcVp4gqFuPcqV8OfHfM5dtRZzNTCgYyUjes7OsWdzeHlTzmEeCFCvwwryrJS
        FAdQhdXlrvTEIPF2+e+n0do5Aw4ea8spZJXRkwPMpMkwu4tRyRCKml2gZbdu2Cjd8a1Ho2
        96uEu4xqD1h6A9U6F4Swd5+cc59A+1W6NkO0SK25d7rD5Pzo1Z1NOi60qyDcgg==
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
Subject: [PATCH v2 3/8] dt-bindings: PCI: renesas-pci-usb: Allow multiple clocks
Date:   Thu, 14 Apr 2022 09:40:06 +0200
Message-Id: <20220414074011.500533-4-herve.codina@bootlin.com>
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

Define that multiple clocks can be present at clocks property.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
index 3f8d79b746c7..5b85be751b88 100644
--- a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
@@ -54,7 +54,8 @@ properties:
       Standard property that helps to define the interrupt mapping.
 
   clocks:
-    description: The reference to the device clock.
+    description:
+      The references to the device clocks (several clocks can be referenced).
 
   bus-range:
     description: |
-- 
2.35.1

