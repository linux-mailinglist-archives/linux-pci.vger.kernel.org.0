Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54C543C033
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 04:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbhJ0CtZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 22:49:25 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:45120
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238184AbhJ0CtY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 22:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enhZbtfV6tRWths14g3mmfq+0qhojTBAzHPYiF844kSI9W2SRx5LT1Pi9vNtQkkrGUcSr32xgurKQWs8lMN6KZ05ZJ1sPNk7ATsF/1E42RLXcQ8bJtdK9C3FDWCS30ERVbRkTVEO9iCr9KN/6WbeoaRW1SfXkm1I4fZMuImi0CyI4GXGYERrL5vviExXFu8MksieVu+UTuAew/DLtij0xc2lXVVowPYGimcFbSMAJOsihUc27AgAyFixsXa+ly/tvVm6RrZ0Rc3EWwqN7Z++NF9C4eAsyl83a8j50MYb/KOXzEZmVInldcVYpwp3n5kq7LRpTDKYvQmEFOXJi8SFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9vHLsjIgDDEhfdU9hfDolOTjnMHhG6DoYK59xCG8lM=;
 b=UJFoQnpZM/58Ik1ZanlbyHQsyI71QT/OoiGz27Hr9UCT0AKC6DaehD8jvABGtXeuHuHo8YyJndOBbnfSbpAYv+Tp4ze+qEGrl8wIiOZ1KqkthPHMb5ENq2dutGU6mllwL91NWxt73hcb2+VHiuKbXsb32dldtDxOl+q04YqPLFG15h3L47urSg9t5UuStWHQslWgxywcb8XM23iWvn/rBhMDicUZjPogy51tsbTHpR3gelkHpdNoKzo+qOFAp3i7HA1FDWmttRPB399BVIIihPn+RrsGQ4+qToSI+w9D3hpsaSR/iVmy3nQtohOof8epuyZVxuJmzhgmBrQ8Ff2LCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9vHLsjIgDDEhfdU9hfDolOTjnMHhG6DoYK59xCG8lM=;
 b=FGqTSEfvauhtjOu+uU2LUbZvMXkSImjWBKRJQEdTysqyM2XHefGkE4k4OY7hG1h1xR+tAsVsMSscAWC6i5nF340AyMu/8sXdbT8oi18rjTj/9Au4FSYT0v5OdKfYQ5Q3QZSpCvylAuKu7tJDzvQRf9wYbo6nSS8wNFp4851+Anc=
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com (2603:10a6:802:a::24)
 by VI1PR04MB6143.eurprd04.prod.outlook.com (2603:10a6:803:fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 27 Oct
 2021 02:46:57 +0000
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::793c:ef8d:72fc:df15]) by VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::793c:ef8d:72fc:df15%7]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 02:46:57 +0000
From:   "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH 1/2] arm64: dts: Add PCIe endpoint mode DT node for
 ls1012a
Thread-Topic: [PATCH 1/2] arm64: dts: Add PCIe endpoint mode DT node for
 ls1012a
Thread-Index: AQHXxNsHHuEdoXhrNkaTj5PtbQy5Z6va6CyAgAtB4/A=
Date:   Wed, 27 Oct 2021 02:46:57 +0000
Message-ID: <VI1PR04MB2974FEC7C2669721E83B40DE84859@VI1PR04MB2974.eurprd04.prod.outlook.com>
References: <20211019111750.28631-1-Zhiqiang.Hou@nxp.com>
 <AS8PR04MB8946F2F300CD848DF1C29F658FBD9@AS8PR04MB8946.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8946F2F300CD848DF1C29F658FBD9@AS8PR04MB8946.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2486586d-a1fc-40d0-ff77-08d998f40b43
x-ms-traffictypediagnostic: VI1PR04MB6143:
x-microsoft-antispam-prvs: <VI1PR04MB6143FE2E54097A754587545B84859@VI1PR04MB6143.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dtnwGGDqkU5YPY7A+1L0H1Y9yIMZuva2lACJlZpxlWfFJ33gqWqwZtTc90Z+wF+EpGgF/pAPPnp+FgnXBgc2ANLA30LHiwFmBk5ZhbfufVweUU0durL+CYFzz7r5KLJ10gh0rfoOgBpl0Y6X8ffo0Kn2D8VbN0bIpk12H3NPEh6oJNF6byxJPyIjVmmhFptYaqZagKd8gGrdSGuL2OcQE4JuinwFTJTnjlAjM791jVp3Ibr7IMONwDbddhU6ywy69XjLwWb37k9/Rv+zrwc/qnN5qf2UFckDFankyH45dYaFj40AOQri5h4Rbk1Dr+MzeSvz3GHKpOosjxml4B/2K2+40ntOu/AGFffeqxIe96JizvtVCQJCcCtnw++RLh3CTNP5t4RnlZ+g/AjBO75RcmEVKCBPUkSmHRfrkaiUS6/IvLOiJggMmD14THpBG+QXsNSB6d25j0zUoZm4ySHSX+nWFIwDzSi5xe6jvA2hl+m4ZOrMP/J2BYdwAu2jGsDYTFyundlOTsQNUJK4PImZQI+xhYKFPwz50Sfev7lo2FE79Xz7Ok9jWSYKFVyL3lkrGjlirCFfZcy7FJXlwl46JRphJwhqJOV8Hw/X4+5uzcCyXYtL+bQli/D3oNQEMZqhcnG//vs0AyP+hsc8GHdjsCM8iEcpjvK/c5+17WizP+7z3fCYj/ljRBWt7nfrtnE9vTDKIboM/bquyh7Zx4CWMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB2974.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(83380400001)(508600001)(71200400001)(8676002)(66446008)(186003)(8936002)(26005)(38070700005)(5660300002)(7696005)(66476007)(316002)(6506007)(64756008)(66556008)(66946007)(38100700002)(76116006)(9686003)(122000001)(53546011)(86362001)(110136005)(2906002)(55016002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N2lBMHRlTk5rVEE0Nm9XOW9aK29VcWNzeDJvdDVDclZxZE5sb3ZMY2RsaXAx?=
 =?gb2312?B?UlFhQ0dRZ09FUWZ0TjJ5YVUzeGttYkxnWS84L3F0b094SXh3UUdiUlZoNHor?=
 =?gb2312?B?cWdldVlzODloM2c0TGM2ZjBWUzVHeEhQVWZiaWxSWW0zY1RWL0JUd3NUVFVy?=
 =?gb2312?B?VG83WDF0SjZIN1RXek43Q0ZqSm51aS9waFZsVGlPVDNQK0VxSFhYK3g5QTFG?=
 =?gb2312?B?ZnIvb01tendDRVhJb3h2QWx3NG12VTZjbzJkOGFXTHUwUFdZck5ET2Vkamgr?=
 =?gb2312?B?eXVDVHdYSmRrM2FVWXZkOVZLZ2ZHZGlCR3F0MnM5QkF6ZDNSZ0lYMzZDU0R4?=
 =?gb2312?B?ZlU2OCsvYmdTWm5rdlM4RzllQlZiUTMydVl5djN6Ky9mMDJZRFRQWVlkRUFH?=
 =?gb2312?B?bC9RYzFuUml3ZUgvNFdJK1QzY2RXbVNSemRQcTFhNGlXOFNkQkZseUpLTmdF?=
 =?gb2312?B?R0l3SFoxdUhmUzdHcUhiZjlCU00wTUZkdVlJSnZOZjNNRkVZOUU4dFUvY1dl?=
 =?gb2312?B?ellNZXJuenJ0K1NMRXl0VlkyUHRCUjNkQm1PcFA4YW5CWFY0Q0IzWThGYk1M?=
 =?gb2312?B?RzhMekRpQ002Wkc0dkZJRmQxeGlFWk90c0ZLTmtJcjRNa2FrRDIreUdYL2NL?=
 =?gb2312?B?ZGZRSzhzNzhLSGtkYTVGV2FWR09FVERKL1c3ZzA2Sk43c2NyUnFFRWIzR1Yw?=
 =?gb2312?B?SFYrVHBNSDJERTZxZC9FQVpGckpKcmtQOGhiLzJnWmlDUWdwYi90NjUzUFVC?=
 =?gb2312?B?TldFdlU2SmcyMXNBdHlSZG5GZUtmOGJlRDFrMkduK0FNRlorVjF0Um9CNk8y?=
 =?gb2312?B?V212YU02bS9IU0R6OGZZTm0rOVlIUU9OU3h4K01OQ3FBVG5CU1d2K1FQWnJH?=
 =?gb2312?B?TjdLeWZ2Z24vWUxKMmcyeldNRmVMelF2NEdCMFV2V05qbTU1UXBLbk1rSTlw?=
 =?gb2312?B?cHNkT21SdW1wSVlxYzFoSTZhZ3M0ald6S3BPSjAyZkdxNlArakNsUGYwZDJC?=
 =?gb2312?B?RnVCTnhNNzNqcWxwQlZJbEVndUh2WVV0UndQYWtGT0R3cVM0UE5USkpnSkVp?=
 =?gb2312?B?SU9CT1J6M1ViL2M0emZEVlZwNW9wTnBYL0Z6R0l1bG1lM1NGSXYyem8wY2w5?=
 =?gb2312?B?Sk8wRXk4aWFvbVFQVjNpMFZ6R1RpNXpYZlp3YlY0RTlYays3WjFlM2kreXFI?=
 =?gb2312?B?U285eVdIc1NYSStUTzZNMzhZZEFTZGV5eU5DYXdqZk84bldFQVNTbHZjOUhX?=
 =?gb2312?B?aHc1cUtVbjlWRHp0UTJPMUR6WGx4TmxQTzBzbnhQeVp1WktrZnFBaUR2d2pl?=
 =?gb2312?B?VGV2NURQQ0lUckZCejl4YUxEcUtRU3lBS2pjY1FFNlMxeDdyODdsM1lJUHM3?=
 =?gb2312?B?V2Y5bUJtY0ZrS2RrempveXhJOTJzVmhWYlZoNDFWMDl2MU1HZnJpZThXbVJF?=
 =?gb2312?B?OHpUM0YzNVp2MURrK3lUbW84WVJqSG1JTFIrZWpBZzNBUGxDVUcwNWRUWTI0?=
 =?gb2312?B?Ry81aHJ0dGM2NlRGRWlrQUZxcFBveGlNRGh4NWNOVEhCRGNtc1BsTE1CTUVI?=
 =?gb2312?B?YzlYckFpQ21XSVFWekpxRkdudkxHU05maU5VK1ZPQlA0MDZRS0VRYXQwam9u?=
 =?gb2312?B?MlRLc2tnSEhudmg0YkF1RTNIbVhxeFlmdTJ5VHhMdElUTmVEUFA2RHFLTHZJ?=
 =?gb2312?B?aVBwdlVQdFZTMytoQ1NjL3BDSjRIM3hvbnA3ckFha2JHaVYwUGNjUk12WHF4?=
 =?gb2312?B?dnVBaDhOcGZzOHByM1VDbEpWWFh5UFBPN1BmcTRYSjNZUTlLNkoycm5QYS9U?=
 =?gb2312?B?QXVkcnZpbVJNZXpQeWlwb0g5eEk5RFpoMy9wbVJucVdhS3VrZks0c2R5UnIw?=
 =?gb2312?B?VFAwMzlUdG5LbUplNVhTa1dUM3JObzZNcG93Tit2ejBhMEllVnBhUkE3VlJl?=
 =?gb2312?B?UDEraGIxcDF3M0FRQ0RvSG4xSDZRREs3RzIvR29hMmtCcVJTK1RMYzUzYy9F?=
 =?gb2312?B?bEM1bmh3MEp2WFFzZUZqZ2dTd3d4bE9VOFN4YllsaXNaREdOM21qeGtsMGps?=
 =?gb2312?B?aU83Z1NmVnBSaXNCaGt0NEwrTDdET3lFRUNxUWFyZXVKMVExUXkwU1cyM2ZO?=
 =?gb2312?B?V0xZdGlUb25LOGg1K0c5TmtxcEVqeE5sNGpZdWFFU1QzWU52NDQ0SlhmMmJM?=
 =?gb2312?B?L0E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB2974.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2486586d-a1fc-40d0-ff77-08d998f40b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 02:46:57.7344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66CgkcNIyqW2VZPC0T7YYww4uEkbYXzsybNVzIl3CuihMC97lv7c1VFmHQxCBUgcJzc8bLcOx0gwvhUphiZZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6143
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTGVvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExlbyBMaSA8
bGVveWFuZy5saUBueHAuY29tPg0KPiBTZW50OiAyMDIxxOoxMNTCMjDI1SA2OjMxDQo+IFRvOiBa
LlEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7
IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGtpc2hvbkB0aS5jb20NCj4gU3ViamVjdDog
UkU6IFtQQVRDSCAxLzJdIGFybTY0OiBkdHM6IEFkZCBQQ0llIGVuZHBvaW50IG1vZGUgRFQgbm9k
ZSBmb3INCj4gbHMxMDEyYQ0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gRnJvbTogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiA+IFNlbnQ6
IFR1ZXNkYXksIE9jdG9iZXIgMTksIDIwMjEgNjoxOCBBTQ0KPiA+IFRvOiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiA+
IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0
QGtlcm5lbC5vcmc7DQo+ID4gTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBsb3JlbnpvLnBp
ZXJhbGlzaUBhcm0uY29tOyBraXNob25AdGkuY29tDQo+ID4gQ2M6IFouUS4gSG91IDx6aGlxaWFu
Zy5ob3VAbnhwLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBhcm02NDogZHRzOiBBZGQg
UENJZSBlbmRwb2ludCBtb2RlIERUIG5vZGUgZm9yDQo+ID4gbHMxMDEyYQ0KPiA+DQo+ID4gRnJv
bTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBQQ0ll
IGVuZHBvaW50IG1vZGUgRFQgbm9kZSBmb3IgbHMxMDEyYSBhbmQgcmV1c2UgdGhlIGNvbXBhdGli
bGUNCj4gPiBzdHJpbmcgb2YgbHMxMDQ2YS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBa
aGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMTJhLmR0c2kgfCAxMCArKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAxMmEuZHRzaQ0KPiA+IGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAxMmEuZHRzaQ0KPiA+IGluZGV4IDUw
YTcyY2RhNDcyNy4uODJiZjJmZTZmOGJkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMTJhLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDEyYS5kdHNpDQo+ID4gQEAgLTU0NSw2ICs1NDUsMTYg
QEANCj4gPiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gKwkJ
cGNpZV9lcDE6IHBjaWUtZXBAMzQwMDAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGxz
MTA0NmEtcGNpZS1lcCIsImZzbCxscy1wY2llLWVwIjsNCj4gPiArCQkJcmVnID0gPDB4MDAgMHgw
MzQwMDAwMCAweDAgMHgwMDEwMDAwMD4sDQo+ID4gKwkJCSAgICAgIDwweDQwIDB4MDAwMDAwMDAg
MHg4IDB4MDAwMDAwMDA+Ow0KPiA+ICsJCQlyZWctbmFtZXMgPSAicmVncyIsICJhZGRyX3NwYWNl
IjsNCj4gPiArCQkJbnVtLWliLXdpbmRvd3MgPSA8Mj47DQo+ID4gKwkJCW51bS1vYi13aW5kb3dz
ID0gPDI+Ow0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGVzZSBwcm9wZXJ0aWVzIGFyZSBkZWZpbmVk
IGluICJzbnBzLGR3LXBjaWUtZXAueWFtbCIgaW5zdGVhZA0KPiBvZiAibGF5ZXJzY2FwZS1wY2ku
dHh0Ii4gIFNoYWxsIHdlIGFkZCBhIHJlZmVyZW5jZSB0byB0aGF0IGluIHRoZSBiaW5kaW5nPw0K
PiBPciBtYXliZSB3ZSBjYW4ganVzdCByZXVzZSB0aGUgc25wcyxkdy1wY2llLWVwLnlhbWwgYmlu
ZGluZz8NCg0KWWVzLCByZXVzZSBpcyBhIGdvb2QgaWRlYSwgYW5kIEknbGwgY29udmVydCB0aGUg
YmluZGluZyBmaWxlIHRvIHRoZSBmYXNoaW9uIERUIHNjaGVtYSBhbmQgc3BsaXQgaXQgZm9yIFJD
IGFuZCBFUCBtb2RlLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+IA0KPiA+ICsJCQlzdGF0dXMg
PSAiZGlzYWJsZWQiOw0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICAJCXJjcG06IHBvd2VyLWNvbnRy
b2xsZXJAMWVlMjE0MCB7DQo+ID4gIAkJCWNvbXBhdGlibGUgPSAiZnNsLGxzMTAxMmEtcmNwbSIs
ICJmc2wscW9yaXEtcmNwbS0gMi4xKyI7DQo+ID4gIAkJCXJlZyA9IDwweDAgMHgxZWUyMTQwIDB4
MCAweDQ+Ow0KPiA+IC0tDQo+ID4gMi4xNy4xDQoNCg==
