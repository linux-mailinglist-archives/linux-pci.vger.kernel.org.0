Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4A5D07A6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 08:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJIGva (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 02:51:30 -0400
Received: from mail-eopbgr1300058.outbound.protection.outlook.com ([40.107.130.58]:63024
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfJIGva (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 02:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUHLahWKUV/QiU15LFOO9VshXBzrAIGwnwclQmJTXKP+sWfhAM5Qjt6nkQqgV3Zb3d5a6qnRN/wy8Cm0Tsu702ce5w0POyl9ykqoTCasLlJz+SEVOeg3PkZqQgMF2Yu5AH1CBEmWInKaWK4ljfRubDsEUgoFqcGVhQnAh8Ba3ZkIfpRCRFK3JCVnv83f1ZfXAIU7kKwk4e7ZQuzgyVZkXlQzYunpxV5MtpmVyfgXmYjmRVcolIXnnHMSK123s4xggNGF9sJxxaODXWXPMKgFm/RoMAEtzOdx7S7rL6NSOSwkydaW9k+7xl+dunkrcMaqIqDkjyDRpdxKFJkEcGtX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFs/iPrJVpT22ljywAqabQIlN7YfEa96tRrToLr9igo=;
 b=L9S3Bp+AsSDx4CRefIaVcgarKoaZHAXnZI9c68Fv2gJ719VlE2rd25NXOZmwZWsPFtU8zxMvpjXrpumS4CIRr/M1ZrIIyMzmzmeMoyu2n2UDW3PWBViLU3unJqqM4L/tE6BumhtIUO7X3Z5OXDSxTZghYpFZVb0IscjQXQK23r+pAQVGE9xT1kRrZA9NeZPsmdRC9efnY6g/rDQ6SLIetVXOEr/xjGladSZnNKC7fUb5YdaobWfRqnaK5th3hUFgNSjdxDB3pzXMOlY/sbgCjVaXi3Y0AZnteVoE0goiN1LScl5utroLj/jhNgu5FqCpBzL1tTVbTmtkiu8TeEf2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFs/iPrJVpT22ljywAqabQIlN7YfEa96tRrToLr9igo=;
 b=ogY3c/PEuvz3OncjsaIN6ZmVyKZlhjsfNnpa+jeD3jT5tE4kYDb4ru7Mq8tsWB1dmKipUVzMsvROBjLLEXn4t4i36P6IQpF+SspY+rW3tDzyWYUEGVa45bp4PikabZzNfmD2Wfh4Qi21V6xhsP85+c4GKsT4qb2chK+9U+nGgDY=
Received: from HK0PR02MB3444.apcprd02.prod.outlook.com (20.177.31.85) by
 HK0PR02MB3588.apcprd02.prod.outlook.com (20.177.165.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 06:51:25 +0000
Received: from HK0PR02MB3444.apcprd02.prod.outlook.com
 ([fe80::84c8:ae28:c409:66e4]) by HK0PR02MB3444.apcprd02.prod.outlook.com
 ([fe80::84c8:ae28:c409:66e4%3]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 06:51:25 +0000
From:   =?gb2312?B?ufDTwMHW?= <opera.gui@fibocom.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: About PCIE MHI driver build question!
Thread-Topic: About PCIE MHI driver build question!
Thread-Index: AdV+bU/fFrYSYOwvQKi3VQ3FHM30/A==
Date:   Wed, 9 Oct 2019 06:51:25 +0000
Message-ID: <HK0PR02MB3444E2FB30721FCADEE180FAEA950@HK0PR02MB3444.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=opera.gui@fibocom.com; 
x-originating-ip: [117.22.252.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 068ae05b-f09f-451b-3153-08d74c851aad
x-ms-traffictypediagnostic: HK0PR02MB3588:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <HK0PR02MB358842EC43EB48C072C2649DEA950@HK0PR02MB3588.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39850400004)(366004)(136003)(51744003)(199004)(189003)(5640700003)(99286004)(102836004)(26005)(508600001)(86362001)(25786009)(71190400001)(85182001)(6916009)(186003)(7696005)(71200400001)(966005)(8936002)(81156014)(81166006)(8676002)(55016002)(2351001)(66946007)(66476007)(66556008)(64756008)(66446008)(6506007)(76116006)(14454004)(9686003)(6306002)(6436002)(5660300002)(52536014)(7736002)(486006)(256004)(33656002)(74316002)(305945005)(476003)(15974865002)(2501003)(316002)(3846002)(6116002)(66066001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:HK0PR02MB3588;H:HK0PR02MB3444.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: fibocom.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6pAnHJsEan8XX0+bm8LP5/Wvc219719BMOdKkgTu+QV0PXH+dIzahTG7s0ecqluWV3rj5tOvlQvRwTU0CI87MqqQJmpi6fEIvpv8DNYyif2Hg8V+qe7bVDmou+Q75peVQIEYuh8UBc3xGNRtuA4A/8QuK/vVYePTxtrBk0QpAwewL5C8Mspj46qhjMtGAdaORpYAsnV3W/3DhReGq/PEZV+gaKW9VlvQbUkWj0W3d2UsZelQWBfCJLgsugotW2xGWcPchnIx0C0b30rPD2vLaQeKUF3fsyOX5fvKGZRNfrGKzcXSYqYO3ZJiuUHLEtBf2fTZsMrZbjgc6G/u7k41SGuNRWtwFIMxfcvmOcIgAtAb76lGC8aeWeC9+n/kSMivlT9HNiVOgZ5T/+XhHiHEtpGhMlK4cEiyYh3p0+r98aUf0tlEpJuDryqLlvvrYM8n4VXs7YKuh9oXrKe+p8ZjUQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068ae05b-f09f-451b-3153-08d74c851aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 06:51:25.5805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwrk7lpAeYsxkwZ+9bekRzUCRQLNvyNB0CfBIDSYyL6iRpcr3/oUZt8g0AbBOEZGHX7TSZ53/AsscBQe01ulSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB3588
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQogICBJIGhhZCBnb3QgYSBRdWFsY29tbSBNSEkgUENJRSBkcml2ZXIgd2hpY2ggaGFkIHJl
bGVhc2VkIG9uIGtlcm5lbF94aWFvbWlfc204MTUwL2RyaXZlcnMvYnVzL21oaS8gcGF0aC4gQnV0
IEkgY2FuJ3QgYnVpbGQgdGhlIGRyaXZlciBhbmQgdGhlIGtlcm5lbC4gSWYgc29tZW9uZSBjYW4g
aGVscCBtZSBnaXZlIG1lIGEgZ3VpZGUgYWJvdXQgaG93IHRvIGJ1aWxkIHRoZSBNSEkgZHJpdmVy
Pw0KICAgSSB1c2UgYmVsbG93IGNvbW1hbmQgdG8gY2xvbmUgdGhlIHByb2plY3Q6DQogICAgICBn
aXQgY2xvbmUgLWIgaHR0cHM6Ly9naXRodWIuY29tL0RlbW9uMDAwL2tlcm5lbF94aWFvbWlfc204
MTUwL3RyZWUvbGluZWFnZS0xNy4wDQogICBUaGUgTUhJIGRyaXZlciBsb2NhdGVkIGF0IGtlcm5l
bF94aWFvbWlfc204MTUwL2RyaXZlcnMvYnVzL21oaS8gcGF0aC4NClRoYW5rcyENCk9wZXJhDQoN
Cg0KDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyBbbWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnXSANCreiy83KsbzkOiAyMDE5
xOoxMNTCOcjVIDE0OjQwDQrK1bz+yMs6ILnw08DB1iA8b3BlcmEuZ3VpQGZpYm9jb20uY29tPg0K
1vfM4jogUmU6ILTwuLQ6IEFib3V0IE1ISSBkcml2ZXIgYnVpbGQgcXVlc3Rpb24hDQoNCkhpLA0K
DQpUaGlzIGlzIHRoZSBmcmllbmRseSBlbWFpbC1ib3Qgb2YgR3JlZyBLcm9haC1IYXJ0bWFuJ3Mg
aW5ib3guICBJJ3ZlIGRldGVjdGVkIHRoYXQgeW91IGhhdmUgc2VudCBoaW0gYSBkaXJlY3QgcXVl
c3Rpb24gdGhhdCBtaWdodCBiZSBiZXR0ZXIgc2VudCB0byBhIHB1YmxpYyBtYWlsaW5nIGxpc3Qg
d2hpY2ggaXMgbXVjaCBmYXN0ZXIgaW4gcmVzcG9uZGluZyB0byBxdWVzdGlvbnMgdGhhbiBHcmVn
IG5vcm1hbGx5IGlzLg0KDQpQbGVhc2UgdHJ5IGFza2luZyBvbmUgb2YgdGhlIGZvbGxvd2luZyBt
YWlsaW5nIGxpc3RzIGZvciB5b3VyIHF1ZXN0aW9uczoNCg0KICBGb3IgdWRldiBhbmQgaG90cGx1
ZyByZWxhdGVkIHF1ZXN0aW9ucywgcGxlYXNlIGFzayBvbiB0aGUNCiAgbGludXgtaG90cGx1Z0B2
Z2VyLmtlcm5lbC5vcmcgbWFpbGluZyBsaXN0DQoNCiAgRm9yIFVTQiByZWxhdGVkIHF1ZXN0aW9u
cywgcGxlYXNlIGFzayBvbiB0aGUgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KICBtYWlsaW5n
IGxpc3QNCg0KICBGb3IgUENJIHJlbGF0ZWQgcXVlc3Rpb25zLCBwbGVhc2UgYXNrIG9uIHRoZQ0K
ICBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIG9yIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcgbWFpbGluZw0KICBsaXN0cw0KDQogIEZvciBzZXJpYWwgYW5kIHR0eSByZWxhdGVkIHF1ZXN0
aW9ucywgcGxlYXNlIGFzayBvbiB0aGUNCiAgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZyBt
YWlsaW5nIGxpc3QuDQoNCiAgRm9yIHN0YWdpbmcgdHJlZSByZWxhdGVkIHF1ZXN0aW9ucywgcGxl
YXNlIGFzayBvbiB0aGUNCiAgZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZyBtYWlsaW5nIGxp
c3QuDQoNCiAgRm9yIGdlbmVyYWwga2VybmVsIHJlbGF0ZWQgcXVlc3Rpb25zLCBwbGVhc2UgYXNr
IG9uIHRoZQ0KICBrZXJuZWxuZXdiaWVzQG5sLmxpbnV4Lm9yZyBvciBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnIG1haWxpbmcNCiAgbGlzdHMsIGRlcGVuZGluZyBvbiB0aGUgdHlwZSBvZiBx
dWVzdGlvbi4gIE1vcmUgYmFzaWMsIGJlZ2lubmVyDQogIHF1ZXN0aW9ucyBhcmUgYmV0dGVyIGFz
a2VkIG9uIHRoZSBrZXJuZWxuZXdiaWVzIGxpc3QsIGFmdGVyIHJlYWRpbmcNCiAgdGhlIHdpa2kg
YXQgd3d3Lmtlcm5lbG5ld2JpZXMub3JnLg0KDQogIEZvciBMaW51eCBzdGFibGUgYW5kIGxvbmd0
ZXJtIGtlcm5lbCByZWxlYXNlIHF1ZXN0aW9ucyBvciBwYXRjaGVzIHRvDQogIGJlIGluY2x1ZGVk
IGluIHRoZSBzdGFibGUgb3IgbG9uZ3Rlcm0ga2VybmVsIHRyZWVzLCBwbGVhc2UgZW1haWwNCiAg
c3RhYmxlQHZnZXIua2VybmVsLm9yZyBhbmQgQ2M6IHRoZSBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQogIG1haWxpbmcgbGlzdCBzbyBhbGwgb2YgdGhlIHN0YWJsZSBrZXJuZWwgZGV2ZWxv
cGVycyBjYW4gYmUgbm90aWZpZWQuDQogIEFsc28gcGxlYXNlIHJlYWQgRG9jdW1lbnRhdGlvbi9w
cm9jZXNzL3N0YWJsZS1rZXJuZWwtcnVsZXMucnN0IGluIHRoZQ0KICBMaW51eCBrZXJuZWwgdHJl
ZSBmb3IgdGhlIHByb3BlciBwcm9jZWR1cmUgdG8gZ2V0IHBhdGNoZXMgYWNjZXB0ZWQNCiAgaW50
byB0aGUgc3RhYmxlIG9yIGxvbmd0ZXJtIGtlcm5lbCByZWxlYXNlcy4NCg0KSWYgeW91IHJlYWxs
eSB3YW50IHRvIGFzayBHcmVnIHRoZSBxdWVzdGlvbiwgcGxlYXNlIHJlYWQgdGhlIGZvbGxvd2lu
ZyB0d28gbGlua3MgYXMgdG8gd2h5IGVtYWlsaW5nIGEgc2luZ2xlIHBlcnNvbiBkaXJlY3RseSBp
cyB1c3VhbGx5IG5vdCBhIGdvb2QgdGhpbmcsIGFuZCBjYXVzZXMgZXh0cmEgd29yayBvbiBhIHNp
bmdsZSBwZXJzb246DQoJaHR0cDovL3d3dy5hcm0ubGludXgub3JnLnVrL25ld3MvP25ld3NpdGVt
PTExDQoJaHR0cDovL3d3dy5leXJpZS5vcmcvfmVhZ2xlL2ZhcXMvcXVlc3Rpb25zLmh0bWwNCg0K
QWZ0ZXIgcmVhZGluZyB0aG9zZSBtZXNzYWdlcywgYW5kIHlvdSBzdGlsbCBmZWVsIHRoYXQgeW91
IHdhbnQgdG8gZW1haWwgR3JlZyBpbnN0ZWFkIG9mIHBvc3Rpbmcgb24gYSBtYWlsaW5nIGxpc3Qs
IHRoZW4gcmVzZW5kIHlvdXIgbWVzc2FnZSB3aXRoaW4gMjQgaG91cnMgYW5kIGl0IHdpbGwgZ28g
dGhyb3VnaCB0byBoaW0uICBCdXQgYmUgZm9yZXdhcm5lZCwgaGlzIGVtYWlsIGluYm94IGN1cnJl
bnRseSBsb29rcyBsaWtlOg0KCTkxMiBtZXNzYWdlcyBpbiAvaG9tZS9ncmVnL21haWwvSU5CT1gv
DQpzbyBpdCBtaWdodCBiZSBhIHdoaWxlIGJlZm9yZSBoZSBnZXRzIHRvIHRoZSBtZXNzYWdlLg0K
DQpUaGFuayB5b3UgZm9yIHlvdXIgdW5kZXJzdGFuZGluZy4NCg0KVGhlIGVtYWlsIHRyaWdnZXJp
bmcgdGhpcyByZXNwb25zZSBoYXMgYmVlbiBhdXRvbWF0aWNhbGx5IGRpc2NhcmRlZC4NCg0KdGhh
bmtzLA0KDQpncmVnIGstaCdzIGVtYWlsIGJvdA0K
