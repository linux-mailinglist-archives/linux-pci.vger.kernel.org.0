Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C65554447
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351983AbiFVHGk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 03:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351980AbiFVHGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 03:06:38 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA7536B5B
        for <linux-pci@vger.kernel.org>; Wed, 22 Jun 2022 00:06:32 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220622070628epoutp0362685c15db869a2abac73dda9920d514~634f0e2A-2263322633epoutp03R
        for <linux-pci@vger.kernel.org>; Wed, 22 Jun 2022 07:06:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220622070628epoutp0362685c15db869a2abac73dda9920d514~634f0e2A-2263322633epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655881588;
        bh=zeSvkutVhCwLhqpuMOBEA1bNHvXYgLmki1LCYFH8ryI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Fgwfqmq9SouqvbWl/e8zTMMr8zQt8l0z+Q7giXpIWZfitgcPAzp5uMgQYcwkIgMii
         MRegCbYegGNoSzUSUNUfCGPr8tyvAijViyoPcgx5em5peD3vHFDH7j+LA2huCDo04x
         nUrj9F9WPVReRNUeA40GPz9IesF6/FBgOPyz8tDo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220622070626epcas2p24cd717a2358840c3a44b92cb6bcacdd1~634d8kFfJ3086230862epcas2p2n;
        Wed, 22 Jun 2022 07:06:26 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LSZDd4V6fz4x9QJ; Wed, 22 Jun
        2022 07:06:25 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-8a-62b2bf71c064
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.DD.09650.17FB2B26; Wed, 22 Jun 2022 16:06:25 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v3 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
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
In-Reply-To: <20220621211354.GA1332400@bhelgaas>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220622070625epcms2p27b8af447c871dba8219b5dd16c2860c7@epcms2p2>
Date:   Wed, 22 Jun 2022 16:06:25 +0900
X-CMS-MailID: 20220622070625epcms2p27b8af447c871dba8219b5dd16c2860c7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmqW7h/k1JBv9uKFosacqweHlI02L+
        kXOsFrtnLGeyeHVmLZvFzKlnmC2eH5rFbPGpRdXiwtMeNouXs+6xWZw/v4HdoqHnN6vFkTcf
        mS32H1/JZHF51xw2i7PzjrNZTFj1jcXize8X7BbnFmdatO49wm6x884JZotfW/8wOYh5rJm3
        htHj+roAjwWbSj02repk83hyZTqTx+Yl9R59W1Yxehy/sZ3J4/MmuQDOqGybjNTElNQihdS8
        5PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKD3lBTKEnNKgUIBicXFSvp2
        NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGR2z/zEXLNGt2Lzz
        BnMDY59OFyMnh4SAicTuW9+Yuxi5OIQEdjBKvD3wl7GLkYODV0BQ4u8OYZAaYQFniV3/N7GB
        2EICShI71sxjhojrS1xf0c0KYrMJ6Er8W/ySDaRVREBNoqs9FGQks8AOdom7b78zQuzilZjR
        /pQFwpaW2L58K1icU8BAYs2LI0wQcQ2JH8t6mSFsUYmbq9+yw9jvj82HmiMi0XrvLFSNoMSD
        n7uh4lISC54cYoWwqyX2//0NNbOBUaL/firIbRJAN++4bgwS5hXwlVj/4DsrSJhFQFWi5YM8
        RLWLxO7mbrCJzALaEssWvmYGKWEW0JRYv0sfYoiyxJFbLDA/NWz8zY7OZhbgk+g4/BcuvmPe
        E6hb1CTmrdzJPIFReRYilGch2TULYdcCRuZVjGKpBcW56anFRgVG8IhNzs/dxAhO5VpuOxin
        vP2gd4iRiYPxEKMEB7OSCK8N94YkId6UxMqq1KL8+KLSnNTiQ4ymQE9OZJYSTc4HZpO8knhD
        E0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1MHqxRn/UW1VgslHsRU6vo
        vSlCw6Xl1JU+rba0KvfAzGKVPxzPpusFudm1yf55ePnFi6LtKwy9jxT+mqapG+VgppTOrORt
        tE3+8Wf9w/YmDuf8hdYtm7vR/wgLb5v4jGQTgxv2pgkhcS/PhvZ6y9nssJvw4cZfvkT/3kmd
        mVXf3jh2zWsN3/V+9fpfK75uKjohnLhsX5CEWBz7ahaPv/prDyYzTPiv0c/H06t1XSfw3LYF
        qyvaXfkeszNwfK6TsfOvSE04xCZdmtvauJ+LUfj9pIbnUxbdmHBWPrwn42v75wX6HTMnCwdx
        Liv7lXdTg3tX81eGrd4uPydusp3Uav7660+xrb7r1DxcbpVMZFBiKc5INNRiLipOBADCFcZD
        bgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220621212357epcas2p41ecf1ace5d207b154cc77dac79bc7e53
References: <20220621211354.GA1332400@bhelgaas>
        <CGME20220621212357epcas2p41ecf1ace5d207b154cc77dac79bc7e53@epcms2p2>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A022/06/2022=C2=A006:23,=C2=A0Bjorn=20Helgaas=C2=A0wrote:=0D=0A>=20On=
=C2=A0Mon,=C2=A0Jun=C2=A020,=C2=A02022=C2=A0at=C2=A005:38:21PM=C2=A0+0900,=
=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>>=C2=A0On=C2=A017/06/2022=C2=A007=
:59,=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0wrote:=0D=0A>>=C2=A0>=C2=A0On=C2=A0=
13/06/2022=C2=A018:29,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>>=C2=A0>>=
=C2=A0Add=C2=A0description=C2=A0to=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=C2=
=A0SoC.=0D=0A>>=C2=A0>>=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platfo=
rm=C2=A0of=C2=A0Axis=C2=A0Communications=0D=0A>>=C2=A0>>=C2=A0and=C2=A0PCIe=
=C2=A0phy=C2=A0is=C2=A0designed=C2=A0based=C2=A0on=C2=A0SAMSUNG=C2=A0PHY.=
=0D=0A>>=C2=A0>=C2=A0=0D=0A>>=C2=A0>=C2=A0No=C2=A0improvements=C2=A0here.=
=C2=A0On=C2=A0v2=C2=A0I=C2=A0gave=C2=A0you=C2=A0link=C2=A0pointing=C2=A0to=
=C2=A0specific=0D=0A>>=C2=A0>=C2=A0paragraph=C2=A0of=C2=A0our=C2=A0document=
ation=C2=A0which=C2=A0you=C2=A0need=C2=A0to=C2=A0apply=C2=A0-=C2=A0wrong=C2=
=A0wrapping.=0D=0A>>=C2=A0>=C2=A0Is=C2=A0there=C2=A0something=C2=A0unclear=
=C2=A0here?=0D=0A>>=C2=A0>=C2=A0=0D=0A>>=C2=A0>=C2=A0Please=0D=0A>>=C2=A0>=
=C2=A0do=0D=0A>>=C2=A0>=C2=A0not=0D=0A>>=C2=A0>=C2=A0wrap=0D=0A>>=C2=A0>=C2=
=A0in=0D=0A>>=C2=A0>=C2=A0different=0D=0A>>=C2=A0>=C2=A0style.=0D=0A>>=C2=
=A0=0D=0A>>=C2=A0I=C2=A0think=C2=A0i=C2=A0misunderstood=C2=A0your=C2=A0revi=
ew=C2=A0comment.=0D=0A>=20=0D=0A>=20Krzysztof=C2=A0was=C2=A0pointing=C2=A0o=
ut=C2=A0that=C2=A0your=C2=A0commit=C2=A0log:=0D=0A>=20=0D=0A>=20=C2=A0=C2=
=A0Add=C2=A0description=C2=A0to=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0=
SoC.=0D=0A>=20=C2=A0=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=
=C2=A0of=C2=A0Axis=C2=A0Communications=0D=0A>=20=C2=A0=C2=A0and=C2=A0PCIe=
=C2=A0phy=C2=A0is=C2=A0designed=C2=A0based=C2=A0on=C2=A0SAMSUNG=C2=A0PHY.=
=0D=0A>=20=0D=0A>=20only=C2=A0fills=C2=A0about=C2=A050=C2=A0columns,=C2=A0a=
nd=C2=A0if=C2=A0you=C2=A0run=C2=A0=22git=C2=A0log=22,=C2=A0most=C2=A0commit=
=C2=A0logs=0D=0A>=20fill=C2=A0about=C2=A075=C2=A0columns=C2=A0so=C2=A0that=
=C2=A0when=C2=A0git=C2=A0adds=C2=A04=C2=A0spaces=C2=A0of=C2=A0indentation,=
=C2=A0they=0D=0A>=20fit=C2=A0nicely=C2=A0in=C2=A0an=C2=A080-column=C2=A0ter=
minal=C2=A0and=C2=A0take=C2=A0advantage=C2=A0of=C2=A0the=C2=A0whole=C2=A0wi=
dth.=0D=0A>=20=0D=0A>=20It's=C2=A0easier=C2=A0to=C2=A0read=C2=A0when=C2=A0a=
ll=C2=A0the=C2=A0commit=C2=A0logs=C2=A0are=C2=A0roughly=C2=A0the=C2=A0same=
=0D=0A>=20width.=C2=A0=C2=A0So=C2=A0please=C2=A0wrap=C2=A0yours=C2=A0to=C2=
=A0something=C2=A0like=C2=A0this:=0D=0A>=20=0D=0A>=20=C2=A0=C2=A0Add=C2=A0d=
escription=C2=A0to=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0SoC.=C2=A0=C2=
=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=0D=0A>=20=C2=A0=C2=A0platform=C2=A0of=
=C2=A0Axis=C2=A0Communications=C2=A0and=C2=A0PCIe=C2=A0PHY=C2=A0is=C2=A0des=
igned=C2=A0based=C2=A0on=C2=A0Samsung=0D=0A>=20=C2=A0=C2=A0PHY.=0D=0A>=20=
=0D=0A>=20The=C2=A0PCI=C2=A0driver=C2=A0the=C2=A0commit=C2=A0log=C2=A0is:=
=0D=0A>=20=0D=0A>=20=C2=A0=C2=A0Add=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=
=C2=A0SoC.=0D=0A>=20=C2=A0=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0pla=
tform=C2=A0of=C2=A0Axis=C2=A0Communications.=0D=0A>=20=0D=0A>=20=C2=A0=C2=
=A0This=C2=A0is=C2=A0based=C2=A0on=C2=A0arm64=C2=A0and=C2=A0support=C2=A0GE=
N4=C2=A0&=C2=A02lane.=0D=0A>=20=C2=A0=C2=A0This=C2=A0PCIe=C2=A0controller=
=C2=A0is=C2=A0based=C2=A0on=C2=A0DesignWare=C2=A0Hardware=C2=A0core=C2=A0an=
d=C2=A0uses=C2=A0DesignWa=0D=0A>=20=C2=A0=C2=A0re=C2=A0core=C2=A0functions=
=C2=A0to=C2=A0implement=C2=A0the=C2=A0driver.=0D=0A>=20=0D=0A>=20=C2=A0=C2=
=A0=22pcie-artpec6.=C2=A0c=22=C2=A0supports=C2=A0artpec6=C2=A0and=C2=A0artp=
ec7=C2=A0H/W.=0D=0A>=20=C2=A0=C2=A0artpec8=C2=A0can=C2=A0not=C2=A0be=C2=A0e=
xpanded=C2=A0because=C2=A0H/W=C2=A0configuration=C2=A0is=C2=A0completely=C2=
=A0differe=0D=0A>=20=C2=A0=C2=A0nt=C2=A0from=C2=A0artpec6/7.=0D=0A>=20=C2=
=A0=C2=A0phy=C2=A0and=C2=A0sub=C2=A0controller=C2=A0are=C2=A0different.=0D=
=0A>=20=0D=0A>=20This=C2=A0should=C2=A0be=C2=A0similarly=C2=A0rewrapped=C2=
=A0to=C2=A0fill=C2=A075=C2=A0columns.=C2=A0=C2=A0The=C2=A0short=C2=A0lines=
=C2=A0are=0D=0A>=20a=C2=A0signal=C2=A0to=C2=A0the=C2=A0reader=C2=A0that=C2=
=A0=22this=C2=A0is=C2=A0the=C2=A0last=C2=A0line=C2=A0of=C2=A0a=C2=A0paragra=
ph,=C2=A0so=0D=0A>=20expect=C2=A0a=C2=A0new=C2=A0paragraph=C2=A0to=C2=A0fol=
low.=22=0D=0A>=20=0D=0A>=20But=C2=A0in=C2=A0commit=C2=A0logs,=C2=A0paragrap=
hs=C2=A0are=C2=A0typically=C2=A0separated=C2=A0by=C2=A0blank=C2=A0lines,=C2=
=A0so=C2=A0a=0D=0A>=20short=C2=A0line=C2=A0followed=C2=A0not=C2=A0by=C2=A0a=
=C2=A0blank=C2=A0line=C2=A0but=C2=A0by=C2=A0text=C2=A0that=C2=A0*could*=C2=
=A0fit=C2=A0on=C2=A0the=0D=0A>=20previous=C2=A0short=C2=A0line=C2=A0is=C2=
=A0a=C2=A0confusing=C2=A0signal.=0D=0A>=20=0D=0A>=20This=C2=A0similar=C2=A0=
to=C2=A0the=C2=A0Wikipedia=C2=A0style:=0D=0A>=20https://en.wikipedia.org/wi=
ki/Wikipedia:Manual_of_Style/Layout=23Paragraphs=0D=0A>=20=0D=0A>=20The=C2=
=A0PCI=C2=A0driver=C2=A0commit=C2=A0log=C2=A0should=C2=A0also=C2=A0join=C2=
=A0=22DesignWare=22=C2=A0and=C2=A0=22different=22,=0D=0A>=20which=C2=A0are=
=C2=A0currently=C2=A0split=C2=A0across=C2=A0lines.=0D=0A>=20=0D=0A>>=C2=A0I=
=C2=A0will=C2=A0modify=C2=A0it=C2=A0as=C2=A0below.=0D=0A>>=C2=A0s/SAMSUNG=
=C2=A0PHY/Samsung=C2=A0phy=0D=0A>=20=0D=0A>=20=22PHY=22=C2=A0is=C2=A0typica=
lly=C2=A0all=C2=A0caps=C2=A0in=C2=A0English=C2=A0text,=C2=A0e.g.,=C2=A0see=
=C2=A0examples=C2=A0here:=0D=0A>=20https://en.wikipedia.org/wiki/Physical_l=
ayer=23PHY=0D=0A>=20=0D=0A>=20Bjorn=0D=0A=0D=0AThank=20you=20very=20much=20=
for=20your=20detailed=20review.=0D=0AI=20will=20fix=20the=20commit=20msgs=
=20as=20your=20description.=0D=0A=0D=0ABest=20regards,=0D=0AWangseok=20Lee
