Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA65445E6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiFIIbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241196AbiFIIaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 04:30:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746FB17ED00;
        Thu,  9 Jun 2022 01:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY/+rO+DAkRlR68iLczDIZeIdh0dyOTYP7HihE5ZMHLoMRxv60ya1+Jp9Ur7TqARnHYrCIeyCPGu98qSE/nxGQB/Ep0UFM1BLn4ro146bnRyu3nz+pM3eJJwK3gyg7X88W0Sj4Te1xczCNOAQifWQ3HFm/ByTvH4uohbvUkLhQsdGdSMpzaGNd5ouIlYBvxUUCvFq1b0R/NZFFngSnJlComuIAd1vDU8InNvcoT6p1diX8dtkOuYdwp4C8L61nGt4PQcxOMcUmX0pmxtJuJTtyWSgZjhrsPxVf4UTmbTrX6SJkzzOYnMrFHsCIkGOf8cs6NTkwQ4zT5A4yqWrnILjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvM+EeenWE/n58tWHa+9YZMICBmCsTn1Af0lRvjRsKg=;
 b=Sybj7aDzkxo1lB9y1LmbCwrvlQoNUS2LsEh23yCQbAg4WLJ0DSnHinCWfDoxc3jKbj8tB4Nbypv7NW62nDgLHj6Nr105cwnWO4jsOWL9WueF9leFzOGflYzNIJa0YP7Eq9z8/6IMnyVbIew889wfAk1jD+Tm9qxXyD/uGVzy+X0vseJl4DITadRDaqSe58uzxMcSPjN8qrs/xuXO7qovmUNbjxOTRnqG0n60viBaXugLXEUKG02Z3ex+MNWju4gyKcGM86PzUHztv3Pyt8cZ7Libb3VCp6TmrgCDUsfMSjWfr4Z1+WLXSqtvF7A/X24tTVJNjOJtVGx2b4Fi/yiHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvM+EeenWE/n58tWHa+9YZMICBmCsTn1Af0lRvjRsKg=;
 b=n1fEXqrfmDy40nlYRtnxxtRjn76e104x+nqU7KBGUM93n9BEaSSDJ6wdIH9RMYCKU7GyTKVtWvjfcsfu2Xhyq/Mdx7gBP4vl7hS8vJd8m5PKG4QNJ4ZynwR172eOQ9o5n6258m2XKuXeveLQ0oxmhncL7UsPjm9Eus8iVjZ0fWs=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 08:30:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 08:30:25 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after
 link is down
Thread-Topic: [PATCH v9 6/8] PCI: imx6: Disable clocks and regulators after
 link is down
Thread-Index: AQHYYOzgdcPKaCfHJE+sY2pPsqwsuK1FUrsAgAF0kuCAACNYgIAAAdEw
Date:   Thu, 9 Jun 2022 08:30:25 +0000
Message-ID: <AS8PR04MB867602DC67F2DE8B021AAA818CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-7-git-send-email-hongxing.zhu@nxp.com>
         <5be4f4322e00e33fa9417280b0d74ecb7aab913e.camel@pengutronix.de>
         <AS8PR04MB86763AE6FF5BABE3EBED833B8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <e496d9d52064d25a8a0ce3c6aa1debfc134b8147.camel@pengutronix.de>
In-Reply-To: <e496d9d52064d25a8a0ce3c6aa1debfc134b8147.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73212581-9572-4e8c-28e0-08da49f24d75
x-ms-traffictypediagnostic: AM8PR04MB8002:EE_
x-microsoft-antispam-prvs: <AM8PR04MB8002EB003C431BECF050C2728CA79@AM8PR04MB8002.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZghkNxGApll7Art6dvrvbHm2xOsdAZIWVBgCcHyvVT3XEx4rsWU1UuKKYtTxAl6vBWg/5RWV6jIhqBnfi2DN6AXmCsdhWKkPKeEMxVO/iFf5rUvWNX2THf46/Bov7lIwGAdKCe5m/5v/Fsm3A1wEGkBCOQNFrHa9HcYZxxKgQ8OaVhB/GST3BM4NODam+3DmJ3xW2SoFU5/k3RNTXrHoUw5JC/vPnfl9WKbCoPZGX2EXGBui9e+GNWfxpZ/Hr5pVtFhr1OxSdsXgFUYIY6gk2OYCopHHk6xVGBznH8+3er6avCJegWJAeWc3kip+xWz7QZ4CZnOXlTFCH9n0IsZo3MAg4RKw5DutkzURQtspuDUL8WNAJW5QRqy8A438f2Q+Ar4L5sU62NLnRDgYO7wwFqRSH1uv4D9Ah9IJWFterFw9KBxB/JNytvDzWX986tFW+kgn+D58nx4xcrGourRGvkiydDQOjyMmltb0qcU1Ec58drIiZ5XCeVjYFQ+uFZ+R3buWiupyeE7SQiCXO4VgW/wmaZF+u0cSJgLUyFVvtldsCeP96XpgA/kJowP8x9QKtagdoCokBTMQ+98k9A+dgK6kPzKYLJTJadMODKO+tr68HwSteHIiuzewr9746ZmabyT0NEYMZdErr5fzn9zuSfwDfB7b41DU2vMAcY3I8tHLGL00Offfn25WAub1zcgfTJPkvB3v/77E6GsVYGBXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(186003)(53546011)(26005)(9686003)(86362001)(38100700002)(83380400001)(122000001)(44832011)(54906003)(33656002)(38070700005)(64756008)(4326008)(8676002)(2906002)(7416002)(52536014)(66556008)(66476007)(66946007)(66446008)(5660300002)(76116006)(55016003)(8936002)(71200400001)(508600001)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3NNUXJqa2VqbkFYaEJyalZIOEpKdXBLWHNFbEx5eklEc2d6RVdFWnRTUUl2?=
 =?utf-8?B?Ny9WaHhRVkNCQk56QklNQ0VNNFBaMmtEcnl0Y0xjL3RBU2pBVnR0aU1DU0tZ?=
 =?utf-8?B?dC9ITnA5K1lBZ3lZZS9JaFpvaGFZd3VjL2ZtQXlocnQ0djJERkRhT0xQUVd2?=
 =?utf-8?B?U2ZiZDdjKy9mWHVMY2RkSHA1RE5LQlNVUmt2NVExSHYrNklLUVdteEpFb2t4?=
 =?utf-8?B?UEVDWXN0em9HZmZXTUlDU3ZGaVZ3U3JkemtxUTJQM3dmS0w1Yjl5UHZMMWZN?=
 =?utf-8?B?TDdVRWVKTEU2QzA4SDNjYzE3Wnl0SW5ERGVqbVJPMWpaMFh3ODNwWFBlOEJo?=
 =?utf-8?B?ZU83N2FQa0tFVm9tZVB6blVab1VqZytvcUsyei9BVzdZQmpMb1NLVzhSbDls?=
 =?utf-8?B?L2JQU0U0cmhaSTlRcy9nbHQyZmV2NlR6YW1yY2xndHBuZGU3Wk9QYk1jakt3?=
 =?utf-8?B?c2VSUkFxS1hDWDZSUktsT1ZoMjJxL29MTDYvMmM1VmRLUk5LZHJpVTVtZUJr?=
 =?utf-8?B?bkFiNTdqWG56emdVRzdvTTlueTUxUTc3d1FaaUp2ZHNiVjI1cDlQU2FZTGZh?=
 =?utf-8?B?cGQzY2FXdUt1NzU1eGwrc256V1d5Mko1SUwzU3o2UEppcFZicW4vWVlRZFFp?=
 =?utf-8?B?M3hQMTFja0wraXcwOXVNdTc1Y2pCQ3V5VDBKQXl5N3BJVm9lTGZFc3o3NWYr?=
 =?utf-8?B?YkRHQVl0Q25QOWNRdUxBcTJHTzVTeUhVK09QT1BBYksxRFNCSFN0U1JRMW5I?=
 =?utf-8?B?YThlRlM5dG8xalh5cytGSlFxcFNGck1KRFo0NmJDMGt3c1dnd0dCSk1jUVVQ?=
 =?utf-8?B?cmJoaGRQdlVRTjYybFBBK0tXVFlsSU1ZU2RPRDR6V3Q3TnhJSmRIbkF2cG85?=
 =?utf-8?B?cWVjbWZHcDVERnlydVVVWW1takhudmxhMGlRcG9GKzhMVW5vR0NoOG1BWTJ2?=
 =?utf-8?B?VUVNcG5sZ1BCa2dOUnRpSUNwTlVnZkNYUUM3Mmp4YTNYRXdOVXJBL1Q2TXJ0?=
 =?utf-8?B?ZnE0bE13SzJaSTl5QmxlZXp6cGNSdVdJMXQ2c3RHUkZudHhvR0RnLzJBZ1NP?=
 =?utf-8?B?eS9qbCtwVjNOcW9COW5XNWt1Yk1hd0oyOUlxU3Z6aFJva01QWXg2QzZMUm9K?=
 =?utf-8?B?eE1oUkh6R2dvQjJZaW85YWh5YjNvenhJajMzVmxHaG5lM0RxdDhiRnQyVFI4?=
 =?utf-8?B?Nk9kc1NlVjQ0ODJGdkpVZTZVeGY2dmFFMHRXc2hKOE1jaTVjbzdwbVMzam9Y?=
 =?utf-8?B?UXNsMWZFRGYzVkhQQndpZHJHTWdOZ3Voei9EcEdLL055WGJEN3VBc1BtcHlZ?=
 =?utf-8?B?QmJDMjBpek5qQWhsaG5tZGcxRzNZTEZOMkNtNXRlVVpiM2xQc0o5dmYzWDFt?=
 =?utf-8?B?d04zT1NhRUZVMEdxcUdqNFlQMVJ3ZVlHbzltbTAvMFlYc1FZdW9JM0lJa1hs?=
 =?utf-8?B?ZVo1cVJzU1gwVU1wWFEwTzNleUp2RkZtKzJ5R1c0N3VXN25ROG1CL1IrbGVs?=
 =?utf-8?B?OXlYZ2RIdHdkSyt0QVVIbTY1MEpRemFDR2xBOUhoN3VzTnUwME5FRENtWEJi?=
 =?utf-8?B?RCtrOGs1TUI3Q053bnBSdE1zZXBMRFE5QmR0U09WbCtBdEV1MmdYZmhTUGtX?=
 =?utf-8?B?b3Jua1krbDlXRjFNdlpWZWErZGdmZ2JhdUpNcWxkUTR1Z2lsWER0N2JFNjZ6?=
 =?utf-8?B?aDg2akMxK04zM1pxMjNHa3BqZkk3TFkzV0puaExGTXAzQU81dUd2cGNxVDMx?=
 =?utf-8?B?UFQ5L1JuSURPaU9QUnVQbmRXWVpQbTZrakNrSSt6MmhlRkhFckxWeS9OKy8v?=
 =?utf-8?B?ZjVVSjJ3MVIrSmh3Q3hQT2o5ejZPOU9tRENrY292UWdlOHE1cldJS0lpQ0pu?=
 =?utf-8?B?bmtMMndNRnVqNWR2V3pKRGFBUUxTanp1dW52Kzk1ZlBXQzBLYWN2WmluSFlM?=
 =?utf-8?B?TmZWK0c0RDk5THZYdktlRmY4eTlqNFJsZDJKNTkvc1BGRXRNb0cyY2pIR3lU?=
 =?utf-8?B?ZVgrYU8zSVB1T2RhR0Vsd0dTZVFHTkkwZG9aUEY4b0NhQ2NZVmlNSXRvdW1K?=
 =?utf-8?B?T2lQa21obW5LQkJmVTJTU3JrVXBZZ1NNanV2NndiZmJyQVJZSUZZeWl4ZjNy?=
 =?utf-8?B?eEVkLzVkb0dLVXpuNGlKRUU2emxNTmkxYnI3N0hkM1FmRXFyWkxSVDdUNmhS?=
 =?utf-8?B?TGd5dTJDek5nRk42SjY1ZWJyVnJKS2J4VnpQRmkrNEdvU0NxSE9MTjFCTm14?=
 =?utf-8?B?OXpreU01NGw0VTBXczZOVjdoTWV1eEJHS1ZpaUNDR1BLZ2ROcFVXNlFnMW5Y?=
 =?utf-8?B?VkVieVRtTW1YV3lBOFNaNGFhUHB5UEhpa3hjY0VuUDA3VnBVN3BDUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73212581-9572-4e8c-28e0-08da49f24d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 08:30:25.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tK5CNq0Hpd+PSvHcy0eDHqQkQCCh4/d2kQX5opFhcBfVKQSDIoOIVbFGnfqldx2wPK29GoyW2INjJDGjKgvA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDbmnIg55pelIDE1OjU1DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gcm9iaCtkdEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207DQo+IGppbmdvb2hhbjFAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgt
aW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSA2Lzhd
IFBDSTogaW14NjogRGlzYWJsZSBjbG9ja3MgYW5kIHJlZ3VsYXRvcnMgYWZ0ZXIgbGluayBpcw0K
PiBkb3duDQo+IA0KPiBBbSBEb25uZXJzdGFnLCBkZW0gMDkuMDYuMjAyMiB1bSAwNjoxNyArMDAw
MCBzY2hyaWViIEhvbmd4aW5nIFpodToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gPiA+
IFNlbnQ6IDIwMjLlubQ25pyIOOaXpSAxNTozNQ0KPiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gcm9iaCtkdEBr
ZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207
DQo+ID4gPiBqaW5nb29oYW4xQGdtYWlsLmNvbTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+ID4g
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20NCj4gPiA+IENjOiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOw0KPiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBkbC1saW51eC1pbXgNCj4gPiA+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjkgNi84XSBQQ0k6IGlteDY6IERpc2FibGUgY2xvY2tzIGFuZCByZWd1bGF0
b3JzDQo+ID4gPiBhZnRlciBsaW5rIGlzIGRvd24NCj4gPiA+DQo+ID4gPiBBbSBGcmVpdGFnLCBk
ZW0gMDYuMDUuMjAyMiB1bSAwOTo0NyArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+ID4g
PiBTaW5jZSBpLk1YIFBDSWUgZG9lc24ndCBzdXBwb3J0IGhvdC1wbHVnLCByZWR1Y2UgcG93ZXIg
Y29uc3VtcHRpb24NCj4gPiA+ID4gYXMgbXVjaCBhcyBwb3NzaWJsZSBieSBkaXNhYmxpbmcgY2xv
Y2tzIGFuZCByZWd1bGF0b3JzIGFuZA0KPiA+ID4gPiByZXR1cm5pbmcgZXJyb3Igd2hlbiB0aGUg
bGluayBpcyBkb3duLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAxOSArKysrKysrKysrKysrKystLS0tDQo+
ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiA+ID4gPiBpbmRleCAzY2UzOTkzZDU3OTcuLmQxMjJjMTIxOTNhNiAxMDA2NDQNCj4g
PiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4g
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IEBA
IC04NDUsNyArODQ1LDkgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3Qg
ZHdfcGNpZQ0KPiA+ID4gPiAqcGNpKQ0KPiA+ID4gPiDCoAkvKiBTdGFydCBMVFNTTS4gKi8NCj4g
PiA+ID4gwqAJaW14Nl9wY2llX2x0c3NtX2VuYWJsZShkZXYpOw0KPiA+ID4gPg0KPiA+ID4gPiAt
CWR3X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPiA+ID4gPiArCXJldCA9IGR3X3BjaWVfd2Fp
dF9mb3JfbGluayhwY2kpOw0KPiA+ID4gPiArCWlmIChyZXQpDQo+ID4gPiA+ICsJCWdvdG8gZXJy
X291dDsNCj4gPiA+DQo+ID4gPiBUaGlzIGFkZHMgYmFjayBlcnJvciBoYW5kbGluZyB0aGF0IGhh
cyBiZWVuIGludGVudGlvbmFsbHkgcmVtb3ZlZCBpbg0KPiA+ID4gZjgxZjA5NWU4NzcxICgiUENJ
OiBpbXg2OiBBbGxvdyB0byBwcm9iZSB3aGVuDQo+ID4gPiBkd19wY2llX3dhaXRfZm9yX2xpbmso
KSBmYWlscyIpLg0KPiA+ID4gV2hpbGUgSSBhZ3JlZSB0aGF0IGRpc2FibGluZyB0aGUgY2xvY2tz
IGFuZCByZWd1bGF0b3JzIGlzIHRoZSByaWdodA0KPiA+ID4gdGhpbmcgdG8gZG8gd2hlbiB3ZSBk
b24ndCBtYW5hZ2UgdG8gZ2V0IGEgbGluaywgd2Ugc2hvdWxkIHN0aWxsDQo+ID4gPiBhbGxvdyB0
aGUgZHJpdmVyIHRvIHByb2JlLCBzbyBwbGVhc2UgYWRkIGEgInJldCA9IDAiIHRvIHRoaXMgbmV3
bHkNCj4gPiA+IGFkZGVkIG5vbi1mYXRhbCBlcnJvciBwYXRocy4NCj4gPiA+DQo+ID4gVGhhbmtz
IGZvciB5b3VyIHJldmlldyBjb21tZW50cy4NCj4gPiBUaGVyZSB3b3VsZCBiZSBhIGxvbmcgbGF0
ZW5jeSBpZiB0aGUgbGluayBpcyBkb3duIGFuZCBwcm9iZSBpcw0KPiA+IGZpbmlzaGVkDQo+ID4g
wqBzdWNjZXNzZnVsbHkuDQo+ID4gU2luY2UgdGhlIGR3X3BjaWVfd2FpdF9mb3JfbGluaygpIHdv
dWxkIGJlIGludm9rZWQgdHdpY2UgaW4gZXZlcnkNCj4gPiBkcml2ZXIgcHJvYmUNCj4gPiDCoGFu
ZCByZXN1bWUgb3BlcmF0aW9uIGxhdGVyLiBFYWNoIGR3X3BjaWVfd2FpdF9mb3JfbGluaygpIHdv
dWxkDQo+ID4gY29uc3VtZSBhYm91dA0KPiA+IMKgOTAsMDAwKjEwIH4gMTAwLDAwMCoxMCB1LXNl
Y29uZHMuIEknbSBhZnJhaWQgdGhhdCBzdWNoIGEgbG9uZyBsYXRlbmN5DQo+ID4gd291bGQNCj4g
PiDCoGJyaW5nIGJhZCB1c2VyIGV4cGVyaWVuY2UuDQo+ID4NCj4gPiBIZXJlIGFyZSB0aGUgbG9n
cyB3aGVuIHByb2JlIGlzIGFsbG93ZWQgd2hlbiBQQ0llIGxpbmsgaXMgZG93bjoNCj4gPiBbICAg
NTUuMDQ1OTU0XVsgVDE4MzVdIGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUE06IGNhbGxpbmcN
Cj4gPg0KPiBpbXg2X3BjaWVfcmVzdW1lX25vaXJxLjc0MmRmYTA3NGI0MGRjYTdjYTkyNWYwYzQ5
YzkwNWVjLmNmaV9qdCsweDAvMHgNCj4gPiA4IEAgMTgzNSwgcGFyZW50OiBidXNANWYwMDAwMDAN
Cj4gPiAuLi4NCj4gPiBbICAgNTYuMDc0NTY2XVsgVDE4MzVdIGlteDZxLXBjaWUgNWYwMDAwMDAu
cGNpZTogUGh5IGxpbmsgbmV2ZXIgY2FtZQ0KPiA+IHVwDQo+ID4gWyAgIDU3LjA3NDgxNl1bIFQx
ODM1XSBpbXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6IFBoeSBsaW5rIG5ldmVyIGNhbWUNCj4gPiB1
cA0KPiA+IC4uLg0KPiA+IFsgICA1Ny4xODIzMDBdWyBUMTgzNV0gaW14NnEtcGNpZSA1ZjAwMDAw
MC5wY2llOiBQTToNCj4gPg0KPiBpbXg2X3BjaWVfcmVzdW1lX25vaXJxLjc0MmRmYTA3NGI0MGRj
YTdjYTkyNWYwYzQ5YzkwNWVjLmNmaV9qdCsweDAvMHgNCj4gPiA4IHJldHVybmVkIDAgYWZ0ZXIg
MjEzNjMzNCB1c2Vjcw0KPiA+DQo+ID4gWyAgIDU3LjE4MjM0N11bIFQxODM1XSBpbXg2cS1wY2ll
IDVmMDEwMDAwLnBjaWU6IFBNOiBjYWxsaW5nDQo+ID4NCj4gaW14Nl9wY2llX3Jlc3VtZV9ub2ly
cS43NDJkZmEwNzRiNDBkY2E3Y2E5MjVmMGM0OWM5MDVlYy5jZmlfanQrMHgwLzB4DQo+ID4gOCBA
IDE4MzUsIHBhcmVudDogYnVzQDVmMDAwMDAwDQo+ID4gLi4uDQo+ID4gWyAgIDU4LjIxMDU4NF1b
IFQxODM1XSBpbXg2cS1wY2llIDVmMDEwMDAwLnBjaWU6IFBoeSBsaW5rIG5ldmVyIGNhbWUNCj4g
PiB1cA0KPiA+IFsgICA1OS4yMTA4MzFdWyBUMTgzNV0gaW14NnEtcGNpZSA1ZjAxMDAwMC5wY2ll
OiBQaHkgbGluayBuZXZlciBjYW1lDQo+ID4gdXANCj4gPiAuLi4NCj4gPiBbICAgNTkuMzE4MzEz
XVsgVDE4MzVdIGlteDZxLXBjaWUgNWYwMTAwMDAucGNpZTogUE06DQo+ID4NCj4gaW14Nl9wY2ll
X3Jlc3VtZV9ub2lycS43NDJkZmEwNzRiNDBkY2E3Y2E5MjVmMGM0OWM5MDVlYy5jZmlfanQrMHgw
LzB4DQo+ID4gOCByZXR1cm5lZCAwIGFmdGVyIDIxMzU5NDkgdXNlY3MNCj4gPg0KPiA+IFNvLCBJ
J20gcHJlZmVyIHRoYXQgaXQncyBiZXR0ZXIgdG8gbGV0IHRoZSBwcm9iZSBmYWlsZWQgd2hlbiBs
aW5rIGlzDQo+ID4gZG93bi4NCj4gPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRoYXQ/DQo+IA0K
PiBJdCBkaWZmZXJlbnQgZnJvbSB0aGUgYmVoYXZpb3Igb2Ygb3RoZXIgcGxhdGZvcm1zLCB0aGF0
IHN0aWxsIHNob3cgdGhlIHJvb3QgYnJpZGdlDQo+IGluIGxzcGNpLCBldmVuIGlmIHRoZSBsaW5r
IGlzIGRvd24uIEkndmUgc2VlbiBwZW9wbGUgY29uZnVzZWQgYnkgdGhpcyBiZWhhdmlvci4NCj4g
Q29tZSB0byB0aGluayBhYm91dCBpdDogZG9lcyBsc3BjaSB3b3JrIHdoZW4gYWxsIHRoZSBjbG9j
a3MgYXJlIGRpc2FibGVkPw0KPiANCj4gVGhlIGxhdGVuY3kgaW4gdGhlIHByb2JlIHBhdGggaXMg
bm90IHRoYXQgcmVsZXZhbnQsIGFzIGl0IGlzIGRvbmUgYXN5bmNocm9ub3VzLA0KPiBzbyBpdCBk
b2Vzbid0IHN0YWxsIHRoZSBib290IHByb2Nlc3MuIFlvdSBoYXZlIGEgcG9pbnQgb24gdGhlIHN1
c3BlbmQvcmVzdW1lDQo+IHBhdGggaG93ZXZlci4gTWF5YmUgd2UgbmVlZCB0byByZW1lbWJlciB0
aGUgbGluayBzdGF0ZSBpbiBzdXNwZW5kIHRvIGtub3cNCj4gaWYgcmVzdW1lIHNob3VsZCBldmVu
IGRvIGFueXRoaW5nIHVzZWZ1bD8NCj4gDQpUaGlzIHNvdW5kcyBnb29kLiBUaHVzLCBvbmUgZmxh
ZyBpcyByZXF1aXJlZCB0byBzcGVjaWZ5IHRoZSBsaW5rIGlzIHVwIG9yIG5vdA0KYmVmb3JlIHN1
c3BlbmQuIElmIHRoZSBsaW5rIGlzIGRvd24sIHRoZSBpbXg2X3BjaWVfc3RhcnRfbGluaygpIHNo
b3VsZG4ndA0KaW52b2tlZCBhdCBhbGwgd2hlbiByZXN1bWUgYmFjay4NClRoZW4gd2UgY2FuIGF2
b2lkIHRoZSBsb25nIGxhdGVuY3kgYW5kIGtlZXAgcHJvYmUgZmluaXNoZWQgd2hlbiBsaW5rIGlz
IGRvd24uDQoNCkluIHRoaXMgc2NlbmFyaW8sIHdlIGNhbiBsZXQgcHJvYmUgc3VjY2Vzc2Z1bGx5
LCBhbHRob3VnaCB0aGUgbGluayBpcyBkb3duLg0KQW5kIHRoZSBsYXN0IHBhdGNoIGNhbiBiZSBk
cm9wcGVkLCBzaW5jZSB0aGUgY2xvY2tzL3JlZ3VsYXRvcnMgYXJlIGFsd2F5cyBvbg0KaW4gdGhp
cyBjYXNlLg0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiBhbmQgaW5zcGlyYXRpb24uDQoN
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4g
Pg0KPiA+ID4gPg0KPiA+ID4gPiDCoAlpZiAocGNpLT5saW5rX2dlbiA9PSAyKSB7DQo+ID4gPiA+
IMKgCQkvKiBBbGxvdyBHZW4yIG1vZGUgYWZ0ZXIgdGhlIGxpbmsgaXMgdXAuICovIEBAIC0NCj4g
PiA+ID4gODc2LDEyICs4NzgsMTQNCj4gPiA+IEBADQo+ID4gPiA+IHN0YXRpYyBpbnQgaW14Nl9w
Y2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiA+ID4gwqAJCQlyZXQgPQ0K
PiA+ID4gPiBpbXg2X3BjaWVfd2FpdF9mb3Jfc3BlZWRfY2hhbmdlKGlteDZfcGNpZSk7DQo+ID4g
PiA+IMKgCQkJaWYgKHJldCkgew0KPiA+ID4gPiDCoAkJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0
byBicmluZyBsaW5rIHVwIVxuIik7DQo+ID4gPiA+IC0JCQkJZ290byBlcnJfcmVzZXRfcGh5Ow0K
PiA+ID4gPiArCQkJCWdvdG8gZXJyX291dDsNCj4gPiA+ID4gwqAJCQl9DQo+ID4gPiA+IMKgCQl9
DQo+ID4gPiA+DQo+ID4gPiA+IMKgCQkvKiBNYWtlIHN1cmUgbGluayB0cmFpbmluZyBpcyBmaW5p
c2hlZCBhcyB3ZWxsIQ0KPiA+ID4gPiAqLw0KPiA+ID4gPiAtCQlkd19wY2llX3dhaXRfZm9yX2xp
bmsocGNpKTsNCj4gPiA+ID4gKwkJcmV0ID0gZHdfcGNpZV93YWl0X2Zvcl9saW5rKHBjaSk7DQo+
ID4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiA+ICsJCQlnb3RvIGVycl9vdXQ7DQo+ID4gPiA+IMKg
CX0gZWxzZSB7DQo+ID4gPiA+IMKgCQlkZXZfaW5mbyhkZXYsICJMaW5rOiBHZW4yIGRpc2FibGVk
XG4iKTsNCj4gPiA+ID4gwqAJfQ0KPiA+ID4gPiBAQCAtODkwLDExICs4OTQsMTggQEAgc3RhdGlj
IGludCBpbXg2X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QNCj4gPiA+ID4gZHdfcGNpZQ0KPiA+ID4g
KnBjaSkNCj4gPiA+ID4gwqAJZGV2X2luZm8oZGV2LCAiTGluayB1cCwgR2VuJWlcbiIsIHRtcCAm
IFBDSV9FWFBfTE5LU1RBX0NMUyk7DQo+ID4gPiA+IMKgCXJldHVybiAwOw0KPiA+ID4gPg0KPiA+
ID4gPiAtZXJyX3Jlc2V0X3BoeToNCj4gPiA+ID4gK2Vycl9vdXQ6DQo+ID4gPiA+IMKgCWRldl9k
YmcoZGV2LCAiUEhZIERFQlVHX1IwPTB4JTA4eCBERUJVR19SMT0weCUwOHhcbiIsDQo+ID4gPiA+
IMKgCQlkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfUE9SVF9ERUJVRzApLA0KPiA+ID4gPiDC
oAkJZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBQQ0lFX1BPUlRfREVCVUcxKSk7DQo+ID4gPiA+IMKg
CWlteDZfcGNpZV9yZXNldF9waHkoaW14Nl9wY2llKTsNCj4gPiA+ID4gKwlpbXg2X3BjaWVfY2xr
X2Rpc2FibGUoaW14Nl9wY2llKTsNCj4gPiA+ID4gKwlpZiAoaW14Nl9wY2llLT5waHkgIT0gTlVM
TCkgew0KPiA+ID4NCj4gPiA+IFBsZWFzZSB1c2UgdGhlIG1vcmUgY29tbW9uIGlmIChpbXg2X3Bj
aWUtPnBoeSkgaGVyZS4NCj4gPiA+DQo+ID4gT2theS4gVGhhbmtzLg0KPiA+DQo+ID4gQmVzdCBS
ZWdhcmRzDQo+ID4gUmljaGFyZCBaaHUNCj4gPg0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IEx1Y2Fz
DQo+ID4gPg0KPiA+ID4gPiArCQlwaHlfcG93ZXJfb2ZmKGlteDZfcGNpZS0+cGh5KTsNCj4gPiA+
ID4gKwkJcGh5X2V4aXQoaW14Nl9wY2llLT5waHkpOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKwlp
ZiAoaW14Nl9wY2llLT52cGNpZSkNCj4gPiA+ID4gKwkJcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9w
Y2llLT52cGNpZSk7DQo+ID4gPiA+IMKgCXJldHVybiByZXQ7DQo+ID4gPiA+IMKgfQ0KPiA+ID4g
Pg0KPiA+ID4NCj4gPg0KPiANCg0K
