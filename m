Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B85B1BC7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfIMKxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 06:53:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16719 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbfIMKxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Sep 2019 06:53:48 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190913105344epoutp03815c58f610ec167d125a80b0ad4e0001~D_gwHrwD52504925049epoutp03S
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2019 10:53:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190913105344epoutp03815c58f610ec167d125a80b0ad4e0001~D_gwHrwD52504925049epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568372024;
        bh=76g1YBKaFCioZ+UKiXiYnPhsoECHOq4HWCTPvC6iWf4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=VuiXn4gAwMcI+CfCnVXuJ5r+gs5XrZnyASMeut7feft1f8nZ/Cr3JxzukqHBd+g5F
         DyZr8hAYBDsj+CwKHHHlyfziu84JH9DDKb4wHR9HUTkkeQk/O034n8FOQWxZwWC5Xr
         YP8kLxcx+G9ANLH5vXD+3VhGFm+KkDNhuULRix7Q=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20190913105344epcas5p4116bd65bf16919188662f43b85f32d81~D_gvrgrzD1987819878epcas5p4q;
        Fri, 13 Sep 2019 10:53:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.C1.04429.8357B7D5; Fri, 13 Sep 2019 19:53:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20190913105343epcas5p432c6a1e1bee51a1a402d259c05eb1fad~D_gvLMtaT1981519815epcas5p40;
        Fri, 13 Sep 2019 10:53:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190913105343epsmtrp1235804239e4286d5dbb7ba64a5418ef9~D_gvKjXsr1653716537epsmtrp1E;
        Fri, 13 Sep 2019 10:53:43 +0000 (GMT)
X-AuditID: b6c32a4a-655ff7000000114d-b1-5d7b75386126
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.E9.03638.7357B7D5; Fri, 13 Sep 2019 19:53:43 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190913105342epsmtip2fdd4665125d0075ffd7d2a4a19700f4c~D_gt-tPf92994629946epsmtip2q;
        Fri, 13 Sep 2019 10:53:42 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Gustavo Pimentel'" <Gustavo.Pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <jingoohan1@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, "'Anvesh Salveru'" <anvesh.s@samsung.com>
In-Reply-To: <DM6PR12MB4010B4CC5DD11D3607D157ABDAB00@DM6PR12MB4010.namprd12.prod.outlook.com>
Subject: RE: [PATCH 1/2] PCI: dwc: Add support to disable GEN3 equalization
Date:   Fri, 13 Sep 2019 16:23:41 +0530
Message-ID: <002701d56a21$82a4c880$87ee5980$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHkrftp/qePsooAO7EnIOhukMFsOwG9FaICAkQIfYem6t2S8A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3uPiatbtPyqBE5KpiZZlncIntIf4yyDIOQVGzobRPdXJvT
        1D8SM1Ex84Glw2euKbJS5spahqI1H6USKUmgZhhmBoLLfIXFdif53+ec8z18zxcOhYlacW8q
        QZXCalSyJDHhxn/eI5EcZHSZMYfKTduYQWs9zhiyFYx1PI9kmn5VksxHaxXBDNb0EszPte/k
        GVJqqjEh6Uv9OCmtM+ukRZZmJLV02pHUbt59mbjmdjKeTUpIZTWBp667KYr0T3F1qe+tpdUl
        lIWMPgVIQAEdDLbFCbwAuVEi+hWCutIRHlcsILA1dyCu+I3A+LeV2FhpfdJEcIPXCCr6+kmu
        mENQ2PLMqSLoQBharsEd7EGngb3kEVaAKAqjM8FsCXG0BXQMLBosTok7fQEGCktIB/PpfdBe
        O8p3sJA+DrXvPiOOt0N/5bSzj9EHwFg/h3EH7YGVb0aXVSgsD5chTuMJs2/fOG8DeoYA09SY
        a+EcNBavu9gdfvRaSI69YfZ+rouTYbmhFOOWcxCU9Vbj3OA0dI1U8bkwEmixBnJmW+He2jTP
        0QZaCHm5Ik69H5Zm3rusdsHUncc8jqUwaS3HipGvflM0/aZo+k0R9P/N6hC/GXmxaq1SzmqP
        qg+r2LQArUyp1ankAXHJSjNy/pHf+RfIOBTWjWgKibcIGf+MGBEuS9WmK7sRUJjYQ1h0MzNG
        JIyXpWewmuRYjS6J1XYjH4ov9hSW4qPRIlouS2ETWVbNajamPErgnYWi9tbO55XdjU2U7Jg0
        R0NHp3+2LTynvSP0yEp4m+efs4beiCh9AxGa1BjyJe7EFbXg6nrKeOAHTVfbXOvAanYEL3gx
        ciJBof7a0xfWlJ9fMR/x8Fjhgi2SHhYobbezSGn4zoSu6h5earHdILcGVVzMvXHp04OxqElf
        ZIhjvXLEfK1CFuSHabSyfxrPZN5DAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvK55aXWswZJ5WhZndy1ktVjSlGGx
        624Hu8WKLzPZLS7vmsNmcXbecTaLN79fsDuwe6yZt4bRY+esu+weCzaVevRtWcXosWX/Z0aP
        z5vkAtiiuGxSUnMyy1KL9O0SuDL+rLIr2KxQsfbgEqYGxr1SXYycHBICJhIb1q5g62Lk4hAS
        2M0ocWzrf3aIhIzE5NUrWCFsYYmV/56zQxS9ZJQ4+aMRrIhNQF/i3I95YEUiApUSV1a/Ygax
        mQXqJe5OWw419TWjxMqll5lAEpwCsRJfl2wBaxAW8JY41TMRbBCLgKrE9vlXWUBsXgFLifmn
        bzFC2IISJ2c+YYEYqi3R+7CVEcZetvA1M8R1ChI/ny6DOsJJ4sf5yVA14hIvjx5hn8AoPAvJ
        qFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCo0pLawfjiRPx
        hxgFOBiVeHgfaFbFCrEmlhVX5h5ilOBgVhLh7SusjhXiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        K59/LFJIID2xJDU7NbUgtQgmy8TBKdXAKOATsP566P7EhgOH2/PncFb4sO9OC3ih//7z0muR
        78KmTdmR/mR+/OET3+ZO1G76s6siw0HEcu3i0tbnleeai2PqmGN5Vk19ekP59u2fMx41+HFY
        vd9r0XFwnfAFu7k6SyYw//btvZEeenx97J1J8TWN1/zDUiQnsKW1LeD4pFylNUP3056F05VY
        ijMSDbWYi4oTAfrqjrCmAgAA
X-CMS-MailID: 20190913105343epcas5p432c6a1e1bee51a1a402d259c05eb1fad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f
References: <CGME20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f@epcas5p4.samsung.com>
        <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
        <DM6PR12MB4010B4CC5DD11D3607D157ABDAB00@DM6PR12MB4010.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Gustavo Pimentel <Gustavo.Pimentel=40synopsys.com>
> Sent: Thursday, September 12, 2019 7:52 PM
> To: Pankaj Dubey <pankaj.dubey=40samsung.com>; linux-pci=40vger.kernel.or=
g;
> linux-kernel=40vger.kernel.org
> Cc: jingoohan1=40gmail.com; Gustavo.Pimentel=40synopsys.com;
> lorenzo.pieralisi=40arm.com; bhelgaas=40google.com; Anvesh Salveru
> <anvesh.s=40samsung.com>
> Subject: RE: =5BPATCH 1/2=5D PCI: dwc: Add support to disable GEN3 equali=
zation
>=20
> Hi,
>=20
> On Tue, Sep 10, 2019 at 13:25:1, Pankaj Dubey <pankaj.dubey=40samsung.com=
>
> wrote:
>=20
> > From: Anvesh Salveru <anvesh.s=40samsung.com>
> >
> > In some platforms, PCIe PHY may have issues which will prevent linkup
> > to happen in GEN3 or high speed. In case equalization fails, link will
> > fallback to GEN1.
> >
> > Designware controller has support for disabling GEN3 equalization if
> > required. This patch enables the designware driver to disable the PCIe
> > GEN3 equalization by writing into PCIE_PORT_GEN3_RELATED.
>=20
> s/Designware/DesignWare
> s/designware/DesignWare
>=20
> >
> > Platform drivers can disable equalization by setting the dwc_pci_quirk
> > flag DWC_EQUALIZATION_DISABLE.
> >
> > Signed-off-by: Anvesh Salveru <anvesh.s=40samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c =7C 7 +++++++
> > drivers/pci/controller/dwc/pcie-designware.h =7C 7 +++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 7d25102..bf82091 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > =40=40 -466,4 +466,11 =40=40 void dw_pcie_setup(struct dw_pcie *pci)
> >  		break;
> >  	=7D
> >  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > +
> > +	if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
> > +		val =7C=3D PORT_LOGIC_GEN3_EQ_DISABLE;
> > +
> > +	dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> >  =7D
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index ffed084..a1453c5 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > =40=40 -29,6 +29,9 =40=40
> >  =23define LINK_WAIT_MAX_IATU_RETRIES	5
> >  =23define LINK_WAIT_IATU			9
> >
> > +/* Parameters for PCIe Quirks */
> > +=23define DWC_EQUALIZATION_DISABLE	0x1
> > +
> >  /* Synopsys-specific PCIe configuration registers */
> >  =23define PCIE_PORT_LINK_CONTROL		0x710
> >  =23define PORT_LINK_MODE_MASK		GENMASK(21, 16)
> > =40=40 -60,6 +63,9 =40=40
> >  =23define PCIE_MSI_INTR0_MASK		0x82C
> >  =23define PCIE_MSI_INTR0_STATUS		0x830
> >
> > +=23define PCIE_PORT_GEN3_RELATED		0x890
> > +=23define PORT_LOGIC_GEN3_EQ_DISABLE	BIT(16)
> > +
> >  =23define PCIE_ATU_VIEWPORT		0x900
> >  =23define PCIE_ATU_REGION_INBOUND		BIT(31)
> >  =23define PCIE_ATU_REGION_OUTBOUND	0
> > =40=40 -244,6 +250,7 =40=40 struct dw_pcie =7B
> >  	struct dw_pcie_ep	ep;
> >  	const struct dw_pcie_ops *ops;
> >  	unsigned int		version;
> > +	unsigned int		dwc_pci_quirk;
>=20
> I'd prefer called this variable just quirk, the prefix is redundant here.
>=20
> >  =7D;
> >
> >  =23define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie=
,
> > pp)
> > --
> > 2.7.4
>=20
> I understand your idea and I'm fine with it, but I just wonder if there i=
sn't any
> other typical way to do this kind of quirks... I'm not seeing a similar c=
ase to this
> although.

Even we didn't see any existing approach to address this.

> For me makes more sense to squash both patches (1 and 2), since we aim to=
 add
> this quirk especially because it focuses is on this =22GEN3_RELATED=22
> register in a logical patch.
>

Done. Posted =5Bv2=5D where we squashed both the patches.
v2: https://lkml.org/lkml/2019/9/13/171

Thanks for review.
=20
> Regards,
> Gustavo

