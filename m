Return-Path: <linux-pci+bounces-23322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627DA596E3
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074CD1889C88
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5822CBF5;
	Mon, 10 Mar 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="AEq9ZZlc"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011036.outbound.protection.outlook.com [52.103.68.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0422CBF1;
	Mon, 10 Mar 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615209; cv=fail; b=k8/Jgj6OqaWtODwc0vQffRsFNNoxfYkFOA+7U8gyiwZtnGEPKMixagqrPaWr7koct8nHXRA98OoJrVhWuhUBa7KeTgM9B90gesOoy6iATAYMFE1tRym98ErFkN4QmJfBdSHb2SxEd9629SJi+bokNDRDN4tLwhL24TOXhAyqqCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615209; c=relaxed/simple;
	bh=ieBbQje/JzRsj1rhIukgIVoz2dE3IKtKD0QTXHC6IJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UDhuG+/3zgpn/yqu7H9ygk6tHATKczTVMt15YTJ96XFZVmuJ3PT2uSSiJPF+dZgO12cw5cZeMV8KmPfG6+97z39pUxDOWb1cIwcZGJZtQ5bqDCoh/mEE1OTA2KrdA3Kjt4u8tSwWvcB+JCbSaxzHJZvl/aJaZauAiJfgnyWpj/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=AEq9ZZlc; arc=fail smtp.client-ip=52.103.68.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvzjnv5HUczSPgdqNedFo6aHvki9GxkAI2+DV3QhiVU9jGmIWrStewjCNkuLqu3NWff2PlsF6NBP9YUxFMNcWSulnbcN3tAggksG0jjZAVqu70kQdXFxFLSioDmmy9++Yw0ciPfQep4STUqroE6jZW6zd4q4uWNSHdwEtWw8PlbIiJBzisZkpQ9FQa0z/vPYBzhVGH1wTwKB3UmzqY4L9nU6efd+0iOe1ndOb1B2+BoHxOL9W5A7dEOGXVPSUveiPK5AC1jEpP8qXGQ3dBK4fytjZjXYpZas1e+SWHxaAbysELQyT+Y7LdUNURHlaKSbO3w9ALpP+xeXf1W4mrUcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieBbQje/JzRsj1rhIukgIVoz2dE3IKtKD0QTXHC6IJ4=;
 b=WosWGEpPNNvwFunWXxwCjI+ADBv0h7psHB4JX/qTczD5xz9XGAV5J7ekWISzb4RKQKXkHtRHSNiwT5HqFXcXL4GcmMBAjtqOTARioxhKXVhifJAYUI9/HZ4JNf2CRtT3AZDk2k92ArIrn3+uUY1AGl4svs0+m+0FSCRiQMdigg8S6UM0RC+hOUNuPK4bdpwSLUzOMRbfnQxiXAxEqvtUVKCz3L+6Locu4UMnhBN9UE1MwYit3Cn3YnZN1PM7UUdm+MPcRAynweS6OrOe/VKMYwxGz+PN66e8m0k4iPgr3hkU8L1vb7zD4nFxN88MZR3aazSukWYDSywOf33Cto7zCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieBbQje/JzRsj1rhIukgIVoz2dE3IKtKD0QTXHC6IJ4=;
 b=AEq9ZZlcQt7NnPeY36REV9mr3dx1/mHJ4qtU3Cw9EiIi76X800aV7mLArMd45ndFJuY5Hm7C5rVhw0fwbWSLne+16TP9w7O2p6peVW7i7mLtYQigPWEJUhf9g77lOeYbhULz8lOLnz3xI4ri1U99yaq/DAWxkLzoCKukCNVY7dKwNyDx2Eo/r4+5eSAWRNie38r5TM0lLRcW6hfiNqXGK/O+wn2MzC4ur2xasAmzhYTREiGc4jJr9PpMcHVMM+22ySZR+kNsM79v2e8pKn2GcJgyrcseUJNl1tkn6Fg5dlstlItYF2M+nUCoX3yqW6CkDC8ehTxLsO1XAQqzFG8nQA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7031.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 14:00:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 14:00:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Aun-Ali Zaidi <admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>, Orlando
 Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Topic: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Index: AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNsZMuAgAABkgCAAAFwwQ==
Date: Mon, 10 Mar 2025 13:59:59 +0000
Message-ID:
 <PN3PR01MB95970AA2AD456AC15B7AD3C6B8D62@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
 <ef8dcf7a-34ed-4b27-a154-e01bc167d4e6@arm.com>
 <Z87vKltfijzRtlpL@smile.fi.intel.com>
In-Reply-To: <Z87vKltfijzRtlpL@smile.fi.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB7031:EE_
x-ms-office365-filtering-correlation-id: 3f2cffa8-edd4-44d3-1d50-08dd5fdbd90b
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15080799006|7092599003|6072599003|10035399004|440099028|3412199025|21061999003|12071999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDZuQll5RkRTaUs1N29WQ1N3MWkxcUJqMnkvQUZPbnBJSjlzTkM3LzBDQnEv?=
 =?utf-8?B?Qlc1R1VHRkljYVd5S0djTGNXd1FIK2tOU3F3YVA5L01QTFZiQlBsVEJCWk5I?=
 =?utf-8?B?cjlXZk43cGxqak5YUG1UWHE5WlVpZTZEQ0tMM2JnWVEyYlNFRnlCTUFEUTFO?=
 =?utf-8?B?S3NJZFlUNHpHakhaWGE3UHRMSkx6aWN5VTI1MU1VTStkWFExRW43TUkyL2Iv?=
 =?utf-8?B?VW5EUVFaQ0JjdEtYWTlUeGFtNDNHaHZGdDU0T3p0SFhmNmVqNVdSTlZJazRU?=
 =?utf-8?B?OTFYalNmWlR3eDZHWXQ5V2JxZEluZnFNQlQzeHBFakZRRVhUcFBwcXN0NGJR?=
 =?utf-8?B?L0UxWkw0Zk5vVDdBV2tIdjRTSW9TTFhOVUtNMXFlMkxISSs4U2FiWHZ4UHVX?=
 =?utf-8?B?Rm12M0RtYTBRbUZKR056a1hxaWxTd0RscDJybmVwYnJTV2dZZlJ4OGdwblZK?=
 =?utf-8?B?cHNHeHp4SFdOREFJNHZJYlVsQmErOFBNZUd4MVJXOXlWSUk2dHBka09DVHBC?=
 =?utf-8?B?THVXV3l5MTRWOEpsdzVkN05yTXdtYnJ6SmNseEd0VHJpQWc2b1N6Qno2SDNP?=
 =?utf-8?B?WDJmd212MCsvZjN3d3RTRFdpNG81c1BNQTlnekE5YmVwUzBLUFJFSUhjOU5N?=
 =?utf-8?B?Mk5KQ29VNVhsZEp2czFMb2lidDRpcVBTcE9qclF6ZWtTZHJsRzZWekVxNTJo?=
 =?utf-8?B?QklGL28veDBCM0NmWDBFT3hYQU9Hdm5CUDZQZW9mdzNSd1Y2U3owMTRIWTZr?=
 =?utf-8?B?eXpDc2NHSEhBNVE0WTdCYkxmOGxxQ1B0WmQwWkl2VkcrTlBFSkYwMUVqZGRC?=
 =?utf-8?B?a2JDOFU5Z1pjSHAydEF4elBrUnR0bnF4aWdrbUFNdDdORkJVWUNOR090MnZB?=
 =?utf-8?B?QitvRkZCL1lUdi81WU53dFVVNFk1R01OK3RTdjBQTnFzUjk5d1BqT0xHSXlk?=
 =?utf-8?B?WkQ2THFna0NjUm1sYkNDalg4b1JsY2ljbEdCd0tsSFpXNWFHUGU5QXI4RkNq?=
 =?utf-8?B?R3Q4YzEwOEw5emNNU05RNDBwazhoejR4cGlEK2tOT2pRM2tRSDBSSTlsVFBj?=
 =?utf-8?B?bWtTUjc4bmdBZTI3STYrMDc2SmRuaVIvV3ZTMGcwdWwyZDlJUEIvNDY2MFll?=
 =?utf-8?B?VFB4S3dNTU4wamVlR1FpUmw1UTVIL3djRS93WFA3VFY1QXVBaDVFZWZaem1w?=
 =?utf-8?B?aEhMdGxNZVNjYk44emVaR1JoeFZqTmIwdFFlY3FrUldlSXVhQ3Ewb3MwSVhs?=
 =?utf-8?B?dXJ2YUQxakhhQ0MvT1ZndVo1K3o3d1FJZXF2eWsrOWtweDI1Z2JCYUQxYWlt?=
 =?utf-8?B?WlE4Wk4yNVdJSDJ4QlZSMnpoc1pBdDZYenlJTEJNSW9uWXU4YW9DWUdBRmFP?=
 =?utf-8?B?UHlCSUhDNkMvUHhMVzhGakloeEFmaFh5aHZiYndsNCtVMzV6R3lCa2QyWXVl?=
 =?utf-8?B?SXBsR01RcWFaVHdMUVBTUnRpZFhwaW1uRk1ZTEpaZG5hRDUrS1Y1c0NCK0Fz?=
 =?utf-8?B?N0FkdzhYc0lSMGZyd00rQWwya055Rk9mOUVoaVAxUWsvQVhsbDJwd3ZHV2dt?=
 =?utf-8?B?emhXY09sdEVyRlczWjcrVUdMOVIzTmxaRDExTDk0eU1Td1daNjNCemExSExn?=
 =?utf-8?B?MjE4ZFM3UTlyZUo1a0J0RzhVdVdkSVVLN0dCOUNtTjliYmFKVGphalBFYk51?=
 =?utf-8?B?cWRKR3JVMlJDUWljRjFnQ0lxV3RobEh1SWZpUDNSeTh0USt3UGFsbXlRPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVIyYThZRnJ1NTh6N3BtaTBvcnQvNERqMjNnd0h0QlF5OFJkRUFaTHZ2d0Ry?=
 =?utf-8?B?bXB1MU5mWWdDVnlyazl5SHh5THoxUjJmWUlHQTJVc2g3WmdjU0QvUTAwbXF4?=
 =?utf-8?B?R0VqTWI1Q2xFSU9QYzdQTHEwL1BFazByWjduaDU4TmtRWFIzWkNNenEzSStJ?=
 =?utf-8?B?OU5KWTEyMHYxVnNLSDEvc1BxMEhVdjZHUHpkVEIwa2Jpb2Flb0lTRGFmY0ZR?=
 =?utf-8?B?VUkxZXVaS0p3VjQveVlQSkRJWVRTOHloNno1bTh5cDNJSHJyYjY2TVN3TUJP?=
 =?utf-8?B?WGE4MkRvU0s4blROendLejlUMFhvVHJZYWtjMmZBSlJqY1hiOWxGSUZhU25Q?=
 =?utf-8?B?dDhpRjBaejU1WkhraHJCZEpUODNJejdNYlpDRzVqdmUyVWxiZEwwVTRnbHNF?=
 =?utf-8?B?WE5jUmNMMDZLaU1sdVdPb3JnVGY1V2JnOEhYOHFRQjYydFJmaHR0bWNuOEdF?=
 =?utf-8?B?MDV0SnlMSEp1TEZrWDdncTZ4Qy95YnJ1ZVNBZ1hsL1FieEkwYm5jNnBNWFR0?=
 =?utf-8?B?aUVSdnpQZTk2UG84MnZzUjBhV20vL2Y1TWZleTZRenRQOUNWYTJsNWQ4Y3Zk?=
 =?utf-8?B?R0hwcjZWclE1NXlJUnVYMmpEekprdVBERTBjeE96aitNeSsrdmg3d2lGeDhE?=
 =?utf-8?B?c2FOSXVndmZMOTRkN3QwS3Z2WFAwbXdBY1dWTG1WYkY1QnY3VXJOU1I2am1r?=
 =?utf-8?B?VEFzVXNRVVpjZGRoVHRUMWVZNVBrQUE5aDVnZkx4TEJXZERhQ3B2OFlDTnNo?=
 =?utf-8?B?bis5ZzVVWDBmSjVLWHlHZndDN3p5NWw1VTBVcXhOUlhjY0R5QjExeG5kcm5H?=
 =?utf-8?B?b1ZMV1BKckRoVGhOWkhaTEFnT0xtUFQ4eWRPNmRDOWRIK01rWWx5U1BrVkdN?=
 =?utf-8?B?Z28zaS9KOUp5cXpEZU1pNUNDTzE0UHpCUGRlQXc0UTlMTHRXQXowbzRJTTVO?=
 =?utf-8?B?Z1hhcXZUYWZnck9hUFBxUWd1RHRxZGMxMHQzeUNJWWEyajI5S2JneFI1UmdH?=
 =?utf-8?B?UU1lcmVPd052T1Q3TzVWeXFKNldSVDhsbHpLS0h2TjJ6TzlLY1ZPR1hLaU5w?=
 =?utf-8?B?OENwL2Z0azJvVjdnVjZGeExOSlUvMFBrcTJ6VjJrbHB4UkpMMFZLZnRmeTdk?=
 =?utf-8?B?VDE4YzdTQTdiVDVoSVlYVkJmb2pxaUU0MzZ5N3EyNng2aHpIb0Vha0xNRk5B?=
 =?utf-8?B?eUorYWFLZkdTYWppcjc4SWVOTC9BR3pCUVNHaDZxL0pJTDhGQ0FETnB2MVI5?=
 =?utf-8?B?UTVyeG44Rjl5bVB1WFM4SjVIZit0bEVldFJEYjA2cXAzK2NmMUNnUk5Xckc3?=
 =?utf-8?B?VkhjTEI3RUZGajRWTHpZS1BjREpTZUhTKzY5UWtOMnFTdmRkTDlhZTJzb2gy?=
 =?utf-8?B?WnpyMmVVSXdmWEwzOUNZcllxTlpzTEVscWJWOFk2cThhTkNyQ3hYbDB3VGwz?=
 =?utf-8?B?WW1LcmZpelJ4Tk5hODI4d1oraUs1QzNpZVUzRGdRVDc2T2IrS2dUV3NwQjZ0?=
 =?utf-8?B?RDBqbzJlUDVVTDcxM2lIMzdDYWw1dHVQUjl2eDg0WFN0T1o3SnpiREFqa0V3?=
 =?utf-8?B?VmVUTkJ3NFFVVExmMjliYWZQZ0ExL2g5SFNGZzdXb2Zpd2k1cUJTZUlMWkN2?=
 =?utf-8?Q?ghyUghyaVZgyoEmQ7Ba2/nOZn8LJh66qVk8aUTpO4Cao=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2cffa8-edd4-44d3-1d50-08dd5fdbd90b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 13:59:59.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7031

DQoNCj4gT24gMTAgTWFyIDIwMjUsIGF0IDc6MjXigK9QTSwgYW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tIHdyb3RlOg0KPiANCj4g77u/T24gTW9uLCBNYXIgMTAsIDIwMjUgYXQgMDE6
NDk6MTNQTSArMDAwMCwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPj4+IE9uIDIwMjUtMDMtMDkgODo0
MCBhbSwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4gRnJvbTogUGF1bCBQYXdsb3dza2kgPHBhdWxA
bXJhcm0uaW8+DQo+Pj4gDQo+Pj4gVGhpcyBwYXRjaCBhZGRzIGEgZHJpdmVyIG5hbWVkIGFwcGxl
LWJjZSwgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSBUMg0KPj4+IFNlY3VyaXR5IENoaXAgZm91bmQg
b24gY2VydGFpbiBNYWNzLg0KPj4+IA0KPj4+IFRoZSBkcml2ZXIgaGFzIDMgbWFpbiBjb21wb25l
bnRzOg0KPj4+IA0KPj4+IEJDRSAoQnVmZmVyIENvcHkgRW5naW5lKSAtIHRoaXMgaXMgd2hhdCB0
aGUgZmlsZXMgaW4gdGhlIHJvb3QgZGlyZWN0b3J5DQo+Pj4gYXJlIGZvci4gVGhpcyBlc3RhYmls
aXNoZXMgYSBiYXNpYyBjb21tdW5pY2F0aW9uIGNoYW5uZWwgd2l0aCB0aGUgVDIuDQo+Pj4gVkhD
SSBhbmQgQXVkaW8gYm90aCByZXF1aXJlIHRoaXMgY29tcG9uZW50Lg0KPj4+IA0KPj4+IFZIQ0kg
LSB0aGlzIGlzIGEgdmlydHVhbCBVU0IgaG9zdCBjb250cm9sbGVyOyBrZXlib2FyZCwgbW91c2Ug
YW5kDQo+Pj4gb3RoZXIgc3lzdGVtIGNvbXBvbmVudHMgYXJlIHByb3ZpZGVkIGJ5IHRoaXMgY29t
cG9uZW50IChvdGhlcg0KPj4+IGRyaXZlcnMgdXNlIHRoaXMgaG9zdCBjb250cm9sbGVyIHRvIHBy
b3ZpZGUgbW9yZSBmdW5jdGlvbmFsaXR5KS4NCj4+PiANCj4+PiBBdWRpbyAtIGEgZHJpdmVyIGZv
ciB0aGUgVDIgYXVkaW8gaW50ZXJmYWNlLCBjdXJyZW50bHkgb25seSBhdWRpbw0KPj4+IG91dHB1
dCBpcyBzdXBwb3J0ZWQuDQo+Pj4gDQo+Pj4gQ3VycmVudGx5LCBzdXNwZW5kIGFuZCByZXN1bWUg
Zm9yIFZIQ0kgaXMgYnJva2VuIGFmdGVyIGEgZmlybXdhcmUNCj4+PiB1cGRhdGUgaW4gaUJyaWRn
ZSBzaW5jZSBtYWNPUyBTb25vbWEuDQo+IA0KPj4gSSdtIHNsaWdodGx5IHB1enpsZWQgd2h5IHRo
aXMgd2FzIHNlbnQgdG8gdGhlIElPTU1VIG1haW50YWluZXJzIHdoZW4gaXQNCj4+IGRvZXNuJ3Qg
dG91Y2ggYW55IElPTU1VIGNvZGUsIG5vciBldmVuIGNvbnRhaW4gYW55IHJlZmVyZW5jZSB0byB0
aGUgSU9NTVUNCj4+IEFQSSBhdCBhbGwuLi4NCj4gDQo+IFBlb3BsZSBsaWtlIHRvIHB1dCBhIHJh
bmRvbSBwZW9wbGUgdG8gYSByYW5kb20gY29udHJpYnV0aW9ucyA6LSkNCj4gDQo+IEFkaXR5YSwg
eW91IGNhbiB1dGlsaXNlIG15ICJzbWFydCIgc2NyaXB0IFsxXSB0byBzZW5kIHRoZSBzZXJpZXMN
Cj4gdG8gbW9yZS1vci1sZXNzIHJlbGV2YW50IHBlb3BsZSAoYnV0IGRlZmluaXRlbHkgdG8gdGhl
IHJpZ2h0IG9uZXMNCj4gwrEgcG90ZW50aWFsbHkgaW50ZXJlc3RlZCwgaXQgaGFzIGEgaGV1cmlz
dGljcyBpbnNpZGUpLg0KDQpUaGFua3MgYSBsb3QgZm9yIHRoaXMuIEkgdXNlZCBhIGJpdCBBSSB0
byBnZXQgbWFpbnRhaW5lcnMgZm9yIHRoaXMsIGxvb2tzIGxpa2UgSU9NTVUgZ290IGFkZGVkLiBT
b3JyeSBmb3IgdGhhdCA6KQ0KPiANCj4gWzFdOiBodHRwczovL2dpdGh1Yi5jb20vYW5keS1zaGV2
L2hvbWUtYmluLXRvb2xzL2Jsb2IvbWFzdGVyL2dlMm1haW50YWluZXIuc2gNCj4gDQo+IC0tDQo+
IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCj4gDQo+IA0K

