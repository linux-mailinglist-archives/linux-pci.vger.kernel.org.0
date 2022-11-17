Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB662E1C6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 17:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiKQQ2d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 11:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbiKQQ1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 11:27:44 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C27C011;
        Thu, 17 Nov 2022 08:27:38 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id 421D462628;
        Thu, 17 Nov 2022 16:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1668702457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zorltqywtJvpH+5vDOCm8ouz6cvEkR6i53PVbOSwOJs=;
        b=JMOenCf1BZ7VBovSL8w7R6EffCuNTrC3ljboeJ+DZqT/2xA3YO/+rcqa7mG7eGf+LrUigd
        8838WuxXoresOC10bkR5Udb9gih1hYragnwpRtgk0p0by1QSLzgfjMs3QiECIe3Qe1wJCx
        krz6s55+p09qKFxLB3296XuKe0ZSwVw=
Received: from frank-G5.. (fttx-pool-80.245.75.65.bambit.de [80.245.75.65])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id F0B8A100501;
        Thu, 17 Nov 2022 16:27:35 +0000 (UTC)
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
Subject: [PATCH v5 03/11] dt-bindings: usb: mtk-xhci: add support for mt7986
Date:   Thu, 17 Nov 2022 17:27:20 +0100
Message-Id: <20221117162728.20608-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117162728.20608-1-linux@fw-web.de>
References: <20221117162728.20608-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: d8cc6aad-2523-4429-9dc7-7de00f7b5bc4
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
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 939623867a64..a3c37944c630 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -28,6 +28,7 @@ properties:
           - mediatek,mt7622-xhci
           - mediatek,mt7623-xhci
           - mediatek,mt7629-xhci
+          - mediatek,mt7986-xhci
           - mediatek,mt8173-xhci
           - mediatek,mt8183-xhci
           - mediatek,mt8186-xhci
-- 
2.34.1

