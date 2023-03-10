Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B476B3805
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 09:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCJIFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 03:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCJIFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 03:05:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0209CB1B3D;
        Fri, 10 Mar 2023 00:05:45 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65BC46603083;
        Fri, 10 Mar 2023 08:05:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678435543;
        bh=+ZX7vYLxaBazI08zF5lNguc40/rFNVo9sCm+2OiHagA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6hA6R1SqYQZ8YdpMwHANgLV+I9hzt66+OemjAwE845VtxO74K9Po0yR/hVpmVMyu
         f6TgbY9c6KP0RDpUg410/rYRZ+GOdjEpA2EQqx3gefaidQAsb1eD3Q8hE7Fq/+GFHm
         OeTDg5c54bmdFCsPx3xsrqHpDCFrSkfOr5OWemVy2McvZwdhtmPWBQ8piV02l/QsAC
         iFNLsZIStXoDWuJURmmWRetliS5IV2EvNx3bjf3rDAl2/nJQmI25U7/JeQXiifJAl6
         LwysFb/wruv0JXp1RVe8oFJ8Mf/cLKf0XGbWgdgxdl55E79Vf6mV/vyR97+SmkeQKN
         uG839CYQzQbTA==
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
Subject: [PATCH 3/7] dt-bindings: phy: rockchip: Add rk3588 compatible line
Date:   Fri, 10 Mar 2023 08:05:14 +0000
Message-Id: <20230310080518.78054-4-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310080518.78054-1-lucas.tanure@collabora.com>
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
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

RK3568 Naneng Combo Phy driver can support RK3588 with the additional
clocks and initial configuration, so add the compatible line.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index 8d8698412de0..9ae514fa7533 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - rockchip,rk3568-naneng-combphy
+      - rockchip,rk3588-naneng-combphy
 
   reg:
     maxItems: 1
-- 
2.39.2

