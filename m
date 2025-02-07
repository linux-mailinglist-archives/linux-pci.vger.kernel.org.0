Return-Path: <linux-pci+bounces-20913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D97EA2C92F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975E83A5124
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DEC18DB38;
	Fri,  7 Feb 2025 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P71BV5VX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3423C8AF;
	Fri,  7 Feb 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946765; cv=fail; b=OL7DRHD8QHikAZEjXh2cQRCwE2H23Px8bw+aD754oQzzF6bxZnybsIMXp7yTHu2ASWoYlnavWmN35oXMfnZm5h/DugP8kGlDkxgcCt4FWhdWCC/s+Xm4gtQdsaCmpNZ99Ezqu+35N+Bpn87hqCS8sZQk3YywIbk5HeOGXy6jfQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946765; c=relaxed/simple;
	bh=oJ1LWAniHhkgqIqO7zjTT3KqnXy1ho2rrI0icNTRv3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NT0qg90itVID4bLqQFQ4YnSjA6VBgftWIrHU/bU5UqmlwZ0+wa8Fi2s7JAjqOpsFez94F6EZqEZWPSaQlzoVZoVPMKzGBoe/3YNLIQi0QsUXP4hT5aqi3mzTo4L9aUSo39rI9x82pckC6hfmpVjzhRQb9pvXZAYnePGaJGIJ6so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P71BV5VX; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEr/pabAIoF0euQknn6DxEnwYCE2B6uLTAqxTf1qWhL/C4R2Ab+LXiVKK4setPtEG8GR0IRD8urIJOByXvRAwPOMAmMnoke0WV64XcFeyMnEvyi9tbilB6+H8B7nB7scuMgFsFZl1tIlg1lUDgRmKmAkLj13F62H9zF+dCRiProsLZOqlxpWYfnHpNhCReyXyG5M/+uQNu8KkJ/SmhKrwC9mNyrPwciLltw5yhaw5ddbdpcXH20NzzRTKGXYvirfPXeEPpkvNqv666bDLQffN06jWNaMPwzsCFxOfCpn7oI34dhwGSl0NPK9ne1CXcjgZSsJRJWs2kQ8jihTNdwTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9YpMa+7EQTqGxSGXOuGwcrTHr8w5/Rz2YovMEJ153s=;
 b=ZVt72MjHRPW7uFetaIYkP2V707OJcNEc62Cb7JcAZHjYEu11KlBjmW1mLVsiRT1gRwGou1ueMI1l61DjFPwGdC9MiqLUQYMYw/2ukykA+5FpT3g1BcIRPd+qmopStqA5iGAjR+BJ/Gv1UtGCJMGyRwJXGSwVEp8FDb5iortPkaeXBCRPMhlVjP13pgvA07XzaaSNQqT2I6vZd2ccUUDjc3pFoQcZm+Y/D/zCnJiy8M/KnLh3pGJBO76/8KAzUouvJbAg22/43elBeQcmKHaKf3kL4fpUOuxWFt3Xwbh5NcCxJMTP+haRq2NcO9sn8Kwp9bBJ9WFSXXMOeGH14W7U/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9YpMa+7EQTqGxSGXOuGwcrTHr8w5/Rz2YovMEJ153s=;
 b=P71BV5VXaATErOQu/py6y4RwmXiw4csGsL/jeFanILxTrgX9uAqoCOgV/2HU2fziSyHkZxGjLxjS8t+2n35+B0G4ZElFmJG36F55THanS5cJsn1AVb1m1hQWyx3Td8rQgMFfunIRa+08AVYbXQZOacbn3gDm2LorbTxVHrjJW4E=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Fri, 7 Feb 2025 16:45:58 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 16:45:58 +0000
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
Thread-Index:
 AQHbckFGnEXox34FgUW7RyRWX+Tmz7M17kwAgAD2/bCAANnSgIAA4JSwgAAEO5CAACnVAIADOvqQ
Date: Fri, 7 Feb 2025 16:45:58 +0000
Message-ID:
 <SN7PR12MB7201E0303AE7A1469A9BC62F8BF12@SN7PR12MB7201.namprd12.prod.outlook.com>
References:
 <SN7PR12MB720115611148E80D555A1A1E8BF72@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20250205142038.GA910930@bhelgaas>
In-Reply-To: <20250205142038.GA910930@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM4PR12MB6133:EE_
x-ms-office365-filtering-correlation-id: 12e3d7af-fa59-46c9-8a99-08dd4796e611
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?s7Nk3YWbOOEaQxmMEFXd0q+q/u+/EaAooY+tb0xnUog/084B9T+wg1ouzLCX?=
 =?us-ascii?Q?rIu/tHKF5kV5Hp/ebSvysgDV573NIG0nxN8R66YfmGPVllbVtMcmM8Seq2QG?=
 =?us-ascii?Q?waWmgTHvvPL3cEY8HXXeks5eYZUdUlxHWDhI/QRdUsnq1Jr3eK6BtzcIgUML?=
 =?us-ascii?Q?01n6QHKHUg5WBm98LKUwDxK2JAnnLx/yM51JW7Q37W8umAIwAh8OuJMG64hD?=
 =?us-ascii?Q?y3SajXn/puVkjU3ocRap+XSeuOMh69RUDQPAzCsGeg6cJ9KfvotNEDfDnY0z?=
 =?us-ascii?Q?e+0g2nhRaVJu7c1I0Hk9z5ZFkGajVtjyK+ZMBCnDB/epRikfvTtFIY/8+3SO?=
 =?us-ascii?Q?X0YieJKhmQWoYb7hRLWYWBndNOfpArndrNYe9rQWhib3K1A0SWUaQNultnXF?=
 =?us-ascii?Q?9bOVNJn1jao3qZPKkA4OdgtIow4XDbrbXKBv1914yKQt49HGQlaNwTuC6OUm?=
 =?us-ascii?Q?2BAK0+18egco9D26anmEJ8Qmy3iWb0WzEgbA28TPB24oM+zv0KaXArsVk5db?=
 =?us-ascii?Q?AWgc475dky++lrrJN6Mf+9pc2sH3YA78s1WHLw8I2K7jKJLI7m9bPtAkneYB?=
 =?us-ascii?Q?ysjjce9GeB2HNY235wjWRY5k9FRXfBn1lzlZi9fkrZHMGafbRHLcK6+ITcfv?=
 =?us-ascii?Q?Gw5nSmrWH9PSk5NdcvbsoCE9bTvrjlaWoK3AYDrePdpyKpTVQq1/DBbI3Aa1?=
 =?us-ascii?Q?zo6F2hte3vIy1s8ZcyBxVST4n9WYg30r8aHeDus4w6sCokl4SDKPbY91oltB?=
 =?us-ascii?Q?uZ0VSXLjdJ6Lns5GLmbC3JJ2zB7KMS4sTIPrwrSkBYkeDBL7qM88zl/26mp3?=
 =?us-ascii?Q?6/29VrGiW/nzJpsreYKTAnb0FFSdeEM1nF7n1KVs9jwllsfTyLrjgF5OvRf6?=
 =?us-ascii?Q?/PbtCAi78e2QO7o+5aF79z5tqpjwYYg8tKdVqU7zrIQFlZhMDJS4C/fcAlji?=
 =?us-ascii?Q?afpJfXvYedvkqnqZJlq13br18HFFa4xIDHiRhUcQrgJeKDlUOXr6yDifQqHs?=
 =?us-ascii?Q?T8yee26Z12Q3l5ymIdsWZtGBOd8rURjWa0+EafDhMe4lNGJwFVk4esIVVRok?=
 =?us-ascii?Q?2yuubPh6ggeZMloYyij/ikhVN7FUMIdyXzpUJLZ2cyzcBx+hjoOT4QV4swk/?=
 =?us-ascii?Q?mybWmuyZ3OkfxYuc+BMnfkIO9WoTfRtltQyTvo4m+UFwt7pzmASqRR8LzzRO?=
 =?us-ascii?Q?0mGE0FcLCs6XM4+/BnIGWvM8WQJEzH+gaWv/w+nRJLTxxw3AAjOkHLHjxbO2?=
 =?us-ascii?Q?opyvEOys7FkzTf6r1VQA1o6h26L6dP2QHrAaXecxsuKHrRM0lZwwY1WWFYT5?=
 =?us-ascii?Q?p1QeQ/X7cA9Hlv7FCa4KYB07M8jWoLL1K00kUpfrjYGK3qVrQ/j84j+2UBWc?=
 =?us-ascii?Q?Nht5nmnJsWvT+OKXUnwVre7QFUsm9j2rwLsKzxoOZsQxR4s/2vt6w/sIbkM2?=
 =?us-ascii?Q?nRkfT5XSohzVYnfNWZsP3Rskd3Q3GY4i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DsnpYlko36l/8e9RTtuVK5K0H6/pbNrAUtTpqfe9AldP2XwLTkB2y0h/mhLf?=
 =?us-ascii?Q?wLfAJ4ZxiwMb47olzWIogHX365d9koANMzP49NRbOJjNmC/8BBy34kPtiULZ?=
 =?us-ascii?Q?j9NrbHdQzfhFabhdX64C0H7CvV0aj1TJDw5WIx9D6bBfYwb4sW9CHNovteDm?=
 =?us-ascii?Q?Z4Z7ctGZTdzAbwisVELWpKqRZCo411lj8pirm9skqkFZJtc6ivVBq8d2j0I7?=
 =?us-ascii?Q?wxqzI8CiridoI2RoO/c7mjC6NXdtPGqWxk/ggX9/xeu8cXMF0o8Ii+bIIku7?=
 =?us-ascii?Q?fBANtFFwu1XdTxm3nfvKxIbZI6lGQGhOlmwScm1y9yj2gwK+pQGhhocVqRu/?=
 =?us-ascii?Q?iWYbMOtuzp4YoF9b2+ejFkwEfBz92LZp4nkKxPvOw0O91jQA1uLUANdtZe7c?=
 =?us-ascii?Q?Z5w8lyS4lc8uuw6DOtXnsHupGHMHGleDFzmx+yHLzsrOO1Z+cn/S/W7+Opfx?=
 =?us-ascii?Q?1C7tzLj+riGXxkeb32QX+IksGsDLMw5xTsjknkPIaIIcjrnF1b/1xJJF+Omf?=
 =?us-ascii?Q?HX0TDxTfxQPXQv5Dhqd26ncAnHXjFtbXdOGqTxkC+C/nkLVekArtJCAIdN+X?=
 =?us-ascii?Q?jodeBSIGvcVy0Syh/g5rbwwOOtRtslXt7z45z94vdVZHNrAVFCmIUYwqQuSQ?=
 =?us-ascii?Q?FRNs/11jZqcYKpJHChVfbHb6eBmJdh3Vs5WrCokWvi0MCBFHQmhyusit2fwh?=
 =?us-ascii?Q?GRBIsrFAaaheWS0mYiOxlc58vIqR9c+OGwIcO9xlA/0c/5cpJSHg4/cJDIpy?=
 =?us-ascii?Q?YfUgwBlYskggnd205Hrehp/tKit0PwGCZiRV/zGPCCzxmi71UUXFHX+s7saf?=
 =?us-ascii?Q?S8oTM39tqAzjFmpIAG1GpuoMkZPaSBtALY7QSDGe1xpyCBJhGwCL3zG7ZVSF?=
 =?us-ascii?Q?KEKJtPEYteweXR0wpWdS8f5rmtuDJ5/EZrRwjSu/16CqkZYMFybEuXaAn36Q?=
 =?us-ascii?Q?8uA3rLCuOmekzPsFYZ2tteTx+4TeBMDok0NCuEqiCn80BJqpr9Ez0B7UV0aS?=
 =?us-ascii?Q?C/yxry8oBgKnPqHMkBrrp7k3XcflKuGh14OungpyiTCsqcsF0Y5JhNY+JSZd?=
 =?us-ascii?Q?hes4LXVmYSjXtmIAbFGoLArRpViqOXA6vjq6qXI2LAXWLFL7VHlUTEpb1xlI?=
 =?us-ascii?Q?itfy+64CiTjtoqxy1J/CmLlDNp6vxVocK+cEAfmWsAGjqG1AjZGIt91tDotS?=
 =?us-ascii?Q?k9h+7ACH9D9EB3qRXwHt9hTwqcEz+Jj6tI4csqVApEifUwBeD7PGa46UdgIl?=
 =?us-ascii?Q?YLaLc9GqzHwPwF4p10gkQRJqbfKFgU2//ELi6TyBHW4YsqGCgOgz4xnpRFrw?=
 =?us-ascii?Q?aMdYD//zpZfXw3+leuSqjNq343j4AFuRcLTVw12DIPxtJe/vAL28PY0ZrkOV?=
 =?us-ascii?Q?AKjjsp2e3vIXvmg8xUEcF5Ac/SKL3PdBqm5KSuD/AUKMwduhe31DTZE/w4PD?=
 =?us-ascii?Q?S4C9fswSoPcfhGEd/ZYbevSTrfYydSXurv39P0zXmpbs2008OqJpmZ5WGUn3?=
 =?us-ascii?Q?N7GsTVPEPywWNYgAbB9CvdAW6dX2Y8WgbA5TiX1jMdA6hmrmGdHXqXzKLFbX?=
 =?us-ascii?Q?jH8ddrfELruamkkvJJM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e3d7af-fa59-46c9-8a99-08dd4796e611
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 16:45:58.6514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qe0qETTWDmL9LsUmRf8pUfK6TWiBuJyJGnWRfK2dNb5AQHmyEy1FhvfWPp6fD/pqTR4Ye5ayZocgcgNo1HkY9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, February 5, 2025 7:51 PM
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
> On Wed, Feb 05, 2025 at 11:53:53AM +0000, Havalige, Thippeswamy wrote:
> > > -----Original Message-----
> > > From: Havalige, Thippeswamy
> > > Sent: Wednesday, February 5, 2025 5:08 PM
> > > To: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > > manivannan.sadhasivam@linaro.org; robh@kernel.org;
> krzk+dt@kernel.org;
> > > conor+dt@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> > > <michal.simek@amd.com>; Gogada, Bharat Kumar
> > > <bharat.kumar.gogada@amd.com>
> > > Subject: RE: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port
> driver
>=20
> > > > > > It's kind of weird that these skip the odd-numbered bits,
> > > > > > since dw_pcie_rp_intx_flow(), amd_mdb_mask_intx_irq(),
> > > > > > amd_mdb_unmask_intx_irq() only use bits 19:16.  Something
> > > > > > seems wrong and needs either a fix or a comment about why
> > > > > > this is the way it is.
> > > > >
> > > > > ... the odd bits are meant for deasserting inta, intb intc &
> > > > > intd I ll include this in my next patch
>=20
> Tangent: I don't know what "deassert" would mean here, since INTx is
> an *incoming* interrupt and the Root Port is the receiver and can mask
> or acknowledge the interrupt but not really deassert it.
>

Yes, I agree but our controller, however, provides explicit tracking of bot=
h transitions using internal registers
(TLP_IR_STATUS_MISC).

> > > > > > > +#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> > > > > > > +#define AMD_MDB_PCIE_IMR_ALL_MASK			\
> > > > > > > +	(						\
> > > > > > > +		IMR(CMPL_TIMEOUT)	|		\
> > > > > > > +		IMR(INTA_ASSERT)	|		\
> > > > > > > +		IMR(INTB_ASSERT)	|		\
> > > > > > > +		IMR(INTC_ASSERT)	|		\
> > > > > > > +		IMR(INTD_ASSERT)	|		\
> > > > > > > +		IMR(PM_PME_RCVD)	|		\
> > > > > > > +		IMR(PME_TO_ACK_RCVD)	|		\
> > > > > > > +		IMR(MISC_CORRECTABLE)	|		\
> > > > > > > +		IMR(NONFATAL)		|		\
> > > > > > > +		IMR(FATAL)				\
> > > > > > > +	)
> > > > > > > +
> > > > > > > +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> > > > > >
> > > > > > I would drop AMD_MDB_PCIE_INTR_INTA_ASSERT, etc, and just
> > > > > > use AMD_MDB_TLP_PCIE_INTX_MASK in the
> > > > > > AMD_MDB_PCIE_IMR_ALL_MASK definition.
> > > > > >
> > > > > > If there are really eight bits of INTx-related things here
> > > > > > for the four INTx interrupts, I think you should make two
> > > > > > #defines to separate them out.
> > > >
> > > > > Yes, there are 8 intx related bits I ll define them in my next
> > > > > patch.  I was in confusion here regarding "PCI_NUM_INTX "
> > > > > since this macro indicates INTA INTB INTC INTD bits so I
> > > > > discarded deassert bits here.
> > > >
> > > > It seems like what you have is a single 8-bit field that
> > > > contains both assert and deassert info, interspersed.
> > > > GENMASK()/FIELD_GET() isn't enough to really separate them.
> > > > Maybe you can do something like this:
> > > >
> > > >   #define AMD_MDB_TLP_PCIE_INTX_MASK          GENMASK(23, 16)
> > > >
> > > >   #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(1 << x)
> > > >
> > > > If you don't need the deassert bits, a comment would be useful,
> > > > but there's no point in adding a #define for them.  If you do
> > > > need them, maybe this:
> > > >
> > > >   #define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)  BIT((1 << x) + 1)
> > > >
> > > > > > > +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args)=
 {
> > > > > > > +	struct amd_mdb_pcie *pcie =3D args;
> > > > > > > +	unsigned long val;
> > > > > > > +	int i;
> > > > > > > +
> > > > > > > +	val =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> > > > > > > +			pcie_read(pcie,
> AMD_MDB_TLP_IR_STATUS_MISC));
> > > > > > > +
> > > > > > > +	for_each_set_bit(i, &val, 4)
> > > > > >
> > > > > >   for_each_set_bit(..., PCI_NUM_INTX)
> > > >
> > > > > In next patch I will update value to 8 here.
> > > >
> > > > And here you could do:
> > > >
> > > >   val =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> > > >                   pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> > > >
> > > >   for (i =3D 0; i < PCI_NUM_INTX; i++) {
> > > >     if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
>=20
> > > This condition never met observing zero here.
>=20

The val variable will hold the bits that are currently set. For example, if=
 the INTA bit is set (10000 in binary),
then val will have a value of 1 after applying FIELD_GET(AMD_MDB_TLP_PCIE_I=
NTX_MASK,=20
pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC)).

Issue with these Macros:
#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(x << 1)
#define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)  BIT((x << 1) + 1)
When x =3D 0, the condition inside the loop:

if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))

expands to:
if (val & BIT(1 << 0))
Since 1 << 0 evaluates to 1, this becomes:

if (val & BIT(1))
If val =3D 1, this results in 1 & BIT(1), which evaluates to 0, meaning the=
 condition is never satisfied.

> > To satisfy this condition need to modify macros as following.
> > #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(x)
> > #define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)    BIT(x+1)
>=20
> Maybe I don't understand how the assert/deassert bits are laid out in
> the register.
>=20
> The original patch has this:
>=20
>   +#define AMD_MDB_PCIE_INTR_INTA_ASSERT    16
>   +#define AMD_MDB_PCIE_INTR_INTB_ASSERT    18
>   +#define AMD_MDB_PCIE_INTR_INTC_ASSERT    20
>   +#define AMD_MDB_PCIE_INTR_INTD_ASSERT    22
>=20
> and if the odd bits are for deassert I thought that meant they would
> look like this:
>=20
>    #define AMD_MDB_PCIE_INTR_INTA_DEASSERT  17
>    #define AMD_MDB_PCIE_INTR_INTB_DEASSERT  19
>    #define AMD_MDB_PCIE_INTR_INTC_DEASSERT  21
>    #define AMD_MDB_PCIE_INTR_INTD_DEASSERT  23
>=20

Yes, your correct. ASSERT & DEASSERT bits in the register are laid in the s=
ame way.

>   +#define AMD_MDB_TLP_PCIE_INTX_MASK     GENMASK(23, 16)
>=20
> If we extract AMD_MDB_TLP_PCIE_INTX_MASK with FIELD_GET(),
> the field gets shifted right by 16, so we should end up with
> something like this:
>=20
>   INTA assert     0000 0001  =3D=3D  BIT(0)
>   INTA deassert   0000 0010  =3D=3D  BIT(1)
>   INTB assert     0000 0100  =3D=3D  BIT(2)
>   INTB deassert   0000 1000  =3D=3D  BIT(3)
>   INTC assert     0001 0000  =3D=3D  BIT(4)
>   INTC deassert   0010 0000  =3D=3D  BIT(5)
>   INTD assert     0100 0000  =3D=3D  BIT(6)
>   INTD deassert   1000 0000  =3D=3D  BIT(7)
>=20
> But maybe that's not how they're actually laid out?
>=20
> I think the argument to AMD_MDB_PCIE_INTR_INTX_ASSERT() should
> be the hwirq (0..3 for INTA..INTD), so if we use
>=20
>   #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(x)
>   #define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)  BIT(x+1)
>=20
> as you propose, don't the assert/deassert bits collide?
>=20
>   AMD_MDB_PCIE_INTR_INTX_ASSERT(0)   =3D=3D BIT(0) for INTA assert
>   AMD_MDB_PCIE_INTR_INTX_ASSERT(1)   =3D=3D BIT(1) for INTB assert

Your analysis is correct-using above macros does not yield the expected res=
ults

>=20
>   AMD_MDB_PCIE_INTR_INTX_DEASSERT(0) =3D=3D BIT(1) for INTA deassert
>=20
> > > >       generic_handle_domain_irq(pcie->intx_domain, i);
> > > >
> > > > > > > +		generic_handle_domain_irq(pcie->intx_domain, i);

To ensure proper handling of INTx interrupts, I plan to use the following m=
acros:

#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(x * 2)
#define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)  BIT(x * 2 + 1)

With this approach, the conditions will be evaluated as follows:

For an assert bit:
if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
Example:
AMD_MDB_PCIE_INTR_INTX_ASSERT(0) -> BIT(0 * 2) -> BIT(0),
If val =3D 1, then 1 & BIT(0) is true, and the interrupt will be handled.

For a deassert bit:
if (val & AMD_MDB_PCIE_INTR_INTX_DEASSERT(i))
Example:
AMD_MDB_PCIE_INTR_INTX_DEASSERT(0) -> BIT((0 * 2) + 1) -> BIT(1),
If val =3D 2, then 2 & BIT(1) is true, indicating that the deassert conditi=
on is met.

To incorporate this logic, I propose updating the loop as follows:
for_each_set_bit(i, &val, 8) { =20
    if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i)) =20
        generic_handle_domain_irq(pcie->intx_domain, i); =20

    if (val & AMD_MDB_PCIE_INTR_INTX_DEASSERT(i)) =20
        generic_handle_domain_irq(pcie->intx_domain, i); =20
}
This ensures that both assert and deassert conditions are handled correctly=
.
Let me know if you have any suggestions or correct me if am missing anythin=
g.

Regards,
Thippeswamy H

