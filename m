Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656574E6790
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 18:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352163AbiCXRQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiCXRQ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 13:16:29 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1FD633B;
        Thu, 24 Mar 2022 10:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHo/brhxj7W/0mqPxkenLY8Avm1P50HQErzVWAeyQmA9qeCIhvewTBPldtmzilADXbAv4zbNM/FMuKDZ1tRQ9dt77EURCJ+sm/h0dykEAmRNgNKyzK5gNVAUSFZ9CjJ/+RCQBXudeB+D/IhESJQ1R7uwpB6VCmbY/AlcHHKKdAPbSWCS3QkYD5nUirRpKrNTA0VCJKq6cdbhGanR7ioNkzCt+10h6gm2Q1tUvpxzoMtefYuUSIZ+ElCeWwLZrt9dAviFoAZoPBnwcqfS4W33mQ6gc3i/2eBBsvWSbJwapTxISs8LaBh2N01SpnX7lMFtfxSsvcoZnrua4tp7ynOymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyueCCPLhddYCPoCcjqrj2U3QPe0wlAtDWXkiX5JgkI=;
 b=d3XHmNQpHVqjjeTgTO+Opwbi2jJ7iZMnQYIK8TWvgOFyZske4r03Dnd7qjwST8IKpbaBOOEWXsEVQwt55AXP724DJ5Gnqvr+UTQw0Xg93IoKQMXSBwVctheldBSm0YDZXUCbndO5rWsgN5tQi0OROcttYlkoTOOF/TqP5ZJyhK+REJ7GFY4lj78UAdB7ZVq2jvoLnnKm/0/XA4XK9cGVlqEwlSqM6736SsqkGNuSEYFs0z0pzzE1/Z0dfAalqmRCbbsWUnLf6DT38kXkgfLGwMDYheSqAyXN5SG00FYxm+vc4GgWPSLEJMRw4y9gzmEA6DY/6cx/2ONRUiQmHew32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyueCCPLhddYCPoCcjqrj2U3QPe0wlAtDWXkiX5JgkI=;
 b=A1uzlW8ex/EyKds4q+81dd0chWQCyGQHX0JR2elPONFrUksTXJv34xWpWtPs4GjBGzP/cC6qCzbIVUYiK6bDdYLJ+h9n0PqXMzkMq8wdn9KepjZYexligTem0KWKRNTr9W5PF8ZGeJqGzp63auyGB0i2vib/rMFVp9n/ozz29pg=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN8PR12MB3201.namprd12.prod.outlook.com (2603:10b6:408:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 17:14:53 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 17:14:53 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if device
 can wake from D3
Thread-Topic: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if
 device can wake from D3
Thread-Index: AQHYOIH4cjkXql1VyUKxzqcCT79LiazApEsAgAAAXoCADIi5gIAAUUqAgAAEXdCAAAnIgIAAAD8ggAE8GACAAAJrUA==
Date:   Thu, 24 Mar 2022 17:14:53 +0000
Message-ID: <BL1PR12MB515720B6EE3EC337081FBFDDE2199@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <BL1PR12MB51575C7E6979A60E2637CC82E2189@BL1PR12MB5157.namprd12.prod.outlook.com>
 <20220324163452.GA1449620@bhelgaas>
In-Reply-To: <20220324163452.GA1449620@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-24T16:43:33Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=faac0088-094b-4ed0-a7c6-2c4f85b91324;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-24T17:14:51Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9440d33b-2b2e-40af-b64b-b54e8d9ec693
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 240ff71f-a4c4-417e-15a8-08da0db9d000
x-ms-traffictypediagnostic: BN8PR12MB3201:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3201DF36972CDCEDE8347813E2199@BN8PR12MB3201.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zh9fZAg1nSoQ8qgJenNjGJaWHGhFpD9YJpWkZ1A/+FMFt20VgqpF2G5fk+O6I8eqzbeJG1AigylcgoKnvx1VL9Se+8fDXUAsfhfMq2vUcjfBwqISj48XNuos1umQvX4SfOeNnRxF8JruMNvWFp+n8w6D+HOULAYLlvnS1Bvgb1IApZMspZD9EfviptMoMoJ6G6U0BscEh99+q9R4H/EBEeGhIHKCDPuWQBReSK/Z+07AalVx7fqfLrWStGHAJv6MQGtDYVGFh5mx7FYg6CQgLYSssrs/JJOzvSfBJnno/qyjJMkoiGMykJqCq5aeBdNb7ssExeyiv4d4WhghXebsoC6IIc/ZhV3FPUooshaj4KCpWlt1fNl2Qx0+YAFY6ICiC7Bk694HhMFV+p1dct9JumZseW4ubGv1+eVCzHPfY8cS6JtVyhiQr21h+6wNqnDnadXbP/QvNCM2LMEQtcS89IUm05UsR3M1R+VLJ36ldPn6tYkagf/ZKoq2gH9DqEiHba/pe+uU2vqpi6Ud4d+cpU0vC9j722JenH2F6blYbNywlSOMLL6e7FrmbdaHH9GfEjbtqmVYDEFUUhOewWhqcrDrJa1UbLQspeGMdLDOjlUu3Sb5qHIHBU3ykeU/uHbfQOSz0F+Xuj+gV5akFMLcQ29UjoOYQ6oDrgglUQ15dYWZfDqHjfX+VACupbt75c1E/78ByCnPZS5CuGP4qwTms+K9jbM++MchokwXQpIMH+o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(4636009)(366004)(7696005)(6506007)(122000001)(9686003)(2906002)(33656002)(186003)(38100700002)(53546011)(55016003)(71200400001)(45080400002)(86362001)(52536014)(8936002)(19627235002)(508600001)(38070700005)(8676002)(4326008)(54906003)(64756008)(66446008)(66476007)(66556008)(5660300002)(6916009)(66946007)(76116006)(316002)(83380400001)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v3ZrpUtyuL50FdtIbad9pqfcG82c350Jjn8asJjRaFPU+jMsIK4/hq68BqIK?=
 =?us-ascii?Q?B7MjGmgXXYtFNt4JnZ36LosmEYvUil4Ko3+ZqSIB1OII03G1DEbogN9yOY2+?=
 =?us-ascii?Q?ity0gK7Pvrz+BnP6uf3+WRUZlhkw1lcmlR0CG1MY8h41VCC/CCsIJknFr1Ti?=
 =?us-ascii?Q?czMZPRVNmr8xMfL90v3OG1sswm/OxgL7LZUtOl0ZQu5X5tNpYaU8lAOy9cwL?=
 =?us-ascii?Q?maIDftqO/LRHoUYXoGPsJPPbEgC/6phZzrjzJVrDlN2jmvlbl+Af73nPcC/K?=
 =?us-ascii?Q?8J42S986Uy46sSX6eB1Yodkd8eUtN/M1Uncpd2h9jCUCCU4ebJGGWJbLSZ+F?=
 =?us-ascii?Q?q/g0d+Tg9vHAnNQ+8pcKxSoJB1Y/4C1ITW+DBrgLyYCGWcyLgM1FFnZL5G+k?=
 =?us-ascii?Q?wWkV3s3Z9mT7vydwXZYDzm18QaOowxxMYiH0ZhiwPVd+8T2hLdpls0/DhVfj?=
 =?us-ascii?Q?pxqbup38HYGdABrhEGZxZH6js3iwObImMar+StYdaaAqiRzucYNJ0W6ip2dZ?=
 =?us-ascii?Q?6jVgPAkNR5/nj6X0V7GY6O+2EFp305otnwk45y+jyQbVxDYT2CY4hqn1OP26?=
 =?us-ascii?Q?RgItkzWTKKaDmUfJPkiA5SvDHZHkgq+w39zwbVcZo1UnrkSPd63C1P3npcyI?=
 =?us-ascii?Q?CDfePRdfouzOGVGJdYjFtJquEyj8dVzGYWM39wn7/vuuC133qX986jqduXxy?=
 =?us-ascii?Q?YEXSqFvdIh5/RmdKeKThk7ln06eVpBSn1rpsQ2gDTa1zX71sT+TyGqiHcN14?=
 =?us-ascii?Q?QJ7ZdmJCR2y03qHtVaoAVo/dcB8BAmD+bD3EsbLu7SaexPG8psmuyaOnR/MZ?=
 =?us-ascii?Q?xEnET2brQBDL+Agu16uXtKe96YNK88aLQe8GWukQG1chEItTtF20Swhw2Z9F?=
 =?us-ascii?Q?I6927fQY9j9t6MIWnD7ccIFCPTypw9J3fDNmpEXx2sgEXus2qmhU1GxZtYKI?=
 =?us-ascii?Q?drPMAKB8GK9qKovaktJdkGLXLyvLgf3yvBib83De690XHYlA6ECb8Z9em57s?=
 =?us-ascii?Q?gW5tKVLuhQ86+JTNiJRdcJUmNGfbbRHKpfvvc0cyruzDDYnQ1VNzZeaOLXWp?=
 =?us-ascii?Q?+AiWUCMX5gTFnuqno2L4mlHfWOdZYnBNVq+nj+GOoxqjA/FLeknJVEHSSt+9?=
 =?us-ascii?Q?nR+szKA3uisMVkryhOYTch3DfrcAaPdyy6lyH8v2tg+jMVKB913tbo+N4Gu1?=
 =?us-ascii?Q?Z+fUr5zlo2sIIOCjeZXMeD0dWe30tfeRGShV7UPFQxMt2ZhFU2Vy+T/Ih4eA?=
 =?us-ascii?Q?5irCHEf3mof2OB1FkSnwrEHehEaEo4dvMJmUwYrjJC7Gz0HxNxtBGRmjappB?=
 =?us-ascii?Q?a2BxX5A8u1R8d0002uVm+XVbvgVRiLPS36HrU4TWyM6Ox8VvLrvDVn8xXLn6?=
 =?us-ascii?Q?zUG1N8vYqZ7H+x/X70DiS2WAe80AMr2tbXtRY0/3jochb53mK955IJqljUSg?=
 =?us-ascii?Q?rdrtsEB8oeH5LJPdw6mfsumXnkILUaXZSSOkmdI4VV5jY0NlpE2MRJSmiiZs?=
 =?us-ascii?Q?P8UrT/r5YI9cxW77iSDRprSyn0Lkaf7/2qWLFt2pFununiqn0pFI/Gw8Oq39?=
 =?us-ascii?Q?WILJlL8cCS6+jdLKb9ETMt84toNO7Xno16s4mb2cUUy8ibd7AiW/vq0YxDgs?=
 =?us-ascii?Q?axu9DXStDiP3vjvedHDpaQQjxqxLW2ibvtSAXdYXbKpUROo94iUs8BnvXzll?=
 =?us-ascii?Q?y5WUz5+k2vhXEitNG1Akt+lz2uF2wh4iqEn7ELxTSIpmha2/arOnQ79A0JJB?=
 =?us-ascii?Q?LEHbgQ/Oq7u6YcuRmg/3LTIQv6uvJef3KyB6M3jHbJ0hMCnIqoWx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240ff71f-a4c4-417e-15a8-08da0db9d000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 17:14:53.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oo3hw2i3sjUinAdG8W3zmaVYOHR379V87/f5YgzNRCUPe28QMKF/zsNiWYtZ9ViyCoEDTaOxZB7F5fUTdY7ggA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, March 24, 2022 11:35
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; open list:PCI SUBSYSTEM <linux-
> pci@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>; Mehta, Sanju
> <Sanju.Mehta@amd.com>; Rafael J. Wysocki <rafael@kernel.org>; Mika
> Westerberg <mika.westerberg@linux.intel.com>
> Subject: Re: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if
> device can wake from D3
>=20
> [+cc Mika, "HotPlugSupportInD3" scope question below]

FYI - Mika had approved some earlier versions of this, so I expect conceptu=
al
Alignment at least with the latest one.

<snip>

> > > Can we at least list some common scenarios?  E.g., it affects
> > > kernels after commit X, or it affects machines with CPUs newer
> > > than Y, or it affects a certain kind of tunneling, etc?  Distros
> > > need this information so they can figure whether and how far to
> > > backport things like this.
> >
> > It's going to affect any retail machine with the SOC we refer to in
> > the kernel as "Yellow Carp".  This is one of the first non-Intel
> > USB4 hosts and will be using the USB4 SW CM in the kernel.
> >
> > Without this change, effectively PCIe tunneling will not work when
> > any downstream PCIe device is hotplugged.  In the right
> > circumstances it might work if it's coldbooted (if the paths
> > selected by the pre-boot firmware connection manager are identical
> > to that selected by SW CM).
>=20
> Thanks a lot for this context!  As far as I can tell from grubbing
> through the git history, there are no PCI, USB4, or Thunderbolt
> changes related to Yellow Carp, so I assume this has to do with Yellow
> Carp firmware doing things differently than previous platforms.

There have been a variety of Thunderbolt/USB4 changes as a result of
Yellow Carp development and findings, but they have not been quirks;
they have been done as generic changes that still make sense for all
USB4 devices.

Sanju (on CC) has submitted a majority of these, so if you want to see
a sense of what these are you can look for his commits in drivers/thunderbo=
lt.

>=20
> Previously, if a Root Port implemented the HotPlugSupportInD3
> property, we assumed that the Root Port and any downstream bridges
> could handle hot-plug events while in D3hot.
>=20
> I guess the difference here is that on Yellow Carp firmware, even if
> there is a HotPlugSupportInD3 property on the Root Port, the Root Port
> cannot handle hot-plug events in D3hot UNLESS there is also an _S0W
> method AND that _S0W says the Root Port can wakeup from D3hot or
> D3cold, right?

Yes, correct!

>=20
> I have some heartburn about this that's only partly related to this
> patch.  The Microsoft doc clearly says "HotPlugSupportInD3" must be
> implemented on Root Ports and its presence tells us that the *Root
> Port* can handle hot-plug events while in D3.
>=20
> But acpi_pci_bridge_d3() looks up the Root Port at the top of the
> hierarchy and assume that its "HotPlugSupportInD3" applies to any
> switch ports that may be below that Root Port (added by 26ad34d510a8
> ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports") [1]).
>=20
> That seems wrong to me.  How can the platform firmware know how
> downstream switches behave?

Mika might be able to better answer this than me.

>=20
> I have the same question about this patch because it looks for _S0W on
> the Root Port, even if acpi_pci_bridge_d3() was called for some switch
> port below the root.
>=20
> > Yellow carp isn't supported in the kernel until 5.14, so should this
> > be backported it shouldn't need to go any further than 5.14.
> > (Realistically though no distro should be on 5.14, they should have
> > gone to the 5.15 LTS).
>=20
> The question of moving from v5.14 to v5.15 is outside the scope of
> this patch.  I think we just have to mention Yellow Carp and the way
> its firmware differs from previous practice, and distros can make
> their own decisions.
>=20

OK.
