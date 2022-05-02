Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DFB516D1F
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354255AbiEBJRK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiEBJRJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 05:17:09 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F2366A2;
        Mon,  2 May 2022 02:13:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 812F041982;
        Mon,  2 May 2022 09:13:31 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] dt-bindings: pci: apple,pcie: Drop max-link-speed from example
Date:   Mon,  2 May 2022 18:13:08 +0900
Message-Id: <20220502091308.28233-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We no longer use these since 111659c2a570 (and they never worked
anyway); drop them from the example to avoid confusion.

Fixes: 111659c2a570 ("arm64: dts: apple: t8103: Remove PCIe max-link-speed properties")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/devicetree/bindings/pci/apple,pcie.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index 7f01e15fc81c..daf602ac0d0f 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -142,7 +142,6 @@ examples:
           device_type = "pci";
           reg = <0x0 0x0 0x0 0x0 0x0>;
           reset-gpios = <&pinctrl_ap 152 0>;
-          max-link-speed = <2>;
 
           #address-cells = <3>;
           #size-cells = <2>;
@@ -153,7 +152,6 @@ examples:
           device_type = "pci";
           reg = <0x800 0x0 0x0 0x0 0x0>;
           reset-gpios = <&pinctrl_ap 153 0>;
-          max-link-speed = <2>;
 
           #address-cells = <3>;
           #size-cells = <2>;
@@ -164,7 +162,6 @@ examples:
           device_type = "pci";
           reg = <0x1000 0x0 0x0 0x0 0x0>;
           reset-gpios = <&pinctrl_ap 33 0>;
-          max-link-speed = <1>;
 
           #address-cells = <3>;
           #size-cells = <2>;
-- 
2.35.1

