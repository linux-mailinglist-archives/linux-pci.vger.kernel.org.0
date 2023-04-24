Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536E46EC647
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 08:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDXG1O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 02:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXG1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 02:27:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532EA8;
        Sun, 23 Apr 2023 23:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlSlftzOJTvhJjAV5qVXNEZsHm9JdOBsEaKGjMfiY+4z4LOUCQXftfCGwcHsZOxoKV6AbUBf6UX4WVAhEu6tyFnQgv63Tr9TEwCVeZ2/qQcf9zHUvFkM4EUnW2Ic7T7dhV45Ondfk8t3ja9W6q76HFjf0LzNMrwMMYw/q91uaZ99MCsviMDdcMJ+VF4H4c9xNaLAuZV+aheFvZSs7KDq+AhaJ/+m6oivKBxovBVPLJKZ0LhkkZ0yZ/EbaCbv3sfsxC8XysoEOYIio2ouaBvEUttgnFQdMHHCVTB55y23dR3J/pc75ABOL8AcZ+xHv4eA0PQq0WHBiFNjHzHkgMqf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfqcAbQsQBCHOLFdv8rLTjDTZ/OtreLZ8dUj9S36WVI=;
 b=iltCxI3w6u+KH8xvssxAKLd8C889HJi5Qm65/Inu8uEgU3wVOqE47TTqqC27xazq4WSITXGrrrP67fOYIrW4viLtk9Wo15qznXzNSzIHgRbfzFnFZsQXac4XL37/1d3wtKW+elmz5n3ZlfASKEJ8Znk5DPIljsMj8KhbOsAPMpz2jEU2zRJ5zcAw7pHXXRrBj4EbMwKPau94+XqaHNIuNoiB++JTinSZMcdFYs1++Au1By8FXazuQw9Iq/vHr2TLrXXIPkIyPpwEtk3fVaZnrIMVJRbGy5WYkOlfX2051y/sdqwNunyCY56pi4BlMEtCqb84zNtwOrqTgKnMFT9pUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfqcAbQsQBCHOLFdv8rLTjDTZ/OtreLZ8dUj9S36WVI=;
 b=P5xSRrFSdmvmhlnHIdkmMwkb3P+AckFluGSEcCWnt1+ohAbzKo6g6p4X/ELv/cAiYRMAFp4fage47eTI4KtxB+lQQMX9XCdCkb1I0bdEpjOmQBAmzXLhw+cxLYqFBLmDTCxyTH22kIii6mZQbhH0+IJQOyJiOt4FiqtAUSeaI+U=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10193.jpnprd01.prod.outlook.com
 (2603:1096:400:1e5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 06:27:08 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 06:27:08 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v13 15/22] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Thread-Topic: [PATCH v13 15/22] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Thread-Index: AQHZcfCy3j7WsgHR5UWE6pbFrgPQIq83YbsAgAKlx3A=
Date:   Mon, 24 Apr 2023 06:27:08 +0000
Message-ID: <TYBPR01MB5341F1132310866FB33C3AD0D8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-16-yoshihiro.shimoda.uh@renesas.com>
 <20230422140034.GL4769@thinkpad>
In-Reply-To: <20230422140034.GL4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10193:EE_
x-ms-office365-filtering-correlation-id: c6e6b6d6-6a12-4299-d086-08db448cee06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlw418jzu0djJbq3FPNb3gP+B7m9fmqXcFbR+mItlgrKYLsraqKqPgLACzpoDMREtFyZxwXPr9up1xI17CG+L2ZRJKvI0Dsf7UI+wUgoG7zIxhfZA/iFDMLYF4LEG/N5Vq0S4hvAhXGxF8dEJbDsxdP5rvIUNGFHr5VokCCHWUfvZsGBnyGqzdmFbJl4u3ON01HmQcmVkK1aOe/a4+PxqyPn0GcIi3KWso7RPhfLsOBUR52XDPMuokzQmRoiMIN62mcEaZihZQiXp+/HWoi5mMCYVEBkfBWMupKHxyTFDecDThq7VlcCmzDFzRn4p8rgeM9AVPPL8o2JmA7aTmri0BFBth1eUEytI1UlygxtxnH5YrV8IcR2v5Jrp6X0J+rAWIfFu428hBrIW/eBLUAvtWJ/Y3ACtkBA1tTONGM9yI+bbN8FNuaQn+2RExLlWTwyF1F+YK6CspjLX3hdYHGpfztiUMbZDaRNVvtnMhykrFSrU81cvSvZy+L9SCbL24Pgt06Qssly6jKV4Pf8IgpbqBhfww6KgGLGkB8ioLtBUNjNlAxwYKrKELUNX1l5mdF/YKE+2Xh+fW/XI7tfdIxBGkHvETGLjNu2W6PEyoQ78L1ZyRl7pvy/S/xir3Pq1UrFqt01sf/wLu66C0TbEDwu6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(186003)(7696005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(316002)(83380400001)(66946007)(76116006)(2906002)(38100700002)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(7416002)(52536014)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkVqYkJraUpIZkcrTDFOOCt0UU9aeVphcUMwWEtNSTJ3OElndHlPekVNWlFS?=
 =?utf-8?B?VDdkckRYdDN6NWowTHNmdjBGdUhaMG9zc2FILzdvWHlaMWZiazAyUE05R3Rh?=
 =?utf-8?B?cHRWRDdZR2ZSMW92bldzQXBzQXhFN3A5NFEvcyt6QXBneUxqYnNOd0ZLcFpz?=
 =?utf-8?B?MFI4ZVRrWm1ULzNoMnJNbFVSN2JrcFhTWndkSnZIdFg1QkV3OTE2VE5jWHR5?=
 =?utf-8?B?akUxLzVjUVZYL2RnUGd3TU5RTmxHZUNmQUhDZlRDOXRCVEhiWWJMRUw5SVZu?=
 =?utf-8?B?bWk2ZXJXbkN6V3ZGTWNpVjN2MytCMFdneEYwaFFtRFBLdVYzd3lqbmRreUNK?=
 =?utf-8?B?Zm16WUlzUVhPRTZjc2IxNGJEeWlzOVpMZVhCR0o3OTNaUzZoajBCQXhab2dB?=
 =?utf-8?B?MTZjOGNzazZRQ0xLVGc4U2pybnNNb05LeU9QdXhKNUFsSFNpeUFPRGpVaTF1?=
 =?utf-8?B?Y1diL0YzclYzMjdRWnBrbUxEZ0NCZnFxejJGWTdLdFdPZGxtVE1LSVJwRGtv?=
 =?utf-8?B?RFJTaEpCaTZRV0JycEpUdEVNZlpyM2Z2VmNZL1ZDaUVCZWE5ZlU4U2RvSHcy?=
 =?utf-8?B?NU9LN1NOWG1VNHJoaVpmYzJLcHVBcmhtd0pFNWhaeXZJYU1mNDlZcEFRN3dJ?=
 =?utf-8?B?UjV5Nkw3cTE4UWwwWWN4cm5pNHRKdVYxVVRQZjVXK1NVNUY2cjlFeEhxTFNP?=
 =?utf-8?B?OGQ2T3FFRzJCZW5NRlRlOVZBc3grNE8vSGdSTEVFc0NrQitkZXlhV3I0aWhk?=
 =?utf-8?B?bm54MTBzWHFtc2NLZmdEcHVML1J3TWJYcWdZV2YzWUdpNUEyeklMMXlSdEYx?=
 =?utf-8?B?T2RzYzJZVFVuNTFSc20xVlZ4R1BwUy95OGFaNkkwVjdSSitCQ3BIa3JRZFc4?=
 =?utf-8?B?TENWZHpHalRvOFRIckcya1luclZMTHZOeTY2TEVjajdHR1dMb0NlQkFieFIy?=
 =?utf-8?B?ZlkwdXhOK05OYURXTnJ1R0J1Q2JwNXlQNmFtU3RJNmhOSmtLWGxZTjcySGl5?=
 =?utf-8?B?RzlDQWZVdDUzYjNSdzJtSVN3bmtaOFRWdEJUSkx5eEQvUU5OYUp4NEkyNEZD?=
 =?utf-8?B?WUZKRmliQ2dtTFE1UmpxTmRlVGJrWmtKdEJXSmdXNldIYWtEVUtSWEkrOUZt?=
 =?utf-8?B?WFJJZmhTbUZRMG9IelBjL24xN0dOUC96UzBEUWVoV2F3bm95RmxIS2FhOUNj?=
 =?utf-8?B?UW1IN3AybUkvT2c0TDg0U3BvKzM4bnU2cFhocGlnM0NXTUk0VGczd3A2bmhy?=
 =?utf-8?B?UkhUWDRNM2JlYnNpRENTcWw1dWJ2RWVpL2RLUnBFQjA4RkY4QXJVZHUyWGhj?=
 =?utf-8?B?ektPSUN0MEV5Z2JUWjV3QzZCYmlVbCtTUDRWWHRNU2tFbStTcE84dGZEYVB2?=
 =?utf-8?B?TUU2TEFKd0o4cGk0L24xOU1oVFRSYnlzM3VUUkw3Z01sK1RmbFFBdW0xWUVv?=
 =?utf-8?B?UDlyTGZYSm5uNWhPRG5ya3B1K29pNUx2UUVGRUw2RzVNdkNpWE1qSng2cUNt?=
 =?utf-8?B?dE9vZnM0Y0J6OGVTOGNSejAxRzZoTUhWc2RjblM5eXdYZ1lDdFRmNUxsODhx?=
 =?utf-8?B?U0FjUkpPVlpCZ2k0S2hmSHFRT21GK01rUUZQQ2s4TEhCVmMxUmpHbWkxSWc3?=
 =?utf-8?B?UFkyZE51UEZCK1lHdll1bkRnSGd6NmxqaEk3OHpLcnNzSmZWdHdLVG1UVmZM?=
 =?utf-8?B?NXhQOUhJWjFlVnJJUWxGSWU2ZEtJSG9pbll0Q2QzMmJxTU9ISkVoMjNzZzFs?=
 =?utf-8?B?cEswUzVNbjk2NEVCVGZEdTBQOWR2ZFMxQXRrR1N2N2RCMHhRYmx3VVhrREx2?=
 =?utf-8?B?cjRoWFE0N2hUL0JCek5DTHJBMWxVOHpkaThyanRWYlVRUFphVE1YRWRwMk5J?=
 =?utf-8?B?eUE1Nkd0WDE4TmlJNnBaY0FyWTZ0UEpzenFJdnhJUkl0dE8vYWIxQXBySlp3?=
 =?utf-8?B?N1RTc1dvTlZkOXNFUEptS00rdm1vNlRjeHBYOG5RS1B6eVYvWGkwSjRhWlU5?=
 =?utf-8?B?ZkcvNjFoVnpJM3JTUEtTb2FSTHByS1lZVWNDR3ZTR0ZBK3dKd0FKTllnUzl5?=
 =?utf-8?B?M0w4TG9nQk9oNDhXVUkxRUNxMkd5dzRyL1l6dlp2Z1gvMWJndytFK2M4ZjZz?=
 =?utf-8?B?RFFyQzJ2VFcvTXlhZlJUZis3MDYvQjJTQW16UUZSOHdvQ3ZObUZBbisxclZL?=
 =?utf-8?B?M3RsUEJncGZ0N0MvS2FpSkpHSDlRdW9TejFmNEVPZGNab0RGZDUranZPSlNa?=
 =?utf-8?B?N1VRZ3JpYWhFdllLTkVoeFJvbDRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e6b6d6-6a12-4299-d086-08db448cee06
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 06:27:08.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXEvWuzQrPPa1PPJlCEObeyaL7uvO1tX1LOijSKXYjX3H1EbcpfMSrPjko8Or9vA9d2t02JyThNLJamzy1AV8dUpT1SaZA6tmAPw6VqLmJ/dqQlm0eOAAyR3BBc7CsZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFNh
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyAxMTowMSBQTQ0KPiANCj4gT24gVHVlLCBBcHIgMTgsIDIw
MjMgYXQgMDk6MjM6NTZQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gT25l
IG9mIGNvbnRyb2xsZXJzIHJlcXVpcmVzIHZlbmRlci1zcGVjaWZpYyBpbml0aWFsaXphdGlvbiBi
ZWZvcmUNCj4gDQo+IEFnYWluLCBzcGVjaWZ5IHRoZSBleGFjdCBjb250cm9sbGVyLg0KDQpJIGdv
dCBpdC4gSSdsbCByZXZpc2UgdGhlIGRlc2NyaXB0aW9uLg0KDQo+ID4gLmVwX2luaXQoKS4gVG8g
dXNlIGR3LT5kYmkgYW5kIGR3LT5idW0tbGFuZXMgaW4gdGhlIGluaXRpYWxpemF0aW9uDQo+IA0K
PiBudW0tbGFuZXMNCg0KT29wcy4gSSdsbCBmaXggaXQuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hp
aGlybyBTaGltb2RhDQoNCj4gLSBNYW5pDQo+IA0KPiA+IGNvZGUsIGludHJvZHVjZSAuZXBfcHJl
X2luaXQoKSBpbnRvIHN0cnVjdCBkd19wY2llX2VwX29wcy4NCj4gPiBBbHNvIGludHJvZHVjZSAu
ZXBfZGVpbml0KCkgdG8gZGlzYWJsZSB0aGUgY29udHJvbGxlciBieSB1c2luZw0KPiA+IHZlbmRl
ci1zcGVjaWZpYyBkZS1pbml0aWFsaXphdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlv
c2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMg
fCA2ICsrKysrKw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUuaCAgICB8IDIgKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUtZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1l
cC5jDQo+ID4gaW5kZXggMjQ1OGNhMmJjMGU0Li5hMDExZGI3ZTMwNjQgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0KPiA+
IEBAIC02NzAsNiArNjcwLDkgQEAgdm9pZCBkd19wY2llX2VwX2V4aXQoc3RydWN0IGR3X3BjaWVf
ZXAgKmVwKQ0KPiA+ICAJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9lcChl
cCk7DQo+ID4gIAlzdHJ1Y3QgcGNpX2VwYyAqZXBjID0gZXAtPmVwYzsNCj4gPg0KPiA+ICsJaWYg
KGVwLT5vcHMtPmVwX2RlaW5pdCkNCj4gPiArCQllcC0+b3BzLT5lcF9kZWluaXQoZXApOw0KPiA+
ICsNCj4gPiAgCWR3X3BjaWVfZWRtYV9yZW1vdmUocGNpKTsNCj4gPg0KPiA+ICAJaWYgKGVwLT5p
bnR4X21lbSkNCj4gPiBAQCAtNzgzLDYgKzc4Niw5IEBAIGludCBkd19wY2llX2VwX2luaXQoc3Ry
dWN0IGR3X3BjaWVfZXAgKmVwKQ0KPiA+ICAJZXAtPnBoeXNfYmFzZSA9IHJlcy0+c3RhcnQ7DQo+
ID4gIAllcC0+YWRkcl9zaXplID0gcmVzb3VyY2Vfc2l6ZShyZXMpOw0KPiA+DQo+ID4gKwlpZiAo
ZXAtPm9wcy0+ZXBfcHJlX2luaXQpDQo+ID4gKwkJZXAtPm9wcy0+ZXBfcHJlX2luaXQoZXApOw0K
PiA+ICsNCj4gPiAgCWR3X3BjaWVfdmVyc2lvbl9kZXRlY3QocGNpKTsNCj4gPg0KPiA+ICAJZHdf
cGNpZV9pYXR1X2RldGVjdChwY2kpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gaW5kZXggYzRiZGZlZDdiMmUyLi5hZThhYzE1ZTUzZGMg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUuaA0KPiA+IEBAIC0zMzYsNyArMzM2LDkgQEAgc3RydWN0IGR3X3BjaWVfcnAgew0KPiA+ICB9
Ow0KPiA+DQo+ID4gIHN0cnVjdCBkd19wY2llX2VwX29wcyB7DQo+ID4gKwl2b2lkCSgqZXBfcHJl
X2luaXQpKHN0cnVjdCBkd19wY2llX2VwICplcCk7DQo+ID4gIAl2b2lkCSgqZXBfaW5pdCkoc3Ry
dWN0IGR3X3BjaWVfZXAgKmVwKTsNCj4gPiArCXZvaWQJKCplcF9kZWluaXQpKHN0cnVjdCBkd19w
Y2llX2VwICplcCk7DQo+ID4gIAlpbnQJKCpyYWlzZV9pcnEpKHN0cnVjdCBkd19wY2llX2VwICpl
cCwgdTggZnVuY19ubywNCj4gPiAgCQkJICAgICBlbnVtIHBjaV9lcGNfaXJxX3R5cGUgdHlwZSwg
dTE2IGludGVycnVwdF9udW0pOw0KPiA+ICAJY29uc3Qgc3RydWN0IHBjaV9lcGNfZmVhdHVyZXMq
ICgqZ2V0X2ZlYXR1cmVzKShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApOw0KPiA+IC0tDQo+ID4gMi4y
NS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTg
rr7grprgrr/grrXgrq7gr40NCg==
