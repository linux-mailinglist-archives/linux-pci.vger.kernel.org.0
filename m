Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F866A15D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjAMSAf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 13:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjAMSAE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 13:00:04 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D288DDC;
        Fri, 13 Jan 2023 09:53:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rra4PwFsfCucNuGqFCXBdt45M+KxlZdYmkIVI6gFPBqjIzJ7SJt1WurXjgZFcCzHxxlGSIp92JN63lVgZExO4sXHVpj9iSQzkA9ywAPuOUsZWeJzdQJcH8u17QWHBFMJENHNJog3nGHbFUa3Nf2DeK4aYdTb2J/XnPMehKGMaAfiJFDpuj8LxmL5wzmKnrrjIgSedQYzkdSdb4xbohI2giNEbDjqc/iVjw8NxjiqskwuL3YybQUzel45JHRU9dZug6sCvLh/yX2kIa0sntLKG7R668sA6NPX10Fg3xq7tn2DAQKje+kx9fiTWXRQZBfjWTsP0ucb3FFsgDz6JKkU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMbnbPOfKv+LHmKBUE763U3a36epBjlUOhL9UH1BDpQ=;
 b=RuSuxMUXZHoQbSx3EVYHuOhzPfkbR2pG1CWYGktuRDXBjfC2QAeuAgSnSfqNVRy3HsKQAzLNMLALqu1gIJJya28C53xExKxKqgpu5e1G+S3oqv0R5iv5HGN/HldUPg00RpAAGLkQSATi99DpoWfwzNS/F9aU3Ii8nPueD9gZxbLCcsagQgAhcuyL14WtYd2FTz+kI0gAgV9mMxGcWgRd1b+fiOQBWq6pJpyU9f09pfZqLfT1cPHQSiDfDM6zeoR6BKabymVVlkeB6Fp39nI+OQCC6TyGT5yAlWBdSkZincjMrzZeikSFfgSt7dBZa9/kyUfuvE6MxS7cogjSjm3MfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMbnbPOfKv+LHmKBUE763U3a36epBjlUOhL9UH1BDpQ=;
 b=C0Kv4oLxmlh11UTs98utvhy4ZvEGChUGwqotO17yTjFk9ypVhAyrkdqf8v4hI1eJAPm3hjgErJrop+vBtLie88TomaVGSUEIRX/ZGaTEntYTWfVVctHpSa0RIP7rLoEjtL3liEyj0KwfmXw01Id/3xuZ2ZjRlsAA74q8wiFcPdM=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 17:53:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 17:53:42 +0000
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
Thread-Index: AQHZJseoN/xcWk1Uu0CFj4KpEohgeK6bVWqAgAAAjtCAAApZAIAAACkQgAFBUgCAAAAy8A==
Date:   Fri, 13 Jan 2023 17:53:42 +0000
Message-ID: <MN0PR12MB6101528DAC69EDE1CB51733FE2C29@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <MN0PR12MB61016E8166D73C4BD7C720D4E2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <20230113175136.GA1848594@bhelgaas>
In-Reply-To: <20230113175136.GA1848594@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-13T17:53:39Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2d96a3cd-8a49-45cc-94c0-75fb9c0ed2de;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-13T17:53:40Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b4b5395d-d5a1-4c42-96be-afd2ae16006a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MN0PR12MB5932:EE_
x-ms-office365-filtering-correlation-id: eeefe2d2-b35e-4f46-2c65-08daf58f1bbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYCA9QScSsDs+9Rz8DKGJ5ZEz9h8t/+h/t8dEZXA2RzEFcb03MjBs8KcHjSgLfxwzsxESq8XQxaz0BIqU5M52K7SWx+UnwtBoMr1MWMP4qpvC8qKHl1SvkGQd0ezuL9/4Rib1+r+icnGIjj9mJPB81DKZDQCdXDkS3vov6dcrCZOzTMpM5FrlL+ciKtckj2T5Ix5WGK+fk1efMEvZrgjxMtLuyXd1yiazMEzuiw2tggJTBdvHUDHRn8QWutULsabrMwlpK+6NGi2vrNeolDW8l7GLjBtu9KpNOEIxHD6YmW3VnaxvOy0yRlkfGHrnX7xRL05fIeDJlOODQPTdlaZNnCwEa7Buts1dMpbNwIEiQK3e190dX3THgf5IdJN8eCGTKdg+YL6iGMFc6juLmnaEXAIM3JVbxzJ99aJHArOLrOv74fKcJuvyqIqj8r/HagBYhw0/Pdjnf56cpx8vYVTFnu6O29KV2vPqB+3sgkfHonHVkwRoBxS1mwMmIwhp5VbHJBPZguDb/H5HzY7Kzdhegell6IEwr75FEVYPyfAZNaYjfSSgxEXhkkeNHSVP6ykHltJqEE/vbIjCJHNLOwTKmmphmRpuP3EII8TbBL0TbSzuOXaWcGCipPweRtEqa4aN215RgH2MetwDkeZhWrzFuRJmH5vT4iNWU/HcgJ3cOvvGjB9y+YwxT7mla3Q3R5wHEvs1+HvgaAK7HaZqEmteknUXSXmVbcpB7+N9KXgVrA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(86362001)(66556008)(8676002)(54906003)(66946007)(41300700001)(76116006)(66476007)(83380400001)(66446008)(4326008)(64756008)(6916009)(122000001)(33656002)(38070700005)(7696005)(38100700002)(55016003)(53546011)(66574015)(966005)(6506007)(26005)(186003)(478600001)(7416002)(52536014)(8936002)(316002)(15650500001)(2906002)(71200400001)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lCm/GQNdG2uhH00QsUNvKyvOjqGLtGlpt3a6F4KKtmRngy32odvKgPXNhDSI?=
 =?us-ascii?Q?AmYwCYVEawmI2PRBJklyC4PMGEmg+MZQfzjDL36Vag7ZzJpCfmkNcfdDWpZw?=
 =?us-ascii?Q?OsrbkS4Q54PiI6iHX7MmSd1Ndhbkgv0T66DzfJf3LvZ+HeFUkcp5RBGkQJgt?=
 =?us-ascii?Q?jLb2yCi8XDD08zquVZJzjcc2hXc5UEVOwuWfYefRtD1lHdBap4cXyuiAWJA5?=
 =?us-ascii?Q?wws6HdLnznZoRJm2+5R3QSSVpc7CA4AMY6sHVMkXSZlusRUlEejC+ly7rST5?=
 =?us-ascii?Q?W6EvW7aX0fZvWunx/pP3owQUHS1gJlO+qxhvu6itKCgyAlfouAOD92ty0wn/?=
 =?us-ascii?Q?1THQPqjnbfZL9LLSlkXLM5h7p2XjicfOTxL3lTI2Tym9jh3uFyisKNSmlMsy?=
 =?us-ascii?Q?RfZHyKqlalGRGIWjDfMgheU28snmxNIDn4H76h5ofbfL7Deb48ZPJ0ZyqSXP?=
 =?us-ascii?Q?gW3eKjIUvCu6wwPtEhcFH2EsZfKuVAMUduFi2lWhMOGZukeXL52Z/j3k67SP?=
 =?us-ascii?Q?Xe/pZkdFaDpyTkIsutTNJ0WFUur7U1Gc81sdYr4069KXkHvfnOO9juP/KpIR?=
 =?us-ascii?Q?XTbcXJfnNURA7suP3AvrTdqtulMBpigQqQmYTe/c1cAaYoAWQyqMT/Jfvudy?=
 =?us-ascii?Q?GYWqznSICAIFZT+AESnVCSFKycmY26zn3mFFZXroLAK0TzGAJHDwFtAhCBhy?=
 =?us-ascii?Q?PW9R39IyX91yx83K9nBBtl5I+xICUdFRH04h2TMslPSSjPWeamC19Wpu6K3T?=
 =?us-ascii?Q?pLAKU6Hbh4wqBxm8hCSIYsMAWa9OEhIG0sDDEL/Xn2KA9z+9agRlEyRVGnnh?=
 =?us-ascii?Q?3Y5IlfNRYv/AuZWA+5NjesB/S6BLZF2SxML2LLCAXHwlaNNPjHLU46GU3+LN?=
 =?us-ascii?Q?2WoVfu/L98kWVcSSw5hRb2bVWVriQnYkylmdEGKQFlAexcKsPFnlD8igIOfr?=
 =?us-ascii?Q?zJqFCm9BC0X6ETJfIci04j18kMumJWHVjAuyK/fRAtbr8QtY2I1Tn2olRPaW?=
 =?us-ascii?Q?4rO3pTJPSwFKiFYKfU607oTO+xPXdhOE6IvKNjl00wTSf7Ijne7am71KOPw8?=
 =?us-ascii?Q?SnlI5FvkvBWp6VhjEhlYpd442kk2crfVoOfhoUE0G4sJjrHAvXMOMm4ML5LA?=
 =?us-ascii?Q?XlYLLOBXHWfdfqdC/zhr8ZKn+e8weMpqogmJuXhv8Hwc1HEfju6PnyjVw9vg?=
 =?us-ascii?Q?4rOIzevHnkbLWqKiDE+pAMLBJct93a9cjsVuoTDybbedpwaoMHYqJYwfxL7I?=
 =?us-ascii?Q?tsmR5GYQW8ZlHpeEa77BMiG7zV4ZgPCXlXQPm0f2HEtdEzDbZ58GaMQ2Mt2I?=
 =?us-ascii?Q?+UBTNcPbeU0WBSvXFslGnEQsO2+EcYt2bolhGDm6uELlcQSsD1UqhW0KVZB6?=
 =?us-ascii?Q?tKpHYpWNGfi+Mfact+60ruFDhWOUWuAemq1XAUM2Pjg5q6fym+tsBhQaUI6W?=
 =?us-ascii?Q?/OEXFfZ1T+e+UHKwazmmKHiehIRsSgiFjvOrHZULqrSYZfgECh2PUoUVN9c5?=
 =?us-ascii?Q?1YMR+B/WUa8ebX7d+8Uid7vKdLMTOTsin8QEiNyxk2Ep3xDgcPzm4FwhgiFl?=
 =?us-ascii?Q?AQO7fX6Se6RukuvyPCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeefe2d2-b35e-4f46-2c65-08daf58f1bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 17:53:42.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1DBbbJpGBGqas9nMwbe1TwCXyMd+5OLjssGdwcBsWUM0pljmSgRDae0KYiY/MGOH2abu580qR6h2i56gQ5TRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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
> Sent: Friday, January 13, 2023 11:52
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; linux-pci@vger.kernel.org; Raf=
ael
> J. Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Bjorn
> Helgaas <bhelgaas@google.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Mehta, Sanju
> <Sanju.Mehta@amd.com>; Lukas Wunner <lukas@wunner.de>; Rafael J .
> Wysocki <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>
> Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridge in=
to
> account in acpi_pci_bridge_d3(()
>=20
> On Thu, Jan 12, 2023 at 10:45:03PM +0000, Limonciello, Mario wrote:
> > [AMD Official Use Only - General]
> >
> >
> >
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Thursday, January 12, 2023 16:41
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; linux-pci@vger.kernel.org;
> Rafael J.
> > > Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Bjorn
> Helgaas
> > > <bhelgaas@google.com>; Mika Westerberg
> > > <mika.westerberg@linux.intel.com>; Mehta, Sanju
> <Sanju.Mehta@amd.com>;
> > > Lukas Wunner <lukas@wunner.de>; Rafael J . Wysocki
> > > <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>
> > > Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target bridg=
e
> into
> > > account in acpi_pci_bridge_d3(()
> > >
> > > On Thu, Jan 12, 2023 at 10:09:21PM +0000, Limonciello, Mario wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Sent: Thursday, January 12, 2023 16:02
> > > > > To: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > > Cc: linux-pci@vger.kernel.org; Limonciello, Mario
> > > > > <Mario.Limonciello@amd.com>; Rafael J. Wysocki
> <rafael@kernel.org>;
> > > Len
> > > > > Brown <lenb@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> Mika
> > > > > Westerberg <mika.westerberg@linux.intel.com>; Mehta, Sanju
> > > > > <Sanju.Mehta@amd.com>; Lukas Wunner <lukas@wunner.de>;
> Rafael J .
> > > > > Wysocki <rafael.j.wysocki@intel.com>; linux-acpi@vger.kernel.org;
> linux-
> > > > > kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>
> > > > > Subject: Re: [PATCH v4] PCI / ACPI: PM: Take _S0W of the target
> bridge into
> > > > > account in acpi_pci_bridge_d3(()
> > > > >
> > > > > On Thu, Jan 12, 2023 at 09:51:24PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > It is generally questionable to allow a PCI bridge to go into D=
3 if
> > > > > > it has _S0W returning D2 or a shallower power state, so modify
> > > > > > acpi_pci_bridge_d3(() to always take the return value of _S0W f=
or
> the
> > > > > > target bridge into accout.  That is, make it return 'false' if =
_S0W
> > > > > > returns D2 or a shallower power state for the target bridge
> regardless
> > > > > > of its ancestor PCIe Root Port properties.  Of course, this als=
o causes
> > > > > > 'false' to be returned if the PCIe Root Port itself is the targ=
et and
> > > > > > its _S0W returns D2 or a shallower power state.
> > > > > >
> > > > > > However, still allow bridges without _S0W that are power-
> manageable via
> > > > > > ACPI to enter D3 to retain the current code behavior in that ca=
se.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-pci/20221031223356.32570-1-
> > > > > mario.limonciello@amd.com/
> > > > > > Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Applied to pci/pm for v6.3, thanks!
> > > > >
> > > > > It'd be great if we could include a short description of the prob=
lems
> > > > > users might see.  I think the original problem was that on some A=
MD
> > > > > systems we put a USB4 router in D3 when it should remain in D0.  =
And
> I
> > > > > assume this means something doesn't wake up when it should?  Or
> maybe
> > > > > we miss a hotplug event?
> > > > >
> > > > > If somebody has an example or some text, I'll add it to the commi=
t
> > > > > log.
> > > >
> > > > Here's a blurb for what happens on AMD side:
> > > >
> > > > When the platform is configured to not allow the PCIe port used for
> > > > tunneling to wakeup from D3 it will runtime suspend into D0 and the
> > > > USB4 controller which is a consumer will runtime suspend into D3.
> > > >
> > > > This inconsistency leads to failures to initialize PCIe tunnels for
> > > > USB4 devices.
> > >
> > > And what is J. Random User going to see?  DisplayPort not working
> > > ever?  It works to begin with, but not after a suspend?  Devices in a
> > > dock not being able to wake the system?
> > >
> > > I don't really know what "PCIe tunnels for USB4 devices not being
> > > initialized" means for me.  I want to know what a problem report from
> > > a non-expert user might look like.
> >
> > DP tunnels aren't affected, so monitors should still work.
> >
> > In terms of what doesn't work it depends on the architecture of the
> > the connected device.  Here's some concrete up-leveled examples:
> >
> > USB4 docks contain that a PCIe network adapter and that adapter won't
> > work when the dock is plugged in after the system boot.
> >
> > USB4 docks that contain a USB network adapter should work properly,
> > but downstream USB4 or TBT3 devices connected to that USB4 dock will
> > not work when the device or dock is plugged in after the system boots.
> >
> > TBT3 storage devices connected after the system has booted will not wor=
k.
>=20
> Thanks, this is exactly the sort of thing I was looking for.  Since
> they all mention "connected after boot," I assume the issue with the
> current code is that a hotplug notification is being missed because a
> bridge is in D3.

Yeah.

>=20
> If the devices are present and enumerated at boot, there's no issue
> with suspend/resume, right?
>=20

I intentionally left that out because it's going to be conditional based on
a lot of other things.

> What do you think of the following possible text?  I don't want to be
> overly specific because I don't think it's practical to list every
> scenario.  We just need a hook to make people think "Hmm, I'm seeing a
> dock issue; maybe this is the fix."
>=20
>   This fixes problems where a hotplug notification is missed because a
>   bridge is in D3.  That means hot-added devices such as USB4 docks
>   (and the devices they contain) and Thunderbolt 3 devices may not
>   work.

Perfect.
