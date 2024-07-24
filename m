Return-Path: <linux-pci+bounces-10716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBA293AF0D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 11:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29992281964
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77A13DDC2;
	Wed, 24 Jul 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FweSXF0j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7E3715E;
	Wed, 24 Jul 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813426; cv=fail; b=EcSHo9wpSMYEidg6DBg4IKXCECHdRkdnbE42pyQEVYvS17ekr+bs+PLauOItZwpUQHQUhsG30V5De3g7YH0wnt/S4Gax7wol6hM7m7k5qzonJZ5Q5/O+xS099UzcnKRRxEr2zgEniQ19X2wGdyWIdK5mdQWuOMvDoEM4LN9OJTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813426; c=relaxed/simple;
	bh=qbzuzgKWc70Yq8bhFoHbN3mHqStzbAqyzLKbu95SJMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nPHn9pcMMYsv0qxL4ZMYR5aIpN8cptxvfGbk5Dav2aMh0St1Z1fjX25lhnQ4+4qfn0W4sYgfd9qEggdIhozkCta0SE+YiO7q84H1du4GlTiodWFCnoVZeT2imrmCzruoQYYgY3x1olKpBcctemPZ2c0g/xbk06it8zFDLrJ2iI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FweSXF0j; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0TEp3BpUQbHUMadVx2NhcA5O5lJQmGEBrWqLp4dV57NDiHv/jlaxjUgjgN7JDIEiP62YwK+XNV1bLjhW8Qyg/eVqzIuaDJrzx/tCdZZAD2071f8u/DOMFjh/P8bFsP2ojcXvZ7FTHxIUQPTTy7HziNcNOTRvjRFIlrp9VNE4K+BMDpu6QM6klcqn3FeoSIqwKqjtMLChH5ESr6of/+EckLPXYJgCj4ohsdDNNlBvxDZVu3WaL/OKDzGNLxUeBYEwOEV8tNA/TWATKKATcXaf55G13KsIqFRqgYMUkY96H9MYhIeAF6x7pUEjGjMMZtvzgowm+8WWqZrrZuG3RCr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DXaBm39GwvHE/vQuXjGEZDl8LefbCfzJV2I7arR5UY=;
 b=Am+4rWZ5gN2YjcmLwFw/CbVQz4VzF7VmyknENdCxP6n+SsZwXBVzp9yqfQYdbycZaWXZQeELCftGxghfD5GAYUPW1f7Q4ajWSxCBNeO8SOPlZAjvTSwNIwbZCsUEQN0qlHM7aYcIRHKqaqieNpq5oMndZukiv4Ca3YZCOk5xFtSkP+1bAeC0NhXypo7s6r/M9bPW/G2zLt2XG3yzy27Wam/q43Fx+si1Xos7ZuizlQ0y0YIFKeAQSiYoqicckFVsJs8uJmIFgy8DnXUG8HLnZMo1+JwXQxT7vJStCqMEGx3TTwCcpqyg9HprXd4C5O0rIjqmApTSZ8wEzbzTc4vDjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DXaBm39GwvHE/vQuXjGEZDl8LefbCfzJV2I7arR5UY=;
 b=FweSXF0jeadiTS5vslEbzkiSbuOcCsspxSgWwVf1Sqk92vLXNJv5p9R0vVuh24ae1W0sRQrmU1AbIaW0ud19QAC1CbO6ZUxiTO1RtMi3apEWl+R0rzQkCVBsBQebJOx18vVcDipG79RwuWC/UU2gkEeokPdpvYnvP+Dfs1Iym04=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 09:30:21 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7762.032; Wed, 24 Jul 2024
 09:30:21 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Conor Dooley <conor@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
	<michal.simek@amd.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge
Thread-Topic: [PATCH v2 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge
Thread-Index: AQHa3AAYIVPC9Y+vE0emaLQwTVNC/LIC9OYAgAKqV9A=
Date: Wed, 24 Jul 2024 09:30:21 +0000
Message-ID:
 <SN7PR12MB7201729CCCF2953D9AC1A04F8BAA2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240722062558.1578744-1-thippesw@amd.com>
 <20240722062558.1578744-2-thippesw@amd.com>
 <20240722-wham-molasses-ec515cc554a0@spud>
In-Reply-To: <20240722-wham-molasses-ec515cc554a0@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SA3PR12MB9090:EE_
x-ms-office365-filtering-correlation-id: 8f13135f-59fd-4844-bb31-08dcabc33d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FiFBPX1slKHF9s1k9v6aesHptV9ToWjr5J8j+Tw8wCDSdAc/8WIjXDY2nAe5?=
 =?us-ascii?Q?q3A9JcYPk2YJ03jmhVemHH/vr7wtICk/MQsqQxbVYlB66c8wERzjP+u7YCiM?=
 =?us-ascii?Q?v+xiLBo6nPLBv2BnRoiL/4v444IApZeJ6cc7g15U5XSZ5oa8hDD0YOLr60Fb?=
 =?us-ascii?Q?qsgXtlzggj40QX3HOFmzRSabMq491gD8Y1nKVivk2g2S/rmNctLll1O+/J2d?=
 =?us-ascii?Q?uFlwjDaeN3uH5r8gR268hI8Tpnlyne9BOQxFqGAlrpCKq+Ot4AQqIUiHjn/g?=
 =?us-ascii?Q?jDQWOA2nkuLcwbeaYbxwU4ErUzL5x47cxxfpOKdbSJehnmeqXi0k9Jy2SCd3?=
 =?us-ascii?Q?cfJJ9OTrBNaVPDN70eR4Q0j2QXmhQ3Tj+NTsXiB9LzqOg/GNV55bWL8V55mE?=
 =?us-ascii?Q?fvK0olA67O4aoBLaDCVN1xh8IHr2WE0V3B/GyMGVm2XQINeatj+nLobBoL/3?=
 =?us-ascii?Q?UnXxmyVKRBuIm8km99o1fu+kTIHGYZuHN5cajSuwtV13Oe+iZ+snQnv+JBb4?=
 =?us-ascii?Q?hlOANKz1atNO+c003WQ1gIYckJvrKFY2hCMvf1DCcKIviwaCVxIlL5knpf/A?=
 =?us-ascii?Q?1z/YwZ5YS7IgMewlqnwo7NX/4u3oLHfdYpbDwSIQr7lOnq+5zU8NwJEYLKXD?=
 =?us-ascii?Q?ZetU60qLx0uaD0dNlihvi00KSzEFF6Spw+CZz7eOXRaqITIcBAFBEwTHkzPg?=
 =?us-ascii?Q?ir0swzt/i5W6/cLYJGvLYq110c/obt1K7Ed2WR1AR6YDQ+agyZ1sas9hN1bn?=
 =?us-ascii?Q?KTvAD6uUgm4C+RGJOagUqEPfPkFbJOd9IXV6lglW2RHLHzIIXt42VpNtXZpi?=
 =?us-ascii?Q?DraQ6DoJhohNA1qGne9Hc+KnC9YCxz5zi83+JuMzN1m7DiJhzIteNpE3Il9Z?=
 =?us-ascii?Q?lTqZzLmnW8qUxaW/tV8LTUkAwPDwDhqjYcQlL1BfpNZ6exKlzeCRe4FNDpsg?=
 =?us-ascii?Q?oZ8rnZJ4I6vP7pPpzkrHwVvs5lHGE6/g2H7m/dIUFZThCuW3JPZe9W9xeb4g?=
 =?us-ascii?Q?UwjWDL9ODz6NrNJe9Dd0bTvJAVGxnd4WNBXi7nnjmYr9uz99MaiPw0aOB54i?=
 =?us-ascii?Q?z7WXeaW3vzmfP6bXNfo1dDPgMLWSztfzCdSUIv758NurkFNuuBKz3n0LFxG+?=
 =?us-ascii?Q?tZ2tI9JnrLXqPU/1C18FJLVuFxzKRWjua/yK/5RTwRhCNlvhDCgfPfg0d0wZ?=
 =?us-ascii?Q?eYJejXtjGUm8dJNxPUsLFJsU4R+svTp1HCYhJ1LmAqgkyVjOsNMiOzMaS+vS?=
 =?us-ascii?Q?1c5edfYFa6ZHIH7pM4j3tZTLg1yanFIwjlDM6MDDsCvrdum+S+vul7fIDZ+4?=
 =?us-ascii?Q?DSHvzHRmngi4g+MrmutkALZ8NLHstO1qSiNMevfutXgRgMZVuoEyOD+ZXc93?=
 =?us-ascii?Q?pXSUu0Re2QwdN1DVs/m9tghOgZe6iEXplqZBjLB00n8ocPKyQQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1eQSoqxmTZ4rZHgd70Drfma6YEhd+UzrMHS9YVKMbzkVM6+RHEeHgmGA1Mg9?=
 =?us-ascii?Q?vvolm9KK18FAkWuDssDeQiztIEWifOOgY8nADwcJoGJDUrpGj+kZokrubgQa?=
 =?us-ascii?Q?PmHrRZenzOeZ/1LNudgC26B1Qzk2z8KZ/BxdnlUsU4dy/AnyFsG4qZzgtr8p?=
 =?us-ascii?Q?O/Zxd6/vd4FvAd+OtMGFdu9AV60twp/DGeNpOtgKbTfXJV0Ikcq4BQSTVaph?=
 =?us-ascii?Q?yMWkSHDwz9kVBciwpYgRIYeYIsUJ7oHkq8WLSW4YpbGylGMJP5F6PC/YLDxl?=
 =?us-ascii?Q?2puxB5nTNjPc4M/q9g+rA3jZJkbwTB5IEVR8aqrZQ9VrHkH2+17FCXO98joO?=
 =?us-ascii?Q?85v1bq4wb7+xFdUk2559BByq+umwX4jJxrLbVLkTbHhg2OGQ6EG5GdWH+TMy?=
 =?us-ascii?Q?oZHv+jC8ACAsHBB7eAJtuxpA88Hqlbeo2NMK/bXO7Jl4v1/oDIYIp7V73WfN?=
 =?us-ascii?Q?17AE+4CJzKsOcse+R01l2OZp+3kqbXR4bAGvliMSb5e4I2blerFwh6wvXzmC?=
 =?us-ascii?Q?DCohKcBk9xRiHTVIz3JB0G0IeClUOouL+FzWjLDCTKtbi45NGwBh02OScba7?=
 =?us-ascii?Q?RBQgiaEyW/rV4aHF2T2CXpkz7iPn9jiSD8GjA6+G9Szhboy3Nrq08FpAP8vX?=
 =?us-ascii?Q?yBTy+kRTSFs3hTke3EpxnX/zWSIaus9hLn4zek84u1/BbFs914L0KAX0wjku?=
 =?us-ascii?Q?mmL/nmGDjfjqXSIZKmoUilZgTuv+NQ9f7JB4XdfWwQIF/4ntJZgbN9fbSS1t?=
 =?us-ascii?Q?2x0q1sIm+lvwUxPavk0HcEgJ/wJPBgflA/+ETX+0hQaysNjg3MBt5XuphKMs?=
 =?us-ascii?Q?3vLLnjSSoPajPPALFNrlsYsVERybw0/6CiCov6Eo5fCj0obaaZIFrpCDDTth?=
 =?us-ascii?Q?FwmQOXZ0XFTjJjWtyqwiq75GzTG2DvwqfwLc+57jV985FNeDQQJ+43pxnjbn?=
 =?us-ascii?Q?1A7XBwJ7lpfvzr1rA78m0h7T1q8qfp0KVLFcGX/WKe88Y313dcM0j+buvlvr?=
 =?us-ascii?Q?67a4I8o7frgreHgQueX7bwuoe+5AmXeZaDbYern15n/FBWbXm3/g/DhMBGY+?=
 =?us-ascii?Q?Q/2yHkgz0ZkxHvH5TK53C4gm3rnofepdZTyh5KK1325bJKnNcGx7WZ3XxgM1?=
 =?us-ascii?Q?aZ8pNzCy7Dnpy3bpJzEddtVfklpDjoHVD4a9cAzrhw5il0DxZLRTWb8oOoJZ?=
 =?us-ascii?Q?pJpjfDIEOIMlM9aGAVJOGn1LEIIdhEopWWGTAJCgK/xGWLGWp1kVB/59OpRQ?=
 =?us-ascii?Q?jq8LUj2LvUbqqDmzAbF1Co2Bmj7MtIUEfcjfu7Rx4a+eF1TBbf8I67wKfTO3?=
 =?us-ascii?Q?3FOGddTrLZMLBbutRFR+3WlSrhmBVrNkxzW9SWJd3Ete8GjLHnB8n1eJ7q5q?=
 =?us-ascii?Q?LjpZX0vpttCRiAN8JTkUM/lz4nNB1jgYY+BZBkbV0xTcy4g8Zyyg0SyYQBDH?=
 =?us-ascii?Q?OZm9ZCpWC5LMGXP991IlS+kLdonjWMV6+w+SDiUD+uAl0IhbIx+RqaSg+ots?=
 =?us-ascii?Q?6WChsvCIzhW2Lt9ciVBgRp3nyLfOkgl/FnaCMxgtHaBeCwPoENNemlC74Pgi?=
 =?us-ascii?Q?5UoKxZSSScfdV1asrrw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f13135f-59fd-4844-bb31-08dcabc33d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 09:30:21.6546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kO5ADTvLY7uRRR+e7W6RLsb/HTfERbRn23wGGUzSokGyZ/uHDYk5coyxJ5EGG6aMeCjwjc345XJ2LWbRhfImJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

Hi Conor Dooley,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, July 22, 2024 10:15 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; krzk+dt@kernel.org; conor+dt@kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>; linux-arm-kernel@lists.infradead.org;
> Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas fo=
r
> Xilinx QDMA PCIe Root Port Bridge
>=20
> On Mon, Jul 22, 2024 at 11:55:57AM +0530, Thippeswamy Havalige wrote:
> > Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port
> Bridge.
> >
> > Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> > ---
> >  .../bindings/pci/xlnx,xdma-host.yaml          | 41 ++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 2 deletions(-)
> > ---
> > changes in v2
> > - update dt node label with pcie.
> > ---
> > diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> > index 2f59b3a73dd2..28d9350a7fb4 100644
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
> >
> >    reg:
> > -    maxItems: 1
> > +    items:
> > +      - description: configuration region and XDMA bridge register.
> > +      - description: QDMA bridge register.
>=20
> Please constrain the new entry to only the new compatible.
- Thanks, I ll resend patch with required changes.
>=20
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
> > @@ -111,4 +122,30 @@ examples:
> >                  interrupt-controller;
> >              };
> >          };
> > +
> > +        pcie@80000000 {
>=20
> tbh, don't see the point of a new example for this.
- For this in both examples ranges properties are different. So, here I wan=
ted to make sure that our example device tree bindings work straight forwar=
d when our reference designs are used.
>=20
> > +            compatible =3D "xlnx,qdma-host-3.00";
> > +            reg =3D <0x0 0x80000000 0x0 0x10000000>, <0x0 0x90000000 0=
x0
> 0x10000000>;
> > +            reg-names =3D "cfg", "breg";
> > +            ranges =3D <0x2000000 0x0 0xa8000000 0x0 0xa8000000 0x0
> 0x8000000>,
> > +                     <0x43000000 0x4 0x80000000 0x4 0x80000000 0x0
> 0x40000000>;
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            #interrupt-cells =3D <1>;
> > +            device_type =3D "pci";
> > +            interrupt-parent =3D <&gic>;
> > +            interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI =
85
> IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "misc", "msi0", "msi1";
> > +            interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> > +            interrupt-map =3D <0 0 0 1 &pcie_intc_0 0>,
> > +                            <0 0 0 2 &pcie_intc_0 1>,
> > +                            <0 0 0 3 &pcie_intc_0 2>,
> > +                            <0 0 0 4 &pcie_intc_0 3>;
> > +            pcie_intc_1: interrupt-controller {
> > +                #address-cells =3D <0>;
> > +                #interrupt-cells =3D <1>;
> > +                interrupt-controller;
> > +            };
> > +        };
> >      };
> > --
> > 2.25.1
> >

Regards,
Thippeswamy H

