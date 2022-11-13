Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34069626E67
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 09:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiKMIAX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 03:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiKMIAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 03:00:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85128F002;
        Sun, 13 Nov 2022 00:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668326398;
        bh=3acDHfn8jKJnznMLsVG0xCR20xZJ2jmq57QrDlNGNmc=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=IM+By4R5MXaGf8bPD/mJ57quLcj85g60ZIbuX0vfB6x12ARuOZ8NXkbwpuvNZJl+c
         kz2QYQsuuuu5alnb0lFKMOUXY1JIml+vkdxn/jBmiQwQ2Iuu+XPjFHdvSWYPn2gQLh
         sDOotj1Lu65K7r+8nyr5XuZwCxo7gcbkS15mmIjCuTNv4M2V22TfBfHP5N29pEvoV/
         cRfsGN/wcCdV0jLgiqpXxEy8jUQ3emWxNMcVhLEvmcGqX8M2jHVuZ5Urz8PmlG4WMN
         ihkvTRJ/beuUYYvi0rPzZg2DMUb/5RNk8nGq75fylfR8s1KUUCxlX87imu0AVNew91
         DqUmSyITTX99A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.74.27]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1ou7uI0vwG-0007QC; Sun, 13
 Nov 2022 08:59:58 +0100
Date:   Sun, 13 Nov 2022 08:59:53 +0100
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_04/11=5D_dt-bindings=3A_PCI=3A_m?= =?US-ASCII?Q?ediatek-gen3=3A_add_SoC_based_clock_config?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20221112091518.7846-5-linux@fw-web.de>
References: <20221112091518.7846-1-linux@fw-web.de> <20221112091518.7846-5-linux@fw-web.de>
Message-ID: <F894EE66-6824-43C7-AE04-7AE6FF1C52AC@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GUCsNyzDalZvWOJYdXrFPJmqG2HqRf25PM8dw6TA7DzeHRVC53P
 uLC2wpK1PjOwQKyB/73jGq1NLinwFc1rN1/UFJkrLbqnpkH5NBT1nP4asPu4hqBhT3Tpilt
 urMDX2Sk1pMqFUC07KwwCBywFgrKRLck1KxsgDdiQHJ22yVfECODzaB/RG+jgJHptT3PxmZ
 5Vlna3KMRTIB8N+Nhs7xA==
UI-OutboundReport: notjunk:1;M01:P0:pUUva5akvIk=;DbmGJfxgnH1QL1fCq2YPuyMYNlt
 pIxwd5dNSo4z+ai0OzGHBcupfJZyt2rveBjwVPyz5o8/YKl/Ae+En/QCgE3dRQLoAG2lWqek/
 iB7CdcHTtg9NBxQ9xhI6RtyyMSBOe8rJGiTmxNBze/JMX2Ho2MXUvzhOpKGnsy5c2kz2MONX/
 OK/dqTjNzyth3cXZXU/4RNKS1aau9pC1FOfjHdsy4zp0TePszfMAold9FyC/bNxu0D7CSK/x4
 jOP4dw1UHSaJ9juq6X03BXxWF/vaxpIsiPWlbb6sRV0MuMhQI/4sWz72LLfF1OhSUHf20qIGz
 iNTS07ivBgQuRcz+yNu59z+5tQ7ZvX64CXY0rtStfUlUKKNIsZN3wQXgy5EVWWmeajRp97XkF
 aSB1tBg4e4MlamIAEEbJYkuhguo0+QoiPy09JzOoCp4qUjizaLjWVK8esh59jBUJuXtiiWJdg
 14/KvkHiD95hgi+zoyVgiQxdkrYwlgdLcxcyqpDvCq0M7mZIA4vrgQ+A7X2ygH5J5VZac9LY/
 ikjyAjIokHQGO7FCwknlYVJUGBbqb1XP/DJES6pEbj6pPs26c8egt5X/K9czIy3FhT+oIyv68
 13eRA61sYVKFBIv1gnXwBipiStwmp2sgypwp2ER0MSLTARh+05xqBKC8j6Id/k44GKQ/AoyyO
 3bqOMbkKZ0TfWWQBU4OpT3dTbGiCfuiVGF0dKxSsrd+TKXQFnGr3X8dkdEQtxRBsxzxGQR6/c
 L/qbkaSFiDMgELGvWX5SXCE9CIo5rGOFS2APHgjUPbT+CkP8NtDFc7diZqkiLEB3ikCEeUZ2p
 RnFC/GdYRNlhlASqX/4wy8c/e6GI9PO8ZztyzgTyeDisxj8edULt1ozo+kDqMg0nqL5lTm9wA
 rZx0M+jtbKhZHe7hagMhXn1dFufOLaaDRmIm/meA0KcK7FNhZ+fzRI29PCB1pN8PLV0ejo4xw
 RVOhwXaqC1n8BOlcnz2aMO9W1NA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I missed ack i've got here:

https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/202210291758=
06=2E14899-2-frank-w@public-files=2Ede/

Acked-by: Jianjun Wang <jianjun=2Ewang@mediatek=2Ecom>
regards Frank
