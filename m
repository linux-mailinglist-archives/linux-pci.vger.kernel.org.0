Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A527D5A5D62
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiH3HvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiH3HvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:51:01 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50070.outbound.protection.outlook.com [40.107.5.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347457D7AC;
        Tue, 30 Aug 2022 00:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJBar/VGVrJgUGMLBhcJf2F54F+lxjwrEluAdogmlcJXnZ+L4ly2IZQjaSOXJJ9eTk7n6+F0IxPGsONGzHstJb3fn8iM4TTfr8qNGLA426ikaCquBui2yMRRkBeCtpJjx5gTt3X/zuMlmRKwoZFify2zOaBicvIIZz/a9dvXuMpeMHCDMMLBkvc0wkchOQXI+2OADyjUUPqrGa66fDcdgewLqN8cGHjdCD7+tftLGCuLuFcTf5r4nTHWxZYtSwEQ1tDI/d3bwFYKWLAhV839mxCoEpRK5hfZGHxRx4Y1n0ZFMQjI95IH7mtzTooxS6SRyqy4baPYIs46nnFnZj5TkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdZOwtzmOj1O01f0czfdIJ3hBUie8rwVkiNbvNBZSMg=;
 b=ajd+dV16NQL0cIcmZotJmYX4zXtuoOZlmpDSzPTWpdd7xcpb6fF4DXC/jbqfdZG/hA5fdWX8jrRmjVmIIZ3FU0orCZeCS++DNPh5Kc2/TZT0L3LRPzZPEOxCHlmTEtLkum86VFQGvxQsFmgpHbh9NJVmC74Al1PT5HYEY+LI6RU45yxORRqCLWwGBFaooPIAxiqHyk3Pr2tQ4MTyCrOWAD7dygH9eKjfYKoR5l/hKnRZty18WJ0AsgLRtzkKx5dPJe1bW9gzdn7eHhThfbmUqQCrKXRRmljqcJqB+jpSJuouqfPKPU4tcK/+VrtPd13sqNqJ59LQMRGQ0DVbZR9t+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdZOwtzmOj1O01f0czfdIJ3hBUie8rwVkiNbvNBZSMg=;
 b=CJNeZ7ZgleZGW71Hodc9cXEb5kzA1T97BKo6UtXKC1dueJUDoeug3b8cGBMBas6l7kPk1lRJap+6EaK71BxH6xfUNbunQB4M7nBbDL8yf9ofx8JExELeae8i491aeu9dOl2mjMl0oFQNeDjDSN4riD1HfcScZy/h4X+4kC7USn0=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by HE1PR0401MB2379.eurprd04.prod.outlook.com (2603:10a6:3:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 07:50:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 07:50:55 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Topic: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Index: AQHYtisJvWRatmeqJkC37ps54LPbAa3FdjaAgAFfrrCAAD5dAIAABDdw
Date:   Tue, 30 Aug 2022 07:50:55 +0000
Message-ID: <AS8PR04MB86763A2187AED57CFD55625E8C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661173856-1192-1-git-send-email-hongxing.zhu@nxp.com>
 <e6d5f688-f4c3-6094-91f6-a160b601c07d@pengutronix.de>
 <AS8PR04MB86767CFA73F8C639EDD16A298C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <d3625367-9f7a-c864-7908-0c819bf3f496@pengutronix.de>
In-Reply-To: <d3625367-9f7a-c864-7908-0c819bf3f496@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6bcdf69-7b1f-44fa-eba8-08da8a5c5e89
x-ms-traffictypediagnostic: HE1PR0401MB2379:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKfJkUHVlhdFKC86Xer76YfN2WxQUkjRXqze1Z70Lt1dCGu5wIjS4pbvCHxHLAQ+ccUoQBgtRxL+Pt5RafxOGd4CH4r0Op9YTpRxvlEOJupbBJzQnSUKZE8rw0Cz87ltO0yXZgAenduf1clV0D3oIt/eYc54py3LwOnXjVBcHvyk2cRbvINEUY71uJ6107kee1dzYFPOB4o6WQNAqmLTr8tJVbbO9AxQjYm1WRP48plb0Md7g4hDgw6+bJP1qQBxH6ErS+ujlWvgWbMObSoHHlH5wXuP0Ies+wYbNyWn+VCGFE2oKnYCOQcm44HYl/bkMEYd5crgt0xppIdqdKOwf/QC4iGIY1QxuURUrF25YuAFfeSlXi+dzmrc0Rr50Y1+p5jgQsZCH1W5KcAqtRV1G1YSyejrhf7LJsRBCC8CL9ug4AY+TsngoogFBChUTL6H9pSMFEkrmD/E6fKl6C1r878g1UwBUBMOxTHKyIdK2uCM1ND/Cb15KYTgR+YNAFHtLMgecyMtOR/SafzRV8k2TL/f4lcjyp6BcQ9U1VJ/+9fovSxzQAyEIGRDsQuJWik/k81oO3Y24rMl9cYGXrmrweFXYJnkqBaRsdFCNo42c/QF1pT5mxRHay1Hl4cx5reScjYBsfgAhm+bd0+5jIAYKxEYQbGKtvONSUuq/oa4bDArGqzPrGf+kVuS5fHvjJZgKzrZM63PuARx/iKkR2ouwlRocNMg+yvJW1EaO3k5QyUSEPrsG85tLdM4F93rNu3j2Au/wYjeysVWVahJP6foLwj2WQmLtBPzFUa+r3lGEEk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(9686003)(55016003)(2906002)(66446008)(4326008)(8676002)(66946007)(76116006)(64756008)(66556008)(66476007)(110136005)(45080400002)(53546011)(6506007)(7696005)(26005)(54906003)(316002)(33656002)(41300700001)(71200400001)(478600001)(966005)(8936002)(86362001)(38070700005)(186003)(122000001)(83380400001)(5660300002)(7416002)(38100700002)(52536014)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VnREcERtYUkxbEpuMlRTbmdaSzlUTW1qMmhzZTR0c0ZIT20xdEJkb3EzcjB5?=
 =?gb2312?B?WGY0RmlWcXNXTERYSXQ3dFV1R3o4Sm1oeTd4THZYVFQ3R0FzeFNkVm0yMVhj?=
 =?gb2312?B?QlRPRDQ4d3cwNW5KOWsvbjJoRnhPbksrRmhkclZTbTBadkVCUXJ3UklLRENr?=
 =?gb2312?B?NlhUWXM2b01ySEc4Q1B4dE9iODRpeGJlbEZ3eHJuVzZxZ2drdUlhQnVtR21Y?=
 =?gb2312?B?TU1BQUJ6ODVFV25BYWxpWldtc3JGek05T2FLZHhueWJMWDlhNkV4YllPd2Rz?=
 =?gb2312?B?b0VEVjVsNzJleFRpVGx2YTVEUFlKN2RGMXFLbFNkYmUvd0RFY242OU5KdTFy?=
 =?gb2312?B?USsvUkpQNzhleGt1ZlZCemlVZWlmSlFHQVN5dVBrKzR0NHQrY3N1SjBQeVAz?=
 =?gb2312?B?QyttZThJVmFxMjF1RWRTYzA1ZXoyRTE1cEFjTVBwUHZnNkI2QkRhalJVbkNN?=
 =?gb2312?B?SlB6QUsyTHFEOEN4cjhJNjdZTUFGY20yT3gycGNsYVRmd1hRZjJVeTZjNEtM?=
 =?gb2312?B?dEYram8yajU0T2Z3b3ZMY09BRE9xVlZPWjE0WUJxZStpSkdrWHBaWHhXUDk1?=
 =?gb2312?B?R1hPQ2UwNldRMk1uQkhSNndLVStmVU90TnlidlJScmNwYnRETEFtNWtHMENm?=
 =?gb2312?B?aEhYclRxQWFWclk2M0pqQ01KMmlja1p0RUtXMEY0a01nRlhKdmIyV2gzRFB2?=
 =?gb2312?B?SkhuWlNIZVBCVnMvTUlkc3ZoaVR2ZkppcGxmNkNqOFdSRktzMXZwOTJ3c1J6?=
 =?gb2312?B?UURjVVdPd2RieWcxb1ZyWUhxdmxWaHNzT3JHbW1zbEIzRE1raVRWU3RkTmZP?=
 =?gb2312?B?eE5rdFBMOWNrVDZIKzlReHBYNGt5R1pCdWhaQmphbTFJNDQvVDVuZ3dvZ1gw?=
 =?gb2312?B?QTliMWszMjB0UG13VmZMYUdYMlFETmZRZEhWZWFRQmN4NXR3a0l1ZExTQ0NR?=
 =?gb2312?B?UkUvV1cxdUV3Tjh1aEIzNmtWRUdjOTFzMkZ2aENrSERNaU8vSUhzSWNxZ2gw?=
 =?gb2312?B?N3NUTnovc1Z0TVhFQkRWaDVsbHhUVHBCcG9YU0tYZWE5S21RbUpCb2duVGtF?=
 =?gb2312?B?a05Iakx2UTgvdkg4VnhhU1V3Zyt5R2g5c2ZqZUJNSk1ScXg1UHpYOWxHMW9n?=
 =?gb2312?B?L05LaUEwOXZUYkZUcW9HWlZueUhaMCs0WHF0VVZreEtPRmhPekJJWTJCL0hB?=
 =?gb2312?B?VGZvTEZrZi95SFZVN05VOUN6NkNaS2ZXMTA0cHhZUmxyUGJSWmFqZ2RJd2gr?=
 =?gb2312?B?MGN2T083SUlVNnVWTU9aWFN4NC9SUTBDWXVnOFlidkFBZ1YrQVpZbk1SME93?=
 =?gb2312?B?U0lUN2w3UkE2U2oyd2s1RTlsZjNNdWkxMlZYMDcvQVJ4VDNjZUNGMjlkdWN0?=
 =?gb2312?B?TytzbHhHZjZCbWdmbkJjZjM1bE9Yb1g4YzMwMC9MeEdNRGg5YnQrMGNLVUtV?=
 =?gb2312?B?aUlHUTFmK1o5c3RpVHh6NlVVU0hVNXNTOWU5ZTU2b3E2STBBdGp4L1h5UXJK?=
 =?gb2312?B?TzdBUmx0UWVrTXNEZlM5ckhmMDFTMXp4U0U5UXA1dEtWbEoxSDZVMVREQkFD?=
 =?gb2312?B?S0Z1dUM1d09TZUdpK0hJdXA0RGNVVkJ1bTVGOTRoWnRvc0Q3QmVMMnBZbVAw?=
 =?gb2312?B?dVl4Z2VxSzVNeWNjYnllWkVQRnNqNXNycWJ4Z2xDczdaOE84MjRYMTJVM1BR?=
 =?gb2312?B?VHJ3NDI4cVNrY0NQMkZrblFoV2Y4TklTT01GUlBoUE5jSjVQWnh0MWVLWW0w?=
 =?gb2312?B?RkJUZXRMcnFFQ0VyVzdmZUNnbmhsSVhoUzFDZ1JRbVdZUGtCWk9uMkgvb3Zk?=
 =?gb2312?B?VDhYUU5SUEJUS2FmU2VCcng0WVJLSGxET1E3bWtRVXE3N2VlaUlySC9lVU9o?=
 =?gb2312?B?VFEwSzcwQ01GNXZWQVdaUlZLRmhFVEMrR3BISldWdHllcWZtdTA1ZVJBUmdv?=
 =?gb2312?B?WUNtU0RwUTZxREpHZE5Mck9iZzd5dFZiNSs3K012YjBkMktOTkNOUkg0d3FE?=
 =?gb2312?B?VUo0U09Cc25XWUV1bFNVMTJ4M2dqNGo0MEM2UlpjVVNmekhIWnlOZzQxa2g5?=
 =?gb2312?B?TDA0dGFBc1J6ZXlocCs5RFZCYVZUaUdPS2JKTHNWTXNydGFJT3phWHJTWG9M?=
 =?gb2312?Q?+c0fdOTNzQ4EoObxmKiDFKxRc?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bcdf69-7b1f-44fa-eba8-08da8a5c5e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 07:50:55.3585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmwiI/+kCVU7AZEUdseHIk+faqjpDbnZRAYY/imWaq9tAi+abofIOS6A61yl0M9fJp0BW2xSVZJkvvxIGdNrYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaG1hZCBGYXRvdW0gPGEuZmF0
b3VtQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIyxOo41MIzMMjVIDE1OjE2DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5k
ZTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgdmtv
dWxAa2VybmVsLm9yZzsgTWFyY2VsDQo+IFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRl
eC5jb20+OyBraXNob25AdGkuY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBu
eHAuY29tPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjEgMC8yXSBGaXggdGhlIHdyb25nIG9yZGVyIG9mIHBoeSBjYWxsYmFja3MN
Cj4gDQo+IEhlbGxvIFJpY2hhcmQsDQo+IA0KPiBPbiAzMC4wOC4yMiAwNTo0NywgSG9uZ3hpbmcg
Wmh1IHdyb3RlOg0KPiA+Pj4gW1BBVENIIHYxIDEvMl0gUENJOiBpbXg2OiBGaXggdGhlIHdyb25n
IG9yZGVyIG9mIHBoeV9pbml0KCkgYW5kDQo+ID4+PiBbUEFUQ0gNCj4gPj4+IHYxIDIvMl0gcGh5
OiBmcmVlc2NhbGU6IGlteDhtLXBjaWU6IEZpeCB0aGUgd3Jvbmcgb3JkZXIgb2YNCj4gPj4NCj4g
Pj4gVGhpcyBpbnRyb2R1Y2VzIGFuIGludGVybWl0dGVudCBicmVha2FnZS4gQ2FuIHlvdSBzcXVh
c2g/DQo+ID4NCj4gPiBIaSBBaG1hZDoNCj4gPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQo+
ID4gRG8geW91IG1lYW4gdG8gc3F1YXNoIHRoaXMgZml4IHRvIHRoZSBwcmV2aWV3IHNlcmllcz8N
Cj4gPiBJJ20gYWZyYWlkIHRoYXQgaXQncyBub3QgZWFzeSB0byBkbyB0aGF0Lg0KPiA+IEJlY2F1
c2UgdGhlcmUgYXJlIGEgbG90IG9mIHBjaS1pbXg2IGNvZGUgY2hhbmdlcyBhZnRlcg0KPiA+IGNv
bW1pdDogMWFhOTdiMDAyMjU4ICgicGh5OiBmcmVlc2NhbGU6IHBjaWU6IEluaXRpYWxpemUgdGhl
IGlteDggcGNpZQ0KPiBzdGFuZGFsb25lIHBoeSBkcml2ZXIiKS4NCj4gDQo+IFRoZSB3YXkgSSB1
bmRlcnN0YW5kIGl0LCBpZiBhIGJpc2VjdCBlbmRzIHVwIGJldHdlZW4geW91ciB0d28gcGF0Y2hl
cywgaS5NWDhNDQo+IFBDSWUgd2lsbCBiZSBicm9rZW4sIHdoZXJlYXMgaXQgd29ya2VkIGJlZm9y
ZS4gSSB0aHVzIHdvbmRlciBpZiB3ZSBzaG91bGRuJ3QNCj4gaW5zdGVhZCBzcXVhc2ggdGhpcyBz
ZXJpZXMgaGVyZSBpbnRvIGEgc2luZ2xlIHBhdGNoLg0KWWVzLCBpdCdzIGEgcG9zc2libGUgY2Fz
ZSB3aGVuIGRvIHRoZSBiaXNlY3QuDQpTaW5jZSB0aGVzZSBjaGFuZ2VzIGFyZSBiZWxvbmcgdG8g
ZGlmZmVyZW50IGdpdCByZXBvLg0KSXQgd2lsbCBicmluZyBtYWludGFpbiBkaWZmaWN1bHRpZXMg
aWYgdGhlc2UgdHdvIHBhdGNoZXMgYXJlIHNxdWFzaGVkIGludG8gYQ0KIHNpbmdsZSBvbmUuDQpJ
dCdzIGRpZmZpY3VsdCB0byBtYWtlIGEgY2hvaWNlLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQg
Wmh1DQo+IA0KPiBDaGVlcnMsDQo+IEFobWFkDQo+IA0KPiANCj4gPg0KPiA+IEJlc3QgUmVnYXJk
cw0KPiA+IFJpY2hhcmQgWmh1DQo+ID4+DQo+ID4+Pg0KPiA+Pj4NCj4gPj4NCj4gPj4NCj4gPj4g
LS0NCj4gPj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4g
Pj4gfA0KPiA+PiBTdGV1ZXJ3YWxkZXIgU3RyLiAyMSAgICAgICAgICAgICAgICAgICAgICAgfA0K
PiA+PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cCUzQSUyRiUyRnd3dy4NCj4gPj4NCj4gcGUlMkYmYW1wO2RhdGE9MDUlN0MwMSU3Q2hvbmd4
aW5nLnpodSU0MG54cC5jb20lN0M5OTUwMTI0YmM3MWMNCj4gNGU4YzNjNg0KPiA+Pg0KPiA3MDhk
YThhNTc3MDUxJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYz
DQo+IDc5NzQ0MDU0DQo+ID4+DQo+IDA2OTA2MDM2JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5
SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2kNCj4gVjJsdU16SWkNCj4gPj4NCj4gTENKQlRpSTZJ
azFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9dktGWHgNCj4g
NFhEalJzSw0KPiA+PiBLcWg5YUJHT21EVE5HbkRKdVVjSmhPblRmN2JvQ0V3JTNEJmFtcDtyZXNl
cnZlZD0wDQo+ID4+DQo+IG5ndXRyb25peC5kZSUyRiZhbXA7ZGF0YT0wNSU3QzAxJTdDaG9uZ3hp
bmcuemh1JTQwbnhwLmNvbSU3QzMyNzcNCj4gPj4NCj4gNjFiYWM1Yjk0MDdkOTc3MDA4ZGE4OTg4
NmIxNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjMNCj4gPj4NCj4gNSU3QzAlN0Mw
JTdDNjM3OTczNTE2MjU0NjU2OTg1JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5Sg0KPiA+Pg0K
PiBXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlNw0KPiA+Pg0KPiBDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9aGFzT3RYNzclMkZl
YTV5TGJWOEM3d09mZFpTdEY1ZXJIT0w1OA0KPiA+PiBaZjZaWmJvNCUzRCZhbXA7cmVzZXJ2ZWQ9
MCAgfA0KPiA+PiAzMTEzNyBIaWxkZXNoZWltLCBHZXJtYW55ICAgICAgICAgICAgICAgICAgfCBQ
aG9uZToNCj4gPj4gKzQ5LTUxMjEtMjA2OTE3LTAgICAgfA0KPiA+PiBBbXRzZ2VyaWNodCBIaWxk
ZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6DQo+ID4+ICs0OS01MTIxLTIwNjkxNy01
NTU1IHwNCj4gDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KPiB8DQo+IFN0ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAgICAg
ICAgICB8DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwJTNBJTJGJTJGd3d3LnBlDQo+IG5ndXRyb25peC5kZSUyRiZhbXA7ZGF0YT0wNSU3
QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3Qzk5NTANCj4gMTI0YmM3MWM0ZThjM2M2NzA4
ZGE4YTU3NzA1MSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1DQo+ICU3QzAlN0Mw
JTdDNjM3OTc0NDA1NDA2OTA2MDM2JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SlcNCj4gSWpv
aU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAl
M0QlN0MzDQo+IDAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9eFdlMHVudDJjSnM0NHpKZjEwaCUyQjNm
c3Z4azZTdU9ONnREY0FDSA0KPiBvd0ltQSUzRCZhbXA7cmVzZXJ2ZWQ9MCAgfA0KPiAzMTEzNyBI
aWxkZXNoZWltLCBHZXJtYW55ICAgICAgICAgICAgICAgICAgfCBQaG9uZToNCj4gKzQ5LTUxMjEt
MjA2OTE3LTAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAg
ICAgfCBGYXg6DQo+ICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCg==
