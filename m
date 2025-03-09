Return-Path: <linux-pci+bounces-23228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25221A58286
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F47A534B
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5F18A92D;
	Sun,  9 Mar 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Uw09ZuRg"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456FD13665A;
	Sun,  9 Mar 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511153; cv=fail; b=f6O1clGqdCKHmMKYCWQRWRfTfR6BiouFcKEKK31RRqPds0EtXz1n2qVuqPamxr7LTDqGiq18YGk+2aChksmXD9Umxm4HUWxZ1+JSXjKnkPp9X7/Y1M8AsYn1qGs0tYK8lfKJaVZARc4/4ktZt27HPX4EYXXISMZFGIZ/9z75EXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511153; c=relaxed/simple;
	bh=rTBDk+WKXNbpXS4eS7mc8fBL2pzATrrHzKwjfsSy+lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mMhluszT+AzsToP+NW5vUMRf8SsT3tl9obwcNm1L1Hg5rVkmllEwKoBR7t1H/jfyLLwVkkkxhaolLUrZ9+e++SFl/Dsfhu3KzZ9HBZOPRdg7vtEajdXVtT/SKiY5UDHN3ROr9GGYg7VSNKbDP7zWUgT01GQAxc+9jxf7DPTjvMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Uw09ZuRg; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qdt/+M5dXZyVpNTXx6unkwn4FZgeeM7vVJO0cHR32m1rIbJWRErAAK3nAPLnRDZkNV/v7fcHZJTPB2t+TQYSrZ2gLefyzwEWKKnzmXOD75stvOeLOhVYlBk+FSG7dxUgpnD+Tfg6086eFJI43QvOpThLI+FmsaEXD59qJUDOxzCd0AIFNDqs92FayStc1BTUo113lPgxY4EFjR0cGbYkO/k/WEQueYNupUPN9W5y9UDmJ9TFrdDMWzE+rtgQUATYLBjeDJ9TmqO1XL2cNCwAlIllEscuKwq+ZxgK2BgdWkoqlRG5NDddEbVu/ZMQNmSpJrukoa8cIQu4orh0zLInbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTBDk+WKXNbpXS4eS7mc8fBL2pzATrrHzKwjfsSy+lM=;
 b=D2CPsopGhdmN6IhculpHr6j4pSLi/k9y9TNFWic/+C4pyRo1/tinKE5rc0Gb95dfp3gW+6Byn8v5vf4mUXKJuDBKZeMTrNC+uno+zC4UGLXS9o3VlWa6yAthUvAHzb4Pb5rFRn0rmvE8Iy2H+u1Dq8Jjt8TVCsCdW3rIBJ0LkUUgSj+4ZmtlzIYe0L7OI9QPsrnI97Y0Vk8FOaLaYu8pATOPTl34FnKQZuVgEEnER5L0T0ib1uItmWU7PA7zc3DKJsX+/fwnEbefNQq+mBeWc8hPiEc/jTC8GPmqIwY0P5GKANlaUIFteSQX7Zy1fKaa4hESGZFE/ULV6MuL+WpXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTBDk+WKXNbpXS4eS7mc8fBL2pzATrrHzKwjfsSy+lM=;
 b=Uw09ZuRgmRFMG68PMbSqMgQDwVAVi5QHebYLFUHj18M6t41tu3MZnL+qRWES5sNa5B4PRHjY7wJpSd/aUou24jdW1YuJ/RXIpXVxFvsRJhE5r2bFpv0IjfOXrnxpVBso+8SLFkHlsw7GE5Jv+31TbzaW6Lwo+Nr9MrLVwSyhnP0cL8ptVwr+/uTJQRf4ZUiFqwBKdv9BD56dDV9nTY9FY/uVxXumkCMc2AZf0f3Brvk0ox9OSz1H9qrp3kFQ4NvErcSkvJrBUA8Sb2soedEQk29x043Ve6sC8BcL7PVua2D0WR+dKREa5GLLxhcaDBrnSLvGWlNT6m37dwWCY+s4RA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB5915.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 09:05:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 09:05:45 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Aun-Ali Zaidi <admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>, Orlando
 Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Topic: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Index: AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNqf5kAgAAAdQCAAAM1mA==
Date: Sun, 9 Mar 2025 09:05:45 +0000
Message-ID:
 <PN3PR01MB95970134B40651A901F825DCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
 <2025030905-claim-hardiness-4e7b@gregkh>
In-Reply-To: <2025030905-claim-hardiness-4e7b@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB5915:EE_
x-ms-office365-filtering-correlation-id: 0fd7b6ff-7e96-46f9-f2af-08dd5ee993c9
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|19110799003|461199028|6072599003|7092599003|15080799006|12071999003|21061999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmhEZXFUYmdnaFlLa1hXb2xycmd5SmRPZEgrVmpQcDZJQVNvOWI5S1JCQ2dn?=
 =?utf-8?B?SGduWjZiT0R6ZVc1bUczdG9HbXRCMFppRkhzbGFUTEtvYUZYMUt4N2JXVW9T?=
 =?utf-8?B?dnpZem9lZXdSUjBMSm5FbUFlOG45L2JYOVpsYlBWMEtwTlE2OVBSMWFGZDh2?=
 =?utf-8?B?a1FCZUZmVWpBdXBxbGtiYi8zdmRmK1BsQlh6VEgvU1JLWENZdDhXL1Z3Zm52?=
 =?utf-8?B?YjM4MEU4Y0RCWjZxbThhbEhuWXRuMlhqcldHRk15Q205M1VYZGd5eXJVNTFX?=
 =?utf-8?B?OVZXSjAyMVJHT2JQWm4wVzNjeEdJQWFnc1RmWUh2dGJpcGlWYi81NURZZTE2?=
 =?utf-8?B?d1VQeW9aUmVKbnN2U09PNzJrUHFsMEtRWGMrakJrOGEycmUxcEtsUW1kVGRO?=
 =?utf-8?B?NTZRNXRPaW5xaEFqREVSSXNSS0VIT2hjdWV6S213S1hlZzNyVDR0K0FPNVhj?=
 =?utf-8?B?Nnl5RVd1ZEtvNXJIYjhPNjc3SThrN1Z1RHkrQTRTMVBERkxjRExIMUx2RVVN?=
 =?utf-8?B?MURxWURNRUlVbm51TzhxcWJ2K3VMUzdyK2tHSWt1bzhhaURWalN4OWxXVzlR?=
 =?utf-8?B?dkxta2dqNUlHR0dKZ1dVWDFRMWlxeitBOWlya0c3M0g2RTRhS1BRZzJ3WGlU?=
 =?utf-8?B?dTYzSm54ZHVoL0hnMDlVV1Q4SldzdEF1dU0vYlNpMXF5NWQwb2toVDdKb3d1?=
 =?utf-8?B?SDY2NTVrQVc3QkFadWRGKzByV2RSM1J5cHpGNUhLaE9FN1MrOXJ4VTJJYXdC?=
 =?utf-8?B?TmZZdUdYUFphSHQyUXFaY3FtY3pQWmVqZkZBTlFERHZxUDRZL0NvWU0wcWZZ?=
 =?utf-8?B?clJXL2xwQ0xqUEdlWTI0Z0NiWDczeWUzb0gwZkVpODhjNUpLU0c3SXVtNEsx?=
 =?utf-8?B?UURLWEU1a0ZFYVg0TmI4ay9LN0hCaHZsVFRJOG1DQmpBY05MZCthNHQwcCtt?=
 =?utf-8?B?SUtmeFBMVGVIZXFKc3BvR2s5S0F0b2o2dXdkdTFPUnZCR0l0QUY1KzFNUEd3?=
 =?utf-8?B?VEZsSlJLRnUwbGNkeW0xM215UHRsU0VVSHpWL2kvVWFNOGtCNjM5ZmZQMlNw?=
 =?utf-8?B?SWlnQ0dBTi9sc1R1NjZsVXhZZjNhTTBGZXdOVGhDd3pubkxQUFl1NnZSMTZ5?=
 =?utf-8?B?ZGhvUE8xWk5hS0pHa1pnbDE3K2wvbi9xZW9kK1ZmQy9EV2RZeSs1ZnNCenFG?=
 =?utf-8?B?ZllPRm9mNjEvcHZvM1QrTFVBNGZyWWdOcE0zTldFb2JOdUhJTUt5NFA0ZG9T?=
 =?utf-8?B?SHovd0FHTTB1SWZDSDJXVDNEeGx3MEMyczF1VUNVTmd2M3FTT1VYVWlTY24r?=
 =?utf-8?B?UmZ5Ty85VCtuc2Q2V3ZvcEpDaFo0aXJ6QldaRmNydTh3QitHSnI3SlFMRzNQ?=
 =?utf-8?B?UHhaWE9iMmVhWmJ5bjJ6K2M3Z1VYY0Fra05QV1ZocmFpcUlOYm1sUk9lT056?=
 =?utf-8?B?UHNkY0VBSlFJbnZDVmZ2RVBMbXIzN0Y2RnhVQzBlOWY3ZDZrK1ZWTmdlVWtN?=
 =?utf-8?B?LzFuelNWd1Bkb3BiS1pFU0RkOHhpQ01mWUpYdmdCTzBnNHhoUjdxV2dDYUls?=
 =?utf-8?Q?HFKka6NUKut8NsiD2bjaTnja0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlVncjl6N3pQcVRRcXRWU2pHWnFXYndaR3Rld1FaeVN2cit2bnRRbFJKTDRp?=
 =?utf-8?B?ZXU3UnNkSWNVRTVNbm9OcDltTjR1REQ3YnZoUlFVWGdyZm5JQkIrcjZQbW05?=
 =?utf-8?B?eU9KTzVVZkt6SW5TUG1TNnNnTzZkOFhYTjBtanVZV0xDMVpVUVR0cFltNjlr?=
 =?utf-8?B?UENVcTljSnZhblp1S3V0OVdRRXdNN0lmTVRVNHVYNVVpVTBUMU9GUTdTUkli?=
 =?utf-8?B?TURheGYwcjJqdEl2eGUwNmZMc3EyREExVlc4ZnBGWXlDNlpiWTUrY1Ywcmpj?=
 =?utf-8?B?ZEJEeW4waDFpMVIvTFNoc3BXMEkvbiszcU93VE44UHJnU3pTak1QL3dyVUNu?=
 =?utf-8?B?QWtZVWZ4ZDFROGI5OXlkM2E0WXpzT2VYMTQvdDVWSldKR3BQbmYrMGkveDY4?=
 =?utf-8?B?QzdTbit5VDVyZzlmVURUYTUzTHBzbkg1VUdTN1E1VnNzcmFuUGxuWW9NOTR5?=
 =?utf-8?B?RzgzMTFEbEFQRXZZcTM2YXNWTFc5amIxWTkvTjA2bmNua1I1VFlxM0YxZUx3?=
 =?utf-8?B?VEp4MHB0a2l0dmZuOCtab1YxcGVyMk0vMFFMSUNSc0w5Y2VDVTB4NlJGVlB0?=
 =?utf-8?B?TThZL3d5dVVkUFF1ejlNVUJDMmNoYlRpRnEydDM4ZXR2U0FHaXJDdTJFYlND?=
 =?utf-8?B?cTgyZy93TjlKV0c5NC9QUzNMQ2p4bk9SYkpmUG51Y2ZuS21iMnAwRkprNytQ?=
 =?utf-8?B?Vkx4MmNmckhNd1NvbE5iVzZZV2lhSXZqeUp1REVxVWN2UVhQL05rVW5WU2ht?=
 =?utf-8?B?UVExYmc3WllvM3BzY0ZEZnJyYVpveDgvNTRWazJNQm5hY2RObWJjZWUvamJ1?=
 =?utf-8?B?bmg3K0JDOHRjMGpmdjdhaEV4ZEt1MkVOMjlRZ0tUd0E2eDVicjRyWFBBWG1G?=
 =?utf-8?B?Y2RoNlFhUnFLVDNVNWQxNTIzb0ltc0Y2TXZ3QTZUSXZWeE4vb3AvVkxyOGJ2?=
 =?utf-8?B?S2RZdlpuelh1K2s0YTc0VXFSR29GUFBjaDRyRHNMd2V6cTMwcE5SOW5GcS9s?=
 =?utf-8?B?T1A1Y21EQWIvaXptWXFYVUVCRHlXZFpnKzltNkp4U2FKcmlheGVQT3BIWkFR?=
 =?utf-8?B?TFQ3OFA3a1NzS3pwN1JxUyt3SlJOcmx5U2RHUERXWUtSY0E1UDVDYmR6V3Ew?=
 =?utf-8?B?V3kxK0xvYTdCbEtRNmJOYmpsLzBHYnpuU2tKN1NWc0VORTR2dFFpMXI0WDda?=
 =?utf-8?B?V1VadGU2RmNkMk94TDM0MHhjU2hWMFlGTDFaSmdnaHZZdXBRTFB0VElPMGtp?=
 =?utf-8?B?UURyL2V6cVJweXpGcEFaRGpWbHVXTWFjMkhsZXRBWjNVTEQwVFVKcWc1by81?=
 =?utf-8?B?SWxJTGpqTVRPVjl2SXVPN3RyMVhvMjBFUnRldmV2eGNGeFFCeVNOM05xSFZx?=
 =?utf-8?B?MENqRWV6MGYzY0lWRlZqUW4yWWtyaE1oZ0pNdU1IbmVGM28ycXF2L2o5UGdi?=
 =?utf-8?B?RXBUUDByWWI3dUJhc29LaVMrWjArRjh4c2JoUW9hYXVuZXRKb0M1Ry9LK09t?=
 =?utf-8?B?aHJRTDlQUnN1S2cyN1ZrZXlxSHJURGNMTktJQXBqV1JrMnVoZHFRY1RWb24z?=
 =?utf-8?B?bzFxNDVURkdNSEpLSGVEdzhKLzc4MHNoU214UFVQa2tHMW1GSXNraW4wTCsr?=
 =?utf-8?Q?jdzfr0AY0UuTl9+b8gs4xGKemqZU09hrncj41fAf48z8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd7b6ff-7e96-46f9-f2af-08dd5ee993c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 09:05:45.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5915

DQoNCj4gT24gOSBNYXIgMjAyNSwgYXQgMjoyNeKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjUyOjM4QU0g
KzAxMDAsIGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0KPj4+IE9uIFN1biwgTWFy
IDA5LCAyMDI1IGF0IDA4OjQwOjMxQU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+IEZy
b206IFBhdWwgUGF3bG93c2tpIDxwYXVsQG1yYXJtLmlvPg0KPj4+IA0KPj4+IFRoaXMgcGF0Y2gg
YWRkcyBhIGRyaXZlciBuYW1lZCBhcHBsZS1iY2UsIHRvIGFkZCBzdXBwb3J0IGZvciB0aGUgVDIN
Cj4+PiBTZWN1cml0eSBDaGlwIGZvdW5kIG9uIGNlcnRhaW4gTWFjcy4NCj4+PiANCj4+PiBUaGUg
ZHJpdmVyIGhhcyAzIG1haW4gY29tcG9uZW50czoNCj4+PiANCj4+PiBCQ0UgKEJ1ZmZlciBDb3B5
IEVuZ2luZSkgLSB0aGlzIGlzIHdoYXQgdGhlIGZpbGVzIGluIHRoZSByb290IGRpcmVjdG9yeQ0K
Pj4+IGFyZSBmb3IuIFRoaXMgZXN0YWJpbGlzaGVzIGEgYmFzaWMgY29tbXVuaWNhdGlvbiBjaGFu
bmVsIHdpdGggdGhlIFQyLg0KPj4+IFZIQ0kgYW5kIEF1ZGlvIGJvdGggcmVxdWlyZSB0aGlzIGNv
bXBvbmVudC4NCj4+IA0KPj4gU28gdGhpcyBpcyBhIG5ldyAiYnVzIiB0eXBlPyAgT3IgYSBwbGF0
Zm9ybSByZXNvdXJjZT8gIE9yIHNvbWV0aGluZw0KPj4gZWxzZT8NCj4+IA0KPj4+IFZIQ0kgLSB0
aGlzIGlzIGEgdmlydHVhbCBVU0IgaG9zdCBjb250cm9sbGVyOyBrZXlib2FyZCwgbW91c2UgYW5k
DQo+Pj4gb3RoZXIgc3lzdGVtIGNvbXBvbmVudHMgYXJlIHByb3ZpZGVkIGJ5IHRoaXMgY29tcG9u
ZW50IChvdGhlcg0KPj4+IGRyaXZlcnMgdXNlIHRoaXMgaG9zdCBjb250cm9sbGVyIHRvIHByb3Zp
ZGUgbW9yZSBmdW5jdGlvbmFsaXR5KS4NCj4+IA0KPj4gSSBkb24ndCB1bmRlcnN0YW5kLCB3aHkg
ZG9lcyBhIHNlY3VyaXR5IGNoaXAgaGF2ZSBhIFVTQiB2aXJ0dWFsDQo+PiBpbnRlcmZhY2UgaW4g
aXQ/ICBXaGF0ICJkZXZpY2VzIiBoYW5nIG9mZiBvZiBpdCB0aGF0IGFyZSBmb3VuZCBhbmQNCj4+
IGVudW1lcmF0ZWQgYnkgdGhlIGhvc3QgT1M/DQo+PiANCj4+IEFuZCB3aGF0IG90aGVyIGRyaXZl
cnMgdXNlIHRoaXMgY29udHJvbGxlciwganVzdCBub3JtYWwgTGludXggZHJpdmVycywNCj4+IG9y
IHZlbmRvci1zcGVjaWZpYyBvbmVzPw0KPj4gDQo+Pj4gQXVkaW8gLSBhIGRyaXZlciBmb3IgdGhl
IFQyIGF1ZGlvIGludGVyZmFjZSwgY3VycmVudGx5IG9ubHkgYXVkaW8NCj4+PiBvdXRwdXQgaXMg
c3VwcG9ydGVkLg0KPj4gDQo+PiBBZ2FpbiwgaXMgdGhpcyBhIHBsYXRmb3JtIGRldmljZSBvciBk
b2VzIGl0IHNpdCBvbiB0aGUgQkNFICJidXMiIHlvdQ0KPj4gd2lsbCBjcmVhdGUgaGVyZT8NCj4g
DQo+IEFsc28sIGl0IGxvb2tzIGxpa2UgeW91IGFyZSBjcmVhdGluZyBzb21lIG5ldyB1c2VyL2tl
cm5lbCBhcGlzIGhlcmUNCj4gKGkuZS4gYSBjaGFyIGRldmljZSBmb3IgYSBVU0IgaG9zdCBjb250
cm9sbGVyPykgIFNvIHRob3NlIG5lZWQgdG8gYmUNCj4gZXhwbGFpbmVkIGEgbG90IGFzIHRvIHdo
YXQgdGhleSBhcmUgZm9yIGFuZCB3aG8gaXMgdXNpbmcgdGhlbSBhcyBJDQo+IHJlYWxseSBkb24n
dCB1bmRlcnN0YW5kIHRoZWlyIG5lZWQsIG5vciBrbm93IHdoYXQgdXNlcnNwYWNlIGNvZGUNCj4g
Y29udHJvbHMgdGhlbS4NCg0KSSdsbCBjbGVhbnVwIHRoZSBjb2RlLCBhbmQgdHJ5IHRvIGZpeCB0
aGUgdG9kb3MgaWYgcG9zc2libGUsIGFuZCBzZW5kIGEgcGF0Y2ggd2l0aCBwcm9wZXIgZXhwbGFu
YXRpb24uIE15IG1haW4gcHVycG9zZSB0byBwdXQgaXQgaW4gc3RhZ2luZyB3YXMgdGhhdCB3aXRo
b3V0IGtleWJvYXJkLCB0cmFja3BhZCBhbmQgb3RoZXIgaW5wdXQgZGV2aWNlcywgbGludXggaXMg
dW51c2FibGUgb24gdDIgbWFjcy4NCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==

