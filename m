Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88A47CC266
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 14:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbjJQMG4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 08:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjJQMGZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 08:06:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4545C10FA;
        Tue, 17 Oct 2023 05:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr/rNwv72KWejvwkR83uxBbJfGh61NL4nQ42wgCsup5UAHyrb4unNV39vPpbI7O+WbpTlQh+B+p9iSN3OsiD9rgknK7+9vs7lffaJInkRSJRi+Dc7sBQgWsTCDAjv7KYXm3kgiypit0LOJsn+/i5bw4hdDrypNGgvHlBrkchdo9OlJmRAcQLc/zmZ7gACVWDEl60mqewNbPZeM6L52eK8yDPzBZf26d813WE9FTNsNfKqf/P39WtY8A0Gx2H5nVVcl/IS1Y+qWl0CmTAhLZ29FAbRP7L4U60+OMLcA9eljx8baodqfkBGO6p5WjVVjM6utc4jCchkajNEFizpZAr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6EzN4bosh5xuY0YhlhxLFcbBWg+mnRuAx0CnBW4Q34=;
 b=B/BsJEu6zbKuuyr2aT5mf8xr3+d+qIixNXGbwUlBGDGZh3I0W5mWmrbP2IhShU4e4340upOnOzQD51yZG8w/NE9WMddJ/q37HaTiT8FbRJfrgZCIwfmIIgF6+PFx3DGkRAypfhh5i3OX5Ez9kErFoWh9ywpdeBT77DrrkW8syxZUV2RKMg/pjdzOD0y2a6X+qpN78k4J3hlBN7XN4+eoqrWC3kTgMu1fQMhRC/OKSILeEPqNrksrDB3vkMvUh/ATfjcgoIDm7b9JjOhmVeLbYqqXQ7Zm0G6J9viryQe11hBgvN6Yjh4PH+wNuXzSjKQNXomzbAiqzOqqpB8o3vpdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6EzN4bosh5xuY0YhlhxLFcbBWg+mnRuAx0CnBW4Q34=;
 b=FCt04BRE5SbVh2Aobmll3ukFtlRvTQyZmwxUKmx33zuP7P46M6h1Gs+gmjnFzYbF9lSEPWR04+4VXoS3qlDBgIiIo8OtFyrcEN+n0Esk2NoKoSB+J/ANwOhmyCDjmMhst4XWgfsn8XkbmMK/16+nNRcK7yybhPtohrAnAyeZ+zs=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB11122.jpnprd01.prod.outlook.com
 (2603:1096:400:3df::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 12:05:12 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 12:05:12 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
CC:     "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid unnecessary
 memory assignment
Thread-Topic: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid
 unnecessary memory assignment
Thread-Index: AQHZ/BKVrluFe2vL8EK2EaoOE81Q27BNveCAgAAopfA=
Date:   Tue, 17 Oct 2023 12:05:12 +0000
Message-ID: <TYBPR01MB5341006D4CEAA1422B0A41F3D8D6A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
        <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
        <CGME20231017091924eucas1p2e65759cd05340e3e5b3a1d9ab9de1320@eucas1p2.samsung.com>
 <a85158a0-858c-43c3-b64a-c09de72a50f9@samsung.com>
In-Reply-To: <a85158a0-858c-43c3-b64a-c09de72a50f9@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB11122:EE_
x-ms-office365-filtering-correlation-id: 8a2ef0de-4391-4905-09a2-08dbcf09511c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THoGU4HYD+DhlKcTV0g55YAvDdLPCJHluCbVyqV4VOa3uIsG+o4GCxsL50fJrQhn/2NmOIi64XPSza86XaWbsomVze1+oG6HCFGlWcbFS7ObKBZqcN66T4JCIO6m+qxMJ0xo2N/pfVnHd2FjaL4XRyFBdK1MzjdHN7E8n0DsYhkkqPIDbkfZA3gLx9ppoJzZtSefc5Mp/2tbnqv3WOQTG/eyvFSXkGJAkDO641tI4bZ0hmp0xBiqysLgZuGeC8rh8CHGAYVoPAkqiXqqtp+S5CgMtl5wbRZpyLnykdIWy6n9Yvfhg7xd9cd42WdsH0lXFsAOmcnQnlKHpGe+ExXHmFeRBAm5AmT5FgZI3nmKqwNsLhu23TTrQPfj5mIWgKX8bZVMoBXk4GdCz05ZMUwRxwFjcKCUvFcw/SR08zI/BhDV45cOHhae0qqHbQ6yf7sIcm4f71ugy3pHJNY80dyftPJGt5Odh3H9kN+2NMAlSYX2DSKWonkZjWyht+JNlALHAY/o9JMbrvfqtzs2/zo2JcMq5hwWcjKcdB/i1VFf9VqgZLpKaZaFtpZacmFvSJgcXwCH0T4snrDFf+pVC+Ngdeqzb5Jk93f6fefSiA3TpdyvoTpq/1jW0OtKkruJiZP2V7omARBcroNbhtBYSsC/qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(52536014)(38100700002)(86362001)(5660300002)(122000001)(921005)(38070700005)(33656002)(41300700001)(2906002)(316002)(478600001)(6506007)(66946007)(66556008)(110136005)(71200400001)(7696005)(76116006)(83380400001)(8936002)(45080400002)(8676002)(4326008)(7416002)(53546011)(9686003)(54906003)(66446008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlJKV3ZOSXJyKzFxbDJCOUg1UVZkQVFma014YjZHenFRVU03cWdSa2RvNnBF?=
 =?utf-8?B?S1ZsbEt1MEJKaTExRFlyUHBBWnI3ZDZNT1pPWllyWFl4V0dmdjcxcHVYbHhV?=
 =?utf-8?B?UGViVDdVczRjdGRoRGsxZTdnNVJJSGJnSHVHVnVOQ0xsNzFBSDdBUlBoRmNr?=
 =?utf-8?B?bHRHK0FTRDZncXdQMWNwaWtLK3hpemJwaEdNemMwTzFyTDZHcG80R3hKVFdZ?=
 =?utf-8?B?OHJrRXNGVTYwajIxYmJTM2x3NklqLzJJbzNMTGZsR3VYZ01QaUI0NkRhOWxu?=
 =?utf-8?B?clFEbE1wYVVYRlVOSW5zMXV2Q0NvTmN0MjUxWEdYNEhhS1NTSlFZUVgrVjBD?=
 =?utf-8?B?Mm9UQ0pLVVllNzNURkY1VU5zVEVjTHN1Zkk4Y283V1RkNU8yNytiQTlqRytL?=
 =?utf-8?B?aXdvU3g0V3owSm9Ud2tyVUNKNk0yUlI2aFJ0YVlXQWNiaWt1M29BZWdiTGVt?=
 =?utf-8?B?anlFaDVVWWt4c2c0VDVwcHg0aWVCZ1BZVU5vZU5nMjQ0dFRvc25hSVpwTlhl?=
 =?utf-8?B?dURXMGlhZG9leEJyYlNqV1dTN0kzOXllUmtESHBlV2tvZEVINHE4Wk04Y2xi?=
 =?utf-8?B?bi9Ua0R0UzY1SmdpbDg4THpHY05Fcm1UMjhMVnZlOGdRam5LTEFtNno5NU56?=
 =?utf-8?B?NCtPQm9uZTgyeFpTR2JPMytWMmhhYWd5STl3S1QxWTkwS20yNkRkalc1aDF3?=
 =?utf-8?B?MUJPaHBLKzVkVmpBNHlmUVhrbUIwQ0Z0RDZ1WW1hKzZiZHUwU1lrc3VycW9O?=
 =?utf-8?B?VFFGQ254V3dZaDdOeXd6cUprR0NMRk5ta05GTG1sVmF0eWhSVkI4VzFLeVpa?=
 =?utf-8?B?dnZybzdtQjVzbkZ3Um5ReXMrbWtVNmJaZzk0bFR6azU4YXFOcThRZG5UQWE4?=
 =?utf-8?B?SE50c3FubVZtby90ZmFYT1ZlemN1cFE3UWNHZ0FXRzdkaHRiYkdFQUJKcWZG?=
 =?utf-8?B?M3hoQVJoK0c1b3BtaCtacWYxUkI4RnF6TTFhOEE3bm1lcE1WOGo3emVOaUdx?=
 =?utf-8?B?KytTT0ZtazRRZk5JK2FhNkJCVmozVnp3ang5TVlOWkU3UldvYmQ2RFMyYUs1?=
 =?utf-8?B?ZVJTMGpjVnR6NkNKYWs0RlIreDhDRlRod3hDVGxDSDhTTGZZMVRaNGJyWFJ6?=
 =?utf-8?B?YWJrUDYwWXJ4bXFVNTA4ZU5HTU91MzY5MEVPZThRT1NSZGRLLzBlQkhTWjV4?=
 =?utf-8?B?K1A4ejVuQnErU0VSNVY5YmJCTGdnVGhwY1d2Rkc0dDgyOUN3alpJNng3N3ZH?=
 =?utf-8?B?MXdHRElQYnh6dWQwcVV5RGt0ZkRIRklPWEdXck1oRENscy9sK1lVTjJPRkJE?=
 =?utf-8?B?U3ZUZEUza1gzRkdQZ1VNY3haN2VkN3hyUmVTRkxUakhHK0g5T1p1Q0RQUjhS?=
 =?utf-8?B?RHRGWlEwVEpieksra1FoMk9hOEVpVHBBeWRzTC8vUzNiS05NSzB5MHZmK3Jz?=
 =?utf-8?B?TXFFN0JpTi9Kc251R3VlQVIvQzFRN0N5b25GVUNWSkpJWkhaazVSRy9tRFQ2?=
 =?utf-8?B?T3k5MUhhSTBNb3dQT084WEFJL21iTk5aT3FRb0syYWFzR2c5MUZyNkV3TmRI?=
 =?utf-8?B?SkMyaGpTVTVOaldBWlZPQjhxSy9NUy9jTUpCRXhpUGhTc1RpV2NIUUFpSTJW?=
 =?utf-8?B?TSsxRmNBVjNaazduRCtkWUlBRVNSSmlWUHJHRUl6azY4bE1NaXpJbFVhVVZJ?=
 =?utf-8?B?bXhjMmFUWUxhNEpyM2pCZ2JpdEk3U1pIbFJaVStzQXBwUEJuWmNaelYvV3VC?=
 =?utf-8?B?THZUUE04U25rTVY5VnV6QTlhKzU1OURaTE4zNnJLRmIyZlVVd0lRYXcyTFdL?=
 =?utf-8?B?VlVFN2ZYd256YUdqdVVWNlhCQ2VrYXMzR0NINkUvR2RVRGZ3OXB0R3QrSnky?=
 =?utf-8?B?TnZ6NXFubm1yYTJoL2V3ZnBkV3dDOCt4VWdSaXJHK1JHR3lRUmZqZ0kvSkNN?=
 =?utf-8?B?ZlM5NnhlcDlqSU93Y09DMVM4UGpaWWxxbDZDQmczTVZnN29Tam9nRlZ1RUdN?=
 =?utf-8?B?Y0ZodDBOK2xaYTk4TEswTlNPeStlQ3JFQ21uQjVJK0ZId09IZTBLQWxzeTF5?=
 =?utf-8?B?N2crZGxnVDE5MVRrNlFZTmQxSkV1aStRdUVQVytNdlkrTEpOVDYvL2J3N2dr?=
 =?utf-8?B?Y2kzYWxvb05abFM1bFFRSlhQR3ZqZ09GbjBLNkxQd21ZNUx2bEFNYW5LRnBp?=
 =?utf-8?B?OUluMjlLeXZCR2k3a3BJOWN5OHhKWHpTdlB0Tk12SitqbTlVK0xQQnZ4ZCs4?=
 =?utf-8?B?d1VBZnovLy8zZkVKRDN3M3pEUzl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2ef0de-4391-4905-09a2-08dbcf09511c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 12:05:12.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U16e5Sg9arHbrLYuBV5+3xYTRf1eBA7BOKS2EUNSMDWEuyKfz9BbLuOCXekpfLaezmgLbp1bLNebQUko/CIFHtv1YqEACQcNIrnNO1lIUoGTY6yU3JeHdJqmemDVyZpB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RGVhciBNYXJlaywNCg0KPiBGcm9tOiBNYXJlayBTenlwcm93c2tpLCBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDE3LCAyMDIzIDY6MTkgUE0NCj4gDQo+IERlYXIgQWxsLA0KPiANCj4gT24gMTEuMTAu
MjAyMyAwOToxNCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gQWNjb3JkaW5nIHRvIHRo
ZSBzZWN0aW9uIDMuNS43LjIgIlJDIE1vZGUiIGluIERXQyBQQ0llIER1YWwgTW9kZQ0KPiA+IFJl
di41LjIwYSwgd2Ugc2hvdWxkIGRpc2FibGUgdHdvIEJBUnMgdG8gYXZvaWQgdW5uZWNlc3Nhcnkg
bWVtb3J5DQo+ID4gYXNzaWdubWVudCBkdXJpbmcgZGV2aWNlIGVudW1lcmF0aW9uLiBPdGhlcndp
c2UsIFJlbmVzYXMgUi1DYXIgR2VuNA0KPiA+IFBDSWUgY29udHJvbGxlcnMgY2Fubm90IHdvcmsg
Y29ycmVjdGx5IGluIGhvc3QgbW9kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGly
byBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gDQo+IFRoaXMg
cGF0Y2ggbGFuZGVkIGluIHRvZGF5J3MgbGludXgtbmV4dCAyMDIzMTAxNyBhcyBjb21taXQgZTMw
ODUyOGNhYzNlDQo+ICgiUENJOiBkd2M6IERpc2FibGUgdHdvIEJBUnMgdG8gYXZvaWQgdW5uZWNl
c3NhcnkgbWVtb3J5IGFzc2lnbm1lbnQiKS4NCj4gVW5mb3J0dW5hdGVseSBpdCBjYXVzZXMgdGhl
IGZvbGxvd2luZyBrZXJuZWwgcGFuaWMgb24gU2Ftc3VuZw0KPiBFeHlub3M1NDMzLWJhc2VkIFRN
MmUgYm9hcmQ6DQo+IA0KPiBleHlub3MtcGNpZSAxNTcwMDAwMC5wY2llOiBob3N0IGJyaWRnZSAv
c29jQDAvcGNpZUAxNTcwMDAwMCByYW5nZXM6DQo+IGV4eW5vcy1wY2llIDE1NzAwMDAwLnBjaWU6
wqDCoMKgwqDCoMKgIElPIDB4MDAwYzAwMTAwMC4uMHgwMDBjMDEwZmZmIC0+DQo+IDB4MDAwMDAw
MDAwMA0KPiBleHlub3MtcGNpZSAxNTcwMDAwMC5wY2llOsKgwqDCoMKgwqAgTUVNIDB4MDAwYzAx
MTAwMC4uMHgwMDBmZmZmZmZlIC0+DQo+IDB4MDAwYzAxMTAwMA0KPiBleHlub3MtcGNpZSAxNTcw
MDAwMC5wY2llOiBpQVRVOiB1bnJvbGwgRiwgMyBvYiwgNSBpYiwgYWxpZ24gNEssIGxpbWl0IDRH
DQo+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRk
cmVzcyBmZmZmODAwMDg0MTk2MDEwDQo+IE1lbSBhYm9ydCBpbmZvOg0KPiAuLi4NCj4gRGF0YSBh
Ym9ydCBpbmZvOg0KPiAuLi4NCj4gc3dhcHBlciBwZ3RhYmxlOiA0ayBwYWdlcywgNDgtYml0IFZB
cywgcGdkcD0wMDAwMDAwMDIyMDQ3MDAwDQo+IFtmZmZmODAwMDg0MTk2MDEwXSBwZ2Q9MTAwMDAw
MDBkZjZmZjAwMywgcDRkPTEwMDAwMDAwZGY2ZmYwMDMsDQo+IHB1ZD0xMDAwMDAwMGRmNmZlMDAz
LCBwbWQ9MTAwMDAwMDAyNGFkOTAwMywgcHRlPTAwMDAwMDAwMDAwMDAwMDANCj4gSW50ZXJuYWwg
ZXJyb3I6IE9vcHM6IDAwMDAwMDAwOTYwMDAwNDcgWyMxXSBQUkVFTVBUIFNNUA0KPiBNb2R1bGVz
IGxpbmtlZCBpbjoNCj4gQ1BVOiA0IFBJRDogNTUgQ29tbToga3dvcmtlci91MTg6MCBOb3QgdGFp
bnRlZCA2LjYuMC1yYzErICMxNDEyOQ0KPiBIYXJkd2FyZSBuYW1lOiBTYW1zdW5nIFRNMkUgYm9h
cmQgKERUKQ0KPiBXb3JrcXVldWU6IGV2ZW50c191bmJvdW5kIGRlZmVycmVkX3Byb2JlX3dvcmtf
ZnVuYw0KPiBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAt
U1NCUyBCVFlQRT0tLSkNCj4gcGMgOiBkd19wY2llX3dyaXRlX2RiaTIrMHhiOC8weGM4DQo+IGxy
IDogZHdfcGNpZV9zZXR1cF9yYysweDMwLzB4NGU0DQo+IC4uLg0KPiBDYWxsIHRyYWNlOg0KPiAg
wqBkd19wY2llX3dyaXRlX2RiaTIrMHhiOC8weGM4DQo+ICDCoGR3X3BjaWVfc2V0dXBfcmMrMHgz
MC8weDRlNA0KPiAgwqBkd19wY2llX2hvc3RfaW5pdCsweDIzOC8weDYwOA0KPiAgwqBleHlub3Nf
cGNpZV9wcm9iZSsweDIzYy8weDM0MA0KPiAgwqBwbGF0Zm9ybV9wcm9iZSsweDY4LzB4ZDgNCj4g
IMKgcmVhbGx5X3Byb2JlKzB4MTQ4LzB4MmI0DQo+ICDCoF9fZHJpdmVyX3Byb2JlX2RldmljZSsw
eDc4LzB4MTJjDQo+ICDCoGRyaXZlcl9wcm9iZV9kZXZpY2UrMHhkOC8weDE2MA0KPiAgwqBfX2Rl
dmljZV9hdHRhY2hfZHJpdmVyKzB4YjgvMHgxMzgNCj4gIMKgYnVzX2Zvcl9lYWNoX2RydisweDg0
LzB4ZTANCj4gIMKgX19kZXZpY2VfYXR0YWNoKzB4YTgvMHgxYjANCj4gIMKgZGV2aWNlX2luaXRp
YWxfcHJvYmUrMHgxNC8weDIwDQo+ICDCoGJ1c19wcm9iZV9kZXZpY2UrMHhiMC8weGI0DQo+ICDC
oGRlZmVycmVkX3Byb2JlX3dvcmtfZnVuYysweDhjLzB4YzgNCj4gIMKgcHJvY2Vzc19vbmVfd29y
aysweDFlYy8weDUzYw0KPiAgwqB3b3JrZXJfdGhyZWFkKzB4Mjk4LzB4NDA4DQo+ICDCoGt0aHJl
YWQrMHgxMjQvMHgxMjgNCj4gIMKgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANCj4gQ29kZTogZDUw
MzMyYmYgNzkwMDAwMjMgMTdmZmZmZTIgZDUwMzMyYmYgKGI5MDAwMDIzKQ0KPiAtLS1bIGVuZCB0
cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCj4gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6
IE9vcHM6IEZhdGFsIGV4Y2VwdGlvbg0KPiBTTVA6IHN0b3BwaW5nIHNlY29uZGFyeSBDUFVzDQo+
IEtlcm5lbCBPZmZzZXQ6IGRpc2FibGVkDQo+IENQVSBmZWF0dXJlczogMHg4YzAwMDIwZSwzYzAy
MDAwMCwwMDAwNDIxYg0KPiBNZW1vcnkgTGltaXQ6IG5vbmUNCj4gLS0tWyBlbmQgS2VybmVsIHBh
bmljIC0gbm90IHN5bmNpbmc6IE9vcHM6IEZhdGFsIGV4Y2VwdGlvbiBdLS0tDQo+IA0KPiBJJ3Zl
IG9ic2VydmVkIHNpbWlsYXIgaXNzdWUgb24gUXVhbGNvbW0ncyBSQjUgcGxhdGZvcm0gd2l0aCBz
b21lDQo+IGFkZGl0aW9uYWwgbm90LXlldCBtZXJnZWQgcGF0Y2hlcyBlbmFibGluZyBQQ0llIHN1
cHBvcnQuIFJldmVydGluZw0KPiAkc3ViamVjdCBvbiB0b3Agb2YgbGludXgtbmV4dCBmaXhlcyB0
aGlzIGlzc3VlLg0KPiANCj4gTGV0IG1lIGtub3cgaWYgeW91IG5lZWQgbW9yZSBpbmZvcm1hdGlv
bi4NCg0KVGhhbmsgeW91IGZvciB0aGUgcmVwb3J0LiBJIGd1ZXNzIHRoYXQgdGhlIGlzc3VlIGlz
IHJlbGF0ZWQgdG8NCm91dC1vZi1yYW5nZSBhY2Nlc3Mgb2YgZGJpMjoNCi0gSW4gYXJjaC9hcm02
NC9ib290L2R0cy9leHlub3MvZXh5bm9zNTQzMy5kdHNpLCB0aGUgZGJpIHJlZyBzaXplIGlzIDB4
MTAwMA0KICBsaWtlIGJlbG93Og0KLS0tLS0NCiAgICAgICAgICAgICAgICBwY2llOiBwY2llQDE1
NzAwMDAwIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic2Ftc3VuZyxl
eHlub3M1NDMzLXBjaWUiOw0KICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MTU3MDAw
MDAgMHgxMDAwPiwgPDB4MTU2YjAwMDAgMHgxMDAwPiwNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDwweDBjMDAwMDAwIDB4MTAwMD47DQogICAgICAgICAgICAgICAgICAgICAgICByZWct
bmFtZXMgPSAiZGJpIiwgImVsYmkiLCAiY29uZmlnIjsNCi4uLg0KLS0tLS0NCg0KLSBJbiBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYywgImRiaTIiIGFyZWEgaXMg
Y2FsY3VsYXRlZA0KICBieSB0aGUgZm9sbG93aW5nIGlmIHJlZy1uYW1lcyAiZGJpMiIgZGlkbid0
IGV4aXN0Og0KLS0tLS0NCiAgICAgICAgICAgICAgICAgICAgICAgIHBjaS0+ZGJpX2Jhc2UyID0g
cGNpLT5kYmlfYmFzZSArIFNaXzRLOw0KLS0tLS0NCg0KLSBIb3dldmVyLCB0aGlzIGlzIG91dC1v
Zi1tZW1vcnkgb24gZXh5bm9zNTQzMy5kdHNpIGJlY2F1c2UgdGhlICJkYmkiIHNpemUgaXMNCiAg
MHgxMDAwIG9ubHkuDQotIEFuZCB0aGVuLCB0aGlzIHBhdGNoIGFsd2F5cyB3cml0ZXMgUENJX0JB
U0VfQUREUkVTU19bMDFdIHRvIGRiaTIgYXJlYS4NCiAgU28sIHNpbmNlIHRoaXMgaXMgb3V0LW9m
LXJhbmdlLCB0aGUga2VybmVsIHBhbmljIGhhcHBlbnMuDQoNClBlcmhhcHMsIHdlIHNob3VsZCBy
ZXZlcnQgdGhpcyBwYXRjaCBhdCBmaXJzdC4gQW5kLCBhZGQgdGhlIHNldHRpbmdzIGludG8NCm15
IGVudmlyb25tZW50IChwY2llLXJjYXItZ2VuNC5jKSBvbmx5LiBJIGFsc28gaGF2ZSBhbHRlcm5h
dGl2ZSBzb2x1dGlvbiB3aGljaA0KbW9kaWZpZXMgdGhlICJkYmkyIiBhcmVhIGNhbGN1bGF0aW9u
IGFuZCBhdm9pZCBvdXQtb2YtcmFuZ2UgYWNjZXNzIHNvbWVob3cuDQpCdXQsIGl0IG1heSBjb21w
bGljYXRlIHNvdXJjZSBjb2RlLi4uDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2Rh
DQoNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS1ob3N0LmMgfCA4ICsrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBpbmRleCBhNzE3MGZkMGU4NDcuLjU2Y2M3ZmY2ZDUwOCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLWhvc3QuYw0KPiA+IEBAIC03MzcsNiArNzM3LDE0IEBAIGludCBkd19wY2llX3NldHVw
X3JjKHN0cnVjdCBkd19wY2llX3JwICpwcCkNCj4gPiAgIAl1MzIgdmFsLCBjdHJsLCBudW1fY3Ry
bHM7DQo+ID4gICAJaW50IHJldDsNCj4gPg0KPiA+ICsJLyoNCj4gPiArCSAqIEFjY29yZGluZyB0
byB0aGUgc2VjdGlvbiAzLjUuNy4yICJSQyBNb2RlIiBpbiBEV0MgUENJZSBEdWFsIE1vZGUNCj4g
PiArCSAqIFJldi41LjIwYSwgd2Ugc2hvdWxkIGRpc2FibGUgdHdvIEJBUnMgdG8gYXZvaWQgdW5u
ZWNlc3NhcnkgbWVtb3J5DQo+ID4gKwkgKiBhc3NpZ25tZW50IGR1cmluZyBkZXZpY2UgZW51bWVy
YXRpb24uDQo+ID4gKwkgKi8NCj4gPiArCWR3X3BjaWVfd3JpdGVsX2RiaTIocGNpLCBQQ0lfQkFT
RV9BRERSRVNTXzAsIDB4MCk7DQo+ID4gKwlkd19wY2llX3dyaXRlbF9kYmkyKHBjaSwgUENJX0JB
U0VfQUREUkVTU18xLCAweDApOw0KPiA+ICsNCj4gPiAgIAkvKg0KPiA+ICAgCSAqIEVuYWJsZSBE
QkkgcmVhZC1vbmx5IHJlZ2lzdGVycyBmb3Igd3JpdGluZy91cGRhdGluZyBjb25maWd1cmF0aW9u
Lg0KPiA+ICAgCSAqIFdyaXRlIHBlcm1pc3Npb24gZ2V0cyBkaXNhYmxlZCB0b3dhcmRzIHRoZSBl
bmQgb2YgdGhpcyBmdW5jdGlvbi4NCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiAtLQ0KPiBNYXJlayBT
enlwcm93c2tpLCBQaEQNCj4gU2Ftc3VuZyBSJkQgSW5zdGl0dXRlIFBvbGFuZA0KDQo=
