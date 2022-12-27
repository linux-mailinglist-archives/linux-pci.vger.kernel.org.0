Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4DA656977
	for <lists+linux-pci@lfdr.de>; Tue, 27 Dec 2022 11:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiL0Kab (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Dec 2022 05:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0Kaa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2022 05:30:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D512B;
        Tue, 27 Dec 2022 02:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1672136978;
        bh=6rUL/0fqLXUc3EXcoTbmuRQCiIi6QAilAchLciXsdAw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=r+YiZvZlnUxMyhBIQFkg9VK1CsEsBPCu6gPQmPLEQAbDGpbAgmHGBNxB9+1Wb6M8d
         bup5FzjJkrbh1fMYLiyeFtuDwJa6ZkHx0E+STBoBmQLLSf4a7EBZmaXYTnyqq15MK6
         bih6f6Upn/2wdI00+suCEySy+JEh086fjGTuOr71z2z7vLwlI0gNKqv9/QQRrajwr2
         cXjHb/p4UJPo/MrkCPMTfwfNWb0jtaiEVQfgMStgHTrt/o4A+ZUNKX6xZMRIGbLwWI
         w5r8HysTrW/d6YI606cN0756PxNSy1S7CL4J9npulX21/9iXbrjfPpZEFkmcmPijUz
         xVlGB6lU/wpfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.153.252] ([217.61.153.252]) by web-mail.gmx.net
 (3c-app-gmx-bap27.server.lan [172.19.172.97]) (via HTTP); Tue, 27 Dec 2022
 11:29:38 +0100
MIME-Version: 1.0
Message-ID: <trinity-6777c8ee-36ac-4564-8542-f74d3a942a91-1672136978587@3c-app-gmx-bap27>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org
Subject: Aw: Re: [next v7 8/8] arm64: dts: mt7986: add Bananapi R3
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 27 Dec 2022 11:29:38 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-256904b6-bbb5-4424-9686-50ec7fa14f26-1672134220733@3c-app-gmx-bap27>
References: <20221127114142.156573-1-linux@fw-web.de>
 <20221127114142.156573-9-linux@fw-web.de> <Y6dMWFy7gChG88j0@makrotopia.org>
 <trinity-256904b6-bbb5-4424-9686-50ec7fa14f26-1672134220733@3c-app-gmx-bap27>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:uoMc7nMOIJIrLTMKyLHi5Zf+w/mb4Fzoluw4dxHqiG7Oh3NCdu3bQPysJDKjXeSdF3pWn
 jaWkxXdLvNm01Hn/aewnT06IsBqEfmbeCdLtU+ilvh7Nvs5l2AOup2GSF8gppkuGSLyU1iSxGiv+
 ptXmk1z2u14AHo0epOf9V04OMa20adKrX+D38DcBs6YA/e2rffYiPf6hNVrblfNU6Q8qlHy1svFl
 FcSO5I8fpT3Bm/fGPcLdiGgk4WFUT8NQRt3q3Fb+zatO03cpqNqj3lWpRWG9hHwQNVG2DrXuL1YE
 Tw=
UI-OutboundReport: notjunk:1;M01:P0:zRngNs/wW1c=;wpD4ghfb7HZxstpqtJ4IJmHdX7N
 Nh97dEZkWW/RqQx7esRtmZ/sUkd5Z7pn7kzVkfTKFrprUoZ8RYp8I8kjw9SfGMq17fGTL6teZ
 xNEE5R5GD9wo9ZYbcwsY8iCr/nkj6AV8L5j2Zt8xwJDFoezR7BDmknG4R3j4milCUSgJOdyi/
 cIzq+a9DCoQLMcR1Z0wjpmY/ZiMQy5JVt1e8J3340hf5RTTs2gujA5Kf4T0/wLTYEOeWc/1Lh
 GnxQZuRatOn35fBKz7I10efG2DJUqmCah6Ab/ohbSEZqlNM7ZmbxVj4lulKoMrTIG0UuwjUmu
 QJZ6tbNcIXDKsJCrqNX9PW1CvD3tySRFkXbS4V5ifIsoL0fAHXy1USexOWPXRDva1TAi8OIWi
 a8KkRFoU+3N5QXEghfPevzMmkf+f7WeSLEG+ySQYFC3fyJ6iFp1t9oxEv9cZXxYUGZeCURbUe
 L42ylPAQg3xqLQgR82+aXdFWKEYTVfGPBqgekqye/ZhedDaIu+hkMivudxlY6pOB+Y/vy0h94
 x1fS3kz+qVRejgFh6fKMxDq+NTUgRMBpNxaKqBAHXQyDf/8Fdvzq/ug8EGuKyDR6PAPQ8gDhr
 EvaTpEPQPX6pt4qBGEWYO8SxLgjDQL5zr2VqYDoCkXKGufX6YxVPG4nG0xm2iw15fHHb1FeSf
 FSi4gbxb5+5ZQ19xfx2v4QEpeeOtNHBWrmy1asxToSqD3FcI+HUX8MXJEJxhUkd+1nnvcugAD
 K8G749+8bBgWSqokMRKk4onu7yBdK09ngsSuA2d/e0d1Zk3F+bOrgWAQXBJIEeWOdAVxtHCwy
 4jJA7C8+M/YaDnXtB/4ZYFug==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

looks like i've found it:

when reverting these 2 (latter alone was not enough and seems not fixing t=
he timeout as shown in my trace)

Revert "spi: mediatek: Enable irq when pdata is ready"  (HEAD -> 6.2-rc)
Revert "spi: spi-mtk-nor: Add recovery mechanism for dma read timeout"

so this breaks spi on mt7986:

c6f7874687f7 2022-11-28 spi: mediatek: Enable irq when pdata is ready

have sent bug-report to mailinglist and author/reviewer/maintainer...

regards Frank


> Gesendet: Dienstag, 27. Dezember 2022 um 10:43 Uhr
> Von: "Frank Wunderlich" <frank-w@public-files.de>
>
> at first look it seems it is needed...as i get this trace with 6.2:
>
> [    2.145931] pc : mtk_spi_can_dma+0x0/0x34
> [    2.155212] lr : mtk_spi_interrupt+0x74/0x360
>
> [    2.091801] mtk-spi 1100a000.spi: spi-mem transfer timeout
> [    2.097310] spi-nor: probe of spi0.0 failed with error -110
> [    2.102930] Unable to handle kernel read from unreadable memory at vi=
rtual address 0000000000000010
>
> but i get the same trace when reverting the cs-gpios change....seems som=
ething is broken in 6.2-rc1
>
> 6.1 works without the bogus cs-gpios (and the mt7531 interrupt-change)..=
.
>
> have tried reverting this commit, but it does not fix the issue:
>
> 8330e9e8269b 2022-12-07 spi: spi-mtk-nor: Add recovery mechanism for dma=
 read timeout

