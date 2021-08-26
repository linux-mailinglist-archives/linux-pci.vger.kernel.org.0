Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF33F81BC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 06:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbhHZE0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 00:26:47 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:47758 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhHZE0q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 00:26:46 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 17Q4PXFC005433; Thu, 26 Aug 2021 13:25:33 +0900
X-Iguazu-Qid: 34tr8rsmqMCiV5546q
X-Iguazu-QSIG: v=2; s=0; t=1629951933; q=34tr8rsmqMCiV5546q; m=mOkDOz64ub+YwAVwOaqjIo35m9Y4e+2ySMhFiUDgVog=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1511) id 17Q4PVgF012923
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Aug 2021 13:25:32 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id ADC9910014F;
        Thu, 26 Aug 2021 13:25:31 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 17Q4PVV0024181;
        Thu, 26 Aug 2021 13:25:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHdwPSIVnpgBV+ErJ45mLWeA6WifwrfKLxRC9efe4/XLJOYN7lvOoL025X3VqBkRk6m9d0Q902gKviXvqb/Wn8UsR7T5HwXk1eJN53zmRla5Y+kArQkY6nUEaGo/emF3X+tFzQwRFKGHjWuBsn+TLR0tbI4C9ZpR87om/eLiL3Qm4ygKWvfztEISK6CxCq65uO4GE5rmWZeSboIk/xNAEgBqgBQZ7VGjk8j7Hxm56pIJiCUPCB4K5yNQ9XEl//NA5AN3vt4w85w9KVgfVeaMDHZ94J1H2zBbbzuz5HxdQsKJ3FjOmEK/o98LN5VPirG6/HVz1hIyOlUJCJ69sDaJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65Aq7oc5xYjPlGh41TwXlwJC0CGayKAsgeya2+So/Yc=;
 b=T0gXwolV3SbpBOy7a36rkOAsVyTnFlfdrUI1T3U91EMP31skbAlHIIHbXQlMD6iqeCEZtWm0ulWkdIef6KORhCiyiQhOZroln+vJR71p/sfD4aqzW7daSwsooZ+nPWsctOv/7Lsg2FzN9PSJlo2jNylZoYjGVfy5OAwc+ebw/TqxKR+D/NbopsdXKQPAg09dq7c6ly46chddl8JewZ+t+CXNw4f7GbFWpGfTxxVZhHFN4qajn5FM8unRPPRg0f0vh6a6sOEyhhiDdJpcJz3KoUfoU1rjqmRFJnOxlxJL7ROhWBEDm/70PdZEAgsnnlH9zoIbaV5nQ39461UhlmqJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <nobuhiro1.iwamatsu@toshiba.co.jp>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <kw@linux.com>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <punit1.agrawal@toshiba.co.jp>,
        <yuji2.ishikawa@toshiba.co.jp>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host
 controller driver
Thread-Topic: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host
 controller driver
Thread-Index: AQHXjoxPS94cnMPoeEOD7WgANI6+jauFR0fw
Date:   Thu, 26 Aug 2021 04:25:28 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB625257B58932922E355C988292C79@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: toshiba.co.jp; dkim=none (message not signed)
 header.d=none;toshiba.co.jp; dmarc=none action=none
 header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1552c9d-27f4-4286-31a1-08d9684988ab
x-ms-traffictypediagnostic: TY2PR01MB3961:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3961868FD665F7DFECA74BE892C79@TY2PR01MB3961.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W5r9XM02Iio6M0+hGtsnoL+qFJQhnB9asCcGHWadpm+IaY/w/r4o1Zvh5O8eE7TN34pt88Ge/yrMEktcHIMmXfoJD4ewdU2HN3XBdN9wJJkLCnjZXvEV35ohFwLtwET/cOxXh1odMKvVjUQAAJppHZ6YMItVaIoYv5/pQqhKvUy55RLZ5C2SN5Lp9CIa5iHoZ6yWxaoObhjFleL6ee2UF27P0xpzcgMog448B508rpeb5m7LZ7xfNc6wbSI6TZfAWpu+pZkG7ll/EiOhrXkSxVHXQSmC6jPy+552ZSZqF/nTmFds7753wVP6RyeWr0FRa2b6OwaQ+y5ByLpPVmd3D+RGdRjwsLlVJ6Y8iOQDzL9j7i7zwNnZRoZuATIwj69yj6BxwU5aKfHoUkWkVy9bWgFeLu5KltW7o2Vwy4mTiStKzQEr8ZO7vZzcOS03NJaNySNW+OfYdEdzrHDyK+utXKR53wTa/WBgxVFslf4+nslbGp79LE34qIlufjQsCQYjYJtS76pKsAaYW0+ghOnNoxiD81Vs8Gqv9iq/T2VU9nHPwILD5X8jqvpPGzyYnYRP4LQMNYTLvtyCIig00f4We0ZJq5co4ndIMNlU+9sJzi/Vz0XSBdPsGUQ7+IyPffv6BshWaMYJiO+kjpIzjBhQEfvACEGIOLTYQ9NDY38OVZPTsjEUm2asNCnPYYINYZHevCrRYfiOy7X4rT9vh/wdClZYRiiQ8+F3fkHhFer2Fb9AYQY9RNkgs6X2YCdef0VVQiOGDn1IXOLaiGt17lpyDNS0R9mhaIjlhwXw4qI4OCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(66946007)(33656002)(71200400001)(8936002)(76116006)(8676002)(66446008)(9686003)(55016002)(4326008)(86362001)(52536014)(5660300002)(38070700005)(38100700002)(122000001)(966005)(64756008)(66556008)(478600001)(66476007)(83380400001)(66574015)(186003)(26005)(7416002)(2906002)(7696005)(54906003)(110136005)(53546011)(6506007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGpHSVJKOUhZOFIwZWltUVdxcW12eDlrelRjVTVCRWs4RkFWR0N5Vmg4dmhC?=
 =?utf-8?B?MFlFNjhLeC9PRy9Ka1VNSmw2R3YzYjQ5MXpwY2VHRlVIYmZmRnFCOUtSc3dB?=
 =?utf-8?B?dEZ2bHZiVi9HMHV5VmJsVEhTNU1PdkJVNGJxdGN4cEQyUkRWZEl4MmJNeDB4?=
 =?utf-8?B?anptSDF1dlFXZmR2VFR0YjVHb0syMzE2TzJuQkErbUdRdWFnWC9MVDZvb1Zq?=
 =?utf-8?B?MG9uNWlDOWNXYXJ0azJ5dm1nSTU3MWw0UkRTS0xzdjNObFJDb0liUUI4ei9Y?=
 =?utf-8?B?VXVQUVd0Yzd1SW51RDZPTUpTZ2k4RmdhNjFYWEdPbW10SjJYUGNYQkVGWU5h?=
 =?utf-8?B?U00rYTdLaW0ybURSL043KzB1UzYwWHBlK0tZM2FnVnE3R3JFdFFnVnpKY1c3?=
 =?utf-8?B?eEs5emRSMnQ4RVJjQUIrdytGQ1QrTk9Wdk0xdjZmWGp1R2poRkRMaE5BdVBj?=
 =?utf-8?B?MUV1aHh6ZndvS2lDNDlPM2NQSGFFTkpleTBuTUNyQWtBTHNoTXk0R2FNeVUr?=
 =?utf-8?B?Y0hkYTBMcFhYSjBnbksyYnFGSnFHZWxXcThOVnZPdzUzR2s1dmorRzZ5cDZM?=
 =?utf-8?B?QmhXM2R2MW9INnJYQ0UxclFQQy9pdDRnRFRTNWt2VndvTWtEL3BlQnFYZExG?=
 =?utf-8?B?cmlDOStzaTg4bXBnTCt0dHFMWk1wQytpTzhTaXBqUFIwYmU4Y3h6eEw2M3Bp?=
 =?utf-8?B?bCtJdjN0QVA1ZWRoSDdYUFcxalV6WnphMTJFTnFGR2NkVlR5L2FMQXlXMDRo?=
 =?utf-8?B?UWNVams2bFhvS3U4T0RsdExtKzJ1cDhvcTFRTllpNmE0UGhNSkVhN0hQTHp2?=
 =?utf-8?B?bWFMNWVvRUFnc3lpVzE4TGh0WnhGWEhXUWZnTjM5UXlxbk4wcFNyazRqbUNU?=
 =?utf-8?B?a25Cdk5Vcmw1R0RnQmkzWEljYmVrV2d2NkZZQTBYUHNNWnFyN3YweWRsaG15?=
 =?utf-8?B?VTV5Nm5lc2daaFVZUmRGN1I5amp0RnhpdDFjYXpTdTBTVDgzaWlVWkEwUG45?=
 =?utf-8?B?NmZVZDRUNHAxbnhHdXBUaWVwdUo3d1JTSHpnUUFGNzJaaTAxa0xBVGM0NkUw?=
 =?utf-8?B?OG9obmxsM1E4ZVJqSWVFYXFobXdJNzVoWVJ2MHJJR052UjgrKzViWjRBUFlq?=
 =?utf-8?B?ckJVNjYvWnhWdFJ5MHZIVkdvNTR0SlFnUzF2d0xVNFgzdTFrdWVpSDIwQjN1?=
 =?utf-8?B?OStyVHZ1bXZlZ0ZVaXg4RzZOQ01iMGVHOFIzRkkzL3ZTVStEem1YZzZ4R2lm?=
 =?utf-8?B?S3UyUDAxL1YzWU5mZktIdE8rMTVIK2lOVEo0N1BocXZiK1U0cU1wSW14c1Q4?=
 =?utf-8?B?K0o2TXYrdmtSOERqVHdEcXRnZTA1bHJzRW1MRVVMM2hXSXlOMGJXWmxnNzUx?=
 =?utf-8?B?VkVITXY1OURvUWc3UWNWT1JPb1V3dm14aGxpWFh0d0JIcE1BdzYveFIveGNi?=
 =?utf-8?B?RXk2VUNoclZ4V1lNbzU4Y0RxcmlkWmdReHRqejhacjdLak5hWXM2TlVPRHJK?=
 =?utf-8?B?WURpQ3czMUk5eGlrWm93NTBKcHRhNEFOTGEwU2NJdWU4Sko3TkdBWEM5ZzM1?=
 =?utf-8?B?bGtyMlFzWGgzcHZibEMxVlFJMHpScDk1R0YvNm8ybFRVQVVBeUlZWlhJTk5Q?=
 =?utf-8?B?TnF5YkFuL0RobkM3YmdPeGhCZkVTNmNSYWcwcDVhSHpRQWtoUDlLTkVOQjNx?=
 =?utf-8?B?clVUWkg1Qkc2c3R2cnhnVCtZN1luRlAxd1Q1d00ySWR0akc2cjd3bkhYaTBi?=
 =?utf-8?Q?1uJ+TBCPXJBdw1eMzdU2wmdZfLppM7Kko32jspn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1552c9d-27f4-4286-31a1-08d9684988ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 04:25:28.3731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjspy1ivUqvScBah2yL5EEtBzmh5S5L+DrtDfo2BcRXIRnF+8c3Cj5uzrIA+XBA5rR82Vjh8fkPiVvlKzrhjrb4BkpLoyIWQ/7GSEK3N6NbQroSHYwCtCS0CsNyoK8mB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3961
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCkRvIHlvdSBoYXZlIGFueSBjb21tZW50cyBvbiB0aGlzIHBhdGNoIHNlcmllcz8NCklm
IHRoZXJlIGlzIG5vIHByb2JsZW0sIHBsZWFzZSBhcHBseSBpdCBpbnRvIHRoZSBwY2kgdHJlZS4N
Cg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IE5vYnVoaXJvIEl3YW1hdHN1IFttYWlsdG86bm9idWhpcm8xLml3YW1hdHN1
QHRvc2hpYmEuY28uanBdDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDExLCAyMDIxIDU6Mzgg
UE0NCj4gVG86IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBSb2IgSGVycmlu
ZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTG9yZW56byBQaWVyYWxpc2kNCj4gPGxvcmVuem8ucGll
cmFsaXNpQGFybS5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBLcnp5c3p0
b2YgV2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT47IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtp
c2hvbkB0aS5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgYWdyYXdhbCBwdW5p
dCjjgqLjgrDjg6njg6/jg6sg44OX44OL44OIIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkgPHB1
bml0MS5hZ3Jhd2FsQHRvc2hpYmEuY28uanA+Ow0KPiBpc2hpa2F3YSB5dWppKOefs+W3nSDmgqDl
j7gg4peL77yy77yk77yj4pah77yh77yp77y077yj4peL77yl77yh6ZaLKSA8eXVqaTIuaXNoaWth
d2FAdG9zaGliYS5jby5qcD47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+
IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD4NCj4gU3ViamVjdDogW1BBVENIIHY2IDAvM10gVmlzY29udGk6IEFkZCBU
b3NoaWJhIFZpc2NvbnRpIFBDSWUgaG9zdCBjb250cm9sbGVyIGRyaXZlcg0KPiANCj4gSGksDQo+
IA0KPiBUaGlzIHNlcmllcyBpcyB0aGUgUENJZSBkcml2ZXIgZm9yIFRvc2hpYmEncyBBUk0gU29D
LCBWaXNjb250aVswXS4NCj4gVGhpcyBwcm92aWRlcyBEVCBiaW5kaW5nIGRvY3VtZW50YXRpb24s
IGRldmljZSBkcml2ZXIsIE1BSU5UQUlORVIgZmlsZXMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
ICAgTm9idWhpcm8NCj4gDQo+IFswXTogaHR0cHM6Ly90b3NoaWJhLnNlbWljb24tc3RvcmFnZS5j
b20vYXAtZW4vc2VtaWNvbmR1Y3Rvci9wcm9kdWN0L2ltYWdlLXJlY29nbml0aW9uLXByb2Nlc3Nv
cnMtdmlzY29udGkuaHRtbA0KPiANCj4gICBkdC1iaW5kaW5nczogcGNpOiBBZGQgRFQgYmluZGlu
ZyBmb3IgVG9zaGliYSBWaXNjb250aSBQQ0llIGNvbnRyb2xsZXINCj4gICAgIHY1IC0+IHY2Og0K
PiAgICAgICAtIE5vIHVwZGF0ZS4NCj4gICAgIHY0IC0+IHY1Og0KPiAgICAgICAtIE5vIHVwZGF0
ZS4NCj4gICAgIHYzIC0+IHY0Og0KPiAgICAgIC0gQ2hhbmdlZCB0aGUgcmVkdW5kYW50IGNsb2Nr
IG5hbWUuDQo+ICAgICB2MiAtPiB2MzoNCj4gICAgICAgLSBObyB1cGRhdGUuDQo+ICAgICB2MSAt
PiB2MjoNCj4gICAgICAgLSBSZW1vdmUgd2hpdGUgc3BhY2UuDQo+ICAgICAgIC0gRHJvcCBudW0t
dmlld3BvcnQgYW5kIGJ1cy1yYW5nZSBmcm9tIHJlcXVpcmVkLg0KPiAgICAgICAtIERyb3Agc3Rh
dHVzIGxpbmUgZnJvbSBleGFtcGxlLg0KPiAgICAgICAtIERyb3AgYnVzLXJhbmdlIGZyb20gcmVx
dWlyZWQuDQo+ICAgICAgIC0gUmVtb3ZlZCBsaW5lcyBkZWZpbmVkIGluIHBjaS1idXMueWFtbCBm
cm9tIHJlcXVpcmVkLg0KPiANCj4gICBQQ0k6IHZpc2NvbnRpOiBBZGQgVG9zaGliYSBWaXNjb250
aSBQQ0llIGhvc3QgY29udHJvbGxlciBkcml2ZXINCj4gICAgIHY1IC0+IHY2Og0KPiAtIFJlbW92
ZSB1bm5lY2Vzc2FyeSBjb21taXQgbG9nLg0KPiAtIEZpeCBzcGxpdCBsaW5lIG9mIHZpc2NvbnRp
X2FkZF9wY2llX3BvcnQoKQ0KPiAgICAgdjQgLT4gdjU6DQo+ICAgICAgIC0gUmVtb3ZlIFBDSUVf
QlVTX09GRlNFVA0KPiAgICAgICAtIENoYW5nZSBsaW5rX3VwIGNvbmZpcm1hdGlvbiBmdW5jdGlv
biBvZiB2aXNjb250aV9wY2llX2xpbmtfdXAoKS4NCj4gICAgICAgLSBNb3ZlIHNldHRpbmcgZXZl
bnQgbWFzayBiZWZvcmUgZHdfcGNpZV9saW5rX3VwKCkuDQo+ICAgICAgIC0gTW92ZSB0aGUgY29u
dGVudHMgb2YgdmlzY29udGlfcGNpZV9wb3dlcl9vbigpIHRvIHZpc2NvbnRpX3BjaWVfaG9zdF9p
bml0KCkuDQo+ICAgICAgIC0gUmVtb3ZlIGNvZGUgZm9yIGxpbmtfZ2VuLg0KPiAgICAgdjMgLT4g
djQ6DQo+ICAgICAgIC0gQ2hhbmdlIHZhcmlhYmxlIGZyb20gcGNpX2FkZHIgdG8gY3B1X2FkZHIg
aW4gdmlzY29udGlfcGNpZV9jcHVfYWRkcl9maXh1cCgpLg0KPiAgICAgICAtIENoYW5nZSB0aGUg
Y2FsY3VsYXRpb24gbWV0aG9kIG9mIENQVSBhZGRyZXMgZnJvbSBzdWJ0cmFjdGlvbiB0byBtYXNr
LCBhbmQNCj4gICAgICAgICBhZGQgY29tbWVudC4NCj4gICAgICAgLSBEcm9wIGRtYV9zZXRfbWFz
a19hbmRfY29oZXJlbnQoKS4NCj4gICAgICAgLSBEcm9wIHNldCBNQVhfTVNJX0lSUVMuDQo+ICAg
ICAgIC0gRHJvcCBkZXZfZGJnIGZvciBMaW5rIHNwZWVkLg0KPiAgICAgICAtIFVzZSB1c2UgdGhl
IGRldl9lcnJfcHJvYmUoKSB0byBoYW5kbGUgdGhlIGRldm1fY2xrX2dldCgpIGZhaWxlZC4NCj4g
ICAgICAgLSBDaGFuZ2VkIHRoZSByZWR1bmRhbnQgY2xvY2sgbmFtZS4NCj4gICAgIHYyIC0+IHYz
Og0KPiAgICAgICAtIFVwZGF0ZSBzdWJqZWN0Lg0KPiAgICAgICAtIFdyYXAgZGVzY3JpcHRpb24g
aW4gNzUgY29sdW1ucy4NCj4gICAgICAgLSBDaGFuZ2UgY29uZmlnIG5hbWUgdG8gUENJRV9WSVND
T05USV9IT1NULg0KPiAgICAgICAtIFVwZGF0ZSBLY29uZmlnIHRleHQuDQo+ICAgICAgIC0gRHJv
cCBlbXB0eSBsaW5lcy4NCj4gICAgICAgLSBBZGp1c3RlZCB0byA4MCBjb2x1bW5zLg0KPiAgICAg
ICAtIERyb3AgaW5saW5lIGZyb20gZnVuY3Rpb25zIGZvciByZWdpc3RlciBhY2Nlc3MuDQo+ICAg
ICAgIC0gQ2hhbmdlZCBmdW5jdGlvbiBuYW1lIGZyb20gdmlzY29udGlfcGNpZV9jaGVja19saW5r
X3N0YXR1cyB0bw0KPiAgICAgICAgIHZpc2NvbnRpX3BjaWVfbGlua191cC4NCj4gICAgICAgLSBV
cGRhdGUgdG8gdXNpbmcgZHdfcGNpZV9ob3N0X2luaXQoKS4NCj4gICAgICAgLSBSZW9yZGVyIHRo
ZXNlIGluIHRoZSBvcmRlciBvZiB1c2UgaW4gdmlzY29udGlfcGNpZV9lc3RhYmxpc2hfbGluaygp
Lg0KPiAgICAgICAtIFJld3JpdGUgdmlzY29udGlfcGNpZV9ob3N0X2luaXQoKSB3aXRob3V0IGR3
X3BjaWVfc2V0dXBfcmMoKS4NCj4gICAgICAgLSBDaGFuZ2UgZnVuY3Rpb24gbmFtZSBmcm9tICB2
aXNjb250aV9kZXZpY2VfdHVybm9uKCkgdG8NCj4gICAgICAgICB2aXNjb250aV9wY2llX3Bvd2Vy
X29uKCkuDQo+ICAgICAgIC0gVW5pZnkgZm9ybWF0cyBzdWNoIGFzIGRldl9lcnIoKS4NCj4gICAg
ICAgLSBEcm9wIGVycm9yIGxhYmVsIGluIHZpc2NvbnRpX2FkZF9wY2llX3BvcnQoKS4NCj4gICAg
IHYxIC0+IHYyOg0KPiAgICAgICAtIEZpeCB0eXBvIGluIGNvbW1pdCBtZXNzYWdlLg0KPiAgICAg
ICAtIERyb3AgImRlcGVuZHMgb24gT0YgJiYgSEFTX0lPTUVNIiBmcm9tIEtjb25maWcuDQo+ICAg
ICAgIC0gU3RvcCB1c2luZyB0aGUgcG9pbnRlciBvZiBzdHJ1Y3QgZHdfcGNpZS4NCj4gICAgICAg
LSBVc2UgX3JlbGF4ZWQgdmFyaWFudC4NCj4gICAgICAgLSBEcm9wIGR3X3BjaWVfd2FpdF9mb3Jf
bGluay4NCj4gICAgICAgLSBEcm9wIGRiaSByZXNvdXJjZSBwcm9jZXNzaW5nLg0KPiAgICAgICAt
IERyb3AgTVNJIElSUSBpbml0aWFsaXphdGlvbiBwcm9jZXNzaW5nLg0KPiANCj4gICBNQUlOVEFJ
TkVSUzogQWRkIGVudHJpZXMgZm9yIFRvc2hpYmEgVmlzY29udGkgUENJZSBjb250cm9sbGVyDQo+
ICAgICB2NSAtPiB2NjoNCj4gICAgICAgLSBObyB1cGRhdGUuDQo+ICAgICB2NCAtPiB2NToNCj4g
ICAgICAgLSBObyB1cGRhdGUuDQo+ICAgICB2MyAtPiB2NDoNCj4gICAgICAgLSBObyB1cGRhdGUu
DQo+ICAgICB2MiAtPiB2MzoNCj4gICAgICAgLSBObyB1cGRhdGUuDQo+ICAgICB2MSAtPiB2MjoN
Cj4gICAgICAgLSBObyB1cGRhdGUuDQo+IA0KPiBOb2J1aGlybyBJd2FtYXRzdSAoMyk6DQo+ICAg
ZHQtYmluZGluZ3M6IHBjaTogQWRkIERUIGJpbmRpbmcgZm9yIFRvc2hpYmEgVmlzY29udGkgUENJ
ZSBjb250cm9sbGVyDQo+ICAgUENJOiB2aXNjb250aTogQWRkIFRvc2hpYmEgVmlzY29udGkgUENJ
ZSBob3N0IGNvbnRyb2xsZXIgZHJpdmVyDQo+ICAgTUFJTlRBSU5FUlM6IEFkZCBlbnRyaWVzIGZv
ciBUb3NoaWJhIFZpc2NvbnRpIFBDSWUgY29udHJvbGxlcg0KPiANCj4gIC4uLi9iaW5kaW5ncy9w
Y2kvdG9zaGliYSx2aXNjb250aS1wY2llLnlhbWwgICB8IDExMCArKysrKysNCj4gIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnICAgICAgICAgICAgfCAgIDkgKw0KPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUgICAgICAgICAgIHwgICAxICsNCj4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdmlzY29udGkuYyAgICB8IDMzMyArKysrKysrKysr
KysrKysrKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgNDU1IGluc2VydGlvbnMoKykNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3Rvc2hp
YmEsdmlzY29udGktcGNpZS55YW1sDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS12aXNjb250aS5jDQo+IA0KPiAtLQ0KPiAyLjMyLjANCg==

