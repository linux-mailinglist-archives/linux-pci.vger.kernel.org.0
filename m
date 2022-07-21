Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397E457C241
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 04:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiGUC3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 22:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUC33 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 22:29:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21C57748D;
        Wed, 20 Jul 2022 19:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3iCRSfeP5W8zaXfbRbTbGAJQMfHNcpGKQU37VHL1cTX0GxFtNmEql5GAndMjfTwbsPMXIhwtlkrh730eM1DySgrHIiUTwgghNm/U5lU76MGo40VbjU96PlHHI1tPlCL4iTtMaggUgci8DTDcTbbCKCaZ5mnxoPnt61v1UquLZe04/DA0+9rhkekOWedbY55rKjZUmTfSBV17ewTjOakF5zm/TkuXc2hz2UQz5HbVc5ZEUl6/2Ziw9iABIGLcUPBkFEHhVYLAaSItIVsj8j63Rmb6BUiHNUrRQg5n6/1vsK7wO8S1b9lANo9/UAla+U/p+NiZony3+W8ZONKwVKgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YP/g9E2gS1mINHNDvelWsyhbJ2jHj6ahIwEydZrild0=;
 b=EjPcUIBy6qAt6vzqUSr09g/yckffRQwdR5JlVhZefKF60RqshQ6/PEfIH3B4RNJ4mavfFxfltwUEOiqkxAo/kA7Ox3/lg4NUXRIgXQHbrE8dM8x9/n4ZmoFZvScHJfRbQwacsXS4erXJcYIYinv5jnL1Yp7s/fja0PoAUeHlMX0zfOgKZesNsaMK//rQMy5yoI0+ko13FOiLzWVu8vuqQJUWvEm5L/rUUMgAERemNF09H1Zn+3ejXzJmVXDixSK8SBto6TbpeJ9Ks5ulf4B6A2XlW50Mg3hk6Eyqhr6s2B285yMY9zh0UhT9W17sEQMp4h69mOje/hutgWo5d3rlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YP/g9E2gS1mINHNDvelWsyhbJ2jHj6ahIwEydZrild0=;
 b=cSIw4xVP06umtontx/9YNFjpwvFFJivBYsw1ehx6tFC5fmLPVVKDg4BDJLwJdNnBxe/2xOF/zDYhs2rtnr3c8rYCFx345Iz58gN7CQXWEG50xyAfRie5Tn13xi7Pw7lx4OMyWjxgp4YGGv6FjwfbV1ZZzbSnzkWs3bHyPXzYuhw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB6549.jpnprd01.prod.outlook.com
 (2603:1096:604:f9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Thu, 21 Jul
 2022 02:29:26 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::307d:7cc:2021:f45f]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::307d:7cc:2021:f45f%7]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 02:29:26 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 09/13] PCI: renesas: Add R-Car Gen4 PCIe Host support
Thread-Topic: [PATCH v3 09/13] PCI: renesas: Add R-Car Gen4 PCIe Host support
Thread-Index: AQHYjShAgQj55T6hG0WCdmXoYXKRcq2Fy7oAgAJszpA=
Date:   Thu, 21 Jul 2022 02:29:26 +0000
Message-ID: <TYBPR01MB534178A1153084018D6A79B0D8919@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
 <20220701085420.870306-10-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWH1XL3PrPc8UujotDwCB+AabvUpS1-V-p7dLKF8N=+SA@mail.gmail.com>
In-Reply-To: <CAMuHMdWH1XL3PrPc8UujotDwCB+AabvUpS1-V-p7dLKF8N=+SA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa49af19-064f-47e2-72d7-08da6ac0d4c7
x-ms-traffictypediagnostic: OSZPR01MB6549:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMupAaDks38/Lo0Fmw7m8BH5Rcu4guyaL1sPsAWxl0oswwTU1X7HMI0fkLJEiLcTQcRU/fCOFF1kWFc379dv10UYBaUKGsjiLiuxnRwPCxfksh6v/nry62P1v7E932WRpXql+sCe0DrwVnIgjxsg+Nj9s0yJxhFQEkNdQyG3u/jSo87bjpuyWmLaGB8Uav4ARbWTdCbeP+BOZTIoQz/0MGxOubU7/G27za2GUBE+gO85uUad5ZhUUBt71om71YTZnXRFIhyoyp1ohOSxECwqLJioqmvoMUMiAcJK7eqA6UOIesk6Q6vrJbr3aeAI9FYUab1teGiOhREp0CTQq3X3bzSeWTYZ9t48/ehN4GZo+h/2JhZPE5MkQVSVJxMJJdp/LPjRae3fAKsefCSCUS38xAUw6BZRu6SJLp7VFBAJFHmdXUy1lJy0kd41xUbQFHBvIK2bQxXEy5aQTtrOPSil0WloVnh9AtUfB78hpJQa1Mf6BKEy1omQ3SNAgGM1sT7faG+oCMMN/L/bYjzFdZajqQWsIJA3fEZwL7UUeNgvCw2dqB5xrqV4nZ1e8hCcODF8EYAHs21HLZO35NTyq6Bim290fuJve/p5dNZR1KoA6zJy71ykJPJWm7ZN3UgCPEj3V2RjS4PNC0aviZZAOwtGc0sT5Gn0uyOCOMPDAXUGnS1qsZ8syOb0PGX16ulxbuwsRuUtHrl3V2V06fB56NS4K3Y9xuHW0ieqFlfXU8IxXCdsEFLfc4L2dFhQnHFwhHq+xyCVOJUJ+b2EDQwl1RnT2F8glAaUeqGY0NbVFXehBdNEaQ4OnOqZKHFRWbzpM06kkNM8V9KNQtf76eb3b3TboQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(186003)(66476007)(41300700001)(66556008)(52536014)(76116006)(64756008)(316002)(55016003)(4326008)(86362001)(6916009)(8676002)(53546011)(66446008)(6506007)(9686003)(966005)(66946007)(54906003)(8936002)(7416002)(7696005)(33656002)(2906002)(71200400001)(38100700002)(45080400002)(478600001)(5660300002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWZ4aDRKUjIyTyt1alhwbTh4cWl5WFM1ek9IdWljWG1VdHBSa0FITWQ2TTVY?=
 =?utf-8?B?S1JGNWRVZm5BdUxjOGd0bUFucEM5YlRrc0N5OE0xTVZaRy82dXZwZHNPSjB3?=
 =?utf-8?B?UGtac0tYVkdVSTFVVUU2RFZaZ0JkVlJsdXhnQTRod2dCcTVtemFhM1pMTDR6?=
 =?utf-8?B?MzFFbEtoSG43YjZuMW81dE1MV2NsZDNjeDJ4aUdseW51Tkd5bHBPTkJ4Rmp0?=
 =?utf-8?B?MVFwdENVcHFNKzVNUUVuTUpzK1ppdVJEczc5djh1SVdNa2FoZUNHdHhsbkZN?=
 =?utf-8?B?Y0tOS2ZIVGhzUVhmdE0zamdIcUhhcHhWYzl1UmdpbGtvT2d0aWxESWUyS3Q3?=
 =?utf-8?B?Y3p4Q2ZmT0hTTkhNRC9SU3FjTEZEblI5Vm1EemZBMGRJbTRzYjd3TGVJcEdZ?=
 =?utf-8?B?NEJsZnZkeUEyZE1DODZWZ1pBTnJmdmk2SnFwdkdsZS9mL001Z2hHSXZPYitF?=
 =?utf-8?B?V2xQUDJPWjFXdG1EcGFnNkNrczg0S2dIa3Avenp2K1V5WXhmb3dCZHF6ci96?=
 =?utf-8?B?b2tZcGhRNVh5Qnd5MXFvM2VUaG1HaEs3UnUxbzFKSFlobEFrOWVUSnVuazdX?=
 =?utf-8?B?Y0NPUm40UmF0aUpES1RaR0ZhQnU3SzF5YUxGdjI5Z0Q0UDRwWE84Rjl5QjJp?=
 =?utf-8?B?a245dG9oRnRGVTl4SDVsNklXMGdzTXYvOG9kL1FQdzUybVN0ZXZITjZvVzVq?=
 =?utf-8?B?bGlyZGk5bkV3TW9ZbVBZT1c3YjgyTDc1NkFsTEpQV0tWclhkQW9aRnpKVEFJ?=
 =?utf-8?B?MEJhc1pZbDhyTlgvUXBKS3k3RGw2RnlqZXJPVGFiWXE5dWYvY21TSERmL3Jm?=
 =?utf-8?B?NTRxeTFabk9abGY5RzM3ZVp2R240QmlNdGFlZEFJc2t3eGZteVBnUkZrTHBh?=
 =?utf-8?B?bTNBQzRPM3VCN0lxcVg1aHY5WnJiR29LYVpEaThDN29aNVVPQzRCdlVYTzlP?=
 =?utf-8?B?eFBvWlFJMFV0b2htaEdKYlNJRUZYbUhOQ2M0VVJnTzBHbFRXT1c5WVo3VEE2?=
 =?utf-8?B?YytMdXR4WGVoSjVEK1V1dlJsczZpZlp0UEFsSXlqYlVPWlEyOE5zZytaTTVV?=
 =?utf-8?B?Q3cxZkxNQnRKRHY0UmhNbVg2c0FaUUgvc3I3aFJzNHFEWi9xQkJHVU9QM1Rt?=
 =?utf-8?B?a1F6c1lwT3M3djJlV1htbTB6Y1ZEc0VVRldaNXJHRktpR1Vxei9zbVJmK1M3?=
 =?utf-8?B?SGhWc0FmQVhYcGR6YXdKbElYREVubTVNb1JuNkFqVlFiRGRCYzM4dm9PdTVF?=
 =?utf-8?B?c2xrdGxBT0pVQkN5NVVrbFNtakZWUHBIdzR0NHFxdmdVRVJONTZjZEpNeEdU?=
 =?utf-8?B?Z1N2TkVDSWtFNk1FWjZyd3ZlMHN0T3IybjJxbVA0MFU0ZXFkUmN6OVVUaUhR?=
 =?utf-8?B?WDRQRU5EUnFIRFozZ0dWb1ZPQ2h5c2VVeDdEbjd5QlBUQnhYYVFybVdGUk5Q?=
 =?utf-8?B?TTZTTi9JTk9uYnpqaHhybTlmZjlsMDVOK0JOMzdWWDNUWkpwdkpGUURWRUla?=
 =?utf-8?B?YVZaakplS3ZpOFlJcDd2RURzTlUwU2FKY1N6MDlVaWUxOTRtZnlwajZjMzZ3?=
 =?utf-8?B?clYyM1pZbDd4VC9hMkJUaHZEeUh0S1JtZlhySnJuQTdqVDQrVTQ5ZjUvTVdV?=
 =?utf-8?B?SE95WUVBazlSeE9aZlVxN0VwYm9hSHdYREVPTjBBMWRVcVRTVFRvbXhkNXRH?=
 =?utf-8?B?TEx4Sm5kb0pZRUpMOFhEY3IrQ3VGU3N1RVNJV3FqaEsvWm9ZRUNUVHhySFdn?=
 =?utf-8?B?T3lKYWlPMmtNdUhtcXRsLzE5bkNBTWltZ1Y1d3FhcE9TOUhrVVdjZ2k4NlBV?=
 =?utf-8?B?RGhFNGt5NlI0UzRJdERUdzg2TmpwRnAvV3doYSszR2k1bVdDVUsyYmZSdFNK?=
 =?utf-8?B?dVJ0QStZYmJ1M1BvQmlnSk1IbmxHeHBOZS9KNXB2TWw3eVdkV3V1cFl6d29N?=
 =?utf-8?B?Sm5DMnFhcEt1enQ3Z05iOTRGbXArdXM5RlhVNUZ2M0o3NVgyb25IR1QwbUk3?=
 =?utf-8?B?aUNaU3BWUURXZ3grYmRwRUlUdHVObE9DRnpQY0lHS0Vpa0gwU0ttR2lCOGxv?=
 =?utf-8?B?VnVKWWpqL2dLNG5WRXpUdWdST0sreENCVEZEUzFZVGd2TnFIaldzU3htL3Jk?=
 =?utf-8?B?aUxKOTJaYUk5bHZpT0NaOVg0Z1ljajVEV01TZE9JSWtPeVRsMjgvMjc2RHo2?=
 =?utf-8?B?Q0RpeCtrbXIySzkwYXZPVlF1NkJ2TzVOWTg5QVFSUG85dDNOWHRTS3l6UWtw?=
 =?utf-8?B?Wkh1RFJLeEtzTjlNajlGeWluc2tRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa49af19-064f-47e2-72d7-08da6ac0d4c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 02:29:26.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+BgJr+HFzlawoY1HESnRCbuRuQJRRz9dzt8FmPi6Vez3yRbsV4w/Ecjre2BrvRnEGhuPtRV8v3UFmhZ6tdCTAV10zltsG/KNc6QE648Uxmh4jmGrkyhnz1TwIchuALd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6549
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVHVlc2Rh
eSwgSnVseSAxOSwgMjAyMiAxMDoyNiBQTQ0KPiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0KPiBP
biBGcmksIEp1bCAxLCAyMDIyIGF0IDEwOjU1IEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gQWRkIFItQ2FyIEdlbjQg
UENJZSBIb3N0IHN1cHBvcnQuIFRoaXMgY29udHJvbGxlciBpcyBiYXNlZCBvbg0KPiA+IFN5bm9w
c3lzIERlc2lnbldhcmUgUENJZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBT
aGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gDQo+ID4gLS0tIC9k
ZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1n
ZW40LWhvc3QuYw0KPiA+IEBAIC0wLDAgKzEsMTk1IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKy8qDQo+ID4gKyAqIFBDSWUgaG9zdCBjb250cm9sbGVy
IGRyaXZlciBmb3IgUmVuZXNhcyBSLUNhciBHZW40IFNlcmllcyBTb0NzDQo+ID4gKyAqIENvcHly
aWdodCAoQykgMjAyMiBSZW5lc2FzIEVsZWN0cm9uaWNzIENvcnBvcmF0aW9uDQo+ID4gKyAqLw0K
PiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L3BjaS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAicGNpZS1yY2FyLWdlbjQuaCINCj4gPiArI2lu
Y2x1ZGUgInBjaWUtZGVzaWdud2FyZS5oIg0KPiA+ICsNCj4gPiArc3RhdGljIGludCByY2FyX2dl
bjRfcGNpZV9ob3N0X2luaXQoc3RydWN0IHBjaWVfcG9ydCAqcHApDQo+IA0KPiBGVFIsIHMvcGNp
ZV9wb3J0L2R3X3BjaWVfcnAvZyBzaW5jZSBjb21taXQgNjBiM2MyN2ZiOWI5MmI4YiAoIlBDSToN
Cj4gZHdjOiBSZW5hbWUgc3RydWN0IHBjaWVfcG9ydCB0byBkd19wY2llX3JwIikgaW4gcGNpL25l
eHQuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50ISBJIGFsc28gcmVhbGl6ZWQgdGhhdCwg
c28gSSBzZW50IGFuIGVtYWlsIHRvIHRoZSBjb3ZlciBsZXR0ZXIgWzFdLg0KDQpbMV0NCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC9UWUJQUjAxTUI1MzQxN0VGRTBBNkRDNUFGM0Q1NEEwRjNE
ODgyOUBUWUJQUjAxTUI1MzQxLmpwbnByZDAxLnByb2Qub3V0bG9vay5jb20vDQoNCkJlc3QgcmVn
YXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9l
dmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1t
NjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBw
ZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRv
IGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRo
YXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMN
Cg==
