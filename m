Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB8347068
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 05:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhCXEKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 00:10:44 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:45376
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229882AbhCXEKZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 00:10:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL1fHye6rL5t2K/MTR1Nha5wPn+G7X9hp0Fhnm6qFq2JTuvrqL/eqSwJ6jfkKRLl8JjOBeYJFTdmqpGttTiLi6TYzGMzJvphFhvD39oqyosu2J54wJSS1Fr4D1QKgZLrmqHgXgd22+uhJs1mzr2afLf6sa6iy0n5jsfbs/hOp4zIHKohGuM73YaNnQXCCCDHe9xLSqHDiYerthv4/t0yK2DJzL1MucWQsan99pDIJo72e7uyJ9n/BM/zw7v9ayi1EqSkv5E944J8BtjS9mTtv/J8+o3/BV6MN5dAOnoPGv/0huiEKn2iYervCaXhOivaQhEDSM8CI35mQYmu7suJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5GI0QW6TPr0mgcU0SH9TJo4Vf0lp9/XiEVQFziiFFM=;
 b=hNhIxNpNbKZISVZn6/BR//bH7uPQp7+BwdAEa4CkiGNvj+o8xm0V0tje/a/m3JdQMA3pYfhzTuBhAplii+SvaNvfYicCRk2mhdHkr2NDQWCwxgHZGU6zCl52b5+9Q8QloIO90sxKKKDshj37HK6GhRm+n4eSOT0PI8bgeXfKdSs5XQzVZKqxS0lYGQhIC3GP76DHSNtszfhhLyzN0USFcdAUfSBTwX5qTO20YkOZtaT29igmKsCHR2/MVZzYvSmukz6q2xDZy210m8qpAyRg8XJtCO3eImrDRZrNlt+QE4nKLGVViY9XYtqwRSPu2HxcIfSDJHtfQUGJQYIJQ1+Vig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5GI0QW6TPr0mgcU0SH9TJo4Vf0lp9/XiEVQFziiFFM=;
 b=DmhQKmMl/Qa/9Fhr01C4PneatfJI4c8ZUQyaHvpPWbtfIS2bwejTumvx7VzlIgInR+riqq6/ZQWFzE3V3t4Ra2IdxRD45cRkaDBh1SvE5UhXn417MVleHM+DzpHsRTscq/y5EK3u5JdeEsARakkYCpnMuk3xI9SfC06G1N5h9Vc=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Wed, 24 Mar
 2021 04:10:21 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3955.025; Wed, 24 Mar 2021
 04:10:21 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: RE: [PATCH 0/7] PCI: layerscape: Add power management support
Thread-Topic: [PATCH 0/7] PCI: layerscape: Add power management support
Thread-Index: AQHWhNoqYY2XFhbuC0+/9+cQvqlvcaqSoe8AgAEbHAA=
Date:   Wed, 24 Mar 2021 04:10:21 +0000
Message-ID: <HE1PR0402MB3371214795F5063073B28F1484639@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20210323111524.GD29286@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210323111524.GD29286@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2b565bd-c45b-40a4-00ab-08d8ee7abe16
x-ms-traffictypediagnostic: HE1PR0402MB3371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0402MB33714D40CB43298FB4C62AA084639@HE1PR0402MB3371.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cpG76Fdwx75/1hTs4cMqUSVGk6vn/kJAxTkIQnEde0pwo2mEXodMypafoqGEjTjaLI61t4X60e33uZzd7N+DUbkA4dMzy/IxI1k9EP5PZq1AOvXhpGdhwFA5sNE5ZgQwLflRgtN3HKan0IpmnZ27oXmlgwQjPZmWRTedS8EOoyaWx5JCjvt8xORliny1BHjnK7+jbMB3c/ZmUfgUOqcuvYtsbj5NXcAKfBR9FWdG/P4MQ/YsDGm4HzthTOoC21DmYM2aJUEpQTAY/Yzq3bg23YFD9Xmv33QV9DpcHWcQsZdOh7sioo+vtJGSfdyAujasjE8Rp7TnCONMb3ZyOG1o9MVE909PJmtOWeOch3LKhmqmc/RbPlRO91mr7X4raZakbw2oEDdM1gU/AJ8wmPpySIrz/gcqY4+kCrAd27/JhwiaQtpOuLG2LSnNAU+RCt0+/QIgDGLilzoaSniCp2Pu6FAoiVwmnBIrWHfrP4yJ3lmdaIgjmgczoaZ0aIVDQtpWmyd4f98p/GhgDRiMXK0bcEtudIBoHmuLU7Pnci+Csn74zrTa2YpVExDgrN2uga6iwWiIUTYVF/9HEtftQKY6BCxIr/BuHh2KdsVjGaPnMCO2/sNHLkmHETGljetQbL3FnqTCfRbGGGSHX0ScNkF1SiyDucrMWRxe0+IofbiBBuM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(86362001)(64756008)(66446008)(8676002)(66556008)(55016002)(66946007)(2906002)(5660300002)(54906003)(316002)(76116006)(38100700001)(478600001)(9686003)(52536014)(66476007)(33656002)(26005)(6506007)(7696005)(186003)(53546011)(71200400001)(4326008)(8936002)(83380400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?L1ovdjhmOEk0czB2QncxRWpIWGwyT3NZdElhN2VrSmZUWldCTTdiRzhaUkdh?=
 =?gb2312?B?SWFGS29mOUk4eHhtVC8yd0RQMld2RTRJNmFBNUI0SVlOOXBDQUxqMHNQZGNJ?=
 =?gb2312?B?U0FMWUw0RFo3cHNEZjZhS0lYR3NhQ2JKZVFGUk9hZWNCTXFOVzJIWkROMHZY?=
 =?gb2312?B?WWxDOHpPQUJhRE9NUFlWVENicGpUK0VnQUJ5a1kwMXhkaFdDVjFLZHhITCt5?=
 =?gb2312?B?WDRRZlNHcFNkN1hYMWQvMENIMlhVNHMzRkhLSWpta0hqcWQ5MGxvaTNMcXhk?=
 =?gb2312?B?NWRVRXJ1dmhURlVHYjA0Z0R2eHJQcmN0aitSeHVpblpvTVdGNTJtcDl4czRr?=
 =?gb2312?B?OHJFUTdrRmhEYWQ3OHZkWExKa1V0VkRMU2lWVG5mTTlMTVFpYkx1cVRCTnpv?=
 =?gb2312?B?WVpMa3JtUHNJVU11RFpndzJyOVl5ZVlBdHg0ZWl4N0RjSms1RkJyUnduVTV5?=
 =?gb2312?B?KzlGQlRGdllrSDFma1hyRldsWFV1VU5qRmNTOUNaa2RBRXUzYlNlVnNOUjF4?=
 =?gb2312?B?RWdOcm42QVRPMTY1c1lBN3ZzaXUyMTZ5Wm5XMGlvejErOXBFVHNWQVAvMjdG?=
 =?gb2312?B?Vk1uZ2IvajlMSmcwTy9ZbUgwaHg5c25XRFJCTk1waWN2dVR5UmQyS2gzQnF2?=
 =?gb2312?B?ZFNzUHZIOHRycGE1bk91MkYzdVBTZW9pNU51eEt5Um1MYmpCaktuTmw4eEd1?=
 =?gb2312?B?bVNYcExNZ0pzc0pTWFkzUUtXeXRPNEZlTU03MENiSWc4WXVmcVNtN3JSWkYw?=
 =?gb2312?B?TGEwTGhybWx6RlM5WlJsTE1vSVlVRzNlaUJDRDF5bmpqU1NiYVRUU2JENUFX?=
 =?gb2312?B?OGtHYktWaWxoWEZhQXNQc3cvaDdCRmlKOXoxQWFCeEUvYms1d3VNbWozVS9q?=
 =?gb2312?B?MXBzKzh0NVBuZzVLZ2FERnF2amNmaTR2ZnFJU3dLN240d2dqR1ptR1M3NjJR?=
 =?gb2312?B?aDdmTC8zdW5GL1Z5Q01TQXg4dHZ3ZUVFM3VPNjR4b044TFFpdXZ1U1FQaUN3?=
 =?gb2312?B?RE9Ud0FQS0pIeEN5QTJZNnpyK1ZkbVpqS0VyUEsrTXY4TG9kOVZrTjNGSGla?=
 =?gb2312?B?enNYTlIySUszVDNNaUdUV2hPQy9ucW1KWTFEalFHR1cvWGNaL3ZnRkZGS1da?=
 =?gb2312?B?cU9UNzVMQ3RwUW01SmZhdzduYklCZTJrcWFxWWJ4RkJrZmpBZWsyTGp1MWpk?=
 =?gb2312?B?bzh2QUhzUlBSZlYxL3hKZnhNTTN1cWxhSkFtUTFGRk9VeEgwdkVFcmpxY09k?=
 =?gb2312?B?N3lWcU9jRkZOdm1GRktBSStpb3oyb0ZIRGtDNThvaUM2U0FKNU1QUmVvVDlr?=
 =?gb2312?B?QWRxRGlXNGFEc0t5NTZYUkpDc1FZUEdWcnZ6TjFLVFhwMk9WckcxM0JkM2F0?=
 =?gb2312?B?WVFFR3Y3VnVZNmVwcm55cmRTbjNlUW1xNUJIc1l6ekhYV25ZdW12NUd3cTZ1?=
 =?gb2312?B?NUcwRzFUTzdaZEFnRG0zdnFxWnNncER1d3dtTVFBMzkvNzhQVWNialRncDJJ?=
 =?gb2312?B?c1Nab3RocUl1RlJSUHdlL1B5Zkc1UVpOY085R3lCM0hVU0VKbUxubGxodnF1?=
 =?gb2312?B?QnpIbkpKOHRnYmNjSlJJQWdibjZuQ1JQQlViVm1yR1Y2b1NZNkNEWk5paTc4?=
 =?gb2312?B?VDR4M3dYTDVlZjFYSHE1YzBNd21iWmN5RE56ZXMzVmJyTGNVSUl0VUQvcnZH?=
 =?gb2312?B?UXFxMUtXd1phZm56dUZJeWxwdUtacC94QjNDa1NQNVQzRXhkOUdvaUpnWDZ0?=
 =?gb2312?Q?z2HI/fwXliMucYVBfNP9sUQucxyUDoMyUYdurm8?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b565bd-c45b-40a4-00ab-08d8ee7abe16
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 04:10:21.2950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eITWAzrD4q5rmahpvK9jXbe1K+WbQDp/ybeX2NX8vnkE9Y5fa6WprX68NS8zqgs5WLTzropriZPnRKVyRsekkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogMjAyMcTq
M9TCMjPI1SAxOToxNQ0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBD
YzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IHJv
YmgrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5n
LmxpQG54cC5jb20+Ow0KPiBndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbTsgTS5oLiBMaWFu
IDxtaW5naHVhbi5saWFuQG54cC5jb20+Ow0KPiBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5j
b20+OyBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAw
LzddIFBDSTogbGF5ZXJzY2FwZTogQWRkIHBvd2VyIG1hbmFnZW1lbnQgc3VwcG9ydA0KPiANCj4g
T24gTW9uLCBTZXAgMDcsIDIwMjAgYXQgMDE6Mzc6NTRQTSArMDgwMCwgWmhpcWlhbmcgSG91IHdy
b3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4N
Cj4gPiBUaGlzIHBhdGNoIHNlcmllcyBpcyB0byBhZGQgUENJZSBwb3dlciBtYW5hZ2VtZW50IHN1
cHBvcnQgZm9yIE5YUA0KPiA+IExheWVyc2NhcGUgcGxhdGZyb21zLg0KPiA+DQo+ID4gSG91IFpo
aXFpYW5nICg3KToNCj4gPiAgIFBDSTogZHdjOiBGaXggYSBidWcgb2YgdGhlIGNhc2UgZHdfcGNp
LT5vcHMgaXMgTlVMTA0KPiA+ICAgUENJOiBsYXllcnNjYXBlOiBDaGFuZ2UgdG8gdXNlIHRoZSBE
V0MgY29tbW9uIGxpbmstdXAgY2hlY2sNCj4gZnVuY3Rpb24NCj4gPiAgIGR0LWJpbmRpbmdzOiBw
Y2k6IGxheWVyc2NhcGUtcGNpOiBBZGQgYSBvcHRpb25hbCBwcm9wZXJ0eSBiaWctZW5kaWFuDQo+
ID4gICBhcm02NDogZHRzOiBsYXllcnNjYXBlOiBBZGQgYmlnLWVuZGlhbiBwcm9wZXJ0eSBmb3Ig
UENJZSBub2Rlcw0KPiA+ICAgZHQtYmluZGluZ3M6IHBjaTogbGF5ZXJzY2FwZS1wY2k6IFVwZGF0
ZSB0aGUgZGVzY3JpcHRpb24gb2YgU0NGRw0KPiA+ICAgICBwcm9wZXJ0eQ0KPiA+ICAgZHRzOiBh
cm02NDogbHMxMDQzYTogQWRkIFNDRkcgcGhhbmRsZSBmb3IgUENJZSBub2Rlcw0KPiA+ICAgUENJ
OiBsYXllcnNjYXBlOiBBZGQgcG93ZXIgbWFuYWdlbWVudCBzdXBwb3J0DQo+ID4NCj4gPiAgLi4u
L2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaS50eHQgICAgICAgICAgIHwgICA2ICstDQo+ID4g
IC4uLi9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAxMmEuZHRzaSB8ICAgMSArDQo+
ID4gIC4uLi9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0M2EuZHRzaSB8ICAgNiAr
DQo+ID4gIC4uLi9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEuZHRzaSB8ICAg
MyArDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLmMgICB8
IDQ3Mw0KPiArKysrKysrKysrKysrKy0tLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLmMgIHwgIDEyICstDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oICB8ICAgMSArDQo+ID4gIDcgZmlsZXMgY2hhbmdlZCwg
Mzg4IGluc2VydGlvbnMoKyksIDExNCBkZWxldGlvbnMoLSkNCj4gDQo+IEkgZG9uJ3Qga25vdyB3
aGljaCBwYXRjaGVzIGFyZSBzdGlsbCBhcHBsaWNhYmxlLCBJIHdpbGwgbWFyayB0aGlzIHNlcmll
cyBhcw0KPiBzdXBlcnNlZGVkIHNpbmNlIHlvdSB3aWxsIGhhdmUgdG8gcmViYXNlIGl0IGFueXdh
eSAtIHBsZWFzZSBsZXQgbWUga25vdw0KPiB3aGF0J3MgdGhlIHBsYW4uDQoNCkknbGwgcmViYXNl
IHRoaXMgc2VyaWVzIG9uIHRoZSBsYXRlc3QgYmFzZS4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg0K
PiANCj4gVGhhbmtzLA0KPiBMb3JlbnpvDQo=
