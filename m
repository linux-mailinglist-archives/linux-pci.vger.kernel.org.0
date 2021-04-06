Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CB5354F59
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 11:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbhDFJDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 05:03:48 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:42497
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240625AbhDFJDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 05:03:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzHuGOuQEO50YvDNpGVkGWGWcETHXfZ/+pdPRGxHbEEwONi8ru2iGxWTH03WXZSfQYZp7jxmf8izXjRdyCX7BjfrDaY3W9wrYUC+PNza11Mq5xbUBb/YHeK831gDEMXedwuUXOIU66C0yGipETDVfUdYwESp+1uyD4sDpBNApjQ7b0jlk4ZWkDbO4FZZk56wGTbTzNYTI0KkEnuKZXONSEIosYjpSMi5qSieHtxccS8BW0joL+E8D9f8+oL7yK9MI007u919+efyJrF5D7lD5hCqt/BgoBW2kPBPAtk7PRGoYGWFOOyFMfZ7QXRrlNopO8wqSpgCXeMppkWxvyHoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIeNaCrCJLSK4O3n28C7TfK7rJTKxWin4RW3TwQ3MdY=;
 b=CSgMJij4ZDvZSPDpnby0EVD03Gr0vLQIUxc/cCGTVcnbsEfIV1CleuRhZF6lqbR0Sg+LM9iJw3D03S3S8e3sKZwnp5Z80V2lEtMtPOqIT0arYCL0RTXuJNQgu5OoqXkwzRK2HI5U5OUguzBmWLWFtuJHf47cDEqEVZPscfAkdHGfpW+94TjS58xZI/l+poxmLDJr0jddwUrMawmbviNEUW1UGNTaK/5iM38JeEeCR5XzjaEDwgT0iEhuqD7Jj9bwve8VX5PKW09BpjQJ85YYyaKPoieysMV1uWsvwrIwnZ26FxnQ0444gkJi6ail8fXNoKR8UNV6uk3TwoBbyAHI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIeNaCrCJLSK4O3n28C7TfK7rJTKxWin4RW3TwQ3MdY=;
 b=SU6Rwz+lqnBa3GL55jvOv3PURupQbPm0+QYFq2dBsEAneMiDpw6kkBghUlDEbmPZIG8/Bglzd2Lh5AqhoBU6a6bPnFfe+AtzPvaDQirvhpdca08leQAlJ7xU+PhTl8KE0Y1lN8BdNnY/72NFHhpvr6Iy5v9G2devxhLy9UYRm94=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2297.eurprd04.prod.outlook.com (2603:10a6:3:23::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 09:03:38 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 09:03:38 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>
Subject: RE: [PATCH 0/4] PCI: dwc: Refine the EP code no functionality change
Thread-Topic: [PATCH 0/4] PCI: dwc: Refine the EP code no functionality change
Thread-Index: AQHW5NPYJJ38TJTBX0qf9zYY4LThKaqnvNNw
Date:   Tue, 6 Apr 2021 09:03:38 +0000
Message-ID: <HE1PR0402MB33717865894604AE704CD38E84769@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20210107091123.8616-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20210107091123.8616-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04fb337e-fe1c-48f8-1d69-08d8f8daddec
x-ms-traffictypediagnostic: HE1PR0401MB2297:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0401MB2297092748A8C3EF7DEB049084769@HE1PR0401MB2297.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C5FIhShR5OZTF+LAY3elDZaOCyQFaL558bphdMMT2rtr3AypALz38j+oVrqSTF3b/AjBxzLV2b41wZJ9eiseS55UDA0+m+c5eYeevtIBvkQR6A1b7AYqElHWoo+DzCdGyLj+UpXNrho364awFkZZXpbGm0L2VwFYbhqHyy5PLHv3q9nvgh+VuuK6AA30s0qG962dU0UJ8NXzduy0z/1160PzTRMwYOEFXuUDyUJfkxrHgikmDWLtESrwFfRB5KoolQrANXBY+qaR/xysmtRvbrLLIJyJvpfKrMXEoZIgnlwjE5ybQUpVcjwW+ptnE6e2XNK6DJFSguUoffeU+cUE+vA9d1QbsPpiu4I6tlYMjSTzSuNHF6Zm3V6PPdWKCfcR7oANjfXq+AU7WEgymHXI80eE0hirgd7qcH0shrJSq4qYDjzD5Dx/8yLNTFAZ+LMZ0dGT/N/5xiTZugljpFWcsyiUK+1NVmY6qGRSpDWWAjPjUuV0gobhXMLTL7m/JFX/Zk71xbJ4PXhuwL7l5H2eiM2h7oQ9u9Y1AdL4+bUx2pQ8QnVcR4itS10dgRoNuTOUkw6YZzs28VLwWR0g/0fKM+QZO9We6yd+Krd0NBiBHGlt9EG0vpc/pj/drbaP503OqbWgDj5R4V6oy57cu3lXjGGVydrKO+XkortrxXILMsY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(7416002)(5660300002)(64756008)(66446008)(66556008)(66476007)(83380400001)(76116006)(86362001)(71200400001)(33656002)(26005)(66946007)(8676002)(52536014)(38100700001)(186003)(2906002)(55016002)(8936002)(7696005)(110136005)(54906003)(9686003)(6506007)(478600001)(53546011)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?ODdWUDVjQ281U1l6NU45SHhNMEM0Nk9uZm12U0hwQmlRWTVpS2M0QVRTZC9Q?=
 =?gb2312?B?ck0wUGFmSXdTWUQ3bWhyUWo2ZEs2YjFSNm4zaTZJQzFmYzVvRmpxOHpBaWJi?=
 =?gb2312?B?SzlRWUhJYlpLcitXZHIyMVQ1NlQwcWxHTm9paE1WUHhSdFhvR2VuUjN0WjVR?=
 =?gb2312?B?V0VMSkV5VjBHRTNUQXpPS0FvSk9ERzY0b0JPdTY4UStZYWZvYzdSM2dqK2ZO?=
 =?gb2312?B?cDB4U3pJSnFWc2EyMUJiWXN3VzZKRmg4Rnlzc1BzZC9nOFBVUWdTSDVXK25o?=
 =?gb2312?B?U2Qzek8rcGF0NGtFb3VZUlh5d241SnJMcjFjRTBaSGRGcTB4M0ZNTVgwMmpZ?=
 =?gb2312?B?L3cvejcyZWtqcHV1dDZSVWVGTGFUdDNTdU01K2xKZE1weWZ6bzBIMkQvaXBz?=
 =?gb2312?B?TUtLWXpLeWZUcm5xRTd2b3RnbmtRTHp6UzVpd1hkMWhkY056RmtBTWMya1hO?=
 =?gb2312?B?YkpnQzErTFFCNmg5OS9WTmxONFZZTjdxbG5OY1ZSZ2dQWjRlMUdpYUZOTTJt?=
 =?gb2312?B?TTNYMWFKaEJNVU1JbzdCak91WUo3ME1FcEI1M2ZMb3dpdjVVWlJ3R0FpTjBE?=
 =?gb2312?B?U0VIaklFMDQ2ZUNiZXpoU0gvR2RCbExWM0huRkFWZ3RLaVpqV2JmdExqMnZ6?=
 =?gb2312?B?UUNjUTVmdmxVMmJVYkh4K0hZOUJ0Qk9XWnRzeklmeCtiVGFGNytMcU1GcUxi?=
 =?gb2312?B?a0U3d1pCL01BbXpoK3U3QlVsZENaUmtVRWRPaGViWkFpUTh0YkJGVnVjQytt?=
 =?gb2312?B?L3gxVWhoWkZnNkUxZW9yZ3hGc2l3RkZoQW5wQjVqTkJwcy9XTjBLTmpJWExT?=
 =?gb2312?B?Ujd1WG5mOWhHMmhFd0dBV0I3MkkyM3RVM2ZmRENEa05vWXB6YU9RcGFxSHd2?=
 =?gb2312?B?VCtmMFZSN2JiSmxHNWhtcURSV0pLRnd3OFdIM3NJd2JhOU1hVktoc2d2T3hi?=
 =?gb2312?B?bGxrTDloUDFVak9mbFIrZ2RPTmFJZjdDQ0xIQ2R3M2ZtRGdVTWRVQlhaRnBj?=
 =?gb2312?B?dFA4ekNLaDFtK0IrVFpqdzhjSzRjZGJrZlRzQ0hNbGdRcndQeFN4WUQ0Nkk0?=
 =?gb2312?B?OTl5T0ZxY2x1TnB0SlIvM2ErR0ZnaEdDQ1liT1o4Q3dmR3gxaCtZcnRiMXZC?=
 =?gb2312?B?L2pCZDJYSjM1K3A2YzREa2hvanJ4TVg4MjlTbEtSdjhMTXZpYjR2QjBORlAy?=
 =?gb2312?B?ZERTNGNPRnk3SjNPaTZFRlovWXBNbHhBVkNzUGk3bC9tY0dNRDdGSUU5cnFy?=
 =?gb2312?B?anBXUHFNSkd2bW5qVmJZYTducFBLbGVNeStkK2ErclNDZUhiMmxZenJLOU5P?=
 =?gb2312?B?UVR6L2FGVEZ6MmR0bTBocThYcTcvaVpVd0duUjhSSzhranJBNTA1V2RsWUVT?=
 =?gb2312?B?N3g2NXhhcUdUMkRQTlJBV0NwR1hadWR4Q2VUenQwRlplMFA5Nm5lVEZiSlA4?=
 =?gb2312?B?Qy9CaDVJelQzZXRWQ0RUdlc4UjZXUlB5ZE1MUGpHcWhQY0pnQUJjOUhpdVVS?=
 =?gb2312?B?K09sQ3ZvY3R6a0ZEUWZQZGdRSUhMbVBaTzUxT1VrMEo2cExZZGh2VHR2akxB?=
 =?gb2312?B?QVZGUWI1ajBrN01MMU9mRVB4YXVWem9oYVMwZG1VRjJxdUFYTVdUVVcrc21X?=
 =?gb2312?B?UXFtS1gzN2dUTWZNN1ZVZGhvMlRsV2xoWXU1eTcwREFGRFJEMzFKbisxK0dp?=
 =?gb2312?B?ekZTT29TQnVnaG1wSGJla01HZWRma0wvMzdaeWYzOExubmx0VWdUdlBSOWph?=
 =?gb2312?Q?Z6QCL4Fc2Jy9qtHA83q1SEWDGQCHwwxUtK4CPe9?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fb337e-fe1c-48f8-1d69-08d8f8daddec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 09:03:38.0594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXhipXzO0byS9TyNzs4unNTh9EoGix3AN1wRya/Sy7xJB28/BxfaqOFZyQ+E4Gs9F06QwEiuu5w3qu1RUyVUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2297
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywgUm9iIGFuZCBCam9ybiwNCg0KQW55IGNvbW1lbnRzIG9uIHRoaXMgc2VyaWVz
Pw0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gU2VudDogMjAyMcTqMdTC
N8jVIDE3OjExDQo+IFRvOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGF4aXMuY29t
OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyByb2JoQGtlcm5lbC5vcmc7DQo+IGJoZWxnYWFz
QGdvb2dsZS5jb20NCj4gQ2M6IGtpc2hvbkB0aS5jb207IE0uaC4gTGlhbiA8bWluZ2h1YW4ubGlh
bkBueHAuY29tPjsNCj4gamVzcGVyLm5pbHNzb25AYXhpcy5jb207IGppbmdvb2hhbjFAZ21haWwu
Y29tOw0KPiBndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbTsgaGF5YXNoaS5rdW5paGlrb0Bz
b2Npb25leHQuY29tOyBaLnEuDQo+IEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCAwLzRdIFBDSTogZHdjOiBSZWZpbmUgdGhlIEVQIGNvZGUgbm8gZnVuY3Rpb25h
bGl0eSBjaGFuZ2UNCj4gDQo+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5j
b20+DQo+IA0KPiBUdW5lIHRoZSBFUCBtb2RlIGNvZGUgc2xpZ2h0bHkgdG8gbWFrZSBpdCBtb3Jl
IHJlYWRhYmxlLg0KPiANCj4gSG91IFpoaXFpYW5nICg0KToNCj4gICBQQ0k6IGR3YzogQ2hhbmdl
IHRvIHVzZSBhbiBhcnJheSB0byBzdG9yZSB0aGUgc3RydWN0dXJlIG9mIGZ1bmN0aW9ucw0KPiAg
IFBDSTogZHdjOiBBZGQgQ0ZHIG9mZnNldCBpbmZvIGludG8gZnVuY3Rpb24ncyByZXByZXNlbnRl
ZCBzdHJ1Y3R1cmUNCj4gICBQQ0k6IGR3YzogUmVuYW1lIGNhbGxiYWNrIGZ1bmN0aW9uIGZ1bmNf
Y29uZl9zZWxlY3QgYW5kIGl0cyBpbnN0YW5jZQ0KPiAgIFBDSTogZHdjOiBDaGFuZ2UgdGhlIHBh
cmFtZXRlciBvZiBmdW5jdGlvbiBkd19wY2llX2VwX3Jlc2V0X2JhcigpDQo+IA0KPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWRyYTd4eC5jICAgICAgIHwgICAyICstDQo+ICAuLi4v
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMgICAgfCAgIDggKy0NCj4gIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYXJ0cGVjNi5jICAgICB8ICAgMiArLQ0KPiAg
Li4uL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyAgIHwgMTkyICsrKysr
KysrLS0tLS0tLS0tLQ0KPiAgLi4uL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUt
cGxhdC5jIHwgICAzICstDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuaCAgfCAgMTEgKy0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdW5p
cGhpZXItZXAuYyB8ICAgMyArLQ0KPiAgNyBmaWxlcyBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCsp
LCAxMjUgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjE3LjENCg0K
