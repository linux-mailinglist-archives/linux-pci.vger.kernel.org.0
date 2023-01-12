Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7CA668730
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 23:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbjALWpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 17:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbjALWpG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 17:45:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4B95E0BF;
        Thu, 12 Jan 2023 14:45:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDoJxX3VEkGyv/9391zjkjVB45q8qLaXHvmjzP1lpV0jVxJ7XwLBcu27BIG4+ZPgqw1bUAqlX4drXLhjZ4x0onjNU6+8Z6lzw3QTsmsnrOABSjEJaxG3Sk8fVFJho4y3dcfmXuZ27YeBp3S4aXdibqtwnoLj+VK9jcHHQgKoJNAvb2f3eelczfRzIqCGxMFFzkS5aSrYd8dH4gi4e4DbM6vCHbyYkofc8PppiJYIj/psEpETg015UBw/FWYH0+19Xia5CeiZtYv2txPm2//6YGHdFaZRdzQaCwznQjwiG5zFEU6reJkdeoNvd18iKUjzzyKM+kTM2phsEN2ZbzpnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axiiyS7UsCNIvDOypTHJYKsdaZ+zx5E7oCA6KLldgrY=;
 b=Vz4Y5FmnKE9F+paIrWtfQUrj89NmuEO+Qz6RTU7CY78Ajh5M6/VJuQ7+AMiXx5wwUYqkJ0s16R+tW1KufQaz3ecCFCW4mLa33YpZKnfLgjn+Ae+yisUO9ZxpvzDl6ZbiyV3evqs9YsOz3esw0CswkUdntYGPUgN7pwdEPOPtTO+PDT7Dq7z5wSOQUVdO7MWZw8zmZAOzabmu1yn8o4c83XcUr9OhY5iUMq0+ESEVvOMbuJZhubpTZ0Hyw/QiVFUDJFJ0ee+4jnSaCB7urt72NDn4idY5cZQnQcACOATchTS+lg9UGL4TTcGs4hqcbuGMxYphBkiglKBIVBvBuxDz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axiiyS7UsCNIvDOypTHJYKsdaZ+zx5E7oCA6KLldgrY=;
 b=JaTZfgTSH1n3Og5JkvnG47v95iI4CGxXzx7uXc0qcoqN/ui5SGdOHEQFM4574R8HTZmIxeoW0unVAM1vA9nIawG3BRSWYZFXpLR706WOd4Dddq3Lz7Wy8xYGjVLMpG661a9R2uQNPidgY3pAFebypnRGeLiwPkFTbTl7oQ8y5zE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 22:45:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 22:45:03 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
Thread-Index: AQHZJseoN/xcWk1Uu0CFj4KpEohgeK6bVWqAgAAAjtCAAApZAIAAACkQ
Date:   Thu, 12 Jan 2023 22:45:03 +0000
Message-ID: <MN0PR12MB61016E8166D73C4BD7C720D4E2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <MN0PR12MB61013E30A82224755A81B0BEE2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <20230112224058.GA1799052@bhelgaas>
In-Reply-To: <20230112224058.GA1799052@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-12T22:41:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6f4ab7c4-aab2-49aa-a872-9998375e902a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-12T22:45:01Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d3d74f71-fbf9-4036-8d3a-32ea1522f198
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SA1PR12MB7222:EE_
x-ms-office365-filtering-correlation-id: f8f0899c-16ed-45d6-26df-08daf4eea4d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2nnRjaIZaumYGXuPQiHeAEHjHh57xoaVqggNPnQhtHUPgrZidLMuvTJeBlYTi91+zQ7RlH6BpYRAPUpin1qgbrNXfvkoiM7qRIWITVouHzGGVXaYvzHZ0Ee33+PLaLPAFbU1eUM4b3laD2HdZdSXh6io+8o5f9tKv9XT/1FNjWO5oQ3rIw8uqMnfDVOJ+oVJvutok4BjXmWVtbiEmMl/L9lYkBtxc1MceE5ZmjRdXc1bpWLU58Q8oXtyJhBcJ9Shpx3feW7vUL8rbx2cp5jbZQbY+fi1pjpK3P5fMYL3i4frwDf6fVHUwAO88yGUGhaatJmCy21bsTWL25dLJ7KQQGxpQOK9twVLVt5muQK6wggmF9DG9QP2JvHvnGEFddr30MD3ITLUaW/L5lR4HK+5NyTzRZR9mXoFS+VJ5IfWkz3GNq8Xq6sazoX/3EYwS6a1xCapGhfJVaIAyVwTG8QS8/7twiWi9lre7/UUSHsWfRBK3RP7c13Dz7D6nJESo7JR1pefmuU5Vkh58nd8JeFeDXKKF8DOmANbgks1TPOns7boxfk0CQqz2Gnp5HskG2BI6bwP42wf58dZLjwuVhQZrC8sIVN07bQXikWKyuZs6gZSNPeLT9VDmhbEFkRIgOAQ/peVWwwcwHNmv5EkPWazw9NDRwLDjBli3C0gJ4DAfWUVj6TqLFOUW0W9e8MF27epP/aH51jhwEciFGKMuGXmWXKc64gwegY7THb7YEB78oA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(9686003)(6506007)(54906003)(186003)(55016003)(76116006)(86362001)(66946007)(38100700002)(66446008)(4326008)(66476007)(38070700005)(64756008)(7416002)(5660300002)(122000001)(66556008)(478600001)(66574015)(8676002)(6916009)(2906002)(71200400001)(33656002)(316002)(8936002)(41300700001)(52536014)(7696005)(83380400001)(15650500001)(966005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EfrGqT1Wwkeq/opvMmvTTnPOiHwL0iIGSw1zRJ3FVCGfrSWvpkdcg0m5/Kls?=
 =?us-ascii?Q?eqHATn14PH1p9wCoUGmBpYRMvDkcKdo+TUOEqEFR42KSjq6P2YEZUt6ERK0o?=
 =?us-ascii?Q?T8YUd/XvWaoeS7DO09xS2P3zCmOsubcTZYEqsisUCn1rW+sY2Zk3jlg98+Bm?=
 =?us-ascii?Q?wVqRL7YbNd8maodebkf3tiOcn6pASvSBzSEk6yrXCi8xznESqYy88xy+WwHF?=
 =?us-ascii?Q?EB+0SzAAGbDe2ePY6ShKxxZCqncMr/Liky0efWWDa0msZlCRWXoyzJjyo2LC?=
 =?us-ascii?Q?WldmOxyCIZo2Y6RS/rKi9HwtUwWSGcbg548RrU88ZfGi1iGYp7ON3InkEMzN?=
 =?us-ascii?Q?ExtdJHOk9gNnA0qbkvF4PVizAg8uCVUcWJT2Npok6jwYfdGl2tyD6MUWrTnp?=
 =?us-ascii?Q?UBuprvsA6DUEpWtO+S5NRauyJCwv9+pSmmgBP2kPzWcF4cvGQSI9Y36X8con?=
 =?us-ascii?Q?zsFIRJcC05wX7EXCOL8QgHHoJ8sBBB86piUSvENQwSLo6M7eengNwYVe2bfu?=
 =?us-ascii?Q?N/v2IlB0pAipGWzx3wptskcIl10WZE4AC0vFssUoerFXtXDtA+5RHlBZ5oWG?=
 =?us-ascii?Q?O0Qs+jqLGkM7p9NNjoBYbB9mqCXhPBQWzcn8g/neMgUlRmpnwiB7JHeYKcY9?=
 =?us-ascii?Q?QBB3+l27wwVldNr8kKNeP9nKFTkDbqdBqk6zGBeBlxiopxA8xChbZJnij2za?=
 =?us-ascii?Q?hcGOKJoLObZKx5yShi/aobtoNaaxOQaPL5sUNQAjQn8+iX8nQ4PKVrpV5Nlb?=
 =?us-ascii?Q?fd3Y4qK4NOrGfI6ZkoWQQLTDn7vrtBv4PW6MQJw91wKmYBvuMzlge/Fc0/+6?=
 =?us-ascii?Q?efMJazh5ckxmAECUzlVoW9/Vy5sFgzdrCz/EMKKgRqf2k6IsLO4JpcMy5LsJ?=
 =?us-ascii?Q?BD1OTT5we0GXxf9++gHVfDV26Q70EFVL907UxjE/wbXrxQwNOFWYqGslIb7k?=
 =?us-ascii?Q?eFNbbIWdWsg7Y55zYYW078fx5otqiEI2q1Vs4ogkK2hcHnYcmozRAU2rpUqN?=
 =?us-ascii?Q?3OTFuBBd6ifDHpf7Wp9u26glbfXwa1ka7mtJVko1x1g5jvK5INBUBXwC8SAp?=
 =?us-ascii?Q?/ul/yXkyFecX6g6oFJkKNOKiyBba45NY/NZAIXzRL3H83GPq6iwinUr0XdKR?=
 =?us-ascii?Q?WZDnOFs3HiKWFQbKj0UECSq/6+Y6aiderNBg2N5ErahVo3F86bT6XO6kiTmR?=
 =?us-ascii?Q?IbgCDPB4XJjItCkPoUioUMEDQtWkU2SK2zWHuB9bVER8mYbqmWOJ9MMzk+l4?=
 =?us-ascii?Q?05s91EwsgHiX8QBh/9Sa2ioevVKhylzCVMinhXKcLgVPjEPlmR9lAgk8sv4B?=
 =?us-ascii?Q?DLEFm76h9NS5CTABgiNwj+fKjLzk454yNyNkHX3R5LfDtnVKgMcfjBQ7/Pja?=
 =?us-ascii?Q?cxlJYYXtYW5GAQj86UFSZfLV1UYGT94eTjSs/GcgbCBAelbwo6H1Df05D9mj?=
 =?us-ascii?Q?RSk/tlYrVLCWl4jRZOjeCNQlTSIPsYNU774a9QdFQDXLj+diWsFjDQqCr4wx?=
 =?us-ascii?Q?T7iQxkbQ6RlJDzwTw5yJNq85tAOb5ZaD3c7SL1LgotxmGqDxmfdnLCbBTLYG?=
 =?us-ascii?Q?qQvYL7H1bhVS3O6mAomU02kennw8NKimp4iEO9Dc+tmHxHaDNJPkmpnV0zQn?=
 =?us-ascii?Q?FssXgAUCql1+V/JEpEatmVE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f0899c-16ed-45d6-26df-08daf4eea4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 22:45:03.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjttSqUU+moiyGx9J2bmx0H1oq+01YqsC2tviWQcTPLUPSZ4UTVi5vJpSCOsFHQXBsGm/E0rMgUkseUlNkrvcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, January 12, 2023 16:41
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; linux-pci@vger.kernel.org; Raf=
ael J.
> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Mehta, Sanju <Sanju.Mehta@amd.com>;
> Lukas Wunner <lukas@wunner.de>; Rafael J . Wysocki
> <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>
> Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridge in=
to
> account in acpi_pci_bridge_d3(()
>=20
> On Thu, Jan 12, 2023 at 10:09:21PM +0000, Limonciello, Mario wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Thursday, January 12, 2023 16:02
> > > To: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Cc: linux-pci@vger.kernel.org; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; Rafael J. Wysocki <rafael@kernel.org>;
> Len
> > > Brown <lenb@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Mika
> > > Westerberg <mika.westerberg@linux.intel.com>; Mehta, Sanju
> > > <Sanju.Mehta@amd.com>; Lukas Wunner <lukas@wunner.de>; Rafael J .
> > > Wysocki <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org; lin=
ux-
> > > kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>
> > > Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridg=
e into
> > > account in acpi_pci_bridge_d3(()
> > >
> > > On Thu, Jan 12, 2023 at 09:51:24PM +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > It is generally questionable to allow a PCI bridge to go into D3 if
> > > > it has _S0W returning D2 or a shallower power state, so modify
> > > > acpi_pci_bridge_d3(() to always take the return value of _S0W for t=
he
> > > > target bridge into accout.  That is, make it return 'false' if _S0W
> > > > returns D2 or a shallower power state for the target bridge regardl=
ess
> > > > of its ancestor PCIe Root Port properties.  Of course, this also ca=
uses
> > > > 'false' to be returned if the PCIe Root Port itself is the target a=
nd
> > > > its _S0W returns D2 or a shallower power state.
> > > >
> > > > However, still allow bridges without _S0W that are power-manageable=
 via
> > > > ACPI to enter D3 to retain the current code behavior in that case.
> > > >
> > > > Link: https://lore.kernel.org/linux-pci/20221031223356.32570-1-
> > > mario.limonciello@amd.com/
> > > > Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Applied to pci/pm for v6.3, thanks!
> > >
> > > It'd be great if we could include a short description of the problems
> > > users might see.  I think the original problem was that on some AMD
> > > systems we put a USB4 router in D3 when it should remain in D0.  And =
I
> > > assume this means something doesn't wake up when it should?  Or maybe
> > > we miss a hotplug event?
> > >
> > > If somebody has an example or some text, I'll add it to the commit
> > > log.
> >
> > Here's a blurb for what happens on AMD side:
> >
> > When the platform is configured to not allow the PCIe port used for
> > tunneling to wakeup from D3 it will runtime suspend into D0 and the
> > USB4 controller which is a consumer will runtime suspend into D3.
> >
> > This inconsistency leads to failures to initialize PCIe tunnels for
> > USB4 devices.
>=20
> And what is J. Random User going to see?  DisplayPort not working
> ever?  It works to begin with, but not after a suspend?  Devices in a
> dock not being able to wake the system?
>=20
> I don't really know what "PCIe tunnels for USB4 devices not being
> initialized" means for me.  I want to know what a problem report from
> a non-expert user might look like.
>=20

DP tunnels aren't affected, so monitors should still work.

In terms of what doesn't work it depends on the architecture of the
the connected device.  Here's some concrete up-leveled examples:

USB4 docks contain that a PCIe network adapter and that adapter won't
work when the dock is plugged in after the system boot.

USB4 docks that contain a USB network adapter should work properly,
but downstream USB4 or TBT3 devices connected to that USB4 dock will
not work when the device or dock is plugged in after the system boots.

TBT3 storage devices connected after the system has booted will not work.

Thanks,
