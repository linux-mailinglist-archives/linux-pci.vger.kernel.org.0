Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59657AD51
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 03:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiGTBoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 21:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiGTBoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 21:44:02 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140058.outbound.protection.outlook.com [40.107.14.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A3FC3C;
        Tue, 19 Jul 2022 18:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeLmcV8Uc0DKxwltS8Frvgd7x4rkB9OTGPgWB9fhhEyg7Pzd1j/v9lHNQSxYoxFe50iVj3bhZmVoHtTo5dSYfNR1e9Hut5UF5kEc6vERgNZKhjwUOd3eG6ajoww9MgJEg04UBTMTH4DQyYwCgSL94uADZJxHNszIUUV1y4KWGBOmilLGoVw0mXzReGIsromMa2QAK49jU+GBRBoMbESdQGbMdPV0idFotefKsYWAPlvVxOcdw/Gxq7VdIpKFwGPLdSNL1bJnXTisGyfJXhecTyOQvc5KHVwM2OPQCWgWMaESM43/+3Jd0RSv3Fjak4W6H3KlGlZbvPEG+UCWTZv56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1AjazmUofmIi3o+W0gKO4phouZSe2ZfY/rlsAs5/RU=;
 b=StTz5p9l3q6x7aVAKWynGTHbKVE56abLh/OO6gA0baEDaCtya9M3N5sPYee8/Cfsy7nAGlq+lKbOMEWDuSBYp2SbQrzBuqEcX5vuePE4wgVqVFG5ABgDb+tF7ZcAqWzxRi09TKACSCBuHqck5Ms1Nr6hJ3npWgwOpISUQSol3uapNpOhGr0OJtjwK176aW/xVp377/SlZR3BXvJSi0f9IACtFuK/Ce3DAofUlzqMqVwL6GosZrvCkGjMFoY4wKThS6RwxtbDZW7NdrdrH+yzjLGWEmsftgYvvXNPwzfx2k1FbyxnJdaV4WcOXqjmCyp1g06cZgsQYv6MANqbNvWwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1AjazmUofmIi3o+W0gKO4phouZSe2ZfY/rlsAs5/RU=;
 b=a9xi6LaE+P62cpMQ5CzE8wkp/I+V4RwvXa0zCv6Gjod1FSymNVL5uNVhBzBOC3cwucAlexZdhp+Pt0YiO8+Nvjn8FI934/UeJ+E1o3WPDGU9piOlmDsKH4stLNcg1BkQm7XeSoNTTq/ctzKfhQtbyH7Aj8UJdF1D5y4fhnhr/EM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 01:43:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%9]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 01:43:55 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC 2/2] PCI: imx6: Support more than Gen2 speed link mode
Thread-Topic: [RFC 2/2] PCI: imx6: Support more than Gen2 speed link mode
Thread-Index: AQHYapxdhAuqFs2pP02KMI8xGlwwK62G0pqAgAAJ42A=
Date:   Wed, 20 Jul 2022 01:43:55 +0000
Message-ID: <AS8PR04MB8676EF521BAD0F98AE6CA9DD8C8E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1652866528-13220-1-git-send-email-hongxing.zhu@nxp.com>
 <1652866528-13220-2-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU0FM_zs9nQ6rX=xNJzsgaH=5WOeNDNCS9rs5VF2Av5eRQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU0FM_zs9nQ6rX=xNJzsgaH=5WOeNDNCS9rs5VF2Av5eRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a77462f9-b9e2-47e8-8532-08da69f14ee4
x-ms-traffictypediagnostic: AS8PR04MB7750:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oy6Wh7HfxZsETmwmBnSELM9SQ2z0NDcIAXLMEgMDbzWQ2wCv3G7xOGlW4xNZ+2B5dEDOhW7HgyUbAXgFEV+RMB0Lin1QgxiHfrTyIEY8POw2IcKsk6ILQ14Xrjx2Yh05fQTgOm+RLOVzme9qd7uZJhFxo5d8jY4gptodhT4ZO9523vYolnxSoJ1kT8bZbTYYXDoWgMBaRMflZ+xF+0QdInYNnf1KFlfeREhEBZj03uKmGj+vM/9U/SXKPYlMhk1f/0t7HautLbPGrfMXpJJyh91PQyPpj7lW6/oc0/aAw7o2RWaKB3kH1YCtQf/dWpL59kfIY1xao1woHvta8dD/4KPIPnf3xL3q1k7Vq4Rx1lbCayRPWMQwrwuIJNWyIZQwzt9YjLK+tx0HqakuC0XpWt0i/Iphqq3o7YxLLGFTU6gLSihraimBcLbpaB3tFowRNlqN7TU74WDLojbSOEPpBK5OR7PjmFDlyXjlMfP1vUnAgIIGZCY6QkM8G+LQFg4+ZM/azvUSdB8FlQzw074JlM6hxVjnSGtOQxfSWCPJlCnHy7t7KZBs3kAB7B5T0m9oTvk8bdOs8mAjTi+7VX4f8MiWlx1KsiMCaSJ7nun9g55u4Avf+EvYGwCg/z7Lm0P+Q6e4FUWV1PmqBnoPO1XansfD3QRwLJwmKkZyxg56sqyaEKv8/MQW8G+CK8zMJmLB+kHrQAdAlII3kq7i5kFCKCRU1x8BGO/Y2u/TXMmVksAzH5tEZ+8AKKQABWvbfsIr/NakMRf6sEUbHQ2ITpdyTmkYSakwbzeLhODJH0Hl4AqieuTKu+sJ/jNXPnA8sjhpVOKyIO5gK3IVcEUex9BRYXCK1L6i0ssaKdfXeXcBOWbOl8JlXi94q2rnj0eQmuvU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(9686003)(5660300002)(122000001)(2906002)(6506007)(53546011)(54906003)(83380400001)(86362001)(41300700001)(7696005)(26005)(44832011)(33656002)(478600001)(52536014)(4326008)(38070700005)(966005)(186003)(64756008)(55016003)(38100700002)(66476007)(76116006)(66556008)(66446008)(71200400001)(316002)(8936002)(66946007)(8676002)(6916009)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?K252dlFvOWpiSGpWc3dncGtBMHptdTFsRko0Y0FJK21JQWNHdlRXVFVXN1J1?=
 =?gb2312?B?emxYQlhyNzdETDdJQ2FqblNObzBTWEg5bi9yT2xUTktsbnEzV3F3KzlxSnlG?=
 =?gb2312?B?Yi9wMy9sQTdKdFdKbDYyS3Y3Z291VlNpb2psTDh2UWJSTkdGTzJIczBqR2Y1?=
 =?gb2312?B?bVhLNUVwM2hVblRyOVZpN04vemptMElMNUFEcmI4dXhVeU80TW5TRW92dEUv?=
 =?gb2312?B?R2ZCQlV3eWNwemkySmRsVGUwalRGTU11M2NUcUdaR3FvTnBhd3lBZFYzWTJn?=
 =?gb2312?B?Z3RxdFFKaDQxSndtY0JORE15ZFpRbnAzeklGVVgxZkZCamcwZmREbWRpS0E1?=
 =?gb2312?B?WUExcFNraXkyQjJrb1IvMVd0cW85ZXJiNE5pUzEvMEdVeTAyN3RUS3h2enM0?=
 =?gb2312?B?Q0c1aG5FYWYvL2tDTHZVeEMvU2crdk4zcjVCU3lHd01CcWdQUk5VRWNsQk1X?=
 =?gb2312?B?dUEwT3pKSWRLNEd6T3M2MTgrNElvb1IramYrOE8xekNQM0hCWThMK2Uxd0R3?=
 =?gb2312?B?QjZNOHdWSTZvK2hwdTd2cXZsMXBzYTJpTk05d3lvU1AxckhTZDlySUlrZks2?=
 =?gb2312?B?T0VaNWpwZHkzRWtiMm9VcTVCcnVyalo0TjBFWVhNRlgxQmNvOTl0Q2FEdC9T?=
 =?gb2312?B?WEZoK0dud1NTUHByL2MvdCsrZm5sWUNhQkVHYXZPaW9VSUpCN3NIN2wzbTZV?=
 =?gb2312?B?L2xuRUd2cUVzVVlqT2VUeEZ1T0ZSL0FidU04bWNYQWE3RlcvK0MwY1cyaHc1?=
 =?gb2312?B?R2laSjc4WXV1cElMN1YvRjJuNUlrenAxaGlhRGhDdnFXbzFlWlo3RDNIajE3?=
 =?gb2312?B?d1ZVKzZTSEtpbWQ0MjVJNm1aQ0dySkxrSEdCRzJDd3pLOStPZEYxMlc1K3V3?=
 =?gb2312?B?SVhDWGFtZi9JTjFSYll3YlFKOHU2M2p0VWtBMlJTV3M1THpCdkJPTHVtaWl6?=
 =?gb2312?B?ckJqOUVjRktDRmZ2eVhRNmlXWXhKaWFFdHRMcnV5MThlYXJBazhUNGdtSUNK?=
 =?gb2312?B?RWExVDBiL1FJR0lZeHNFRWpqSDNmd2JaRWVULzVybkVFRksrMnI0SW0rc09r?=
 =?gb2312?B?ZEF6TkdrUnVmcDc5WEJaN1BQb0hSZDk4a2g3WWUxOW5SRW1lT3duSEQ2SFZi?=
 =?gb2312?B?S2RVc2tNT3YxandVV0FJN0ZkMHVIaDZrU1ppMnN4RnpsaFZxSmF1K1ZhbGJu?=
 =?gb2312?B?d3dDL0hGUStKNW9IV3NzQzkrV2RiMnBpOVNkSW93Wiswai9BSG9iVlBQOWpP?=
 =?gb2312?B?MmhxSHkyZjlVaEZnNldoTnpZZmY1RWJRQnJaM0FtTEJwOTBDMHJ3V0VNaVRW?=
 =?gb2312?B?Vldzc2llMWtQK2JiQ3Z0MTAvOFE2U0xnTC9mVzgxS0piYXUvcERzTUF5b052?=
 =?gb2312?B?dkhXWXhyZ2YyU3JWSHNSU0xkQlBsUjdPSHdHNWorR1ZmbDVSdUdBRXlaWFNX?=
 =?gb2312?B?MGxWa25HbG1RWmQ3eUFiT24rZG1NTkxBczhWNzVEaktxc0NTZTlYQXp0NXZj?=
 =?gb2312?B?bXFFN2NRM3pLOHRTaFk1aWplam1EbmxtR1krWkJxZExmSmlnelVDeUh3VXFt?=
 =?gb2312?B?eHU1OFFJaGlwTTR4cjE1M1JRYjBqY000LzN0VVhzT0FLbnZYeGJSaWdXcndu?=
 =?gb2312?B?UnRxb2FhaXR1MEhqWWNGMkVHU0MvR0VkanJzc3NiSi9KdWJEQWg4MkFLb2tX?=
 =?gb2312?B?V1M2RFVzeXp6ZzdjeTZFd3BoS3hRbGZqYnA3MGYzZ0U3eFpnRi9XRGpRUmds?=
 =?gb2312?B?aG4xK1lQK3NFdEF0RkZXT0dHWkxPTVFldWJtQzRGQWwxNklmalpZekdBUVhK?=
 =?gb2312?B?Unp0QndqL0Q0TGlKSU9ib0xYWFR1dnBPSzQ1SG1ueVBvOGlOdWs5WUx6amZF?=
 =?gb2312?B?RFJUdE5JalhUTWhUb1o0a09nalFKSXhZUkdoTXhpM25sZUJvKytlL0oyak5H?=
 =?gb2312?B?SUY3TXdYVHFsVjJsY2VTcDYxRXVUR1NIZHN5M3l3Q05kcGJkOTNNWUFDTmVT?=
 =?gb2312?B?d2QxTmtMdkxaU0lvWWtSUS83SklqUUVTVGxWTm5JRUp3anZ2NzN4VlFxUFZJ?=
 =?gb2312?B?V1FHU3hnQm8xcW1uaWtuOUZ0VUw2ckxXWit5NjNKQ2JiZ2FseTNWdDhrbVp4?=
 =?gb2312?Q?/2UALHLBDROelUs1TswqCBwm6?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77462f9-b9e2-47e8-8532-08da69f14ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 01:43:55.7511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMhIS/l5dJ6cOkYTVFFoJ9BjO3SQHZ5+0yDJ/2dkfvMAXG+D4KkaDl7EO3mvmiVcWZUVU/FhzyYnHBU6pyWVGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW0gSGFydmV5IDx0aGFydmV5
QGdhdGV3b3Jrcy5jb20+DQo+IFNlbnQ6IDIwMjLE6jfUwjIwyNUgODo1OQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0YWNo
QHBlbmd1dHJvbml4LmRlPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgTG9yZW56bw0KPiBQaWVyYWxp
c2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+Ow0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBMaW51eCBBUk0gTWFpbGlu
ZyBMaXN0DQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBvcGVuIGxp
c3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPGtlcm5l
bEBwZW5ndXRyb25peC5kZT47DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUkZDIDIvMl0gUENJOiBpbXg2OiBTdXBwb3J0IG1vcmUgdGhhbiBHZW4y
IHNwZWVkIGxpbmsgbW9kZQ0KPiANCj4gT24gV2VkLCBNYXkgMTgsIDIwMjIgYXQgMjo0OSBBTSBS
aWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gU3Vw
cG9ydCBtb3JlIHRoYW4gR2VuMiBzcGVlZCBsaW5rIG1vZGUsIHNpbmNlIGkuTVg4TVAgUENJZSBz
dXBwb3J0cyB1cA0KPiA+IHRvIEdlbjMgbGluayBzcGVlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDQgKystLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCAzMDY0MWQyZGRhMTQu
LjM3MDEyZjlhMzNhMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiA+IEBAIC04MDksOCArODA5LDggQEAgc3RhdGljIGludCBpbXg2X3BjaWVfc3RhcnRf
bGluayhzdHJ1Y3QgZHdfcGNpZQ0KPiA+ICpwY2kpDQo+ID4NCj4gPiAgICAgICAgIGR3X3BjaWVf
d2FpdF9mb3JfbGluayhwY2kpOw0KPiA+DQo+ID4gLSAgICAgICBpZiAocGNpLT5saW5rX2dlbiA9
PSAyKSB7DQo+ID4gLSAgICAgICAgICAgICAgIC8qIEFsbG93IEdlbjIgbW9kZSBhZnRlciB0aGUg
bGluayBpcyB1cC4gKi8NCj4gPiArICAgICAgIGlmIChwY2ktPmxpbmtfZ2VuID4gMSkgew0KPiA+
ICsgICAgICAgICAgICAgICAvKiBBbGxvdyBmYXN0ZXIgbW9kZXMgYWZ0ZXIgdGhlIGxpbmsgaXMg
dXAuICovDQo+ID4gICAgICAgICAgICAgICAgIGR3X3BjaWVfZGJpX3JvX3dyX2VuKHBjaSk7DQo+
ID4gICAgICAgICAgICAgICAgIHRtcCA9IGR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgb2Zmc2V0ICsg
UENJX0VYUF9MTktDQVApOw0KPiA+ICAgICAgICAgICAgICAgICB0bXAgJj0gflBDSV9FWFBfTE5L
Q0FQX1NMUzsNCj4gPiAtLQ0KPiANCj4gUmljaGFyZCwNCj4gDQo+IEkgbm90aWNlZCB0aGF0IHlv
dXIgaW14OG1wIHBjaWUgc2VyaWVzIFsxXSB3aWxsIGZvcmNlIHRoZSBpbXg4bXAgdG8gbGluayBv
bmx5IGF0DQo+IGdlbjEgc3BlZWRzIHVubGVzcyBzdXBwb3J0IGxpa2UgdGhlIGFib3ZlIGlzIGFk
ZGVkLiBJIGJlbGlldmUgeW91IHdvdWxkIGFsc28NCj4gbmVlZCB0aGUgZm9sbG93aW5nOg0KPiAt
ICAgICAgICAgICAgICAgdG1wIHw9IFBDSV9FWFBfTE5LQ0FQX1NMU181XzBHQjsNCj4gKyAgICAg
ICAgICAgICAgIHRtcCB8PSBwY2ktPmxpbmtfZ2VuOw0KPiANCj4gV2hlbiBJIHVzZWQgdGhpcyBh
bG9uZyB3aXRoIHlvdXIgaW14OG1wIHNlcmllcyBob3dldmVyIEkgb25seSBnZXQgYSBnZW4xIGxp
bmsuDQo+IA0KPiBIYXZlIHlvdSBtYWRlIGFueSBwcm9ncmVzcyBvbiBhIHYzIG9mIHlvdXIgaW14
OG1wIHNlcmllcz8NCj4gDQo+IERvIHlvdSBrbm93IGlmIHRoZSBkb3duc3RyZWFtIE5YUCB2ZW5k
b3Iga2VybmVsIFsyXSBzdXBwb3J0cyBpbXg4bXAgR2VuMw0KPiBsaW5rcz8NCkhpIFRpbToNClRo
YW5rcyBmb3IgeW91ciB0aW1lbHkgcmVtaW5kZXIuIEkganVzdCB3YXMgcHV6emxlZCBhIHdoaWxl
IHdoeSBvbmx5IEdlbjEgaXMNCiBsaW5rZWQgdXAgb24gaS5NWDhNUC4NClJvb3QgY2F1c2UgaXMg
dGhhdCBJIGZvcmdldCBtZXJnZSBzb21lIGxvY2FsIGNoYW5nZXMgdG8gdGhlIHVwLXN0cmVhbSBj
b2Rlcy4NCkJUVywgdGhlIGxvY2FsIGNvZGVzIHN1cHBvcnRzIHRoZSBHZW4zIGxpbmsgb24gaS5N
WDhNUCBBMSBjaGlwIG9yIGxhdGVyLg0KU2luY2UgdGhlIEEwIGNoaXAgUENJZSBvbmx5IHN1cHBv
cnRzIHVwIHRvIEdlbjIgbGluayBzcGVlZC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
DQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IA0KPiBUaW0NCj4gWzFdDQo+IGh0dHBzOi8vZXVyMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGNo
dw0KPiBvcmsua2VybmVsLm9yZyUyRnByb2plY3QlMkZsaW51eC1wY2klMkZsaXN0JTJGJTNGc2Vy
aWVzJTNENjIwODg3JTI2c3RhDQo+IHRlJTNEKiZhbXA7ZGF0YT0wNSU3QzAxJTdDaG9uZ3hpbmcu
emh1JTQwbnhwLmNvbSU3QzljN2IxMWYyNTk5DQo+IDY0NWY2MmRkNjA4ZGE2OWViMTQ1NSU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3DQo+IEMwJTdDNjM3OTM4NzU1NjI5
OTYyMzA3JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0DQo+IHdMakF3TURBaUxD
SlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTcNCj4g
QyU3QyU3QyZhbXA7c2RhdGE9STNQd25STzU2alY3eUtXMEFsMTZDJTJGJTJGWTVHdXBpeUlpZmRL
JTJGRTINCj4gMkFpU3MlM0QmYW1wO3Jlc2VydmVkPTANCj4gWzJdDQo+IGh0dHBzOi8vZXVyMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnNvdXJj
ZS4NCj4gY29kZWF1cm9yYS5vcmclMkZleHRlcm5hbCUyRmlteCUyRmxpbnV4LWlteCUyRiZhbXA7
ZGF0YT0wNSU3QzAxJTcNCj4gQ2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M5YzdiMTFmMjU5OTY0
NWY2MmRkNjA4ZGE2OWViMTQ1NSU3QzY4DQo+IDZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYz
NSU3QzAlN0MwJTdDNjM3OTM4NzU1NjI5OTYyMzA3JTcNCj4gQ1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVA0KPiBpSTZJazFoYVd3
aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9UFV1bCUyRjhiDQo+IDYl
MkZ0UmpKTUhPT0hjbTdKYjFCWHdHaSUyRlZuTG5XbUtDZU5lbzQlM0QmYW1wO3Jlc2VydmVkPTAN
Cg==
