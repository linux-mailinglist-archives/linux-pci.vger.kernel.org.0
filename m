Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9325676A973
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 08:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjHAGqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 02:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjHAGqG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 02:46:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2130.outbound.protection.outlook.com [40.107.113.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FEC1;
        Mon, 31 Jul 2023 23:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ6smHs4RIB6yWGYxFOrVn0+gl+9PLKWahturk36gROu0XJDQG1PsGnO77hsXYRnbQdYZ2+ercI1BiBJa/9r6NABx1uz9U4BOM5PDioxUF5QRTTvGzM7xXqVmZReuN9p+F0uxAkiJcP7G2dcOAiZSrMhoZKBNv5EBMps0vOBUX7GahZz4O6MYLtwflxmBuOaxMa5GAnL5F260hgT43NOYY+73dPaN5PWeVsMylpqae0aWaTqvwH8+z8Q6l5eIX5kEFdpc4kJsQ1wdbcMo1wo8k4S6aLvYZnMSKNswUUeDJF22ei4+hOl7q8K3vM8JyG0mdpNAfBQ8vKA5azPXhTNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOvaJlT4aFxxuKEKeSVKojrUj+rI7LbAZHy2gDPQdcw=;
 b=b/YfiUFYOVvXs4NKNgafD88gVL7mW8D+kBFP93JoPWLh6QyDr4rEGsoARnLWZC1I0XuEUY1oTLhHQy7TXkMle9EI7c7DUoa5N8r3zt7HEqojkM+UefoRYiZluqyj9yVxwqUrAkl4oSI1HIWxsaNwBC1cjMXqK1HdzSlfWAVNVYNEYV+TdEIfIcxFkXjwyFPelrxiABWcqx9PVfs7fjjWGVNvNrpnx5/tzxpCR7SZ41nokXk7OxmH7FYF1DsvndnIm+qRLFna50hfyUF06HGYfVKcefi5R3EilwPw/ektz9zacaBYVQ6ma3bbfAHiebGOlnd3PWyP6KWR5vQvAPatdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOvaJlT4aFxxuKEKeSVKojrUj+rI7LbAZHy2gDPQdcw=;
 b=nzhfRSxMEepU6c2Dyi+kS3ZWqJg9n+SjDbnZJOljZ/BR4oP+WaNsAdMhuttMfwoy7HX67zv2Hc+M8iOCOnIaCqUKkfdfDh1Y64sOXEiS2NkAJtMYg8JRAot2Jc4tTtVVridiSBfYDANs1hz6Gj8qB0CudAHjXhWh5Z3UVF12m5Y=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB11668.jpnprd01.prod.outlook.com
 (2603:1096:400:37a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 06:46:00 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 06:46:00 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 17/20] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v18 17/20] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZu6dF+eAWr/hO202ce1Hahwu7w6/I3VoAgAvUKACAAF2zIA==
Date:   Tue, 1 Aug 2023 06:46:00 +0000
Message-ID: <TYBPR01MB5341F025C9C34C910BF4E91BD80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-18-yoshihiro.shimoda.uh@renesas.com>
 <20230724122820.GM6291@thinkpad>
 <gmy7uzvuy2fkmc7hsanslkv2f4mxzydxvewrv5i5w3b3voqzfv@nmkpewdj726m>
In-Reply-To: <gmy7uzvuy2fkmc7hsanslkv2f4mxzydxvewrv5i5w3b3voqzfv@nmkpewdj726m>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB11668:EE_
x-ms-office365-filtering-correlation-id: 330a0d02-f947-46e2-e562-08db925af7e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jyDUHWIv7IOiFgKc1aG0OdmNQWWhJqe2u1/Q96rmnGyWoYo2b7GvssDLPPizlBjC+GrSSmHoXYnz3hBJkwGmJdc+/6Fn4tQW8RsgZXhotO/b4I2XX1hIQD2E8HCsRub/+4tEEIls76iw2pSkhndrRtmmJvG3o6HoclmsCt8YJFTwZDYEkIKlYGoy00rE28kKsHFiVj6FiiEwZwQ2qLyKY0KVCFG3/R9EvGK1xznip2P7HggTICujvxYVrdlUYln+4FIFiJVDn0qXgjuU4a2Bu0BF6P8tbSshzkECAgX5LmuUr7bD3+qNHeOqPl/62HXSlQG3IjYxPMZplCS89GPfKGy3kZU6APgjiCCNJG5CuA/SAm6VFcU1rFz3gOKcx5XYzFPm8A4hpGuphzh20klI6opMuAY2leSqihfPCBzWBtATscfmTf1zzQYX4aIjhoT4/2zDWN3nOxmpowCdvMy+LGNzn9FdZfpc6/fkvfJPh5TUvzieM6Usw7poVf9BNrwZwPiTMNj/iM6JM0eGE5AWOnI+BstzjU5gTIssCGmgJHd/eW00cwJx5HunqNQukjCTdVVPZghBeB24oEpJKWy8FKb1+OltQNveJMRHsaSyqxr+UIdJp0+clBQ6m8tAOf4H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(33656002)(30864003)(4326008)(7696005)(9686003)(478600001)(2906002)(38100700002)(186003)(7416002)(52536014)(5660300002)(83380400001)(26005)(6506007)(86362001)(316002)(66556008)(66476007)(66946007)(76116006)(64756008)(66446008)(8676002)(54906003)(110136005)(8936002)(122000001)(55016003)(71200400001)(38070700005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1NKazlxT09maVE1b3pNcHB6b3lsS1dTZkFPTjZRU0tURXgwSUFXTngvdTRz?=
 =?utf-8?B?UkVDZGJyOWxYUG5rS2hWS0VlVjA3bHZ2T1oxMFMxcHhrQSt3WllCTDBlSFov?=
 =?utf-8?B?OFVENk9VK1BwK0dxNDBHbzlvUldFUU5SVEo3NjhtYUhBR3ZGTVBHMklOVzJ3?=
 =?utf-8?B?ajh4a01GUnBiWjg0VHVkQU1BMC9DRFVMQmhaTzZ0RG5kNCtpOVVTWUlMUFh3?=
 =?utf-8?B?d0RFanZZZFlsZlFYYVdrdTlZV3ZnRnBEQVpJRGRUWm9HQndpMDlHTzA2VG1m?=
 =?utf-8?B?TnA1aXRnaVNtTzRqa3J2SXRUdm1icCs3MTl6RnVrQmRYR1ExaG0yNHhOb2I4?=
 =?utf-8?B?RlNHclBPbnh5Yml6cmQ3Q0ovZlZnUGRyL2w3cDlFUDhHSk1VUVJtaEM0clFH?=
 =?utf-8?B?aU9xWkk4ZDNjRE9EYWFmOHYyYjJncEEyMmVSN0lmYU1oUGRmbnArRERHVDh5?=
 =?utf-8?B?OXhhaCt4OVRjWnFSelFKTGZVODYvd21BWUpuYW1tR1M1Mm1Ib2drNGp2a1ZX?=
 =?utf-8?B?OVhYVERnbTg5cFZCNkZMZDNmelRsOU5RZ3hWWUl6bUswWFc4MG5VajhuRW4y?=
 =?utf-8?B?Rmg5Y1BwdEJGdWMySEpQSVYxT005MWw3RGpSbWFQaWVuRUU4a0YwRkdTNUtw?=
 =?utf-8?B?dXV2ZTZ3MmtPNlZJTjJEQzh4RjlDa0VWQm9EMC9TUXlHT1czVDQzU2ZCczQ5?=
 =?utf-8?B?cUxTT1FOSmxudVF3WU16UUdqYzVPMCt2TXcyNHcyWmZjbGZpMWFOTkpkTnpD?=
 =?utf-8?B?WWQ2a0VZWHdjazIrZjlWNzExN0hPWURaZmJ5OXRUNzY1dGFDOWFPY0c4Rndy?=
 =?utf-8?B?WDFsdFkxV1Q4bzRIcXl4Rm04TzBEM0lYak9ZZ2RGRWE4YWpFbzJISEZzZktq?=
 =?utf-8?B?bmM3S3JwRHRZOW8zRWIySldSblk0QUMrS3UyQUwydk5XNXhZK0paMXBlR2Rx?=
 =?utf-8?B?a2VLZDIvdGxJYlBpa1BMbDRTdS9KQXBTQlRQaGwrQ3lrWmhtUEgyZ3hFalAr?=
 =?utf-8?B?ZmZ2UG5JSnZybWp6WExiNWI3MzlJNEZWa2dJZUtxY25NUDJicVl5cld3NXlt?=
 =?utf-8?B?MUpTRkl0d3REbmVUeTJYMkRDN1B6d0RmWmZmd2VzaEJTTjBMVmJVcFl2MTBW?=
 =?utf-8?B?UXNjT1kxRVRaVmM2MHBKK0pHUkZQbzNnYUw5NUV3NzdTQytyeFdUNFNDVmN6?=
 =?utf-8?B?VkFNcDc0d2F0YmxLWFhuVFFsbUFzZDNza0hvRGk2SVp3T0wydmtMM29wYkFJ?=
 =?utf-8?B?REJqbENLK2orRHlOS0NQeDdmK2hTc1BRQWJpRkZid0JneENvUXpETDhBS1Z4?=
 =?utf-8?B?eGY5QXVORkZmS2ZLM2svQ1Jja1Q0ejN4aFN5bXNaV0pMN0RpZUxnUXVyQkV0?=
 =?utf-8?B?M0dxZjZwKy83ZVNobzF1THlyVjE1SUkyVXRsaUxHSWFUNTVCRVJnY3pWd3BS?=
 =?utf-8?B?WlZwOHpqQkFYUGh4bjk4STFzSjNoZWJxR1ZYaEVKN3ZPUWQzTUVTVU9nK0Iv?=
 =?utf-8?B?NUZvYXQ3T3FmNWlOZmN6OUdwTHBZRU51OHZPZjk0SW90RFBCSjduMkpwb0tJ?=
 =?utf-8?B?YzUvTGtlaU5wVTBLTUVQMzMycUhIbCs1RzMrUkZhd3I3cXFFUVhvUnlXQ1pY?=
 =?utf-8?B?MFMveWdYUGdrYUhLT2x3QWYra3g3Tk5Md3J0dEtqVGNsR3ZGSDZUbGdtbmh2?=
 =?utf-8?B?N2cweWE1NFNEb2p2cDBGRkhCYlkzYjYrc3hZOW5lWFJsRG5LYXZ3Ym1hU2dG?=
 =?utf-8?B?cm4ySzlaSmFLb3lkRHVNQk5WNm5KSE9xQW0yNDVvRnFOYldWaHZ4RWljcDll?=
 =?utf-8?B?aG5ZZkM0cnZVcmZpZW5yaHREZkh3b3Z3TFBMRUxzbGVKLzNSQTV5VGMvVXFV?=
 =?utf-8?B?RHZqVFprUGF6bW9qcnZpMkZ4cTdkU3lBci81eG9MRnJQRk5ES2NiZkRmcUVS?=
 =?utf-8?B?akcrenpQYmJnMDdUbW1lNlV0YzVYQ1c2ZGxRWERQTGxCVTdvQmROMVJieGJw?=
 =?utf-8?B?WXZ1UHlCT01tN3pwVXo0NTB3b0NXaDF0R2FabmxxNlo1UHNUazhzWDFWcTJx?=
 =?utf-8?B?dDBvRi85UnFNSWY4a0R6U202c2xzbUdOejFVYnoxNkp2ei94dnBFYjB2dkZK?=
 =?utf-8?B?Z0xjV3lCaXA4U0xZR25YeW9SeXBkU1Bnc1JDNHlFR0hWTHpQTlRzZGRZMUpt?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330a0d02-f947-46e2-e562-08db925af7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 06:46:00.6432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7F8E2xYBRK1kZMsXkJPkSSfK6zham+jh0NBbacJhhPVZ697BCdOwpaMDNZiuwGqVequ7SfVJ1JPIN/Yyidrvgezp6XX5+Rnhh1ZrQU9sWdLrZRwWcKqVzu8MlzS5nTkn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAx
LCAyMDIzIDEwOjA3IEFNDQo+IA0KPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAwNTo1ODoyMFBN
ICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0gd3JvdGU6DQo+ID4gT24gRnJpLCBKdWwgMjEs
IDIwMjMgYXQgMDQ6NDQ6NDlQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4g
PiBBZGQgUi1DYXIgR2VuNCBQQ0llIEhvc3Qgc3VwcG9ydC4gVGhpcyBjb250cm9sbGVyIGlzIGJh
c2VkIG9uDQo+ID4gPiBTeW5vcHN5cyBEZXNpZ25XYXJlIFBDSWUsIGJ1dCB0aGlzIGNvbnRyb2xs
ZXIgaGFzIHZlbmRvci1zcGVjaWZpYw0KPiA+ID4gcmVnaXN0ZXJzIHNvIHRoYXQgcmVxdWlyZXMg
aW5pdGlhbGl6YXRpb24gY29kZSBsaWtlIG1vZGUgc2V0dGluZw0KPiA+ID4gYW5kIHJldHJhaW5p
bmcgYW5kIHNvIG9uLg0KPiA+ID4NCj4gPiA+IFRvIHJlZHVjZSBjb2RlIGRlbHRhLCBhZGRzIHNv
bWUgaGVscGVyIGZ1bmN0aW9ucyB3aGljaCBhcmUgdXNlZCBieQ0KPiA+ID4gYm90aCB0aGUgaG9z
dCBkcml2ZXIgYW5kIHRoZSBlbmRwb2ludCBkcml2ZXIgKHdoaWNoIGlzIGFkZGVkDQo+ID4gPiBp
bW1lZGlhdGVseSBhZnRlcndhcmRzKSBpbnRvIGEgc2VwYXJhdGUgZmlsZS4NCj4gPiA+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhA
cmVuZXNhcy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9LY29uZmlnICAgICAgICAgICAgfCAgIDkgKw0KPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL01ha2VmaWxlICAgICAgICAgICB8ICAgMiArDQo+ID4gPiAgLi4uL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLXJjYXItZ2VuNC1ob3N0LmMgIHwgMTQ5ICsrKysrKysrKysrKysNCj4gPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jICAgfCAyMDAgKysr
KysrKysrKysrKysrKysrDQo+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1y
Y2FyLWdlbjQuaCAgIHwgIDQ0ICsrKysNCj4gPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDQwNCBpbnNl
cnRpb25zKCspDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaWUtcmNhci1nZW40LWhvc3QuYw0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jDQo+ID4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmgN
Cj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2Nv
bmZpZyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcNCj4gPiA+IGluZGV4IGFi
OTZkYTQzZTBjMi4uNjRkNGQzN2JjODkxIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvS2NvbmZpZw0KPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvS2NvbmZpZw0KPiA+ID4gQEAgLTQxNSw0ICs0MTUsMTMgQEAgY29uZmlnIFBDSUVfVklT
Q09OVElfSE9TVA0KPiA+ID4gIAkgIFNheSBZIGhlcmUgaWYgeW91IHdhbnQgUENJZSBjb250cm9s
bGVyIHN1cHBvcnQgb24gVG9zaGliYSBWaXNjb250aSBTb0MuDQo+ID4gPiAgCSAgVGhpcyBkcml2
ZXIgc3VwcG9ydHMgVE1QVjc3MDggU29DLg0KPiA+ID4NCj4gPiA+ICtjb25maWcgUENJRV9SQ0FS
X0dFTjQNCj4gPiA+ICsJdHJpc3RhdGUgIlJlbmVzYXMgUi1DYXIgR2VuNCBQQ0llIEhvc3QgY29u
dHJvbGxlciINCj4gPiA+ICsJZGVwZW5kcyBvbiBBUkNIX1JFTkVTQVMgfHwgQ09NUElMRV9URVNU
DQo+ID4gPiArCWRlcGVuZHMgb24gUENJX01TSQ0KPiA+ID4gKwlzZWxlY3QgUENJRV9EV19IT1NU
DQo+ID4gPiArCWhlbHANCj4gPiA+ICsJICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IFBDSWUgaG9z
dCBjb250cm9sbGVyIHN1cHBvcnQgb24gUi1DYXIgR2VuNCBTb0NzLg0KPiA+DQo+ID4gQWRkIGEg
bGluZSBhYm91dCBtb2R1bGUgb3B0aW9uIGFuZCBzcGVjaWZ5IHRoZSBtb2R1bGUgbmFtZS4gTGlr
ZSwNCj4gPg0KPiA+IFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBN
IGhlcmU6IHRoZSBtb2R1bGUgd2lsbCBiZSBjYWxsZWQNCj4gPiBwY2llLXJjYXItZ2VuNC1ob3N0
LWRydi5rby4NCj4gPg0KPiA+IEkgaGF2ZSBhIHN1Z2dlc3Rpb24gZm9yIG1vZHVsZSBuYW1lIGNo
YW5nZSBiZWxvdy4uLg0KPiA+DQo+ID4gPiArCSAgVGhpcyB1c2VzIHRoZSBEZXNpZ25XYXJlIGNv
cmUuDQo+ID4gPiArDQo+ID4gPiAgZW5kbWVudQ0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
TWFrZWZpbGUNCj4gPiA+IGluZGV4IGJmNWMzMTE4NzVhMS4uNDg2Y2Y3MDZiNTNkIDEwMDY0NA0K
PiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUNCj4gPiA+ICsr
KyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+ID4gPiBAQCAtMjYsNiAr
MjYsOCBAQCBvYmotJChDT05GSUdfUENJRV9URUdSQTE5NCkgKz0gcGNpZS10ZWdyYTE5NC5vDQo+
ID4gPiAgb2JqLSQoQ09ORklHX1BDSUVfVU5JUEhJRVIpICs9IHBjaWUtdW5pcGhpZXIubw0KPiA+
ID4gIG9iai0kKENPTkZJR19QQ0lFX1VOSVBISUVSX0VQKSArPSBwY2llLXVuaXBoaWVyLWVwLm8N
Cj4gPiA+ICBvYmotJChDT05GSUdfUENJRV9WSVNDT05USV9IT1NUKSArPSBwY2llLXZpc2NvbnRp
Lm8NCj4gPiA+ICtwY2llLXJjYXItZ2VuNC1ob3N0LWRydi1vYmpzIDo9IHBjaWUtcmNhci1nZW40
Lm8gcGNpZS1yY2FyLWdlbjQtaG9zdC5vDQo+ID4gPiArb2JqLSQoQ09ORklHX1BDSUVfUkNBUl9H
RU40KSArPSBwY2llLXJjYXItZ2VuNC1ob3N0LWRydi5vDQo+ID4NCj4gPiBJdCdkIGJlIGJldHRl
ciB0byBjYWxsIHRoZSBtb2R1bGUgYXMgcGNpZS1yY2FyLWdlbjQtaG9zdCBhbmQgdGhlIGZpbGUg
YXMNCj4gPiBwY2llLXJjYXItZ2VuNC1ob3N0LWRydi5jDQo+ID4NCj4gPiBBbHNvLCBtb3ZlIHRo
ZSBnb2FsIGRlZmluaXRpb24gZmlyc3QuDQo+ID4NCj4gPiA+DQo+ID4gPiAgIyBUaGUgZm9sbG93
aW5nIGRyaXZlcnMgYXJlIGZvciBkZXZpY2VzIHRoYXQgdXNlIHRoZSBnZW5lcmljIEFDUEkNCj4g
PiA+ICAjIHBjaV9yb290LmMgZHJpdmVyIGJ1dCBkb24ndCBzdXBwb3J0IHN0YW5kYXJkIEVDQU0g
Y29uZmlnIGFjY2Vzcy4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLXJjYXItZ2VuNC1ob3N0LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLXJjYXItZ2VuNC1ob3N0LmMNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBp
bmRleCAwMDAwMDAwMDAwMDAuLjMxNjhmNWQ5OGE3OQ0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQtaG9zdC5j
DQo+ID4gPiBAQCAtMCwwICsxLDE0OSBAQA0KPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9ubHkNCj4gPiA+ICsvKg0KPiA+ID4gKyAqIFBDSWUgaG9zdCBjb250cm9s
bGVyIGRyaXZlciBmb3IgUmVuZXNhcyBSLUNhciBHZW40IFNlcmllcyBTb0NzDQo+ID4gPiArICog
Q29weXJpZ2h0IChDKSAyMDIyLTIwMjMgUmVuZXNhcyBFbGVjdHJvbmljcyBDb3Jwb3JhdGlvbg0K
PiA+ID4gKyAqLw0KPiA+ID4gKw0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+
ID4gKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+ID4gKyNp
bmNsdWRlIDxsaW51eC9wY2kuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+DQo+ID4gPiArDQo+ID4gPiArI2luY2x1ZGUgInBjaWUtcmNhci1nZW40LmgiDQo+ID4g
PiArI2luY2x1ZGUgInBjaWUtZGVzaWdud2FyZS5oIg0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBp
bnQgcmNhcl9nZW40X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwICpwcCkNCj4gPiA+
ICt7DQo+ID4gPiArCXN0cnVjdCBkd19wY2llICpkdyA9IHRvX2R3X3BjaWVfZnJvbV9wcChwcCk7
DQo+ID4gPiArCXN0cnVjdCByY2FyX2dlbjRfcGNpZSAqcmNhciA9IHRvX3JjYXJfZ2VuNF9wY2ll
KGR3KTsNCj4gPiA+ICsJaW50IHJldDsNCj4gPiA+ICsJdTMyIHZhbDsNCj4gPiA+ICsNCj4gPiA+
ICsJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGR3LT5wZV9yc3QsIDEpOw0KPiA+ID4gKw0KPiA+
ID4gKwlyZXQgPSBjbGtfYnVsa19wcmVwYXJlX2VuYWJsZShEV19QQ0lFX05VTV9DT1JFX0NMS1Ms
IGR3LT5jb3JlX2Nsa3MpOw0KPiA+ID4gKwlpZiAocmV0KSB7DQo+ID4gPiArCQlkZXZfZXJyKGR3
LT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIHJlZiBjbG9ja3NcbiIpOw0KPiA+ID4gKwkJcmV0dXJu
IHJldDsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlyZXQgPSByY2FyX2dlbjRfcGNpZV9i
YXNpY19pbml0KHJjYXIpOw0KPiA+ID4gKwlpZiAocmV0IDwgMCkgew0KPiA+DQo+ID4gVXNlICJp
ZiAocmV0KSIgZm9yIGNvbnNpc3RlbmN5Lg0KPiA+DQo+ID4gPiArCQljbGtfYnVsa19kaXNhYmxl
X3VucHJlcGFyZShEV19QQ0lFX05VTV9DT1JFX0NMS1MsIGR3LT5jb3JlX2Nsa3MpOw0KPiA+ID4g
KwkJcmV0dXJuIHJldDsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwkvKg0KPiA+ID4gKwkg
KiBBY2NvcmRpbmcgdG8gdGhlIHNlY3Rpb24gMy41LjcuMiAiUkMgTW9kZSIgaW4gRFdDIFBDSWUg
RHVhbCBNb2RlDQo+ID4gPiArCSAqIFJldi41LjIwYSwgd2Ugc2hvdWxkIGRpc2FibGUgdHdvIEJB
UnMgdG8gYXZvaWQgdW5uZWNlc3NhcnkgbWVtb3J5DQo+ID4gPiArCSAqIGFzc2lnbm1lbnQgZHVy
aW5nIGRldmljZSBlbnVtZXJhdGlvbi4NCj4gPiA+ICsJICovDQo+ID4gPiArCWR3X3BjaWVfd3Jp
dGVsX2RiaTIoZHcsIFBDSV9CQVNFX0FERFJFU1NfMCwgMHgwKTsNCj4gPiA+ICsJZHdfcGNpZV93
cml0ZWxfZGJpMihkdywgUENJX0JBU0VfQUREUkVTU18xLCAweDApOw0KPiA+ID4gKw0KPiA+ID4g
KwlpZiAoSVNfRU5BQkxFRChDT05GSUdfUENJX01TSSkpIHsNCj4gPg0KPiA+IERyaXZlciBkZXBl
bmRzIG9uIFBDSV9NU0ksIHNvIHRoZXJlIGlzIG5vIG5lZWQgb2YgdGhpcyBjaGVjay4NCj4gPg0K
PiA+ID4gKwkJLyogRW5hYmxlIE1TSSBpbnRlcnJ1cHQgc2lnbmFsICovDQo+ID4gPiArCQl2YWwg
PSByZWFkbChyY2FyLT5iYXNlICsgUENJRUlOVFNUUzBFTik7DQo+ID4gPiArCQl2YWwgfD0gTVNJ
X0NUUkxfSU5UOw0KPiA+ID4gKwkJd3JpdGVsKHZhbCwgcmNhci0+YmFzZSArIFBDSUVJTlRTVFMw
RU4pOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCW1zbGVlcCgxMDApOwkvKiBwZV9yc3Qg
cmVxdWlyZXMgMTAwbXNlYyBkZWxheSAqLw0KPiA+ID4gKw0KPiA+ID4gKwlncGlvZF9zZXRfdmFs
dWVfY2Fuc2xlZXAoZHctPnBlX3JzdCwgMCk7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAwOw0K
PiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgdm9pZCByY2FyX2dlbjRfcGNpZV9ob3N0
X2RlaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3Qg
ZHdfcGNpZSAqZHcgPSB0b19kd19wY2llX2Zyb21fcHAocHApOw0KPiA+ID4gKwlzdHJ1Y3QgcmNh
cl9nZW40X3BjaWUgKnJjYXIgPSB0b19yY2FyX2dlbjRfcGNpZShkdyk7DQo+ID4gPiArDQo+ID4g
PiArCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChkdy0+cGVfcnN0LCAxKTsNCj4gPiA+ICsJcmNh
cl9nZW40X3BjaWVfYmFzaWNfZGVpbml0KHJjYXIpOw0KPiA+ID4gKwljbGtfYnVsa19kaXNhYmxl
X3VucHJlcGFyZShEV19QQ0lFX05VTV9DT1JFX0NMS1MsIGR3LT5jb3JlX2Nsa3MpOw0KPiA+ID4g
K30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfaG9zdF9vcHMg
cmNhcl9nZW40X3BjaWVfaG9zdF9vcHMgPSB7DQo+ID4gPiArCS5ob3N0X2luaXQgPSByY2FyX2dl
bjRfcGNpZV9ob3N0X2luaXQsDQo+ID4gPiArCS5ob3N0X2RlaW5pdCA9IHJjYXJfZ2VuNF9wY2ll
X2hvc3RfZGVpbml0LA0KPiA+ID4gK307DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCByY2Fy
X2dlbjRfYWRkX2R3X3BjaWVfcnAoc3RydWN0IHJjYXJfZ2VuNF9wY2llICpyY2FyKQ0KPiA+ID4g
K3sNCj4gPiA+ICsJc3RydWN0IGR3X3BjaWVfcnAgKnBwID0gJnJjYXItPmR3LnBwOw0KPiA+ID4g
Kw0KPiA+ID4gKwlwcC0+bnVtX3ZlY3RvcnMgPSBNQVhfTVNJX0lSUVM7DQo+ID4gPiArCXBwLT5v
cHMgPSAmcmNhcl9nZW40X3BjaWVfaG9zdF9vcHM7DQo+ID4gPiArCXJjYXItPm1vZGUgPSBEV19Q
Q0lFX1JDX1RZUEU7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBkd19wY2llX2hvc3RfaW5pdChw
cCk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyB2b2lkIHJjYXJfZ2VuNF9yZW1v
dmVfZHdfcGNpZV9ycChzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIpDQo+ID4gPiArew0KPiA+
ID4gKwlkd19wY2llX2hvc3RfZGVpbml0KCZyY2FyLT5kdy5wcCk7DQo+ID4gPiArCWdwaW9kX3Nl
dF92YWx1ZV9jYW5zbGVlcChyY2FyLT5kdy5wZV9yc3QsIDEpOw0KPiA+ID4gK30NCj4gPiA+ICsN
Cj4gPiA+ICtzdGF0aWMgaW50IHJjYXJfZ2VuNF9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRl
di0+ZGV2Ow0KPiA+ID4gKwlzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXI7DQo+ID4gPiArCWlu
dCBlcnI7DQo+ID4gPiArDQo+ID4gPiArCXJjYXIgPSByY2FyX2dlbjRfcGNpZV9kZXZtX2FsbG9j
KHBkZXYpOw0KPiA+ID4gKwlpZiAoIXJjYXIpDQo+ID4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4g
PiA+ICsNCj4gPiA+ICsJZXJyID0gcmNhcl9nZW40X3BjaWVfZ2V0X3Jlc291cmNlcyhyY2FyKTsN
Cj4gDQo+ID4gPiArCWlmIChlcnIgPCAwKSB7DQo+ID4gPiArCQlkZXZfZXJyKGRldiwgIkZhaWxl
ZCB0byByZXF1ZXN0IHJlc291cmNlOiAlZFxuIiwgZXJyKTsNCj4gPg0KPiA+IFVzZSBkZXZfZXJy
X3Byb2JlKCkuDQo+IA0KPiBSaWdodC4gQ2FuJ3QgYmVsaWV2ZSBJIG1pc3NlZCB0aGF0IGFuZCB0
aGUgZXJyb3IgY2hlY2tzLg0KPiANCj4gPg0KPiA+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiA+ICsJ
fQ0KPiA+ID4gKw0KPiA+ID4gKwllcnIgPSByY2FyX2dlbjRfcGNpZV9wcmVwYXJlKHJjYXIpOw0K
PiA+ID4gKwlpZiAoZXJyIDwgMCkNCj4gPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gPiArDQo+IA0K
PiA+ID4gKwllcnIgPSByY2FyX2dlbjRfYWRkX2R3X3BjaWVfcnAocmNhcik7DQo+ID4gPiArCWlm
IChlcnIgPCAwKQ0KPiA+ID4gKwkJZ290byBlcnJfYWRkOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1
cm4gMDsNCj4gPiA+ICsNCj4gPiA+ICtlcnJfYWRkOg0KPiA+DQo+ID4gZXJyX3ByZXBhcmUNCj4g
DQo+IElNTyBlaXRoZXIgImVycl91bnByZXBhcmUiIG9yICJlcnJfYWRkX3JwIi4gRmlyc3Qgb3B0
aW9uIHNlZW1zIGJldHRlcg0KPiBzaW5jZSB1bmxpa2UgdGhlIHNlY29uZCB2ZXJzaW9uIGl0IHdv
dWxkIGxvb2sgY29ycmVjdCBpbiBjYXNlIG9mDQo+IGhhdmluZyBtdWx0aXBsZSBnb3RvcyB0byB0
aGUgc2FtZSBsYWJlbC4NCj4gDQo+ICJlcnJfcHJlcGFyZSIgZG9lc24ndCBpbmRpY2F0ZSBuZWl0
aGVyIHRoZSB0YXJnZXQgY29kZSBub3IgdGhlIHNvdXJjZQ0KPiBvZiB0aGUganVtcC4gU28gdGhl
IG5hbWUgZG9lc24ndCBzb3VuZCBkZXNjcmlwdGl2ZSBpZiBub3QgdG8gc2F5DQo+IG1pc2xlYWRp
bmcuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9uLiBJIGNoZWNrZWQgcGNpZS1kZXNp
Z253YXJlLXtlcCxob3N0fS5jIGFuZA0KaXQgc2VlbXMgdGhhdCB0aGUgZ290byBsYWJlbHMgYXJl
Og0KDQplcnJfe3BhcnRfb2ZfY2FsbGluZ19mdW5jdGlvbl9uYW1lfToNCg0KRm9yIGV4YW1wbGU6
DQoNCmVycl9zdG9wX2xpbms6DQogICAgICAgIGR3X3BjaWVfc3RvcF9saW5rKHBjaSk7DQoNCmVy
cl9yZW1vdmVfZWRtYToNCiAgICAgICAgZHdfcGNpZV9lZG1hX3JlbW92ZShwY2kpOw0KDQpTbywg
ZXJyX3VucHJlcGFyZTogaGVyZSBpcyBhIGdvb2QgbGFiZWwsIEkgdGhpbmsuIEknbGwgZml4IHRo
ZSBsYWJlbA0Kb24gdjE5Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+
ID4NCj4gPiA+ICsJcmNhcl9nZW40X3BjaWVfdW5wcmVwYXJlKHJjYXIpOw0KPiA+ID4gKw0KPiA+
ID4gKwlyZXR1cm4gZXJyOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgdm9pZCBy
Y2FyX2dlbjRfcGNpZV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+
ICt7DQo+ID4gPiArCXN0cnVjdCByY2FyX2dlbjRfcGNpZSAqcmNhciA9IHBsYXRmb3JtX2dldF9k
cnZkYXRhKHBkZXYpOw0KPiA+ID4gKw0KPiA+ID4gKwlyY2FyX2dlbjRfcmVtb3ZlX2R3X3BjaWVf
cnAocmNhcik7DQo+ID4gPiArCXJjYXJfZ2VuNF9wY2llX3VucHJlcGFyZShyY2FyKTsNCj4gPiA+
ICt9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgcmNh
cl9nZW40X3BjaWVfb2ZfbWF0Y2hbXSA9IHsNCj4gPiA+ICsJeyAuY29tcGF0aWJsZSA9ICJyZW5l
c2FzLHJjYXItZ2VuNC1wY2llIiwgfSwNCj4gPiA+ICsJe30sDQo+ID4gPiArfTsNCj4gPg0KPiA+
IE1pc3NpbmcgTU9EVUxFX0RFVklDRV9UQUJMRSBzaW5jZSB0aGlzIGRyaXZlciBjYW4gYmUgYnVp
bHQgYXMgYSBtb2R1bGUuDQo+ID4NCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RyaXZlciByY2FyX2dlbjRfcGNpZV9kcml2ZXIgPSB7DQo+ID4gPiArCS5kcml2ZXIgPSB7
DQo+ID4gPiArCQkubmFtZSA9ICJwY2llLXJjYXItZ2VuNCIsDQo+ID4gPiArCQkub2ZfbWF0Y2hf
dGFibGUgPSByY2FyX2dlbjRfcGNpZV9vZl9tYXRjaCwNCj4gPiA+ICsJCS5wcm9iZV90eXBlID0g
UFJPQkVfUFJFRkVSX0FTWU5DSFJPTk9VUywNCj4gPiA+ICsJfSwNCj4gPiA+ICsJLnByb2JlID0g
cmNhcl9nZW40X3BjaWVfcHJvYmUsDQo+ID4gPiArCS5yZW1vdmVfbmV3ID0gcmNhcl9nZW40X3Bj
aWVfcmVtb3ZlLA0KPiA+ID4gK307DQo+ID4gPiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihyY2Fy
X2dlbjRfcGNpZV9kcml2ZXIpOw0KPiA+ID4gKw0KPiA+ID4gK01PRFVMRV9ERVNDUklQVElPTigi
UmVuZXNhcyBSLUNhciBHZW40IFBDSWUgaG9zdCBjb250cm9sbGVyIGRyaXZlciIpOw0KPiA+ID4g
K01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1yY2FyLWdlbjQuYw0KPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uYTVmYjlhYWUwYTZmDQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jDQo+ID4g
PiBAQCAtMCwwICsxLDIwMCBAQA0KPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9ubHkNCj4gPiA+ICsvKg0KPiA+ID4gKyAqIFBDSWUgaG9zdC9lbmRwb2ludCBjb250
cm9sbGVyIGRyaXZlciBmb3IgUmVuZXNhcyBSLUNhciBHZW40IFNlcmllcyBTb0NzDQo+ID4gPiAr
ICogQ29weXJpZ2h0IChDKSAyMDIyLTIwMjMgUmVuZXNhcyBFbGVjdHJvbmljcyBDb3Jwb3JhdGlv
bg0KPiA+ID4gKyAqLw0KPiA+ID4gKw0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0K
PiA+ID4gKyNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9k
ZXZpY2UuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ID4gPiArI2luY2x1ZGUg
PGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4g
PiA+ICsNCj4gPiA+ICsjaW5jbHVkZSAicGNpZS1yY2FyLWdlbjQuaCINCj4gPiA+ICsjaW5jbHVk
ZSAicGNpZS1kZXNpZ253YXJlLmgiDQo+ID4gPiArDQo+ID4gPiArLyogUmVuZXNhcy1zcGVjaWZp
YyAqLw0KPiA+ID4gKyNkZWZpbmUgUENJRVJTVENUUkwxCQkweDAwMTQNCj4gPiA+ICsjZGVmaW5l
ICBBUFBfSE9MRF9QSFlfUlNUCUJJVCgxNikNCj4gPg0KPiA+IFNwYWNpbmcgaXMgbm90IGNvbnNp
c3RlbnQuDQo+ID4NCj4gPiA+ICsjZGVmaW5lICBBUFBfTFRTU01fRU5BQkxFCUJJVCgwKQ0KPiA+
ID4gKw0KPiA+ID4gKyNkZWZpbmUgUkNBUl9OVU1fU1BFRURfQ0hBTkdFX1JFVFJJRVMJMTANCj4g
PiA+ICsjZGVmaW5lIFJDQVJfTUFYX0xJTktfU1BFRUQJCTQNCj4gPiA+ICsNCj4gPiA+ICtzdGF0
aWMgdm9pZCByY2FyX2dlbjRfcGNpZV9sdHNzbV9lbmFibGUoc3RydWN0IHJjYXJfZ2VuNF9wY2ll
ICpyY2FyLA0KPiA+ID4gKwkJCQkJYm9vbCBlbmFibGUpDQo+ID4gPiArew0KPiA+ID4gKwl1MzIg
dmFsOw0KPiA+ID4gKw0KPiA+ID4gKwl2YWwgPSByZWFkbChyY2FyLT5iYXNlICsgUENJRVJTVENU
UkwxKTsNCj4gPiA+ICsJaWYgKGVuYWJsZSkgew0KPiA+ID4gKwkJdmFsIHw9IEFQUF9MVFNTTV9F
TkFCTEU7DQo+ID4gPiArCQl2YWwgJj0gfkFQUF9IT0xEX1BIWV9SU1Q7DQo+ID4gPiArCX0gZWxz
ZSB7DQo+ID4gPiArCQkvKg0KPiA+ID4gKwkJICogU2luY2UgdGhlIGRhdGFzaGVldCBvZiBSLUNh
ciBkb2Vzbid0IG1lbnRpb24gaG93IHRvIGFzc2VydA0KPiA+ID4gKwkJICogdGhlIEFQUF9IT0xE
X1BIWV9SU1QsIGRvbid0IGFzc2VydCBpdCBhZ2Fpbi4gT3RoZXJ3aXNlLA0KPiA+ID4gKwkJICog
aGFuZy11cCBpc3N1ZSBoYXBwZW5lZCBpbiB0aGUgZHdfZWRtYV9jb3JlX29mZigpIHdoZW4NCj4g
PiA+ICsJCSAqIHRoZSBjb250cm9sbGVyIGRpZG4ndCBkZXRlY3QgYSBQQ0kgZGV2aWNlLg0KPiA+
ID4gKwkJICovDQo+ID4gPiArCQl2YWwgJj0gfkFQUF9MVFNTTV9FTkFCTEU7DQo+ID4gPiArCX0N
Cj4gPiA+ICsJd3JpdGVsKHZhbCwgcmNhci0+YmFzZSArIFBDSUVSU1RDVFJMMSk7DQo+ID4gPiAr
fQ0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBpbnQgcmNhcl9nZW40X3BjaWVfbGlua191cChzdHJ1
Y3QgZHdfcGNpZSAqZHcpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgcmNhcl9nZW40X3BjaWUg
KnJjYXIgPSB0b19yY2FyX2dlbjRfcGNpZShkdyk7DQo+ID4gPiArCXUzMiB2YWwsIG1hc2s7DQo+
ID4gPiArDQo+ID4gPiArCXZhbCA9IHJlYWRsKHJjYXItPmJhc2UgKyBQQ0lFSU5UU1RTMCk7DQo+
ID4gPiArCW1hc2sgPSBSRExIX0xJTktfVVAgfCBTTUxIX0xJTktfVVA7DQo+ID4gPiArDQo+ID4g
PiArCXJldHVybiAodmFsICYgbWFzaykgPT0gbWFzazsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4g
PiArc3RhdGljIGJvb2wgcmNhcl9nZW40X3BjaWVfc3BlZWRfY2hhbmdlKHN0cnVjdCBkd19wY2ll
ICpkdykNCj4gPg0KPiA+IEl0J2QgYmUgZ29vZCB0byBhZGQgYSBjb21tZW50IGZvciB0aGlzIGZ1
bmN0aW9uLg0KPiA+DQo+ID4gPiArew0KPiA+ID4gKwl1MzIgdmFsOw0KPiA+ID4gKwlpbnQgaTsN
Cj4gPiA+ICsNCj4gPiA+ICsJdmFsID0gZHdfcGNpZV9yZWFkbF9kYmkoZHcsIFBDSUVfTElOS19X
SURUSF9TUEVFRF9DT05UUk9MKTsNCj4gPiA+ICsJdmFsICY9IH5QT1JUX0xPR0lDX1NQRUVEX0NI
QU5HRTsNCj4gPiA+ICsJZHdfcGNpZV93cml0ZWxfZGJpKGR3LCBQQ0lFX0xJTktfV0lEVEhfU1BF
RURfQ09OVFJPTCwgdmFsKTsNCj4gPiA+ICsNCj4gPiA+ICsJdmFsID0gZHdfcGNpZV9yZWFkbF9k
YmkoZHcsIFBDSUVfTElOS19XSURUSF9TUEVFRF9DT05UUk9MKTsNCj4gPiA+ICsJdmFsIHw9IFBP
UlRfTE9HSUNfU1BFRURfQ0hBTkdFOw0KPiA+ID4gKwlkd19wY2llX3dyaXRlbF9kYmkoZHcsIFBD
SUVfTElOS19XSURUSF9TUEVFRF9DT05UUk9MLCB2YWwpOw0KPiA+ID4gKw0KPiA+ID4gKwlmb3Ig
KGkgPSAwOyBpIDwgUkNBUl9OVU1fU1BFRURfQ0hBTkdFX1JFVFJJRVM7IGkrKykgew0KPiA+ID4g
KwkJdmFsID0gZHdfcGNpZV9yZWFkbF9kYmkoZHcsIFBDSUVfTElOS19XSURUSF9TUEVFRF9DT05U
Uk9MKTsNCj4gPiA+ICsJCWlmICghKHZhbCAmIFBPUlRfTE9HSUNfU1BFRURfQ0hBTkdFKSkNCj4g
PiA+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4gPiA+ICsJCXVzbGVlcF9yYW5nZSgxMDAwMCwgMTEwMDAp
Ow0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBmYWxzZTsNCj4gPiA+ICt9DQo+
ID4gPiArDQo+ID4gPiArc3RhdGljIGludCByY2FyX2dlbjRfcGNpZV9zdGFydF9saW5rKHN0cnVj
dCBkd19wY2llICpkdykNCj4gPg0KPiA+IEZvciB0aGlzIG9uZSB0b28uDQo+ID4NCj4gPiA+ICt7
DQo+ID4gPiArCXN0cnVjdCByY2FyX2dlbjRfcGNpZSAqcmNhciA9IHRvX3JjYXJfZ2VuNF9wY2ll
KGR3KTsNCj4gPiA+ICsJaW50IGksIGNoYW5nZXM7DQo+ID4gPiArDQo+ID4gPiArCXJjYXJfZ2Vu
NF9wY2llX2x0c3NtX2VuYWJsZShyY2FyLCB0cnVlKTsNCj4gPiA+ICsNCj4gPiA+ICsJLyoNCj4g
PiA+ICsJICogUmVxdWlyZSBkaXJlY3Qgc3BlZWQgY2hhbmdlIHdpdGggcmV0cnlpbmcgaGVyZSBp
ZiB0aGUgbGlua19nZW4gaXMNCj4gPiA+ICsJICogUENJZSBHZW4yIG9yIGhpZ2hlci4NCj4gPiA+
ICsJICovDQo+ID4gPiArCWNoYW5nZXMgPSBtaW5fbm90X3plcm8oZHctPmxpbmtfZ2VuLCBSQ0FS
X01BWF9MSU5LX1NQRUVEKSAtIDE7DQo+ID4gPiArDQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIFNp
bmNlIGR3X3BjaWVfc2V0dXBfcmMoKSBzZXRzIGl0IG9uY2UsIFBDSWUgR2VuMiB3aWxsIGJlIHRy
YWluZWQuDQo+ID4gPiArCSAqIFNvLCB0aGlzIG5lZWRzIHJlbWFpbmluZyB0aW1lcyBmb3IgdXAg
dG8gUENJZSBHZW40IGlmIFJDIG1vZGUuDQo+ID4gPiArCSAqLw0KPiA+ID4gKwlpZiAoY2hhbmdl
cyAmJiByY2FyLT5tb2RlID09IERXX1BDSUVfUkNfVFlQRSkNCj4gPiA+ICsJCWNoYW5nZXMtLTsN
Cj4gPiA+ICsNCj4gPiA+ICsJZm9yIChpID0gMDsgaSA8IGNoYW5nZXM7IGkrKykgew0KPiA+ID4g
KwkJaWYgKCFyY2FyX2dlbjRfcGNpZV9zcGVlZF9jaGFuZ2UoZHcpKQ0KPiA+ID4gKwkJCWJyZWFr
OwkvKiBObyBlcnJvciBiZWNhdXNlIHBvc3NpYmxlIGRpc2Nvbm5lY3RlZCBoZXJlIGlmIEVQIG1v
ZGUgKi8NCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ICt9DQo+
ID4gPiArDQo+ID4gPiArc3RhdGljIHZvaWQgcmNhcl9nZW40X3BjaWVfc3RvcF9saW5rKHN0cnVj
dCBkd19wY2llICpkdykNCj4gPiA+ICt7DQo+ID4gPiArCXN0cnVjdCByY2FyX2dlbjRfcGNpZSAq
cmNhciA9IHRvX3JjYXJfZ2VuNF9wY2llKGR3KTsNCj4gPiA+ICsNCj4gPiA+ICsJcmNhcl9nZW40
X3BjaWVfbHRzc21fZW5hYmxlKHJjYXIsIGZhbHNlKTsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4g
PiAraW50IHJjYXJfZ2VuNF9wY2llX2Jhc2ljX2luaXQoc3RydWN0IHJjYXJfZ2VuNF9wY2llICpy
Y2FyKQ0KPiA+DQo+ID4gcy9iYXNpYy9jb21tb24NCj4gPg0KPiA+IC0gTWFuaQ0KPiA+DQo+ID4g
PiArew0KPiA+ID4gKwlzdHJ1Y3QgZHdfcGNpZSAqZHcgPSAmcmNhci0+ZHc7DQo+ID4gPiArCXUz
MiB2YWw7DQo+ID4gPiArDQo+ID4gPiArCWlmICghcmVzZXRfY29udHJvbF9zdGF0dXMoZHctPmNv
cmVfcnN0c1tEV19QQ0lFX1BXUl9SU1RdLnJzdGMpKQ0KPiA+ID4gKwkJcmVzZXRfY29udHJvbF9h
c3NlcnQoZHctPmNvcmVfcnN0c1tEV19QQ0lFX1BXUl9SU1RdLnJzdGMpOw0KPiA+ID4gKw0KPiA+
ID4gKwl2YWwgPSByZWFkbChyY2FyLT5iYXNlICsgUENJRU1TUjApOw0KPiA+ID4gKwlpZiAocmNh
ci0+bW9kZSA9PSBEV19QQ0lFX1JDX1RZUEUpDQo+ID4gPiArCQl2YWwgfD0gREVWSUNFX1RZUEVf
UkM7DQo+ID4gPiArCWVsc2UgaWYgKHJjYXItPm1vZGUgPT0gRFdfUENJRV9FUF9UWVBFKQ0KPiA+
ID4gKwkJdmFsIHw9IERFVklDRV9UWVBFX0VQOw0KPiA+ID4gKwllbHNlDQo+ID4gPiArCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKGR3LT5udW1fbGFuZXMgPCA0KQ0KPiA+
ID4gKwkJdmFsIHw9IEJJRlVSX01PRF9TRVRfT047DQo+ID4gPiArDQo+ID4gPiArCXdyaXRlbCh2
YWwsIHJjYXItPmJhc2UgKyBQQ0lFTVNSMCk7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiByZXNl
dF9jb250cm9sX2RlYXNzZXJ0KGR3LT5jb3JlX3JzdHNbRFdfUENJRV9QV1JfUlNUXS5yc3RjKTsN
Cj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArdm9pZCByY2FyX2dlbjRfcGNpZV9iYXNpY19kZWlu
aXQoc3RydWN0IHJjYXJfZ2VuNF9wY2llICpyY2FyKQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0
IGR3X3BjaWUgKmR3ID0gJnJjYXItPmR3Ow0KPiA+ID4gKw0KPiA+ID4gKwlyZXNldF9jb250cm9s
X2Fzc2VydChkdy0+Y29yZV9yc3RzW0RXX1BDSUVfUFdSX1JTVF0ucnN0Yyk7DQo+ID4gPiArfQ0K
PiA+ID4gKw0KPiA+ID4gK2ludCByY2FyX2dlbjRfcGNpZV9wcmVwYXJlKHN0cnVjdCByY2FyX2dl
bjRfcGNpZSAqcmNhcikNCj4gPiA+ICt7DQo+ID4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IHJj
YXItPmR3LmRldjsNCj4gPiA+ICsJaW50IGVycjsNCj4gPiA+ICsNCj4gPiA+ICsJcG1fcnVudGlt
ZV9lbmFibGUoZGV2KTsNCj4gPiA+ICsJZXJyID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChk
ZXYpOw0KPiA+ID4gKwlpZiAoZXJyIDwgMCkgew0KPiA+ID4gKwkJZGV2X2VycihkZXYsICJGYWls
ZWQgdG8gcmVzdW1lL2dldCBSdW50aW1lIFBNXG4iKTsNCj4gPiA+ICsJCXBtX3J1bnRpbWVfZGlz
YWJsZShkZXYpOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBlcnI7DQo+ID4g
PiArfQ0KPiA+ID4gKw0KPiA+ID4gK3ZvaWQgcmNhcl9nZW40X3BjaWVfdW5wcmVwYXJlKHN0cnVj
dCByY2FyX2dlbjRfcGNpZSAqcmNhcikNCj4gPiA+ICt7DQo+ID4gPiArCXN0cnVjdCBkZXZpY2Ug
KmRldiA9IHJjYXItPmR3LmRldjsNCj4gPiA+ICsNCj4gPiA+ICsJcG1fcnVudGltZV9wdXQoZGV2
KTsNCj4gPiA+ICsJcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ID4gPiArfQ0KPiA+ID4gKw0K
PiA+ID4gK2ludCByY2FyX2dlbjRfcGNpZV9nZXRfcmVzb3VyY2VzKHN0cnVjdCByY2FyX2dlbjRf
cGNpZSAqcmNhcikNCj4gPiA+ICt7DQo+ID4gPiArCS8qIFJlbmVzYXMtc3BlY2lmaWMgcmVnaXN0
ZXJzICovDQo+ID4gPiArCXJjYXItPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2VfYnluYW1lKHJjYXItPnBkZXYsICJhcHAiKTsNCj4gPiA+ICsNCj4gDQo+ID4gPiArCXJldHVy
biBJU19FUlIocmNhci0+YmFzZSkgPyBQVFJfRVJSKHJjYXItPmJhc2UpIDogMDsNCj4gDQo+IFRo
aXMgY2FuIGJlIHJlcGxhY2VkIHdpdGggUFRSX0VSUl9PUl9aRVJPKCkuDQo+IA0KPiA+ID4gK30N
Cj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfb3BzIGR3X3BjaWVf
b3BzID0gew0KPiA+ID4gKwkuc3RhcnRfbGluayA9IHJjYXJfZ2VuNF9wY2llX3N0YXJ0X2xpbmss
DQo+ID4gPiArCS5zdG9wX2xpbmsgPSByY2FyX2dlbjRfcGNpZV9zdG9wX2xpbmssDQo+ID4gPiAr
CS5saW5rX3VwID0gcmNhcl9nZW40X3BjaWVfbGlua191cCwNCj4gPiA+ICt9Ow0KPiA+ID4gKw0K
PiA+ID4gK3N0cnVjdCByY2FyX2dlbjRfcGNpZSAqcmNhcl9nZW40X3BjaWVfZGV2bV9hbGxvYyhz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGRl
dmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiA+ICsJc3RydWN0IHJjYXJfZ2VuNF9wY2llICpy
Y2FyOw0KPiA+ID4gKw0KPiANCj4gPiA+ICsJcmNhciA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVv
ZigqcmNhciksIEdGUF9LRVJORUwpOw0KPiA+ID4gKwlpZiAoIXJjYXIpDQo+ID4gPiArCQlyZXR1
cm4gTlVMTDsNCj4gDQo+IEEgYmV0dGVyIGFwcHJvYWNoIHdvdWxkIGJlIHRvIHJldHVybiBFUlJf
UFRSKC1FTk9NRU0pIGhlcmUgYW5kIGNvbnZlcnQNCj4gdGhlIG1ldGhvZCBjYWxsZXIgdG8gcGVy
Zm9ybWluZyAiaWYgKElTX0VSUihyY2FyKSkgcmV0dXJuDQo+IFBUUl9FUlIocmNhcikiLiBUaHVz
IGluIGNhc2UgaWYgeW91IGRlY2lkZSB0byBleHRlbmQgdGhpcyBtZXRob2QNCj4gc2VtYW50aWNz
IHdpdGggYWRkaXRpb25hbCBjaGVja3MgeW91IHdvbid0IG5lZWQgdG8gdXBkYXRlIHRoZSBjYWxs
ZXINCj4gYW5kIGFsbCB0aGUgZXJyb3JzIHJldHVybmVkIHdpbGwgYmUgcHJvcGFnYXRlZCB1cCB0
byB0aGUga2VybmVsDQo+IGRldmljZS1kcml2ZXIgc3Vic3lzdGVtLg0KPiANCj4gLVNlcmdlKHkp
DQo+IA0KPiA+ID4gKw0KPiA+ID4gKwlyY2FyLT5kdy5kZXYgPSBkZXY7DQo+ID4gPiArCXJjYXIt
PmR3Lm9wcyA9ICZkd19wY2llX29wczsNCj4gPiA+ICsJZHdfcGNpZV9jYXBfc2V0KCZyY2FyLT5k
dywgRURNQV9VTlJPTEwpOw0KPiA+ID4gKwlkd19wY2llX2NhcF9zZXQoJnJjYXItPmR3LCBSRVFf
UkVTKTsNCj4gPiA+ICsJcmNhci0+cGRldiA9IHBkZXY7DQo+ID4gPiArCXBsYXRmb3JtX3NldF9k
cnZkYXRhKHBkZXYsIHJjYXIpOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gcmNhcjsNCj4gPiA+
ICt9DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1y
Y2FyLWdlbjQuaCBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmgN
Cj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjc4
MTE2NTQyMjczOQ0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQuaA0KPiA+ID4gQEAgLTAsMCArMSw0NCBAQA0K
PiA+ID4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8NCj4gPiA+
ICsvKg0KPiA+ID4gKyAqIFBDSWUgaG9zdC9lbmRwb2ludCBjb250cm9sbGVyIGRyaXZlciBmb3Ig
UmVuZXNhcyBSLUNhciBHZW40IFNlcmllcyBTb0NzDQo+ID4gPiArICogQ29weXJpZ2h0IChDKSAy
MDIyLTIwMjMgUmVuZXNhcyBFbGVjdHJvbmljcyBDb3Jwb3JhdGlvbg0KPiA+ID4gKyAqLw0KPiA+
ID4gKw0KPiA+ID4gKyNpZm5kZWYgX1BDSUVfUkNBUl9HRU40X0hfDQo+ID4gPiArI2RlZmluZSBf
UENJRV9SQ0FSX0dFTjRfSF8NCj4gPiA+ICsNCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvaW8uaD4N
Cj4gPiA+ICsjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+ID4gPiArDQo+ID4gPiArI2luY2x1ZGUg
InBjaWUtZGVzaWdud2FyZS5oIg0KPiA+ID4gKw0KPiA+ID4gKy8qIFJlbmVzYXMtc3BlY2lmaWMg
Ki8NCj4gPiA+ICsjZGVmaW5lIFBDSUVNU1IwCQkweDAwMDANCj4gPiA+ICsjZGVmaW5lICBCSUZV
Ul9NT0RfU0VUX09OCUJJVCgwKQ0KPiA+ID4gKyNkZWZpbmUgIERFVklDRV9UWVBFX0VQCQkwDQo+
ID4gPiArI2RlZmluZSAgREVWSUNFX1RZUEVfUkMJCUJJVCg0KQ0KPiA+ID4gKw0KPiA+ID4gKyNk
ZWZpbmUgUENJRUlOVFNUUzAJCTB4MDA4NA0KPiA+ID4gKyNkZWZpbmUgUENJRUlOVFNUUzBFTgkJ
MHgwMzEwDQo+ID4gPiArI2RlZmluZSAgTVNJX0NUUkxfSU5UCQlCSVQoMjYpDQo+ID4gPiArI2Rl
ZmluZSAgU01MSF9MSU5LX1VQCQlCSVQoNykNCj4gPiA+ICsjZGVmaW5lICBSRExIX0xJTktfVVAJ
CUJJVCg2KQ0KPiA+ID4gKyNkZWZpbmUgUENJRURNQUlOVFNUU0VOCQkweDAzMTQNCj4gPiA+ICsj
ZGVmaW5lICBQQ0lFRE1BSU5UU1RTRU5fSU5JVAlHRU5NQVNLKDE1LCAwKQ0KPiA+ID4gKw0KPiA+
ID4gK3N0cnVjdCByY2FyX2dlbjRfcGNpZSB7DQo+ID4gPiArCXN0cnVjdCBkd19wY2llIGR3Ow0K
PiA+ID4gKwl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXY7DQo+ID4gPiArCWVudW0gZHdfcGNpZV9kZXZpY2VfbW9kZSBtb2RlOw0KPiA+ID4g
K307DQo+ID4gPiArI2RlZmluZSB0b19yY2FyX2dlbjRfcGNpZShfZHcpCWNvbnRhaW5lcl9vZihf
ZHcsIHN0cnVjdCByY2FyX2dlbjRfcGNpZSwgZHcpDQo+ID4gPiArDQo+ID4gPiAraW50IHJjYXJf
Z2VuNF9wY2llX2Jhc2ljX2luaXQoc3RydWN0IHJjYXJfZ2VuNF9wY2llICpyY2FyKTsNCj4gPiA+
ICt2b2lkIHJjYXJfZ2VuNF9wY2llX2Jhc2ljX2RlaW5pdChzdHJ1Y3QgcmNhcl9nZW40X3BjaWUg
KnJjYXIpOw0KPiA+ID4gK2ludCByY2FyX2dlbjRfcGNpZV9wcmVwYXJlKHN0cnVjdCByY2FyX2dl
bjRfcGNpZSAqcmNhcik7DQo+ID4gPiArdm9pZCByY2FyX2dlbjRfcGNpZV91bnByZXBhcmUoc3Ry
dWN0IHJjYXJfZ2VuNF9wY2llICpyY2FyKTsNCj4gPiA+ICtpbnQgcmNhcl9nZW40X3BjaWVfZ2V0
X3Jlc291cmNlcyhzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIpOw0KPiA+ID4gK3N0cnVjdCBy
Y2FyX2dlbjRfcGNpZSAqcmNhcl9nZW40X3BjaWVfZGV2bV9hbGxvYyhzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KTsNCj4gPiA+ICsNCj4gPiA+ICsjZW5kaWYgLyogX1BDSUVfUkNBUl9HRU40
X0hfICovDQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4gPg0KPiA+DQo+ID4gLS0NCj4gPiDg
rq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
