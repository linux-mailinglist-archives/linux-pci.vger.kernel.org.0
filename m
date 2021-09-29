Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA1241C53D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbhI2NLQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 09:11:16 -0400
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:25696
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344078AbhI2NLP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 09:11:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq55aZauyYU28RGf5HKaGajCD9HqXGVQGPrM4lGrtiPcty+Yx9x6FUDmyTc08/FlAfUS9RMJWbY/MyRaJWH2jgFiJGS1uIOyG4ewujCXo1zX7YK3+EX6KyCAWwGOUv8Er0nl0XNfDsdH8w1EnSw567kng7XqWthl3EC4gS3WH1D3kXQQXF1x2IRaAfSX46Dtaansv7AS101KAWpc85mv+A01LkbnAvFyA5e615507sgH2ZFS88ePHovayew7V017GdsM7YZm22MSlKqZpKjtFEPIIb+Ivu+DwG+ZwWYsFlFeZ60qMjNaxNTi4CHMveDMfb6RaGW10T6xfcJlLC9bDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ww2m4KuelkMRqhIE82BKaeRLWqy2zVMLZV37NmWs0hM=;
 b=VbZ0GBXaqSbg5oIQ/uL5PrEC52NrIsZ0p+m4PbwpQkxb7rEFFbdGQdrr35WaEo2KC2avH0kVWRLR/rvCuTvOS7TyPXEMXCSTwDvjTNmvq4lVFAm5e4gCOfoTI3ffwVz+USysqECq7RnPFaEe1bMDQrSDsfFRwrGr455OGEY/jmrBa1mrw0H2GBax73+Y2RAuMq7AhFEm4i1jAO/tfECzc5+TbiU9RzAlNorItcYIg2YWaqEJyYrPaepfwhSdLxu5QV6hJ0Ws/yTEcuTJw3LTMSp187Pmx6gjcMN7pCk2BY2u7mIolyBgfwWb6T/QvCa8+AeUKWc9slBNA1ZFLeWH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww2m4KuelkMRqhIE82BKaeRLWqy2zVMLZV37NmWs0hM=;
 b=M2OBijjGU94UVWcVNjN8rVxHAikz3uvdjE5XNS9cALUF/S70PUPc6eBJ+6jC97qXCoNns+ZMKIUQlzvBfNhNb+Kq2UdyLkDAu2NGjNkBnS8k5bbInC1a/QUKHgayBRN6WOflMc3eEUJczi0wHd+xo9cMAUZL+5iDiZYKCU2/lJs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 13:09:31 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a%7]) with mapi id 15.20.4566.014; Wed, 29 Sep 2021
 13:09:31 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Jaundrew <david@jaundrew.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: RE: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Thread-Topic: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Thread-Index: AQHXtNWX79MakDGcMkGdFJQKTS/CDKu6/IXA
Date:   Wed, 29 Sep 2021 13:09:31 +0000
Message-ID: <BL1PR12MB5144E21584FF1337814C538BF7A99@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <9e85bcad-a73c-cccd-4522-a45e599309d7@jaundrew.com>
 <20210929015902.GA753214@bhelgaas>
In-Reply-To: <20210929015902.GA753214@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-29T13:09:28Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=83f057be-52c1-4088-b8bc-30c233a8f649;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10450dd0-1091-427d-d793-08d9834a6045
x-ms-traffictypediagnostic: BL1PR12MB5361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5361D1C5F5FCEC063314B47AF7A99@BL1PR12MB5361.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/iJHmggB2zTKmRdcx22oUkVUO1ONUw5R3QDozOIdQE0niRz39wmVdButVLe6kD+MCgqQ3r+UypgSxPzTQi5dJ61afWqoxOSMXh/Os7PfzZtUl1vvdf9brcAagu3uxQd3nfDsOXJL7g0pV4Z+sVcYCySTjiSZ/ev8alTYv3U40t+4oQF1ej8ktVICF85kWPWGR218LKVCgQ4YeH02UQjY8LaDXexAimO5WBAKCJNLTsWm2mbHYlQyBD+bnDkMS8BMeQxqWLe9q42ZXQRzFp8QpS3gefkbFr52/J7NC7SEKfmlfQJnb36WhWjhuGyd8zLKiIcK/lPt2kXQ2aBEUE7klxcAGgsKRgH8CpI+IJs8YFQ2LFukRD2SA4sIPGcWKA6Xjyyvy66zqmo6JnVRB+B9MjuK1Q2bG5P2UOvMuDpSTcvhKrHYwqYsECggb6CYMZdzkE/4cJXE2Xt4ai59IMFZqB7uWTePpir7zw5RLiiabfERzHLFAj/Tsa4dPjOoaET332luZZmkRw4dC/YssgyLDcQNrkr+Ifl5ILpArcRHyV1KN95MNgCVbl11A8AtCZDFqEXrNtDyQ+PhSMt2EwwN7QfeQuK3adFdrGexFI/r7MOdAxNm+YZK1YtqWRqwZ/bOGOQC9yHSshdNo7A6TF0ZLSAyULkmwc/nwfWaSM1cGsjkznlXAhVUmbQpxlMLXB59WqcSb/hz+BIuHi6IUQ1gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(83380400001)(122000001)(66446008)(38070700005)(66574015)(53546011)(64756008)(4326008)(6506007)(9686003)(76116006)(2906002)(33656002)(55016002)(8676002)(8936002)(316002)(38100700002)(71200400001)(5660300002)(26005)(508600001)(52536014)(86362001)(54906003)(110136005)(186003)(7696005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?FEevXuIiODDn3SUa3J1dNW2Gv6u4f053w1k7uNiFANXdLJR8N0uu8neKmN?=
 =?iso-8859-2?Q?WMV5349b1WpeEE3y3EGjEUQjeEfRGCwSbGDHNlydmmlir0mNnzpdGRovzl?=
 =?iso-8859-2?Q?3IQJvkR2XbHG9bE5Vcv02AlFv5Twr9wUJ3MVfx5LXylAZvMRYbAXU4rQKe?=
 =?iso-8859-2?Q?XGRXzweazGlsSiBTg9Fqt8pVLI4bz131pk6Aw2jWOfLMhHptoZRp6z6++7?=
 =?iso-8859-2?Q?8P/lXLeU03F0m/zWZZWTxaNrRzKyT3Ex4D4G3mKCvxnwssEiI2Pv4HAhju?=
 =?iso-8859-2?Q?UTu+UwFe3GYO4RWt0YLgRcNq+neSbi/pCHzNulWIfXwJ4gqtUIUQGFDo3m?=
 =?iso-8859-2?Q?fP/78MmKGDHC6V6mEbJF+y6z8EO+IXgzyVuqw+uDsaJPnNWSq2qiKYiTgN?=
 =?iso-8859-2?Q?VHTw6Omk7jXk+nop3EmRD7wiCyTUfmxI9ECTNocdJowXHcZ4wHnOglH+4a?=
 =?iso-8859-2?Q?kHZkv2fynnXDS8VqOurQyii1Z+j7+TehVkaMJvgN6wWSZ8c/jd4QEj8Fq2?=
 =?iso-8859-2?Q?5GatZ872ywNeFHBNCiClByFNyzHtHxbRcmlbNoGmclhXfdUT6/OBZV47KH?=
 =?iso-8859-2?Q?DORjUy49UNWXdxE6jPG1GSvKv9F1kbMIDutIxd18ptXoeKu6x7gr2dJBNf?=
 =?iso-8859-2?Q?zf0/03LdvwGsPElqZlruTPHeTYeFydo8MNByQPP6I8JRohOVIFfv+CdH/c?=
 =?iso-8859-2?Q?5InivWVdjyN2cRf2Iiu4S3I3yAbdxVKk8iMTAhfZ/b9vLgcnZNhHLX4Hu5?=
 =?iso-8859-2?Q?Lb0sj2Zvt+gBhZtzoKkYeqgnNWAMdLfuWzzr0essnG1wMZrfsE1dRpOnhK?=
 =?iso-8859-2?Q?/Ofcw7EoYd2m8lIgQkGousThoNWxJ2CTYrZK6on0Ir1WkJKfFYE7BanSk6?=
 =?iso-8859-2?Q?OaQh84qdWbC31bIMkvsaJDnQQfBaLR4mGl7TctmywuxCOvXezdsLitD+2t?=
 =?iso-8859-2?Q?aAU6LD2DC/wx6d15HGUnTwzoljLd9zthr05JOQX7CHr/jsDzq03b4TTeve?=
 =?iso-8859-2?Q?wSXBbWCRB/ba09td+9aZ1xhIOi+ghpycUQVcpyG8M8dEPXmXkGHTJ9c+Zy?=
 =?iso-8859-2?Q?CwJUyPU7edqmprE0C8HHO3wnsbEeZBx3kXxT/0s8ecnENJZm4dbCgwXM7S?=
 =?iso-8859-2?Q?r6cvVdW6ameTur09/QPzgCLZrZYq+Ty8loegFxR4L6mcrobmq22MMl7El8?=
 =?iso-8859-2?Q?6x6IlnRuxiGMnQbl9FzRuFn6JCbXTEPZCeKU8z9r+0gw5ZPeRYoEol2Olx?=
 =?iso-8859-2?Q?XiHbLGXzw1TQxT+noSsiLBL2EbNUvnRUvugkcXYfIVVN4Bv0Pg5hTQJswl?=
 =?iso-8859-2?Q?7mgx5moglm81e9jKrT/IifT9di6EL1q/JjoRFD+17jFji0AgyIwNQC/Wp6?=
 =?iso-8859-2?Q?nzdBW91REL?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10450dd0-1091-427d-d793-08d9834a6045
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 13:09:31.3623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUJsncblfJBTNXy1flEhzecjQl8/6JGzxRpCUcRKqVRj78BD6BoZKLgssLFB/uYViBNqtPBYFOS4tig7jYGJlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, September 28, 2021 9:59 PM
> To: David Jaundrew <david@jaundrew.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; Alex
> Williamson <alex.williamson@redhat.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Shah, Nehal-bakulchandra <Nehal-
> bakulchandra.Shah@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Krzysztof Wilczy=F1ski <kw@linux.com>
> Subject: Re: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
> Coprocessor
>=20
> [+cc Alex, Krzysztof, AMD folks]
>=20
> On Tue, Sep 28, 2021 at 05:16:49PM -0700, David Jaundrew wrote:
> > This patch fixes another FLR bug for the Starship/Matisse controller:
> >
> > AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP
> >
> > This patch allows functions on the same Starship/Matisse device (such
> > as USB controller,sound card) to properly pass through to a guest OS
> > using vfio-pc. Without this patch, the virtual machine does not boot
> > and eventually times out.
>=20
> Apparently yet another AMD device that advertises FLR support, but it
> doesn't work?
>=20
> I don't have a problem avoiding the FLR, but I *would* like some indicati=
on
> that:
>=20
>   - This is a known erratum and AMD has some plan to fix this in
>     future devices so we don't have to trip over them all
>     individually, and
>=20
>   - This is not a security issue.  Part of the reason VFIO resets
>     pass-through devices is to avoid leaking state from one guest to
>     another.  If reset doesn't work, that makes me wonder, especially
>     since this is a cryptographic coprocessor that sounds like it
>     might be full of secrets.  So I *assume* VFIO will use a different
>     type of reset instead of FLR, but I'm just double-checking.
>=20

Will try and get more information on these questions with the right teams i=
nternally.

Alex

> > Excerpt from lspci -nn showing crypto function on same device as USB
> > and sound card (which are already listed in quirks.c):
> >
> > 0e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc.
> > [AMD]
> > =A0 Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
> > 0e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD]
> > =A0 Matisse USB 3.0 Host Controller [1022:149c]
> > 0e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD]
> > =A0 Starship/Matisse HD Audio Controller [1022:1487]
> >
> > Fix tested successfully on an Asus ROG STRIX X570-E GAMING
> motherboard
> > with AMD Ryzen 9 3900X.
> >
> > Signed-off-by: David Jaundrew <david@jaundrew.com>
>=20
> The patch below still doesn't apply.  Looks like maybe it was pasted into=
 the
> email and the tabs got changed to space?  No worries, I can apply it manu=
ally
> if appropriate.
>=20
> > ---
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > 6d74386eadc2..0d19e7aa219a 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5208,6 +5208,7 @@
> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,
> > 0x443, quirk_intel_qat_vf_cap);
> > =A0/*
> > =A0 * FLR may cause the following to devices to hang:
> > =A0 *
> > + * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
> > =A0 * AMD Starship/Matisse HD Audio Controller 0x1487
> > =A0 * AMD Starship USB 3.0 Host Controller 0x148c
> > =A0 * AMD Matisse USB 3.0 Host Controller 0x149c @@ -5219,6 +5220,7 @@
> > static void quirk_no_flr(struct pci_dev *dev)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0 dev->dev_flags |=3D PCI_DEV_FLAGS_NO_FLR_RESET;
> > =A0}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486,
> quirk_no_flr);
> > =A0DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487,
> quirk_no_flr);
> > =A0DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c,
> quirk_no_flr);
> > =A0DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c,
> quirk_no_flr);
> >
