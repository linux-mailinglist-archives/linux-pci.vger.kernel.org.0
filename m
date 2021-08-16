Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABCB3ECFAD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 09:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhHPHu3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 03:50:29 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:65415
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234060AbhHPHu2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 03:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Unn5q/ksNcfKwaheMQRyJYpSngQpQuFszoDbacsLhKKWWRU4fA8lDl4396WnA1q+3ylCFJpxZ2QwhYFnb9OEuiiMjmKWZ5AdfdbiCDrp1bntg7f0zW3t2yl4+HO+eFJPgQNN0ReZGaeU/psuknu8hLrRn7K7w5yH1druhd36pM0WAP+1wEEXmSRaO3VuNS6MoAqxrxg/dj+XQXXW13hhCCDR9rLwYa0ZWmYzxk1quY8hBxgMetIKxUAeVWAviZOC9bknfA9QO5Vw5CfFmMA4a699qQEbG4DWqkBdOQaXV4m0Mb6id57IdSjWC+fiELcdoK42VRul+2yNw1rqa9WypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxOSXwe5BGdV9sUkqpCmxXGfdtbLJk1oDARs9DISglg=;
 b=C9N7DmR6tg/5VDH2ZKvzzUgX4kGFpUm5K9LoLTsakub3XbOL9HB4lB1iGtWEGrE7OqNPJTsEBmCuO/DIu3G4n67MXDDDaAToXxguoM1AojY09Qhv1/RgGXOqgF0KBBu6gPf87HI8Bpt7631oN3O5cIFTOxRX+A0ez7A0mhiffryI31Pu2IKU9NaEc5bcpGBYsVdFk3qs6g+nZqhOBMAtcI8M6v3xZpGaRRo3pSpc9Mk/g9oBeOcXRY6Dgfcl8bZ5Tg/a8cCVe0nZA+79QyTgnRW7BeN3qp7YPZquUcu/xZw0c1yNAaN4xBx3RLe148niYR3dV+zG+ezpjxizbgwX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxOSXwe5BGdV9sUkqpCmxXGfdtbLJk1oDARs9DISglg=;
 b=C6BUlKrhwIgvkKlE047S3HQo00nhWcP6sUfc17sqyGvn3buHW6jcSI3ceqVLEfhYtOfL4Nv60DkiIKY2T4KRx6Pik0s3h7CDX4AbEuZEzd6A+0YQ0iTcZ/Bj+P/SIwX1njypUyBqMDVHR1jKBxhQOmohK8njnFXhpdofI7yDz80=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 07:49:53 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::50a3:f548:9c83:b50d]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::50a3:f548:9c83:b50d%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 07:49:53 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "khalasa@piap.pl" <khalasa@piap.pl>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Artem Lapkin <email2tema@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
Thread-Topic: [PATCH] PCIe: limit Max Read Request Size on i.MX to 512 bytes
Thread-Index: AQHXkCCAd25MMNZS+EiXilahDYVGlqtxN1uAgAAgpRyAAHj5AIADyxzygAAmrlA=
Date:   Mon, 16 Aug 2021 07:49:52 +0000
Message-ID: <VI1PR04MB5853728C0FD18D19901138048CFD9@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <20210813192254.GA2604116@bjorn-Precision-5520>
 <m3wnomynkm.fsf@t19.piap.pl>
In-Reply-To: <m3wnomynkm.fsf@t19.piap.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: piap.pl; dkim=none (message not signed)
 header.d=none;piap.pl; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee347ead-b79f-4e96-8e91-08d9608a6eda
x-ms-traffictypediagnostic: VE1PR04MB7374:
x-microsoft-antispam-prvs: <VE1PR04MB7374EDE60722F2E00BCD664C8CFD9@VE1PR04MB7374.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lg6We9aj6k71i0O+FYr9r1wOUobjigoBlqo1+YKFm06DyFY/pcTlPeiKRtUaafgZfjibrwghreC/H9oLKxUGaHuFfj3BMEGRbZOKZ3KFksZZrdHBqXU+dgTOt/yM0HJLXSkkxuWdpeWuJTCTgSbqiXEKcFgoWRtfupmAvkNbt5157LMOn7Vs+mNVMdK8kC+IsB7BPTTJgk6ZpJQD6hgC+XFNeTv8lEOm9PV5ApN86Dux82GD4DAbo1SAo77RrGPmWiyw6kvyR99Pl6FpsWY2qgk3ieilOyY5owQyV4TAG7McFBoqSLZPS71X+dDNmtN5eurPpfNUJwSzGkMop17oWRDjyC18G/uoEh+aJWoPANercOPhzMUn/51z3N42Kqi+RHBRCg62BFJOg2kfxPoxQAtvLoOshFRW0I12f+u1DvSni9YU47mp/B9k02q0GBz8vT1vNwVClvxLduv6YkPhL6vbpPr56NfPmb40ESPxnRqEWoWNdfk2UvSHzdYep5OD1WEiYgn5ilMfftd/3TA/mFyi5EJWV/0eCWW4TAd0prQ9RWHQQ9O/iM2uUpuP4Ngzbpvv6Q5Sdz5xe48qDPPSoLe4Qeafna5bXnXC/QKmFG2ygKYqIfySftlv0szv8gJzJnPBCTjVlcIEZT8TSjmgyth84ayxYVDEtcMOwCvyoWI4Rm6hdA40JAyJrKcwbuSxbGV1mmnErF4reoeH96F4iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(478600001)(8936002)(186003)(33656002)(7416002)(4326008)(2906002)(66574015)(53546011)(6506007)(7696005)(54906003)(110136005)(316002)(26005)(52536014)(64756008)(66446008)(9686003)(66556008)(55016002)(66476007)(76116006)(71200400001)(66946007)(83380400001)(38100700002)(38070700005)(122000001)(86362001)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0swanMzakxwcGN4dFB4M1pIRkphQXkzd2JRb1dTeUV1VExRZzByZUVybC8z?=
 =?utf-8?B?dTlMK0ROTWtIODhkQnAzT0xzMVB2TmVIZExnMSt2b1oreFlEVTNpTmxZdEZw?=
 =?utf-8?B?K282QUl2Y3lWd0FNTUozLzlsUUdDNmV5SzZvMnY1NGNWZ0FGbXlBb3dkMHM2?=
 =?utf-8?B?c1VTVFI3V2NScmVsK1krVy9KREJMbndTTXk1QVlYRnpDNE9VeFVBZ1V4cHhT?=
 =?utf-8?B?b2tvOXc3QTl5a3JIZkorcXJoeFlDa3FVOEhhRkVmRkVxSDVScm1ybWVjNTZ1?=
 =?utf-8?B?ckNMRW00SGkwKzdxVDZ1ZUpHVjNkc21Xa21EbkpTd1ZIaXZQZ3BVQUg2cURo?=
 =?utf-8?B?dnErczEzbmRwODhyNU5US1dKMkpVYW9lcnczME1hYXFoSGc5TC93cUU4WU12?=
 =?utf-8?B?V0xvSjJUOGpvblYrR3FObVVQcStzWExacmcyWTZvU2RiY1JyV1hMVjZyWGRn?=
 =?utf-8?B?QWlNWjBXMEtLUVRoWVJHZDB3UGlJbXB2WTNsWWU4bjZ4aHRQTGtJWFRMVkFs?=
 =?utf-8?B?czBXb29KcEpIaGhRNFYxV09JOW1DWmR6elRvbk5Semt5clgxajZaZ3BOb1B4?=
 =?utf-8?B?aS9HRktPLzc3MzdnZUk1Qkgzamw4Umg1aGR6YWplSkZ3TCsxMjJGd0dxN0Ir?=
 =?utf-8?B?UWxiTUVIQ1lCRE9CZVdwN0VXSmViTndrQUJUZkdZaVB6ejR0blFRYTRnSU1o?=
 =?utf-8?B?clRVbWNrQWZ6K2FOUGZqSWkzdHJ4cUpDQmFoYVdiQ09tOUhtOFJudVprVStY?=
 =?utf-8?B?TDBDK0Uwck8vcEJWSjVBMnFGZlJGZ1AvcUxVYUp6ZkczYm90TzRGV2FYVFFB?=
 =?utf-8?B?cWlUNkVWKzk1T096SzZqR2xKK2YwN05YeFdlT3Bnb3l4Z0ZUaVdBbFVqMnFY?=
 =?utf-8?B?QmY5TkE5bzJVUmlYQXdTYi9Zb1JHSlVhSTlGMU0reFRhWXlzWnBNcnkwSVpE?=
 =?utf-8?B?STNYQVNtc3lBS2EydFBGeWpEazJ5SzdtdjV6Y3ZaOXZMMjNqaHMrV1k2NlRl?=
 =?utf-8?B?TUE1SytRRnJXd2RkdGxGMDNtYzc2aWoyam1Ma0NWcUI0d3EzZVc2TzNZUUti?=
 =?utf-8?B?MzRaUDFLRUk2a2FYSlVTWmw1Z3QxcnlhSVdhME5DRzFpUWVnUXJncHdtYmRF?=
 =?utf-8?B?eXYzc29GRXhuQWxac0w3SGh0SDgySFVneHc4dmFQVjcyaElSVHp5TXVlc0xo?=
 =?utf-8?B?d0pXR29oc3dncUM5NHVUYXBTK2JNN0NKT0MxeUR0RFFXUm5rOElXQnNJODBD?=
 =?utf-8?B?Q0FIQWtXRmJRTyt0Ykw1aDJNNjRWdUhObzRjaUx5bE13aVFpQmJzT01NaEsv?=
 =?utf-8?B?RkNwOW1HLzZsbm9EdmlrR2NKMWFGZW9nNkREdmVPMmpDMzZzaEgxaGx5RXJR?=
 =?utf-8?B?aUt6NDFVWGhSMUZpRE0zSWdRbDVlRHFJb3czeExoUDJWUFNmUGNhdm03dElV?=
 =?utf-8?B?VGNQNFJNa1NrOHQvWXZnQnZGUzdnMnV1dnJPemszemhhRXZHYWdmcmdQK0Yx?=
 =?utf-8?B?RGM3QndLR2xSWFl5NEwzV21QZWRWMWdMcUExYU9GdXlUeVJaWTA4UkJxN3J0?=
 =?utf-8?B?aDlxV1FLWGNwWnd4Vjhndzlrc05lSStqREQvbENMeEVsaG9MeURsUVMxS1JX?=
 =?utf-8?B?QmY4SDUrSXRlTENMZUdlWjdobS9pREh0RmRtb3N1dmVVdEQvUGIvYmYxWUtu?=
 =?utf-8?B?VXEranVDN0h5WFdNd09QTEhUMkdHaENCbjVxVzFrTSt3aVVrYXpBSE9Sd2R4?=
 =?utf-8?Q?pWki711d6TZTQ/6QUzzALQVmaga9fO56tOt51fh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee347ead-b79f-4e96-8e91-08d9608a6eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 07:49:53.0096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EJwqvpkN+xnOPpd8sbMuUuBnGsXD6KVMSAJL/EZENemL7NfSzL52wRc7BKjjnWPY9qkUJRVCE9asuYulArVMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7374
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mOg0KUmVnYXJkaW5nIG15IHVuZGVyc3RhbmRpbmcsIHRoYXQgdGhlcmUgc2hv
dWxkIGJlIGRlY29tcG9zaXRpb24gb3BlcmF0aW9ucyBpZiB0aGUNCiBNYXhfUmVhZF9SZXF1ZXN0
X1NpemUgaXMgbGFyZ2VyIHRoYW4gdGhlIE1heF9QYXlsb2FkX3NpemUgc3BlY2lmaWVkIGJ5IFJD
IHBvcnQuDQoNClRoZSBiaXQwIG9mIEFNQkEgTXVsdGlwbGUgT3V0Ym91bmQgRGVjb21wb3NlZCBO
UCBTdWItUmVxdWVzdHMgQ29udHJvbCBSZWdpc3RlcihPZmZzZXQ6MHg3MDAgKyAweDI0KQ0KIGhh
ZCBiZWVuIHNldCB0byBiZSAxYjEgaW4gZGVmYXVsdC4NCg0KTm90ZTogVGhlIGRlc2NyaXB0aW9u
IG9mIHRoaXMgYml0Lg0KRW5hYmxlIEFNQkEgTXVsdGlwbGUgT3V0Ym91bmQgRGVjb21wb3NlZCBO
UCBTdWItIFJlcXVlc3RzLg0KVGhpcyBiaXQgd2hlbiBzZXQgdG8gJzAnIGRpc2FibGVzIHRoZSBw
b3NzaWJpbGl0eSBvZiBoYXZpbmcgbXVsdGlwbGUgb3V0c3RhbmRpbmcgbm9uLXBvc3RlZCByZXF1
ZXN0cyB0aGF0DQp3ZXJlIGRlcml2ZWQgZnJvbSBkZWNvbXBvc2l0aW9uIG9mIGFuIG91dGJvdW5k
IEFNQkEgcmVxdWVzdC4gU2VlIFN1cHBvcnRlZCBBWEkgQnVyc3QgT3BlcmF0aW9ucyBmb3INCm1v
cmUgZGV0YWlscy4gWW91IHNob3VsZCBub3QgY2xlYXIgdGhpcyByZWdpc3RlciB1bmxlc3MgeW91
ciBhcHBsaWNhdGlvbiBtYXN0ZXIgaXMgcmVxdWVzdGluZyBhbiBhbW91bnQgb2YgcmVhZCBkYXRh
DQpncmVhdGVyIHRoYW4gTWF4X1JlYWRfUmVxdWVzdF9TaXplLCBhbmQgdGhlIHJlbW90ZSBkZXZp
Y2UgKG9yIHN3aXRjaCkgaXMgcmVvcmRlcmluZyBjb21wbGV0aW9ucyB0aGF0DQpoYXZlIGRpZmZl
cmVudCB0YWdzDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbToga2hhbGFz
YUBwaWFwLnBsIDxraGFsYXNhQHBpYXAucGw+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDE2LCAy
MDIxIDE6MTkgUE0NCj4gVG86IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4g
Q2M6IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPjsgQmpvcm4gSGVsZ2Fhcw0K
PiA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IEFydGVt
IExhcGtpbg0KPiA8ZW1haWwydGVtYUBnbWFpbC5jb20+OyBOZWlsIEFybXN0cm9uZyA8bmFybXN0
cm9uZ0BiYXlsaWJyZS5jb20+Ow0KPiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNhaUBnbWFpbC5jb20+
OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsNCj4gTG9yZW56byBQaWVyYWxpc2kgPGxv
cmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBSaWNoYXJkIFpodQ0KPiA8aG9uZ3hpbmcuemh1QG54
cC5jb20+OyBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT47DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJZTogbGltaXQg
TWF4IFJlYWQgUmVxdWVzdCBTaXplIG9uIGkuTVggdG8gNTEyIGJ5dGVzDQo+IA0KPiBCam9ybiBI
ZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+IHdyaXRlczoNCj4gDQo+ID4+IFRCSCBJIGRvbid0
IHRoaW5rIG9mIHRoaXMgYXMgb2YgYSAicXVpcmsiIC0gYWxsIHN5c3RlbXMgaGF2ZSBNUlJTDQo+
ID4+IGxpbWl0cywgaXQganVzdCBoYXBwZW5zIHRoYXQgdGhlc2Ugb25lcyBoYXZlIHRoZWlyIGxp
bWl0IGxvd2VyIHRoYW4NCj4gPj4gNDA5NiBieXRlcy4gVGhpcyBpc24ndCBhIGxpbWl0YXRpb24g
b2YgYSBwYXJ0aWN1bGFyIFBDSWUgZGV2aWNlLCB0aGlzDQo+ID4+IGlzIGEgY29tbW9uIGxpbWl0
IG9mIHRoZSB3aG9sZSBzeXN0ZW0uDQo+ID4NCj4gPiBEbyB5b3UgaGF2ZSBhIHJlZmVyZW5jZSBm
b3IgdGhpcz8gIEkgZG9uJ3Qgc2VlIGFueXRoaW5nIGluIHRoZSBQQ0llDQo+ID4gc3BlYyB0aGF0
IHN1Z2dlc3RzIHBsYXRmb3JtcyBtdXN0IGxpbWl0IE1SUlMsIGFuZCBpdCBzZWVtcyB0aGF0IG9u
bHkNCj4gPiB0aGVzZSBBUk0tcmVsYXRlZCBjb250cm9sbGVycyBoYXZlIHRoaXMgaXNzdWUuDQo+
IA0KPiBJIG1lYW50IHRoZXJlIGlzIGFsd2F5cyBhIGxpbWl0IC0gaXNuJ3QgTWF4X1JlYWRfUmVx
dWVzdF9TaXplIGEgbGltaXQ/DQo+IERldmljZSBDb250cm9sIFJlZ2lzdGVyIChPZmZzZXQgMDho
KSBCaXQgTG9jYXRpb24gMTQ6MTINCj4gTWF4X1JlYWRfUmVxdWVzdF9TaXplIGFsbG93cyBmb3Ig
bWF4IDQwOTYgYnl0ZXMsIHRob3VnaCB0d28gdmFsdWVzIGFyZQ0KPiByZXNlcnZlZCwgc28gdGhl
cmUgaXMgcm9vbSBmb3Igc29tZSBlYXN5IGV4dGVuc2lvbi4NCj4gDQo+IC0gbm9uLUFSTSAobm9u
LURXQz8pIHN5c3RlbXMgYXJlIGxpbWl0ZWQgdG8gNDA5NiBieXRlcw0KW1JpY2hhcmRdIFJlZ2Fy
ZGluZyB0byB0aGUgZGVzY3JpcHRpb25zIGxpc3RlZCBhYm92ZSwgSSB0aGluayB0aGF0IHRoZXJl
IHNob3VsZCBubyBsaW1pdGF0aW9ucyBvZiB0aGUgTWF4X3BheWxvYWRfc2l6ZSBvZiBSQyBwb3J0
Lg0KDQo+IC0gRFdDLWJhc2VkIHN5c3RlbXMgYXJlIGxpbWl0ZWQgdG8gMTI4LCAyNTYsIDUxMiBi
eXRlcyAoYXJlIHRoZXJlDQo+ICAgNDA5Ni1ieXRlIG9uZXM/KQ0KW1JpY2hhcmRdIFRoZSBNYXhf
cGF5bG9hZF9zaXplIGNhbiBiZSBjb25maWd1cmVkIGZyb20gMTI4Ynl0ZXMgdG8gNEtCIHdoZW4g
aW50ZWdyYXRlIHRoZSBEV0MgSVAgaW50byB0aGUgU09DLg0KT24gaS5NWDYgUENJZSwgdGhpcyBw
YXJhbWV0ZXIgaXMgZml4ZWQgc2V0IHRvIDUxMiBieXRlcy4NCkJSDQpSaWNoYXJkDQo+IA0KPiBU
aGF0J3MgaG93IEkgdW5kZXJzdGFuZCBpdCwgcGxlYXNlIGNvcnJlY3QgbWUgaWYgSSdtIHdyb25n
Lg0KPiAtLQ0KPiBLcnp5c3p0b2YgIkNocmlzIiBIYcWCYXNhDQo+IA0KPiBTaWXEhyBCYWRhd2N6
YSDFgXVrYXNpZXdpY3oNCj4gUHJ6ZW15c8WCb3d5IEluc3R5dHV0IEF1dG9tYXR5a2kgaSBQb21p
YXLDs3cgUElBUCBBbC4gSmVyb3pvbGltc2tpZSAyMDIsDQo+IDAyLTQ4NiBXYXJzemF3YQ0K
