Return-Path: <linux-pci+bounces-23234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A0A582C1
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFC63A835D
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D0D198823;
	Sun,  9 Mar 2025 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PU9HUccZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE88EAC7;
	Sun,  9 Mar 2025 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513298; cv=fail; b=dtqs9T6mw1AAYO9urKBPjsznMoYH7fJe+cs1N0mUZVuE8t+vGoq6aAU+syhtHU1vws5NO0wgMnVfLVODJ0K3OIdyYE9WPXR+9RhIP3i76fxLr9HuRadPxk2iauqR8LcI7mS6LAAGow/CGi3e1757Qr23ECVomIZhbDFfL2Wk8wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513298; c=relaxed/simple;
	bh=ypE2dHWyyHHl6dzXKFzMb4MQN3zLxBm7WFbY3HFeoKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gz58zGJJsidi+9yC5E/lx8GXAV6gGs2dTmCxQh4+QEaYvUrSAq/NhuaVp/zj0WwJq/7YVMhMzsScmmGVulvTLaiTCubf+ty2zx3fQtWjkxGAJf+1skUj6VxIkWXARc5/MwcreOgSud9j/K0u9mOaAo7mv5HRaIw+ODWWoKl47mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PU9HUccZ; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxCIBrkMCKc0dHuvJYCHszB3zIOrgczIcJ1/ansCu1ea+tFtDLx104BQat/myyLOonxzk0tpqGl1dwg8rsF8+6smG38PAwVZAx3r+UTMoNITolxCtinXh1hySEAkc24AJa7OqQSSTGwfobGZ8zqEh9qmuzhwnKPnhB5jH0DgqoMFOSqvS83IiwV0SqKiVEB6Agcw6Eg9tKhgnz8HmfV07oO9aWBGbM+g6o2a6NZk2wzjokh8Ao+ZcGwh/QsMLhq1HBlz9Je2boSQRN3slzZrqJ3h5ygeYVMmd1kVKuFvVKNOlkCw6v/veW3Mi9w0Xb4bdPFBHUfWBmqocblTHtoKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypE2dHWyyHHl6dzXKFzMb4MQN3zLxBm7WFbY3HFeoKk=;
 b=K1lBqUv62yiAqjzmchedbngBsjNsR1zXNEkoKIIyV0S68/IP3M4PhFacHhnqIEdGUMLXnbnMbdlAZUHqwrd3VSYXnesxSRuJFoT93ji3dU5uOHoHS31HdZUBlCSaiG6xvWaqQoEqJYf872dcjvds+vGjEMoWsIPR9ZUaxxzJBnY/me7ivmpZ5qqx88iyCbf7N3GtGcQJPMFQkTpSOn2dlNPwHjwIMK4HHStydnVacUg3wPWBqzVMvGOUXp6zUZ5EVrDi3dHa30iJKYSaCTcfmeuNyULh9ehPMqM7c9vwkeUbTpIgCkW0CDqlNZd9CN+0Onn2dLPMfjrKfML8y0qHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypE2dHWyyHHl6dzXKFzMb4MQN3zLxBm7WFbY3HFeoKk=;
 b=PU9HUccZGWpZcHZwY+xny9R+Xef8gHzqpI4scyR3Lht8vRLoFcphsBxDQU92z5CiY7SJ2bcaipOhPz3RQF9DUdMUxIT7jvuN8Lys9pSeP47Gjq/2I88W0dEt5ypXQXFyCtpYa2ClY8mk0SfLiOQ9wo5d1MP9qhEw5pCgVIaDBrRiBk7R6fp745DH6LqshlCHctbwdOjyII/9FwixjyVMuXMYsBh9Wu5YLdTTaDSfmPdhLjTUrj4yF+JV+g+g/Rg33qivh3z4RcAmsSG4gpBuBLNlxXy7ofraOYpT/umsJbJIWfTSBsOWdGx4sdSvrwNt1fKId/8FN4UGX88MqDsD+Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9292.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:120::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 09:41:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 09:41:29 +0000
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
Thread-Index:
 AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNqf5kAgAADB4OAAAMjgIAAA7jxgAACxYCAAAD/gw==
Date: Sun, 9 Mar 2025 09:41:29 +0000
Message-ID:
 <PN3PR01MB9597F040DD8F5A9B1A65B397B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
 <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030937-antihero-sandblast-7c87@gregkh>
 <PN3PR01MB9597F037471B133B54BA25BCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030935-contently-handbrake-9239@gregkh>
In-Reply-To: <2025030935-contently-handbrake-9239@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB9292:EE_
x-ms-office365-filtering-correlation-id: 17c994d6-b469-4783-ebe7-08dd5eee91d3
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|8060799006|461199028|6072599003|7092599003|19110799003|12071999003|21061999003|3412199025|102099032|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVpUOGk4cnZpQ1RxUWRIN0JkTDM5ZXFXU2NQU2grVHlzRWJRc0craWZrcXR3?=
 =?utf-8?B?eDhOL0dRS00zcGtZR09HRktORnRSKytoc0pEMzVoSWdCaklnQ2JGcXExMXBH?=
 =?utf-8?B?MW5yN3E3UWFRT3RqWDUwMGNESllZYXpYRDJtWjdlTlpvVFFGY0hiRUt6WFNz?=
 =?utf-8?B?UFcxL0pQV0xBeHhPS05hVVlYTGdEeFhGWW5aWnh1NE5IK3p6dmNLRkp5Zllu?=
 =?utf-8?B?ZHRmTVlRNXlDeUw2Z2JmbkZRcWpFOTl5RjNxMSs0ZThOdzRURDErR24zTkZI?=
 =?utf-8?B?bmpzQVNGOFJwRk41ZFZTRDBqSTBTdi82dWxJa1h0ZHcwOXY4a2NMZXFHb2g2?=
 =?utf-8?B?dkt0V1RBR0p3elFMMnFXVzZpRlhKQjBoeGoxSk5HeDc1QWwzMWpra0E1enpo?=
 =?utf-8?B?NFhxa3llYjFCZTNpbkg5aEJxYW1UNlVrS2ZpQ0R4Y0pWQ242S0ZnUU43UVZx?=
 =?utf-8?B?VHVqUWhzdmpmSmE1ZUI5RDdWdVpDTFJENjg4b1ZaSEVOelcyYTNtdVpQajNl?=
 =?utf-8?B?QWZmaHJ1VHAwR0dJQ2Z1NXB2YmRidEZhVWNSWVE0SUk0TWVDNVlhRWpZRk91?=
 =?utf-8?B?U0lHSWNQQ3MyaUlPeGdGMSs3LzhBWnJMcDlLdjM0K3k1NG9ZYitxRFd6TzBE?=
 =?utf-8?B?dW5qU0N2dmFFVExGVEl0dWt4Vm5LTG9wb24vWElpeWNDdE54WGtxa29zRTJt?=
 =?utf-8?B?cVFjVkt1NGgwTXFycUNaQWoveWFhR1E4Q3pLejlwcFpWS1FUZXo2Smp6L2R1?=
 =?utf-8?B?Tjh1TWNnNkJVeE9NVUJWMWtqd2cxOG8yckwrUDc1blJyZ2U4L0dPZDZ6QUZD?=
 =?utf-8?B?Nnhld2srSHY5Z29TNTJSN3FsWWo5QTkzaWttOFptY3dOUnczRjdvYkZFQWQ3?=
 =?utf-8?B?dEdQZ3duZ1dUYXY3Vm96cWdMMm1JT1J2U3VvaVFweEg0L2NyMUxYN0JPN3M0?=
 =?utf-8?B?VTlSVVFZQTBuUUhjcm00U3gwWUhoR05HSEV4SVRCb1B2Zzl2NitsdEQwZ2hF?=
 =?utf-8?B?a0MxOFZ5SmhaeSsxVzMrVDJidk9Eajdqb2NvK0MraGc5d0lsdndtYjhhYXdC?=
 =?utf-8?B?THYvbWNUNktBQitXUEh1OGhSM0lYZlp4RE5mQVhNUTQ4NXRSbkJsOHhBY1I3?=
 =?utf-8?B?Rzd4WnV0TG5md3hVRHltRXZONjlERFlGMHZLYjQ2WHVIbDBnU1BTUThkbWMz?=
 =?utf-8?B?ZjFxWTNtUkpuNUY2TnZOenJFa1plV3NFb01NeFdnZDBQRzJWdGtpUGZ2WGp4?=
 =?utf-8?B?eUVzYUxpSkFoMzM1TC9HRnpsVjBmMnVkbWdyYVFqVnh1amN2MTZuMk4wTEJL?=
 =?utf-8?B?cTlnWXRGOUhpTjFRSE8zMnhoRi9oNEF3U0Z0a1VYTjQ2QnBrc1NSUm0yOUJT?=
 =?utf-8?B?dVYxNVJDRm9lZVU0S2ZselRZZm1Pck1EU0F2NE1PYStQWjhxZVQvZllqRUlG?=
 =?utf-8?B?RHlaTmhsZzhkMmVUdnRPbFc3cnFxeUovVm5ucFFTTmdWV0trMnlkNC9wNUY3?=
 =?utf-8?B?ZmppWUMrWW9nUXZkUjJoOVlzejA3WVNyd3FGck1DSXE4MFRhWVlmMCt1QWpo?=
 =?utf-8?Q?iQ6HapNVUyn6nerh0yvH2amOA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGR5ZFBUYnAyTmpBY0ZhTUNhdVVkaVFIN01xZmQzNzEwSUpYL2JMOFc4R25M?=
 =?utf-8?B?NUw2bWtYMDNPbHNRM0RqWnA1Q1Ztd2NYcUtTb1NuZm5ZaTNUTFE5ejU4cCto?=
 =?utf-8?B?azUrQ3Rqd1ljWFFsdWZOYmVTSnpvS3UyTkptUDRtRFdnend4SE9KeTlxcm9N?=
 =?utf-8?B?VG5pYXBMcGdwRENtOVVhWVVRR0lqSU4rS3QvWkNXd2kzZllUOTlNbXBYb1Ew?=
 =?utf-8?B?SklPcXVacW5uZUhRK0RhM0hwQS9KckpxcEg0aW96SEMrVXUzNU5jUUMxSzJr?=
 =?utf-8?B?OUlXZ2pwT25Wb2xzVVBGTzBjWm1PZERYckUxUzg4ckRTcVdhT0JUekhUbWVG?=
 =?utf-8?B?NDFPcGZKRkdWbFIvNXRTZmxTS0Y5SjZFcmlvYTliTXZmMzF1SXRrbDRMVGsw?=
 =?utf-8?B?ZEdTMjRPc0U3VFhMQ2JrWHRLN2d3eFlDY3BKUCtlK21QVTQwZFl5U2lyTVBV?=
 =?utf-8?B?QWJ1LzVOOHdudFlZc0ErSWpic3MzVGlPQ0RaVzZLQ29hSFgrKzhxcm0vWjBn?=
 =?utf-8?B?b2RwSC8zUng1bTRobmRsaEp5bVJMY05mTmMwSUxPZ2JlanpnNlp3aFhBNExn?=
 =?utf-8?B?MC9VdkJ3QmJOaXpHZkgxOTBVV3Z5a1pJYVV0T1NzS0cvNml1WjRIREk2UHMv?=
 =?utf-8?B?Wm13TVJVYjlUWU9WbkYrTFNlMkV0MHRjYTJXb1JmMVczSjQ5eWJKOTVEYkE0?=
 =?utf-8?B?MkRUeUFDbFcvMTkzcDc4dWlUNzZrNTV5bFRDVmpudm52MEJYNUhLdVMxYXRC?=
 =?utf-8?B?WlYxK0lpY29jRDA3RXJRTlFjaGI1amZjRG9pc2RTUERjWGNxQlc4bTJPNnNh?=
 =?utf-8?B?UlNxek9QZ1JmMHR1OFZhQVBTVDBqTXhsamlBcHNpTnBWZFkxODNHVU5FejNE?=
 =?utf-8?B?WDNqQ1FHQ1BZbkZkVDRnT2Q1MVd0RWJyRHlhcklzUy9rLzRWb3JsQXFIOUpr?=
 =?utf-8?B?U0hWQ3N0ZnovRlIza2F1UGFiajkxKzBZL0ZnRlltS1JtVWwveEhaQVk5ZUk4?=
 =?utf-8?B?Q3U1UlBYaU8zMWw2YWN1WWt6cUt4SUM0bjkzbG5JTG9qUys0aE5mMlB6dmw3?=
 =?utf-8?B?SEV2VXlrSXZKSm9OYy95RGgyZ1h6YmVMMWNlQ09ObXl2TkJKYTRPQ1J5WnNi?=
 =?utf-8?B?c2t6Qmw4RExhQWthY2NJZ0NYdFRyMXZQVEd0c0RWdFVlczd6MEpqTDhVcTl5?=
 =?utf-8?B?SHdGWWkzaE16RnVIRlRZcmxLVm00TnVHOTZPTGhMU0hKN2dSdm56YUdNbGRJ?=
 =?utf-8?B?dCt6NHVpaUVHL0ZzblhGbExSYVJpeFI3blhGUStMa1pQcjNMdkZUZmNrMHBt?=
 =?utf-8?B?MEdIZXRjWFpuU2MwY214RkRsWmtLQ251MkFoMHVBRHNpNWRTUGdtbTZLWDFp?=
 =?utf-8?B?MVlPVWU1RDgyS2RpU29lNExtek5mNkV0WFdxM056My85cHQyVVBMdUhuSldv?=
 =?utf-8?B?S2JUUldwRFpPYVg1dTJ6QkFFYiswSmVyRjAvOTYxM0dERnBUYkFmaUJtYjI4?=
 =?utf-8?B?SEFjaDVHdzltRXVmM0d4dnZQR0xNN1RWRDNwNmdZMDhHZWxIbWRnNkhHbjBG?=
 =?utf-8?B?VzhnY2t2UGEra0FGQ2N6VGloVFVpTUUyRzJJYTltM2phY0l1eFJzMjFxenJS?=
 =?utf-8?Q?O5lbsPYezT+fJwT6UvrXmatuUnR/R9lNpoX5keHxYilk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c994d6-b469-4783-ebe7-08dd5eee91d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 09:41:29.8113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9292

DQoNCj4gT24gOSBNYXIgMjAyNSwgYXQgMzowOeKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjI4OjAxQU0g
KzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gDQo+PiANCj4+Pj4gT24gOSBNYXIgMjAyNSwg
YXQgMjo0NuKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+PiANCj4+
PiDvu79PbiBTdW4sIE1hciAwOSwgMjAyNSBhdCAwOTowMzoyOUFNICswMDAwLCBBZGl0eWEgR2Fy
ZyB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4+IE9uIDkgTWFyIDIwMjUsIGF0IDI6MjTigK9Q
TSwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IO+7v09u
IFN1biwgTWFyIDA5LCAyMDI1IGF0IDA4OjQwOjMxQU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3Rl
Og0KPj4+Pj4+IEZyb206IFBhdWwgUGF3bG93c2tpIDxwYXVsQG1yYXJtLmlvPg0KPj4+Pj4+IA0K
Pj4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIGRyaXZlciBuYW1lZCBhcHBsZS1iY2UsIHRvIGFkZCBz
dXBwb3J0IGZvciB0aGUgVDINCj4+Pj4+PiBTZWN1cml0eSBDaGlwIGZvdW5kIG9uIGNlcnRhaW4g
TWFjcy4NCj4+Pj4+PiANCj4+Pj4+PiBUaGUgZHJpdmVyIGhhcyAzIG1haW4gY29tcG9uZW50czoN
Cj4+Pj4+PiANCj4+Pj4+PiBCQ0UgKEJ1ZmZlciBDb3B5IEVuZ2luZSkgLSB0aGlzIGlzIHdoYXQg
dGhlIGZpbGVzIGluIHRoZSByb290IGRpcmVjdG9yeQ0KPj4+Pj4+IGFyZSBmb3IuIFRoaXMgZXN0
YWJpbGlzaGVzIGEgYmFzaWMgY29tbXVuaWNhdGlvbiBjaGFubmVsIHdpdGggdGhlIFQyLg0KPj4+
Pj4+IFZIQ0kgYW5kIEF1ZGlvIGJvdGggcmVxdWlyZSB0aGlzIGNvbXBvbmVudC4NCj4+Pj4+IA0K
Pj4+Pj4gU28gdGhpcyBpcyBhIG5ldyAiYnVzIiB0eXBlPyAgT3IgYSBwbGF0Zm9ybSByZXNvdXJj
ZT8gIE9yIHNvbWV0aGluZw0KPj4+Pj4gZWxzZT8NCj4+Pj4gDQo+Pj4+IEl0J3MgYSBQQ0kgZGV2
aWNlDQo+Pj4gDQo+Pj4gR3JlYXQsIGJ1dCB0aGVuIGlzIHRoZSByZXNvdXJjZXMgc3BsaXQgdXAg
aW50byBzbWFsbGVyIGRyaXZlcnMgdGhhdCB0aGVuDQo+Pj4gYmluZCB0byBpdD8gIEhvdyBkb2Vz
IHRoZSBvdGhlciBkZXZpY2VzIHRhbGsgdG8gdGhpcz8NCj4+IA0KPj4gV2UgdGVjaG5pY2FsbHkg
Y2FuIHNwbGl0IHVwIHRoZXNlIDMgaW50byBzZXBhcmF0ZSBkcml2ZXJzIGFuZCBwdXQgdGhlbiBp
bnRvIHRoZWlyIG93biB0cmVlcy4NCj4gDQo+IFRoYXQncyBmaW5lLCBidXQgeW91IHNheSB0aGF0
IHRoZSBiY2UgY29kZSBpcyB1c2VkIGJ5IHRoZSBvdGhlciBkcml2ZXJzLA0KPiByaWdodD8gIFNv
IHRoZXJlIGlzIHNvbWUgc29ydCBvZiAidGllIiBiZXR3ZWVuIHRoZXNlLCBhbmQgdGhhdCBuZWVk
cyB0bw0KPiBiZSBwcm9wZXJseSBjb252ZXllZCBpbiB0aGUgZGV2aWNlIHRyZWUgaW4gc3lzZnMg
YXMgdGhhdCB3aWxsIGJlDQo+IHJlcXVpcmVkIGZvciBwcm9wZXIgcmVzb3VyY2UgbWFuYWdlbWVu
dC4NCg0KWWVzIHRoZXJlIG5lZWRzIHRvIGJlIGEgdGllLCBiYXNpY2FsbHkgZmlyc3QgZXN0YWJs
aXNoIGEgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSB0MiB1c2luZyBiY2UgYW5kIHRoZW4gdGhlIG90
aGVyIDIgY29tZSBpbnRvIHRoZSBwaWN0dXJlLiBJIGRpZCBnZXQgYSBiYXNpYyBpZGVhIGZyb20g
d2hhdCB0aGUgbWFpbnRhaW5lcnMgd2FudCwgYW5kIHRoaXMgd2lsbCBiZSBzb21lIHdvcmsgdG8g
ZG8uIFRoYW5rcyBmb3IgeW91ciBpbnB1dHMhDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGst
aA0K

