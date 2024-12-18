Return-Path: <linux-pci+bounces-18681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63789F61C3
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 10:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8637A2309
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22161990D8;
	Wed, 18 Dec 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HpryKlrS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8419539F;
	Wed, 18 Dec 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514109; cv=fail; b=oZxr2gsWbMaZG4e+Uv9shDnFz6mkfduKsYeYZ21aEYfK76ACP/KHdEMhNfzD6CzHLIA+vfV4dyGWSwQRpuJZZzESA6Jo1kzjdHT3addWIelD5bre+jO40SqURuWvhqYwohncp6rYbe9bwyVwYQQ799xOZlcWBzdVveFm//UDsZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514109; c=relaxed/simple;
	bh=fJ5/udI8qFEE6zbH4mu9LyX6JV6QjrVyltNYJmolDog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SaVfExjQHuVePkNMiROfvSxw9iVyTICJmec8n0c8OFF0n1vwAB3xkCOzEWh4/pyWW8/wcJsN6ch/vIFu7kBhNFghwgs+q/CdHTezrDURLSIWWofPMTxolzIXPdrLwb1NdGzTikPXfUhAy4PEymaxBPg5TRpwrjU5xvF3Ijh9zEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HpryKlrS; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZtpOkq5E4Ll8eYZSKjLKs6qnWXp1FsfYqjLs1EjIWDq5u5+HaUG/aH8MGKPvc2pMPRUvRQ+j9r0gD8zmzig0PTs1RavAKKZmgQV8jbnl/IAge1QEnjX5877zstRHxEMGidVuh+jPrmu1XFaLzEuqOVneKu4P/uX2pzVVr4oI9kJEqNQnHokjLGaEcNd3W587dwCdev6I+xLeCPl6e5tzlJVha92yo5Q8Vx7U8L/exISEPKp1MxNWjDbEuKRPM1vouRBr4rrgtYLIUUAH0fPazH+hlg/JRU4lcCLeZlgOt4cU3391j9NUJm/ElnWOjjWF5Vff0v3PnD4bom/vDcUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V/2E5yjyTU6oKEyTOYA74R8R+EHkfZo7Qqnh/ZRGas=;
 b=XmAnC2lZ2Cq47yiLzKMQsgf6p4x4Pe3k6WNGHPZFeJ1fY9qncXH2vucGGhYQq2YzbDdBZxHXgUBHT5JiEAMlH3QHjYJA82zTxkO6Ko43+TcufMNlZmqKItmr/zKa8JBCgeAvipuW8hjsrCbf8dFaAApyXTHLZl74fR/haW/NhhiWOTtCdQsheh/9RMFIAhvTkw0TUWtdWJggkQCrh7iEbCf+z68CU9zw7/PpHhKHruVqLv3gIwKgESqKgYKZaJJiMaQvhFhyd8EwSmRheQnEuTx8hPpiSwcdQiF3Zqztzg1x0PMab1/YPROGQ51L4/lNFiJshS95uQaKvd7OqaiTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V/2E5yjyTU6oKEyTOYA74R8R+EHkfZo7Qqnh/ZRGas=;
 b=HpryKlrSmZSF5zmZ2VbAv+UMQC5dtK2lduxdgSdTREAHH0rx5lp+ZYPpV7zJWyKcRcRJqQqg+esXRY6fgQzH6NWw6n6bDSxlg/Cg3a/q1D513HZq6p3f4FLbnqkBO9AQaMSoD7g1LbB1m4D+Q+gxJRYzhYnwuJ+ceqIJqcXjEDo=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 09:28:24 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 09:28:24 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Rob Herring <robh@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "Simek, Michal" <michal.simek@amd.com>, "Gogada,
 Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [RESEND PATCH v5 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2
 MDB PCIe Root Port Bridge
Thread-Topic: [RESEND PATCH v5 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2
 MDB PCIe Root Port Bridge
Thread-Index: AQHbTSoHt+ZEx9RNdUqAmyOOwFfBurLqkVYAgAEZEFA=
Date: Wed, 18 Dec 2024 09:28:24 +0000
Message-ID:
 <SN7PR12MB72015F80356A44D225F6E3408B052@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
 <20241213064035.1427811-3-thippeswamy.havalige@amd.com>
 <20241217151040.GA1667241-robh@kernel.org>
In-Reply-To: <20241217151040.GA1667241-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM4PR12MB5819:EE_
x-ms-office365-filtering-correlation-id: b55545c8-b1eb-4794-7685-08dd1f46523f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?db66+6GdayBei3K2Xy/q0fqb57myQxCFAmGBdnZU4+tXFmlLQs9GDeIPWzeq?=
 =?us-ascii?Q?UbuSgdHC2WcMPWRbKM1xPlMsaH9to1xYaUEEofihDcsxVszDhi+5afys08M8?=
 =?us-ascii?Q?j/6JXxLs7Ro5TBmEOxZbILZiwyXxkvJsapnolY31GIyk40hsv4JnEGAXzdsp?=
 =?us-ascii?Q?ZoUGkODqSOiXqmvcYIFBmSOYbV4rS0tVMm4JeI1CE0hIe208foNNc/8qvhyi?=
 =?us-ascii?Q?WW59tGD//wdBJ5688+k+EKGDZ/qJq5t2jsbGw+jqV49Fg6R4+Khb8dUUqoxs?=
 =?us-ascii?Q?2vZacn4XF7Aq7+hTd0afl/lgJ1EfPlC+VcNvO8lWrmJ4nxqb97jiSHFDRal/?=
 =?us-ascii?Q?tWhStQ2YGaheerSkG4WGU0HJA4TaXGmbtsN8zNU0MoCEKOQarxDw1xzoByyn?=
 =?us-ascii?Q?RPZv4eNkpD76rERISQqvuqZ+VGnLN6qMKTqlVZShsmES+WFWNg97GdNxbHmK?=
 =?us-ascii?Q?WPuYvSzeGQKB0lrgs640egW6CvuJciQ0QRwj0EDPjNwQ5hDdmsBesdF8zJU5?=
 =?us-ascii?Q?sQ5XRdf75B/E8Vm/QcLwIwTQHq86VhvdPTyg4z8V0B9khOmu9e3aRVVUcUO2?=
 =?us-ascii?Q?VhWbraODknpp/OgfD/1C18GLf8F0WHR6enTPQ7K5cbMucJDYVwEtaL/inO4S?=
 =?us-ascii?Q?YKQd1Je7S+jO/UZ2iwDX148+imThkqqent4Hbctfbc0lyFDtoOJIIACp6dIC?=
 =?us-ascii?Q?v0omYSA/RTAWbB6Sm+8+mWQPAwD2WP2I823MslwPGxodt9eTf5Ib0NAGT43m?=
 =?us-ascii?Q?X5H+3wN5alzxeWVwWdCT/4kdCq8zq8+lsOS72dzGy3FZD1Mgp2i0r86fHH5O?=
 =?us-ascii?Q?J4JpgfWcImQs01AK3Gb3OZMaJc6IKLn8d2tXupai/COGUHU+HBU9gV0xr5/3?=
 =?us-ascii?Q?nJ+u/7X1tczULyAymBFL7isll7ODm2leexu+aDyi1+558U6Rmr+qZ/O+4OPi?=
 =?us-ascii?Q?M1/KcLp1okLc2gTqtVSA+NJb+r/jQj6B2qQ4ULMcfVIoXmtqAyjuvFCuSlVX?=
 =?us-ascii?Q?WaGgEQvbrX8ZWrMfnHLuWsXCC3ZxCvIiiSuHQd3YZ09MiCAJXKC/TMvyh8cg?=
 =?us-ascii?Q?nFpEqMeuHLYGidST3G3F9bEI9nMKA6WZP4413fbBr09sva7r3q7PrLeJbl8q?=
 =?us-ascii?Q?pC5xBBbTwh25/k1eUyn2ngWQHuptoFqegGrD5ClpVZfCkdAJrRBvnEdyFE2v?=
 =?us-ascii?Q?7SKVXYjfRoMOYoIWMJC6KayS+zvR5mPibmVnnU5UlVPMOQ/Jh3SGiQlMI1Wa?=
 =?us-ascii?Q?c946YkDvQQqF7M3p0CydtA+g+f9dh0EntCLEhbBax19UC8CVO5WIsFm4Ko+0?=
 =?us-ascii?Q?HgN/y6uaLZ3I6BWyGqo6JTpPLI0GTS1RIoViFPDH7PXuPiwq4rykrRHdnLCM?=
 =?us-ascii?Q?a5YPg0euhHNphmuCEwBOL9BZxJyzKSIHZMaexGqV2vm3ZkUTug=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KCtoHvPoov4xShG2PyP8aS8e1j5ZS0CIYMLNjzh4ACjcd2tkEKIBMkPXlx5t?=
 =?us-ascii?Q?Htudf41adg5wapCCdm0DxUiLhQJP4G05ZwvoQ7zfWuwvowVpCAfl0HUpuhdF?=
 =?us-ascii?Q?FJR4EL6IcezTpENFbdapiCUudqNoePJDBNMh01e4m7IIM09yhFJdaQ5AQn1S?=
 =?us-ascii?Q?g7So3/VLPB2FNpNuV/zYUFMI+ZxZm+udJUsFhyrMRkKh2EkONFQ+TaukIa+X?=
 =?us-ascii?Q?dA7LY8IRP+oBwg6O1ATZ5cIsYKJhUm+V3lV0VNmpKS1gxe2cIBm/an32jWvD?=
 =?us-ascii?Q?h/bBJS2od++5p5K/5RrgF+e/Lm+nO0v8lzWsUTO40bkKaxZrgZZJFOHyD1pP?=
 =?us-ascii?Q?WH9EPeZZdFqtb50mSSowDNt7NtFQkmXUjHskK3eRPLOX73Bq6Qgoa/ydiuPB?=
 =?us-ascii?Q?9E9QKIESAqTi/6D58Ec5lKUqhdjiNMHcB7FbyhYyat7GgJsQmr/ryvQDUGMd?=
 =?us-ascii?Q?2sEmmO5QsrnZmaJZ1hgtSJp7GTqK2eGVWTlit16HDnIfSJIsMwgwHX5Rhcl/?=
 =?us-ascii?Q?Zt5BF4TV17ea0CnCh7chiIMBoFSPDM8UrW4TW0gMJRJnx1bRsCSNd0d4MbyB?=
 =?us-ascii?Q?d55fwdfceRKh6TCzqO28ODGfqR4hHDNEmoja+bRD5R+hP62fiRUYav4Gjphu?=
 =?us-ascii?Q?DXKO1calUwpN2fUi5iZsyvNM5NguoZHTHxRSY5svi3F+bFW0pkwm3Qwi7OS+?=
 =?us-ascii?Q?LUw/TISOS7sculCLhSyeoTXpzcoVPHJDmqJJ/aXrTKoWDamPWae6rBfHKc02?=
 =?us-ascii?Q?OQ3Ni+LTeRdDQiF0qcNeDSoS7wG16CH4a+c6cKyXxalsTApzfzLyE4WFFA3E?=
 =?us-ascii?Q?rrgXShKGvV92H8HQW8pqu4Tpyyul+Zq7gR/Ym9sCByynjOSy7ChtPgwA7Szo?=
 =?us-ascii?Q?Icf/3Fb2D340sT6VLuH8zE8RtHVwmsNm5T6agSQJTLHRmzPKhv1oxHcfwY6/?=
 =?us-ascii?Q?dFU3DtoqQL547nPrnZD1VSA5C+u4/3WAVxUQfPCHK49adb3ymbLnSJgyobvf?=
 =?us-ascii?Q?5UsNpeKW+lV9TIevkpC7Ob4PS4D/PgaXGQwzkjmkoO8o0mfdyd0crCYz8R1d?=
 =?us-ascii?Q?ai6lpTWaUrHpXVxhkOp3YCgcJuJwqXM3ihEbbsIgExijp+p6Ipwwi083dMpL?=
 =?us-ascii?Q?M+qbSxo7km/9wChKo2/KEMVb1xTNUnd+yKY8PBkFm5a/2KCw3EenW3v5f2tb?=
 =?us-ascii?Q?5VtCxllM7M/g2M2dgEkein6cGfVBRdFQwhrlax70WSPmqMneKz2vwJR6HG7m?=
 =?us-ascii?Q?zdHcy1Ojn5sVr1SNbvgnchwYs8n5tjie1zXx0TaHl9dov9OFStktY6RPrAFR?=
 =?us-ascii?Q?NeCMzw+VvPGlmYqMH6fK3epAbgXNXEGIXIXui1Y/Nsbwty+B7uQkPNLbp7r1?=
 =?us-ascii?Q?qdrkZoI3lLTpYUfmXZntHcYX1oxIUrbTEt/1Qd7CoVixw5tgLDHJJ1glX6HH?=
 =?us-ascii?Q?HZFpxYY2ZSgDIWyu7y/PbQLKfkvgGo5LBdbaQWztqrCPxMFZpUWQEXP3s0xn?=
 =?us-ascii?Q?GAwUU79aTgLJ9+Qp8VCJDXN58PX0r253/XI+fhv2xCXJPH1QMrZXQ2ygPJAn?=
 =?us-ascii?Q?+4Fv747MomzrizoyA98=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b55545c8-b1eb-4794-7685-08dd1f46523f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 09:28:24.4229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9CUkF5HdPVzYt1d6y/L0mv4gtPg4gkwxWnKsS923bK3/r7dvYBnMGayS53qDi49D5eqyEBhZN7fiJquPrModw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

Hi Rob,
> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, December 17, 2024 8:41 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; krzk+dt@kernel.org; conor+dt@kernel.org=
;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [RESEND PATCH v5 2/3] dt-bindings: PCI: amd-mdb: Add AMD
> Versal2 MDB PCIe Root Port Bridge
>=20
> On Fri, Dec 13, 2024 at 12:10:34PM +0530, Thippeswamy Havalige wrote:
> > Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.
> >
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > ---
> > Changes in v2:
> > -------------
> > - Modify patch subject.
> > - Add pcie host bridge reference.
> > - Modify filename as per compatible string.
> > - Remove standard PCI properties.
> > - Modify interrupt controller description.
> > - Indentation
> >
> > Changes in v3:
> > -------------
> > - Modified SLCR to lower case.
> > - Add dwc schemas.
> > - Remove common properties.
> > - Move additionalProperties below properties.
> > - Remove ranges property from required properties.
> > - Drop blank line.
> > - Modify pci@ to pcie@
> >
> > Changes in v4:
> > -------------
> > - None.
> >
> > Changes in v5:
> > -------------
> > - None.
> > ---
> >  .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
> > ---
> >  .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-m=
db-
> host.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host=
.yaml
> b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > new file mode 100644
> > index 000000000000..c319adeeee66
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > @@ -0,0 +1,121 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/amd,versal2-mdb-host.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
> > +
> > +maintainers:
> > +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: amd,versal2-mdb-host
> > +
> > +  reg:
> > +    items:
> > +      - description: MDB PCIe controller 0 SLCR
> > +      - description: configuration region
> > +      - description: data bus interface
> > +      - description: address translation unit register
> > +
> > +  reg-names:
> > +    items:
> > +      - const: mdb_pcie_slcr
> > +      - const: config
> > +      - const: dbi
> > +      - const: atu
> > +
> > +  ranges:
> > +    maxItems: 2
> > +
> > +  msi-map:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-map-mask:
> > +    items:
> > +      - const: 0
> > +      - const: 0
> > +      - const: 0
> > +      - const: 7
> > +
> > +  interrupt-map:
> > +    maxItems: 4
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +
> > +  interrupt-controller:
> > +    description: identifies the node as an interrupt controller
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      interrupt-controller: true
> > +
> > +      "#address-cells":
> > +        const: 0
> > +
> > +      "#interrupt-cells":
> > +        const: 1
> > +
> > +    required:
> > +      - interrupt-controller
> > +      - "#address-cells"
> > +      - "#interrupt-cells"
> > +
> > +required:
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-map
> > +  - interrupt-map-mask
> > +  - msi-map
> > +  - "#interrupt-cells"
> > +  - interrupt-controller
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +        pcie@ed931000 {
> > +            compatible =3D "amd,versal2-mdb-host";
> > +            reg =3D <0x0 0xed931000 0x0 0x2000>,
> > +                  <0x1000 0x100000 0x0 0xff00000>,
> > +                  <0x1000 0x0 0x0 0x100000>,
>=20
> DBI space is 1MB? Last I checked, there's less than 4KB worth of
> registers.
Thank you for your feedback. I will reduce the size to 4KB, as the DBI spac=
e primarily
uses less than 4KB for its registers. Beyond this, the space includes port =
logic registers,
which can be safely ignored in this context.
> The address looks odd. The config space is purely iATU configuration.
> Really, we should have described the entire address space (like the
> endpoint) available to the ATU. So the 1MB offset in the base
> address seems like just that. Most h/w design to cut down signal
> routing would put the base address for the ATU input at something
> aligned greater than the size of the address space.
In AMD (Xilinx) PCIe IPs, the configuration space for the endpoint typicall=
y starts after 1MB.
To align with this, I initially set the DBI size to 1MB. However, consideri=
ng the actual utilization of less
than 4KB for DBI registers, this allocation I'll update in the next patch.
>=20
> > +                  <0x0 0xed860000 0x0 0x2000>;
>=20
> And then the DBI and ATU registers are nowhere near each other?
> Possible, but seems odd.

Thank you for your feedback. The DBI address provided in the device tree se=
rves as
one way to access the local ECAM space, which corresponds to a relative add=
ress
of 0xED840000.

The internal IP uses the 0xED840000 address to configure all PCIe attribute=
s.
When accessing the address 0x1000_0000_0000, PCIe internally translates and
implicitly accesses the 0xED840000 address.

> > +            reg-names =3D "mdb_pcie_slcr", "config", "dbi", "atu";
> > +            ranges =3D <0x2000000 0x00 0xa8000000 0x00 0xa8000000 0x00
> 0x10000000>,
> > +                     <0x43000000 0x1100 0x00 0x1100 0x00 0x00 0x100000=
0>;
> > +            interrupts =3D <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-parent =3D <&gic>;
> > +            interrupt-map-mask =3D <0 0 0 7>;
> > +            interrupt-map =3D <0 0 0 1 &pcie_intc_0 0>,
> > +                            <0 0 0 2 &pcie_intc_0 1>,
> > +                            <0 0 0 3 &pcie_intc_0 2>,
> > +                            <0 0 0 4 &pcie_intc_0 3>;
> > +            msi-map =3D <0x0 &gic_its 0x00 0x10000>;
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            #interrupt-cells =3D <1>;
> > +            device_type =3D "pci";
> > +            pcie_intc_0: interrupt-controller {
> > +                #address-cells =3D <0>;
> > +                #interrupt-cells =3D <1>;
> > +                interrupt-controller;
> > +           };
> > +        };
> > +    };
> > --
> > 2.34.1
> >

Regards,
Thippeswamy H

