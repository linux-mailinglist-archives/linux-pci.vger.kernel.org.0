Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80572E247C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 06:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLXFsa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 00:48:30 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42474 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgLXFs3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 00:48:29 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201224054747epoutp0275b9522a782a698924e9af85e07a5f25~TkPNojofi3203232032epoutp02d
        for <linux-pci@vger.kernel.org>; Thu, 24 Dec 2020 05:47:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201224054747epoutp0275b9522a782a698924e9af85e07a5f25~TkPNojofi3203232032epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1608788867;
        bh=64wMSU7UyI3EEDAyY+AKSnsn1meM9VxgzVzeV5zhgAM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Hwj5NuqcJm8+Rw9Ifgte6dRE4RdnuMEFoS24e6eQAk7qvAynFTyPBcFbFt0K9y2Dd
         8Yw3yJ5CgJRcA48EkUpKG8wuiWdnGpP0JiKRgxj1iG7TUXDZ2SGpL1jHMJ145iGRBW
         sBTCUdlm0bxEcgpst+pq19GKi7eLwJKZ/vpPfcow=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20201224054746epcas5p3cfaa98333aec482b6118957f36da54ce~TkPNIj4DL1530915309epcas5p3i;
        Thu, 24 Dec 2020 05:47:46 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.84.15682.28B24EF5; Thu, 24 Dec 2020 14:47:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20201224053656epcas5p333ff441c532c66667836c32c82b7470c~TkFv_Cmvc3056130561epcas5p33;
        Thu, 24 Dec 2020 05:36:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201224053656epsmtrp17794bcebd039b918ce2a92885f787fa1~TkFv9Hylk0311603116epsmtrp1U;
        Thu, 24 Dec 2020 05:36:56 +0000 (GMT)
X-AuditID: b6c32a49-8d5ff70000013d42-d5-5fe42b824f4c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.7F.08745.8F824EF5; Thu, 24 Dec 2020 14:36:56 +0900 (KST)
Received: from shradhat02 (unknown [107.122.8.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201224053652epsmtip2eddd233ba9a66480faf69e289e8b5e14~TkFruoz1y1413314133epsmtip2C;
        Thu, 24 Dec 2020 05:36:51 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "'PCI'" <linux-pci@vger.kernel.org>,
        "'Jingoo Han'" <jingoohan1@gmail.com>,
        "'Gustavo Pimentel'" <gustavo.pimentel@synopsys.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Pankaj Dubey'" <pankaj.dubey@samsung.com>
In-Reply-To: <CAL_JsqKdzu8EgY-pqxH+ZyDh3ALJGccqgPuj=cc==SGbMvYZJw@mail.gmail.com>
Subject: RE: [PATCH] PCI: dwc: Add upper limit address for outbound iATU
Date:   Thu, 24 Dec 2020 11:06:50 +0530
Message-ID: <095e01d6d9b6$cad59ac0$6080d040$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD+RX98GfriXHZlPUusbE5VD7qwUQIEe2LrAdUrB0urmBJiYA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7bCmum6T9pN4gyld4hZLmjIsdt3tYLdY
        8WUmu8XlXXPYLM7OO85m8eb3C3aLRVu/sFv837OD3YHDY828NYweO2fdZfdYsKnUY9OqTjaP
        vi2rGD227P/M6PF5k1wAexSXTUpqTmZZapG+XQJXxstNXWwF5yQr3r9uYm9gnCncxcjJISFg
        IjFtwhR2EFtIYDejRPMyxi5GLiD7E6PEzIMfWSGcz4wSLx6fZu5i5ADr+L1RDiK+i1Gir3sz
        G4TzglGi/etHsFFsAjoST678YQaxRQRUJZpmPWABKWIW2MokcXnqUzaQBKdAoETTlE9MILaw
        gIfE1YmtLCA2C1BD3/MGsEG8ApYSO7/PZoOwBSVOznwCVsMsoC2xbOFrZogfFCR+Pl3GCrHM
        SeLqw0VMEDXiEi+PHmGHqFnJIbFhuwGE7SKx8+keRghbWOLV8S1QNVISL/vboOx8iakXnrJA
        fFwhsbynDiJsL3HgyhywMLOApsT6XfoQYVmJqafWQW3lk+j9/YQJIs4rsWMejK0s8eXvHhYI
        W1Ji3rHLrBMYlWYheWwWksdmIXlgFsK2BYwsqxglUwuKc9NTi00LDPNSy/WKE3OLS/PS9ZLz
        czcxgtOTlucOxrsPPugdYmTiYDzEKMHBrCTCe4n/cbwQb0piZVVqUX58UWlOavEhRmkOFiVx
        3h0GD+KFBNITS1KzU1MLUotgskwcnFINTPwZx7LK2dWdTP5et2hUXnRd6qpgZFPw5kz3grxd
        3RsYaidvmLnv18/KM9ZRMqybE7U5BeMdeX1eb+LvFdSJPf/J/+1pll/C6XOcL3ByN10S+fbp
        TpPI1UklLyzjFnSdC9npLWD1LHHeniDe0x+ahe4sfKt7MqD97aZb25lFeYMiH2dvuLfg3//S
        qV9ET51nOMNYK1mbJSHu/VNo6u0sHm+lJ2+iVEzbtlqvKPl/xluJmfvImy/CbEySz9f874kM
        XDnX3rls8ffySwFf3pzddDb+hseCL4avTgesNvSdtf1hYVLfQadZp9af2esYYfbtpTRLz4u2
        w9/uqpxxf3mtbF7HrJVWFcYsN14e1Eh0vaDEUpyRaKjFXFScCAA65FBsvgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO4PjSfxBgvPKVosacqw2HW3g91i
        xZeZ7BaXd81hszg77zibxZvfL9gtFm39wm7xf88OdgcOjzXz1jB67Jx1l91jwaZSj02rOtk8
        +rasYvTYsv8zo8fnTXIB7FFcNimpOZllqUX6dglcGc+272QqWChZceP4OeYGxldCXYwcHBIC
        JhK/N8p1MXJxCAnsYJS497adsYuREyguKfH54jomCFtYYuW/5+wQRc8YJWb33mQGSbAJ6Eg8
        ufIHzBYRUJVomvWABaSIWWAnk8TymX0sEB13GCVaXm0HG8UpECjRNOUTmC0s4CFxdWIrC4jN
        AtTd97yBHcTmFbCU2Pl9NhuELShxcuYTsBpmAW2JpzefwtnLFr5mhjhPQeLn02WsEFc4SVx9
        uIgJokZc4uXRI+wTGIVnIRk1C8moWUhGzULSsoCRZRWjZGpBcW56brFhgVFearlecWJucWle
        ul5yfu4mRnCsaWntYNyz6oPeIUYmDsZDjBIczEoivJf4H8cL8aYkVlalFuXHF5XmpBYfYpTm
        YFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwFTY8fx449yVdzbLet6/ZBc7ac/h07Z7L2d1
        f/P3+/jjOfedlq1v+voEp9e4Pmzmr3W6F8v0bWnwfeUtp1ZObNlzi7uXJcDi+sk35sXzJ+S5
        P+zLjvv/yme/aXTStVSbAzevL48+eypgW3m04gnvF21iRnVTPCoCdbO2nL93f07M/kX6ttMT
        4p772Vytzi4Miy+/eW+b/P0uZ+4ZV5PiVTYe+zKp9FvNr9Nv1kVcmMH6wH6qa9bEv+/TGHmm
        WPxZd+HMk2S5UyWvAlkfndW496DyQNGvRVrJj1Qi4u8qRjQqL/tXuypHMGdTL9u7/U6tffLx
        X1vWcPo0b7z+SDZf5HncweaELGOBwLqTto6XNtkosRRnJBpqMRcVJwIAqKLGViQDAAA=
X-CMS-MailID: 20201224053656epcas5p333ff441c532c66667836c32c82b7470c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201218153043epcas5p1831d9bc440e9e05609792f19dfeb4012
References: <CGME20201218153043epcas5p1831d9bc440e9e05609792f19dfeb4012@epcas5p1.samsung.com>
        <1608305434-31685-1-git-send-email-shradha.t@samsung.com>
        <CAL_JsqKdzu8EgY-pqxH+ZyDh3ALJGccqgPuj=cc==SGbMvYZJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Rob Herring <robh=40kernel.org>
> Subject: Re: =5BPATCH=5D PCI: dwc: Add upper limit address for outbound i=
ATU
>=20
> On Sun, Dec 20, 2020 at 6:56 PM Shradha Todi <shradha.t=40samsung.com>
> wrote:
> >
> > The size parameter is unsigned long type which can accept size > 4GB.
> > In that case, the upper limit address must be programmed. Add support
> > to program the upper limit address and set INCREASE_REGION_SIZE in
> > case size > 4GB.
>=20
> Not all DWC h/w versions have the upper register and bit. Is it safe to w=
rite to
> the non-existent register?

Thanks for the review.
Surely it exists post 4.80a version of controller but I am not sure in=20
which version of the controller this was introduced. I can figure this
out from the SNPS team and update the patch accordingly.

>=20
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c =7C 8 ++++++--
> > drivers/pci/controller/dwc/pcie-designware.h =7C 1 +
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 28c56a1..7eba3b2 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > =40=40 -290,12 +290,16 =40=40 static void __dw_pcie_prog_outbound_atu(s=
truct
> dw_pcie *pci, u8 func_no,
> >                            upper_32_bits(cpu_addr));
> >         dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
> >                            lower_32_bits(cpu_addr + size - 1));
> > +       dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
> > +                          upper_32_bits(cpu_addr + size - 1));
>=20
> If not safe, perhaps only write if non-zero.
>=20
Writing zero has no side-affect and we have tested this.

> >         dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
> >                            lower_32_bits(pci_addr));
> >         dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
> >                            upper_32_bits(pci_addr));
> > -       dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type =7C
> > -                          PCIE_ATU_FUNC_NUM(func_no));
> > +       val =3D type =7C PCIE_ATU_FUNC_NUM(func_no);
> > +       val =3D upper_32_bits(size - 1) ?
> > +               val =7C PCIE_ATU_INCREASE_REGION_SIZE : val;
> > +       dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
> >         dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> >
> >         /*
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index b09329b..28b72fb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > =40=40 -106,6 +106,7 =40=40
> >  =23define PCIE_ATU_DEV(x)                        FIELD_PREP(GENMASK(23=
, 19), x)
> >  =23define PCIE_ATU_FUNC(x)               FIELD_PREP(GENMASK(18, 16), x=
)
> >  =23define PCIE_ATU_UPPER_TARGET          0x91C
> > +=23define PCIE_ATU_UPPER_LIMIT           0x924
> >
> >  =23define PCIE_MISC_CONTROL_1_OFF                0x8BC
> >  =23define PCIE_DBI_RO_WR_EN              BIT(0)
> > --
> > 2.7.4
> >

