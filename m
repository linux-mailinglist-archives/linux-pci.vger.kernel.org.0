Return-Path: <linux-pci+bounces-7736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA288CB8AA
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 03:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53020283B32
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FF24C6D;
	Wed, 22 May 2024 01:51:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2101.outbound.protection.partner.outlook.cn [139.219.146.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CCC1FA1;
	Wed, 22 May 2024 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716342667; cv=fail; b=puzHrzIDRl3lFNWPCqzfabP8iTnrpAxbzilPp5PBjYmq7E8ltBL376XBmV+0zHalo7DawhYED7VEHaHsvm8EaGw6CiN0/AhTqwkU+MmJbu6rBQaNhRqxNgtNxUOEBS5AnKDxwKfAR7yTlpaVArnE9Oa45KhEi65lqjuFN+BPL6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716342667; c=relaxed/simple;
	bh=j4yoTHtbsPHnMLh+Cb5EiK9S4L+2OX7IWth7jFWKZh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kPC+7Ox/f6yopAINnqP2tTOvc5mxYflDSyqK7fZ1yTfD7ZTLuUtgJph4xlHCDlTvvZzbM7bCcMkELC9iCUXUqgSQh3XJfjK/bn9W/iBY/Morr1BVNaTqxA6fSFIhaK5A4aht+c3+KupCZeOs5Tx/m71pwEjNktSFFOY3VWThp+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILXuluOBL1WAGeMJdokhAx1tuixve9VSdWUQLVquwZZae0COvnfDnsjrLsXEhoAyRVs7egjJiMm3wq8d1SYCUJNfIY0N3XCigARg7xXZQXl3N7jzacmAgGvTvdiXgZNku/4tW4RmbApa5nd/p0+YE9DLYzoDoOREKofExGJlVpr44VFgup+h3p6ZOQOjJJiVbjUx/whK6YASeuVWLCm//dngP6rW4dYKcsXRM+vChSiO0N6+eCTX8HXfOCDHKKWPVpLzinvCSi7JuU9zfkdZxx1Fs/52UG28+KkjMGIRIX5dJDmgwGHJax6ZZdWW1nE7VSKvYq9egjqdiDM1sgnmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4yoTHtbsPHnMLh+Cb5EiK9S4L+2OX7IWth7jFWKZh4=;
 b=EnZQCe8+sogd7UzXAqQimThRRf8xdkUfso/dpF2Omn+TeGkuN9CtqeS2Tl4bgiUZ6BQUQU4TJxv2o7UxKgImZQtDAavEpCLyGWBoYAzCZHZzB1VDJueHglLus7Ir44QE9BkEBS9pj+eScZxm2GLFDKjcHgUxs3P4+ZuWTdxF0XS1U5rwmd5/FYOx2bi1d5XI+BTDhuUUZvIjjKDuurOFmSu6xzsX7VfPLEiIaEnm1DmOusR5SqN3Ey5esPh7zXbn2NnkxhIH49OFPYIKoKrc4ORjJEfMYy5efUr4stkpE/mkT830X5H+mj5vp7yQIbB33UCZd2DpYrW4Nxb0xspIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0830.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 22 May
 2024 01:50:58 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7587.035; Wed, 22 May 2024 01:50:58 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Conor Dooley
	<conor@kernel.org>, =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Philipp
 Zabel <p.zabel@pengutronix.de>, Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Kevin Xie
	<kevin.xie@starfivetech.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxNiAwOC8yMl0gUENJOiBtaWNyb2NoaXA6IENoYW5n?=
 =?gb2312?B?ZSB0aGUgYXJndW1lbnQgb2YgcGxkYV9wY2llX3NldHVwX2lvbWVtcygp?=
Thread-Topic: [PATCH v16 08/22] PCI: microchip: Change the argument of
 plda_pcie_setup_iomems()
Thread-Index: AQHagPDzrxFwM5ned0uU5e4g9ZRYQ7GimIiAgAAs70A=
Date: Wed, 22 May 2024 01:50:57 +0000
Message-ID:
 <SHXPR01MB086351396027D8A443BB6068E6EB2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240328091835.14797-9-minda.chen@starfivetech.com>
 <20240521222121.GA51329@bhelgaas>
In-Reply-To: <20240521222121.GA51329@bhelgaas>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0830:EE_
x-ms-office365-filtering-correlation-id: d7625557-c0c8-4ee4-24d8-08dc7a01a021
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LjSItgXDQoOttq+iEjows3gNg79A7LofiMuZfH8WGsT3ERkiroz9z259iUUu+raXgLZ0alY4yXKYP8dv6DdhPFZ8dCGeLkXqvTBJns0R7Y8LKHMKiEBRyc8mRdwa7EgkY1Fi1zw0f7ZT4yD/B8uJFs9wPNqhfYN4BMXu3HzDuhRTnY7Zf2NKKndQTe35QIFaYloOAFzhzMKwUKUHcmT1TEANrXEbtQD5owXzyx1hLihBg3TInFkOhZYS84I/LR9SGFjpbwZlE7RaufvjfaVhxbaePq4KE+2E1TIesQIMgFdLDfVLEqBVnu9sy/9H+VFjeOF214+8q/baqxzCUEZmyaeEhD68gsB6C1Vbe6Jxr0vjPXpAgDCeAZTgy8IzpPCT665/Sa2Y5Lxf5J8IqrWXFXs8rw/jLkRxiQWJvQJFOSe+JzBLil968meU3mKqyLQ2X1Ff7mTB+fkPDfmKWgVZkz3PmWlOXHtxyWwPFsQBfCu+cFV5yMOGq1NJW6AVdQQLKoLjMYLh90Q5oB500Xp6nDCGgbhn5nKZ2IZR8UG03JIrpJnQ9CNDnx1LvozgbCFKbRr+joEAdOh+UA8OO9QlbIyIekDRnBlUGQSR7oFLU9ycFzyF7BEIegsvwgp1HwSt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?akRRYnB2UllvVnZOWERpVDJielRjK1doQTJRS05qTHQzTzZMVktSZk1nUVRx?=
 =?gb2312?B?NWxvbTVUdlJxQ3I5WERIQVdNRmNzd1JTNzI5czdrRHlFalprRDJzQkIwZzRH?=
 =?gb2312?B?SFpIalBLRHhkZnl3cXhrd1lpVlJJRjNnbytOc1lUaFdLdTJOZ0N5bzFVcmV3?=
 =?gb2312?B?bTNySzBLSHduOWpXWldXNzVia2s5M3VsMWJTVmxOSnY0OXlGYkNhaFF0czFJ?=
 =?gb2312?B?N29aWnZhZm1QdFdpV0NwRXRSZ2hoMDA2VC9ldHJGOXJkcmhXVkpJNFhCbzBq?=
 =?gb2312?B?TkowTkpScDVoWlYwL2VaRTJCeE5JL1hLTllIZ0dEZjdiRGozQWk4M3lCWHNl?=
 =?gb2312?B?ZDJKTmZWbTZqTkVhemNkMlZYVUdPd3FQMzFtQnB6L3RuZVR3SGh4VkpsNE1h?=
 =?gb2312?B?ODFKUzZRRGpOUkt5S3RjeXAvWGhPVmZwbUJySHVIOVVubjkwTnArQVdqcFRR?=
 =?gb2312?B?NHA5VUpldmp5ZU5NdWVycE44UktUU3NxSklRWHZ2bVdwRy9Ecjg4NStTMHJO?=
 =?gb2312?B?SDhrR3UrL2hxdGZBK0FXeDN3c2gxSzMxNWFTMEJLRW9BQVREWTdXTC9kUnd3?=
 =?gb2312?B?OFN1aTMzUXpMZk8zVGRDYVU0OERiNFRhQ0JMc3NrUmdsTmliRW1zQUdJaWh5?=
 =?gb2312?B?SVNDSVpRUXZtaFhCaVNQNENEQWtNNm8waEc0YXJXTk04UEI1eFlHWWJOMXpE?=
 =?gb2312?B?RGwwcGVLOXZIcTFyRDV5a0RKdUl6eUluT3l5WEtxYjM2VmRpaDlJcnVCSUhz?=
 =?gb2312?B?UFhpdFJkSTlWVCswdzNKcXZUZGVLQ3BxUkttQmlFVDF4M2pabjdkakQrMjhX?=
 =?gb2312?B?L1JyM0w1QldoQkxxdDFUNmNGQjdwQWdockpvRXJBYzBuSnZqQk9odWF3bThx?=
 =?gb2312?B?aEwxZzlxTlE1ckVsSHRnT0xGT2VGTW5ucHAvcnV6SHNUSlFTUHpoOXc0azRD?=
 =?gb2312?B?SVRia2tJakZ2RWlScWd5UStabVJiY2tTa3pTSGNrMFNHbEQ0Uit6S09wT3I1?=
 =?gb2312?B?clZzRkJyY2xzVUtZMEx5NzNsTUpDY1YwNmtKKzVMREpGa2hCRVJxMzBSY2J2?=
 =?gb2312?B?WktjcXJnZDJEay9YcUY1UEs2SHQzbzh2cWROby9vR1d5K3dkd211amZJclZr?=
 =?gb2312?B?d0todHpjKzY5NDlsNmt0U2ZtTG5TeFNEQlNJeStPNGptaWZ2Q2M0M3UzNnhz?=
 =?gb2312?B?UkFmWFBFdTFrc3V6amZQbERhYjBwSXJVVVVyVndIYmxuU1RWQjNZZDRWcXhV?=
 =?gb2312?B?T3JRYkNFTE5LejJaVXRCNnRDdEFNNGduTDc2MmZScnlPMHhRU2tCMXNMV2Qr?=
 =?gb2312?B?eDdkU1lhZ0YvYXAvck1OeWlPYTJid21vZlh2RmdxalFBSVBtWldmN1JFNGpS?=
 =?gb2312?B?OGpzcnFyeC8wVVJ1T3NLNVNqNmMrVUpvYWx0T09oMFIzRnQ0dURpZ09pY0FJ?=
 =?gb2312?B?N3JuL01aYlNpeVNJeGNQOEs0SElqUmM4TmdpbHY1Y1I0N3k0YlRVT1g3MzB3?=
 =?gb2312?B?ZDErc1V1Z0pWRXczeFpSUy91NUJzSGV0a0FVcHc3OUVRcWlXbFV3NS9tOGxI?=
 =?gb2312?B?TWViNjBmd3Z2R21tcTdIWkc0NGtPTml1aCtIQWFKT1lmRzZFQnVxVE1Gandt?=
 =?gb2312?B?UktIYUJPaXhocWU3VGxMMm9zd3pHdmJMbDV0bEJrMnEvTWx1cjdUV1pUQlQ5?=
 =?gb2312?B?S1dRemJWaGxsT3ZKbGlJbmJxYS84UE1UOVR0UlRJK3FFOWZuTWxEM1Yyd2xE?=
 =?gb2312?B?WG1VK2hlTVo1RWhCRkhVMm1IZlMzYzBsaTcyR1ZiajBuVng2UUFVVzd3MDY1?=
 =?gb2312?B?L3c2bHBzMHEzTDJMSkw0NHNOTXBjcytVeTZDdUpQaGRQTWNubndiT0FUK0Vv?=
 =?gb2312?B?ZGVJd01oNS9zc29JYmxleGFnT0psd2doTmZoRDYxamdCcHU5SHkrZFhYbWta?=
 =?gb2312?B?b25YaTIyNWhqVzNnMFRGMEIwemN4cmRNR2piNk9VNzU1Nk1KYUxzWCtYYnh4?=
 =?gb2312?B?QjduRlZ4ZEhEK0NFS1h2Rlh5VVZyZk9xSFU1djhuSyt3SWxjVXhMclVsTmtN?=
 =?gb2312?B?U3I1WFFCSE5GSjY4ektKK1pRMGpFcENKWncvL2N0QWxKUm1UVmhraUVQVXJN?=
 =?gb2312?B?RHgxbkROVjdKVDlOSVFQbnRCQkZDVnVSZ0lZditlLyt5cFdUcHlCQ1dDVEV0?=
 =?gb2312?B?MWc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: d7625557-c0c8-4ee4-24d8-08dc7a01a021
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 01:50:57.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xjs1hc/OVRcF6vNNAHD9WA4HkMqkzQhJXS64OtBzUS3gQxByz06vQk6dlIupmXhlK2lBml4k33/aZ8qkIH+2sxo96Go2sRotsMZkV/ARUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0830

DQoNCj4gDQo+IFRoZSBwYXRjaCBpcyBPSywgYnV0IHRoZSBzdWJqZWN0IGxpbmUgaXMgbm90IHZl
cnkgaW5mb3JtYXRpdmUuICBJdCBzaG91bGQgYmUgdXNlZnVsDQo+IGFsbCBieSBpdHNlbGYgZXZl
biB3aXRob3V0IHRoZSBjb21taXQgbG9nLiAgIkNoYW5nZSB0aGUgYXJndW1lbnQgb2YgWCIgZG9l
c24ndA0KPiBzYXkgYW55dGhpbmcgYWJvdXQgd2h5IHdlIHdvdWxkIHdhbnQgdG8gZG8gdGhhdC4N
Cj4gDQo+IE9uIFRodSwgTWFyIDI4LCAyMDI0IGF0IDA1OjE4OjIxUE0gKzA4MDAsIE1pbmRhIENo
ZW4gd3JvdGU6DQo+ID4gSWYgb3RoZXIgdmVuZG9yIGRvIG5vdCBzZWxlY3QgUENJX0hPU1RfQ09N
TU9OLCB0aGUgZHJpdmVyIGRhdGEgaXMgbm90DQo+ID4gc3RydWN0IHBjaV9ob3N0X2JyaWRnZS4N
Cj4gDQo+IEFsc28sIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgcmVhbCBwcm9ibGVtLiAgWW91
ciBQQ0lFX01JQ1JPQ0hJUF9IT1NUDQo+IEtjb25maWcgc2VsZWN0cyBQQ0lfSE9TVF9DT01NT04s
IGFuZCB0aGUgZHJpdmVyIGNhbGxzDQo+IHBjaV9ob3N0X2NvbW1vbl9wcm9iZSgpLCBzbyB0aGUg
ZHJpdmVyIHdvdWxkbid0IGV2ZW4gYnVpbGQgd2l0aG91dA0KPiBQQ0lfSE9TVF9DT01NT04uDQo+
IA0KPiBUaGlzIHBhdGNoIGlzIGFscmVhZHkgYXBwbGllZCBhbmQgcmVhZHkgdG8gZ28sIGJ1dCBp
ZiB5b3UgY2FuIHRlbGwgdXMgd2hhdCdzIHJlYWxseQ0KPiBnb2luZyBvbiBoZXJlLCBJJ2QgbGlr
ZSB0byB1cGRhdGUgdGhlIGNvbW1pdCBsb2cuDQo+IA0KSXQgaXMgbW9kaWZpZWQgZm9yIFN0YXJm
aXZlIGNvZGUuIFN0YXJmaXZlIEpINzExMCBQQ0llIGRvIG5vdCBzZWxlY3QNClBDSV9IT1NUX0NP
TU1PTg0KcGxkYV9wY2llX3NldHVwX2lvbWVtcygpIHdpbGwgYmUgY2hhbmdlZCB0byBjb21tb24g
cGxkYSBjb2RlLg0KDQpJIHRoaW5rIEkgY2FuIG1vZGlmeSB0aGUgdGl0bGUgYW5kIGNvbW1pdCBs
b2cgbGlrZSB0aGlzLg0KDQpUaXRsZTogDQpQQ0k6IG1pY3JvY2hpcDogR2V0IHN0cnVjdCBwY2lf
aG9zdF9icmlkZ2UgcG9pbnRlciBmcm9tIHBsYXRmb3JtIGNvZGUNCg0KU2luY2UgcGxkYV9wY2ll
X3NldHVwX2lvbWVtcygpIHdpbGwgYmUgYSBjb21tb24gUExEQSBjb3JlIGRyaXZlciBmdW5jdGlv
biwgYnV0IHRoZSANCmFyZ3VtZW50MCBpcyBhIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgcG9pbnRl
ci4gcGxkYV9wY2llX3NldHVwX2lvbWVtcygpIGFjdHVhbGx5DQp1c2luZyBzdHJ1Y3QgcGNpX2hv
c3RfYnJpZGdlIHBvaW50ZXIgb3RoZXIgdGhhbiBwbGF0Zm9ybV9kZXZpY2UgcG9pbnRlci4gRnVy
dGhlcg0KbW9yZSBpZiBhIG5ldyBQTERBIGNvcmUgUENJZSBkcml2ZXIgZG8gbm90IHNlbGVjdCBQ
Q0lfSE9TVF9DT01NT04sIHRoZSBwbGF0Zm9ybQ0KZHJpdmVyIGRhdGEgaXMgbm90IHN0cnVjdCBw
Y2lfaG9zdF9icmlkZ2UgcG9pbnRlci4gU28gZ2V0IHN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgcG9p
bnRlcg0KZnJvbSBwbGF0Zm9ybSBjb2RlIGZ1bmN0aW9uIG1jX3BsYXRmb3JtX2luaXQoKSBhbmQg
bWFrZSBpdCB0byBiZSBhbiBhcmd1bWVudCBvZiANCnBsZGFfcGNpZV9zZXR1cF9pb21lbXMoKS4N
Cg0KDQo+ID4gTW92ZSBjYWxsaW5nIHBsYXRmb3JtX2dldF9kcnZkYXRhKCkgdG8gbWNfcGxhdGZv
cm1faW5pdCgpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZGEgQ2hlbiA8bWluZGEuY2hl
bkBzdGFyZml2ZXRlY2guY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9y
LmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BsZGEvcGNpZS1taWNyb2NoaXAtaG9zdC5jIHwgNiArKystLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BsZGEvcGNpZS1taWNyb2NoaXAtaG9zdC5jDQo+
ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BsZGEvcGNpZS1taWNyb2NoaXAtaG9zdC5jDQo+
ID4gaW5kZXggOWIzNjc5MjdjZDMyLi44MDU4NzBhZWQ2MWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wbGRhL3BjaWUtbWljcm9jaGlwLWhvc3QuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCj4gPiBA
QCAtODc2LDExICs4NzYsMTAgQEAgc3RhdGljIHZvaWQgcGxkYV9wY2llX3NldHVwX3dpbmRvdyh2
b2lkIF9faW9tZW0NCj4gKmJyaWRnZV9iYXNlX2FkZHIsIHUzMiBpbmRleCwNCj4gPiAgCXdyaXRl
bCgwLCBicmlkZ2VfYmFzZV9hZGRyICsgQVRSMF9QQ0lFX1dJTjBfU1JDX0FERFIpOyAgfQ0KPiA+
DQo+ID4gLXN0YXRpYyBpbnQgcGxkYV9wY2llX3NldHVwX2lvbWVtcyhzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2LA0KPiA+ICtzdGF0aWMgaW50IHBsZGFfcGNpZV9zZXR1cF9pb21lbXMoc3Ry
dWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlLA0KPiA+ICAJCQkJICBzdHJ1Y3QgcGxkYV9wY2ll
X3JwICpwb3J0KQ0KPiA+ICB7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJyaWRnZV9iYXNlX2FkZHIg
PSBwb3J0LT5icmlkZ2VfYWRkcjsNCj4gPiAtCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmJyaWRn
ZSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICAJc3RydWN0IHJlc291cmNlX2Vu
dHJ5ICplbnRyeTsNCj4gPiAgCXU2NCBwY2lfYWRkcjsNCj4gPiAgCXUzMiBpbmRleCA9IDE7DQo+
ID4gQEAgLTEwMTgsNiArMTAxNyw3IEBAIHN0YXRpYyBpbnQgbWNfcGxhdGZvcm1faW5pdChzdHJ1
Y3QNCj4gPiBwY2lfY29uZmlnX3dpbmRvdyAqY2ZnKSAgew0KPiA+ICAJc3RydWN0IGRldmljZSAq
ZGV2ID0gY2ZnLT5wYXJlbnQ7DQo+ID4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0g
dG9fcGxhdGZvcm1fZGV2aWNlKGRldik7DQo+ID4gKwlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpi
cmlkZ2UgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiAgCXZvaWQgX19pb21lbSAq
YnJpZGdlX2Jhc2VfYWRkciA9DQo+ID4gIAkJcG9ydC0+YXhpX2Jhc2VfYWRkciArIE1DX1BDSUVf
QlJJREdFX0FERFI7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+IEBAIC0xMDMxLDcgKzEwMzEsNyBAQCBz
dGF0aWMgaW50IG1jX3BsYXRmb3JtX2luaXQoc3RydWN0DQo+IHBjaV9jb25maWdfd2luZG93ICpj
ZmcpDQo+ID4gIAltY19wY2llX2VuYWJsZV9tc2kocG9ydCwgY2ZnLT53aW4pOw0KPiA+DQo+ID4g
IAkvKiBDb25maWd1cmUgbm9uLWNvbmZpZyBzcGFjZSBvdXRib3VuZCByYW5nZXMgKi8NCj4gPiAt
CXJldCA9IHBsZGFfcGNpZV9zZXR1cF9pb21lbXMocGRldiwgJnBvcnQtPnBsZGEpOw0KPiA+ICsJ
cmV0ID0gcGxkYV9wY2llX3NldHVwX2lvbWVtcyhicmlkZ2UsICZwb3J0LT5wbGRhKTsNCj4gPiAg
CWlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPg0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+
ID4NCg==

