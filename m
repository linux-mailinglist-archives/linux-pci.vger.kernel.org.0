Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2FA3DE66D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhHCF6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 01:58:22 -0400
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:48864
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233839AbhHCF6V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 01:58:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CepS2Dhvti8ozONCzjJkYnVYyFOXeh8ruycB/XPr1UsdeaRnmZOYgLFTtHbtFIDKipOF0p14QohBMj7dvU8DwcHupoBQ6lWdE2rMRY1p82pDFRxKbZH15ClqeF5jIDYjkz+x0iug5nEzsH83dsVwKq90vqgVB37N3jrJW6XwyWFB0V37PiaOMP8OqWrMa43hQE74ZcMJY6cBzjkFuPnhSXJkgHty+UEvObVZHFAizCoDEM1QLAyqvM4JT7YqQsiRrOGrgWUev8o38qA1I0LOQwVW9t0sU8X4s1MiV30ny+Gu461nraCHJioHX9q19I00OhN2e510YQRUc4R31FHqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrQiZl1Pz97N0jQyjxdvHkasMCCNfaKy3BwFEMJoAOY=;
 b=fCkED2NL1STTru/MZi/jX2qGHx6lHUnD3q/AHhk1Ur1CPoYBnyWU2rAkFIAUavmHk0xPGSmaRsdfrdejbQnh+jc2PrtS1up07Z1+di7A0m82fzDGn7LWQEAHJ3y4pufYOSc7bbjvnCCy9tWOGYyzdGEM8q+43Xrh5gsiA8mpzy6iD7Hz7bE9F7s9QUks92ZqNyJtDcFm551n++ej+MAnWT4uBFNbVBtd0ca+8RZKBBN2gnbGZr0NqSV59fIKt7UIeZigiOp73BxCnOA8gL2maOBGPs5yCCcR/gzw6mbatxIvqOHVuRmy6umgrGoBmgYLymNT/MKx63AG97SzACGB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrQiZl1Pz97N0jQyjxdvHkasMCCNfaKy3BwFEMJoAOY=;
 b=GhjV6iLwk4TZUOcyIYI22O6Kuf6bl5/RZdqbT4WymrCeAxA3SOdh99OPBCnkC7SHKs2e9MEuFhcznPcilKtg5OA113XHlqgoWM1FoEjR0UGxusfg+VfdQuSd4nCDlrs0atUfpOvhdDeb3/ng+lmAiVwAwJIrd6Pgz3VNt62S1tk=
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9)
 by DU2PR04MB8758.eurprd04.prod.outlook.com (2603:10a6:10:2e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 05:58:09 +0000
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4]) by DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 05:58:08 +0000
From:   "Wasim Khan (OSS)" <wasim.khan@oss.nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Wasim Khan (OSS)" <wasim.khan@oss.nxp.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH v2] PCI: Add ACS quirk for NXP LX2160 and LX2162 C/E/N
 platforms
Thread-Topic: [PATCH v2] PCI: Add ACS quirk for NXP LX2160 and LX2162 C/E/N
 platforms
Thread-Index: AQHXh7cFKOZKp7QqQEes/qfC0L8GMqtgYL0AgADoZ/A=
Date:   Tue, 3 Aug 2021 05:58:08 +0000
Message-ID: <DU2PR04MB8726E7690B48B101D8D0F0AB90F09@DU2PR04MB8726.eurprd04.prod.outlook.com>
References: <20210802155644.3089929-1-wasim.khan@oss.nxp.com>
 <20210802160434.GA1383714@bjorn-Precision-5520>
In-Reply-To: <20210802160434.GA1383714@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6408b34b-724c-4e2e-a218-08d95643ab78
x-ms-traffictypediagnostic: DU2PR04MB8758:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DU2PR04MB8758F1E0D0C963C0572C4C08D1F09@DU2PR04MB8758.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zw7eDrfgKxZWPaxuTLt1wjvZHUnHOG1em08tase5jbxPbI23/1xkDxgMF1HAFj/Jm6+8n24D3PSJIVvTEAyvdyEg6jycZZjouP6R7YDSXWeNtcVBs5lE7171V/j5hrr7sw/APIRXT9AbiBmwS8SMs5pxwbHJkCuZLvV7tUVYZPZP5ceWif/xkQMTOy9+UBquKmDMr3FcqQDdYO2aVs7NKppowX28T+QF5Cip7NI2Zs8BjDab8HxclCch3YS6vn8IUjZY5jBJgafRcRhiRILwB36sa6MFdUK3/J7EID0OjI/LSU2gatTu0ctul9UHtoJoeG3Goh8cQhA2VmTgkCjFctf+cF9tF5Gm9ksuKIVLfiRc2FUbnFwJp81VdECkeebu92nBnaKbNB6ET7kVzRJVJkltg5II3XqFy4kM7za6QPQtbc37YZsOBysxpnRDVqhnLF7xCSH5sxuPnw450csPi+Sdtns60vp6+ERTa2IspqK4Xv7AnoyW7B5hB4X6eecYnUmhgYxyHshWIe3I9NY/w5xKLUchCg7Xx3K5Cqxtf3ng7uuO1WBvu5zMVPU0Y8RLigZiH1ZAZX7msZF8JPbtVFA186yZi37mrRXaC80gjwb1EQSlHz/b+cHoPkV01sUqhHWWh8lydDNiehgLkj5p6NK4XqsoSbra3GXGiLQ8ioTWi7Jxp6AGRFU6jQV717i5q7+ek90uhHoaH3pIBYSDag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8726.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(83380400001)(4326008)(71200400001)(478600001)(76116006)(8936002)(316002)(86362001)(33656002)(38070700005)(5660300002)(7696005)(38100700002)(55016002)(8676002)(53546011)(26005)(2906002)(6506007)(122000001)(186003)(9686003)(66476007)(52536014)(110136005)(66946007)(66446008)(66556008)(64756008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DdLQsmncKs04scztUZRiq4GGNJMtd0epnb3h5YTlA6RwQD1VqvlbHpiyAgfm?=
 =?us-ascii?Q?QsMtTpdbP/oRgpJRV3lPje0nZZ/QxIRnF5TRD6xy2pPJ2uW33FJN8n4pg6ji?=
 =?us-ascii?Q?2hRGu0HzXPCNkltc9oXG2v/rBRDZPRYKNoDMHSj8ThX1qQ4lzC2MJFn2Ltlv?=
 =?us-ascii?Q?rcW4W2wI9VQKynWiKlyPqfK+KQhzc4N8bpBzRw+2/sEcdNwJoBEfMJtObFc4?=
 =?us-ascii?Q?8DO678sF9K1JOZKRYzqHw4VGmV/AHuoeSUGM+ocwB1OZCEtIGuI2ST2fazTk?=
 =?us-ascii?Q?tfluNojZNqh+TEuKB4io0/x+MUmskLQpcvtmx+1dGSpanMBNPEkQXla3/Bwv?=
 =?us-ascii?Q?Ca9edFhC8rj0OLf98JuzFVbJId+JhMrbrAijgR6o9VuHK+7JVExHpfiF8YN2?=
 =?us-ascii?Q?KIg/R9jaS8MIh77p6bf2Bxi59qh0L/6QQ5gwjMRnVbvC0K0u++7QI8CGTy4x?=
 =?us-ascii?Q?9hBCMca3KqhbnZtzd1iII5IjQMDk40f1Sue7FGgWsDYo8cUQmCegXBBOte5G?=
 =?us-ascii?Q?u7at45Gw4KwI809mj5O10NiBHoy5H94EVMg+YViLooyGfzYars0+FWwaIh6x?=
 =?us-ascii?Q?A0BwI97OTFZaaJTWb3LPNuAas7+LBI4d7Vt3SMiD8eCVqSejnhIKfmkw4L6b?=
 =?us-ascii?Q?5bNUwKzIjRS7ctTjmHPtBtZbagGcaXTMbytRjt86zoZZNctDrjMRscBoyu/4?=
 =?us-ascii?Q?f8T5c+LJGAL50F9UrYl8M5ZQiZSoGTpSnqWNvuQFEoWxz/J1LxtPq3Xyp/NX?=
 =?us-ascii?Q?v/I1HJWngfOwdk0qTDNCvRsQMPMeMvGAn2tOKWksuYE9vTFtmJwFxZroxFLH?=
 =?us-ascii?Q?8kd/TeXTo/yvc6RhUdef+jpOq1bM3B69BP40Om9Gj44DLSRUBk/pf8m+jZH2?=
 =?us-ascii?Q?QYY1o3n9aJDsm1ykHt1xTlOrKm1IgGS3eiVTqPk5lv2CVMmgK9nsQXf/bH0O?=
 =?us-ascii?Q?DXAQ2KJlCngAErsSydlPP9Z6v7+V8HTpgcm//l48beIYsGLBVRLZZ/DKQ/YZ?=
 =?us-ascii?Q?9piIRhU2Ch5SsGM7OB2IwDImFk36X4OrdaNFEi9b4ZNdyqVyw40VHaXVSgYF?=
 =?us-ascii?Q?G0xRN+bM2aQR79DYGhWo3hbeBu+K7CSvvflXdO9V91sA0SYUk8SKfFD4xq9S?=
 =?us-ascii?Q?3ySORqfj+DM/rStCPe2L4quhtFwLb4x3NpuzI7kAszv2OCAHsRjhAfrZfUen?=
 =?us-ascii?Q?PiBNYBEZOqt5ZLX1ujOXxy5f3hHT5u+YfUWxYOGb9xxYrpnQlGT6ttNtEAoI?=
 =?us-ascii?Q?+ES5RlwStS/yCLkwQ0OxtPDJ8gngPxhrudd7J5pBmYS3x+P6F4os7w9uVpqF?=
 =?us-ascii?Q?Ea4a9+eCL/1rxaesNLAh+Mtc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8726.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6408b34b-724c-4e2e-a218-08d95643ab78
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 05:58:08.8028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcCqrV0HWUIf0cDqktjrWdHDMp9yeGwOs+3iFXRCOGg9sQZDA8khs4FnlIHzsAfOYGrHqOAdMwmVbgh15V4Xbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8758
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, August 2, 2021 9:35 PM
> To: Wasim Khan (OSS) <wasim.khan@oss.nxp.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Wasim Khan
> <wasim.khan@nxp.com>
> Subject: Re: [PATCH v2] PCI: Add ACS quirk for NXP LX2160 and LX2162 C/E/=
N
> platforms
>=20
> On Mon, Aug 02, 2021 at 05:56:44PM +0200, Wasim Khan wrote:
> > From: Wasim Khan <wasim.khan@nxp.com>
> >
> > LX2160C : security features + CAN-FD
> > LX2160E : security features + CAN
> > LX2160N : without security features + CAN LX2162C : security features
> > + CAN-FD LX2162E : security features + CAN LX2162N : without security
> > features + CAN
>=20
> Can you associate these with the device IDs, please?  Ideally a one-line
> comment in the code, but if that doesn't fit nicely, at least include the=
 device
> ID for each here in the commit log.

Thank you for the review.
Sure, I will associate them with device IDs and send updated version.

>=20
> > Root Ports in NXP LX2160 and LX2162 where each Root Port is a Root
> > Complex with unique segment numbers do provide isolation features to
> > disable peer transactions and validate bus numbers in requests, but do
> > not provide an actual PCIe ACS capability.
> >
> > Enable ACS quirk for NXP LX2160C/E/N and LX2162C/E/N platforms
> >
> > Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
> > ---
> > Changes in v2:
> > - removed duplicate entry of 0x8d80 and 0x8d88
> >
> >  drivers/pci/quirks.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > 24343a76c034..1ad158066d39 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4787,6 +4787,23 @@ static const struct pci_dev_acs_enabled {
> >  	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
> >  	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
> >  	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d99, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d8a, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d9b, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8da8, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8db9, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d98, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8db8, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d9a, pci_quirk_nxp_rp_acs },
>=20
> Sort these in order of device ID so it's easier to see duplicates and to =
find the
> one you're looking for.
>=20
> >  	/* Zhaoxin Root/Downstream Ports */
> >  	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID,
> pci_quirk_zhaoxin_pcie_ports_acs },
> >  	{ 0 }
> > --
> > 2.25.1
> >
