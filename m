Return-Path: <linux-pci+bounces-23226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89186A58282
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B001C188E86A
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A913D28F;
	Sun,  9 Mar 2025 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dqQT/S15"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8519C56C;
	Sun,  9 Mar 2025 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741510815; cv=fail; b=WWFTZMzncEeJilYcGfJP+FFnsQvoi+4a+dDtR+mwg+R2imiMVRGzVeuHIUR6IqDUGykIqTri9Gu/b6rDvZPgmQWXfhyVB0NjeZgLL2OtD/Txg23ilQcL3OdA37ALuz0B1Ao/5pgreCQocd1KianXCPnxHm5FhEiSjQ8U1HWC9Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741510815; c=relaxed/simple;
	bh=JDPONfL77W440E7brLGg2jrYYE/qJuuR+LPIiakHv+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p6RG6LX7ikgjXNbZWWByHmpOSo4eWeFXkkmdCn4Li0qDCHJ+/8gqDjZg3NBWMqtR9t0PCj4qCdn4Obci2jGRW8eFewl3XyhE17lMpO9Ex4+SXlG6uJpX71jXwJrnEw6HZnIYofVqpJ/nZL9b+AM2Y5GbBZMXLtqxDxb/Du+zJsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dqQT/S15; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWclbaiUUV2KyYpbMWNHo/kD1jm31U3C6SmGwfTbDGHCm5oZ0n+uFngLYfJr0yM0GW5xZY6ZQydPmflfgYmriiR4BFUN3UzC7XOJnLSBxUo49+mbPplBqRT/YJi/csOL9inZy2D7Sb9fCcCJBelFFOToEABxAIux9mFLuc0gTQTHTDLaYT1VcR3TyKYljIu46pc4tKXCZrFjk7CvmxvPIztgDooqj+od7lmLZj5YbeK6ppLfDsq6HJS7VJDH4ZMdyHO+vKQ57J94ZwW29JrOgbgxZtk9Xh2iAmAdOfjkMpkOKYor+loBa1nTtIhxvndiws5yrMeLl/E7hVXC6e7GMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDPONfL77W440E7brLGg2jrYYE/qJuuR+LPIiakHv+E=;
 b=HgBYm/CdFH4/retoDIX1K7/vkElia5sbYbQTffwk2b+JXC0Hk4A5yXEHkibuZGvs59yUUavNdy/+yakqw22zQtZSYseFuj95zg9kVeGG3JxtZehmGakoAqYAAx+Av0VX1YKB61x9uk5/4bVnEPKWOObcjEPsywIrA/olOBQi9MFEPewHcYSHGE4UiBB+K3eYnjPdb1HARU4OzBz1d366+YluTDFUM5hJeNenuXi7LL6zo3PUKaa/drIlc8Y/NJ/KTdrcq44zlqgTkTfA/F42jFBFLgU2j2eRlvxH1uAv1fDDb0caGGs4sJkZtuOWEfSHZMAPPy5xN/S+pflBzaT2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDPONfL77W440E7brLGg2jrYYE/qJuuR+LPIiakHv+E=;
 b=dqQT/S15yUGS134w1emz4MdC59oSTsqK5qhBrMeIog/TghR04CrsT4q8D6tvW7xtPGtiRQMcqRq/bG13QX9JCx5NKUxBS33LgKge/ftqXp6MIMjEoAh52jpF1N3b6J7bsIyrQ9saer52kKlWMYY0DXBOltNrWqMwYMZEKZ5OiwLUlSNsoMWuQUhn3dK6Xhc92FcoA2A9gDgNcjnDXhPRCasPwKLrsjkvQzJ8VBV32sKPfyQ7qllKRrddFHCijoCAypJdaDqcJU6rZMR2DkntwnMRU+JLVrqqwJ9UHl5+7sNplj7F/S5iVswQxUUlo7YwZTbh0MhMp7B+3MDSXeJz2Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB5915.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 09:00:07 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 09:00:07 +0000
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
Thread-Index: AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNqfTUAgAABm4CAAALgYw==
Date: Sun, 9 Mar 2025 09:00:07 +0000
Message-ID:
 <PN3PR01MB9597AEE275F867871BD9A5DFB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2B62772A-4292-4673-8F86-9D27D7AB4EE6@live.com>
 <2025030939-moonrise-zipfile-97cf@gregkh>
In-Reply-To: <2025030939-moonrise-zipfile-97cf@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB5915:EE_
x-ms-office365-filtering-correlation-id: 2019e00d-dc5b-45b0-40d8-08dd5ee8ca38
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|19110799003|461199028|6072599003|7092599003|15080799006|12071999003|21061999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3FkbGJxUHhjUmhxZHJMZTNYMUZNNnkrSzdKTW1YVkMrSUhINDRkdC9TUXdR?=
 =?utf-8?B?eGtCUEdCTTZaOFQzSE5hTXB1YzErYjF5b3cvWVdzNTFBS1d4Zk5oYVU0cCtl?=
 =?utf-8?B?dC9BOUV3NytKWjNaLzVmRWkyNVpVSmhNM3FkdGJEeVQ5NlNpUXA3S0tadDYz?=
 =?utf-8?B?dXlZb0VsQWJMbjVGZ3lWL0kveDJjMlVmY1NSU2lZRGNNemd5N3hvdFVXYVZx?=
 =?utf-8?B?RkJ1b2tDcWU4NnZkWXplVy9PdE9UVDdCb1p2S2Mvd1BsNXdzaWliMWFaV1ds?=
 =?utf-8?B?YW1pM0cvMytuNVVsdmhYS2lsK2xwak5Pc3g4dmQxNmJ4UVJvd0NicUd6d0xk?=
 =?utf-8?B?c0xXZGJOL0pWVUhNRmdzMDhqczM5T3MrWllHOXBpRkExTm5Id0FwcE5NUjAv?=
 =?utf-8?B?OVlKQ0gxK3BMajZvaDdGcTZpQ0owdjN0ajd4b3BRUmdtd0ZlZzNQMm9BRUFH?=
 =?utf-8?B?UWRicDhOZXFXMi92MXc2UWhOQ2taandXN1NRdWFEeHNUK2xLdE1zODNxTWhK?=
 =?utf-8?B?NDhvRGlSMzN3ejFVWFdwNytZU2xVeFNxTXo1N0R6NkZEdWFhTENIOXZtZHZG?=
 =?utf-8?B?S202aW1VMDJRbDhsa1VmNnAyNXJHdUZ5NktsTDRuWVpBLzQwWi9LaFlhU1Rx?=
 =?utf-8?B?aUhEcUtHODZyYUZrSDZFcXZEcWxnTDMvWTFTdVBNSU9kbzdPNjd5Vit3MnM3?=
 =?utf-8?B?SXVlbzRUZjFCbmtqa2tuOGE3bXJsMnVEQlRwdGs5cHNYN3VycEtWdXdrT3Ez?=
 =?utf-8?B?NUhSaHRld2lZQ3RyR3Yvb3Z5cDFsOHFHeFFTTFdWdDg3bnNyQzRlM3BoaHhx?=
 =?utf-8?B?bC9hQ3l3WGtNeWJzTlNWZ0xlZUFIaitkQXBYaXh4UnRjU0dLeUNJdTlReVFK?=
 =?utf-8?B?V01uRE5CaFBTeXRLQ2RtM2JPRXliOGZFQlVvelY2RXAvMmJEbURxODBqZ04r?=
 =?utf-8?B?TjV5MmU4Mm8zSVdhczhiNytVVE1DMGR2M2U1OEdaaFJkdzNONkRMV3gzUVhp?=
 =?utf-8?B?RGJ2STZpU1RvS2ZkWkl6QVF3UTlvUWFVakFkeWdnZmpzdjd0eDhUSmZUYkhj?=
 =?utf-8?B?R25SYi9xSW1UNzRDdlNwRFpDanNscUlkQVdqOWludnEvZnc4b1lYTDRkYzlR?=
 =?utf-8?B?V08xN1FxUmZ6bzNadFVWZWprYmVLbzN5TlJHdXBoeTVHUE1EcHhON0F1YmVT?=
 =?utf-8?B?SUJVSEl5cTJER2JHYWJmRHRRNEx4UDdwcUtBaEtFckQ2K3F3K3R2eHdXMllv?=
 =?utf-8?B?UmxnbHM5dWcvTnpDREJqSlA0MDhxeEtyc0ZhMlZSWFRCdEtpVzVQSkJ3SjEr?=
 =?utf-8?B?REFZUkhEdE9kMDVSbGY2TzFyajJkZEhtek92bE9KRi9tOGo1MzR0cGJXKzhD?=
 =?utf-8?B?QnFEQUwydUZjbGxOakhFL055cEx1Nm9GNkV6Rit3alJYZXJlcVU3YWFMS290?=
 =?utf-8?B?VERPOTdCVmd5Z2YraWN4eXBHYTlibkVFVzJ6Ukh3Wml1c1hLQlZ6bFRXTDlk?=
 =?utf-8?B?eVdYV2JreTdSUU1kU3N5SUEveEQyY0tzeEQvUU5WWnRQdk13R3VxNUJrNGZT?=
 =?utf-8?Q?+8Cn6PLVjbtDsPw0SZkPdAivI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S09VV2xlMjBvYmRYWHlzekkyb3BkOW5WNGFBRzVTZmlYRmtpc1pGVHNPM2x6?=
 =?utf-8?B?RkZtYXpQbW4wczcwSkFJbklxZzJhcW5vOC81Uy8wdzhPUUF2U1FKQXkybDJ6?=
 =?utf-8?B?bjNzMzhPNjgySk5KYURPeU9uUE5hL1p0Rm9JS3YvaldWZklyK09PSXdDZUdJ?=
 =?utf-8?B?enZBanpucDI4MDZnb0hGRFQzZDJ1c2xhRFIveFRuUmc4d2ZWM2pnd0xwQTdO?=
 =?utf-8?B?ZkxjNW4yWDJ0YU9ML0lINW5NejdqN2VqSFNOZjRQM21NWHhKYWxNV2c5VEdr?=
 =?utf-8?B?S0JlaVpvQWZudnh0ZFhyWDM3STZhek1CdGp1RVg5MmU0VENTcU5XOGFmUTIy?=
 =?utf-8?B?Nlh1V0Njcm9Zc2xONUxDU1RLcHRONTZGTE9Ob1dJRkdHeUVjZ3RNMHgxSDJt?=
 =?utf-8?B?K1BRV2ZzYU8vbHJjN3NjcWlQOW1UbHJDYjMvdjlJbXhRaE5IY2p3blRFMDF0?=
 =?utf-8?B?djIzMHh6U3p1Vlh0bHlvdjJCWU5PTzdCU1VKdVYyL0d1VTBzc1ZxdFc1bWNi?=
 =?utf-8?B?S0MrakNta29VU1RVTmVZYnVVMFlEeXFRTktwWk9kckpNenZXVURNS1UyeVNa?=
 =?utf-8?B?L0ovOExIQjVvYkdHbFphUUpoZW5rWFNwaDdQdzVBeU42ZGQ4YVdtNFNVMzZm?=
 =?utf-8?B?K1AxeSt4VUIxRXFYVXUxMnVESUhOaU8vaFNKZTRaTExEZnlPUFcwQlhEbkky?=
 =?utf-8?B?YkZFbms5WC9LTzFhT2Fsd0VBMC9Tb3lmdURscWh1Y2NYYWdQRm8yYlN2MlpT?=
 =?utf-8?B?TVRhblI1WWpiZzZkQ1VVVXAxbmtGR3FtMCtQVGlLdGh3RGl6ZTFzVVk0TWps?=
 =?utf-8?B?Z3Z1UDQ1aXE0OW5haVQ4MjEvTTRSWHZ2TTA0aythZTR5TFk2MkhrM0dVckhz?=
 =?utf-8?B?ZC91UVdjbVBJc04veS9PSm5ySWpHSEprTnI4Mk1PeGQ1Mm1oZmovSmRvNnZi?=
 =?utf-8?B?V0M1NC8xNFNnVzlPRmZ5RE9CWHNmdzdzQkl4am9OOWhVdlNSVWRoL3ozeWJa?=
 =?utf-8?B?amNnOGRxSytxY2NuY1orcHBOZWJXYXNsamtYUmZSV0N0YU9VMzc2ZW8wV3VE?=
 =?utf-8?B?SnpQSUNQK0lLemFpcEZGaktDQnhWRUxJQ2c3UTc1UDJxeHdFalNyN3QxZHJz?=
 =?utf-8?B?N0lEMWRqRG5SMXE5OEtEL2sxV1FDaGg5bTArWWpSTTZJeEVwSXBUN0xTeENj?=
 =?utf-8?B?YUF6ZnovUWY5Lys3Snl5R1VEbXlyTWVraHQwSTdIQThZTVUxUkRUaEV6WVBE?=
 =?utf-8?B?THlIZjVqYjZXYjdpUWxYaFJsNy82am9yVHpWNnBzQXhlKzlMVzAxNmpZUHcz?=
 =?utf-8?B?WHd6WDRmb1RaaU05eWhlRDZzbjYzVW04NGhCTjNMdXVTbzZIZGYwN0Y5QUt3?=
 =?utf-8?B?Uy8wMmduMlg0bFk0dTltUWhqdVFGSGs5NW0rUldTZWE5eVFKcUZuSWkrQitB?=
 =?utf-8?B?UmNMQVdNczYyUWdoVkVDK0dDSjlkK0dIZnBwd2psY2UwdDhBbUFPOFR1akNE?=
 =?utf-8?B?RmxYUTRHNDQ4Q3FBOTJOekpjN0VyTGVYbE44SzluY1luUWxtRFRTWjc5YlVj?=
 =?utf-8?B?dGxkM05QQkhyTkpsS2Fkd08yNDY5RlRjTkRJWXdHQ3pTdE5Zc3hiRnFDMHZ6?=
 =?utf-8?B?a1ZOTTRQai9aSHNJKzBUaWlkejgwaFJWRk8yQXAxdXVNZWp0VnlFb1VDWUh1?=
 =?utf-8?B?NnVUTlFtK1I3aStMSlNQVUo5MFllOHFRam5leXJBcWxNajFZR2c2ampsLy9q?=
 =?utf-8?Q?56xM/OXplthWf813dU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2019e00d-dc5b-45b0-40d8-08dd5ee8ca38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 09:00:07.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5915

DQoNCj4gT24gOSBNYXIgMjAyNSwgYXQgMjoyMeKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA4OjQ0OjE2QU0g
KzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gDQo+PiANCj4+Pj4gT24gOSBNYXIgMjAyNSwg
YXQgMjoxMOKAr1BNLCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPiB3cm90ZToN
Cj4+PiANCj4+PiBGcm9tOiBQYXVsIFBhd2xvd3NraSA8cGF1bEBtcmFybS5pbz4NCj4+PiANCj4+
PiBUaGlzIHBhdGNoIGFkZHMgYSBkcml2ZXIgbmFtZWQgYXBwbGUtYmNlLCB0byBhZGQgc3VwcG9y
dCBmb3IgdGhlIFQyDQo+Pj4gU2VjdXJpdHkgQ2hpcCBmb3VuZCBvbiBjZXJ0YWluIE1hY3MuDQo+
Pj4gDQo+Pj4gVGhlIGRyaXZlciBoYXMgMyBtYWluIGNvbXBvbmVudHM6DQo+Pj4gDQo+Pj4gQkNF
IChCdWZmZXIgQ29weSBFbmdpbmUpIC0gdGhpcyBpcyB3aGF0IHRoZSBmaWxlcyBpbiB0aGUgcm9v
dCBkaXJlY3RvcnkNCj4+PiBhcmUgZm9yLiBUaGlzIGVzdGFiaWxpc2hlcyBhIGJhc2ljIGNvbW11
bmljYXRpb24gY2hhbm5lbCB3aXRoIHRoZSBUMi4NCj4+PiBWSENJIGFuZCBBdWRpbyBib3RoIHJl
cXVpcmUgdGhpcyBjb21wb25lbnQuDQo+Pj4gDQo+Pj4gVkhDSSAtIHRoaXMgaXMgYSB2aXJ0dWFs
IFVTQiBob3N0IGNvbnRyb2xsZXI7IGtleWJvYXJkLCBtb3VzZSBhbmQNCj4+PiBvdGhlciBzeXN0
ZW0gY29tcG9uZW50cyBhcmUgcHJvdmlkZWQgYnkgdGhpcyBjb21wb25lbnQgKG90aGVyDQo+Pj4g
ZHJpdmVycyB1c2UgdGhpcyBob3N0IGNvbnRyb2xsZXIgdG8gcHJvdmlkZSBtb3JlIGZ1bmN0aW9u
YWxpdHkpLg0KPj4+IA0KPj4+IEF1ZGlvIC0gYSBkcml2ZXIgZm9yIHRoZSBUMiBhdWRpbyBpbnRl
cmZhY2UsIGN1cnJlbnRseSBvbmx5IGF1ZGlvDQo+Pj4gb3V0cHV0IGlzIHN1cHBvcnRlZC4NCj4+
PiANCj4+PiBDdXJyZW50bHksIHN1c3BlbmQgYW5kIHJlc3VtZSBmb3IgVkhDSSBpcyBicm9rZW4g
YWZ0ZXIgYSBmaXJtd2FyZQ0KPj4+IHVwZGF0ZSBpbiBpQnJpZGdlIHNpbmNlIG1hY09TIFNvbm9t
YS4NCj4+PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXVsIFBhd2xvd3NraSA8cGF1bEBtcmFybS5p
bz4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29t
Pg0KPj4+IA0KPj4gDQo+PiBGV0lXLCBJIGFtIGF3YXJlIG9mIHRoZSBtaXNzaW5nIG1haW50YWlu
ZXJzIGZpbGUgYW5kIHN0aWxsIG5vdCByZW1vdmVkIExpbnV4IHZlcnNpb24gY2hlY2tzIGluIHRo
ZSBkcml2ZXIuDQo+PiANCj4+IE15IG1haW4gcHVycG9zZSBvZiBzZW5kaW5nIHRoaXMgd2FzIHRv
IGtub3cgdGhlIHZpZXdzIG9mIHRoZSBtYWludGFpbmVycyBhYm91dCB0aGUgY29kZSBxdWFsaXR5
LCBhbmQgd2hldGhlciB0aGlzIHF1YWxpZmllcyBmb3Igc3RhZ2luZyBvciBub3QuDQo+IA0KPiBJ
IGhhdmUgdG8gYXNrIHdoeSBkbyB5b3Ugd2FudCB0aGlzIGluIGRyaXZlcnMvc3RhZ2luZy8gYXQg
YWxsPyAgV2h5IG5vdA0KPiB0YWtlIHRoZSBkYXkgb3Igc28gdG8gY2xlYW4gdXAgdGhlIGNvZGUg
dG8gYmUgdGhlIHByb3BlciBzdHlsZSBhbmQNCj4gaGFuZGxlIHRoZSBuZWVkZWQgaXNzdWVzIGFu
ZCB0aGVuIHN1Ym1pdCBpdCB0byB0aGUgbm9ybWFsIHBhcnQgb2YgdGhlDQo+IGtlcm5lbD8NCj4g
DQo+IFB1dHRpbmcgY29kZSBpbiBzdGFnaW5nIGFjdHVhbGx5IHRha2VzIG1vcmUgd29yayB0byBj
bGVhbiBpdCB1cCBhbmQgZ2V0DQo+IGl0IG91dCBvZiB0aGVyZSB0aGFuIGp1c3QgZG9pbmcgaXQg
YWxsIGF0IG9uY2Ugb3V0LW9mLXRyZWUuICBTbyB3ZSBuZWVkDQo+IGEgZ29vZCByZWFzb24gd2h5
IGl0IGlzIGluIGhlcmUsIGFzIHdlbGwgYXMgd2hhdCB0aGUgcGxhbiBpcyB0byBnZXQgaXQNCj4g
b3V0IG9mIHN0YWdpbmcgZW50aXJlbHkuICBTbyBhIFRPRE8gZmlsZSBpbiB0aGUgZGlyZWN0b3J5
IGZvciB0aGUgZHJpdmVyDQo+IGlzIHJlcXVpcmVkIGhlcmUuDQoNCkkgc2VlLiBJIHdhcyBvZiB0
aGUgdmlldyB0aGF0IHN0YWdpbmcgaXMgbW9yZSBvZiBsaWtlIGEgcGxhY2UgdG8ga2VlcCBiZXRh
IGRyaXZlcnMNCj4gDQo+IEFsc28sIGFzIHRoaXMgaXMgYXQgbGVhc3QgMyBkaWZmZXJlbnQgZHJp
dmVycywgdGhpcyBzaG91bGQgYmUgYSBwYXRjaA0KPiBzZXJpZXMgYW5kIG5vdCBhbGwgaW4gb25l
IGlmIGF0IGFsbCBwb3NzaWJsZS4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=

