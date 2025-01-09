Return-Path: <linux-pci+bounces-19580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC2FA069F3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 01:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10813A68BA
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F948291E;
	Thu,  9 Jan 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YWNzhcdn"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCB3D64;
	Thu,  9 Jan 2025 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736382877; cv=fail; b=id74PHYyG5NEbzaBVYkiRQoTgLjMmh019rHhrFawahcJDse7qIvvOBAs33MW7hyicYipf1K9nxIj9K4rgnPsvVIT6LTTq99frdCNrOr40jiNZZ226AawvAVaO0wmmAhC3mejXDW76H5pEtOEN5TRSrf+76YD+mYUSPP3eMz404k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736382877; c=relaxed/simple;
	bh=9PTy5Otko/pcgP6LnKnFnNn/ZgCgjZ7FOYhkc3F1D5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JbghkNlxH7LLfL9B+fBb2pXqXw2xMdU2xNVn/BrsKgjGmFpGuHNu7r8/ed8Yga9Mbxei8myMYpIZz8JgIfRkVNI1r1PEEiN+k3rqt7iL848fmo1Iv4bgR4w2yBHpWL2ohZW1GJhl6vzjfjilWFBSSEHy3fBA5mUkdhYjnQVh9Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YWNzhcdn; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXia1BWAmzRF98YAKbBzJ0iebf/pviAuVSnAmVKQZ88kUErhYwAPBGp24c8uXZXwucTMvESUKdcpMqvOwsG0wQ4gl/yXovAIp2zvxEKC9MsnlcjLgqNHNtQrQ/oRAx5eq9En4QGDtcH3B1xG6D2bM5dfxtKWB9ZGQlpfDd92TtLupi0CEU3t123IU01hOl6tvMcccS9ReUxwTb+ZRoNmuXQ3rJUltIVCcq6r0PxzR5q8Z6rVa7xjIp8PKEOPzCa8dUsS22QzPmkDhziMCX+q31Cxz64JueLw6dEKV7ubkQ1eIX1tOp/3n84phWrmtjLAWrkXbkzgYVKF3kr0RvRLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PTy5Otko/pcgP6LnKnFnNn/ZgCgjZ7FOYhkc3F1D5I=;
 b=jpQZZIuoHmh1CGdgfDU1VKn2n/f6/NkmKZZ9vgovgrRrX0px8mINET7XcLyyCfuxnMdiOrw21VbZriO2UxainkGtNGKsUnO/TkqKJPFqOVnUPmwH7zUzvyQ+locuPZhLHGokQ+8Ua5G+2sY4uRQJzKc7pMR4UuLuygKaQcyfLAvuWBXSuJ7tEvVFzJHllHjTLs1uyNEdWBVv6v56e3TFuyvh1+OrOYceO76w6ay0GAFzBC9XXQVANXYvTnwOQA3VBmgwdSC8ypE6h/cpJGIa9SyyF0+O1lhMFdhlHD9Y0T1P5e04Ir0c8Qi6eVPxSoBsCSDbi1rTHTyRz14m8sBFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PTy5Otko/pcgP6LnKnFnNn/ZgCgjZ7FOYhkc3F1D5I=;
 b=YWNzhcdnhgktiV3PEpwWP8IuRDVGHAuQhvPhXm36BaTdaLC0qkB+KkHcTojYSFGn1BKSmbSgNlEOXnrKoMWEK/4gytvJVTaNduyp4uHyoL0i+RtmVCx+Z+5AujnyQFiWD49yZYsJBnuB/yXJ93lbEd0ZfDgey0Mziiz+7ePV0K0=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 00:34:31 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 00:34:31 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jeremy Linton <Jeremy.Linton@arm.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "robert.moore@intel.com"
	<robert.moore@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"wei.huang2@amd.com" <wei.huang2@amd.com>, Honnappa Nagarahalli
	<Honnappa.Nagarahalli@arm.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>, Rob
 Herring <Rob.Herring@arm.com>, nd <nd@arm.com>
Subject: RE: [RFC 0/2] GENL interface for ACPI _DSM methods
Thread-Topic: [RFC 0/2] GENL interface for ACPI _DSM methods
Thread-Index:
 AQHbYFhh+XQXSn+/5EqzpOVXCwp9ILMKCWEAgAGLcoCAAANEAIABtuaAgAAOOgCAADmnMA==
Date: Thu, 9 Jan 2025 00:34:31 +0000
Message-ID:
 <PAWPR08MB8909F2373F84E4951F74A79C9F132@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
 <20250106180140.00005132@huawei.com>
 <85fb2b19-9d15-44ea-8f76-b3cac14e2810@arm.com>
 <20250107174842.GN5556@nvidia.com>
 <d35924de-a560-40aa-a99d-7278009c5ff3@arm.com>
 <20250108205030.GU5556@nvidia.com>
In-Reply-To: <20250108205030.GU5556@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AM8PR08MB6322:EE_
x-ms-office365-filtering-correlation-id: 37788d39-6904-4756-072d-08dd30456223
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4+48tod+e+vk/tQ5aPWDH0tl+fvcz02C/GfliGL6nurGj4qFVJEBdDoffaq/?=
 =?us-ascii?Q?KfyF3QqBzcszjQbvbiaelZdeHtz+LU5gcflzHNk4eChssBygrrlYpVNoz02U?=
 =?us-ascii?Q?eilbwR6J4QFpDUJUm67MYiU44cvE2zdKygeMYUmFnuWm7wCXpT16QwhB8CUn?=
 =?us-ascii?Q?Q1yCoTBK9Ce0qM6PZoTWaZjICqnuYOGbPAQMVXPHbBzBgR5VdY67khiRLdmE?=
 =?us-ascii?Q?1cMhr+hes3qP7eF4mdgVaPfxsVI0ZexEI5SZxzSTJoqBzRPlwYf8bkhnT72r?=
 =?us-ascii?Q?NF5Cx5gHLZXAsDvrmb/h8izZPIGLpZolwEWLRvhuoyFWXokg45QtJahsUtVH?=
 =?us-ascii?Q?QVy3OEkPjcJ+cvzT5nJREUPg3h9qbvRTk4epvq53j0uHIGPFWzCt1QAR9EZV?=
 =?us-ascii?Q?xm+5V2i4jiFEuQMfco5glsN4z5W8n1fX7uhYHkrRZR1fB0P5cLGlm3kmOBbN?=
 =?us-ascii?Q?kYuH+VB/qA8XYvCOAs69uIdk1JNxdKSfHB9HAhgQRVySlkStmvMv4aUYxAvY?=
 =?us-ascii?Q?im75EiiHlmN8IMLKeiy/b/qmPBeCh/dwXjeYMaauVhddz9o8nRYiz8XzHzjb?=
 =?us-ascii?Q?txuUbZlhgX9BFitO1v3Ba3l7efjXwgnovoO11k15Q2TV812NpCXqqG95G/m/?=
 =?us-ascii?Q?yjhGIBJGYGzVCYzMGij1laDme9pJB05GXpzSkRFBeklrc3KkZC78yGSE5HTN?=
 =?us-ascii?Q?/KiJae2keNb+2fRp73aHi/dq1ofB4dai3RmA31q7dl4slEgvAw6smpTb7Al9?=
 =?us-ascii?Q?yNVXQiKZcthIto3fPcVVv6Qst4ZEBUtggnTBm1iksauWXiAyZ17Jp9dDvTPY?=
 =?us-ascii?Q?rrPSkV0CDjs6Llg0WRdvNuUuQva+sN09Y5HqwXrQhpyHiVgocpelhePDSKMg?=
 =?us-ascii?Q?Bls1fgB0OlnsbMerd81p7txk2Na4JcE7nQ3Z/YcNoj+I9K1h6V5NHoRKI4Mc?=
 =?us-ascii?Q?AUyHX4UX21GjMZYgBXkxaxtd78c8+KBGp/jtK1gS9u/DOQ+cxDeZMBwBDMP/?=
 =?us-ascii?Q?6fu0dAgmWtan24/0yQfhIlmlRAu9Z3jogEj/4vS0cIZ02vhCxfRMO8ap6Gcg?=
 =?us-ascii?Q?+hdub8+SiJmk4WNyNVuSacWsL3FSopaxcKL/GRLSlV2t2PDtljzyuctRLqTL?=
 =?us-ascii?Q?xYwcIgJxJ0cfORUQ3OU8/eX8/YCeIu6snBmEL8YuaXaD1NY3UR5az6u4g6Os?=
 =?us-ascii?Q?AWZAPdwpIgBmOKHEVdqeLVPr34+fZqYfGYijzpfxBTB260ud6+yQRCs0QuFl?=
 =?us-ascii?Q?XjqqCYUfIuxdMGB/JZKqmvdbHSpXrYg9bwqhAfllVhJ04A2ohsq+XrgBHSa8?=
 =?us-ascii?Q?JPnn5yVZU1M+PWwmFSpWreii3Td0K3+z6N5eTgb3keY/iTUieXbSIUs5K7Ys?=
 =?us-ascii?Q?m2XcFvNWcCZHSdJYZ69Jr27uMEGlzkD9jMaHLIVOMZtZofyBpDAxkm8EDOss?=
 =?us-ascii?Q?gfM/tkBXEqPGIVqFqrrWAjwGmyZ9PZDR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8x5/fa7vjSt8WlmK/qr1rNPy6b8gK1EKNQ1TT3YT0mH+gte0oH2TJbpmqk7P?=
 =?us-ascii?Q?i+4XvM51rrKaZwujMAApzLLqwoyaYdBh5t3Xn7irjUzm7kh6UnS9aFGHY0QZ?=
 =?us-ascii?Q?cgQhV2ZrG5h2m7Zlf/QeFQKPLurvlw/RUOL6RT7nC3nhoREF87b1FZ+Y58DM?=
 =?us-ascii?Q?n7jMztbC/vbmlikZDMJOxLXv9jBIGuYq9KGu03++mdOZ2aalyFiUgDM4+0np?=
 =?us-ascii?Q?WPTKOQqhIcJervz7n9Ljde39bdwQ9N/WB7aCoBp3Om4nkY+9sh51W14myTLc?=
 =?us-ascii?Q?pf0UeTvuOi4E8kcbax/0tAjctzvbysDcEMFD/Kth/+4sNkP8mBRtXZaeyAPF?=
 =?us-ascii?Q?/8XdN8YMg00CXcGKGhqiXSG0gnoMZ2BBfAP3foCulQAcv3pIwwsqomxm4/Kc?=
 =?us-ascii?Q?Ljfn84klSqyQQLKHHD25L6D3HC7T5gR/p4G4eEpAqA3art0RP/ni80mgiLCg?=
 =?us-ascii?Q?Slfbxbg1QgZhYEHhfauW2Czu9s+5tTG8f77RGT8/ptBriHLPpQi0q9Rzc2Kw?=
 =?us-ascii?Q?6QlJNnEXaX7TrA+DcL1wyZxZmeF9h3cqwFTJ4/aTMdtjmowt5ZQbPIagZdap?=
 =?us-ascii?Q?xz3yn2fEek+YkON4rfORvpNzM/TTUljk5K2AnGeaBBXTiJvl0EdVvEWfdH/A?=
 =?us-ascii?Q?Rv8wlXR7mOlbeRDYqf3MUMnTEqxfPsC+290rpPkBOzYFnKkY2Hk3Vegyj7Cm?=
 =?us-ascii?Q?3o/yTfzIc0ZSHNq9SdcG65TtUg5BZWPT2yyPu05EfLIZ6JakwS9bPYNPEe1r?=
 =?us-ascii?Q?ro/YnvmB7O83eryTb8EYXSZTJtPGMP1ZMpmg5QSO6TemQL/LMnbdaJRCJRye?=
 =?us-ascii?Q?vLu0v0yhTFFO8Sm5Nv1ca6Mjuu6VVDN8mdUnnW4Y9v8EN6Gc1vw6szjqADzO?=
 =?us-ascii?Q?ylhqQUITY2h5DPw1h11zPfVL6EL4olw9RYe/QzGIInzcr/ZrPrLSlg4LawkC?=
 =?us-ascii?Q?uGkJks9II6vC2t0u7kV8ca5pECVYJzYE5G6ECPvMZnchuyI4c4BOtxrbzJf9?=
 =?us-ascii?Q?NZurZAa5sOgYlsTWpZhXeVJWn8sjBojNSUX3tdtalxFCN5tIkyqzrsD7q3/a?=
 =?us-ascii?Q?mZu42rMaVfwGQq+Zo4to44xn1ulTZrVc07F8ntRKgfAlAVLQF5kdSSprfNkE?=
 =?us-ascii?Q?Csqnr25PgvrNIpSMBpSyE/UjeiRCaHBOUfUsbBkqDCZMgQDVhqlsQEi1fux8?=
 =?us-ascii?Q?66oXmu0Q4Fpn2RQGvyqwuGC1MDpMhvGY0xHpnvBtWBFFTnOwLdkn7cAiWWzY?=
 =?us-ascii?Q?0y6YjjuWJJ7Bzuk5B0jqeqDflysYAF2cDcKhIWBy2qt7+J6FJUuEAiDa0IE4?=
 =?us-ascii?Q?eB8zdlWAuLm6yza2m2R/hXZ7JX7rMAs7MIdMkKjcc4X4l18jkW5Ck5txYrtY?=
 =?us-ascii?Q?vU+vNzt+jh4of/PQMLQTDWd8Jx6M04++4n5+MAPS5Lk68+6sjgiIqpFZ5ic0?=
 =?us-ascii?Q?NPPVM3n9YwjZEtDrFhbCITudEFHLQxqaiLEFQfasisa2lesSf8y/q9xW/8bp?=
 =?us-ascii?Q?oY3ZJbv8dTdzzdPF8cqjIGJaflO790myiopdp7ep2RBV0JY4M2iz/TRn9d0p?=
 =?us-ascii?Q?jKJvo6xG9or63nHhxmj94ijGg4CFOqtbJ6I1N0DV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37788d39-6904-4756-072d-08dd30456223
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 00:34:31.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOOO0U1Yk+kPi3tNdgdChC7QgNrHvYWwjCNkCaqgI2KHBUzpzCJH4rurulPP9TCxdqJV3y9dJbJLu7E6bbh5NhgD8p7+5w8kFOeg1qay6/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322

>=20
> On Wed, Jan 08, 2025 at 01:59:35PM -0600, Jeremy Linton wrote:
>=20
> > I'm under the impression this is a similar problem to cpu/irq/numa
> > affinity where the driver/subsystem should be making the choice, but
> > the user is provided the opportunity to override the defaults if they
> > think there is benefit in their environment.
>=20
> Which I think has been proven to have been a mistake. Instead over overri=
ding irq
> affinity though proc/irq under the covers of the driver and hoping for th=
e best the
> driver itself should have the opportinuty to set the affinity for its obj=
ects directly.
>=20

Do you mean that the driver should handle affinity requests from the user d=
irectly
as per its policy?

> Lets us not repeat this mistake with steering tag. The driver should alwa=
ys be
> involved in this stuff, if you want it to work with DPDK then go through =
the kernel
> driver that DPDK is running on top of (VFIO or RDMA)
>=20

This RFC is only about acquiring the steering tag from the ACPI _DSM, which=
 the DPDK
user space driver will set in the queue context of the device it manages.
Setting of the steering tag part happens in the DPDK device driver.
Are you suggesting that I should instead pass a CPU and a cache ID to VFIO =
and let VFIO
decide what's right for the application?


--wathsala


