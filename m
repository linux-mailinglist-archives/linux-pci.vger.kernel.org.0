Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C85749E5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiGNKAE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiGNKAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 06:00:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157864E85E
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 02:59:59 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220714095957epoutp03b87cd5b2cf02f7effbc2b911999a28bc~BqcQq3ILt1615116151epoutp03b
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 09:59:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220714095957epoutp03b87cd5b2cf02f7effbc2b911999a28bc~BqcQq3ILt1615116151epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657792797;
        bh=0aAHM3hKuspUcMppNQjaigO1obsyhzNCJFbT+4VcEW8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Q3gfn3UlAkUveDiLNhftZ8RXdF09KbLIo6aF651lNObxBaT03BY9zVraRc5p3idbu
         ODQZSN3IxWEPuwAv0qKkpzMw/tYXO8m33NxczhOcWoRLbU6hCFFF7cwT90psF1yMsn
         lQemLHzvLRFka20tz7SnS/sRkVwbTCtbpna8ONyM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220714095956epcas2p49a29c26bba338ec73a6a172b3ab221d4~BqcP2fDTV2288722887epcas2p4G;
        Thu, 14 Jul 2022 09:59:56 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lk92h2mSJz4x9Pv; Thu, 14 Jul
        2022 09:59:56 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-aa-62cfe91cf8bc
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.78.09650.C19EFC26; Thu, 14 Jul 2022 18:59:56 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v3 4/5] phy: Add ARTPEC-8 PCIe PHY driver
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YsW9m6hotDKacXe3@matsya>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220714095955epcms2p5f5e9a3123a368069b5c661cdeb70485e@epcms2p5>
Date:   Thu, 14 Jul 2022 18:59:55 +0900
X-CMS-MailID: 20220714095955epcms2p5f5e9a3123a368069b5c661cdeb70485e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmha7My/NJBi+PC1osacqweHlI02L+
        kXOsFrtnLGeymDn1DLPF80OzmC0+tahaXHjaw2bxctY9NouGnt+sFkfefGS22H98JZPF5V1z
        2CzOzjvOZjFh1TcWize/X7BbnFucadG69wi7xc47J5gtfm39w+Qg4rFm3hpGj+vrAjwWbCr1
        2LSqk83jyZXpTB6bl9R79G1Zxehx/MZ2Jo/Pm+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGe8u85bcNy/YkHXAZYGxv2+XYycHBIC
        JhJ/zlxg7mLk4hAS2MEosfrDFyCHg4NXQFDi7w5hkBphAVuJhVdesIHYQgJKEjvWzGOGiOtL
        XF/RzQpiswnoSvxb/BKsRkRAUeJqz3GwOLPACzaJVW1lELt4JWa0P2WBsKUlti/fygiyilNA
        TeJzhypEWEPix7JeZghbVOLm6rfsMPb7Y/MZIWwRidZ7Z6FqBCUe/NwNFZeSWPDkECuEXS2x
        /+9vJgi7gVGi/34qyCoJoJN3XDcGCfMK+ErMuvIVrJxFQFXizZZZjBAlLhKvn3FBHK8tsWzh
        a3B4MAtoSqzfpQ9RoSxx5BYLzEsNG3+zo7OZBfgkOg7/hYvvmPcE6hY1iXkrdzJPYFSehQjk
        WUh2zULYtYCReRWjWGpBcW56arFRgRE8WpPzczcxglO2ltsOxilvP+gdYmTiYDzEKMHBrCTC
        233oXJIQb0piZVVqUX58UWlOavEhRlOgJycyS4km5wOzRl5JvKGJpYGJmZmhuZGpgbmSOK9X
        yoZEIYH0xJLU7NTUgtQimD4mDk6pBiaxtRN1EtlKRaddcr/88eL2pBvF37pYNRPir93Tq18x
        56dMjI+w4qtF8TYXezWDq/x1Nl67Y9MRePi1Ts3+EBu2tUsCnlx0/rWjs0e8LKc0/NHm9401
        /724OmNvLHYqbjs93/uzUrtx67fAuEVNv8S+Mau0bvojrJ/12mvaKSFGq1WXvr2/+OI0WzTL
        NMHd4lznE1o2bHl9835z4YeJThxnjwVZtGz7KDG3KfmVDhOXnpSVWLqm+8zFRT0Sqf/5csNy
        xdfsuCW/cVngwtetq+04n378+W3902l2zsf+82zs2/aYo41ZcpVF6IKQ15Glz+uuXv3ZIbSj
        qvP51MhnE57/P79j+3TrE3V5a1Yrmk9QYinOSDTUYi4qTgQA5ZNv2WIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <YsW9m6hotDKacXe3@matsya> <YsPYc3YPuG56yTYM@matsya>
        <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <20220614013446epcms2p8c88ea65da49447f72fef6536c7f73fb6@epcms2p8>
        <20220706081036epcms2p6baf1d8afac994cd0d45c5e59029c8ce7@epcms2p6>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A007-07-22,=C2=A001:52,=C2=A0Vinod=20Koul=C2=A0wrote:=0D=0A>=20On=C2=
=A006-07-22,=C2=A017:10,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>>=C2=A0On=
=C2=A005-07-22,=C2=A015:30,=C2=A0Vinod=C2=A0Koul=C2=A0wrote:=0D=0A>>=C2=A0>=
=C2=A0On=C2=A014-06-22,=C2=A010:34,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=
=0A>>=C2=A0>>=C2=A0Add=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0SoC.=0D=
=0A>>=C2=A0>>=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0of=
=C2=A0Axis=C2=A0Communications.=0D=0A>>=C2=A0>>=C2=A0This=C2=A0is=C2=A0base=
d=C2=A0on=C2=A0arm64=C2=A0and=C2=A0support=C2=A0GEN4=C2=A0&=C2=A02lane.=0D=
=0A>>=C2=A0>>=C2=A0This=C2=A0driver=C2=A0provides=C2=A0PHY=C2=A0interface=
=C2=A0for=C2=A0ARTPEC-8=C2=A0SoC=C2=A0PCIe=C2=A0controller,=0D=0A>>=C2=A0>>=
=C2=A0based=C2=A0on=C2=A0Samsung=C2=A0PCIe=C2=A0PHY=C2=A0IP.=0D=0A>>=C2=A0>=
>=C2=A0=0D=0A>>=C2=A0>>=C2=A0Signed-off-by:=C2=A0Wangseok=C2=A0Lee=C2=A0<wa=
ngseok.lee=40samsung.com>=0D=0A>>=C2=A0>>=C2=A0Signed-off-by:=C2=A0Jaeho=C2=
=A0Cho=C2=A0<jaeho79.cho=40samsung.com>=0D=0A>>=C2=A0>>=C2=A0---=0D=0A>>=C2=
=A0>>=C2=A0v2->v3=C2=A0:=0D=0A>>=C2=A0>>=C2=A0-remove=C2=A0unnecessary=C2=
=A0indentation=0D=0A>>=C2=A0>>=C2=A0-redefine=C2=A0local=C2=A0struct=C2=A0t=
o=C2=A0statis=C2=A0const=0D=0A>>=C2=A0>>=C2=A0-add=C2=A0static=C2=A0const=
=C2=A0to=C2=A0struct=C2=A0that=C2=A0requires=C2=A0static=C2=A0const=C2=A0de=
finition=0D=0A>>=C2=A0>>=C2=A0-remove=C2=A0wrappers=C2=A0on=C2=A0writel=C2=
=A0and=C2=A0readl=0D=0A>>=C2=A0>>=C2=A0=0D=0A>>=C2=A0>>=C2=A0v1->v2=C2=A0:=
=0D=0A>>=C2=A0>>=C2=A0-change=C2=A0folder=C2=A0name=C2=A0of=C2=A0phy=C2=A0d=
river=C2=A0to=C2=A0axis=C2=A0from=C2=A0artpec=0D=0A>>=C2=A0>>=C2=A0---=0D=
=0A>>=C2=A0>>=C2=A0=C2=A0drivers/phy/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=
=C2=A0=C2=A0=C2=A01=C2=A0+=0D=0A>>=C2=A0>>=C2=A0=C2=A0drivers/phy/Makefile=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A0=C2=A01=C2=A0+=0D=0A>>=C2=A0>>=C2=A0=C2=
=A0drivers/phy/axis/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A0=C2=A09=C2=A0+=0D=0A>>=C2=A0>>=C2=A0=
=C2=A0drivers/phy/axis/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A0=C2=A02=C2=A0+=0D=0A>>=C2=A0>>=C2=A0=
=C2=A0drivers/phy/axis/phy-artpec8-pcie.c=C2=A0=7C=C2=A0776=C2=A0++++++++++=
++++++++++++++++++++++++++=0D=0A>>=C2=A0>>=C2=A0=C2=A05=C2=A0files=C2=A0cha=
nged,=C2=A0789=C2=A0insertions(+)=0D=0A>>=C2=A0>>=C2=A0=C2=A0create=C2=A0mo=
de=C2=A0100644=C2=A0drivers/phy/axis/Kconfig=0D=0A>>=C2=A0>>=C2=A0=C2=A0cre=
ate=C2=A0mode=C2=A0100644=C2=A0drivers/phy/axis/Makefile=0D=0A>>=C2=A0>>=C2=
=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=A0drivers/phy/axis/phy-artpec8-pci=
e.c=0D=0A>>=C2=A0>>=C2=A0=0D=0A>>=C2=A0>>=C2=A0diff=C2=A0--git=C2=A0a/drive=
rs/phy/Kconfig=C2=A0b/drivers/phy/Kconfig=0D=0A>>=C2=A0>>=C2=A0index=C2=A03=
00b0f2..92b8232=C2=A0100644=0D=0A>>=C2=A0>>=C2=A0---=C2=A0a/drivers/phy/Kco=
nfig=0D=0A>>=C2=A0>>=C2=A0+++=C2=A0b/drivers/phy/Kconfig=0D=0A>>=C2=A0>>=C2=
=A0=40=40=C2=A0-73,6=C2=A0+73,7=C2=A0=40=40=C2=A0config=C2=A0PHY_CAN_TRANSC=
EIVER=0D=0A>>=C2=A0>>=C2=A0=C2=A0=0D=0A>>=C2=A0>>=C2=A0=C2=A0source=C2=A0=
=22drivers/phy/allwinner/Kconfig=22=0D=0A>>=C2=A0>>=C2=A0=C2=A0source=C2=A0=
=22drivers/phy/amlogic/Kconfig=22=0D=0A>>=C2=A0>>=C2=A0+source=C2=A0=22driv=
ers/phy/axis/Kconfig=22=0D=0A>>=C2=A0>>=C2=A0=C2=A0source=C2=A0=22drivers/p=
hy/broadcom/Kconfig=22=0D=0A>>=C2=A0>>=C2=A0=C2=A0source=C2=A0=22drivers/ph=
y/cadence/Kconfig=22=0D=0A>>=C2=A0>>=C2=A0=C2=A0source=C2=A0=22drivers/phy/=
freescale/Kconfig=22=0D=0A>>=C2=A0>>=C2=A0diff=C2=A0--git=C2=A0a/drivers/ph=
y/Makefile=C2=A0b/drivers/phy/Makefile=0D=0A>>=C2=A0>>=C2=A0index=C2=A001e9=
eff..808c055e=C2=A0100644=0D=0A>>=C2=A0>>=C2=A0---=C2=A0a/drivers/phy/Makef=
ile=0D=0A>>=C2=A0>>=C2=A0+++=C2=A0b/drivers/phy/Makefile=0D=0A>>=C2=A0>>=C2=
=A0=40=40=C2=A0-12,6=C2=A0+12,7=C2=A0=40=40=C2=A0obj-=24(CONFIG_PHY_PISTACH=
IO_USB)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=A0phy-pistachio-usb.o=0D=0A>>=C2=A0>>=
=C2=A0=C2=A0obj-=24(CONFIG_USB_LGM_PHY)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=A0phy-l=
gm-usb.o=0D=0A>>=C2=A0>>=C2=A0=C2=A0obj-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=A0allwinne=
r/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=5C=0D=0A>>=C2=A0>>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0amlogic/=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=5C=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0axis/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=5C=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0broadcom/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=5C=0D=0A>>=C2=A0>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cad=
ence/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=5C=0D=0A>>=C2=A0>>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0freescale/=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=5C=0D=0A>>=C2=A0>>=C2=A0diff=C2=A0--git=C2=A0a/=
drivers/phy/axis/Kconfig=C2=A0b/drivers/phy/axis/Kconfig=0D=0A>>=C2=A0>>=C2=
=A0new=C2=A0file=C2=A0mode=C2=A0100644=0D=0A>>=C2=A0>>=C2=A0index=C2=A00000=
000..7198b93=0D=0A>>=C2=A0>>=C2=A0---=C2=A0/dev/null=0D=0A>>=C2=A0>>=C2=A0+=
++=C2=A0b/drivers/phy/axis/Kconfig=0D=0A>>=C2=A0>>=C2=A0=40=40=C2=A0-0,0=C2=
=A0+1,9=C2=A0=40=40=0D=0A>>=C2=A0>>=C2=A0+config=C2=A0PHY_ARTPEC8_PCIE=0D=
=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=
=A0=22ARTPEC-8=C2=A0PCIe=C2=A0PHY=C2=A0driver=22=0D=0A>>=C2=A0>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends=C2=A0on=C2=A0OF=C2=A0&=
&=C2=A0(ARCH_ARTPEC8=C2=A0=7C=7C=C2=A0COMPILE_TEST)=0D=0A>>=C2=A0>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select=C2=A0GENERIC_PHY=0D=
=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help=0D=
=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0Enable=C2=A0PCIe=C2=A0PHY=C2=A0support=C2=A0for=C2=A0ARTPEC-8=C2=A0So=
C.=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0This=C2=A0driver=C2=A0provides=C2=A0PHY=C2=A0interface=C2=A0for=
=C2=A0ARTPEC-8=C2=A0SoC=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCIe=C2=A0controller.=0D=0A>>=C2=A0>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This=C2=A0i=
s=C2=A0based=C2=A0on=C2=A0Samsung=C2=A0PCIe=C2=A0PHY=C2=A0IP.=0D=0A>>=C2=A0=
>=C2=A0=0D=0A>>=C2=A0>=C2=A0How=C2=A0different=C2=A0is=C2=A0it=C2=A0from=C2=
=A0SS=C2=A0IP=C2=A0and=C2=A0why=C2=A0should=C2=A0it=C2=A0not=C2=A0be=C2=A0u=
nder=0D=0A>>=C2=A0>=C2=A0phy/samsung/=C2=A0then?=0D=0A>>=C2=A0>=C2=A0=0D=0A=
>>=C2=A0=0D=0A>>=C2=A0SoC=C2=A0platform=C2=A0is=C2=A0completely=C2=A0differ=
ent=C2=A0from=C2=A0exynos=C2=A0platform=C2=A0and=C2=A0different=C2=A0=0D=0A=
>>=C2=A0from=C2=A0exynos=C2=A0PCIe=C2=A0PHY.=C2=A0So=C2=A0the=C2=A0overall=
=C2=A0sysreg=C2=A0configuration=C2=A0is=C2=A0different=0D=0A>>=C2=A0and=C2=
=A0register=C2=A0map=C2=A0is=C2=A0also=C2=A0different.=C2=A0The=C2=A0reset=
=C2=A0method=C2=A0and=C2=A0type=C2=A0of=C2=A0PHY=C2=A0for=0D=0A>>=C2=A0init=
ialization=C2=A0are=C2=A0different.=C2=A0This=C2=A0is=C2=A0not=C2=A0a=C2=A0=
driver=C2=A0that=C2=A0supports=C2=A0Samsung=0D=0A>>=C2=A0SoC=C2=A0platform,=
=C2=A0but=C2=A0this=C2=A0PHY=C2=A0driver=C2=A0that=C2=A0supports=C2=A0only=
=C2=A0Axis,=C2=A0Artpec-8=0D=0A>>=C2=A0platforms,=C2=A0so=C2=A0it=C2=A0is=
=C2=A0not=C2=A0added=C2=A0to=C2=A0phy/samsung.=0D=0A>=20=0D=0A>=20SoC=C2=A0=
is=C2=A0a=C2=A0moot=C2=A0point.=C2=A0If=C2=A0the=C2=A0IP=C2=A0block=C2=A0is=
=C2=A0same=C2=A0then=C2=A0we=C2=A0should=C2=A0try=C2=A0to=C2=A0reuse=0D=0A>=
=20the=C2=A0existing=C2=A0phy=C2=A0driver,=C2=A0modifications=C2=A0to=C2=A0=
current=C2=A0driver=C2=A0to=C2=A0support=C2=A0your=0D=0A>=20changes=C2=A0sh=
ould=C2=A0be=C2=A0fine...=0D=0A>=20=0D=0A>=20Is=C2=A0that=C2=A0feasible?=0D=
=0A>=20=0D=0A>=20--=C2=A0=0D=0A>=20=7EVinod=0D=0A=0D=0ASorry=20for=20late=
=20reply.=0D=0A=0D=0AAbove=20all,=20the=20IP=20blocks=20of=20phy-exynos-pci=
e.c=20and=20artpec8's=20pcie=20phy=20are=0D=0Adifferent.=20As=20a=20result,=
=20the=20H/W=20architecture=20and=20operation=20sequence=20is=0D=0Avery=20d=
ifferent.=20So=20it=20is=20very=20difficult=20to=20merge=20into=20a=20exyno=
s=20pcie=20file.=0D=0AIf=20possible,=20we=20would=20like=20to=20proceed=20w=
ith=20a=20new=20file.=20Is=20that=20possible?=0D=0A=0D=0ABest=20regards,=0D=
=0AWangseok=20Lee
