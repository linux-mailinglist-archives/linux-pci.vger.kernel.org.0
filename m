Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0055C275
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbiF1MdV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 08:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbiF1MdU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 08:33:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869A11827;
        Tue, 28 Jun 2022 05:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1qfqjruEUGzflVniNPuMk9r6B45tLlGJsyjEaU2i0jX7ytG/+DlX6TN0DkaGgujlcvHulcQQfwxzanPTCvl5TAD1JuuVcaqHZAg829Hl/jiezkEWRGKQIGVHUvizQlToL6fwNlbRMMSN3GOcrMGi8032OcuV6ZnGhCDWZzhWygXQ2cZmXE/jrJQntnneZ8/aEMLPwKeKNDIw6XmorIJk0meYAmgqAojMSCOJ4xwgSMFEtDsw3JQW6ZP04/fObD7GcoOwFCdN/k+Wxnyw+noe561eAwAkBSkTDxIOMkSrjONctnddKKg/DrCEmcQjKpGrekdpfLFjCLGgkQoR4mexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjanm7kRVqF3JZYADwDf5C6JQ9P6AccPni/+3cwa9Sg=;
 b=S0uY4HfyIihN4dQ3y5eYv4lKruBnHSr2F/jCyqDwnZVYgOzi9Fb70PEzlcuipUB+QtjkB7dhL2yfvqCjWuoD7iMSB08a6vmxCvvKPHShkoRyf6N9ZMErR4kfXtY6INSYvgppnDYONWj8iqmt8c4K6104qdYAy3glCCm73jATDIRW/TZjv6eUjLLImSN8XXJZb85RYN2/hSo69JeNAL9Q9N1lBF6yXcLzzu/ZDWwFGTf0CqMVm0JC6IGxJzXMA73863zNgErlryT/MJu2zkOEJ9z7DOZBl9iVWoSSP/uH5N48jGq26FTvF87TC3PouiQQRZEzVZYkJ2V4iNNUJ43bSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjanm7kRVqF3JZYADwDf5C6JQ9P6AccPni/+3cwa9Sg=;
 b=PBevIrMWPNxkLqtbAZGGOT3fkMW+jO2nxr6SZFm6kh0IkLEshCItMO+9jmWQZbKQPogTSXG/jXi090EKtUsj95XFlx1GoXgetKQh47JoxVShEur3mG4vCq8bgjvGKv+1iMoYFS84e8IMUpPuv7oLgzzFX+5W5OCYXSMArC7ATjY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB6983.jpnprd01.prod.outlook.com
 (2603:1096:604:12e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 12:33:16 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 12:33:16 +0000
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
Subject: RE: [PATCH v2 10/13] PCI: renesas: Add R-Car Gen4 PCIe Endpoint
 support
Thread-Topic: [PATCH v2 10/13] PCI: renesas: Add R-Car Gen4 PCIe Endpoint
 support
Thread-Index: AQHYiiDa0J6IyEov6UKGcbF3p2tNA61kcxsAgABMu0A=
Date:   Tue, 28 Jun 2022 12:33:16 +0000
Message-ID: <TYBPR01MB5341CC81120D63D5B28FC4BFD8B89@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220627122417.809615-1-yoshihiro.shimoda.uh@renesas.com>
 <20220627122417.809615-11-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdW5M7tLaCg_=+mxybEyRVL=1T6FM-M6xshPM7yvXjjqMA@mail.gmail.com>
In-Reply-To: <CAMuHMdW5M7tLaCg_=+mxybEyRVL=1T6FM-M6xshPM7yvXjjqMA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eff5ae69-de9e-4711-b64d-08da59026016
x-ms-traffictypediagnostic: OS3PR01MB6983:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2/dRoFT52hm60COltzjn63Sl+vCpbvN/2qVbD60NBZlCwsdsbSdW9xHEwI69AXRwMVDLpMvX9KpcId0U9LKpEFWttZJgsciOKqGMYElhwYsw3fvncGJq6AR+jN0t0Bx1cZqDUrqoKnPwik3rBQ/OK1B/DXqmKkKN9RvrqUs8W/JNAZPDxTs/6UxZbqZa6wHf2G7TMla74mKGY4+biWd9vZd2VhYrt0g+//ptePq4yt+IE0qJXNBtr539FLWp3FHB7byHqjO2KjpCX1gOWqurCJ7DMX31pLe7t9DIe6wR93Cm0R7SHePVsv4bmPKbk0KMi0TtIEXS58TPdgEo8mKWrkZIdWTvJXD8DBMpiAfafa//sn534+MAZrWOtOITbMuk70/52tgIfT/XXTZU9WEoLRZPyGXhnys4C9y68/MVrijv3nY5EFwys8u1GH1u3+/dcprTD9tMZDJnmuauRW43TiZZyxvHb4Yoin0VQ2NCe8VAEg2YoFWBukG4tDaEtwgXmg31fqj1xQyzdxJTSvSYfLEqsCKoDBev/y4fSD+cHdM9b4MQygvwFg5kCcwbngLHL/m+X1MgX8pGZbrsRPVUGhFVv/6cmoMvt9pz+RplWBsBCUyDN4igArhq0iGsvsP2KBGU6GSaJicZTR6Ap3ZiyRwpDeYNewHwampdGWk2rOVhOLwqsA1H2MfPWsRZKs5bT8H1aKjvGD+DKDBMZE8qswog/Ydp7AJ723ofJkIx0gvwVVTjSmP7AwQVsxnAlsg4l/jzaAa36inpTo2ARscKxNxoCGyMyMgClsP7nJlPxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(122000001)(38070700005)(83380400001)(186003)(7696005)(6506007)(9686003)(86362001)(38100700002)(41300700001)(53546011)(33656002)(6916009)(54906003)(71200400001)(7416002)(66556008)(66946007)(66446008)(64756008)(76116006)(316002)(4326008)(8676002)(66476007)(478600001)(5660300002)(2906002)(52536014)(8936002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmJ2cDZydHBNZXdEU2gyS1AyUUhWaFBra2FrU0JTQnNYVDhqMWpieUo4cjFQ?=
 =?utf-8?B?ajRVRXpuSFNLcnRZOXZMZVlyVFhtTzkyL0dCV3ZNY2NCNUxPTzc2UnhmNFVH?=
 =?utf-8?B?VkxlVEEraEk1blE1YkdZY2tKSHBjMnNtZFVETlBWUldhck5lY3Q1WHdnTTJy?=
 =?utf-8?B?M0F4anJiTDB4a251MDl4bGF0Mlhiajc0TmJWWDdJWkpOcE4rWnFIYXIxd1U0?=
 =?utf-8?B?SW5uNkpvQ2YvVW8zTzFnRlBFRE9ZUmFTclVvdklmVkd4T0JIRVJuQjExbEwx?=
 =?utf-8?B?Z3Rjcnp4dUxESk9ocmtma2lGZE5sUmt5V0dxNXZiQWxPMmwyeERIZFp4SjRh?=
 =?utf-8?B?cGJ6L051TTZnSXYyMHdlM29uWnhZR0MrLzkySGR6RDdmMGJaTVVJcUxjaktP?=
 =?utf-8?B?RnczWUp5OEZKTnllTFR6UVZjV0VLNXNVeVAyNUc4K093cEhVbE9EYUNYdVVK?=
 =?utf-8?B?WDJkTFpLZ1FDbklDZGFNWkFMYzlORjE0c1hucEZXK21qUVc5dmM5ZWpBa2xh?=
 =?utf-8?B?Ulg1cWMyOUw4cjlBOVhBSzJJYkQ5WU52MVUvTU5Xd0xGV3RpT0V5eHBpV01Z?=
 =?utf-8?B?UzZCdnIrWlg2amE1RndQL3ZCdFF2aklNaFU1Z3hvS01sY05MOTNhVmloYWsv?=
 =?utf-8?B?QjhPWEs1SGw3alBlSmEyMmJiOWFWQW9iWDdTUGxoaysrZzExWEFlSE9zQUVN?=
 =?utf-8?B?TlM0a09TSnBlZXZhMGFOTmVIeFZIaDhZajFmaDZRbGlZQWxPbkZZU2xIVUtJ?=
 =?utf-8?B?dFNrRndqeUxkcWl6dzJvdmMwUzF6RFN2cXNzWXk5MTVRVW9RNU91OWdYc3BD?=
 =?utf-8?B?YnBhZWV3L2Z4aVEzaVVwQmh1WnROSFR5VWJ3VGlQRkNlenJTbzYrZWp4M29h?=
 =?utf-8?B?KzFyQUxwMTRNa0Y0bDhXOWhJTGppWmFtcTBMVTQ0NkZ5YmQyK2wxbTF6MVlQ?=
 =?utf-8?B?V1Z1ZWQxN2V1U1Y2a2dZRElTMWw1UGEzamtROEZmTGZqcmxMTVlQRXp0bUIr?=
 =?utf-8?B?VDVVTmxqWEFPeVFPVVJTdlVMVEN0Nmx0YmhES1ZIa1kvRkhJaUZ4SElWWGtK?=
 =?utf-8?B?S0kzV0hBYWNMTHUwSnQzYXBRSlgvd0pxU2lIdVJycU1ia2ROdzZwWGlRNk1Q?=
 =?utf-8?B?RG5hb3FqdFZLN1J2SGdrMUF2YVFMZ1ZoRVNlQTF2OVpHdng5b3MzQ2JVSkJ6?=
 =?utf-8?B?SUJENFFmczhMK054cHVFbXB1K3VsbXdoNHpySXp3Q3JzaUZjUVhwSkQweW1V?=
 =?utf-8?B?NEZWOG9sZGJ6WXEzUjNzZnRHbk16cE5Ba0xiNEgxRGRwZEY3SndUMmdTTm1l?=
 =?utf-8?B?dzY4MitkdThHNlRJNjRuVkV2VFZJaW5wZ1RwVm5VOVNZM3FmU0k2NDA0S1VL?=
 =?utf-8?B?Z0hKMmNGdTQ0a3UwLzZrWEpFZTJIUGxMSjlnQU4wY3VOWVd1eWJJQmdxcVFG?=
 =?utf-8?B?cW4rMXp6SlFicHBpNVI0VEZDNllCdlFxQ2hjdWhRclgyQlJOV1JpMnhjaTZS?=
 =?utf-8?B?R0lWbnZkMGtrM29YVmFNZHpYOFl4dHVqb0dsTkY5RnlmN25MTUM1R25mZEdZ?=
 =?utf-8?B?NU43MFRmWXZZTU5LSk9lbkF3Z2hDN1FpMW45eWtnVXh3ZkxUWGUwUmJHZ0NN?=
 =?utf-8?B?OGlKbEtkdUxKUE5TQ3hRTjIzbnlJcW43bC91MWRLWUI3TWdsbHd5SGIwNjYx?=
 =?utf-8?B?N3VKWDZjVVlaa3QwT1JCZzc4M2U4QXRrRk1zNEF3YmRxSERGcVAybnk5eDI5?=
 =?utf-8?B?bCtwckFwdTg4SGUzZEtmSmlRVG1pWHQzSkw1S0h5NXZidFhNZU96OFRYUlJ1?=
 =?utf-8?B?N0dVSWJ2YjNRaWFyam01Rjh3YjVHOTRUU241dzRrYmpUWU5VT3pKNGU5dzU2?=
 =?utf-8?B?WjRFNzBKeTcyaytjUUNEWGU2ME95dm5LdWU5WUt5b3VKTSswcmEwd2VqU09N?=
 =?utf-8?B?RVRBeGFSMGM3RCsvL09NOGdOYWhDLzB0UEFKcG01cldsQTJrZG40c3dudXp1?=
 =?utf-8?B?ZXBhZU4vSG9TVXM4QWtleGdtUjBJeUplZ0I4d3F3OUIrZ0s5WkhKYSttbGpX?=
 =?utf-8?B?bFBKYkNLZ0lDK3pGOUpKTit1VGM5a1JmcVFpR29zYURMbG1vcnhHMXhTd2Zt?=
 =?utf-8?B?MGlQdW9iaDZxcnNXVTdHczdyeDRoMFp6UmFGdGwzUi9CWGtpWlFvbDJNRTN5?=
 =?utf-8?B?Mm9aRGxmNC9JWGtId2Q5aGFRekxkZTM0K0xBelVGekhJMzg4azBIZCt0SVdT?=
 =?utf-8?B?QjBxUDVzbUVKeWROWFI1SVhLYmZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff5ae69-de9e-4711-b64d-08da59026016
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 12:33:16.2629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xu5sD+yFCxsr+VPt8+L9P4uPamUH3G8nI62Us0G8iquCUhMLL2cRVUtTopkLJyYJffuzRu25GBGavrqLO/D2LCMlI1skqb1Od5W+jBuFKHxcS2YiZ2CycaErERkj+gbT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6983
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVHVlc2Rh
eSwgSnVuZSAyOCwgMjAyMiA0OjUwIFBNDQo+IA0KPiBIaSBTaGltb2RhLXNhbiwNCj4gDQo+IE9u
IE1vbiwgSnVuIDI3LCAyMDIyIGF0IDI6MjQgUE0gWW9zaGloaXJvIFNoaW1vZGENCj4gPHlvc2hp
aGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBBZGQgUi1DYXIgR2VuNCBQ
Q0llIEVuZHBvaW50IHN1cHBvcnQuIFRoaXMgY29udHJvbGxlciBpcyBiYXNlZCBvbg0KPiA+IFN5
bm9wc3lzIERlc2lnbldhcmUgUENJZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGly
byBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5r
cyBmb3IgeW91ciBwYXRjaCENCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyENCg0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJj
YXItZ2VuNC1lcC5jDQo+IA0KPiA+ICtzdGF0aWMgaW50IHJjYXJfZ2VuNF9wY2llX2VwX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcmNhcl9nZW40
X3BjaWUgKnJjYXI7DQo+ID4gKyAgICAgICBpbnQgZXJyOw0KPiA+ICsNCj4gPiArICAgICAgIHJj
YXIgPSByY2FyX2dlbjRfcGNpZV9kZXZtX2FsbG9jKGRldik7DQo+ID4gKyAgICAgICBpZiAoIXJj
YXIpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAg
ICAgIGVyciA9IHJjYXJfZ2VuNF9wY2llX3BtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ID4gKyAg
ICAgICBpZiAoZXJyIDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgInBt
X3J1bnRpbWVfZ2V0X3N5bmMgZmFpbGVkXG4iKTsNCj4gDQo+IFRoZSBlcnJvciBtZXNzYWdlIGRv
ZXNuJ3QgbWF0Y2ggdGhlIGZ1bmN0aW9uIGNhbGxlZA0KPiAoc2FtZSBmb3IgcGF0Y2ggOS8xMyku
DQoNCk9vcHMuIFRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgaXQgb3V0Lg0KDQo+IEFzIHRoaXMgaXMg
YWJzdHJhY3RlZCwgcGVyaGFwcyAiZmFpbGVkIHRvIGVuYWJsZSBSdW50aW1lIFBNIj8NCg0KSSB0
aGluayBzby4gQnV0LCBBcyBJIG1lbnRpb25lZCBvbiBwYXRjaCA5LzEzLCBpZiBJIGNhbiBtZXJn
ZQ0KcmNhcl9nZW40X3BjaWVfcG1fcnVudGltZV9lbmFibGUoKSBpbnRvIHJjYXJfZ2VuNF9wY2ll
X3ByZXBhcmUoKSwNCkknbGwgY2hhbmdlIG90aGVyIGVycm9yIG1lc3NhZ2UuDQoNCkJlc3QgcmVn
YXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGVy
cjsNCj4gPiArICAgICAgIH0NCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAt
LSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5v
cmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxl
LCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3Vy
bmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
