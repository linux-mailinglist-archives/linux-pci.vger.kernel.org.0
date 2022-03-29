Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E414EA7CE
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 08:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiC2GYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 02:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiC2GYT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 02:24:19 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9743B248796
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 23:22:33 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220329062227epoutp01d55632e1b13d56289dd73d216d6a1a59~gxczuOyQs1937719377epoutp01O
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 06:22:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220329062227epoutp01d55632e1b13d56289dd73d216d6a1a59~gxczuOyQs1937719377epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648534947;
        bh=N51PSQTtmOXZTnikqsTn+4JvQLS/DokmO4Rw6FKKyok=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Zm+j0moQXMFHEM9s3rgQzuSVNMrePZu3S+KbcNC3NV9ZoEoi2z82im0RZ6eNcfwiS
         28RTCfV3jXnqUUqzK5DBRFB8Rim9XAxLSbkApSYO0BPInI62UVhs1ltcLaKszhGiG7
         Ezin9uemqyIwQ+6KDo/5PF/oD0zGhhgg6cszB1so=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220329062226epcas2p42c9e83f9fefb9ef9276a3575005cdfc2~gxcy7dADK1074710747epcas2p4N;
        Tue, 29 Mar 2022 06:22:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KSKH411lvz4x9Q1; Tue, 29 Mar
        2022 06:22:24 +0000 (GMT)
X-AuditID: b6c32a45-4fdff700000228cc-17-6242a59cdbf1
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.48.10444.C95A2426; Tue, 29 Mar 2022 15:22:20 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 4/5] phy: Add ARTPEC-8 PCIe PHY driver
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <da2351be-1fca-4269-cb7b-9dcd6a01b2dc@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220329062220epcms2p2e66ed043478fd6c40906863cead7e8de@epcms2p2>
Date:   Tue, 29 Mar 2022 15:22:20 +0900
X-CMS-MailID: 20220329062220epcms2p2e66ed043478fd6c40906863cead7e8de
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmhe6cpU5JBtP36lgsacqweHlI02L+
        kXOsFs8PzWK2+NSianHhaQ+bxctZ99gszp/fwG7R0POb1eLIm4/MFvuPr2SyuLxrDpvF2XnH
        2SwmrPrGYvHm9wt2i3OLMy1a9x5ht9h55wSzg5DHmnlrGD2urwvwWLCp1GPTqk42jydXpjN5
        bF5S79G3ZRWjx/Eb25k8Pm+SC+CMyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCd0fnhO3vBAd6Knp6ZzA2MXbxdjJwcEgImEteftrJ1MXJx
        CAnsYJTYuXsvkMPBwSsgKPF3hzBIjbCAlcS+xknMILaQgJLEjjXzmCHi1hKfplxmAbHZBCwl
        LrY+ZASZIyLwjUli9o9XYEOZBW4zS8x//p4FYhuvxIz2p1C2tMT25VsZQWxOATuJd0vnMEPE
        NSR+LOuFskUlbq5+yw5jvz82nxHCFpFovXcWqkZQ4sHP3VBxKYkFTw6xQtjVEvv//maCsBsY
        Jfrvp4I8JiGgL7HjujHEj74SX1tqQCpYBFQl7va8hep0kbh87xDYRGYBbYllC18zg5QzC2hK
        rN+lDzFEWeLILbifGjb+ZkdnMwvwSXQc/gsX3zHvCdQtahLzVu5knsCoPAsRzrOQ7JqFsGsB
        I/MqRrHUguLc9NRiowJDeNQm5+duYgSnaS3XHYyT337QO8TIxMF4iFGCg1lJhFf2rH2SEG9K
        YmVValF+fFFpTmrxIUZToC8nMkuJJucDM0VeSbyhiaWBiZmZobmRqYG5kjivV8qGRCGB9MSS
        1OzU1ILUIpg+Jg5OqQamuZV1MxT3WKRyfJi6OPiK5SHpfsnJHz7eW7k1tODkgbedG521ZFY/
        O8B0fNrbGeE5TCFpphPb5lq0L9bNshRWyw/cvjzkyYpps8s/dH8VS9Yv/eFaceQG4yqNO3Pn
        d90P3/O+Jfi845+7m/bMEX2ScvG0x7v2bU8+3Y49nyTHJtCfb2fEI1Pz0oJ1xR2TNgmXOTl3
        zy0TlEtcnnrc7vLk3Qcs1tYKbCtIScm/Elb989xaJU3D4+ruaU8XdNvs4GhlttHiO1bF3hDz
        NmtCu8/9inzX7/M9627pKCu57ZWX5HeWX9FQfevW3pzmrNvKq+Ye83/lX7r5zqvKC2XGFrkP
        ai5O/nghWjHqc8FcxdO3lFiKMxINtZiLihMBF+7RclwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4
References: <da2351be-1fca-4269-cb7b-9dcd6a01b2dc@kernel.org>
        <20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4@epcms2p6>
        <CGME20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4@epcms2p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> --------- Original Message ---------
> Sender : Krzysztof Kozlowski=C2=A0<krzk=40kernel.org>=0D=0A>=20Date=20:=
=202022-03-28=2022:09=20(GMT+9)=0D=0A>=20Title=20:=20Re:=20=5BPATCH=204/5=
=5D=20phy:=20Add=20ARTPEC-8=20PCIe=20PHY=20driver=0D=0A>=20=C2=A0=0D=0A>=20=
On=C2=A028/03/2022=C2=A004:18,=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=A0wrote:=
=0D=0A>>=C2=A0Add=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0SoC.=0D=0A>>=
=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0of=C2=A0Axis=C2=
=A0Communications.=0D=0A>>=C2=A0This=C2=A0is=C2=A0based=C2=A0on=C2=A0arm64=
=C2=A0and=C2=A0support=C2=A0GEN4=C2=A0&=C2=A02lane.=0D=0A>>=C2=A0This=C2=A0=
driver=C2=A0provides=C2=A0PHY=C2=A0interface=C2=A0for=C2=A0ARTPEC-8=C2=A0So=
C=C2=A0PCIe=C2=A0controller,=0D=0A>>=C2=A0based=C2=A0on=C2=A0Samsung=C2=A0P=
CIe=C2=A0PHY=C2=A0IP.=0D=0A>>=C2=A0=0D=0A>=20=0D=0A>=20You=C2=A0already=C2=
=A0sent=C2=A0it=C2=A0on=C2=A028th=C2=A0of=C2=A0January=C2=A0and=C2=A0did=C2=
=A0not=C2=A0respond=C2=A0to=C2=A0my=C2=A0comments.=0D=0A>=20=0D=0A>=20Pleas=
e=C2=A0do=C2=A0not=C2=A0resend=C2=A0same/similar=C2=A0code,=C2=A0but=C2=A0i=
nstead=C2=A0respond=C2=A0to=C2=A0comments=0D=0A>=20received=C2=A0earlier.=
=0D=0A>=20=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Krzysztof=0D=0AHello,=20Krz=
ysztof=0D=0A=0D=0AYes,=20you=20are=20right.=0D=0AI=20have=20sent=20a=20patc=
h=20set=20this=20time,=20=0D=0Aincluding=20parts=20that=20need=20to=20be=20=
modified=20in=20the=20previously=20sent=20patch.=0D=0APlease=20ignore=20pre=
viously=20sent=20patch=20and=20refer=20to=20the=20new=20patch=20set.=0D=0AI=
=20also=20replied=20to=20the=20previous=20e-mail,=0D=0Abut=20the=20email=20=
address=20was=20wrong=20and=20returned.=0D=0A=0D=0AThanks.
