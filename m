Return-Path: <linux-pci+bounces-31775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DECEAFEB2D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A7E4E291F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B1C2E8880;
	Wed,  9 Jul 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CxlQFxem"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105E82E5B2C;
	Wed,  9 Jul 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069489; cv=fail; b=SXE5SV7SBwM44wst5Dmj8eU6ukpweGJdjCwn2S1gU8/ezBhdd1T84UZXPTtmEOclIoGIbLdWuxidRzB0IIyiGVbgnvbSbNYcmzCsVr1edSGi6SbGmTsHNZschxNYqqA8rwhAOb7zXewBuiFXsPwCLMHpV3t+RTLrpsunAs3saXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069489; c=relaxed/simple;
	bh=BN3qADC9i4+4jh+mBRu3gaSuqVIFIwUHXoiiRPWcsmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qT4KE49X6+6iV7c9a3sz/oQqJkzyubp2477qkD1jUuJewIwJtBhVHuOgzq+ETod0Wk9BdHkSnOGE3C6Yu8rPfR8I9sitfKWDLuoI8R957/Tn9l58ep4XQ7MUycNPOO9Lt1Llg30idwuNtlpewBX54DcZUo3lJmKCaKBHcz8k+Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CxlQFxem; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH99ZU73JkDozfBEUpRIvaf8JUeRhrCh9xUmLMLEMdi/By27xLGOIiLcBwoK9S9voJ1UJsDncTFvjwMGSQQIKzOWw2BdSVl0ixSrnN/rPGFQZmxBCk5TYZtZobaeu59JOpNIct94qccZE5xjDqF6MaXT3BnbIoiYUOLP0wQ24HR79xaCIw1HFYf1zdRzCYWr7M3BGiDNSP+fdW0YdooZuyXiFmgBJWPKvdpjsP8WgPXFmN7RTsnseA/Cjx39Qjze3kMV0z24orAJcmlp5lPF6/KwA9Yfq1DWd9qYjCYTs08UX4S/Vs63vscxdGMJPbaZQ4wsh5IZTvFxujTvdJ66kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXBP+oansSaDj0g1MWQ6z0bQNOp3iHRp0oAYjEUE9Lk=;
 b=szGC4slfEdJ2Eq9s6POJrstbJOzpFy1os0IdHHej/hpg+OcYsYpSdKVeIzVVCWmi2BFiBeV9/b4pIyH9XDtnstlAM2PxXkP9YPhWm7RgXVvEsTJ8ROt82/qhDy8+kmjIgJkLIf7QxNGNzn7GbfR4L6itKRbDLKfVxLsTKkYTp6NxdbT28VNJz2AHh21RMuZwvOfXo8eYuz0ShXFmpJ4t9YkmK0JdPsxmw9vDTfXrrXkcjdnlXGigezABuLKqf3NU5Asg3ApqcIqwSkIFpM0ndkNNlwiMgyaNZWphgzxKc9Cojo+76R/IB2K0HZCuS1M5x83Q5OlJKsHr4inHiIQRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXBP+oansSaDj0g1MWQ6z0bQNOp3iHRp0oAYjEUE9Lk=;
 b=CxlQFxemA7agnT1/fcFj2CRl3BrDE/SwtJn/N8hVMp5IvM8RGcg3AmKbf5SduIaNd/RlnCwyt+4orjGnYJuFhCNRefG2ZOsVEjkaQdOoM1C7sVecnamSNtTdBfikWxzTjXBjQUJrXrCX3IPYl3Klpy62ymNZ3gF9/tI6YIzhA88=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.23; Wed, 9 Jul 2025 13:58:03 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 13:58:03 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "lkp@intel.com" <lkp@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v4 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Topic: [PATCH v4 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Index: AQHb5l4cnivLszIGk0GQVNOmpOsA5rQo8eGAgADzgAA=
Date: Wed, 9 Jul 2025 13:58:03 +0000
Message-ID:
 <DM4PR12MB615836EC3E90259F51568F56CD49A@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250626054906.3277029-3-sai.krishna.musham@amd.com>
 <20250708232327.GA2169793@bhelgaas>
In-Reply-To: <20250708232327.GA2169793@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-09T13:54:58.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|PH7PR12MB7428:EE_
x-ms-office365-filtering-correlation-id: 3af239ae-c0c2-4fe1-36ac-08ddbef09f8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gmp/0Ozz21E9JMU6ZfPDoM5ARxJbvNPvfGw4UylUQ3U/cyEcngtTIgAV5hzC?=
 =?us-ascii?Q?G8Na8zPJXOxmlGNu3OJpxeXg28ZujGLtsgLrn4OVzwb3he+ulI9SareuEuU/?=
 =?us-ascii?Q?SFVtYSgzgLLIdNlzI65Z9dWj10ipc4N4VTaQWApJgeUwRgNFAPGg0QHEBhEd?=
 =?us-ascii?Q?RFWDZn7CWLHqiWZR5fGfpaLHmzcvZf/QF8bns0icaRDAv+2xkne4DIMw6Pux?=
 =?us-ascii?Q?Boz0IdYCtkzkRcPWj+gisYtW5GhZ7rUz9YsNbXHcbiuGYGvqmbE57aHMSa1s?=
 =?us-ascii?Q?MnyiRwZ47RAkVEMgj86eycD0/8nYeCx9lW7wcb5v3MxRVnq59/iab63AxaKp?=
 =?us-ascii?Q?Mz5QeJzwiyBvrd3sTCdZAQr/BXMRmpJR7klEDCDcUqTeHm2f72LV1N6LyJqg?=
 =?us-ascii?Q?tzICIfGKcFeRPjS5M62ewyDQXWWt/SwDgwuTW8xUsBeo5yFZG/GqcCjXMVkU?=
 =?us-ascii?Q?A/2zfLmM/D/BNfSR9VGvF2HVTUvRYpXAowMMYkJVyjMtNyomE4LuYpLCyijH?=
 =?us-ascii?Q?6r827I3DvNgslFoZhogyR8L+1X83jNzCfsYkbNwoQyHdjedzjBt/64mtTiW+?=
 =?us-ascii?Q?F1jiU47zqNJ8gr0P00BIVEhOYOa9J5UscD4RAovwhmZQS1NpiElYDnokOxa1?=
 =?us-ascii?Q?jFEs3qcTl/sbXOsJU4aJq2S06u3CweG4p8LoGMD27gh84VlKz+fYbTciybr5?=
 =?us-ascii?Q?Px8xiIbM7oYcCW3BgKDCN5noipcLkZk98GirVEv8Jpb8kTpw0TnNi4wMhC8O?=
 =?us-ascii?Q?dfOoVSimfGhRjCr4P+3Xh2a5xDrPZ2DmLMZ2ytCqnOsjXVVdxxpDPetCC5OP?=
 =?us-ascii?Q?Q11RVq4MQqdzZY8DM2arbVXCp9S8amUjCQJVeU3FTzT/CaVRieDegRLBSXYy?=
 =?us-ascii?Q?W/POVy2zNTcQcyJH/LYTHYpWAh5qtayUSgPZS28z4/EFHl9zbtvyqgR6wp6w?=
 =?us-ascii?Q?ABqFIZdRD2FBLZoXeZpdgXygSs2a4eZB8Ds0LjIFu67jICes2GFjmSOW1GxJ?=
 =?us-ascii?Q?8f6QOuXfc0vDy/3Hxd3vQ73soquNbMEQkxYO2/VOMwSCSbF7nCO23YenWiGT?=
 =?us-ascii?Q?Dm3zHIIYQDLdxl02LsOhVkL+bdzlJ7P1QtCvDzMOMjy3Vq3C/mLB9txmtB2m?=
 =?us-ascii?Q?6sR87tFdYB1xbBFQWmU8CUNF1TrxGYcr+BLkuyTqVgQeJTenV0vwOk+NcL7X?=
 =?us-ascii?Q?22d389qjbquwwGWJInPLQrZmKu+djyxscuRDXMy28Ys0T8L7jevr7P4zUWBu?=
 =?us-ascii?Q?QLuDC/jq9Rg0b00ECPzVgyyOqGF2hsed0tuvsYPyUEYvy5yAtX7ZGEnvak2U?=
 =?us-ascii?Q?M834RG3eY4y/JL/zvv+0wqnwfPbGh8q4awPp3x+j4YlyAP1fMin7//u0z7lI?=
 =?us-ascii?Q?nFR7YlJXceDQT0Sm9VJjFQJVmK7lYp5kHvarCu4xNaRNKaq0wcVd39h/vtg3?=
 =?us-ascii?Q?vDwqGXtBddLnYYEOwWoqQxoZwmkqPg7piASBEFfJ/Buwnedh9DFhI/neMpMs?=
 =?us-ascii?Q?32XLTO65D2FEPO0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EMStUukFtmL+dzRA6Rn1WJ4veD5s/bdNnjGmJ9pBfZbcDbkllPBaAenf4W8A?=
 =?us-ascii?Q?YzUUjoLBxr1oVdy1xvkLhkSzWKC8SUqiVvkBaQhyOihT0sSCiKH2ef9qAocp?=
 =?us-ascii?Q?XGAxSi34CvUUW4EREDXcb/8xN35mrVbcYWdeCSbv9RJDqMoY10YmlGdlM9/3?=
 =?us-ascii?Q?Qfbeww/5Y0hHq/SjkMlVjfzM1/wAGv8g22bfQPfVr1Z2G1VsXpeM++k/mJ2A?=
 =?us-ascii?Q?O7ytDNR08pw23Wep4ljlufRRC7BtRWiqJzM1F5bXcOgbjXmkU6n0eDfS6ziZ?=
 =?us-ascii?Q?CI039BYWoc2xpLB/zB7zMDr8XZvrIMx67PDkmt8QU6m724V1qA/bxMOiDrKW?=
 =?us-ascii?Q?O1EB6SvPDvBVc3UmfxEae3Hl7gUzIM9c2BQba14rK6oM7ix1mQp2n3h1mCsH?=
 =?us-ascii?Q?5a3N721yzralOHv1JjPAG8vOH4uL2TWypxeyZymZEFDooRVs/yvQCja60DG9?=
 =?us-ascii?Q?p/jh1qAFij82xnw2R1YNNJhEK59kWjCL6X6OqDot6oJbIGA2wHrhIKrZWSs5?=
 =?us-ascii?Q?bb1ZhOB2SEig9A6n5cj7ogAyXrj7EbKKnlDydQsB6puOxz3A5CxOhtG/3nRH?=
 =?us-ascii?Q?vtHE1jF0OepQNERlcKG8SuUSNuHPGQLGZ4+2j/NvG6glqcp+NN9VrUHG2p6a?=
 =?us-ascii?Q?QG/leAoddPHSbV/C+oWYvwgqscnNYJp91GOdwHVn7TKyG0zreg+XE+IxqyxE?=
 =?us-ascii?Q?cQoygkllbIitqFtv2wQHnLF9uL7o8aCB3u3olxwBJOklpN6nidnXNp141iSU?=
 =?us-ascii?Q?0kMw1rPtkao6HQIdUUuyES0XT5374R499e2GVrJjUAZq9WZrypjobFm3peWs?=
 =?us-ascii?Q?TKBcDmO1XJJC9uQuXO/8Ur5bre+IJ2KjC87wdTitZOGvHabJb9gN40l78S6R?=
 =?us-ascii?Q?LU87UwDwH66+0tzVrjySoAv4HMBowLc3+RGf/EiTr770brj1LaPtq2J+SYNE?=
 =?us-ascii?Q?Od0HIdQa/+qEASB+iWg5pHOqfHn6AURZ7UIkPO/JorgIbtlDehc+k/vTU3x5?=
 =?us-ascii?Q?EaDhXkX4omfy0p8U3DekSuj6QwCAHUStbvHYyOxdDJvswk21xiMNArD7qlH6?=
 =?us-ascii?Q?yazlcA7YItXWX3/nxOZ61gYsszcHPmGcPzFaOftiSJIG3jqv4cNCoqxyUYOS?=
 =?us-ascii?Q?DRuIdn5JgTaUQ2fyYZChOwdApkI1RFeTuMxTQOxhD0DlUsksOgfYLWuAWw1m?=
 =?us-ascii?Q?actCtN9oe7n/Uv+awzyvYgKBkP+Vxj8nCi4xFv8SaSTQthWna2ryslyCD2fg?=
 =?us-ascii?Q?bQgZ1gO6DLf7ljnVNuWXEAeHvcI2BHNOyP7i4NQHKj4CgTZjIn8r4p9x/5cA?=
 =?us-ascii?Q?DRPXH7JWIBkfL5sNjNiaNXygqB06KbrRc8A9cdZQTROdoqCcah4afgs2HzOQ?=
 =?us-ascii?Q?pr74XtOgWN/B69tG/d4T3VczUkf98iooXpU39ki5/jhDLcmGx8AxYACRKMeO?=
 =?us-ascii?Q?YO0CfqoW4hBPmRICny1TT4ymPfgO9U3t7LxJjidE40rgcPhZAYc1fJmj4UpO?=
 =?us-ascii?Q?Uc//cbiJlASxrazD7bnA0Tikql2lfZFHn7zGFdAEGYVp1fv0l70u3onnw/ht?=
 =?us-ascii?Q?RRJXvTTigPFnlT3NUwk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af239ae-c0c2-4fe1-36ac-08ddbef09f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 13:58:03.4303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goznrE1a5oPx9XBO962gT33cIipadQsUEyofACIC8FyGCuIzJShYXe9z08jOsm1yoY37jj41t1WtMQmHZcpv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, July 9, 2025 4:53 AM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; mani@kernel=
.org;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.o=
rg;
> lkp@intel.com; linux-pci@vger.kernel.org; devicetree@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bha=
rat
> Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: Re: [PATCH v4 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
> signal handling
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Jun 26, 2025 at 11:19:06AM +0530, Sai Krishna Musham wrote:
> > Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> > signal via a GPIO by parsing the new PCIe bridge node to acquire the
> > reset GPIO.
> >
> > As part of this, update the interrupt controller node parsing to use
> > of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> > node now has multiple children. This ensures the correct node is
> > selected during initialization.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-
> lkp@intel.com/
>
> Omit these tags.  This kernel test robot report is basically a code
> review comment that doesn't need to be acknowledged here (the robot's
> report says:
>
>   If you fix the issue in a separate patch/commit (i.e. not just a new
>   version of the same patch/commit), kindly add following tags ...
>
> IIUC this is just a new version of the same patch, so doesn't need the
> tags.
>

Sure, I will omit these tags, Thanks.

> > Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> > ---
> > Changes in v4:
> > - Resolve kernel test robot warning.
> > https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.c=
om/
> > - Update commit message.
> >
> > Changes in v3:
> > - Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpio=
s
> property.
> >
> > Changes in v2:
> > - Change delay to PCIE_T_PVPERL_MS
> >
> > v3 https://lore.kernel.org/r/20250618080931.2472366-1-
> sai.krishna.musham@amd.com/
> > v2 https://lore.kernel.org/r/20250429090046.1512000-1-
> sai.krishna.musham@amd.com/
> > v1 https://lore.kernel.org/r/20250326041507.98232-1-
> sai.krishna.musham@amd.com/
> > ---
> >  drivers/pci/controller/dwc/pcie-amd-mdb.c | 46 ++++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > index 9f7251a16d32..f011a83550b9 100644
> > --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/resource.h>
> >  #include <linux/types.h>
> >
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >
> >  #define AMD_MDB_TLP_IR_STATUS_MISC           0x4C0
> > @@ -56,6 +57,7 @@
> >   * @slcr: MDB System Level Control and Status Register (SLCR) base
> >   * @intx_domain: INTx IRQ domain pointer
> >   * @mdb_domain: MDB IRQ domain pointer
> > + * @perst_gpio: GPIO descriptor for PERST# signal handling
> >   * @intx_irq: INTx IRQ interrupt number
> >   */
> >  struct amd_mdb_pcie {
> > @@ -63,6 +65,7 @@ struct amd_mdb_pcie {
> >       void __iomem                    *slcr;
> >       struct irq_domain               *intx_domain;
> >       struct irq_domain               *mdb_domain;
> > +     struct gpio_desc                *perst_gpio;
> >       int                             intx_irq;
> >  };
> >
> > @@ -284,7 +287,7 @@ static int amd_mdb_pcie_init_irq_domains(struct
> amd_mdb_pcie *pcie,
> >       struct device_node *pcie_intc_node;
> >       int err;
> >
> > -     pcie_intc_node =3D of_get_next_child(node, NULL);
> > +     pcie_intc_node =3D of_get_child_by_name(node, "interrupt-controll=
er");
> >       if (!pcie_intc_node) {
> >               dev_err(dev, "No PCIe Intc node found\n");
> >               return -ENODEV;
> > @@ -402,6 +405,34 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie
> *pcie,
> >       return 0;
> >  }
> >
> > +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> > +{
> > +     struct device *dev =3D pcie->pci.dev;
> > +     struct device_node *pcie_port_node;
> > +
> > +     pcie_port_node =3D of_get_next_child_with_prefix(dev->of_node, NU=
LL, "pcie");
> > +     if (!pcie_port_node) {
> > +             dev_err(dev, "No PCIe Bridge node found\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Request the GPIO for PCIe reset signal and assert */
> > +     pcie->perst_gpio =3D devm_fwnode_gpiod_get(dev,
> of_fwnode_handle(pcie_port_node),
> > +                                              "reset", GPIOD_OUT_HIGH,=
 NULL);
> > +     if (IS_ERR(pcie->perst_gpio)) {
> > +             if (PTR_ERR(pcie->perst_gpio) !=3D -ENOENT) {
> > +                     of_node_put(pcie_port_node);
> > +                     return dev_err_probe(dev, PTR_ERR(pcie->perst_gpi=
o),
> > +                                          "Failed to request reset GPI=
O\n");
> > +             }
> > +             pcie->perst_gpio =3D NULL;
> > +     }
> > +
> > +     of_node_put(pcie_port_node);
> > +
> > +     return 0;
> > +}
> > +
> >  static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> >                                struct platform_device *pdev)
> >  {
> > @@ -426,6 +457,14 @@ static int amd_mdb_add_pcie_port(struct
> amd_mdb_pcie *pcie,
> >
> >       pp->ops =3D &amd_mdb_pcie_host_ops;
> >
> > +     if (pcie->perst_gpio) {
> > +             mdelay(PCIE_T_PVPERL_MS);
> > +
> > +             /* Deassert the reset signal */
> > +             gpiod_set_value_cansleep(pcie->perst_gpio, 0);
> > +             mdelay(PCIE_T_RRS_READY_MS);
> > +     }
> > +
> >       err =3D dw_pcie_host_init(pp);
> >       if (err) {
> >               dev_err(dev, "Failed to initialize host, err=3D%d\n", err=
);
> > @@ -444,6 +483,7 @@ static int amd_mdb_pcie_probe(struct platform_devic=
e
> *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct amd_mdb_pcie *pcie;
> >       struct dw_pcie *pci;
> > +     int ret;
> >
> >       pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> >       if (!pcie)
> > @@ -454,6 +494,10 @@ static int amd_mdb_pcie_probe(struct platform_devi=
ce
> *pdev)
> >
> >       platform_set_drvdata(pdev, pcie);
> >
> > +     ret =3D amd_mdb_parse_pcie_port(pcie);
> > +     if (ret)
> > +             return ret;
>
> I'm not a DT expert, but doesn't this break if you run
> amd_mdb_parse_pcie_port() on a system with an existing DT that lacks
> the pcie@0,0 stanza you added to the binding in patch [1/2]?
>
> I.e., amd_mdb_parse_pcie_port() will return -ENODEV in that case, and
> the probe will now fail?
>
> It's good to add new functionality, but if the driver runs with a DT
> that doesn't describe the new functionality, it should fall back to
> the previous behavior (without the new functionality) instead of
> failing completely.
>

Thanks for the review, I'll make this change for backward compatibility
and include it in the next patch.

> >       return amd_mdb_add_pcie_port(pcie, pdev);
> >  }
> >
> > --
> > 2.44.1
> >

Regards,
Sai Krishna

