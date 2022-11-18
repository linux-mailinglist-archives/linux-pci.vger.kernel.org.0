Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09C62FD97
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 20:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbiKRTCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 14:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242845AbiKRTBw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 14:01:52 -0500
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B728130550;
        Fri, 18 Nov 2022 11:01:38 -0800 (PST)
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
        by mxout1.routing.net (Postfix) with ESMTP id D092F4039D;
        Fri, 18 Nov 2022 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1668798097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0G8A0Vfo5m7AIOUJk0K0IJlgKB0iQp40ZYsUGIkco0E=;
        b=miuTTB51NT/kO2sKHO/2VyDlH4Kc5NLo6WnZxaMyP4eIt/g9EX3Kxz2ZrQUQRDJPo357nW
        EKDcCfvHT4l7gcTBVRKJMg6gHPWbvrg5/ptkSesICi7iyy+/D8hstXwaKO8UY3zbSoISKA
        EPHLN7RTg+sp3cIzwiZnkqip8AcwvVM=
Received: from frank-G5.. (fttx-pool-80.245.77.125.bambit.de [80.245.77.125])
        by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 76AC81226BC;
        Fri, 18 Nov 2022 19:01:36 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v6 02/11] dt-bindings: phy: mediatek,tphy: add support for mt7986
Date:   Fri, 18 Nov 2022 20:01:17 +0100
Message-Id: <20221118190126.100895-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118190126.100895-1-linux@fw-web.de>
References: <20221118190126.100895-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible string for mt7986.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index 5613cc5106e3..230a17f24966 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -79,6 +79,7 @@ properties:
           - enum:
               - mediatek,mt2712-tphy
               - mediatek,mt7629-tphy
+              - mediatek,mt7986-tphy
               - mediatek,mt8183-tphy
               - mediatek,mt8186-tphy
               - mediatek,mt8192-tphy
-- 
2.34.1

