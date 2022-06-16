Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FFD54E03F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiFPLwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiFPLv7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 07:51:59 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC056C35;
        Thu, 16 Jun 2022 04:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5zUL0stGISctwNZKyEj60alkql+3EaseDv/W3w3LmrChO/tokaGbRkrKccYfr1skQtaIWjZx0Ox6ImlzHwwoVDveWL/0/wgxF/IeueO6ngK5ioEIg82ejCFNCXypUw0KZjrFc2nN+cH0y74x9itgaJr6uzcvHP2TObiwLNOAjNeZjls2wQqPR1efO/0h/EUrsx04HCsGzCT93Vzl6KfuTdClVOlgN/bWwWizqbOQ5cgbCs1nOBuzxqIjVyJkWO1Q3k3ZWxZpkfBq1ayr/Qclhdg9myfItkWsJEdXxc+Q73XTJQYgeOY9UesL0fUnVyBsOrlP+6n/hC6VFvUF1sbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0D0H4nOD8vGKWDPrhCvuWI1jtxiFppblZWNW0zqXrk=;
 b=eZAt+HKF7lwl0LKtgik17VVqCql1yiFDXaqLHl/vBr+cWu/A4Ebw9iOhUwZve2xu892Cdmcx73L1w2k3cnmtNeutF0WYobSQnwmTuyRtH43Y5fsPKbW0w988vrZLX/+y7cNIM3Uv+ynIGmURCfmWvZkIaO91nsKvLz+di0BwJi78Z3qAUbrzAO6++AvBPzs2/P7OlodUNF14HT3Ke8Z6MtHenfXBiHdVd6HM2LmBJLxc+DedMVlzRshLrRoR8HJy4xhCS2sRcsNWcgyeziWeXXhas1YiCefzv6HdlYlZbop3s2TUKA6eMmyfgq9NpX/fGUtsGPc0wlUafBly/NXtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0D0H4nOD8vGKWDPrhCvuWI1jtxiFppblZWNW0zqXrk=;
 b=G7B6FDfffWCRNORov05foDfu2cxMAGEHJPAUxPG8CswscrqKMe2irPmeGSFnrKc3u6elD2+D69sJbz/gebKTIaC+ACmiIZzFvkW1IQEZsJYLZbyniupKoG8rxNbQOTT2gr1JXe0xgFm64LO/bQja8TQjYI7LnVxIbGbzs1SUtcA=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB9311.jpnprd01.prod.outlook.com
 (2603:1096:400:1a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 11:51:55 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%6]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 11:51:55 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
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
Subject: RE: [PATCH 2/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Topic: [PATCH 2/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Index: AQHYfxy+tH40A+U6tUmoN6cFOSaQgq1QK8eAgAHElGA=
Date:   Thu, 16 Jun 2022 11:51:54 +0000
Message-ID: <TYBPR01MB5341B1943093FF320EA42FAFD8AC9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
 <20220613115712.2831386-3-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVUJmxJDM-5Y3W0fBdBCK_oim8j-=V63DEZk+EgvnZ0vQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVUJmxJDM-5Y3W0fBdBCK_oim8j-=V63DEZk+EgvnZ0vQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be5f477e-0977-47c0-fb32-08da4f8e9c26
x-ms-traffictypediagnostic: TYWPR01MB9311:EE_
x-microsoft-antispam-prvs: <TYWPR01MB9311B3609330757BC34ABDAAD8AC9@TYWPR01MB9311.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3UApVMi/E5/+5oRmGdL45GeLKtt1VFJQLqtdKScprEfjFoIbKYPqfPNBpVD4riPrZTtOrKm6+SJLlJIOVNuguP83o/d0bRMOjcPRwLJR4DelFTmKGAvbxAJe/Xwucycx9K+r0aTZbnacjjEzmArN+3xwgj1DWohNbnW1e24RkZsjAgpfGAog83g4mC6kO9zfI39+SW2HKHPjTeJxogrb0uAqZuDT+egL+qSCdHuCtwRi4i9uC845KChiG79KXe4PS9AQw/m7LMJW7rC+6EHHUzE+i/TK97OvO6JsCGNQgQud8Tw8fwsQ/NwfznB4GObXAGNXI//9Oe5LVT10k7fTE6c+uDfBzdvCFr+lgXt+PqkSzVklB22Oso1BN8fbBUFAP7Dx1mm5iahHDSY0MgixeEw5MgoGCmWEf+x0ebxApAnhs1EDtGcLlCB6RqeuqJmH4REBeX+bjGRxvMp1ShP8Wn+mx+nAF3jvXRdpGItvBvv+2j6SYWYhVm0KCVvn1el/YAv1TdeJo9hws1Id7tfRgqo4xA52sqUBEbAC94DFLGPpcBTWaqekKDzmZ+ATTHCN2XAAcrUlIW1NOCanS0zwa5t8YKWPgpZe8crTP2XAwCLEvZC6fbitWCjg295YBVCg8rT9KFBTbY7LkVaMybTGaFnRUdnmYoD10gH1Csn8hPILQdQoVpY0l6No2OOCGIQNe24tbLk5T/0LhZ4uDlT/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(76116006)(7696005)(2906002)(6506007)(64756008)(8676002)(66946007)(66556008)(4326008)(9686003)(71200400001)(66476007)(53546011)(33656002)(55016003)(6916009)(66446008)(508600001)(54906003)(7416002)(5660300002)(186003)(316002)(86362001)(38070700005)(8936002)(52536014)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmNseDgyMEpvRWc0dUhKaGxERGhqMy8rMTl3SDV0SUY3ZVd3TVBQcXg5dkpl?=
 =?utf-8?B?Qjd6SmhyM1JkWWg2WEVhNlYxcGRHZVowZHZsaG1BRzVwUE9VK3U4VWg3a003?=
 =?utf-8?B?d05XcS9iVkl2a2lSU1k1M2lZOHliOGNmMVphRkwxMnl1WHpKYnMrYTZaUVBN?=
 =?utf-8?B?VnN1dFpCNjYvOXR0VlV6akppdk91TENKQ2wzMG5nNGdSOHRET0tLbG90Z1FO?=
 =?utf-8?B?RmVUQ0szcEo2M1A4ZGxlY0M1WG90NmJUR3gyNTVIMnlXa010QldQYzRXZVpI?=
 =?utf-8?B?RlZGcHZaQ3I5OHVRYWRveTVjcktSV3U3QWxpV1BtMXo1YVZnL2s2MnppZmlP?=
 =?utf-8?B?ZTZqR2ovaFFoK09DUTUzWllqSUpiZ3VNcmtxSmNQRXRPRDdxQXFxTkpxR1c1?=
 =?utf-8?B?VXpwZlF3cHBMM0ZOMUxXYkdvdFNMdlFXNURLaE9CTWtneXUzMTl6WTBhakFQ?=
 =?utf-8?B?UExEcis3T1UxRDl3d0NEQ0tBVlRZM2t3VXpBcVJOUlk3QXVlbmNNOTN5ak95?=
 =?utf-8?B?RUxnd3BTSXlyUzd3anNLMWdYUkR1QTJIU0FzOGVFM3EwVE1oaUZPZUR3bnVr?=
 =?utf-8?B?SUREZFdWOXRxbVJRNnEvMlZOWUt1R0MrcU1LcEFldDFxcm5lTjNVRVZheW9w?=
 =?utf-8?B?OXZqcVdxaHFRVkduZ3BQVHFPME05by9UUTVWemZER2pLR0lnL01Ecm04UFRZ?=
 =?utf-8?B?SnpKUmhXYnBqR01NeUZjTHY3bjhuNk12ZXdRV1Zqd2RpRmxlUUM5MVdoMkNw?=
 =?utf-8?B?b2g4UWIvRjZhR1ZXT2o5SzBlY2ZqcFRPMlJpcUdiZndXRHRJZmxmdEU3Ym1O?=
 =?utf-8?B?NGUyQmkvWm9nUEFYR0J1UnNjZVNwT0s3NHlrOXZQL2ZDSklKQ2dRelJkK1Av?=
 =?utf-8?B?V2FxcmYyVzVuYUFzWC9Xdk5rTzA2cnZDVXNYMUtFbm8zek9MdUVGeC9YT1l1?=
 =?utf-8?B?UXJoR1NlcXdFMmVTbUNSME5aNURiVkVGT1RYU0tZWTdER0VBQThZR1pkTmsv?=
 =?utf-8?B?dlhWRmJIa2JrTCtiRkNnVU1EUTVqa09NVHdycmpaakdnYzFrME1rQldTL1hG?=
 =?utf-8?B?OXR3RWhCbTRXbnFZQ2wwd1pITFcrLzg0OVVJSER4VlI0Tks3MVBsSmxFckpx?=
 =?utf-8?B?aWUrMFd6UEV4WjM2ZVdLenZIcjZ6UmlUZDN3QVZBc2xLcUo2NUpQWkRpaDBN?=
 =?utf-8?B?THpGZko5cURBQjdtWDZ2cGlvakkwcHJac2RtK2JIamJxczdneGNGUDV2WFJo?=
 =?utf-8?B?OGcrWVhGU1lwQVl4OGcrREQ1OWlMcTJCc0JmczVRbktuMlpKeHZidm1iVFpN?=
 =?utf-8?B?NEdnSkJUdEZvbGVUaDA4K0FPVUdxMGMzT0FUc3NwcXF3bFZOaWo5MjB2QzZw?=
 =?utf-8?B?aGJFdjZ3VHB1TFdoK0FHL24xbzMzeHAwTVJGei8ycFQyRWhZWUR6eHZEczc3?=
 =?utf-8?B?WXRZNGJMRVhPbzgxaitFemxMaCtsL0VTNkZHa1VUbWRtdGpORWc1L1VkV3NX?=
 =?utf-8?B?aWRSMGlVZFp3Y01aem9NRzFmYWVUOXRrdmp4TWNIaTVEZkZtaWJXUVVoQTlG?=
 =?utf-8?B?VHQ0STVMYmxRaHl5ZGZTUGd2SUFwQk1vam5ieFZjcVBLREE5YklhR0tpdGRQ?=
 =?utf-8?B?cXpKd0w2MTZKSGpKVk8xblk5ZDF6T3QxcWhDZ1N1cE1oWWtKN0xhdkZVbE5H?=
 =?utf-8?B?VTFqblJveWVuVUl6ZzM4dVQ5TWZkS1BoaGVtdWNqbCs0a042dGk4SG1WUENs?=
 =?utf-8?B?cFZDQVoyL1Y1NmRuTE5xaERuZUthYTJldFZPdDNvd1JtSFBCelpmYkxBejJG?=
 =?utf-8?B?WTdlTXcrSWZIdG1aeG1TTkxSSm1qZ3g4V09CSTFMdVFxM3o4blRHaUJNZ01T?=
 =?utf-8?B?ZCtyeDJyZjZ1bEJVNm5FaHFTZC9KNzRsZUtmb3gwNE9rWDQ0UGlQSk5QNWR5?=
 =?utf-8?B?aFBBcU0wbkgxNnN1UkFaVVdzY1NINXBaZEh3dmlreXdiSVZoYi9zNnM2TDdE?=
 =?utf-8?B?cmg3a3pRdEhWaEYxckdoT1RNWkt4NnpkUkZ0UWVSUjNIdytrMnc0ZzRNMm10?=
 =?utf-8?B?dUk0Mm1FWUtCNkNzSG1WOElWcUJFRy9YeVJpYi9mNDRENDdrL0MwSnFJOXRw?=
 =?utf-8?B?bGFhYUV0VTdiYTJsWjdBV2NmWnhXcit2Tm9uNGRqQkdiakR3aFpiSEI1Qm1r?=
 =?utf-8?B?ZmtOajFSaGxYQVlYV2dqRk9UdEl6K2hrTWJiZ0NBUVJtNkRKRC9NL09weExI?=
 =?utf-8?B?cVVDZkRrZ0E1aTJMeG1qa2JSeVV3N1ppMFdsY0t0UFdDODRGOWFNbDB0U0lW?=
 =?utf-8?B?dmVwd1h3RGhEejMwcVZQQVJGVUduQW9EUmdFNW5mN2FPSE5SMkZKTXFqV1Ux?=
 =?utf-8?Q?X4jX+6zFI97S1EGb1xZl0VTtNrUMfY/O5VFw8Z5sLY6NG?=
x-ms-exchange-antispam-messagedata-1: zIYCOxvF3WYAsm1Shp5C6qdQxl61spL6uAc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5f477e-0977-47c0-fb32-08da4f8e9c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 11:51:54.9941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUMZ6WPQnnts+94GKCeNil17QhnSIgpndyRY4Q91wXO4sj0/lIMkzKV20Ov0R+c+cXUeU0IJ4h16oNehOr+UNRQP7iYitBK3KqJNnYOknt5Z4I0zYJl4T/RI1Cxv1UP/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9311
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IEZyb206IEdl
ZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogV2VkbmVzZGF5LCBKdW5lIDE1LCAyMDIyIDU6NTEgUE0N
Cj4gDQo+IEhpIFNoaW1vZGEtc2FuLA0KPiANCj4gT24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMTo1
NyBQTSBZb3NoaWhpcm8gU2hpbW9kYQ0KPiA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5j
b20+IHdyb3RlOg0KPiA+IERvY3VtZW50IGJpbmRpbmdzIGZvciBSZW5lc2FzIFItQ2FyIEdlbjQg
YW5kIFItQ2FyIFM0LTggKFI4QTc3OUYwKQ0KPiA+IFBDSWUgZW5kcG9pbnQgbW9kdWxlLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2Rh
LnVoQHJlbmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9yY2FyLWdlbjQtcGNpLWVwLnlhbWwNCj4gDQo+ID4gKyAgaW50ZXJydXB0czoNCj4gPiAr
ICAgIG1heEl0ZW1zOiA2DQo+ID4gKw0KPiA+ICsgIGludGVycnVwdC1uYW1lczoNCj4gPiArICAg
IGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBtc2kNCj4gPiArICAgICAgLSBjb25zdDogZXJy
DQo+ID4gKyAgICAgIC0gY29uc3Q6IGZhdGFsDQo+ID4gKyAgICAgIC0gY29uc3Q6IG5vbmZhdGFs
DQo+ID4gKyAgICAgIC0gY29uc3Q6IGxwDQo+ID4gKyAgICAgIC0gY29uc3Q6IHZuZG1zZw0KPiAN
Cj4gU2FtZSBjb21tZW50IGFzIGZvciB0aGUgaG9zdCBiaW5kaW5ncyBpbiBbUEFUQ0ggMS83XS4N
Cg0KSSBnb3QgaXQuIEknbGwgZml4IHRoZSBpbnRlcnJ1cHQtbmFtZXMuDQoNCkJlc3QgcmVnYXJk
cywNCllvc2hpaGlybyBTSGltb2RhDQoNCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVu
IC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhr
Lm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9w
bGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpv
dXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQu
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
