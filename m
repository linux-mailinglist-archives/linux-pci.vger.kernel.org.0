Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF741CD33
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 22:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbhI2UJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 16:09:11 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:5472
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346585AbhI2UJB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 16:09:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgD2SVabPjdfbpbs5z8iIBt0z8zIMcLUyK3BjhWEY35scChNDO28mM65YAN+LZhwX4MHK110+BeUrvp3ccfh0dhhNwF7oh9GzNta4C3AdKzTOljAQ3scCRq1RS74ygAVkn2hIu1wBqaEVw73tf1pGPc/mAhnqJFasKS4QSQNLHXWzMeHiaAQ+1xuPnqXnyUfBm3lRkRR7qlMwPOvkWRLhS+87dCHuVyMCE31l7EX+qGllfbhPVfWs8lhIZ5MP6P8aRDdM3TUaC/jjgAWzzdNP/JNEFCf+h0U7AMTrk2M+2D1GoNqqH6Zm2M31rh3NFJYkb3gb6HO/r7wDNp2dUNTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NJbReWQyZl5vnG94dsHWUJNC/7RFHOQpW56g2pWI8wE=;
 b=N1+tR1Hjy04oCqIaQbyaq4/RSJzDLyNoJjmhLbwYGmtDXF9lqiaAbnG2g4bGPQOUSEsJd6KZ7Y1EmQF49rLozl+nfZXfebJwdxqd4BCILLg5So4ZYaQzIFyLDs7eRMX6C0pOci44Qfs56KI8wf1xDr5eFoOpLI8CSw0+44dF3qWLsrnvtcqXaeDfGNqmOFB7jaO7QyF2Wo7demsTnRsS1L4eWNSQPIPasRbfFmRLQG7Uq+WcGGuSvpuEB06z2iosh3EX3nFaNXdwBFrqmxdPkI+Dr80EdGgk9y3nnDmFF8r40xEJeMhxYsLCLPN5hyTrw96JFevDNLiWTP+qi9duOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJbReWQyZl5vnG94dsHWUJNC/7RFHOQpW56g2pWI8wE=;
 b=SuDuSQEhSNOhG3bldsbl9+v9cfu3bML0pZT61iSZc8NggHYditLbHg3k9JzOx2BD1GL4rdKpK7zgvzVtPy0apfSJ3q/EoCo8zbDpkF70C5WrFvz/72w1ITgFJ5+DDo6CgQABTbbIRYRXMOz15O4td0JGts9Rq/HCQat/4p2BP/g=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 20:07:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::7140:d1a:e4:a16a%7]) with mapi id 15.20.4566.014; Wed, 29 Sep 2021
 20:07:18 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
CC:     David Jaundrew <david@jaundrew.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: RE: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Thread-Topic: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
Thread-Index: AQHXtNWX79MakDGcMkGdFJQKTS/CDKu7VUoAgAAGyYCAAAwEEA==
Date:   Wed, 29 Sep 2021 20:07:17 +0000
Message-ID: <BL1PR12MB5144B6A2560F1534F8CEFFB8F7A99@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210929122612.02e54434.alex.williamson@redhat.com>
 <20210929185029.GA790241@bhelgaas>
In-Reply-To: <20210929185029.GA790241@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-29T20:07:13Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=31e27882-dfdf-4cc2-8cf4-ca3e91b7fce5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a278e478-6b0e-496c-36d0-08d98384bd14
x-ms-traffictypediagnostic: BL1PR12MB5173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5173C794DFD25D7267717E20F7A99@BL1PR12MB5173.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2Rx6PAEu3b2uMrNZui9C1QPc/RAV4MEdPF19NbhJMKBHNZSELTdxEL1pFXVH8o9KL1X3r1muSVTDshSrbTayAOUUzc2zL5B54Vx+9DuDUHChIeoVpo4mr4CLfMlNWfS9GP9azHpMaDrqhEcBdG8TNnZg6W3xHxl97N2498cepFngVTq6lECcypdnpR0YFYj2TYUN1TKFkKMyi6dVN239rmH4Z1vM8Xy52NVAK8KkCNgSvVwsLkZYjPHMUKwcWYwqJNTH3WSygD5uoJMduHn7kfA2GFRB5ZY3WpQ/zs5H8wty3kH5m4WkYsvAO0VvKprKOnnllgL9Def8dgWxBjL5TrlOTU26Y1jW9sbrLw2dNzR79LtjjA3XD01Jk5AI+UYdOni/4eiNR6H1F4SiMilX7EGNt6bt7hLkF7X0MUUNsZnr56nw/piQPHsrlR5QEN0IXD+WVaTtX9yfTvC1askPl3PkBhilAgNe0hUeTd3CXY18mZ0M6BClorQEsUSYdQw8W5tTI5Vx6kl0iYEDiTXzz7F9WeJ4Br5fCpq02NZOjKPvnp4N0+B7Ja2155Cm7/3AigAkQES/e2ACH2g36Rq5ROzAbbQqgb9tQfHpkW5zbGawxKHc0KzUIx2YZzz97Op2L4cEHlXTzV0xeME9U4Sw1nKxZcjF5gDAdt7zQdj9tEln6IRVuEehaJvXbfrZ6RPz/djjNi3RX0RpSluzQ5yK3txCfUIyAXl/Skher0fV3YHKv921Bm1PjM6Y5E8HFsddLruP3VUrEZWPJLNWKMVQXv7gdhpF9kpDQOuSeKGRYY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(966005)(66476007)(66556008)(64756008)(33656002)(6636002)(38070700005)(55016002)(66946007)(2906002)(66574015)(5660300002)(7696005)(45080400002)(9686003)(52536014)(122000001)(508600001)(26005)(38100700002)(110136005)(6506007)(186003)(4326008)(71200400001)(83380400001)(8676002)(8936002)(76116006)(53546011)(54906003)(316002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?zKHdciQaQGoSG83MlULzE/fZ/ppe566ZUwHAjT1BrdBMJpxPwihwiC04SP?=
 =?iso-8859-2?Q?ALuoH8kacz+I5bh1YPYR8ZRu9ZV/+8eFNne9I7h4gT5CutQhw1EU+D7cid?=
 =?iso-8859-2?Q?3JXNWW6BJrXqrO9naX7lVajXvkxDvrMdF6mppOwbgLfClDIWmak1r6EKvw?=
 =?iso-8859-2?Q?fi2jXzrc6k2TE6ZaorwpU/8WnOdAt7+tDPtFUvbdQJIBcTa05olmuZxhmT?=
 =?iso-8859-2?Q?TU6AI/PwOMH51fG3TIPXAzPvMyIO6RV2oJJcJiWonSHH3OtORbmlcyz4G+?=
 =?iso-8859-2?Q?4oO0J3BoBA0ZAlrptPR01/qdInoJTEKlzhNmqzWuaJMWRRBEwhdgvSiUyw?=
 =?iso-8859-2?Q?/11usayZvHC42J0cJs+hUBnCykezJoaQWAj1Ge6wACRVHXuADI2Ymw4030?=
 =?iso-8859-2?Q?yK+MB9BscQjalFuinQdMjNlb94ZHBtePxzWGGDmS8Qpiik9JW9BsxOrzv2?=
 =?iso-8859-2?Q?wp0S91u8AIXlAoTSl/2j7vYHM1jaQhTbnwxzAfr2vEkmJ/5CYVC5uLJd78?=
 =?iso-8859-2?Q?7TjVzHj6tRzYMIGVSgOdWMSkGbBkuAhoer7fHYfUiLOLWvvTCMq9P3hhSP?=
 =?iso-8859-2?Q?V8atlOsdVPf0lCzAXXZP9xKO8ycLJy7K+Kr/XrcFNMqHdZONcQHElRyRFb?=
 =?iso-8859-2?Q?bI1WB670LWdFJD5KUnA9q5wc7L94OgSERDNEOpFIEUa05Nw80zR51N9Dlm?=
 =?iso-8859-2?Q?xODSZvXDEDKwHutABwiGq/pRNUq68EOy1WuVuwniuXy/sLkQytgGp4Yxxp?=
 =?iso-8859-2?Q?5D+miP6bBPQLEnB6JLJrumudXSVbra8I/pBStK+1XwQS8hg8nvJZ/zN42k?=
 =?iso-8859-2?Q?HPuZxWtyY0clCXOu8jc24qLL/1QelKOi596fAyTDVFgoQwtQFfeF4PgR0B?=
 =?iso-8859-2?Q?zlqkpII2ibrHbuIRKpw0vm3NSxUKPojb6TVNUXfTp2wp1RhJ7Vb0uoVWcO?=
 =?iso-8859-2?Q?ORIxfsm/M/gaZBSTk3CQurpVD/aomsSnWSSl2JD2q2sEeRqMnUfT4ogrT5?=
 =?iso-8859-2?Q?UtoN0crkjujCfV5bHYdtXaHlHvSxgdzoz9bJV0IFF1g8FX1qdQtg9h6kZ5?=
 =?iso-8859-2?Q?MZJYFE0fpP9WFrlBUrRZ3+2GZg85YloAJdspmbvsHjj3bnQOyampXdHwaf?=
 =?iso-8859-2?Q?5aW8ZP6JR39K0TyXBoV9GdAR1tCg/hc8uOwhBE9IE+YNIvv3qcealMo6KY?=
 =?iso-8859-2?Q?mF5G7z073HQ0aF0zFoxp4X+e+QXeUbVS+g6LHjVKFjHb7NyxzEahMItdyj?=
 =?iso-8859-2?Q?OfAk29fM3BgiB9zVrr92ujDLblmhZ0n2ZeLtZd6AoTxVHE5lDBY+WYurv9?=
 =?iso-8859-2?Q?2NojYA4Qv5V4FfOqiJop2HDCGMVfcFWlRi4lvysyvOTpopOVDQlRvZiAPb?=
 =?iso-8859-2?Q?Jx6S2n0Y4b?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a278e478-6b0e-496c-36d0-08d98384bd14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 20:07:17.9820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R68RIFhhmyJMdZBwp4U9my59fRcARJeooJbYUgzX4XHBWMPAdRaH+nNLiT1q2pSz+1jMjEQFAAEif8OhCoOMGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, September 29, 2021 2:50 PM
> To: Alex Williamson <alex.williamson@redhat.com>
> Cc: David Jaundrew <david@jaundrew.com>; Bjorn Helgaas
> <bhelgaas@google.com>; linux-pci@vger.kernel.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Shah, Nehal-bakulchandra <Nehal-
> bakulchandra.Shah@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Krzysztof Wilczy=F1ski <kw@linux.com>
> Subject: Re: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
> Coprocessor
>=20
> On Wed, Sep 29, 2021 at 12:26:12PM -0600, Alex Williamson wrote:
> > On Tue, 28 Sep 2021 20:59:02 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > > [+cc Alex, Krzysztof, AMD folks]
> > >
> > > On Tue, Sep 28, 2021 at 05:16:49PM -0700, David Jaundrew wrote:
> > > > This patch fixes another FLR bug for the Starship/Matisse controlle=
r:
> > > >
> > > > AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP
> > > >
> > > > This patch allows functions on the same Starship/Matisse device
> > > > (such as USB controller,sound card) to properly pass through to a
> > > > guest OS using vfio-pc. Without this patch, the virtual machine
> > > > does not boot and eventually times out.
> > >
> > > Apparently yet another AMD device that advertises FLR support, but
> > > it doesn't work?
> > >
> > > I don't have a problem avoiding the FLR, but I *would* like some
> > > indication that:
> > >
> > >   - This is a known erratum and AMD has some plan to fix this in
> > >     future devices so we don't have to trip over them all
> > >     individually, and
> > >
> > >   - This is not a security issue.  Part of the reason VFIO resets
> > >     pass-through devices is to avoid leaking state from one guest to
> > >     another.  If reset doesn't work, that makes me wonder, especially
> > >     since this is a cryptographic coprocessor that sounds like it
> > >     might be full of secrets.  So I *assume* VFIO will use a differen=
t
> > >     type of reset instead of FLR, but I'm just double-checking.
> >
> > It depends on what's available, chances are not good that we have
> > another means of function level reset, so this probably means it's
> > exposed as-is.  I agree, not great for a device managing something to
> > do with cryptography.  It's potentially a better security measure to
> > let the device wedge itself.  Thanks,
>=20
> OK, I think that means I need to ignore this patch until we have some
> evidence that it's actually safe to allow VFIO to pass the device through=
 to
> another guest.
>=20
> And I guess we are making the assumption that the audio, USB, and etherne=
t
> controllers [1] are safe to hand off between guests?  I don't know enough
> about those controllers to even have an opinion about that.  Surely there=
 is
> config space and MMIO space that could leak data between guests?

Adding a few more AMD people.

I doubt FLR was intended to be enabled on these consumer parts, it was prob=
ably a mistake.  I'm trying to find out more internally.  In general, I sus=
pect most vendors don't do much passthrough validation on consumer level ha=
rdware. =20

>=20
> Is there anything that tracks whether the device has been reset after bei=
ng
> passed through to a guest?  For example, I assume the following would be
> safe if we could tell the reset had been done:
>=20
>   - Pass through to guest A
>   - Guest A exits
>   - User resets all devices on bus (including this one)
>   - Pass through to guest B
>=20

Probably the safest thing to do would be to not allow passthrough on any PC=
I devices which don't have functional FLR support.  Do other things like PC=
I hot resets make the same guarantees about device state that FLR does?

Alex


> [1]
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k
> ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%
> 2Ftree%2Fdrivers%2Fpci%2Fquirks.c%3Fid%3Dv5.14%23n5212&amp;data=3D04
> %7C01%7CAlexander.Deucher%40amd.com%7Cf6d3929788584ce937d208d98
> 37a0366%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6376853823
> 39000224%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DDMR7b2J
> W%2FnSO6hmz44r%2FRvvu0ml2krECECZaU2pXC%2BM%3D&amp;reserved=3D
> 0
>=20
> > > > Excerpt from lspci -nn showing crypto function on same device as
> > > > USB and sound card (which are already listed in quirks.c):
> > > >
> > > > 0e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc.
> > > > [AMD]
> > > > =A0 Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
> > > > 0e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD]
> > > > =A0 Matisse USB 3.0 Host Controller [1022:149c]
> > > > 0e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD]
> > > > =A0 Starship/Matisse HD Audio Controller [1022:1487]
> > > >
> > > > Fix tested successfully on an Asus ROG STRIX X570-E GAMING
> > > > motherboard with AMD Ryzen 9 3900X.
> > > >
> > > > Signed-off-by: David Jaundrew <david@jaundrew.com>
> > >
> > > The patch below still doesn't apply.  Looks like maybe it was pasted
> > > into the email and the tabs got changed to space?  No worries, I can
> > > apply it manually if appropriate.
> > >
> > > > ---
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
> > > > 6d74386eadc2..0d19e7aa219a 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -5208,6 +5208,7 @@
> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,
> > > > 0x443, quirk_intel_qat_vf_cap);
> > > > =A0/*
> > > > =A0 * FLR may cause the following to devices to hang:
> > > > =A0 *
> > > > + * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
> > > > =A0 * AMD Starship/Matisse HD Audio Controller 0x1487
> > > > =A0 * AMD Starship USB 3.0 Host Controller 0x148c
> > > > =A0 * AMD Matisse USB 3.0 Host Controller 0x149c @@ -5219,6 +5220,7
> > > > @@ static void quirk_no_flr(struct pci_dev *dev)
> > > > =A0{
> > > > =A0=A0=A0=A0=A0=A0=A0 dev->dev_flags |=3D PCI_DEV_FLAGS_NO_FLR_RESE=
T;
> > > > =A0}
> > > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486,
> quirk_no_flr);
> > > > =A0DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487,
> quirk_no_flr);
> > > > =A0DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c,
> quirk_no_flr);
> > > > =A0DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c,
> quirk_no_flr);
