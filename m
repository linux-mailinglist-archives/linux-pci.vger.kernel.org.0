Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4836C6196
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 09:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCWIYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCWIY2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 04:24:28 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19396305F1;
        Thu, 23 Mar 2023 01:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN8D+PfCn9fHvJpwRFQkJVIbTC+VZOXeaNheonugqlsFY8OOMer622hsoEY+KCy7pnIXLHXk6tRungW+lNhnT8jWR5q3FfoGVYG1IG02Hh4MANVYZggG1hVCnztOKHxeLeJyjspmADHJJscz+KpKGtbw8s1kdzeUWdP4eCxPMAZG6JY0LGKVwNMY4MWGlhrbAMZPruEMRWrLMdONqEPuo8uWg5/98Pup0TlhSIYSH7A+A2yAd8LABO51LTrNl+J2kvIMCx0x0/P0DqeuR2YixEjqXAxyTJNfVT53Iy6bqsEZzgg2rQduGG772hKQKoy7BtLXLl1eKf+PB9UgK4D3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuZM8qQaPGLatmtB5k6A7/DH8IdcN7r/LnGmdouPQVM=;
 b=ibBh8uOxJ9SznJM3Eebi05hGs8G7AOUnsASNUu/7CjbcSFdfpV8EpWBDJFYzV27hHcU/q1bQbc6DkV+QYj+CD9NwOVVyjlEjsANGIJ/IRNI2opRe/vHyWVmIXKS3O9cf6naJTJph+V7aT7YTDRofxDGvSt6hc4LI5U1EWxOcf6vXaXRCjQcVPI/0Fb77pJ6Twp3HYMjJlKz5dOrn4DLIwXgBAOWMXcsDcK6rUYOWI0jp//lDcQP+gMuPoS9GaMeFiaKf/mnkGYuaQMQIZe0fQRPA3XmXAyvtnvJdNpS0B5vTKpobkMWW/xK6NJJmcfHfPHBrRmEnTKLydZEBSXJrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuZM8qQaPGLatmtB5k6A7/DH8IdcN7r/LnGmdouPQVM=;
 b=TdHFE4/kqSYxCSF2Cb9ITb3E5RaidTXIpDuzsKABM1sJcAolOg7zGkKnCtxvj9himqECn1hcCWF18+phsVftSMBqAEK2gAbGe00yUv4TXicXzLmUVQOeZ/eAoMH3RniFQYNtddPnYe0iKxcvfox/sl/6AfWsziAhmPi1UNoT9fE=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DUZPR04MB9821.eurprd04.prod.outlook.com (2603:10a6:10:4b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:24:22 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a6f5:af13:52e6:b3b]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a6f5:af13:52e6:b3b%6]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 08:24:22 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] PCI: imx6: Use
 devm_platform_get_and_ioremap_resource()
Thread-Topic: [PATCH -next] PCI: imx6: Use
 devm_platform_get_and_ioremap_resource()
Thread-Index: AQHZXVuDz/Me5IsvZ0WtGEOnKrZwIa8IBeKQ
Date:   Thu, 23 Mar 2023 08:24:22 +0000
Message-ID: <AS8PR04MB86768249326301DE16AB36B08C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20230323074553.90372-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230323074553.90372-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DUZPR04MB9821:EE_
x-ms-office365-filtering-correlation-id: c685f0c8-aa4d-4ee6-d593-08db2b78016c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+0LdsPEbouHwDJGGhQ6mBxqlmZw3/JKRpeSMEX8u79cfvMJ7Dq3vObBWj/bMxxnd6w6wxIy/rDJjfDrpZMVVoWbx9rHZIvE1NEe09b7d7UDZpTU6N/5Z0Ngy8XcLkeh41U20slm9ujTonln0jyApTFzxv5W4cQTGpkkzzCxVi6G2dr9Nxe60NP18WFBRhCoTk62WZJPQdtpAmxRaAG2n6+dFiZgaB0nPNN8HVACTyM++gymTrQE3UszMkHmUsouPLzov3al06hpRozp1iiITiXevrC94oBaLHx++P7H6wr0jQpOFGXNVq9LCf6wtjgSHx9fCM9Zi8wc9YJe/0y+/cJ3F0mde4iQVDk17nSU5tQzmCk3DDJf/hAAQNX6gFFvS9qSrdkps2Dl+bfYLJ1w0/Ah7Lq78EkingegVCSDwtSOdwuXP5L73QThtgaNoe0aGldCmpCXOxhiLBTVVFA1D8Fuv1a+h3Rtk2vO5fWYMDCv9Cz6VymWgJOto7sXYGFJhOG7ZWbpFRqlq3llWLCGqTvxGsotIZPAiOM9/b9Yop/hz45H3SEGFOSXH+M7G4pCpQU8ZmI+rAFd6IZcYDXpvu6USYg3HBUnKgXSHxHInuXl/Y8ouBr5n3sb3Nz4H242TtY0ZHWpvrWhtLmsbv/FSg5MzfY4va/eqWChgCqPld4CluoWVBFvuQoN/TN/HT5CuZ4DDtgriN5B1ZuvNvlZ5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199018)(55016003)(38100700002)(2906002)(38070700005)(71200400001)(478600001)(83380400001)(7696005)(186003)(9686003)(86362001)(33656002)(54906003)(316002)(66476007)(8676002)(66946007)(66556008)(64756008)(66446008)(4326008)(6916009)(76116006)(44832011)(52536014)(8936002)(53546011)(6506007)(26005)(122000001)(7416002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b0N5aGJDaTdPVytRMzZJbXJBbVJoZVY2dWRLajJoZlYrREwxRjJ2STlUVmhs?=
 =?gb2312?B?VGwyYnFwNEMxY1g1ekgvVXJjUWphVUhWMnk2cDdYc2NhVFAzK3ZXSE40aWY1?=
 =?gb2312?B?eUE1d2k4b3BGektXcWZKUTcwV1RZblZQR0h0aEtQUXRJcmpIRWxoeWFiOVho?=
 =?gb2312?B?K2NmWi94NUFYTkZwTm00MSt3N3ZZK0V0dUhJVVQ4bU1Sc0oreFROWXhwSTIx?=
 =?gb2312?B?d21iV0ZZV3dtMFdFRE10NU93RlVaUWJsOVB0SjUxODl4Q1UzcTJSUEMzam93?=
 =?gb2312?B?THJjakVrT21jekJqdW5lRXB5ektKSlR4NmFUSW16RktBUm1ERURpbXorL2R1?=
 =?gb2312?B?ZzN4cFNLOUgxdXgwbTVWUFBQbWo1S1h6Si9yZjU1eExtTzAzT2tpL2dQTzBC?=
 =?gb2312?B?NkRZdWpmeDd0aTBacVB0WlJEdlJLVWc0OFJYa2tqZ3p4dWpNVTFoaFhmZkVC?=
 =?gb2312?B?bmwzY2pQQ2VDUGxFU3pDUTFpRzVmV0xZN0o4cnFsMkc1Uk9CU200dUhzOFVj?=
 =?gb2312?B?azd4RmFzSmJiMXcrN2x5RXBvWVNiR2JKVEg0RUNDM0RnQWtValJjaUs1WEV4?=
 =?gb2312?B?RGN4UDZ1MWNMeEorT1lUOExLaDE0OHUxSUNSdURvUnJXQ21IeS8vMXBoTFN5?=
 =?gb2312?B?aEJIZjBuUExXOU5vdGx0ajJDUGtKV0ducXJicHlSV2pHTFl5aU1TS05FSmta?=
 =?gb2312?B?S2tSZjR1cmszZXR1d1h6U0NFOENaMGdNbHpWeGVURWk5Qys0WHhiTlFWNmxP?=
 =?gb2312?B?RFphNjhlbzk0SFI5UWdJM1NYQTVMQUlnRlNXVGtaV0gwTEVTaTEySUxTckxI?=
 =?gb2312?B?aFZqWWNDcUF0SnpRczhqQjNaRHVPZmZ6UGZiQXV6SzhsMmkzL0JVdVBVSFNK?=
 =?gb2312?B?YlJtYi9aSlF4STllWHJrSTV5K3hVc1BUb1k1RENLbGFxcEhWYmhpb1ZrRlI4?=
 =?gb2312?B?WjFraDBxc2toU1lpYWJTQ09yampXeGtyUklOVjk1Q21rVWJLb213WjV2Mkh0?=
 =?gb2312?B?OUV3aFROYjNyQlVIaVZGSEtjRnFJb0tubHg5ZE81VEQ0M1NreE80bmVaQ3Vh?=
 =?gb2312?B?elFYbUlJMzdnWmlrMmhkeEgySFlaSlEwNkNDVHppRUN2NWdXNXZCSEJ4eTRX?=
 =?gb2312?B?Z01NdXFvcUo3dmhsTWZDUytXTFZNNEpxeE9iMFJqSXhXVEt4MUxFSWt5WC9w?=
 =?gb2312?B?Q2Zwc2hUY0tJOTRUUnVtNlBtTHAwekg5UW5kS2hld0g5MGZhZ0RObDBJQkVF?=
 =?gb2312?B?amgzWnlCMlNDRFNnQlNJdzRnVGZxdHZhektmSnpVbU9JOHZ4NnVKU2svZlln?=
 =?gb2312?B?SkZlbzB6VS9LL0NDUXRBejN2ZFp5TnJlbmNna0NCV3FRTnhHOXQ0RXFKU2tP?=
 =?gb2312?B?RDliV2dGN0JuWkZEN1RYZ21ySGlwTVRjMVVXZFNvWkJJVExIQ2wrK21NUXIx?=
 =?gb2312?B?VkFCdHNKNDd0R3VZNy9ueHR0WlFzYWtxOTEzbUo4TjFaUGNNbjVXU1ZqMTM3?=
 =?gb2312?B?Z0c0aFZpeEZKbFRQMXJGbUFpTlczME5YL3Y0OWlvRnN4VHpaRUZPT0puUHly?=
 =?gb2312?B?RUIrZGJ3bS9POUoxYVA3d1gxWFI4T0JnejhMMUcxcmxiWUUvaW5KZUVnTHFv?=
 =?gb2312?B?ck5lSUV2V1BKWDBUdjdxNzJNSTNlRXMwRnYyQnhhVVN4ZktYUU1nc1I3d1N4?=
 =?gb2312?B?cjJlTUhERFRmK01rU1hnQkxuREZFUzJma3Exd0UzZUJiNnRWMFFVRkphTWQz?=
 =?gb2312?B?MEZlQ2RiTVArV2xxRzMxNG9KajZHemtTQkVUYm8wdmsya2hPZU0wMHJNSWJN?=
 =?gb2312?B?cFlOZjIyMDFFa2dSUDk5VzQydk0rMjA3bzlLZDJYdzNvZmhYSGRJUnBEcVQ3?=
 =?gb2312?B?blZiamJ5V3QzSkk1ZDVMRkdYUCtscVp4cVZKbkY0cXp5QWlRV3NoWnNtZjQ5?=
 =?gb2312?B?aDhrSlpTVThzTDdBSnVZSlAwcE9scTJ6Znd4WEs5T2ozVjFFb3NWTkpMc0hq?=
 =?gb2312?B?NHZMczhaamZhY1kxcU1Nd3dIVzlyN2NqZnAveEFkNDFHVWpJRWhqaktrT3oy?=
 =?gb2312?B?aHVkMGNlSXhFRXVCYWwxOVgvSDh0UEVmS1ZKUHg3NlVKMTJDQi9aVnlWdElC?=
 =?gb2312?Q?2GhW+wqz8SRgumHOya4mbEzBG?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c685f0c8-aa4d-4ee6-d593-08db2b78016c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:24:22.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KzUnL8VsEbs6qUVEyQsBFZ29onl0NOpX0f7LNpA5/ofmG/ucsgvjSZq7a17ysis2j/yNM1RnTA2GsTYMTWjeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9821
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZYW5nIExpIDx5YW5nLmxlZUBs
aW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogMjAyM8TqM9TCMjPI1SAxNTo0Ng0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGxw
aWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxn
YWFzQGdvb2dsZS5jb207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgWWFuZyBMaSA8eWFuZy5sZWVAbGludXguYWxpYmFiYS5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SCAtbmV4dF0gUENJOiBpbXg2OiBVc2UNCj4gZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBf
cmVzb3VyY2UoKQ0KPiANCj4gQWNjb3JkaW5nIHRvIGNvbW1pdCA4OTBjYzM5YTg3OTkgKCJkcml2
ZXJzOiBwcm92aWRlDQo+IGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCki
KSwgY29udmVydCBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UoKSwNCj4gZGV2bV9pb3JlbWFwX3Jlc291
cmNlKCkgdG8gYSBzaW5nbGUgY2FsbCB0bw0KPiBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1h
cF9yZXNvdXJjZSgpLCBhcyB0aGlzIGlzIGV4YWN0bHkgd2hhdCB0aGlzIGZ1bmN0aW9uDQo+IGRv
ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIExpIDx5YW5nLmxlZUBsaW51eC5hbGliYWJh
LmNvbT4NClRoYW5rcy4NClJldmlld2VkLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54
cC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiAtLS0NCj4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAzICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGluZGV4IDU1YTA0MDViOTIxZC4uYzYxYzg1ZTA5YzRiIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ICsr
KyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gQEAgLTEyNTksOCAr
MTI1OSw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UNCj4gKnBkZXYpDQo+ICAJCQlyZXR1cm4gUFRSX0VSUihpbXg2X3BjaWUtPnBoeV9iYXNlKTsN
Cj4gIAl9DQo+IA0KPiAtCWRiaV9iYXNlID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElP
UkVTT1VSQ0VfTUVNLCAwKTsNCj4gLQlwY2ktPmRiaV9iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291
cmNlKGRldiwgZGJpX2Jhc2UpOw0KPiArCXBjaS0+ZGJpX2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2dl
dF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLA0KPiArJmRiaV9iYXNlKTsNCj4gIAlpZiAo
SVNfRVJSKHBjaS0+ZGJpX2Jhc2UpKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihwY2ktPmRiaV9iYXNl
KTsNCj4gDQo+IC0tDQo+IDIuMjAuMS43LmcxNTMxNDRjDQoNCg==
