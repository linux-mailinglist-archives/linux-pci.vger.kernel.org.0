Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB745736AF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 14:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiGMMzV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiGMMzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 08:55:21 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ACA7393D;
        Wed, 13 Jul 2022 05:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAO1TF5C/eOGuqWeZtLRX9SfrPhS+vFb1k6MqwOAvjOBAdrJQ2FsYWkA2LCDuiXL5+0YApUMaIRJEKQz+eqcZMWaPmUb/PEkLV/u+zaMfFyqpVVp5OaRg6IHZX1ws8W3cPFfw1E/TRKyatKd4ZJ1I2AEEMO2pEEoWLOEnuH11e9+fjYXW9HRgaEB6kUJ9fvjqICVUp+L7NPYDMmxEfV7F7prK4HD4+I91+XwWjezO0K/2Z92m0VuVEqa/tYOUPGplYaLdrH1GOi7dvL8nAfPjfAez9HrPAxJYsJaXsbRzZ2HueoMqjZI4YigYHw7W1syVn4IJfAMDIwS3aPtc06DDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6NYgX4WjmQEKhEq4EkWLMPuWUTEUWRI0Bd5XgzAf34=;
 b=ec2sAgvkOKdtAsf3MQBva0Zvia30CnAhOy3xwOieQ1O+gQmkM/rYj4eZx3uEparFu6iLs/3nKOfyAoORt82cBK4hGi/+DG0SPb0Crsl7b4NOBWp96qwzBbb2Z7giL50fwhPqPulXZh51IK5Qaa2itSSGm8e4ulINgMjPc1rmdxdeeIb3qMrZ6hNBusLcHmofwGgCyvyha4Wuw9hJvUYIr4Tw1lQcpJgsGiBYxO1i37EhqHVi63iBdE0xI/pqZXfN9ybcEG6F5qBfjpynEfWx4NClK9nlSV26TxMRK6dcrwOs8FAg1A70gEpDdwNO3Q8l8oF/8j5ZfMoLlEcyydPuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6NYgX4WjmQEKhEq4EkWLMPuWUTEUWRI0Bd5XgzAf34=;
 b=j3uQm/YojnLIj8O80erRDUd63rp91VPgPTtH51vHw4Q65M5/BDnTrs+6WDr6cBMwlKt6bWdeJ528mjKJG7i94ArSE6T9J87DEDXVyQ5g3S7H8ueYY8C3jrzN4wUIQ6/5LZ0uAzICKgxwtCsjjRr2c3Mehfe6fvWcV+Mx9AirHRo=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by HE1PR04MB3081.eurprd04.prod.outlook.com (2603:10a6:7:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 12:55:14 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%7]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 12:55:14 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 10/17] PCI: imx6: Turn off regulator when system is in
 suspend mode
Thread-Topic: [PATCH v14 10/17] PCI: imx6: Turn off regulator when system is
 in suspend mode
Thread-Index: AQHYjPxOJfW03qc+LUO9IW8deJoxCK18DLgAgAAQtCCAAB5gAIAAGSXQ
Date:   Wed, 13 Jul 2022 12:55:14 +0000
Message-ID: <AS8PR04MB8676238B47BA35890CC1F8B18C899@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-11-git-send-email-hongxing.zhu@nxp.com>
         <6f0cd4c69e0eba3e5da513cfbbe5f162e650a8f1.camel@pengutronix.de>
         <AS8PR04MB8676F0E41C38891B2C21F8D78C899@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <4f4ab64a45c23cd1820423bb9a6513d2a4cb15e4.camel@pengutronix.de>
In-Reply-To: <4f4ab64a45c23cd1820423bb9a6513d2a4cb15e4.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5bb16eb-cda2-4378-fb2b-08da64ceee1d
x-ms-traffictypediagnostic: HE1PR04MB3081:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PQJbn5B8AP+vMvfGZoBkMeEn+So0dywROnFa5GC+oU26TcMpZOMLcA0VK3BtKLi8pPGvEQm9eEpZMzzHI3U0qevwybve3jrLmF7l5X6meO6iVBWIhZhZ+oUtJciARcARSbASXXxiPs1TVIpJiDGqU3VS+oUpJeOfwRqC5VFyQs9TFO0EIt9ir6ilsE1uRc47QarJ03n3/DFtKsc183AuWlpgy/ipzIFKV3e1smqUmH71HmUySiCFM/ApMkoTAoTKXZi9YQKsEi3Ix/5j+2pP1PlUnNzCxwIEsWX1uG6kFI/aGO7p5NUF1x+VrwsV0GAg8YYmrW6y4aKSrg3EByxSgvBrhaQqIWZtYpi69Hk6Df0JYOLfULHgQ6sFlQe14Tv/TXcDikrodA2yS+gdVv75Z6WedIeqHuMIDm3FE/FS8OYQRzYcvHfUvdq5ouzvQ1fN0Ij7T4XuZmEoyeZogTVcxiENwK0/Vm6G/LLocj927iuFcpbUWT/v0K9Z2QPo+lGlL2Cf+5+6xWwUPlqGfaAQIt39mr68KLjU/Z5G/1B9BS4Swvw85MlTpwUNP7YMAqzeEzGme+Uv58yCuJkAKuJIFzzpy5qz6IL/QvJ/jKMDTArqD+TxTb8US1VA1x6jPySmq3O6JJkWBtqTeErukQTijuc3ykdiYoQDXXB0QDDe4H6Ij16OlzG+DCe9cxLjIPpQPZMRWkXVPoyRCkFjBbxYuWNZyTl4IVCDifTjgAl1GMNcD3iIfKWSypTrQw9BPf0SLWUdYZTxQZ1MAopkD+963fLHURjIlppdsUpDWMQQ75s+i3hES4e1oebdra0fa0my/K1SWTF7Yd/6l96sCJOEJzEHVfYvjygCv5qSDrTnL5u6iWDmlGpVoYwx68pek/H4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(71200400001)(44832011)(38100700002)(122000001)(83380400001)(45080400002)(66446008)(966005)(33656002)(15650500001)(9686003)(186003)(4326008)(66556008)(8676002)(54906003)(5660300002)(55016003)(110136005)(64756008)(66476007)(76116006)(8936002)(86362001)(53546011)(2906002)(7696005)(52536014)(6506007)(41300700001)(26005)(316002)(66946007)(38070700005)(478600001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qi9od1lKMnpta0ZodmJxbS8rL0plVGZQREMxZzhndmR2NU9YaDJ1cUR0Ylpj?=
 =?utf-8?B?TDNOajBNRWpwbVdySmlDQzlnMGMwalZNdC9mZU9lYWI5QktaYzZhczBKMStm?=
 =?utf-8?B?ampUWHUzdDZ6N1VGQXM3NVg4bGVsam5HNUVsNDkrOGp4VU4vaEY5Q3FyL1JS?=
 =?utf-8?B?amw1L1RzeGVCSEtTNzJNeEFvVTBYdUZTZzRmWVlCLzN1QmhBQUQyUnY3SEJW?=
 =?utf-8?B?dy9yWXVMalZOSmxnZzFlVmJjMnVDd0xSeW5aTWhMenpwRmYrUVFUTDFvY0pN?=
 =?utf-8?B?c3c3WXZRZStaUm1nbXdXdDJKdHhiOGNFajZGRll2YXZTMFV1Ykl4SGFnZVl5?=
 =?utf-8?B?M0tHSGQzL0dyRUpQamczakp5cXNhbjN0TlFWTTB1RytZaCtJVEliUlJsVnJu?=
 =?utf-8?B?cm9nRUUxRjJXdlZQUkZxM3YzR0tDeis0bGQyRUxheUtiT3p2VzVocGt0S2Nx?=
 =?utf-8?B?bHl4WGdiK2pGMCttRHZiTEQ0RkVDNFZOczBiZ2IvbUJRS0diRmFZVHRVaFJI?=
 =?utf-8?B?WDdzZHFJZGl1MWZWcGtGZ0Q5ME9WS21Nd1QwOGV6dnV6UVpZWnI4NHdsMWZI?=
 =?utf-8?B?ZXF1bzBXRkRxNkZmTS90TENQT0J2N0UrREtRczhOSGJoUGptek01T3laWnRV?=
 =?utf-8?B?YVZicXBKbDBWS0Q5L3BTM0gvZWs2dEt2M3ZJUGs5eXRHV0x0eGV3S2VhZTZn?=
 =?utf-8?B?SXJ1NFpXMVM2R0xEV2sza3htV0N0Zm1QbkJ6d3BaTkFtekxKQXRaQ1VPQkJT?=
 =?utf-8?B?ZStSV1BtL3VpZlcrdzZEVnlQZ3ZuU1kyNk9LTlZCYmROVVBidlBiN01SMzk2?=
 =?utf-8?B?UEE5dG1vOHFjMkgvWVZRSjYvK3dWZzR2N2pjbGhWNmhxYStmQTFHdnlUUlM4?=
 =?utf-8?B?Wjd6aEpyRVVGRjdmbm54aG9sWUNrMlMzQzhrb1BjNGJFNXE2STFGS1pMdlVV?=
 =?utf-8?B?c0tycTRKT1ZBcS8rOFJjZDlaUVlsYkllZ2hFOXR0YW9ydmhqbktNTFRMQ3hK?=
 =?utf-8?B?Z0lCekJKTUxPczJhN1JpamdUV05Ld3BSbk83VkVRUHhsRUhTVkY5ck5NdVhy?=
 =?utf-8?B?bG9UVHFLQjdDejVTOU83bzFqR2xnUnV1SHNsTm9oTVh0ZE05dXJOeCtMajJv?=
 =?utf-8?B?R0xHZ2RHNXpJTXU2ZGtmTTF6THJENlU2VGJUNkxyTlRTZkt4cXBHU1dBZ0hs?=
 =?utf-8?B?ZzFQTXhzbVJqdGhtVTJBK09BeUloZS9QU011L3RoSE8wOGxzR1ZEeGI4WGx2?=
 =?utf-8?B?ZTBFbjNnVWNMRkxaVE9KVGJuaDZKaXAzSWhObTdUVlQvWHJzN2RiT3lVUzQ5?=
 =?utf-8?B?RjFKcDhVNWJHN0QyUDdZYlFFcmhYNHp4eHVmazhSWXZhRkVNZ1pQM2Naand3?=
 =?utf-8?B?RmoxdlRvb3NLNmo4VmswY0xXRDFiTThVMEV6dzBhTEVVYXBmUFMrczgxWEox?=
 =?utf-8?B?T0QzUzVKK29XcGZYNDRZN1RTOW5LK1IvejhyYjBtMWZrdDhmOWMrb0poRGtX?=
 =?utf-8?B?aEpaL0ZVTHc2UGliYXpacUFQeTBUcnV2YlhRNllUTVN3ZGtGejllTENkVXZo?=
 =?utf-8?B?SExJTEFqVUR4VzRzOUJZVkh2R0EyQjN4S3dlanFpWlc2aXJDcjVtSGwveGVy?=
 =?utf-8?B?em9GTXdTTDk3eW1WczZWdURWdnBGT2pGWjdOMllrZXVZVWpxNlZwUnZnc1J5?=
 =?utf-8?B?Ukc1WHFWeGRuZlNTVGtpOXVjSVZiclFjb2V5M05MVTIrZGkrZnBhdlUybGFN?=
 =?utf-8?B?SjExU0UxYVZRa21DMFRsdUFtMFhGOHovYWhsVkN4aWZqQUlyUCt3VXg5Q3FO?=
 =?utf-8?B?NnhoODZmSm5KTDgxQ0s2eGVnd3I0MzIxeXJJT2V5aG96UDF4RElhbCtWcmhO?=
 =?utf-8?B?SGFSTnQ2R3I4MDBNN3YwMHYxa0FHeE9hR1NEN3FlZURtY2JpekY4eW5SRGJl?=
 =?utf-8?B?bUtpd3Q1NUpNVmI0dkZNMWVUSDV3UXU5clBCdk9maEpiMGcrcVJsZ3E5K3g5?=
 =?utf-8?B?eWhHQ0paVlliKzVPRXY4SXlOeGV1Um5oNGRRb2htaTBQaEdSVHJyaXNncDkv?=
 =?utf-8?B?WVVYU0NaSTJMUU5zUHpUN056S2RiaSs2VEN5bUVKQTgzMWdqMnpyaXdBWUs0?=
 =?utf-8?Q?r6uEbNld07JIzb2Q0+CNZdpRx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bb16eb-cda2-4378-fb2b-08da64ceee1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 12:55:14.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Onq+dNWZHoRhyOaFZU+dFUz2JAdWu8AawfHtdjVp4KKkc447YKHSRbkJKibhwnxJO0fZVGkGIWWTeFAJOgb76g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDfmnIgxM+aXpSAxOToyMw0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207
DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgYnJvb25pZUBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRv
cmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTQgMTAvMTddIFBDSTogaW14NjogVHVybiBvZmYg
cmVndWxhdG9yIHdoZW4gc3lzdGVtIGlzIGluDQo+IHN1c3BlbmQgbW9kZQ0KPiANCj4gQW0gTWl0
dHdvY2gsIGRlbSAxMy4wNy4yMDIyIHVtIDEwOjU2ICswMDAwIHNjaHJpZWIgSG9uZ3hpbmcgWmh1
Og0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEx1Y2FzIFN0
YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4gU2VudDogMjAyMuW5tDfmnIgxM+aX
pSAxNjozNA0KPiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBi
aGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gcm9iaCtkdEBrZXJuZWwub3JnOyBicm9vbmllQGtl
cm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+ID4gPiBmZXN0ZXZhbUBnbWFp
bC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tDQo+ID4gPiBDYzogbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZGwtbGludXgtaW14DQo+ID4gPiA8bGludXgtaW14QG54cC5jb20+DQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYxNCAxMC8xN10gUENJOiBpbXg2OiBUdXJuIG9mZiByZWd1bGF0
b3Igd2hlbg0KPiA+ID4gc3lzdGVtIGlzIGluIHN1c3BlbmQgbW9kZQ0KPiA+ID4NCj4gPiA+IEFt
IEZyZWl0YWcsIGRlbSAwMS4wNy4yMDIyIHVtIDExOjI1ICswODAwIHNjaHJpZWIgUmljaGFyZCBa
aHU6DQo+ID4gPiA+IFRoZSBkcml2ZXIgc2hvdWxkIHVuZG8gYW55IGVuYWJsZXMgaXQgZGlkIGl0
c2VsZi4gVGhlIHJlZ3VsYXRvcg0KPiA+ID4gPiBkaXNhYmxlIHNob3VsZG4ndCBiZSBiYXNpbmcg
ZGVjaXNpb25zIG9uIHJlZ3VsYXRvcl9pc19lbmFibGVkKCkuDQo+ID4gPiA+DQo+ID4gPiA+IE1v
dmUgdGhlIHJlZ3VsYXRvcl9kaXNhYmxlIHRvIHRoZSBzdXNwZW5kIGZ1bmN0aW9uLCB0dXJuIG9m
Zg0KPiA+ID4gPiByZWd1bGF0b3Igd2hlbiB0aGUgc3lzdGVtIGlzIGluIHN1c3BlbmQgbW9kZS4N
Cj4gPiA+ID4NCj4gPiA+ID4gVG8ga2VlcCB0aGUgYmFsYW5jZSBvZiB0aGUgcmVndWxhdG9yIHVz
YWdlIGNvdW50ZXIsIGRpc2FibGUgdGhlDQo+ID4gPiA+IHJlZ3VsYXRvciBpbiBzaHV0ZG93bi4N
Cj4gPiA+ID4NCj4gPiA+ID4gTGluazoNCj4gPiA+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGDQo+ID4gPiA+IGxvcmUN
Cj4gPiA+ID4gLmtlcm5lbC5vcmclMkZyJTJGMTY1NTE4OTk0Mi0xMjY3OC02LWdpdC1zZW5kLWVt
YWlsLQ0KPiA+ID4gPiBob25neGluZy56JmFtcDtkDQo+ID4gPiBhdA0KPiA+ID4gPg0KPiA+ID4N
Cj4gYT0wNSU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzM2MWM5YmYzNjViNjQ4OTU0
ODI4MDhkYTYNCj4gPiA+IDRhYTdjY2ElDQo+ID4gPiA+DQo+ID4gPg0KPiA3QzY4NmVhMWQzYmMy
YjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5MzI5ODA2Mzg1MzczDQo+ID4gPiAz
OSU3Q1Vua24NCj4gPiA+ID4NCj4gPiA+DQo+IG93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0
d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxDQo+ID4gPiBoYVd3aQ0KPiA+ID4g
Pg0KPiA+ID4NCj4gTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1BJTJG
dzZBRkNkZEMwVCUyRkENCj4gPiA+IG9jQlQlMkY3T0paDQo+ID4gPiA+IGRkQWVZUFRiZ2VBeHBI
cFB1Ymt3JTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4gPiA+IGh1QG54cC5jb20NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiA+ID4g
PiAtLS0NCj4gPiA+ID4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwg
MTkgKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gaW5kZXggMmI0MmMzN2YxNjE3
Li5mNzJlYjYwOTc2OWIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWlteDYuYw0KPiA+ID4gPiBAQCAtNjcwLDggKzY3MCw2IEBAIHN0YXRpYyB2b2lkIGlt
eDZfcGNpZV9jbGtfZGlzYWJsZShzdHJ1Y3QNCj4gPiA+ID4gaW14Nl9wY2llDQo+ID4gPiA+ICpp
bXg2X3BjaWUpDQo+ID4gPiA+DQo+ID4gPiA+IMKgc3RhdGljIHZvaWQgaW14Nl9wY2llX2Fzc2Vy
dF9jb3JlX3Jlc2V0KHN0cnVjdCBpbXg2X3BjaWUNCj4gPiA+ID4gKmlteDZfcGNpZSkNCj4gPiA+
ID4gew0KPiA+ID4gPiAtCXN0cnVjdCBkZXZpY2UgKmRldiA9IGlteDZfcGNpZS0+cGNpLT5kZXY7
DQo+ID4gPiA+IC0NCj4gPiA+ID4gwqAJc3dpdGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlh
bnQpIHsNCj4gPiA+ID4gwqAJY2FzZSBJTVg3RDoNCj4gPiA+ID4gwqAJY2FzZSBJTVg4TVE6DQo+
ID4gPiA+IEBAIC03MDIsMTQgKzcwMCw2IEBAIHN0YXRpYyB2b2lkDQo+ID4gPiA+IGlteDZfcGNp
ZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QNCj4gPiA+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0K
PiA+ID4gPiDCoAkJYnJlYWs7DQo+ID4gPiA+IMKgCX0NCj4gPiA+ID4NCj4gPiA+ID4gLQlpZiAo
aW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2X3BjaWUtDQo+ID4g
PiA+ID52cGNpZSkgPiAwKSB7DQo+ID4gPiA+IC0JCWludCByZXQgPSByZWd1bGF0b3JfZGlzYWJs
ZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiA+ID4gLQ0KPiA+ID4gPiAtCQlpZiAocmV0KQ0KPiA+
ID4gPiAtCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZGlzYWJsZSB2cGNpZQ0KPiA+ID4gPiBy
ZWd1bGF0b3I6ICVkXG4iLA0KPiA+ID4gPiAtCQkJCXJldCk7DQo+ID4gPiA+IC0JfQ0KPiA+ID4g
PiAtDQo+ID4gPiA+IMKgCS8qIFNvbWUgYm9hcmRzIGRvbid0IGhhdmUgUENJZSByZXNldCBHUElP
LiAqLw0KPiA+ID4gPiDCoAlpZiAoZ3Bpb19pc192YWxpZChpbXg2X3BjaWUtPnJlc2V0X2dwaW8p
KQ0KPiA+ID4gPiDCoAkJZ3Bpb19zZXRfdmFsdWVfY2Fuc2xlZXAoaW14Nl9wY2llLT5yZXNldF9n
cGlvLA0KPiA+ID4gPiBAQCAtNzIyLDcgKzcxMiw3IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gaW14
Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+ID4gPiBpbXg2X3BjaWUgKmlteDZf
cGNpZSkNCj4gPiA+ID4gwqAJc3RydWN0IGRldmljZSAqZGV2ID0gcGNpLT5kZXY7DQo+ID4gPiA+
IMKgCWludCByZXQ7DQo+ID4gPiA+DQo+ID4gPiA+IC0JaWYgKGlteDZfcGNpZS0+dnBjaWUgJiYg
IXJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0NCj4gPiA+ID4gPnZwY2llKSkgew0KPiA+
ID4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKSB7DQo+ID4gPiA+IMKgCQlyZXQgPSByZWd1bGF0
b3JfZW5hYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+ID4gPiDCoAkJaWYgKHJldCkgew0KPiA+
ID4gPiDCoAkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSB2cGNpZQ0KPiA+ID4gPiBy
ZWd1bGF0b3I6ICVkXG4iLA0KPiA+ID4NCj4gPiA+IFRoZSByZWd1bGF0b3IgcmVhbGx5IGhhcyBu
b3RoaW5nIHRvIGRvIHdpdGggdGhlIGNvcmUgcmVzZXQuIFBsZWFzZQ0KPiA+ID4gbW92ZSB0aGlz
IHJlZ3VsYXRvciBlbmFibGUgaW50byBpbXg2X3BjaWVfaG9zdF9pbml0KCkuDQo+ID4gSGkgTHVj
YXM6DQo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiA+IEdvdCB0aGF0LiBIYWQgZG9u
ZSBpdCBpbiB0aGUgMTEvMTcgY29tbWl0Lg0KPiA+DQo+ID4gPg0KPiA+ID4gPiBAQCAtNzk1LDcg
Kzc4NSw3IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVz
ZXQoc3RydWN0DQo+ID4gPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPiA+ID4gwqAJcmV0dXJu
IDA7DQo+ID4gPiA+DQo+ID4gPiA+IMKgZXJyX2Nsa3M6DQo+ID4gPiA+IC0JaWYgKGlteDZfcGNp
ZS0+dnBjaWUgJiYgcmVndWxhdG9yX2lzX2VuYWJsZWQoaW14Nl9wY2llLQ0KPiA+ID4gPiA+dnBj
aWUpID4gMCkgew0KPiA+ID4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKSB7DQo+ID4gPiA+IMKg
CQlyZXQgPSByZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiA+ID4gwqAJ
CWlmIChyZXQpDQo+ID4gPiA+IMKgCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZGlzYWJsZSB2
cGNpZQ0KPiA+ID4gPiByZWd1bGF0b3I6ICVkXG4iLCBAQA0KPiA+ID4gLTEwMjIsNg0KPiA+ID4g
PiArMTAxMiw5IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiA+ID4gPiDCoAkJYnJlYWs7DQo+ID4gPiA+IMKgCX0NCj4gPiA+ID4NCj4g
PiA+ID4gKwlpZiAoaW14Nl9wY2llLT52cGNpZSkNCj4gPiA+ID4gKwkJcmVndWxhdG9yX2Rpc2Fi
bGUoaW14Nl9wY2llLT52cGNpZSk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gwqAJcmV0dXJuIDA7DQo+
ID4gPiA+IMKgfQ0KPiA+ID4gPg0KPiA+ID4gPiBAQCAtMTI2OCw2ICsxMjYxLDggQEAgc3RhdGlj
IHZvaWQgaW14Nl9wY2llX3NodXRkb3duKHN0cnVjdA0KPiA+ID4gPiBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gPiA+DQo+ID4gPiA+IMKgCS8qIGJyaW5nIGRvd24gbGluaywgc28gYm9vdGxv
YWRlciBnZXRzIGNsZWFuIHN0YXRlIGluIGNhc2Ugb2YNCj4gPiA+ID4gcmVib290ICovDQo+ID4g
PiA+IMKgCWlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChpbXg2X3BjaWUpOw0KPiA+ID4gPiAr
CWlmIChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+ID4gPiArCQlyZWd1bGF0b3JfZGlzYWJsZShpbXg2
X3BjaWUtPnZwY2llKTsNCj4gPiA+DQo+ID4gPiBUaGlzIGxvb2tzIGxpa2UgYSBzZXBhcmF0ZSBj
aGFuZ2UsIG5vdCBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdA0KPiA+ID4gbWVzc2FnZS4NCj4gPiA+
IEknbSBub3Qgc3VyZSBpZiB3ZSBzaG91bGQgZG8gdGhpcy4gU2h1dGRvd24gaXMgc3VwcG9zZWQg
dG8ganVzdCBzdG9wDQo+ID4gPiB0aGUgZGV2aWNlLCB3aGljaCBpcyBhbHJlYWR5IGFjaGlldmVk
IGJ5DQo+ID4gPiBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKS4NCj4gPiA+DQo+ID4gPiBJ
ZiB3ZSB3b3VsZCB3YW50IHRvIGRvIGEgZnVsbCBjbGVhbnVwIGhlcmUgd2Ugd291bGQgYWxzbyBu
ZWVkIHRvDQo+ID4gPiBkaXNhYmxlIGNsb2NrcyBhbmQgZ2V0IHRoZSByZXNldCBHUElPIGludG8g
YXNzZXJ0ZWQgc3RhdGUuIEkgZG9uJ3QNCj4gPiA+IHRoaW5rIHdlIHdhbnQgdG8gZG8gYWxsIG9m
IHRoaXMgaGVyZS4NCj4gPiBUaGUgcmVndWxhdG9yX2Rpc2FibGUoKSB3YXMgY29udGFpbmVkIGlu
DQo+ID4gaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KCkgYmVmb3JlLg0KPiA+IFdoZW4gcmVm
aW5lIHRoZSByZWd1bGF0b3IgdXNhZ2UsIHRoZSByZWd1bGF0b3JfZGlzYWJsZSgpIGlzIG1vdmVk
IG91dA0KPiA+IG9mDQo+ID4gwqBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKS4NCj4gPiBC
YXNlZCBvbiB0aGUgZGlzY3Vzc2lvbiBbMV0gd2l0aCBGcmFuY2VzY28uDQo+ID4gVG8ga2VlcCB0
aGUgc2FtZSBiZWhhdmlvciwgdGhlIHJlZ3VsYXRvcl9kaXNhYmxlKCkgaXMgcGxhY2VkIGJlaGlu
ZCBvZg0KPiA+IMKgaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KCkgaW4gaW14Nl9wY2llX3No
dXRkb3duKCkgaGVyZS4NCj4gPiBbMV0NCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjDQo+ID4NCj4gaHdvcmsu
b3psYWJzLm9yZyUyRnByb2plY3QlMkZsaW51eC1wY2klMkZwYXRjaCUyRjE2NDQyOTA3MzUtMzc5
Ny02LWdpDQo+IHQNCj4gPg0KPiAtc2VuZC1lbWFpbC1ob25neGluZy56aHUlNDBueHAuY29tJTJG
JmFtcDtkYXRhPTA1JTdDMDElN0Nob25neGluZy4NCj4gemh1JQ0KPiA+DQo+IDQwbnhwLmNvbSU3
Qzg4YjRiZWRkMTdlODRjNDQwYzU2MDhkYTY0YzIwNjk4JTdDNjg2ZWExZDNiYzJiNGM2DQo+IGZh
OTJjZDk5DQo+ID4NCj4gYzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5MzMwODE3NDM0NTg3MDclN0NV
bmtub3duJTdDVFdGcGJHWg0KPiBzYjNkOGV5SldJam8NCj4gPg0KPiBpTUM0d0xqQXdNREFpTENK
UUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMA0KPiAwJTdD
JQ0KPiA+DQo+IDdDJTdDJmFtcDtzZGF0YT1OSGw0cHJDTXJmUjRLQVpnSWFDdUpYJTJGT3JNSlcz
VXAzMU5YJTJGek1NWQ0KPiBwYWclM0QmYW1wDQo+ID4gO3Jlc2VydmVkPTANCj4gDQo+IEkgZGlz
YWdyZWUgd2l0aCBGcmFuY2VzY28gb24gdGhpcy4gVGhpcyBraW5kIG9mIGhhbGYtZG9uZSBjbGVh
bnVwIGRvZXNuJ3QgaGVscA0KPiBpbiBhbnkgd2F5LiBFaXRoZXIgd2UgY2FyZSBhYm91dCBkb2lu
ZyBhIGZ1bGwgY2xlYW51cCBoZXJlLCB3aGljaCB3b3VsZA0KPiBpbnZvbHZlIGNsb2NrcyBhbmQg
cmVzZXQgR1BJT3MsIG9yIHdlIGp1c3QgY2FyZSBhYm91dCBnZXR0aW5nIHRoZSBjb3JlIGluIGEg
c3RhdGUNCj4gd2hlcmUgaXQgc3Vydml2ZXMgYSByZWJvb3QsIHdoaWNoIGZyYW5rbHkgd2FzIHRo
ZSBvcmlnaW5hbCBpbnRlbnRpb24gd2hlbiBJDQo+IGFkZGVkIHRoZSBzaHV0ZG93biBjYWxsYmFj
ay4NCj4gDQo+IEFzIHRoZSBkZXZpY2VzIG9uIHRoZSBidXMgd2lsbCBzZWUgYSBmdWxsIFBFUlNU
IHJlc2V0IHZpYSB0aGUgcmVzZXQgR1BJTyBhbnl3YXlzLA0KPiB0aGVyZSBpcyBubyBoYXJtIGlu
IGtlZXBpbmcgdGhlbSBwb3dlcmVkIGFjcm9zcyB0aGUgcmVib290Lg0KT2theSwgSSBzZWUuDQpU
aGFua3MgZm9yIHlvdXIgY29tbWVudC4NCkkgY2FuIHJlbW92ZSBpdCBpZiB5b3UgaW5zaXN0Lg0K
DQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQoN
Cg==
