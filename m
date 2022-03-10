Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5824D41F5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 08:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiCJHmP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 02:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiCJHmP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 02:42:15 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20070.outbound.protection.outlook.com [40.107.2.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973461323F1;
        Wed,  9 Mar 2022 23:41:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMkLRfRG4QiW3j2TSOZWS/Gx3J73glN2K4l0mSayVZMAY/qVfX/BJa1LBPb3NzK+m6WKOglRDIBzFDZUOk/64jHSKZXELcp3vtmOTv6bgbB5wisaS9aepBjoL8Q1OClcjYbkfagcTZBYQRaQETeMFQPc7I/u56tbvXV4MLLLvvK5jKcnA4PUGssaLyW7AhTRxTYOUFJLwTMsdNGTEXiqrxdeOBLKviEByp/4Dgn0OENNXozxQ+RxaAfaG80xTSQuQPrKQIDgdlr5/LsuoPJiaLlYUfmZVqqJN6TLDXRymC5tiVpaXf2xoJKOnFM5CTfrbnuiLOzkYXYJGgu7z9hgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBFsAPbgiQxVWCFq37UCSx168IjB+we266BihiXOkys=;
 b=NKve4sx0120+0AGmCysp3lOAQmmsczWvGzV88mKIl7Tzh46UIj1xSVDuikfS4xojQkA7DhodnjXqlCVnQ96ric9sTwg74oRTmARA5ad4XPgllOURFDjiwRJYXG2IVx6YTlXz42vITieUV56gJwrRfMAjso3ovIq8JGS0FlkPYfjcSmB47p4RXRv3fzPXFa7raN+9bEOsjXFvGGbOpp83P+2UYNuCppObo0oFqyxn18ukPeFgYLSAAchjjzVa0WJcieBOSkCC1wbIwySoyLaXLe0kuO1oe607u+73YRuSYlbPktIaM4IdIfgSGJOq4rPaLujDgphH53dq9wuFa5EjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBFsAPbgiQxVWCFq37UCSx168IjB+we266BihiXOkys=;
 b=A48AntXPqOZI+gC6NCsq3gI4y27r2roZPMVHrtMma/s2qxqruLB4Ra2Rb5SyEQtgcjmZoAiheFuRFwDV2CBOO8gFiyrW2apLqgtWshGWb80h4cm/WuyfkQUWB08HSiFohhB9V/H6u/GrW2LawoPQdfn5sCaWOX/1airyRiBer/A=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM6PR04MB5720.eurprd04.prod.outlook.com (2603:10a6:20b:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 07:41:10 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 07:41:10 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Trent Piepho <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Add missing of_node_put() in imx6_pcie_probe
Thread-Topic: [PATCH] PCI: imx6: Add missing of_node_put() in imx6_pcie_probe
Thread-Index: AQHYMpRe7AxJbOre90GymOy2Uc2Abay4Pq+A
Date:   Thu, 10 Mar 2022 07:41:10 +0000
Message-ID: <AS8PR04MB86767DB07F7E767698E7A12E8C0B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220308022929.30002-1-linmq006@gmail.com>
In-Reply-To: <20220308022929.30002-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e35d011-db03-42ef-741a-08da0269587f
x-ms-traffictypediagnostic: AM6PR04MB5720:EE_
x-microsoft-antispam-prvs: <AM6PR04MB5720971B171673B35FBD25A88C0B9@AM6PR04MB5720.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hc781dnpU56dok85vjk5fKlFn4YgksLyA/TRrcTmQPtQPo9jJJUF5wkJmfRrZvGqsO05SUsRjqXrn0507y3WlDz9/nOa+K1EKl6FsCrUWk8nKhWTitcqg7dhzehaSxCS6JsQauqtVj81vB3cVCwDQfL/NgCxyA/hxPbmv6/e1wh4p8dg6qQJoq3oqWKYXPJ1KsxHdtaIzD+TYDAGD1yuwLY+MX9s7Cvk7hVmA6JRuHUvICu7T1lbmNwVMhGfX56/5lBljslTPcqz71RMHjovg6Xy8o1bvKTFlPkV2/uIhaBmuC4uRWagajX8HlM0ZxzOx4S95mHKD5jQ3A8yfQZWY3fL/9f4vv1oYFmiOAvkDUV8wyT/JuOGoPks++6ay3Ii9iAZljXNrpFTh8vm8iwgV6YG9Ct2Gckjco1ywUVi2oBWqMupDgdcuFKw9A9HUxx7j5T+qlHnt2m427zUVmiNJkcbVJlS3e73lV8RNLuSrWdz8HgOHmIkxiAPt6MYHrxWtR589NhHTP+f9+sA4A9HDHFnY1snVwMJNFghui79OBD0CglGnzmcYYqvy7vQG+LKVTZI7YTrOQGcq2QFvYSP6VimXmJfC5Qd9TKMfpGeZqqU4aBmPEqa1pP/B24Iqdb0GYzjzT/Vlzjd5hoiv6588uKUYfCUwzXKqoZ2Tz1J9Bp0XKhl3Nv6m5GpFu1DiY1kDd5NqfXb04jgcS3FvoggAV0zAp6KGi1F9UpXE7HbMDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(83380400001)(110136005)(71200400001)(38100700002)(38070700005)(2906002)(53546011)(9686003)(7416002)(52536014)(44832011)(66556008)(66946007)(921005)(5660300002)(66446008)(64756008)(76116006)(66476007)(66574015)(186003)(498600001)(26005)(7696005)(6506007)(122000001)(8676002)(55016003)(8936002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NzVjbmZGcDdSWndzMy9uUElJSm5hWWEyaVJDSFl6enJxMnZUQ0dkeUE3dkRY?=
 =?gb2312?B?cm94Z3o2N2h3TTNzMGxsUGpQQXlXVVpzMVZIN1dOaFlqWlZhaWlNNHhFL3Ju?=
 =?gb2312?B?enp4UUNvZVNQMWcrSmVZdFlrNVB2b1FLQk11Z2lDTkVQelhNT2Q1Y05mN3Mz?=
 =?gb2312?B?cndYbTJLanQzUTZSMm9zb3RkL1ZLcTIyN0pjUHlzS2JVZHh2TkUxN0hHaFJQ?=
 =?gb2312?B?RnBqeFRsSFRsQ3gvbzd0b3ZuVEFTWXYxdjd6VW5MbjJEYVZxTUFtSTR3V0Vi?=
 =?gb2312?B?MVMvT0dKbFQxY281TTh1TzFpOTlMb3lFVEFXMlZaZDhybEZTalY0R0tYSkVX?=
 =?gb2312?B?ckNFV3gwSXA1SVhObjNlTldRRE9jbERjN1FLd3ZoQTlGVzVhWkwrYXovcWtI?=
 =?gb2312?B?UmptSXZRRGNVODBReHJYb3pzQkNLTUpDYkJUN2xsT1NkNkdsMnpzUUVzUTA0?=
 =?gb2312?B?Z2Iwa2dCRk5leGFXMkVHTXZOeS9XY0ZrN21NZUtQd2RBaFRCeTJVNUVZeFI3?=
 =?gb2312?B?OFlzNVIyY0JxVmxaS3BhL0ZueU5DMkNjbHRQWmM4VDgySVBMNlJ5Wmh2Qm41?=
 =?gb2312?B?ZlhaT2tuZkIwMU9FNmM5UEgwdEdrT2EwblBhSE1qVVNvMFRZWEtwVHg2eGNU?=
 =?gb2312?B?SGpocjIwL1c4QlhFTGNxdkxSY2hMWmZtRU9QY3JJRG03QzIvWXZDUDlKZDVM?=
 =?gb2312?B?eGR6YlNRWEg2STRiclNtdHhnYzVnRTFFeWRuRDJmZUIyNzNjVXlyNlRJT0VQ?=
 =?gb2312?B?am42MWFpV2NLRVlLTno4UzBFUnNmOFpBc2hRNmdNL01QWlZjU1ZlZnJDYy9w?=
 =?gb2312?B?VFY4UmgwRnlScWtsaDVDNDk2dDdaNCt2VGNBQU40ODZmWWlzYlRYQnUyZlVa?=
 =?gb2312?B?aExuSzk2OHJ2VEZMNDU5dXRXc05ubHphWWpEZUZITTRFd2QrOVJyOWhoczlz?=
 =?gb2312?B?N0pqYXQrc21iaWdVbVJ4TThNRnZVeEtFaXhSckIzUHNPVE9NVWU5RHdaNDha?=
 =?gb2312?B?YkhicGlJSlE4UUVVTXl2MTNlY2dZTTErZ0l2YlJ2Qkdla0xtNU5vcXgrWGh0?=
 =?gb2312?B?aDJ4R1k2d3ZIREVmN3hWVGN4MUQvL1ZZTzlkQThwZHdGcWRlQVVhaXFvZmoz?=
 =?gb2312?B?bGU4MXltdzRxN2Y1amU2cnJsTTZZYmlGR0xqTGt6YUJaVXAvM294ZFB2Z1pt?=
 =?gb2312?B?cmJ0aHN3WFFzZ09kS2NBdDlEVytHUS9JSkErZVJxL0pwSEV1UGM5Qm9yTkdr?=
 =?gb2312?B?Y3RxeENJeVpPSnJTSmd5THViMHJoM3dSdW5iNjNRbjI5NmRyWUZsUVk1Y0F3?=
 =?gb2312?B?L1JKdDNJTytERTZMWkJxdlI0a2dRaGVud3k3SS9PZjl3ejE1NGNIT2lQK2VR?=
 =?gb2312?B?QmZkZHFUUkhFV3B4c0EveTZQNkQzbnJDYlBMVmlBNitqT3J4UUJCYzZoRUJk?=
 =?gb2312?B?UDFwQ21Ma1d2T2tkc2J6ZW1QelhidTlZbVlXNEtIQXVkcnkxc05XK1NzM0Zh?=
 =?gb2312?B?THNMR0wxQ0hMYWJMbEd2NFRTbHRDM0dScWFNSkdZMmVRZVJiNmZXcmxZUmFr?=
 =?gb2312?B?U256STVsVk9xWEMvdnFyUVRpVnhFTWxtR0RwQ3JsWVVEcWExb1paSDJmeGdl?=
 =?gb2312?B?S2RPNUUvWFZxR0JieFFGNW50c1JZMGRNc0NYUVpIU2JLaDhGL1pEUDFiamdX?=
 =?gb2312?B?MUgwRi9CV2ozWVBiWWVmVnZZdThvODVjNkRtaW5tcjgyZ1FZay9JUHRDTTlh?=
 =?gb2312?B?bDZ4MmMrN09YdnpGeXIvSHJIY0VaYk9HdWFEcklLQ0gybEFmUHYzaEUySXFT?=
 =?gb2312?B?bFVTQmhhUExMUEJCMFdkTjNQWFQrOTNpaEt3L3pkWDV4aXdCUkFkV3J0NS9K?=
 =?gb2312?B?R1cxN2VQczJ1UnltcVdiOThucUNkTHNyamxlT3A5TmpvMjNXZ1o1Y1hpNUZi?=
 =?gb2312?B?UkYvMmNMSldkbmwwTkZpTjl6YURyaGlYNzFiQllYc3BLUnpyVCtmUmtLODY4?=
 =?gb2312?B?aWtkYWlEc2ZDZ2I0R2Z4VzJHb00xR0pzLzBzbXpVdmM4dFpraTRxN1lNSUlm?=
 =?gb2312?B?MXd0VjZjMk9yM1FhQnR1dHlvKzhGbHJtWDhIZDN3R0dyMVVpRFMxc1VVVlV2?=
 =?gb2312?B?OU5lSFJ4TjdsYWwyaldIMUg3dmpUMUNuTk1WKzhoR0c3Tmh4b2RpNys3bU1M?=
 =?gb2312?B?eXc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e35d011-db03-42ef-741a-08da0269587f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 07:41:10.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOs0iWfn1OrFQQkU1XjDuYQPhenYlbMQo2dMvthVTVueKT0IQN32qoLUo/isBJ7owJQBZMX5lUAXZY+iKmkMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5720
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWFvcWlhbiBMaW4gPGxpbm1x
MDA2QGdtYWlsLmNvbT4NCj4gU2VudDogMjAyMsTqM9TCOMjVIDEwOjI5DQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgTHVjYXMgU3RhY2gNCj4gPGwuc3RhY2hAcGVu
Z3V0cm9uaXguZGU+OyBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNv
bT47IFJvYg0KPiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgV2lsY3p5qL1z
a2kgPGt3QGxpbnV4LmNvbT47IEJqb3JuDQo+IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+
OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Ow0KPiBTYXNjaGEgSGF1ZXIgPHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8a2VybmVsQHBl
bmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsNCj4gZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IFRyZW50IFBpZXBobyA8dHBpZXBob0BpbXBp
bmouY29tPjsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBsaW5tcTAwNkBnbWFpbC5jb20NCj4gU3ViamVjdDogW1BBVENIXSBQQ0k6IGlteDY6IEFkZCBt
aXNzaW5nIG9mX25vZGVfcHV0KCkgaW4gaW14Nl9wY2llX3Byb2JlDQo+IA0KPiBUaGUgZGV2aWNl
X25vZGUgcG9pbnRlciBpcyByZXR1cm5lZCBieSBvZl9wYXJzZV9waGFuZGxlKCkgIHdpdGggcmVm
Y291bnQNCj4gaW5jcmVtZW50ZWQuIFdlIHNob3VsZCB1c2Ugb2Zfbm9kZV9wdXQoKSBvbiBpdCB3
aGVuIGRvbmUuDQo+IA0KPiBGaXhlczogMWRmODJlYzQ2NjAwICgiUENJOiBpbXg6IEFkZCB3b3Jr
YXJvdW5kIGZvciBlMTA3MjgsIElNWDdkIFBDSWUgUExMDQo+IGZhaWx1cmUiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBNaWFvcWlhbiBMaW4gPGxpbm1xMDA2QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NClRoYW5rcy4NCg0KQmVzdCBSZWdh
cmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gaW5kZXggNjk3NGJkNWFh
MTE2Li5iY2MzMzhhYjZjMTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiBAQCAtMTA1MCw2ICsxMDUwLDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAkJc3RydWN0IHJlc291cmNlIHJl
czsNCj4gDQo+ICAJCXJldCA9IG9mX2FkZHJlc3NfdG9fcmVzb3VyY2UobnAsIDAsICZyZXMpOw0K
PiArCQlvZl9ub2RlX3B1dChucCk7DQo+ICAJCWlmIChyZXQpIHsNCj4gIAkJCWRldl9lcnIoZGV2
LCAiVW5hYmxlIHRvIG1hcCBQQ0llIFBIWVxuIik7DQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAtLQ0K
PiAyLjE3LjENCg0K
