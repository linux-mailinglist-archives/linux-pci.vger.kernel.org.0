Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDFF59F609
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 11:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiHXJPT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiHXJPS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 05:15:18 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140055.outbound.protection.outlook.com [40.107.14.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27A472B4B;
        Wed, 24 Aug 2022 02:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8f32umoNJU6Fvv4V6inLBgDWIpNXKBH/FvlGnXnQm9oyO3EYYosrWxeubQrDwDsp4xyHiB+O2GuVZ4E5pyi/wC6kmf6Bjja1Z5DsS3V58TLvOiyaBYCvdCPZcDNajdZWdVlu15ru85QmLcBnzb2mGcL8nNhPfG7d/iHxdTwpbp810p7wBqdrtkrRfE18Lq9xhsfmZBRF9xZddnhLoWxtnWSvzX5ldWxdl2SDD5eEI/Gw8+0oziC3/V0RrgJzv8ZDdRekBXgDbTiHl4oLjel1Jb0RSpJ+PEL9UHpIDOYbY1gD/3x8ooU9GdlvhmLmYhOAvJXd1bRj94QXdRD/OjSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk+ffMAXegPv7fPrx+TdjCDTLhL4bTfSr89Z0YJ5iNI=;
 b=QN8sPQ0xa+sUQHHzN6VNnSad1w4WWkEAyp8/nlv551W/frDEKNd1XE6oqMaBjKJbJ9nujg4cOKQbCZQRV9bDoyTzEg/PoEV5OB0oMuBtU6v7GTmNwPX3IXMH0dQKgJFfxBDX0V74S3fDdVWXnGbk2u9ExxUihkWPYda8+p9iMpMNvI6qHL08EgVvGg3D2/tXzs580vAv74mgoTyt6Zw4IMN/OJxEYhSzS2EQXhC9UKP7LmIYbN8e6cx54AEsIsuWVv/k+peov1nj9bM8S1Qez4NtiJU7jeUxk3XNnf7eRTg/ZkqiNUbdXW+BtGrXOcb5rEc0FWrsLlQwvPf+SvZUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk+ffMAXegPv7fPrx+TdjCDTLhL4bTfSr89Z0YJ5iNI=;
 b=L/4kPrEjJmm0Zubvk1zbH/bQpuO0OgTinxgJ68eG3THf7gqAUzsnrAI33hCAw7YEK0mmzPWMhbMR4vrBa5tMsKexj+qhq0DQih4hSwPssPbz03eGLxHW57PgaLvK0MHHiURutdjI/w3EDe2dVA0XWQncip/lEjY+4EYoTbDS6oE=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM5PR0401MB2660.eurprd04.prod.outlook.com (2603:10a6:203:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 09:15:13 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%7]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 09:15:13 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 2/6] dt-binding: phy: Add iMX8MP PCIe PHY binding
Thread-Topic: [PATCH v3 2/6] dt-binding: phy: Add iMX8MP PCIe PHY binding
Thread-Index: AQHYstLhBnUuOF8ALUKGid366nxpcK27PlyAgAB2RfCAAhXaIA==
Date:   Wed, 24 Aug 2022 09:15:13 +0000
Message-ID: <AS8PR04MB8676D5B40F7D0645BAB361228C739@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
 <1660806153-29001-3-git-send-email-hongxing.zhu@nxp.com>
 <20220822180713.GA75195-robh@kernel.org>
 <AS8PR04MB8676272814A6F20E26C53B758C709@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676272814A6F20E26C53B758C709@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8f70649-f339-4489-3494-08da85b126dd
x-ms-traffictypediagnostic: AM5PR0401MB2660:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hqRsJ7s0OL09quTASOBoleVZP+X4HjiC/fZEthjut9DShbvpB/2e5o/AVFksj6pCz1La490kEO+34vq/YOQElE1SfVbJtTxTHefnLz63F22faDYCNF0/s0TyJJ5jUpVxQazC/bBGh3h1Z3GhMoWPSRmvY8dOr7yidOvGvAphaHI3VLA72ej32MJZTFEz2VklOJyURuaxw6Fu4HxPvcOVNMKRIxVYggjdEa4tKZ0RxHRuq4lhRRdEb9KIdVf18FCGiEdPwx/mcNg2G2OAPAjtA64masrzLSCx4vOc2bziqmgE72cVYLHMgtEKo6iUqA5Imb6DiWorTn61LjRwJVb2pr/+YBQ3E3nKIlFRkJ349SrB/wCI/n1fkn5oguFrCs7RyQVrQoRbXHoRv2rq5yxmg/9+kbN0tRjXjCnwestq+F4rXSGKzzOV9RjHBZkfA0RGBpWb6rH/uciJ2Y0h+15+O3M7DuEcTr4HWUoYjpmEiZ7s79b8ucV+JohR2RXtx0Gr5d8muV+DX8uM5qIbH2lW1XMZI8da/n8EzEvNbNt2Y6bumRzOJaxaedPwwY/4gZJfn+vp67HG5+qqzC4hLgbv771WpbUzwCw/P8UZHBlU2mtAbfIXWs6Y1kIzNwRSgZ1tGOBaRHi8AkXGbunPtksToXH8TQUNOBoVF+0SRGuQ/LYUvpmHSSJ4q8zvwuERBYipsu5y7xhsAd75FKYQ8V7e8LCmGVR+EcMbAMZfzhsF5oB+9865jtNhwQahnoKVq7tAXcIg9NtOBSM5E2Y6pwZq7RZ5r/FmH6ryQ4dVWG97YzE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(122000001)(53546011)(7696005)(83380400001)(38100700002)(41300700001)(6506007)(8676002)(4326008)(66946007)(64756008)(2906002)(66446008)(5660300002)(66556008)(7416002)(66476007)(52536014)(33656002)(44832011)(9686003)(26005)(8936002)(76116006)(86362001)(71200400001)(478600001)(55016003)(6916009)(316002)(54906003)(186003)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WVhQRkIva2daMU9UTXpnZU1PRVIxVHJuYWlXdjd0YWExMC8xYkxmSEJGQUZp?=
 =?gb2312?B?R1ZUU3VoUkF4OTZSb2NqS3F6cmlyOVZGSC9lSVBlZWxhZ0RlUHg2blVrMnA0?=
 =?gb2312?B?cXcrUVBFSFpER0I3eWVSKzJLSkxGdlNvQ1NnQ1c3cjJLM1ptL25MM0wvQ3JT?=
 =?gb2312?B?Z3ovWXh4VXZHejM1WTVHWUFyZnhxeEN0TlFveVZCSy9LczAwMElTSFNBa3dW?=
 =?gb2312?B?cHdZTUVxVXZRZTIyVk82OEZGTmZLcFlCdm9ROWdFMUwzR3ZITldKZ2ovdFkw?=
 =?gb2312?B?U0xnbWpFK0tMMlFER01ZeU9nMVpOa2VUUExkUHhGc3JWelZVYUxGRXpZWlRG?=
 =?gb2312?B?SFlHdzNtMlQwemN2Nmd6bDhId2dBamNISDF1YzM1cHg3dTVkL1dJZXoweVhS?=
 =?gb2312?B?QzhZSVF3SG1tMHVMc0VCRFE3ZEMyTlFVWHp6S3duSGFEbkI3WlZQbmVQOVVW?=
 =?gb2312?B?ZTQ1ZDhrenY1WWRtS0I0bEpud3c2SkV6RUtud3I0NDJkRGxKNEVMWDlVTjdh?=
 =?gb2312?B?KzV0RWNvbm5jemNpSC8yazFaa3ladlF3Z0hYQStGS1lYN3FVVitPMzgySktK?=
 =?gb2312?B?WEp4TmFkTmJNMlV0dERQMWxPcEtUZFZMUVdVNVhOam1RdnQvRTNaa253dVZv?=
 =?gb2312?B?QXhMY1p0OWxDQTVXRGovYVZKaXlBamZYRWZhQjM4UWhucVBKSDNoeVZoS2Vv?=
 =?gb2312?B?aHk0cGVQMWdsTC9hMVBzdHRSVmVSeDNlL2dHZHZUQ3VlYjI5KzdSRDJkcTli?=
 =?gb2312?B?Mjl6NFNLVXVwTjVwMTBXQWZGQjY0cERDaFZ6Y0JPTnJONTRmWlJieWlLZndB?=
 =?gb2312?B?NXBlZXNwZitCNUxZby9qZUpSYXM3YitjWjFWTzhhOXF2WDFuaDMxVzdGcnBv?=
 =?gb2312?B?UzdXQmVOVUhIbFZHOHVIWWphdUF4Y2Z3OFhlVWk0MzNoLytrTXJadjVjSWhF?=
 =?gb2312?B?WUczZ2FhMjB5dmRiUjhYMVJJbmkyOUVXb080cmgwUWFpUEIxbnRpbVIrR09T?=
 =?gb2312?B?YUg2alM3cWN6ZXVYcVFBakFYMk5IYXk2MTBTYmxUdmtPa3Z4bFB1NUVtVzBs?=
 =?gb2312?B?cGR0cXBOaSt4STcrNzFwcjR1VlN2c2JBVDAzWE9VbUN6OVc2bFJ4azdjY2pu?=
 =?gb2312?B?bUxnLzYra3RBTHZIRm1tSnU4eDlSUk12M0UxcjBQeWY3QXR2YTVRNjJzbU1w?=
 =?gb2312?B?QXhqQVo5a2FSRjFnOXNQaWsyRjJSeXR3cVplTStyUWwzSDJETVVoUnlLWjl2?=
 =?gb2312?B?S0FqNGM0NHVZQncxQ1Y5cm5NdkQ1VEFxOVB0T1JBWVZoaDVCVzQ1N3A3Zkpp?=
 =?gb2312?B?Z1lDOTA0NzJYUFBYSzhwYkVDVkNremdhRGhlOC9LZzE1WlYwWThYL2Jyd2lt?=
 =?gb2312?B?bFNlZlhsTDh5LzBhVWdnNHZjZWYraFYyWXgrK0l3SjdpcTR1aGhrLzBoa0ll?=
 =?gb2312?B?M1hMZ1RtQmNmSWFwNFVtSDdjbzc1WStkeHRUM0MvWjZZNW9PMXdVcVRlZ2xU?=
 =?gb2312?B?cThWcG1kMVlDMWdtZEdkaWJ4Z1hLYWpVeUV6bXh1b2k4SFFmTDFnRjY4eW1H?=
 =?gb2312?B?aWlteW5pcGErSktKMUJOQTVDcTQvQjI0VG01YU1qYzZsNnZEM2lNZENxV1RH?=
 =?gb2312?B?YUVVUitoeGc5Q1VLbGlQL1lQb0h4Q3l6ajcyQlB0Y2JWbjd6YW5YWjhxM2FG?=
 =?gb2312?B?RDl5UVZaQjcrSXAxMWo3L0l3alVkaVF6d08zQU05aVpQME42d3lJenNQYjd5?=
 =?gb2312?B?QkxXa0pRY2NOK3pYZEpraXNrMFNhR3ZXZ1ZkZnRJWG4wQ3RaS1JrWXBYbUxw?=
 =?gb2312?B?d0dySG1sUjFkYklNSERPdVNUUzU2RVE3SEorQmdjZzZqdEJRaHZUMTVhaDNn?=
 =?gb2312?B?WTI5WUgxMjBvL0RuOUpUQ2FicStDV21uUUNmVk5ic1VVbVpNYlhCa0wwVUxM?=
 =?gb2312?B?aTczeXFFdFJiWWVRcy9uQVIwaVhtQ2drQ05QTERxOGZzbUwyL1hxcCtBd1pl?=
 =?gb2312?B?a2l0Z2NLbzZPMlNhUUtJM2ZuekRFUWZTT25mQ0VOTVpxa1ZySlhkcUdTTTBR?=
 =?gb2312?B?dk1JY1R4bXlWZERDaEpVUUsvKzhPbmlrR3c3TllUVkNEeFViOUVpL0JCL2Nk?=
 =?gb2312?Q?/YNyLwk2HMdC1bhZviQJCMj3i?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f70649-f339-4489-3494-08da85b126dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 09:15:13.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrKd9jJLyAgAhmfhscfIF6uUtkUxBnyXrgSCMZ+Rs52qEA/U30aRBfyNM6qx0/mtrF6KSbnApXkNz89HC3yN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2660
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUNCj4gU2Vu
dDogMjAyMsTqONTCMjPI1SAxMDoxMg0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gQ2M6IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHZrb3VsQGtlcm5lbC5vcmc7DQo+IGFsZXhhbmRlci5zdGVpbkBldy50
cS1ncm91cC5jb207IG1hcmV4QGRlbnguZGU7DQo+IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0K
PiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMi82XSBkdC1i
aW5kaW5nOiBwaHk6IEFkZCBpTVg4TVAgUENJZSBQSFkgYmluZGluZw0KPiANCj4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+DQo+ID4gU2VudDogMjAyMsTqONTCMjPI1SAyOjA3DQo+ID4gVG86IEhvbmd4aW5nIFpodSA8
aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gQ2M6IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+ID4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gPiB2a291bEBrZXJuZWwu
b3JnOyBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOyBtYXJleEBkZW54LmRlOw0KPiA+
IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPiA8bGludXgtaW14QG54cC5jb20+DQo+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzZdIGR0LWJpbmRpbmc6IHBoeTogQWRkIGlNWDhN
UCBQQ0llIFBIWQ0KPiA+IGJpbmRpbmcNCj4gPg0KPiA+IE9uIFRodSwgQXVnIDE4LCAyMDIyIGF0
IDAzOjAyOjI5UE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gQWRkIGkuTVg4TVAg
UENJZSBQSFkgYmluZGluZy4NCj4gPg0KPiA+IEV4cGxhaW4gdGhlIGRpZmZlcmVuY2VzIGluIGgv
dy4gVGhlIHBoeSBpcyBjb25uZWN0ZWQgdG8gUEVSU1QjPw0KPiA+DQo+IEhpIFJvYjoNCj4gVGhh
bmtzIGZvciB5b3VyIHJldmlldyBjb21tZW50cy4NCj4gWWVzLCBpdCBpcy4gUEVSU1QjIGltcGFj
dHMgUENJZSBQSFkgdG9vLg0KPiBUaGUgZGVmYXVsdCB2YWx1ZSBvZiB0aGlzIGJpdCBpcyAxYicx
IG9uIGkuTVg4TVEvaS5NWDhNTSBwbGF0Zm9ybXMuDQo+IEJ1dCBpLk1YOE1QIGhhcyBvbmUgaW52
ZXJzZWQgZGVmYXVsdCB2YWx1ZSAxYicwIG9mIFBFUlNUIGJpdC4NCj4gVGhlIFBFUlNUIGJpdCBz
aG91bGQgYmUga2VwdCAxYicxIGFmdGVyIHBvd2VyIGFuZCBjbG9ja3MgYXJlIHN0YWJsZS4NCj4g
U28gYWRkIHRoZSBQSFkgUEVSU1QgZXhwbGljaXRseSBmb3IgaS5NWDhNUCBQQ0llIFBIWS4NCj4g
DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2ll
LXBoeS55YW1sICAgICAgICAgIHwgMTYNCj4gKysrKysrKysrKysrKy0tLQ0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQNCj4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bo
eS9mc2wsaW14OC1wY2llLXBoeS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGh5L2ZzbCxpbXg4LXBjaWUtcGh5LnlhbWwNCj4gPiA+IGluZGV4IGI2NDIxZWVk
ZWNlMy4uNjkyNzgzYzdmZDY5IDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sDQo+ID4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2ZzbCxpbXg4LXBjaWUtcGh5Lnlh
bWwNCj4gPiA+IEBAIC0xNiw2ICsxNiw3IEBAIHByb3BlcnRpZXM6DQo+ID4gPiAgICBjb21wYXRp
YmxlOg0KPiA+ID4gICAgICBlbnVtOg0KPiA+ID4gICAgICAgIC0gZnNsLGlteDhtbS1wY2llLXBo
eQ0KPiA+ID4gKyAgICAgIC0gZnNsLGlteDhtcC1wY2llLXBoeQ0KPiA+ID4NCj4gPiA+ICAgIHJl
ZzoNCj4gPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiA+IEBAIC0yOCwxMSArMjksMTYgQEAgcHJv
cGVydGllczoNCj4gPiA+ICAgICAgICAtIGNvbnN0OiByZWYNCj4gPiA+DQo+ID4gPiAgICByZXNl
dHM6DQo+ID4gPiAtICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArICAgIG1pbkl0ZW1zOiAxDQo+ID4g
PiArICAgIG1heEl0ZW1zOiAyDQo+ID4gPg0KPiA+ID4gICAgcmVzZXQtbmFtZXM6DQo+ID4gPiAt
ICAgIGl0ZW1zOg0KPiA+ID4gLSAgICAgIC0gY29uc3Q6IHBjaWVwaHkNCj4gPiA+ICsgICAgb25l
T2Y6DQo+ID4gPiArICAgICAgLSBpdGVtczogICAgICAgICAgIyBmb3IgaU1YOE1NDQo+ID4gPiAr
ICAgICAgICAgIC0gY29uc3Q6IHBjaWVwaHkNCj4gPiA+ICsgICAgICAtIGl0ZW1zOiAgICAgICAg
ICAjIGZvciBJTVg4TVANCj4gPiA+ICsgICAgICAgICAgLSBjb25zdDogcGNpZXBoeQ0KPiA+ID4g
KyAgICAgICAgICAtIGNvbnN0OiBwZXJzdA0KPiA+DQo+ID4gVGhpcyBkb2VzIHRoZSBzYW1lIHRo
aW5nOg0KPiA+DQo+ID4gbWluSXRlbXM6IDENCj4gPiBpdGVtczoNCj4gPiAgIC0gY29uc3Q6IHBj
aWVwaHkNCj4gPiAgIC0gY29uc3Q6IHBlcnN0DQo+ID4NCj4gT2theSwgdGhhbmtzLg0KPiANCkhp
IFJvYjoNCkRvIHlvdSBtZWFuIHRoZSBmb2xsb3dpbmcgZGVmaW5pdGlvbiBvZiByZXNldD8NCi4u
Lg0KICByZXNldHM6DQogICAgbWluSXRlbXM6IDENCg0KICByZXNldC1uYW1lczoNCiAgICBtaW5J
dGVtczogMQ0KICAgICAgLSBjb25zdDogcGNpZXBoeQ0KICAgICAgLSBjb25zdDogcGVyc3QNCi4u
Lg0KV2hlbiBkbyB0aGUgZHRic19jaGVjayBsYXRlciwgaXQgY29tcGxhaW5zIGxpa2UgYmVsb3cu
DQoiDQpDSEVDSyAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi12ZW5pY2Ut
Z3c3OTAyLmR0Yg0KICBEVEMgICAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cC1kaGNvbS1wZGsyLmR0Yg0KICBDSEVDSyAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcC1kaGNvbS1wZGsyLmR0Yg0KL2hvbWUvcmljaGFyZC93b3JrL2xpbnV4LWlteC9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZGhjb20tcGRrMi5kdGI6IHBjaWUtcGh5
QDMyZjAwMDAwOiByZXNldHM6IFtbODMsIDI0XSwgWzgzLCAyNV1dIGlzIHRvbyBsb25nDQoJRnJv
bSBzY2hlbWE6IC9ob21lL3JpY2hhcmQvd29yay9saW51eC1pbXgvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sDQogIERUQyAgICAgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdGINCiAgQ0hFQ0sgICBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0Yg0KL2hvbWUvcmljaGFyZC93
b3JrL2xpbnV4LWlteC9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0
YjogcGNpZS1waHlAMzJmMDAwMDA6IHJlc2V0czogW1s2MSwgMjRdLCBbNjEsIDI1XV0gaXMgdG9v
IGxvbmcNCglGcm9tIHNjaGVtYTogL2hvbWUvcmljaGFyZC93b3JrL2xpbnV4LWlteC9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2ZzbCxpbXg4LXBjaWUtcGh5LnlhbWwNCiIN
Cg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IEJlc3QgUmVnYXJkcw0KPiBSaWNoYXJk
IFpodQ0KPiA+DQo+ID4gPg0KPiA+ID4gICAgZnNsLHJlZmNsay1wYWQtbW9kZToNCj4gPiA+ICAg
ICAgZGVzY3JpcHRpb246IHwNCj4gPiA+IEBAIC02MCw2ICs2NiwxMCBAQCBwcm9wZXJ0aWVzOg0K
PiA+ID4gICAgICBkZXNjcmlwdGlvbjogQSBib29sZWFuIHByb3BlcnR5IGluZGljYXRpbmcgdGhl
IENMS1JFUSMgc2lnbmFsIGlzDQo+ID4gPiAgICAgICAgbm90IHN1cHBvcnRlZCBpbiB0aGUgYm9h
cmQgZGVzaWduIChvcHRpb25hbCkNCj4gPiA+DQo+ID4gPiArICBwb3dlci1kb21haW5zOg0KPiA+
ID4gKyAgICBkZXNjcmlwdGlvbjogUENJZSBQSFkgIHBvd2VyIGRvbWFpbiAob3B0aW9uYWwpLg0K
PiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gIHJlcXVpcmVkOg0KPiA+ID4g
ICAgLSAiI3BoeS1jZWxscyINCj4gPiA+ICAgIC0gY29tcGF0aWJsZQ0KPiA+ID4gLS0NCj4gPiA+
IDIuMjUuMQ0KPiA+ID4NCj4gPiA+DQo=
