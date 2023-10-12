Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88847C6872
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347248AbjJLIDn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 04:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbjJLIDl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 04:03:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26B3DA;
        Thu, 12 Oct 2023 01:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2cjrHyy5UuI4M099dagigaF7t3KsEvUL9VLk4HijQA0rL9GIco+k1JtV/szgN6TC09qFPkXxkijz28WnaC3oomydx58nkGkEZM1bdLeoAJe82VLzswkD0MYl/HGtoTVg4f8LFuz2jP2epmWm4ITltJTO+zrgHUGEE2VhCQsLPAiZm5EVkdU56rIIJ3ZMosrulvMGx3DHnBB0NoviatrkNn6EEEjn4jCsIve51I0GHbYp9VSiAm2FSX+/4IJUC87qPHiJ4Fw9rKnysWICFkb6MWwjJoQI0i3Uqr2pGPE4G8IEGmtNu6W6ScKLGwqzvBwmrh5mFTvMDxp0aJt0rdO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyZlswK03hMfgKI9DIVTWSj07wnZ368H4FOOwYos8G4=;
 b=h+yl1yB7w5qHzIDHnT7Qv61QtdNb5jAY78c886ccWGQYoBPJeesPZ/wr5ZKsj2LqM6XNsuDWwJz9pmR+Gst6HOSJ7wggfdAalpiRzD8cwgt0kykS2tM0HlN4SiYHHvVhKihNfDJ84CQ3dcRjnVZiDWvgecek14fFdaKdbK5KD8aXjDSYaRCCIjC+g0a9bnPi6ygLtrBpB2bXsmpq5xhVJDlx0BS+FEHrO5mBzAXuB6JpYq4uyBgKBX3s21dQNPbIl6S2UWNMLzbKgBG2rCtel9Ui6/qOe8E7gEuDqct1yHBgCFosi8hso5D525s9MOkqyca0Bsdd74VCVbUZuzC3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyZlswK03hMfgKI9DIVTWSj07wnZ368H4FOOwYos8G4=;
 b=lkUFWZFoVf49VvYmOQIyJKoIZWuXmFvceLlAYUGh/OAtRTZ4MCIEVhpsTq7i24hFopoLXTmkbn6k6Fw1vWslBn7K+tHpeuUP8D+tQhHP59oJwetV8jFbNblxBJrWBDu1Qxa+9rWjQTSk9tGsAFfAGUojTckYkK2EraGkN2T/3d0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5804.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:03:34 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 08:03:34 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid unnecessary
 memory assignment
Thread-Topic: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid
 unnecessary memory assignment
Thread-Index: AQHZ/BKVrluFe2vL8EK2EaoOE81Q27BEeMGAgAAW3YCAAAMjAIAAGZMAgAER4NA=
Date:   Thu, 12 Oct 2023 08:03:34 +0000
Message-ID: <TYBPR01MB534168BE8CED70F2768E46AAD8D3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
 <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
 <abf65z7xxsnd7adkg523mneccudwenvdzcw7jpblafqzvhca5n@lbpsch7ztxsn>
 <20231011130727.GA3722793@rocinante> <20231011131840.GB5952@thinkpad>
 <yaogf4d672yb76lbx7e7gu2ykm7shujfwgqiztfydbsodwuymr@rkffjewg6hnp>
In-Reply-To: <yaogf4d672yb76lbx7e7gu2ykm7shujfwgqiztfydbsodwuymr@rkffjewg6hnp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB5804:EE_
x-ms-office365-filtering-correlation-id: 276ef5d4-a14d-47cc-882f-08dbcaf9bb63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AqG1Qs+IQZWMIrheNuwTjHoGkAG3GNeSk9S6lx28r6rxLHYvKjltutwl9H++vZJyfu+dN9+S5gOddGW1Njmp6bFuBdOHa3BN0sVWUw/ws4Dylmyh2VT3z03+yk1vqfRByzQ0wAfbF3wDSHsK89hGNyTwpThIe7ty/CrPWDgRrHcevfr7PCXga4jXbsiU+DyltNRectzynmeXnik0reE5PYJn9sOXkNWUuayePeQwBR5iIkCHtm4rkWqydjBUJJojV3KLREO2UF8+nFOnldlHjuE6IzWsTY7t45Hf6bVUbkP4xy5VxwCF/Doswinobm4DSUVSsE4b1RaNsCrQiRuaakGzuIfiBPLv0xnFFfF5lHYAGkd05sMEF9Ieo4yq5sjes4za1NaBUIajw1ZoudFPWyCpqObxBD/P4+0fPpDX6lJ46EuOCMnpB3+azVanmh6XFcrm5R4OJljp+5cagbbp3tfAM4k3uM/gnngmwr8CblSjW7bEB5JiZmwwTMAybfP0Sq8MpirJheqEjiwxjaFOY2EPjQofCtcWMnnL6IUV3obQPrzHUxpvV6p6x5r4EznPuEO+bQlo49BV/yFJWiHx6/LpEvTOr8oXd9ecbT5mAXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(4326008)(8936002)(8676002)(38070700005)(64756008)(52536014)(54906003)(5660300002)(110136005)(66946007)(66446008)(76116006)(66556008)(66476007)(316002)(41300700001)(38100700002)(45080400002)(7416002)(33656002)(9686003)(66574015)(86362001)(122000001)(71200400001)(966005)(478600001)(55016003)(83380400001)(2906002)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHVkT2NHcWRqZG8vVkRDZ3BoQ2V6ZzBIWWt0ekhOUzNIOHB4dFFRL1pjdmJq?=
 =?utf-8?B?Ym9KZllaaHZ1dC9FQW10cFRLRWdxVzQ5a2oycEZRYkJhbTFYemxHTVNXRExo?=
 =?utf-8?B?MFBSd0ZqYzZKdk9BTzVpd2g5RUQxUDJNY1ZMcXU0R1R2U1BsSG53czZCb1h2?=
 =?utf-8?B?ejgxTzkvdW1JeU5Pa3drQ2dINjhyR0wzSHE3czY0cUhGNUIxdnlRQ1lQOWdh?=
 =?utf-8?B?ajFHN2YvQkVkSmpIZ1ZtM3JjZUt2ajlac0xvMjNGZHYyenpoNjhObzZJbHpJ?=
 =?utf-8?B?YnpPalMvN3JnRFovQW9xMzBwTzlWR2RRRTh1NkFsT0Y1OXlEWUh5VHRYelVG?=
 =?utf-8?B?QzlvVUZlb2ZHYXhLOTRWeGZiRnFNZXFDRnpaRnhmK2gxNStZOGNqRjdHSEJp?=
 =?utf-8?B?TVA3WTE0b2ovcDVYNWx2SExzUTNHem0yYkdGSzZISzZ6bmhSanJSLytYT2p6?=
 =?utf-8?B?SDNPZlp6b29yOFl0QXdNYS8zWXdUcjNIN1FMYzJyMDE0K0l1Y2prZHZiWWJ1?=
 =?utf-8?B?U3hPekh5cS96VGozT1NIQWFaVkxnZ2tiZFNDdHJoV3hjWWpMcmkyMzFwM1pY?=
 =?utf-8?B?WUVBb3ZZQmVENmRpOU1mRlhkQ0pENW82ZUxDek9TUFcza0RORDFoL2dBd3U5?=
 =?utf-8?B?SWVZSmF6OFJUZVVuNXdDbVcyeGZMRUN5eStFM0FYK2EwMmFqbWhFbmxDRVYz?=
 =?utf-8?B?Zi9WNW1CNVJaWW9mUFU4TERxZzVHTXVKS3RhZXp2WDJoKzlXV3BWcFdVak9F?=
 =?utf-8?B?bW9CNm9CdjFwaW5qZCthQ2MwenRNeUhRdnpuU3Ztek9FOG1XcXI1WE1iTHBI?=
 =?utf-8?B?ODJQTFZQbndrL1ZYZXdtMVVmTGpxc2tGcFpvUW1MUmhVYlZXYi9KS1ZveGlQ?=
 =?utf-8?B?djIvY2lQMGhvRXhLVlNZbDVGSXdOUXdmTmdVV2pOdVJNQ3Btb25FWE5XT3g0?=
 =?utf-8?B?dEdRUThxWTlWWFhTUXBpU3l6b0cyOTNVcUhENnlyandQK2pBanlsVUxtUFFv?=
 =?utf-8?B?aDBKQndvUkl5YlE0VFBVRThIQW1ISlZTWG10aEt4TUtOS2N5L201bjlNRWxo?=
 =?utf-8?B?WVg4WkhtY0lsa0hvamVGWEJJc1E1eWlRaGxKV2RWa2phb2k0Mll4aU14N3R0?=
 =?utf-8?B?RE9pZzVVU0JFclpLYUcydUZ1anp2RyttOEErN2RqcmlQdnZab1p0UjVnazZZ?=
 =?utf-8?B?NWlCd2hBWVBWZG9KK0VYM1hBMWt5WnFmL0tSSktxNjYrNGcveHJzakw4MGZO?=
 =?utf-8?B?c0VXaUxQZFBDejdNTEFUS05oVGVwK0xXamliVUdLWXh4OUVMUDB0ZlNIcnZh?=
 =?utf-8?B?bjN5WEtNV2dDK3FrMzQzbjk1UWJjbW9xeUs0ejdEKzBzQzlwbzRLMWVJTm1u?=
 =?utf-8?B?NUJFVXJBTmdURHNoUFAzZGFmRHprdkZYVzRqMXZOekhHVE1Ga0VwdUFJbzVC?=
 =?utf-8?B?Ly82Z2RtSWpVZW1nQlp3VWgreHltUUZZaElWUTZwVjhGTjVPZjVodkQ2dmw1?=
 =?utf-8?B?cVdhWjZhOUVWRnN5VEV6aWZRYzNEM2hwdkRCTmcxSUlxSjczT29ZK3B6blBy?=
 =?utf-8?B?cjB6Mlh3RHdPS1ZiWEtFWmx3eGZYK29zUmpZWUpzelB0RmFTK2N6TGRuU2J3?=
 =?utf-8?B?alIyVE9lYmx1MFAyQU1LcFJyRU5acStsZTB4cUQxV3JBWlNaWWdON1ZkNHU3?=
 =?utf-8?B?VXRNa29pMHAyK1ZNZ0tqS2dDZ3JGKzY4MG9iN0VYSDBPQW4wWTNDbGZlQkNs?=
 =?utf-8?B?K0dsNzIwZTJJbU9nVStrc2kzMUFCRGJaMFdBUmIwWXlySzA1RndWRURlZndD?=
 =?utf-8?B?Sml1bi9mNE40M2wxVFZHRlQxSEZKTzVnVURObS83b3hDQ0phSk9YSXJFcXhx?=
 =?utf-8?B?UnF1TmdIajllQURkT2FFYVJuRnArZk9ZWXcvbnBGVG1kQmRwZE5lRVJ2cm5l?=
 =?utf-8?B?Wm80QkVDYXB5MGRmUDJ2bDZsalZpeW4wZ215bEQ0UDZ3am91S2ZNSVRKQk56?=
 =?utf-8?B?Z2lLTFFrSkJKaUxsY0pQZE9ZRjYvRmFpc0xKSkhKcTllNXFFQW9vUURCVGZ1?=
 =?utf-8?B?NlZISFpralVwelgvem5remk5WHUzWHlBWTUyeVV5WkU0UlBhb1B0VVFQMkpG?=
 =?utf-8?B?QmJOWjJTWXJaYUhCRy94SFd4R1EvUWZEZzluZHlQUlJienlIRW1yZG9mNzlu?=
 =?utf-8?B?YVBYdXMyUUpISUg5OVVQUmRpbGtSU1JxUXVxcGRmeXNHaHNvRTNPeXpRaGgz?=
 =?utf-8?B?ZEZUbzA1azNsMUJUbUJ1OXZIbzZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276ef5d4-a14d-47cc-882f-08dbcaf9bb63
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 08:03:34.2188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIPwNJzSE9Pkx48eqxisOys70hlSPRmtQLpJnPWe/8nD3Lrur23oVJrOp/pkW89v6UCYTpUnxvEXnCLF9CeemKnlbul7tmwMWxwIYqlcBunb8OumIRjtOfnk58Hsq8+T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gU2VyZ2UsIEtyenlzenRvZiwgTWFuaSwNCg0KPiBGcm9tOiBTZXJnZSBTZW1pbiwgU2Vu
dDogV2VkbmVzZGF5LCBPY3RvYmVyIDExLCAyMDIzIDExOjUwIFBNDQo+IA0KPiBIZWxsbyBLcnp5
c3p0b2YsIE1hbmkNCj4gDQo+IE9uIFdlZCwgT2N0IDExLCAyMDIzIGF0IDA2OjQ4OjQwUE0gKzA1
MzAsIE1hbml2YW5uYW4gU2FkaGFzaXZhbSB3cm90ZToNCj4gPiBPbiBXZWQsIE9jdCAxMSwgMjAy
MyBhdCAxMDowNzoyN1BNICswOTAwLCBLcnp5c3p0b2YgV2lsY3p5xYRza2kgd3JvdGU6DQo+ID4g
PiBIZWxsbywNCj4gPiA+DQo+ID4gPiBbLi4uXQ0KPiA+ID4gPiA+ICsJLyoNCj4gPiA+ID4gPiAr
CSAqIEFjY29yZGluZyB0byB0aGUgc2VjdGlvbiAzLjUuNy4yICJSQyBNb2RlIiBpbiBEV0MgUENJ
ZSBEdWFsIE1vZGUNCj4gPiA+ID4gPiArCSAqIFJldi41LjIwYSwNCj4gPiA+ID4NCj4gPiA+ID4g
YW5kIDMuNS42LjEgIlJDIG1vZGUiIGluIERXQyBQQ0llIFJDIGRhdGFib29rIHY1LjIwYS4NCj4g
PiA+DQo+ID4gPiBPSy4gIEkgY2FuIGZpeCB0aGlzIGNpdGF0aW9uIGxhdGVyLg0KPiA+ID4NCj4g
PiA+ID4gPiArICAgICAgLi4uIHdlIHNob3VsZCBkaXNhYmxlIHR3byBCQVJzIHRvIGF2b2lkIHVu
bmVjZXNzYXJ5IG1lbW9yeQ0KPiA+ID4gPiA+ICsJICogYXNzaWdubWVudCBkdXJpbmcgZGV2aWNl
IGVudW1lcmF0aW9uLg0KPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+ID4gKwlkd19wY2llX3dyaXRl
bF9kYmkyKHBjaSwgUENJX0JBU0VfQUREUkVTU18wLCAweDApOw0KPiA+ID4gPiA+ICsJZHdfcGNp
ZV93cml0ZWxfZGJpMihwY2ksIFBDSV9CQVNFX0FERFJFU1NfMSwgMHgwKTsNCj4gPiA+ID4gPiAr
DQo+ID4gPiA+DQo+ID4gPiA+IFdoYXQncyB0aGUgcG9pbnQgaW4gZG9pbmcgdGhpcw0KPiA+ID4g
PiAJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJX0JBU0VfQUREUkVTU18wLCAweDAwMDAwMDA0
KTsNCj4gPiA+ID4gCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSV9CQVNFX0FERFJFU1NfMSwg
MHgwMDAwMDAwMCk7DQo+ID4gPiA+ICAgICAgICAgLi4uDQo+ID4gPiA+ICAgICAgICAgZHdfcGNp
ZV93cml0ZWxfZGJpKHBjaSwgUENJX0JBU0VfQUREUkVTU18wLCAwKTsNCj4gPiA+ID4gYWZ0ZXJ3
YXJkPw0KPiA+ID4gPg0KPiA+ID4gPiBJIGd1ZXNzIGlmIHRoZSBCQVJzIGFyZSBkaXNhYmxlZCB0
aGVyZSBpcyBubyBuZWVkIGluIGhhdmluZyB0aGVtDQo+ID4gPiA+IHRvdWNoZWQuIEFtIEkgd3Jv
bmc/DQoNCkkgdHJpZWQgdG8gcmVtb3ZlIHRoZXNlIHNldHRpbmcgb24gbXkgZW52aXJvbm1lbnQs
IGFuZCB0aGVuIGl0IGFsc28gd29ya2VkLg0KU28sIGFzIHlvdSBtZW50aW9uZWQsIHRoZXJlIGlz
IG5vIG5lZWQsIEkgdGhpbmsuDQoNCj4gPiA+ID4gQlRXIEkgZmFpbGVkIHRvIHVuZGVyc3RhbmQg
d2h5IHRoZSBCQVJzIGluaXRzIHdhcyBvcmlnaW5hbGx5IG5lZWRlZDoNCj4gPiA+ID4gZmlyc3Qg
bWVyZ2luZyB0aGUgQkFSMCBhbmQgQkFSMSBpbnRvIGEgc2luZ2xlIDY0LWJpdCBCQVIsIHRoZW4N
Cj4gPiA+ID4gc3dpdGNoaW5nIGl0IGJhY2sgdG8gdHdvIDMyLWJpdCBCQVJzLiBNb3Jlb3ZlciBo
ZXJlIGlzIHdoYXQgcHJpb3IgRFcNCj4gPiA+ID4gUENJZSBSQyB2NS54IGRhdGFib29rcyBzYXkg
YWJvdXQgdGhlIEJBUnM6DQo+ID4gPiA+DQo+ID4gPiA+ICIzLjUuNiBCQVIgRGV0YWlscw0KPiA+
ID4gPiBCYXNlIEFkZHJlc3MgUmVnaXN0ZXJzIChPZmZzZXQ6IDB4MTAteDE0KQ0KPiA+ID4gPiBU
aGUgU3lub3BzeXMgY29yZSBkb2VzIG5vdCBpbXBsZW1lbnQgdGhlIG9wdGlvbmFsIEJBUnMgZm9y
IHRoZSBSQw0KPiA+ID4gPiBwcm9kdWN0LiBUaGlzIGlzIGJhc2VkIG9uIHRoZSBhc3N1bXB0aW9u
IHRoYXQgdGhlIFJDIGhvc3QgcHJvYmFibHkgaGFzDQo+ID4gPiA+IHJlZ2lzdGVycyBvbiBzb21l
IG90aGVyIGludGVybmFsIGJ1cyBhbmQgaGFzIGtub3dsZWRnZSBhbmQgc2V0dXANCj4gPiA+ID4g
YWNjZXNzIHRvIHRoZXNlIHJlZ2lzdGVycyBhbHJlYWR5LiINCj4gPiA+ID4NCj4gPiA+ID4gSSBh
bSBub3Qgc3VyZSBJIGZ1bGx5IHVuZGVyc3RhbmQgd2hhdCBpdCBtZWFucywgYnV0IGl0IHNlZW1z
IGFzIERXDQo+ID4gPiA+IFBDSWUgY29yZXMgZGlkbid0IGhhdmUgYW55dGhpbmcgYmVoaW5kIHRo
ZSBSQyBCQVJzIGV2ZW4gYmFjayB0aGVuLiBTbw0KPiA+ID4gPiBpdCBzZWVtcyB0byBtZSB0aGF0
IHRoZSBCQVJzIG1hbmlwdWxhdGlvbiB3YXMgdGhlIEV4aW5vcyBQQ0llIGhvc3QNCj4gPiA+ID4g
c3BlY2lmaWMsIGZyb20gd2hpY2ggZHJpdmVyIHRoZXkgYXJlIG9yaWdpbmF0aW5nIC0gY29tbWl0
IDM0MGNiYTYwOTJjMg0KPiA+ID4gPiAoInBjaTogQWRkIFBDSWUgZHJpdmVyIGZvciBTYW1zdW5n
IEV4eW5vcyIpLg0KPiA+ID4NCj4gDQo+ID4gPiBXb3VsZCBhbnkgb2YgdGhlIGFib3ZlIGJlIHNv
bWV0aGluZyB3ZSBuZWVkIHRvIGFkZHJlc3MgYmVmb3JlIHRoaXMgc2VyaWVzDQo+ID4gPiBjYW4g
YmUgc3VjY2Vzc2Z1bGx5IG1lcmdlZD8gIEkgYW0gYXNraW5nIGlmIHRoaXMgaXMgYSBzaG93IHN0
b3BwZXIsDQo+ID4gPiBzb21ldGhpbmcgd2UgY2FuIGZpeCBsYXRlciwgb3IgZXZlbiBzb21ldGhp
bmcgSSBjb3VsZCBhZGRyZXNzIG9uY2UgSSB0YWtlDQo+ID4gPiB0aGlzIHNlcmllcyBhZ2Fpbi4N
Cj4gPiA+DQo+ID4gPiBUaG91Z2h0cz8NCj4gPiA+DQo+IA0KPiBJIGNhbid0IGNvbmZpcm0gZm9y
IHN1cmUgdGhhdCB0aGUgQkFScyBtYW5pcHVsYXRpb25zIGluIHRoaXMgcGF0Y2gNCj4gd2lsbCB3
b3JrIG9uIHRoZSBvbGRlciBJUC1jb3JlcyAocHJpb3IgNS4xMGEpIG9yIHdpbGwgYmUgcmVxdWly
ZWQgZm9yDQo+IGFsbCBuZXcgY29udHJvbGxlcnMgKDUuMTBhIGFuZCBuZXdlcikuIEJhc2VkIG9u
IHRoZSBCQVJzIGRlc2NyaXB0aW9uDQo+IHBvc3RlZCBpbiB0aGUgSVAtY29yZSBIVyBtYW51YWxz
LCB0aGUgQ1NScyBzZW1hbnRpYyBoYXMgY2hhbmdlZA0KPiBiZXR3ZWVuIHRoZSBtYWpvciByZWxl
YXNlcy4gT2xkIERXIFBDSWUgUkMgSVAtY29yZSBIVy1tYW51YWxzDQo+IGV4cGxpY2l0bHkgc3Rh
dGUgdGhhdCB0aGUgQkFScyBhcmUgdW5hdmFpbGFibGU6DQo+IA0KPiAiVGhlIFN5bm9wc3lzIGNv
cmUgZG9lcyBub3QgaW1wbGVtZW50IHRoZSBvcHRpb25hbCBCQVJzIGZvciB0aGUgUkMNCj4gcHJv
ZHVjdCINCj4gDQo+IE5ldyBEVyBQQ0llIFJDIElQLWNvcmVzIG1hbnVhbCBzYXkgdGhhdCB0aGUg
QkFScyBleGlzdCwgYnV0IGFyZQ0KPiBub3JtYWxseSB1bnVzZWQ6DQo+IA0KPiAiVHdvIEJBUnMg
YXJlIHByZXNlbnQgYnV0IGFyZSBub3QgZXhwZWN0ZWQgdG8gYmUgdXNlZC4gWW91IHNob3VsZA0K
PiBkaXNhYmxlIHRoZW0gdG8gYXZvaWQgdW5uZWNlc3NhcnkgbWVtb3J5IGFzc2lnbm1lbnQgZHVy
aW5nIGRldmljZQ0KPiBlbnVtZXJhdGlvbi4gSWYgeW91IGRvIHVzZSBhIEJBUiwgdGhlbiB5b3Ug
c2hvdWxkIHByb2dyYW0gaXQgdG8NCj4gY2FwdHVyZSBUTFBzIHRoYXQgYXJlIHRhcmdldGVkIHRv
IHlvdXIgbG9jYWwgbm9uLWFwcGxpY2F0aW9uIG1lbW9yeQ0KPiBzcGFjZS4uLi4gVGhlIEJBUiBy
YW5nZSBtdXN0IGJlIG91dHNpZGUgb2YgdGhlIHRocmVlIEJhc2UvTGltaXQNCj4gcmVnaW9ucy4u
LiINCj4gDQo+IFNvIGluIHRoZW9yeSBpdCdzIHBvc3NpYmxlIHRvIGhhdmUgcGxhdGZvcm1zIHdp
dGggdGhlIEJBUnMgc29tZWhvdw0KPiB1dGlsaXplZCBldmVuIGluIHRoZSBSb290IFBvcnRzLiBU
aG91Z2ggY3VycmVudGx5IEFGQUlDUyB3ZSBkb24ndA0KPiBoYXZlIHN1Y2ggZGV2aWNlcyBzdXBw
b3J0ZWQgaW4ga2VybmVsLg0KPiANCj4gPg0KPiA+IElmIFlvc2hpaGlybyBjYW4gY29uZmlybSB0
aGF0IGhpcyBjb250cm9sbGVyIGNhbiB3b3JrIHdpdGhvdXQgdGhpcyBwYXRjaCwgdGhlbg0KPiA+
IEknZCB2b3RlIGZvciBkcm9wcGluZyB0aGlzIHBhdGNoIGFuZCBhcHBseWluZyB0aGUgcmVzdC4N
Cj4gDQo+IEFGQUlSIFlvc2hpaGlybyBpbnNpc3RlZCB0byBoYXZlIHRoZSBCQVJzIHJlc2V0IGJl
Y2F1c2Ugd2l0aG91dA0KPiBpdCBzb21ldGhpbmcgZGlkbid0IHdvcmssIHNvIGhlIGFkZGVkIHNv
bWUgY29tbWVudCB0byBqdXN0aWZ5IGl0Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1wY2kvVFlCUFIwMU1CNTM0MTA0Mzg5OTUyRDg3Mzg1RTg3NDVFRDg4NzlAVFlCUFIwMU1CNTM0
MS5qcG5wcmQwMS5wcm9kLm91dGxvb2suY29tLw0KDQpZZXMsIHRoZSBzZXR0aW5ncyBhcmUgcmVh
bGx5IG5lZWRlZCBvbiBteSBlbnZpcm9ubWVudC4NCiMgSSBjaGVja2VkIHRoaXMgYWdhaW4gdG9k
YXkuDQoNCj4gVGhvdWdoIGJhc2VkIG9uIHRoZSBjb21tZW50IHRoZSBCQVJzIHJlc2V0IHN0aWxs
IHNlZW1zIG9wdGlvbmFsLg0KPiANCj4gT25lIG1vcmUgbG93LWxldmVsIGRyaXZlciB3aGljaCBh
bHJlYWR5IGRvZXMgd2hhdCBpcyBpbXBsZW1lbnRlZCBpbg0KPiB0aGlzIHBhdGNoIGlzIHRoZSBL
ZXlzdG9uZSBQQ0kgaG9zdC1jb250cm9sbGVyIGRyaXZlciAoc2VlLA0KPiBwY2kta2V5c3RvbmUu
YyBhbHNvIGFjdGl2YXRlcyBkYmlfY3MyIGFuZCB6ZXJvcyBvdXQgdGhlDQo+IFBDSV9UWVBFMF9C
QVIwX0VOQUJMRUQgZmxhZykuDQoNClRoYW5rIHlvdSBmb3IgdGhlIGluZm9ybWF0aW9uLiBJIGNv
dWxkIG5vdCBmaW5kIHRoZSBzZXR0aW5ncy4uLg0KLS0tLS0NCnN0YXRpYyB2b2lkIGtzX3BjaWVf
c2V0dXBfcmNfYXBwX3JlZ3Moc3RydWN0IGtleXN0b25lX3BjaWUgKmtzX3BjaWUpDQp7DQouLi4N
CiAgICAgICAgLyogRGlzYWJsZSBCQVJzIGZvciBpbmJvdW5kIGFjY2VzcyAqLw0KICAgICAgICBr
c19wY2llX3NldF9kYmlfbW9kZShrc19wY2llKTsNCiAgICAgICAgZHdfcGNpZV93cml0ZWxfZGJp
KHBjaSwgUENJX0JBU0VfQUREUkVTU18wLCAwKTsNCiAgICAgICAgZHdfcGNpZV93cml0ZWxfZGJp
KHBjaSwgUENJX0JBU0VfQUREUkVTU18xLCAwKTsNCiAgICAgICAga3NfcGNpZV9jbGVhcl9kYmlf
bW9kZShrc19wY2llKTsNCi0tLS0tDQoNCj4gTW9yZW92ZXIgc29tZXRoaW5nIHNpbWlsYXIgaXMg
ZG9uZSBpbg0KPiB0aGUgZ2VuZXJpYyBEVyBQQ0llIEVQIGRyaXZlciBpbiB0aGUgZnJhbWV3b3Jr
IG9mIHRoZQ0KPiBfX2R3X3BjaWVfZXBfcmVzZXRfYmFyKCkgbWV0aG9kIGluY2x1ZGluZyB0aGUg
ZGlyZWN0IEJBUnMgemVyb2luZyBvdXQNCj4gKHdoaWNoIEkgcXVlc3Rpb25lZCBpbiBteSBpbml0
aWFsIG1lc3NhZ2UgaW4gdGhpcyB0aHJlYWQpLiBTbyBzZWVpbmcNCj4gdGhpcyBwYXRjaCB3b3Vs
ZCByZS1kbyB3aGF0IGlzIGFscmVhZHkgZG9uZSBmb3IgdGhlIEtleXN0b25lIGRldmljZQ0KPiBh
bmQgd291bGQgYWRkIGEgcGFydGx5IGR1cGxpY2F0ZWQgY29kZSBpdCB3b3VsZCBiZSByZWFzb25h
YmxlIHRvIGRyb3ANCj4gdGhlIHBhdGNoIGZvciBub3cgYW5kIGdldCB0aGUgQkFScyByZXNldCBi
YWNrIHRvIHRoZSBSY2FyIGhvc3QNCj4gbG93LWxldmVsIGRyaXZlciBhcyBpdCB3YXMgaW4gdjIz
LiBXZSBjYW4gZ2V0IGJhY2sgdG8gdGhlIHRvcGljDQo+IGFmdGVyd2FyZCBhbmQgc2VlIHdoZXRo
ZXIgdGhlIEJBUnMgcmVzZXQgY291bGQgYmUgZG9uZSBnZW5lcmljYWxseSBmb3INCj4gdGhlIFJQ
cy4gSWYgd2UgZmlndXJlIG91dCB0aGF0IGl0J3MgcmVxdWlyZWQgYXQgbGVhc3QgZm9yIHRoZSBu
ZXcNCj4gY29udHJvbGxlcnMgdGhlbiB3ZSdsbCBiZSBhYmxlIHRvIGltcGxlbWVudCBhIGdlbmVy
aWMgUlAvRVAgQkFScyByZXNldA0KPiBtZXRob2QsIGhhdmUgaXQgdXRpbGl6ZWQgaW4gYm90aCBE
VyBQQ0llIGNvcmUgZHJpdmVycyBhbmQgZHJvcCB0aGUNCj4gcmVzcGVjdGl2ZSBjb2RlIGZyb20g
Ym90aCBSY2FyIGFuZCBLZXlzdG9uZSBMTEREcy4NCg0KSWYgcG9zc2libGUsIEkgd291bGQgbGlr
ZSB0byBoYXZlIHRoZSBzZXR0aW5nIG9uIHBjaWUtcmNhci1nZW40LmMgb25seSwNCmZvciBhdm9p
ZGluZyBhbnkgdHJvdWJsZSwgZXNwZWNpYWxseSBvbiBvdGhlciBEV0MgZHJpdmVycy4NCg0KPiAt
U2VyZ2UoeSkNCj4gDQo+ID4NCj4gPiBUaGlzIGNhbiBiZSBzdWJtaXR0ZWQgbGF0ZXIgaWYgcmVx
dWlyZWQuDQo+ID4NCj4gPiAtIE1hbmkNCj4gPg0KPiA+ID4gPiAqIEJUVyBZb3NoaWhpcm8sIEkg
YW0gc29ycnkgdG8gc2VlIHlvdXIgcGF0Y2hzZXQgaXMgc3RpbGwgdW5kZXIgcmV2aWV3Li4uKA0K
DQpTZXJnZSwgbm8gd29ycmllcyEgVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBzdXBwb3J0
IGFnYWluIGFuZCBhZ2FpbiENCg0KPiA+ID4gWWVzLCB3ZSBuZWVkIHRvIGRyYXcgYSBsaW5lIHNv
bWV3aGVyZS4gOikgIEkgYW0gaGFwcHkgdG8gdGFrZSB0aGlzIHNlcmllcw0KPiA+ID4gc28gd2Ug
ZG9uJ3QgbWlzcyBhbm90aGVyIG1lcmdlIHdpbmRvdy4gIFdlIGNhbiBhbHdheXMgZml4IG90aGVy
IGJpdHMgYW5kDQo+ID4gPiBwaWVjZXMgbGF0ZXIgYW5kIGlyb24gb3V0IGFueSBraW5rcyB0aGF0
IG1pZ2h0IGhhdmUgZmFsbGVuIHRocm91Z2ggdGhlDQo+ID4gPiBjcmFja3MsIHNvIHRvIHNwZWFr
Lg0KDQpLcnp5c3p0b2YsIHRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgc3VwcG9ydCEgSSBo
b3BlIHRoYXQgdGhpcyBwYXRjaHNldCBjYW4gYmUNCm1lcmdlZCBpbnRvIHY2LjctcmMxLi4uDQoN
CkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gPiA+IAlLcnp5c3p0b2YNCj4g
Pg0KPiA+IC0tDQo+ID4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCu
v+CuteCuruCvjQ0K
