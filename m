Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0BC5426F3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiFHGBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 02:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbiFHFvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 01:51:22 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9AC18FA71
        for <linux-pci@vger.kernel.org>; Tue,  7 Jun 2022 20:32:03 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220608033202epoutp03a0d6b98010e7e0a50bf434cb327689af~2h7RtXPsH0355503555epoutp03v
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:32:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220608033202epoutp03a0d6b98010e7e0a50bf434cb327689af~2h7RtXPsH0355503555epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654659122;
        bh=R6XWyD0M4zYeiZaM11sDfcj4kG76ksycJZ3q1CIX1qM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=n3i5UWiyq88Zb6W9ZFw+HRM6PZRMCrqT4gMaa51NZWkWBndnu2bZCULrkuHlCdl72
         D58SqwrWk558W7xpaTCnEn+R8wqD8jtteT8L9mQCRdvz3vwybY7my+96vb1O5C+N0k
         lLyVaVeEkrB1uDYc54yxF4i5btpZtlz5/fSt8Kas=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220608033201epcas2p15b42645a7c039b4d5dd14fe94961466f~2h7Q70ymD0186101861epcas2p1c;
        Wed,  8 Jun 2022 03:32:01 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LHt7h07F2z4x9Q5; Wed,  8 Jun
        2022 03:32:00 +0000 (GMT)
X-AuditID: b6c32a46-f75ff70000002624-49-62a0182f860d
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.EC.09764.F2810A26; Wed,  8 Jun 2022 12:31:59 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v2 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wangseok Lee <wangseok.lee@samsung.com>,
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
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <5ddc30ca-df6d-d31d-e500-2faebc0f32f6@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220608033159epcms2p4e4d4045f2e6493463b59a032a501fc31@epcms2p4>
Date:   Wed, 08 Jun 2022 12:31:59 +0900
X-CMS-MailID: 20220608033159epcms2p4e4d4045f2e6493463b59a032a501fc31
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA12Tf0wTZxjHc3flrjA7T0R8x6LBc7ABA1qg8GrAsc2wG9sS4rK5LNvqQS8t
        o7RNrzXOxVgXQSzOQe026EjphMgsPwQGUgGFlAaQDVycEyFVlECgA+L8MWVUdC0tuuy/z/vN
        932e7/P+4GOh03gEP1+pZTVKRkHhIbyzfTHi+ERgzRWeLIew9is5dDtiYLVzJAh2VdShsPLb
        XzE44zBj8O7hKPjb9DEcus03cHh+rp2A+mOeIOicv4PBnoHTKPy9swqHw5YBHJbZHvDgvGeW
        gCM1+bDovJOA51yDGHT1DfPgUvsjNDOcbrA0IPRoUw5tbdXRrbajOO262o3TU1e+R+mfaw/S
        x9tsCD1wrQOl77Vuzgn5uCBdzjJSVhPJKvNU0nylLIN6533JmxJxqlAUL9oG06hIJVPIZlA7
        382Jz8pXeGekIvcyCp1XymE4jkrcka5R6bRspFzFaTMoVi1VqNPUCRxTyOmUsgQlq90uEgqT
        xF7jngL50IWrhNrUjuyb0DcQeqS7GTEgwXxApoCjdQaeAQnhh5J2BFR2XMQMCJ8vINeBZft6
        n2c9mQ3qDVW4j0NJCtgbLJhfTwSjP5UG+Rgn48HjGjfuqxNGNmGg61oj4VtgpJMHXEceEv5u
        AlBxZJrn5xdBR137SopgcgeYaWsMJHoFLJ76GvPzBjBWv0Cs8u3+6oAnDBTdGA541oGb/3QF
        9AhgnXIE+flL0LPsQf2sR8A3E6xvMOBNbR9N9skC8j3gHL6+EodHRoEn938IlNwJ3Eb7CmNk
        HDj149zKmWBkDDjTmeivshU4x3mrQ+lbPMT/GSOfByV9y091u2UqECYaWE6fw8qQreZnB23+
        Ty/zs15WBLMh4ayaK5SxXJI66ent5qkKW5GV9x6bZUdMC38lOBCUjzgQwMeoMMELu6tzQwVS
        5ov9rEYl0egULOdAxN4py7GIDXkq74dRaiWilG3ClNRUUVqSWJhGbRRkS5uZUFLGaNkCllWz
        mtV9KD84Qo/SOe7FE3Wdn16KTl3QtiiMLfOuKhNaMmdVhx+Y0TzY9cdIM7xYcfjEL0v7xJ78
        frdmsZjwfJjpqs/t/u6zW5d3O590dgS/9tbJSzXXjYNyc7Xu5gc2KzFWe6iIuxs7lvVcU4/N
        PN4wPt/Y4i6R/Dm2ZravfIsi6Y2BNtJqVFYeX+TNmvfkZqc1mSbeFo1appMfTi6+emCqp1by
        +eXZwegU4+v9vZ8ckoCNFZPilpni2oP7h5g1Emqof1hW+nf040230MziC2vvpdx3Oky9CXfO
        RjVzm7f0m3bVSF5aaiqd21QoSpdlfmSAcS/HJPdO7p28Is1eS2jDMzLiztzuVJZVohSPkzOi
        WEzDMf8CUnk8n3gEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603015431epcms2p6203908cebe6a320854136559a32b54cb
References: <5ddc30ca-df6d-d31d-e500-2faebc0f32f6@linaro.org>
        <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
        <20220603023452epcms2p22b81cfd1ee4866d5a6663c089ded6eac@epcms2p2>
        <CGME20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p4>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On=C2=A006/06/2022=C2=A019:25,=C2=A0Krzysztof=C2=A0Kozlowski=C2=A0wrote:=0D=
=0A>=C2=A0On=C2=A003/06/2022=C2=A004:34,=C2=A0Wangseok=C2=A0Lee=C2=A0wrote:=
=0D=0A>>=C2=A0Add=C2=A0support=C2=A0Axis,=C2=A0ARTPEC-8=C2=A0SoC.=0D=0A>>=
=C2=A0ARTPEC-8=C2=A0is=C2=A0the=C2=A0SoC=C2=A0platform=C2=A0of=C2=A0Axis=C2=
=A0Communications.=0D=0A>>=C2=A0This=C2=A0is=C2=A0based=C2=A0on=C2=A0arm64=
=C2=A0and=C2=A0support=C2=A0GEN4=C2=A0&=C2=A02lane.=0D=0A>>=C2=A0This=C2=A0=
PCIe=C2=A0controller=C2=A0is=C2=A0based=C2=A0on=C2=A0DesignWare=C2=A0Hardwa=
re=C2=A0core=0D=0A>>=C2=A0and=C2=A0uses=C2=A0DesignWare=C2=A0core=C2=A0func=
tions=C2=A0to=C2=A0implement=C2=A0the=C2=A0driver.=0D=0A>>=C2=A0=0D=0A>>=C2=
=A0changes=C2=A0since=C2=A0v1=C2=A0:=0D=0A>>=C2=A0improvement=C2=A0review=
=C2=A0comment=C2=A0of=C2=A0Krzysztof=C2=A0on=C2=A0driver=C2=A0code.=0D=0A>>=
=C2=A0-debug=C2=A0messages=C2=A0for=C2=A0probe=C2=A0or=C2=A0other=C2=A0func=
tions.=0D=0A>>=C2=A0-Inconsistent=C2=A0coding=C2=A0style=C2=A0(different=C2=
=A0indentation=C2=A0in=C2=A0structure=C2=A0members).=0D=0A>>=C2=A0-Inconsis=
tent=C2=A0code=C2=A0(artpec8_pcie_get_subsystem_resources()=C2=A0gets=C2=A0=
device=0D=0A>>=C2=A0=C2=A0=C2=A0from=C2=A0pdev=C2=A0and=C2=A0from=C2=A0pci=
=C2=A0so=C2=A0you=C2=A0have=C2=A0two=C2=A0same=C2=A0pointers;=0D=0A>>=C2=A0=
=C2=A0=C2=A0or=C2=A0artpec8_pcie_get_ep_mem_resources()=C2=A0stores=C2=A0de=
v=C2=A0=0D=0A>>=C2=A0=C2=A0=C2=A0as=C2=A0local=C2=A0variable=C2=A0but=C2=A0=
uses=C2=A0instead=C2=A0pdev->dev).=0D=0A>>=C2=A0-Not=C2=A0using=C2=A0devm_p=
latform_ioremap_resource().=0D=0A>>=C2=A0-Printing=C2=A0messages=C2=A0in=C2=
=A0interrupt=C2=A0handlers.=0D=0A>>=C2=A0-Several=C2=A0local/static=C2=A0st=
ructures=C2=A0or=C2=A0array=C2=A0are=C2=A0not=C2=A0const.=0D=0A>>=C2=A0=0D=
=0A>>=C2=A0Signed-off-by:=C2=A0Wangseok=C2=A0Lee=C2=A0<wangseok.lee=40samsu=
ng.com>=0D=0A>>=C2=A0---=0D=0A>>=C2=A0=C2=A0drivers/pci/controller/dwc/Kcon=
fig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A031=C2=A0+=
+=0D=0A>>=C2=A0=C2=A0drivers/pci/controller/dwc/Makefile=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A0=C2=A01=C2=A0+=0D=0A>>=C2=A0=C2=A0dr=
ivers/pci/controller/dwc/pcie-artpec8.c=C2=A0=7C=C2=A0864=C2=A0++++++++++++=
++++++++++++++++++=0D=0A>>=C2=A0=C2=A03=C2=A0files=C2=A0changed,=C2=A0896=
=C2=A0insertions(+)=0D=0A>>=C2=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=A0dr=
ivers/pci/controller/dwc/pcie-artpec8.c=0D=0A>>=C2=A0=0D=0A>>=C2=A0diff=C2=
=A0--git=C2=A0a/drivers/pci/controller/dwc/Kconfig=C2=A0b/drivers/pci/contr=
oller/dwc/Kconfig=0D=0A>>=C2=A0index=C2=A062ce3ab..4aa6da8=C2=A0100644=0D=
=0A>>=C2=A0---=C2=A0a/drivers/pci/controller/dwc/Kconfig=0D=0A>>=C2=A0+++=
=C2=A0b/drivers/pci/controller/dwc/Kconfig=0D=0A>>=C2=A0=40=40=C2=A0-222,6=
=C2=A0+222,37=C2=A0=40=40=C2=A0config=C2=A0PCIE_ARTPEC6_EP=0D=0A>>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Enables=C2=
=A0support=C2=A0for=C2=A0the=C2=A0PCIe=C2=A0controller=C2=A0in=C2=A0the=C2=
=A0ARTPEC-6=C2=A0SoC=C2=A0to=C2=A0work=C2=A0in=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0endpoint=C2=A0mode.=C2=
=A0This=C2=A0uses=C2=A0the=C2=A0DesignWare=C2=A0core.=0D=0A>>=C2=A0=C2=A0=
=0D=0A>>=C2=A0+config=C2=A0PCIE_ARTPEC8=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=22Axis=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0c=
ontroller=22=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+config=C2=A0PCIE_ARTPEC8_HOST=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=22Ax=
is=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0controller=C2=A0Host=C2=A0Mode=22=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends=C2=A0on=C2=
=A0ARCH_ARTPEC=0D=0A>=C2=A0=C2=A0=0D=0A>=C2=A0=7C=7C=C2=A0COMPILE_TEST=0D=
=0A>=C2=A0and=C2=A0test=C2=A0it=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk,=C2=A0I=C2=
=A0will=C2=A0add=C2=A0'COMPILE_TEST'=0D=0AAnd=C2=A0then=C2=A0test.=0D=0A=C2=
=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends=
=C2=A0on=C2=A0PCI_MSI_IRQ_DOMAIN=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0depends=C2=A0on=C2=A0PCI_ENDPOINT=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select=C2=A0PCI_EPF_TEST=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select=C2=A0PCIE_DW_=
HOST=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select=
=C2=A0PCIE_ARTPEC8=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0help=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0Say=C2=A0'Y'=C2=A0here=C2=A0to=C2=A0enable=C2=A0support=C2=A0fo=
r=C2=A0the=C2=A0PCIe=C2=A0controller=C2=A0in=C2=A0the=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ARTPEC-8=C2=A0SoC=C2=
=A0to=C2=A0work=C2=A0in=C2=A0host=C2=A0mode.=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This=C2=A0PCIe=C2=A0controller=
=C2=A0is=C2=A0based=C2=A0on=C2=A0DesignWare=C2=A0Hardware=C2=A0core.=0D=0A>=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0And=C2=
=A0uses=C2=A0DesignWare=C2=A0core=C2=A0functions=C2=A0to=C2=A0implement=C2=
=A0the=C2=A0driver.=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+config=C2=A0PCIE_ARTPEC8_E=
P=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=
=22Axis=C2=A0ARTPEC-8=C2=A0PCIe=C2=A0controller=C2=A0Endpoint=C2=A0Mode=22=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends=C2=
=A0on=C2=A0ARCH_ARTPEC=0D=0A>=C2=A0=0D=0A>=C2=A0=7C=7C=C2=A0COMPILE_TEST=0D=
=0A>=C2=A0and=C2=A0test=C2=A0it=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0A=
Ok,=C2=A0I=C2=A0will=C2=A0add=C2=A0'COMPILE_TEST'=0D=0AAnd=C2=A0then=C2=A0t=
est.=0D=0A=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0depends=C2=A0on=C2=A0PCI_ENDPOINT=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0depends=C2=A0on=C2=A0PCI_ENDPOINT_CONFIGFS=0D=0A=
>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select=C2=A0PCI_EP=
F_TEST=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select=
=C2=A0PCIE_DW_EP=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0select=C2=A0PCIE_ARTPEC8=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0help=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Say=C2=A0'Y'=C2=A0here=C2=A0to=C2=A0enable=C2=A0sup=
port=C2=A0for=C2=A0the=C2=A0PCIe=C2=A0controller=C2=A0in=C2=A0the=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ARTPEC-8=
=C2=A0SoC=C2=A0to=C2=A0work=C2=A0in=C2=A0endpoint=C2=A0mode.=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This=C2=A0PCIe=
=C2=A0controller=C2=A0is=C2=A0based=C2=A0on=C2=A0DesignWare=C2=A0Hardware=
=C2=A0core.=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0And=C2=A0uses=C2=A0DesignWare=C2=A0core=C2=A0functions=C2=A0to=
=C2=A0implement=C2=A0the=C2=A0driver.=0D=0A>>=C2=A0+=0D=0A>>=C2=A0=C2=A0con=
fig=C2=A0PCIE_ROCKCHIP_DW_HOST=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=22Rockchip=C2=A0DesignWare=C2=A0PCIe=C2=
=A0controller=22=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0select=C2=A0PCIE_DW=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/drivers/pc=
i/controller/dwc/Makefile=C2=A0b/drivers/pci/controller/dwc/Makefile=0D=0A>=
>=C2=A0index=C2=A08ba7b67..b361022=C2=A0100644=0D=0A>>=C2=A0---=C2=A0a/driv=
ers/pci/controller/dwc/Makefile=0D=0A>>=C2=A0+++=C2=A0b/drivers/pci/control=
ler/dwc/Makefile=0D=0A>>=C2=A0=40=40=C2=A0-25,6=C2=A0+25,7=C2=A0=40=40=C2=
=A0obj-=24(CONFIG_PCIE_TEGRA194)=C2=A0+=3D=C2=A0pcie-tegra194.o=0D=0A>>=C2=
=A0=C2=A0obj-=24(CONFIG_PCIE_UNIPHIER)=C2=A0+=3D=C2=A0pcie-uniphier.o=0D=0A=
>>=C2=A0=C2=A0obj-=24(CONFIG_PCIE_UNIPHIER_EP)=C2=A0+=3D=C2=A0pcie-uniphier=
-ep.o=0D=0A>>=C2=A0=C2=A0obj-=24(CONFIG_PCIE_VISCONTI_HOST)=C2=A0+=3D=C2=A0=
pcie-visconti.o=0D=0A>>=C2=A0+obj-=24(CONFIG_PCIE_ARTPEC8)=C2=A0+=3D=C2=A0p=
cie-artpec8.o=0D=0A>=C2=A0=0D=0A>=C2=A0This=C2=A0does=C2=A0not=C2=A0look=C2=
=A0properly=C2=A0ordered.=C2=A0Usually=C2=A0entries=C2=A0should=C2=A0not=C2=
=A0be=C2=A0added=0D=0A>=C2=A0at=C2=A0the=C2=A0end.=0D=0A>=C2=A0=0D=0A=C2=A0=
=0D=0AI'll=C2=A0move=C2=A0to=C2=A0the=C2=A0'CONFIG_PCIE_Axxx'.=0D=0A=C2=A0=
=0D=0A>>=C2=A0=C2=A0=0D=0A>>=C2=A0=C2=A0=23=C2=A0The=C2=A0following=C2=A0dr=
ivers=C2=A0are=C2=A0for=C2=A0devices=C2=A0that=C2=A0use=C2=A0the=C2=A0gener=
ic=C2=A0ACPI=0D=0A>>=C2=A0=C2=A0=23=C2=A0pci_root.c=C2=A0driver=C2=A0but=C2=
=A0don't=C2=A0support=C2=A0standard=C2=A0ECAM=C2=A0config=C2=A0access.=0D=
=0A>>=C2=A0diff=C2=A0--git=C2=A0a/drivers/pci/controller/dwc/pcie-artpec8.c=
=C2=A0b/drivers/pci/controller/dwc/pcie-artpec8.c=0D=0A>>=C2=A0new=C2=A0fil=
e=C2=A0mode=C2=A0100644=0D=0A>>=C2=A0index=C2=A00000000..d9ae9bf=0D=0A>>=C2=
=A0---=C2=A0/dev/null=0D=0A>>=C2=A0+++=C2=A0b/drivers/pci/controller/dwc/pc=
ie-artpec8.c=0D=0A>>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,864=C2=A0=40=40=0D=0A>>=
=C2=A0+//=C2=A0SPDX-License-Identifier:=C2=A0GPL-2.0-only=0D=0A>>=C2=A0+/*=
=0D=0A>>=C2=A0+=C2=A0*=C2=A0PCIe=C2=A0controller=C2=A0driver=C2=A0for=C2=A0=
Axis=C2=A0ARTPEC-8=C2=A0SoC=0D=0A>>=C2=A0+=C2=A0*=0D=0A>>=C2=A0+=C2=A0*=C2=
=A0Copyright=C2=A0(C)=C2=A02019=C2=A0Samsung=C2=A0Electronics=C2=A0Co.,=C2=
=A0Ltd.=0D=0A>>=C2=A0+=C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0http://www.samsung.com=
=0D=0A>>=C2=A0+=C2=A0*=0D=0A>>=C2=A0+=C2=A0*=C2=A0Author:=C2=A0Jaeho=C2=A0C=
ho=C2=A0<jaeho79.cho=40samsung.com>=0D=0A>>=C2=A0+=C2=A0*=C2=A0This=C2=A0fi=
le=C2=A0is=C2=A0based=C2=A0on=C2=A0driver/pci/controller/dwc/pci-exynos.c=
=0D=0A>>=C2=A0+=C2=A0*/=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=23include=C2=A0<linux=
/clk.h>=0D=0A>>=C2=A0+=23include=C2=A0<linux/module.h>=0D=0A>>=C2=A0+=23inc=
lude=C2=A0<linux/mfd/syscon.h>=0D=0A>>=C2=A0+=23include=C2=A0<linux/of_devi=
ce.h>=0D=0A>>=C2=A0+=23include=C2=A0<linux/regmap.h>=0D=0A>>=C2=A0+=23inclu=
de=C2=A0<linux/resource.h>=0D=0A>>=C2=A0+=23include=C2=A0<linux/types.h>=0D=
=0A>>=C2=A0+=23include=C2=A0<linux/phy/phy.h>=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=
=23include=C2=A0=22pcie-designware.h=22=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=23def=
ine=C2=A0to_artpec8_pcie(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dev_get_drvdata((x)->dev)=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+/*=C2=A0Gen3=C2=A0Co=
ntrol=C2=A0Register=C2=A0*/=0D=0A>>=C2=A0+=23define=C2=A0PCIE_GEN3_RELATED_=
OFF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00x890=0D=0A>>=C2=A0+/*=C2=A0Disables=C2=A0equilzati=
on=C2=A0feature=C2=A0*/=0D=0A>>=C2=A0+=23define=C2=A0PCIE_GEN3_EQUALIZATION=
_DISABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x1=C2=A0<<=C2=A01=
6)=0D=0A>>=C2=A0+=23define=C2=A0PCIE_GEN3_EQ_PHASE_2_3=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
(0x1=C2=A0<<=C2=A09)=0D=0A>>=C2=A0+=23define=C2=A0PCIE_GEN3_RXEQ_PH01_EN=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0(0x1=C2=A0<<=C2=A012)=0D=0A>>=C2=A0+=23define=C2=A0PCIE_G=
EN3_RXEQ_RGRDLESS_RXTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(0x1=
=C2=A0<<=C2=A013)=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=23define=C2=A0FAST_LINK_MOD=
E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(7)=
=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+/*=C2=A0PCIe=C2=A0ELBI=C2=A0registers=C2=A0*/=
=0D=0A>>=C2=A0+=23define=C2=A0PCIE_IRQ0_STS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x000=0D=0A>>=C2=A0+=23define=C2=A0P=
CIE_IRQ1_STS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A00x004=0D=0A>>=C2=A0+=23define=C2=A0PCIE_IRQ2_STS=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x008=0D=0A>>=C2=A0+=23defi=
ne=C2=A0PCIE_IRQ5_STS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00x00C=0D=0A>>=C2=A0+=23define=C2=A0PCIE_IRQ0_EN=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x010=0D=0A>>=C2=
=A0+=23define=C2=A0PCIE_IRQ1_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A00x014=0D=0A>>=C2=A0+=23define=C2=A0PCIE_IRQ2_EN=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x018=
=0D=0A>>=C2=A0+=23define=C2=A0PCIE_IRQ5_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x01C=0D=0A>>=C2=A0+=23define=C2=A0IRQ_=
MSI_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0BIT(20)=0D=0A>>=C2=A0+=23define=C2=A0PCIE_APP_LTSSM_ENABLE=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A00x054=0D=0A>>=C2=A0+=23define=C2=A0PCIE_ELBI_LTSSM_ENABLE=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00x1=0D=0A>>=C2=A0+=23define=C2=A0PCIE_ELBI_CXPL_DEBUG_00_31=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x2C8=0D=0A>>=C2=A0+=23defi=
ne=C2=A0PCIE_ELBI_CXPL_DEBUG_32_63=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00x2CC=0D=0A>>=C2=A0+=23define=C2=A0PCIE_ELBI_SMLH_LINK_UP=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0BIT(4)=0D=0A>>=C2=A0+=23define=C2=A0PCIE_ARTPEC8_DEVICE_TYPE=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x080=0D=0A>>=C2=A0+=23define=
=C2=A0DEVICE_TYPE_EP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00x0=0D=0A>>=C2=A0+=23define=C2=A0DEVICE_TYPE_LEG_EP=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A00x1=0D=0A>>=C2=A0+=23define=C2=A0DEVICE_TYPE_RC=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x4=0D=0A>>=C2=A0+=23=
define=C2=A0PCIE_ELBI_SLV_AWMISC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x828=0D=0A>>=C2=A0+=
=23define=C2=A0PCIE_ELBI_SLV_ARMISC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x820=0D=0A>>=C2=
=A0+=23define=C2=A0PCIE_ELBI_SLV_DBI_ENABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0BIT(21)=0D=0A>>=C2=A0+=23define=C2=A0LTSSM_STATE_MASK=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A00x3f=0D=0A>>=C2=A0+=23define=C2=A0LTSSM_STATE_L0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x11=0D=0A>>=C2=
=A0+=0D=0A>>=C2=A0+/*=C2=A0FSYS=C2=A0SYSREG=C2=A0Offsets=C2=A0*/=0D=0A>>=C2=
=A0+=23define=C2=A0FSYS_PCIE_CON=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A00x424=0D=0A>>=C2=A0+=23define=C2=A0PCIE_PERSTN=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(5)=
=0D=0A>>=C2=A0+=23define=C2=A0FSYS_PCIE_DBI_ADDR_CON=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
0x428=0D=0A>>=C2=A0+=23define=C2=A0FSYS_PCIE_DBI_ADDR_OVR_CDM=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x00=0D=0A>>=C2=A0+=23define=C2=A0FSYS_=
PCIE_DBI_ADDR_OVR_SHADOW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x1=
2=0D=0A>>=C2=A0+=23define=C2=A0FSYS_PCIE_DBI_ADDR_OVR_ATU=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x36=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+/*=C2=A0PMU=
=C2=A0SYSCON=C2=A0Offsets=C2=A0*/=0D=0A>>=C2=A0+=23define=C2=A0PMU_SYSCON_P=
CIE_ISOLATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x3200=0D=0A>>=
=C2=A0+=0D=0A>>=C2=A0+/*=C2=A0BUS=C2=A0P/S=C2=A0SYSCON=C2=A0Offsets=C2=A0*/=
=0D=0A>>=C2=A0+=23define=C2=A0BUS_SYSCON_BUS_PATH_ENABLE=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+int=C2=A0art=
pec8_pcie_dbi_addr_con=5B=5D=C2=A0=3D=C2=A0=7B=0D=0A>=C2=A0=0D=0A>=C2=A01.=
=C2=A0I=C2=A0think=C2=A0I=C2=A0pointed=C2=A0before=C2=A0the=C2=A0need=C2=A0=
to=C2=A0constify=C2=A0everything=C2=A0which=C2=A0is=C2=A0const.=0D=0A>=C2=
=A02.=C2=A0Missing=C2=A0static=0D=0A>=C2=A03.=C2=A0definitions=C2=A0of=C2=
=A0static=C2=A0variables=C2=A0go=C2=A0after=C2=A0type=C2=A0declarations.=0D=
=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk,=C2=A0i=C2=A0will=C2=A0modify=C2=A0to=C2=A0s=
tatic=C2=A0const=C2=A0type.=0D=0A=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0FSYS_PCIE_DBI_ADDR_CON=0D=0A>>=C2=A0+=7D;=0D=0A>=
>=C2=A0+=0D=0A>>=C2=A0+struct=C2=A0artpec8_pcie=C2=A0=7B=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0dw_pcie=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*pci;=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0clk=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*pipe_clk=
;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=
=A0clk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
*dbi_clk;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str=
uct=C2=A0clk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0*mstr_clk;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0struct=C2=A0clk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0*slv_clk;=0D=0A>=C2=A0=0D=0A>=C2=A0Not=C2=A0really...=C2=A0=
=C2=A0Just=C2=A0use=C2=A0clk_bulk_api.=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk,=C2=
=A0i=C2=A0will=C2=A0modify=C2=A0to=C2=A0use=C2=A0clk_bilk_api.=0D=0A=C2=A0=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const=C2=A0s=
truct=C2=A0artpec8_pcie_pdata=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0*pdata;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vo=
id=C2=A0__iomem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0*elbi_base;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0struct=C2=A0regmap=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0*sysreg;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0struct=C2=A0regmap=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*pmu_syscon;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0regmap=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*bus_s_syscon;=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0regmap=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*bus_p_syscon;=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum=C2=A0dw_pc=
ie_device_mode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mode;=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0link_id;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/*=C2=A0For=C2=A0Generic=C2=A0PHY=C2=A0Framework=C2=
=A0*/=0D=0A>=C2=A0=0D=0A>=C2=A0Skip=C2=A0comment,=C2=A0it's=C2=A0obvious.=
=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk.=0D=0A=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0phy=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*phy;=0D=0A>=C2=A0+=7D;=0D=0A>=
>=C2=A0+=0D=0A>=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0/*=C2=A0fsys=C2=A0sysreg=C2=A0regmap=C2=A0handle=C2=A0*/=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0artpec8_ctrl->sysreg=
=C2=A0=3D=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0syscon_regmap_lookup_by_phandl=
e(dev->of_node,=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=22samsung,fsys-sysreg=22);=0D=0A>=C2=A0=0D=0A>=C2=
=A0NAK.=0D=0A>=C2=A0=0D=0A>=C2=A0Usage=C2=A0of=C2=A0undocumented=C2=A0prope=
rties.=C2=A0Every=C2=A0property=C2=A0must=C2=A0be=C2=A0documented.=0D=0A>=
=C2=A0=0D=0A>=C2=A0Since=C2=A0you=C2=A0do=C2=A0not=C2=A0want=C2=A0to=C2=A0m=
erge=C2=A0it=C2=A0with=C2=A0existing=C2=A0drivers=C2=A0(and=C2=A0more=C2=A0=
people=0D=0A>=C2=A0insist=C2=A0on=C2=A0that:=C2=A0https://lore.kernel.org/a=
ll/Ym+u9yYrV9mxkyWX=40matsya/=C2=A0),=0D=0A>=C2=A0I=C2=A0am=C2=A0actually=
=C2=A0considering=C2=A0to=C2=A0NAK=C2=A0entire=C2=A0set=C2=A0if=C2=A0you=C2=
=A0do=C2=A0not=C2=A0post=C2=A0a=C2=A0user=C2=A0of=0D=0A>=C2=A0this=C2=A0-=
=C2=A0DTS.=C2=A0Mainly=C2=A0because=C2=A0we=C2=A0cannot=C2=A0verify=C2=A0ho=
w=C2=A0does=C2=A0that=C2=A0user=C2=A0look=C2=A0like=0D=0A>=C2=A0and=C2=A0su=
ch=C2=A0changes=C2=A0are=C2=A0sneaked=C2=A0in.=0D=0A>=C2=A0=0D=0A=C2=A0=0D=
=0AOk,=C2=A0sure=C2=A0.=0D=0AI=C2=A0will=C2=A0should=C2=A0be=C2=A0documente=
d=C2=A0the=C2=A0all=C2=A0property=C2=A0include=C2=A0subsystem=C2=A0resource=
.=0D=0A=C2=A0=0D=0A>=C2=A0Best=C2=A0regards,=0D=0A>=C2=A0Krzysztof=C2=A0=0D=
=0A=0D=0AThank=20you=20for=20kindness=20reivew.=0D=0A=0D=0ABest=20regards,=
=0D=0AWangseok=20Lee
