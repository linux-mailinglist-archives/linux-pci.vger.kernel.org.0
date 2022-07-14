Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22539574221
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 06:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiGNEPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 00:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGNEPe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 00:15:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A68E27143;
        Wed, 13 Jul 2022 21:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IclUF/pgRaulTJ3WpovawOxe/42aNvwuftw13dnr2VYaY2BnHhncvH0AhWYxeK73XGy5ixPL4IJJjhJDUqxcuURzFAZ/AUa+LJvGdvav23sNT70DDo33kB3uWDykquQhSRnnwGYTzWjTfLlAN0IdSO5T7aKmKTUxjIY7Ykbn8l91UugRJtUmtcYe4535/wsEmvv1N9bICvXfHqjV5ZseGM3CGt4aPj76Y7Y5UWN9LXDNeusNGQyxlZAlKmyB9ISmZTlrGu8ai7qUddn8/i0k4aloMXatas5qggbvlBxqY+jHiHIeJNOyHtebErjU+JQ8ES28BNflhe4NT9jSK8pkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoSAwbgReEp2OfFOu1WqNR4Etlfs8cRGxOEPYO0xky8=;
 b=U7/S45FUQVdXQwm19VR0PZIox+OLUEoso58zmvctBU8z8eB26AU9S9jPnlwjPd7MkWS4nU2kW9W1APGdgnklALCf1wltDjs8CaK/zaR+tB87seqGec7SLLjMD1w6OUbeFS8BynHDLyIUOP6sfrxuQ8xQtcowaeHj0tgRyrYUzbV1yficJt/TAdae4s5BNYh7BhA4B8nECIesNzY3g/poCWqacXzQqYSiGgyNVm+xEKRrmX3ZNSxbKUCjcMbdA/PY4EU+V3gaSJo3zpkhgkf/l+s0W6lQHnsRJJnCJaBwkR1al0L0vIBHFyTcleNn31+KwdUrmdDST9RzA9Rf/Hj0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoSAwbgReEp2OfFOu1WqNR4Etlfs8cRGxOEPYO0xky8=;
 b=smXT5JaLLYOz6D+l6RXQ6DA/yUv2IzWExcAel/ZjLsxuH38TWJR+buhDUgM1zvIuaRtcyJgoia2fQ9osaWBEsruBNjkxu9zE+SIBuKVUA3lnsLmblr4DwhYWdS3EVNvVAxLd0ScEstGIM+t4cfcivhpZXACRyzpvNXKvP43A7s8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM6PR04MB4405.eurprd04.prod.outlook.com (2603:10a6:20b:1d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 04:15:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%7]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 04:15:30 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 0/17] PCI: imx6: refine codes and add the error
 propagation
Thread-Topic: [PATCH v14 0/17] PCI: imx6: refine codes and add the error
 propagation
Thread-Index: AQHYjPxHFbykmmmAgUGqKcWdyq4LO6150YmAgALEhwCAAK+MoA==
Date:   Thu, 14 Jul 2022 04:15:30 +0000
Message-ID: <AS8PR04MB86762D6FF4AD5B96AADBACEA8C889@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220711222959.GA701423@bhelgaas>
 <20220713164554.GA833183@bhelgaas>
In-Reply-To: <20220713164554.GA833183@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61e96375-08cc-4843-120d-08da654f7d6a
x-ms-traffictypediagnostic: AM6PR04MB4405:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWfkvw5jSGI0o+ZfG3iJ2B/ZpN7+T8Obfn0J1frdT4X2beSBrwClSHXRnDn2lwkFbGMlgBfXjMmLi2bzZGmIyWexmTJlsvq2qH8+egFARdQ8djZJtAMuLjbMEWa75aGm1MCtKckImoS6pxS+JoEVleWPMewtbbL9/7vFPiwANgn4pfWvvoafTPnmpIhagd2GIC83AJZe4tW4N0lz4UjirSXLA1t2xrQtT4BsVDTrWX6l2HY65RBacUB+FSNyY/W6ExUaSUQhOXLujr6q6i8VXCAaeeb1oNj81y2mctlq3gCCRzEzEcYK8JObSS2CEkMCX+OHIiwOcuMbJcW1Oxe0f6WDN7Z1q4ARlrsZxJPFCA1C2C8kdAMrthX411/rs/CA8t+JAX8DBXg/8S9KQC8E0CY/USaaZ5RY5XWLe7Iel2ARF9HIrrGP56D6f9qsR8HnEJwjI/+OfuCMmsjiIvx4THmGi9OYHt5xksMx10RHuO65K6DV359QNlT+Vn4lX/ggsHoa3qJsyi3ua3h0xbdoj/7igIp7eKzY9tYWvKj4wVnMuuoGHi9P4qBT2NsMYGP0h+DZjSTSZnD/ygZ1uQeJi0Vc6t6DBIjJ3qeF7lh4p9dPBIFhY/8Gj7RZPQXH8iG50Dba4ndL7mOVKtsQHlKJZ6Px71d86t6LyvjNx1WhlHiMS4QUMs2Xk51UqIy7Phobqx3LnBox39tmqMnJ8jMlyKVUbha5KzsLgfjmpN1LKaJ2vhqlimmALvvBQ8mmhgi8ZTLspy0IvqEUUPhvr5xNBB6cikRGrlVMiUYDvAP33pddCs7ZV95pUdClAXpTne4m/BqMn/acNmYKt8D3sddmKX4lFdDZeUy6yCvkxfwnx1Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(26005)(478600001)(2906002)(186003)(53546011)(9686003)(38100700002)(966005)(66946007)(83380400001)(6506007)(41300700001)(7696005)(5660300002)(45080400002)(33656002)(52536014)(6916009)(54906003)(8936002)(7416002)(38070700005)(64756008)(122000001)(4326008)(8676002)(76116006)(66476007)(66556008)(316002)(86362001)(71200400001)(44832011)(55016003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eEZQSWVRL1M4eG9LZ21kTzhackYwNS9WVHUrVTJWQ2c1Qk0raWpvN0VwYzd0?=
 =?gb2312?B?V3JkYk1aSWpjZmcwczRBVnJFZU5nVXdFeGh3Z1ozL3REVVgyVnBnMmwyMmVi?=
 =?gb2312?B?U0MybG04VmgwMWQ4RzJzdG9YS0gzbXpKLytHWVNJNmUwa2JRSEppazdTM3dZ?=
 =?gb2312?B?cHhaZm1vRFpFRWpmLzZ1KzVKT1JNN3FRL1JrQnNralFFWVR2TnErYzdXKzJs?=
 =?gb2312?B?dm5yaU51Nm1HWVlMUnZmYS9QaldoMnBLa2RXdnNDY2dxcnZkdVRRZTFqVWtX?=
 =?gb2312?B?NGZSUGNVaFd3dlBlT3Z3akRuKzZlYzNteWp4WG1YeTkrTERwNkttK2xqWit2?=
 =?gb2312?B?aXdEbXRDYllMNkZkc1dydWFiME9WOUNQZVQ3RkdqQ1NidEJWY25tRWJ0SXJr?=
 =?gb2312?B?U1VLUDBJSHhlMUNTY1BvUWsvODJtbVR1THRMZTl1dEJOcWxUeHJUNnorWUNQ?=
 =?gb2312?B?U2xPTTg3c1NsbHIzNkw5VDRrSjVPMHlOeURBckQxQ09GUmFLQi9DTzhqZnpF?=
 =?gb2312?B?cXVqUjFqSjBwdVJrYXV6YXFIU0lGWWlRYmlXTEVHeFdkK09SRFNyWjhtTzAz?=
 =?gb2312?B?YTdMd3BVc3ZrWlRDRnJEbE5jT3RQNkpCZlM0c0xsbXRDcDZrOFJxTklLZ2ZD?=
 =?gb2312?B?WTVKWitUVWFJc0hDZTluTkF0NnBJTHA4WVVRbC92MUlxeTBucmRZbFk2Nmgy?=
 =?gb2312?B?UGdGcUhNd0tMUEI4Q0FSRTUveVFyZ3FnaS9TcDhzQUM4T0hQbnhpNHhJQ1h3?=
 =?gb2312?B?MlhKQXg3MldxZDJVRG44aktRYnprRTlyckVVSEVKSXh2eUlSSFNRRUw2dmpM?=
 =?gb2312?B?NUU5YnJ1QmV1QU9kcmlGbmJpZ3B6RGxJa3Y3aTArSEoyRG13RllZMVpFWmxX?=
 =?gb2312?B?ZW1qbWRETkE2c3VnM2FDd0x6aDk4cHpDQmVpZnhCeG5ZeE4xRlVia0hOVW5I?=
 =?gb2312?B?RHE5U1RWaXRCY0ZmUVl2bldMc3BkTmFUT05vY0Z5VnBXZERPWWdFQVhXWlJy?=
 =?gb2312?B?Z3puQjNWbXNuc3QzSWJ1WEZ2WmlkUko1SHM5RW9NUTcwdHcvZ0FkK3UvN2hh?=
 =?gb2312?B?UDBCRUdQWkZlbHZzWkFqVUlUbmhkUGhCNWI3OHVQSWJpSUF4ekJ0bncvV2J0?=
 =?gb2312?B?Q3Z1OUxiY0RFVXF0c0NuUmlHRnZUalM4c1pxKzcwdGZCVFI5SWNXbmVWM1I3?=
 =?gb2312?B?UWREbDg2cDU5bkt5YkpULzB2TG4vUHhvUU5qSGtPT1k2c08xVHJhTU9oaEdY?=
 =?gb2312?B?NExsYThwcE9mOHo4eUJHbjE4WGYzMXpZcHV2SnA4RW96K1REYk5YTnJMRzBJ?=
 =?gb2312?B?dUM5Smg4MUFJS0Q5ZzRyUDIrVjVmMU9GTzYvYTNLV2oxWGZmZ3FaM3dZNUJT?=
 =?gb2312?B?cUJGSzBCZWtGNHBYaDR5YXRRcjVTcWN1VVU3K3dNTmpuOHUrcHdrd2JLZWRK?=
 =?gb2312?B?RUtLUXBNekhpbUxVRVB2Z0x1ZjJ4ZjBUYWZXNWJpZmVBM1FSRnlwc2phQk9G?=
 =?gb2312?B?OWZod3RscUpFTDI0ODk1UzBDYTg5UnlFL2dzdEdJM2M1Nmx2N2RBaHFQRWxI?=
 =?gb2312?B?Zit2cXdXSDhvZURMKzhwZGFTMzUrVGQrR2o4eHJ2cUVWTXgyQll2dXlPZVJR?=
 =?gb2312?B?VHIzUEYyUzVTMkUyaTN5dHc4amF0MitENlpLNkxTQjdmL1JydE9sOXFRSllw?=
 =?gb2312?B?OVliNVI0aFk0dVN2VUhPRmV1alQrbC9MaDUxQ2ZaR0d0QTdIYmRxOGZOMFp4?=
 =?gb2312?B?VjdwNWFWZTlOQ29aVDdSSXVjQkI4RG9uVWthOWRORkhmZFhTQkJEbTJlODhy?=
 =?gb2312?B?NU5ZTklRVjZwcElnajNuLzVYak1MT3ZyRHBpdzVWRzRMZFMyNytDc1NyM2lT?=
 =?gb2312?B?NEJTRkxVUi9MdmhnK0NrMThyUURwR3ZYWmZCMUl1alUwckNKdCtXdVYwbnFp?=
 =?gb2312?B?NGRwdTNkZHhxTE10MlQzWFpMdmVrWnR4MmxnZGNlWlEzeHlOay8xVUgrTnNj?=
 =?gb2312?B?bjRJNmdBQy9OU2pGc0JibjlnTk5JVWVCdFJTQTA2aUZERUtURVRjRTExa21N?=
 =?gb2312?B?WmsrdVFFaWdkVUJhSTJKR2hCTWFiNm5zdVVmdmdDSksvM1RVRG55VnhDRTNI?=
 =?gb2312?Q?ydevTrtPHjEjOpReXjURhWG7S?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e96375-08cc-4843-120d-08da654f7d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 04:15:30.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSi7/6q1+VbEInq8fBvK2zBaD6IcX694uUusQ98k25WJcXQxzrLwi5kr+tqNpB9gQ0zF+jLl4F6ZZf8dvAicOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jfUwjE0yNUgMDo0Ng0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gYnJvb25pZUBr
ZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTQgMC8xN10gUENJ
OiBpbXg2OiByZWZpbmUgY29kZXMgYW5kIGFkZCB0aGUgZXJyb3INCj4gcHJvcGFnYXRpb24NCj4g
DQo+IE9uIE1vbiwgSnVsIDExLCAyMDIyIGF0IDA1OjI5OjU5UE0gLTA1MDAsIEJqb3JuIEhlbGdh
YXMgd3JvdGU6DQo+ID4gT24gRnJpLCBKdWwgMDEsIDIwMjIgYXQgMTE6MjU6MThBTSArMDgwMCwg
UmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiAuLi4NCj4gDQo+ID4gPiBCam9ybiBIZWxnYWFzICg1
KToNCj4gPiA+ICAgUENJOiBpbXg2OiBNb3ZlIGlteDZfcGNpZV9ncnBfb2Zmc2V0KCksIGlteDZf
cGNpZV9jb25maWd1cmVfdHlwZSgpDQo+ID4gPiAgICAgZWFybGllcg0KPiA+ID4gICBQQ0k6IGlt
eDY6IE1vdmUgUEhZIG1hbmFnZW1lbnQgZnVuY3Rpb25zIHRvZ2V0aGVyDQo+ID4gPiAgIFBDSTog
aW14NjogTW92ZSBpbXg2X3BjaWVfZW5hYmxlX3JlZl9jbGsoKSBlYXJsaWVyDQo+ID4gPiAgIFBD
STogaW14NjogRmFjdG9yIG91dCByZWYgY2xvY2sgZGlzYWJsZSB0byBtYXRjaCBlbmFibGUNCj4g
PiA+ICAgUENJOiBpbXg2OiBEaXNhYmxlIGNsb2NrcyBpbiByZXZlcnNlIG9yZGVyIG9mIGVuYWJs
ZQ0KPiA+ID4NCj4gPiA+IFJpY2hhcmQgWmh1ICgxMik6DQo+ID4gPiAgIFBDSTogaW14NjogTW92
ZSBpbXg2X3BjaWVfY2xrX2Rpc2FibGUoKSBlYXJsaWVyDQo+ID4gPiAgIFBDSTogaW14NjogQ29s
bGVjdCBjbG9jayBlbmFibGVzIGluIGlteDZfcGNpZV9jbGtfZW5hYmxlKCkNCj4gPiA+ICAgUENJ
OiBpbXg2OiBQcm9wYWdhdGUgLmhvc3RfaW5pdCgpIGVycm9ycyB0byBjYWxsZXINCj4gPiA+ICAg
UENJOiBpbXg2OiBEaXNhYmxlIGkuTVg2UURMIGNsb2NrIHdoZW4gZGlzYWJsaW5nIHJlZiBjbG9j
a3MNCj4gPiA+ICAgUENJOiBpbXg2OiBDYWxsIGhvc3QgaW5pdCBmdW5jdGlvbiBkaXJlY3RseSBp
biByZXN1bWUNCj4gPiA+ICAgUENJOiBpbXg2OiBUdXJuIG9mZiByZWd1bGF0b3Igd2hlbiBzeXN0
ZW0gaXMgaW4gc3VzcGVuZCBtb2RlDQo+ID4gPiAgIFBDSTogaW14NjogTW92ZSByZWd1bGF0b3Ig
ZW5hYmxlIG91dCBvZg0KPiA+ID4gICAgIGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkN
Cj4gPiA+ICAgUENJOiBpbXg2OiBNYXJrIHRoZSBsaW5rIGRvd24gYXMgbm9uLWZhdGFsIGVycm9y
DQo+ID4gPiAgIFBDSTogaW14NjogUmVkdWNlIHJlc3VtZSB0aW1lIGJ5IG9ubHkgc3RhcnRpbmcg
bGluayBpZiBpdCB3YXMgdXANCj4gPiA+ICAgICBiZWZvcmUgc3VzcGVuZA0KPiA+ID4gICBQQ0k6
IGlteDY6IERvIG5vdCBoaWRlIHBoeSBkcml2ZXIgY2FsbGJhY2tzIGFuZCByZWZpbmUgdGhlIGVy
cm9yDQo+ID4gPiAgICAgaGFuZGxpbmcNCj4gPiA+ICAgUENJOiBpbXg2OiBSZWZvcm1hdCBzdXNw
ZW5kIGNhbGxiYWNrIHRvIGtlZXAgc3ltbWV0cmljIHdpdGggcmVzdW1lDQo+ID4gPiAgIFBDSTog
aW14NjogTW92ZSB0aGUgaW14Nl9wY2llX2x0c3NtX2Rpc2FibGUoKSBlYXJsaWVyDQo+ID4gPg0K
PiA+ID4gZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDY2MQ0KPiA+ID4N
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiArKysrKysrDQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gPiA+IC0tLS0NCj4gPiA+IDEgZmlsZSBjaGFuZ2VkLCAzNTggaW5zZXJ0aW9ucygrKSwgMzAz
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gQXBwbGllZCB0byBwY2kvY3RybC9pbXg2IGZvciB2NS4y
MCwgdGhhbmtzIGEgbG90IGZvciBhbGwgeW91ciB3b3JrDQo+ID4gaGVyZSENCkhpIEJqb3JuOg0K
PiANCj4gSSB1cGRhdGVkIHRoZSBicmFuY2ggd2l0aCBMdWNhcycgYWNrcyBhbmQgd2l0aCB0aGUg
bWlub3INCj4gaW14Nl9wY2llX3N0YXJ0X2xpbmsoKSByZXR1cm4gdmFsdWUgY2hlY2sgaGUgc3Vn
Z2VzdGVkLg0KPiANClRoYW5rcyBhIGxvdCBmb3IgeW91ciBraW5kbHkgaGVscC4NCg0KPiBJIGRp
ZCBub3QgZG8gYW55dGhpbmcgYWJvdXQgdGhlIG1pc3NpbmcgSU1YOE1RIGNhc2UgaW4NCj4gaW14
Nl9wY2llX2x0c3NtX2Rpc2FibGUoKSBvciB0aGUgUEhZIGluaXQgb3IgcmVndWxhdG9yIG9yIHNo
dXRkb3duIGlzc3Vlcy4gIElmDQo+IHlvdSB3YW50IGNoYW5nZXMgdGhlcmUsIHBsZWFzZSBtYWtl
IHRoZW0gc3RhcnRpbmcgd2l0aCB0aGUNCj4gcGNpL2N0cmwvaW14NiBicmFuY2ggYW5kIEkgY2Fu
IGp1c3QgcmVwbGFjZSBpdDoNCj4gDQo+IA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXQua2Vybg0KPiBlbC5vcmcl
MkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRmhlbGdhYXMlMkZwY2kuZ2l0JTJG
Y29tDQo+IG1pdCUyRiUzRmglM0RwY2klMkZjdHJsJTJGaW14NiUyNmlkJTNEN2Q2NTJjZTk1ZTcw
JmFtcDtkYXRhPTA1DQo+ICU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3Q2QwYjNkODJk
YWUzNzQ5NWIyZjdlMDhkYTY0ZWYyYQ0KPiAzYSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVj
MzAxNjM1JTdDMCU3QzAlN0M2Mzc5MzMyNzU2MTAzDQo+IDMxMDA5JTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1DQo+IE16SWlMQ0pCVGlJNklr
MWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1aOA0KPiBncmxB
TFlxczNPTkpwMUVRSnNGSmQ4ZkQ4WGlFM3pGWEh1WWxmRTRUSSUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
PiANClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBhcmUgYXBwbGllZC4NClNob3VsZCBJIHJlLXNlbmQg
YWxsIDE3IHBhdGNoZXMgb3V0LCBvciBqdXN0IHRoZSBmb2xsb3dpbmcgZml2ZSBwYXRjaGVzPw0K
DQoxMC8xNw0KLSBSZW1vdmUgcmVndWxhdG9yX2Rpc2FibGUoKSBmcm9tIGlteDZfcGNpZV9zaHV0
ZG93bigpIGFuZCB1cGRhdGUgdGhlIGNvbW1pdA0KICBsb2cgYWNjb3JkaW5nbHkgcmVmZXIgdG8g
THVjYXMnIGNvbW1lbnRzLg0KMTEvMTcNCi0gTW92ZSB0aGUgcmVndWxhdG9yIGVuYWJsZSBiZWZv
cmUgdGhlIFBIWSBpbml0IGFuZCBjb3JlIHJlc2V0IGFzc2VydCB0bw0KICBhdm9pZCBpbnRyb2R1
Y2luZyBtb3JlIGZhaWx1cmUgY2xlYW51cCBwYXRocyByZWZlciB0byBMdWNhcycgY29tbWVudHMu
DQoxNC8xNyBoYXMgdGhlIGNvZGVzIGNvbmZsaWN0aW9ucy4NCi0gUmViYXNlIHRoZSAxNC8xNyBw
YXRjaCBiZWNhdXNlIG9mIHRoZSBjb2RlcyBjb25mbGljdGlvbnMgaW50cm9kdWNlZCBieQ0KICBw
cmV2aW91cyAxMS8xNyBuZXcgY2hhbmdlcy4NCjE2LzE3DQotIEFkZCB0aGUgbWlzc2luZyB0aGUg
SU1YOE1RIGNhc2UgYW5kIGRyb3AgdGhlIGRlZmF1bHQgY2FzZSBpbg0KICBpbXg2X3BjaWVfbHRz
c21fZGlzYWJsZSgpIHJlZmVyIHRvIEx1Y2FzJyBjb21tZW50cy4NCjE3LzE3DQotIFJlYmFzZSB0
aGUgY29kZXMgYW5kIHJlc29sdmUgdGhlIGNvZGVzIGNvbmZsaWN0aW9ucyBpbnRyb2R1Y2VkIGJ5
DQogIHByZXZpb3VzIDExLzE3IG5ldyBjaGFuZ2VzLg0KLSBDb3JyZWN0IG9uZSBmYWlsdXJlIGNs
ZWFudXAgaW4gaW14Nl9wY2llX2hvc3RfaW5pdCgpLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQg
Wmh1DQoNCj4gQmpvcm4NCg==
