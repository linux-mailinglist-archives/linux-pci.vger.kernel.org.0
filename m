Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A00626E30
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 08:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiKMH5M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 02:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMH5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 02:57:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F910FE0;
        Sat, 12 Nov 2022 23:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668326194;
        bh=89zGoUuEp0HViTv9Y4Q00ELT3Jsiq1G3fJq8q2YvMXU=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=HsweIWo/8e9KBqGDXifPqdRYg7hPtBJn+NSsXfDJveiKDLIKaOZPvC9mBVGShVL6O
         Tcv/J2tPLwAN8VEcKo47xB1ZkyeIyTpTyFuwJcQ1tCbNhmRsm4byeIPyfXSMTGdN7R
         TIX7ty1r7j3b0tl08iDZsPunz1HxwCgXhsBiaMBtPqnHaphDeZ5Wnbz8jpDWnHfLJO
         sgh0zw8wbnjXXq9ysLw4hVvkM9FqGHQhN0ktto801QPHl2HjC4JOeQr/Q/jo4g2W63
         0jRYSeDahc3pBFFt9+H+Ms35dyLHZzf/xmEPaMxqabTZ3lKGPMIB5+r+groVm7rd/9
         Z+Vd6JI5Gzrvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.74.27]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1pP4st2nFx-00e34I; Sun, 13
 Nov 2022 08:56:34 +0100
Date:   Sun, 13 Nov 2022 08:56:25 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
CC:     Ryder Lee <ryder.lee@mediatek.com>,
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
        Rob Herring <robh@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_05/11=5D_dt-bindings=3A_PCI=3A?= =?US-ASCII?Q?_mediatek-gen3=3A_add_support_for_mt7986?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20221112091518.7846-6-linux@fw-web.de>
References: <20221112091518.7846-1-linux@fw-web.de> <20221112091518.7846-6-linux@fw-web.de>
Message-ID: <25CE3BBD-05B2-4E44-8451-A164C5BBB9BD@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RXjpN3W3W08raP5C+yB86kDRdauG6M3S3eL3CGdnFOEzy1z2uqO
 c0VuIMpQdLSMca3RMicXAAFQWhc6aMaZD2torvrkll2auuhfPeZDEUrJE+JETn/lZyeqXf9
 ynsmAmu7Is39/DsSy6ZiKkA/JNLZ5PClaErZVvZK/rsg5/1HjbCFpq6c321bQpwjFrfFEOY
 vJh1yqsy72FaLvEJcT3/A==
UI-OutboundReport: notjunk:1;M01:P0:rvZvYhD2qSo=;guJK+ePlyLa4DOpD8osZUFG8WXV
 qQXP7A97MRV80Pt4Z9vfrJvOhBwbgfSkeuW2oU7l2RG5qWsG7Gm6txwFC4RtUDU4wqPjPveen
 ZvBxpm6WToW+LdKUPe/ixOjOXhe6SkWrV3SbzAjdMWfAZt/t1vrBNjQqmU8Re+O6/mFjXs0p2
 IR321siC4clhkLFqyjCSC8dCyV2PGo1oKxBpTSYHCQQX93BwPhIxOawmxA3nEBE1UOZtpH1uw
 aC9WAPd/IUDrK9FqkqE7YJ2lUgmUfun7yjeoikbmenNy3qYB/pO1MuMjw8EPV8Fxj+3mHu04p
 zCL3I3G1qXv3bGPehpbGPu3860gX65vA2yJYb1mbUs9MyCgiWbZkWi6gy7Ar989zEK269m6CT
 vYWAtQ+lK1TM+5+rD3Fv25Ccx/pjzbplBDXlv/YBso3fyGernQxiea0dIUz4jo20CywWTxR9V
 kkAn6k1YjyKfDR1i8uGWpyBgaMH0qHd0pakOBZU9kxhaYMN6EU9RSg0RyOse9ILwgzsk3Lgrg
 Rmi/Z2+JQeu7bDncltr3T7u6P9KX3DU3jKDr5VE+pgOMsVUGeyZ3GY21I5dPRQD66Ih5ccv7Q
 g7cTgW+8MxLgRTuP7lendVgCljwIrgfinJLwPudC3D2+du/PCOjIfdkaeSaxslYvFjzuTxzIH
 Kp2guw4er3l3T2J6a7ukfc1edXc5cb9yrbXgxZqGmfDCsjjNeB/jXpEBvukeo6uwyUL1zlDtp
 rOPG7d3Yc+egCfKysdF4DoEHv1AKX5CLAlV+vmJ2u7vGg9RG+tuQrUu/ZlgKgESPa8dKzN7ct
 YVk9i4Kl+DBS4+egeoBx/L1SzKyU2qjUEI/CPvoxfh7C93kfRtE7rjr8Mzjt275sZTEBSKdHc
 o+9TOT2HWFJHP5FhVe5y03dVU5Ol4ydtCZ2L+vOhiRW6FMNpuoIGfN8nzCTB7nU59/02G7pij
 mYHcGw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 12=2E November 2022 10:15:12 MEZ schrieb Frank Wunderlich <linux@fw-web=
=2Ede>:
>From: Frank Wunderlich <frank-w@public-files=2Ede>
>
>Add compatible string and clock-definition for mt7986=2E It needs 4 clock=
s
>for PCIe, define them in binding=2E
>
>Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>Reviewed-by: Rob Herring <robh@kernel=2Eorg>
>---
>v2:
>- squashed patch 2+3 (compatible and clock definition)
>---
> =2E=2E=2E/bindings/pci/mediatek-pcie-gen3=2Eyaml        | 17 +++++++++++=
++++++
> 1 file changed, 17 insertions(+)
>
>diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3=2Ey=
aml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3=2Eyaml
>index 5d7369debff2=2E=2Ef7a02019daea 100644
>--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3=2Eyaml
>+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3=2Eyaml
>@@ -48,6 +48,7 @@ properties:
>     oneOf:
>       - items:
>           - enum:
>+              - mediatek,mt7986-pcie
>               - mediatek,mt8188-pcie
>               - mediatek,mt8195-pcie
>           - const: mediatek,mt8192-pcie
>@@ -78,9 +79,11 @@ properties:
>       - const: mac
>=20
>   clocks:
>+    minItems: 4
>     maxItems: 6
>=20
>   clock-names:
>+    minItems: 4
>     maxItems: 6
>=20
>   assigned-clocks:
>@@ -160,6 +163,20 @@ allOf:
>             - const: tl_32k
>             - const: peri_26m
>             - const: peri_mem
>+  - if:
>+      properties:
>+        compatible:
>+          contains:
>+            enum:
>+              - mediatek,mt7986-pcie
>+    then:
>+      properties:
>+        clock-names:
>+          items:
>+            - const: pl_250m
>+            - const: tl_26m
>+            - const: peri_26m
>+            - const: top_133m
>=20
> unevaluatedProperties: false
>=20

Missed ack i got here:

https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/202210291758=
06=2E14899-3-frank-w@public-files=2Ede/

Acked-by: Jianjun Wang <jianjun=2Ewang@mediatek=2Ecom>
regards Frank
