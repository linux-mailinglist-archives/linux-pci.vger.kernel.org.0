Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CA460D148
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiJYQHq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJYQHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 12:07:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00605183DAB;
        Tue, 25 Oct 2022 09:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFSu8+WgNm6EkgYmTnYlC8kyp/wAPPaKq0JjaoD4FVcD02ULDwWFeIkdqSMLOlc0ysiLmm8wqgnlbjkE4iWbEUE1/hWBiON5/vxCfAW3/J9O7iGOeRm8YHUxakTi9QuCHjZVOBJD4OiDfn5ofrF2ekRUhxtO4RhqtmVqrMbpjlLSOp4Qh0mpZDj5YsosEviMNwhERiCWqkhP2yAqdnyRYAbhAC8un7TaLLlQryQDmG/dr7wn5DS9b0wDcivWZ9XjsWKmxpL4dI+zSIkKRhcu3os7waFzGfGvlNFQWEaNwImkBzD3mIIOKUb4XGnOFiojzEtddJOccSX1Ktxyqcyx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipxDk/X1nkCpmKvgcCLkdYppBppEZmhSaEj+M4yK6LA=;
 b=dcUPm0R5fbb4Xm6y9QJEEbA0bxZOaY9EcuyV8E8sXJ2iNITL5FGMaFHD1oDSuGw/5P2fCVpU80dnzNaBa5eAox2MbqanP7rRnzfhIv9Xi+p1IsQuzsvwL+CtTNhSctM9INjxdI1MXgehws9S8CyTntxCGg0ladv3P7I1VabMekH7TP4eX0SOW+eaNxbAeB4fAODbhJnLIppLdd77z5e9ZdlJfWkTelkib+a09Osl43dNm4sDXQbpKYQxJ8CC/iIv/cbBTKhYJvlB2LIw+BhWHqJBWqItpH6M5DO0SvliojT2hBrkx2RA0LLwUL79LGzZO9XBKjlezBfAiedpD/At+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipxDk/X1nkCpmKvgcCLkdYppBppEZmhSaEj+M4yK6LA=;
 b=mH497i3JONXvRoxQz/UhyeuzPJteJhO1s7ohNA8RbQ9zG5keL79cIKh5Zg/2FYrJR4/ytEOBh44G2oX/QK6kn8ESAqYCLV8y+Eso8aMRM+KTPm5A5gwk7gD9demuCDALcxR5Fm/eyVbF2ysImNLS2PuufS7TFebU+TYs2kvj95M=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by VI1PR04MB6863.eurprd04.prod.outlook.com (2603:10a6:803:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 16:07:40 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.023; Tue, 25 Oct
 2022 16:07:40 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shunsuke Mie <mie@igel.co.jp>
CC:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
Thread-Topic: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
Thread-Index: AQHY6H0/bvuG5O/HGUqsNICaEl4Piq4fRolw
Date:   Tue, 25 Oct 2022 16:07:40 +0000
Message-ID: <HE1PR0401MB233126D2C7410EC5F6C3976488319@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20220922092357.123732-1-mie@igel.co.jp>
 <20221025142143.GA109941@thinkpad>
In-Reply-To: <20221025142143.GA109941@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|VI1PR04MB6863:EE_
x-ms-office365-filtering-correlation-id: 62ea8ea4-497c-4abc-be68-08dab6a30adb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChZ2gMj9MdsZ21HXfwOCb3YPjgDr0nVfiBw+KW+2QqJctCiSwA+NUJgrHnmpVln1G5o2Q7Sdmkf4eT9vxDZKJXssq9W2pK33UxFv6czkFOuwU1IxHU0ShLiskjlV4l+0mdXTpsUx5W3FnXR0XUfedq5xd9JD5TWyCx78NlCIUCvdd9VRmG5fSX13aShttZMFiIY0M/OW+cwOxVseIkZb16ga2HIHBsuvdoi0zG2JWK8AS+bI5CUo6oAY+LMBWgAxP8bBvCDWdqPPI+Qy2ILpZb9jUYjUqPhno1keKtKkGMFlUoAQIxKTnadHutV+ZNE0vn+dwspAkAqBxdUgkmPrNwRh4E3ae9kGxdw6Uz+im5iteD4OITdKLMvUxuz9BLErB6hP8sJHmjcjGn+VkBJ1xv3XEBa5PQsW2S478Rkk1g9qikklafHkCsXFuD7Ru05ZhiWlpK2JeNF8VVN38UYcRPxSYv3SOLnN1juZBTdHxodFDYKXLUbvfs+rVsTF5jQutwkpvya/XzGwBvN6qBkdtvwOtriAzChQlpjYuV1/zZ/ZOUbjuTP46rCUhwPClkTlH1x7a2+dsED2BgdX4jHfvhkvT4SCWcZkCKvMZX1yfU1EdeQXRdaqHZacU9YKkXM0UxbuCYwjKrqTsBEMMBRod9hGE4d08MCi++nLLOsDl9ePayUYJ5GWibFoSj4Mto7FvS4TyeLJxiRqU2GTY8tHp4lxIDrqwt1sPtL5vgiD7QSW88VHywH8GIyDurinQ5LEKPVl30yaA3YhF/O/KhHkaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(52536014)(8936002)(41300700001)(44832011)(7416002)(2906002)(5660300002)(110136005)(316002)(54906003)(71200400001)(76116006)(66446008)(8676002)(66476007)(64756008)(66946007)(4326008)(66556008)(33656002)(86362001)(55016003)(9686003)(38070700005)(186003)(122000001)(38100700002)(478600001)(53546011)(26005)(7696005)(6506007)(55236004)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1hKVVRyNDRpejBBcUt2UjBqNUFha0FUYnlaWnMyTVBsbHJLbDFNS0xsb0Zk?=
 =?utf-8?B?Mmk3UjV3MnkxSGxpZmlzcGxFVXRSOGVjbktORU5lVkxqNlJSNlU1UjBzMWhL?=
 =?utf-8?B?aDFzSDB3WHRhbllDT2hxQjZzRTU2UDJWeFNmRGZoL1ZVekR5dzFoL3F3aWFk?=
 =?utf-8?B?OWZkTlBCS1pIeXA5cU8zaGkzdHQ5eDdiY2pTQWpzeDkvQ0M1WVVBeEVLU2Ex?=
 =?utf-8?B?d1UxQ3Zva2FqQlNHZkIyUVYwdkNHRWwvaTIrTUhGVWxyWWdwNXJhV2x6VUZo?=
 =?utf-8?B?T1RnRldJTkFBNVEyT0JLM0N6Vm03SFRPcHROb080WDMxSURaVEd3YXByeUVy?=
 =?utf-8?B?MXRxVEdyYzRhNDVVQXVFRzRTN0E3d3VQMDZCZ1RyQWdqQnl2Y3d0ZUFKaER3?=
 =?utf-8?B?K2ZTckxQV3B4M2tFY3NKcEFsYU00OGo1UHhjWE9Ndlp6Wm1SeEJwTDYzY0k0?=
 =?utf-8?B?UjhXdjNCOXcybU4zOVRSR0RORC9MeXBaZTdneVNPVFZ2aWt5M25yc2JmS3Yy?=
 =?utf-8?B?WEhYTDZBZ2ZoODFWcnFWRVo1eW5naE80TStyZFJPOG1aaDVPa2NEdkwzWDdV?=
 =?utf-8?B?MGFtQzFlQnQvcUJib2NQaDZFcWZWdWxyZ0hHaVoya2VOZFlsL1lSTUsyTmNF?=
 =?utf-8?B?bkw4QWswUzVoSmNuWCsyU2E0a3Z4clV3UlF6TzR5QTd3ZUtTSG42M3lwdEV1?=
 =?utf-8?B?Mkd5OG9wT3lQTVg3RVAvSWM0V2lKVTU0a3pmeG5URDF5TE9TVkU5R2t4WjRI?=
 =?utf-8?B?SWdQRTJoQWZBelVSRDdhZW9HK1hVNjdYMjgrc2dVdEpFbzhVZXNuczNxQUNP?=
 =?utf-8?B?Wnc4VVdBdGlUU3g1cUpSU0M1ZGFKZlR0a2FZc0prMEU1bTZCeTNNZFZYMEtr?=
 =?utf-8?B?MkNNOTV1a3VXc1Z2WUlsaTV1aWtVbTZIdVBFTDJoZUs3ZzN4WWVnTlNNYkpx?=
 =?utf-8?B?TzNFbmlxVmRqdWlzUGlBSzFHUllmUFF1Y2FjdXFlT1ZWR0pNUkJFeVErLzdt?=
 =?utf-8?B?V09kY1FoWXdKNEZkRjZWOFhiSU4zMWF5bU5rOFM1YXppa0h1TTFjd0xYcmhF?=
 =?utf-8?B?TjNMMEV2dTEyVDR2ZWUyclI0L1J1ZWRLS041N08ycER4ZG80bkNXUjI4L1pq?=
 =?utf-8?B?T3ZvWnpZdWFPVk9VRFkxRWQ5UUxyVHoyN3UwRUYxVDNZYVBtL0NsZHhLMkZo?=
 =?utf-8?B?RXZuRjhaTHZFOTdvcnUzbWI4Q1RwRXlzd0FBYmE0bG1WYkhZU0JUU3RRRG9Z?=
 =?utf-8?B?OTlGalZtSzBFMU5GREJpQjBsVGowdGRWRjlMRXhBVjBhY0F4UjRjNWo2V0l5?=
 =?utf-8?B?NVM5eUN1dU1ZRi9FL1J4TG5MNzgwb1lFMHorTW5TdnIvZXVmUi9EZ3hWQUM4?=
 =?utf-8?B?NUJab21SNFh6U3BzLzRWWVFaWFlLcVF3dUlqakhCVUpTNExicTB5WVhnVDZp?=
 =?utf-8?B?ajdNc2dCY0pOYndZNGZiMHVlOHI4NXkxRWNkdS94SVp1SmpRdnlieXZwTzgy?=
 =?utf-8?B?b0M2bWRZVXRJWk9zMHQxT3Q2MCtMUWVUd29GMmJ2WHhuUTRvMDF1WnpWeFBr?=
 =?utf-8?B?a2hwRkZBRkpwRTQ2Q09mTDNlM1RKV0xrU2VmV1c0SkFod3B4MllkNG92ODJF?=
 =?utf-8?B?R1ZuUSsxL042dDF6enVnNHFUQzFDc0l3TWw0NFpkdkgvM2EzUTRIcFovZEds?=
 =?utf-8?B?WjRQSjdrTUV6WEFFazVkVUJiaEE0ckRjSDJNN0t3M2d4d2ZjaHprUk9rb2xC?=
 =?utf-8?B?aFc2UDd1QndlbDBOaG4vS1VPeHlBQ2RFcXhOM3BGYk1Lb2UzR1d1UkEvSTVl?=
 =?utf-8?B?UkNtVUpYQ2Nia0VqNFRtTkhPYlRaK1kwWUxUY29EQnVXc3hweWdUb2loMmhw?=
 =?utf-8?B?QWVUUkl0bnk2RW53MTNUeWxISGVKSkxhZXAvRWErU1Fick9HMjE4NzVOZnFR?=
 =?utf-8?B?YlZNRDB5OFpyazBsT1EzUE9SWjRPbFNWV2Zna081R0huRjZhOVpiaHUxNVJ4?=
 =?utf-8?B?NDBBMUMreCtRbW9Vd3ZaWm5PcVdFYWV2SDAvRk9xdVF5d1psNnh3WkhFNXYy?=
 =?utf-8?B?K09vd2psaTlCUm5hOTdoWDlhZTFTeWVVUHJkOEt5SURHQ3p3RXJhdjduNFlH?=
 =?utf-8?Q?rJFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ea8ea4-497c-4abc-be68-08dab6a30adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 16:07:40.3819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RZCarJJvkbM++8WVdR+YSW8ezqQGKc188QP/YrX6ngN1iCHZ9/IsMeYzpGLoJqytzK5fWdd4EdpaZWMrtry4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gU2VudDogVHVlc2Rh
eSwgT2N0b2JlciAyNSwgMjAyMiA5OjIyIEFNDQo+IFRvOiBTaHVuc3VrZSBNaWUgPG1pZUBpZ2Vs
LmNvLmpwPg0KPiBDYzogSm9uIE1hc29uIDxqZG1hc29uQGt1ZHp1LnVzPjsgRGF2ZSBKaWFuZyA8
ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+Ow0KPiBBbGxlbiBIdWJiZSA8YWxsZW5iaEBnbWFpbC5jb20+
OyBLaXNob24gVmlqYXkgQWJyYWhhbSBJDQo+IDxraXNob25AdGkuY29tPjsgTG9yZW56byBQaWVy
YWxpc2kgPGxwaWVyYWxpc2lAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiBXaWxjennFhHNraSA8
a3dAbGludXguY29tPjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47DQo+IG50
YkBsaXN0cy5saW51eC5kZXY7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2Ml0gUENJOiBl
bmRwb2ludDogcGNpLWVwZi17LHZ9bnRiOiBmaXggYSBjaGVjayBmb3Igbm8NCj4gZXBjIGFsaWdu
bWVudCBjb25zdHJhaW50DQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIFRodSwg
U2VwIDIyLCAyMDIyIGF0IDA2OjIzOjU3UE0gKzA5MDAsIFNodW5zdWtlIE1pZSB3cm90ZToNCj4g
PiBTb21lIFBDSSBlbmRwb2ludCBjb250cm9sbGVycyBoYXZlIG5vIGFsaWdubWVudCBjb25zdHJh
aW50cywgYW5kIHRoZQ0KPiA+IGVwY19mZWF0dXJlcy0+YWxpZ24gYmVjb21lcyAwLiBJbiB0aGlz
IGNhc2UsIElTX0FMSUdORUQoKSBpbg0KDQpbRnJhbmsgTGldIHdoeSBub3Qgc2V0IGVwY19mZWF0
dXJlcy0+YWxpZ24gMQ0Kbm8gYWxpZ25tZW50IGNvbnN0cmFpbnRzIHNob3VsZCBtZWFuIGFsaWdu
IHRvIGJ5dGUuDQoNCj4gPiBlcGZfbnRiX2NvbmZpZ19zcGFkX2Jhcl9hbGxvYygpIGRvZXNuJ3Qg
d29yayB3ZWxsLiBDaGVjayBmb3IgdGhpcyBiZWZvcmUNCj4gPiBJU19BTElHTkVEKCkuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHVuc3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPg0KPiANCj4g
UmV2aWV3ZWQtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA8bWFuaXZhbm5hbi5zYWRoYXNp
dmFtQGxpbmFyby5vcmc+DQo+IA0KPiBUaGFua3MsDQo+IE1hbmkNCj4gDQo+ID4gLS0tDQo+ID4g
Q2hhbmdlcyBpbiB2MjoNCj4gPiAqIEZpeCB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gcGhyYXNpbmdz
IGFuZCB3b3Jkcy4NCj4gPiAtLS0NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtbnRiLmMgIHwgMiArLQ0KPiA+ICBkcml2ZXJzL3BjaS9lbmRwb2lu
dC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMgfCAyICstDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLW50Yi5jDQo+IGIvZHJpdmVycy9w
Y2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtbnRiLmMNCj4gPiBpbmRleCA5YTAwNDQ4Yzdl
NjEuLmY3NDE1NWVlOGQ3MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9lbmRwb2ludC9m
dW5jdGlvbnMvcGNpLWVwZi1udGIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1
bmN0aW9ucy9wY2ktZXBmLW50Yi5jDQo+ID4gQEAgLTEwMjEsNyArMTAyMSw3IEBAIHN0YXRpYyBp
bnQgZXBmX250Yl9jb25maWdfc3BhZF9iYXJfYWxsb2Moc3RydWN0DQo+IGVwZl9udGIgKm50YiwN
Cj4gPiAgICAgICBwZWVyX3NpemUgPSBwZWVyX2VwY19mZWF0dXJlcy0+YmFyX2ZpeGVkX3NpemVb
cGVlcl9iYXJub107DQo+ID4NCj4gPiAgICAgICAvKiBDaGVjayBpZiBlcGNfZmVhdHVyZXMgaXMg
cG9wdWxhdGVkIGluY29ycmVjdGx5ICovDQo+ID4gLSAgICAgaWYgKCghSVNfQUxJR05FRChzaXpl
LCBhbGlnbikpKQ0KPiA+ICsgICAgIGlmIChhbGlnbiAmJiAoIUlTX0FMSUdORUQoc2l6ZSwgYWxp
Z24pKSkNCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gICAgICAg
c3BhZF9jb3VudCA9IG50Yi0+c3BhZF9jb3VudDsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5jDQo+IGIvZHJpdmVycy9wY2kvZW5k
cG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5jDQo+ID4gaW5kZXggMGVhODVlMWQyOTJlLi41
ZTM0NmMwYTBmMDUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rp
b25zL3BjaS1lcGYtdm50Yi5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rp
b25zL3BjaS1lcGYtdm50Yi5jDQo+ID4gQEAgLTQxOCw3ICs0MTgsNyBAQCBzdGF0aWMgaW50IGVw
Zl9udGJfY29uZmlnX3NwYWRfYmFyX2FsbG9jKHN0cnVjdA0KPiBlcGZfbnRiICpudGIpDQo+ID4g
ICAgICAgc2l6ZSA9IGVwY19mZWF0dXJlcy0+YmFyX2ZpeGVkX3NpemVbYmFybm9dOw0KPiA+ICAg
ICAgIGFsaWduID0gZXBjX2ZlYXR1cmVzLT5hbGlnbjsNCj4gPg0KPiA+IC0gICAgIGlmICgoIUlT
X0FMSUdORUQoc2l6ZSwgYWxpZ24pKSkNCj4gPiArICAgICBpZiAoYWxpZ24gJiYgIUlTX0FMSUdO
RUQoc2l6ZSwgYWxpZ24pKQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4N
Cj4gPiAgICAgICBzcGFkX2NvdW50ID0gbnRiLT5zcGFkX2NvdW50Ow0KPiA+IC0tDQo+ID4gMi4x
Ny4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTg
rr7grprgrr/grrXgrq7gr40NCg==
