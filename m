Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80486EC4BF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 07:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjDXFWx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 01:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDXFWx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 01:22:53 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4259F26AD;
        Sun, 23 Apr 2023 22:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UylTXSRH9SH+V+gcKq+9eZH5XOYSM45BOgI9Cj6N49sQW+Ep2sE0//7N7m8YGLa7YNn6sf19P/lB9Hn+t0+UCeE+zakZfFMTDjSjXuoIR8KHqQ3sYmq7RXfT4a3fhN2R/HiZUskeZQY3T9faEs6tH1dzm1m2YWb1d6Zd7mPM4/iMRURhpLHrH1mxTfEAMJmgXm/zq4XNn1rXBA3x6avpRa+ZtE+mGVDbH4nx3K53zFDxc0v4iPQrF34vNgT95kZ2tbpS/kmPISXewBhZC+2/QRQMKq9icekR+1KK72PCuAjWmc3HPtCJmfY3oAGXlAAYNRoTh3cf41iFMxm8sbjRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz0fQSIXh+OU6kPhYZ5Q0A9uh6NxPicG9didbEB0l4w=;
 b=YoBXpcs6gfpRdkmD4xpJWmz0BBMRUlkiu3t7CTxTw3uiUncgIBOEieHZW6cgk2emcVNVdUFSsqEXbi23q0IglnFMfHD37p9AAClLSoje0x+uYsOJ3szmsaTGX9HpQOYX/KEl8kzX+0eDea6Q04uPCPoVAzdPgw1touWTX4+na+KthmxBItC3Vir6X2NpOlhZxbnuiw2hF8Yr2dwaRRYcymHfNonwG5ohpmZk6LIaBM7mgwgm3lF/P0YWFMTl7oJ6SzVK84envIvD5NK5keoNBq9yQr75tot8pijBHPHaBFSxcvy23Dv2ftrwWOjyUmH+yV1Vml2n7700LqkUwq2LtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz0fQSIXh+OU6kPhYZ5Q0A9uh6NxPicG9didbEB0l4w=;
 b=geSTktl5E9E2gcui7z4otH/6yxuRuTpjknlv7zEZ6XWhcbosOFn9e27uGwjb1SYzeX2AP7o9ZT7zf7J8QBNoGB9R43WLeazC33322Uiv6fXdyUvHl6keOBXn52aI17C7f1Xv+4gV+rePJAI1D/+/kq0Q6ws7zNv6s+LQANcBtg0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB9390.jpnprd01.prod.outlook.com
 (2603:1096:400:1a3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 05:22:48 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 05:22:48 +0000
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
Subject: RE: [PATCH v13 08/22] PCI: dwc: Change arguments of
 dw_pcie_prog_ep_outbound_atu()
Thread-Topic: [PATCH v13 08/22] PCI: dwc: Change arguments of
 dw_pcie_prog_ep_outbound_atu()
Thread-Index: AQHZcfCwRL8io9HOf0OzceBtSuf+s683M3OAgALB3tA=
Date:   Mon, 24 Apr 2023 05:22:48 +0000
Message-ID: <TYBPR01MB5341D18873AB26589A8B4EB8D8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-9-yoshihiro.shimoda.uh@renesas.com>
 <20230422111455.GD4769@thinkpad>
In-Reply-To: <20230422111455.GD4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB9390:EE_
x-ms-office365-filtering-correlation-id: 64d86871-6566-4f88-0250-08db4483f148
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W11ITgyvxhvtaBbj221tettWtk8h45wNtz/ucKK8OmzAQdHoCclgis/+9rwoeFjVTnAiOes3Z+rTkwE9PhwWJUf41XxSA9MAkv+fUFantXIVfMhBG9LvLoZX2tZAdb2FU9l+4scBSchjOhUT2DKEHFHGAu58KZebn9tv+Y6l+cme5gOIyzHfP49yAp3JdIGvv7T6vTQH0LW4D6tFq8Lio0777z31nTL61rQzpqNIE2Ik5am2S6fHKu1BLP47IkYqmXEs6GoC5N/fnnwH5Y3Qnq3hbgg/9smeYjXmxmMBYZyIBSyVQiShK/1BptNB4Fi0rpCjKBgxuJv2lFkwcCblz9nXjBD1zjYv32pmyulxwla0keLdk907FqJgQOf7OtTDcH+8kqWaOsRZdR7K01wwSGD53xOiCoNr/JbIKYNGS3bgB2ZAza5T4c1CX+AIba1Lfo8YcYVLot7ZV77PptY3TOtLuqSQ2nYdDAh/57MKMezytAf0dd9aJyt/6dF2ojRN3M+NmlIE32y3PPrXMayERKaojsWkt+ND9eQhiARNIpZgBm/ZGr9+VmipofEh6TjgBMKrzq0Vz7Jn6G+6JNo1+4mjhQzii9l3EtxC8vplP7tZS9t7yA/1GKPQTcnRMZnO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(66556008)(66446008)(66476007)(8936002)(7416002)(54906003)(8676002)(478600001)(66946007)(76116006)(122000001)(38100700002)(6916009)(64756008)(86362001)(2906002)(41300700001)(316002)(33656002)(4326008)(5660300002)(52536014)(71200400001)(7696005)(38070700005)(9686003)(6506007)(186003)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTZOcTFwRUoxNUZNZDBCWm1XbStlM3RaZkJCT3oyRUhndGh0cXJFVjBWaXhu?=
 =?utf-8?B?ZHFOVzRUNzVxbk9tUThicDJtK3RKQSszMVgwWEc3dVZPeTZoVUI2WDFRSkl0?=
 =?utf-8?B?WGZ5NGR1SHdRanFmUzZCbFhtT1YzWGwyMnZZUWJQOHFqTW9nWStoUGo0eUdV?=
 =?utf-8?B?NXA0ajNLVnRtaU1hNVl0SmZrQm9oWmp0TERLckJVQzRkQ0dONEdDRldOdkNL?=
 =?utf-8?B?OVFxSytxQXpidUMraktEL0FwRlBlMzV1aSt2b2xLNzRlRTRVdW5ldjRmM25Y?=
 =?utf-8?B?VnI1M2NvdzU3QnM2b0F1Z3p5N292bkI5S25kMmlKVWxpNHZNbFVUd1pBbEN3?=
 =?utf-8?B?TWZ5NzVzVUFjejB0cUJiSnFkQzNHNFBiZEhOK2FnUHBjNksxM1NrMUF1by9X?=
 =?utf-8?B?VkFuRmFUUEp4Z2RnUGY1Sm1Hei83UDdOWTRMWk55Z1JvSFBzcnpHbjJQR0Ry?=
 =?utf-8?B?dHRRVStkRzBDa3dGZlJpNHk0OEdNaklBUjlpUjFqbVJrYmNCdnZRRDVsSytt?=
 =?utf-8?B?Y1BZNVUrZHg3VldxZzhKbTcvSjR4Vnp4OTlkZ2k0LzV4ODc2bEJvRTJ4RU1o?=
 =?utf-8?B?ZGZHSFUxZjBiekZhSFlYNVBNdEdQTlpDaVpraS9yN1pyRmNmTnovS2J4ME9m?=
 =?utf-8?B?TVUwV1RKMUNvSVBoRU5nMHZWdG1uYW9nd2k4Z1hGQ29IQ1FWWXpLVkUrUjlN?=
 =?utf-8?B?dVZUTXJUbXZyL2pmMHlQZm5HK2VkSTZ3YjJGVnJBa3kvRGJ5QnZNY1VJNkRw?=
 =?utf-8?B?eUtibmNGR2h1ZUhqTzhYbmdmdi9hLyt6eXhaanY4WkdMOFJQRGd4dVBqUC9X?=
 =?utf-8?B?VjlLSXBlNko0d3Rnbk1CUFVHZkRScHQyczFWTm1NYlErMElEWXpHa3orSzlI?=
 =?utf-8?B?UlJMVmRKN3RUcXNiYzRLS1NFc1dPMW9WRFpCOVB4UFI1S09aWDNreU5WYnNo?=
 =?utf-8?B?WVYvelVYdDdDQ08wNHBYZEU0dXJKRVJQSDk5UTJiUE93ZWR5SDZXVXhVOWR6?=
 =?utf-8?B?SElLNFVLZytnRHZIb3dJNENtQWdUOUJkbHgvY0xlS3BScm1UMS9pNHpwRFpF?=
 =?utf-8?B?VDc5OC9aS2JJSU9TUWE4ZlZrcHl4SnNxZnFZcXpVczlVWHVkRkVEcWFYY3l1?=
 =?utf-8?B?VHRheDhjMSt3S0FqQnl2MVp4cGJBN1FidXpuQWUvL2lKOHR0Qks1dHdSNkJk?=
 =?utf-8?B?VnRtNXkva2JaRzVIaDZzTXB6ckdPQS9QS1ppSlBSaWpldGFGL1JYWTd3anRI?=
 =?utf-8?B?dUU5YlFtOThGRDZNUFVtQlVYSndVNEtXTi9IUVlaalJWRWtFOHMrN3ZCdHVS?=
 =?utf-8?B?Nk13aEV3RFpWcEJXa1IwelZwYmZxL09zSmp0dWlFUHBIOHVOd1JOZmFGSXlN?=
 =?utf-8?B?WW5CeXBFYTRFanNONTQwUXhETlB1R2Q3b1p2UTZlQ0JxVDdjc0hFMFRiazJ2?=
 =?utf-8?B?VTNCd2p6ck5Dd1RJTys4d1BRSEx4eFNjaHF4clNoYURPN243ZUxIUlFqS2Q0?=
 =?utf-8?B?d2lzQ3NUdDNuV0x2N01DcU9BNFRaUVZQanhsbngrcDVpMStENTZjSmlhdlFn?=
 =?utf-8?B?M2Z4WWtCREFpbW9tNU5xbSsybjdhOStzbDFaV21PdXE0dTVtQ2tLREZWV2RR?=
 =?utf-8?B?UzFTdk9ncW8wRWVEd1dSMGlhN0Q3THYvRDNYTkRkcXd0bzNlemx1ejNrOTMv?=
 =?utf-8?B?RlgzcTFWSDBjbjJ1YUFtZjA1TWdOL2hXUjhEd000aXhkdTVxZ0xxUUJYcnAy?=
 =?utf-8?B?b2tYTjBEczJFRGdsSGQxZ1h6eFBWeUZnOWZUcFpLSVBhZDN6U1dtMTE1cmRE?=
 =?utf-8?B?QVVTcWhUSW90NjBsQ0FaVmpQbHhqUGlGaDNaSVFpYTFITDdIbjdsdzdjQ2hj?=
 =?utf-8?B?NyswUCtvcE5OSW85VnpnU0ZBTTZuRlJTb1o0M1gxQTVacTBudExWRTFYRFN0?=
 =?utf-8?B?OTdWTjVUMDgwZXRWYWxSNEM2b1pXbU5NVG9MOThIM09vSFQxMDRzUW1kUWdS?=
 =?utf-8?B?ZWwxaEpkQTdyc1lXeHE5Z3NjeWRucWUwRkNWS1FyeFBrVndaVXRiMjBqb0R2?=
 =?utf-8?B?elJkK1lSUHZyYlhMMEV5U1Jvb0pQdFljVnJ0VXY4SGY2R09Edi9uOXFQQ2pL?=
 =?utf-8?B?M0xKV3pnK1BUOFdSUHVlcTRLbWhDNkx1SmFXcm1GeUdrU20wVmxoc1l6NVA2?=
 =?utf-8?B?c0gxYjY0MWJ0dk1SY2NBMmpDa0lpSjBNKy9aZml3R3NGT05Jd1pRWGpQT0gy?=
 =?utf-8?B?VXJhTkxUNHE5dEhOYThEWWlkSThRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d86871-6566-4f88-0250-08db4483f148
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 05:22:48.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRUctU9ZQYLZBlIlVzQViuXC0PF8bnw8X7n9kCpi39EI5tvBQUmnsjKfxw4QPbVDhR+A5nEw8rckkDwWB/ZXaraX+FcS6fBIJit5+q4zSfXcshgYYx4rFqGbn/ps//6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9390
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
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyA4OjE1IFBNDQo+IA0KPiBPbiBUdWUsIEFwciAxOCwgMjAy
MyBhdCAwOToyMzo0OVBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBUbyB1
c2UgImNvZGUiIGFuZCAicm91dGluZyIgcGFyYW1ldGVycyBvbiBhbiBvdXRib3VuZCBpQVRVLA0K
PiA+IGNoYW5nZSBhcmd1bWVudHMgb2YgZHdfcGNpZV9wcm9nX2VwX291dGJvdW5kX2F0dSgpLiBO
byBiZWhhdmlvciBjaGFuZ2VzLg0KPiA+DQo+IA0KPiBPaywgeW91IGFyZSB1c2luZyB0aGUgc3Ry
dWN0IGhlcmUgYnV0IGl0IGNvdWxkJ3ZlIGJlZW4gZG9uZSBpbiA2LzIyLg0KDQpJIGdvdCBpdC4g
SSdsbCBtZXJnZSB0aGlzIDgvMjIgdG8gNi8yMiBvbiB2MTMuDQoNCkJlc3QgcmVnYXJkcywNCllv
c2hpaGlybyBTaGltb2RhDQoNCj4gLSBNYW5pDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hp
aGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyAgIHwgMjEg
KysrKysrKysrKysrLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUuYyAgfCAxNSArKystLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oICB8ICA0ICsrLS0NCj4gPiAgMyBmaWxlcyBjaGFu
Z2VkLCAxOCBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+ID4gaW5kZXgg
YTgwYjlmZDAzNjM4Li45NjM3NWIwYWJhODIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0KPiA+IEBAIC0xODMsOSArMTgz
LDggQEAgc3RhdGljIGludCBkd19wY2llX2VwX2luYm91bmRfYXR1KHN0cnVjdCBkd19wY2llX2Vw
ICplcCwgdTggZnVuY19ubywgaW50IHR5cGUsDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+
DQo+ID4gLXN0YXRpYyBpbnQgZHdfcGNpZV9lcF9vdXRib3VuZF9hdHUoc3RydWN0IGR3X3BjaWVf
ZXAgKmVwLCB1OCBmdW5jX25vLA0KPiA+IC0JCQkJICAgcGh5c19hZGRyX3QgcGh5c19hZGRyLA0K
PiA+IC0JCQkJICAgdTY0IHBjaV9hZGRyLCBzaXplX3Qgc2l6ZSkNCj4gPiArc3RhdGljIGludCBk
d19wY2llX2VwX291dGJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsDQo+ID4gKwkJCQkg
ICBzdHJ1Y3QgZHdfcGNpZV9vdXRib3VuZF9hdHUgKmF0dSkNCj4gPiAgew0KPiA+ICAJc3RydWN0
IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9lcChlcCk7DQo+ID4gIAl1MzIgZnJlZV93
aW47DQo+ID4gQEAgLTE5NywxMyArMTk2LDEzIEBAIHN0YXRpYyBpbnQgZHdfcGNpZV9lcF9vdXRi
b3VuZF9hdHUoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OCBmdW5jX25vLA0KPiA+ICAJCXJldHVy
biAtRUlOVkFMOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlyZXQgPSBkd19wY2llX3Byb2dfZXBfb3V0
Ym91bmRfYXR1KHBjaSwgZnVuY19ubywgZnJlZV93aW4sIFBDSUVfQVRVX1RZUEVfTUVNLA0KPiA+
IC0JCQkJCSAgIHBoeXNfYWRkciwgcGNpX2FkZHIsIHNpemUpOw0KPiA+ICsJYXR1LT5pbmRleCA9
IGZyZWVfd2luOw0KPiA+ICsJcmV0ID0gZHdfcGNpZV9wcm9nX2VwX291dGJvdW5kX2F0dShwY2ks
IGF0dSk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4NCj4gPiAgCXNl
dF9iaXQoZnJlZV93aW4sIGVwLT5vYl93aW5kb3dfbWFwKTsNCj4gPiAtCWVwLT5vdXRib3VuZF9h
ZGRyW2ZyZWVfd2luXSA9IHBoeXNfYWRkcjsNCj4gPiArCWVwLT5vdXRib3VuZF9hZGRyW2ZyZWVf
d2luXSA9IGF0dS0+Y3B1X2FkZHI7DQo+ID4NCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4g
QEAgLTMwNiw4ICszMDUsMTQgQEAgc3RhdGljIGludCBkd19wY2llX2VwX21hcF9hZGRyKHN0cnVj
dCBwY2lfZXBjICplcGMsIHU4IGZ1bmNfbm8sIHU4IHZmdW5jX25vLA0KPiA+ICAJaW50IHJldDsN
Cj4gPiAgCXN0cnVjdCBkd19wY2llX2VwICplcCA9IGVwY19nZXRfZHJ2ZGF0YShlcGMpOw0KPiA+
ICAJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9lcChlcCk7DQo+ID4gLQ0K
PiA+IC0JcmV0ID0gZHdfcGNpZV9lcF9vdXRib3VuZF9hdHUoZXAsIGZ1bmNfbm8sIGFkZHIsIHBj
aV9hZGRyLCBzaXplKTsNCj4gPiArCXN0cnVjdCBkd19wY2llX291dGJvdW5kX2F0dSBhdHUgPSB7
IDAgfTsNCj4gPiArDQo+ID4gKwlhdHUuZnVuY19ubyA9IGZ1bmNfbm87DQo+ID4gKwlhdHUudHlw
ZSA9IFBDSUVfQVRVX1RZUEVfTUVNOw0KPiA+ICsJYXR1LmNwdV9hZGRyID0gYWRkcjsNCj4gPiAr
CWF0dS5wY2lfYWRkciA9IHBjaV9hZGRyOw0KPiA+ICsJYXR1LnNpemUgPSBzaXplOw0KPiA+ICsJ
cmV0ID0gZHdfcGNpZV9lcF9vdXRib3VuZF9hdHUoZXAsICZhdHUpOw0KPiA+ICAJaWYgKHJldCkg
ew0KPiA+ICAJCWRldl9lcnIocGNpLT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIGFkZHJlc3NcbiIp
Ow0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmMNCj4gPiBpbmRleCA2MGU2NTIyZjA3NjIuLmU4ZDRkNWJkZTJkMyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS5jDQo+ID4gQEAgLTU0MCwxOSArNTQwLDEwIEBAIGludCBkd19wY2llX3Byb2dfb3V0Ym91bmRf
YXR1KHN0cnVjdCBkd19wY2llICpwY2ksIGludCBpbmRleCwgaW50IHR5cGUsDQo+ID4gIAlyZXR1
cm4gX19kd19wY2llX3Byb2dfb3V0Ym91bmRfYXR1KHBjaSwgJmF0dSk7DQo+ID4gIH0NCj4gPg0K
PiA+IC1pbnQgZHdfcGNpZV9wcm9nX2VwX291dGJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNpZSAqcGNp
LCB1OCBmdW5jX25vLCBpbnQgaW5kZXgsDQo+ID4gLQkJCQkgaW50IHR5cGUsIHU2NCBjcHVfYWRk
ciwgdTY0IHBjaV9hZGRyLA0KPiA+IC0JCQkJIHU2NCBzaXplKQ0KPiA+ICtpbnQgZHdfcGNpZV9w
cm9nX2VwX291dGJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNpZSAqcGNpLA0KPiA+ICsJCQkJIHN0cnVj
dCBkd19wY2llX291dGJvdW5kX2F0dSAqYXR1KQ0KPiA+ICB7DQo+ID4gLQlzdHJ1Y3QgZHdfcGNp
ZV9vdXRib3VuZF9hdHUgYXR1ID0geyAwIH07DQo+ID4gLQ0KPiA+IC0JYXR1LmZ1bmNfbm8gPSBm
dW5jX25vOw0KPiA+IC0JYXR1LmluZGV4ID0gaW5kZXg7DQo+ID4gLQlhdHUudHlwZSA9IHR5cGU7
DQo+ID4gLQlhdHUuY3B1X2FkZHIgPSBjcHVfYWRkcjsNCj4gPiAtCWF0dS5wY2lfYWRkciA9IHBj
aV9hZGRyOw0KPiA+IC0JYXR1LnNpemUgPSBzaXplOw0KPiA+IC0JcmV0dXJuIF9fZHdfcGNpZV9w
cm9nX291dGJvdW5kX2F0dShwY2ksICZhdHUpOw0KPiA+ICsJcmV0dXJuIF9fZHdfcGNpZV9wcm9n
X291dGJvdW5kX2F0dShwY2ksIGF0dSk7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgaW5saW5l
IHUzMiBkd19wY2llX3JlYWRsX2F0dV9pYihzdHJ1Y3QgZHdfcGNpZSAqcGNpLCB1MzIgaW5kZXgs
IHUzMiByZWcpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5oIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmgNCj4gPiBpbmRleCAyMGExMDdjMmU1NDMuLjk1NGQ1MDQ4OTBhMSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ICsr
KyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gQEAg
LTQzNSw4ICs0MzUsOCBAQCB2b2lkIGR3X3BjaWVfdXBjb25maWdfc2V0dXAoc3RydWN0IGR3X3Bj
aWUgKnBjaSk7DQo+ID4gIGludCBkd19wY2llX3dhaXRfZm9yX2xpbmsoc3RydWN0IGR3X3BjaWUg
KnBjaSk7DQo+ID4gIGludCBkd19wY2llX3Byb2dfb3V0Ym91bmRfYXR1KHN0cnVjdCBkd19wY2ll
ICpwY2ksIGludCBpbmRleCwgaW50IHR5cGUsDQo+ID4gIAkJCSAgICAgIHU2NCBjcHVfYWRkciwg
dTY0IHBjaV9hZGRyLCB1NjQgc2l6ZSk7DQo+ID4gLWludCBkd19wY2llX3Byb2dfZXBfb3V0Ym91
bmRfYXR1KHN0cnVjdCBkd19wY2llICpwY2ksIHU4IGZ1bmNfbm8sIGludCBpbmRleCwNCj4gPiAt
CQkJCSBpbnQgdHlwZSwgdTY0IGNwdV9hZGRyLCB1NjQgcGNpX2FkZHIsIHU2NCBzaXplKTsNCj4g
PiAraW50IGR3X3BjaWVfcHJvZ19lcF9vdXRib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUgKnBjaSwN
Cj4gPiArCQkJCSBzdHJ1Y3QgZHdfcGNpZV9vdXRib3VuZF9hdHUgKmF0dSk7DQo+ID4gIGludCBk
d19wY2llX3Byb2dfaW5ib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUgKnBjaSwgaW50IGluZGV4LCBp
bnQgdHlwZSwNCj4gPiAgCQkJICAgICB1NjQgY3B1X2FkZHIsIHU2NCBwY2lfYWRkciwgdTY0IHNp
emUpOw0KPiA+ICBpbnQgZHdfcGNpZV9wcm9nX2VwX2luYm91bmRfYXR1KHN0cnVjdCBkd19wY2ll
ICpwY2ksIHU4IGZ1bmNfbm8sIGludCBpbmRleCwNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+
IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K61
4K6u4K+NDQo=
