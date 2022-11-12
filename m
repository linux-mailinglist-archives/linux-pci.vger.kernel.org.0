Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FFF62691E
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 12:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiKLLTO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 06:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLLTN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 06:19:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC51570F;
        Sat, 12 Nov 2022 03:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668251925;
        bh=rp7zYqpOsau/LPIR3QvWAmM9M3FNKxiBJ0iJkyMuijU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JuhM5ybwF5gc+v79eCj+IvH2l036jTI020NgkMPbe3QYZRjidKTEjW5WoGJVmsd9J
         22oe31g+QvlOE73Xe1OpFmrkKHlYWUe5hr3vD5p5n7LoKIKEm3SsYj7ffdZPDkDbvc
         3qRTc6DyHMVnz0UALX4Hc4Rm3uwzIW6AloSAJ9VKXJJxOQbTlDB6HA8UAhV5yqV5oY
         sQCLMVa9TVyDf464kwnXEVBfEW4LGHKHO62EumkElDXW+y8ZQl75aQZYFWHt0LKTvr
         g3aUU0UV1IfkwOv+v6VgApUmGejFne7/DP3Lcbu02Dh0KsJeQ8yJIZurq9oma21foN
         tca6VycS14GiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.227.41] ([157.180.227.41]) by web-mail.gmx.net
 (3c-app-gmx-bs18.server.lan [172.19.170.70]) (via HTTP); Sat, 12 Nov 2022
 12:18:45 +0100
MIME-Version: 1.0
Message-ID: <trinity-74ed6753-8790-4b4e-b479-8b79594deaa9-1668251925295@3c-app-gmx-bs18>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
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
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Aw: [PATCH v4 03/11] dt-bindings: usb: mtk-xhci: add support for
 mt7986
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Nov 2022 12:18:45 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221112091518.7846-4-linux@fw-web.de>
References: <20221112091518.7846-1-linux@fw-web.de>
 <20221112091518.7846-4-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:gCRoOpkI2dmBRiFBhn0pU9g6q49HTv0O8fEgaXiLsVAXzpLqMNbIn85QOPLr3N/vBYIXH
 WTylJph/OdYJnhgtFfTamYnylP/AdKUIfBu6AqCaxy9/Yd/hyv0YV1LJ5Q+nKlR0ughGRgyazSqo
 iX4spko7QjCGGWUmkxUnA30Js5isX49SecDWSA8NbJsDVzs4foq6++Xzic6VkiAnPeH61szIVIKd
 1ixmQGyTOgG1NnC4VmqMvyL1fzK8XnffDvuKdyQUTUng61ACp+NklnmqwPDVcOu+on19uvP9rCWT
 5U=
UI-OutboundReport: notjunk:1;M01:P0:lCc17Sn1yzU=;z2pK6blWRcnBHwu86+5E0PgAAkj
 xGOA5K/vmoAeepi2y/t+uUzg5F7ZYKMrqYpyrtUSqcIX93dLGw8aI7mz+F5UZpCtoSZmEytNJ
 Cq+Q2voskO1u4QaZk8KJ3e4gjBkfz4UJtyAsCm8llAAPPoBeboWDlAxZPcBIQ7UPOQiAaTUoZ
 neWMdEyzWXjFqWqy9imB3LFCk8e+/pJwEt1YJceCR++/lND+ebXaoALdMjitN5sr5QXCoiwJY
 cObwDWnPI3H+l3Xjh0XN4kgfTEKsKJcGnYh0LYLrTcM3iCAt0XkONq5Tki4w9ZlAIwRjZ0TZH
 GYQ6IVH+CGz+C0OIyNn6vwM1t9gT8KSJBMs6U17edmKsgXC+/J5bNTpCeQLOOHHf7F4iOHagK
 CAuJjbQX5VuPs+jwiRkqXURtXgcyZ4VBsVDlE1ECp1qfJj2gmMgxGpx4kgP6Rc5nou2Qr3M0Y
 t7ps4A/0s1bY+4jeSW4ydAXZL1t4fG738PdqbLUkCkUki73gaMmDAAJ5rRW79fQE7PfxQipit
 OwAyCGdDOL7vP1vLJxcSmkAZpx3fL4zsENg9IUL6QTMuAUeZicUbfJih6MhytXPJfpLR09Vrf
 VAEEEcobqD08vJl0OHPHH6cvAAt0l5m8/x7Dn0J/PJ4o5Y0WSNE8rKze0CKLg6AkD8YA3WHkb
 nqaaRon6DyZQS3yg90rLqpU8IWteOy+5Qs5h0LzVPKoaNc8KG20WW4dML2+mVPs2CNbh7yX+D
 2Bq4xRscwlqJcV3dIijXyTkLy35P4z2kxcRERQL+j4urJf17FIosEDVtbOif85eB4PcRM14mO
 CxXIP9pwTOC4yMVfr/6rOKKNmfxnz4w1VwYmEWJMvPaPA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i've noticed that i missed the Ack from Krzysztof i've got in v1 [1]

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20221017104141.7338-4-linux@fw-web.de/

regards Frank
