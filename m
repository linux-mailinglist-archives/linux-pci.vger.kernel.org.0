Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11524CF374
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 09:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiCGIUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 03:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiCGIUu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 03:20:50 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048DD62114;
        Mon,  7 Mar 2022 00:19:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDyk2Bzfan1JuSbXgs6i7t/Sg/85lTtT6HWsunZ1qnU+6d3HAbHZhMF+BK3ib4xJBTWa1MBimK+BohyeG08VUgi4dJvGUh0jCEpwTIAreInbPQdLjeNny/hONVp9yAS0rKy+AD2rxQZQT4u5s7rHsxXRynW20yFWHWKhoqxUSPshSqh03J6Pjm0Ob8DhKNYlxgVYpYB9HOtsXIlVIlr9pbytf1hxwYE6YCp8N4cPnR/rdyGAZjDiCgLsnbUTBE05zv+O4rlj4/5pq3RZcVy8FEVw+qbJ969YtTn35i8RmpOx7u1bC8yI7cjY3xPrlMY1Mt4xBtZgvr0FiDllNxQYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isUqIRXR050WFpGxorVt+qv5KpBEpf+VnqVTTaHU9hQ=;
 b=QMhCCE6bj9vZzhYc/4uWPYfewZlD2lwQ7n/+w1InD0rFBXZFEBDxsLz91UAjEZC0f4J959d3jzoAkoATUrzNeXW49qYeJIa9Z0OJ2qDfTj4f5V97I4/33cOEH9odvs5sqqMLea0ii1O+FC+QKdXf1GetYogEehY11p3lEJwCMz4NC48JcWO4LDUslEZR/x8/gigMuBaXmOFigdj1vAne7vSHVquP+DHupvqKYrzlLHhUf4AVMxwGHN5SXLb6x7LiZApDvDHyhPMr7y+ERgC4ued15/yR1rS7lz8bRSy6LmwepeEHWGFfEFvG2WVSuq7gmuvw+80kSXPSPj37AhBKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isUqIRXR050WFpGxorVt+qv5KpBEpf+VnqVTTaHU9hQ=;
 b=NYJwOfSKGjKoAgWA4YiEElnOQz6Xh5IkJtLve0tUahZ+Rzrdy9o/jTql1S3YU9mIEzIZPzGfy8Ks2aBgbWm1cLgZkmF0sh/JQ1YNp74RjIn3m6eaj+FmMON9dvZ9bApG51T/3X6mDrmuFLwlkRR0/L9ymeyWBVgc6VKWRKLE314=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB7831.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 08:19:52 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%8]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 08:19:52 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: (EXT) [PATCH v1 4/7] dt-bindings: imx6q-pcie: Add iMX8MP PCIe
 compatible string
Thread-Topic: (EXT) [PATCH v1 4/7] dt-bindings: imx6q-pcie: Add iMX8MP PCIe
 compatible string
Thread-Index: AQHYMe3vPeeuNBAhAUGzu2iza7Hki6yzj6gAgAAAO6A=
Date:   Mon, 7 Mar 2022 08:19:52 +0000
Message-ID: <AS8PR04MB8676905699E85011E625BFE68C089@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646634556-23779-1-git-send-email-hongxing.zhu@nxp.com>
 <1646634556-23779-5-git-send-email-hongxing.zhu@nxp.com>
 <11939148.O9o76ZdvQC@steina-w>
In-Reply-To: <11939148.O9o76ZdvQC@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d78db1cd-f918-47ec-ee7d-08da0013415f
x-ms-traffictypediagnostic: AS8PR04MB7831:EE_
x-microsoft-antispam-prvs: <AS8PR04MB783162837BFB71D7E788D8D88C089@AS8PR04MB7831.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: efhCut369onzauYxu4PpZvw7w4zZuvlucZG+dyb4K8ndnYaxjCh/8cu2IFJqzPM4cEcCKCq17563zZ4tUiErWBwHSdTqKibgW5GNACpeMVVIFpTMsznJeIE5rIjJtmkVRKqAbFu3NrPKN+ADNYA4oYOERYbHtwyerc2Fy8yBtS5ioGgVKZg+8aao/O2NFBpoDWXrBkJ3VXghTvkdk3ZDsgvVoXsED1UuCvLDf7EwSe9wO2CLR6V9Xi5NtZKWKyoXI4gVXDR1jJIimA8UxbOsUxEm/jSrT9SIRgkeenTt2rnPgC7Yq7j9Tv4oGjtV/oiysnS8vlC5VLXswhu9SuCDdUyehP6XadhXdOiKXHatn+r8/jtk7M5C7TAETvcWEmMR8Gr8X/u52tSUurNMLAkanlVQ+H21NeO5OErfz8dF8GCLEby82/eTyPW9+pWZ8BvceEiaF9X5SyCWhsk9O2CbBxNi8YIJ3jVi0/+TQSZFhrwzssZ5BxjsThh2S1G/Ry5kTphd9o0Zf0xD6W07UAnmRqSPYx4prxyz0PnTaK39QaloLu9auLY6tJF6eIQsdH8FrK1mWzir1MJ+ySN0IabJhqFpEaAmE7gEwrV4G/j3tpwQb6a0dEsbwsHoSl+pxqnC4gqCwSG8bK2/ELPk0DVIKvrAixwM6Qx7psSF5ETKfw2NkNlpg7WRztKtzEptaKXMmNpvbxpH4giKzr3pFkx06LLqgcgI+qFGiQymIscDNxTMJlUfqqCYitAXfqR2fAhWUIwroK1yf+2zkA5frEjg9Mc/lJaUU2lab9kqme0LNSGglAailfwPN/MSvdyuc7GiVouib0iAiznpOp+IeII3Pzh9fqcolwC533UWBmeKDqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(71200400001)(8936002)(52536014)(33656002)(4326008)(8676002)(2906002)(66556008)(64756008)(66446008)(66476007)(5660300002)(76116006)(83380400001)(7416002)(86362001)(55016003)(508600001)(38100700002)(316002)(9686003)(122000001)(6506007)(186003)(7696005)(26005)(54906003)(38070700005)(44832011)(6916009)(53546011)(66946007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1NjVnNTeWdJb0FnR2czR3VHanc5a1dqUjhPazlueHUzL2U4WUF0NnI1TGxv?=
 =?utf-8?B?MnhaSFE1WXpKN0tmS0dodmJ6T2VKZ3NPSDVnNHNqK0QvS0hHWVcxOXZGUk9V?=
 =?utf-8?B?SGovMmdxQVJNNEZLV2FhRDBwenV0OG9kai9VRVdQWDhoNkF0ZlRFZEhZZEY2?=
 =?utf-8?B?Kzg3ZkIyTDZTMHpEU3MwSGNFbFNoNGxDUXRTZ1JhRWJuZXIwZEhsYnc2dWlt?=
 =?utf-8?B?RVhsOWZBL3B4N2Z6NUVrOHVVd3ZNaTVvRnRNY2xyLzFBSTRzay9kYkhxQXNY?=
 =?utf-8?B?RGJNeXVnQ2lBaHVGRGFjSHQ2TVhHcjUrbm4vMktrMXhzdGJLa0ZodHNtTEhv?=
 =?utf-8?B?RlVTYit6S0FqTmo3a2FLc21DZ0xwN3h4dUF1NEhJTWhHa3lORXcvRmFHeU5O?=
 =?utf-8?B?MkVBZWM0dUNvcWJpNGNwZmYrdDdQZ3B2cmxMR3B4TWpTL2g1d2dqR056YXNV?=
 =?utf-8?B?LzVkT3pkaXc2ZFpHcCtEWE1yWnBlbmRZZm9BdnEyRkZiYUw4OTNIUHFPSzEx?=
 =?utf-8?B?Z0hOOHlaTWRjTUI3NXgxMXNwampqWFk2RHRPQVR3TFhqQXdKd2FkOVRBb1NU?=
 =?utf-8?B?d3laNFJXR0QxNW9rbVQ2RDRDUnZKazJPaHlHcVR4NUVOb0psZGl1L2gvWDhV?=
 =?utf-8?B?SlVSc3d4Nzc1aWZtUTVyNk5Kd3dKbDMwdmpWTnpyT1NvSDNxV1FBTTVIOHRM?=
 =?utf-8?B?N2QrS0NXZmxJZmlZU1k3cmNYZXpibVdRa1VycUNabERrU284YkVGQWRySWpY?=
 =?utf-8?B?anhYWFQxZE5kUkg5eGUrY3lXRlI5SjgwZ2kxZFJkbDZwNGdNZzZCVk1kUlpU?=
 =?utf-8?B?QXdUMHZHNVFXTjhxQVhvTXlzcXZJS202WkZkazYvK0xCYnVKcUVlYmluZ3li?=
 =?utf-8?B?RWlXTWNIZlczMGc3MCswYjB4R1hSaTF0b21QTGdmTnVuUmdGZzg3clA2bDZ1?=
 =?utf-8?B?UnBqdDIyOXZIdDR5TExpeE83b3B5YkR3NHlRT3NnbHNUbmJzS3h2OVVwbVNh?=
 =?utf-8?B?SUE2bC9CTUVwMytxS1lGWVo4MTBkbVBoalJ6SjZvZUFYUm9Wc1pHTjlUNmtm?=
 =?utf-8?B?MktGS2t5TElYYUtjSUhPNDcvSEN1WWREa3Z3a21sc3JRb2x4M3lNbHpDdjY1?=
 =?utf-8?B?dmh1SW5OdWlqN2Z6TStyNVppcnRBUkJFL3RXVE9XU0w1QXgyRFJjWkk3S1JP?=
 =?utf-8?B?VGhBTlh2SnBqQmdzUVAyU2RVbnhKUXBVWVJlSk9MMkt4WkhyTXppV2tjVHhM?=
 =?utf-8?B?UlZ2aWorRlFKRnQxQzlRQnZ4NExQdzlMY0EzaHJQZ1A1ZnhNSWFJTlJ3Q0po?=
 =?utf-8?B?V2U2M1I4SWIyOFpLdjhXVEx6UXJEQXZUazd1UitFdUhlMUpqMFB3bmxGazA2?=
 =?utf-8?B?K1NwRmFwR3lURDZvYjNrWjJNSlVxdWE4RWhRVjQ3T2o1UkVESmJTbUZuU3hW?=
 =?utf-8?B?VnEzUmxBYXhBekhSRVlLRlkySHp5S09nZThMQkE4bFg1NjdPK2ZuM1Y5c202?=
 =?utf-8?B?NUIwV0Y2dlJCMmdoSngwWmxlczVJOXlxMXpUZkxTWVZHSm1JcXFyUTRuekVB?=
 =?utf-8?B?MUlWZGZrallDWjdKOEE2ay83RzdzSHA2eE1SNEZUV0pWTFRnM0VDNHozL3lj?=
 =?utf-8?B?OGVIc3UzL0lpS2FnYmpubThLRitwTVRwMTNqSkZSRHdJck8yRzR3cFJpWkxC?=
 =?utf-8?B?eE5QRmkzd0hPZFpvb2RraUdtUEptYzFrYmRQS1pwOU9nTnBaeDBtczczUmN0?=
 =?utf-8?B?N1FiSElaUW9VL1lUd0kzdmVNWWMxaUp4RXUwNm9TRmp1MHpkU0ZPbkhFWWRZ?=
 =?utf-8?B?bHRaYXVQZ2w2NVJ0K05WMUZFdURxems4YStjd0lJSE1hbWFiY0VaWEhrVjRI?=
 =?utf-8?B?VzFrNjloQ2tWeE9MTWJoUFMxNEhjYitUbU14aWl0MlRFaExYR1g4WXl6aFNT?=
 =?utf-8?B?c05QVncydGVZVlVxVTlucW95UUJZVFgwWFRLV1dGSlZHNFh2Szl0elcwT2FC?=
 =?utf-8?B?eHVwNG1naCtSRFhBajFWMzVGeStzM1VvRk9meTRaTnVxT2NKZnFrOFJnTHZ4?=
 =?utf-8?B?R3V3MVV3MEJ0SGdIcG55UkxMTG1pTnBJMDB0VE1SUldpNXdRaklJcU5jQ1BR?=
 =?utf-8?B?SEdiK1JpekVwMmREMDJtNUFaNmdaYWpSK2NaMXl5YkxDZnp6OERDZ3dDL21D?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78db1cd-f918-47ec-ee7d-08da0013415f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 08:19:52.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gwVMVVcVosHKeASbEC4pxOIgCqAb67xjFOHVTtXXKAnBbZXTRmwxxn+yL3nfAFvjYv6EumfnS0E6pcsJ99wlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgU3RlaW4gPGFs
ZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb20+DQo+IFNlbnQ6IDIwMjLlubQz5pyIN+aXpSAx
NjowMw0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHAu
emFiZWxAcGVuZ3V0cm9uaXguZGU7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdv
b2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJvYmhAa2VybmVsLm9yZzsg
c2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0K
PiA8bGludXgtaW14QG54cC5jb20+OyBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29t
Pg0KPiBTdWJqZWN0OiBSZTogKEVYVCkgW1BBVENIIHYxIDQvN10gZHQtYmluZGluZ3M6IGlteDZx
LXBjaWU6IEFkZCBpTVg4TVAgUENJZQ0KPiBjb21wYXRpYmxlIHN0cmluZw0KPiANCj4gSGkgUmlj
aGFyZCwNCj4gDQo+IHRoYW5rcyBmb3IgcHJvdmlkaW5nIGEgcGF0Y2ggc3VwcG9ydGluZyBQQ2ll
IG9uIGlNWDhNUC4NCj4gDQo+IEFtIE1vbnRhZywgNy4gTcOkcnogMjAyMiwgMDc6Mjk6MTMgQ0VU
IHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gQWRkIGkuTVg4TVAgUENJZSBjb21wYXRpYmxlIHN0
cmluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9mc2wsaW14NnEtcGNpZS55YW1sIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sIGluZGV4DQo+ID4gMzZj
OGEwNmQxN2EwLi4yNTJlNWI3MmFlZTAgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+
ID4gQEAgLTI2LDYgKzI2LDcgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgLSBmc2wsaW14N2Qt
cGNpZQ0KPiA+ICAgICAgICAtIGZzbCxpbXg4bXEtcGNpZQ0KPiA+ICAgICAgICAtIGZzbCxpbXg4
bW0tcGNpZQ0KPiA+ICsgICAgICAtIGZzbCxpbXg4bXAtcGNpZQ0KPiA+DQo+ID4gICAgcmVnOg0K
PiA+ICAgICAgaXRlbXM6DQo+IA0KPiBXaGljaCBicmFuY2ggaXMgdGhpcyBiYXNlZCBvbj8gSSBk
b24ndCBoYXZlICdmc2wsaW14OG1tLXBjaWUnIGVudHJ5IGluIG15IHRyZWUuDQo+IEFub3RoZXIg
cGF0Y2ggNyBhbHNvIGRvZXNuJ3QgYXBwbHkgY2xlYW5seS4NCj4gDQpIaSBBbGV4YW5kZXI6DQpU
aGFua3MgZm9yIHlvdXIgcXVpY2sgcmVwbHkuDQpJbiB0aGUgcGFzdCBkYXlzLCBJIGhhZCBzdW1t
aXQgc29tZSBwYXRjaGVzLCBhbmQgd2FpdCBmb3IgYWNrIG9yIHJldmlld2VkIHRhZ3MuDQpCdXQg
dGhleSBtaWdodCBoYXZlIHNvbWUgY29uZmxpY3Rpb25zIHdoZW4gZG8gdGhlIGNvZGVzIG1lcmdl
Lg0KSSdtIHdhaXRpbmcgZm9yIHRoZSBhY2ssIGFuZCB3aWxsIHJlLWJhc2UgdGhlbSBpbiBhIHBy
b3BlciBzZXF1ZW5jZSBsYXRlci4NCg0KQWJvdXQgdGhlICM0IHBhdGNoIGFwcGx5LCBpdCdzIGJl
dHRlciB0byBwaWNrIHRoZSBmb2xsb3dpbmcgY29tbWl0LCBzaW5jZSBpdCBoYWQNCiBMdWNhcycg
UmV2aWV3ZWQtYnkgdGFnLCBhbmQgd2FpdCBmb3IgbWVyZ2UuDQpodHRwczovL3BhdGNod29yay5v
emxhYnMub3JnL3Byb2plY3QvbGludXgtcGNpL3BhdGNoLzE2NDYyOTM4MDUtMTgyNDgtMS1naXQt
c2VuZC1lbWFpbC1ob25neGluZy56aHVAbnhwLmNvbS8NCg0KQWJvdXQgdGhlICM3IHBhdGNoLCBJ
IGRvIHRoZSBjaGFuZ2VzIGJhc2VkIG9uIHRoZSBmb2xsb3dpbmcgcGF0Y2gtc2V0Lg0KaHR0cHM6
Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9jb3Zlci8xNjQ1NzYwNjY3
LTEwNTEwLTEtZ2l0LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1QG54cC5jb20vDQoNCkkgd291bGQg
YWRkIHRoZSBkZXBlbmRlbmN5IHBhdGNoLXNldCBsYXRlciBpbiB0aGUgY292ZXItbGV0dGVyIGxh
dGVyLg0KU29ycnkgdG8gYnJpbmcgaW4tY29udmVuaWVuY3kgdG8geW91Lg0KDQpCVFcsIElmIHlv
dSB3YW50IHRvIHRlc3RzIFBDSWUgb24gaS5NWDhNTSBFVksgYm9hcmQgdG9vLCB0aGUgZm9sbG93
aW5nIGR0cw0KY2hhbmdlcyBzaG91bGQgYmUgY2hlcnJ5LXBpY2tlZCBmcm9tIFNoYXduJ3MgZ2l0
Lg0KYjRkMzZjMTBiZjE3IGFybTY0OiBkdHM6IGlteDhtbS1ldms6IEFkZCB0aGUgcGNpZSBzdXBw
b3J0IG9uIGlteDhtbSBldmsgYm9hcmQNCmFhZWJhNmE4ZTIyNiBhcm02NDogZHRzOiBpbXg4bW06
IEFkZCB0aGUgcGNpZSBzdXBwb3J0DQpjZmM1MDc4NDMyY2EgYXJtNjQ6IGR0czogaW14OG1tOiBB
ZGQgdGhlIHBjaWUgcGh5IHN1cHBvcnQNCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+
IFJlZ2FyZHMNCj4gQWxleGFuZGVyDQo+IA0KDQo=
