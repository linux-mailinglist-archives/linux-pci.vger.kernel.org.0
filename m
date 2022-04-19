Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C458A50609E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 02:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbiDSAKW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiDSAKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 20:10:20 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985563A7
        for <linux-pci@vger.kernel.org>; Mon, 18 Apr 2022 17:07:39 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220419000733epoutp0177e34ba24cb5d580042bcfe2456fa201~nI4d-EnOY2377423774epoutp01u
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2022 00:07:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220419000733epoutp0177e34ba24cb5d580042bcfe2456fa201~nI4d-EnOY2377423774epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650326853;
        bh=AChNfJQWMXjSwwKi12gVmv2Q77//iQk0dtbyPaoW1Ls=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Kgxtor4qALYW5tJjrytsesasDEb6okogLTiBAPEqKcE/Zv/7zZ+FIAeywTCPq423j
         Url6N7Qa3RFbNHAeWSfT0f+nc71Sbgsvd+XI2cppeNSLEq5+9Y8E1bhRTEj4cHfFDH
         3x+m4TbI4O3xQvMqW+DaaE4YLBE+lkBJTKQDDtOE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220419000732epcas2p1b9493d582a4b17b4ef6bdc5e24ef5ce3~nI4c_DA3O0349203492epcas2p1H;
        Tue, 19 Apr 2022 00:07:32 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Kj3yp6jvCz4x9Qb; Tue, 19 Apr
        2022 00:07:30 +0000 (GMT)
X-AuditID: b6c32a45-4fdff700000228cc-45-625dfd42be01
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.47.10444.24DFD526; Tue, 19 Apr 2022 09:07:30 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        robh+dt <robh+dt@kernel.org>, krzk+dt <krzk+dt@kernel.org>,
        kishon <kishon@ti.com>, vkoul <vkoul@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "jesper.nilsson" <jesper.nilsson@axis.com>,
        "lars.persson" <lars.persson@axis.com>
CC:     bhelgaas <bhelgaas@google.com>,
        linux-phy <linux-phy@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi" <lorenzo.pieralisi@arm.com>, kw <kw@linux.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        kernel <kernel@axis.com>, Moon-Ki Jun <moonki.jun@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220419000730epcms2p77c94d5e55db13ebf2f88b25d16b6ef7a@epcms2p7>
Date:   Tue, 19 Apr 2022 09:07:30 +0900
X-CMS-MailID: 20220419000730epcms2p77c94d5e55db13ebf2f88b25d16b6ef7a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmma7T39gkgzdt8hZLmjIsXh7StJh/
        5Byrxe4Zy5ksnh+axWzxqUXV4sLTHjaLl7PusVmcP7+B3aKh5zerxZE3H5kt9h9fyWRxedcc
        Nouz846zWUxY9Y3F4s3vF+wW5xZnWrTuPcJusfPOCWYHYY8189YwelxfF+CxYFOpx6ZVnWwe
        T65MZ/LYvKTeo2/LKkaP4ze2M3l83iQXwBmVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
        qGtoaWGupJCXmJtqq+TiE6DrlpkD9I+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
        p8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjePs51oLNYhWzX31iamB8IdrFyMkhIWAicXta
        IzOILSSwg1Fi2R32LkYODl4BQYm/O4RBwsIC7hKTmqayQ5QoSexYM48ZIq4vcX1FNyuIzSag
        K/Fv8Uu2LkYuDhGBBUwS9+fOYAJxmAX+M0m8ajzGBrGMV2JG+1MWCFtaYvvyrYwQtobEj2W9
        zBC2qMTN1W/ZYez3x+ZD1YhItN47C1UjKPHg526ouJTEgieHWCHsaon9f38zQdgNjBL991NB
        npEAunTHdWOQMK+Ar0TnsQ9gJSwCqhKnn8yBOsdF4tHBWWAjmQW0JZYtfM0M0sosoCmxfpc+
        xBRliSO3WGAeadj4mx2dzSzAJ9Fx+C9cfMe8J1DHqEnMW7mTGWKMjMTWl/4TGJVmIcJ5FpK1
        sxDWLmBkXsUollpQnJueWmxUYAiP2eT83E2M4HSt5bqDcfLbD3qHGJk4GA8xSnAwK4nw9iyJ
        ThLiTUmsrEotyo8vKs1JLT7EaAr08ERmKdHkfGDGyCuJNzSxNDAxMzM0NzI1MFcS5/VK2ZAo
        JJCeWJKanZpakFoE08fEwSnVwNTtV1KZ9vDXG4NcxbA5CYwhegJd6n/rn9mH+vlIrGVlXOx+
        4qKPHpuEQ9rpJRe25eX/ySzJr557rmdKnQaP8uMd3dukl+UsWHa+a2b5vuXenUX6Xp9cWWZ3
        +wlWlU+P+O2w/6rDu8kc/Gpf7LdUnb83h02oLorp8tQXUtoprDP9uqLWp8nVtBiJ8zDtuur/
        9eqqffLf3vGsr5oZsbL54M0mgfsClkE7iqytLaakNsV9vpmsxGY/sZrP0egMW00By8zKi/lM
        UvOOM95qWDLNw9fvmebSNwVb6qTFL73pWJv2Z3vuruDVn+a42DtI8UtYV+zr2NB7++ZRway6
        fWxZiVnGAe9c41/x/WxOfsCgxFKckWioxVxUnAgAgmXUsGAEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220419000730epcms2p77c94d5e55db13ebf2f88b25d16b6ef7a
References: <CGME20220419000730epcms2p77c94d5e55db13ebf2f88b25d16b6ef7a@epcms2p7>
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

> On=C2=A028/03/2022=C2=A004:14,=C2=A0=EC=9D=B4=EC=99=95=EC=84=9D=C2=A0wrot=
e:=0D=0A>>=C2=A0Add=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0SoC.=0D=0A>>=
=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0of=C2=A0Axis=C2=
=A0Communications.=0D=0A>>=C2=A0This=C2=A0is=C2=A0based=C2=A0on=C2=A0arm64=
=C2=A0and=C2=A0support=C2=A0GEN4=C2=A0&=C2=A02lane.=0D=0A>>=C2=A0This=C2=A0=
PCIe=C2=A0controller=C2=A0is=C2=A0based=C2=A0on=C2=A0DesignWare=C2=A0Hardwa=
re=C2=A0core=0D=0A>>=C2=A0and=C2=A0uses=C2=A0DesignWare=C2=A0core=C2=A0func=
tions=C2=A0to=C2=A0implement=C2=A0the=C2=A0driver.=0D=0A>>=C2=A0This=C2=A0i=
s=C2=A0based=C2=A0on=C2=A0driver/pci/controller/dwc/pci-exynos.c=0D=0A>>=C2=
=A0=0D=0A>>=C2=A0Signed-off-by:=C2=A0Wangseok=C2=A0Lee=C2=A0=0D=0A>>=20---=
=0D=0A>>=20=20drivers/pci/controller/dwc/Kconfig=20=20=20=20=20=20=20=20=7C=
=20=2031=20+=0D=0A>>=20=20drivers/pci/controller/dwc/Makefile=20=20=20=20=
=20=20=20=7C=20=20=201=20+=0D=0A>>=20=20drivers/pci/controller/dwc/pcie-art=
pec8.c=20=7C=20912=20++++++++++++++++++++++++++++++=0D=0A>>=20=203=20files=
=20changed,=20944=20insertions(+)=0D=0A>>=20=20create=20mode=20100644=20dri=
vers/pci/controller/dwc/pcie-artpec8.c=0D=0A>>=20=0D=0A>=20=0D=0A>=20I=20to=
ok=20a=20look=20at=20the=20your=20driver=20and=20at=20existing=20PCIe=20Exy=
nos=20driver.=0D=0A>=20Unfortunately=20PCIe=20Exynos=20driver=20is=20in=20p=
oor=20shape,=20really=20poor.=20This=0D=0A>=20would=20explain=20that=20mayb=
e=20it's=20better=20to=20have=20new=20driver=20instead=20of=0D=0A>=20mergin=
g=20them,=20especially=20that=20hardware=20is=20different.=20Although=20I=
=20am=20still=0D=0A>=20waiting=20for=20some=20description=20of=20these=20di=
fferences...=0D=0A>=20=0D=0A>=20I=20said=20that=20Exynos=20PCIe=20looks=20p=
oor...=20but=20what=20is=20worse,=20it=20looks=20like=0D=0A>=20you=20based=
=20on=20it=20so=20you=20copied=20or=20some=20bad=20patterns=20it=20had.=0D=
=0A>=20=0D=0A>=20Except=20this=20the=20driver=20has=20several=20coding=20st=
yle=20issues,=20so=20please=20be=0D=0A>=20sure=20to=20run=20checkpatch,=20s=
parse=20and=20smatch=20before=20sending=20it.=0D=0A>=20=0D=0A>=20Please=20w=
ork=20on=20this=20driver=20to=20make=20it=20close=20to=20Linux=20coding=20s=
tyle,=20so=0D=0A>=20there=20will=20be=20no=20need=20for=20us,=20reviewers,=
=20focus=20on=20basic=20stuff.=0D=0A>=20=0D=0A>=20Optionally,=20send=20all=
=20this=20to=20staging.=20:)=0D=0A>=20=0D=0A>=20Best=20regards,=0D=0A>=20Kr=
zysztof=0D=0AHi,=0D=0A=0D=0AThank=20you=20for=20your=20kindness=20review.=
=0D=0AI=20will=20re-work=20again=20close=20to=20the=20linux=20coding=20styl=
e.=0D=0AAddiltionaly,=20If=20you=20tell=20me=20what=20=22bad=20patterns=22=
=20you=20mentioned,=0D=0Ait=20will=20be=20very=20helpful=20for=20the=20work=
.=0D=0ACould=20you=20please=20tell=20me=20that?=0D=0A=0D=0AThank=20you.
