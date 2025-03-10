Return-Path: <linux-pci+bounces-23265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD251A58B83
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 06:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF623AA5B4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 05:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D91B6CF1;
	Mon, 10 Mar 2025 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WV3eFLqs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FB23A0;
	Mon, 10 Mar 2025 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583262; cv=fail; b=azDEF+Ki6iVVIM3pvlHiTzdVf2C51D0urKO3ej+BcDuiCxcv55dIBWSEdQz7tBmzeMwIYLvCe4exfHmiQelBTlUe4urbk10v0P8cV3BKRyqYyKL0WpCiU4Ucw8sNLp8369Q7L9GTDYFt7NXrtHL9/Atu73ofJWy7J7eZmNh4nHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583262; c=relaxed/simple;
	bh=LEkIHZnvlmKXPCuZp3T/5Ty70dBg9ZGAEvgR9G2LyNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jsvk3wyYGbF2KV8YtGAhJgyRS8/qpu+11xiFqj2BFao33USb+YdcJsJ/kJ+XoD3k1KyKM+TvjHzzPyIm2eG6SmrfHLkdPJv5rNO8EuHzfC7GB47nvpcapuUi4k8I6xVYm0NCw+Va7dr0qeCzc/PSzlwOqtK94WfoScmMeNCEdus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WV3eFLqs; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGrTkJrXzZVSYlYssQK6Nq+hPfmnZei4UzYZnt2bBVq9H+A5lh4mzIx0jT17mpTuPOwNwkgJCoLl7b9zVv3jS/xI2cHKnpM4ZVSNfhkBV5a+bQ6gX2XSw48sW9TDHb4HsMyLWJxW6fa8752ayL24yyQZaluoTT3UsaO4qkB9EgS3EiDofQfYHu2Ts81xpkQpzhQhcVbLZKfAV/jQgQ5UJ4S2a6sLY115fFF3tzNZv8LU7KLLp/BWJzUukkgStK06k+V24iUIvgPsbOaZZNJNQqyhlIU/rrKEiFT9u9pL0j/5p9Sqwyv6ZrDsPJobJyZziOW8SRnycWiUXqQ76zTJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9PT+RMDenLoBlWQPX08g8ZNZ2oaA3pnm/fM9Ct9NqI=;
 b=qnhhQ4DYZTCrbrr2knXzQzmvZ6hMVR9RvvKIZ5pFQ/8zO0BK6QwAQjl2rtUniUKMbGHOln/seFuJLp/RFVKdXRKuQGNvDdbLW5TvDGeiLfXOQ1uW4jltNEGRxJmRPYnd0TltYOLWBuDmTI2PQ4tPaTyDsXBjBtV0GrNYGEYNIgi32OCUxIJR8YkY7e+mQYfAFM2IBB0tdE/JaeL5ZQQX1I06NwiYYraGuyFM0vbky51Y3Ux55FDEABwtd3Pn6JRAsgTVpv0sKwSSbLKrmKnyPtWoj/D6qTJ1wZ7Bc9xXoYf/93R4e4y3Xvv3Uk/XXkCe7UehFPjeDPjVzP1U2+z//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9PT+RMDenLoBlWQPX08g8ZNZ2oaA3pnm/fM9Ct9NqI=;
 b=WV3eFLqsDOeekTDly0cuG2a/tmdb5o3YxOr9QWTHUT0l3on07NLnrvHc0YyoIJxTYRNkJjJ3EqKMMbMIqPMocIVUWyst68JcRUrrcvbSEQZeWcYkyshjiQtI4k5eRWuSYDpSu/G8y4PQOSGZrYc1MyUf3LEfyWULUm1Xiv6cASM=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 05:07:37 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 05:07:37 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v5 0/3] Add support for Versal Net CPM5N Root Port
 controller
Thread-Topic: [PATCH v5 0/3] Add support for Versal Net CPM5N Root Port
 controller
Thread-Index: AQHbhtPXKa7E7DFDf0uHK+zJj734orNrJEMAgADChvA=
Date: Mon, 10 Mar 2025 05:07:37 +0000
Message-ID:
 <SN7PR12MB72013FC0623E0C20FF1638078BD62@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
 <20250309173032.GA2564088@rocinante>
In-Reply-To: <20250309173032.GA2564088@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b2cc4bae-96f5-4754-94af-7f0858c10350;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-10T05:06:45Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|IA1PR12MB8555:EE_
x-ms-office365-filtering-correlation-id: 86bc1960-fcb8-4fcc-51a3-08dd5f9179be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?pPtYyQD4z/1KM2DiogvrzQ7H6ojZPxbghuGMFLly3deSG7QuS448wLToOV?=
 =?iso-8859-2?Q?2V2rbOdGUZ3dN1CgcMoCjq8G9LYPmcBPZi8iyWDrejql1IK3jx6xdczgSD?=
 =?iso-8859-2?Q?dnTNUONU703v0PmFUi65jUhFbCS2cFu0jglMPDqPJTpeAK2lsRgmKRr0EM?=
 =?iso-8859-2?Q?k/+q0sezQ+xhFkIRd25H38YjOIRQ+vURjGIQQlDy0fNIezen0MMM+OXbtk?=
 =?iso-8859-2?Q?pd9pj0yjwKI5WYXJKFjBkidMWhye7sgK+movm7IIj1kBYXv+9ErGq/70rL?=
 =?iso-8859-2?Q?mnYFsWvhmddeIWALhtGn4can7j3q9e+5sKGOsd9JcYGBXMwRe9AQRoO25m?=
 =?iso-8859-2?Q?LguJnPcNGvCaQaudVEZBCohdepG9QbIkAeEoH0092wFHzteaYXWk+Zqf6K?=
 =?iso-8859-2?Q?ljT9tZ52izx4MUg2ei3PPlk1YzXAXWMNWKG6nLWue+AWo8+RJsRxuS766P?=
 =?iso-8859-2?Q?wlz1TstL9CFiF0J7kDSh2exyOT2mnwSIORrwdbeNjmFMkgSFeE3iTGhFaZ?=
 =?iso-8859-2?Q?eB3q+Bx15EV1c2h2ax0W/Wqee16UesdnzOPuCO0TQd77IsSyx0Gfz/ixmS?=
 =?iso-8859-2?Q?Xl3Z72/WJkbKAeoGWHWYid+k9Ek3QURf/djaMfEebmeflkaSTTHl6S4RxG?=
 =?iso-8859-2?Q?a2SFJy0pUvyV8w+dqpEW+8FN/wNL0Pr/NZaOeyysNPlWXVvgDNDhj+5Wpo?=
 =?iso-8859-2?Q?kao0km1/2X3Onz4ZoLvn0tso0090CSpBfY0l+Y/VMqbyOa08/2iT/7TXxx?=
 =?iso-8859-2?Q?iHxlt1nh6/eQQiJbXgggWf7Wb0aWDmkNendQ4EQBV4ut82n4pL1LniGXPq?=
 =?iso-8859-2?Q?rblN4Uv27PTbn0LVzNcVzOdNA5bh05ZXu2Egh9ob9iPP0f/oEDDCwWnceQ?=
 =?iso-8859-2?Q?HcFthj0WA6xPNygOQxkbEKTAP0ABWJQD+xhV7LHihQQxGfKqAgMRxOe6Cl?=
 =?iso-8859-2?Q?qzPLn78ABTP/J1kaaQu9gPT5nN1t18WJR0zsyRfXia7jHIZYCotLGW+Mcm?=
 =?iso-8859-2?Q?/mBE7MXzd0JCbvZjvKj/7QPRO+ZMfoQMdpMn35dNmaPk/vixw4aDva86Dy?=
 =?iso-8859-2?Q?Bxut6auAhni0Y+AKURDRUbpmVD6J8zQbRZn1P38XQSOkUmWJ7r5aRUVqO+?=
 =?iso-8859-2?Q?VOf8Gk5/ITm0FD4I68jB3tdyf2bx7lirQw4Y797P0TMR58tVcCLiCZDSYD?=
 =?iso-8859-2?Q?igQU/N2hEw99Is8VNnlIwaWrSJoGofYkfXb1jLFgyddu+/pRIgTUqsJvCM?=
 =?iso-8859-2?Q?WAxo/9doZuhzSt3C87VdtZam0T0p6taIQ98tXEPNsbCdKQr4kXiwciIYb/?=
 =?iso-8859-2?Q?/ObnJLkrozKLUogvXOBmKLuwdsMNpfRV+/ZaibCqdr8Kok/bnazYpPVM7E?=
 =?iso-8859-2?Q?QLMS1QLQOpag4Be3R3UEVUl4NEh19jMGBTfeT4WTATQ98I1w6X7tWuDPsS?=
 =?iso-8859-2?Q?AQ4xwnH4KHsWlSwi+qjfNLcmFwRuf8RA2KoDVYVqsiEvlu8o+/jv10GMDX?=
 =?iso-8859-2?Q?INF7qgrb3cuMu8ROFy/PxR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?5NKQAZ6bNakY8PC9g/aSzEXpdFPgmoAjKg2foEVBrYH+kABkdYweHX4ils?=
 =?iso-8859-2?Q?cj9f4xTiNrkSeGTtMIMxk6yyAas/HzpWikOBujP8+LwpM3Gm4kZQ3NIMXT?=
 =?iso-8859-2?Q?qtP/rRnKcf02G+Vtlq68DXw9uaBE68VqJUd2arP48PyxXUwT11sYq7pzaX?=
 =?iso-8859-2?Q?9EoFe+vAV2OvvtGMhhKUs/eK2tMnRRi8lRjq6zkpiXYj+dkdHgJtaZWxBd?=
 =?iso-8859-2?Q?iJEduX0MhRKlVrPGZPKGAfrUOibpAhel2DGVsW8rKiwjbDo4d+Gs9iIxpe?=
 =?iso-8859-2?Q?4UelT4OMIcHFhPAJ2voo8Xk+OAXYqvssy/1UVmIAle6YTRmYqR3tIdBKDM?=
 =?iso-8859-2?Q?+BO8U8uT/emfHl6MMvfOS0U8qTrIFJO/RAGgOOLuCqozq1VmxqA2yzH3uC?=
 =?iso-8859-2?Q?ctBGm1Yuer7xPSj+BcL4gG9W52DbvfP3gnN3BYZV2mRBqYiAiBuWfEjN5x?=
 =?iso-8859-2?Q?kvjXVvbqrWCj92AIXsjCRtl6VaLFWtWou2V/nJvDQDJMB+J8ujYwQR1fmS?=
 =?iso-8859-2?Q?wV1UfOzT96SGcGkRvX52tEfHZ0Rh1sqaGor0KF/IVZh83FLSrnOXNzn1Zr?=
 =?iso-8859-2?Q?e3xt6fHJay6hYZF9YNT3/r5W0r8KYyqDxlxIndJatkQFWkvYvJ4+3B0SPR?=
 =?iso-8859-2?Q?V+RLLGJ+rtUC+9RNJlhUMYpDF1gXl7tilka2LIORtOrLnxMtRt0FxTTqgD?=
 =?iso-8859-2?Q?8P0eJ7W1e70JeKOGklyeUBwhHjvYqo+H445TKYY2hG5mlIBqe/2oHq4UM9?=
 =?iso-8859-2?Q?P5EYzG17gAkTU9zKGQmxKI+9vF5CGIErc4bBl6gxGrC1Np6I3p64ClTbba?=
 =?iso-8859-2?Q?+TWC0lPON2rfh5vhMKjaOyUeJK9cXuSfhSxdhdfkwcfP69ips2/SeXpS8S?=
 =?iso-8859-2?Q?+DMQ4XvNeiDS99sU2Y5SOkKCJi7A0GlJuAzHPaih9f5uCVwV0EivWAlij9?=
 =?iso-8859-2?Q?0f75YEt2ngEVKq4bFnMby6T1CSRuQvXI5nPYgwsnD8JcDs9JUJZCxfSfFx?=
 =?iso-8859-2?Q?jhpNkUTQz86hHquhb+B6PgWNN998Btc1bmiiZ4oxN1qijnmbpKOETeLMwI?=
 =?iso-8859-2?Q?LTf2ap9CGiGcLlyT8NuwrPQFpcQtUpsFeJbew4pkIbDGuIgDvUULCHpjSC?=
 =?iso-8859-2?Q?1BL6We/bRVIKrdkxc7DQuMN7yO3Rea3M3qQlKoTFIGd33dGW2oiPiZkoRM?=
 =?iso-8859-2?Q?XkahoK33Nk4TM4rtmZuk2U84CGhzx34403zVEUgi8zuNsHGQlCYEc19ShO?=
 =?iso-8859-2?Q?p/H0AvTIkKa8VeYakpnMFYLBOH5DAymAcRQbkkOjSZBQq3vvebDk6Q6Ise?=
 =?iso-8859-2?Q?Eyux+a2aYvvkIZq2oVVIeWfpll4re1OSDYKfo8IBQa7NGiI04VdbMF2YPe?=
 =?iso-8859-2?Q?x0z9gQxX9hH7BeWtu1lM+MprQ8UK2cbzURmtK9Hfufja+df0oZCmK/8Q2B?=
 =?iso-8859-2?Q?AGImmS5XEvHzdzi3X+k4M+KkHXFpUdrKnF6d9PnRzhGYN8kwyJ5q8tRnV6?=
 =?iso-8859-2?Q?HGBgHeroZsfDrlGdN1vaILFyzT7X5aTGMZNGcJ5bcxDR+vw+64c4jRcSQ9?=
 =?iso-8859-2?Q?6hn4zaywxwjc8B9uQYcxeOQfNhHBj7yJFOWDyZuS7DbO0/P2MZI1oYhHVr?=
 =?iso-8859-2?Q?bkOo1Adj5R0sY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bc1960-fcb8-4fcc-51a3-08dd5f9179be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 05:07:37.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: De15zCjsQMblNCRVMZpvXtegzxiEVx1eHmXBIO0WwfbN6qimQTwTTre0KP9UGunJuPdrf9vcup8iklAAJXUceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

[AMD Official Use Only - AMD Internal Distribution Only]

Thank you, Krzysztof for applying patches.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Krzysztof Wilczy=F1ski <kw@linux.com>
> Sent: Sunday, March 9, 2025 11:01 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH v5 0/3] Add support for Versal Net CPM5N Root Port
> controller
>
> Hello,
>
> > Add support for Versal Net CPM5NC Root Port controller 0.
> >
> > The Versal-Net ACAP devices include CCIX-PCIe Module (CPM). The
> > integrated block for CPM5NC along with the integrated bridge can
> > function as PCIe Root Port.
> >
> > Bridge error in Versal-Net CPM5NC are handled using Versal-Net CPM5N
> > specific interrupt line & there is no support for legacy interrupts.
>
> Applied to controller/xilinx-cpm, thank you!
>
>       Krzysztof

