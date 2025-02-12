Return-Path: <linux-pci+bounces-21270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BDFA31DCB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 06:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D4718879FC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 05:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCFF1465BA;
	Wed, 12 Feb 2025 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2BgOWESb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7F38FA3;
	Wed, 12 Feb 2025 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739337520; cv=fail; b=UtAC8n/ZgO8s/HBXtW+96zvcTvJM+WOyOp4XRoYSZwy9VHR3YCtF+KWw9BdHzYty6uaKLHJLN9QDfOIsTXMPjLo+RtvAEJCPsa0F7ySgGxM+UQj2xS/DvKxjlwcDhU0PdkCmokOE+3An7+mG0Goh2st2m70CeevEIHwXAA09hjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739337520; c=relaxed/simple;
	bh=bIfMLI4h+PoLV3gUbAn2VedbwxTNx4whVJWIIVkBMm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KH/f4igwMgjisNVWuqxLD2wyXVFpgiNg3e2wqbsNrN/EyUbdtVgm167OsB/G0ZiW3s8kSDwpNqP9aeVz+DJkdD3vd0Y9czN4iIQO9kuN0cI625ZeIhPj/WutNOmAkMtGlxsTohjDAmLaWdrtUuVFIrHoW31KPf+piU5jd7kpR/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2BgOWESb; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILktjtfq2JKsC/5jE+PNXWCjw0aTgAxHZ3qR8TEgkY3zlN8uKs+cOm+dI69T8aqX8cUUAXr3kad07S6vIy9ya2nHGmEfMBHEfV+ojbxwfsbprtB/+7Ky1KBpAgs52mhIdyS+RkXBLeUYmYPlaJddO52wJJQ+zcvsW9KKrWVWvq/R6acZDJm91aH46nnRz9u7c6x2jxGt8i9siTT6P4hrV+upuWs5wMpGV7ODYkHap7MulCwBwqPquDm0FUSPaafhw+tZUzmcNli9h69HvYwBxZw8F6cofTDUi4r7B7Wdb37dcUx8e1LWUyq3pAUqdzSZprrRSqvauI/JnZC2oTLU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIfMLI4h+PoLV3gUbAn2VedbwxTNx4whVJWIIVkBMm0=;
 b=g20Wun0RkMN+1ntgPDr1fVK+IvAL+daN3iXo4jCtn0PZ7a1qZgy0bqgVl9808vEjOGS1nMSFj9wi2Q/kPlNruhNPzeRkZjE+2p1rz6H1I35Q5tYFkALdDQoEaPGjkosjhTPJqRujmzgXk+1rJuwjiiE1QtEtVC1/wo8bRmimAy1sc4Fj073F/MuP5AG3a5DokHMC6qXsPXXF0DBP4SPhdhAlHIqYhd1B/QzpIji0Z7ZlOYMUpWmZn4VzHZrt/odmUqtJudQEvjriN5E4PNMtRFkMG9oqm++3hZPAVK5FDGMhHO3xFPL8rbQ5mmUYeFKF4vVSSrH9N1lvnBHqxUR3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIfMLI4h+PoLV3gUbAn2VedbwxTNx4whVJWIIVkBMm0=;
 b=2BgOWESbpjFHh3IWGF1qxTBiTT8FHNyr38yH8b+7+YriVGDOCasZLG+qkdOnlxgU+qZ2NWnhArpeWI/z2Xp50BuB77Pyxa6D5nPosdn0zebrDZPhcMRpVyVKZdyGq/PDUhYGPDMIso0T934S6495x7aaFgvh65+rUIY0Eva2k8A=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 05:18:35 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 05:18:35 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC
 Root Port controller
Thread-Topic: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC
 Root Port controller
Thread-Index: AQHbfF1xIxrFM3D92EWzuDnWqlDetbNCcx4AgACvBWA=
Date: Wed, 12 Feb 2025 05:18:34 +0000
Message-ID:
 <SN7PR12MB72013A4C3EE69C7DC59209098BFC2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250211081724.320279-3-thippeswamy.havalige@amd.com>
 <20250211185114.GA51552@bhelgaas>
In-Reply-To: <20250211185114.GA51552@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH7PR12MB5927:EE_
x-ms-office365-filtering-correlation-id: 29df7425-dd6e-4297-c64d-08dd4b24b2fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R502OVLhsT0lWgUV4cKD5l4VXk5Cx7gDLV/x3vpG1lF3N3XY9rJajuu/nFb+?=
 =?us-ascii?Q?4gt5PaF12Zk8PRE4sSpn5IVLw0OuNv+/OTlod4i8dIpy/fUFnCsB3lBQBurD?=
 =?us-ascii?Q?iMETtFoAP+dt3B29rjpNBkqGQj8LoEZmhWzQ1VAJEnzkuOZRuKtyAyGSgzfY?=
 =?us-ascii?Q?12HN4Hv1EnXQkV/8IFkRNr1R8gRg72O9G+uXz6aOPwOClkZjsPOWkVGwFXov?=
 =?us-ascii?Q?1+dQ4j6owvmbhsryXBquEn2RQsVpN8WAgZieezsKNgb2qU//BuLAC+zvu3qx?=
 =?us-ascii?Q?f0f6pCXnuHIFMEhF7z4cKKSl12dbsDjqIPHwoaKfN99/2cn5W4Ju1/pFX8y0?=
 =?us-ascii?Q?EkEcQhDmtw3Mfj0AVhBPigZ7tKeGTsuKfTtZ2jnnPCKqlb3wJXXI+4vMdsKO?=
 =?us-ascii?Q?l5rCrFT9Rm6kO3XgIJCVmclpotT1Bj3QFNtXv/MH2UX76n6xecDabxICizDT?=
 =?us-ascii?Q?O/MKbIxbKToBIUYf11scNYlc8qZXpJnz/IASOmSkNhzePGc7SmhGJRa1C0xG?=
 =?us-ascii?Q?fOgqglbieKqduhwHUsSjbukQNj72MwluyYVjzwDzg6hLH4yQM8STo40OZPYa?=
 =?us-ascii?Q?jc7IOtl6yYr6CK19vnKBWI0upZU8PWLpc3feexrAlkyjmdTmV6OIkKz3KvTX?=
 =?us-ascii?Q?UKbjjfRLSWgPiyD5dH3D9KxmmOiI26FvwPwfL8EiEqqmroJPzNr12kYmPBf6?=
 =?us-ascii?Q?8wikZQ3jH/OL4bUWwOs5joUMFzIe9s0YjEefjkLdjXKysrli6TEcPG/kzw0k?=
 =?us-ascii?Q?CJ+0cVj3VvxDxnbnoq4OAO3KFi/Dka+x66gH10boH2+KXD0bCT1AoMIutx2m?=
 =?us-ascii?Q?iiQsg+YQm6ZbO2HD25LxtB+ARkk81iYE/AJTqVxQl7DTDZraLp5/rekqiH73?=
 =?us-ascii?Q?JaQ0uT0uZ813dr93XvjeZCGdJdi+2XkQdZLcG6QtyEiH/pGSa3q2DIfKuRDI?=
 =?us-ascii?Q?OKsiiTAs4LIc6HxsAnuQFj/T4sdq7B1XYUNWovFk+vpdHRC+cwNzNNPDAmlS?=
 =?us-ascii?Q?lfTwdNAg1NHLIwZr0vqXHeb1K10PV+LctYsaYKgAoUEqIwvrcF9bhuWrj5+X?=
 =?us-ascii?Q?dAet4tKNqihiE8RJC/NBkoGXXH3P8Bia8GMievezs1YqaAyEGL3cfnNRsGVB?=
 =?us-ascii?Q?CCO0p9mL7S1c5qeJ3gNiEjgMJKMWR8TKHw8SH78l5BpWdGF1tstGujoTmeqw?=
 =?us-ascii?Q?MT59Veki8C0uLJqRkiz68TlrJL5g/SpYAryS6ZdZhOBRoluz6COuycHkQumW?=
 =?us-ascii?Q?PZzx+XBM5EBki3BttyBvFm9sBBaJIZKQ7bZRli+WHLjHrPS7oj5APDU8Wdhw?=
 =?us-ascii?Q?2MQ/eiVGV/fnrAnw6TKwYSRgSdTIeGIJ45lcDZi525CMkS4eHkZRL1+cpvho?=
 =?us-ascii?Q?giTkNOmbI9OPczMQgNEXzrhWnf2BV9snLYImKJq+ZqxWa/hGENS9I9G1Eqoi?=
 =?us-ascii?Q?MAcFX9yAWB7FsEQ8yD9TF/LXVs3+jSrZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KtoDrji5yCZPr5FBSJF1cT2KRhLDGiX9sHaJ4XreeI4PMXxhWzuBvwhsY28i?=
 =?us-ascii?Q?rA1vOQr714bkBp0FWihgg/NHCul10UJnUX5h+CZQirn6tc7rglUiFbU/8Sfh?=
 =?us-ascii?Q?uDXP7+gerVoiju/aphAsGnflwrQrYj64+gHsFKrzkV7H/d3p7Tp1my/IZ2yA?=
 =?us-ascii?Q?QGcy3gR9aIyFsNgSPh8UPT6YmYpKwclaSPZQgenRw1P5RLMgb2/H0fGV0AdO?=
 =?us-ascii?Q?4AowfmXUtKr8yHZeHFYJeiPM2r13RNFl18e3XnGicurW82FKJbcqcbcZ+amK?=
 =?us-ascii?Q?ssJ4ZJlfPWIBWCohtKDvZm48grDmnDCOgV7N8QGceLYdd4BnIqUFgYi++zSG?=
 =?us-ascii?Q?I8dLjz9Wc9DzRLEKYP1myxjA+M30eIbdRBA/QBFJXECBUjCNmD5bk0adp1AP?=
 =?us-ascii?Q?rofmJ91woHuBwFSLVyOxZos1WV+JqSZjTHm6l28BNI1mGsytlakOCghioMon?=
 =?us-ascii?Q?8B/5qN02MZPkA1junAZFzh0FrQ7XIhTirH73BqvWG/Bz1VI4mvfzJZURPPZJ?=
 =?us-ascii?Q?cbqLvc2btjNv4reMeJWUUlNZtitIRHZgjLcmjArQj4G1h5ay1xRWY8Z7pmRH?=
 =?us-ascii?Q?rjs4m+MlvRkvTccdhnz4mDjdI0OQ7tDqhbYNCxeZZUzN4mlZtWsUukjBLKLa?=
 =?us-ascii?Q?B2zTTGGIEtJEITKwADqa6PLY5RQTNtJqFqb95qJtpAqWVqgsm+VKJs5HGgHS?=
 =?us-ascii?Q?lT0IYtNzqn517TkjoFT/6ATDFVBObelNAsBmjKd+HKOW1Z3ep/XBBr9n/lVS?=
 =?us-ascii?Q?g8sIDgJp5PUTpW3AmnDUEaQ01bary6XHxPU9HF+t1jDXzW1+yWOBndQCfJCQ?=
 =?us-ascii?Q?aIgWMB5v0vjXVdvKbDUqhgdEpebQ+QX07XFQ8MSJXJPncAVJPNajZn5EU6zR?=
 =?us-ascii?Q?8892NLC2zWZS2p3V6o6CNwFrAVPaPq3MiWEioSuuZH41pHub1Fqnhx1XYCwp?=
 =?us-ascii?Q?nQF8epLfXNnAiw0ej/HVOFRypt8LzDN5lC0jBbHCCe3IYEr918O2Mn1704lc?=
 =?us-ascii?Q?jCd+7ZQJTc+hoFMkBT9f+f/n7brkEAkq3O+/WOtYNvjQQQsMehreY9uBNBEV?=
 =?us-ascii?Q?63TOQoFZqYayIoaf63Py49n+EhKzvpLHQwDypIEWlzK7XSAcPfGeWj8J8u5s?=
 =?us-ascii?Q?Ni7WN/0Tg++5IfzIVioQKsK5045Kuroza8ng8PzsABtzuZVEf9ykk3WA3fep?=
 =?us-ascii?Q?Zwvh/wtHwEjOSORrcgDEs0FRtNA4yJoiHE+kzL6Y4FYE9Al7uu1qzv0grhKT?=
 =?us-ascii?Q?m5U/CimQ80c/32gK2bckmQPygGIClAnL6NBJxpPwQLs2EkO1Pgy/KB+wlsWP?=
 =?us-ascii?Q?xSaFlrAtZ0T560Bw3X/3ehhEoiDmt7plyc1YhzkG5pUH7KPpjDWNCI87hBLj?=
 =?us-ascii?Q?rYcodBQL9/oqymdWBNqo7fXP2rJumGvJMS/yXigIuIAbe+TUIzrVO5Qt5nns?=
 =?us-ascii?Q?TpF00tjWD8vdkwsEALaDir4+jnCD67DGRujdyyXgnuW1CAQr3GUnEGz0y4aO?=
 =?us-ascii?Q?awT8+OMDYLUaLgZAjxSWM+kntoHfaaDSx939ZDwSqLWvB84SoRv+Ba5cNkrc?=
 =?us-ascii?Q?RAfBKqsiDeaKV1LaeTk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29df7425-dd6e-4297-c64d-08dd4b24b2fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 05:18:34.9826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lfmJygTbtb65QTmqobsH1PrtfWSGtnySrIBNQbgzlLMVD2pNLu38eAoaK3B945idnpR9GvjBtVBCruna6W0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927

Hi Bjorn,

Thank you for your response.

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, February 12, 2025 12:21 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5=
NC
> Root Port controller
>=20
> On Tue, Feb 11, 2025 at 01:47:24PM +0530, Thippeswamy Havalige wrote:
> > The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> > incorporate the Coherency and PCIe Gen5 Module, specifically the
> > Next-Generation Compact Module (CPM5NC).
> >
> > The integrated CPM5NC block, along with the built-in bridge, can functi=
on
> > as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfe=
r
> > rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> > configuration.
> >
> > Bridge errors are managed using a specific interrupt line designed for
> > CPM5N. Legacy interrupt support is not available.
>=20
> I guess this means INTx support is not available?
>=20
> If so, I'd like to say "INTx" instead of "legacy" to be more specific.
> Someday "MSI" may also be considered "legacy".
- Thank you, Will update it in next patch.
>=20
> Bjorn

