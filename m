Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6B6B9700
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 14:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjCNN5Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjCNN46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 09:56:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49982211D;
        Tue, 14 Mar 2023 06:56:01 -0700 (PDT)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EA83660308F;
        Tue, 14 Mar 2023 13:55:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678802159;
        bh=37ljbgJkpZPvb9TsF+DacOqstVGArWpTYRb2PXFGvQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmTWq49ZrHWRELwwEFA6LQdTmWRrBo4rWKwqLzLaH6VuhUwqqXp/7LHr3IJfoMi5u
         2InmgkAPTh/0z8n8DHT7xIZAgGnfcLwItpM6MpRFB7DEsRY6sLxqNPwb6j/WS0Tty/
         v4tPcfuvnQaIrf/omYEVP902qgTIvtSGk5FXEu4ofr1tkG9RfdoAG348pg40DieZxa
         5CzkoHyLdvD5n458AOdMK+1yDgi+vrQdorxp9slEZ0jjFqTWPTdT94mJFZE10SDuHc
         XgOY05ppehOLpx6N2WBbjSaW0LmD5HhZj8c7llTZkEmlhk9FcABkZWUkAkVbRdG9NO
         XpKErX7e1g4pw==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCHv2 1/3] dt-bindings: PCI: dwc: Add rk3588 compatible
Date:   Tue, 14 Mar 2023 13:55:53 +0000
Message-Id: <20230314135555.44162-2-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314135555.44162-1-lucas.tanure@collabora.com>
References: <20230314135555.44162-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe for RK3588 is the same as RK3568.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 2be72ae1169f..24c88942e59e 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -21,8 +21,12 @@ allOf:
 
 properties:
   compatible:
-    items:
+    oneOf:
       - const: rockchip,rk3568-pcie
+      - items:
+          - enum:
+              - rockchip,rk3588-pcie
+          - const: rockchip,rk3568-pcie
 
   reg:
     items:
-- 
2.39.2

