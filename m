Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8CA5511EF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 09:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiFTHz4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbiFTHzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 03:55:55 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B1E10547
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 00:55:52 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220620075550epoutp014a91cb8a09a030240f0f29c3f837c2ad~6RRCUxjR82911629116epoutp01d
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 07:55:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220620075550epoutp014a91cb8a09a030240f0f29c3f837c2ad~6RRCUxjR82911629116epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655711750;
        bh=H0hpKJAniw4icv3pxgRcY2hKqIRTNCU1Dc70icFRVXo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=uqqlW/m2YSVWM90THc+Rmbm6fKhQ7jkK8LcFuzG6W4GccdTe9CgdAWlHYds+z7Czg
         QANIISeyYoqLBaS6KC5UE0l7k508lkTHO5Hcr7fkwHIJVx1APYVzpEXj2B3u7OMM/6
         fyl0un81iObZZlDLzb785VaavyCKr9A5DJrVZhyQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220620075549epcas2p2173fcc11166b5c01cc3bcb2622495c7d~6RRBo0lri2990529905epcas2p2i;
        Mon, 20 Jun 2022 07:55:49 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LRMQY27Wtz4x9QF; Mon, 20 Jun
        2022 07:55:49 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-45-62b028057f2b
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.60.09642.50820B26; Mon, 20 Jun 2022 16:55:49 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        "kernel@axis.com" <kernel@axis.com>
CC:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <8d806fc9-0067-2c8d-ec41-13787c7644a2@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220620075548epcms2p61182d9d7f41fadb1eb139b349bf7486d@epcms2p6>
Date:   Mon, 20 Jun 2022 16:55:48 +0900
X-CMS-MailID: 20220620075548epcms2p61182d9d7f41fadb1eb139b349bf7486d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmhS6rxoYkg7U3uC2WNGVYvDykaTH/
        yDlWi90zljNZzJx6htni+aFZzBafWlQtLjztYbN4Oesem8Xe11vZLRp6frNaHHnzkdli//GV
        TBaXd81hszg77zibxYRV31gs3vx+wW5xbnGmReveI+wWO++cYLb4tfUPk4Oox5p5axg9rq8L
        8FiwqdRj06pONo871/aweTy5Mp3JY/OSeo++LasYPY7f2M7k8XmTXABXVLZNRmpiSmqRQmpe
        cn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtB7SgpliTmlQKGAxOJiJX07
        m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjE/3bjEXPOxjrFj+
        4AhjA2N7N2MXIyeHhICJxKY7/1lBbCGBHYwSC5dVdTFycPAKCEr83SEMEhYW8JJYu+4VC0SJ
        ksSONfOYIeL6EtdXdIO1sgnoSvxb/JKti5GLQ0RgNZvErJ0vmEAcZoEFjBL7f++DWsYrMaP9
        KQuELS2xfflWsDingJ3E2skrmSHiGhI/lvVC2aISN1e/ZYex3x+bDzVHRKL13lmoGkGJBz93
        Q8WlJBY8OcQKYVdL7P/7mwnCbmCU6L+fCvKYBNDVO64bg4R5BXwlml68ADuHRUBVYu3y01Cn
        uUisud0ItpZZQFti2cLXzCCtzAKaEut36UNMUZY4cosF5qmGjb/Z0dnMAnwSHYf/wsV3zHsC
        dYyaxLyVO5knMCrPQgT0LCS7ZiHsWsDIvIpRLLWgODc9tdiowBgeucn5uZsYwSldy30H44y3
        H/QOMTJxMB5ilOBgVhLhteHekCTEm5JYWZValB9fVJqTWnyI0RToy4nMUqLJ+cCsklcSb2hi
        aWBiZmZobmRqYK4kzuuVsiFRSCA9sSQ1OzW1ILUIpo+Jg1OqgUndum2dtk+l8cFtQYfZrims
        m8/H+DzAJk0n2Lnj2/RJ/omxvJpdyw1sjqQodKdJK//lv7zsVOms1Ro7TgjqsGhObP859xzL
        2b8TVmroenowbDikXOv7aHrNgpscdncLucR5bZQeyvvunZBxWbpop0jCzUvNvfNa/wrfs+Q5
        W5bps/g6z4fL981VD1z9t2u68pnZsw818yUdPhxyf8H/S72O1Q8eX3jMrcWU2e51dbGaq5vB
        prOWV+r2/JR9nvT8RvYN6YUti7fFZlb+2blN4nLYoqlqF1MjHue2/ag87rp60jPhdJcHHD9O
        fp+5tle91FuoQs5it1juIRYHAbsPm6+cclDlf/Zd4+D19MUd/2crsRRnJBpqMRcVJwIAdtQv
        X3IEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <8d806fc9-0067-2c8d-ec41-13787c7644a2@linaro.org>
        <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <20220614012713epcms2p810386a5137fbcf6aefc41fe086badc0b@epcms2p8>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p6>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A017/06/2022=C2=A007:54,=C2=A0Krzysztof=20Kozlowski=20wrote:=0D=0A>=
=20On=C2=A013/06/2022=C2=A018:27,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>=
>=C2=A0Add=C2=A0description=C2=A0to=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=
=C2=A0SoC.=0D=0A>>=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=
=A0of=C2=A0Axis=C2=A0Communications=0D=0A>>=C2=A0and=C2=A0PCIe=C2=A0control=
ler=C2=A0is=C2=A0designed=C2=A0based=C2=A0on=C2=A0Design-Ware=C2=A0PCIe=C2=
=A0controller.=0D=0A>>=C2=A0=0D=0A>>=C2=A0Signed-off-by:=C2=A0Wangseok=C2=
=A0Lee=C2=A0<wangseok.lee=40samsung.com>=0D=0A>>=C2=A0---=0D=0A>>=C2=A0v2->=
v3=C2=A0:=0D=0A>>=C2=A0-=C2=A0modify=C2=A0version=C2=A0history=C2=A0to=C2=
=A0fit=C2=A0the=C2=A0linux=C2=A0commit=C2=A0rule=0D=0A>>=C2=A0-=C2=A0remove=
=C2=A0'Device=C2=A0Tree=C2=A0Bindings'=C2=A0on=C2=A0title=0D=0A>>=C2=A0-=C2=
=A0remove=C2=A0the=C2=A0interrupt-names,=C2=A0phy-names=C2=A0entries=0D=0A>=
>=C2=A0-=C2=A0remove=C2=A0'_clk'=C2=A0suffix=0D=0A>>=C2=A0-=C2=A0add=C2=A0t=
he=C2=A0compatible=C2=A0entries=C2=A0on=C2=A0required=0D=0A>>=C2=A0-=C2=A0c=
hange=C2=A0node=C2=A0name=C2=A0to=C2=A0soc=C2=A0from=C2=A0artpec8=C2=A0on=
=C2=A0examples=0D=0A>>=C2=A0=0D=0A>>=C2=A0v1->v2=C2=A0:=0D=0A>>=C2=A0-'make=
=C2=A0dt_binding_check'=C2=A0result=C2=A0improvement=0D=0A>>=C2=A0-Add=C2=
=A0the=C2=A0missing=C2=A0property=C2=A0list=0D=0A>>=C2=A0-Align=C2=A0the=C2=
=A0indentation=C2=A0of=C2=A0continued=C2=A0lines/entries=0D=0A>>=C2=A0---=
=0D=0A>>=C2=A0=C2=A0.../bindings/pci/axis,artpec8-pcie-ep.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0109=C2=A0+++++++++++++++=
++++=0D=0A>>=C2=A0=C2=A0.../devicetree/bindings/pci/axis,artpec8-pcie.yaml=
=C2=A0=7C=C2=A0120=C2=A0+++++++++++++++++++++=0D=0A>>=C2=A0=C2=A02=C2=A0fil=
es=C2=A0changed,=C2=A0229=C2=A0insertions(+)=0D=0A>>=C2=A0=C2=A0create=C2=
=A0mode=C2=A0100644=C2=A0Documentation/devicetree/bindings/pci/axis,artpec8=
-pcie-ep.yaml=0D=0A>>=C2=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=A0Document=
ation/devicetree/bindings/pci/axis,artpec8-pcie.yaml=0D=0A>>=C2=A0=0D=0A>>=
=C2=A0diff=C2=A0--git=C2=A0a/Documentation/devicetree/bindings/pci/axis,art=
pec8-pcie-ep.yaml=C2=A0b/Documentation/devicetree/bindings/pci/axis,artpec8=
-pcie-ep.yaml=0D=0A>>=C2=A0new=C2=A0file=C2=A0mode=C2=A0100644=0D=0A>>=C2=
=A0index=C2=A00000000..d802bba=0D=0A>>=C2=A0---=C2=A0/dev/null=0D=0A>>=C2=
=A0+++=C2=A0b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.ya=
ml=0D=0A>>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,109=C2=A0=40=40=0D=0A>>=C2=A0+=23=
=C2=A0SPDX-License-Identifier:=C2=A0(GPL-2.0-only=C2=A0OR=C2=A0BSD-2-Clause=
)=0D=0A>>=C2=A0+%YAML=C2=A01.2=0D=0A>>=C2=A0+---=0D=0A>>=C2=A0+=24id:=C2=A0=
https://protect2.fireeye.com/v1/url?k=3D87636683-e61e8c00-8762edcc-74fe4860=
0158-e7a1c3794076f0b9&q=3D1&e=3D35e09b7f-4fb1-4c8f-83ac-7ec33e124d44&u=3Dht=
tp%3A%2F%2Fdevicetree.org%2Fschemas%2Fpci%2Faxis%2Cartpec8-pcie-ep.yaml%23=
=0D=0A>>=C2=A0+=24schema:=C2=A0https://protect2.fireeye.com/v1/url?k=3D36f5=
6c4e-578886cd-36f4e701-74fe48600158-afd7270f84937054&q=3D1&e=3D35e09b7f-4fb=
1-4c8f-83ac-7ec33e124d44&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fc=
ore.yaml%23=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+title:=C2=A0ARTPEC-8=C2=A0SoC=C2=
=A0PCIe=C2=A0Controller=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+maintainers:=0D=0A>>=
=C2=A0+=C2=A0=C2=A0-=C2=A0Jesper=C2=A0Nilsson=C2=A0<jesper.nilsson=40axis.c=
om>=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+description:=C2=A0=7C+=0D=0A>>=C2=A0+=C2=
=A0=C2=A0This=C2=A0PCIe=C2=A0end-point=C2=A0controller=C2=A0is=C2=A0based=
=C2=A0on=C2=A0the=C2=A0Synopsys=C2=A0DesignWare=C2=A0PCIe=C2=A0IP=0D=0A>>=
=C2=A0+=C2=A0=C2=A0and=C2=A0thus=C2=A0inherits=C2=A0all=C2=A0the=C2=A0commo=
n=C2=A0properties=C2=A0defined=C2=A0in=C2=A0snps,dw-pcie-ep.yaml.=0D=0A>>=
=C2=A0+=0D=0A>>=C2=A0+allOf:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=24ref:=C2=A0=
/schemas/pci/snps,dw-pcie-ep.yaml=23=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+propertie=
s:=0D=0A>>=C2=A0+=C2=A0=C2=A0compatible:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0const:=C2=A0axis,artpec8-pcie-ep=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=
=C2=A0reg:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0Data=C2=A0Bus=C2=
=A0Interface=C2=A0(DBI)=C2=A0registers.=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0Data=C2=A0Bus=C2=A0Interface=C2=A0(=
DBI2)=C2=A0registers.=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=
=C2=A0description:=C2=A0PCIe=C2=A0address=C2=A0space=C2=A0region.=0D=0A>>=
=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0reg-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0co=
nst:=C2=A0dbi=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0cons=
t:=C2=A0dbi2=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const=
:=C2=A0addr_space=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0interrupts:=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0maxItems:=C2=A01=0D=0A>>=C2=A0+=0D=0A>>=
=C2=A0+=C2=A0=C2=A0clocks:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PI=
PE=C2=A0clock,=C2=A0used=C2=A0by=C2=A0the=C2=A0controller=C2=A0to=C2=A0cloc=
k=C2=A0the=C2=A0PIPE=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=
=A0description:=C2=A0PCIe=C2=A0dbi=C2=A0clock,=C2=A0ungated=C2=A0version=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PC=
Ie=C2=A0master=C2=A0clock,=C2=A0ungated=C2=A0version=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0slave=C2=
=A0clock,=C2=A0ungated=C2=A0version=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=
=A0clock-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0pipe=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0dbi=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0mstr=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0slv=0D=0A>>=C2=A0+=
=0D=0A>>=C2=A0+=C2=A0=C2=A0phys:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0maxI=
tems:=C2=A01=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0num-lanes:=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0const:=C2=A02=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+requ=
ired:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0compatible=0D=0A>>=C2=A0+=C2=A0=C2=
=A0-=C2=A0reg=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0reg-names=0D=0A>>=C2=A0+=C2=
=A0=C2=A0-=C2=A0interrupts=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0interrupt-names=
=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0clocks=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0c=
lock-names=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0samsung,fsys-sysreg=0D=0A>>=C2=
=A0+=C2=A0=C2=A0-=C2=A0samsung,syscon-phandle=0D=0A>>=C2=A0+=C2=A0=C2=A0-=
=C2=A0samsung,syscon-bus-s-fsys=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0samsung,sy=
scon-bus-p-fsys=0D=0A>=20=0D=0A>=20=0D=0A>=20We=C2=A0are=C2=A0making=C2=A0c=
ircles...=C2=A0This=C2=A0was=C2=A0before=C2=A0and=C2=A0I=C2=A0commented=C2=
=A0already=C2=A0it=C2=A0is=0D=0A>=20wrong.=C2=A0You=C2=A0cannot=C2=A0have=
=C2=A0some=C2=A0unknown/random=C2=A0properties=C2=A0in=C2=A0=22required:=22=
=0D=0A>=20without=C2=A0describing=C2=A0them=C2=A0in=C2=A0=22properties:=22.=
=C2=A0Please=C2=A0list=C2=A0all=C2=A0your=0D=0A>=20properties=C2=A0in=C2=A0=
=22properties:=22,=C2=A0except=C2=A0the=C2=A0ones=C2=A0coming=C2=A0from=C2=
=A0snps=0D=0A>=20bindings/schema.=0D=0A>=20=0D=0A=0D=0AI=20missed=20that=20=
when=20adding=20new=20items=20to=20=22required=22,=0D=0Ait=20should=20also=
=20be=20added=20to=20=22properties=22.=0D=0AI=20will=20add=20the=20followin=
g=20items=20to=20the=20property.=0D=0A=0D=0Asamsung,fsys-sysreg:=0D=0A=20=
=20description:=0D=0A=20=20=20=20Phandle=20to=20system=20register=20of=20fs=
ys=20block.=0D=0A=20=20=24ref:=20/schemas/types.yaml=23/definitions/phandle=
=0D=0A=0D=0Asamsung,syscon-phandle:=0D=0A=20=20description:=0D=0A=20=20=20=
=20Phandle=20to=20the=20PMU=20system=20controller=20node.=0D=0A=20=20=24ref=
:=20/schemas/types.yaml=23/definitions/phandle=0D=0A=0D=0Asamsung,syscon-bu=
s-s-fsys:=0D=0A=20=20description:=0D=0A=20=20=20=20Phandle=20to=20bus-s=20p=
ath=20of=20fsys=20block,=20this=20register=0D=0A=20=20=20=20are=20used=20fo=
r=20enabling=20bus-s.=0D=0A=20=20=24ref:=20/schemas/types.yaml=23/definitio=
ns/phandle=0D=0A=0D=0Asamsung,syscon-bus-p-fsys:=0D=0A=20=20description:=0D=
=0A=20=20=20=20Phandle=20to=20bus-p=20path=20of=20fsys=20block,=20this=20re=
gister=0D=0A=20=20=20=20are=20used=20for=20enabling=20bus-p.=0D=0A=20=20=24=
ref:=20/schemas/types.yaml=23/definitions/phandle=0D=0A=0D=0A>>=C2=A0+=C2=
=A0=C2=A0-=C2=A0phys=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0num-lanes=0D=0A>>=C2=
=A0+=0D=0A>>=C2=A0+unevaluatedProperties:=C2=A0false=0D=0A>>=C2=A0+=0D=0A>>=
=C2=A0+examples:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=7C=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=23include=C2=A0<dt-bindings/interrupt-controller/irq.h>=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=23include=C2=A0<dt-bindings/interru=
pt-controller/arm-gic.h>=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0soc=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=23address-cells=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=23size-cells=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcie_ep:=C2=A0pcie-ep=40172=
00000=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible=C2=A0=3D=C2=A0=22axis,artpec8-pcie-ep=
=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0reg=C2=A0=3D=C2=A0<0x0=C2=A00x17200000=C2=A00x0=C2=A00x10=
00>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<0x0=C2=A00x17201000=
=C2=A00x0=C2=A00x1000>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<0x=
2=C2=A00x00000000=C2=A00x6=C2=A00x00000000>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg-names=C2=A0=3D=
=C2=A0=22dbi=22,=C2=A0=22dbi2=22,=C2=A0=22addr_space=22;=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=23int=
errupt-cells=C2=A0=3D=C2=A0<1>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupts=C2=A0=3D=C2=A0<GIC_=
SPI=C2=A0115=C2=A0IRQ_TYPE_LEVEL_HIGH>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupt-names=C2=A0=3D=
=C2=A0=22intr=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clocks=C2=A0=3D=C2=A0<&clock_cmu_fsys=C2=A039=
>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<&cloc=
k_cmu_fsys=C2=A038>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<&clock_cmu_fsys=C2=A037>,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<&clock_cmu_fsys=C2=A036>;=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock-=
names=C2=A0=3D=C2=A0=22pipe=22,=C2=A0=22dbi=22,=C2=A0=22mstr=22,=C2=A0=22sl=
v=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0samsung,fsys-sysreg=C2=A0=3D=C2=A0<&syscon_fsys>;=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0samsung,syscon-phandle=C2=A0=3D=C2=A0<&pmu_system_controller>;=0D=0A>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0samsung,syscon-bus-s-fsys=C2=A0=3D=C2=A0<&syscon_bus_s_fsys>;=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0samsung,syscon-bus-p-fsys=C2=A0=3D=C2=A0<&syscon_bus_p_fsys>;=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0phys=C2=A0=3D=C2=A0<&pcie_phy>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy-names=C2=A0=3D=C2=A0=
=22pcie_phy=22;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0num-lanes=C2=A0=3D=C2=A0<2>;=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus-ra=
nge=C2=A0=3D=C2=A0<0x00=C2=A00xff>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0num-ib-windows=C2=A0=3D=C2=
=A0<16>;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0num-ob-windows=C2=A0=3D=C2=A0<16>;=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D;=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=7D;=0D=0A>>=C2=A0+...=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/D=
ocumentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml=C2=A0b/Document=
ation/devicetree/bindings/pci/axis,artpec8-pcie.yaml=0D=0A>>=C2=A0new=C2=A0=
file=C2=A0mode=C2=A0100644=0D=0A>>=C2=A0index=C2=A00000000..dbbe1fd=0D=0A>>=
=C2=A0---=C2=A0/dev/null=0D=0A>>=C2=A0+++=C2=A0b/Documentation/devicetree/b=
indings/pci/axis,artpec8-pcie.yaml=0D=0A>>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,12=
0=C2=A0=40=40=0D=0A>>=C2=A0+=23=C2=A0SPDX-License-Identifier:=C2=A0(GPL-2.0=
-only=C2=A0OR=C2=A0BSD-2-Clause)=0D=0A>>=C2=A0+%YAML=C2=A01.2=0D=0A>>=C2=A0=
+---=0D=0A>>=C2=A0+=24id:=C2=A0https://protect2.fireeye.com/v1/url?k=3D8f17=
d1f3-ee6a3b70-8f165abc-74fe48600158-c1db309737e1575c&q=3D1&e=3D35e09b7f-4fb=
1-4c8f-83ac-7ec33e124d44&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fpci%2F=
axis%2Cartpec8-pcie.yaml%23=0D=0A>>=C2=A0+=24schema:=C2=A0https://protect2.=
fireeye.com/v1/url?k=3D50e0873f-319d6dbc-50e10c70-74fe48600158-c376ff145b3e=
096a&q=3D1&e=3D35e09b7f-4fb1-4c8f-83ac-7ec33e124d44&u=3Dhttp%3A%2F%2Fdevice=
tree.org%2Fmeta-schemas%2Fcore.yaml%23=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+title:=
=C2=A0Artpec-8=C2=A0SoC=C2=A0PCIe=C2=A0Controller=0D=0A>>=C2=A0+=0D=0A>>=C2=
=A0+maintainers:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0Jesper=C2=A0Nilsson=C2=A0=
<jesper.nilsson=40axis.com>=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+description:=C2=A0=
=7C+=0D=0A>>=C2=A0+=C2=A0=C2=A0This=C2=A0PCIe=C2=A0host=C2=A0controller=C2=
=A0is=C2=A0based=C2=A0on=C2=A0the=C2=A0Synopsys=C2=A0DesignWare=C2=A0PCIe=
=C2=A0IP=0D=0A>>=C2=A0+=C2=A0=C2=A0and=C2=A0thus=C2=A0inherits=C2=A0all=C2=
=A0the=C2=A0common=C2=A0properties=C2=A0defined=C2=A0in=C2=A0snps,dw-pcie.y=
aml.=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+allOf:=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=
=24ref:=C2=A0/schemas/pci/snps,dw-pcie.yaml=23=0D=0A>>=C2=A0+=0D=0A>>=C2=A0=
+properties:=0D=0A>>=C2=A0+=C2=A0=C2=A0compatible:=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0const:=C2=A0axis,artpec8-pcie=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=
=C2=A0=C2=A0reg:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0Data=C2=A0Bus=
=C2=A0Interface=C2=A0(DBI)=C2=A0registers.=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0External=C2=A0Local=C2=A0Bus=C2=
=A0interface=C2=A0(ELBI)=C2=A0registers.=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0configuration=C2=A0spa=
ce=C2=A0region.=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0reg-names:=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0dbi=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0elbi=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0config=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=
=A0=C2=A0ranges:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0maxItems:=C2=A02=0D=
=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0num-lanes:=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0const:=C2=A02=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0inter=
rupts:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0maxItems:=C2=A01=0D=0A>>=C2=A0=
+=0D=0A>>=C2=A0+=C2=A0=C2=A0clocks:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0i=
tems:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=
=C2=A0PIPE=C2=A0clock,=C2=A0used=C2=A0by=C2=A0the=C2=A0controller=C2=A0to=
=C2=A0clock=C2=A0the=C2=A0PIPE=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0-=C2=A0description:=C2=A0PCIe=C2=A0dbi=C2=A0clock,=C2=A0ungated=C2=A0=
version=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0descriptio=
n:=C2=A0PCIe=C2=A0master=C2=A0clock,=C2=A0=C2=A0ungated=C2=A0version=0D=0A>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0description:=C2=A0PCIe=
=C2=A0slave=C2=A0clock,=C2=A0ungated=C2=A0version=0D=0A>>=C2=A0+=0D=0A>>=C2=
=A0+=C2=A0=C2=A0clock-names:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0items:=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0pipe=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0dbi=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0mstr=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0const:=C2=A0slv=
=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0phys:=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0maxItems:=C2=A01=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+required:=0D=0A>>=
=C2=A0+=C2=A0=C2=A0-=C2=A0compatible=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0reg=
=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0reg-names=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=
=A0device_type=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0ranges=0D=0A>>=C2=A0+=C2=A0=
=C2=A0-=C2=A0num-lanes=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0interrupts=0D=0A>>=
=C2=A0+=C2=A0=C2=A0-=C2=A0interrupt-names=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0=
clocks=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0clock-names=0D=0A>>=C2=A0+=C2=A0=C2=
=A0-=C2=A0samsung,fsys-sysreg=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0samsung,sysc=
on-phandle=0D=0A>>=C2=A0+=C2=A0=C2=A0-=C2=A0samsung,syscon-bus-s-fsys=0D=0A=
>>=C2=A0+=C2=A0=C2=A0-=C2=A0samsung,syscon-bus-p-fsys=0D=0A>=20=0D=0A>=20Sa=
me=C2=A0problem.=0D=0A>=20=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Krzysztof=
=0D=0A=0D=0AThank=20you=20for=20kindness=20reivew.=0D=0A=0D=0ABest=20regard=
s,=0D=0AWangseok=20Lee
