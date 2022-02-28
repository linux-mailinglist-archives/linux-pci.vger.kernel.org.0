Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BEE4C61E3
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 04:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiB1Dnq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Feb 2022 22:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiB1Dnq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Feb 2022 22:43:46 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572B839836;
        Sun, 27 Feb 2022 19:43:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt24isBI0w1D4ws1G1dgoITh/vqBHhyXhDypQ7itGne0csIGMNfxiOUxyWH+QILbti9HbLna5a5F0Q5fM1FBkvOGECEQf3UwrIqg7YgqIYKO/rH0P6zs8VuRStnr+wTC+5rDlEp2BvG9xx6dQxF2UdqNEJYCajKw2pdRelmXkmvuLQj9qVU8lthX079dYiYVaQzNCzPjBef3heX5tbY8DgEXP59usM44I2EHVNoAZbQU0n4BDBMsX9F36IaKNkE2pO0nkWAWoqBLVBPrA8pvkqULkEfLmB72mjeAcvfJu8Wl+Iyc71MHZawooX7ibi26K4B7PbzWnlQE/HkO4vcCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0VUcfSIM+uDYrOSS+CUeQZnBE3vc5IdMv2w/6s2ylk=;
 b=TxLjySiwXuRItt69U5XCT3qA+YldIG4nyHAxyDEtXqW2r2nnQOBSvr8GRr/+3WQEqtgwiFLH5OZ2HSTocB9Kv5ZQtvhyHBBucjyLB7T87euwxBmN/S47Ob7V6oZZn/vI6/JjLj0Y18duxaR5v2aZsGz5dyyQa0GCu2xWj7lIMJLIKQdnSfW1mq6mu1n9S5FRIGeB/eRePMXB9FKZMf4lLexy4VepKKaI8CMoIXuJZAn10ZngYJaVg/uEsSgQZIznCM0j7kdA87g3RbUq2AA1uP8rvANNHC+TUl/gLo8RkcvOLBVnyasYa9GRCG1aWGXRl9ShjQdNlWXXblL71zW87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0VUcfSIM+uDYrOSS+CUeQZnBE3vc5IdMv2w/6s2ylk=;
 b=o/tXw/zcUVDRDqGU1Xb3eC+sGIFf+uQMbuLRKG60lfBpIM2ShGY6ZgLTuDUfVjjnyJVqA3bdjP1iNBU+TAMaXLrDdUPhW3zLNuEAL6q5EIjnfZRqgNYqTYji8zGNbaudW9u0IySfmM3r2hL73xDA7ZuPojZ5ZY4I7O+1hSkQzCg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM6PR04MB3958.eurprd04.prod.outlook.com (2603:10a6:209:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 03:43:03 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%7]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:43:03 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v8 5/8] PCI: imx6: Refine the regulator usage
Thread-Topic: [PATCH v8 5/8] PCI: imx6: Refine the regulator usage
Thread-Index: AQHYKfsvg1HUHyEWlUuoa32+k2SRDqykBDGAgAQzpNA=
Date:   Mon, 28 Feb 2022 03:43:03 +0000
Message-ID: <AS8PR04MB8676418087498F9CAF9849FD8C019@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-6-git-send-email-hongxing.zhu@nxp.com>
 <20220225094301.GA2171975@francesco-nb.int.toradex.com>
In-Reply-To: <20220225094301.GA2171975@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09adeac0-1746-4992-5ea7-08d9fa6c6c7a
x-ms-traffictypediagnostic: AM6PR04MB3958:EE_
x-microsoft-antispam-prvs: <AM6PR04MB3958A3F4207E24B45553C8E28C019@AM6PR04MB3958.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MkBsmBW7Mrx5C4sk034pJh6mCBvWTAuxJRfwaPCgNIF7lM+59Oomd0itJ28mlgoBZgkGhaYvNozqaUQiY/4iD48bnxPH2XYO0zBTMTbflNjpdkxvuEKC8SfNHN71EGdXMbttF6Pqq7IxLUPI5AJ3uly7VPx6lDyC/sNfCL9Oe4NDfiag4z+jufak7PYRp33pIBFGxToKtxfMkeJB3rGlIg2Esu13O2cxpTYY/5AGIA2mo8lm0tHctQvEqGJlF2TjVtWMQVVlu35FwreaqjR1Fm+X9q4RhDu3RwM7qzFH1e73AodGEYNwq7/1FrbcgJ4c35/TTzxgX5hVnvSDLATt6Sp4MeAEDJ3hQk0Z/1bbYTGzb6X5tk0ZqIQ0p8CKDNf8TEtflqqPPLt7Um8iZurRUaDwvG/FEzyXWW4zkYIeNmJ2WAU22k0rxuxb9n0nGg7g/JjOdzRqqd6uIbB3geV9PE9jWFf3XhnGDcaUkWe2MrLwlDItG6ogM6Fv/rmyak5sfdyEWms17EqtvhmP1v/pkJNGAZJypGLuVgn4wznNjvNfw2l5NpGF1d/a9+4cxIfxwG394wDEoEAdwXxVzCW3+z7v/+VHscI+ERxuNrgMT+E+QXrq6Q76S0DJRLFXoEkOWiOjGBzeWMX8V8y4jzIZ2eM80FK5OhxOnT1CjCHs77JbNdl4mthcEPUTPGxy3rTfW33jaPZH5B/j8Pp4iefQwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(55016003)(2906002)(52536014)(44832011)(54906003)(316002)(508600001)(26005)(186003)(86362001)(53546011)(33656002)(6506007)(7696005)(9686003)(71200400001)(83380400001)(38070700005)(38100700002)(122000001)(6916009)(66946007)(66556008)(76116006)(64756008)(66476007)(66446008)(4326008)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZG4yUjZ4R3NSRzVscDRoSlp3S3RnS1VkWXBCdEhQd2MwK3dPTk5sTXhKWDU3?=
 =?gb2312?B?VTI2YXJtWFRkcVAzWWk0alVvcWlUcjRCWXhXRHNHempLdFNkcExjR1QwUXVp?=
 =?gb2312?B?YXpxYzRDZGg1SkFFQnM3RGxrYUdkRGZpR1ViMjR5cEl5djdRaEdRZk5zTUNZ?=
 =?gb2312?B?bUk1WkdsVWVTQ0FPSE5lQUEvZ1B0YW5TZCttSEM1R3Z6cWFjZW1VTm8yN0V1?=
 =?gb2312?B?a0NFWGRlVDBuai90dnNUVnpsdlRpZDJwcnlXTnVSZTFsWE5qSHYzc0kraDFk?=
 =?gb2312?B?MGtWNWVTajlMbjRiYW9XcXVkOGZ6L3htUkhxZWZISkZwUExkc21tWkFoaXpU?=
 =?gb2312?B?VVBpaFFFMnVnRmhsaDgvNVRDL0puVEVkemhXajYxd0szT3A4WlIzTEVMU05X?=
 =?gb2312?B?RXNJNDRWL0pHTXNCMDAyeGVybUk1OXFpUk5BNTBMZUFUSURTNFFhSFNYaVg5?=
 =?gb2312?B?dEdoNWRSVUNyeEo1bDRkV1Z4cEtjZ3dzZ1JYQ3BJWWJBam44Q3JrU05vVXU0?=
 =?gb2312?B?RlNDZHJlM3A3NlFZSWpLd01jTVFXdGkzRjBsOUpJMFBjaTRjNTM3bTZPZFRw?=
 =?gb2312?B?OFkrZ0RPekZnRlUrV2RRVjM0aXhOU1Z6MlRybHA2NjJpZWFSWjNSUUNCK3JB?=
 =?gb2312?B?WkZZZVkzZ2oxOVB5b0c2dCtkL3IvdUpmbXE1clV1WnFNejdsOFpPVlFUTnhx?=
 =?gb2312?B?anZVUy9ra1l0S2tMOFVCRUlxM3Fnb1hzVTRheWEwNXBnMVNkNnV1NlhWTXJi?=
 =?gb2312?B?YlFxQ21hMmxVZUVqV3VOeFNkWUFKdVhKZG5Eand0a1JmUGRhU2RQVGtZekVY?=
 =?gb2312?B?NG1YcVJFTXB1RmU3UVJEbHc4RkgxWGJrQ3FqdFMzQUpjZFdQR3AyK0RMRHJy?=
 =?gb2312?B?SXJ1UHNSVEwzMnVXU2JaU1dJVitnaHJwdytYYytORzd2aTBNYUU4Y3p4MWhl?=
 =?gb2312?B?ODlaOWVnWTgvNDZydzhIZVN3a2kzb3lkTmJDUS9oOVpvdysvUjE5eDdGUUwv?=
 =?gb2312?B?ZzlJSHFqVnVQWW5XTlJmY3hja3lDTFZqcEZVSDFveEdiNkdnQURvaE41elBF?=
 =?gb2312?B?YmhIdE45MG90YlNsWVlJY3pmcXNrdmpvczRaQURkU1h1Y0NQOXEwOFA1L1JK?=
 =?gb2312?B?djVFd3A5WGcycmtNOTlabzVSVVVyeHdxYjFzbDA3NnJTc1dwOEZlbWxlN0V4?=
 =?gb2312?B?d1lpZ2UyVkNHYzBvOTM4dHVZMnk5S3NYRUlYZlB2UlF6eTIyOWNCNzAzbW5K?=
 =?gb2312?B?WkVHa2VrcGQ1UVo2ZVBwdW9YUS9yYjR1QnZRdDh2QnFPVHJaY1RuTU5FSjI2?=
 =?gb2312?B?R082VXdTQW9VOGw3Z1FBSVVVYWJ1RWd2Tm84b3Jza1VndDc5cTBCRG1Db0d4?=
 =?gb2312?B?cVdIT1FxZURUY3V3Ynp6MndOb0Joa291NnY0RnVtN1praGViTExxeDhQWW0r?=
 =?gb2312?B?QzZXRGM4MDNKSXh3Uk9hZzFWMndEcEdJVHZCRTF2UDNjQWVRTTlWdUl0dlZk?=
 =?gb2312?B?eHlRUFJDTWxUOEJXSWM5K1pSYXljZk0wd0hQcGVndkVQRmR0T1kvMzZlL1VX?=
 =?gb2312?B?enRpZHJLeXYzVVdsS213L1htTDNTUnNCdFBkMnRiS2d2NStwOE1lUUFaY2U0?=
 =?gb2312?B?bU9icFdGWEtWenVHdjNYdEFYeWFuREpSL1kyOFVJY084OHBWbTk2YVV4ZEQy?=
 =?gb2312?B?eU9ud09BTEZkY3R5Y1FCYnhpNC9tT1ZpdVo0dU9hQ1RpbGFoeFpEQTlDSURB?=
 =?gb2312?B?ZHlmN2VCZmhBSTJDUElJTm5lVW84Sk00MFkxYXVJMEt1NVQzMDdSanQ1QW1I?=
 =?gb2312?B?Ry9rMnBkMzl2d3MySjQ4NkVjRjRxR0xwOE5UZVF6S1I4US9OWW44dllkMTJ2?=
 =?gb2312?B?ai9Cd3lCU21GY0F1WWJweWs5SkFic2YrbnhkMjhyNjRWZjc3QUNhTk01aVd0?=
 =?gb2312?B?eVNkWXJBcGVvZnc5K2VCRjV0Vi9zTDhzT2NzaGFWZ1BhMHBHZjEveXBZYWox?=
 =?gb2312?B?dWtDdDUva2pxa3ZUMnpOZUZpOWxDQkVwUjN0bWp6elFxSitEcitkMkluNUUz?=
 =?gb2312?B?aWJtWkc2ZXhvSmtyVytQRHRPRXA3WHpxQzMxUGlMbVY3VGdMVXRqN3RGallS?=
 =?gb2312?B?bm9XQm5OR2psZldVd2tnWUM5U1JkcXlhN1pyRmhDZWhpY055ZTBicjdpejNF?=
 =?gb2312?B?d0E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09adeac0-1746-4992-5ea7-08d9fa6c6c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 03:43:03.1756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KzH77RkZmoLylj9h6TFmE/qvqQJSEsCdcpre9fgBDPOwepig0QycMSlrLtpqhiIRd1FI0tjp8TSuJhGAFRQSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3958
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFNlbnQ6IDIwMjLE6jLUwjI1yNUgMTc6
NDMNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsLnN0
YWNoQHBlbmd1dHJvbml4LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBicm9vbmllQGtlcm5lbC5v
cmc7DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGppbmdvb2hhbjFAZ21haWwuY29tOyBm
ZXN0ZXZhbUBnbWFpbC5jb207DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOyBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OCA1LzhdIFBDSTogaW14NjogUmVmaW5lIHRoZSByZWd1bGF0b3IgdXNhZ2UNCj4gDQo+
IE9uIEZyaSwgRmViIDI1LCAyMDIyIGF0IDExOjQ0OjI0QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdy
b3RlOg0KPiA+IFRoZSBkcml2ZXIgc2hvdWxkIHVuZG8gYW55IGVuYWJsZXMgaXQgZGlkIGl0c2Vs
Zi4gVGhlIHJlZ3VsYXRvcg0KPiA+IGRpc2FibGUgc2hvdWxkbid0IGJlIGJhc2luZyBkZWNpc2lv
bnMgb24gcmVndWxhdG9yX2lzX2VuYWJsZWQoKS4NCj4gPg0KPiA+IFRvIGtlZXAgdGhlIGJhbGFu
Y2Ugb2YgdGhlIHJlZ3VsYXRvciB1c2FnZSBjb3VudGVyLCBkaXNhYmxlIHRoZQ0KPiA+IHJlZ3Vs
YXRvciBqdXN0IGJlaGluZCBvZiBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSBpbiByZXN1
bWUgYW5kDQo+IHNodXRkb3duLg0KPiANCj4gV2hpbGUgdGhpcyBwYXRjaCBkb2VzIG5vdCBsb29r
IHdyb25nIGFuZCBpbXByb3ZpbmcgdGhlIGV4aXN0aW5nIGNvZGUsIEkgZG8NCj4gaGF2ZSBhIGNv
dXBsZSBvZiBjb25jZXJuLg0KPiANCj4gMS4gSXQncyB3ZWlyZCB0aGF0IHJlZ3VsYXRvciBlbmFi
bGUvZGlzYWJsZSBhcmUgcmVhbGx5IG5vbiBzeW1tZXRyaWMgaW4gdGhlIGNvZGUsDQo+IGVuYWJs
ZSBpcyBpbiBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpLCB3aGlsZSBkaXNhYmxlIGlz
IG5vdCBpbg0KPiBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSBidXQgc3ByZWFkIGFyb3Vu
ZC4NCkhpIEZyYW5jZXNjbzoNClRoaXMgcmVndWxhdG9yIGRpc2FibGUgd2FzIGEgcGFydCBvZiBp
bXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSBiZWZvcmUsDQoganVzdCBoYWQgYmVlbiBtb3Zl
ZCBvdXQgb2YgaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KCkgaW4gdGhpcyByZWZpbmUNCiBj
b21taXQuDQoNCj4gDQo+IDIuIFdlIGFyZSBwbGF5aW5nIGFyb3VuZCB3aXRoIHZwY2llIGR1cmlu
ZyByZWd1bGF0b3IgZHVyaW5nIHN1c3BlbmQvcmVzdW1lLA0KPiB3aHk/IFdlIGN1cnJlbnRseSBo
YXZlIGlzc3VlIHdpdGggc3VzcGVuZC9yZXN1bWUgd2hlbiBhIFBDSWUgc3dpdGNoIGlzDQo+IHRo
ZXJlLCB3aXRoIHRoZSBmaW5hbCBlZmZlY3Qgb2YgUENJZSBiZWluZyBub3QgdXNhYmxlIGFmdGVy
d2FyZC4gSSBmZWFyIGxpa2UgdGhpcyBpcw0KPiByZWxhdGVkIHRvIG91ciBpc3N1ZS4NCj4NClRv
IG15IHVuZGVyc3RhbmRzLCB0aGUgVlBDSUUgaXMgdGhlIGFic3RyYWN0IG9mIHRoZSBESUVTQUJM
RSMgc2lnbmFsLg0KUmVmZXIgdG8gdGhlIENoYXB0ZXIgMy4xLjEyLjMgV19ESVNBQkxFIyBTaWdu
YWwgb2YgUENJIEV4cHJlc3MgTS4yIFNQRUMuDQpUaGVzZSBzaWduYWxzIGFyZSB1c2VkIHRvIGRp
c2FibGUgdGhlIEFkYXB0ZXIncyByYWRpbyBvcGVyYXRpb24gdG8gbWVldCBwdWJsaWMNClNhZmV0
eSByZWd1bGF0aW9ucyBvciB3aGVuIG90aGVyd2lzZSBkZXNpcmVkLg0KSXQncyByZWFzb25hYmxl
IHRvIGFzc2VydC9kZS1hc3NlcnQgV19ESVNBQkxFIyBzaWduYWwgZHVyaW5nIHN1c3BlbmQvcmVz
dW1lLg0KDQo+IFdoYXQgYWJvdXQgdnBjaWUgZW5hYmxlIGluIHByb2JlLCBhbmQgdnBjaWUgZGlz
YWJsZSBpbiBzaHV0ZG93biBhbmQgdGhhdCdzDQo+IGFsbD8NClRoZSBXX0RJU0FCTEUjIFNpZ25h
bCBpcyB1c2VkIHRvIGNvbnRyb2wgdGhlIHJhZGlvcyBvbiB0aGUgQWRhcHRlcnMuDQpJIHRoaW5r
IHlvdSBjYW4gZG8gdGhhdCwgaWYgdGhlIHJhZGlvcyBhcmUgYWx3YXlzIG9uIGluIHlvdXIgc3lz
dGVtLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQNCj4gDQo+IEZyYW5jZXNjbw0KPiANCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDE5ICsr
KysrKystLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+IGluZGV4IDBmMWI4Yzg3M2E0YS4uMTYwYTBiZDAyMDk4IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTM2OSw4ICszNjks
NiBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9hdHRhY2hfcGQoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiA+DQo+ID4gIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1Y3Qg
aW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4gew0KPiA+IC0Jc3RydWN0IGRldmljZSAqZGV2ID0g
aW14Nl9wY2llLT5wY2ktPmRldjsNCj4gPiAtDQo+ID4gIAlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2
ZGF0YS0+dmFyaWFudCkgew0KPiA+ICAJY2FzZSBJTVg3RDoNCj4gPiAgCWNhc2UgSU1YOE1ROg0K
PiA+IEBAIC00MDAsMTQgKzM5OCw2IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9hc3NlcnRfY29y
ZV9yZXNldChzdHJ1Y3QNCj4gaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4gIAkJCQkgICBJTVg2
UV9HUFIxX1BDSUVfUkVGX0NMS19FTiwgMCA8PCAxNik7DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAl9
DQo+ID4gLQ0KPiA+IC0JaWYgKGlteDZfcGNpZS0+dnBjaWUgJiYgcmVndWxhdG9yX2lzX2VuYWJs
ZWQoaW14Nl9wY2llLT52cGNpZSkgPiAwKSB7DQo+ID4gLQkJaW50IHJldCA9IHJlZ3VsYXRvcl9k
aXNhYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+IC0NCj4gPiAtCQlpZiAocmV0KQ0KPiA+IC0J
CQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBkaXNhYmxlIHZwY2llIHJlZ3VsYXRvcjogJWRcbiIs
DQo+ID4gLQkJCQlyZXQpOw0KPiA+IC0JfQ0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIHVuc2ln
bmVkIGludCBpbXg2X3BjaWVfZ3JwX29mZnNldChjb25zdCBzdHJ1Y3QgaW14Nl9wY2llDQo+ID4g
KmlteDZfcGNpZSkgQEAgLTU4NCw3ICs1NzQsNyBAQCBzdGF0aWMgaW50DQo+IGlteDZfcGNpZV9k
ZWFzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPiAgCXN0
cnVjdCBkZXZpY2UgKmRldiA9IHBjaS0+ZGV2Ow0KPiA+ICAJaW50IHJldCwgZXJyOw0KPiA+DQo+
ID4gLQlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiAhcmVndWxhdG9yX2lzX2VuYWJsZWQoaW14Nl9w
Y2llLT52cGNpZSkpIHsNCj4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKSB7DQo+ID4gIAkJcmV0
ID0gcmVndWxhdG9yX2VuYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgCQlpZiAocmV0KSB7
DQo+ID4gIAkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSB2cGNpZSByZWd1bGF0b3I6
ICVkXG4iLCBAQA0KPiAtNjU3LDcNCj4gPiArNjQ3LDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVf
ZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QgaW14Nl9wY2llDQo+ICppbXg2X3BjaWUpDQo+ID4g
IAlyZXR1cm4gMDsNCj4gPg0KPiA+ICBlcnJfY2xrczoNCj4gPiAtCWlmIChpbXg2X3BjaWUtPnZw
Y2llICYmIHJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0+dnBjaWUpID4gMCkgew0KPiA+
ICsJaWYgKGlteDZfcGNpZS0+dnBjaWUpIHsNCj4gPiAgCQlyZXQgPSByZWd1bGF0b3JfZGlzYWJs
ZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgCQlpZiAocmV0KQ0KPiA+ICAJCQlkZXZfZXJyKGRl
diwgImZhaWxlZCB0byBkaXNhYmxlIHZwY2llIHJlZ3VsYXRvcjogJWRcbiIsIEBADQo+IC0xMDI5
LDYNCj4gPiArMTAxOSw5IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Jlc3VtZV9ub2lycShzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4NCj4gPiAgCWlteDZfcGNpZV9h
c3NlcnRfY29yZV9yZXNldChpbXg2X3BjaWUpOw0KPiA+ICsJaWYgKGlteDZfcGNpZS0+dnBjaWUp
DQo+ID4gKwkJcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+ID4gKw0KPiA+
ICAJaW14Nl9wY2llX2luaXRfcGh5KGlteDZfcGNpZSk7DQo+ID4gIAlpbXg2X3BjaWVfZGVhc3Nl
cnRfY29yZV9yZXNldChpbXg2X3BjaWUpOw0KPiA+ICAJZHdfcGNpZV9zZXR1cF9yYyhwcCk7DQo+
ID4gQEAgLTEyNjIsNiArMTI1NSw4IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9zaHV0ZG93bihz
dHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4NCj4gPiAgCS8qIGJyaW5nIGRv
d24gbGluaywgc28gYm9vdGxvYWRlciBnZXRzIGNsZWFuIHN0YXRlIGluIGNhc2Ugb2YgcmVib290
ICovDQo+ID4gIAlpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoaW14Nl9wY2llKTsNCj4gPiAr
CWlmIChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+ICsJCXJlZ3VsYXRvcl9kaXNhYmxlKGlteDZfcGNp
ZS0+dnBjaWUpOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXg2X3Bj
aWVfZHJ2ZGF0YSBkcnZkYXRhW10gPSB7DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
