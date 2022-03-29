Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF4A4EA70D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 07:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiC2FWp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 01:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiC2FWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 01:22:44 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A3519A55A
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 22:21:00 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220329052055epoutp03bf16bf87a778c28c3c90467773630a6e~gwnE4qY9h0708607086epoutp03H
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 05:20:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220329052055epoutp03bf16bf87a778c28c3c90467773630a6e~gwnE4qY9h0708607086epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648531255;
        bh=9fjLCEadA6/+3pmT0Zg5DOylhoulxyWmmYdU3kRn7Ro=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Ip+GEYkxSTJAv9tGFkLNfPIxeYoDWb16YaStL1nATztdFijGEUQKX+qv1+Bt69yU1
         6FZIu/vivNPK+pVx88yoeShB9eEQQyq1W+hgvNPboVmwht9S3UOLHum+EXcLsvQA8u
         vrmCctA4WisrLuxiNklk30J7K+ykCqRbl6ncw3I8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220329052054epcas2p1e9ac022b162b5dbca77c441e89f1efa8~gwnEKwr1a0181101811epcas2p1B;
        Tue, 29 Mar 2022 05:20:54 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KSHw50J8sz4x9QT; Tue, 29 Mar
        2022 05:20:53 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-99-6242973273f9
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.2B.16040.23792426; Tue, 29 Mar 2022 14:20:50 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
To:     Rob Herring <robh@kernel.org>
CC:     "kernel@axis.com" <kernel@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1648471865.787623.2153571.nullmailer@robh.at.kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220329052049epcms2p623bd47de38aba8a43689e515bc712ede@epcms2p6>
Date:   Tue, 29 Mar 2022 14:20:49 +0900
X-CMS-MailID: 20220329052049epcms2p623bd47de38aba8a43689e515bc712ede
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmha7RdKckg1k3uS2WNGVYvDykaTH/
        yDlWi+eHZjFbfGpRtbjwtIfN4uWse2wWDT2/WS2OvPnIbLH/+Eomi8u75rBZnJ13nM1iwqpv
        LBZvfr9gtzi3ONOide8Rdov/e3awW+y8c4LZQchjzbw1jB7X1wV4LNhU6rFpVSebx5Mr05k8
        Ni+p9+jbsorR4/iN7UwenzfJBXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAL2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9Ar
        TswtLs1L18tLLbEyNDAwMgUqTMjOmLDiJHNBv2TF4ok72BsYN0t0MXJySAiYSDz4cJypi5GL
        Q0hgB6PEyivX2boYOTh4BQQl/u4QBqkRFnCQ2LPiMxuILSSgJLFjzTxmiLi1xKcpl1lAbDYB
        S4mLrQ8ZQWwRAUWJ323TWEFsZoEVbBJrmrIgdvFKzGh/ygJhS0tsX74VrJ5TwE3ib/8xVoi4
        hsSPZb3MELaoxM3Vb9lh7PfH5jNC2CISrffOQtUISjz4uRsqLiWx4MkhqDnVEvv//maCsBsY
        Jfrvp4K8JSGgL7HjujFImFfAV+Lzs8tgY1gEVCUmtZ+FOs1F4uLhFmaI87Ulli18zQzSyiyg
        KbF+lz7EFGWJI7dYYJ5q2PibHZ3NLMAn0XH4L1x8x7wnUMeoScxbuZN5AqPyLEQwz0KyaxbC
        rgWMzKsYxVILinPTU4uNCozgMZucn7uJEZyktdx2ME55+0HvECMTB+MhRgkOZiURXtmz9klC
        vCmJlVWpRfnxRaU5qcWHGE2BvpzILCWanA/ME3kl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTS
        E0tSs1NTC1KLYPqYODilGpjaDyW0NH1V+nP5tWxoXFjeneJ6zYfRnjsVFnifU7d2PCy09vO6
        mZ9Sl0XJm288v6benOnGmj1JZo53513s/ONnFHHxT5jpirS7O4RuP2g52/lRTle1fZP7U9nW
        ro7ZvHMy/PRs3tVMSXfnfOrD8IDLdMl84Z+Lkn05Xmxq4Uo1uXsqs3PHyist/ZI8ilv5TfX3
        hur9nbU1aF5Wjl/NpOOBYQ+bFPUsFlkG6/QpLDqfce8Pe47UW+MJZ+2fHX+T+kf6bLq46rKt
        4UYv+524/l48JxQn571HjsP4s5DdetNbZ4KnfZLNX6+a/3yuWujC3yYaBep8pb/m5SVdbNmm
        z9bUKem/jv2sm32udHDqRyWW4oxEQy3mouJEANffGbJbBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603
References: <1648471865.787623.2153571.nullmailer@robh.at.kernel.org>
        <20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p3>
        <CGME20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> --------- Original Message ---------
> Sender : Rob Herring=C2=A0<robh=40kernel.org>=0D=0A>=20Date=20:=202022-03=
-28=2021:51=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=202/5=5D=20dt-bin=
dings:=20phy:=20Add=20ARTPEC-8=20PCIe=20phy=0D=0A>=20=0D=0A>=20On=C2=A0Mon,=
=C2=A028=C2=A0Mar=C2=A02022=C2=A017:43:19=C2=A0+0900,=C2=A0=EF=BF=BD=EB=8C=
=81=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=C2=A0wrote:=0D=0A>>=C2=A0Add=C2=A0d=
escription=C2=A0to=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0SoC.=0D=0A>>=
=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0of=C2=A0Axis=C2=
=A0Communications=0D=0A>>=C2=A0and=C2=A0PCIe=C2=A0phy=C2=A0is=C2=A0designed=
=C2=A0based=C2=A0on=C2=A0SAMSUNG=C2=A0PHY.=0D=0A>>=C2=A0=0D=0A>>=C2=A0Signe=
d-off-by:=C2=A0Wangseok=C2=A0Lee=C2=A0<wangseok.lee=40samsung.com>=0D=0A>>=
=C2=A0---=0D=0A>>=C2=A0=C2=A0.../bindings/phy/axis,artpec8-pcie-phy.yaml=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A067=C2=A0+++++++++++++=
+++++++++=0D=0A>>=C2=A0=C2=A01=C2=A0file=C2=A0changed,=C2=A067=C2=A0inserti=
ons(+)=0D=0A>>=C2=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=A0Documentation/d=
evicetree/bindings/phy/axis,artpec8-pcie-phy.yaml=0D=0A>>=C2=A0=0D=0A>=20=
=0D=0A>=20My=C2=A0bot=C2=A0found=C2=A0errors=C2=A0running=C2=A0'make=C2=A0D=
T_CHECKER_FLAGS=3D-m=C2=A0dt_binding_check'=0D=0A>=20on=C2=A0your=C2=A0patc=
h=C2=A0(DT_CHECKER_FLAGS=C2=A0is=C2=A0new=C2=A0in=C2=A0v5.13):=0D=0A>=20=0D=
=0A>=20yamllint=C2=A0warnings/errors:=0D=0A>=20=0D=0A>=20dtschema/dtc=C2=A0=
warnings/errors:=0D=0A>=20Documentation/devicetree/bindings/phy/axis,artpec=
8-pcie-phy.example.dt.yaml:0:0:=C2=A0/example-0/artec8/pcie-phy=4016c80000:=
=C2=A0failed=C2=A0to=C2=A0match=C2=A0any=C2=A0schema=C2=A0with=C2=A0compati=
ble:=C2=A0=5B'samsung,artpec8-pcie-phy'=5D=0D=0A>=20=0D=0A>=20doc=C2=A0refe=
rence=C2=A0errors=C2=A0(make=C2=A0refcheckdocs):=0D=0A>=20=0D=0A>=20See=C2=
=A0https://protect2.fireeye.com/v1/url?k=3D0fdd5edc-6f3fc381-0fdcd593-000ba=
bd9f1ba-cd731013fdd72389&q=3D1&e=3Ddf20f229-606a-4e6a-bcb2-2cbdc399248e&u=
=3Dhttps%3A%2F%2Fpatchwork.ozlabs.org%2Fpatch%2F1610068=0D=0A>=20=0D=0A>=20=
This=C2=A0check=C2=A0can=C2=A0fail=C2=A0if=C2=A0there=C2=A0are=C2=A0any=C2=
=A0dependencies.=C2=A0The=C2=A0base=C2=A0for=C2=A0a=C2=A0patch=0D=0A>=20ser=
ies=C2=A0is=C2=A0generally=C2=A0the=C2=A0most=C2=A0recent=C2=A0rc1.=0D=0A>=
=20=0D=0A>=20If=C2=A0you=C2=A0already=C2=A0ran=C2=A0'make=C2=A0dt_binding_c=
heck'=C2=A0and=C2=A0didn't=C2=A0see=C2=A0the=C2=A0above=0D=0A>=20error(s),=
=C2=A0then=C2=A0make=C2=A0sure=C2=A0'yamllint'=C2=A0is=C2=A0installed=C2=A0=
and=C2=A0dt-schema=C2=A0is=C2=A0up=C2=A0to=0D=0A>=20date:=0D=0A>=20=0D=0A>=
=20pip3=C2=A0install=C2=A0dtschema=C2=A0--upgrade=0D=0A>=20=0D=0A>=20Please=
=C2=A0check=C2=A0and=C2=A0re-submit.=0D=0A=0D=0AHello=20Rob=20Herring=0D=0A=
Thanks=20for=20your=20review.=0D=0A=0D=0AI=20wrote=20the=20wrong=20=22compa=
tible=22=20value.=0D=0Aso=20i=20will=20modify=20this=20part=20and=20summit=
=20it=20again.=0D=0Aalso=20i=20checked=20the=20result=20by=20performing=20=
=0D=0A=22make=20dt_binding_check=20DT_SCHEMA_FILES=3D=0D=0ADocumentation/de=
vicetree/bindings/pci/axis,artpec8-pcie.yaml=22.=0D=0A=0D=0AThanks.
