Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC334B82EE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiBPIYe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 03:24:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBPIYd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 03:24:33 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10046.outbound.protection.outlook.com [40.107.1.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB70274CAA
        for <linux-pci@vger.kernel.org>; Wed, 16 Feb 2022 00:24:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8WaPaSBKoX3bIezktpjIRlNxx/YpgnL6CKMIevKutGNQN5M2pDX6kpcG0QuklznPz6fjjgWIcJFKYT+Wy5eIhXhVh+EIdoIMpFAPM6HkA+9zKd03wfPva8r7gKGwSzdkM3vH7u7rKlVzZaIYxT+bzkMUS/Qf+k2STpxo3yP6C9m01sUYRX1y4eqBBXlV27rSqKBA8lKjJrnOJBHEtg8Ltn3vMO7KMPXg5LM0JxeoHExhTvecbB9my11qY8nl4uhG0yrCGJWkSYlrXANRrHBSN/+4jQdEDZ8T2AKJpYnbcDjl9Gj2qy9VTMQujemqPNI28EYUk1YedZAGRPh649hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k99CmMG6yc+4pabcB4UttBiq+aWECtrGHoULX/gzCis=;
 b=cg8V1wyCxY2BvNhh97IermEizCW4GCutHlxKeHoNWoYS5m4HiQW8Vl4DCmohywK8w8D2ko5dzPAmBSFMaArfVvGGqx/AM9zwgFxnDL9MbQkJ9OOR515RN36TMNy05PRx0KIXJjTo7QTWTestVRIJeQ3zYm58kdvh0rqN9xNzFGzvsqHbXFtG+dq/X7YHf2iySE9U+bvPlueUClHliX9JFIGPGgis337fWOJm0KZPHp4prK+ZAJj5YogVuyk5FOy4gZjhsYb/mZSBAZLhz1p7bR208Oc0TQVRjyB0l2uuvetTVBQ7R3hZfzjCEwFUFPg0/UR+qiAZghzZn5D4I+4v4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k99CmMG6yc+4pabcB4UttBiq+aWECtrGHoULX/gzCis=;
 b=K1ncutQUYag7zIcuM5L/50gN2zAkNFx+vTbMivwk3JUMiPyBj/SIxGTFXmhdEf49ZZsneiT5Og52HzTx45vCp1NAFx3oiE6cmGvbpHhLd/AZKz6uVAGIZJ2Tvk8EwMXHH1jHWxVi3z/k/ngexxVFU9Y1y/CPjKRydftjrMQSRsk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB5506.eurprd04.prod.outlook.com (2603:10a6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 08:24:17 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4975.018; Wed, 16 Feb 2022
 08:24:17 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] PCI: imx6: Fix PERST# start-up sequence
Thread-Topic: [PATCH v2] PCI: imx6: Fix PERST# start-up sequence
Thread-Index: AQHYIb4XaEcFdGrYn0+5xmDfxlrd9qyVyafw
Date:   Wed, 16 Feb 2022 08:24:17 +0000
Message-ID: <AS8PR04MB86768CFB51197C865209898D8C359@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220214161522.102810-1-francesco.dolcini@toradex.com>
In-Reply-To: <20220214161522.102810-1-francesco.dolcini@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ef504fc-dc45-4d12-4839-08d9f125b98a
x-ms-traffictypediagnostic: AM0PR04MB5506:EE_
x-microsoft-antispam-prvs: <AM0PR04MB5506DED326FEA32BF7C8E17A8C359@AM0PR04MB5506.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+MgAEYxoZ30z4wLHcLGdti2ex65TfHhQIzR6Chfj7ci60P950IGXNqQVXAC+vv3Lmg42niPYZE9fK/S0TOEsxZ2qpt7KcVGIgrB65JPaOylyaNZWRZY2Vd9YgVmGaMBi4KGEym7i8V/3nqAtYfpg/7iTZqb4ccMI6ayGf7YNGwFNXgA2GJ8QXQcUn9i9Qt1diqfFnPlDhYrSXhG+Ztvmm6a2JI7r7RxG3w2XK5mh8VJuufIHVtq2sOGROMPVXdadgMpo7rC/MF/+r/sBsswKsQFMaZaOC8nNOlEC1CIWBYK6pHEl0V+m5+dufHAsNdjkkvo9oroqf0O1jyqah55OhekFsZUgwgxmBpI2b91/8rYbzDX8bXuRFJFpXrAafU0REhPMFKvhS6ukL/HzBrwzJ1De7EqgfKTkHz5j9V2p6brjEwFdmojxu81KwbbnDz8yxHCdsQnltIYIfBwEfP80s1WmiyAr6GR1LYqr3Sc9rknJl+7/TBbRs8q4iHZTyvJKhwh1FfsEXQNl2GYcwglpwzRPKbjg9R3pqKGZaOHwZtrXcE9i+b/qhqwO6OJqQouA3JMlOh0HByI9QZ7QQpy/2y12Yh6gk6tiT6mKGqBpWJSqZI73Rvmcb34szehd+PsUZMFwy7Ipxj2b0C2tMDBUdzSp+0Vc8bGzjDMw7aTWuIidWpf4kE6ke7Giy7TW1eKFv00wKrNuoYidyE+xoEs90GRcd/8iXS/Fei8tVKThNgPCMd6Brg+UWwNH3roCtQXAqwFOErFVBr2R5L/QPda1UATCRJXja2ovUS5mnfS+NM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(52536014)(44832011)(4326008)(8936002)(86362001)(38070700005)(38100700002)(8676002)(186003)(122000001)(7416002)(26005)(508600001)(66574015)(71200400001)(966005)(45080400002)(53546011)(9686003)(7696005)(6506007)(76116006)(64756008)(66476007)(66556008)(66946007)(110136005)(66446008)(83380400001)(55016003)(33656002)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Zk1qTHdnbXVEYWtUOHBJUVpqMnZtWFMzK3ZvTmN5WGZYUExpK09mWktUVnp1?=
 =?gb2312?B?b0dLUk1UdGRJSysvL0szVVFnZlBZMldWeFdtY1dqaUl5Q1VaeXJiTkdpUFZh?=
 =?gb2312?B?Q1lnUFp4Z3NwcnpkOGxYRnQweENBbVJqeFFjV0laMnExV014ZlF4cUpJOTZw?=
 =?gb2312?B?c1NDUUFXdnhBbTFHYUJ2b0FobjR5MktrZTZqa2dBSnhHRnp2WHVXVmw4bEtS?=
 =?gb2312?B?cnpxcVNzZERUMGMyRHVyOTdjdHNSUHBUT0JVdDZGVk9BeHRCS0ZXZjJ5QmFG?=
 =?gb2312?B?NlRlYVRMQ05JTE9sYjFEOE13ZktGR3o4T3c2YkZ6aDlRRkJYTk5lUDNhaWlm?=
 =?gb2312?B?RjdkekZKcFN3MHkrT1NkOTgweEFFb3oyRGF2MGRTT0dkTTRYVTl3WWtnL01i?=
 =?gb2312?B?TWoxS3BWY1ltYTdFWmF4Z2tmbTZTb1lnK3B5bXhKV2drVm9rMzdyeHJzQ2RD?=
 =?gb2312?B?b3Ywa3VKUjdGV01wWmRmSnk1bnFOM3R1L2dmdkIyZlRrMjFWbWRwb3p0SmxP?=
 =?gb2312?B?MXByOTdXNGJObEVkNHNDd2x1K0VsNmg4RmpneUxOVVU4YW9yUDdRZmFIbzFS?=
 =?gb2312?B?ckZ3cDFnNFN1Rksrb05IT1JqS0tyUUxjYjdUSmdRdlVOSkVIK0pRTkQ4RzhW?=
 =?gb2312?B?Q0VIbWk0S081LzhmdVBYMDF4YlhmcGN4SGdUMHh1dnU4ZEROVEtFWjZwakdK?=
 =?gb2312?B?SUtpak80ZXVCWW41Vlp3TFJoQ216Y2xNUDF4d1kvNi9BYVdRTi9xbUZPRHJS?=
 =?gb2312?B?YjNLUyszWkljaHQ2UmliSGFoMUp2SEpDdzJjYkZFUUw2YUZuNU1MR1lDSjlJ?=
 =?gb2312?B?VTlZOXROeDFybGM1Y3FHbklocVMyby9mdm9mTGpadm1JbDNyVWIxRGNLRjVi?=
 =?gb2312?B?c203SFN3SmZtVnVkcU5HVWovZlc5OWNDTlk3bmx2eWVTaFowUWFDVnRJeG5Y?=
 =?gb2312?B?cUg4Nk5LTjhoRWE3S3RKdVBWaG42UEVaQ1owYy9adFo2UFNVamp3eU5PZXds?=
 =?gb2312?B?OC9ZczBTU3YzT3kzdzdFUUpMTU1oakZ1cVk5RzZvL1ZmVXdSWVNmdXgyZ2dI?=
 =?gb2312?B?SExlUUFGYlF5czl0YndrcFprNDl1Wkk1ZWRjODgxYWVaMTkzRkxCVGVZbjBV?=
 =?gb2312?B?Unp2cnpzTmk4dVRsNlBKUWJIc21WelU1YjJiMmtJdXVjNHE0Vmp5RWRRdGtp?=
 =?gb2312?B?N3B2eEJVZDh4ZFNuQmJhNkc4ajJPNWxCcFVJMmE4UUdKbHQwUTZhejBwbVpB?=
 =?gb2312?B?SlRwajJXOXlMeFhJbHpyNGZwd3VzOGx5d29jSHhyQjV6ZHp1Y0I4eUV3REJ0?=
 =?gb2312?B?OS9kQlBSSGR6dWZWYitzRjAzQTJjUkZ2UjdMazBydzBzbC9kUGt4dFlhRUNr?=
 =?gb2312?B?cGxUaVByL051ZlRSeHEyazlmMTRIc0tDSEE1Wk9md0x1ZnJuRHZhN0JDbHA5?=
 =?gb2312?B?MXByOStJZHNRRHN1T0xpNGxyK2JXNVdScTB5NXgyY3dOcloxSmRVZkRPYzY1?=
 =?gb2312?B?VVVSRTh0Z085NWRWRlVTM1hHRFE2VzZBdjJUdmNLMFYzQUlsL0tueXBYOVBJ?=
 =?gb2312?B?SnVUVi9DdWtJRE5xRWxmNHRmbnFXUkUxQjZZam95MXVTUDY4YWU5ZFNDMlFC?=
 =?gb2312?B?QzVieFBKcmNHOHZobUlIRk5aZVFIS0J4czlERVZ1Y1g4bHZ5NTV5RVY3UEIy?=
 =?gb2312?B?bEVoWjFCSjVxVkcrdEdvTWRDb0hlcThPRm9qOEltTm4wdTUvdHduWGJJVXFp?=
 =?gb2312?B?VE5LbTNnL21PaC9EbCtDSS9pTXdFNnZFWVdxV3ZQZHc1RFR6ekVKOEZWdWNN?=
 =?gb2312?B?d1hxenJ0VmdaM3VWK2xISWM2a3FXQlF6OE40dXc2MSsxWFhTcUtvV3gxODN1?=
 =?gb2312?B?bHhuOVoxb2NSeEhXSEh4em9QSHFRSkdzeXA1a1JubkhXMHBNTEFHMlo4aUtW?=
 =?gb2312?B?cms0OTZWTkZDUi90UUt4anNPWndQUHgwT0VQV1ZqZ3I5QkdaNDR2c2NTK0Zt?=
 =?gb2312?B?bVNvWGlkZGV3eDEzV05ibDJKVEJGdUtNck0wOVpZcnduV2ZGQWlHcEcyN0Ju?=
 =?gb2312?B?M2liQ3RYa2RzQUFVZXRFVkhKSmtvQ0RTbWZkd3pGa2hVOXJaanNIS05DSGo3?=
 =?gb2312?B?QkdFSHlYS3FqbkpobCt1ZXJIM3Q0NDRjR21zWTYxQytqRys4cUh6Z2d0ajhC?=
 =?gb2312?B?Nmc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef504fc-dc45-4d12-4839-08d9f125b98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 08:24:17.8098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lgj7KE1Ywpw+MUtoVSFt1YwYT1qbLHpwBc9RlAsOgXn5aCCdXRe42aEcc5E2a31NydVKIkm1KCagMIQjgbg+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5506
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
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFNlbnQ6IDIwMjLE6jLUwjE1yNUgMDox
NQ0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IEx1Y2FzIFN0YWNo
DQo+IDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPjsgTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8u
cGllcmFsaXNpQGFybS5jb20+OyBSb2INCj4gSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6
eXN6dG9mIFdpbGN6eai9c2tpIDxrd0BsaW51eC5jb20+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwg
VGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1A
Z21haWwuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEJqb3JuIEhlbGdh
YXMNCj4gPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gQ2M6IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFu
Y2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVs
Lm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47DQo+IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIFBDSTogaW14NjogRml4IFBFUlNUIyBzdGFydC11cCBzZXF1
ZW5jZQ0KPiANCj4gQWNjb3JkaW5nIHRvIHRoZSBQQ0llIHN0YW5kYXJkIHRoZSBQRVJTVCMgc2ln
bmFsIChyZXNldC1ncGlvIGluDQo+IGZzbCxpbXgqIGNvbXBhdGlibGUgZHRzKSBzaG91bGQgYmUg
a2VwdCBhc3NlcnRlZCBmb3IgYXQgbGVhc3QgMTAwIHVzZWMgYmVmb3JlDQo+IHRoZSBQQ0llIHJl
ZmNsb2NrIGlzIHN0YWJsZSwgc2hvdWxkIGJlIGtlcHQgYXNzZXJ0ZWQgZm9yIGF0IGxlYXN0IDEw
MCBtc2VjIGFmdGVyDQo+IHRoZSBwb3dlciByYWlscyBhcmUgc3RhYmxlIGFuZCB0aGUgaG9zdCBz
aG91bGQgd2FpdCBhdCBsZWFzdCAxMDAgbXNlYyBhZnRlciBpdCBpcw0KPiBkZS1hc3NlcnRlZCBi
ZWZvcmUgYWNjZXNzaW5nIHRoZSBjb25maWd1cmF0aW9uIHNwYWNlIG9mIGFueSBhdHRhY2hlZCBk
ZXZpY2UuDQo+IA0KPiBGcm9tIFBDSWUgQ0VNIHIyLjAsIHNlYyAyLjYuMg0KPiANCj4gICBULVBW
UEVSTDogUG93ZXIgc3RhYmxlIHRvIFBFUlNUIyBpbmFjdGl2ZSAtIDEwMCBtc2VjDQo+ICAgVC1Q
RVJTVC1DTEs6IFJFRkNMSyBzdGFibGUgYmVmb3JlIFBFUlNUIyBpbmFjdGl2ZSAtIDEwMCB1c2Vj
Lg0KPiANCj4gRnJvbSBQQ0llIHI1LjAsIHNlYyA2LjYuMQ0KPiANCj4gICBXaXRoIGEgRG93bnN0
cmVhbSBQb3J0IHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBMaW5rIHNwZWVkcyBncmVhdGVyIHRoYW4N
Cj4gICA1LjAgR1Qvcywgc29mdHdhcmUgbXVzdCB3YWl0IGEgbWluaW11bSBvZiAxMDAgbXMgYmVm
b3JlIHNlbmRpbmcgYQ0KPiAgIENvbmZpZ3VyYXRpb24gUmVxdWVzdCB0byB0aGUgZGV2aWNlIGlt
bWVkaWF0ZWx5IGJlbG93IHRoYXQgUG9ydC4NCj4gDQo+IEZhaWx1cmUgdG8gZG8gc28gY291bGQg
cHJldmVudCBQQ0llIGRldmljZXMgdG8gYmUgd29ya2luZyBjb3JyZWN0bHksIGFuZCB0aGlzDQo+
IHdhcyBleHBlcmllbmNlZCB3aXRoIHJlYWwgZGV2aWNlcy4NCj4gDQo+IE1vdmUgcmVzZXQgYXNz
ZXJ0IHRvIGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldCgpLCB0aGlzIHdheSB3ZSBlbnN1cmUg
dGhhdA0KPiBQRVJTVCMgaXMgYXNzZXJ0ZWQgYmVmb3JlIGVuYWJsaW5nIGFueSBjbG9jaywgbW92
ZSBkZS1hc3NlcnQgdG8gdGhlIGVuZCBvZg0KPiBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNl
dCgpIGFmdGVyIHRoZSBjbG9jayBpcyBlbmFibGVkIGFuZCBkZWVtZWQgc3RhYmxlDQo+IGFuZCBh
ZGQgYSBuZXcgZGVsYXkgb2YgMTAwIG1zZWMganVzdCBhZnRlcndhcmQuDQo+IA0KPiBMaW5rOg0K
PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZsb3JlLmtlcg0KPiBuZWwub3JnJTJGYWxsJTJGMjAyMjAyMTExNTI1NTAuMjg2
ODIxLTEtZnJhbmNlc2NvLmRvbGNpbmklNDB0b3JhZGV4LmNvDQo+IG0mYW1wO2RhdGE9MDQlN0Mw
MSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0MyODkzOWRjYjc4YTg0NjBmDQo+IGMzZGIwOGQ5
ZWZkNTM4Y2IlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDDQo+
IDYzNzgwNDUyMTMzNTY2NDI0OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdM
akF3DQo+IE1EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNE
JTdDMzAwMCZhbXA7c2RhDQo+IHRhPWw3dmppSjNLdUVSbWFXWU15MDlzdkVMY1VjSTFla0xKUFZL
cHQwQVZpVG8lM0QmYW1wO3Jlc2VydmVkPTANCj4gRml4ZXM6IGJiMzg5MTllYzU2ZSAoIlBDSTog
aW14NjogQWRkIHN1cHBvcnQgZm9yIGkuTVg2IFBDSWUgY29udHJvbGxlciIpDQo+IFNpZ25lZC1v
ZmYtYnk6IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT4N
ClRoYW5rcy4NCkFja2VkLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQoN
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gLS0tDQo+IHYyOiBBZGQgY29tcGxldGUgcmVm
ZXJlbmNlIHRvIHRoZSBQQ0llIHN0YW5kYXJkcywgcy9QQ0ktRS9QQ0llL2cNCj4gLS0tDQo+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMjMgKysrKysrKysrKysrKyst
LS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1p
bXg2LmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGluZGV4
IDdiMjAwYjY2MTE0YS4uNzNiYWEyMDQ0Y2NmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gQEAgLTQwOCw2ICs0MDgsMTEgQEAgc3RhdGljIHZvaWQgaW14Nl9w
Y2llX2Fzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4g
IAkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGRpc2FibGUgdnBjaWUgcmVndWxhdG9yOiAlZFxu
IiwNCj4gIAkJCQlyZXQpOw0KPiAgCX0NCj4gKw0KPiArCS8qIFNvbWUgYm9hcmRzIGRvbid0IGhh
dmUgUENJZSByZXNldCBHUElPLiAqLw0KPiArCWlmIChncGlvX2lzX3ZhbGlkKGlteDZfcGNpZS0+
cmVzZXRfZ3BpbykpDQo+ICsJCWdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwKGlteDZfcGNpZS0+cmVz
ZXRfZ3BpbywNCj4gKwkJCQkJaW14Nl9wY2llLT5ncGlvX2FjdGl2ZV9oaWdoKTsNCj4gIH0NCj4g
DQo+ICBzdGF0aWMgdW5zaWduZWQgaW50IGlteDZfcGNpZV9ncnBfb2Zmc2V0KGNvbnN0IHN0cnVj
dCBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gQEAgLTU0NCwxNSArNTQ5LDYgQEAgc3RhdGljIHZv
aWQgaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+IGlteDZfcGNpZSAqaW14
Nl9wY2llKQ0KPiAgCS8qIGFsbG93IHRoZSBjbG9ja3MgdG8gc3RhYmlsaXplICovDQo+ICAJdXNs
ZWVwX3JhbmdlKDIwMCwgNTAwKTsNCj4gDQo+IC0JLyogU29tZSBib2FyZHMgZG9uJ3QgaGF2ZSBQ
Q0llIHJlc2V0IEdQSU8uICovDQo+IC0JaWYgKGdwaW9faXNfdmFsaWQoaW14Nl9wY2llLT5yZXNl
dF9ncGlvKSkgew0KPiAtCQlncGlvX3NldF92YWx1ZV9jYW5zbGVlcChpbXg2X3BjaWUtPnJlc2V0
X2dwaW8sDQo+IC0JCQkJCWlteDZfcGNpZS0+Z3Bpb19hY3RpdmVfaGlnaCk7DQo+IC0JCW1zbGVl
cCgxMDApOw0KPiAtCQlncGlvX3NldF92YWx1ZV9jYW5zbGVlcChpbXg2X3BjaWUtPnJlc2V0X2dw
aW8sDQo+IC0JCQkJCSFpbXg2X3BjaWUtPmdwaW9fYWN0aXZlX2hpZ2gpOw0KPiAtCX0NCj4gLQ0K
PiAgCXN3aXRjaCAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50KSB7DQo+ICAJY2FzZSBJTVg4
TVE6DQo+ICAJCXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaW14Nl9wY2llLT5wY2llcGh5X3Jlc2V0
KTsNCj4gQEAgLTU5OSw2ICs1OTUsMTUgQEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2RlYXNzZXJ0
X2NvcmVfcmVzZXQoc3RydWN0DQo+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiAgCQlicmVhazsN
Cj4gIAl9DQo+IA0KPiArCS8qIFNvbWUgYm9hcmRzIGRvbid0IGhhdmUgUENJZSByZXNldCBHUElP
LiAqLw0KPiArCWlmIChncGlvX2lzX3ZhbGlkKGlteDZfcGNpZS0+cmVzZXRfZ3BpbykpIHsNCj4g
KwkJbXNsZWVwKDEwMCk7DQo+ICsJCWdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwKGlteDZfcGNpZS0+
cmVzZXRfZ3BpbywNCj4gKwkJCQkJIWlteDZfcGNpZS0+Z3Bpb19hY3RpdmVfaGlnaCk7DQo+ICsJ
CS8qIFdhaXQgZm9yIDEwMG1zIGFmdGVyIFBFUlNUIyBkZWFzc2VydGlvbiAoUENJZSByNS4wLCA2
LjYuMSkgKi8NCj4gKwkJbXNsZWVwKDEwMCk7DQo+ICsJfQ0KPiArDQo+ICAJcmV0dXJuOw0KPiAN
Cj4gIGVycl9yZWZfY2xrOg0KPiAtLQ0KPiAyLjI1LjENCg==
