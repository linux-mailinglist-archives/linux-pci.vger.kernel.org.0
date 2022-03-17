Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF734DBBCB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 01:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354476AbiCQAbP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 20:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237889AbiCQAbO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 20:31:14 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130082.outbound.protection.outlook.com [40.107.13.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F891CB08;
        Wed, 16 Mar 2022 17:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGK10qNDwHgYq99UoFfg/5B9oOjGS3QAI6M1fuxO418fX9Krbu9ujlAvFWrIydXGUsccc03n6IFE41HKR+TqHqBhNzKqiivhy4AUgoZtxEkYTkBeyNUt3ZqaIfLGQ6pHNfkV96W2RooBIVHZ92ficpLepeAR942XMAOeGIxRLq+bTMInKZoEk5iumjtYATgRvihsWfFTvllP1JtszWGsTDZaIvmcZmwszWGZf1f/vgyLusDQs/aCclpDiBbjIqxEfYKeFPqjz8MubSf0UZkhNqw/f+9A28zXQGcAamYlXv0OVZtIxlpFzU69AJv4L9WD4aW/mtB8TSfTsi4in0W+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBL54WwwKUevTElnw7rruh9QHblyRn+NZ6IJw6H0NB4=;
 b=l2I/0BsMmSchJXFK5ghN5Jz1xtweBdGpem7RPV43GpKBiWqGCbjfbdIabYVvJfrhx0kQh0jF4rjXxrnkXcBPTOnQaB1VSe1i0DmEG/1sKkMqw8EnloOR4r/CXbeRhf2+ZuPL8/006pUI+lABDSbAxLnfttKQJ78MRXg9pCXUwtOFAG3Tv5+jTwYjg3TPkrHHmuTrq/5K8HVI1xVevoxCeAK4L3WCuzzB4o+Ulg7ZKt90UJRZJ2DJGPHG9sIxF6QICVKinSmt+3A/XgsWmXvH6CZKfGzmtvr8aRVy0CoAU1QxmVAGq+zueaBvH+YJZpR7lPT4epghGWMa9RuFJCN44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBL54WwwKUevTElnw7rruh9QHblyRn+NZ6IJw6H0NB4=;
 b=XRNQBYKSUlu61V7MLNHJhkRSr+1G4v4jxbQo88XkACZf24+Dvsh8gpugOOgPIQNkVWwkBWJ/fXe02miVovz5asWz/mzFbiNzRbtqyEXOYEx6sRl8cM/+r+h941xtoNOmDzesE/le5rNiSlzQmR0WdJoGr48gn0WJfMZ34mgVDQQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 00:29:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 00:29:55 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] PCI: imx6: Invoke the PHY exit function after PHY power
 off
Thread-Topic: [PATCH] PCI: imx6: Invoke the PHY exit function after PHY power
 off
Thread-Index: AQHYLsn7WwIs+ObiHUuj0vitQkpm3KzB1XKAgAD2A8A=
Date:   Thu, 17 Mar 2022 00:29:55 +0000
Message-ID: <AS8PR04MB86761853B899882338FCE8678C129@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646289275-17813-1-git-send-email-hongxing.zhu@nxp.com>
 <cf0943a1144e91048fc88fe9b11660bafe1a2d8d.camel@pengutronix.de>
In-Reply-To: <cf0943a1144e91048fc88fe9b11660bafe1a2d8d.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90d70ed2-011e-4982-f8f2-08da07ad42b4
x-ms-traffictypediagnostic: AM9PR04MB8113:EE_
x-microsoft-antispam-prvs: <AM9PR04MB8113B63230CB28C1DE1D77FF8C129@AM9PR04MB8113.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXjEw4FEoXrrk2KaJ9GO0qZfaup7WA/JrxYN1/z5np51tU4ksJ5E0lTjzJS+JHyi2RA3wtRxrhVD+srU3s7CIndxMdVXCu8xODnjUkZwnUu0xfLPKQnbq+OqH2ycBDQQElfh26vmc8/uAjbY5OdPU+z9dgd2kADHQ93eE8SvQfxwNNYpwHT/EWJApdGoP9NSYuKbeMel/u0yvhV1aDgl8LUp5RC/b4uPru+A0urgr1TVs78Ig5mavI9+zlHI7itFBWCAnmwULwES5daXk/9lTw4//I7JcM3X1vf3POdG9Q3ZvSJAbXa5v0fjpBHHXDMYVc5I9MB+rjDHmmEgT2mjGf81BpFOiKKk5OIb0/Ddkg19vgaKVLAyOU23slJ+aBGJ+nHbEswYabpnSBcRF+ZhoEDIslNYjyw2yaQrMJoLBdzGGZlA03QdvxSxTpb6MdeKIKnR7ihBGoEQlRO1QFThUMW1S/sQGVvQkAIQQV3rApELgif7rc3wY4lpqmztk1iW2uUFUqvjaybSGmXSqBGpACb78LmUYF77p2ima9CQLa9HIOlEfAF7S7HEcMSl5xv8pKmD7exHQdekrruUkbMFSK+D763gSx8kGnk6Src/AqH8lJVdL84F3HQ+0PI7Qx3gY6HpcRmkxOyLynd2aZdQ9+/twnNM3klhe81I2SesRcc0DlHrAjl8rmeT95r4NdjytOjFrZCGhWFX6ZTW4tqvfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(8676002)(5660300002)(4326008)(2906002)(55016003)(38070700005)(508600001)(53546011)(76116006)(8936002)(66946007)(52536014)(66556008)(66476007)(64756008)(6506007)(66446008)(7696005)(44832011)(38100700002)(71200400001)(33656002)(86362001)(26005)(186003)(316002)(9686003)(54906003)(110136005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TklCblJ3SWRVMlAzdUFOTUtNYlhvUUFiT2VUNklHYVFpYXVCN0hoZ2dTdVc3?=
 =?utf-8?B?Q2tUVVdtRnYwSVFFcGh5M1ZuTWJZRDdKb2dJVmVjMWt2UVlJZWk2UXJaY1Vk?=
 =?utf-8?B?bVhQWStKVDhON1N5ZllMMDdHc1Z3T3FFWmE5YmJQaXRyWU85ZklRRTVuQ3pK?=
 =?utf-8?B?NjNIWmR6L1Vhd2RRcUhMa1JhQWZXbUh1M1RyU05sNVo3K25tZTNpck5RS043?=
 =?utf-8?B?TzRXb1N1QzNZaFZ0OFpRak40aEYxbHMwYXZUdmQxNm51MHlhOW5NNE5OMlcz?=
 =?utf-8?B?WUJmYWxSU3o5TjhVc1hCdEVUSmhYdm82WkQyYzhQa3V6RkRjM05wNDdLTjZT?=
 =?utf-8?B?RklLb3JUamdFVDQzY2h5anhOSlN1UWxBMllnWUpvb1hjemE1c3FsWUE2N0dP?=
 =?utf-8?B?ZUZobnBoZEp3NE5DdkdhYUNRM2NRV0dlWE9hRVZRQTlobjhaemx3MVZTT2Z0?=
 =?utf-8?B?TEJ6d2VMZXI5Sk5TeWU2bXRZZHpsL09LYmtpekVlMTJUZjI3UnA5MnFlKy9o?=
 =?utf-8?B?NnVjMFR4cDA5Uy9WWUV6VVU2azdXZ3psOFVGQVVNUFBQWGdMNFlVcmszNnd1?=
 =?utf-8?B?VjBHakFsa1huWFQ0MzNocmdyTHBxMkdJbmh0SGtvNWRHU1QzOWl4bFQ1a3ht?=
 =?utf-8?B?TktuMGNLNzFqUTZJU0lwQ0VwZlVpUkU5WCt2cksyeHNRNS9pV1pKbEg0RmN2?=
 =?utf-8?B?NVhJSlRCRXN1V3VScFpselhnb1hWQ0E0T3VkallYc096RzNmTHdjNi9KV3Bs?=
 =?utf-8?B?Q3dVTXJncmRlSktlQW9CUHBzLzNqSGRWb1J2eEFpamNPOG56Q3RGTVQ2TnRr?=
 =?utf-8?B?U1ZCVTlDMmd5NW5jQkFlSGx4RC9WelJpVDVlbzVtbXBneUVOSi9zMEo1ZS9s?=
 =?utf-8?B?TkdXZEVzbHJ1K2tRR3RxWnFQV1NLa2RVbFp4dWRnKzdGZjEwOFNzYzRjMVdt?=
 =?utf-8?B?Qk1qTHgxaXdnQnRITUpHSTE1c054cmY4TDAxdHA0S3MyeEpCakdZSDJnZlIz?=
 =?utf-8?B?eUJrb2FZN3pvTUlQR01idE42OU9HZGhHLzFJR2E2UUlaa1o5cjZqNTVXaDEz?=
 =?utf-8?B?MEpFY0p1T3l3TXRXc2tkS3FFT2t4TmdJRFk3THQxZFQ3WnhhNUNpU2t0d1Zj?=
 =?utf-8?B?bEpXcDBWdVVvV1dlWFY3ZW9MbTYwTDVmZjAzQ2tDNllMbUhvZUJSeldvcFNH?=
 =?utf-8?B?OUxoUmFtTVlRc3pOeE15TnhoVHRGcXQva1ZvenE3MHdEbVpKZ0orc3FmTjlq?=
 =?utf-8?B?UE5CTURibzFuMUpvRmFsYVF3UENsRFAySWFUUlNxQmdFMVRURDJzS09YdC9t?=
 =?utf-8?B?NkdOc29zeldoT3dYNjZCTlFUdU96bk0vUkgrWDFGT1FqVU5DSXpxbkpyc1N4?=
 =?utf-8?B?Lys0d3AwYzRLZEdtNDd2L2dHU0JlWldnM25zbFpia0VtbDNFcU1ycWtnVlI0?=
 =?utf-8?B?di84ZDZ2aHB0L2lSSVczV011cWc5NC9mL0loVi9aQXVBTnVpRnkyRVRCZjNx?=
 =?utf-8?B?VEw0SXZGK2dRN3dUZ0hhWkZWRjNjWnFaeVU2L1pFMlE0SGJKeEZnb2hURkpz?=
 =?utf-8?B?ZFFrQVV0cE5rZS9kUW5KYW03ZE9tWFdiMkpPN1MrV3hyUTVNbWRsSTE2RmhD?=
 =?utf-8?B?SzBtUm55N2xlWHM0a0ViZ3hnLzk2cVFNcjNSTG8xd1c3SnBJemJ0RFdreFI0?=
 =?utf-8?B?L3c0aFAxRHUxb2h5cURiVlBTUWpnTjRydFNmdU5UaVFTVW5HRDU1MUhnR0tx?=
 =?utf-8?B?MXhYQlpMM2dveXVPZCthTjV6TEZ6OGN3dU1mRXVEQWxpM2t3SjRDeitSb1Rh?=
 =?utf-8?B?azd6ZHRXdW42MjlSdTNoalVEeGFiSWs2UFZVZnIzWEV2Sm9NNTgzRHR4UTlG?=
 =?utf-8?B?ZlNlZFpUSnZlWkZnbmdkN0s3alhKR2FQR01YUTA3QVZuUzdBVUwyUmNoeUhX?=
 =?utf-8?Q?BKKGtW2KkpUgCmJuruwSiWL2C9mzp7wn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d70ed2-011e-4982-f8f2-08da07ad42b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 00:29:55.5302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaXsGGd7VF7G0HrosqzuOLaiScEiuvew/0md4Poy2mmV6KciUD8UOwLdfl6G06FN1TDz5PoBvcVbosQEPBoGWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDPmnIgxNuaXpSAxNzozOA0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207
DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgN
Cj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IGlteDY6
IEludm9rZSB0aGUgUEhZIGV4aXQgZnVuY3Rpb24gYWZ0ZXIgUEhZIHBvd2VyDQo+IG9mZg0KPiAN
Cj4gQW0gRG9ubmVyc3RhZywgZGVtIDAzLjAzLjIwMjIgdW0gMTQ6MzQgKzA4MDAgc2NocmllYiBS
aWNoYXJkIFpodToNCj4gPiBUbyBiYWxhbmNlIHBoeS0+aW5pdF9jb3VudCwgaW52b2tlIHRoZSBw
aHlfZXhpdCgpIGFmdGVyIHBoeV9wb3dlcl9vZmYoKS4NCj4gPg0KPiBUaGlzIGxvb2tzIG9rYXkg
YXMgYSBmaXgsIGJ1dCBvdmVyYWxsIEkgZG9uJ3QgbGlrZSB0aGF0IHdlIG5lZWQgdG8gaGF2ZSBz
cGVjaWFsIFBIWQ0KPiBoYW5kbGluZyBpbiB0aGUgc3VzcGVuZCBwYXRoIGFuZCBQSFkgaW5pdCBo
aWRkZW4gaW4NCj4gaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KCkgaW4gdGhlIHJlc3VtZSBw
YXRoLiBNYXliZSB3ZSBjYW4gbWFrZSB0aGlzDQo+IFBIWSBoYW5kbGluZyBhIGJpdCBtb3JlIG9i
dmlvdXMgYnkgc3BsaXR0aW5nIGl0IG91dCBvZiB0aGUgY29yZSByZXNldCBzZXF1ZW5jZS4gSQ0K
PiBkb24ndCBzZWUgdGhlIGZ1bGwgaW1wbGljYXRpb25zIG9mIHN1Y2ggYSBjaGFuZ2UgeWV0LCBi
dXQgSSB0aGluayB3ZSBzaG91bGQgYXQNCj4gbGVhc3QgZ2l2ZSBpdCBhIHRyeS4NCj4gDQo+IEZv
ciBub3csIHRoaXMgcGF0Y2ggaXM6DQo+IFJldmlld2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCkhpIEx1Y2FzOg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBjb21t
ZW50Lg0KQWdyZWUgd2l0aCB5b3UsIHRoZSBQSFkgaGFuZGxpbmcgc2hvdWxkbid0IGJlIGluY2x1
ZGUgaW4gdGhlIHJlc2V0IGZ1bmN0aW9uLg0KSSB3b3VsZCBwbGFuIHRvIHJlZmluZSB0aGUgUEhZ
IGhhbmRsaW5nIGFmdGVyIHRoaXMgZml4Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoN
Cj4gDQo+ID4gRml4ZXM6IDE3OGUyNDRjYjZlMiAoIlBDSTogaW14OiBBZGQgdGhlIGlteDhtbSBw
Y2llIHN1cHBvcnQiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+
ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggMzMx
NDkwNjE0ZDU1Li4zNDNmZTE0MjllM2MgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtOTczLDYgKzk3Myw3IEBAIHN0YXRpYyBpbnQgaW14Nl9w
Y2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJY2FzZSBJTVg4
TU06DQo+ID4gIAkJaWYgKHBoeV9wb3dlcl9vZmYoaW14Nl9wY2llLT5waHkpKQ0KPiA+ICAJCQlk
ZXZfZXJyKGRldiwgInVuYWJsZSB0byBwb3dlciBvZmYgUEhZXG4iKTsNCj4gPiArCQlwaHlfZXhp
dChpbXg2X3BjaWUtPnBoeSk7DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAlkZWZhdWx0Og0KPiA+ICAJ
CWJyZWFrOw0KPiANCg0K
