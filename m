Return-Path: <linux-pci+bounces-18598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343CC9F48AE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A22188BD69
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A071DFE31;
	Tue, 17 Dec 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y6Ug1oeu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1114600F;
	Tue, 17 Dec 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430568; cv=fail; b=Kkvcvs1it+yLXAdgUmqFNWy3NtGqsJ62GATOsVpN8aEbLIB8ASxpairywt5zW6c+qBeD6S3tw5A9oX+OOrnEIQ56BC5DrhgDLHao4r77S/9N/57foa4NsoQ4c/SO3QP8mi1i7iSGF3s6YAfhhD5N60PZP88Djkz5oj7jvjcFXPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430568; c=relaxed/simple;
	bh=50L0IgHg43c1smIVo2T2AHKw9KbM/W+G3hU0B/WpVJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=anwRlgXHyQbm+WkZs4LNqRdbXN9CNa8jEF7BnD1bfnQUAhuHO4wUMOJw9KFMz4+a763cZ+D5yYUl2RcGr1DSc0RYt2YAsUWprboYLOW0oxU4W4Dk3dNz2TwkZdThfF7nh41W157uABW841qBBX6wMrTa8sgsVdBtjlEqxhIzNGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y6Ug1oeu; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1ExhhR9yt+fP3VoL1tTKe8XwPN+6E+O9jiTTO8HRKB5j6blt0qBy9sIlIjMMRLRE4V/edfGaEJhwDqlwq8PoEUCRPktpF54P3MlBpA+7HPErMeo76Tt0LKAcNyXiIrct4ipPfwYB4EdKhf5eWvyOEo2lG+X8WIuX/EXrhgLpeXALBirqyVAbpuhKRj1SeiyUpp+0jmYIIMqv338K6HFbJI6rtyEhtTCsk2KbTLwoQbtW/S+ViqeolKvpAaNF2zRx9USEMRXolFvggf2chqTwEx3fKtew0z0s47jmDEtXvzKhXNmv7cWZOrUmEtSKY8/tMvYCAZ2u2mPKDg2iJtvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8So9mNO8frC8WthUAs95WzbxGjf0nl0jN4YTj7R+YY=;
 b=K8DG7yoU+bLU1ogC50imG+TRl2SrO//Z0+bo4VECVpnXQmxGVCoijE+IQKfAkeC5d4YeBrQyLJvvraoRPy59vZ9Nc21rB54Jed5+5BHtKiFaOvxfceYUSUyxfK6r6NEh5qILZpNu8MoVFM5p1/CbP/3dK+zmEj2+/JPbF4uh4GV5ZX5yrY/N3oMmcOmkYogVGHp7Gwlh0/2TSx/x7bP9i3jaPGsH9zUAo1Qzk6xQ0+IHwkCzSL/KzbOFUmF7q1fuk5aQTUxgsoggL9qycFVITXXJUxMq2Q6bzSirx8IyhcF/sroc+RSQwB8Fkp7sJ27FYGg3NVhV2Vqky5hwnBW3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8So9mNO8frC8WthUAs95WzbxGjf0nl0jN4YTj7R+YY=;
 b=y6Ug1oeumqWHOi6Rf1jURL1I+4HGhmMTUTqsKJXkuocmkWKAAiyHwDsRqr+IeUWgy4bMeSoiIRSiNcsRkN40RWmK5D/lZCcK28JbDHdsIY2Soh0AW5jLA6ELlfBc4Q4aLFT44PhvxOh+EUNTFpInag4U9nGRK9uPmtMNkAbSLwk=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 10:16:02 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 10:16:01 +0000
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
Subject: RE: [RESEND PATCH v5 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [RESEND PATCH v5 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbTSoAD+H9NHR8M0eytwmkfGPPnrLkbmGAgAXQZGA=
Date: Tue, 17 Dec 2024 10:16:01 +0000
Message-ID:
 <SN7PR12MB72012F5EB73E0C315467770F8B042@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241213064035.1427811-4-thippeswamy.havalige@amd.com>
 <20241213172759.GA3418116@bhelgaas>
In-Reply-To: <20241213172759.GA3418116@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH7PR12MB6420:EE_
x-ms-office365-filtering-correlation-id: 44a2e490-4cf9-423e-ffca-08dd1e83cf05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?duu8xj1db4Zazg+/pVgUqecvW9ox67nikyYcjuEV7u9+2hOROVsQU91qOH21?=
 =?us-ascii?Q?VO/EiT6IlHwTspgjpKm4F3DZYyK3a8gasisfqxHIa5F7F+6taixX1NnXq9L9?=
 =?us-ascii?Q?FzGBg3GK4XMKJ2RvJUyoLgLGvWKa7bLIsWxvldQgtmkeoDQFmIGirGs3prE7?=
 =?us-ascii?Q?k0GjuLYdb5v7ZZSQhuapwWBrg9Ly6qFXSB3gFdpvJ3ppjqpl5eqJlJdpxzFJ?=
 =?us-ascii?Q?6nt/c6J/jWmF45XMHTu6qFmeJ0r/zPjXgHEwsxznOqHQZYEpKfMKhRs/tIyO?=
 =?us-ascii?Q?lG42IqYqMZMhzVst34v134KTxeh2OmcmgyKQazE6NuucALetqxixI0UPnTs5?=
 =?us-ascii?Q?qFTsqwGEZQO7+6B8SmgrAhk0ICKfVXe9BwU5Ro1oLvc8FdCZnczB95lKOrb0?=
 =?us-ascii?Q?ojLQExBSWHxEMqrBEJL1Q9qHqZUsmK6q8kjQXJ9wZ7T8N1mLM09qXRURNeCa?=
 =?us-ascii?Q?hEQDCkH5rSFqAXWCId94CbcP3aw/gnWKUFuDNV94/Ah3bdKuV8voafZasnEP?=
 =?us-ascii?Q?GAhqB2Bo7piS2ooCW91QnJLQ8vWFXikLYjPBiB4f8h2Q3vZIu+2eJKRO1CAO?=
 =?us-ascii?Q?8NCBTpJPTMpZ88zj7fyfqAovIDt80+UU+DXRD5reYZBMcuyOWI1JXoKgj6+H?=
 =?us-ascii?Q?pwjdVXm3gkyiTb0P4SSxSiWjrTUAdWzH5kOFYWOhyK6ovhVA3CrfuLfJJuDE?=
 =?us-ascii?Q?HXtZkC3YcRpABIoPyeJKkLTTCmiYC9iPyp7prfGHQzQJ+CkiQXI94Ih52b7f?=
 =?us-ascii?Q?Ep0ueUEH4ORXHiX6XlmIqfFqfcWPfi7urpyRvL8o8dAwo3ypI9+bLsP1c1/z?=
 =?us-ascii?Q?kVaXGAKRjpmmnOqRq1Nc1KjpvJjq1PaproFluxf59zUv3Dlq5qAXDn6MwKxG?=
 =?us-ascii?Q?uKVtcB7AA3hUyMc9oJcU81CNCZM1uREntpXVTspF6gcJzgYtzG0XIapMvwjZ?=
 =?us-ascii?Q?vIthXMGBmP4QW1wNJB9ZMjnc8LzEfDhAb4iGQhkkFrLEFDe8ffoT5FoahMnD?=
 =?us-ascii?Q?i604rGhso5utEm/K5uoL4RlZ3ATWD0GKuNbiwXSV3sxCe5dyl1rE4Ke4EI1u?=
 =?us-ascii?Q?KE8uIEO65r9VQHA8neImgsPKjx+7+xBx+R7U+Wjw2updqiqH7XTz3EQi3ERz?=
 =?us-ascii?Q?NwYXo+/prDtO6duLLdUllXWCS6kSZJjmZto4Eo7MGLjC8vrsiGQ40AIA83my?=
 =?us-ascii?Q?y0e/439ZDhCLRrJPsD6cx1f6EWnrETVSwj/b/yhHXdD3pqjJRa/uvtsxV0pM?=
 =?us-ascii?Q?clfDzi9tg5aqcMZKUCQ9d2eVEIKuoHuiQaZRPsM5tPCUplO+ISaCCEtcBc0+?=
 =?us-ascii?Q?tet3QonWZCnAEJTw5Ngs3Mx3iNCWBuKIdNvwk1TjWJ47oJwwNBV62CoQynv1?=
 =?us-ascii?Q?lw2uOErWCUvNY+LRjDPDphEGqoAN3MK3vtEwMj7efjQJd2Qg1LLIS4ZCFChI?=
 =?us-ascii?Q?e7Ny3UN0Dzh/7fYfSwzEXqPEzLGWrVTm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2it5ZsZtu9vzv83YMgn34InLiM7KHv2e1hPF1StGRo+KeUETWIBMQgozaYhE?=
 =?us-ascii?Q?MtAEAr/XRNllz049YE1E7pK++09rtwjHv8ZM4z9lWk4jytPVmIUQY3NnhmQK?=
 =?us-ascii?Q?mVFCBCj58MvtexJHxrMwQoEnGj7valcLgIZ2z8uGXjfGaNxZX7SSik+YCCIB?=
 =?us-ascii?Q?ASVvdl6UCuIXE4UA6SdXtivh/N5e6ZZPhOh2jp6YwLfnOj7m8vyzATRiQQy/?=
 =?us-ascii?Q?+QM60XBcXL19+J2rkAOHZ/xo9akZ8DpQa1/DChkUtqp73dMJtBVYyseZMFm2?=
 =?us-ascii?Q?PucqorqTN0xW/64NwRwfTB2t53G819UoecYUQRX4egXL9EqTEUkoEYQ63AD5?=
 =?us-ascii?Q?H6IvhCHeVEZCr9cPLWga7kqMsa3lfA+2RE0VNr4FY8HNCNNHqi+Ps8l7cml/?=
 =?us-ascii?Q?XMhjhnE3N04b1ppaBut7C91FplqD6fu9o2hkVk35PRCF8bxrFmgSdRVV7Onl?=
 =?us-ascii?Q?ovpCsg3ghC5FP5tCt79VT1MXXYFD2V3REW7hX3ttTdDnuLKKMNPoeLAnx4Ds?=
 =?us-ascii?Q?81t3AxfGEBWuMP5x1ntK863+v0Wl+vQ+tw0DDO4JeiBSnDUSqDvgxFwVekm9?=
 =?us-ascii?Q?5S2wpOiPiHivdiMxvssVGVr06BB0T1eThjMCdDqrWPkLXQhJyBVrDu+P8WDF?=
 =?us-ascii?Q?iNlwy2u3/DLn7uNnvEPTWRWSjpd+EymHLrxEFjEcI9ap9NJc+h9Q5fMLQ/xW?=
 =?us-ascii?Q?v8W5wZoH6jEYc3LoTZ5UTXLU9wx2m8SJ0LkLS35JXmkahJO0MaOwU8GssCYP?=
 =?us-ascii?Q?beufrD3ToWSLAtKYAv+K9VdbvpkmFeRaSgXvnbw5AENFGN0OeMfPApOX5ghV?=
 =?us-ascii?Q?s5LlVr3jhmKt5UK1FNGqhDq1olPPZD+LMLqIJSAFFvqTJo7N1loBJBvaeagO?=
 =?us-ascii?Q?RCMGvj56b/cPB8r6dzTgeZsbnSxWo7hErtVc4/Yp0m3k2eKGsafIzvM9edjC?=
 =?us-ascii?Q?/yxIKtpMbxG1cy1fhwH0XGXDky9RHRXBTcOrNC2YhtGSF9BlcbGekAKjC4jG?=
 =?us-ascii?Q?tg/MB0hftfQ5zHkETX0sXfobqenVg67ax1IKdYJovE+Ph9ApMEOR/55cDWXl?=
 =?us-ascii?Q?0bmE6yRTuKLGBJuuPEMO4Qio59MxCVM+IcEiOuRFMoVMjUhhJBQyXiVjnKDC?=
 =?us-ascii?Q?h1F/HOSz5EMDv6599m7kyPSZpMUuouFvUGLMy9qvKkFe8zMsB3iFIcEYrj0l?=
 =?us-ascii?Q?8nslvs90NSpW/LT2ppchFASG4vkGbDAbanHhWaHAnWDndA4CvfZZ0LPLEFPg?=
 =?us-ascii?Q?ZhS3w9EjeKh2P6vxAjnBnIBQ4Y1RM8NQsnZYIO1/fHJh1gfVsmKokBerTUbq?=
 =?us-ascii?Q?ysY1GTFlGtVekBg6eUMAIZ7dcCcHv4y9O2igVcmkDX7jLS8JTfvq3lOetmwT?=
 =?us-ascii?Q?6VHPP7e/Ob2GbzptLkvhG+iXdQmO17KWoVgOosbPwSxkVZVnxdkiHgE/z99c?=
 =?us-ascii?Q?YbZId3F9r68KrKFiQeRJbJBjhdRzSqX+3O2SiGoMhMhJyh+WJ0P2kI0lthxf?=
 =?us-ascii?Q?ddFSMomYjg76vHcuE0gB5XswTcAiwrBi911NR9EgsoO5X7NmMy0bC3xFYTWc?=
 =?us-ascii?Q?hdPO+E/kv5l8WI+SM18=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a2e490-4cf9-423e-ffca-08dd1e83cf05
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 10:16:01.8867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpspugMk7o68wkipXZsh/bMoGWq3Y5KdmK6HXIUi1GyogOm9fLw7qcQVOIP/KNz1g4CrVc+qEfQ6e/cXcmcOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420

Hi Bjorn,

Thanks for review comments, will fix all below comments in next patch.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, December 13, 2024 10:58 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g; linux-
> kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [RESEND PATCH v5 3/3] PCI: amd-mdb: Add AMD MDB Root Port
> driver
>=20
> On Fri, Dec 13, 2024 at 12:10:35PM +0530, Thippeswamy Havalige wrote:
> > Add support for AMD MDB(Multimedia DMA Bridge) IP core as Root Port.
>=20
> Add space before "(".
>=20
> > +config PCIE_AMD_MDB
> > +	bool "AMD PCIe controller (host mode)"
>=20
> Seems too generic to describe this as "the AMD PCIe controller".
> Perhaps at least "AMD MDB PCIe controller"?  And/or include "Versal2"?
>=20
> > +	depends on OF || COMPILE_TEST
> > +	depends on PCI && PCI_MSI
> > +	select PCIE_DW_HOST
> > +	help
> > +	  Say Y here to enable PCIe controller support on AMD SoCs. The
> > +	  PCIe controller is based on DesignWare Hardware and uses AMD
> > +	  hardware wrappers.
>=20
> Make this help text a little more specific, too.
>=20
> > + * struct amd_mdb_pcie - PCIe port information
> > + * @pci: DesignWare PCIe controller structure
> > + * @mdb_base: MDB System Level Control and Status Register(SLCR) Base
>=20
> Add space before "(".
>=20
> Thanks for expanding this initialism.  Capitalize it in the text of other=
 patches so it's
> obvious that it's an initialism, not a word.
>=20
> > + * @intx_domain: Legacy IRQ domain pointer
>=20
> Just say "INTx IRQ domain pointer".  No point in using two terms when we =
use
> "INTx" everywhere else.
>=20
> > + * @mdb_domain: MDB IRQ domain pointer  */ struct amd_mdb_pcie {
> > +	struct dw_pcie			pci;
> > +	void __iomem			*mdb_base;
> > +	struct irq_domain		*intx_domain;
> > +	struct irq_domain		*mdb_domain;
> > +};
>=20
> > + * amd_mdb_pcie_init_port - Initialize hardware
> > + * @pcie: PCIe port information
> > + * @pdev: platform device
> > + */
> > +static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie,
> > +				  struct platform_device *pdev)
>=20
> "pdev" is unused, why include it?
>=20
> > +static irqreturn_t amd_mdb_pcie_event_flow(int irq, void *args) {
> > +	struct amd_mdb_pcie *pcie =3D args;
> > +	unsigned long val;
> > +	int i;
> > +
> > +	val =3D  pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
>=20
> Spurious extra space.
>=20
> > +static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
> > +					 struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct dw_pcie_rp *pp =3D &pci->pp;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *node =3D dev->of_node;
> > +	struct device_node *pcie_intc_node;
> > +
> > +	/* Setup INTx */
> > +	pcie_intc_node =3D of_get_next_child(node, NULL);
> > +	if (!pcie_intc_node) {
> > +		dev_err(dev, "No PCIe Intc node found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	pcie->mdb_domain =3D irq_domain_add_linear(pcie_intc_node, 32,
> > +						 &event_domain_ops,
> > +					       pcie);
>=20
> Fix whitespace.  "pcie" would fit on the previous line.
>=20
> Bjorn

