Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0B626919
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKLLSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 06:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbiKLLSc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 06:18:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7283A222;
        Sat, 12 Nov 2022 03:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668251878;
        bh=pCQDOALh79Wg0//BO+hwd+gUI9nb61JMC5A9n1oxDJo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tC3jbkeFkyX2cGN5JP1yoh4sVVWUa5ymY5NF+It/5QcNljZdruXu1yBVIN1g7T1qe
         A9EZgSPfohPm/l3mHuWUeS7927l1fYBKiP92ZCzzfkBYfSPL6g9MJKb5L6xUFkg/Ev
         Zs83RBF1wRw1eWZzTCO53hJPyo4Qyx3iucl4Ubpg5VuJb9njcoms2FNpgpo8MArnfT
         Ih2beDS9/awFyP+bWyZYtoxCk7MOHZUYLjpGuqCRsGAkmR0KZBHzVSThSGMoyPOes6
         t0lAgaAU0zI5LXWOfKpRfmNlOZ2VWyBKNCcj8LM4bWG+heAeLkxJpZx8861Zjdh7Mk
         sjTeHAcdWDPbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.227.41] ([157.180.227.41]) by web-mail.gmx.net
 (3c-app-gmx-bs18.server.lan [172.19.170.70]) (via HTTP); Sat, 12 Nov 2022
 12:17:58 +0100
MIME-Version: 1.0
Message-ID: <trinity-33afde2b-7023-45f4-844c-db49f68e38aa-1668251877983@3c-app-gmx-bs18>
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
Subject: Aw: [PATCH v4 02/11] dt-bindings: phy: mediatek,tphy: add support
 for mt7986
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Nov 2022 12:17:58 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221112091518.7846-3-linux@fw-web.de>
References: <20221112091518.7846-1-linux@fw-web.de>
 <20221112091518.7846-3-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:IdjKRZAc4G6HLMosS9W3l4ACXAgHyMBKtsfZjV4glKnOIzpgLETAF/Ge5C5uC/JhQ6zhZ
 /Zvg98qbTZFOmoFYCHzhZG5sxbYMoGDfz5NyaC58aArUlPzICX8mFJZzw2ZfO9S3lKXGy3BetKKi
 339Em2xQ9y3WF05mYO60eRivo3jDP2APs7nYnDZn9c/qjxP/IGwmfTaMoq30YO1xt8nfdyTEj7R7
 O9m8Dghdk8Dqr+rq2rF69B43EIqlU6iSuD3jvw35BgDi6pJ7SDX59buR56WIYe8gzXP8s1CDX/Oa
 Ik=
UI-OutboundReport: notjunk:1;M01:P0:Wc91JkxEs9I=;xIIdT2P6VfTS19OEOCIzPeazsU1
 n1qm5hLpvysdWBP1oqyWMAFpe5vNdlKFVrtIPzSrbmEmH2ED6XNLsi46eP617uq7hhQJH/zBM
 DS8FrSx2mFuk38mJsDr4xMLcinXuQswZN/dpJH/qHFTSHwxlonxzT24tZNsYn2UABe0C4Ulgk
 rlbfKzC1cEbF9kYOWByhDvnWQKEq0RvuB9QM3uPOFiXec3DAchkKMrwJIRgtG+z5bjs5EkHll
 6DoZGD9DgxJxQ5ToSH2nKlNyq52WLWXYWWikIJCano2QLV816u2+i2L72C/h4nXsUsdDIP5d/
 CBeRv6+U3qcDm4Pi6RnFU/xgqFNqsLdKIlYRRRcB24qZt0aBPpnJlkwGU4YMGgnCjbdEW/Dex
 sqRrXwV3Kqyssq6xwMvlQd5Yp3Acgw0BNy3gv7p6bwO7DtrMVf3PUNmsurROoX42gHKseyAc7
 qskz+HyFSwMlwl3EUGwgviSYfHjp2BpBLjyhAh6EhgLuKpQR9f1rc3f1W8txvGBN/7W6gywdq
 LTdwp3Sisurq1EyHwhxINCvnziH6Kvx9X8316+4ipx1QJwO/918v99elQFXmL+c5Qxh2AxP9d
 dnXPTRbigZEa/VgW4Pd/W+bw9nLTlAggS5LA1w7ZrJ65ybPFvJobDAdrN4tdk9lfoJb1uillM
 UsfOV8TItHB+Moe2oYOJzqyH3aS17kHLAq0SIXMuhYHiujRTCLsfZ5/oMjepyVcm+s5fQ95T6
 QGAQg5UQxreUGlHKg/3bGRhWCzrRRevxxfmd4FCOhM5vhi7vSEb5YfTDJZpH1LqIX0ebqHQM+
 sCXz0Qoiz9HGFjvpLC87PgYg==
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

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20221017104141.7338-2-linux@fw-web.de/

regards Frank
