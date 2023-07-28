Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42415766308
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 06:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjG1ETo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 00:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjG1ETn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 00:19:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2091.outbound.protection.outlook.com [40.107.113.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CCC35A0;
        Thu, 27 Jul 2023 21:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzftaFVwkLpgigCJt1HtUKCVFQt91liTxzCF2HsRkKHebsTiSOic27KHT1ICRZz9vWo7PMbQXZbnXTVRiVM7KwxTX2YEgbO1JMiiFrR480GiT7uV0jV99pYvRM8LcnFOqasKyXW1zQuSNhOxJMlg74SEdHg1F2e0QVafgLRmZYZtUUPAdvpxvkDNQQ2zU5QU4tnWDMvSUxLjDz+dkWlUCwMP6DEmch+GKN0zvJEH16xbhFapjhRWLQZ4+L6D0i7CbZzeR4F7nVXQCsUISdeTpyr/J+tGgMs/db25cF/AphuR9WNIyqfqljvqoQbsnlzvTLCgDON2H1G8jOFJIw5FOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKhKWng0zRBxqQzK6zLevaTamMnswIhOyg0pLYPWX6c=;
 b=RHsD8W5bKFVLJcgQdF31lHNWXwXUJ7ADZnlq1FNkDbAzMqy2vXPv9w8x60apnDs/Z7oECdfQ4CPsAAytRyTJgLrQdJS9CeCOuKqcTmWu3NVwV79I8pixMsm0lGE0lTOIgVpLMWJ01Gd3YjCVIKUItM/AXMvSkjYvQalYaG00Nx3cKZ1NRSF29F3NhxxvbU3TmrE/O4P73F+EukmfDsQntDjHtEQvtRyv/OLFkg8Sk8jUGm9lkOoKjvxTFZktao/5/KHikjvD6F0g4K0BmxtMHxBY2srW0Z2hkWMb/5vMvf/WZFSZ5sZYZzQ7MKcTswEU87EKHmFSYsgt5d0y2btSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKhKWng0zRBxqQzK6zLevaTamMnswIhOyg0pLYPWX6c=;
 b=DArRhnm47X7Qrwgc9nciYw0wrKuvvA0992RByfcoBpJ+x/op1JSjTMqSRZnCSduWhmbHyZOHqRTKwZe54KqyHhVv1cZL/NjDikb/o+aTjcPll3vwZJaLUyeTcGEptuh0CBgUYwWAxLgmhsSjjwyWkvLZZuIQVjYenWWjXU7IJN4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB8014.jpnprd01.prod.outlook.com
 (2603:1096:400:187::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 04:19:38 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 04:19:38 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Thread-Topic: [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Thread-Index: AQHZu6dDGGGQ+OAg50C3BavsZe1ATa/IxbcAgAKD7jCAAzvRgIAAGFuw
Date:   Fri, 28 Jul 2023 04:19:38 +0000
Message-ID: <TYBPR01MB534130DF2431F0A49E0C5C3BD806A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-10-yoshihiro.shimoda.uh@renesas.com>
 <20230724110344.GH6291@thinkpad>
 <TYBPR01MB534165847452C8A2398B03D9D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230728025119.GB4433@thinkpad>
In-Reply-To: <20230728025119.GB4433@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB8014:EE_
x-ms-office365-filtering-correlation-id: 1eb253db-d060-4d17-e586-08db8f21dbc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2ls4na1IeW2Ca4wfQgMX8bxFbwqFvZ/OgZjAmX1HVmDjGS7e828Yi+6mjH7sRIhT13woOjHzY3ze2ubER3xALL6SKu0nuJNkW1+d3nYO9QRobMVbpalWe3gLPhc9G3VyipECf7egNHhlcajPTvq5k0PsopMKrmPo1dCRgirBMJWNnNjwSY3GJDzlfv5EZxHx3BXD3sAwTSEjMHjhJHnxdDClApRyGy6PXjuvV7EEN/aUuRMOnyehGmfsfD143DMCZsUiShz8pzFc3RRd5xeaCdrqdHCGMMyblMq/Fr6PfrU6ZSborTWRhat7x/P5ykqXwEazfQDnxiLAHRZc5tT9MiLq78xPBAk5P6/HkhTfPeEujoksVQEQ66W+DNQTBVR0wM8VyFco3rV6wdomz7FZo5xkzVRELOxOzwcbnl7LnpJocri/so9rxlM/q+NotPJHQT9KLAaCmBew8yfYx7ajsIyEoq2iRmlpYZ/9Ph1cNF5mTI9jrcdN+yGbCJ+3TLI/A/AQL/AGwkd1sUOQLvJC/PbSIciuS1jvAvCX6K+cnBsPXyih42IYGF+53tqd5xtSf1H49Yb9qnKeQ2XkTkN9AHsHoxzX0fxlmJEc4h1TL1vBcXuRWKTw1BYHnkv51mF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(6916009)(38070700005)(66446008)(7696005)(71200400001)(66556008)(66476007)(76116006)(9686003)(66946007)(64756008)(4326008)(54906003)(38100700002)(55016003)(122000001)(41300700001)(478600001)(2906002)(83380400001)(7416002)(5660300002)(8676002)(8936002)(52536014)(33656002)(6506007)(316002)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzN2ZlRrUytaUWw4a2o1clRDckdHTVUzT0RqY09xNW52TittLzdKSlgybDB4?=
 =?utf-8?B?cnF1K3h3K0JiVG1CN0Z3aGtXcmtoaFJRVE1Wb2plV3EvRGo4czltejNJSVZ0?=
 =?utf-8?B?ZDFEYjRxdHJENktIOForcXkrTHlBVGFDVkpMZnpBMFpDSk9LM09CamNxSmxM?=
 =?utf-8?B?a2x6WTAzTlVnV0g3N2FYWmNKSERmYU9KUXFtZzdZdXl3RG9wa3Vqd3N0U3F6?=
 =?utf-8?B?N1dJOW90cm9Rci9NTEFTWW53REhPMUxFNjUvZ0dqa2pmMkFuT3ZRdHJMRk5i?=
 =?utf-8?B?QUpjL2VIT0JmbVkxWjQ1MlREaUVvVnc2Qi8rNDdYTTAremlrbGE3enhCUlhl?=
 =?utf-8?B?dThtamhGdFZJN3YrdytCRkFJMU5mUVE1NzJvdFB6YkJIWkJ6NVRveTlQR29o?=
 =?utf-8?B?TmJNeE1VemlsdFY0cVNOdU9RVHhJeFdjOHdrMDhPV3VnODd1enV4VUhDeHNj?=
 =?utf-8?B?MU9ScTd1OFRXS3NPaTI1OVY0bktXS21OQS9OcnhYQlZFU1g4SStka0kxSkF1?=
 =?utf-8?B?U01OM0FUR1ZodUtwdWExdlc4R0xMQi95NzBqQlJ1dGVvNU5SeXgwbTh3R25n?=
 =?utf-8?B?MUlUWHUrbjg1NWxKVWswYWR6ZmlKQU5Hd2RSUjNlVnlRZzZhQ1Z3ekJ2Vjkr?=
 =?utf-8?B?Ym9vV0U4OEtyZXg3R0pQaGJLNG9NYjBYVlh6Nm8zSXhkaFJrYVJGQ1cyL0dH?=
 =?utf-8?B?M2tTcVhCUk1XVnIyUVlreSsvSXF5SWRrdXpyMGtvSXBRYndpRG51Z0xGQW8r?=
 =?utf-8?B?T1FjSFRKRmI0R2RxbXM1dVVvajFjVjZqSUtJQitGVjR5VjFTRXhmTUNqaVNm?=
 =?utf-8?B?NGNyQ3pnZWhmTVhXaUo1ME1hNEltZVkyZ3VaYzZOZmdzK2Z2VW02S0lLSEJY?=
 =?utf-8?B?Vm5qWkR1b2lTYnV3MWx5a0ZlTHovSzVuQ0NZNWd6Z2NVdEtxdTlrK1l4a3Ri?=
 =?utf-8?B?N2RlYk8xZ1RmZ1JzVmpVdWtONm9KSFRuVnNqSTc0aStSWnBiUEZlZFFQUXMx?=
 =?utf-8?B?Q1UxUHVucDlhNFkvKzVZbXkzNi9PdnNsQWtYU2dldUlXUWdwckVwUDFKMzBR?=
 =?utf-8?B?RjV4L3h6a0RXbi84TGorRGlJOWVlc3EwVjczRXlCVVJWWndlbkpxWjNqdTRp?=
 =?utf-8?B?V0dQNThUVlNEU2xJTWVnN3BBWkRja3hjSndIV01pVVFJdlV0OWlaVFNVMGRZ?=
 =?utf-8?B?MUYzS1p5ZThEZXUwY1BRQm1odlN5TmtDMHlTb0dRZEdubXlaakNFYTJob3p0?=
 =?utf-8?B?UXBsQkJBejBrbUtuQll1NE1VdWpoOHJtQnQzc01WajBET2g0M3BvV2FEaEY0?=
 =?utf-8?B?U3NuWmtNeTJNNGd5QVUxbFByM0JJRHRCa3N1WEtuSURlVHQ1SGJ3TWJmYkZq?=
 =?utf-8?B?SWZ3Vm1NdXdCd2RhNTVUSytnQ1RVdmRja1FMK1ZKdUREenVyci80dHIzQ21m?=
 =?utf-8?B?TE1YNEFhSUk3WndONnR6TjdQV045NkpLT1pGNldFY1RaaUcvQi9UK2J6bEhv?=
 =?utf-8?B?ZmRyNDZ0N2JFTHpxZ0VWUFpIeDZHc3R0KzBBWm5xa3pjbVE0Z29mUTA4QUx1?=
 =?utf-8?B?N0xHOTFjOVA4YS9wbGtlNHF2RisrWjFvY1RqU1l2eXBSajA3VUozQ2VxOVp4?=
 =?utf-8?B?SU81eVVjZ1IyZm13L2Z4d2NVWjJKakt2T0RmK1NTejB2dG56ZWNMZWw4eDRq?=
 =?utf-8?B?U2JCaldsVkFkZVNHTUJKV1dPTUJibUpibVVuMWx3anhkV0ZuU3JpZk1oRVlL?=
 =?utf-8?B?Q0NkUTZuV1VZaGJObGhWWXdnZkhucjAxTVNlMkRFNmtuRDBObXJFbDdNeC9G?=
 =?utf-8?B?dHhQYWxiWFVjZGMxRmVlTDRSa0w0Ly9PUkhjMi9LU3hjVVJDcU5GK0FJTDN3?=
 =?utf-8?B?ODJoWkFDaFZiZ0JVM3Y5VHp4U2NRRkZIL0dRV2g5c1JXa3ZsTzh2SHZ5K0xx?=
 =?utf-8?B?VUc5aDdSRWozZCs0Z2VFUCtGbDZnU2FJVjViaTZ3dU10V0Y2Q2FFM3pSeldt?=
 =?utf-8?B?cVdQYkRhRmJrNHhQbkNEUWlsSkdodXJHQlhqRGMxSXRRRkRoVGV6ZC9VRUVT?=
 =?utf-8?B?R2FDMUR3b3RLTjFPbTNDMGFPQWFKWTRpOXdEcm8yUkcyY3VQQUw2Q090MXla?=
 =?utf-8?B?TVEyNkE0VzE5OGduRC9LbjZPUWVYV3doU3pwUkZOVmFCbkt6RVRCcThKZ2NF?=
 =?utf-8?B?MTk1YjNwWldRQzlobXRncUdQQ09CMFZZOTJGazdSdTVBbFNRN2prSThWS00r?=
 =?utf-8?B?Z3Z5azRNdGJrYnltQUwrQkNPeHpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb253db-d060-4d17-e586-08db8f21dbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 04:19:38.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xm7MSqdzfI1gE33EOpkOOFnxSrYi1sEpuHqoWi56w0J1VWbwlg/LMemruvvZn4ZLSSpcM+EVRmsz6nkDi0sdlJmOG7K0g1cVkna8ir5oJzaEUUHUOdW2EkPth/J2W2Ej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IEZy
aWRheSwgSnVseSAyOCwgMjAyMyAxMTo1MSBBTQ0KPiANCj4gT24gV2VkLCBKdWwgMjYsIDIwMjMg
YXQgMDI6MTI6MTVBTSArMDAwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gSGkgTWFu
aXZhbm5hbiwNCj4gPg0KPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtLCBTZW50OiBN
b25kYXksIEp1bHkgMjQsIDIwMjMgODowNCBQTQ0KPiA+ID4NCj4gPiA+IFN1YmplY3Qgc2hvdWxk
IGNvbnRhaW4gdGhlIHdvcmQgIm1pc3NpbmciLiBMaWtlLCAiQWRkIG1pc3NpbmcgUENJX0VYUF9M
TktDQVBfTUxXDQo+ID4gPiBoYW5kbGluZyIuDQo+ID4NCj4gPiBJIGdvdCBpdC4NCj4gPg0KPiA+
ID4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMDQ6NDQ6NDFQTSArMDkwMCwgWW9zaGloaXJvIFNo
aW1vZGEgd3JvdGU6DQo+ID4gPiA+IFVwZGF0ZSBkd19wY2llX2xpbmtfc2V0X21heF9saW5rX3dp
ZHRoKCkgdG8gc2V0IFBDSV9FWFBfTE5LQ0FQX01MVy4NCj4gPiA+ID4gSW4gYWNjb3JkYW5jZSB3
aXRoIHRoZSBEVyBQQ0llIFJDL0VQIEhXIG1hbnVhbHMgWzEsMiwzLC4uLl0gYXNpZGUgd2l0aA0K
PiA+ID4gPiB0aGUgUE9SVF9MSU5LX0NUUkxfT0ZGLkxJTktfQ0FQQUJMRSBhbmQgR0VOMl9DVFJM
X09GRi5OVU1fT0ZfTEFORVNbODowXQ0KPiA+ID4gPiBmaWVsZCB0aGVyZSBpcyBhbm90aGVyIG9u
ZSB3aGljaCBuZWVkcyB0byBiZSB1cGRhdGVkLiBJdCdzDQo+ID4gPiA+IExJTktfQ0FQQUJJTElU
SUVTX1JFRy5QQ0lFX0NBUF9NQVhfTElOS19XSURUSC4gSWYgaXQgaXNuJ3QgZG9uZSBhdA0KPiA+
ID4gPiB0aGUgdmVyeSBsZWFzdCB0aGUgbWF4aW11bSBsaW5rLXdpZHRoIGNhcGFiaWxpdHkgQ1NS
IHdvbid0IGV4cG9zZQ0KPiA+ID4gPiB0aGUgYWN0dWFsIG1heGltdW0gY2FwYWJpbGl0eS4NCj4g
PiA+ID4NCj4gPiA+ID4gWzFdIERlc2lnbldhcmUgQ29yZXMgUENJIEV4cHJlc3MgQ29udHJvbGxl
ciBEYXRhYm9vayAtIERXQyBQQ0llIFJvb3QgUG9ydCwNCj4gPiA+ID4gICAgIFZlcnNpb24gNC42
MGEsIE1hcmNoIDIwMTUsIHAuMTAzMg0KPiA+ID4gPiBbMl0gRGVzaWduV2FyZSBDb3JlcyBQQ0kg
RXhwcmVzcyBDb250cm9sbGVyIERhdGFib29rIC0gRFdDIFBDSWUgUm9vdCBQb3J0LA0KPiA+ID4g
PiAgICAgVmVyc2lvbiA0LjcwYSwgTWFyY2ggMjAxNiwgcC4xMDY1DQo+ID4gPiA+IFszXSBEZXNp
Z25XYXJlIENvcmVzIFBDSSBFeHByZXNzIENvbnRyb2xsZXIgRGF0YWJvb2sgLSBEV0MgUENJZSBS
b290IFBvcnQsDQo+ID4gPiA+ICAgICBWZXJzaW9uIDQuOTBhLCBNYXJjaCAyMDE2LCBwLjEwNTcN
Cj4gPiA+ID4gLi4uDQo+ID4gPiA+IFtYXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHByZXNzIENv
bnRyb2xsZXIgRGF0YWJvb2sgLSBEV0MgUENJZSBFbmRwb2ludCwNCj4gPiA+ID4gICAgICAgVmVy
c2lvbiA1LjQwYSwgTWFyY2ggMjAxOSwgcC4xMzk2DQo+ID4gPiA+IFtYKzFdIERlc2lnbldhcmUg
Q29yZXMgUENJIEV4cHJlc3MgQ29udHJvbGxlciBEYXRhYm9vayAtIERXQyBQQ0llIFJvb3QgUG9y
dCwNCj4gPiA+ID4gICAgICAgVmVyc2lvbiA1LjQwYSwgTWFyY2ggMjAxOSwgcC4xMjY2DQo+ID4g
PiA+DQo+ID4gPiA+IFN1Z2dlc3RlZC1ieTogU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21h
aWwuY29tPg0KPiA+ID4NCj4gPiA+IEFkZCBSZXBvcnRlZC1ieSBhbHNvPw0KPiA+DQo+ID4gSSBk
b24ndCB0aGluayBzbyBiZWNhdXNlIFNlcmdlIHN1Z2dlc3RlZCB0aGUgY29tbWl0IGRlc2NyaXB0
aW9uIGZyb20gbXkgc3VibWl0dGVkIHBhdGNoIFsxXS4NCj4gPg0KPiA+IFsxXQ0KPiA+DQo8c25p
cCBVUkw+DQo+ID4NCj4gDQo+IEZpbmUgdGhlbi4NCj4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4g
PiA+DQo+ID4gPiBUaGlzIGxvb2tzIGxpa2UgYSBwb3RlbnRpYWwgYnVnIGZpeCB0byBtZS4gU28g
cGxlYXNlIG1vdmUgdGhpcyBjaGFuZ2UgYmVmb3JlIHRoZQ0KPiA+ID4gcHJldmlvdXMgcGF0Y2gg
dGhhdCBpbnRyb2R1Y2VzIGR3X3BjaWVfbGlua19zZXRfbWF4X2xpbmtfd2lkdGgoKSwgdGFnIGZp
eGVzIGFuZA0KPiA+ID4gQ0Mgc3RhYmxlIGxpc3QgZm9yIGJhY2twb3J0aW5nLg0KPiA+DQo+ID4g
SSB0aGluayB0aGF0IHRoaXMgcGF0Y2ggc2hvdWxkIGJlIGEgbmV4dCBicmFuY2ggYmVjYXVzZSB0
aGlzIGlzIHBvc3NpYmxlIHRvDQo+ID4gY2F1c2Ugc2lkZSBlZmZlY3RpdmUuIEFsbW9zdCBhbGwg
ZHJpdmVycy9wY2llL2NvbnRyb2xsZXIvZHdjLyBob3N0IGRyaXZlcnMgZXhjZXB0DQo+ID4gcGNp
ZS10ZWdyYTE5NC5jIGRvZXNuJ3QgaGF2ZSB0aGlzIHNldHRpbmcsIGJ1dCBJIGFzc3VtZSB0aGF0
IHRoZSBkcml2ZXJzIHdvcmsgY29ycmVjdGx5DQo+ID4gd2l0aG91dCB0aGlzIHNldHRpbmcuDQo+
ID4NCj4gPiBBbHNvLCB0byBiZSBob25lc3QsIEkgY291bGQgbm90IGZpbmQgYSBzdWl0YWJsZSBj
b21taXQgSUQgZm9yIHRoaXMgcGF0Y2gncyAiRml4ZXMiIHRhZy4NCj4gPiBBZGRpdGlvbmFsbHks
IEkgY291bGQgbm90IGRldGVybWluZSB3aGljaCBvbGQga2VybmVsIHZlcnNpb25zIHNob3VsZCBo
YXZlIHRoaXMgcGF0Y2gNCj4gPiBhcHBsaWVkIGFzIGJhY2twb3J0aW5nLg0KPiA+DQo+IA0KPiBP
ay4gQnV0IHlvdSBjYW4gc3RpbGwgbW92ZSB0aGlzIHBhdGNoIGFzIEkgc3VnZ2VzdGVkLiBJZiB3
ZSBoYXBwZW4gdG8gaGl0IGFueQ0KPiBpc3N1ZSB3aXRoIHRoaXMgc2V0dGluZywgdGhlbiB3ZSBj
YW4gZWFzaWx5IHJldmVydCBpdC4NCg0KSSBnb3QgaXQuIEknbGwgbW92ZSB0aGlzIHBhdGNoIGFz
IHlvdSBzdWdnZXN0ZWQuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4g
LSBNYW5pDQo+IA0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBZb3NoaWhpcm8gU2hpbW9kYQ0KPiA+
DQo+ID4gPiAtIE1hbmkNCj4gPiA+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBTZXJnZSBTZW1pbiA8
ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgfCA5ICsrKysrKysrLQ0KPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4g
Pg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUu
Yw0KPiA+ID4gPiBpbmRleCA1Y2NhMzQxNDBkMmEuLmM0OTk4MTk0ZmU3NCAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4g
PiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMN
Cj4gPiA+ID4gQEAgLTczMCw3ICs3MzAsOCBAQCBzdGF0aWMgdm9pZCBkd19wY2llX2xpbmtfc2V0
X21heF9zcGVlZChzdHJ1Y3QgZHdfcGNpZSAqcGNpLCB1MzIgbGlua19nZW4pDQo+ID4gPiA+DQo+
ID4gPiA+ICBzdGF0aWMgdm9pZCBkd19wY2llX2xpbmtfc2V0X21heF9saW5rX3dpZHRoKHN0cnVj
dCBkd19wY2llICpwY2ksIHUzMiBudW1fbGFuZXMpDQo+ID4gPiA+ICB7DQo+ID4gPiA+IC0JdTMy
IGx3c2MsIHBsYzsNCj4gPiA+ID4gKwl1MzIgbG5rY2FwLCBsd3NjLCBwbGM7DQo+ID4gPiA+ICsJ
dTggY2FwOw0KPiA+ID4gPg0KPiA+ID4gPiAgCWlmICghbnVtX2xhbmVzKQ0KPiA+ID4gPiAgCQly
ZXR1cm47DQo+ID4gPiA+IEBAIC03NjYsNiArNzY3LDEyIEBAIHN0YXRpYyB2b2lkIGR3X3BjaWVf
bGlua19zZXRfbWF4X2xpbmtfd2lkdGgoc3RydWN0IGR3X3BjaWUgKnBjaSwgdTMyIG51bV9sYW5l
cykNCj4gPiA+ID4gIAl9DQo+ID4gPiA+ICAJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJRV9Q
T1JUX0xJTktfQ09OVFJPTCwgcGxjKTsNCj4gPiA+ID4gIAlkd19wY2llX3dyaXRlbF9kYmkocGNp
LCBQQ0lFX0xJTktfV0lEVEhfU1BFRURfQ09OVFJPTCwgbHdzYyk7DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKwljYXAgPSBkd19wY2llX2ZpbmRfY2FwYWJpbGl0eShwY2ksIFBDSV9DQVBfSURfRVhQKTsN
Cj4gPiA+ID4gKwlsbmtjYXAgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIGNhcCArIFBDSV9FWFBf
TE5LQ0FQKTsNCj4gPiA+ID4gKwlsbmtjYXAgJj0gflBDSV9FWFBfTE5LQ0FQX01MVzsNCj4gPiA+
ID4gKwlsbmtjYXAgfD0gRklFTERfUFJFUChQQ0lfRVhQX0xOS0NBUF9NTFcsIG51bV9sYW5lcyk7
DQo+ID4gPiA+ICsJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgY2FwICsgUENJX0VYUF9MTktDQVAs
IGxua2NhcCk7DQo+ID4gPiA+ICB9DQo+ID4gPiA+DQo+ID4gPiA+ICB2b2lkIGR3X3BjaWVfaWF0
dV9kZXRlY3Qoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4yNS4x
DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+Cu
qeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCu
o+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
