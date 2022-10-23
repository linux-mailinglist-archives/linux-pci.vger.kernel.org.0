Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF36094F6
	for <lists+linux-pci@lfdr.de>; Sun, 23 Oct 2022 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiJWRCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Oct 2022 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJWRCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Oct 2022 13:02:52 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F94067C99;
        Sun, 23 Oct 2022 10:02:50 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout4.routing.net (Postfix) with ESMTP id 895A710085C;
        Sun, 23 Oct 2022 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666544568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/+qwOcJ+Ykv/tsQAvaNcC2RFDOgqrMsuP9mqjxWRnA=;
        b=LVZpdg+qdJ8mDixU4po/b2W0QM58yN/XDmsrGJHfrBjdiWXN6UFnr/hVnILmrgliAOQ7KC
        uc1xHy3g40URxyRYBgMtTzX6EZvo5rYzXk1OCBPIwatL2+xtedyt/UNqmzFlsc9RHt6Pzh
        MQSAy4BKccYrLk2GW1OdKaRjcFqtKxE=
Received: from frank-G5.. (fttx-pool-80.245.79.234.bambit.de [80.245.79.234])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id B2C9F100352;
        Sun, 23 Oct 2022 17:02:47 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sam Shih <Sam.Shih@mediatek.com>,
        Steven Liu <steven.liu@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: PCI: mediatek-gen3: add support for mt7986
Date:   Sun, 23 Oct 2022 19:02:33 +0200
Message-Id: <20221023170234.83621-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221023170234.83621-1-linux@fw-web.de>
References: <20221023170234.83621-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: faab5a44-dd36-424f-82ff-370abfa0d751
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
---
 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index af0d2201746d..3662422b38ea 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -48,6 +48,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - mediatek,mt7986-pcie
               - mediatek,mt8188-pcie
               - mediatek,mt8195-pcie
           - const: mediatek,mt8192-pcie
-- 
2.34.1

