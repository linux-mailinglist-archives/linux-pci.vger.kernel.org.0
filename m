Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEE6F0A3E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbjD0Qup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 12:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbjD0Quo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 12:50:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6081704;
        Thu, 27 Apr 2023 09:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhmC9V32x3WMADFMvnz+3yA9HAyiDRIHwZaeAVjT/UHSilJUO7PjZzSlAGDLXpDMmhIuCBfV0MCP13Af+bI0aAebvwsDmvvLZvcUofkU8ZBbnb+XAn8EYM22MLDdGkkD1IEX57X/1qWJGSQyKXm/7SARavZXVlwicHmieIRpDv+B+NfVnS7+JxRXU4F9WMXnleKGi2CpG8ClPJusjncH+HnrMUmghUU6XqWm8fb8QVIzdK43luFHXeZbjCzA7cxYqaAf29pKn+nhrKjtN/1gWyA0VYcazU6tTjbS94I++FHpyCucw1ctHXTavo2VKQanHLQUubsseV0QOjzos4cpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8zv4fEzv/CWLV0VDyS38vmpZ2fZ9t9iWNJ9tlFW+4g=;
 b=UZJn6cyPYgQncdUT4Kq+ALyBSNOsjkB3Cfp0BOGbaG2dUfPYFN6uYaSno525rrZXops7m2dnApiK4rgAU3IbaqJorGiDDB+IAsHKpIIZmUgUGJO9StJGz79fu/JDIHjvLAX/ML8rzOhPZKIEZqSzTgX1cm3xzz7xD3YWf/gR5Bbv8tj/zS2/VG79OaxENMD1g5MXNYsvrKw1JFqwopdum74Dck8+kDNDuZs0vdTi5gJAiYUBWIco+4eAA9arteZUTzF5+/ILQZBb3Tctj3/Ro2+KKjV3IVfzlYsbz+zQ2N/9FhLVWSRs1LUsd/vceDQWZT7hCEd2IKJapdPDQYExPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8zv4fEzv/CWLV0VDyS38vmpZ2fZ9t9iWNJ9tlFW+4g=;
 b=Tb/Ajej1/pp9lZS7ZaK0swF/EjMUyo8DIKUjiJ5gJjTmSgtCUYNVmdT+D5QD03jZT6R5liULIDArXo67Okfuk6RXPcHmmCTgYWUc9GfoOgbetALncYUGSeOTMzPOlmzFHKanwEou4rqD5iA0gcRFWeLy6+GT+BISjIdf+gM59KE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 16:50:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 16:50:40 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Thread-Topic: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Thread-Index: AQHZeMne9ZdOCI5VAUibEWjErYT7K68/XieAgAAAQNA=
Date:   Thu, 27 Apr 2023 16:50:40 +0000
Message-ID: <MN0PR12MB6101C995D38915BD81816701E26A9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230427053338.16653-2-mario.limonciello@amd.com>
 <20230427164651.GA255475@bhelgaas>
In-Reply-To: <20230427164651.GA255475@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-27T16:50:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9c06945d-9f54-4c3c-bb07-504946cd37b9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-27T16:50:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: dddced2f-9e30-4da3-931a-87cdd191b5b7
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB5264:EE_
x-ms-office365-filtering-correlation-id: 31db90f2-daf1-4957-7715-08db473f88ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8zNzxkoZRqpByNq9DzJhy+hRXO0/NfLu1FZ9L4wXxUtlAeimDXNMXx28BF0Ij/92AlR0tybuiyudd+lsiHYnxjYlh6Nqw1v9dpvREp/qg2vGNSqD18txKMNpQ9Kr/mUKIdIcnNaNCNK21GKSV33dIOJxGFzpXZf9SjlVBPeLHnsV48HYudIRgPlZ4NndweBRq0kv++v31qjBcVNzJa6xZK3ofIQmOOgoGwxPc6TJlbH6SQFn+VInb5yy6JBhfZiDC+huPJMbP8OItFG5GZyvMCQhRFqycPt6Q4mLEAm8quwds+jE9AHe5g/V0LjnWYhzljKRre2ZU4TmWDqgDSYp685LZcgOrwtqMqrhD0jOSfS6y7AjKa4wRQ9GKUC0mlfWpUGK0HVyw4p35x4bgzkcwOCwct7b5dkNqpmxZTlG+GqfapfSANBPjybg/leQg17r3loXJaiBffO3OmNmFzZdUsQue4Xo8PP7kX/EDU31GUZa/HMoV/j4FBOIe3BOxNRePoHo36RpTeNWnBKnfU05n3ZhARg/H5BtzNqOD82r+rWQ4ez/CMO+xEiaJwh86pZG/mM0kXVQ19Cttz//ZYnZNLGnrPvJ/z1FO9yU9yGpBXF7pB08lw+kbmE4D7C0ngD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(33656002)(86362001)(9686003)(6506007)(26005)(71200400001)(7696005)(478600001)(54906003)(7416002)(66476007)(316002)(64756008)(76116006)(66946007)(66556008)(66446008)(4326008)(6916009)(8936002)(41300700001)(8676002)(38070700005)(122000001)(52536014)(38100700002)(2906002)(186003)(5660300002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NBRBB4S8fPm/ndQzAc5m0Tko9SMCVEGVIryuRpmDCZY6HpXv8uxJBFDiOwCW?=
 =?us-ascii?Q?l1Uk0QfPGyiyGCR3CUEOZGoTBVmCRKcuXChU7UCJisSwu+lnfPHuO/tGlJym?=
 =?us-ascii?Q?bdgsHqDVybX0X7N09oJJCwWJPwsTFP4DozvO9t32U5EW8j1AksnZAQ9t19bX?=
 =?us-ascii?Q?gfCpHLNFikrx9DHhngy0E0D0AdVGf23yxF4qBfoVN/LBH7g8DQ/Q0hpi1OnR?=
 =?us-ascii?Q?RnryahIfyTMxRAqoe8nutoj0kA7MCcMM5yuJe0P5OERYui4kXMqNTkb1QcUG?=
 =?us-ascii?Q?rheZZSsUMNZ4fR1wYgdVQajcFtnU+CaWzjoK1We74o80v4vzhmcLtYclf8Bm?=
 =?us-ascii?Q?KIOL6necyXJbo6VQZ+j32X68fmu5tDPGyHtGLI4wTEJh+4J2HstHFSPpy+ht?=
 =?us-ascii?Q?ngFZgXzQ02W2yDS8/mODsM+prDzckmarP78TKYHW0zVlzktv/4kexrskQ52M?=
 =?us-ascii?Q?pec4ei4QJ3M00OBSDehxOO9ZlJYcwQ/YJRXKOpOrlEyXUGZiWTsP5bAJoVSN?=
 =?us-ascii?Q?ZS9V7mNGGgFgRFrVcVeM+/F8uv7bU1mRiNtBhJtJFryEbuHBMnKYxHUp/s9u?=
 =?us-ascii?Q?/umIKtqG40PWYNOiSzAiePDKV10ot1edvD9g9AnHtWblNRDUoG4zSHLVuXV9?=
 =?us-ascii?Q?visCcNaFNoEeqPSgJfVzE1TbNdBBkFcWlRpVG4J/KIgGqokukzs8sCx33MDU?=
 =?us-ascii?Q?pKjhBCpYA+IcfqDODHMvvw3w40Vf0YDtiLJPtFhpDu2XJaEXGIYbhbB9sFP7?=
 =?us-ascii?Q?wQSMvv8nqjmhDo9Z2mnWwRXe+dGmD35R9wFLraFvex2WH/1NWvmdVTS20LSz?=
 =?us-ascii?Q?XW++4dZfhNubKXej8u2JRFtEjYRApzi562QHQzpvREiT2/0tMpAWY9+cK2gq?=
 =?us-ascii?Q?smIwh2QYGPwiTfwKd0Cnuw5a+ZABTCrzNOmTJUCtu9OiRjHY4fcW1veK4ii2?=
 =?us-ascii?Q?V3lY3fnwXx4Owwo2KapRciJz4/UXcaA0/0Z3AcAYjt3rGO4+MbSY6dBU1soY?=
 =?us-ascii?Q?INwr2kavqbCBqQXESifQo6TBC54AZbEE4FqR39UN48OrvGLv40A2iiRvSJdw?=
 =?us-ascii?Q?neQPbxMdlzCsStrq/Q4MRflp/ZENYdqg/jFa/vadnFVFWFdrkG3FVKTZ9gdA?=
 =?us-ascii?Q?i3zJs/MnpP6EsbnwL6dclzzfD/DRmuazEuMWyN5+LvGAzZhbAITSPf6DVJIJ?=
 =?us-ascii?Q?2ITAX2CUbphpDZXoZSdJMvkd6xkfF0lGhorDXOut3PHCO/doZvTG3yGOEzXP?=
 =?us-ascii?Q?wtYTVjQnvuxy4awtvUp0L+tCs5kixm2W2m/5EuKlY/pmhDt47Hw4cgJk8MPO?=
 =?us-ascii?Q?7+yKw1CNHTl8IcsVg4/egm+j7JxgFUjGbDcKBdwGNxNesecOJxgCgNCY77xs?=
 =?us-ascii?Q?eH5XtZax6ahJKvWHXWvh0KCscQHsmHQhEQlcdhY7a64JwdyQulaQhQL5aO4D?=
 =?us-ascii?Q?5LzEfU/kxMF9WgFCGy/8sck8x7fnmqC7MTrQ5k5oO60ziwX+A9Cw2PPOgAlM?=
 =?us-ascii?Q?+dPHf0E3fjOO8mTSFShgyimDw3Ur68BcoU+Oik2p6g357h8ou9jtvbb1R7Xv?=
 =?us-ascii?Q?bjxUugMxwOkdPiAn5cs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31db90f2-daf1-4957-7715-08db473f88ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 16:50:40.3790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcPwfKChBHBSKJ+ImdKDF4ImdfplYUg5EnH5tSKG+U1tDDoUaqA4v3gkR9oGErSkb82lRJplX7t4SG9ELSHl3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]

> On Thu, Apr 27, 2023 at 12:33:36AM -0500, Mario Limonciello wrote:
> > s2idle previously worked on this system, but it regressed in kernel
> > 6.4 due to commit 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN
> > index 0 for driver probe").
> >
> > The reason for the regression is that before this commit the SMN
> > communication was hardcoded, but after amd_smn_read() is used which
> > relies upon the misc PCI ID used by DF function 3 being included in
> > a table.  The ID was missing for model 78h, so this meant that the
> > amd_smn_read() wouldn't work.
> >
> > Add the missing ID into amd_nb, restoring s2idle on this system.
>=20
> Is there a long-term solution for this that will not require adding
> new IDs every time new hardware comes out?
>=20
> drivers/platform/x86/amd/pmc.c already matches ACPI IDs; maybe there's
> some way for the platform to provide the information you need via
> ACPI or something?
>=20
> Bjorn

I had the same question when I came up with this and found out the=20
ACPI tables don't encode the information needed right now.

But, yes there are discussions ongoing to make this more scalable in
a future generation.
