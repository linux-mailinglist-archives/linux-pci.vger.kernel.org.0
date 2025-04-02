Return-Path: <linux-pci+bounces-25121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B6A788ED
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4AD16BEB6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52770232369;
	Wed,  2 Apr 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HHYuyymX"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24302233153;
	Wed,  2 Apr 2025 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579612; cv=fail; b=cH3LZkhLNPaiq+dbTqLnuC1i/ejJk6KxqunJ1QXHvuc/OeM7sazCsaIybrp6Qxo82WU3fv8ToBD/iTwFhTwVL/mn4/8GcdeWWbNr9OG/IO62W37Hau4pzcOyGG45YDpCztq8EN9cwci0XCpw8NjAbsJtvK3mljrqYd5jKyQ0PWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579612; c=relaxed/simple;
	bh=VGoIT+B06VPSuqBqvMGuMm1fjC8I9QkuU48VK1A7PGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LA9EI27S2yL2/nnc9i3JE8cqFVavMZTBnEJiJYyDNc3agCWfwas0GICXbn+eA7o/xF/I5nQ53qIvBKUxTRe7jjwF5GlU+valrGc13CNB612n9PmpmUWO462A0mxkOt/05S8IdP3pe7E5yw3ivyFIYUt9dtj3iXYT3qq8zd6ti68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HHYuyymX; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdVi8m2cESXmOePm9aJ3GBijRVEGIx/xZlFWdK4dxYMeb/bsL+ej28EgN6kDcoz5YYlXok15WdC5IekHL4bDvKotomoXKzfrOOjyhPDwTZGs/3ZTAMvQ5s9sGKRmtvkw2p9ClcBTNfolXc1QrosQ95PSmF1kxHLNDQxB6RG6hU5qnzcVkO9kv1TZEnED5ZEWwkpeWVx2jKqDWPxTdcODJgQaw1Y5sAHJWuvOiDlKwQZhf14v6mVBkVBWnNPwUS5eMr5ykHlrWz9GH9hOAs4gsqteYNnIZy4HdLd8Ngi3fHfD/4z5bMXHSqsATEweeWgR35EUSkS6ekIo8pWuD5ARLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGoIT+B06VPSuqBqvMGuMm1fjC8I9QkuU48VK1A7PGI=;
 b=QRnnwf97j2efQ1BT4CPcloABB/1J0AbT4O0STAk1zpHA5gi1ZPCDM01lHKGnZ39zCG5Uk+ccyqgUhCQ4gIMUleDpxmw3slViK33OM/IkeTSGoUTK18DrIqXfvGQokAwduGFyWrMEYEw67c2KlsojS2t69YVzC6eJDcAPBAT5/pRbeN65CQXMTHFzLsZZnRVHDri8JE5ANJ6TdVklfPuFIfYi/fHZKGvMYc5jnjEN5GuzFYIWRkkjuM2nS2kLpzYeHeqrs7qnKkWuEsNSIkRWUkQ+/hC7vdZR6yYYIrOEdQq8dApRR2jeEz88MryFsqskuFRpxpFKA+skCsWd3mzUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGoIT+B06VPSuqBqvMGuMm1fjC8I9QkuU48VK1A7PGI=;
 b=HHYuyymXI/j9e8kRo3+mq6HONPBkTK0Zu1AbMSShEUfZZpMF86IWWjEdRXJzfPgHg4wiM4HtpoJJ7OGRCqae27Hqiny5P+dfEpPZ9Ny9+fMcxynyfB+jOAwtW7Hp9xCtXhGqRjOIs9tUpD7zDZIJIsy0Qvv2OjVSn2xiq4LbalbKRv8g1iVwDwk2FbPdVnCqEUKqm+U21MPEXMrOEbXZ0PqIDPgk5OK+sf5kChBigsw1L1QECR7yytz30jxQwpem6x1JS68xi9h9Lo8La7LCpcobQlE4RDV3EjDdImbxYo5Qs/3yIp9xL+sb8ioVmmGMtthSVTRnbNknxyy8TzrzZQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB10775.eurprd04.prod.outlook.com (2603:10a6:150:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 07:40:06 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 07:40:06 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Thread-Topic: [PATCH v3 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Thread-Index: AQHbn44AkYR6+WUsnEWQ4bYQc1DMNLOP9AWAgAAIS5A=
Date: Wed, 2 Apr 2025 07:40:06 +0000
Message-ID:
 <AS8PR04MB8676D14C8DB1FBE6B034CEE28CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-3-hongxing.zhu@nxp.com>
 <fatfobrf53l3ngps3rl67gayhnlsqncgd2tabgcspac3n3o4xt@a4yrmtvaitai>
In-Reply-To: <fatfobrf53l3ngps3rl67gayhnlsqncgd2tabgcspac3n3o4xt@a4yrmtvaitai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB10775:EE_
x-ms-office365-filtering-correlation-id: 682f8fbd-2caf-4731-c7b3-08dd71b99659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnFtQ252anMxWE5QaDVtZmtvQk9iMGd1Wk0vYWNSRmMrbHBxTnBKYnI5U0NF?=
 =?utf-8?B?MGdXa2FocmJhUkZRcXErTHJMcUJEWmIwenhxa21yOUs3Y3phK2t4RDV1NVBH?=
 =?utf-8?B?Qy9oQUllTFEvWkovQy92dU8xaFU4Y2ZuTGhSUmhUbU5LcEtJcUVibXNqNGxw?=
 =?utf-8?B?MmY3VzlFa1JvZWNCVStFaGt3UWU5UTF3c1JwQ3U3RzIya1NhY2VVV1d1QW9P?=
 =?utf-8?B?LzRtRWt0UklIZzRCcnlCYU9jdG84aFRhc1NaMFhJR0g3TXFVcXF3RlBMYStu?=
 =?utf-8?B?a1NLd2xpZmo5Q20veUd1cXJPR0ExLy9jNnFLckl4RTBlMjBPSUdidkdTSE5t?=
 =?utf-8?B?d3MxUDRmQjRjMkYvNnB5RWd3UVo5WTFrWlNlY1krYkJXZW13aTlPQ2V0Y2Jn?=
 =?utf-8?B?cVRaVHdnaVJhWWlROXhscDUrN1JPMnEvdktkOE5IMUVHZGl0OE0wMXRTSUxV?=
 =?utf-8?B?bkxlKzFWbDNVeEJhdEdoeGd6RjNmWVJRcjdaUlJZa3YzMjdWNXN2cTlJQ2x2?=
 =?utf-8?B?U3dSSHh2ci92WUJwazYrY2J6OGkxN3JZNHQzZXMxcjNpUXdha2Q2aVRXdlJX?=
 =?utf-8?B?OUNCeVZkRGk3MlBMeDRaVnpYbTZtR3NLbEFmc0RnNFpiVlVibnZJWlJ6OVpG?=
 =?utf-8?B?NEJSelV4cVowdjI1V29uTndPSStlb0hDOWovWHVxVzRNU28wNWpaT3U0TmEr?=
 =?utf-8?B?dmZVMm5Ba0FuZ1psNXkrOHNLU1Z4WVpxRTVtTmhncWppcHc3MWJLMjA5OXY5?=
 =?utf-8?B?RXhFS3E4a0FPNHZJdXFEODgyTnVQaXBXVzJIYzhzM2E1NWl0SHhxRHlyU2dU?=
 =?utf-8?B?RTdZdWltTXR3WjY0b1AyMXR4QUM2U1VxTm5PcHlGQ0tCUHhMUlErK3JCUXZz?=
 =?utf-8?B?akdMUWdmMVR5OFh4Q2pCYTIvbCticXZ1WWNCVU1RRUYyYTdER1RVL0hFM0Ro?=
 =?utf-8?B?Q21qaW1xTjUyT0lMZlpvdXZSQldRd1g1ZUdzTzhCc3pJbmwydHJ4NDZuLzFD?=
 =?utf-8?B?a1dqVWhmOTByaVluWXNObXdZdmNBQ0VDREJHcnFvazQ4Z2VpRzBzK3huMnll?=
 =?utf-8?B?TklNZFgzWmk3dWFnK1g4aFEwK1oxWUpsSTFISy9RV0ZDRk40ZytTaXI3VUl1?=
 =?utf-8?B?Mmg1VUZQYmZyYkphZnR5UVEwcE5CS2hyeUpSakpNZzBBalB4dkhpSGxSODdJ?=
 =?utf-8?B?NUtVcmZibzFTMVlaNC9LMWRFaHM0RGxtS3JYajNMTlhrK00vT1p5VDJBNnlE?=
 =?utf-8?B?bzJESGlyZEVDbUhaSEplUUovYTlYR2hPSW5jSVJtd1hnRmtybUZqRWNkSFR6?=
 =?utf-8?B?Q2ZBZXVKQXM3cWRGOFZNR3YvcXdsOTBWWUNHNmhYbkZkQ3VDMHkyYW93a3Fi?=
 =?utf-8?B?QkZnV1lIVVZ2VUR6aDFSSEdmK1p0emJBUDVmek94WUNBMDBlVnBzRjh3S1ls?=
 =?utf-8?B?Q0dLbUNtTm0vQ0Y3M3owWmJEMXZnRU15eVE2MGQ0WTlTVHAzcThHM0tHQXRZ?=
 =?utf-8?B?U2JlUWxzdENZbWR1QllBVFlMY0xnRXY0VWl2OVd3b2xYWEZ2UllEeDBpV0lP?=
 =?utf-8?B?VS9rT3piZmNsQWd3OEVsUnNERkYwbkk3QW1pR0NKZFpONTd0MXdZVXJDNHh5?=
 =?utf-8?B?WHVndGVvd2pmdEVHQk1JTjMvV1oxRHVIS2Fhc01DNGpvZkZWZnRGNWtvelZY?=
 =?utf-8?B?ME10MW9SN1JTRlUwWnhKdUNOMVkwWmJ0MVl4N2JQR20vZHhQeVZ6NTJ0eFA0?=
 =?utf-8?B?UnZMQS9mWHlnNnQzTzk2MzNQd25yTjFzb21yUnNnMDlMM0RaekhIbU5JRnZZ?=
 =?utf-8?B?Zit5UGFmNHVvdmhReVRkS1lZNDkzYkRTNmwra1R1WmhhNmxYbEppOWNUaEh6?=
 =?utf-8?B?dkNJVnR4aXVVaVNNVzJ4dHg3SGRjRGxHUDBnNTZkanF1aHdpSHNZaHFzVFJJ?=
 =?utf-8?B?cVNyOXhpTlY5NFkrOEExTlhybVJvWUtldW9TdXdNNFBEVlhnakZ5ckdlLy9n?=
 =?utf-8?B?cDBwTkdYdjFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVpEZTRWYldsc3Z1RkJDZVZvcTJIRzZEUVNKVXMzT0NhWWFDZ3lWb24vZ0JC?=
 =?utf-8?B?LzJWNFNOaGFTYzlmcjZzQ0RZMk9KNmJ6bW4wS3AzV05UZXR0NDdXdjdQVWZU?=
 =?utf-8?B?cE1TNHBRMnl3NFNQMW04bTJFcjdPTmdpTmdJd2tMT0tRTWI0b01QWFo4OE84?=
 =?utf-8?B?TmYrTWJKQjlJTkJzQXMxT1YzYXpDdFl4UDlEUXVYUWVwU29BUDRUZzAyeWEr?=
 =?utf-8?B?NlZNNzhaN0ZNWVphMnZHN1JVMmhseG1kQ2dZb25aZHFiS002VDByOTQ4Vys5?=
 =?utf-8?B?aTVoTWd0UStFSTZpMzZkeC9JZ2tHd2ZkeGxWUDByc0ovRENjTE9kLzFyUXVQ?=
 =?utf-8?B?OHEweG02Z29lQzdmeGZaSGlKTkRhMlA2SUtEOU5YdWdKcGRFU3poTmwyNUFv?=
 =?utf-8?B?d2ptSGNwVVZSQURSaUl1RURPSll4dEltOFhPRldUNW5RblZLdzdVNkt6ZVU2?=
 =?utf-8?B?cE1UYlhWZDNKcTdaUzlCTGVPUnFHUHE1Ym5UWG5QRDJobmowVHpUWUk2WG1K?=
 =?utf-8?B?aXViMm9BZkpZL0x2akpDSzh6SGg5NE0yVngrTGJzTDV0aEYzUFFsS1Zib0xj?=
 =?utf-8?B?ek1tbHZaVzBsYUNaZWdVdXh6UktyYXljR1BTa3grdHBmQUNGODlYb0Q2cjVn?=
 =?utf-8?B?UGtwS2wrVU1rZ0tyQ3JRRnVJZTVyQUt6dGZpM2c4VU1OamRHWXBSN1A4YitT?=
 =?utf-8?B?aWJhb3pGM1hqQkl4SGdmejE4VHFhVUlZQWE5NGRDQ2FwNTBYZXIwa1QxbFFC?=
 =?utf-8?B?ZUN5d2RMYTI1NjVuYUYyRDc2ditaenptNFMzV2NKKzVpd1grcnM5cHcycUtB?=
 =?utf-8?B?Q3J6YTZhTlBHNkNmc0dYY2NjOTVvaFlsWEdPMGZ2U3dDK3VGVENVWlBtcGlt?=
 =?utf-8?B?bG5uUlgwZlJLWGUySGMvVTZ4dkFtd1F5WWFZRHVjL2twOXV3L2p2OUpuMzMx?=
 =?utf-8?B?Mm1NTE1sVHA3SmhMZmZiTjArb1NmNzdUUnRlQmw4cXJ4L0phbFlHRDZsZzdw?=
 =?utf-8?B?SDRUUExJcml6U1UrU3FUTHBVQ2lOcWovdi95ZHhQMy9qYUV6UG1zeXZRUys1?=
 =?utf-8?B?d3JRYzZIMGZUdGM5djVXVDZJQjAyUFBKS0N5akd6SlFQZlZ0UkZ1YmRXNFZI?=
 =?utf-8?B?ZkRIekVoRTR0VVMvdzZqZ28xZHRzL1drVVdnaTRzNjdJTStjNm03SGxZTkdP?=
 =?utf-8?B?MXhDL0VqV3NTOSs0OFRYYlZaY0xIK0xGWVEyOCs0YlRFUzNwMkhIQ3ZNL2Nn?=
 =?utf-8?B?MzZWcmVIYXUwMTl1RXlPRXRzQitJS3ovQk9MekcyMGhUY3NtWVRXZWVvWVc3?=
 =?utf-8?B?bmRvVE5HN0VhcnVSWmNFNW1RT2J4aFhkYnIxZkwwVHBFcE9HK1lpdDlaNVk3?=
 =?utf-8?B?ZktnZEpqT05VeEVVTHBPSVppeE5USWlabWdTTTJ2cXBUdkRnUW1YUWlOZDlJ?=
 =?utf-8?B?MGZBVGlObUt3V1Z4dzEyNzlpbE51ckg4Q3hsbzdkb2pveTQ5YVVhbnFkUnc5?=
 =?utf-8?B?YlhDbWRHeGtXOGthK05EbEhXNUQ0Z0RPMnp5N0ZHMzBkVmkzd0JaaWVxVndM?=
 =?utf-8?B?VjVHS1hiYUVTc3dtOUttNGhCUUtpVXhoSmdkV3p4RTk0YzFlUExnMVlzcGxG?=
 =?utf-8?B?RksxQmU1Q0g4QXc2bEd5SWROUW9wMGNJMGttd1NZVVlEWnIzYzZlN3NsdEhY?=
 =?utf-8?B?eko3ZkJubFAyUkRqR292VVJhTzVydXVnZnJab212R09EY1BJelVCakxFOUZu?=
 =?utf-8?B?cU5lNGk5R1JiNUN3bnJkSEhqWWppVUhCK0dDREVIY1EzRmNYY3paMm5aaTJ4?=
 =?utf-8?B?SnR0UjhielFHMTlCTkF2dUxQeEprM0xtVEtJWHN6bDhrWnZmT2JmZWV2OWZl?=
 =?utf-8?B?ck5DOFdrUTlZVk4rcnVSYVRMK1p1anhrR3ZtWHVFUmxIWlBNNm9rZXNCVVZw?=
 =?utf-8?B?MEZ0UDVSVjdvYU4rUDc3NW1XMkU2dGNJY05JTi9kaEgvcVNPZXNYRHo0cEdQ?=
 =?utf-8?B?OUxpZFBhTnZNUkZEaVk5UXo5cGlubk9qZWR0TmNjMFhBM3lYdmRja0RudGFv?=
 =?utf-8?B?cVZEdTU0OVdhdkJTMjJMbENmblAvNDhRazFMZ09EVGN0MXplbEVlMlFDa3BU?=
 =?utf-8?Q?4tZNHGVxlaGgCyz7uXWvBDNGj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682f8fbd-2caf-4731-c7b3-08dd71b99659
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 07:40:06.1581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NeButnPn9QtA/dk9qaiGkuSMXDCixGiesxVVXQ/SyIqG76xEGVcSMBVfx+2jeCVEu1gdaFWcdq3QPEH7TPFhng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10775

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0NOac
iDLml6UgMTQ6MzYNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29t
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzZdIFBDSTogaW14NjogVG9nZ2xl
IHRoZSBjb2xkIHJlc2V0IGZvciBpLk1YOTUgUENJZQ0KPiANCj4gT24gRnJpLCBNYXIgMjgsIDIw
MjUgYXQgMTE6MDI6MDlBTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gQWRkIHRoZSBj
b2xkIHJlc2V0IHRvZ2dsZSBmb3IgaS5NWDk1IFBDSWUgdG8gYWxpZ24gUEhZJ3MgcG93ZXIgdXAg
c2VxdWVuY3kuDQo+IA0KPiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICdjb2xkJyByZXNldD8gSXMgaXQg
J2NvcmUnIHJlc2V0PyBJIHNlZSBib3RoIHRlcm1pbm9sb2dpZXMNCj4gdXNlZCBpbiB0aGUgY29k
ZS4NCj4gDQpSZWdhcmRpbmcgbXkgdW5kZXJzdGFuZHMsIHRoZSBjb2xkIHJlc2V0IGlzIG9uZSBy
ZXNldCBjYXRlZ29yeSBvZiB0aGUgY29yZSByZXNldC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDQyDQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0K
PiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4IDU3
YWE3NzcyMzFhZS4uNjA1MWIzYjU5MjhmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTcxLDYgKzcxLDkgQEANCj4gPiAgI2RlZmluZSBJTVg5
NV9TSURfTUFTSwkJCQlHRU5NQVNLKDUsIDApDQo+ID4gICNkZWZpbmUgSU1YOTVfTUFYX0xVVAkJ
CQkzMg0KPiA+DQo+ID4gKyNkZWZpbmUgSU1YOTVfUENJRV9SU1RfQ1RSTAkJCTB4MzAxMA0KPiA+
ICsjZGVmaW5lIElNWDk1X1BDSUVfQ09MRF9SU1QJCQlCSVQoMCkNCj4gPiArDQo+ID4gICNkZWZp
bmUgdG9faW14X3BjaWUoeCkJZGV2X2dldF9kcnZkYXRhKCh4KS0+ZGV2KQ0KPiA+DQo+ID4gIGVu
dW0gaW14X3BjaWVfdmFyaWFudHMgew0KPiA+IEBAIC03NzMsNiArNzc2LDQzIEBAIHN0YXRpYyBp
bnQgaW14N2RfcGNpZV9jb3JlX3Jlc2V0KHN0cnVjdCBpbXhfcGNpZQ0KPiAqaW14X3BjaWUsIGJv
b2wgYXNzZXJ0KQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50
IGlteDk1X3BjaWVfY29yZV9yZXNldChzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llLCBib29sDQo+
ID4gK2Fzc2VydCkgew0KPiA+ICsJdTMyIHZhbDsNCj4gPiArDQo+ID4gKwlpZiAoYXNzZXJ0KSB7
DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBGcm9tIGkuTVg5NSBQQ0llIFBIWSBwZXJzcGVjdGl2ZSwg
dGhlIENPTEQgcmVzZXQgdG9nZ2xlDQo+ID4gKwkJICogc2hvdWxkIGJlIGNvbXBsZXRlIGFmdGVy
IHBvd2VyLXVwIGJ5IHRoZSBmb2xsb3dpbmcgc2VxdWVuY2UuDQo+ID4gKwkJICogICAgICAgICAg
ICAgICAgID4gMTB1cyhhdCBwb3dlci11cCkNCj4gPiArCQkgKiAgICAgICAgICAgICAgICAgPiAx
MG5zKHdhcm0gcmVzZXQpDQo+ID4gKwkJICogICAgICAgICAgICAgICB8PC0tLS0tLS0tLS0tLT58
DQo+ID4gKwkJICogICAgICAgICAgICAgICAgX19fX19fX19fX19fX18NCj4gPiArCQkgKiBwaHlf
cmVzZXQgX19fXy8gICAgICAgICAgICAgIFxfX19fX19fX19fX19fX19fDQo+ID4gKwkJICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fX19fX19fX19fXw0KPiA+ICsJCSAqIHJl
Zl9jbGtfZW5fX19fX19fX19fX19fX19fX19fX19fXy8NCj4gPiArCQkgKiBUb2dnbGUgQ09MRCBy
ZXNldCBhbGlnbmVkIHdpdGggdGhpcyBzZXF1ZW5jZSBmb3IgaS5NWDk1IFBDSWUuDQo+ID4gKwkJ
ICovDQo+ID4gKwkJcmVnbWFwX3NldF9iaXRzKGlteF9wY2llLT5pb211eGNfZ3ByLCBJTVg5NV9Q
Q0lFX1JTVF9DVFJMLA0KPiA+ICsJCQkJSU1YOTVfUENJRV9DT0xEX1JTVCk7DQo+IA0KPiBJcyB0
aGlzIHJlYWxseSBDT0xEIHJlc2V0PyBPciBDT1JFIHJlc2V0Pw0KQ29sZCByZXNldCBpcyBvbmUg
cmVzZXQgdHlwZSBvZiBjb3JlIHJlc2V0IHJlZmVyIHRvIG15IHVuZGVyc3RhbmQuDQo+IA0KPiA+
ICsJCS8qDQo+ID4gKwkJICogVG8gbWFrZSBzdXJlIGRlbGF5IGVub3VnaCB0aW1lLCBkbyByZWdt
YXBfcmVhZF9ieXBhc3NlZA0KPiA+ICsJCSAqIGJlZm9yZSB1ZGVsYXkoKS4gU2luY2UgdWRlbGF5
KCkgbWlnaHQgbm90IHVzZSBNTUlPLCBhbmQgY2F1c2UNCj4gPiArCQkgKiBkZWxheSB0aW1lIGxl
c3MgdGhhbiBzZXR0aW5nIHZhbHVlLg0KPiA+ICsJCSAqLw0KPiANCj4gVGhpcyBjb21tZW50IGNv
dWxkIGJlIHJlcGhyYXNlZDoNCj4gDQo+IAkJLyoNCj4gCQkgKiBNYWtlIHN1cmUgdGhlIHdyaXRl
IHRvIElNWDk1X1BDSUVfUlNUX0NUUkwgaXMgZmx1c2hlZCB0byB0aGUNCj4gCQkgKiBoYXJkd2Fy
ZSBieSBkb2luZyBhIHJlYWQuIE90aGVyd2lzZSwgdGhlcmUgaXMgbm8gZ3VhcmFudGVlDQo+IAkJ
ICogdGhhdCB0aGUgd3JpdGUgaGFzIHJlYWNoZWQgdGhlIGhhcmR3YXJlIGJlZm9yZSB1ZGVsYXko
KS4NCj4gCQkgKi8NCj4gDQpPa2F5DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiAt
IE1hbmkNCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7g
rprgrr/grrXgrq7gr40NCg==

