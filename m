Return-Path: <linux-pci+bounces-19604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DCFA077FD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 14:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5EF162A75
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE2218AC9;
	Thu,  9 Jan 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="duOoaVyF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AA21639C;
	Thu,  9 Jan 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430177; cv=fail; b=XQZIHZAgT6ebfZF6+EqmVovl63OAISfzZOL5cSI8jZGLYXLRxryrOF0MKjcN9eb0WE+MYeUfvNYQSaMNNIdT8JvEVtPaQjphNckU253Xn7foSKkITkB1ugWclR3A5KDuwmhskIOn4z/08RyNJzicmByHI1wb856U00XfMxuULtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430177; c=relaxed/simple;
	bh=4MAzZMCPSNB49KkQfS9rIwl2XMhCA+bSRwmQ05jA268=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jp6H8ZicGrHf6OS1caRo9sVmrki3mJnrNQ8SYskTDb0D8XI4MXjo2tol/PmJTa6Fp4w8avCStDIpfuVQZ+uhZuQhhgvY45FytAh859i/JHYLm6crOmbFdmqes6ZN4KOeXVz65ULzzmc0r9g7SPb+dHF/L1+tM0LuKioJaw7l/I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=duOoaVyF; arc=fail smtp.client-ip=40.107.105.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXuLi/CaJtbFU6GLHhAvC/nsw1U/vuxH8AGf1g86ei15SxXQZSVjxS1VwSfDHlDcJtnMWFGHfVBo4QivvqGiasGPEObLS0V8zKAG/VYFTY8I6ntZldEtnUTzz4a7494KKUsAVDZggekwtHYBTW5X8AQ3Qb6khGRM4NDRdQiT3qdKygIwOncPoEwukZm5wV6pdJZIjqXD0UOsObWvoPktQInD482RhgY/2iYgNRcJoHuyiuON/Kzv6hrxpimJQvWo+xgJA31h89Nx65d1lXMwIZn7fR5Y+Fs+610JW8yEKnAlE8sGnRWDqXFKpDHjkVx6Fe6keiW6FibkWzxjp6JtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MAzZMCPSNB49KkQfS9rIwl2XMhCA+bSRwmQ05jA268=;
 b=rIUr0O9ikbZbpSx21b/MY0JCysQnuo3zboqyttxl6RZ/ozJhBQOm8vbhCqhYDfJtYnYP8cEG1ruNOoBt1HE5MBRBJCflO2tUSfzxNdSXlWd6rfE16Kx5TBLRTgctu4V/62j/yaht08iU6QNj5jg75PNtPT7O8h4CZdS2rjIrV1RL7pL0GfS5J0bChps8kqkjW1ONUaC6vCAD1XcGVgJrL38Z9DmpMIG3aD43yhUlXusHiGG39nwSA9dWzLJIUmkRsuStupkRBESgULh81SrIpXaiGtMgv51WL2l6wRCgdfwIJscFQCK6zgGkIspqtR0a2ulFIUkJcUKdAPSXEwNegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MAzZMCPSNB49KkQfS9rIwl2XMhCA+bSRwmQ05jA268=;
 b=duOoaVyFqeu/a85A+vwyoB3aS4VkVKw77CbGpBdqcwb0UKF8VxhbY9yhlUxLs+qqqOhw0BuPtOGIMTv82zr4VLVcDR2Vxr8GZ+wyWtJch8hfC5y0QORayESet718NJCVAGrudNBbt/SaVkP1fqa7AQIbxtmI41XiA7c8k7uuPRA=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 13:42:50 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 13:42:50 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jeremy Linton <Jeremy.Linton@arm.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "acpica-devel@lists.linux.dev"
	<acpica-devel@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"robert.moore@intel.com" <robert.moore@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "wei.huang2@amd.com" <wei.huang2@amd.com>, Honnappa
 Nagarahalli <Honnappa.Nagarahalli@arm.com>, Dhruv Tripathi
	<Dhruv.Tripathi@arm.com>, Rob Herring <Rob.Herring@arm.com>, nd <nd@arm.com>
Subject: RE: [RFC 0/2] GENL interface for ACPI _DSM methods
Thread-Topic: [RFC 0/2] GENL interface for ACPI _DSM methods
Thread-Index:
 AQHbYFhh+XQXSn+/5EqzpOVXCwp9ILMKCWEAgAGLcoCAAANEAIABtuaAgAAOOgCAADmnMIAA3+mAgAAA2dA=
Date: Thu, 9 Jan 2025 13:42:50 +0000
Message-ID:
 <PAWPR08MB89099DA1BF11CACBA14E21359F132@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
 <20250106180140.00005132@huawei.com>
 <85fb2b19-9d15-44ea-8f76-b3cac14e2810@arm.com>
 <20250107174842.GN5556@nvidia.com>
 <d35924de-a560-40aa-a99d-7278009c5ff3@arm.com>
 <20250108205030.GU5556@nvidia.com>
 <PAWPR08MB8909F2373F84E4951F74A79C9F132@PAWPR08MB8909.eurprd08.prod.outlook.com>
 <20250109133815.GV5556@nvidia.com>
In-Reply-To: <20250109133815.GV5556@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AM7PR08MB5463:EE_
x-ms-office365-filtering-correlation-id: 77b6cb60-b05d-465b-c023-08dd30b3829d
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1JH/EDDZOsDQmoIjVVE3cLkH9Oeux2AFljZzHVHQAED+iwpd3WpPpW6nqo2T?=
 =?us-ascii?Q?l/Hqucu+cgQ5JgqqkWeqOLkPDIroHyFB2CwlRdX41ftc9U8rQUqMBVRWOTNo?=
 =?us-ascii?Q?kUD7BHDx90gHU+jDDIbhYkGVS55RqnRXHM2+IZOlZV09yA6xlqJb9rvxYiqt?=
 =?us-ascii?Q?Q7Im09cR5A2r447C3242bYiN+HssKGJBRVa2AkUbd+cnPsleW7qh8ih9mq6D?=
 =?us-ascii?Q?GzrBXjV+6+nHxYwUi6k9NSuFo6Sl5HFdKQIS/0IBcJzsUi5I1ZZ9AbVRe+Hk?=
 =?us-ascii?Q?5OrwTk8OvBo7kSBxDs3eccISk+u5scn6HtkgjVAlJMeMZVP6oz68KNynLTVR?=
 =?us-ascii?Q?GqvJIGj07aWE4IRKjfAkLCAxVId+ruYIIPZvopTCLMTh0MxX3wzSwczGGwLq?=
 =?us-ascii?Q?Gpd9OmG5zfHB0ut2umCokdR7z0m1rOI0mo+dfDra/SlZi+QseJjki8d47fM7?=
 =?us-ascii?Q?bXdVGQps5NUfD4oP4KamK66aETKP9MzTHQMqpPskbjdT6MwvhKu/347FsmgR?=
 =?us-ascii?Q?WorvblpQc4TOmxXkjclcBzn6vZWXJ72Us1oghd0oJQj5YuS0+cjE8zRqKe8Q?=
 =?us-ascii?Q?/NxWR/oVGatXgQIhglELdC2W9xdnl2m/FLamEPsaOK26T/TGvobr3V0vNlqn?=
 =?us-ascii?Q?p1LpldvFgZuacFZmpWtWr9s70qcTPqwz5JlSZy7a30W7RLFWYIddHkTqst/4?=
 =?us-ascii?Q?hac7RcW0su1rMD9NUVVcI+SRzE9zfFo11qn4hpT34lLkH173X+urhtSSe6xv?=
 =?us-ascii?Q?rPKJiE/Ed3nISAVgsykzrDnMi4N3elNFhNF77UlgG0DgIDhigOEdEzlduFUK?=
 =?us-ascii?Q?CBciBr2eh1oby4XeGQXPyzL5uG5DpKWN1v4LGru+rU4yg21uZlop6XAyEwQI?=
 =?us-ascii?Q?e44JrZpq+US5+wg8FsJ2TeUdvrZZmX+3DzbbO8SUU5F6K3+Uys3ykCgHljjS?=
 =?us-ascii?Q?TN67ZIvDXZh2n0FZHjWjhu/x9HtCAwovasl1IZKW7HaKDMkFJjdTCupLZfUt?=
 =?us-ascii?Q?MxwqSMPX8MLomKudcc/+Qc+hunux9Nl4ztZlGhqGVX9MZF5l3omO2QJn++xo?=
 =?us-ascii?Q?1TOvuxxA9+Atyhfm3bAlXGs8r6arc5g6zuHLywvWIJw5n0FRkYy0CSNip2JR?=
 =?us-ascii?Q?+EBYitPsmN+tIo4zgoYVP38K7d8m7+dYuxpMVnPO6RktYiPs2VNMki/4GR8T?=
 =?us-ascii?Q?07Y4uWFz3Lr6lcekDloNNRunDJW2zmb7VNJTU3yjGGxQuXm4lLbHkZN92gmr?=
 =?us-ascii?Q?KQDbbnL4jInGhE/58I4P9vzytK1Vr4bCjEQZD2rPO4BZIAvNGJWr3ym02qYp?=
 =?us-ascii?Q?gz2IihkjL8Yj2j3T6aIqAs0jTlT2uCmIBV4gJVhAba0bSFZfWOo0JoSYh45E?=
 =?us-ascii?Q?H/IhsUtgyUJ0RrpVdK7sm8pU18hZV++vYKBmTI1rhOiRiXtlcrfaXGL92ALz?=
 =?us-ascii?Q?/exXq2wvj4VeVtvetmRY1bmTXZ2A8Pjq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?724Yg77oBYIe/D1AZCnrb0QiLIsVz5dNFSVwEvcDmt6UxjYGY8B1GB9Pz/6M?=
 =?us-ascii?Q?PH4nPZzku3a42TuzfNFBFyVIk4xXWe3JUuvJjXYw4KXQlP+5sMcaG/7k27Wb?=
 =?us-ascii?Q?Yk+K1+3IRxH+Rhj/rQPVPxLlxJ5Ws6nt348e0x8uX45f96q3R03DFWQhM3TH?=
 =?us-ascii?Q?Clh8AaN/jtHQNoz/X8lbXTWL1hGTlKUhjJg8V/++npkhpfd3MjkrZtX3CHGm?=
 =?us-ascii?Q?7c9mS+prez8NDuX7urV7svnPZ5MOBigjm1KSc5oMthUNB18R5AmH3CPgnMH8?=
 =?us-ascii?Q?66xBkH4PQiPDpKFPhJ3Ll7fajX4SgWtJWf1QoEHosC4Yex4HUeuhPtfE0l4H?=
 =?us-ascii?Q?OggffEPpyPxhVG4QsjNbCuyDIevM/3ZbZvbe0kT5/ASbvYBMcqkqH0ri1q1/?=
 =?us-ascii?Q?OZ+81hXhrfzW0/wHqr+QOweuRJ5T+UjRBgy6OZVx5fAg++KOOmLDdqN/26V+?=
 =?us-ascii?Q?CKQ8LtxZytl7tYh1Thx6YBBcPpnTRfdtUrFIDmA8UvdxiPHcAJ3Pf0B2bdB2?=
 =?us-ascii?Q?nUdpjc/l9RchBW3eJZcvEYrg+nXnVC5aqeIvcSkoqhXn+FtXOxBqnXzbVSFj?=
 =?us-ascii?Q?2wUckKu7HCpVxflO8YvbU87RADWDQGfmPVc4Quf8+L5ByBS5CQ/+Q+Mb2MtJ?=
 =?us-ascii?Q?Gm0yuH00c806kPk+42pqayDSkJlVlf2B7fBQfneKHrFWnHkBG9zYb2vspbq3?=
 =?us-ascii?Q?ADaho9aEZ5o1qH7j1Lan9tVn3OrSlbwPvCYh9uJJv1DW5qRdLjc1X2yLgq9h?=
 =?us-ascii?Q?zaoxTlSXQGe83VnsV3WIUWiZY2bYXe7cFzzqJvtKai4rlq4XYt6CLV3KH6C9?=
 =?us-ascii?Q?R6/rRjvDwH49eSpjNiT1f1/y+9I6vYaml3ywhvcpgGa+uZqDBFQ0+pREpKie?=
 =?us-ascii?Q?FMvJ4+Prif/JJFUOIdx4dprSYE0jPlJWtIGzAKXc0jRyByCoWSlHAlxy749y?=
 =?us-ascii?Q?PbR9Mf839vTUgsDM9BnrsBpm/qJsyX+9joXMq4rYLWubeB0I5McEPWkSe6v2?=
 =?us-ascii?Q?LJUEm7/iu6jIMBs0q7q1ZbmWru10H9M5VEYNJ8CAV51cB5e0/69Thppe/a6X?=
 =?us-ascii?Q?ODpgItCcihmL88nHqjuUDWvtGtadQ75td3r9tJnXfgyW6YhoWpwLIguFtUFG?=
 =?us-ascii?Q?IdqP8e7jLlS0wWC/6aEEioDaK5sKuap1IK6VRQtXgXSJ5rO2SlL5A6xLmebk?=
 =?us-ascii?Q?eEFwybGk4cTpRZ9hOQSa+us6lXtkoO/hUbzaQGjQxMezBdPauP3s4xmvrosN?=
 =?us-ascii?Q?bNiYC51ITkexg80ho7UX/zcswV2wAhyiMr3aqPy350ZmQI7o3r2JBiD3WWSI?=
 =?us-ascii?Q?95qVFD2QKIrcTVUy2L50WSiEKdBMpYO+X8IuIyv6iKg92ejauq8+TsFuIr0j?=
 =?us-ascii?Q?uCr//4ctLrmBhfsEAOFBcMD49ldICGKACUfW5kF+rW0EmsA8QaUJk3gO0tTz?=
 =?us-ascii?Q?ojdJw/MyiIB+IVNXnXGH0AkxINMy1f3um4Q+WMnVOEnaui3DEBJBxaTLyklW?=
 =?us-ascii?Q?ff/k0zf9mdt14u4G1pbSHDtv4I7WE8hEmMm+dg4+3Kut+xrSHq7Lkj5nwPjR?=
 =?us-ascii?Q?mvOLwhFNbeQfrK/Y4yRud+t/TXylt//LlwqlvoDg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR08MB8909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b6cb60-b05d-465b-c023-08dd30b3829d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 13:42:50.4982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktP8jmN1GR/kIkj/wRwEe8IxXM8z2Xep/CkxSJ4hSuMOUwnqbnnnIrVBx2q5UramoAqoetdIjHEBrReJ9LsoRPwpImKYS/2X8RDBRBEQ0Uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463

>=20
> > > > I'm under the impression this is a similar problem to cpu/irq/numa
> > > > affinity where the driver/subsystem should be making the choice,
> > > > but the user is provided the opportunity to override the defaults
> > > > if they think there is benefit in their environment.
> > >
> > > Which I think has been proven to have been a mistake. Instead over
> > > overriding irq affinity though proc/irq under the covers of the
> > > driver and hoping for the best the driver itself should have the oppo=
rtinuty to
> set the affinity for its objects directly.
> >
> > Do you mean that the driver should handle affinity requests from the
> > user directly as per its policy?
>=20
> Yes, not every driver has tidy mappings of objects to interrupts vectors.
>=20
> > > Lets us not repeat this mistake with steering tag. The driver should
> > > always be involved in this stuff, if you want it to work with DPDK
> > > then go through the kernel driver that DPDK is running on top of
> > > (VFIO or RDMA)
> >
> > This RFC is only about acquiring the steering tag from the ACPI _DSM,
> > which the DPDK user space driver will set in the queue context of the d=
evice it
> manages.
> > Setting of the steering tag part happens in the DPDK device driver.
> > Are you suggesting that I should instead pass a CPU and a cache ID to
> > VFIO and let VFIO decide what's right for the application?
>=20
> I think that would be better, yes. Get VFIO to give you the steering tag
> information, and any related control of the config space you may need, vi=
a an
> IOCTL.

Sounds good, I like that idea.

--wathsala


