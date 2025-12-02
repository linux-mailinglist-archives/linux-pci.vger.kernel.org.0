Return-Path: <linux-pci+bounces-42428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04138C99D0B
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 03:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B3DE345E20
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 02:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A711EF0B9;
	Tue,  2 Dec 2025 02:01:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499112F5A5;
	Tue,  2 Dec 2025 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640900; cv=fail; b=Uv2Yqoi0LYMaEHkEbbh/bPhX94zuksFdiEn9Tr6n3TqUTjMm3dy5FT+kW4awWXaOJ27Z5+AoYV8cSsCyTVZ8mUhkvmD9XUt/TIgQZSJRFD7vu0a2ZuKL5bYr3SSzcakQtNl46fLgrtykPisDUn5zATI+KNL6cpNoCPDdox67+uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640900; c=relaxed/simple;
	bh=Xga+9lHbe9+nOwIeDhlARtoCOn8b6QCeoeFvqMiACRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qx7o+wcG3RfNeUAJ57k3xOUBRJviui1Rpg5/pqveoss6VBqjsJEp/V1hen3k5uJRec7Xgtaf1rpndT/yNV/1cTLoC6Z/7AMCuB/Q+b+e3maXDMNbWSTs4pe7odSnco5orWIvql34f892Cr3TOCvIQ8At+/P+h/LQkHcOcwyhSk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY3l9kMChk0Ceh6+G1JRUP5efX/1lUpFzeqFAsI2AYP2EO7wvStD7WKL0WKxBbnuNtBfmilNLpKrvETHcjnohaFxn8AAigB7JAZkJ7IYtzuMxVQKfeeL7kcn/CynMDTFLs0RnjM5IPMFqTqcR46Q+jOhV96dnSFLSpOMy0BUNPJhDA0aL6u1cr5fWzueoAcBffQ7Tf81qHgu6xrbopDEx8Me3YdFk9xWyvbwx1d4M8ef02q0x2NlQ0rm8Hj+OWWucIi3NnsmBc6k1eMnmZMlrQw5NiIhhnCW7Y9Dr7iZHoM5CgkZh8wzxoZZvIS6wuF9ZFdPVaXmsLsqIwtWauSS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xga+9lHbe9+nOwIeDhlARtoCOn8b6QCeoeFvqMiACRs=;
 b=QbH0sSgGrVkGMxVJ1I0usEIzdnXxwjKMM/GuXnFW1mLCKNyaqIW+zdC9YwBHJWlNbI/wqQIWy/t6ZoUFbayNs758pdtSGrkeDk0Yq87L0QRoc5s031QjhiQxy4HhrpBDK4v54n4/wtVrZQYxxiOUmJg27cGAyyjASwbvWMgvc8jZj+gXKQPr/+6XQmI4t5FyA85JtonIOfyHZrdEhMjml4DCGf24Nc9Rh+oBnRPu1B4fclMsJML+Y9EFh/h5NjhE1v9EU9fAKPB0vcrvFZdhlCijBO1OdnY5u2eYGgWKi9SojjnTKS39bPT352VJFJa7x00IDBhTHhuFBhfAvoO3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::13) by ZQ0PR01MB1301.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 01:45:34 +0000
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b9:99db:485d:ea26]) by
 ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn ([fe80::f2b9:99db:485d:ea26%4])
 with mapi id 15.20.9388.003; Tue, 2 Dec 2025 01:45:34 +0000
From: Kevin Xie <kevin.xie@starfivetech.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Hal Feng <hal.feng@starfivetech.com>
CC: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Albert Ou
	<aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, E Shattow <e@freeshell.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHY0IDEvNl0gUENJOiBzdGFyZml2ZTogVXNlIHJlZ3Vs?=
 =?gb2312?B?YXRvciBBUElzIGluc3RlYWQgb2YgR1BJTyBBUElzIHRvIGVuYWJsZSB0aGUg?=
 =?gb2312?Q?3V3_power_supply_of_PCIe_slots?=
Thread-Topic: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Thread-Index: AQHcYwRwWAZxAfe/n0a28faM175GW7UNkvow
Date: Tue, 2 Dec 2025 01:45:34 +0000
Message-ID:
 <ZQ0PR01MB09816F6CF06E8021488DBCBC82D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
References: <20251125075604.69370-2-hal.feng@starfivetech.com>
 <20251201205236.GA3023515@bhelgaas>
In-Reply-To: <20251201205236.GA3023515@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB0981:EE_|ZQ0PR01MB1301:EE_
x-ms-office365-filtering-correlation-id: 5c40aa84-ca5e-4ec2-e9fc-08de31447c73
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|41320700013|366016|38070700021;
x-microsoft-antispam-message-info:
 VbgrMmDbZvteqZ452GiKe6p4BSp9HR0YBsg/EzO2YeIsCRxobd13xX/GW+7KnKHhfkN0oFJGjkZ1HmOAtCAueoXa+NZr0t8PUHlpRUK2Ec1215l58gKmpPhzt2KtpzL0tNO3IXRs1IZBI2fh2CVk1s343JfhbtRMcy4EdO2CZo98KGl6Xw7rST/5wOSvEvMnWXqN9liEkBANzg576AX4hgOp7OBnlDL3SALhrKxRyjkvobrH7hdE9UTVa8HJ+8qJsZV48YZLrIPzqY9OaYhxvxOh511a/Mtp20oGf9wbal+CAZqi7NVEt1ydSsc90dtdTNOUOJleW7Pga/6CqnExG7FAocnjJHmqe4bndzbG8gSi1aLzpYAhChdI8Pfm6IBU7r6mTNwmcRVk+3/3DHBeaVFYxt2fEjaCYnOawL78TZB4gLuew/j3nH1nhmSMH2n6E95mUdlC093aUQAnj8wHRJLkkrlb6gRHWhiLhtrhDabwG9Vl4Y7vepZmdMovqy5gWZMmXcxCPvOee6JBIuQC/F/RHTp3Hz5TPJyN6MUSZ/j0mag9b89jgPiEWoXZAqcVJXr+vOdD6SvlzItHpZK/nGvQEhb5CztLLJQEwr5N0Dc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(41320700013)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RnVzK2RNQUhVcEwybDRkUFkveEQzaTYvVHJmRWhBOGdFdEtEaWZlcUVkL2ly?=
 =?gb2312?B?N01jZVB6NVlxd3l3L0NTenJOM1I0cndBZTBmNm0rOXlzYzBUeXZrRk9YK1RZ?=
 =?gb2312?B?RDJRQ1V2a0FqdjVFck5IaUNnVWFpT3hsQ2lrWmhPYjAwY0dJcG9RZVcxMVVa?=
 =?gb2312?B?dEpaNGF1WGJBMXc0cW5QN2JQcmhNdjZXazR0N2Z6anNQM0NTSGRVci9TYW5Y?=
 =?gb2312?B?UXRzS09MNWhIdWdyK1RNSTk2STg4eFZDNFpyWTdpZWc5R21BY0xxZ3VPRlgy?=
 =?gb2312?B?T0pkSnZSM2FQeWtVQzNsdlJBY3lkRUtFeElUd2NlOTJMK0VxTWpBSmR0dzVx?=
 =?gb2312?B?bkZkZDQvclltajFlSGxzbjFJdjl0c0Vlc2hIdkUveDdsQ0V3eEFaQWF6WnVO?=
 =?gb2312?B?WGpVZ3NWcVp3SXZpWURNOThCSUM1d3RaZEptMDNnM0ZYTUhsTGZyaVhMOVdX?=
 =?gb2312?B?MmtuWHVkeSs2Vldudm16NmljZ1U1VVo3Wk1qUnVhNno5OGtNaUhBKzNWOUc4?=
 =?gb2312?B?dCtKUnRyRWlYcVNzZHFqVXBNa1dNK3hYNGt0S1o2TURJUFZaRVRWRGhtN0VK?=
 =?gb2312?B?NUpMV1BSSE83d2NZckFadUJLa2pzalk2VWVzY05GVkpkc2RsaVNwQmpRSVdT?=
 =?gb2312?B?Nmx6VDhOMkdoUzU3RTltVWJPbXM3MUh4UGdMQlV3NEZPMFN6ZTJoakQxblRz?=
 =?gb2312?B?cUZiQ29hQldzODhLb2VwaERNM1VrOVVTVkRCTDBPRmNJSFkwV3FxVjBIYWFu?=
 =?gb2312?B?cGF6U3NOWW91alhWQjFNam01aDJHdlZjaTQvYmV1bFJjb2VwL0ZLay9mckZa?=
 =?gb2312?B?VHpEMEhVclRnazF2ZGlSZFN4c0RlTzhZTk5FRVZqOTM0VGdQZ2JSL0JMZnEx?=
 =?gb2312?B?RTFaMVBuSWRGSUszS0xrenplVWl4azNjdm1qQjJ4SGc1cUdFWHZGL21abG5X?=
 =?gb2312?B?bFFBL2tSOGVsdGMrMXBlZWlEMHlyTERyLzFwdVlnOUJNS1BYZVp6VmlrVE5n?=
 =?gb2312?B?RW9YazlEbjdxb2VMblFQb1dtbGpEQjVMTXVyUitRMnFVZlE4RW13dnNVYkZn?=
 =?gb2312?B?V0hCZHdOTTM1OUNEcUZRdHVnQmNFaTdobHhjNU1GVEZEaCs3cTg3UW9XeU0x?=
 =?gb2312?B?cXdJbDJuRWhuT1JYSnhmUzJ6YWs3cU9Fd0NuUWdQN2Y5WXd5WjVVQno5YjFG?=
 =?gb2312?B?K3dZbjRnQVJXQWV0Um93REJBa1l4NXY2a01nU01xRW42NzlUWTBVaGtEbi9x?=
 =?gb2312?B?UGZnaEM1eHI2UU4rMU04bWlPOTQ2aHU0cGNyWTN1RkhrV1VLeENqWlI1V3FL?=
 =?gb2312?B?OVVWNDJCSnVJenBBK1VLMVU4MnhTNmlQdWp6L2c5NnpZVzdTbVN3WVNTaEtN?=
 =?gb2312?B?bURtK0JlMFd5Skk4b2E1S0R6bzMwK3IvcWJPblJCK0ZpWjZTTHZqMHB1Zk9B?=
 =?gb2312?B?ZnE3bTVKaUZHaG5mS2VldHR5cXRPT1EybnlIVkE2aFF6M24wZjZmQkJNbUVL?=
 =?gb2312?B?MW5GU2JidmRVaXFUSDFuNzJDZ3liVzRMN1d0RWc4OGg0TW5OWWdtZy9RNlEz?=
 =?gb2312?B?aUlVY0l3SmR3MWkzOUZ5QmVuSnd5dUlYWExLa1hVZmQwdHZJT0VMdGh2Qkpw?=
 =?gb2312?B?NlBsakpTNzZ5cHZHTy84V09aMVZQMFhGR2llL0krK0dLSHV3TTRWLzdvbFIy?=
 =?gb2312?B?UnFFNjF2YkJTQW94NitLSGg5cjhZYlpLeVg5YUFaTDRMTU1QQ01VMVRSbERI?=
 =?gb2312?B?OWpQeWZvOEZNTm5KaXpoV0prZm9nb0dYVnBCbWRiYzc1ZzZIY2lpd3NqTmEv?=
 =?gb2312?B?N0ZCN0YxU2JSV0g2VjBLSU9CRE83bWpVc0xOUFFydWZnKzRudTVoRHJsekRY?=
 =?gb2312?B?ckJoRzh3RmRScjdZYWhLandFWGcwUU5zODQ3NG1vOGdrRHJTRDAwbVBna2tO?=
 =?gb2312?B?MmJNWUJlbDZEM1BLNWN4NDFuZC91WFR4R3p2NWt2TG0yd3lHQTVveTZrWS9M?=
 =?gb2312?B?dnRyMjBKdzdRa1pydkpGbkJWdGExTjVWWElCNGVuTlhzRTZuUU9mdjBYeVBS?=
 =?gb2312?B?Unp6N2pMSzAzODhnY0VsTXF6SkVmYWhjWGZLK1ZYTnE5UTFRUkVad2F6MkZh?=
 =?gb2312?B?Snk1dFBWT2tMRWVscUtoU2xHb1Q2dzVyWlpvRnV4Yk14Kzg5dTdEdFNDZHhm?=
 =?gb2312?B?Nmc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c40aa84-ca5e-4ec2-e9fc-08de31447c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 01:45:34.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60H6ouTSZfEBobyfwq0NUi9aYgG3Kcw7OAWSu1/paDRtiTmB8Q3/aR6JA6IB0krygIk4I0Oy0O7ZxSiQTgy3sPsE3YuNRnsLE4gDcIxJKV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1301

PiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBQYWxtZXIgRGFiYmVs
dA0KPiA8cGFsbWVyQGRhYmJlbHQuY29tPjsgUGF1bCBXYWxtc2xleSA8cGp3QGtlcm5lbC5vcmc+
OyBBbGJlcnQgT3UNCj4gPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT47IFJhZmFlbCBKIC4gV3lzb2Nr
aSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBWaXJlc2gNCj4gS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5h
cm8ub3JnPjsgTG9yZW56byBQaWVyYWxpc2kgPGxwaWVyYWxpc2lAa2VybmVsLm9yZz47DQo+IEty
enlzenRvZiBXaWxjenmovXNraSA8a3dpbGN6eW5za2lAa2VybmVsLm9yZz47IE1hbml2YW5uYW4g
U2FkaGFzaXZhbQ0KPiA8bWFuaUBrZXJuZWwub3JnPjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNA
Z29vZ2xlLmNvbT47IExpYW0gR2lyZHdvb2QNCj4gPGxnaXJkd29vZEBnbWFpbC5jb20+OyBNYXJr
IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBFbWlsIFJlbm5lcg0KPiBCZXJ0aGluZyA8ZW1p
bC5yZW5uZXIuYmVydGhpbmdAY2Fub25pY2FsLmNvbT47IEhlaW5yaWNoIFNjaHVjaGFyZHQNCj4g
PGhlaW5yaWNoLnNjaHVjaGFyZHRAY2Fub25pY2FsLmNvbT47IEUgU2hhdHRvdyA8ZUBmcmVlc2hl
bGwuZGU+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgS2V2aW4gWGllDQo+IDxrZXZpbi54aWVAc3RhcmZpdmV0ZWNoLmNv
bT4NCj4g1vfM4jogUmU6IFtQQVRDSCB2NCAxLzZdIFBDSTogc3RhcmZpdmU6IFVzZSByZWd1bGF0
b3IgQVBJcyBpbnN0ZWFkIG9mIEdQSU8gQVBJcw0KPiB0byBlbmFibGUgdGhlIDNWMyBwb3dlciBz
dXBwbHkgb2YgUENJZSBzbG90cw0KPiANCj4gWytjYyBLZXZpbiwgcGNpZS1zdGFyZml2ZS5jIG1h
aW50YWluZXI7IHdpbGwgbmVlZCBoaXMgYWNrXQ0KPiANCj4gU3ViamVjdCBsaW5lIGlzIGV4Y2Vz
c2l2ZWx5IGxvbmcuDQo+IA0KPiBPbiBUdWUsIE5vdiAyNSwgMjAyNSBhdCAwMzo1NTo1OVBNICsw
ODAwLCBIYWwgRmVuZyB3cm90ZToNCj4gPiBUaGUgImVuYWJsZS1ncGlvIiBwcm9wZXJ0eSBpcyBu
b3QgZG9jdW1lbnRlZCBpbiB0aGUgZHQtYmluZGluZ3MgYW5kDQo+ID4gdXNpbmcgR1BJTyBBUElz
IGlzIG5vdCBhIHN0YW5kYXJkIG1ldGhvZCB0byBlbmFibGUgb3IgZGlzYWJsZSBQQ0llDQo+ID4g
c2xvdCBwb3dlciwgc28gdXNlIHJlZ3VsYXRvciBBUElzIHRvIHJlcGxhY2UgdGhlbS4NCj4gDQo+
IEkgY2FuJ3QgdGVsbCBmcm9tIHRoaXMgd2hldGhlciBleGlzdGluZyBEVHMgd2lsbCBjb250aW51
ZSB0byB3b3JrIGFmdGVyIHRoaXMNCj4gY2hhbmdlLiAgSXQgbG9va3MgbGlrZSBwcmV2aW91c2x5
IHdlIGxvb2tlZCBmb3IgYW4gImVuYWJsZS1ncGlvcyIgb3INCj4gImVuYWJsZS1ncGlvIiBwcm9w
ZXJ0eSBhbmQgbm93IHdlJ2xsIGxvb2sgZm9yIGEgInZwY2llM3YzLXN1cHBseSIgcmVndWxhdG9y
DQo+IHByb3BlcnR5Lg0KPiANCj4gSSBkb24ndCBzZWUgImVuYWJsZS1ncGlvcyIgb3IgImVuYWJs
ZS1ncGlvIiBtZW50aW9uZWQgaW4gYW55IG9mIHRoZSBEVCBwYXRjaGVzDQo+IGluIHRoaXMgc2Vy
aWVzLCBzbyBtYXliZSB0aGF0IHByb3BlcnR5IHdhcyBuZXZlciBhY3R1YWxseSB1c2VkIGJlZm9y
ZSwgYW5kIHRoZQ0KPiBjb2RlIGZvciBwY2llLT5wb3dlcl9ncGlvIHdhcyBhY3R1YWxseSBkZWFk
Pw0KPiANCg0KcGNpZS0+cG93ZXJfZ3BpbyBpcyB1c2VkIGluIHRoZSBvdXIgSkg3MTEwIEVWQiwg
aXQgc2hhcmUgdGhlIHNhbWUgcGNpZSBjb250cm9sbGVyDQpkcml2ZXIgd2l0aCBWaXNpb25GaXZl
MiBib2FyZC4gQWx0aG91Z2ggSkg3MTEwIHdhcyBub3QgdXBzdHJlYW1lZCwgd2Ugc3RpbGwgaG9w
ZQ0KdG8gbWFpbnRhaW4gdGhlIGNvbXBhdGliaWxpdHkgb2YgdGhlIGRyaXZlci4NCg0KPiBQbGVh
c2UgYWRkIHNvbWV0aGluZyBoZXJlIGFib3V0IGhvdyB3ZSBrbm93IHRoaXMgd29uJ3QgYnJlYWsg
YW55IGV4aXN0aW5nDQo+IHNldHVwcyB1c2luZyBEVHMgdGhhdCBhcmUgYWxyZWFkeSBpbiB0aGUg
ZmllbGQuDQo+IA0KPiA+IFRlc3RlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWJydWdnZXJAc3Vz
ZS5jb20+DQo+ID4gRml4ZXM6IDM5YjkxZWI0MGM2YSAoIlBDSTogc3RhcmZpdmU6IEFkZCBKSDcx
MTAgUENJZSBjb250cm9sbGVyIikNCj4gDQo+IEJhc2VkIG9uIHRoZSBjb3ZlciBsZXR0ZXIsIGl0
IGxvb2tzIGxpa2UgdGhlIHBvaW50IG9mIHRoaXMgaXMgdG8gYWRkIHN1cHBvcnQgZm9yIGENCj4g
bmV3IGRldmljZSwgd2hpY2ggSSBkb24ndCB0aGluayByZWFsbHkgcXVhbGlmaWVzIGFzIGEgImZp
eCIuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRl
Y2guY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BsZGEvcGNpZS1z
dGFyZml2ZS5jIHwgMjUNCj4gPiArKysrKysrKysrKystLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLXN0YXJmaXZlLmMNCj4gPiBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLXN0YXJmaXZlLmMNCj4gPiBpbmRleCAz
Y2FmNTNjNmMwODIuLjI5ODAzNmMzZTdmOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BsZGEvcGNpZS1zdGFyZml2ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wbGRhL3BjaWUtc3RhcmZpdmUuYw0KPiA+IEBAIC01NSw3ICs1NSw3IEBAIHN0cnVj
dCBzdGFyZml2ZV9qaDcxMTBfcGNpZSB7DQo+ID4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcmVz
ZXRzOw0KPiA+ICAJc3RydWN0IGNsa19idWxrX2RhdGEgKmNsa3M7DQo+ID4gIAlzdHJ1Y3QgcmVn
bWFwICpyZWdfc3lzY29uOw0KPiA+IC0Jc3RydWN0IGdwaW9fZGVzYyAqcG93ZXJfZ3BpbzsNCj4g
PiArCXN0cnVjdCByZWd1bGF0b3IgKnZwY2llM3YzOw0KPiA+ICAJc3RydWN0IGdwaW9fZGVzYyAq
cmVzZXRfZ3BpbzsNCj4gPiAgCXN0cnVjdCBwaHkgKnBoeTsNCj4gPg0KPiA+IEBAIC0xNTMsMTEg
KzE1MywxMyBAQCBzdGF0aWMgaW50IHN0YXJmaXZlX3BjaWVfcGFyc2VfZHQoc3RydWN0DQo+IHN0
YXJmaXZlX2poNzExMF9wY2llICpwY2llLA0KPiA+ICAJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRl
diwgUFRSX0VSUihwY2llLT5yZXNldF9ncGlvKSwNCj4gPiAgCQkJCSAgICAgImZhaWxlZCB0byBn
ZXQgcGVyc3QtZ3Bpb1xuIik7DQo+ID4NCj4gPiAtCXBjaWUtPnBvd2VyX2dwaW8gPSBkZXZtX2dw
aW9kX2dldF9vcHRpb25hbChkZXYsICJlbmFibGUiLA0KPiA+IC0JCQkJCQkgICBHUElPRF9PVVRf
TE9XKTsNCj4gPiAtCWlmIChJU19FUlIocGNpZS0+cG93ZXJfZ3BpbykpDQo+ID4gLQkJcmV0dXJu
IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKHBjaWUtPnBvd2VyX2dwaW8pLA0KPiA+IC0JCQkJ
ICAgICAiZmFpbGVkIHRvIGdldCBwb3dlci1ncGlvXG4iKTsNCj4gPiArCXBjaWUtPnZwY2llM3Yz
ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFsKGRldiwgInZwY2llM3YzIik7DQo+ID4gKwlp
ZiAoSVNfRVJSKHBjaWUtPnZwY2llM3YzKSkgew0KPiA+ICsJCWlmIChQVFJfRVJSKHBjaWUtPnZw
Y2llM3YzKSAhPSAtRU5PREVWKQ0KPiA+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBU
Ul9FUlIocGNpZS0+dnBjaWUzdjMpLA0KPiA+ICsJCQkJCSAgICAgImZhaWxlZCB0byBnZXQgdnBj
aWUzdjMgcmVndWxhdG9yXG4iKTsNCj4gPiArCQlwY2llLT52cGNpZTN2MyA9IE5VTEw7DQo+ID4g
Kwl9DQo+ID4NCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gQEAgLTI3MCw4ICsyNzIsOCBA
QCBzdGF0aWMgdm9pZCBzdGFyZml2ZV9wY2llX2hvc3RfZGVpbml0KHN0cnVjdA0KPiBwbGRhX3Bj
aWVfcnAgKnBsZGEpDQo+ID4gIAkJY29udGFpbmVyX29mKHBsZGEsIHN0cnVjdCBzdGFyZml2ZV9q
aDcxMTBfcGNpZSwgcGxkYSk7DQo+ID4NCj4gPiAgCXN0YXJmaXZlX3BjaWVfY2xrX3JzdF9kZWlu
aXQocGNpZSk7DQo+ID4gLQlpZiAocGNpZS0+cG93ZXJfZ3BpbykNCj4gPiAtCQlncGlvZF9zZXRf
dmFsdWVfY2Fuc2xlZXAocGNpZS0+cG93ZXJfZ3BpbywgMCk7DQo+ID4gKwlpZiAocGNpZS0+dnBj
aWUzdjMpDQo+ID4gKwkJcmVndWxhdG9yX2Rpc2FibGUocGNpZS0+dnBjaWUzdjMpOw0KPiA+ICAJ
c3RhcmZpdmVfcGNpZV9kaXNhYmxlX3BoeShwY2llKTsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTMw
NCw4ICszMDYsMTEgQEAgc3RhdGljIGludCBzdGFyZml2ZV9wY2llX2hvc3RfaW5pdChzdHJ1Y3QN
Cj4gcGxkYV9wY2llX3JwICpwbGRhKQ0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0
Ow0KPiA+DQo+ID4gLQlpZiAocGNpZS0+cG93ZXJfZ3BpbykNCj4gPiAtCQlncGlvZF9zZXRfdmFs
dWVfY2Fuc2xlZXAocGNpZS0+cG93ZXJfZ3BpbywgMSk7DQo+ID4gKwlpZiAocGNpZS0+dnBjaWUz
djMpIHsNCj4gPiArCQlyZXQgPSByZWd1bGF0b3JfZW5hYmxlKHBjaWUtPnZwY2llM3YzKTsNCj4g
PiArCQlpZiAocmV0KQ0KPiA+ICsJCQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRv
IGVuYWJsZSB2cGNpZTN2MyByZWd1bGF0b3JcbiIpOw0KPiA+ICsJfQ0KPiA+DQo+ID4gIAlpZiAo
cGNpZS0+cmVzZXRfZ3BpbykNCj4gPiAgCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocGNpZS0+
cmVzZXRfZ3BpbywgMSk7DQo+ID4gLS0NCj4gPiAyLjQzLjINCj4gPg0KPiA+DQo+ID4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBsaW51eC1yaXNj
diBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0K

