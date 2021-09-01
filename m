Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219163FDD59
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 15:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbhIANlB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 09:41:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34550 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240837AbhIANlA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 09:41:00 -0400
X-UUID: 2bdbc86db8d249b9ab5c577196539a3a-20210901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XsOdlDkmIVmFXV9IujibU6detIFtWgasQDKOExxOTcU=;
        b=qlWXbSVjcjz/iW8zQwTnpu0qIg/90ECib9E9K4JEFS4UoDOWjGvdQsG4VtghLe3EVpfIVQXsMVPdBEkxDrO4tXH19cl1ccY2YdDICSlfpftkGm+/7cB8o7EoIFrfihD1s98uObUSSa0R7UnPvLF2m6Qth1ZPnZ6N80S3NLrEO6Y=;
X-UUID: 2bdbc86db8d249b9ab5c577196539a3a-20210901
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1127875085; Wed, 01 Sep 2021 21:40:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 21:39:58 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Sep 2021 21:39:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8DsF6nzTxDXBsW5xF1eWYe8By3YmuLiSVnWsz29Fik09nauk+IsDGatUbzFoh00AL1kHE5KkkmF5MgnOYP68LJ0Bycn4n9/6ryusONOT7mEO2ARIvn4MFIbrjExhImbM642SMuKT3H1v0GxbqwiOTF7MNMcroHIltT9KNCYdF7oQnPjeQnCZVNmkrm5agO9QNV+FbErBRGaKhBQJgOL6BH19i7w9S29aV63uQeFll6UowBL6opTvn4ooqmSDruuPtHaYD9ngSIgvYY+FmqQBcVyPyB9+zkGy6dpHxp1crsUk7yILWH9YFOXpE9xztxj03iWx1FtRrwAlq9WX5dScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XsOdlDkmIVmFXV9IujibU6detIFtWgasQDKOExxOTcU=;
 b=PLnmzKYVYlzlzA3A0DgDZgwRpU71zCIyw6+A/l9oFqoN/ryCfHX0dX1R3vcLboGpjDBuOp6Jz7rIOA3RxjYcsFC8qwsqdllVnEYvFDjFzGjSoJOQdP3wsFUOoJutiiszptbDAz5E4XFw2g8tYodqExZ5+C7C02PHVH7ZTBT/+zQskha5DbBSAIEIjuc5e7MtJkEhpbL9ubdHEUAKx0d4rgC/W3q7xHWaquTYxlUMrbDRx/wtofHfqBIBRC9BsWJMHUVvuAJmL0COKcw/ri6kBdCTX1aDnuQq1coU4OfL+Xvw5FK45uSDx9T+W9vWVxIViWvKQt2tB7FxsNoyZZ+KNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsOdlDkmIVmFXV9IujibU6detIFtWgasQDKOExxOTcU=;
 b=Y5Wb+PAWjto9jkO5+uKZ4T8rZ2f0I8yRJT9OnV1UJ/ZHXwOvBAmehArmQSYixzSkoKFeCTVLdRjzd3rp3U9SGl6sI7C8WPHdeGr4yscFH+/c2cySl86yLLhrk6xSIlJhjQBN9Jv11XETF0be3Zbism5vh495LoTR9ypO8KgSlEU=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by PUZPR03MB6102.apcprd03.prod.outlook.com (2603:1096:301:b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.12; Wed, 1 Sep
 2021 11:46:47 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::3d11:979f:9b79:dcbb]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::3d11:979f:9b79:dcbb%6]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 11:46:47 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "caihuoqing@baidu.com" <caihuoqing@baidu.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        =?utf-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <Ryder.Lee@mediatek.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: mediatek-gen3: Make use of the helper function
 devm_platform_ioremap_resource_byname()
Thread-Topic: [PATCH] PCI: mediatek-gen3: Make use of the helper function
 devm_platform_ioremap_resource_byname()
Thread-Index: AQHXnwS6tgwrxPbhHkaXvSpMIUFhY6uPDqEA
Date:   Wed, 1 Sep 2021 11:46:47 +0000
Message-ID: <d1ad95b4b4a7ac4f729bd9338b0448d9d32cfc29.camel@mediatek.com>
References: <20210901074006.8783-1-caihuoqing@baidu.com>
In-Reply-To: <20210901074006.8783-1-caihuoqing@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 472bc580-02bf-4415-c7a8-08d96d3e2e07
x-ms-traffictypediagnostic: PUZPR03MB6102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PUZPR03MB610240AE559C2C39140112EAE7CD9@PUZPR03MB6102.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JmAfb9MApcOq/MXBQmkExtJaGeTNrboa+6WOYgdokZKXflJbRvrTvJadkAAjv3D+AiJZQo5YZ+b+P52bQO8CdVeCIJP0ozkUFNbzqX5GfKUm7g/wiAi8BkCBHe+CaEarWNS14cPn//956RMjRcR/eAa0ihxsBhq1ZelJ1pkDcoW1aYzBCZo6HCjDdPUcz+EWFlZGPzu6AeipkbsCgC1j/UInSXCCWS8xyOjH8u4IlCCxdwkhFrJZq/11wEZ655G1F+R7jVWws7W4P3EqUSgvRRNxLF7ppHNbTSkGP6Z2BlVK+YPT1zQgd/PNvASIEs1QdTryO5BZ9fj5r7jfq87rL0hCt+dyTQ2N/9Czn7NScQ82+MEprLR2ZhDA5EXzJJpaLHCatfyEnTGh5X1mTtUr7yIiGVxwXD+ZQdmdf/QHojQiAwf5EwDrqJ37wNmfM76sLDW0jwO8jtOAAjFfFlOdReoBB1ZQHdcnmpjB8NwxwvoQy7UfKel6lE1kPekUCGtQ7t40A/zPPEbO59xVFUmLdHdZuwmJDlTZZs/lWXJhP3TOQz/3HY5py0ibmYMTo1v6hlH7rQt9shuoVm2ARyh496gw7LelDARTlzs7W5am1fDQaRQwyOYTLI5dhNz3YFA7NYZe02XAr45MTMGLHqMqMeTgUe/MwQKD4LSLPEeVyWW0Y8RDR1g/ImF8LtZ9SJcy28nmv+DFe1KnvxZ56/NPKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(85182001)(83380400001)(6486002)(91956017)(66946007)(66476007)(66556008)(64756008)(66446008)(86362001)(4326008)(5660300002)(2616005)(6506007)(498600001)(6512007)(8936002)(186003)(8676002)(36756003)(38100700002)(71200400001)(2906002)(122000001)(38070700005)(6916009)(26005)(7416002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGRsdW1SbEtkU3dkTFA1UDBGb2tDT2l0NXA4Z2VzamxQODRMOXN1TVlOWUZ2?=
 =?utf-8?B?NFNiTXJQbEdpZlUxQW5UeGUzRUpkdjA4WmtoaU4wSDczWThCV0lGYlZxVlEr?=
 =?utf-8?B?SHFrSVAvZXl5eklzZXA1VXF2UnFuclo2b1lwclNBWFBTVXN5UU1VZUhsM1hR?=
 =?utf-8?B?YWJEM1IrcFg4eGJyak11c21vaWdvRDhyTS8zdXVqZnlYN2UvUWcvMWRoL2NZ?=
 =?utf-8?B?ZWdEZHZDUTNJdVlvWWdqSDh1N1BCK2J0NEtLdW1hQ3B6TWFSbDlvbUREd2ha?=
 =?utf-8?B?b3F1WjVyMzFyZlBaQk1EN3I5TEJPZ3dRZUpDLzY0S0s4MHlTRHptdDZEbHh2?=
 =?utf-8?B?ZGc3TDl5dkk4Y1pzOGZrZGIxWCtGVWFIY0hMTHUvMXhWNHFiazlYOGdPWHpL?=
 =?utf-8?B?VkM5ck1PVFhiNXpQbEYrZGdpMnloSGdtU0VFdUhNRzIrTXpQZkVtakNDOW5p?=
 =?utf-8?B?bS8zMzA0cTRFVFhiNGlFWVhram5YTnVZcjZpcE80S3d6MjZlSHcvd3EvOFBt?=
 =?utf-8?B?SmtjNDZTV2FEYnc2YlJ0MXVZc091YmJNQUUxQSsxVFdyaXZzTm5kU3JUeDNF?=
 =?utf-8?B?TWN6QXFFZnhaeTJwRG9WMTFhVHpYM3FlZDNPNlBySzZvdTQyTFIvSEM5UjR3?=
 =?utf-8?B?ZnRoUjJhNU1zd2FVWTliaGxNVVBwc0Q1cDlqVjRteXhOTmp6TFNKdFRHMjRn?=
 =?utf-8?B?bUtoK0lUNzhuZTJVZnlxRTN3clV6RGw1Yyt3elUwRVdxdEpvMXZsYW9LSUtZ?=
 =?utf-8?B?bmRZb2s5L0pVdjRlM29EbFZ1bFEyYU5KOEtwL3hZbUNqak5OdW5oWWVuSzNj?=
 =?utf-8?B?WXVseFpINlRUTm1ub1VOR0UwcmpZdnR2bGJnVngvZEhEalRiaThwaVlLekgx?=
 =?utf-8?B?NDF4b2pxM2trU1VnRG1lcDNBUFpDZkZwUU1KUjRBVk9CaVY5QmFsQXoxL2JT?=
 =?utf-8?B?UElwZHk1djIwK09HQk85QzBPd2l5SFMzTzdRWHdEODh4U1VuM2R4OUtoTHpJ?=
 =?utf-8?B?Wmxnb0pJYXhFZ0pOTk9oN2xhZWJHbG80Mm03MmdHdXM0QysrUVdJeVEvRitk?=
 =?utf-8?B?dTQ5eHpsWWlPMFZLQzZLVitUL2JHa0V2L3ozMFFWNGR2L1Nkbnd1ZUxnMGZk?=
 =?utf-8?B?d05oSElESVJmazdvZFF6VlQ4WmNrbzZINTN4ZjlOV2t1VVZqMGRURGk5TUpG?=
 =?utf-8?B?Yk5BcHhiQWZENHFCRHcwelM2bHVaR256Q0psR255dkFXcnBPWFFyUmo3QXFW?=
 =?utf-8?B?b0huWTk4cDRCazc2elFHejludDZsSi9yck01RDNzeUIyUWxsSVE2T1h0RFRa?=
 =?utf-8?B?WG41ckZGeUFHWnV2Zng1NzFMbDdpazFWZUVHSm5ZcmQyV1NEdXJSdnJHY2hN?=
 =?utf-8?B?TWtRUzRzSDA0Q2hYSjN4ZE84bkdkYUg4Rm0wOUVIZTY4SXAyQkI4c3Vuc29i?=
 =?utf-8?B?cUlvb3RNRGtwMGNnZ2ErNEFnOE1FKzMvZjZEbm95S0dXcUtwa1BPVjdlaEN5?=
 =?utf-8?B?bk16b1BSNUQ3Q3cyWEJtL2V5NTFCTGZnZ2hDVGtXV01aZXJ4UGJBcWVBQkJ6?=
 =?utf-8?B?MTZRU3R1eGxWWFZZSGY0azBSQXp5WEpRNFEwMTFpUFdZQ2VydW1qL1pIZDVC?=
 =?utf-8?B?d3RCRzNvM2dlbW5oTVJFYWMzeElBc3FmOHJOaG4yZ1ZVcDk4RHFKVjZmVEpv?=
 =?utf-8?B?QWV5c25GKzQ3Q2FDdy84bUhWeWxFdkJrZFNXUXdranNKdDliM0I2d0k4Yzh5?=
 =?utf-8?Q?wfvoI1UE0MPtrZqzrcu8gVDPt9ROKg6zcSfw2R2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB97466A6CD9E74F9EB9C0E26A07C1D8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472bc580-02bf-4415-c7a8-08d96d3e2e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 11:46:47.5973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 527n59gf+uDU8j64ovAXizzl+U6n8OlY6SNmiu6a3koE2GafBU6Opf0DAGrqeimy2x/qvDq6gHJhrucOT68bqEReNfihzIOuJ/2vcwUQ2jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6102
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIxLTA5LTAxIGF0IDE1OjQwICswODAwLCBDYWkgSHVvcWluZyB3cm90ZToNCj4g
VXNlIHRoZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKCkgaGVscGVyIGlu
c3RlYWQgb2YNCj4gY2FsbGluZyBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKCkgYW5kIGRl
dm1faW9yZW1hcF9yZXNvdXJjZSgpDQo+IHNlcGFyYXRlbHkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IENhaSBIdW9xaW5nIDxjYWlodW9xaW5nQGJhaWR1LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jIHwgNSArLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IGluZGV4IDE3YzU5YjBkNjk3
OC4uMDE0NzQ3YzZkY2Q0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aWUtbWVkaWF0ZWstZ2VuMy5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1t
ZWRpYXRlay1nZW4zLmMNCj4gQEAgLTcxNSwxMCArNzE1LDcgQEAgc3RhdGljIGludCBtdGtfcGNp
ZV9wYXJzZV9wb3J0KHN0cnVjdA0KPiBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiAgCXN0cnVjdCBy
ZXNvdXJjZSAqcmVnczsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+IC0JcmVncyA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sDQo+ICJwY2llLW1hYyIpOw0K
PiAtCWlmICghcmVncykNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0JcG9ydC0+YmFzZSA9IGRl
dm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlZ3MpOw0KPiArCXBvcnQtPmJhc2UgPSBkZXZtX3Bs
YXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsICJwY2llLQ0KPiBtYWMiKTsNCj4g
IAlpZiAoSVNfRVJSKHBvcnQtPmJhc2UpKSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRv
IG1hcCByZWdpc3RlciBiYXNlXG4iKTsNCj4gIAkJcmV0dXJuIFBUUl9FUlIocG9ydC0+YmFzZSk7
DQoNClRoaXMgInJlZ3MiIHdpbGwgYmUgdXNlZCBieSBwb3J0LT5yZWdfYmFzZSBhcyBmb2xsb3dz
Og0KDQoJcG9ydC0+cmVnX2Jhc2UgPSByZWdzLT5zdGFydDsNCg0KUGxlYXNlIGRvbid0IHJlbW92
ZSBpdCBkaXJlY3RseS4NCg0KVGhhbmtzLg0K
