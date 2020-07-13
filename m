Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C721E32C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 00:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGMWsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 18:48:42 -0400
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:2351
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgGMWsl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 18:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLpwYS3ymqtttRB8MQ50iqHwiw20bK8pPiaE5i9gPhNeXh2DRCGW+cbgf2GyxSHX/oSPlprtNZYi3u87mnTWXevoE+eIpzy7KM+5T95c/SlL09j2FDwdgLDrz0ZBFyZ4hWSPW7FVJ8Ht16tEh5eegHxgiisWcnkWa/c3EgTC8Tw/Q9coJZz2W5sNtPNfLSYtnlsU+jW+TVV7suqCWUTSLI1fyWGe+EcgmD+EWPTRdKSR1YWRibpSSJs1g1/W3KJ0Rz4Z5ahkKb34cVN8xHP0bMS0zu26X6sX3BL3seQkRxkq5rYPJrHdpF2KWQoy7Jv1VvK66WhDGGlTXUuECbE7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3N313ogYZPLbKqibcKqfMd0pLqESh7yF2X93tmaGFg=;
 b=SZzoG/ibCyMnXUrZo5oi5llq8Oq+cp70MSkBCM3JDXR6E3EMQ7TFYhVENvEICxe0xcSxTEncNWU/AbdNdtDLPjE04+OBGxxrdU2LZKw5MLcjjNhKm/KJenyu2do8Gt3QhBcSRKWRTUs3wQYei9V9I5aN/T7n1lTcs+bWIto1gsLj8x4/OA/nKtcbNsFJvJCjOKTDUXfggwFWqt62Fh8dBVh55GET1W0DAQSoV+30BnSPbWFtkE7JKnSLyHdIUEBw58hIXbH+zGL+9mRlyYG16iWmijdQyLyYMLYXH3C7D3/jsqEMZG61r5YvPeApDqiewUSZ8U3gmXMfljKbMpS3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3N313ogYZPLbKqibcKqfMd0pLqESh7yF2X93tmaGFg=;
 b=VbnKf/c8cWmoqpB/BexFqPE9jQ+rS7p4Bj7D9qsHHKv/88Y2KFCIemES+O3B771EwDHozppK8ggKedwgqGZD/TuYPLg+LQ7snWwj3fibzCVdlxx9ZhNVdHcAFtnGGa++/JsYm+FOU26mGVIRefHRJwE6G7drQGzMyhv1/saPJIk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 22:48:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%6]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 22:48:36 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Marcos Scriven <marcos@scriven.org>
CC:     "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Kevin Buettner <kevinb@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
Thread-Topic: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
Thread-Index: AQHWNG42jRTQBk1do0S3m0V1mtJWrqi8dW2AgACxSICAEeojAIABLcqAgBkNmwCAHHGqAIAAn0qAgAAIpuA=
Date:   Mon, 13 Jul 2020 22:48:36 +0000
Message-ID: <MN2PR12MB448830959FDA665230B94FCBF7600@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <CAAri2DpQnrGH5bnjC==W+HmnD4XMh8gcp9u-_LQ=K-jtrdHwAg@mail.gmail.com>
 <20200713221451.GA285058@bjorn-Precision-5520>
In-Reply-To: <20200713221451.GA285058@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-13T22:48:32Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f41c828e-513c-49bd-8259-0000eb9eab11;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-13T22:48:22Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4a502395-ec89-47d2-85d0-0000b51a088e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-13T22:48:34Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 50c27079-e0ac-4d72-810b-000045f87e82
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fa71002-f2a5-49b4-ffe2-08d8277ee120
x-ms-traffictypediagnostic: MN2PR12MB4046:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB404636E996354217EF018529F7600@MN2PR12MB4046.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w3BXR4GyxYYlX+UKhlOF939aNg/wQRBt3R7+4WQ0ORkMsvKgw20EB8hvJ4qqUTiW9rEjR4eOhGqynnQCrMNCxC598LJEcsG3v99xhWAZoEPmLIg//+IBWnOlFvqbaTt+0SKzPuA3wnePsh7Rhao77deeGA6ClpCP1bnJ380ZuBZLfUx24Y8P1HUJHdrsrqoJ/edZ37eHW4HuhBDoBLns+rKlV05dsuuyO3K2+3lH8Nw9xg08bEsrvqfcktZasVqfLTi/v3yHW7dWyYLZEVEZH/3I9O5JNqRKnfpB2a2HvJ7qZ029zQa/8GkMaB568X+PRJtOjEiRB28lAB9WkCmUqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(478600001)(86362001)(76116006)(53546011)(5660300002)(66476007)(54906003)(110136005)(2906002)(66946007)(6506007)(66556008)(7696005)(71200400001)(9686003)(55016002)(26005)(66446008)(4326008)(52536014)(64756008)(316002)(8936002)(33656002)(8676002)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4dtJDr1GS1A3wtBNq9/avPjIboHJ8Fs/Mzt9UVvHvr41VZrnYcV4nAKQZnUAIE+9Xp8+J7jb0wXhgWdKnPNMTf3hgJBt6JpGb4hqPRGZV3guu6fjoTXArBTbV2SL9BXyQ7kyAzpt/Ma/sdQt3G60OeDPHuY2agX+Hg7JvKc3WQvsfClyguUynMb48lo8DwMcN647gexdNr+XojLbLaDabcKtCjNdvmSgkIAqkGOfNUluDtEAqpgGx7HuhpsnRpBJKzDqrSwQG1UxuhLD1smNMxDUjoiJhDaVmPowKj4hnWKUd3TsNdzLN22Dg9JQhZ0A89oTmchmEhe1SdBeVCwXfjxazCkrqQoz3446q533h3SbzVQqrENGaNAJzfKnR2c7x7a3b3s1eQmOskvznSdlt+1IzpCysRA4fxkyw5SUKJLVrcJhnEloR3Fq4OVPm9XKm8AD3i4TdyDWEG9u6/3sgEytqsj974bhh5EJPBQ/vxJ8OvHKr0gQsHtVKGctH32h
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa71002-f2a5-49b4-ffe2-08d8277ee120
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 22:48:36.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIT3WOO/RCJKIfHVAQoaP0zJJq73HuuEiIgZxFlNk0dVnLmkOrAwye4jgANbV99FJR6LBkxC76VyLfedFOYb5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, July 13, 2020 6:15 PM
> To: Marcos Scriven <marcos@scriven.org>
> Cc: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Kevin Buettner
> <kevinb@redhat.com>; linux-pci@vger.kernel.org; Bjorn Helgaas
> <bhelgaas@google.com>; Alex Williamson <alex.williamson@redhat.com>;
> Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
>=20
> On Mon, Jul 13, 2020 at 01:44:44PM +0100, Marcos Scriven wrote:
> > On Thu, 25 Jun 2020 at 11:22, Marcos Scriven <marcos@scriven.org> wrote=
:
> > > On Tue, 9 Jun 2020 at 12:47, Shah, Nehal-bakulchandra
> > > <nehal-bakulchandra.shah@amd.com> wrote:
> > > > On 6/8/2020 11:17 PM, Marcos Scriven wrote:
> > > > > On Thu, 28 May 2020 at 09:12, Marcos Scriven
> > > > > <marcos@scriven.org>
> > > wrote:
> > > > >> On Wed, 27 May 2020 at 22:42, Deucher, Alexander
> > > > >> <Alexander.Deucher@amd.com> wrote:
> > > > >>>> -----Original Message-----
> > > > >>>> From: Bjorn Helgaas <helgaas@kernel.org>
> > > > >>>>
> > > > >>>> [+cc Alex D, Christian -- do you guys have any contacts or
> > > > >>>> insight
> > > into why we
> > > > >>>> suddenly have three new AMD devices that advertise FLR
> > > > >>>> support but
> > > it
> > > > >>>> doesn't work?  Are we doing something wrong in Linux, or are
> > > > >>>> these
> > > devices
> > > > >>>> defective?
> > > > >>> +Nehal who handles our USB drivers.
> > > > >>>
> > > > >>> Nehal any ideas about FLR or whether it should be advertised?
> > > > >>>
> > > > Sorry for the delay. We are looking into this with BIOS team. I
> > > > shall
> > > revert soon on this.
> > >
> > > Sorry to keep pestering about this, but wondering if there's any
> > > movement on this?
> > >
> > > Is it something that's likely to be fixed and actually rolled out by
> > > motherboard manufacturers?
> > >
> > > There's been some grumblings in the community about adding
> > > workarounds rather than fixing, so it would be good to pass on
> expectations here.
> >
> > Any word on this please? Would be keen to know if the BIOS can be
> > fixed, and this workaround can eventually be dropped.
>=20
> Just to clarify what the possible outcomes are:
>=20
>   1) If these AMD devices are defective, but future ones are fixed, we
>   keep the quirk.
>=20
>   2) If these AMD devices are defective *and* future ones are also
>   defective, we keep the quirk and keep adding device IDs to it.
>=20
>   3) If the BIOS is defective, we keep the quirk.  If anybody cares
>   about FLR enough, they can make the quirk smart enough to identify
>   fixed BIOS versions and enable FLR.
>=20
>   4) If Linux is defective, we can fix Linux and drop the quirk.
>=20
> The ideal outcome would be 4), but we don't have any indication that Linu=
x is
> doing something wrong.
>=20
> What we're really trying to avoid is 2) because that means new devices wi=
ll
> break Linux until somebody figures out the problem again, updates the qui=
rk,
> and gets the update into distro kernels.
>=20
> In case 3), we don't drop the quirk because that forces people to upgrade
> their BIOS, and most people will not.  We can't drop the quirk, reintrodu=
ce
> the problem on old BIOSes, and hide behind the excuse of "you need to
> upgrade the BIOS."  That wastes the user's time and our time.
>=20

Understood.  Just trying to find the right people internally to understand =
what has been validated and productized with respect to FLR on various peri=
pherals.

Alex

> > > > >>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > >>>>> index 43a0c2ce635e..b1db58d00d2b 100644
> > > > >>>>> --- a/drivers/pci/quirks.c
> > > > >>>>> +++ b/drivers/pci/quirks.c
> > > > >>>>> @@ -5133,6 +5133,7 @@
> > > > >>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,
> > > > >>>> quirk_intel_qat_vf_cap);
> > > > >>>>>   * FLR may cause the following to devices to hang:
> > > > >>>>>   *
> > > > >>>>>   * AMD Starship/Matisse HD Audio Controller 0x1487
> > > > >>>>> + * AMD Starship USB 3.0 Host Controller 0x148c
> > > > >>>>>   * AMD Matisse USB 3.0 Host Controller 0x149c
> > > > >>>>>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
> > > > >>>>>   * Intel 82579V Gigabit Ethernet Controller 0x1503 @@
> > > > >>>>> -5143,6
> > > +5144,7
> > > > >>>>> @@ static void quirk_no_flr(struct pci_dev *dev)
> > > > >>>>>     dev->dev_flags |=3D PCI_DEV_FLAGS_NO_FLR_RESET;  }
> > > > >>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487,
> > > > >>>>> quirk_no_flr);
> > > > >>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c,
> > > > >>>> quirk_no_flr);
> > > > >>>>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c,
> > > > >>>> quirk_no_flr);
> > > > >>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502,
> > > > >>>> quirk_no_flr);
> > > > >>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503,
> > > > >>>> quirk_no_flr);
> > > >
> > > > Regard
> > > >
> > > > Nehal Shah
> > > >
> > >
