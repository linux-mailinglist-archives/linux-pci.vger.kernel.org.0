Return-Path: <linux-pci+bounces-11578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB6F94DF85
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 04:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23C71C20A9E
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 02:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A56A8F48;
	Sun, 11 Aug 2024 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YELjh4YP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE16AB8;
	Sun, 11 Aug 2024 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723342399; cv=fail; b=HlFboQrGyuhKVGT8DnTe/xVs+VWvDaONpsD7ZNNxdmOsheS8ZAF2p4KOEs542O2N3qyKlfn0xNDJdLGS3Yhoo31sYPYNfJ+qAuLXiIHiBM12wsBGjhmU1KrMij6X5Yr2NbeT6nlaj+Ebblf6IXjGd3wHd4WP9FHsuV3bHhOdfWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723342399; c=relaxed/simple;
	bh=xv8J8DJS8UMlsJXCZMdtDzbQZeSzfSTGCiqf9a5RFO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hhwB8pNSzZFDbbiVHcJBw1iUYjFTid0HtyS2TfFFo/gaAs0XDao0an4t2SU/cRlz3SkchxZT5BAgNf9aWBYD6aw0gJFlLCeZCGysCFquptWgofezWhTbxtscnW6i9KXhpgqycbN0jsD3iPfsJB6jY0dqLSeRLIBGpA1ycH6FCRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YELjh4YP; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFC7PY5E59GWmM3YJRwArPgMOw7/dmqTImjFFyMwPtz+qyPD9re43MbHh8fcAu1mf6NpZCQkXW1FLFKHewWQQ7tRcU/5eO61bDYbNDVlxkKLrc6MjphCyb0KENyTPfc1HVgokr/u+2nAKEd6auaFooYKGPYUkP2Kf1ZxAEhrMP+Ev5BFeTiAlnHRL9BrF5s9v1NkdIyJqakIBLnXlYqKq9htMQqVeKFk0OW5VCFHpKLHHNi7A/QYsRh/aNmOtqltV2mAqsvt6ySVkR2r5oQ5piuFZAvVzrqxN63Y16fK04KstqXPMAJNjo1iQEQE0QEVhv1sBY/LMGsfu9BCagYCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+c/2dMNhBL8lbS33Dl/YxgWSEJDIvNMZxvVl7sWW1c=;
 b=CGIlH57DhddUKITkGGhOQXQM8GGUz8NhBKz+XgjAtM24aRFpV+Ak/sEnUlRl0FjQoydin2BvkSW4sV4GRHRUv1UNpoITXmZ2qGNJFOKDkBxa3L+7zlkUHNxw76+XrNkX9pgSWVgf3cw44I8zLxmhydTcHwDI7L3dR7RMX86wpVQ27QFR8FFxNMrNNcd6FiLR2ZlCZiCZz1fckbxJn19q694rJU9u5xZHOwlVUKfIrU4Dx0sHsgaJpGYOFilmbuge1RfK45AcHaw1Jhdx4Cdl0t9MPr9l+HPbn6DqH+ESNpuJxkX2nqe0g6pY+y96Sy/zeV785zzcQimMPENJkJgspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+c/2dMNhBL8lbS33Dl/YxgWSEJDIvNMZxvVl7sWW1c=;
 b=YELjh4YPGs/0ZDYxCDPVAbOck/fAp3fhTAVwzSm+fHuCF8KWrSQhdu5ySCMsIyqrRW/OQfTsl/tsapCCmpMgWWZAm6EKqs555dW8z4XZ4OkyTS4IEYIP4eMl52LX/J5LLCQ1y7M4Jt+Kil0IT8P5DZnrCcWWNyQnp1KyIege9Nc=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Sun, 11 Aug
 2024 02:13:12 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7849.015; Sun, 11 Aug 2024
 02:13:12 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Rob Herring <robh@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
	<michal.simek@amd.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge
Thread-Topic: [PATCH v3 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge
Thread-Index: AQHa6iLTWhla/PQVu0e9omCeETYKKbIfOnWAgAIY2lA=
Date: Sun, 11 Aug 2024 02:13:12 +0000
Message-ID:
 <SN7PR12MB72019667934C74F0CA66F5558B842@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240809060955.1982335-1-thippesw@amd.com>
 <20240809060955.1982335-2-thippesw@amd.com>
 <20240809181007.GA967711-robh@kernel.org>
In-Reply-To: <20240809181007.GA967711-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|BL1PR12MB5874:EE_
x-ms-office365-filtering-correlation-id: 27b2aeda-8692-4e28-00ae-08dcb9ab271d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fLy6qv6rhPYGDbM2P1P6hnem0BrQm8zFVdfO/sfz546iKK3QZCAmP6w/cm/S?=
 =?us-ascii?Q?0uTYF+0pVwEinjTpufO1PjqA8W2bJDnMTtnbcX3dcEBEMZEiA64vNvdLc6Pa?=
 =?us-ascii?Q?af3elVepJgbhsPGtEt+I3zfx4zvUNJNahfPbL6YwaFPIAQJwLAQAlqGPJowQ?=
 =?us-ascii?Q?/1CLHu7ne44Ud2j0Ja57Kkzn0HeFQNCaU+gylMJpl1EnLwtEEMaSUYFgwSTW?=
 =?us-ascii?Q?l/vXd7Jw1vHosch4OJa6Yd0kbvXG8zkqmjpoO+o1TOTv+SGfPPdyWvvanONG?=
 =?us-ascii?Q?LWxOB1iJ1/Z6MwCDxYLbkSb9dIs17WR+O9NuhM1Sr61t9FhXvzeRjlNwOM3a?=
 =?us-ascii?Q?IdMx6BBPq8+8Uk8rt0tlPJiK+3Ey3O18murqXtJaJZpWcl1qdro232H2RxA6?=
 =?us-ascii?Q?0kSOLC8qZJWuq9Anub0T+XCQ1Bb/0j/WAJwdWu/CxXgityZkxFdWHZ4tK4Ih?=
 =?us-ascii?Q?laoXT2LcCpJF1Y0/tc4UuQ2PJ/gjEDlUFD09bpuQKQ/DwkFUAhDGlx/SK4ka?=
 =?us-ascii?Q?FZFtpk2/nLD6pwRFjnNtL0xmJP1KB/0OwjJNfmZnl0SyB6tH1fYXN8M8sUhh?=
 =?us-ascii?Q?0eFJldgYX2RK3Hd9kYTx1ti076RjKGh/H9eOX/1at50r55CkW/mPZhU4yUtd?=
 =?us-ascii?Q?otaGhj4YMp149NA6/pdOjq4ox8UMv1+Jf/uv7P4iPfnV6OXk7SGeafy4MI3Y?=
 =?us-ascii?Q?0/vdToJjbxqFZiwUjGVeh0YiY4Dxe7oXAXe+CfPQNjBLsn9qN8vVUZ1FcSUR?=
 =?us-ascii?Q?jWru+wrB/tcfozmgvP8CzCmxSInNjrNXlvoPK3rzdWSxqbq3P/PVuw+k9JVu?=
 =?us-ascii?Q?s/eWeQLN04/TgZ6WdDLyxcxUkbeN5TOMvhPISU2hQ8o9PyfdWkIcC5oAi+Ax?=
 =?us-ascii?Q?bZp2KaMazlxnD2R6f84I7eiYUSjLwoaCzp6sBx0+iF+yKCHTQcosBY4dcvCO?=
 =?us-ascii?Q?3f47GL+KYkMFL1ph4WsUI9msZk9F2nqOrWm9nqnQlTVk1LGNxbEqbhpZ494Y?=
 =?us-ascii?Q?Gkqh/Z/AkAdOpuqTAc005GwZkUWbDJ4bcHB5L8HhMdW/0ea/39VvWfSi+G3G?=
 =?us-ascii?Q?Ccp6DrwtTFqmjt7+F4IMF/+g3niQ99oHa6WJplwrRijQCkU23wOCDV8wU3Qc?=
 =?us-ascii?Q?UxeoU/KH9BTadFkR+AkQZrorj3FuXAKkqbM3Fjman9ZMvtwOZLAg/sNPwkOd?=
 =?us-ascii?Q?Faz00hOE+XS6XCRnUJeww82eM1s6GVuxFYcqqQCVGXoV8ulvwYUnOuH4TK4h?=
 =?us-ascii?Q?LM0St552TT0c1AezXQ0URhhEpz9xp2anffBWBrmD+XHJB5epj73d0tv2kObM?=
 =?us-ascii?Q?C0hxhqwngfK/1EdVxHVrABYbi8KFGNXkmaE8zYAs2ZgKzVCno5v5rmCYJKI1?=
 =?us-ascii?Q?Mi2aicv/6G4Rqi49w/lpT7O9vNiJ5POKdISEbMd8rKkC7CtsNA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KcGtebtT6VSx0QrHlYINMt5ZzRaX+wMlBJoc+266/LccHTHjymUndD+Bny+F?=
 =?us-ascii?Q?zSBgJbMJUx9yhNQWFei2YjDiQTCcjd/qBNqh/NJGzMCwyesa/fR77ath4TrX?=
 =?us-ascii?Q?uckEJQPEmUQ+nl5gAT1pXtAuDc6uBAJ3CcJey2usYF1WijQgHe0O912pcOdr?=
 =?us-ascii?Q?6U4G42tYByeU1ZXD3suJQee+GlGywqh2kMbK2gfgxZ6UOwCZflErsMnt4XjF?=
 =?us-ascii?Q?r2P5yDL9ne9092JXqXEsGD1CCC7z43jRLYy5r5DizNXADEGHLJFOhHfpSlL+?=
 =?us-ascii?Q?bGLdryqlJHYzbd7QG178DO2Dupa+cJjrZve006zG45PDztyukr5x9Kjbdfxj?=
 =?us-ascii?Q?hm7njAxK282ZgZyYoEFw9fCg43tHQ9uLfCvp3rTdrt0gjMKA1ygz2smSU0ek?=
 =?us-ascii?Q?4/Uw1UNs9oaTG5g3QC/8jg5+t3RmLS0KNGxjdKMIBIEgktN4x81/ch62odXP?=
 =?us-ascii?Q?/TW3F5z22G9plA9BxzQNB+pPM16Xjd5jJ9HSkF3bygpRckw/VketyKRgM4eb?=
 =?us-ascii?Q?YpjoIShPjrav5X31yBSpchm0UI9gttqOeh/PgimjjLq4FqehSKnj4+cl4tAS?=
 =?us-ascii?Q?x8AhxPG+1qcTyg2Dql2GfcL33q4JQ38e5dxZxSzMtPs751r4JghMZHsby83n?=
 =?us-ascii?Q?R7z2dl19y4FZqdDRiSH4Q8d1OVQAA19MbaSpCFe+b3KtPcJgeRbUE8AwSec3?=
 =?us-ascii?Q?EAQatOJYFFMCoW5LOwSs1RMJKjyO44Hkjj27BzI4adY8x1S5bpsFzmcSfygt?=
 =?us-ascii?Q?8InGHk5hqtUwZAGJf2mF4TgXBPQtngGGKcb8HjKQQAY6h+brAETLNbrnJR88?=
 =?us-ascii?Q?uftrgyPPG3hkWeK5mwdHzlvVEY2Wot7SU6DvF+3JpbMoxfPXQmFAG3mwW8IB?=
 =?us-ascii?Q?GXcRNfsGWVYSNMJosS7XG7+OJjJCfd5vXPsyuykTVkmOtTpbJPHFVgVqYqZW?=
 =?us-ascii?Q?nfF/jjlA+rLbh51oiIWZ1s+3RmgGnsvWzdJ5UX5UgUjfq88LHillBIbX5NVA?=
 =?us-ascii?Q?s+k0ndnr34J8xf8evUsEyTyCPnZSguR/FY9jhR3z4cxlXExchsCYm7KYD0QV?=
 =?us-ascii?Q?Zj5LYPoRQ8e6W9P98F5AN+6or36Nl7BHGjKPagTfXszP1yz8ACAk4EcyTll0?=
 =?us-ascii?Q?njJVFoIBWbSqWhn9er21gHSIIzH3VqhcO7huZaEhXXtZfKu9LUVgysamj3e8?=
 =?us-ascii?Q?5sfp/mZFeqnRl7y2mkDvDNRkWeG8xeCa5GKH6ldkgVUmISPuJMJC4arBQNsX?=
 =?us-ascii?Q?4lYAbYWKE6SzUtN4vUc48ZjQNdZqGdovP9u2MoPNA4PxY8MDdgahUbReOg/1?=
 =?us-ascii?Q?RWMAY171brdmJ6lL5hkrv1kg5XCApQp7EjfsrQdcTKEki18vTKlodhiiPhKb?=
 =?us-ascii?Q?bcUsTwL3EDsogzXDn0mOI+8CSCvdmu5iv5PUAB3xld0nzanqeTbEtdnib96o?=
 =?us-ascii?Q?9/iX8rV23SUquT0qhwoamcBC4ofZURONRu/kmUQ1ohS7B3VxnL1xtjp0y01Y?=
 =?us-ascii?Q?ewklJB9Zv8ZVscXrCM1QRiY+yvGnVG6g1cYxkegXNUFKMqHRqx1JvRoSIize?=
 =?us-ascii?Q?Wp4bxSX6yjnWOMpTf30=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b2aeda-8692-4e28-00ae-08dcb9ab271d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2024 02:13:12.5990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBOQL+haeoNmPgGkdNbTQZUt5H0m+wxYdS78SuSe1sI0KeLdQ6krcUAn4eliisFlz+6qTX58wnTc9vY5KkbDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

Hi Rob Herring,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, August 9, 2024 11:40 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; bhelgaas@google.com;
> krzk+dt@kernel.org; conor+dt@kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org; Havalige,
> Thippeswamy <thippeswamy.havalige@amd.com>; linux-arm-
> kernel@lists.infradead.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas fo=
r
> Xilinx QDMA PCIe Root Port Bridge
>=20
> On Fri, Aug 09, 2024 at 11:39:54AM +0530, Thippeswamy Havalige wrote:
> > Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port
> > Bridge.
> >
> > Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> > ---
> >  .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 36
> ++++++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
> > ---
> > changes in v3
> > - constrain the new entry to only the new compatible.
> > - Remove example.
> >
> > changes in v2
> > - update dt node label with pcie.
> > ---
> > diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> > index 2f59b3a..f1efd919 100644
> > --- a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> > +++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> > @@ -14,10 +14,21 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: xlnx,xdma-host-3.00
> > +    enum:
> > +      - xlnx,xdma-host-3.00
> > +      - xlnx,qdma-host-3.00
>=20
> Kind of odd that both IP have the exact same version number. Please
> explain in the commit message where it comes from. If you just copied it
> from the previous one, then nak.
When QDMA IP bought up we were using 3.0 version initially so the compatibl=
e=20
String is xlnx,qdma-host-3.00=20
>=20
> >
> >    reg:
> > -    maxItems: 1
> > +    items:
> > +      - description: configuration region and XDMA bridge register.
> > +      - description: QDMA bridge register.
> > +    minItems: 1
> > +
> > +  reg-names:
> > +    items:
> > +      - const: cfg
> > +      - const: breg
> > +    minItems: 1
> >
> >    ranges:
> >      maxItems: 2
> > @@ -76,6 +87,27 @@ required:
> >    - "#interrupt-cells"
> >    - interrupt-controller
> >
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - xlnx,qdma-host-3.00
> > +then:
> > +  properties:
> > +    reg:
> > +      minItems: 2
> > +    reg-names:
> > +      minItems: 2
> > +  required:
> > +    - reg-names
> > +else:
> > +  properties:
> > +    reg:
> > +      maxItems: 1
> > +    reg-names:
> > +      maxItems: 1
> > +
> >  unevaluatedProperties: false
> >
> >  examples:
> > --
> > 1.8.3.1
> >

