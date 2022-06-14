Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0254A360
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 03:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiFNBCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 21:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbiFNBCt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 21:02:49 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50078.outbound.protection.outlook.com [40.107.5.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37411BF64;
        Mon, 13 Jun 2022 18:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFwb6qECy/E5DE5ubO2nnLNDI35lFzXR/jzEWzXjAfD6bNUgI7yLn/KOcuqZi3Vzm+zgaYK1ySADiydqt0jRvj0FRCXVIIimuHEcMRJlMlbnKSj1XwhgadjUTTytTBstPFgmddpq0G6f+u+erAyBeLfsPlrWD2JveIYMYyWBTr2YreEbc16/HfCeOfyqalkw3Cr7dBPkobLb8Lnd5+IcDgAZ7j6IS8kOefNZHT8Sx5weZDdh+qtpHPlQQEb9Qm8b51+u1xjURNU3+wX+XSvQDNWl+z+6fSA2XyKfRjqXv9y+SZENgWOEoADoAZ+5uYWWwyYLgRQ0hEN8w+IhtZxeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqG1ZQ2/3C4LDA+HNQUr1D9MJX2vKH77LRffvuiZoP8=;
 b=A8VACviy6vTJbEX85IR5NO3lnbs0LCuYcBeHCbK+0bhDAOpPtoVTRv8tec9FfT1oecz4X4HiAvYEUek5UrjSMfER8Ol/XPPgx2KFj1zc3F03KYx+gZC5mi98xgxQRStx0R1WuPCrB40RwwD3dFJHtaISQ4DP2qBwh6Yb5O9vb8rcGOmJzs31pgT04SKLi6E4tadBaWayU4C4/FNFe/3lElfqSs0D2WS879Vejb5Ow9uDOCKGdIahL1uia3OF1QoTgx9Jj5sa2L5uGRC+k8R44JjOqPPGHRMVZLZikm4MQeuTbSqcwM8ZUt1yaGQCsp1p8Ut5IKs1wRPimLxzxsBmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqG1ZQ2/3C4LDA+HNQUr1D9MJX2vKH77LRffvuiZoP8=;
 b=L8S2sdIQUi6HH6YNczWRblW0vE195YHhiao7kNbnJuERKQK2jta/fagGC67+KeYFItVmyuhKXFDynDlT9gMcuxaUU169ARXBBYCRsxU7EqYl5un8CyLjvrDZW1L/Iqbynkdwt5UqgjbQs5GXpUUvt/yBUniwpEhnG/E/uCzkcMI=
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by AM0PR04MB5378.eurprd04.prod.outlook.com (2603:10a6:208:10f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Tue, 14 Jun
 2022 01:02:44 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::8589:5e05:4fcc:ccf4]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::8589:5e05:4fcc:ccf4%9]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 01:02:44 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v10 6/7] PCI: imx6: Mark the link down as none fatal error
Thread-Topic: [PATCH v10 6/7] PCI: imx6: Mark the link down as none fatal
 error
Thread-Index: AQHYfwVMHst8QH4uN0G6BNAV54Lve61N6cSAgAAspvA=
Date:   Tue, 14 Jun 2022 01:02:43 +0000
Message-ID: <DU2PR04MB8677906BAD7E17A4480F52E88CAA9@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1655110538-10914-7-git-send-email-hongxing.zhu@nxp.com>
 <20220613222119.GA716475@bhelgaas>
In-Reply-To: <20220613222119.GA716475@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dad3e53-f80e-4943-30b0-08da4da196be
x-ms-traffictypediagnostic: AM0PR04MB5378:EE_
x-microsoft-antispam-prvs: <AM0PR04MB537883A737D1222B846CE23C8CAA9@AM0PR04MB5378.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zq5yw0/mksR+s2xRKq5WgVNVe5n2gEasq5LTemzTdOIP3fVLihJxMzFjv3yWX5YzjlRUWWDsUNGVHW3N8CzvgC/J11E6XQPfXZU7MJup5wsqkNm6apHJxK5FgMUMFOexX+q+nSJi/zlrLxUhxH/mwVw0ld7Id7pTXUMMd2iG1gpqXByWVLVqjfElxFaRfU/FAiUVuHZ/ukgo64TMH+TFb8COd/j9BpMY7JfTprVb2/a+EjfMf24sWsH3YkqO1xJvCKlYOj2XtzPOUn1VyXEyhetURwJUobGO3ixP36GJniF1aumzrgPCUl2hx9HUKQDCFUyZXziCH6NfRoJfBnif2hRy0r15wPLAKIs4tfUSKc7L+hk/Qw+yq5amsV9qKHr/DZQS0tzCxOEE6q1kmGXfWMIsZVSIjJuAbSA3FSFn6inlMCM6Sea7+G7NTv/WaSY5W6FaNfLYJ8E+/rAK2befljO+89AeuId80rHrhgYq6LSQVqrvoJQKlv8U8i6Z7Tm3QD8udHcqO0Jbx4K06l5rgq9cahJwstIflOLejQdAH3kMJJP9vKpT4J6+IuYF+DAOV/DJ9PW2tAdLzCWeKtN2R80sKhHgiEXCn4I4ZJaqHm073KlHezeFeUsjyqivkVQlkQvghT5nR52TwdErT26nmM+35q71dqiVqgK9DNj5msje7T1fMj9sXBQElcdzRLYCPbyIekGoaVmnHm+XeEfr8ViMjHcMpVkg/+rMK48JnHzMMKh2BdveNk10nHpEAYpB6SQUfoi+ep/bPSfbxszugAEzqydlRfHArLT3fGZwrQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(316002)(33656002)(2906002)(45080400002)(44832011)(54906003)(186003)(6916009)(83380400001)(26005)(9686003)(122000001)(7416002)(508600001)(71200400001)(38100700002)(55016003)(5660300002)(4326008)(76116006)(8676002)(8936002)(66476007)(64756008)(66946007)(66556008)(966005)(86362001)(53546011)(52536014)(7696005)(6506007)(66446008)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?REpyd0FvdTN1Ri9vVFl5eHEwR0Y4d1BLdzBwYlpjY1hEYkJnemRUTitubEpl?=
 =?gb2312?B?dnZTTEQxMkRvR1E4YXZMeWlGQWNicTZMay9NdW5OeVlrMXkxazd3TGhqcUJV?=
 =?gb2312?B?VTEvbFZHbG9MR0RPOWt0UnZzUjVrRjRYemlKM0dqaHdpMVBGMFVBRUp2MmxB?=
 =?gb2312?B?cE9QU1pyUnBJNmVWMkNxLytndkZUdzdYdjNUWjJ3bWJSK2FHYUxaVkhEMXhW?=
 =?gb2312?B?Y000bVBmbU90ckZJa3Z0SlpTTm1mRkhuNnZtUGxvbW4zWWN2blBXaktXck9Y?=
 =?gb2312?B?TjYyT1BqQWFNRjhnUzN2bGJ4RE13djUyMFBRbjNDYldYTEZiS1IrTnZ4aWFl?=
 =?gb2312?B?UUR5dUFkbkMzRHNqZStNUFdMSGxmR3VQV3UxMGpGZktDRnJrS0tRdmdGVEJj?=
 =?gb2312?B?SEhneFZGWDBxbG0zTHRZUlZtZE00N3poRnBibUxQNkpBb29hMHpXUmptZXI5?=
 =?gb2312?B?Y2JZQndKMHdyc1Zwb01qWFp1MU1JT2k5b29VejJiUFNsRTlEbXo2dmRrZ0pS?=
 =?gb2312?B?UmZkTEhNdGFKQm5VY2NGYWtzSFVtTVh6SVh0YnMyK3RRVzQwMktvM3NqbXRt?=
 =?gb2312?B?ZVdBK1kwL2JpSWdadzJEbFFPbU5EL0FtSklRajlBUitQbnlGQ0FhaEIvNG1l?=
 =?gb2312?B?OUJxVnY2L3gwVUtPVXF0YmhjcDQ3WlBFcmRUaHBtVW9QekgvNEFJVkNvV2Zv?=
 =?gb2312?B?WGp2V2Rhb2trTUZHOWMyeHhqY3BXK2RhMGpIVG1XT1ovdklyaWQyNSsrZ291?=
 =?gb2312?B?YmF3d2ZKd25aa0pWS0ZJY0w5QjJ3ZERSaXEvNjlibkVJc2pNejZBcmxvc1B6?=
 =?gb2312?B?M05mb1ZOQVBEaklybHMycCtiR0VrdFA1NHBad3J4QlNrR2FDQ1loYktoYklm?=
 =?gb2312?B?b2tOOGN3RWd1SzgzV0ZoYW9CcW10elpETW5sUEpqQUExR1RlSFpyUE5jY0F2?=
 =?gb2312?B?NUxwa0M5Z2lzQmNZNmRpZjFFWU1YaC9CTlpxQTZHUnczRnNob1h4K3Z2Q2xo?=
 =?gb2312?B?UndRSGpTcG9lZWoydlBESDkvV0tzak5raUFxQ0pUU0krQ2RYc3VZZkpPRGNx?=
 =?gb2312?B?S00xVDFnTWVKc1daa2xtb255d1ZmcStzSEh2SG9LU1U4cGVhL1d5Q3RpL3lJ?=
 =?gb2312?B?ZHFXb1l1Ykg4SUtkbElhOXlkT214WjhXTldBcUJNNitDUWo5ek43L3Znbm1z?=
 =?gb2312?B?WERUZXJFbFZnQnV0aElrSm0zSkI4R2RMV1UzRzRnSUlQWjlSWDZxcE5jbWJr?=
 =?gb2312?B?TXJ4SnhZWnpSY1ErdXZNNXNDTWVHbU9zVVZiaUdQMTBTYmUvM3pvZjR0V0ls?=
 =?gb2312?B?R01ldmY4QnFtZlNUMjcyVWdyQ3JzSXFIOXJVZnFOVHpDMEJEOGtVTExhSFBQ?=
 =?gb2312?B?eUJOUHZLLzVnN3NjU1YwZkg0VVBOaXF1OWE2dWhVV1dGaDdnUm5VcElPYytP?=
 =?gb2312?B?aTlJdk1KLzRiMFQwSFB2RytUMXpyZ0IxckpHQjJ3RTB2UW9EbXJjSmV4cUFj?=
 =?gb2312?B?QTM3ZFZTNno4QWhPVDVLVGl0ZjgrTDVMZSsweXlpK2FaN21oWnFGaWlqQTRt?=
 =?gb2312?B?bUpUTy9NL2F5WFhrMFNPRlVXWGJ2VVJtcVAvcXJmMXN2bGo3UUh3TUo4Q1kw?=
 =?gb2312?B?WmFUSjA3eEFvaFphVlZHVWtzRUhCbVBjTDVZWlg3MVZBeG5uMFBNdUdPd1F5?=
 =?gb2312?B?cVNRVTVucmdaTUpnSS91KzEraVQyZWo0VkdFK3d5d3AxbTNiOWYxTVFNUXZQ?=
 =?gb2312?B?OGQ5S3JhbVlhTjAzcXVPRmxpNFNlVUV5UWxZaWwxSkw0ekRvMzBhMXYzdk1V?=
 =?gb2312?B?c3lZZGxNaFh4aEZoN2dwUWpDeUR5ZXIvNkJraklPc2dHMmNKRDJIZkQ3ei9x?=
 =?gb2312?B?SDVYdHNWaTN2VnZUNXplOXdPbS9ja2pRNm1id0s1LytUaEF1eTZVeVFibkpP?=
 =?gb2312?B?RUt2QkRXck5mdzV6RW5VZkovL0l2WWVySFJ5cEVud0RTNFRKUVNBZXVhRkZC?=
 =?gb2312?B?dE5JeGRhMFZJWnRTMkFmQVNXZ2IrLys5WnBXKzYwQmU1WlNSMkpzQjNYalFM?=
 =?gb2312?B?QTNIbDAzek8wUStYZ0VRSmRKYkxQSFo1WUtCcjJrQUFxeTFEQ2Vmb1gxRGFK?=
 =?gb2312?B?TTE1UmJidS9KNG43K3RwbXA2K1ZzMnBSckRSRHExSUdRcDRSRVdVR0ZyWmJI?=
 =?gb2312?B?L1JpbFlVT05adXZ2S3VBT0RNV09rQXBzTHEwRE5Tc0ZLcnNIU3ZmSUtIdUJx?=
 =?gb2312?B?dFlmVGxYRkgrM0RWVjdueWszanBaR2ZTOWFReFpSMm1HRmt2MGZLZld6Q1JW?=
 =?gb2312?B?SW9LOUNSalFsK3B4dzdCV1pSQU9oNWJCVEhNaTF2YmJ4NmNiUmtSQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dad3e53-f80e-4943-30b0-08da4da196be
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 01:02:44.0142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+9Q10YlmAGP9QKEf5pDEPMilQFwJbgwFG/6bb/dShKtJpwNKwPZ0esl61heOOTYveSKmLKHgmj/qNa1Gi2P4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5378
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjE0yNUgNjoyMQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gYnJvb25pZUBr
ZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgNi83XSBQQ0k6
IGlteDY6IE1hcmsgdGhlIGxpbmsgZG93biBhcyBub25lIGZhdGFsIGVycm9yDQo+IA0KPiBPbiBN
b24sIEp1biAxMywgMjAyMiBhdCAwNDo1NTozN1BNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToN
Cj4gPiBsZXQgdGhlIGRyaXZlciBwcm9iZSBzdWNjZXNzZnVsbHksIHJldHVybiB6ZXJvIGluDQo+
ID4gaW14Nl9wY2llX3N0YXJ0X2xpbmsoKSB3aGVuIFBDSWUgbGluayBpcyBkb3duLg0KPiA+DQo+
ID4gQmVjYXVzZSBpLk1YIFBDSWUgZG9lc24ndCBzdXBwb3J0IGhvdC1wbHVnIGZlYXR1cmUuDQo+
ID4gSW4gdGhpcyBsaW5rIGRvd24gc2NlbmFyaW8sIG9ubHkgc3RhcnQgdGhlIFBDSWUgbGluayB0
cmFpbmluZyBpbg0KPiA+IHJlc3VtZSB3aGVuIHRoZSBsaW5rIGlzIHVwIGJlZm9yZSBzeXN0ZW0g
c3VzcGVuZCB0byBhdm9pZCB0aGUgbG9uZw0KPiA+IGxhdGVuY3kgaW4gdGhlIGxpbmsgdHJhaW5p
bmcgcGVyaW9kLg0KPiANCj4gVGhpcyBsb29rcyBsaWtlIHR3byBjaGFuZ2VzIHRoYXQgc2hvdWxk
IGJlIHNlcGFyYXRlIHBhdGNoZXM6DQo+IA0KPiAgIDEpIE1ha2UgZHJpdmVyIHByb2JlIHN1Y2Nl
c3NmdWwgZXZlbiBpZiBsaW5rIGlzIGRvd24uDQo+IA0KPiAgIDIpIFJlZHVjZSByZXN1bWUgdGlt
ZSBieSBvbmx5IHN0YXJ0aW5nIHRoZSBsaW5rIGlmIGl0IHdhcyB1cCBiZWZvcmUNCj4gICAgICBz
dXNwZW5kLg0KWWVzLCB5b3UncmUgcmlnaHQuDQpUaGV5IGFyZSB0d28gY2hhbmdlcy4gV291bGQg
c3BsaXQgdGhlbSBpbnRvIHR3byBwYXRjaGVzIGxhdGVyLg0KVGhhbmtzIGEgbG90IGZvciB5b3Vy
IGtpbmRseSBoZWxwLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDE4ICsrKysrKysrKysr
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+
ID4gaW5kZXggYzAyNzQ4MzkzYWFjLi5hYzZlYzJkNjkxYTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtNjcsNiArNjcsNyBAQCBzdHJ1Y3Qg
aW14Nl9wY2llIHsNCj4gPiAgCXN0cnVjdCBkd19wY2llCQkqcGNpOw0KPiA+ICAJaW50CQkJcmVz
ZXRfZ3BpbzsNCj4gPiAgCWJvb2wJCQlncGlvX2FjdGl2ZV9oaWdoOw0KPiA+ICsJYm9vbAkJCWxp
bmtfaXNfdXA7DQo+ID4gIAlzdHJ1Y3QgY2xrCQkqcGNpZV9idXM7DQo+ID4gIAlzdHJ1Y3QgY2xr
CQkqcGNpZV9waHk7DQo+ID4gIAlzdHJ1Y3QgY2xrCQkqcGNpZV9pbmJvdW5kX2F4aTsNCj4gPiBA
QCAtODQ1LDcgKzg0Niw5IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0
IGR3X3BjaWUgKnBjaSkNCj4gPiAgCS8qIFN0YXJ0IExUU1NNLiAqLw0KPiA+ICAJaW14Nl9wY2ll
X2x0c3NtX2VuYWJsZShkZXYpOw0KPiA+DQo+ID4gLQlkd19wY2llX3dhaXRfZm9yX2xpbmsocGNp
KTsNCj4gPiArCXJldCA9IGR3X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPiA+ICsJaWYgKHJl
dCkNCj4gPiArCQlnb3RvIGVycl9yZXNldF9waHk7DQo+ID4NCj4gPiAgCWlmIChwY2ktPmxpbmtf
Z2VuID09IDIpIHsNCj4gPiAgCQkvKiBBbGxvdyBHZW4yIG1vZGUgYWZ0ZXIgdGhlIGxpbmsgaXMg
dXAuICovIEBAIC04ODEsMTEgKzg4NCwxNA0KPiBAQA0KPiA+IHN0YXRpYyBpbnQgaW14Nl9wY2ll
X3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiAgCQl9DQo+ID4NCj4gPiAgCQkv
KiBNYWtlIHN1cmUgbGluayB0cmFpbmluZyBpcyBmaW5pc2hlZCBhcyB3ZWxsISAqLw0KPiA+IC0J
CWR3X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPiA+ICsJCXJldCA9IGR3X3BjaWVfd2FpdF9m
b3JfbGluayhwY2kpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCWdvdG8gZXJyX3Jlc2V0X3Bo
eTsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJZGV2X2luZm8oZGV2LCAiTGluazogR2VuMiBkaXNh
YmxlZFxuIik7DQo+ID4gIAl9DQo+ID4NCj4gPiArCWlteDZfcGNpZS0+bGlua19pc191cCA9IHRy
dWU7DQo+ID4gIAl0bXAgPSBkd19wY2llX3JlYWR3X2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBf
TE5LU1RBKTsNCj4gPiAgCWRldl9pbmZvKGRldiwgIkxpbmsgdXAsIEdlbiVpXG4iLCB0bXAgJiBQ
Q0lfRVhQX0xOS1NUQV9DTFMpOw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gQEAgLTg5NSw3ICs5MDEs
NyBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9zdGFydF9saW5rKHN0cnVjdCBkd19wY2llICpwY2kp
DQo+ID4gIAkJZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBQQ0lFX1BPUlRfREVCVUcwKSwNCj4gPiAg
CQlkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfUE9SVF9ERUJVRzEpKTsNCj4gPiAgCWlteDZf
cGNpZV9yZXNldF9waHkoaW14Nl9wY2llKTsNCj4gPiAtCXJldHVybiByZXQ7DQo+ID4gKwlyZXR1
cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgaW14Nl9wY2llX2hvc3RfaW5pdChz
dHJ1Y3QgcGNpZV9wb3J0ICpwcCkgQEAgLTEwMjIsMTANCj4gPiArMTAyOCw4IEBAIHN0YXRpYyBp
bnQgaW14Nl9wY2llX3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIAlpbXg2
X3BjaWVfaW5pdF9waHkoaW14Nl9wY2llKTsNCj4gPiAgCWlteDZfcGNpZV9kZWFzc2VydF9jb3Jl
X3Jlc2V0KGlteDZfcGNpZSk7DQo+ID4gIAlkd19wY2llX3NldHVwX3JjKHBwKTsNCj4gPiAtDQo+
ID4gLQlyZXQgPSBpbXg2X3BjaWVfc3RhcnRfbGluayhpbXg2X3BjaWUtPnBjaSk7DQo+ID4gLQlp
ZiAocmV0IDwgMCkNCj4gPiAtCQlkZXZfaW5mbyhkZXYsICJwY2llIGxpbmsgaXMgZG93biBhZnRl
ciByZXN1bWUuXG4iKTsNCj4gPiArCWlmIChpbXg2X3BjaWUtPmxpbmtfaXNfdXApDQo+ID4gKwkJ
aW14Nl9wY2llX3N0YXJ0X2xpbmsoaW14Nl9wY2llLT5wY2kpOw0KPiA+DQo+ID4gIAlyZXR1cm4g
MDsNCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCj4gPg0KPiA+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cCUzQSUyRiUyRmxpc3RzDQo+ID4gLmluZnJhZGVhZC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZsaW51eC1hcm0ta2VybmVsJmFtcDtkYXRhPTA1JTcNCj4gQzANCj4gPg0KPiAxJTdDaG9u
Z3hpbmcuemh1JTQwbnhwLmNvbSU3Q2U3N2I4Zjg0ZDFjZjRhMGIxMDU4MDhkYTRkOGIwZTE4JTcN
Cj4gQzY4NmVhMQ0KPiA+DQo+IGQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2
Mzc5MDc1NTY4ODkwMDcwOTAlN0NVbmsNCj4gbm93biU3Q1RXDQo+ID4NCj4gRnBiR1pzYjNkOGV5
SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVg0K
PiBDSTYNCj4gPg0KPiBNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT12ZDBKV3o5ZDV4
RFA0TXBQTlRzcTVVRzJMDQo+IGdteCUyQiUyRnJORQ0KPiA+IHRuRjRVc1pLQ00lM0QmYW1wO3Jl
c2VydmVkPTANCg==
