Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F17C46EC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 02:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344488AbjJKA4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 20:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344450AbjJKA4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 20:56:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2093.outbound.protection.outlook.com [40.107.114.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080A58F;
        Tue, 10 Oct 2023 17:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK/g6Bkmn4tGgDmhbbsd1zrmfDedNnHojy6NVpxD3VIl4DV3Ij47J9geKaoEczI3NIKpscBuR/X7sW0gi6JM7pxc+aScMFHLgixG/+x5B5Nqz9iqav9cTl0iHlM6cpk8KHjsonzWRPfbIbVJMWY+kfPW/pvUcd2KU42Di/wM8cNO5jjTOhnVFP24rKfHnkie428W+A5X78NyIwDE+sc47yYtgwEn0gRJbE/JPcnQ2WXF7Ta+NPREC9lz26EGft/DcbKr1gu2nDr0JTectpptMt7iNDUVQPzZi6c5zDFrOivH7kaR6u6381LhxcRXWlfjnkYpEl5UogeBQJetDeUy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNYGvlwWMgUFXxGCxRyJa0qEddV4T9XSqq0yEr1MBr4=;
 b=f3Sfw9E3qo8RP2tEgBX9qNFR6TgjDt2etDYOu2of7GQ+nnIlEtL1vhTXXq7j6hq5kvYso/IIXf/HJLhC2hxgEjXUkYMG3shZTA1JfbWIdbAA1Gib/8j8UgKTIIcJYcEMBMb82xsEWsOL/e0zaGSXfdmf1KqEgjvCRr28Hp5ztyjNpKDhJwzRmBi+51EqUVsvifl/R9mFjD/Ea1E87JiR4XFlNO85tjVIPrn2STjsotxtccTMoDHddtwKdF/qIuKsUuh4D63PU/5dqvszt5DBLgEo5FSJ1/bDRcwItqt5cyhp9ZEdK+Rlz34/WBB5w49kLY25PNaUaldzLKNVQmRj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNYGvlwWMgUFXxGCxRyJa0qEddV4T9XSqq0yEr1MBr4=;
 b=pKYUrJcEiR2Pni08PcZtWmLTzca0Id8YFM1oNehIiYIR/nEucenX/0zgidu5fno59Omy8/GjuQKozB9kDyDp9skWi/c+9U19JpOLPQCxhYIkfDl+UakrbKbPJJQD8TFJIIEssR99fbtbC/RdydqvWsQMUJAY3j3IS0I1qw1enY0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB8283.jpnprd01.prod.outlook.com
 (2603:1096:400:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 00:56:04 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 00:56:03 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v21 12/16] PCI: add T_PVPERL macro
Thread-Topic: [PATCH v21 12/16] PCI: add T_PVPERL macro
Thread-Index: AQHZ7SGFSZvm03WRaU29sAP6tsQoIbBDAB0AgADg3cA=
Date:   Wed, 11 Oct 2023 00:56:03 +0000
Message-ID: <TYBPR01MB53418C0E91A50B93CB116F36D8CCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
 <20230922065331.3806925-13-yoshihiro.shimoda.uh@renesas.com>
 <20231010113036.GF4884@thinkpad>
In-Reply-To: <20231010113036.GF4884@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB8283:EE_
x-ms-office365-filtering-correlation-id: 465cdb4f-f090-4ef3-2988-08dbc9f4d831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DL5XQFiCcF7ghQCBcOwHV4hVYhNz7k2XZu+lnkvAJzdCDwZKI/jWNoca9ptFxAUJCan/dcblDAgRhKU4UV0ToPP/pElIGNPCfSgjd64XKrSk+BoYgQk7DpyLqBxn55wIVIHfGsXUd0Epn2zcz6A6xiGN7z9QXvoAgxwTyCA+e2K89y6B56i6LONtQfJWdAGLceMv/5FxnaNuNfx23E8TUOifp1hmbkW39xTtZaZ+Zlq5oyQ0QdyRCCrnbdvE1rlohWLVHvIT0FdAximK/P3ZhV3vZ4fSvHX2P6ndUPWAKyl/OkQ9LTsaOCJskmPsDHIXfCnLuL+OI7+sk4YiY1joNp41WIZfYkOp1dA/Ws5hAZZwshfT15dsT9uC9yvWT9f5rwsESHoIcJlHhw0JVCqeHJLC4Eh76g12ktcSdyeZkQbsrNbvN11ghdHxEBPOvCekQ8O5bBzZQVF5xBpir5LkbeKwr/CC80qH2UcuuHs1KY3hUe+B3XC2f0oqT61w2rJRTzGHrrRaMTE34ejGbwY/Og8wNonV774rzGVp1RYji6X4HBY2maINg3d4UOBwzNsKn9P48GvdeksyCUN54jhsGFKAGerV961UA9JSiFem6nhBPKtIy8nKu/rxdH6AnF54
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66446008)(8936002)(55016003)(64756008)(38070700005)(38100700002)(122000001)(9686003)(2906002)(316002)(41300700001)(86362001)(52536014)(6916009)(66476007)(66556008)(66946007)(76116006)(5660300002)(54906003)(7416002)(4326008)(8676002)(7696005)(6506007)(71200400001)(33656002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RytIRGZybzVxUGtGWW9vbUwzN1RISEVaeUJZM3pOZUx2czlvd0pGOTViZmZj?=
 =?utf-8?B?ZnJlV2NyOWFxOW1ycXRjLzZrWHJud0taUVFJT2JFbXNLWHVJT01ncTVIY3Nh?=
 =?utf-8?B?T3ZLTXZyYk9UMHBFYTNUSGlQYW00bW11dmJUMFVyZWVka3pPTHRMQ1JjMlJi?=
 =?utf-8?B?dkRsZnJzUkhKdExDMUJLclprYWhxS3o2TzNUekQvSW1PcmpsTmNLZjc3TkFW?=
 =?utf-8?B?VEp2TVZDZEYrRTUxTDBvMGhsTmpiVDl2S093aFQ1OEZValIvSWoxb0VJYVFw?=
 =?utf-8?B?d01OVGV0WnlMM25rbWZwYXVnWTBKb3d6TytlRFk5aFd4ZFpleWNyTzVKeTVS?=
 =?utf-8?B?RHpZMGJjYWlMWlZzMk5JK1FuOGc5M1dBMlEwQXo5RnhKNE9telRaZzZVSnV0?=
 =?utf-8?B?L1JSM0dmd05sRy9CSExrcG4vNERsTjUzQTJLNiszd1lsMWdFYUlnMndGVktu?=
 =?utf-8?B?ekU3dHNKTXhFVVBNOVBLc0EvQ0cwc2szMWFQNmFaR2x2ejN6ODNGV251clNq?=
 =?utf-8?B?blhVdU9zaGJPTHBLOU02cVJNOXpCZ25nNit0WjlKcWNibmNBZXd0NjVTbUM3?=
 =?utf-8?B?NzBka3FLVXZJT0NpWW4vanpZQSt4VjZsclJPd09tMHBTejIrNEV3b1EwNkIv?=
 =?utf-8?B?a1RJekJmQy9IQU5aUy95NnJCZ1p5SE52MnVVZ0xCVzRlQU5pZmFsZk1xZ1Q1?=
 =?utf-8?B?VEM4SjNHZTY2TExGYjJRbno1ZC8zY241RitUVnhFRHNtUlhhMktMNWhzWG40?=
 =?utf-8?B?QTNEVmUvdmNxY2VvMnBKbkhjNWVFNkFYakJuMVdZNjU4YjltVEtKZnBsMVE5?=
 =?utf-8?B?aTY4N1pjMUZKenJtM1FBSno5bWJScUpmK1ZWU211QXhkVzIvcnFZNVM1aFhy?=
 =?utf-8?B?MDFNTVl4WkgxTGVxaDFMNjhrbkxSUTkwMGg1Y3FKUUJzdmd1YVIyREdhVjVN?=
 =?utf-8?B?TWFMWSsxUFpKaFpMOFVjU3g2UGIxNG4rWHpYR0RFcWlYbDc0TVZNUVJ1N2p0?=
 =?utf-8?B?dEJEa2tCVzJrdnJBOGZHSWpPR2Y3SDN1RU5ZV1BUQ0ZWS1FFbHBpS3BJZ0hx?=
 =?utf-8?B?aWoxWUJuQWJhUHBuYUVYdjcvQzE4OXNVb0xIWGU2R01uNjgrRTBnd3Z3NUZB?=
 =?utf-8?B?Y0VCR3c4b1pZamFwcDg3V0M0WWtkTTJQd01EcnhDa2RxS1dMRVdLb3ZaMFZ3?=
 =?utf-8?B?SHFYQUtwVUVjNkU3QTg1eEhWQmhSTlF4cVVHcGxNU0NYRkpmT3Z1OWx4MUEz?=
 =?utf-8?B?WmFacjJpZElibTlsZ2YyZi9jenh2dEo1akJUVTJRbTJTNUNJckZYTUxLM2pL?=
 =?utf-8?B?Vlo5TGgzWW9aNkpHbHI0VVI3K1p2dFBhaHMzZXJMaHQ1Y1RNd0o1OHFiMzcy?=
 =?utf-8?B?WWVWTXE1ZnVWMC93V2RCY1g5L2d1c1E0YWRSaXhZdzAxbGQyNExYSXQ4dnlP?=
 =?utf-8?B?Rk50WXNtSXFwZU9Zc2tmdG0zWjJYQVBKcFphT0RBbVVmYncya3FWN3lWREV1?=
 =?utf-8?B?NDZoOExveURlbzFGRVoyTGwzVGhYZ2V3aE5VK2M4UXRJWHh6Tzl5dHRTb0dP?=
 =?utf-8?B?WDBHcXpTaUtCTW4vNk8xbC9zMUM2SlVHTWdoTnZZUTBsY3o3WGlUdUhrV3pP?=
 =?utf-8?B?QUZXVU1WdE5NQmwyVERPZHZHVE9OcnM4VzE1VklFYmEwbTN3K2lMa3pXV2JT?=
 =?utf-8?B?ay9wMVhEMWZDOHB1REhKQWo2N3RRSExGVzBKVm80NGVnSlFrMTBOUm12ZUUv?=
 =?utf-8?B?UEYwZGZuSzdhbFN6TDB4UVdPaDZtSHBtQTdtZlY1WWNZOVJpWVZtSWJLK0Fm?=
 =?utf-8?B?VWgvVzd1SEFFd1RVejRITmwwU1UyZW5MMXB2RTZjZmkweE9RSG0rak1aMG9M?=
 =?utf-8?B?TEM2V2lyQUE1VVphV0VSNTNERWhzMlNndWp4MlcvcUp3alNTUGgyZFNXYnBV?=
 =?utf-8?B?VjlvS2pIZUIrN0l1N1VQWThUblErU2FMc1RvQThJNHRZSENXSEJLZ1lHSXJT?=
 =?utf-8?B?aXh4V3RrNXM0ekFEcWVyNlFPQ2NmRXBzdklmVXRIZE1CbHQ3UmVVaG14dzB4?=
 =?utf-8?B?RXZqdVhQdW9HZ3FhUFNXMmJqUTJObk1WK1YxWmh0dEduNzFkckJTWjdqYzRx?=
 =?utf-8?B?NGdOZ2tsenZKSGJxVllieVl0Z1FtdWZ2Z0lONE5KalJXcXNMS3hiTXlCUko0?=
 =?utf-8?B?Z2V1TUorVnZoU1V4NXJKWU1JQWtUd2V2bER3d1hIUWw5TW90azZTSzFYc2hZ?=
 =?utf-8?B?N3czU3NBN3h3QU4xa2kxd09OOCtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465cdb4f-f090-4ef3-2988-08dbc9f4d831
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 00:56:03.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8KVTQooV5TlKiyj0K2Iezu3Tl/fD/kIOa1YaZngKNYgraIX9UlrBLe2pcvT0MGAPOv/uwBnHFkdUzrU40ZTDy3j1flp/BdEZqJB9BFpnBXR2htgG+pDUk2C0piYIdMa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IFR1ZXNkYXksIE9jdG9iZXIgMTAsIDIwMjMgODozMSBQTQ0KPiANCj4gT24gRnJpLCBTZXAgMjIs
IDIwMjMgYXQgMDM6NTM6MjdQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4g
QWNjb3JkaW5nIHRvIHRoZSBQQ0kgRXhwcmVzcyBDYXJkIEVsZWN0cm9tZWNoYW5pY2FsIFNwZWNp
ZmljYXRpb24sDQo+ID4gUG93ZXIgc3RhYmxlIHRvIFBFUlNUIyBpbmFjdGl2ZSBpbnRlcnZhbCBp
cyAxMDAgbXMgYXMgbWluaW11bS4NCj4gPiBTbywgYWRkIHRoZSBtYWNybyB0byB1c2UgUENJZSBj
b250cm9sbGVyIGRyaXZlcnMuDQo+ID4NCj4gDQo+ICJBZGQgYSBtYWNybyBzbyB0aGF0IHRoZSBQ
Q0llIGNvbnRyb2xsZXIgZHJpdmVycyBjYW4gbWFrZSB1c2Ugb2YgaXQuIg0KDQpJJ2xsIHJldmlz
ZSB0aGlzLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGly
by5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQoNClRoYW5rIHlv
dSBmb3IgeW91ciByZXZpZXchDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoN
Cj4gLSBNYW5pDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9wY2kuaCB8IDMgKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9wY2kuaCBiL2RyaXZlcnMvcGNpL3BjaS5oDQo+ID4gaW5kZXggMzlhODkz
MmRjMzQwLi41ZWNiY2YwNDExNzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcGNpLmgN
Cj4gPiArKysgYi9kcml2ZXJzL3BjaS9wY2kuaA0KPiA+IEBAIC0xMyw2ICsxMyw5IEBADQo+ID4N
Cj4gPiAgI2RlZmluZSBQQ0lFX0xJTktfUkVUUkFJTl9USU1FT1VUX01TCTEwMDANCj4gPg0KPiA+
ICsvKiBQb3dlciBzdGFibGUgdG8gUEVSU1QjIGluYWN0aXZlIGZyb20gUENJZSBjYXJkIEVsZWN0
cm9tZWNoYW5pY2FsIFNwZWMgKi8NCj4gPiArI2RlZmluZSBQQ0lFX1RfUFZQRVJMX01TCQkxMDAN
Cj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIFBDSWUgcjYuMCwgc2VjIDUuMy4zLjIuMSA8UE1FIFN5
bmNocm9uaXphdGlvbj4NCj4gPiAgICogUmVjb21tZW5kcyAxbXMgdG8gMTBtcyB0aW1lb3V0IHRv
IGNoZWNrIEwyIHJlYWR5Lg0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCu
ruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
