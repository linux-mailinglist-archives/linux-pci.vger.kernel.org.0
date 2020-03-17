Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5A187E72
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 11:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgCQKgT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 06:36:19 -0400
Received: from mail-eopbgr1400125.outbound.protection.outlook.com ([40.107.140.125]:34336
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgCQKgT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 06:36:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKn25MNWblYsWTtaRQ+dfyynHX3mtbSczcFN1oguAbU/QdVcOMGS3qfo7npjoZwegO3obXy8T2Cm/R9MMjg+NdDkpI3AwqkUsu0X9lHzXceufHBaW7zWJh7m+rm28RxAT+RxAC8cstdTgGFpAagVCRPL7JnBptbwIMLuGEvnM7fyLG75XWCpwRNWGexL6+ZlYpis/O+aCH/+4/imyx4H8jwtlpF++M6fehez9Y5RlHoUNiYCh16GPitoO5m6rR0qOcedeHlBoX7mnl0InAGamzvSQwp54D4s5wDFoM4YzX70jHzeDZi4O3yHIrj1m9NhM+s3sFxlG9lsg0PvS/ExMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uur5A43zlIis658Vag6mGc9U4SZ3N8hynWthYglxrpY=;
 b=J573pYRhjXxz6cr4EQ9MFkrY/piSHNlJ9LAfu9PMI3m6Jlp82f5kYPjFu13aoP+1ybEe9VBVnDBhci8WMNE+78a2OkEBHPdAclO9EkkIOszKI4swloGvfjDc6MH2OswIyC4VPoEVLMzXDleC4KaFFf5fm2v2KTVtN5hp5dp0dXmjijg1Qe86rkHJu430j0E2HeGpgNHKXRkZOgkkxXV7GLu9pdAteEbwVLKCoMUZdobI2xYmP81D2+10GYkYWEs03w9z7bi69h2PMFiYZOOeLnBALbY3uDSO3g0Kwcgi0N+POSo+9AColNCoBinzdlGlzLh+xWqpgl8zJmBNWPW2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uur5A43zlIis658Vag6mGc9U4SZ3N8hynWthYglxrpY=;
 b=Y9Xi4xFyf92TIwC7gimedqS6mr9PN7kjnTouYODAUTWPWp/6zJ8Gzaw8sI8JgI1bXxbVFXeDKHrWVIOvHUxqbuIonzfepb0ClSFxy684KkeDYdKlGrTpWojXeMSxYZ9qvhEQI3BfhJco79MLEGbVTii3wVKIt66FjFwmepbYWGA=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB2662.jpnprd01.prod.outlook.com (52.134.255.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 10:36:13 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 10:36:12 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
CC:     Andrew Murray <andrew.murray@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: RE: [PATCH v5 7/7] misc: pci_endpoint_test: Add Device ID for RZ/G2E
 PCIe controller
Thread-Topic: [PATCH v5 7/7] misc: pci_endpoint_test: Add Device ID for RZ/G2E
 PCIe controller
Thread-Index: AQHV7k2qHnZcas9owkCCufgdtXIhrqhMsfcAgAAA1TA=
Date:   Tue, 17 Mar 2020 10:36:12 +0000
Message-ID: <OSBPR01MB3590DA5CDC8DF1B618B0AA34AAF60@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228154122.14164-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB45441E4766FD57506A5B9F98D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45441E4766FD57506A5B9F98D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.mahadev-lad.rj@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 417486e6-7007-4090-8ec5-08d7ca5f03b0
x-ms-traffictypediagnostic: OSBPR01MB2662:|OSBPR01MB2662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB266246D624F7611F628DC645AAF60@OSBPR01MB2662.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(316002)(26005)(110136005)(52536014)(5660300002)(66946007)(86362001)(64756008)(81166006)(66446008)(66476007)(81156014)(66556008)(186003)(2906002)(7416002)(76116006)(33656002)(53546011)(6506007)(8936002)(478600001)(7696005)(9686003)(54906003)(4326008)(55016002)(71200400001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2662;H:OSBPR01MB3590.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XR8rIn7GMNL4pne/aHHfzP1Lw7O3F/XMP8dw1XbaLQ1JVzYqpybJvpzdKcz4+CeLgYtwTGrXd7gNWUYiC5JBHJvXRqHK+lI8VoPUpjM6oI94OpqbnYJQLmvm/dHyriIU+WNMtjeiU5ouagtfgYTuoFJv0W/Lrb2tMQLkbHBJjTtMQj9KIJy+hQtDzEEJ2bV12pnJJ1ZVtVUvZTZWH7t8goM+mYZvjov1fOrxKmueQQiqnYqFzTkJ1V9W4ALVMLy+U868Au6ui7sVMx5BF0jGDD2BijCqBC61SyObj6TplqKAU+aN+GwYUOk5cFG58Q/R/zldXFARgt/ExwZSBOWf8J6T/qLH369qdPUsY7DvGCiSRS/2SJsEkDvSsW87zKeTKPlc7TMBs9JwpvhI9UFH5IwKSn9hRUx3PaQvf5R/RSTULbnlmMAlLrvACI5iXLsU
x-ms-exchange-antispam-messagedata: 1EsQNu/6793dt86AJ2FVXrO0TEgUs6Sxw+q7mY7dZ4v05flbrg8CnlAraN5XKPelGzHxQSVJXL+zCy8l1he5SxG8Q3IvA8VegsfPvOWmo2R5m6/wNjP/00xp7DZeG3tMN33E5PvZ8Ji5K/VKB8H1Ww==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417486e6-7007-4090-8ec5-08d7ca5f03b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 10:36:12.6242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zijk8rJbZRMsYr+paqqg4EsOB3s7zvIAuikfWRJ7OmmPhQ3z4hIuaXRpdZGtb19h6ojUpwrgddCa2K5H358O+5XZ+jlwm9mx2Bt4g9U+uOIPRp+rq3R0vx/UiljEPtIK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2662
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro,

Thank you for the review.

> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: 17 March 2020 10:32
> To: Lad Prabhakar <prabhakar.csengg@gmail.com>
> Cc: Andrew Murray <andrew.murray@arm.com>; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-renesas-soc@vger.kernel.org;
> linux-rockchip@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; Bjorn Helgaas <bhelgaas@google.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Arnd Bergmann <arnd@arndb.de>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Jingoo Han
> <jingoohan1@gmail.com>; Gustavo Pimentel
> <gustavo.pimentel@synopsys.com>; Marek Vasut
> <marek.vasut+renesas@gmail.com>; Shawn Lin <shawn.lin@rock-
> chips.com>; Heiko Stuebner <heiko@sntech.de>
> Subject: RE: [PATCH v5 7/7] misc: pci_endpoint_test: Add Device ID for
> RZ/G2E PCIe controller
>
> Hi Prabhakar-san,
>
> Thank you for the patch!
>
> > From: Lad Prabhakar, Sent: Saturday, February 29, 2020 12:41 AM
> >
> > Add RZ/G2E in pci_device_id table so that pci-epf-test can be used for
> > testing PCIe EP in RZ/G2E.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c
> > b/drivers/misc/pci_endpoint_test.c
> > index a5e3170..3c84e9a 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -66,6 +66,8 @@
> >
> >  #define PCI_DEVICE_ID_TI_AM6540xb00c
> >
> > +#define PCI_DEVICE_ID_RENESAS_RZG2E0x002d
>
> This define should be in include/linux/pci_ids.h, and adding the define
> should be separated.
> Also, I think "R8A774C0" is better than "RZG2E".
>
Agreed will add it under PCI_VENDOR_ID_RENESAS.

Cheers,
--Prabhakar

> Best regards,
> Yoshihiro Shimoda
>
> >  #define is_am654_pci_dev(pdev)\
> >  ((pdev)->device =3D=3D PCI_DEVICE_ID_TI_AM654)
> >
> > @@ -797,6 +799,7 @@ static const struct pci_device_id
> pci_endpoint_test_tbl[] =3D {
> >  { PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
> >    .driver_data =3D (kernel_ulong_t)&am654_data
> >  },
> > +{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS,
> PCI_DEVICE_ID_RENESAS_RZG2E) },
> >  { }
> >  };
> >  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> > --
> > 2.7.4



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647
