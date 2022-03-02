Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F904CAD8B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 19:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbiCBS3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 13:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiCBS3n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 13:29:43 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6E3C7D62;
        Wed,  2 Mar 2022 10:28:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJVypxw/Cet4dnH6kPx2sHQP7jVGxADoxi1XCjbUmtXfVGbcLSqaCHLY6oQ76KZ9Z8OdEwaZSLT/IVFhH1eJ7dKVjRC8UxbIag4gtimiBxBmAKuja5C8fivwtWbtFbeK8w2mW8T56myGImqdq4nEudGt4bCxVHfgv/anRRpvEdTAfv1+RtEhpaVEzElmEJwl0pzrXFVYeXB87GeKN+9bN9jYNIMM5MUP8Ntha5gpzidAcdxabbo7EeaKfQ9Nyjg/+bbdoQFo1pXe+Ixv2zt6NO8VOHfPlw1x4AZfZofF25b4qrVk2+2xtmrOfNtI4rtexyBSkT5baXQ/xynXbBYoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4y/VJB1SCEfFH90j3mEFLogliA1vFVbIkhQAxdeQLY=;
 b=f+vz5HN353OSq3aDmM3ijSMBdwnQSoaHwWliY+2homFm82+Up7LBm0Cbtdc0wjz63Ud5P2+gsOoV6XboFasl3qo691rZQAraZ7Cs7Y6IK8ud1+WSjQHAOuLZvKU4/3VsBtDkUr1SZid2gflBQ8nDMQmpOjE+kuuK5X1vH43Coe0yeWaehRr55EaNXLoy2qGxQQjz5N87X+Sorg76v8wC2qp53CkKDQxKeYFtJr49Pc4/+Eu977OvsqSXSvbLcC/0tdtFeNaBElngNEZYIashVSgi9i4P+e7/rqR3kM2qVU8YB49C0yKILj5RV2W9o0NONxbHUnuHAVvIc4eV+U0aZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4y/VJB1SCEfFH90j3mEFLogliA1vFVbIkhQAxdeQLY=;
 b=jtc05mo4xhMhU8F9uTfNKcP4jiBFs35hqkzmX6Jn5h3krAf8cz66MyNOonIuFTk2f64mWY952NGPHZoei49SG0xwe//qICwSCdnCnMBmtm1MroX8PFIWxqNPFIxXq3pIsvSpKg1uyecj2+otYcOaLSIiVuRmtco9Ribk2l+qBuo=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR0402MB3472.eurprd04.prod.outlook.com (2603:10a6:803:a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 18:28:53 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%6]) with mapi id 15.20.5017.028; Wed, 2 Mar 2022
 18:28:53 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [EXT] Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC
 handling and driver update for R-Car PCIe EP to support DMAC
Thread-Topic: [EXT] Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC
 handling and driver update for R-Car PCIe EP to support DMAC
Thread-Index: AdguS7LYnJjb3WdWSa+29EVG6gHCPgADcQaAAAIaqDA=
Date:   Wed, 2 Mar 2022 18:28:53 +0000
Message-ID: <PAXPR04MB91866AB1474C9F9F2CB15B7A88039@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <PAXPR04MB9186D7B361F9FFE56A0AE69C88039@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <CA+V-a8t2=MRObzdjHM9OUE8LzQXqoiLo-T+D3i1fLAOaneESpw@mail.gmail.com>
In-Reply-To: <CA+V-a8t2=MRObzdjHM9OUE8LzQXqoiLo-T+D3i1fLAOaneESpw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86e52fab-b56b-4f9a-eddf-08d9fc7a813d
x-ms-traffictypediagnostic: VI1PR0402MB3472:EE_
x-microsoft-antispam-prvs: <VI1PR0402MB34727F697D87C86C73E6B81188039@VI1PR0402MB3472.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /o3j/3+0u7EBbS7wW2pw6ZW/shZJjQcuIv6P0vtOKoiWZp9knzWCBEsiejHqjyTHhesYQrPnP6vrY1JCkwcnbioPkX7REBpUFxIYmlcetosiHX4PV18ao9/qmOs7mhih0VRLL35s1JzuLuZ+OET/P/psaJ4fh/XtGWoLxJ9aiDBz9pekF1LiZuQPcYc1ukZLI9aeh4y7ImpXCA6l6r/GG8VSbIiiB5f1R4GSwjVLYnXKt4rrvN3BRRmAVATAm9hDedF9737uiBU/gULGl55eh4B1NigCvlPBs+VUIvsmbqzoRk0Jzz5K5wJoyF5e/tDgSPZJvZLh/9dFrtqc47T6jglIg9FpypHsUpSt8nfXja50pYaMSP/irlLaOZAqOxGNTyXQ13eartIbJ0C9/ZRFgY6WMBeADL1pQQl5ey62iIgRlRTMLNPMNv/IAgUdHkcR6GbVeVhOzF1oLwi8mY25+v+wFce5XYM9Kpamfm/VeqiXf9H0KQTd/eIBoOtNSxEudmsLytCsk0zbR0VqYNXcQ7vKrAUFbFnHGGhdYMNqpLXm1QReDvSqFaB4LKjKd5k62gq/Z3H3aVjUa9hyhCHTW14VPtIwtVqI1WyO1tFvg8pEaE10pWE1Ss5/JtweOU0p6OYoKlrYQVxTChnPm2RuGonot5Ds89ioWo7OQS4k7fRcFr7+aXymYMoP/7zB5SNPcsim0InhfVEhbgCVXC49foIJap/141WQ9PXKS1MU04Nn8a8q7Jzk/AaIBJeuDiCadwoN0NP1U6o6FSeZduvV/5UK45jcykNvOml+uNfmXU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(64756008)(55016003)(71200400001)(38070700005)(15650500001)(66476007)(26005)(66446008)(66946007)(186003)(66556008)(86362001)(122000001)(966005)(33656002)(45080400002)(498600001)(9686003)(52536014)(6916009)(5660300002)(54906003)(7416002)(8936002)(53546011)(55236004)(83380400001)(44832011)(2906002)(66574015)(7696005)(6506007)(38100700002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?g127Dl6aVsL2jNW/VVvrQ0oNBpESGa5qs5nzsY5qy9WfrhzxHemXLcocZy?=
 =?iso-8859-2?Q?q3MetmB/bNXIVhuWqKWzz5xaYK6qtJeynYkApJYdF+KPkbRQf8mFjUHfcY?=
 =?iso-8859-2?Q?Gpl0FVp6f3IxbGC9/CZo+ofLPZGowIXhdYS7QCFqj3Xhw36LW6uo2ZcZDr?=
 =?iso-8859-2?Q?eDHaP+hQ5TDfvbThqRm4lSDZM3d6QcLRnpwo4b5JzY1wPsav2GPYWwIGLd?=
 =?iso-8859-2?Q?ZssD6JisZ0xcImFtqOqKffzvjYv8mQR+VbeE96OCVwjsGAldChoPC+8V8Z?=
 =?iso-8859-2?Q?hKNYzPcSMsyPWdWYVikicD6fCK08G289L/EzvF/u95GOL+P8k4BtxOfCr0?=
 =?iso-8859-2?Q?oC2syGgCSCbwmfXWT7UUDn+t5eHHXOBioAMHkpboVOF2ufu37iYJ8apbrs?=
 =?iso-8859-2?Q?qlnjimzxkf2yYRxo90b55P0/cBmswBVwUy1YAHU4ndgXq+kpJeYDpn+DxU?=
 =?iso-8859-2?Q?XXOhJaTGFIacTvmtYG7+riWZkgay9WA/Ak5fzry4j6yBwWobWCc+uTPef1?=
 =?iso-8859-2?Q?Tss6J3kkyxFX3BXSyhc0jTe6NoDDymuWCHJjOFGr7exRlfPqt7SYa/Ws1z?=
 =?iso-8859-2?Q?yqoDzN/LnK5POWY5o/DSxVQLR0UZ3EsNYo+b971zCBDF5GDtH+DW7TzQzN?=
 =?iso-8859-2?Q?Wo+X5j6xPXb1PEHGFAsWVaXdxDDA1uM7TxM1fn/ckmpSAd7HKD+gSC/g8f?=
 =?iso-8859-2?Q?d0et5fFVtv92jLMfgtUroox5Ao3FzSRG+WJOXhsSLQ0l8sj4Pi0de+xcMg?=
 =?iso-8859-2?Q?X5os2Ei2usMoBfRhqOM3nhddj3BVHsbpzkcEMO6ynlpE+wEfLyb9sL6d4p?=
 =?iso-8859-2?Q?TgOWECFVjFqxr+QfJ1One4TwxcTqgRnTKwfE8Imxv1yzv+poP+wXesJqHg?=
 =?iso-8859-2?Q?7b7lFWDNWUR3fbSUZ/TcJXj+yZfpDmiLF9I+EzRiHe35QagvvZ0xfauegw?=
 =?iso-8859-2?Q?7nwJ3gQZ9kOkpXmJHLaXDUKirV/j9v2HX2/VkuoFWvUwKMbBJ6IxQAfCjo?=
 =?iso-8859-2?Q?lZ/QAAOY/3IyDDjpyld85P8bAVqgKT5e/CCQ0MEQWHPoHX1YV/Yyzpxjv6?=
 =?iso-8859-2?Q?eYCJmfK949OSxPDCJXxLCV0pWndGZAcLhKr88vqRX+l2fIsA2wBHvEeVBG?=
 =?iso-8859-2?Q?Lw46D6VlmrYCtI4+ke7gFN3OF8Gk0m2Cc3xL6qg8SrrDbyTpJ4pxrpk/WA?=
 =?iso-8859-2?Q?8AnN9j7f6uKCGbqUyYYr49gNrCpmp306x4+mqqAp0p9kNOLTmZp1mbEBjb?=
 =?iso-8859-2?Q?KABSxmTZEMZ4xsttFMAmsiTJzd5MlWXO+a5WjD0UTeCtpBydi6opzZGDQW?=
 =?iso-8859-2?Q?Wk6Al2i4lziwrxx8D96I4jI6jYFYdLXZpxgJmXDnoYJ63mfsDLbxcLe/IE?=
 =?iso-8859-2?Q?5HYleEJMHpAqrntPlZY+3DslU/YhAp0kvNMhnaWD7Rtz7Pvhb4whrU4BvP?=
 =?iso-8859-2?Q?szTaA7fWljfimHNWtTqR8fWAZXDl8g0HM//ixxHPynxxSu0tuzt6+voAGF?=
 =?iso-8859-2?Q?FP1TTgoPtkBAenz0i343ePSu5d1hnb0YrinUfIqf6+XI2bdRY5alM6iCdW?=
 =?iso-8859-2?Q?/vaLECD7Yw/SbBjcP0kw2sVHii6E/8RjLCM9YdkAKBRgUBDuIhJRFiHqPm?=
 =?iso-8859-2?Q?3KTqAkX1hIFx/CD7EWjd1sdyfIvCbCDQ7KIByQ3vv6zlqPvSutJGofIiuA?=
 =?iso-8859-2?Q?Eff0VhudTnPwXy90hoY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e52fab-b56b-4f9a-eddf-08d9fc7a813d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 18:28:53.3227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZxorkoKOLFNgzLS0nE6XOrszsuX6F0RGvFCG6/1kSR5jPylTh54tBNXqI/Me8Z2qAIjaloA5AXdRaD71/jwaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Sent: Wednesday, March 2, 2022 11:18 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Lad Prabhak=
ar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Kishon Vijay Abraham I
> <kishon@ti.com>; Bjorn Helgaas <bhelgaas@google.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Krzysztof Wilczy=F1ski <kw@linux.com>; Arnd
> Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
;
> Marek Vasut <marek.vasut+renesas@gmail.com>; Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com>; Rob Herring <robh@kernel.org>; linux-
> pci <linux-pci@vger.kernel.org>; Linux-Renesas <linux-renesas-
> soc@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: [EXT] Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC
> handling and driver update for R-Car PCIe EP to support DMAC
>=20
> Caution: EXT Email
>=20
> Hi Frank,
>=20
> On Wed, Mar 2, 2022 at 3:42 PM Frank Li <frank.li@nxp.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > > Sent: Thursday, February 10, 2022 3:24 AM
> > > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>; Kishon
> Vijay
> > > Abraham I <kishon@ti.com>; Bjorn Helgaas <bhelgaas@google.com>; Loren=
zo
> > > Pieralisi <lorenzo.pieralisi@arm.com>; Krzysztof Wilczy=F1ski
> <kw@linux.com>;
> > > Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org>; Marek Vasut
> <marek.vasut+renesas@gmail.com>;
> > > Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>; Rob Herring
> > > <robh@kernel.org>; linux-pci <linux-pci@vger.kernel.org>; Linux-Renes=
as
> > > <linux-renesas-soc@vger.kernel.org>; LKML <linux-
> kernel@vger.kernel.org>;
> > > Biju Das <biju.das.jz@bp.renesas.com>
> > > Subject: [EXT] Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC
> > > handling and driver update for R-Car PCIe EP to support DMAC
> >
> > I use standard DMA engine API to implement Designware PCIE EP embedded
> DMA support.
> > Please check
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Fall%2F20220302032646.3793-3-
> Frank.Li%40nxp.com%2FT%2F&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C0e2e5=
fe8f
> d224076afb208d9fc70aa16%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378=
18
> 383096028914%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi=
LC
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DDCDX%2BYEVFsPOE6ZWzwrMxk1=
Fjlk
> ZA%2FEPGmhQSHuPB2c%3D&amp;reserved=3D0
> >
> Thank you for the link. The Designware PCIE EP is implemented as a DMA
> engine driver so it's convenient to use the DMA engine API, whereas
> the R-Car PCIe-EP is implemented as an actual PCIe EP [0].

My means, needn't add new interface pci_epf_internal_dmac_xfr at epc/epf.
Your R-Car PCI-EP DMA part can implement as a dma engine driver like design=
ware.

So EP functional driver use the same method to operate DMA regardless
EP controller type.=20

Best regards
Frank Li=20

>=20
> [0]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
erne
> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-
> next.git%2Ftree%2FDocumentation%2Fdevicetree%2Fbindings%2Fpci%2Frcar-pci-
> ep.yaml%3Fh%3Dnext-
> 20220302&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C0e2e5fe8fd224076afb208=
d9fc
> 70aa16%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637818383096028914%7C=
Un
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJ
> XVCI6Mn0%3D%7C3000&amp;sdata=3Dv96I5m%2BsjozpFVLHgY4VE5H59r9cyG%2F%2FVDUX=
PHKT
> 2Sw%3D&amp;reserved=3D0
>=20
> Cheers,
> Prabhakar
>=20
>=20
> > Best regards
> > Frank Li
> >
> > >
> > > Caution: EXT Email
> > >
> > > Hi,
> > >
> > > On Thu, Feb 10, 2022 at 8:40 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Jan 26, 2022 at 07:50:38PM +0000, Lad Prabhakar wrote:
> > > > > Hi All,
> > > > >
> > > > > The current PCIe EPF framework supports DMA data transfers using
> > > external
> > > > > DMA only, this patch series aims to add support for platforms
> > > supporting
> > > > > internal DMAC on PCIe for data transfers.
> > > > >
> > > > > R-Car PCIe supports internal DMAC to transfer data between Intern=
al
> Bus
> > > to
> > > > > PCI Express and vice versa. Last patch fills up the required flag=
s
> and
> > > ops
> > > > > to support internal DMAC.
> > > > >
> > > > > Patches 1-3 are for PCIe EPF core to support internal DMAC handli=
ng,
> > > patch
> > > > > 4/5 is to fix test cases based on the conversation [1].
> > > > >
> > > >
> > > > This looks similar to the Synopsys eDMA IP [1] that goes with the
> > > Synopsys PCIe
> > > > endpoint IP. Why can't you represent it as a dmaengine driver and u=
se
> the
> > > > existing DMA support?
> > > >
> > > Let me have a look. Could you please share a link to the Synopsys PCI=
e
> > > endpoint HW manual (the driver doesn't have a binding doc).
> > >
> > > Cheers,
> > > Prabhakar
> > >
> > > > [1]
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
erne
> %2F&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C0e2e5fe8fd224076afb208d9fc7=
0aa1
> 6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637818383096028914%7CUnkno=
wn
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6
> Mn0%3D%7C3000&amp;sdata=3D7OMZZxDki3KkquGWF7B7PFDDciohJOEUFuDXSd50avc%3D&=
amp;
> reserved=3D0
> > >
> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2F=
dr
> > > ivers%2Fdma%2Fdw-
> > >
> edma&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C95a5831aac544de2211508d9ec=
772f
> > >
> 9a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637800819106821404%7CUnkn=
ow
> > >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI
> > >
> 6Mn0%3D%7C3000&amp;sdata=3DyG39L2YBN9blGxTcXyVQwIXol8%2FCo%2FZ3GbGPIlqz6M=
g%3D
> > > &amp;reserved=3D0
> > > >
> > > > > Patches are based on top of [1] next branch.
> > > > >
> > > > > [0]
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.s=
pini
> %2F&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C0e2e5fe8fd224076afb208d9fc7=
0aa1
> 6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637818383096028914%7CUnkno=
wn
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6
> Mn0%3D%7C3000&amp;sdata=3DjlSMhNop8XtntmY%2FwySkwQDUd02i3ihhMtOmEesnwyg%3=
D&am
> p;reserved=3D0
> > > cs.net%2Flists%2Flinux-
> > >
> pci%2Fmsg92385.html&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C95a5831aac5=
44de
> > >
> 2211508d9ec772f9a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6378008191=
06
> > >
> 821404%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6
> > >
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DieX2gSSHFDumc1k2iWoOfMyHg236aJT=
E7UZ
> > > 5D74D9KM%3D&amp;reserved=3D0
> > > > > [1]
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
erne
> %2F&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C0e2e5fe8fd224076afb208d9fc7=
0aa1
> 6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637818383096028914%7CUnkno=
wn
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6
> Mn0%3D%7C3000&amp;sdata=3D7OMZZxDki3KkquGWF7B7PFDDciohJOEUFuDXSd50avc%3D&=
amp;
> reserved=3D0
> > >
> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fhelgaas%2Fpci.git&amp;data=3D0=
4%7C
> > >
> 01%7Cfrank.li%40nxp.com%7C95a5831aac544de2211508d9ec772f9a%7C686ea1d3bc2b=
4c
> > >
> 6fa92cd99c5c301635%7C0%7C0%7C637800819106821404%7CUnknown%7CTWFpbGZsb3d8e=
yJ
> > >
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am=
p;
> > > sdata=3DQc5cW6y5OrxprDjFQ1dNMZ4ZUc656I3FZqClaUMLx%2FM%3D&amp;reserved=
=3D0
> > > > >
> > > > > Cheers,
> > > > > Prabhakar
> > > > >
> > > > > Lad Prabhakar (5):
> > > > >   PCI: endpoint: Add ops and flag to support internal DMAC
> > > > >   PCI: endpoint: Add support to data transfer using internal dmac
> > > > >   misc: pci_endpoint_test: Add driver data for Renesas RZ/G2{EHMN=
}
> > > > >   misc: pci_endpoint_test: Add support to pass flags for buffer
> > > > >     allocation
> > > > >   PCI: rcar-ep: Add support for DMAC
> > > > >
> > > > >  drivers/misc/pci_endpoint_test.c              |  56 ++++-
> > > > >  drivers/pci/controller/pcie-rcar-ep.c         | 227
> ++++++++++++++++++
> > > > >  drivers/pci/controller/pcie-rcar.h            |  23 ++
> > > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 184 ++++++++++--=
--
> > > > >  drivers/pci/endpoint/pci-epf-core.c           |  32 +++
> > > > >  include/linux/pci-epc.h                       |   8 +
> > > > >  include/linux/pci-epf.h                       |   7 +
> > > > >  7 files changed, 483 insertions(+), 54 deletions(-)
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
