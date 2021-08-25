Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9564F3F6EC7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 07:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhHYFYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 01:24:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55204 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229457AbhHYFYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 01:24:52 -0400
X-UUID: a9ba4c0bbde54bbba0b714c46d7a80d9-20210825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sNqlhRX6kWmiuuKhDkx63izF7pkvkylWvcAy0vI7f7U=;
        b=QxB1v5kE0P5xe9+sv+8IMd9daJowLwTsHx6W376B4Mf9pfAl4dAV6We8oAjpgQ7grMyb69u58TOdJLXIZFUlTibfTXwMPj6l2/cwKFZ5jED4fjRVyZahgOBHlfLtKwgeJjyTxFbHn/uFuuwImp24nq+cfoY2uUWqGQzvZrJ9EB4=;
X-UUID: a9ba4c0bbde54bbba0b714c46d7a80d9-20210825
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1612980479; Wed, 25 Aug 2021 13:24:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 25 Aug 2021 13:24:01 +0800
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 25 Aug 2021 13:24:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYDbvfuozHZqb6j5ek5ro4SLfG9KaW885H/yikUTta1UesnB+Jv65KTDt3mHK5BuM/m+EewUVklzBuC1RxJZ4gz43JeZVZua0pGLsrPrtdBl6h7ozLO7fhFhVK4dtXW4fnqw0rS+XJkFwlUK2fL7N3/YRcYqFN86+hRWrRRSeP/xK6b7nwdQFyitArHI0jfgJkaHL7gpm0MA3Geup0EOYDhOckffdslI1P1Of2Ili0b4ssUtNJXTjJpYUXLKS4ZLAgDrZ6UdOO2Q/0Pya5uTFSTwkooyZ2Ri/RcEeW8BEj2mu2RgUrEzvJcHPUzIQIXtPBp3knouDldQEwsBTpuO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNqlhRX6kWmiuuKhDkx63izF7pkvkylWvcAy0vI7f7U=;
 b=V5+EZQYpQu/ZWT131CH8R5DtXIUAU36Ihzx7OXcGgPygYeYi/4SyTCfFm18P2XkqzLBd7/C6WCTfep+22xltrbw6XWF3VWQB0vJWY1cM9W7MUYUZOfl5mbwVUfEQmxUm7yXJupb2ByQnNgOFNVd4+vkK3EiXt/VuSDmNPgShmiUbYBqJOSZ6pC05im49g43XSk6dufM6Nw4tx/s0jubATNvffyBSlj5j6UTWOaemptMqAb4roDHbGdkXkiCMtT/8qcuWfmtdOviOO4JsHzwwd0ry4Gq4FObNK6NUKrsFw3YjvjrBKWUUJbzgbN26vVy27yNVa7X3ukXHdAJIHHjdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNqlhRX6kWmiuuKhDkx63izF7pkvkylWvcAy0vI7f7U=;
 b=EXHBjjuQB67Y60VPJmMvR8SBctWLgWksfLLB5SMvujY3UU6Wqe/bV0+0SDFde/gwqbHi9DsCY/AhnczGMc5dOiHdzq4UIE68jX/NwRJzINQA/PKedyO2ppYeijJWHXkSvgJN8jSb5c+pmhf+EZ5LYAFeRMueiiJgg9wI/11hCjg=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by PS2PR03MB3702.apcprd03.prod.outlook.com (2603:1096:300:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8; Wed, 25 Aug
 2021 05:23:50 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::3d11:979f:9b79:dcbb]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::3d11:979f:9b79:dcbb%6]) with mapi id 15.20.4457.016; Wed, 25 Aug 2021
 05:23:48 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        =?utf-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <Ryder.Lee@mediatek.com>,
        =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Add support for MT8195
Thread-Topic: [PATCH] dt-bindings: PCI: mediatek-gen3: Add support for MT8195
Thread-Index: AQHXlWwJDRNjIRM0EUCnH8iy4K8FFauCwROAgADY2oA=
Date:   Wed, 25 Aug 2021 05:23:48 +0000
Message-ID: <9aa2ff56984f2d80152e4800a71cb7f71d0e1203.camel@mediatek.com>
References: <20210820023521.30716-1-jianjun.wang@mediatek.com>
         <YSUE08dgiGhFsjwH@robh.at.kernel.org>
In-Reply-To: <YSUE08dgiGhFsjwH@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e4fc812-618c-456d-f152-08d967888481
x-ms-traffictypediagnostic: PS2PR03MB3702:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PS2PR03MB3702AED4FBD3226638CE8D98E7C69@PS2PR03MB3702.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5vG56+bS90xHCwg8AKz1wWrwtbz/2vY0fipSMqavkYhfGLp4TXnl4x1pk4ONZRHpBntYTi/4zaEtnA0Ch6fCngRWiNmwr5W1BcPI7g7eJ42Lg6fllO/+0o9DYpNFgqHkhrcQqV/oMQouXPIAHeaTHCVbwqZsC9U+5FxgcY6mWRj2pXXnNctxD+1hKxeDa7u0BV6D3EgKwidsrkFlceW1xI5RGeUKTmtv+GbmML7YzqJpl3Ro8BFI4UhReSWxh9Ohm15KqQUPyK8ii1K2/J5r9S/V0ZjsTxaPlATAHQR+tbCWGJAWvyC04/F5cvTCc9iRVgUXRzlIeKA5ougRQmqA0iKfrow232aqs1iV1i1EWvse/fRsXaDEBImEInoBQ4KmLhGG2m67hIZZGVsxtgsL9yxwRbx/bqUVhituz1Ph7hc9Hz2ehohGd/LsViUmfN3+/kE4f+hefIzBON9N9iCXrHCcwY50SRUEXdJFh6x7T/Ltuy0k/0/7FOmgYX+kUpXaILWuTb3yM2gi7dB8X3fZeYBr6+BfBpbzcj8Cutc90jbrlOqhYpcuJHidvRR/lOXzzWWA/eujPZ5Ebi3zkxozNI9UrryNmqnC2L4jpex5wW5y6YdO+eFUApNvihHj4bq/q1mEdcX+HJ2wOnbZDOhI+eiXj6JNCAwAvRPrhbNpIISfHMj1gJaOap2qccfF22DlO/YM5x8M/OkK9X1YK02QoT0Pf7LYRziZYhe/ahfq+Csy5PNK+9DoRirq/KQSRieiyicWkQgON4lNvbFndPmZQ9kIoTdjzXHsyZzWE9060Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(36756003)(2616005)(86362001)(2906002)(6512007)(76116006)(8936002)(966005)(186003)(66446008)(122000001)(91956017)(38100700002)(8676002)(66946007)(66476007)(66556008)(64756008)(5660300002)(316002)(85182001)(6916009)(26005)(83380400001)(6506007)(54906003)(71200400001)(4326008)(38070700005)(107886003)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnI5QnJKek9nWXpzZVhoSFdwUFhiUDh0N0lPc0FtSzQwSjQ0b1U0Y0x6S3lP?=
 =?utf-8?B?Sm96anByemZnbnJYMXdGdy9ScDBLa09xd2l2UU1FMFJEdDdqSnJybUMvcjlM?=
 =?utf-8?B?TFI5TEF4VWJzc2M5eklmOTRsOWIrWGdxeEdGTWF1Rk15YW5Gd2JjT0lTWmNz?=
 =?utf-8?B?Wmd0cGQvZU5sOGREeXNrWlB5NC9RL0hKNTFhdjFER0ZUbDF5VENsVElrVm0x?=
 =?utf-8?B?L3VJUlJFNnhZVmtLQkhGdjJpTXNueWVQUWpMc1dZY1lQOTdwdE1NZ0JYWkE3?=
 =?utf-8?B?K2JoYmxxV0kzYlJJV3MvczZxT1dXUmNRY05OTlJnM2crTGEranJEN2hFenhp?=
 =?utf-8?B?NUpvNUZUVitmcDhkM3RkWURlb1dOclhMaTh0UFdKeHhUU2p5NTZ1M25iRjU3?=
 =?utf-8?B?TUNhb0ZTd0YwQlVVdUxSLzZIUGk5ZzZuOGlNT1ZzOVBMZmtySFpoeXpBdDVi?=
 =?utf-8?B?Q1JlbXpSVXUxVDRTK0ljNFI0OXd2NXlGWFBXNHpabWhUNDJ0S0plL1VrY3NP?=
 =?utf-8?B?dDJBVmJHM0lOWXBKSzhmTjlEbStBc3N2Q0M4UkFzbmFhMWkybkxXSFQ0TU8w?=
 =?utf-8?B?WkdadFdYV01ncVMvNDBuQzBBZW53N3pueWlVZDFwOEt0bWdqa3V2MnpQWlBU?=
 =?utf-8?B?ZkRSdnRxdmpWcE5JclNVUDdZRHdWc3lDMTQ1Zm02TENxVGNwQkFWL2dPYW1N?=
 =?utf-8?B?MDNNSTQ5dmtqb010Z2tmZU9lZ055K1BBYXBHK1VrT3hkbnZ4SENUYmlGakN5?=
 =?utf-8?B?YkdWWGZyaUpuZW1Ia1BVZ3pTdVNBT3p3RWw0QVkyM3Y0SThCeHhSVTNaY0Ez?=
 =?utf-8?B?ZThuck1NRlQzeUZJa2FnTm85TWVySkdqNjkzcVhBSU9JMmpyclZDakRNOVor?=
 =?utf-8?B?bXZGTGk0L1VZVjJFNjdDYzhiMGxKMk5tZThtejh3UDJCaERxSnBUeE5La1kv?=
 =?utf-8?B?NXBYTkpDNDJPRFJiNlQ4T2xCREZPYndBdVduRTRSUEtWUmpkeXlTaVVERmY1?=
 =?utf-8?B?U1Z6b3IyazlBS1BkS216MzgzeURsa1V3Vk4rUUladmViZHl0T2JVZXFmUm4w?=
 =?utf-8?B?ZUE4VmZiaEtucmR4U0M2Tzdud3hUYXVhNzUzODBiMEFGVmwyNzFvUDBhclFX?=
 =?utf-8?B?bmlnZkpCcWg4cGpJMlNZeThxdkdZMWl2NEFkWjdMeFplajRyQVliN2lHOG1T?=
 =?utf-8?B?eHlOTmpVVVlQbEpZTW8yMVVsMmMzZkVHcmUrMTZxczk1a0pyRUt4QlNPR0NR?=
 =?utf-8?B?UW1Dc1JLMGxJZUJaR2Y2ajVmMDFmRmgyVFJJZkhjN1VUdVh0KzNHY0FXYWc0?=
 =?utf-8?B?TUlNZkN5R2IzTzZBazVscXpjTTlWdEFnTjNvckhGTXNnWGRFTXpTRmJYZWwv?=
 =?utf-8?B?ekpvMFdVamd1dnNGN3BFamtUN0c2UVZoejN0ZXlyYzY4U09ob29SSEZVWU5u?=
 =?utf-8?B?MTdGYy9xVy9qQXVyVlh5WkRCVnp3SVNERTdDSkhVbXZ2cmZFU1hLaUdiSHho?=
 =?utf-8?B?UlBsbmF4bWp2dUs5bDVGWXBhQjhKV3hXK2lOMi9ab3N1YnVia3VEMWttRlRy?=
 =?utf-8?B?bkUvcVJzbldmeTBuUDhyV25KK21mMk1pMnRKaC94M2lmRG05MzJYYzZzcTV1?=
 =?utf-8?B?d254bXpJMmsraVVBMEQ4Qk5JK2VCL3ZVVS9KV1MzRVJ4TnV5cGs2UjFqMTdp?=
 =?utf-8?B?ZUFFMEJ5UnBEY3A2enZib3RxYkVIa25Qc0I2SXp6cUdMdFJnR3JHQnNicFR1?=
 =?utf-8?Q?rEAD6ACw5Q+X48sLtdnYzjTilQzpdCSEH6310BV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <537F9349F5B8664AB6AB2E70C2EEB518@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4fc812-618c-456d-f152-08d967888481
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 05:23:48.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydPLQl9FpkUSo25WZHQK+Whp8zKYEkmin8L91h/KQ9iMExxqwwpqK3182AhqbuFpqYSMplaqBrMTby1Pw196kQYMNJpmC1elwAVx+WW6UVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR03MB3702
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTI0IGF0IDA5OjQwIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCBBdWcgMjAsIDIwMjEgYXQgMTA6MzU6MjFBTSArMDgwMCwgSmlhbmp1biBXYW5nIHdy
b3RlOg0KPiA+IE1UODE5NSBpcyBhbiBBUk0gcGxhdGZvcm0gU29DIHdoaWNoIGhhcyB0aGUgc2Ft
ZSBQQ0llIElQIHdpdGgNCj4gPiBNVDgxOTIuDQo+IA0KPiBJZiBpdCBpcyB0aGUgc2FtZSwgdGhl
biA4MTkyIHNob3VsZCBiZSBhIGZhbGxiYWNrIGNvbXBhdGlibGUuICdUaGUNCj4gc2FtZScgDQo+
IG1lYW5zIHRoZSBjdXJyZW50IGRyaXZlciBmb3IgODE5MiB3aWxsIHdvcmsgdW5jaGFuZ2VkLg0K
DQpIaSBSb2IsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNClllcywgdGhlIGNvbnRyb2xs
ZXIgZHJpdmVyIHdvcmtzIGZpbmUgaW4gdGhlIE1UODE5NSBwbGF0Zm9ybSB3aXRob3V0DQphbnkg
Y2hhbmdlLCBhbmQgd2Ugd291bGQgbGlrZSB0byB1c2UgdGhlIGNvbXBhdGlibGUgc3RyaW5nIGlu
IGRldmljZQ0KdHJlZSBhcyBmb2xsb3dzOg0KDQoibWVkaWF0ZWssbXQ4MTk1LXBjaWUiLCAibWVk
aWF0ZWssbXQ4MTkyLXBjaWUiDQoNClRoYW5rcy4NCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogSmlhbmp1biBXYW5nIDxqaWFuanVuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2Vu
My55YW1sIHwgNA0KPiA+ICsrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtDQo+ID4gZ2VuMy55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLQ0KPiA+IGdl
bjMueWFtbA0KPiA+IGluZGV4IDc0MjIwNmRiZDk2NS4uZGNlYmIxMDM2MjA3IDEwMDY0NA0KPiA+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNp
ZS1nZW4zLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sDQo+ID4gQEAgLTQ4LDcgKzQ4LDkgQEAgYWxsT2Y6
DQo+ID4gIA0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gLSAgICBj
b25zdDogbWVkaWF0ZWssbXQ4MTkyLXBjaWUNCj4gPiArICAgIG9uZU9mOg0KPiA+ICsgICAgICAt
IGNvbnN0OiBtZWRpYXRlayxtdDgxOTItcGNpZQ0KPiA+ICsgICAgICAtIGNvbnN0OiBtZWRpYXRl
ayxtdDgxOTUtcGNpZQ0KPiA+ICANCj4gPiAgICByZWc6DQo+ID4gICAgICBtYXhJdGVtczogMQ0K
PiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0KPiA+IA0KPiANCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBs
aXN0DQo+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlaw0K
