Return-Path: <linux-pci+bounces-23291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01ACA58E7D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1416016B8C6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDAE224885;
	Mon, 10 Mar 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mYAMHrGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38AB224222;
	Mon, 10 Mar 2025 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596366; cv=fail; b=g0ZE1SaTtg8JdOk+uVLhS7umU+mLIM0c5XHEMPE0nWKnuEbRJNjNUgt7D+F4N9OkxCsNeNRaoOWV1VaHsEMLXQ4bUkLue354Tn273MQ+Xd2CK9IpbmUatNJm4uKQNsWMFqLJ9DwJ4e+wl7wxmIdjeLm5shkp+t+8Op8Qd3CiKqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596366; c=relaxed/simple;
	bh=NlA26V68ns8E7hQgCgsjN8OHEPoXgNnC9EGbrsNqgDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LipT/dyayO8e/37tqnvIX1OY+yO8peiFLoKL3fW8RftQCsS7svqiwC17mO4OhM3PlsOtKdhzKQVCGGDWv+O5lfsmo+ykUuj0C2S8CABWN0DygMG3Px09cfca3FNPkUXz8m57GzIg5CUplgIFYTYCPPZvUv4tyyK1v73KltyBRro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mYAMHrGK; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf2jnz6xuDQwwAexksJpQ7UG77+5MtqVdvWlKO74I9X/lw7XGptE/TiZ66k5a5+O3S2U0Ol4zATsLXLWOnnIKJndKPWXlvXe8VRN3xZ8WX0qb/IRd7KhXgIeC47b0TfmlZI7EbrScOWXjwpRalvjEpQdigEsjZDoDn8zKgz8MiE8l/solt8QkMi5AQmhnOw912ANMKSVNqUsbLPxCMOdFh+II+S53ScZ7aoZbCPjU6eNRP4JgWpqpy47cKI2akMaRU3BE25+G4gRf+Nbm4i1g0Ao0j19Rrq6ZPfgGby4bvo0HWDL1YiT+4yMKbBvY69JNQvxkav/H8oRkN6Zmi7cXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlA26V68ns8E7hQgCgsjN8OHEPoXgNnC9EGbrsNqgDw=;
 b=Gpd1z0nxMGJS2yXrnMfoUZWTD6SlBe8DDNQys50hfCyvTpZwY8nUmoHawdjoRTpNwyjdfKhiL2/t1i8gPWe6Kt7RGDlNNtO2riYVZObyzWtdTdvy5XvV9nC4j9aOv6CXRiMOwPMf/0qrAlJ+MCI/spVYv9RYsZfzqQuRX0TtJG6mb15pRLfZGdYX3UhIoEYF6ndNxVOL+eW71msRSCTnQEws6BOW0dA8hxWUnoej2j1urff3dODdS7+RTeE/c47OMIXb5MksJuRPST1vW232r+xZFonPPcmlnzatD3btIOTf6LCw8cenoRZR4ZQYIdssxf9xRQW8JEJkKeavTihM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlA26V68ns8E7hQgCgsjN8OHEPoXgNnC9EGbrsNqgDw=;
 b=mYAMHrGK1zpIAbaawUXCtSnyYsLUAwi/sdWDPd3QeR0aDZ/chbc8Pn3Yy61A8qJLI76OJpZxijxivZU5FswDaecXw9XsdXI5WoSjKH3Z2riEesGVcxU8UJlJ7Xlif+lqAXzY11uFqPzSC55ZHEBa3JZgmfU0Ak+1Ufu6FD+tXv5E51yJiiJuNFKkzQGb3bSt7dCWLD3I1kV7GGmgUaaVL0ZuofRkB4POifkdQZG2iIaczPhndGzjZjVDMCD0NMJ/RNt5ewdxb9QwUj2pusHAV+kI5N58IlP7gjPC5C2Lm2E37g1mw9Aw48OkmK2PXpu2TCYgRnR9qeV7YUFEGexjiw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5753.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:45:56 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 08:45:56 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
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
Thread-Index: AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNsB1wAgAAIsvw=
Date: Mon, 10 Mar 2025 08:45:56 +0000
Message-ID:
 <PN3PR01MB95975AD4F7CF318EF7327A91B8D62@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <f483ac12-c731-4dc8-9de5-059e07ff2c85@stanley.mountain>
In-Reply-To: <f483ac12-c731-4dc8-9de5-059e07ff2c85@stanley.mountain>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB5753:EE_
x-ms-office365-filtering-correlation-id: efe29269-cccf-40db-ac0b-08dd5faff959
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|461199028|15080799006|8062599003|8060799006|19110799003|7092599003|10035399004|102099032|440099028|4302099013|3412199025|12071999003|21061999003|12091999003|41001999003|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3E3YlMrVUU1RWtISGpMaXpNYU43T25Xci9jV2RUcmVGbjA1VE1OMjZVMXBk?=
 =?utf-8?B?MVRINXpTanptT3cwMVBXWjc3bUZtS21qTy96VHh3WFNHNFVabWVRRzZHcFAv?=
 =?utf-8?B?T040K2pnc0lrV1pvTDZveFYreUpOUDRoZldiQ3E1ZFlxV1hoSncwUEE3dk11?=
 =?utf-8?B?MjhIcWtKQW5WbGdxNG9waXV5VWVpNm9wT2dFclRBVlMwMVcwcDZFRGlIMkRH?=
 =?utf-8?B?Vy9Gak1MQnJtYnNXcXBya0NmVDUzeWF0MXNEZmovOW4xZVdoMkd0NDg1QWw4?=
 =?utf-8?B?ZHdTU3ZlUHRPVCsxZEM1UGo4dWxOcGw5SjNSbFNoeGpxK0FXZ1lxMiswTnpS?=
 =?utf-8?B?MER1a1p0akZFRXN0dHVXTWlSd2ZkVnlnVEtnNitYQy9QZWtXUFFBUDNSbVF3?=
 =?utf-8?B?Q2lNVFdhRitoVEQ3M2hYcktueXF0dDNLcDV1a3hyZXFEUGUvYkMwV0NONzVE?=
 =?utf-8?B?NEN2K01TTGlVelRLV1Ivb0hIU3NSUkpqb3pqUjM3UHVaUHZlWGkxSTUyUHFq?=
 =?utf-8?B?RU5EaytCSHNFNkMxQXFZZ0ZueHIvbC9vUEZKZ1FuMWd5aW8ySzdLUWxkeTZY?=
 =?utf-8?B?L0l1YnBiNXFvNklQdzY2U214d2c3RmVVbnFxYmpjbG4wZGMzWWZSKzkzWk9i?=
 =?utf-8?B?cThIa09ORExqbW1UaHVtZkMzWjFBY3Z5SEZDdlRvc0Q2SjhYaFNsY1ZsamVV?=
 =?utf-8?B?MHY1dFJ4Y2daQWxvbWFic1FxSEpVbktSRzBKOHp2dU1nelpDMEh2VHYzazU3?=
 =?utf-8?B?ZzBMWEsrelZ3bzRGNjkyaXRBYVZ3L2EzRnl0S2tiRlE1ckxxbklYZThVRFRN?=
 =?utf-8?B?cDFSNHBjTngwK2Q4R2hJNldxTU11Z2Q1RFNua1VDcno5Z2xpbE5PQmJBY3A0?=
 =?utf-8?B?SjBPSE1uNUQ2TitheDUyQUFoVTAyRG1JOE0zSkw3MVpJd3JaQkNESHZtL3NZ?=
 =?utf-8?B?TmF1clQ3UUVwWlBzK1d4eTRmSTdvZ2ZzSjFyaDJsMXZuZ1JtU1FCQXkzaTlT?=
 =?utf-8?B?QWswVmRsR01XOXAvYmZtMmZ4VUtDMXJNdU1yaFlQaWZDZTV3TG9XcVdyMUpW?=
 =?utf-8?B?WS9aRjRvRDdPNVI5WDNHWEpmWHJIL2J2MiszYi9ZSis2YWtFT21VY0VJblB4?=
 =?utf-8?B?WXVOa3hLOWtheGIraTBjS2RrdmprZU1mYkttRFNxaHNaK0o2b0h1NXlzY0Uz?=
 =?utf-8?B?djUzNERmSVdLT2NnR1NnSXV3QnlVWHk3bmpjVVo1TGVkSjZ3TFQ5RWJCcmJk?=
 =?utf-8?B?aEQvYmJGWmd6Zk5uRENBRXVscUlyRlp2WFhydFhYQy9mZVlpM1ZESE52OEVY?=
 =?utf-8?B?TVJEQjgvbDBZWUwwUjdQOC9KcVRzMExlMStNV3V5YXRmNnBjKzJaa2NsVXhO?=
 =?utf-8?B?djg4SGU2alFkbllFdmZpOURpdkRmRzNNMjZ4RXRzbm1ldWwvbnZYa0czY3hY?=
 =?utf-8?B?Q05jdVBIN1IwRVQxRDBEQU9udTYyVCt1a1F2eS9ZNHBNQ2oveU4rTUpvM0Zo?=
 =?utf-8?B?S245NjNvUTVDWjRqaWI3UHVVS2RUM3FEYmtGYnBrYU8rbDBwLy9xWWdlWnhX?=
 =?utf-8?B?Zmsvd2VBc29ZaDJFZXpLTjluK3NLa0NFaW9pZW14WmtBM0xxT3BFN3I1QXB2?=
 =?utf-8?B?T1VneFYwRHVORHByUmFncVloRFNJSHZSN2kvVFpIVkdwL3pwbENnVzFEQ0JW?=
 =?utf-8?B?ZWhSZTZydnZLRjJHNHN5R01SY3UyeENOOWppNDdZZ1VkK3RHUU9PcTExMkZW?=
 =?utf-8?B?QlpPN1hTYmJqRkpNWVVid1lSa21UZHdNbU5icU5GZ2tXOEVyNG1uN1dIekc4?=
 =?utf-8?B?ZEgrYlhxTk5jclFidndwdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFo2TjZmZTluWHVMUUJYemRoT3J3cEZVY1FjOS9ndlVVTUVlWUJhYk12SnFG?=
 =?utf-8?B?OHhTR0NVaDBTTUJxMmdYdElqcS84bWx2aWpZTDN5N01KcXdGTlUxc0J2QTZ5?=
 =?utf-8?B?K2hrcDdVaEJyQmoya3VwSkZDS0hiWlZYSll3NUllZ0R0MUlJeVhRdGw4SnVn?=
 =?utf-8?B?RldHcmVXS2c5V1NxT1oxQ1NEMWNSU0tKaTRBNzN5UkJQRlViRjNFNkpkMzZh?=
 =?utf-8?B?T0hSYkNyYkRZaXZsM1VialAyb0psdTBKMmhkSk5VcGdvbG1Lb0lVNzM5TUtK?=
 =?utf-8?B?NkpEamdUTjhmQnp6ditLNnZCRzhpUkRGUXFQanRwQmJHanJxdUJzVlVHa3Ew?=
 =?utf-8?B?UzNxVmUwS1JHYUJhTkJYWUFKc0NDVUZnRDhobkF4Y0M2UFF2TlQxQkxOQURL?=
 =?utf-8?B?cEtIV2tKM3VJdWh2ZWpLVEdOVGlITldvRHBHcy91WnpTdExiZjRjNG5udGg2?=
 =?utf-8?B?ZmwzNDlpMkswU0JqdXNLRTI5aU1WTWU5Mm1JeFUxYmlETGxWYTNEODVpa29N?=
 =?utf-8?B?YVFZUWgvRURpUEJOMmRTdWhmeXNuc0U0T2c5S3FTQ0FrWGt1TmR0c1FnY2dk?=
 =?utf-8?B?cVNvYms3Mjd1dDlUSDg3aDJTYzNWTmlGR3haUHE0V3lnclRrWENJTTNXNTVl?=
 =?utf-8?B?QWRqKzdlNHhCZEVQb1BNZU1oRldKK3I3SmRzNFBZWFhCUGtuelBBVy90WVA0?=
 =?utf-8?B?NkUvOWlid2owbmFieHBPZHRPRnBQM0VOekFwS0sxa3BsSzRJNjQzZ1dQdDJr?=
 =?utf-8?B?V1Bia0htaVZIaW5BaHpGWVUrbzVMR3V3azlacXRkc1pkVHlibzJMblFldEFB?=
 =?utf-8?B?WEtWSDg3aGtOTUl3TnBtVit6VEp2UGwvdk9TbVFwaytmNWZZSExOYThsTXdl?=
 =?utf-8?B?OFArUFVzN2dweDNQaFRoQnBWK2s4UzVDbnErOXpOMkdndFBVR2J3eFhSNkcy?=
 =?utf-8?B?RXJRc0Y3MTRFb1BpL1Rvdk44V20wdGZFcmZSekUyRURjYzdPZ0RuM3hMWkF4?=
 =?utf-8?B?S1pLSHVxOTk3WkQvTXNFNVowSi9COEpFa0ZjdHQ1YUJpOFBtODZ1Z1BWa0hl?=
 =?utf-8?B?YWFRMnBCdkdsR1lyWEhnSXVPRDdrakhzR0FHSlZkMUFZU1Nwd2dqMVZ0VExn?=
 =?utf-8?B?dEtjRisvVnpVSVBNbzUvS296WFlFMDBoTFZVNjB3ZkpnRk1CQi90b3R4TjUr?=
 =?utf-8?B?ekJBRU5oaldXZmdWL2JhUFEwY1pncWdNanJqdURSMExsUUUzUUozVDRDUlpn?=
 =?utf-8?B?STV1QTRvUStJWEJVNmhOQnZOWk9sTWpKaGtaOFNCdVg0L1RPVytVeFpiZjh0?=
 =?utf-8?B?QjZ4NHE1QUR5M2lSWnB2VUJxaW5haTk2M2NpVFNVNWdnM0dLRGJyZm5aZnFQ?=
 =?utf-8?B?ZDcyMVFmZEx5RXBDL092VUgyNk5ydHhCNGVaZVFiWVdldDF2YWFhbmZMV3pG?=
 =?utf-8?B?WjFvOTFUcmpQY0pjN3dKRmNPdG5WZ1RWV0hRZXlnd1VTMUpQSXZzYUVmVExL?=
 =?utf-8?B?UGlkRGdzZklDRGgvNjdxVkV1K3ZYa3pUOGtzWERhUkVObWxlbVdDc20zWDZN?=
 =?utf-8?B?c1pYUlU3cnFDY0p1VDBrNGVHa0ZIOXlPajRGZkxHR0ZtRkdDZjF3UkxzMlQ5?=
 =?utf-8?Q?PjVfmQMvSClIXu2p2XtVym8qVYkozrk8EkkPcQrNs4us=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efe29269-cccf-40db-ac0b-08dd5faff959
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 08:45:56.3332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5753

SGkNCg0KPiBPbiAxMCBNYXIgMjAyNSwgYXQgMTo0NeKAr1BNLCBEYW4gQ2FycGVudGVyIDxkYW4u
Y2FycGVudGVyQGxpbmFyby5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gU3VuLCBNYXIgMDksIDIw
MjUgYXQgMDg6NDA6MzFBTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zdGFnaW5nL2FwcGxlLWJjZS9hcHBsZV9iY2UuYyBiL2RyaXZlcnMvc3RhZ2lu
Zy9hcHBsZS1iY2UvYXBwbGVfYmNlLmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRl
eCAwMDAwMDAwMDAuLmM2NmUwYzhkNQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvZHJpdmVy
cy9zdGFnaW5nL2FwcGxlLWJjZS9hcHBsZV9iY2UuYw0KPj4gQEAgLTAsMCArMSw0NDggQEANCj4+
ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4+ICsNCj4+ICsjaW5jbHVk
ZSAiYXBwbGVfYmNlLmgiDQo+PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPj4gKyNpbmNs
dWRlIDxsaW51eC9jcmMzMi5oPg0KPj4gKyNpbmNsdWRlICJhdWRpby9hdWRpby5oIg0KPj4gKyNp
bmNsdWRlIDxsaW51eC92ZXJzaW9uLmg+DQo+PiArDQo+PiArc3RhdGljIGRldl90IGJjZV9jaHJk
ZXY7DQo+PiArc3RhdGljIHN0cnVjdCBjbGFzcyAqYmNlX2NsYXNzOw0KPj4gKw0KPj4gK3N0cnVj
dCBhcHBsZV9iY2VfZGV2aWNlICpnbG9iYWxfYmNlOw0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgYmNl
X2NyZWF0ZV9jb21tYW5kX3F1ZXVlcyhzdHJ1Y3QgYXBwbGVfYmNlX2RldmljZSAqYmNlKTsNCj4+
ICtzdGF0aWMgdm9pZCBiY2VfZnJlZV9jb21tYW5kX3F1ZXVlcyhzdHJ1Y3QgYXBwbGVfYmNlX2Rl
dmljZSAqYmNlKTsNCj4+ICtzdGF0aWMgaXJxcmV0dXJuX3QgYmNlX2hhbmRsZV9tYl9pcnEoaW50
IGlycSwgdm9pZCAqZGV2KTsNCj4+ICtzdGF0aWMgaXJxcmV0dXJuX3QgYmNlX2hhbmRsZV9kbWFf
aXJxKGludCBpcnEsIHZvaWQgKmRldik7DQo+PiArc3RhdGljIGludCBiY2VfZndfdmVyc2lvbl9o
YW5kc2hha2Uoc3RydWN0IGFwcGxlX2JjZV9kZXZpY2UgKmJjZSk7DQo+PiArc3RhdGljIGludCBi
Y2VfcmVnaXN0ZXJfY29tbWFuZF9xdWV1ZShzdHJ1Y3QgYXBwbGVfYmNlX2RldmljZSAqYmNlLCBz
dHJ1Y3QgYmNlX3F1ZXVlX21lbWNmZyAqY2ZnLCBpbnQgaXNfc3EpOw0KPj4gKw0KPj4gK3N0YXRp
YyBpbnQgYXBwbGVfYmNlX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkICppZCkNCj4+ICt7DQo+PiArICAgIHN0cnVjdCBhcHBsZV9iY2VfZGV2aWNl
ICpiY2UgPSBOVUxMOw0KPj4gKyAgICBpbnQgc3RhdHVzID0gMDsNCj4+ICsgICAgaW50IG52ZWM7
DQo+PiArDQo+PiArICAgIHByX2luZm8oImFwcGxlLWJjZTogY2FwdHVyaW5nIG91ciBkZXZpY2Vc
biIpOw0KPj4gKw0KPj4gKyAgICBpZiAocGNpX2VuYWJsZV9kZXZpY2UoZGV2KSkNCj4+ICsgICAg
ICAgIHJldHVybiAtRU5PREVWOw0KPiANCj4gICAgcmV0ID0gcGNpX2VuYWJsZV9kZXZpY2UoZGV2
KTsNCj4gICAgaWYgKHJldCkNCj4gICAgICAgIHJldHVybiByZXQ7DQo+IA0KPj4gKyAgICBpZiAo
cGNpX3JlcXVlc3RfcmVnaW9ucyhkZXYsICJhcHBsZS1iY2UiKSkgew0KPiANCj4gU2FtZSBldmVy
eXdoZXJlLiAgUHJvcGFnYXRlIHRoZSBlcnJvciBjb2RlLg0KPiANCj4+ICsgICAgICAgIHN0YXR1
cyA9IC1FTk9ERVY7DQo+PiArICAgICAgICBnb3RvIGZhaWw7DQo+IA0KPiBJbnN0ZWFkIG9mICJn
b3RvIGZhaWw7IiBpdCdzIGJldHRlciB0byB1c2UgYSBmdWxsIHVud2luZCBsYWRkZXINCj4gd2l0
aCBiZXR0ZXIgbGFiZWwgbmFtZXMuDQo+IGh0dHBzOi8vc3RhdGljdGhpbmtpbmcud29yZHByZXNz
LmNvbS8yMDIyLzA0LzI4L2ZyZWUtdGhlLWxhc3QtdGhpbmctc3R5bGUvDQo+IA0KPj4gKyAgICB9
DQo+PiArICAgIHBjaV9zZXRfbWFzdGVyKGRldik7DQo+PiArICAgIG52ZWMgPSBwY2lfYWxsb2Nf
aXJxX3ZlY3RvcnMoZGV2LCAxLCA4LCBQQ0lfSVJRX01TSSk7DQo+PiArICAgIGlmIChudmVjIDwg
NSkgew0KPj4gKyAgICAgICAgc3RhdHVzID0gLUVJTlZBTDsNCj4+ICsgICAgICAgIGdvdG8gZmFp
bDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBiY2UgPSBremFsbG9jKHNpemVvZihzdHJ1Y3Qg
YXBwbGVfYmNlX2RldmljZSksIEdGUF9LRVJORUwpOw0KPiANCj4gICAgYmNlID0ga3phbGxvYyhz
aXplb2YoKmJjZSksIEdGUF9LRVJORUwpOw0KPiANCj4+ICsgICAgaWYgKCFiY2UpIHsNCj4+ICsg
ICAgICAgIHN0YXR1cyA9IC1FTk9NRU07DQo+PiArICAgICAgICBnb3RvIGZhaWw7DQo+PiArICAg
IH0NCj4+ICsNCj4+ICsgICAgYmNlLT5wY2kgPSBkZXY7DQo+PiArICAgIHBjaV9zZXRfZHJ2ZGF0
YShkZXYsIGJjZSk7DQo+PiArDQo+PiArICAgIGJjZS0+ZGV2dCA9IGJjZV9jaHJkZXY7DQo+PiAr
ICAgIGJjZS0+ZGV2ID0gZGV2aWNlX2NyZWF0ZShiY2VfY2xhc3MsICZkZXYtPmRldiwgYmNlLT5k
ZXZ0LCBOVUxMLCAiYXBwbGUtYmNlIik7DQo+PiArICAgIGlmIChJU19FUlJfT1JfTlVMTChiY2Ut
PmRldikpIHsNCj4+ICsgICAgICAgIHN0YXR1cyA9IFBUUl9FUlIoYmNlX2NsYXNzKTsNCj4gDQo+
IA0KPiBkZXZpY2VfY3JlYXRlKCkgY2FuJ3QgcmV0dXJuIE5VTEwuDQo+IGh0dHBzOi8vc3RhdGlj
dGhpbmtpbmcud29yZHByZXNzLmNvbS8yMDIyLzA4LzAxL21peGluZy1lcnJvci1wb2ludGVycy1h
bmQtbnVsbC8NCj4gDQo+PiArICAgICAgICBnb3RvIGZhaWw7DQo+PiArICAgIH0NCj4+ICsNCj4+
ICsgICAgYmNlLT5yZWdfbWVtX21iID0gcGNpX2lvbWFwKGRldiwgNCwgMCk7DQo+PiArICAgIGJj
ZS0+cmVnX21lbV9kbWEgPSBwY2lfaW9tYXAoZGV2LCAyLCAwKTsNCj4+ICsNCj4+ICsgICAgaWYg
KElTX0VSUl9PUl9OVUxMKGJjZS0+cmVnX21lbV9tYikgfHwgSVNfRVJSX09SX05VTEwoYmNlLT5y
ZWdfbWVtX2RtYSkpIHsNCj4+ICsgICAgICAgIGRldl93YXJuKCZkZXYtPmRldiwgImFwcGxlLWJj
ZTogRmFpbGVkIHRvIHBjaV9pb21hcCByZXF1aXJlZCByZWdpb25zXG4iKTsNCj4+ICsgICAgICAg
IGdvdG8gZmFpbDsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBiY2VfbWFpbGJveF9pbml0KCZi
Y2UtPm1ib3gsIGJjZS0+cmVnX21lbV9tYik7DQo+PiArICAgIGJjZV90aW1lc3RhbXBfaW5pdCgm
YmNlLT50aW1lc3RhbXAsIGJjZS0+cmVnX21lbV9tYik7DQo+PiArDQo+PiArICAgIHNwaW5fbG9j
a19pbml0KCZiY2UtPnF1ZXVlc19sb2NrKTsNCj4+ICsgICAgaWRhX2luaXQoJmJjZS0+cXVldWVf
aWRhKTsNCj4+ICsNCj4+ICsgICAgaWYgKChzdGF0dXMgPSBwY2lfcmVxdWVzdF9pcnEoZGV2LCAw
LCBiY2VfaGFuZGxlX21iX2lycSwgTlVMTCwgZGV2LCAiYmNlX21ib3giKSkpDQo+IA0KPiBJIHRo
aW5rIGNoZWNrcGF0Y2ggd2lsbCBjb21wbGFpbiBhYm91dCB0aGlzLiAgRG8gaXQgYXMuDQo+IA0K
PiAgICBzdGF0dXMgPSBwY2lfcmVxdWVzdF9pcnEoZGV2LCAwLCBiY2VfaGFuZGxlX21iX2lycSwg
TlVMTCwgZGV2LCAiYmNlX21ib3giKTsNCj4gICAgaWYgKHN0YXR1cykNCj4gDQo+PiArICAgICAg
ICBnb3RvIGZhaWw7DQo+PiArICAgIGlmICgoc3RhdHVzID0gcGNpX3JlcXVlc3RfaXJxKGRldiwg
NCwgTlVMTCwgYmNlX2hhbmRsZV9kbWFfaXJxLCBkZXYsICJiY2VfZG1hIikpKQ0KPj4gKyAgICAg
ICAgZ290byBmYWlsX2ludGVycnVwdF8wOw0KPj4gKw0KPj4gKyAgICBpZiAoKHN0YXR1cyA9IGRt
YV9zZXRfbWFza19hbmRfY29oZXJlbnQoJmRldi0+ZGV2LCBETUFfQklUX01BU0soMzcpKSkpIHsN
Cj4+ICsgICAgICAgIGRldl93YXJuKCZkZXYtPmRldiwgImRtYTogU2V0dGluZyBtYXNrIGZhaWxl
ZFxuIik7DQo+PiArICAgICAgICBnb3RvIGZhaWxfaW50ZXJydXB0Ow0KPj4gKyAgICB9DQo+PiAr
DQo+PiArICAgIC8qIEdldHMgdGhlIGZ1bmN0aW9uIDAncyBpbnRlcmZhY2UuIFRoaXMgaXMgbmVl
ZGVkIGJlY2F1c2UgQXBwbGUgb25seSBhY2NlcHRzIERNQSBvbiBvdXIgZnVuY3Rpb24gaWYgZnVu
Y3Rpb24gMA0KPj4gKyAgICAgICBpcyBhIGJ1cyBtYXN0ZXIsIHNvIHdlIG5lZWQgdG8gd29yayBh
cm91bmQgdGhpcy4gKi8NCj4+ICsgICAgYmNlLT5wY2kwID0gcGNpX2dldF9zbG90KGRldi0+YnVz
LCBQQ0lfREVWRk4oUENJX1NMT1QoZGV2LT5kZXZmbiksIDApKTsNCj4+ICsjaWZuZGVmIFdJVEhP
VVRfTlZNRV9QQVRDSA0KPiANCj4gRGVsZXRlIGRlYWQgY29kZT8NCj4gDQo+PiArICAgIGlmICgo
c3RhdHVzID0gcGNpX2VuYWJsZV9kZXZpY2VfbWVtKGJjZS0+cGNpMCkpKSB7DQo+PiArICAgICAg
ICBkZXZfd2FybigmZGV2LT5kZXYsICJhcHBsZS1iY2U6IGZhaWxlZCB0byBlbmFibGUgZnVuY3Rp
b24gMFxuIik7DQo+PiArICAgICAgICBnb3RvIGZhaWxfZGV2MDsNCj4+ICsgICAgfQ0KPj4gKyNl
bmRpZg0KPj4gKyAgICBwY2lfc2V0X21hc3RlcihiY2UtPnBjaTApOw0KPj4gKw0KPj4gKyAgICBi
Y2VfdGltZXN0YW1wX3N0YXJ0KCZiY2UtPnRpbWVzdGFtcCwgdHJ1ZSk7DQo+PiArDQo+PiArICAg
IGlmICgoc3RhdHVzID0gYmNlX2Z3X3ZlcnNpb25faGFuZHNoYWtlKGJjZSkpKQ0KPj4gKyAgICAg
ICAgZ290byBmYWlsX3RzOw0KPj4gKyAgICBwcl9pbmZvKCJhcHBsZS1iY2U6IGhhbmRzaGFrZSBk
b25lXG4iKTsNCj4+ICsNCj4+ICsgICAgaWYgKChzdGF0dXMgPSBiY2VfY3JlYXRlX2NvbW1hbmRf
cXVldWVzKGJjZSkpKSB7DQo+PiArICAgICAgICBwcl9pbmZvKCJhcHBsZS1iY2U6IENyZWF0aW5n
IGNvbW1hbmQgcXVldWVzIGZhaWxlZFxuIik7DQo+PiArICAgICAgICBnb3RvIGZhaWxfdHM7DQo+
PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZ2xvYmFsX2JjZSA9IGJjZTsNCj4gDQo+IERvIHRoaXMg
cmlnaHQgYmVmb3JlIHRoZSAicmV0dXJuIDA7Ij8NCj4gDQo+PiArDQo+PiArICAgIGJjZV92aGNp
X2NyZWF0ZShiY2UsICZiY2UtPnZoY2kpOw0KPiANCj4gQ2hlY2sgZm9yIGVycm9ycy4NCj4gDQo+
PiArDQo+PiArICAgIHJldHVybiAwOw0KPj4gKw0KPj4gK2ZhaWxfdHM6DQo+PiArICAgIGJjZV90
aW1lc3RhbXBfc3RvcCgmYmNlLT50aW1lc3RhbXApOw0KPj4gKyNpZm5kZWYgV0lUSE9VVF9OVk1F
X1BBVENIDQo+PiArICAgIHBjaV9kaXNhYmxlX2RldmljZShiY2UtPnBjaTApOw0KPj4gK2ZhaWxf
ZGV2MDoNCj4+ICsjZW5kaWYNCj4+ICsgICAgcGNpX2Rldl9wdXQoYmNlLT5wY2kwKTsNCj4+ICtm
YWlsX2ludGVycnVwdDoNCj4+ICsgICAgcGNpX2ZyZWVfaXJxKGRldiwgNCwgZGV2KTsNCj4+ICtm
YWlsX2ludGVycnVwdF8wOg0KPj4gKyAgICBwY2lfZnJlZV9pcnEoZGV2LCAwLCBkZXYpOw0KPj4g
K2ZhaWw6DQo+PiArICAgIGlmIChiY2UgJiYgYmNlLT5kZXYpIHsNCj4+ICsgICAgICAgIGRldmlj
ZV9kZXN0cm95KGJjZV9jbGFzcywgYmNlLT5kZXZ0KTsNCj4+ICsNCj4+ICsgICAgICAgIGlmICgh
SVNfRVJSX09SX05VTEwoYmNlLT5yZWdfbWVtX21iKSkNCj4+ICsgICAgICAgICAgICBwY2lfaW91
bm1hcChkZXYsIGJjZS0+cmVnX21lbV9tYik7DQo+PiArICAgICAgICBpZiAoIUlTX0VSUl9PUl9O
VUxMKGJjZS0+cmVnX21lbV9kbWEpKQ0KPj4gKyAgICAgICAgICAgIHBjaV9pb3VubWFwKGRldiwg
YmNlLT5yZWdfbWVtX2RtYSk7DQo+PiArDQo+PiArICAgICAgICBrZnJlZShiY2UpOw0KPj4gKyAg
ICB9DQo+PiArDQo+PiArICAgIHBjaV9mcmVlX2lycV92ZWN0b3JzKGRldik7DQo+PiArICAgIHBj
aV9yZWxlYXNlX3JlZ2lvbnMoZGV2KTsNCj4+ICsgICAgcGNpX2Rpc2FibGVfZGV2aWNlKGRldik7
DQo+PiArDQo+PiArICAgIGlmICghc3RhdHVzKQ0KPj4gKyAgICAgICAgc3RhdHVzID0gLUVJTlZB
TDsNCj4gDQo+IFRoaXMgaXMgbGlrZSBzYXlpbmcgImlmIHRoZSBjb2RlIGlzIGJ1Z2d5IHRoZW4g
Zml4IGl0IiBidXQgaXQncyBiZXR0ZXIgdG8NCj4ganVzdCBub3QgaW50cm9kdWNlIGJ1Z3MuICBX
aGljaCBzb3VuZHMgZGlmZmljdWx0IGFuZCB1bnJlbGlhYmxlLCBidXQgaXQncw0KPiBldmVuIG1v
cmUgZGlmZmljdWx0IGFuZCB1bnJlbGlhYmxlIHRvIHByZWRpY3Qgd2hpY2ggYnVncyBwZW9wbGUg
d2lsbCBhZGQNCj4gYW5kIGZpeCB0aGVtIGNvcnJlY3RseS4NCj4gDQoNCkZvciBhbGwgY2hhbmdl
cyByZXF1ZXN0ZWQgYWJvdmUsIEknbGwgZ2V0IHRoZW0gZml4ZWQuIFRoYW5rIHlvdSENCg==

