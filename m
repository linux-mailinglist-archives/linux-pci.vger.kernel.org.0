Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F423F62FFB6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 23:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKRWF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 17:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKRWFz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 17:05:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9914082236;
        Fri, 18 Nov 2022 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1668809116;
        bh=hvzsqeW+pZ6aFflH2DeCG+N++nDpjK40B2TbayEPl3E=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=fxKRAT+HRry568qEjuPyxuqxsmOxh4Ut89W+yMncF4mJNkKMr+YYWLSXrzs8Bhygb
         gtMmeD8NNRrBa2x/408mJhaEpcv+e7EncaHTSisARCpXGDGqE+Ua78jxcb7qs7fB7v
         FqSRREPLyy16mkf6slwzRamQdHq7B0MLmBiGY++cvRU/gct7xlgk5a0NONEk7mmiuJ
         bTMbyOw9Z1x1XJT2wd35t2bO5Tw2ixB0FK1bWOVI+rQL2b3gZ8aZsRWUeC2U9uSdNj
         MQ2ftGVApLk/FLynG7pklgr0+kBi4vdvKgs2JM71nOCdylNpgdyUN81YUkvaeBuzDK
         MZ1DqZv4XCJpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.77.125]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1p5SwP0bLt-0102e6; Fri, 18
 Nov 2022 23:05:16 +0100
Date:   Fri, 18 Nov 2022 23:05:11 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Wunderlich <linux@fw-web.de>
CC:     linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v6 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor overlays
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <CAL_JsqKiRzRToSzk3q+csWR5DEZjZpQWChqZ3mH8MLruvfe=Dw@mail.gmail.com>
References: <20221118190126.100895-1-linux@fw-web.de> <20221118190126.100895-12-linux@fw-web.de> <CAL_JsqKiRzRToSzk3q+csWR5DEZjZpQWChqZ3mH8MLruvfe=Dw@mail.gmail.com>
Message-ID: <99114D73-22EF-43CD-848E-88A37B29B953@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ScE/GLdzMud5Wy9dhqxwyzhpkGMvwUQamRc0PAPEshdXTYQ917R
 W2WaOPx54U0oSso0ZvsU9Tfe7Ytz0Dz0NdoNaAZ3tSrgN3ci493eH4jyax8y3Q2AM8B22Zj
 jnYHxDKAcHQ5+gC+KekOMWdMimNh0IpbabDtg8O1/GJfsLrV/p3dyUaLAA//2lCcDzbtF90
 067bPzcUPbKsFXpppCV2w==
UI-OutboundReport: notjunk:1;M01:P0:jzrKweSzGSM=;rrPo469rUCAif9db3YD44H+IJFQ
 RP9TeEEcYoQ9Y15+4Qqqr36r4ytGk/qXf1ndgvE0mvRc9JcwFpicqvMIhnFQoMMj9kFiSVWCY
 qYOI9NWegO0sFWVYt+uDRy/Vg8oudtQfZqkV1hBdUkCaFtD/j/QUPyk/1ose2PdBVsOwLUVj3
 dVfDKCq454TfNUe8uyD3UjBY07GTdDH2lpppsaj7Nm4ExwIoyNvI9s25LirIJOy1fkXNJ+oRH
 /+Su5ti6m1GrodB6ivViUBGMuiYKA39rVD2YA2SRKf5NT5dtxBaoqxeJhl/VtDHfqIjezjhsF
 MzPbGH+7lFMVCJcUp9O+pvhIU/DR2EXCRmw4YLNz0dfKf02XnNvorFa/Y3Yg7Rk8zYkyVKDMA
 esE6/FuupmZIj+33R/VDPJlsfzZYT1GVAEloc1gXg7SgA1z6l5YGez7T7O5/qY3WbLRWFQF8U
 UNvsPnDOSsBlenzsvz8kPyftCqdxm1azeq3S6ACDjTAmwwu0KKe0XAEHLo8nE+gowCCcY4jx/
 dzXeOiFnVVQOsgNxJ8Ly4abKqimvAav0m2tEywHZBUuKb/H09Dna+GBcCmfkOPRUfOhKozxP+
 Y5/IqectOej/avAT347nvrLm9Cl4IXPYjzzSj9e4QafM98y6hd1/wJh6orfb+Z1LfeQ18iDm1
 XEA3kJVKu9rum8z0BDUk1jM7XY74zCuz3p1c5IhGH5WYxQdX0JnLkECXlyy8UIyvU1L/YoQwu
 iED6oE1g2tVYPQAW8KS0DsuEmrLTF3/B8AHrtZFZvJABhlG4LLOYmumZNrbNbBjb3zlIVK6GG
 HtrmluWV7dcXPXe1YH/AnUqR2kaZ2scpnDI1fyP8Xd1turb8JZUBcdN/vNqg0qiMRt/JfXzfZ
 6YV1DFoB4zYXZxodKoC1hU6hE9xlGtaf3Nlhn6fJjGxSsrLTIwSOXtvQMD/b+msc+b3nhs8bq
 J2vMfA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 18=2E November 2022 22:39:52 MEZ schrieb Rob Herring <robh+dt@kernel=2Eo=
rg>:
>On Fri, Nov 18, 2022 at 1:01 PM Frank Wunderlich <linux@fw-web=2Ede> wrot=
e:
>>
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>
>> Add devicetree overlays for using nand and nor on BPI-R3=2E
>
>Can you not tell at runtime which one you booted from? If not, how
>does one choose which overlay to apply? If you can, why not populate
>both nodes and enable the right one? IMO, if all h/w is present, it
>should all be in the DT=2E Selecting what h/w to use is a separate
>problem and overlays aren't a great solution for that=2E

It is not the decision about bootdevice,more available devices=2E

Only 1 spi device (nand OR nor) is available
at boottime as they share same spi bus and
chipselect is set via hw jumper=2E
Both nodes have reg 0,which is imho not
supported in linux=2E

I choosed overlays to add the right spi
device on the right mmc device where
similar selection happens (see patch 10)=2E
Either sd OR emmc can be used (1 mmc
controller,first 4bits from bus switched by
hardware jumper)=2EBut for mmc i use it as
base fdt because i see mmc as primary
device which holds rootfs too=2E Nand/nor is
imho helping device for accessing emmc or
like rescue system (only uboot)=2E

I probe in uboot if emmc is available (mmc
 partconf) and choose emmc else sd=2E For
 spi i try with sf command to check for nor,if
 this does not work i apply nand overlay=2E

>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>> maybe rename to dtso?
>>
>> "kbuild: Allow DTB overlays to built from =2Edtso named source files"
>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/robh/linux=2Egit/co=
mmit/?h=3Ddt/next&id=3D363547d2191cbc32ca954ba75d72908712398ff2

Should i do this?

>> more comments about the dt overlay-support:
>>
>> https://patchwork=2Ekernel=2Eorg/comment/25092116/
>> https://patchwork=2Ekernel=2Eorg/comment/25085681/

Daniel suggest define sd/emmc as overlay too=2E=2E=2Ewith way you mention =
below we could create 4 full fdt without applying overlays in uboot=2E

>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev=2Edtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-rfb1=2Edtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-bananapi-bpi-r64=2Edtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-emmc=2Edtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand=2Edtbo
>> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor=2Edtbo
>
>These need rules to apply them to the base dtb(s)=2E You just need:
>
>full=2Edtb :=3D base=2Edtb overlay=2Edtb
>dtb-y +=3D full=2Edtb

I would prefer to do this in bootloader to allow all 4 possible configurat=
ions:

Sd+nand
Sd+nor
Emmc+nand
Emmc+nor

>Rob

Hi,
regards Frank
