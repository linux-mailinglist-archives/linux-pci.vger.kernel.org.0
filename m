Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57EC6686AD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 23:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjALWRH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 17:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjALWQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 17:16:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF568CB8;
        Thu, 12 Jan 2023 14:09:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYR8wElba0GX4+7yzDVaVuH8Z4uxEeiMzn2iW4mjO4kXo0Qq6kv3H1o8hiW7qw4akbuiHRbne5i1aK4vVX0ymHQESKyAc/QyuezDB63jG0mBKou0weoZlVr6X0rq10+Ng/q/PbbyFIl4+RAQD587Ce1Bu10Q9aT57gskqZ7g2R1Xzs6x+NoRiH5i+EZFotANJ6ZnC+QRpP3GfqBE0kGbjEQceuRcYI+6Ph3SEdsNi230lBSuHLjfJyiTIwrluIXvEfZvgw6T1Jc1PPXFfI+1B3DSVoE65iczx82mu3tldUr/nCLV4bjWeL01ZVSgAikfQKWzWrTMP1qFvACcG/ypBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJiDSZDXFElS2kxVC1AbxzeGXD0Ur4jNIAkQqhbxYJI=;
 b=idUPuIxk37BocYFk7COdDSKPqeIxf5HV/jW2mzUcKcAUtW9aUh8XSSYST0bbG+sK3V+i8/83c12z4W2z9+26CroDmj/ShyWMfXivIvqEVkU87itRgmZQKH8W08FpcG/SmePO1NiyeD2CuOQu2/hqIJQ70BPur7XMGz5313AFP8wXjl5kObG9ZloL62MtQwMLLQsfPoG4FzzO/6B6PkKGHQRAGamEooBIUd0JOvLgSMbB+ep+FhZeHNjGRDOLe/tH+MWTlfOl4Sz8YAMhtMzB80NF2ch2KM1p9sKiwx5m/sl7EMBlNyoYYoYCHBiiMTdZyCkusdl/IgiwjxU4F35wEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJiDSZDXFElS2kxVC1AbxzeGXD0Ur4jNIAkQqhbxYJI=;
 b=Yg2gFgyUzf0gdiHaWu1K9W3shBjIht040T9gfjd3oscFQj8wleJd3UfoUxCaqFsNAMk2KbZut7bDG7Scb8CNMByOaT4Tet0C8e6xnKLR/jh1j9JuAobtRl0+6tS33xDdY7JwREBy1z8G+2W650ZeIHKpyqEofMRp6E2bedBwj3A=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 22:09:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 22:09:21 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridge into
 account in acpi_pci_bridge_d3(()
Thread-Topic: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridge into
 account in acpi_pci_bridge_d3(()
Thread-Index: AQHZJseoN/xcWk1Uu0CFj4KpEohgeK6bVWqAgAAAjtA=
Date:   Thu, 12 Jan 2023 22:09:21 +0000
Message-ID: <MN0PR12MB61013E30A82224755A81B0BEE2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <12155458.O9o76ZdvQC@kreacher> <20230112220157.GA1795768@bhelgaas>
In-Reply-To: <20230112220157.GA1795768@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-12T22:09:13Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4624138e-5a72-4390-8af5-d3f229285035;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-12T22:09:20Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3e0f7a4d-ed97-484e-9037-88eca5f43de3
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS0PR12MB8573:EE_
x-ms-office365-filtering-correlation-id: 0084be3f-edeb-4776-f1f2-08daf4e9a847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eCmqJ2YDe7O5rt0gQX8GR4YLWD8QfJ8XC9cip/yJELVJV8lk1V+odAXzt+xmRJBNaDzzgd8SdfJuFgoy+k2GGSPOqsZpIOjDs3BcKIYrhpIVFS3lN0cuHxYiVhk3CYCDOfCT3OgRD0AafuaBBh71GCnfmtfQ43o51PIkH5mfRNMix5dWqk+bXXHgKLaQkx6IcbdkeqEHW9FXpRH5yH0vaQUlwRTW/Vkbk4tvDlonY9/rXmBntvoi/jJHI1U9DSDmbslQquBgKxKG+Z9QPaPuaVaLJZQtBfR0piAx3Q8gmZvJu32ga3kwpyEjiVks7aV3YxgemPT/5d2a9kHMaGjROI+vRM9OzVVMymXJE+FhDq72ZtDiSA4o+thhGze5o391b7KCHqUijkfHeU0CgZpSRJyk6B6x7IeOC9jGe31omPnUbaJdCHwy7wc/7fT9qlrsrIThOAhxD70UkFA+67BZfLB2qTNash03QbqnA1gQc4RNLNAKsnkh5Z0ILbp1mMBsxTBUL+IcpsGKwEuBPL3EaV0BnBl8p23iutqwj6So4KXbCVffP1w9tDIHY5S+KNNC+HKvzPk1YWl9UvSYA8x0wuX4QuomcbeXz7L95KEb9pGXFoWXREbQ4CNEyn2yuvN3TZXaF82zE9trSiaag+KunI/JjdH7elagUMyDrcqWMcgl9HnYnJgyYSzdPhSWr6GOLbjaYiZ+mw/+pF9KTDs5NMrCubRpUoq8DUeOdzM/QqX5i7sLUyXB4L4x/3XjT/sDF4hDXd8swyxPxbQykyy0FA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(53546011)(71200400001)(2906002)(15650500001)(6506007)(9686003)(84970400001)(966005)(7696005)(478600001)(186003)(66899015)(64756008)(110136005)(66476007)(66556008)(76116006)(66446008)(4326008)(41300700001)(316002)(8676002)(66574015)(66946007)(5660300002)(33656002)(54906003)(7416002)(8936002)(122000001)(83380400001)(38100700002)(52536014)(86362001)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q1O/BkQ2lbotSUBWmYl/xrZX5j/h09jhWL0lYHJHvAeq+WLjd3eDFeo0Iywi?=
 =?us-ascii?Q?aZLMeQBQ7fwGHtb62aCbflmm4i6xZBRXsBwWgrKB2PcAhGuFXrioem2YpTG5?=
 =?us-ascii?Q?zszN1sSbF02RM5hy3Pymhk9X7U8Vxt+UHuVO67XnZQBwLt8OEiSY+hsFN1Z+?=
 =?us-ascii?Q?GoEN+bV5FrNOdUl0PRXE35uGbDkP+dDiQriyB7tEjlObZw2YEp+pDyOHuD56?=
 =?us-ascii?Q?pQCkjn6tLd5yBRblnVYcGW4QLMRZ5DicjOkE94Hupx6dh1u9qt4n0aKtVcON?=
 =?us-ascii?Q?uEtwsjnO9nQRkcSIPCiHas6rHiqwrc8+x3fGgkOJNsh3u5IUvcnqiuVpxNdL?=
 =?us-ascii?Q?DBNbYyYuua7MMuNYDyjAABImdo3kl3KFouf6MknGLrU7HNwgyFY50RSd42CG?=
 =?us-ascii?Q?NwzNG/l3SxA7etoRk3tU8AkoK0m1I6lq9q5ZBuvUekgFULtlEriGB1wURZUF?=
 =?us-ascii?Q?+fpYVJsYdvaXE+35yL1KIWm/TYdV5juOe/k8jU3VBYdJboMwZwKCscviRu7F?=
 =?us-ascii?Q?Ho1rMhaGtok3VYB8jki7EGpjskj7XQyQYOlEghNxZd/RwdO9/9IxqBLPT6Gm?=
 =?us-ascii?Q?IqwsKDJUaU0SINSeGs7QFdqLDcidxQJThn7Md2RCCkbWSrWA/ebK2zDpFbRO?=
 =?us-ascii?Q?1bpLgoo7nEcd7OXH43NnVS7KobuB3ExEJpdJ5KfOdSQ2cNudAGT+Wy5fEMsz?=
 =?us-ascii?Q?bCRR4hw/cC1UV0/zYcMpM5so0Vo5McAz8DR1w1QMCGnoFATZ4yApt9O4jKu5?=
 =?us-ascii?Q?soh3laFdDQxmVnO0Gk1CfP606LkWCn1yMh3KyZT0KmXWJ+6eX2cvuuElsVvO?=
 =?us-ascii?Q?DnVBFxKT/8ndqrqN/k3jhsIndIcaKHuw+svcwIIp6K/YJXluZSLXgz8WW5Uu?=
 =?us-ascii?Q?sfXKeZbjm+4csRFrsfFuSSbC/yjZZoyAYaumDU+rj3cmJRZFtTgWNmAvUv75?=
 =?us-ascii?Q?lxO2/4LQOoMCC9y3/bWlOeM0x6Slz5BdkUiC2ZYdCzdgSsiSIy2XRCBiOfT+?=
 =?us-ascii?Q?Tk2vCgMzWlgOv661d4eVLao9l7gjhfg6v7GQWUnZ02bjWnP39xMfxgGqMzOv?=
 =?us-ascii?Q?RaQauJCP49YdyPW4Z3SvWeTNH2DE1fLt/WEf+y03TPsqjoYPPCFo69S/ZL0+?=
 =?us-ascii?Q?taTpwb8f79qRez57Rr9sknbUmsyK2TgqThvDqvWP6rg+eMbgA+2Go8BU7WO2?=
 =?us-ascii?Q?ueqOU8B9b4M/aVMubieCtwldpdbDO0OtTm+e0K4CCb9TvST8Wsw2cA13Oj+0?=
 =?us-ascii?Q?KxHcIa5P1XUA1St72fUb9pcgGGI+z3ZuLGmTAaShuN8dUlLA1ucDZhMhzpWG?=
 =?us-ascii?Q?jdkBD0VErntDiW+nq0hEwWYPtlEFakmT/snv/HqNQNG6qMd/n2ktfmwmG5po?=
 =?us-ascii?Q?kgRMu+7ooy9tImqDENvC6yds0Hed28sbW8ObBVgDDDMqA60irgQG4eaCq0P0?=
 =?us-ascii?Q?Zuiqn/iCIfyhVgZDKlHn+rc/oL9YoApfRTO/D0LLR8A+nNI0oxDYKyCoOni0?=
 =?us-ascii?Q?Aj1vUrJot3RqprGbnvGWpcM3u1KYCywfKAXBL0hDwgxRFyLC1YS9HdzPXkal?=
 =?us-ascii?Q?JRtYqV0oZJFWK42wkLDb9DpjTeSyYt+2GqYJLr72T1rNJKROrnnyVwrFrHX2?=
 =?us-ascii?Q?WLvfJ215r3L0KbsZwcf/pt0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0084be3f-edeb-4776-f1f2-08daf4e9a847
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 22:09:21.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crhNJOKPUgyxfo+MMbMTZ68MJ1i65hs1C7ckfrAHmjzP+9uBGTyldneCcxfBuXv2fxl6/zNOnIsTsnCej6gJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, January 12, 2023 16:02
> To: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pci@vger.kernel.org; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Rafael J. Wysocki <rafael@kernel.org>; Len
> Brown <lenb@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Mika
> Westerberg <mika.westerberg@linux.intel.com>; Mehta, Sanju
> <Sanju.Mehta@amd.com>; Lukas Wunner <lukas@wunner.de>; Rafael J .
> Wysocki <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>
> Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridge in=
to
> account in acpi_pci_bridge_d3(()
>=20
> On Thu, Jan 12, 2023 at 09:51:24PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is generally questionable to allow a PCI bridge to go into D3 if
> > it has _S0W returning D2 or a shallower power state, so modify
> > acpi_pci_bridge_d3(() to always take the return value of _S0W for the
> > target bridge into accout.  That is, make it return 'false' if _S0W
> > returns D2 or a shallower power state for the target bridge regardless
> > of its ancestor PCIe Root Port properties.  Of course, this also causes
> > 'false' to be returned if the PCIe Root Port itself is the target and
> > its _S0W returns D2 or a shallower power state.
> >
> > However, still allow bridges without _S0W that are power-manageable via
> > ACPI to enter D3 to retain the current code behavior in that case.
> >
> > Link: https://lore.kernel.org/linux-pci/20221031223356.32570-1-
> mario.limonciello@amd.com/
> > Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Applied to pci/pm for v6.3, thanks!
>=20
> It'd be great if we could include a short description of the problems
> users might see.  I think the original problem was that on some AMD
> systems we put a USB4 router in D3 when it should remain in D0.  And I
> assume this means something doesn't wake up when it should?  Or maybe
> we miss a hotplug event?
>=20
> If somebody has an example or some text, I'll add it to the commit
> log.

Here's a blurb for what happens on AMD side:

When the platform is configured to not allow the PCIe port used for tunneli=
ng
to wakeup from D3 it will runtime suspend into D0 and the USB4 controller
which is a consumer will runtime suspend into D3.

This inconsistency leads to failures to initialize PCIe tunnels for USB4 de=
vices.

>=20
> > ---
> >
> > v3 -> v4:
> >    * Use ACPI_STATE_D2 in the checks in acpi_pci_bridge_d3().
> >
> > v2 -> v3:
> >    * Use rpadev for the ACPI companion of the Root Port in
> acpi_pci_bridge_d3(()
> >      to avoid confusion.
> >    * Make the function evaluating _S0W return the value produced by it =
or
> "unknown
> >      state" on errors and let its caller deal with that value.
> >
> > ---
> >  drivers/acpi/device_pm.c |   19 +++++++++++++++++++
> >  drivers/pci/pci-acpi.c   |   45 +++++++++++++++++++++++++++++++-------
> -------
> >  include/acpi/acpi_bus.h  |    1 +
> >  3 files changed, 51 insertions(+), 14 deletions(-)
> >
> > Index: linux-pm/drivers/pci/pci-acpi.c
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/pci/pci-acpi.c
> > +++ linux-pm/drivers/pci/pci-acpi.c
> > @@ -976,24 +976,41 @@ bool acpi_pci_power_manageable(struct pc
> >  bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >  {
> >  	struct pci_dev *rpdev;
> > -	struct acpi_device *adev;
> > -	acpi_status status;
> > -	unsigned long long state;
> > +	struct acpi_device *adev, *rpadev;
> >  	const union acpi_object *obj;
> >
> >  	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
> >  		return false;
> >
> > -	/* Assume D3 support if the bridge is power-manageable by ACPI. */
> > -	if (acpi_pci_power_manageable(dev))
> > -		return true;
> > +	adev =3D ACPI_COMPANION(&dev->dev);
> > +	if (adev) {
> > +		/*
> > +		 * If the bridge has _S0W, whether or not it can go into D3
> > +		 * depends on what is returned by that object.  In particular,
> > +		 * if the power state returned by _S0W is D2 or shallower,
> > +		 * entering D3 should not be allowed.
> > +		 */
> > +		if (acpi_dev_power_state_for_wake(adev) <=3D
> ACPI_STATE_D2)
> > +			return false;
> > +
> > +		/*
> > +		 * Otherwise, assume that the bridge can enter D3 so long as
> it
> > +		 * is power-manageable via ACPI.
> > +		 */
> > +		if (acpi_device_power_manageable(adev))
> > +			return true;
> > +	}
> >
> >  	rpdev =3D pcie_find_root_port(dev);
> >  	if (!rpdev)
> >  		return false;
> >
> > -	adev =3D ACPI_COMPANION(&rpdev->dev);
> > -	if (!adev)
> > +	if (rpdev =3D=3D dev)
> > +		rpadev =3D adev;
> > +	else
> > +		rpadev =3D ACPI_COMPANION(&rpdev->dev);
> > +
> > +	if (!rpadev)
> >  		return false;
> >
> >  	/*
> > @@ -1001,15 +1018,15 @@ bool acpi_pci_bridge_d3(struct pci_dev *
> >  	 * doesn't supply a wakeup GPE via _PRW, it cannot signal hotplug
> >  	 * events from low-power states including D3hot and D3cold.
> >  	 */
> > -	if (!adev->wakeup.flags.valid)
> > +	if (!rpadev->wakeup.flags.valid)
> >  		return false;
> >
> >  	/*
> > -	 * If the Root Port cannot wake itself from D3hot or D3cold, we
> > -	 * can't use D3.
> > +	 * In the bridge-below-a-Root-Port case, evaluate _S0W for the Root
> Port
> > +	 * to verify whether or not it can signal wakeup from D3.
> >  	 */
> > -	status =3D acpi_evaluate_integer(adev->handle, "_S0W", NULL,
> &state);
> > -	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
> > +	if (rpadev !=3D adev &&
> > +	    acpi_dev_power_state_for_wake(rpadev) <=3D ACPI_STATE_D2)
> >  		return false;
> >
> >  	/*
> > @@ -1018,7 +1035,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *
> >  	 * bridges *below* that Root Port can also signal hotplug events
> >  	 * while in D3.
> >  	 */
> > -	if (!acpi_dev_get_property(adev, "HotPlugSupportInD3",
> > +	if (!acpi_dev_get_property(rpadev, "HotPlugSupportInD3",
> >  				   ACPI_TYPE_INTEGER, &obj) &&
> >  	    obj->integer.value =3D=3D 1)
> >  		return true;
> > Index: linux-pm/drivers/acpi/device_pm.c
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/device_pm.c
> > +++ linux-pm/drivers/acpi/device_pm.c
> > @@ -484,6 +484,25 @@ void acpi_dev_power_up_children_with_adr
> >  	acpi_dev_for_each_child(adev, acpi_power_up_if_adr_present,
> NULL);
> >  }
> >
> > +/**
> > + * acpi_dev_power_state_for_wake - Deepest power state for wakeup
> signaling
> > + * @adev: ACPI companion of the target device.
> > + *
> > + * Evaluate _S0W for @adev and return the value produced by it or retu=
rn
> > + * ACPI_STATE_UNKNOWN on errors (including _S0W not present).
> > + */
> > +u8 acpi_dev_power_state_for_wake(struct acpi_device *adev)
> > +{
> > +	unsigned long long state;
> > +	acpi_status status;
> > +
> > +	status =3D acpi_evaluate_integer(adev->handle, "_S0W", NULL,
> &state);
> > +	if (ACPI_FAILURE(status))
> > +		return ACPI_STATE_UNKNOWN;
> > +
> > +	return state;
> > +}
> > +
> >  #ifdef CONFIG_PM
> >  static DEFINE_MUTEX(acpi_pm_notifier_lock);
> >  static DEFINE_MUTEX(acpi_pm_notifier_install_lock);
> > Index: linux-pm/include/acpi/acpi_bus.h
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/include/acpi/acpi_bus.h
> > +++ linux-pm/include/acpi/acpi_bus.h
> > @@ -533,6 +533,7 @@ int acpi_bus_update_power(acpi_handle ha
> >  int acpi_device_update_power(struct acpi_device *device, int *state_p)=
;
> >  bool acpi_bus_power_manageable(acpi_handle handle);
> >  void acpi_dev_power_up_children_with_adr(struct acpi_device *adev);
> > +u8 acpi_dev_power_state_for_wake(struct acpi_device *adev);
> >  int acpi_device_power_add_dependent(struct acpi_device *adev,
> >  				    struct device *dev);
> >  void acpi_device_power_remove_dependent(struct acpi_device *adev,
> >
> >
> >
