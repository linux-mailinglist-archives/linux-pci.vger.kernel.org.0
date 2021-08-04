Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFEB3DFB49
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 08:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhHDGE0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 02:04:26 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:33926
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232618AbhHDGEZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 02:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIu7I+2uhqxXQu9GhfwCJvYbTLQ3YOX7yV1DYPwRi903a9pUG8Z4HuKCKew5UAYc4Doyk6Ml1lMjDO7sSAME78UJD9OFNpz5DffOkgT9vbgW8irgQJtZViC2JbEGEMWIRzAkmxejoBPG2/Yf5moXZ4954cIWNqnArgZ7k5kfwHkRkV5KXoTkS7G+KmuWBVU5a+um+QVAnSacHHM7KwnWDYOr/PbtD4EzyiN8xdx5JwOsiZmb4MvhDfJwhFKgX0Nfvnk0SIGCCs0+tPZVvgs6ErFrBV1BY2A1QZIgizYbrSrPpiAjB5IjfkwF2v3nYnA5bjBdMFkk6xqxH7NpOf6u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arwWBiQFRO1NwoIUGI8FKfKCgaABXSdLMTlvieXerH0=;
 b=SQm7K8ivEqT1ozvn7+RoEExUgh+VAOu05nykqabABlY++Qsem5LD2NaAiQeJLd3Q9cxFEBrVZdwXs002fITl4aIkJosa1DU4VeM0fZhRlLBD4HW7BvYV4kEHR2ql9ycPjvhGB3dk3HdaykHLV2kR8qo1/QazdY0ea5jU/2m49V+9hslnOI1DN+7LV69zoawoWgO2OVS+jicEEqcdsfXKOOIFHrCiu4q6d4do7tpiu/JXe0FvEkKhG+ypixzc7A4y1OmjZe2ddMmKWH4OTDDBTYyyHkL/vU0SJJGdP2PGAnUwWnnCDaerduEl/o2j9bFU8hqGah5smuXuaXmHw2zo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arwWBiQFRO1NwoIUGI8FKfKCgaABXSdLMTlvieXerH0=;
 b=TPY2SUPkhp2he3BtiYfPnxEFK1P04fMOkRawIPVX6zcx8snxdd1tJ+PIG5FGBnYoa93ANoyFivrdUh1g8YmA4Fgp5EVT7oysHDyy4hL60xUmzqj2wedXWzsLYqAmFWEF1N833rucSuhFel+lp4TZkYnyhZApt6Y60ZHEiyfNxcE=
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Wed, 4 Aug
 2021 06:04:11 +0000
Received: from DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4]) by DU2PR04MB8726.eurprd04.prod.outlook.com
 ([fe80::e50a:234a:7fb7:11d4%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 06:04:11 +0000
From:   Wasim Khan <wasim.khan@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Wasim Khan (OSS)" <wasim.khan@oss.nxp.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH v3] PCI: Add ACS quirk for NXP LX2XX0 and LX2XX2 platforms
Thread-Topic: [PATCH v3] PCI: Add ACS quirk for NXP LX2XX0 and LX2XX2
 platforms
Thread-Index: AQHXiJF2XOqZO6lkOUy6s29FDUpaBKticQ2AgABqeBA=
Date:   Wed, 4 Aug 2021 06:04:11 +0000
Message-ID: <DU2PR04MB8726D0FF61E8691E64CC805090F19@DU2PR04MB8726.eurprd04.prod.outlook.com>
References: <20210803180021.3252886-1-wasim.khan@oss.nxp.com>
 <20210803234135.GA1587049@bjorn-Precision-5520>
In-Reply-To: <20210803234135.GA1587049@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0b3acff-5a9a-4bac-cb84-08d9570dade9
x-ms-traffictypediagnostic: DU2PR04MB8583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DU2PR04MB8583ECF2E07C636585EAA25890F19@DU2PR04MB8583.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z8p+b/Cix+gy0/s0fepiHgwZ6bSSHWj2KOzaRh5gXspue+Wx7TweHVf7Dqx+FvCKz1aKpJFPG4/ALjHV/UH4d+P11RZ5suzuJYerRKk25JBsK06NyAjcd7PLntIvoCu5MX99EvWVw9nEfeSFMzHyFMIcJ+4zl9oo296GzQ8emzBZlVknt9kQsqORWMTZZvzE5qOjZTG+oYj8CP/az1GtCiJSB1wMd9P2gToUT9Gas3ljNQreChPKahnlyU7VxvKSasLHl5NL8jbtHsRu56KEZFpMq/xbKEo4X4rZaWlpqidnY1H+7Fp3XcB3H1SyVELScnMj8XdKEAlFuV/Az8n2OHryL5LNwA9bzu6fAz9Y0EQSqN3u+/3WDTD6eUeWINl5wF873VHUZl3teGheS+GNlnGFDtdLD2ptLNGrBo0yhIx9oSRGnzJii7VM84fvyPg/xrJ9dB2V5sgN1aen+35U4yOTODHRunwZPNhSIPOVHZyfMs3eUUh3nwp8dedamOayuqCFWznMxgOjfSaKQDLE98PpJVwKKc8BhqmIJ/+QFfOhLZ8J+K7hTKt5sAteKEkiLCfplJHGZZW0wwuR1ymNHtuutAXHDrCnrR9xBMWBFkuSrni01nLX2cMWcpyjSLe0UqL8Nc4cpEUkHGTcsSDuwxRaQh+ioAiKL56aSIFt4n2aG6NgESUtgiRLZKkFuZCvrxIBPRt24isMBwljzHde9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8726.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(83380400001)(52536014)(316002)(54906003)(8936002)(5660300002)(53546011)(6506007)(7696005)(186003)(38100700002)(122000001)(33656002)(26005)(38070700005)(110136005)(2906002)(44832011)(55016002)(66476007)(66556008)(4326008)(64756008)(66446008)(86362001)(45080400002)(966005)(76116006)(9686003)(66946007)(508600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qq1xJxn5mhS2IqMlZIVYTbWW+z5pxnpzH4Goul43yfPBFzNKavNl049DjTI3?=
 =?us-ascii?Q?Ko4C7ha0FkSstSI3N/GbfdIn5pbynYuY0bnih4RMUJICfunG4ECt/PjykdVy?=
 =?us-ascii?Q?xp8umHJvphIYGvqbfYwSmQMQFV3CEzN0Kh+KjOn9JhuZD9sv81OeOv19T3jo?=
 =?us-ascii?Q?/W3O1VUAaLXtr9uvglObU9Ljjtyhs8iWChc8QMucvutTW5VUmvS6pNkd1Ei8?=
 =?us-ascii?Q?1aCMxaQAiVhSdXV6Q91cLhfegHITds/SfICybI+avmRmX6gPnZ/5onrpfeLY?=
 =?us-ascii?Q?rh2epSxk9YyrUolbumzW4SdDLj5QGfVw+1MDXelJ3thSCDqTNI2sUCaVkZB4?=
 =?us-ascii?Q?/eMalbB6FGh0LxLPiOnvqclg1KjEp/J3uch6rYdqCKHplYD+Wyw5i1yyAyhR?=
 =?us-ascii?Q?JWSPqjxY70lCVJ+uFOR6s6k9zSn/qeGmrcMYbss7CuZtTGAUdzlA+AGL4LPJ?=
 =?us-ascii?Q?D3URtMcaZ6tIsQPWhzK1XYvO6d5pCEw32nSjydwiNv71HiJVv2wgYThNzv7v?=
 =?us-ascii?Q?45axNOnqaupOuUi2/nM4jIs2fAidbKO7NG9WML8iHCIbVcxJFTO0vF38ch7K?=
 =?us-ascii?Q?s8c1//carcvEbgpJxRs4Pw2vDtjodW2Z4ZhaQ0VMnkoPMmeax3OwqbcGn5PF?=
 =?us-ascii?Q?1p7Ena0EhGZyIbcU4ZusC68C6Vpepmyxgj3Rdi4kTzWYAR7UPH0KLP8E4VJO?=
 =?us-ascii?Q?F2wjWS1Erhu05dtifyDXIAkeO9xhW24rb+HIZFzDGGZBaTsy1GjbPHWXv6Bd?=
 =?us-ascii?Q?TZVEglTaTXPI+V02KV9Zlhl8WH85JvD80k/pZ3BWX35wVwXaWVY0o0K2gzN4?=
 =?us-ascii?Q?iXtJIKdF3t4yclYcbaytcudh3TGoxI23Z0OEueF9/X0b9T0Pv6kZiwsFvlOh?=
 =?us-ascii?Q?Cv4+1gpJLObseCi8Z1bXmZAg3EUepvoFwiS+PvNFmIG9PAGYiJ0jBx8y4IaW?=
 =?us-ascii?Q?0XV+3W1ekMFDebRk3VN7f3o0sc8rMGskZdWVWaCGZzGSr1XWP5/5I68m1AiL?=
 =?us-ascii?Q?hR5XtHUgBIWOX88EoSveqosYgOE4JzJgW6bHks1Hw5nE6GeScbqPnwR4lZbz?=
 =?us-ascii?Q?wDD//DqbNamDMYZPpohqb3QCzgL/uTBps3/QuYAdPVDicwBSpSTHewNeazYt?=
 =?us-ascii?Q?R7QC0IXHMXXqmvAD94Gi+NtoGdnz060yiHz81wd+k0apL5BtiGBXN+XIzfj+?=
 =?us-ascii?Q?faGJZO7We7kL6GcCrbCWvR4goB80oI7JjNBYUgeQrnOVBClofOFn1WwFW32n?=
 =?us-ascii?Q?PPQldOvd/ekmVUCkYncUrhoRN6ymU3Q0AnyHy+8b23brKI4zF1k6zz8gEhwm?=
 =?us-ascii?Q?sPU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8726.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b3acff-5a9a-4bac-cb84-08d9570dade9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 06:04:11.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3Nbl1KhzfQVTuMdTrRuYM86DAmkWspbTSjMjkzFHH9ResyyFX8ZlbX0WG0XVIEjB7vmtZtg63m/VziMzQIong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, August 4, 2021 5:12 AM
> To: Wasim Khan (OSS) <wasim.khan@oss.nxp.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Wasim Khan
> <wasim.khan@nxp.com>
> Subject: Re: [PATCH v3] PCI: Add ACS quirk for NXP LX2XX0 and LX2XX2
> platforms
>=20
> On Tue, Aug 03, 2021 at 08:00:21PM +0200, Wasim Khan wrote:
> > From: Wasim Khan <wasim.khan@nxp.com>
> >
> > Root Ports in NXP LX2XX0 and LX2XX2 where each Root Port is a Root
> > Complex with unique segment numbers do provide isolation features to
> > disable peer transactions and validate bus numbers in requests, but do
> > not provide an actual PCIe ACS capability.
> >
> > Add ACS quirk for NXP LX2XX0 A/C/E/N and LX2XX2 A/C/E/N platforms
> >
> > LX2XX0A : without security features + CAN-FD
> > 	  LX2160A (0x8d81) - 16 cores
> > 	  LX2120A (0x8da1) - 12 cores
> > 	  LX2080A (0x8d83) - 8  cores
> >
> > LX2XX0C : security features + CAN-FD
> > 	  LX2160C (0x8d80) - 16 cores
> > 	  LX2120C (0x8da0) - 12 cores
> > 	  LX2080C (0x8d82) - 8  cores
> >
> > LX2XX0E : security features + CAN
> > 	  LX2160E (0x8d90) - 16 cores
> > 	  LX2120E (0x8db0) - 12 cores
> > 	  LX2080E (0x8d92) - 8  cores
> >
> > LX2XX0N : without security features + CAN
> > 	  LX2160N (0x8d91) - 16 cores
> > 	  LX2120N (0x8db1) - 12 cores
> > 	  LX2080N (0x8d93) - 8  cores
> >
> > LX2XX2A : without security features + CAN-FD
> > 	  LX2162A (0x8d89) - 16 cores
> > 	  LX2122A (0x8da9) - 12 cores
> > 	  LX2082A (0x8d8b) - 8  cores
> >
> > LX2XX2C : security features + CAN-FD
> > 	  LX2162C (0x8d88) - 16 cores
> > 	  LX2122C (0x8da8) - 12 cores
> > 	  LX2082C (0x8d8a) - 8  cores
> >
> > LX2XX2E : security features + CAN
> > 	  LX2162E (0x8d98) - 16 cores
> > 	  LX2122E (0x8db8) - 12 cores
> > 	  LX2082E (0x8d9a) - 8  cores
> >
> > LX2XX2N : without security features + CAN
> > 	  LX2162N (0x8d99) - 16 cores
> > 	  LX2122N (0x8db9) - 12 cores
> > 	  LX2082N (0x8d9b) - 8  cores
> >
> > Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
>=20
> If I understand correctly, this is really an expansion of your previous p=
atch [1], so
> I just squashed them together into a single patch and applied it to
> pci/virtualization for v5.15.
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Fr%2F20210729121747.1823086-1-
> wasim.khan%40oss.nxp.com&amp;data=3D04%7C01%7Cwasim.khan%40nxp.com
> %7C314779f836294f7b2c9b08d956d83d31%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C637636309011310678%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=3DIxiJ7JMpwuhihxxHl%2BTG9WD93P3g9BKjOrKoYYiAs7A%3D&a
> mp;reserved=3D0
>=20

Yes, that is correct.=20
Thanks a lot for the review .

> > ---
> > Changes in v3:
> > - Updated PCIe ID for LX2XX0 and LX2XX2 A/C/E/N
> >   platforms and arranged then in order
> > - Updated commit description and included
> >   device to ID mapping
> >
> >  drivers/pci/quirks.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > 24343a76c034..d445d2944592 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4784,9 +4784,38 @@ static const struct pci_dev_acs_enabled {
> >  	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
> >  	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
> >  	/* NXP root ports */
> > +	/* LX2XX0A */
> > +	{ PCI_VENDOR_ID_NXP, 0x8d81, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d83, pci_quirk_nxp_rp_acs },
> > +	/* LX2XX0C */
> >  	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
> > -	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
> > +	/* LX2XX0E */
> > +	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
> > +	/* LX2XX0N */
> > +	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
> > +	/* LX2XX2A */
> >  	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8da9, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d8b, pci_quirk_nxp_rp_acs },
> > +	/* LX2XX2C */
> > +	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8da8, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d8a, pci_quirk_nxp_rp_acs },
> > +	/* LX2XX2E */
> > +	{ PCI_VENDOR_ID_NXP, 0x8d98, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8db8, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d9a, pci_quirk_nxp_rp_acs },
> > +	/* LX2XX2N */
> > +	{ PCI_VENDOR_ID_NXP, 0x8d99, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8db9, pci_quirk_nxp_rp_acs },
> > +	{ PCI_VENDOR_ID_NXP, 0x8d9b, pci_quirk_nxp_rp_acs },
> >  	/* Zhaoxin Root/Downstream Ports */
> >  	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID,
> pci_quirk_zhaoxin_pcie_ports_acs },
> >  	{ 0 }
> > --
> > 2.25.1
> >
