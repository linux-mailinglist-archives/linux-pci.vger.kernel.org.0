Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AB962B607
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 10:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiKPJIY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 04:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiKPJHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 04:07:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3113F220ED;
        Wed, 16 Nov 2022 01:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668589604;
        bh=JzsGOJXboxKM/3crZDIoEMyOlym1tEKRyGk1X7tJOE0=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=opY5scHBUpdgu5gihOElocUqXf9RoIIv/ruFjs3wkFGtMi7OrUoBj9UWUP5fxuXSo
         br3rUPMDQozK77dNdkOfSr2fkymMLkCQmPGhM102cMWD2uTP0aBUD1WyyaeS45Gb+B
         5XDLEpHZ9JasvKi+X/HWsAszFj/ia+/rEtlKvJDiAqsTcaDauawUzsWuZVSA9W9AsO
         zV6C5vzi/3vFefLseQVKv77r7wSiSKAisu+yO76O9lHkBV0rqk0hqRW8IRFlQ8t7Ki
         Q6tGUgbEnbSOgfEOOp0YoNCEx2Isk7NOVqdF+vXAjyTrIJpnYNOjNczzXX0+2xaykX
         agQm3qRyt4gYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.187.100.158]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1p8NaF3cga-00vPwN; Wed, 16
 Nov 2022 10:06:44 +0100
Date:   Wed, 16 Nov 2022 10:06:29 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Golle <daniel@makrotopia.org>
CC:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 10/11] arm64: dts: mt7986: add Bananapi R3
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <Y3QMMKGc6uNFyfWb@makrotopia.org>
References: <20221112091923.9562-1-frank-w@public-files.de> <Y3QMMKGc6uNFyfWb@makrotopia.org>
Message-ID: <46481C3B-3B46-440F-B923-02934E0445F1@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rehvp2Q0a87CjyOMm8vKg+p92Q77SPjMTuCe012oBGxdzZVfWkj
 YBh88W32HzaGgeWQE2MShbKCC2M8d7DdJ+2MymyUSTbOkv2FYOM9ET0Mn6XgDYnx8OFUq6S
 SSw+BL6nm/b4319IdgAFFtTT6NNFY8YtUpBsWG5J9mI0veVyaOSZoFrI4zqlAEECYUHVBaX
 lRsvvsSTTxZWwYq3YenCg==
UI-OutboundReport: notjunk:1;M01:P0:Yg1rpNvtESI=;ewnDyjRW58XaqRskOpwg+Ef6gi4
 z+IL/9QzhsodSKsHI/5SHVaLHQpep7uQgTUwzQAkCPdoYNfy500OwbUhxx+3ES6OG+l7uVG7F
 OdJbr8H5FN0v7LmRJfm4iDnpO0TovFG/DRTdt3QT+74WXv0eotk4t/SRPbLAeAkMQHwlB8JEO
 QyeADG1ErlosH+9tb86Wx47c0sJCrmsEUnk0zMrc1a8i47mgdX2wzSInH3k793pv9FCeRL3Wt
 G8yApQmnbY39qh7deX/etzqg3DFcPso2KOLBFt3a6/SMeMFs54DB8HD/l492z8pbCjmjPnn/m
 adxbvtuodEgCFpEzvgwwZVTtXIM1yDH3ZT0Gz3eR+vHbV7yQMghLQKVDTB56EwoczrTA6mdaT
 9Jv3BSIKQP65wnJhoQDlKE5sorcTEwoHbnH1xMykMaB8zIvynuC7Z9dfc7FccR7tIhV/wmuji
 eRzD4KuYKrZpLjOAL6Mk+O2rNjfyl8EFbBje3IZY9t2jBSJsrqtqiXIfZOYPTMlzaSpAMb6ia
 UHWW9jOSWosQ+9yfA352aX73A6DlHZrGkUCOwxFh4AABRaI6tBs4/Q+3BzSeZVSUXRvjAO5EN
 /xgAk+sPiN7pv2fDPfRc4hdv9QWeCqe1MYRu7DgY4+2o5rWf/azq8N5ilRrOse7UsUXuOaDRc
 6m9JaGCsNgiKkbq7YkRJCibNQEnB87UC7X0LsyROAJHMFlgvAx8wh2h3mTZzlbynHryjI7zcA
 CdXJmYhLpCmDgx4CX0PaYDJA5VT2k3yKO2UOKET9RCn5LT8hCHVmCc0RPdl60rqHcQqquZg0I
 dqyV38X6IXWgjZwtNBL4nyNbUSz8fniDGcvlF9OFJH1X5rUZjsQljHZ+RLubfDNeM1xzdfYcM
 Xuy5PqUh7qLrRX5/3tL5nPRy2m7dmf+64JoGN5EexBLz9NKxlYm+ej/rh7XS1E4ydD6f0s5n4
 U4NNqtWhoGf+DmliGDuE0KSyqpc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 15=2E November 2022 23:01:20 MEZ schrieb Daniel Golle <daniel@makrotopia=
=2Eorg>:


>The device can boot from all 4 storage options=2E Both, SPI and MMC, can
>be switched using hardware switches on the board, see
>https://wiki=2Ebanana-pi=2Eorg/Banana_Pi_BPI-R3#Jumper_setting
>
>So why do the SPI-NAND vs=2E SPI-NOR switching with device tree overlays
>and the SD card vs=2E eMMC switching with dtsi + 2x dts? To me this looks
>inconsitent=2E Use either one or the other method=2E

Hi Daniel

It is still in discussion,if mainline-kernel will support devicetree-overl=
ays [1]=2E

I used this way to have at least 1 dtb without overlay for booting kernel =
from sdcard which is the only external storage=2E

If mainline kernel rejects dto, we have no "broken" dtb which only allows =
bootup with initrd=2E We can boot this board from sdcard with mainline code=
 only (maybe some users don't need emmc,nand,nor)=2E

As you cannot delete (sd specific) properties in overlays,i added emmc var=
iant=2E And now we can use overlays to support spi devices,which are not ne=
eded for first bootup,but to access emmc=2E

Imho my current sd/emmc dts can be easily converted to dtso and base dtsi =
needs only to be renamed=2E But all only if the big question below is answe=
red=2E

[1] https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/20221106=
085034=2E12582-12-linux@fw-web=2Ede/#25085681

regards Frank
