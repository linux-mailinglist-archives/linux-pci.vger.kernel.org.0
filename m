Return-Path: <linux-pci+bounces-20693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD0A26EA1
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 10:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22747A2934
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2169B207DE5;
	Tue,  4 Feb 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JIs+fXMI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB653207676;
	Tue,  4 Feb 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661876; cv=fail; b=eiA1accDOlMTPmIEdboNYV74bQfnB55bJl+qpWwSpjOedivrbcEM3i3N0rU1mPVfpZrNwbdsV0ttzB1pkpsL8gbin0Bv2wLx41i0u0xsGyteLVHyTVjUsqjMzFdk/V1BfSFFQ2PgzUZi0HKNOB5aWgRSKCyTA57Ajsif4nimQ3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661876; c=relaxed/simple;
	bh=EVhTBz90CMhjr961mEfL7EV7B1oqhj5GiREva7eRbEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ChSxSDrGCPZPYwdixh2Qbi8gcVJztJgccTSQd1fkI1xiN5DdJSPPh4ml8RpFsrttWMa1sv0rJdfFUveLuVgCINZZqP5IJGAoRGQLFrSzWfryOx76uRPcTjSm9unVHz98Ryf2mjr+WpNqsccSpE07gZR+9k1k1nekX/0riZSMjLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JIs+fXMI; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU4sj7Q8E2O83gTTXcpIRRmOffqJVEuE65+heMZmYajRTHfm3Gg+lurXPKWE1tekZnUKWrezypRGAWusgqKjBfRIwyAsA9E9iUi2QxEMs38hD6Jtwxzr6bh7ED1wII7JJ/5EoxUvdyy//B4/OQd9QoTtDtsIMyx6HnXYc+sggtRRsuuulcLyb650W3ZieJAbZ3mUVW4V5ND0Aqwm1aWfzN3ng2gVLaOWD/uhPQM90sB/Arl8pmkBSvHxnMXzL7yikoWFJRv3QRvKrN7csEhbe5JmSAs4wrJZX3s1Ozd+wGzgsFL/Tly22mADTos8hHdVz0F53ARIbD9VefQGYbXWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig45EIgvYGG2KJOMToKW3Ax4/Dj38TBhylrjDIcA/kE=;
 b=wIG+rVoxijJ6AZ5SbH+C5IxP/PQRlOhc7WdKWzh09oCkipkNwOgQmh2KYlsAa+HQYFNNEivYIeWgiV0uXiv6cBODYz6D+bsNOekLpV6CA8UcVNd1RD1I0W48JJ0r5+/dBj+7N0hECR0qFW3cNoIn+hy9NwRHE2ncQLeuxK6ay0ZMJtUWxn1eLjotjZKy2Pp1rMQmEeJCx1LjBnJIPdTPqF9VqZjyYijCDj5zs5TR+YUI0fkhhj5zJ7iQzx4v21TrQMLgh/vmPlLa2V02EfeMLThTRvcBCXO3cGaj+6PkZNoGRIpBXHb051QIzOZtJEOzkIVwGlM7p34CffCLGEgVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig45EIgvYGG2KJOMToKW3Ax4/Dj38TBhylrjDIcA/kE=;
 b=JIs+fXMI0D6rC4PtdbShSA7MZpO5sDG7IWYKF8rrufoISsri5hfmozVFuvIpeabX5rdc5VTIy721NyyrjGOltzoe3DivcnC1do6T2lXHYo2nlA36X2dRq5cZrZxavP2+ydK5pNTnQNJSVRQzC5AOuH95nsNdwKFn5m+7F5ogRCc=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 09:37:51 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 09:37:51 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbckFGnEXox34FgUW7RyRWX+Tmz7M17kwAgAD2/bA=
Date: Tue, 4 Feb 2025 09:37:51 +0000
Message-ID:
 <SN7PR12MB7201EAC37631E10EBA5A299B8BF42@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250129113029.64841-4-thippeswamy.havalige@amd.com>
 <20250203182822.GA793389@bhelgaas>
In-Reply-To: <20250203182822.GA793389@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|MN0PR12MB6101:EE_
x-ms-office365-filtering-correlation-id: b38cc34f-e84c-4c42-c735-08dd44ff97d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lHu1NS+VdbsUELPguR+AH45sy+DSLK6hkU2jJREZMVaiO0VrbtZSd6i5xtsX?=
 =?us-ascii?Q?qB5m5cmWyGR/q3sZIdYj57SmBVZ6oybzesEThPYZvNOWhtCBd0tYaJUzzneM?=
 =?us-ascii?Q?nRuic3ComcHcAYPEsxvSHJ9JWtAdQOOXRH9fYv+gsFcQTT+z17Bhu4OaVvYh?=
 =?us-ascii?Q?/3XcEOdrZz1NTJZjMHX8WpdI/QeFSJwrYhAU5E+Eb7YnbHmoG6+4Xj1IhnDY?=
 =?us-ascii?Q?nQQKRiJmJnrTidugPlnxFGyZgYVMmXVshVOdEiYK4sJs1a3NLKKyhcxkYt6e?=
 =?us-ascii?Q?Hnf8/i0hCdmx6IYW66Rr+pc4TsrNwPjIYxKNWgGdIW5+3oMqiCX6pjgRqda9?=
 =?us-ascii?Q?eE9WDDlZg778omlv1r+q12xIMVMvPPJdOLqsPJOSPOAtpSwVmT4G21ApkU7y?=
 =?us-ascii?Q?5mJbxiSh/a5rWNezZHk/IxQJa1aoyi0Y+PA2xfDiCXEE0HlXMj2t5qYlDxyM?=
 =?us-ascii?Q?iPY+Fi3b/V5UOOJzkrOEv0rdD88wBy93B9ka7oqsxqVBczzfWtCIhVVoMmxl?=
 =?us-ascii?Q?YjHa6c/lujRTkt1FCoeWzLbYH7RgfZWDuxI3BV5mlW0PWfyscnQEnwC4IPyT?=
 =?us-ascii?Q?ocXbNGta9pJhwQFcRBAD1xxaVeMPmNmweuTCZPTo3+CYzqMtJQkUESuzVSOY?=
 =?us-ascii?Q?Mom4F8kSBVwhMB1c6iMN8k9WZdkhypZAn2LHtMsX+gUh22wOIBInnu/VJmTE?=
 =?us-ascii?Q?gdSMhVxQWrPveei6u9CTrrFuobD6A67wQ7hmAk8LMvCZCQnWMtIvtViHhCaE?=
 =?us-ascii?Q?WTQgfdklyHjhwbz66y71rBDAAmVHrZHgf8wFKYY30Usq5sRT2VSz5s+p8Z1+?=
 =?us-ascii?Q?L2HHAufg5Fq+vWLrLhMrqTo40B7WKGSmApgXNESssOy6tNTAQIZE4hwL/iEM?=
 =?us-ascii?Q?5tLrKpiECL5J6F7HuHNVTgozNk1jvJl8CVzGJKJncsoaeRnUt54rd2hNu5dF?=
 =?us-ascii?Q?CGMSk0+1IeqYMNZ9eoEr7yCxqfHz0jkaKz0a4R4yBgpvqvmxUhyaWVIiFedA?=
 =?us-ascii?Q?zyB/PqD8xPvUGpWMUIBA+kcbFnl5iPgVKAPxvFai8kKl6bdFcag4JbKksVgm?=
 =?us-ascii?Q?NvONe8auEFHcQYiYrHw/+ov9t42cs5F41rgI9ccr9JZc7E19D42pNBiB0fh/?=
 =?us-ascii?Q?eN/gac2y0W1Ke2IV62nu5a90rXgA77X5Cp8+PEv4EMO4+4UVQP0juZhp7oLk?=
 =?us-ascii?Q?xkQ3RDlSYPVY4s5d7ofBFBj12g1EYqveJilKC7IdSM3l9xuHpPTG0BHZJUma?=
 =?us-ascii?Q?ID/5UmpmufmN/xgTCpVj7283kRnA+bVMrHbCvwfugWXvKpyR/bXMNZeLC8gI?=
 =?us-ascii?Q?8EPyHKyoHYHB4y8ORISpaak1Phb2/hVHFxEKHRemqarmkjFeDPNYUL0otULO?=
 =?us-ascii?Q?YaKRdWoc5g+4FiVcyVbx9WAHeNqxRGRXyV8agfgsUFl3RF6Jq9OFIk0PAXL4?=
 =?us-ascii?Q?VJ5zrPl5Elt337eiNsvgXWQWx/ZKtg1j?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QsoGL5AkWlfpzGmhxUc/Zm6ljjvjAXArnO8u5uOg5f5A7cXiVFA4jO0TFMfU?=
 =?us-ascii?Q?eCBqWWDycZf2IHz1+7PATUxBRz9Ry8TQy2shgKBWJp0MobzfJwdXOOPuO8jp?=
 =?us-ascii?Q?31SVyLufjkkjVcJhnqndnS0oipW/qgGB8ClolSOdjvCELkEbqUiTL7XMO0sJ?=
 =?us-ascii?Q?9b64iIsEXXxAile5U9eKNdb11tJ9bULyzWoPiFqcZPRk0ufGSEQ/UPZcJBC1?=
 =?us-ascii?Q?37vz9gS2qIj/xw4Hizh8wXAO1w7G4XCKJJyc62gt/F3BtExOnzQGR3NTn6AM?=
 =?us-ascii?Q?Loa7F0Ohi66pOkL+sULJ2BmMMQiPjK769XVWxkEwVovvmiPOb2Dcj/rMzJEy?=
 =?us-ascii?Q?94onvLg6rVOjrbccTW+fZqn7vkeiPw4h169Xc+bP1ku+AUz8TM+q24hLS8Gb?=
 =?us-ascii?Q?5OcgryQR1iNfesRr3TCT2kE5bmRQFF3Gj6E+xsBd5gNv1+TRRMeaoJYth18v?=
 =?us-ascii?Q?laeCBifs6WYKm7aldVFON54SMKI/QWTp1TH3KPJIIvdB0qbpOi2LJ50BLKDd?=
 =?us-ascii?Q?449tfdRF6UzsNX+vGO7TFei8ljziyOMy6RjakF+2brDcVAQ/p2a5SCJmVtmc?=
 =?us-ascii?Q?E3hEma5w8vIotkSd6s44DWsQw0CMgd7Au1OdazlWy8XZjGAu8RPv7m5jT3+I?=
 =?us-ascii?Q?keupfCBoxYVssqvLJ04Ekj2RDtLHoOvrj/ETrhMqJLRIqBzrROoEI6e6ZHgO?=
 =?us-ascii?Q?H1RXH14+71nMcXRVzcOP5/R095OvKhkYpTaEM3EVKAvQfVmq265wgA6TypX0?=
 =?us-ascii?Q?aUpI7vJGxjXtDlrjhXTtD83XtU+5Oop9A6iQ/ZteW9WHYBMF1h3lWgSTrxgd?=
 =?us-ascii?Q?Sp77165vI+Um+mQ/9BLz6Ip272O2AI8dteXQixpDn2iXUCtW9XGmf9uVMmfO?=
 =?us-ascii?Q?+t8wKU1rWcHsu8Wkg7lIQ45+AinN7Oudwrmc8HUWs8Q1711rTd1uG72etAfr?=
 =?us-ascii?Q?bbTLbJmkoKDAYYKq7tHDQfA4OduN4/9YE0p5GBtSjTmDCxjggBDmaG2Siwbu?=
 =?us-ascii?Q?Nz/g6pPr7qbUIat+8ssrwZwW2YXk3Re7IPvd6xRrGCJHcPcZYtjatwiLK4MF?=
 =?us-ascii?Q?N12H/DaVplftY0zc1J38Nmb37lTogeOwtqAq7yaAUJrvWU362GIwUo3bcyzf?=
 =?us-ascii?Q?wQMQZeMDZuYSIWuwR7fy6pjLT6NQd3fpYEUcxj9wKOEwbLi5fHoga8VXyjKA?=
 =?us-ascii?Q?IObXNoY9BW0KKmY2VN2S6/rC7qj9bBNmj8jCGp5h8TCJDCTtbxonzK/o6lui?=
 =?us-ascii?Q?7GWjRc4sxoQPYQo8qNAxB5gZwM52MMtKd7AJ2mal2DY5SbwpJ0Zgh3SMFeZr?=
 =?us-ascii?Q?h/+7RDHRhfDHoDyJ4RJOz8JPAsVZxX7PuLbhlHhKFZRxjarLh/sjq44IHL2M?=
 =?us-ascii?Q?+3ORYDAAMphOhIV+0rRKP06BXaOOV9/fCcFFCtc4RcFLoEVSlyPzWSoTuC8Q?=
 =?us-ascii?Q?y2ZGcm3MCj0Cd9jlPPChzy9s0+dFZNp4P2PrhnCs71k7W6/vhd7IXFs9PmN6?=
 =?us-ascii?Q?SRgU9pQp9MJbAkWTCB8I5wCkt5ItZdv4AmyyvwI4YKFqB6zCGBuBSqw/Ux9l?=
 =?us-ascii?Q?SMBXSKPqYr/4WL1b8xw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38cc34f-e84c-4c42-c735-08dd44ff97d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 09:37:51.0757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ni0aybVfheyGi2WdQcOdWjgQm5jMRpUxOVsY4M38uceaPC87ri57Z89lkGyFLRtJlXnXIwnIJ1x/Fssq+r9hbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, February 3, 2025 11:58 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
>=20
> On Wed, Jan 29, 2025 at 05:00:29PM +0530, Thippeswamy Havalige wrote:
> > Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
>=20
> > +#define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
> > +#define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
> > +#define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
> > +
> > +#define AMD_MDB_PCIE_IDRN_SHIFT			16
>=20
> Remove this _SHIFT #define and use something like this instead:
>=20
>   #define AMD_MDB_PCIE_INTX_BIT(x)
> FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK, BIT(x))
Thanks, will update this in next patch.
>=20
> I don't know what exactly the right name for that is; it looks like maybe=
 these
> bits apply to all the above registers (AMD_MDB_TLP_IR_STATUS_MISC,
> AMD_MDB_TLP_IR_MASK_MISC,
> AMD_MDB_TLP_IR_ENABLE_MISC)
>=20
> > +#define AMD_MDB_PCIE_INTR_INTA_ASSERT		16
> > +#define AMD_MDB_PCIE_INTR_INTB_ASSERT		18
> > +#define AMD_MDB_PCIE_INTR_INTC_ASSERT		20
> > +#define AMD_MDB_PCIE_INTR_INTD_ASSERT		22
>=20
> It's kind of weird that these skip the odd-numbered bits, since
> dw_pcie_rp_intx_flow(), amd_mdb_mask_intx_irq(),
> amd_mdb_unmask_intx_irq() only use bits 19:16.  Something seems wrong
> and needs either a fix or a comment about why this is the way it is.
- Thanks for review comments, the odd bits are meant for deasserting inta, =
intb intc & intd
I ll include this in my next patch=20
>=20
> > +#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> > +#define AMD_MDB_PCIE_IMR_ALL_MASK			\
> > +	(						\
> > +		IMR(CMPL_TIMEOUT)	|		\
> > +		IMR(INTA_ASSERT)	|		\
> > +		IMR(INTB_ASSERT)	|		\
> > +		IMR(INTC_ASSERT)	|		\
> > +		IMR(INTD_ASSERT)	|		\
> > +		IMR(PM_PME_RCVD)	|		\
> > +		IMR(PME_TO_ACK_RCVD)	|		\
> > +		IMR(MISC_CORRECTABLE)	|		\
> > +		IMR(NONFATAL)		|		\
> > +		IMR(FATAL)				\
> > +	)
> > +
> > +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
>=20
> I would drop AMD_MDB_PCIE_INTR_INTA_ASSERT, etc, and just use
> AMD_MDB_TLP_PCIE_INTX_MASK in the AMD_MDB_PCIE_IMR_ALL_MASK
> definition.
>=20
> If there are really eight bits of INTx-related things here for the four I=
NTx
> interrupts, I think you should make two #defines to separate them out.
Thanks for review comments. Yes, there are 8 intx related bits I ll define =
them in
my next patch. I was in confusion here regarding "PCI_NUM_INTX " since this=
 macro
indicates INTA INTB INTC INTD bits so I discarded deassert bits here.
>=20
> > +static void amd_mdb_mask_intx_irq(struct irq_data *data) {
> > +	struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(data);
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct dw_pcie_rp *port =3D &pci->pp;
> > +	unsigned long flags;
> > +	u32 mask, val;
> > +
> > +	mask =3D BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
> > +
> > +	raw_spin_lock_irqsave(&port->lock, flags);
> > +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
>=20
>   val &=3D ~AMD_MDB_PCIE_INTX_BIT(data->hwirq);
>   pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
- Thanks for review comments, Will update this in our next patch.
>=20
> > +	pcie_write(pcie, (val & (~mask)), AMD_MDB_TLP_IR_ENABLE_MISC);
> > +	raw_spin_unlock_irqrestore(&port->lock, flags); }
> > +
> > +static void amd_mdb_unmask_intx_irq(struct irq_data *data) {
> > +	struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(data);
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct dw_pcie_rp *port =3D &pci->pp;
> > +	unsigned long flags;
> > +	u32 mask;
> > +	u32 val;
> > +
> > +	mask =3D BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
> > +
> > +	raw_spin_lock_irqsave(&port->lock, flags);
> > +	val =3D pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
>=20
>   val |=3D AMD_MDB_PCIE_INTX_BIT(data->hwirq);
- Thanks for review comments, Will update this in our next patch.
>=20
> > +	pcie_write(pcie, (val | mask), AMD_MDB_TLP_IR_ENABLE_MISC);
> > +	raw_spin_unlock_irqrestore(&port->lock, flags); }
> > +
> > +static struct irq_chip amd_mdb_intx_irq_chip =3D {
> > +	.name		=3D "AMD MDB INTx",
> > +	.irq_mask	=3D amd_mdb_mask_intx_irq,
> > +	.irq_unmask	=3D amd_mdb_unmask_intx_irq,
>=20
> Prefer
>=20
>   .irq_mask       =3D amd_mdb_intx_irq_mask,
>   .irq_unmask     =3D amd_mdb_intx_irq_unmask,
>=20
> so the function names match the grep pattern of the function pointers
> (".*_irq_mask").
- Thanks for review comments, Will update this in our next patch.
>=20
> > +static struct irq_chip amd_mdb_event_irq_chip =3D {
> > +	.name		=3D "AMD MDB RC-Event",
> > +	.irq_mask	=3D amd_mdb_mask_event_irq,
> > +	.irq_unmask	=3D amd_mdb_unmask_event_irq,
>=20
> Same function name comment.
- Thanks for review comments, Will update this in our next patch.
>=20
> > +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args) {
> > +	struct amd_mdb_pcie *pcie =3D args;
> > +	unsigned long val;
> > +	int i;
> > +
> > +	val =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> > +			pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> > +
> > +	for_each_set_bit(i, &val, 4)
>=20
>   for_each_set_bit(..., PCI_NUM_INTX)
- Thanks for review comments, In next patch I will update value to 8 here.
>=20
> > +		generic_handle_domain_irq(pcie->intx_domain, i);
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> > +
> > +static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args) {
> > +	struct amd_mdb_pcie *pcie =3D args;
> > +	struct device *dev;
> > +	struct irq_data *d;
> > +
> > +	dev =3D pcie->pci.dev;
> > +
> > +	d =3D irq_domain_get_irq_data(pcie->mdb_domain, irq);
> > +	if (intr_cause[d->hwirq].str)
> > +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > +	else
> > +		dev_warn_once(dev, "Unknown IRQ %ld\n", d->hwirq);
>=20
> What's the point of an interrupt handler that only logs it?
- Thank you for your valuable review comments. At this stage, our objective=
 is to notify the
user of the occurrence of an event. While we intend to integrate these even=
ts with the AER=20
subsystem in the future, for the time being, we will limit the functionalit=
y to notifying the user.
>=20
> > +	return IRQ_HANDLED;
> > +}
>=20
> > +static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> > +				 struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct dw_pcie_rp *pp =3D &pci->pp;
> > +	struct device *dev =3D &pdev->dev;
> > +	int ret;
> > +
> > +	pcie->slcr =3D devm_platform_ioremap_resource_byname(pdev, "slcr");
> > +	if (IS_ERR(pcie->slcr))
> > +		return PTR_ERR(pcie->slcr);
> > +
> > +	ret =3D amd_mdb_pcie_init_irq_domains(pcie, pdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	amd_mdb_pcie_init_port(pcie);
>=20
> amd_mdb_pcie_init_port() doesn't initialize anything other than
> disabling/clearing/enabling interrupts.  Seems like it could be squashed =
into
> amd_mdb_setup_irq() or called from there so it's obvious that it's interr=
upt-
> related.
Thanks for review comment, I will update this in next patch.
>=20
> > +	ret =3D amd_mdb_setup_irq(pcie, pdev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set up interrupts\n");
> > +		goto out;
> > +	}
> > +
> > +	pp->ops =3D &amd_mdb_pcie_host_ops;
> > +
> > +	ret =3D dw_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to initialize host\n");
> > +		goto out;
> > +	}
> > +
> > +	return 0;
> > +
> > +out:
> > +	amd_mdb_pcie_free_irq_domains(pcie);
> > +	return ret;
> > +}

Regards,
Thippeswamy H

