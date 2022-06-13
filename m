Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E95547D84
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiFMBuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Jun 2022 21:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiFMBug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Jun 2022 21:50:36 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191AA4B410
        for <linux-pci@vger.kernel.org>; Sun, 12 Jun 2022 18:50:32 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220613015025epoutp0256d121c369edfbd3e22c423fdd570234~4Cw-j_j0g1681016810epoutp02P
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 01:50:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220613015025epoutp0256d121c369edfbd3e22c423fdd570234~4Cw-j_j0g1681016810epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655085025;
        bh=TI5lIB7R6zW2iND4nrZkLphXvV5UKqiH9SxEM/5/FmM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=E5o6iu8L/I4eUSGjfSfnvV4bLuKRv3l25W2oRxpHwsCE1bGCsHHVfYTCDpAoambEv
         7Y4eMYMo7KUBG3hNmCV8L0aXgohIZUFGcp801PQQGsRnz6WSiHEpL3CGm+8g5J4DmC
         JZRsVb3eE2XqbLXjRqUAceS6vPwDa0+4uDw+oLsI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220613015025epcas2p37377353f244eec7ae8a60a8699095200~4Cw_ugwgL1307313073epcas2p3K;
        Mon, 13 Jun 2022 01:50:25 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LLvf81S62z4x9Pr; Mon, 13 Jun
        2022 01:50:24 +0000 (GMT)
X-AuditID: b6c32a46-f75ff70000002624-c0-62a697e0d2f4
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.0A.09764.0E796A26; Mon, 13 Jun 2022 10:50:24 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v2 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
In-Reply-To: <20220610153020.GA597980@bhelgaas>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220613015023epcms2p70e6700a99042d4deb560e40ab5397001@epcms2p7>
Date:   Mon, 13 Jun 2022 10:50:23 +0900
X-CMS-MailID: 20220613015023epcms2p70e6700a99042d4deb560e40ab5397001
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmhe6D6cuSDP7OZrdY0pRh8fKQpsX8
        I+dYLXbPWM5k8erMWjaLmVPPMFs8PzSL2eJTi6rFhac9bBYvZ91js2jo+c1qceTNR2aL/cdX
        Mllc3jWHzeLsvONsFhNWfWOxePP7BbvFucWZFq17j7Bb7Lxzgtni19Y/TA6iHmvmrWH0uL4u
        wGPBplKPTas62TyeXJnO5LF5Sb1H35ZVjB7Hb2xn8vi8SS6AMyrbJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoMyWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbsg/eZC876VBw9d5C9gfG4
        VxcjJ4eEgInEsb8L2boYuTiEBHYwSrS+nszYxcjBwSsgKPF3hzBIjbCAl8TqrjlsILaQgJLE
        jjXzmCHi+hLXV3SzgthsAroS/xa/ZANpFRFQk+hqDwUZySwwkV1iztPzzBC7eCVmtD9lgbCl
        JbYv38oIYnMCzbnUdwQqriHxY1kvVL2oxM3Vb9lh7PfH5jNC2CISrffOQtUISjz4uRsqLiWx
        4MkhVgi7WmL/399MEHYDo0T//VSQ2ySAdu24bgwS5hXwlfj/aSlYOYuAqsSq31+hVrlI7Jy7
        HuwcZgFtiWULXzODtDILaEqs36UPMUVZ4sgtFpinGjb+ZkdnMwvwSXQc/gsX3zHvCdQxahLz
        Vu5knsCoPAsRzLOQ7JqFsGsBI/MqRrHUguLc9NRiowIjeMwm5+duYgSncC23HYxT3n7QO8TI
        xMF4iFGCg1lJhDfg9qIkId6UxMqq1KL8+KLSnNTiQ4ymQF9OZJYSTc4HZpG8knhDE0sDEzMz
        Q3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1M5xMmPeS+m39fyc3lbRyPxNTtieYK
        p9du39t3Jfbw3qq1mjOreZun77x6jjvAqMrQI/iNtH6hHWt4a9pW/qnTOpdud1aq+9f653rx
        j1LOhz/Ued7fMpyTUDYnwcYzZW3FMhMNvsNCDUViy+MDl5u/1ZJdUG5tuTTnVZr2rKPf1+9Q
        Z/B7JMq9zdXpecFKh52HQ9QXZ93WVxZeZj3pgtCL0zO7WXbGpi95uWhf8dvdMeqbt3X/qPv3
        LDQ9LZZpTY6y8c79zg0Gq18uUlkjHLTZfbXPLKWWldc9aqbZ+TG88zf1qVaY8YU3+M09lwP2
        sqnBojUyVmVbqyLNZQ/qHu+u7SlSvzn5dpDWlfLtLxuVWIozEg21mIuKEwFVqrYyagQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610153050epcas2p3b0d83f4f56ffe81a06aae73d8994a3d1
References: <20220610153020.GA597980@bhelgaas>
        <CGME20220610153050epcas2p3b0d83f4f56ffe81a06aae73d8994a3d1@epcms2p7>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/11/2022 00:30, Bjorn Helgaas wrote:
> On=C2=A0Fri,=C2=A0Jun=C2=A010,=C2=A02022=C2=A0at=C2=A009:03:03AM=C2=A0+09=
00,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=0D=0A>>=C2=A0On=C2=A006/04/2022=C2=
=A001:03,=C2=A0Bjorn=C2=A0Helgaas=C2=A0wrote:=0D=0A>>=C2=A0>=C2=A0In=C2=A0t=
he=C2=A0subject,=C2=A0why=C2=A0do=C2=A0you=C2=A0tag=C2=A0this=C2=A0=22axis=
=22?=C2=A0=C2=A0There's=C2=A0an=C2=A0existing=0D=0A>>=C2=A0>=C2=A0pcie-artp=
ec6.c=C2=A0that=C2=A0uses=C2=A0the=C2=A0driver=C2=A0name=C2=A0=22=22artpec6=
-pcie=22=C2=A0and=C2=A0the=0D=0A>>=C2=A0>=C2=A0subject=C2=A0line=C2=A0tag=
=C2=A0=22artpec6=22.=0D=0A>>=C2=A0>=C2=A0=0D=0A>>=C2=A0>=C2=A0This=C2=A0add=
s=C2=A0pcie-artpec8.c=C2=A0with=C2=A0driver=C2=A0name=C2=A0=22artpec8-pcie=
=22,=C2=A0so=C2=A0the=0D=0A>>=C2=A0>=C2=A0obvious=C2=A0choice=C2=A0would=C2=
=A0be=C2=A0=22artpec8=22.=0D=0A>>=C2=A0>=C2=A0=0D=0A>>=C2=A0>=C2=A0I=C2=A0a=
ssume=C2=A0you=C2=A0evaluated=C2=A0the=C2=A0possibility=C2=A0of=C2=A0extend=
ing=C2=A0artpec6=C2=A0to=C2=A0support=0D=0A>>=C2=A0>=C2=A0artpec8=C2=A0in=
=C2=A0addition=C2=A0to=C2=A0the=C2=A0artpec6=C2=A0and=C2=A0artpec7=C2=A0it=
=C2=A0already=C2=A0supports?=0D=0A>>=C2=A0=C2=A0=0D=0A>>=C2=A0=22pcie-artpe=
c6.=C2=A0c=22=C2=A0supports=C2=A0artpec6=C2=A0and=C2=A0artpec7=C2=A0H/W.=0D=
=0A>>=C2=A0artpec8=C2=A0can=C2=A0not=C2=A0be=C2=A0expanded=C2=A0because=C2=
=A0H/W=C2=A0configuration=C2=A0is=0D=0A>>=C2=A0completely=C2=A0different=C2=
=A0from=C2=A0artpec6/7.=0D=0A>>=C2=A0phy=C2=A0and=C2=A0sub=C2=A0controller=
=C2=A0are=C2=A0different.=0D=0A>=20=0D=0A>=20Thanks=C2=A0for=C2=A0this=C2=
=A0detail.=C2=A0=C2=A0Can=C2=A0you=C2=A0include=C2=A0this=C2=A0in=C2=A0the=
=C2=A0commit=C2=A0log=C2=A0next=0D=0A>=20time=C2=A0around=C2=A0in=C2=A0case=
=C2=A0anybody=C2=A0else=C2=A0has=C2=A0a=C2=A0similar=C2=A0question?=0D=0A>=
=20=0D=0A=0D=0AOk,=20sure.=0D=0A=0D=0A>>=C2=A0>>=C2=A0+/*=C2=A0FSYS=C2=A0SY=
SREG=C2=A0Offsets=C2=A0*/=0D=0A>>=C2=A0>=C2=A0=0D=0A>>=C2=A0>=C2=A0The=C2=
=A0list=C2=A0below=C2=A0seems=C2=A0to=C2=A0inclue=C2=A0more=C2=A0than=C2=A0=
just=C2=A0register=C2=A0offsets.=0D=0A>>=C2=A0>=C2=A0=0D=0A>>=C2=A0=C2=A0=
=0D=0A>>=C2=A0Is=C2=A0it=C2=A0clear=C2=A0to=C2=A0change=C2=A0to=C2=A0=22FSY=
S=C2=A0blue=C2=A0logic=C2=A0system=C2=A0registers=22=C2=A0=0D=0A>>=C2=A0lik=
e=C2=A0Jasper=C2=A0Nilsson=60s=C2=A0comment?=0D=0A>>=C2=A0https://lore.kern=
el.org/all/20220607070332.GY18902=40axis.com/=0D=0A>>=C2=A0My=C2=A0opinion=
=C2=A0is=C2=A0the=C2=A0same.=0D=0A>=20=0D=0A>=20Yep,=C2=A0that's=C2=A0fine.=
=C2=A0=C2=A0But=C2=A0spell=C2=A0it=C2=A0=22glue=C2=A0logic=22,=C2=A0not=C2=
=A0=22blue=C2=A0logic=22=C2=A0:)=0D=0A>=20=0D=0A=0D=0AThanks,=20it=20was=20=
just=20a=20typo.=0D=0A=0D=0A>>=C2=A0>>=C2=A0+static=C2=A0int=C2=A0artpec8_p=
cie_get_clk_resources(struct=C2=A0platform_device=C2=A0*pdev,=0D=0A>>=C2=A0=
>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0struct=C2=A0artpec8_pcie=C2=A0*artpec8_ctrl)=0D=0A>>=C2=
=A0>>=C2=A0+=7B=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0struct=C2=A0device=C2=A0*dev=C2=A0=3D=C2=A0&pdev->dev;=0D=0A>>=
=C2=A0>>=C2=A0+=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0artpec8_ctrl->pipe_clk=C2=A0=3D=C2=A0devm_clk_get(dev,=C2=A0=22=
pipe_clk=22);=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0if=C2=A0(IS_ERR(artpec8_ctrl->pipe_clk))=C2=A0=7B=0D=0A>>=C2=A0>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev,=C2=A0=22couldn't=C2=A0get=C2=A0p=
ipe=C2=A0clock=5Cn=22);=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
=C2=A0-EINVAL;=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=7D=0D=0A>>=C2=A0>>=C2=A0+=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0artpec8_ctrl->dbi_clk=C2=A0=3D=C2=A0dev=
m_clk_get(dev,=C2=A0=22dbi_clk=22);=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(IS_ERR(artpec8_ctrl->dbi_clk))=C2=
=A0=7B=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_info(dev,=C2=A0=22co=
uldn't=C2=A0get=C2=A0dbi=C2=A0clk=5Cn=22);=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0return=C2=A0-EINVAL;=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>>=C2=A0>>=C2=A0+=0D=0A>>=C2=A0>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0artpec8_ctrl->slv_clk=
=C2=A0=3D=C2=A0devm_clk_get(dev,=C2=A0=22slv_clk=22);=0D=0A>>=C2=A0>>=C2=A0=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(IS_ERR(artpec8_ct=
rl->slv_clk))=C2=A0=7B=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(d=
ev,=C2=A0=22couldn't=C2=A0get=C2=A0slave=C2=A0clock=5Cn=22);=0D=0A>>=C2=A0>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0-EINVAL;=0D=0A>>=C2=A0>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>>=C2=A0>>=C2=A0+=
=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0artp=
ec8_ctrl->mstr_clk=C2=A0=3D=C2=A0devm_clk_get(dev,=C2=A0=22mstr_clk=22);=0D=
=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=
=A0(IS_ERR(artpec8_ctrl->mstr_clk))=C2=A0=7B=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0dev_info(dev,=C2=A0=22couldn't=C2=A0get=C2=A0master=C2=A0clk=
=5Cn=22);=0D=0A>>=C2=A0>=C2=A0=0D=0A>>=C2=A0>=C2=A0It'd=C2=A0be=C2=A0nice=
=C2=A0if=C2=A0the=C2=A0err/info=C2=A0messages=C2=A0matched=C2=A0the=C2=A0ex=
act=C2=A0DT=C2=A0name:=0D=0A>>=C2=A0>=C2=A0=22pipe_clk=22,=C2=A0=22dbi_clk=
=22,=C2=A0slv_clk=22,=C2=A0etc.=0D=0A>>=C2=A0>=C2=A0=0D=0A>>=C2=A0=C2=A0=0D=
=0A>>=C2=A0I=C2=A0will=C2=A0fix=C2=A0it.=0D=0A>>=C2=A0=C2=A0=0D=0A>>=C2=A0>=
=C2=A0Why=C2=A0are=C2=A0some=C2=A0of=C2=A0the=C2=A0above=C2=A0dev_err()=C2=
=A0and=C2=A0others=C2=A0dev_info()=C2=A0when=C2=A0you=0D=0A>>=C2=A0>=C2=A0r=
eturn=C2=A0-EINVAL=C2=A0in=C2=A0all=C2=A0cases?=0D=0A>>=C2=A0=C2=A0=0D=0A>>=
=C2=A0When=C2=A0property=C2=A0is=C2=A0not=C2=A0found,=C2=A0it=C2=A0just=C2=
=A0to=C2=A0return=C2=A0error.=0D=0A>>=C2=A0I=C2=A0will=C2=A0modify=C2=A0to=
=C2=A0return=C2=A0PTR_ERR.=0D=0A>=20=0D=0A>=20=0D=0A>=20Using=C2=A0PTR_ERR(=
)=C2=A0looks=C2=A0like=C2=A0a=C2=A0good=C2=A0idea,=C2=A0since=C2=A0then=C2=
=A0you=C2=A0return=C2=A0the=0D=0A>=20actual=C2=A0error=C2=A0from=C2=A0devm_=
clk_get()=C2=A0instead=C2=A0of=C2=A0always=C2=A0returning=C2=A0-EINVAL.=0D=
=0A>=20=0D=0A>=20But=C2=A0that=C2=A0wasn't=C2=A0my=C2=A0comment.=C2=A0=C2=
=A0My=C2=A0comment=C2=A0was=C2=A0that=C2=A0it=C2=A0looks=C2=A0like=C2=A0the=
se=0D=0A>=20should=C2=A0be=C2=A0all=C2=A0dev_err()=C2=A0(or=C2=A0all=C2=A0d=
ev_info()).=0D=0A>=20=0D=0A=0D=0AI=20understood=20your=20question.=20I=20th=
ink=20it=20was=20simply=20a=20way=20to=20generate=20log=0D=0Amsg.=0D=0AIn=
=20this=20case,=20is=20there=20a=20more=20proper=20print=20function=20that=
=20use=20to=20generate=0D=0Alog=20msg?=0D=0AIn=20addition,=20error=20return=
=20in=20artpec8_pcie_get_clk_resources()=20will=20be=0D=0Amodified=20to=20d=
evm_clk_bulk_get().=0D=0A(according=20to=20Krzysztof's=20review=20comment..=
=20)=0D=0A=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0switch=C2=A0(mode)=C2=A0=7B=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case=C2=A0DW_PCIE_RC_TYPE:=0D=0A>>=C2=A0>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0artpec8_pcie_writel(artpec8_ctrl->elbi_base,=C2=
=A0DEVICE_TYPE_RC,=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0PCIE_ARTPEC8_DEVICE_TYPE);=0D=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0ret=C2=A0=3D=C2=A0artpec8_add_pcie_port(artpec8_ctrl,=C2=A0pdev);=0D=
=0A>>=C2=A0>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(ret=C2=A0<=C2=A00)=0D=0A=
>>=C2=A0>=C2=A0=0D=0A>>=C2=A0>=C2=A0Are=C2=A0there=C2=A0positive=C2=A0retur=
n=C2=A0values=C2=A0that=C2=A0indicate=C2=A0success?=C2=A0=C2=A0Most=C2=A0pl=
aces=0D=0A>>=C2=A0>=C2=A0above=C2=A0you=C2=A0assume=C2=A0=22ret=C2=A0=21=3D=
=C2=A00=22=C2=A0means=C2=A0failure,=C2=A0so=C2=A0just=C2=A0curious=C2=A0why=
=C2=A0you=0D=0A>>=C2=A0>=C2=A0test=C2=A0=22ret=C2=A0<=C2=A00=22=C2=A0instea=
d=C2=A0of=C2=A0just=C2=A0=22ret=22.=0D=0A>>=C2=A0=C2=A0=0D=0A>>=C2=A0There=
=C2=A0is=C2=A0no=C2=A0special=C2=A0reason,=C2=A0but=C2=A0it=C2=A0seems=C2=
=A0that=C2=A0the=C2=A0format=C2=A0used=C2=A0=0D=0A>>=C2=A0in=C2=A0the=C2=A0=
existing=C2=A0dw=C2=A0driver=C2=A0is=C2=A0applied.=0D=0A>=20=0D=0A>=20Fair=
=C2=A0enough.=C2=A0=C2=A0=22git=C2=A0grep=C2=A0-A2=C2=A0add_pcie_port=C2=A0=
drivers/pci/controller/=22=0D=0A>=20says=C2=A0all=C2=A0*_add_pcie_port()=C2=
=A0calls=C2=A0use=C2=A0the=C2=A0same=C2=A0pattern,=C2=A0so=C2=A0thanks=C2=
=A0for=0D=0A>=20following=C2=A0that.=0D=0A>=20=0D=0A>=20Bjorn=0D=0A=0D=0ATh=
ank=20you=20for=20kindness=20reivew.=0D=0A=20=0D=0ABest=20regards,=0D=0AWan=
gseok=20Lee
