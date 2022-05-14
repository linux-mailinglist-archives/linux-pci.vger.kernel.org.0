Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C875270EA
	for <lists+linux-pci@lfdr.de>; Sat, 14 May 2022 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiENMAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 May 2022 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiENMAC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2022 08:00:02 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01F933D;
        Sat, 14 May 2022 04:59:59 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id CE0035FC10;
        Sat, 14 May 2022 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1652529598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttHT2OQZW/lQ13w5WH/uXi0/FTKlddoK8Am2Usb16Ys=;
        b=h42QGt7IruIjVaHemwUlmWMOIwgLJkZ48UVRCgf7BgUnN4JNyb3RJCxzV6163QJZ9RGXcb
        1bt6vtZCCCDPMQeJ0rZQlzgjJ9+cyMsjBslBeFRRivOE31RLrY0cAxuacZeYRyATe8cdpl
        TxajbMSzH4GIlqXeXv9sgx43xfyCXgQ=
Received: from localhost.localdomain (fttx-pool-217.61.148.252.bambit.de [217.61.148.252])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id C71C936077C;
        Sat, 14 May 2022 11:59:56 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [RFC v3 2/5] dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
Date:   Sat, 14 May 2022 13:59:43 +0200
Message-Id: <20220514115946.8858-3-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514115946.8858-1-linux@fw-web.de>
References: <20220514115946.8858-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 20ca8f05-a1b3-4470-918c-07cf40a24a11
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatibles for PCIe v3 General Register Files.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

---
v3:
- fix order of grf-bindings

v2:
- add soc-part to pcie3-phy-grf
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 3be3cfd52f7b..a854e1f10d63 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -16,7 +16,10 @@ properties:
           - enum:
               - rockchip,rk3288-sgrf
               - rockchip,rk3566-pipe-grf
+              - rockchip,rk3568-pcie3-phy-grf
               - rockchip,rk3568-usb2phy-grf
+              - rockchip,rk3588-pcie3-phy-grf
+              - rockchip,rk3588-pcie3-pipe-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
       - items:
-- 
2.25.1

