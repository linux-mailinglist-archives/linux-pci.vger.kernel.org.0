Return-Path: <linux-pci+bounces-23237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A0A582D6
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688783AE83A
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753751B2EF2;
	Sun,  9 Mar 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="P0jIwny1"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011037.outbound.protection.outlook.com [52.103.68.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C41AC43A;
	Sun,  9 Mar 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513971; cv=fail; b=CLd0WouAEV9ea/ilK8Z1EK2Eyd09+3ueR8AMMQxcTr+UHZSm1b0XHdXbeBjY559BblUfzibZrZDg0FRv1zAkn6NINEKapOAi5pBBgVCMVwLlOgaVuSqsBo8n/I4gxicF39RqBFGP7zxNmoxckRnCNpNhKhw5a6aHpBVGiQNcHSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513971; c=relaxed/simple;
	bh=AxRus2bx0DmIsPqRVIPZUi3dgEnXh6AaC92JckDvKRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K9jSilTZZbDGfMqhpLXeRzoiW9sqAHwWnBpqm6U6nZU2BcBl64CYj2Cqf7HwXcrjrJpihWM/DDqTEXMD1eS1yKrBRzJIbLjryEQ96nOWcLwyWIGgKVoo1+7a1y7cJxGZrgcQM5LES5yQUZqaanwd5Mv4zYhdFefGqA74PxT4MV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=P0jIwny1; arc=fail smtp.client-ip=52.103.68.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPgZCD3go1blmtVgc9cHH2DhSF/0oQSAHYkI5fOLveLTN+AfrQNcXBaIW6kf7Q/SzVRDBl2zrA76dWR9TuXl5fQYxQgfuIZLEexSdrR8N+oZHKB3TIxRKxJBTDwYLyshJU5tKb/3FHzewfN8mjvgMUowLkQ02vr7R2z3Begsiptq6xZ3yzN1Zklu6PqTJ6/QpfBSIGyVn0Vj+mpInFcReYXdutBrxbH5oPiiggzXqwz/8U4NXa5LFAomLxKW8hjsq4+dKmsQ6uFsFxdBjej7/tgJ3tf90Rhr98dPafFMsspa0EjuepcidEd9vWTirA5bJazz1l0OxQv/R2ND95U+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxRus2bx0DmIsPqRVIPZUi3dgEnXh6AaC92JckDvKRY=;
 b=QLNn6V+T09RY6CplFgwu5SDL7PGN3686KZOItgPNc3BJGX2a193w9mcVuo16uxRdF2QzqjyCStRTb3D2cBlQAtJ2+gWCWG27khk7NjGqZ9rsU+BAD+Q/zsf14x6W1NmrqJc9xqGNqtItu1C1Rp5cJ6gQQtRANXNMEYFN5LSf7pL9CtiEDKh/aDBcuVAVQ1uUlg9aBHXoAA1t3JjzPG+T6WZA5vbJ+7xwXlYNUlu2GH8QZaBzwn/FrwWFDTo7WjduVmYFATTe8UFyLmA5WY2MJWZ0ijvYYQ/idCQwqVnvMDoItcZD/7OPEdO8LkhhjY055989/U0Z2hiLA5xU3I6o5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxRus2bx0DmIsPqRVIPZUi3dgEnXh6AaC92JckDvKRY=;
 b=P0jIwny12OqfL07fYgyvCag0nORw8HTV+/txp/KA2Ez8MczdMopUXsaj8IqIkINzoNHXfqI2UUVOL5JrTPzbkFmUsxGz2OeJzQ3hplBkcAGJEKVzxMS81+G2U+d6MkX5D7GjbKMPGq5sOH8Gubk1fBt1Ea9i1VhjVdlfxIgUe8mo6Lb+i42kV1fDko3I3w1B82ydjiwhUtmdxWFm9h0S0IMbx3QuyMlDQRM/KhWW0YHfatGFKjIYB/WCDrlnVAh4KDwf6Xhj/XbxONyHDKyR8g1/fk6PtFefyZ8nazqtOF9wuulqXp6ePlixu34/ZJ1bTwfUWF3sDqGjJOvZHmdcjA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB10117.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 09:52:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 09:52:43 +0000
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
 AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNqf5kAgAADB4OAAAMjgIAAA7jxgAACxYCAAAD/g4AAAhAAgAABE5Y=
Date: Sun, 9 Mar 2025 09:52:43 +0000
Message-ID:
 <PN3PR01MB95970E60B250F91CA8E12720B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <2025030931-tattoo-patriarch-006d@gregkh>
 <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030937-antihero-sandblast-7c87@gregkh>
 <PN3PR01MB9597F037471B133B54BA25BCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030935-contently-handbrake-9239@gregkh>
 <PN3PR01MB9597F040DD8F5A9B1A65B397B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030909-recoup-unafraid-1df0@gregkh>
In-Reply-To: <2025030909-recoup-unafraid-1df0@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB10117:EE_
x-ms-office365-filtering-correlation-id: c6a043bf-69f0-4d28-9f20-08dd5ef0233e
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|7092599003|15080799006|8062599003|461199028|8060799006|19110799003|102099032|3412199025|440099028|12071999003|21061999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHFtR1EwMGVmcndPMnpGTExXZFhxb0tkcHo1dzFjR2Z3eTd5eXA2QUhTSE1y?=
 =?utf-8?B?OHZvcWs3OUpsNlA3KzFGcmFod2xNV0FWbk5lU05QN0EzQXhTV0dVMElrbVdC?=
 =?utf-8?B?SEhBOG1FRExPQ0pqcnpvRnE2M0krMkZYRU1WOFl6MDFyNnJCMjZTdlVmVFdo?=
 =?utf-8?B?c040OUp1YmlsQ3UzeUNPV1dqcXpycVZZYTRBa2xaaVI2bXBqbEZWS045cE9L?=
 =?utf-8?B?ZklDQjIrT2srQlZIZmY2MUJVWE9qaVFhZTEvUE9Ncy9BYy9QWFU1WXprcEU0?=
 =?utf-8?B?bTltSTJic2U2TFJEOFdGUnlJRmY0M0V3MFZHVkRFZy9aek82QW9tdlpTWGFv?=
 =?utf-8?B?d2UwWmp2K0E1aUpEMEFZRTRqVnR4Z1dRWHB6bEdoS2Z2YkllNTRLM0V0aXdu?=
 =?utf-8?B?NFZCdUVlQkNPbVVkVlAvL3dDMnczR0dWMkJWVktPaGZpYS9xNHQ3YlJJa0hM?=
 =?utf-8?B?YkRDSlNZbzhjYklMMGVyZ0YwdUdiNmRQclI2VnBHRzNwOGxVaU13VzlSQ3ZN?=
 =?utf-8?B?TEtHZmlNYjFTc0VPQ051K0c1N2VLTFZvclA3NXFLa1BWMWVjc0JscVlyS0cy?=
 =?utf-8?B?Nk1XWVBSRnJvUjNXVDFmRHNXaDFlY1dJWlZGUEJSeTA2eXJXaDhDRlNNWmt5?=
 =?utf-8?B?SXJwRGtyc3hjQmwyREsvRE4vcUl0QXhlUjNsZXBtOC9aVzZQUFp4bVNGQ1B5?=
 =?utf-8?B?bFowVENoYmRqZ0pOM3IrVzZodDA4NHFoTHpWd1lXWFdmcEt0L0Z6ck54d2pK?=
 =?utf-8?B?ejB0eFp6QlBpZStpSXEyL1AwZHVsV3Z4VGRxUHAxYTVpdExubzdhVVovSXYz?=
 =?utf-8?B?aXQydEhVd3hwQk1Oa2xNbTlFSjJRNHp1T2x2NnBIYjNIdTl6L3VCbUY4K0tQ?=
 =?utf-8?B?MFpGLy9DNGZvUEJJWWNjRGVDdHZyVUszemIxTW4vZC9HcTMyUWJiUnBGa1hn?=
 =?utf-8?B?elcza2pGUEgwdDVybVNSUE9OUHJ5YkJWSGxIRUE2NDZSNy84RVBSOUJDSjNS?=
 =?utf-8?B?d2Jla3d6dEp5U3RtaklkZjVSOHNray80bmtVSFB5NzJUR29TR0RoZDNFZG9p?=
 =?utf-8?B?UkxUM2Mxa0RKUDZaSGJBTnQ5WkNyRnpCc1BTY0MwMFZWS2twb3RmVHEvcmE0?=
 =?utf-8?B?UWM3bVB6Nm8vV0NtS1J4MTU3NnlweDU5cE9ZVDlkK3NRajNWa3M1U0pwNjhm?=
 =?utf-8?B?S1A0R1FnNlFFQjJOemZnTjN1eTRFbnVQRkI0WHljeTBwamYvcTJkaFM0Wjd5?=
 =?utf-8?B?aDNJK1Q1bmE1MGhuNzJvMHp5ZndkQ1B4R3pDamxBZDRxUHBlYU1ob1hjVFBX?=
 =?utf-8?B?T3hldmNVYXVNNWFNVzY1TStaTDI5UGtkYm83OVFueDEzd1dVcDNNeDhXbGE2?=
 =?utf-8?B?VTVkb2o2STZyV0RIN2FLYkkyZjZlNFA3SlZ5YUJTMjNteHd4eXN6RkhncjVT?=
 =?utf-8?B?MjRZb2V2OVl2UHhESnd5Z2kxYkhsWnNQL3R5YmdHU2cxTm1mTlRpdHRpYnBx?=
 =?utf-8?B?ZnJGM2QrWEJmVUpjTG5NMFRPZlh2ZmJuemQxWXAvMnhBdVlnM1F5Q01nczFF?=
 =?utf-8?Q?PZLxeSq//Zk74oeGb4L73L1r4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnBCeVF0Nmg1ZGN4WG00WnNzcWNseFVBRmxuUHYydXQ1T0pzWXdGMU9rT01X?=
 =?utf-8?B?MFNYTCtrTFpCbGNTTnJ5MHA3bnFFYmlxa1N3L29NaUdEZUVsOEtucFpNVWtO?=
 =?utf-8?B?bXFWSmM3azgwY3JqSVhOYzNJdnMxeEduM2E1RENtd0RZT0h3bHo3anp0L1E3?=
 =?utf-8?B?ZzBFOU9lS3dPZmxhOThDSUE3SC9yQk5IOXR4K2ZVTDNrTkJwQ3ZCaEdIaUw1?=
 =?utf-8?B?ejJKNGdxMnYxUEUzOThWRldBRTV4SGFaMUpTK21VSEFjeXV6TFlPRVhUOGNL?=
 =?utf-8?B?d0F2Mkp6aTRpQWpPZ05lSG9sTkJQYVJQaXJhODllRVdnT0d3a3BWcVFCWVdK?=
 =?utf-8?B?NU4zMzhSYmZXdU9zcTNDN1ZFZWRSMVorRmZuWlFLbVV1eFdhdDZFbktZMUha?=
 =?utf-8?B?eTFqT0lzUmQ5Skl1RWtZbnF3d3lJR3VjWFR1dFhOZW1pUzJ5ZFR5SXN3R1Zz?=
 =?utf-8?B?dUpSNkI2dittK05rdW4rL214YWtUR05xRUx3WlpoRVBIWDM0aDhwWXBoV3Jw?=
 =?utf-8?B?cS9uVnEzUE1FR1loQUdaekRIdnJRS2xTT0tiamRIYTBGN1NBWnBzWkd2OVNW?=
 =?utf-8?B?QVJNeG8wUFpoY0I2a2cyUERHNG05ZGVJVE95d200OHZ6bzZaZlJLTkxvUGxr?=
 =?utf-8?B?c3duTTBPeUEyS2I3QllFT0V5aTJ4cW9CdGcrVDJuT3lIbnhjMmt2QktYV1ZH?=
 =?utf-8?B?c2UrUVk5bUgyTjJOZ3UwVmpTeHlpMlVOWjM0cytOUlZIRkRlOWM4RVR3bXFp?=
 =?utf-8?B?TWlOb3ZHNDBhQldLUThidktJTVdrMmFVM3FSZGd3ZDdqTC95SE5zSHF3UU1K?=
 =?utf-8?B?a3RMaUNvckQ3a1NuZWVUTDArT3VuR0lyeHN0dXhjbkorYm5YWnFqVVhEVm45?=
 =?utf-8?B?Qis5L1hLZEp5eHJOUHdzcHZvb0I3S1BtWWdGcEZYWmFldjF1YTM0Z2kyL3FZ?=
 =?utf-8?B?aGVXQ28wQ3Z1Z2wzc21GN20rd1pOalIyOFEwQWwwaGgydVZzRjB3ZzVpc3U0?=
 =?utf-8?B?dEtSS1Y1SXQ1aE5XalU1bnlhTVc5bzN4ZkNaeHZhaTNJcG1IVG4vbU9Jb2Na?=
 =?utf-8?B?djlWOGYwMFNhSUoxbWRoNHhjd2t5cmt4YjBWUURNNFhBTGxBRnZhZzNGa0lV?=
 =?utf-8?B?R29qVlk5amduZndiYzlDd0JoNWZVVGV6bHdDZUdjczBUUnpSMHdUQXBBMFV1?=
 =?utf-8?B?b2FZL1orV2tNVHlZYmpHU1U3WDUvQUt6K0IvMER6aUEvV3RleTR6Q0l4SEFB?=
 =?utf-8?B?QTl2UXE3SXZONHN3K0p3eGUvZk1XNDM5YklpOTM3YWJ3MWY0UThsVDBySHJ0?=
 =?utf-8?B?bjZyR1VpbCt0b2FXcGdSQWlKRFFJeTZyMTh5S1lTQXplU3EydlczYmJ3dGo0?=
 =?utf-8?B?d1gzZVRzTmVZbDNEdFBZckNGTVNpendoRklWK252YTV1RjRsU2VDRHdvRzRk?=
 =?utf-8?B?Y3o4OWFYWmpkaHMreXNPeU9GTzdIMENhcUZMbmZtQjFEblczQmFXdjhJM01v?=
 =?utf-8?B?czNMYjVtVXkzOTJPYmJxc1BZMzIwVmQvNXIxUFpWdCtFZnkxWWtqemgvbmpJ?=
 =?utf-8?B?WEhxSGpnWSs0QVdtYzlvTDA5NjNtU1ZUcGZ6RFlJandrY0dDOWpURzdWMlBZ?=
 =?utf-8?B?NXJ3VER2SWVHRVJXTHFWM3lxSE9LT0JydVEwZ0ZtSlI0K3ZnWEdnTDZmSjQ2?=
 =?utf-8?B?Ymg4NCtOMlhNQVJqYWxiYjdMdFRsOXFlYzErSWNWRFFjeDAzZU1rOXJoaUNL?=
 =?utf-8?Q?livKGBlBhIpvWFT9D8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a043bf-69f0-4d28-9f20-08dd5ef0233e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 09:52:43.2755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB10117

DQoNCj4gT24gOSBNYXIgMjAyNSwgYXQgMzoyMeKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjQxOjI5QU0g
KzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gDQo+PiANCj4+Pj4gT24gOSBNYXIgMjAyNSwg
YXQgMzowOeKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+PiANCj4+
PiDvu79PbiBTdW4sIE1hciAwOSwgMjAyNSBhdCAwOToyODowMUFNICswMDAwLCBBZGl0eWEgR2Fy
ZyB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4+IE9uIDkgTWFyIDIwMjUsIGF0IDI6NDbigK9Q
TSwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IO+7v09u
IFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjAzOjI5QU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3Rl
Og0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+Pj4gT24gOSBNYXIgMjAyNSwgYXQgMjoyNOKAr1BN
LCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IO+7
v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA4OjQwOjMxQU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdy
b3RlOg0KPj4+Pj4+Pj4gRnJvbTogUGF1bCBQYXdsb3dza2kgPHBhdWxAbXJhcm0uaW8+DQo+Pj4+
Pj4+PiANCj4+Pj4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIGRyaXZlciBuYW1lZCBhcHBsZS1iY2Us
IHRvIGFkZCBzdXBwb3J0IGZvciB0aGUgVDINCj4+Pj4+Pj4+IFNlY3VyaXR5IENoaXAgZm91bmQg
b24gY2VydGFpbiBNYWNzLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBUaGUgZHJpdmVyIGhhcyAzIG1h
aW4gY29tcG9uZW50czoNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gQkNFIChCdWZmZXIgQ29weSBFbmdp
bmUpIC0gdGhpcyBpcyB3aGF0IHRoZSBmaWxlcyBpbiB0aGUgcm9vdCBkaXJlY3RvcnkNCj4+Pj4+
Pj4+IGFyZSBmb3IuIFRoaXMgZXN0YWJpbGlzaGVzIGEgYmFzaWMgY29tbXVuaWNhdGlvbiBjaGFu
bmVsIHdpdGggdGhlIFQyLg0KPj4+Pj4+Pj4gVkhDSSBhbmQgQXVkaW8gYm90aCByZXF1aXJlIHRo
aXMgY29tcG9uZW50Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gU28gdGhpcyBpcyBhIG5ldyAiYnVzIiB0
eXBlPyAgT3IgYSBwbGF0Zm9ybSByZXNvdXJjZT8gIE9yIHNvbWV0aGluZw0KPj4+Pj4+PiBlbHNl
Pw0KPj4+Pj4+IA0KPj4+Pj4+IEl0J3MgYSBQQ0kgZGV2aWNlDQo+Pj4+PiANCj4+Pj4+IEdyZWF0
LCBidXQgdGhlbiBpcyB0aGUgcmVzb3VyY2VzIHNwbGl0IHVwIGludG8gc21hbGxlciBkcml2ZXJz
IHRoYXQgdGhlbg0KPj4+Pj4gYmluZCB0byBpdD8gIEhvdyBkb2VzIHRoZSBvdGhlciBkZXZpY2Vz
IHRhbGsgdG8gdGhpcz8NCj4+Pj4gDQo+Pj4+IFdlIHRlY2huaWNhbGx5IGNhbiBzcGxpdCB1cCB0
aGVzZSAzIGludG8gc2VwYXJhdGUgZHJpdmVycyBhbmQgcHV0IHRoZW4gaW50byB0aGVpciBvd24g
dHJlZXMuDQo+Pj4gDQo+Pj4gVGhhdCdzIGZpbmUsIGJ1dCB5b3Ugc2F5IHRoYXQgdGhlIGJjZSBj
b2RlIGlzIHVzZWQgYnkgdGhlIG90aGVyIGRyaXZlcnMsDQo+Pj4gcmlnaHQ/ICBTbyB0aGVyZSBp
cyBzb21lIHNvcnQgb2YgInRpZSIgYmV0d2VlbiB0aGVzZSwgYW5kIHRoYXQgbmVlZHMgdG8NCj4+
PiBiZSBwcm9wZXJseSBjb252ZXllZCBpbiB0aGUgZGV2aWNlIHRyZWUgaW4gc3lzZnMgYXMgdGhh
dCB3aWxsIGJlDQo+Pj4gcmVxdWlyZWQgZm9yIHByb3BlciByZXNvdXJjZSBtYW5hZ2VtZW50Lg0K
Pj4gDQo+PiBZZXMgdGhlcmUgbmVlZHMgdG8gYmUgYSB0aWUsIGJhc2ljYWxseSBmaXJzdCBlc3Rh
Ymxpc2ggYSBjb21tdW5pY2F0aW9uIHdpdGggdGhlIHQyIHVzaW5nIGJjZSBhbmQgdGhlbiB0aGUg
b3RoZXIgMiBjb21lIGludG8gdGhlIHBpY3R1cmUuIEkgZGlkIGdldCBhIGJhc2ljIGlkZWEgZnJv
bSB3aGF0IHRoZSBtYWludGFpbmVycyB3YW50LCBhbmQgdGhpcyB3aWxsIGJlIHNvbWUgd29yayB0
byBkby4gVGhhbmtzIGZvciB5b3VyIGlucHV0cyENCj4gDQo+IElmIHRoZXJlIGlzICJjb21tdW5p
Y2F0aW9uIiB0aGVuIHRoYXQncyBhIGJ1cyBpbiB0aGUgZHJpdmVyIG1vZGVsDQo+IHNjaGVtZSwg
c28ganVzdCB1c2UgdGhhdCwgcmlnaHQ/DQoNClNvIGJhc2ljYWxseSBSRSB0aGUgd2hvbGUgZHJp
dmVyIHRvIHNlZSB3aGF0IGV4YWN0bHkgc2hvdWxkIGJlIHVzZT8NCj4gDQo+IHRoYW5rcywNCj4g
DQo+IGdyZWcgay1oDQo=

