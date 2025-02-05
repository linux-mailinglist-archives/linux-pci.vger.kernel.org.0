Return-Path: <linux-pci+bounces-20732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A46A2896E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 12:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49BD3A2EF5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C3022ACD4;
	Wed,  5 Feb 2025 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ni/8qgWm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38222ACD7;
	Wed,  5 Feb 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755481; cv=fail; b=gSQhbLpZJTTt35US7etAutPgneRfbPgOVLyHwsOLygTgwkufzyFhlqPXGyrCZUg4Wthoyznlp0T2o/mdjcD/O0fJCdzzgN3HmI/eFujzSWpmBqFzM2wIXsCCfMacd6zybgvFAVExEHjsWoWzhvu8upWq2mPQ/3gVmM1u4mZdFu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755481; c=relaxed/simple;
	bh=RivwAC6Iahn981A6c6vJlFV+d2hjraH1KizTi6d0un4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cyn5nvOf+nasG/QAhbBCRFDVEIPgtCczjg8rajaKTkQs3fK7YlMnOAGyk8OuLPI3rzrwFRkdor25ajk0f7gB4PmqLq3H8sZ1+owhqV4tAyZ54TgDB1Fa3pJTg6lMakPybgfZo5ek3S8P0zmt1Q5DoTDl4Po2gi4XF2ag7GXKgSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ni/8qgWm; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaNl6tDeTEZlDQOi3rmwrm+gBArXDauCfTerfiuBVnvWtiv+mD9OVavA+Xcf1Lxr9ffnT+pcY0Dkxs8mdQlRZ/buduO41Zu3sI62C5KGlfK/+kfBi9JnLzR6fgJSjBTi9L7L/ML+UN5QjpllWfRkm7HQd5p2XHLAXaecmyng/pfV30uIMa/jjmIdK6vjFbbWEvXBxCEm0Z3F83IUDysIfLXrNLlV5OLJ9sSKGoXKay4KUK7HX4KEpqPFv6nOsYqcHlcxCyKrbqlRW22KiE8Da2w5HbxyHbQsMuIUZBd6QHsIChkaK/pdw9SWmJ7oUQvCLIkK/VE3B4j9r1gNOv+/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFZraT1DoCCOoDC/xlEgwWHZCXjJ9X/DwDPSPZ0JKu0=;
 b=WXfm9B3vzgdNK75kHagPhYe2U3FEO/dm3TRx9GPfmoeLmzGlhOmw/QC72pHEOO0bZGWAeZVqQcUH8guXus9fpJiDq1k9jSZvr5CUe9XwB0VVwBw+9i7+EVYoZWvfDCutz/T5+mvcNfyFKQW/OHP+fqE5TWOEll3hGMqQIzTyj7kQslguvlNd19tXlZdhk5pp5+h+iRJ5pmIWu4az9WJZbDs/m+MGoR3ufLE16pGJIn+Ep8uZIxnF41HvwIj2h93PLb7Z2r0n0717dlkS3GRZUWQubCCVvXNS2Ej90T33qPByaPWrc/B84EJ9zz/fcK6VcJKRxtnQu8uia/CO0TGIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFZraT1DoCCOoDC/xlEgwWHZCXjJ9X/DwDPSPZ0JKu0=;
 b=Ni/8qgWmDHItgb5uz7LvCdeQz7uoy1lZ+TKwRJ7zys+//Eo1vRqhpqzB3e2WlC9dQdYizz/vADkaLsHRC00PzOH59vyerGsWf469d2VSCP0Y0O4KU361FkoPcs7Q+hw2t7hWPVxTrfuZf/qgMtqCXAMqOgkJ8cN8Yc/wQ8rEIqA=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 11:37:57 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 11:37:56 +0000
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
Thread-Index: AQHbckFGnEXox34FgUW7RyRWX+Tmz7M17kwAgAD2/bCAANnSgIAA4JSw
Date: Wed, 5 Feb 2025 11:37:56 +0000
Message-ID:
 <SN7PR12MB7201964B87531066CCAA22668BF72@SN7PR12MB7201.namprd12.prod.outlook.com>
References:
 <SN7PR12MB7201EAC37631E10EBA5A299B8BF42@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20250204221159.GA863758@bhelgaas>
In-Reply-To: <20250204221159.GA863758@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH8PR12MB7229:EE_
x-ms-office365-filtering-correlation-id: 7ec0c709-d843-450b-682c-08dd45d98915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yeUYHh2Joi+3bK4HyXGMjSuWwPYcv0Dbowi3aYFtPG/RydJD4q8wwPyH9ljI?=
 =?us-ascii?Q?u3X1bNbSfF21Gb9fWm/udhDUkCbtlfTvbiuc5za0rlNcjwInmTXD86SxorWY?=
 =?us-ascii?Q?CiKT3XQJ7ivX+gylZGsJcEyc65JBvb/PiQok5aIB6/D46ZJTm0Wn0pl+Z/2+?=
 =?us-ascii?Q?QmmijijVuJwYrsz2nwmJ6jG7UOt0Iq14JZjd/7Zbfo1VO37b7zi2HhFbBfti?=
 =?us-ascii?Q?BeBLQpg36X1pHzWZxnPp7rLj4P5MHisyoqIFNYB5wadtt2pBothHD/FEOpHC?=
 =?us-ascii?Q?T8PTMS9tq8rK839KkU2vSA1N5nw8tYQfw8FQPpj66rctvgdgkEq+K6AQM1yU?=
 =?us-ascii?Q?7w7eeJYhQWMYMbxlY6x/VXWdbfmOerwILSUNJpYyuuPc+JhnyhmnssJrOopx?=
 =?us-ascii?Q?zHAE2bd/DQQ49t0Q5GKSxBxGifAaEPj7/H6p3Img+mw8whwKZfpQbHBhmDvR?=
 =?us-ascii?Q?wGkcuMYeBclsnc6etNUcZwCfxN8F3D3WF962EgciUdm15qZag0dqK2Nxs8Eh?=
 =?us-ascii?Q?xMFQY/iVD7TgzWiV8M3oJLjQU/DZBkcc4+dsTXkEduEe8t1Ma7AiNlwdfljR?=
 =?us-ascii?Q?/iH7BohIuxMEkJ5pUhoBgw156zY3PRMhlMNxjXyJl3+xJgeHnVccteKn+PFQ?=
 =?us-ascii?Q?mOd2RFTdFlrj62srh79eUUoiS0QCZETqBN9z7ACUVQStgXWR0NySzLdLPLRY?=
 =?us-ascii?Q?1FHDs1LfoR96PAq5Jrzg6nU+t6Ha/KpcUikD+UBVdBe+Q2SBqq+bpUJSMoVI?=
 =?us-ascii?Q?fMaGusQwaN5Jjh2AOMj50rGGm6Dn0WoeWS1MEpQykbqhcoQgzO6z8+C0PawO?=
 =?us-ascii?Q?UHjANF0I2HzEEkbpbPYgHmCyn7PgKbJUHoXgjTlk+gPe06vpnr5I3os/ppRh?=
 =?us-ascii?Q?eHshX3JTxlBo+z177uFkAIiEvB42nHj7DwCh3j1x2BG4SBUowrPE4I1JLo3+?=
 =?us-ascii?Q?iwQyWnRXG4eFx8GVD0sSavVY9s+tIZ9OBd0dnee4an1HSBj8n14E5ik67VV9?=
 =?us-ascii?Q?NXk+ZlmttywY0tukRO5LsyQ/kLcDNoK6ifxqsc7S2Abi6YUKxSD7o1WShbmI?=
 =?us-ascii?Q?oecsGQY9EZ9ZhfDcSpAagqvh6fwG0+gmlKuNB3EsYMa0ZBdRQUR39OFe/FKd?=
 =?us-ascii?Q?Y1QVXozHQb4Oje4FGDUPSHrdlxTtlx8NxZ6eX95E0gE86BdcoKDhjcEphZI6?=
 =?us-ascii?Q?UlbR6Tgp7X0PonRkA8ySbWVX5+4okM4JpxkmS5aYh4CYnd60DpmhsAeAf9MD?=
 =?us-ascii?Q?emLn62jc88Ubcr0Ldp1Z19DRsekZw8EOy8t2j8YRfx3h0Neikmss5NquJuJF?=
 =?us-ascii?Q?v5Q74m/m5Fg7siKqe+1vxeFZSko+By++lo40xSrv5CFuN/jb52DlEF6csVQb?=
 =?us-ascii?Q?R3LDSzbpRJcV4qUG+3BPb85/qXohlGwCoGLMdsGH/FyDcwC4cEBRfW3IcKFr?=
 =?us-ascii?Q?g3nwcETIlUNeJuM+fa92T5GrafBYBXzb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cpc8YgbvAWOYODQND5zAZEvwnQ6rzAz5KJc2IyNhPLfSBSb/UH86sc+dh/3W?=
 =?us-ascii?Q?JQSeYrkX7EO6CKK6iJArnFSa2vaW5lGCZSfeh6EaKz0DTIPiQjIn3lgrbbhN?=
 =?us-ascii?Q?9au4qSYSNgNb8Wju0V1NNsT7nx39zsCSVLbFOOlWjrSaIY4eld4S/F7XSmQ2?=
 =?us-ascii?Q?wGwttO/RtT6qzkhg9mBAavj3kubmJhXsMU8iC3flQ/qmz8pw5MTsQltIdLbZ?=
 =?us-ascii?Q?W8E4IXRl8EjoPerORxC8OKtkSSU1xve+lWJzX+QEzrwXGeHZLFLjEzYmrzli?=
 =?us-ascii?Q?ldZTtP48tczGrAdE6uEmzyzokRJt45FPELJAm1YVLpVjFrra3MzdeHTrJVHh?=
 =?us-ascii?Q?rMSPnKeB19Y1+2k5rw0cWD5proDHCgKlM0yhY4pIjAYKUOY0n8ZtqxJKTFPU?=
 =?us-ascii?Q?0AYu/OBZCVr6pDh+oM87l/TREl+itseHsLHfXvBksPew/QiTtf1DONh2Nkdo?=
 =?us-ascii?Q?v074cXkRi+qt0R58NSeT1HkS8vwijo5yxWipfdH/CuatnUpgD5fXVcZHkbw6?=
 =?us-ascii?Q?JgV1+SCwG8lZDSIIAxZd6+4Yi/NWIoje8xzx6Dth8A4y5wqngTNMUaR58a3s?=
 =?us-ascii?Q?Vgjw9dCBWux6nvcQS2D66qNkc7+N29SrNAr6hmahMYQfxCbZvxu42r9MpEpk?=
 =?us-ascii?Q?Nfo3rRIOHAw2D3lFt/tM1ImodUtbExbtcpsrNoKQBx99oq1mjuoHAEMKhrne?=
 =?us-ascii?Q?zKcIYq/N7qI+EiR5hq8/id6WIBcd7Mg9ciY7xhOc4A2Qx6RPkfkCyvRh1LTr?=
 =?us-ascii?Q?hpXVDnF2nLi28PUVy5c7KdHOzAsPn8smo5gwnijSN9WbrSbn3kNbD7yrfuPz?=
 =?us-ascii?Q?FukHvNPXYNt+04nmalVh8NlVltINB8tnICSyQIz12G7qo8Hoa7kgEuGwXqJq?=
 =?us-ascii?Q?pOTElh68gkpxp7O729/RWru69boqqlAQTvzfCLHpg1GjypA9pvWAuhoVWJmG?=
 =?us-ascii?Q?M8HETYQpjCdxils9hev251MC5GrSl8ENfah2mzXMqOVOHMf9YvQXmYDC3Pde?=
 =?us-ascii?Q?I8bHIGmVqg/SMBN+c8YfEUeZNRBr3xXjWgKIiWPMi0QW3D4KqjpRzRom4bdQ?=
 =?us-ascii?Q?dqr3Aj6hGl2ro/S20N0uv+6qs7dwKxUMv7UDxIuMRJn6swGfYv5qpKzhjmEJ?=
 =?us-ascii?Q?WatheysI01hpCSVHagvAcC8XDX5EclPUxYfHWXBEvy1N4ryPlTmAicBbT1Jk?=
 =?us-ascii?Q?HSH0/Uci4X0JNtg5dF7zUdpzffH1cili1REgy62PU1ORyRVCzYjYjHoH/Oki?=
 =?us-ascii?Q?dUsWwSD4tCdlbyBMGOZwiPJxxEXDMj+Hu4dDWMEhxQ3Zv8NB4XzZiRd0Axtt?=
 =?us-ascii?Q?uz7iTD2mvq0uZWDyvZ5I/X8Rqu/PGx/b53pPKf5kp1gMQ4VC5E518aq/XpEn?=
 =?us-ascii?Q?u6y0dgvxVWXE02UKOCkQmpUWw47gpXYw9T7GACJJxKuLUWQAayu2tjkMLjrc?=
 =?us-ascii?Q?hqQ7Xu/wktU6qRYShZ3SJqiiGwY5wsA5KMHDbPJhE191OIhnHx0+iosfWLXJ?=
 =?us-ascii?Q?HyLWqzhleZNqk1TVHXLB4rssmscTTm/tyF5nY8YYtpvvah/9qNdNspMPPkfF?=
 =?us-ascii?Q?j9ddVz9SyR5ylwwesuY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec0c709-d843-450b-682c-08dd45d98915
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 11:37:56.6024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KE7qARo+O6VjnuBVoUNYkHXRfwHG0WGIdWgKafWW3AWLohTz/MxLXwEFXjiDF5jHLyG/GOsZcPGZrHvPUwhSnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, February 5, 2025 3:42 AM
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
> On Tue, Feb 04, 2025 at 09:37:51AM +0000, Havalige, Thippeswamy wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > ...
> > > On Wed, Jan 29, 2025 at 05:00:29PM +0530, Thippeswamy Havalige wrote:
> > > > Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root
> Port.
>=20
> > > > +#define AMD_MDB_PCIE_INTR_INTA_ASSERT		16
> > > > +#define AMD_MDB_PCIE_INTR_INTB_ASSERT		18
> > > > +#define AMD_MDB_PCIE_INTR_INTC_ASSERT		20
> > > > +#define AMD_MDB_PCIE_INTR_INTD_ASSERT		22
> > >
> > > It's kind of weird that these skip the odd-numbered bits, since
> > > dw_pcie_rp_intx_flow(), amd_mdb_mask_intx_irq(),
> > > amd_mdb_unmask_intx_irq() only use bits 19:16.  Something seems
> > > wrong and needs either a fix or a comment about why this is the way i=
t is.
> >
> > ... the odd bits are meant for deasserting inta, intb intc & intd I ll
> > include this in my next patch
>=20
> > > > +#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> > > > +#define AMD_MDB_PCIE_IMR_ALL_MASK			\
> > > > +	(						\
> > > > +		IMR(CMPL_TIMEOUT)	|		\
> > > > +		IMR(INTA_ASSERT)	|		\
> > > > +		IMR(INTB_ASSERT)	|		\
> > > > +		IMR(INTC_ASSERT)	|		\
> > > > +		IMR(INTD_ASSERT)	|		\
> > > > +		IMR(PM_PME_RCVD)	|		\
> > > > +		IMR(PME_TO_ACK_RCVD)	|		\
> > > > +		IMR(MISC_CORRECTABLE)	|		\
> > > > +		IMR(NONFATAL)		|		\
> > > > +		IMR(FATAL)				\
> > > > +	)
> > > > +
> > > > +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> > >
> > > I would drop AMD_MDB_PCIE_INTR_INTA_ASSERT, etc, and just use
> > > AMD_MDB_TLP_PCIE_INTX_MASK in the
> AMD_MDB_PCIE_IMR_ALL_MASK
> > > definition.
> > >
> > > If there are really eight bits of INTx-related things here for the
> > > four INTx interrupts, I think you should make two #defines to
> > > separate them out.
>=20
> > Yes, there are 8 intx related bits I ll define them in my next patch.
> > I was in confusion here regarding "PCI_NUM_INTX " since this macro
> > indicates INTA INTB INTC INTD bits so I discarded deassert bits here.
>=20
> It seems like what you have is a single 8-bit field that contains both as=
sert and
> deassert info, interspersed.  GENMASK()/FIELD_GET() isn't enough to reall=
y
> separate them.  Maybe you can do something like this:
>=20
>   #define AMD_MDB_TLP_PCIE_INTX_MASK          GENMASK(23, 16)
>=20
>   #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(1 << x)
>=20
> If you don't need the deassert bits, a comment would be useful, but there=
's
> no point in adding a #define for them.  If you do need them, maybe this:
>=20
>   #define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)  BIT((1 << x) + 1)
>=20
> > > > +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args) {
> > > > +	struct amd_mdb_pcie *pcie =3D args;
> > > > +	unsigned long val;
> > > > +	int i;
> > > > +
> > > > +	val =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> > > > +			pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> > > > +
> > > > +	for_each_set_bit(i, &val, 4)
> > >
> > >   for_each_set_bit(..., PCI_NUM_INTX)
>=20
> > In next patch I will update value to 8 here.
>=20
> And here you could do:
>=20
>   val =3D FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
>                   pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
>=20
>   for (i =3D 0; i < PCI_NUM_INTX; i++) {
>     if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
- Thanks for reviewing, This condition never met observing zero here.
>       generic_handle_domain_irq(pcie->intx_domain, i);
>=20
> > > > +		generic_handle_domain_irq(pcie->intx_domain, i);
>=20
> > > > +	d =3D irq_domain_get_irq_data(pcie->mdb_domain, irq);
> > > > +	if (intr_cause[d->hwirq].str)
> > > > +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > > > +	else
> > > > +		dev_warn_once(dev, "Unknown IRQ %ld\n", d->hwirq);
> > >
> > > What's the point of an interrupt handler that only logs it?
> >
> > At this stage, our objective is to notify the user of the occurrence
> > of an event. While we intend to integrate these events with the AER
> > subsystem in the future, for the time being, we will limit the
> > functionality to notifying the user.
>=20
> OK, just add a comment to that effect here.
- Thanks for reviewing, will add this in next patch.
>=20
> Bjorn

