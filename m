Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC9B5AAAD7
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 11:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiIBJEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiIBJEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 05:04:36 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50051.outbound.protection.outlook.com [40.107.5.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618BAA2D88;
        Fri,  2 Sep 2022 02:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns31C2n4Mz4KoBcA3OkjPcZwYUQZqxskBNV1S68M/m6AI9tHIYVKMj+6TuMN+JqFnnxoABMZ2ZfjpAAD+KwjMMu4vQsWn+K75XXPLFsLv8jA2kredTstFUJ3ZTNf0S88Ki7kp518NsGjtH8DiKbny8tFY3UpczNbsMi0GMLgElgRHkBqH/8jvG1a4YKDuXaO5+LDYbI0uX3eP5+9E5eZpxABT8pGQT4fjQ0TtoXciOKfm/AqjsQDlWVd/sCLJfbGJPQe5t+WFCtbdB+w2glS4zlsUnJFLTTMHLKXqtCphV4PkA22Y/24ErM3K/4X/jnI4Yhmam2D1kvckyXuUquPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU56Ks7IDI7X8Xqixk5odjdvkR4qrDHiAHhbRQoDgIM=;
 b=fOCZNmXD3lahFzTPQDDK/KL5yjCVtC3zTSaa5IbKIi6DKS9lkszifmu808a7mOsGAvLa748Hx+I5EJvt1mPOhE9vYLwTlJzqTO6iNDOp50+MRckVAyYBXeCIjo2evOm3ki08UbjQeqX37spssEHAMzYPfoYcNV+dYes4o8fAvwepEZDoEg774qy/DtQQN4eXkXYlXvyokHiqyiJs4sjTJ3aAdWBCJIxmeVqrCITHjD3zR3AtF2T+MBxnU23aQcG/iXZ1wMLgtQc5J32dOIyhOuZBy9oEIxz+tzxJLwlvBDbqR6+UxkDHpNmiqlG37I72PsJOSLwROsEZ5vaJXdyFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU56Ks7IDI7X8Xqixk5odjdvkR4qrDHiAHhbRQoDgIM=;
 b=ZKaQzgWAzPtsYfZ9hRW4RqVWzUx7DVu6+tu+E2c7NIR6dNU194ahi0BVBC+3x04XRd2u8iUb7+bqQjwpa+88Ow8UchtTpYi0YIVnPU6agebmePSu4De6QJJHR0zj7JG0j+W1zwe5aCSTK74VqT2dvRfv8OEre2n1PvPIyWEUF1g=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 2 Sep
 2022 09:04:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 09:04:29 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v6 6/7] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
Thread-Topic: [PATCH v6 6/7] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
Thread-Index: AQHYvbovZqOcMyeNVkmkqaak5h8At63L00CAgAAGwgA=
Date:   Fri, 2 Sep 2022 09:04:29 +0000
Message-ID: <AS8PR04MB86769DD3642A0777CBD897748C7A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1662004960-14071-1-git-send-email-hongxing.zhu@nxp.com>
         <1662004960-14071-7-git-send-email-hongxing.zhu@nxp.com>
 <0aae7d19a079e4631fc7b823d99ffbef30cfb4d2.camel@pengutronix.de>
In-Reply-To: <0aae7d19a079e4631fc7b823d99ffbef30cfb4d2.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3ca4b61-34c5-4de5-a659-08da8cc224fa
x-ms-traffictypediagnostic: DB9PR04MB8281:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6JP0gEjXLjWAnqwi2Z1HsAXMkXedYhd5kgXvdmTEGoePP8uCVE7EjtbazteaeTedSL7GRsSsK20I+7FnP0AyDebltr6mi/aWdY82vu1jiCL6t1AJSedhsDu01mmJJp8Lo+tl2Xf6r6VJ15fTUPHllTdb+NcoceOaYNwlm9yTSTOkClbMi+/OCz0kHonW/duI1FrZKuN7Kt2X30fUqnxEj32C4if/lTriy7PhMFRIzMIwBIb8tgHTYy60IfpJviaVWxkrZ8Jx7JINk3LzkULQC20mpCc5PDR+04/Lih3GyB5awfj+d63N6FJOgwBTHtuKzQyuwyr6iRsmUUg5ZJMxwKq6T7oGtp2vaLv1DYV7kC7DrbIWVMy0cYTufks3WwEYjrcBtzb3gfpGEIclXssXpyxw29ZD9yx7S4yqqw9w0xEUJy5MVTtOeSpRqG9uBPiBD1PHWHVoW53/hhgY1bbDYEtoWdybuBud2LDHnXKsM8+1vB3gLQ5G8cK9GLFckRLkBS5Daff+E25FKX4fJ76UUHpPFBS03/u69KqKYSsKVwz3JkhrbjuCC/jdgHtFnRGz2hVknVyDGGq1BIqFqJtwgzGRkQDD8MAWNpsRZ2IaXuYRo8yz0sBXEZMW+8cdMTZzAjSnYDBeEEFN5bVEc3+pk9R3m5eRQDjInRaKK5laTbf3wK/k6QNUs6VkVr3qokkW18MmKhVyyDFKZdJAtITbnILRc5HI5Re8iRiVKNC5vIFTXcgiNIxMFhyyBElV/K10y3voclBYwpBBTcMLqIFTE6iV3iP8XisAd/i9nz4RuUr59qTF9ci5I1mligIKREK3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(55016003)(44832011)(478600001)(64756008)(66476007)(66556008)(66946007)(76116006)(4326008)(8676002)(66446008)(7696005)(5660300002)(53546011)(2906002)(6506007)(26005)(7416002)(9686003)(316002)(921005)(54906003)(83380400001)(86362001)(33656002)(122000001)(110136005)(52536014)(41300700001)(186003)(38070700005)(8936002)(38100700002)(71200400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjBLVmhGSFpmNGJkTUY1clUrTUw5N0hTK0VHN1VvbUllMlJyYm1TdjVUdmxp?=
 =?utf-8?B?U3BhTjVIY1R1cjlyNDNOdVVmeUtRTXFobjduTndxQ1FtNFM5TVdFR3hrLzlq?=
 =?utf-8?B?K2dqcVRsTUNtU0x4Sm42ZzJ5SEhQNU9mWkFzM0JjZG8wQWEybXZVcWlaZUdk?=
 =?utf-8?B?L0RmUkZZWjlIY21aTlpvWGxxNnRBbXpjOWlwcmxKTW1wakYxNWYrMVBSbnA1?=
 =?utf-8?B?cWdqc2d6bGxnQkVKRjhvaVl1R1V3bjkxbW81VnlMaUx0TkkzRVF4L0RibGtE?=
 =?utf-8?B?c1Nnd2syOWJmZ0dIZzZoMnlsdUo4Y1N3T2VocHNTN1ZVbi9nY09CMEhTWTNZ?=
 =?utf-8?B?akExWTlHa3pwWEFkdFd4V3pjS0M2aG1RQlkzYjVIdzFwS0hqeWM5TnQrOVJW?=
 =?utf-8?B?b0tZd1ZPWHMzR0NvRFZ1bnhJM3R1OTRWYm51c3piNkQ1N2VlSzQ5SEs1MCtp?=
 =?utf-8?B?ZkhQNHYzdHhZNmhvb1U0TmkwdHQ0YThJWkVnRDdDUnVIekRzbE94MDFCc25W?=
 =?utf-8?B?ck44YVZDSmRjakJROW5zT2MzbEsyclZKbTBHZjNidmQveXFySWFKYUZBVkJH?=
 =?utf-8?B?RmJxWmwyOUlqZDhUUkZDa09RMmk0NmVxNlIvZ2ZRS3VtK1NBbVZKMWpQRTdk?=
 =?utf-8?B?akFZaEFkSy8rL3JFajNBRG15OXVyZTRabGJJbk4wbnFFRUNwUEpqY0ZPQWIy?=
 =?utf-8?B?YzhzelM0cThjelI0OUZGcXRRU2dKVmhPNXFYY2llU0VUTnlZSnBvek5ZRkxE?=
 =?utf-8?B?UGNVV2ZRN01mUjRjRnNja2dpanl1bnRWeVJXL0hnY2NlUUpGcC9aOGgwR3VV?=
 =?utf-8?B?QWRKTUp0eExTR1p4VkorKzE1TGQvLzBnK1FETVZmcFZkdTJBYTJFSFBCOC9H?=
 =?utf-8?B?STZPeTFQMzk2ZGlTdlhFV1NJaHg0bS9KNW5YVTJTaTZJVjhUWDlqZGRRR3Bl?=
 =?utf-8?B?QUNjWFFlMG5tdTQyVE9sL29Cbm1iczR2eVI5eFY5MnlDbktUaXJUY0FCU1pY?=
 =?utf-8?B?VUVndHNYOUVyOHJFV3JvK3ZvVHFLVXVwMi9tQU5LOHcxVGVnUHpKM2dtZ1VL?=
 =?utf-8?B?eFQ2Sm1hOVo1eXdpYXZ6R25CNTJoN0FRMEFHS2ZBRUVZMWwycS9JWXFPNy9V?=
 =?utf-8?B?djh4UEVvY2lUN2JhZWw4ZFpZZ3RDbDdSWVRsckVZRUtiQThSN0hDR0dXOGRq?=
 =?utf-8?B?VEsvd0l6RkxpOEtGWXNxWFFpcXc0Rk9iczZsSG93Y29GMkRqOFFzNDZBakhF?=
 =?utf-8?B?SDMvVmM4WVhob3dOY2YyOHlHemFzNzRWVUQ0SHJyMUwxWCsvRHU2Tzd6NlZn?=
 =?utf-8?B?VEowQXlySExESlVqYlZEanJ4VDc4VjRweXpxY0wzai9LWEVhOEw1WEtld0ZW?=
 =?utf-8?B?SjlHaU5tL0tOazNaSGpORnlKRFJvb1A4Q0xYVmJDdmppb0lEOXFwbm02SVZv?=
 =?utf-8?B?Y1BFekoyMXNRN2g3cXlVYi85Vkh3Z21EVGp0SFY2cWQ3K29helNyQVo4MUww?=
 =?utf-8?B?OU9RRmNSV2ZVenk4bk1kN2ZERThaUGxIZjV3TWcvQlNXMHBHN3E5WllKWDE2?=
 =?utf-8?B?Z2ZDM2RmVnRPdnB3MzZYRDZ6Y3Q0MDN6T1J4cENoWm1NdEZGM2RBQjZ3b3RI?=
 =?utf-8?B?OGtRb0E4Z3YvVHBINE9QN0x4MDJBZjRMam0wMnlBM2tnaFpra3l4RFYweTVs?=
 =?utf-8?B?NENwQ1NQZXEvNDZtbFh6RGs2SCtqaTdudGtkY2Rtbk9XWG9sSXRnOXNLR0FT?=
 =?utf-8?B?ZVdOUW91cHQ5bFNySTk3Mk1lMFRCTlNXdEFwNWZsVXlROC85bm92WnpJU2ZE?=
 =?utf-8?B?cklMd1Q2am9ibTkxZTdpR3lpdGRFdXZ1RkQwUTJrTGI1ZHNGQWs1TEg3ZWdS?=
 =?utf-8?B?ZkRDaEdnUFlhSzNUSUtVYWRMcElLMW5MSVdEZi9TZUFCRzRVWlExWFhEUUFH?=
 =?utf-8?B?NkRlL1lLU3VERU1vV0FMeGhQTVBOUFRYaVJCdUYvV3BBS1dRZjluWWdtdFhI?=
 =?utf-8?B?ekd6U3BDNG9XOEVXcDRyVGxKSFMwcmlXOXNtUGpVbFZKQnFDcUMxNXdTMzVu?=
 =?utf-8?B?bjRPQ1BPSldBaHVya0lwdXlRUUxLZHRzbUNoRmFrc2hBTnozUnZ6cnZMVG1y?=
 =?utf-8?Q?Wzj9PD3CdhWLSkTxOQ8y0px+B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ca4b61-34c5-4de5-a659-08da8cc224fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 09:04:29.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmSWngKciURy/gaMuNxhCb1dhnqHzmWeMn9XfAzdR4s9icNqx9LRouSemNlLVR03su7HkZ1wdKPAcIA0E2EK5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiBT
ZW50OiAyMDIy5bm0OeaciDLml6UgMTY6MzgNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+OyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOw0KPiBiaGVsZ2Fhc0Bnb29nbGUu
Y29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyByb2JoQGtlcm5lbC5vcmc7DQo+IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHZrb3VsQGtlcm5lbC5vcmc7IGFsZXhhbmRlci5zdGVpbkBldy50cS1n
cm91cC5jb207DQo+IG1hcmV4QGRlbnguZGU7IHJpY2hhcmQubGVpdG5lckBsaW51eC5kZXYNCj4g
Q2M6IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjYgNi83XSBwaHk6IGZyZWVzY2FsZTogaW14OG0tcGNpZTogQWRk
IGkuTVg4TVAgUENJZQ0KPiBQSFkgc3VwcG9ydA0KPiANCj4gQW0gRG9ubmVyc3RhZywgZGVtIDAx
LjA5LjIwMjIgdW0gMTI6MDIgKzA4MDAgc2NocmllYiBSaWNoYXJkIFpodToNCj4gPiBBZGQgaS5N
WDhNUCBQQ0llIFBIWSBzdXBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEx1Y2FzIFN0YWNo
IDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiA+IFRlc3RlZC1ieTogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+DQo+ID4gVGVzdGVkLWJ5OiBSaWNoYXJkIExlaXRuZXIgPHJpY2hhcmQubGVp
dG5lckBza2lkYXRhLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEFsZXhhbmRlciBTdGVpbiA8YWxleGFu
ZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9waHkvZnJl
ZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jIHwgMTQzDQo+ID4gKysrKysrKysrKysrKystLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspLCA0NyBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1p
bXg4bS1wY2llLmMNCj4gPiBiL2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBj
aWUuYw0KPiA+IGluZGV4IGFkN2QyZWRmYzQxNC4uYzkzN2Q0MjllYThiIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYw0KPiA+IEBAIC0xMSw2
ICsxMSw5IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gICNpbmNs
dWRlIDxsaW51eC9tZmQvc3lzY29uL2lteDctaW9tdXhjLWdwci5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2Rl
dmljZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGh5L3BoeS5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4N
Cj4gPiBAQCAtMzEsMTIgKzM0LDEwIEBADQo+ID4gICNkZWZpbmUgSU1YOE1NX1BDSUVfUEhZX0NN
Tl9SRUcwNjUJMHgxOTQNCj4gPiAgI2RlZmluZSAgQU5BX0FVWF9SWF9URVJNCQkoQklUKDcpIHwg
QklUKDQpKQ0KPiA+ICAjZGVmaW5lICBBTkFfQVVYX1RYX0xWTAkJCUdFTk1BU0soMywgMCkNCj4g
PiAtI2RlZmluZSBJTVg4TU1fUENJRV9QSFlfQ01OX1JFRzc1CTB4MUQ0DQo+ID4gLSNkZWZpbmUg
IFBDSUVfUEhZX0NNTl9SRUc3NV9QTExfRE9ORQkweDMNCj4gPiArI2RlZmluZSBJTVg4TU1fUENJ
RV9QSFlfQ01OX1JFRzA3NQkweDFENA0KPiA+ICsjZGVmaW5lICBBTkFfUExMX0RPTkUJCQkweDMN
Cj4gPiAgI2RlZmluZSBQQ0lFX1BIWV9UUlNWX1JFRzUJCTB4NDE0DQo+ID4gLSNkZWZpbmUgIFBD
SUVfUEhZX1RSU1ZfUkVHNV9HRU4xX0RFRU1QCTB4MkQNCj4gPiAgI2RlZmluZSBQQ0lFX1BIWV9U
UlNWX1JFRzYJCTB4NDE4DQo+ID4gLSNkZWZpbmUgIFBDSUVfUEhZX1RSU1ZfUkVHNl9HRU4yX0RF
RU1QCTB4Rg0KPiA+DQo+ID4gICNkZWZpbmUgSU1YOE1NX0dQUl9QQ0lFX1JFRl9DTEtfU0VMCUdF
Tk1BU0soMjUsIDI0KQ0KPiA+ICAjZGVmaW5lIElNWDhNTV9HUFJfUENJRV9SRUZfQ0xLX1BMTA0K
PiAJRklFTERfUFJFUChJTVg4TU1fR1BSX1BDSUVfUkVGX0NMS19TRUwsIDB4MykNCj4gPiBAQCAt
NDcsMTYgKzQ4LDI4IEBADQo+ID4gICNkZWZpbmUgSU1YOE1NX0dQUl9QQ0lFX1NTQ19FTgkJQklU
KDE2KQ0KPiA+ICAjZGVmaW5lIElNWDhNTV9HUFJfUENJRV9BVVhfRU5fT1ZFUlJJREUJQklUKDkp
DQo+ID4NCj4gPiArZW51bSBpbXg4X3BjaWVfcGh5X3R5cGUgew0KPiA+ICsJSU1YOE1NLA0KPiA+
ICsJSU1YOE1QLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RydWN0IGlteDhfcGNpZV9waHlfZHJ2
ZGF0YSB7DQo+ID4gKwllbnVtCWlteDhfcGNpZV9waHlfdHlwZSB2YXJpYW50Ow0KPiA+ICsJY2hh
cglncHJbMTI4XTsNCj4gDQo+IFRoZSBzdGF0aWMgYWxsb2NhdGlvbiBpcyBleGNlc3NpdmUgYW5k
IHdhc3RlcyBhIGxvdCBvZiBtZW1vcnkuIEp1c3QgbWFrZSB0aGlzIGENCj4gY29uc3QgY2hhciAq
Z3ByOw0KT2theSwgd291bGQgYmUgY2hhbmdlIHRvIGNvbnN0IGNoYXIgKmdwci4NClRoYW5rcyBm
b3IgeW91ciByZXZpZXcuDQoNCj4gDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdHJ1Y3QgaW14OF9w
Y2llX3BoeSB7DQo+ID4gIAl2b2lkIF9faW9tZW0JCSpiYXNlOw0KPiA+ICAJc3RydWN0IGNsawkJ
KmNsazsNCj4gPiAgCXN0cnVjdCBwaHkJCSpwaHk7DQo+ID4gIAlzdHJ1Y3QgcmVnbWFwCQkqaW9t
dXhjX2dwcjsNCj4gPiAgCXN0cnVjdCByZXNldF9jb250cm9sCSpyZXNldDsNCj4gPiArCXN0cnVj
dCByZXNldF9jb250cm9sCSpwZXJzdDsNCj4gPiAgCXUzMgkJCXJlZmNsa19wYWRfbW9kZTsNCj4g
PiAgCXUzMgkJCXR4X2RlZW1waF9nZW4xOw0KPiA+ICAJdTMyCQkJdHhfZGVlbXBoX2dlbjI7DQo+
ID4gIAlib29sCQkJY2xrcmVxX3VudXNlZDsNCj4gPiArCWNvbnN0IHN0cnVjdCBpbXg4X3BjaWVf
cGh5X2RydmRhdGEJKmRydmRhdGE7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGludCBpbXg4
X3BjaWVfcGh5X2luaXQoc3RydWN0IHBoeSAqcGh5KSBAQCAtNjgsMzEgKzgxLDIwIEBADQo+ID4g
c3RhdGljIGludCBpbXg4X3BjaWVfcGh5X2luaXQoc3RydWN0IHBoeSAqcGh5KQ0KPiA+ICAJcmVz
ZXRfY29udHJvbF9hc3NlcnQoaW14OF9waHktPnJlc2V0KTsNCj4gPg0KPiA+ICAJcGFkX21vZGUg
PSBpbXg4X3BoeS0+cmVmY2xrX3BhZF9tb2RlOw0KPiA+IC0JLyogU2V0IEFVWF9FTl9PVkVSUklE
RSAxJ2IwLCB3aGVuIHRoZSBDTEtSRVEjIGlzbid0IGhvb2tlZCAqLw0KPiA+IC0JcmVnbWFwX3Vw
ZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gLQkJCSAg
IElNWDhNTV9HUFJfUENJRV9BVVhfRU5fT1ZFUlJJREUsDQo+ID4gLQkJCSAgIGlteDhfcGh5LT5j
bGtyZXFfdW51c2VkID8NCj4gPiAtCQkJICAgMCA6IElNWDhNTV9HUFJfUENJRV9BVVhfRU5fT1ZF
UlJJREUpOw0KPiA+IC0JcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJ
T01VWENfR1BSMTQsDQo+ID4gLQkJCSAgIElNWDhNTV9HUFJfUENJRV9BVVhfRU4sDQo+ID4gLQkJ
CSAgIElNWDhNTV9HUFJfUENJRV9BVVhfRU4pOw0KPiA+IC0JcmVnbWFwX3VwZGF0ZV9iaXRzKGlt
eDhfcGh5LT5pb211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gLQkJCSAgIElNWDhNTV9HUFJf
UENJRV9QT1dFUl9PRkYsIDApOw0KPiA+IC0JcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5p
b211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gLQkJCSAgIElNWDhNTV9HUFJfUENJRV9TU0Nf
RU4sIDApOw0KPiA+IC0NCj4gPiAtCXJlZ21hcF91cGRhdGVfYml0cyhpbXg4X3BoeS0+aW9tdXhj
X2dwciwgSU9NVVhDX0dQUjE0LA0KPiA+IC0JCQkgICBJTVg4TU1fR1BSX1BDSUVfUkVGX0NMS19T
RUwsDQo+ID4gLQkJCSAgIHBhZF9tb2RlID09IElNWDhfUENJRV9SRUZDTEtfUEFEX0lOUFVUID8N
Cj4gPiAtCQkJICAgSU1YOE1NX0dQUl9QQ0lFX1JFRl9DTEtfRVhUIDoNCj4gPiAtCQkJICAgSU1Y
OE1NX0dQUl9QQ0lFX1JFRl9DTEtfUExMKTsNCj4gPiAtCXVzbGVlcF9yYW5nZSgxMDAsIDIwMCk7
DQo+ID4gLQ0KPiA+IC0JLyogRG8gdGhlIFBIWSBjb21tb24gYmxvY2sgcmVzZXQgKi8NCj4gPiAt
CXJlZ21hcF91cGRhdGVfYml0cyhpbXg4X3BoeS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjE0LA0K
PiA+IC0JCQkgICBJTVg4TU1fR1BSX1BDSUVfQ01OX1JTVCwNCj4gPiAtCQkJICAgSU1YOE1NX0dQ
Ul9QQ0lFX0NNTl9SU1QpOw0KPiA+IC0JdXNsZWVwX3JhbmdlKDIwMCwgNTAwKTsNCj4gPiArCXN3
aXRjaCAoaW14OF9waHktPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gPiArCWNhc2UgSU1YOE1NOg0K
PiA+ICsJCS8qIFR1bmUgUEhZIGRlLWVtcGhhc2lzIHNldHRpbmcgdG8gcGFzcyBQQ0llIGNvbXBs
aWFuY2UuICovDQo+ID4gKwkJaWYgKGlteDhfcGh5LT50eF9kZWVtcGhfZ2VuMSkNCj4gPiArCQkJ
d3JpdGVsKGlteDhfcGh5LT50eF9kZWVtcGhfZ2VuMSwNCj4gPiArCQkJICAgICAgIGlteDhfcGh5
LT5iYXNlICsgUENJRV9QSFlfVFJTVl9SRUc1KTsNCj4gPiArCQlpZiAoaW14OF9waHktPnR4X2Rl
ZW1waF9nZW4yKQ0KPiA+ICsJCQl3cml0ZWwoaW14OF9waHktPnR4X2RlZW1waF9nZW4yLA0KPiA+
ICsJCQkgICAgICAgaW14OF9waHktPmJhc2UgKyBQQ0lFX1BIWV9UUlNWX1JFRzYpOw0KPiA+ICsJ
CWJyZWFrOw0KPiA+ICsJY2FzZSBJTVg4TVA6DQo+ID4gKwkJcmVzZXRfY29udHJvbF9hc3NlcnQo
aW14OF9waHktPnBlcnN0KTsNCj4gPiArCQlicmVhazsNCj4gPiArCX0NCj4gPg0KPiA+ICAJaWYg
KHBhZF9tb2RlID09IElNWDhfUENJRV9SRUZDTEtfUEFEX0lOUFVUIHx8DQo+ID4gIAkgICAgcGFk
X21vZGUgPT0gSU1YOF9QQ0lFX1JFRkNMS19QQURfVU5VU0VEKSB7IEBAIC0xMjAsMjANCj4gKzEy
Miw0NCBAQA0KPiA+IHN0YXRpYyBpbnQgaW14OF9wY2llX3BoeV9pbml0KHN0cnVjdCBwaHkgKnBo
eSkNCj4gPiAgCQkgICAgICAgaW14OF9waHktPmJhc2UgKyBJTVg4TU1fUENJRV9QSFlfQ01OX1JF
RzA2NSk7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCS8qIFR1bmUgUEhZIGRlLWVtcGhhc2lzIHNldHRp
bmcgdG8gcGFzcyBQQ0llIGNvbXBsaWFuY2UuICovDQo+ID4gLQlpZiAoaW14OF9waHktPnR4X2Rl
ZW1waF9nZW4xKQ0KPiA+IC0JCXdyaXRlbChpbXg4X3BoeS0+dHhfZGVlbXBoX2dlbjEsDQo+ID4g
LQkJICAgICAgIGlteDhfcGh5LT5iYXNlICsgUENJRV9QSFlfVFJTVl9SRUc1KTsNCj4gPiAtCWlm
IChpbXg4X3BoeS0+dHhfZGVlbXBoX2dlbjIpDQo+ID4gLQkJd3JpdGVsKGlteDhfcGh5LT50eF9k
ZWVtcGhfZ2VuMiwNCj4gPiAtCQkgICAgICAgaW14OF9waHktPmJhc2UgKyBQQ0lFX1BIWV9UUlNW
X1JFRzYpOw0KPiA+ICsJLyogU2V0IEFVWF9FTl9PVkVSUklERSAxJ2IwLCB3aGVuIHRoZSBDTEtS
RVEjIGlzbid0IGhvb2tlZCAqLw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5p
b211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gKwkJCSAgIElNWDhNTV9HUFJfUENJRV9BVVhf
RU5fT1ZFUlJJREUsDQo+ID4gKwkJCSAgIGlteDhfcGh5LT5jbGtyZXFfdW51c2VkID8NCj4gPiAr
CQkJICAgMCA6IElNWDhNTV9HUFJfUENJRV9BVVhfRU5fT1ZFUlJJREUpOw0KPiA+ICsJcmVnbWFw
X3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gKwkJ
CSAgIElNWDhNTV9HUFJfUENJRV9BVVhfRU4sDQo+ID4gKwkJCSAgIElNWDhNTV9HUFJfUENJRV9B
VVhfRU4pOw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJ
T01VWENfR1BSMTQsDQo+ID4gKwkJCSAgIElNWDhNTV9HUFJfUENJRV9QT1dFUl9PRkYsIDApOw0K
PiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJT01VWENfR1BS
MTQsDQo+ID4gKwkJCSAgIElNWDhNTV9HUFJfUENJRV9TU0NfRU4sIDApOw0KPiA+ICsNCj4gPiAr
CXJlZ21hcF91cGRhdGVfYml0cyhpbXg4X3BoeS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjE0LA0K
PiA+ICsJCQkgICBJTVg4TU1fR1BSX1BDSUVfUkVGX0NMS19TRUwsDQo+ID4gKwkJCSAgIHBhZF9t
b2RlID09IElNWDhfUENJRV9SRUZDTEtfUEFEX0lOUFVUID8NCj4gPiArCQkJICAgSU1YOE1NX0dQ
Ul9QQ0lFX1JFRl9DTEtfRVhUIDoNCj4gPiArCQkJICAgSU1YOE1NX0dQUl9QQ0lFX1JFRl9DTEtf
UExMKTsNCj4gPiArCXVzbGVlcF9yYW5nZSgxMDAsIDIwMCk7DQo+ID4gKw0KPiA+ICsJLyogRG8g
dGhlIFBIWSBjb21tb24gYmxvY2sgcmVzZXQgKi8NCj4gPiArCXJlZ21hcF91cGRhdGVfYml0cyhp
bXg4X3BoeS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjE0LA0KPiA+ICsJCQkgICBJTVg4TU1fR1BS
X1BDSUVfQ01OX1JTVCwNCj4gPiArCQkJICAgSU1YOE1NX0dQUl9QQ0lFX0NNTl9SU1QpOw0KPiA+
DQo+ID4gLQlyZXNldF9jb250cm9sX2RlYXNzZXJ0KGlteDhfcGh5LT5yZXNldCk7DQo+ID4gKwlz
d2l0Y2ggKGlteDhfcGh5LT5kcnZkYXRhLT52YXJpYW50KSB7DQo+ID4gKwljYXNlIElNWDhNUDoN
Cj4gPiArCQlyZXNldF9jb250cm9sX2RlYXNzZXJ0KGlteDhfcGh5LT5wZXJzdCk7DQo+ID4gKwkJ
ZmFsbHRocm91Z2g7DQo+ID4gKwljYXNlIElNWDhNTToNCj4gPiArCQlyZXNldF9jb250cm9sX2Rl
YXNzZXJ0KGlteDhfcGh5LT5yZXNldCk7DQo+ID4gKwkJdXNsZWVwX3JhbmdlKDIwMCwgNTAwKTsN
Cj4gPiArCQlicmVhazsNCj4gPiArCX0NCj4gPg0KPiA+ICAJLyogUG9sbGluZyB0byBjaGVjayB0
aGUgcGh5IGlzIHJlYWR5IG9yIG5vdC4gKi8NCj4gPiAtCXJldCA9IHJlYWRsX3BvbGxfdGltZW91
dChpbXg4X3BoeS0+YmFzZSArDQo+IElNWDhNTV9QQ0lFX1BIWV9DTU5fUkVHNzUsDQo+ID4gLQkJ
CQkgdmFsLCB2YWwgPT0gUENJRV9QSFlfQ01OX1JFRzc1X1BMTF9ET05FLA0KPiA+IC0JCQkJIDEw
LCAyMDAwMCk7DQo+ID4gKwlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXQoaW14OF9waHktPmJhc2Ug
Kw0KPiBJTVg4TU1fUENJRV9QSFlfQ01OX1JFRzA3NSwNCj4gPiArCQkJCSB2YWwsIHZhbCA9PSBB
TkFfUExMX0RPTkUsIDEwLCAyMDAwMCk7DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4N
Cj4gPiBAQCAtMTYwLDYgKzE4NiwyNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBoeV9vcHMgaW14
OF9wY2llX3BoeV9vcHMgPSB7DQo+ID4gIAkub3duZXIJCT0gVEhJU19NT0RVTEUsDQo+ID4gIH07
DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpbXg4X3BjaWVfcGh5X2RydmRhdGEgZHJ2
ZGF0YVtdID0gew0KPiA+ICsJW0lNWDhNTV0gPSB7DQo+ID4gKwkJLnZhcmlhbnQgPSBJTVg4TU0s
DQo+ID4gKwkJLmdwciA9ICJmc2wsaW14OG1tLWlvbXV4Yy1ncHIiLA0KPiA+ICsJfSwNCj4gPiAr
DQo+ID4gKwlbSU1YOE1QXSA9IHsNCj4gPiArCQkudmFyaWFudCA9IElNWDhNUCwNCj4gPiArCQku
Z3ByID0gImZzbCxpbXg4bXAtaW9tdXhjLWdwciIsDQo+ID4gKwl9LA0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaW14OF9wY2llX3BoeV9vZl9t
YXRjaFtdID0gew0KPiA+ICsJey5jb21wYXRpYmxlID0gImZzbCxpbXg4bW0tcGNpZS1waHkiLCAu
ZGF0YSA9ICZkcnZkYXRhW0lNWDhNTV0sIH0sDQo+ID4gKwl7LmNvbXBhdGlibGUgPSAiZnNsLGlt
eDhtcC1wY2llLXBoeSIsIC5kYXRhID0gJmRydmRhdGFbSU1YOE1QXSwgfSwNCj4gPiArCXsgfSwN
Cj4gPiArfTsNCj4gPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14OF9wY2llX3BoeV9vZl9t
YXRjaCk7DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IGlteDhfcGNpZV9waHlfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4gPiAgCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBo
eV9wcm92aWRlcjsNCj4gPiBAQCAtMTcyLDYgKzIxNyw4IEBAIHN0YXRpYyBpbnQgaW14OF9wY2ll
X3BoeV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJaWYgKCFp
bXg4X3BoeSkNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPg0KPiA+ICsJaW14OF9waHktPmRy
dmRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gPiArDQo+ID4gIAkvKiBn
ZXQgUEhZIHJlZmNsayBwYWQgbW9kZSAqLw0KPiA+ICAJb2ZfcHJvcGVydHlfcmVhZF91MzIobnAs
ICJmc2wscmVmY2xrLXBhZC1tb2RlIiwNCj4gPiAgCQkJICAgICAmaW14OF9waHktPnJlZmNsa19w
YWRfbW9kZSk7DQo+ID4gQEAgLTE5Nyw3ICsyNDQsNyBAQCBzdGF0aWMgaW50IGlteDhfcGNpZV9w
aHlfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+DQo+ID4gIAkv
KiBHcmFiIEdQUiBjb25maWcgcmVnaXN0ZXIgcmFuZ2UgKi8NCj4gPiAgCWlteDhfcGh5LT5pb211
eGNfZ3ByID0NCj4gPiAtCQkgc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZSgiZnNs
LGlteDZxLWlvbXV4Yy1ncHIiKTsNCj4gPiArCQkgc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29t
cGF0aWJsZShpbXg4X3BoeS0+ZHJ2ZGF0YS0+Z3ByKTsNCj4gPiAgCWlmIChJU19FUlIoaW14OF9w
aHktPmlvbXV4Y19ncHIpKSB7DQo+ID4gIAkJZGV2X2VycihkZXYsICJ1bmFibGUgdG8gZmluZCBp
b211eGMgcmVnaXN0ZXJzXG4iKTsNCj4gPiAgCQlyZXR1cm4gUFRSX0VSUihpbXg4X3BoeS0+aW9t
dXhjX2dwcik7IEBAIC0yMDgsNiArMjU1LDE0IEBADQo+IHN0YXRpYw0KPiA+IGludCBpbXg4X3Bj
aWVfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJZGV2X2Vy
cihkZXYsICJGYWlsZWQgdG8gZ2V0IFBDSUVQSFkgcmVzZXQgY29udHJvbFxuIik7DQo+ID4gIAkJ
cmV0dXJuIFBUUl9FUlIoaW14OF9waHktPnJlc2V0KTsNCj4gPiAgCX0NCj4gDQo+IE1pc3Npbmcg
bmV3bGluZS4NCkdvb2QgY2F1Z2h0LiBBIG5ldyBibGFuayBsaW5lIHdvdWxkIGJlIGFkZGVkIGhl
cmUgbGF0ZXIuDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hh
cmQgWmh1DQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiArCWlmIChpbXg4X3BoeS0+
ZHJ2ZGF0YS0+dmFyaWFudCA9PSBJTVg4TVApIHsNCj4gPiArCQlpbXg4X3BoeS0+cGVyc3QgPQ0K
PiA+ICsJCQlkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X2V4Y2x1c2l2ZShkZXYsICJwZXJzdCIpOw0K
PiA+ICsJCWlmIChJU19FUlIoaW14OF9waHktPnBlcnN0KSkgew0KPiA+ICsJCQlkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBnZXQgUENJRSBQSFkgUEVSU1QgY29udHJvbFxuIik7DQo+ID4gKwkJCXJl
dHVybiBQVFJfRVJSKGlteDhfcGh5LT5wZXJzdCk7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+DQo+
ID4gIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDAp
Ow0KPiA+ICAJaW14OF9waHktPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMp
OyBAQCAtMjI1LDEyICsyODAsNg0KPiA+IEBAIHN0YXRpYyBpbnQgaW14OF9wY2llX3BoeV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJcmV0dXJuIFBUUl9FUlJfT1Jf
WkVSTyhwaHlfcHJvdmlkZXIpOyAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIGlteDhfcGNpZV9waHlfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAtCXsuY29tcGF0aWJs
ZSA9ICJmc2wsaW14OG1tLXBjaWUtcGh5Iix9LA0KPiA+IC0JeyB9LA0KPiA+IC19Ow0KPiA+IC1N
T0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXg4X3BjaWVfcGh5X29mX21hdGNoKTsNCj4gPiAtDQo+
ID4gIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGlteDhfcGNpZV9waHlfZHJpdmVyID0g
ew0KPiA+ICAJLnByb2JlCT0gaW14OF9wY2llX3BoeV9wcm9iZSwNCj4gPiAgCS5kcml2ZXIgPSB7
DQo+IA0KDQo=
