Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81E2814E2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgJBOUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 10:20:19 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:6128
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgJBOUS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 10:20:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg4PRYsahHpXMieROBl9SRi1Ldj0IIcA5hpAL1YdvFwl5y5a4oWa30IToXXGH+V8A02Yb/bzpxP+F3SXUV9AT0idrbx0PsQax5482F/AjXnIHqLPDfw5j8U8hAFG1R23q9oMdWVbZEiYiqenR+7UsOh/InFwHRNrtCtZRW3e8IWYfRuaPTFC081t8b+pV2B4Lt908ec3e3nvKhS8qIgJqGH7vXTvrzoFmtlg9v9BiIUjtz9ISYUqSc46jhUW/CsweDvTQJEtw6XhsK+AszRiSTrVZYCB1pP9xc9lcW+y8ZkkEpCDJgg1vwjQ7zOJ/OrqMozbRGm//DrPOLWpM8ojpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SpSV8cSJBfwJsJidw5m7wRIwUm7EUCHc59PkTM9DTg=;
 b=gp7xGnMbGuFIC4ZTPjfuQgIVZBCf51YemIU7S4i2Qpyye6+eqBcGNHwsOUTNHH6kJtCvVnUQ5P1w0K4lXoF5DN9x+JDhUkm0ufIh7NQu4S7fzJZuzP4gdOV6LyxJUsbGXKXiQawzVQbC5nZ0qwANkJ2BT9tVEZsWBH7zjKu/+p3JQfh4HIrN+sfnV3OVJ8eVwGhtQ+9CKQ4E81KHOHI4hXesIcqXHgfihE7paSAoI1oWhl9I8a1DZKRClLOzHd1mYjJ5JhqGMcanKc2O1wEPJy453otaHgJGBiuhCeiG4cNy05rNXam6gw90qksUZ1TF/2RdKJBP9wE74MbId7dmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SpSV8cSJBfwJsJidw5m7wRIwUm7EUCHc59PkTM9DTg=;
 b=z01uS5QZjxpH+I16kS8TN5BYzJSSyuVGUXGS47cFS0/WOd79kLB1by5+An78UVpRuaw84NCYJaTCZnbYj6n73L35zxBuiVZXc+hZL59epJZAlQHU3Zx2ytTUv9f+dzPBbiZkjVudpgLwTrdZTYYQc1nxIvBVbaj1o6xwIa0B2KI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 14:20:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3433.036; Fri, 2 Oct 2020
 14:20:15 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
CC:     Aaron Zakhrov <aaron.zakhrov@gmail.com>,
        Michal Rostecki <mrostecki@suse.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shai Coleman <git@shaicoleman.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arthur Borsboom <arthurborsboom@gmail.com>,
        matoro <matoro@airmail.cc>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power managed
 by ACPI
Thread-Topic: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power
 managed by ACPI
Thread-Index: AQHWmHqRW/ArdKHcKEup0PjEoxxiSamEXH+AgAAAcUA=
Date:   Fri, 2 Oct 2020 14:20:14 +0000
Message-ID: <MN2PR12MB44888EB0D4D9B3B1D43698B6F7310@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
 <CAJZ5v0h5dHp6C8rx-B-hS=6hJOvTHuY1K4590qkNzCAkoivK4g@mail.gmail.com>
In-Reply-To: <CAJZ5v0h5dHp6C8rx-B-hS=6hJOvTHuY1K4590qkNzCAkoivK4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-02T14:18:53Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6e2363ce-1f2e-40b3-99db-000067953a86;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-02T14:20:11Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a029e62d-f809-4b24-91b6-00007543ee45
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c171426c-b8b8-482c-2da3-08d866de480f
x-ms-traffictypediagnostic: MN2PR12MB4406:
x-microsoft-antispam-prvs: <MN2PR12MB4406CCDD5BC46E3261CF7ED6F7310@MN2PR12MB4406.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N140TANWlBxS045jgkzH6w9q6pkS+ft97uhaG/8fd2Ptw8co8RXHyKGrb0T/k6CyOKm+PQdNbRWzaKppNJV2cMAJyGbVGXBtkndYYt+dQoEuIucFh7r1Lu0Eqn/EkHUkHm/n7642fR4rsZcgp2Q3HCJxvziDSsiTSdKmBc4Wz4fCHhIwmvk1RdIUUkAANL8XOOzf0SWFZQr9T/v+JCvihW52jUELrqafFEFM3r/LtrI4bmB4cYnmB35SPMW2xWt1xT3VWbbFqBWyZkFOV7N6YDvDm8oMzBQt7ZtFYr6K5WiDToQMBM+WeKXq+SOs5rPb/6xBMl7BEYoOy4iPzibAWdNxqjzKvXziC58rIPFj9vEw/WEhLzcDlHSk+cbPrwniEaRMu5esDCJKDm4yUBRR0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(316002)(86362001)(83080400001)(54906003)(83380400001)(26005)(478600001)(966005)(110136005)(33656002)(45080400002)(66446008)(64756008)(66476007)(5660300002)(4326008)(76116006)(2906002)(52536014)(8676002)(66946007)(186003)(66556008)(6506007)(53546011)(8936002)(55016002)(7416002)(9686003)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8Ea2IsxsL8HnUGWQHIujGNRRU1Ty+SKh+H2l0vsOVbqqLxD9/MqFrqZ+5T88yu+DSGHKpczjtJ9wm7/mzJXt/WENFpQanKZdLfVvd5NTV3u67LbU+b7uHCXlZY/tH4vNyYUwHSqoEeHk89rTgb61sX6TDi4NseGSEwa5iC/3yjZdfm5tlUhRhIN3JbCX2APlYnxTU/I7UU2NIuPODEqsBuFB3VlkTamN21fXAp3Yeb/230XeQyp0TXSrbSni/rumi2sbvGlG/0VsjStvSnOj5+X7R1g2gmez9NNrq1WvWT32/NL/swkUaaEhu407/XJvZb9/KFjO5vXsZEO3v9Wn4cmdB6kNHvSn/C71iTWQWXsakEwpnakh8HQdypwBdisrwD3LXt3p5r+nXlBbpelgpAbqwREsxUoPXsMqWTshoJjwbtZSKANXDc4gxl7FAKVKivv46mZ8vQTXvxSg5M8NzBRtbT0hvCBtRrflqj1UsDNv1ReuaE/l3m+CF3B0oNbdE4EaLt8RXSh/OkFAKzot3ikJsOtUhlfFPsMSa86sKo5ttapvAvb7GkpjkV86R/SJFueOT/0sdVnZb3fY/hhOxZmizM0c0RG9cwN2Iht9T/8Bs9HvDZ17PRMEQWFChgao1qOubc8yEaKHoFUw7meopw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c171426c-b8b8-482c-2da3-08d866de480f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 14:20:15.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HpoVNpbEz8s0SpxitOopR7QeuiPlIG5v9f4EOrH5Nhx523NizibpkMHrj6gSM0wS+R/zlZlWb6LdhYuYBw3Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Rafael J. Wysocki
> Sent: Friday, October 2, 2020 10:17 AM
> To: Lukas Wunner <lukas@wunner.de>
> Cc: Aaron Zakhrov <aaron.zakhrov@gmail.com>; Michal Rostecki
> <mrostecki@suse.com>; Linux PCI <linux-pci@vger.kernel.org>; Rafael J.
> Wysocki <rjw@rjwysocki.net>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>; ACPI Devel Maling List <linux-
> acpi@vger.kernel.org>; Shai Coleman <git@shaicoleman.com>; Bjorn
> Helgaas <helgaas@kernel.org>; Arthur Borsboom
> <arthurborsboom@gmail.com>; matoro <matoro@airmail.cc>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Len Brown <lenb@kernel.org>
> Subject: Re: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power
> managed by ACPI
>=20
> On Fri, Oct 2, 2020 at 7:17 AM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > Recent laptops with dual AMD GPUs fail to suspend the discrete GPU,
> > thus causing lockups on system sleep and high power consumption at
> runtime.
> > The discrete GPU would normally be suspended to D3cold by turning off
> > ACPI _PR3 Power Resources of the Root Port above the GPU.
> >
> > However on affected systems, the Root Port is hotplug-capable and
> > pci_bridge_d3_possible() only allows hotplug ports to go to D3 if they
> > belong to a Thunderbolt device or if the Root Port possesses a
> > "HotPlugSupportInD3" ACPI property.  Neither is the case on affected
> > laptops.  The reason for whitelisting only specific, known to work
> > hotplug ports for D3 is that there have been reports of SkyLake
> > Xeon-SP systems raising Hardware Error NMIs upon suspending their
> hotplug ports:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
> > .kernel.org%2Flinux-pci%2F20170503180426.GA4058%40otc-nc-
> 03%2F&amp;dat
> >
> a=3D02%7C01%7Calexander.deucher%40amd.com%7C99ec20b6d4dc410baf800
> 8d866dd
> >
> e688%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6373724505855
> 84491&a
> >
> mp;sdata=3DEPFyxPA0MDBuAkvH7bbp2wHYnpos8p%2BoZmzlUvvdAek%3D&a
> mp;reserved
> > =3D0
> >
> > But if a hotplug port is power manageable by ACPI (as can be detected
> > through presence of Power Resources and corresponding _PS0 and _PS3
> > methods) then it ought to be safe to suspend it to D3.  To this end,
> > amend acpi_pci_bridge_d3() to whitelist such ports for D3.
> >
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1222&amp;data=3D02%7C01%7C
> >
> alexander.deucher%40amd.com%7C99ec20b6d4dc410baf8008d866dde688%
> 7C3dd89
> >
> 61fe4884e608e11a82d994e183d%7C0%7C0%7C637372450585584491&amp;sd
> ata=3DcMj
> >
> LDIbjp8RQiWX8pgK2bDUH%2B0u3oquy3TqeT9QjZGE%3D&amp;reserved=3D0
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1252&amp;data=3D02%7C01%7C
> >
> alexander.deucher%40amd.com%7C99ec20b6d4dc410baf8008d866dde688%
> 7C3dd89
> >
> 61fe4884e608e11a82d994e183d%7C0%7C0%7C637372450585584491&amp;sd
> ata=3DiP9
> >
> EqNcM15Dj4Ax%2BE6e2HaMWHEX%2B0IO3cMoi0NXWGzM%3D&amp;reser
> ved=3D0
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1304&amp;data=3D02%7C01%7C
> >
> alexander.deucher%40amd.com%7C99ec20b6d4dc410baf8008d866dde688%
> 7C3dd89
> >
> 61fe4884e608e11a82d994e183d%7C0%7C0%7C637372450585584491&amp;sd
> ata=3DVlT
> > UV2UCH4RvKgTXZcpGOpkjZpfijmPgwtvKx6HRT04%3D&amp;reserved=3D0
> > Reported-and-tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > Reported-and-tested-by: matoro <matoro@airmail.cc>
> > Reported-by: Aaron Zakhrov <aaron.zakhrov@gmail.com>
> > Reported-by: Michal Rostecki <mrostecki@suse.com>
> > Reported-by: Shai Coleman <git@shaicoleman.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/pci-acpi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c index
> > d5869a0..d9aa551 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -944,6 +944,16 @@ static bool acpi_pci_bridge_d3(struct pci_dev
> *dev)
> >         if (!dev->is_hotplug_bridge)
> >                 return false;
> >
> > +       /* Assume D3 support if the bridge is power-manageable by ACPI.=
 */
> > +       adev =3D ACPI_COMPANION(&dev->dev);
> > +       if (!adev && !pci_dev_is_added(dev)) {
> > +               adev =3D acpi_pci_find_companion(&dev->dev);
> > +               ACPI_COMPANION_SET(&dev->dev, adev);
> > +       }
> > +
> > +       if (adev && acpi_device_power_manageable(adev))
> > +               return true;
> > +
> >         /*
> >          * Look for a special _DSD property for the root port and if it
> >          * is set we know the hierarchy behind it supports D3 just fine=
.
> > --
>=20
> I'm going to apply this patch for 5.10 unless Bjorn would rather route it
> through the PCI tree.

Any chance we can get this into stable at some point as well?  It would be =
nice to fix the laptops out there in the wild running older kernels.

Alex
