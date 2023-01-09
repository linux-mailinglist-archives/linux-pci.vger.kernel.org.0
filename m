Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3702661C2F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 03:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjAICIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Jan 2023 21:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjAICIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Jan 2023 21:08:15 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DB10B73;
        Sun,  8 Jan 2023 18:08:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/AtEwTTUDWjO8lPcVtzUkK19w7y9yE3L/b1gwVI6YzJjg71YbMsB384hKjbFM5E64Rw3zQuhrQ1+soGb7g0Tz1TQVU8iAajKTKmt6MMGHTutwN46kv05yrfDKqsbHIk2smdlJM8uRAltnjyUh3StiNaJ4RQealu5jczZi0I0ZTmrRVUeHxNFsqACgdbg3V2QrUunI+HFsrUnnlzo97r9E72cSIJvuM2I0yKbBjPJBa+DIwjJZSFP4KaC6Wix6vrkSQysT2bJReUPmbSyeTZIpXly/ER+VrdGvE4aRnIX9NXN5+xddwDl0DVnpSDlj9CZ8Tz36OB14Un/Y5oTbg8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrnCHv4s4CulXFrSwO+0k1XiZw6WKotSIyoy22XoLLU=;
 b=OkqdyxEx2Q1rjhLb2hfZGJds1sCFd6CI9lTQdYr79BfKPS6O2B9K/IcCdfjyharpJVDyTRR6f+w+I8IQWHXTzQ7s+9M/dwk61uwl5gd5fGmGXcRPtNCKSnWRmOqeaEGMirmYknGijTUDZ6p525HUSv/HPcjks/gnDLAm+6nT66xwEV02t5D7YiyDGkehP3wc1xWC9wPBd34Ck7x7M20FptjwiUK3P7IxCylToMCMGno6t4a72mVPSg8Sczg0e4DCLD9YkulhXATpKTLDPrRzak4/Xl7aRcXVT/Ttv1vUlbH6/iYXBQ079i6IzsYql7Mkcz7HwWZRsVF48FIg0D73yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrnCHv4s4CulXFrSwO+0k1XiZw6WKotSIyoy22XoLLU=;
 b=Dp1xNO81kP/Daa8V3YsiewYqhiQ9xohJQdLuMk8zdPbesBAl8VE2SorzBvcdUbadawM7TN5/eP6ATZg0RIKjw6EsRTTV8Lo6nOZjj0jMUw0TjioXSeVWXQkxQKF0f4ktqdpEnG3OOmpIqtcf6Wz+EEzPPKYjFjrAlFSQ+HFOj4k=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7854.eurprd04.prod.outlook.com (2603:10a6:102:c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 02:08:06 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::49b8:a7b4:676b:2f8d]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::49b8:a7b4:676b:2f8d%5]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 02:08:06 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in
 suspend and resume
Thread-Topic: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in
 suspend and resume
Thread-Index: AQHZCs5AD2/8gpjnlEiLVRL42ArW9K6GqvQAgAVt7lA=
Date:   Mon, 9 Jan 2023 02:08:06 +0000
Message-ID: <AS8PR04MB8676F92A932B86E5A2A777798CFE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1670479534-22154-1-git-send-email-hongxing.zhu@nxp.com>
 <Y67+cH15frjqK2vA@lpieralisi>
In-Reply-To: <Y67+cH15frjqK2vA@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA4PR04MB7854:EE_
x-ms-office365-filtering-correlation-id: 5c56ebe0-2b8e-4631-29fc-08daf1e65902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgdTCYkthtFl1pa/4X/AoJ7+zR4ogrIdklfa7N+OQuu2MKewXb8LkuyXW2OiB9EzY30thf/j7608puOktJIaCGULZxbteYCheY1KNk9fi5YuLWAhSfUu6ZRmel/ag0TV43f2M2meGRNTOgg039H4R5vuqGRRTIueZHr6bpQcJwIyh94ZndZokwjy7WZWe8COQ3elAUjjhXEWBEXQ8Y8/dg+xm7U8Bp5qWF3TNkq/gwb8sX1fS8iBygqxckmHWHaoP/6zIoP6WJDttZt2fGzOf2ij6V55G5BXJVmXtHneJLYk/2bAo+c9oDkDzY8WJUlXhNFhNzkIZJxjBZ2oxzeSudla96gG+/NAPb8ltcU+CjO5gNFx127xMwQJkqFvwk5ElBv9/OulEok1IZ3754fSta4s+JWZo7fPY8ReURMGK1P1Wse6g5g0W/gbZxIk/YdK+npY8G0xHY9dshm+Bv7oXDNTWC/I9lh0mBbPnVYXO3ls/mugVk/BGCS5o2ohgsN1O+2B/dLPW+7xssrTdhE1NPiIy6teijJh5lNSeo8PZttAkkxWBA6K+PQdjD8vPVu6LttWWp68WSzpCHfXa+7SzQqrplXFkwc0syUp66vCVvvQQbeeukHlFH1EBCcRaH3M2OTixJgSgMQMzyu7NEP/LI5yVYkFsK/lN9In3L2ot7Oai0QU22VCKuTLXL6ZuWVP6WJ5+jha+DugET1d42qzVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(41300700001)(52536014)(44832011)(8936002)(5660300002)(2906002)(15650500001)(8676002)(66476007)(76116006)(64756008)(66556008)(66446008)(66946007)(45080400002)(316002)(7696005)(71200400001)(110136005)(54906003)(33656002)(966005)(6506007)(53546011)(478600001)(26005)(9686003)(4326008)(186003)(55016003)(86362001)(83380400001)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OERqcm03WXl2Tlphc0RsQVdLTXRpQ2FjQzBFTkk5SG1MOHo1V3VlVWxOemhK?=
 =?gb2312?B?TXg5MjlaMVppZmZaMlZUT0NPcjJJVFUvZFVtcTMwUnNVZkxsVktxdTA5ZkdH?=
 =?gb2312?B?OThMcHUxcTJ0VHU1ZUJVZHRabVlrWHc2RVpndjIzYzNDTVhyeDRSSmYyR04x?=
 =?gb2312?B?V0cxaUhLT3hRY1h6QTRrUWx1WExIV2NIMjQ4MVNSUUY2eml6NDB2dElvbkZU?=
 =?gb2312?B?aHF1VjBzcWpFU2ZyUUcrS2lKVkx0dExveDY4cnpXaUVhRnNoc2NhMmFjSEg5?=
 =?gb2312?B?bVZKNVgycmhLVXdDbCtUYmxXWXpsMDVhckRyQmZvTkU4SWtMZ1gyR2pvNEpZ?=
 =?gb2312?B?bTM3bmRMTnlKZVRieXZvb05HRFdqYlVZcXhWNCtzeFVGbUQvemw3L3VQTEtl?=
 =?gb2312?B?MU9hbWc1NDBhN3dOR2dYVXFxWTExZjZoWWNQVXRGeUgxYVBMbGgzYUVzbkVF?=
 =?gb2312?B?QWl5VXI2VnpoejBoM3owcFMwUWpUemw3c1ZTZmpmMThMWnNJbkFLSlg3T1BQ?=
 =?gb2312?B?K3ZxSVd6UStvMDFZVWtqTDV5R0wxOGdWSkxudlNtZC9KcHQxNnUvWFVBMiti?=
 =?gb2312?B?Q01CKzI4N0E3a3B0YldQVE5maXNSbWkwU1dSeTVCbmovVjgzMmk1OERBOVpW?=
 =?gb2312?B?UjRMVndvYzIxaTgrVU5Vc0JQcEIxTWlxSVBVNGE2K1kyaEJyNVdveFpydmk4?=
 =?gb2312?B?elJ0d0ZheHp4ZEowc0g1OWJUV3pUOG0yZU52c0VKUWhTb2tnemt4dUQ1aUZX?=
 =?gb2312?B?Q0FZTEgwV1pHQUtBTlE1KzlYOWNQaU5wYlIwazEvZlo1NElWbnl5RVM1dllE?=
 =?gb2312?B?c0dWd3h3NWtub2RWTFpNa2pJTkR0MFNhQlNMY1JDeXdiOEtObWozbk9UQk01?=
 =?gb2312?B?SHVoYWxFaUVBYzdaYmsvK1ZrbVYxWDFvMGp5UU9EWXdBb21wSWxpeVA1Ry8r?=
 =?gb2312?B?TWRpMWZRRlZwUWp3NTNIeTNYOUpvU09wWHFmRTArc1RHMnptZmN1OEIyUkxs?=
 =?gb2312?B?TWlTSU1PRWtzMldydkN4U0pNSnhEZmJZaEwwdWdDQ3lWTUFjZDJzSytaVG9z?=
 =?gb2312?B?T1R2ajIvTEdXNzFWaS9NcThFYi9YNDJCN2czMk9WS1JGTU95VjBXRnN0VFBn?=
 =?gb2312?B?emxqcCtiSEN3Q1lXSkMxUmZqQVBieXRpQW9ZcG84aGFpVUFlcFY5ckVkRDEv?=
 =?gb2312?B?MVE1cWx6ZHpxWXpISXlxanpMSkFZWWpsUzhpbmg1akxBQnZWVUhHY1d0L25z?=
 =?gb2312?B?cUZGNHdjU3d3S01MVnpHVmJjWFpybzFDYk1jak9uZGQvZkZtVlRDbkJUK0dx?=
 =?gb2312?B?d0IxbkF4ZFNIZEJrV2VqSzVEN29PUkhJODNOTjdITG9nSTY2NkRDblZNamVy?=
 =?gb2312?B?NTR1alpMQ09obHB0QS9sQVJIRmFMZFpOd2tabnlzQkZRbnRFWEZUNFRIblRi?=
 =?gb2312?B?OTRyNlhrdmcxTkd0bllhV1lpdUVXVWlZam9rMWdJemcxQUx5WnI1MUxKczNP?=
 =?gb2312?B?UnFPQTcvVzhlWTdHSmg3TEpURmFlQW5XOUJDcjJySEp0MG5CTEFoU01XUkNO?=
 =?gb2312?B?WmFDVUtwMVVFRXozR0JCV1U1Q3RBQkNhYUZhT1hmT0VRblZ5S3JwT2tvTWhL?=
 =?gb2312?B?K09MYXM1WnhQUkhJYVpSRnJPbDVBQ1M0VFVXSC84UEwwRTk0L2RhN2xOL0Zz?=
 =?gb2312?B?SEZ4aGJsZWxhMUE3ZjE2RmZWajk1aVdzeERITE1WS2hjNTNTTVR4bE1iRDVi?=
 =?gb2312?B?YmZDQzAvR1VHelFkNWFIOG13cXNrYmJiZFR1S1g1NFFtMEhjZGtkTXFzYWZ2?=
 =?gb2312?B?U3pHcmRhcFRFZWFKVmRLOXZLbFBnOGZSVS82RXV0N21qdGVRUG55Vkd3OFUz?=
 =?gb2312?B?TjlhUXBHQkxMRTNibUdwOXVZYjAyZlJqRXRoUzd3b3E1NHBEMzJHbDFhMUVw?=
 =?gb2312?B?UEhGK3pCVzBPRENZTVppc2RXNGU5TUFjdEhhN2dnRk9KKzZDN3g5aHRseHUz?=
 =?gb2312?B?Z2VidGE2NHVDMHE4M0JNRG85dTlKbFhMNVFHNWI5QzgzWm14TFN4RDgveFdM?=
 =?gb2312?B?MzMzQ1ZCNmlSa0ZCMDhWWGlBZHlvQzhoRmNjNDQ4ejIyTmNpdnZZTWtNZHhY?=
 =?gb2312?Q?OY2tIAh1ElM6++1acNWA1YBJt?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c56ebe0-2b8e-4631-29fc-08daf1e65902
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 02:08:06.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sp05S2yihV5UGPJsjgww0w7DsnvOYSjkFjfTpK3n9I9XqIerQDgvrIDgIaXkkajgQ8yaU9HCJ+iER8sCLL34w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7854
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8
bHBpZXJhbGlzaUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOoxMtTCMzDI1SAyMzowNg0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb20NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgN
Cj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IGlt
eDY6IFNhdmUgYW5kIHJlc3RvcmUgTVNJIGNvbnRyb2wgb2YgUkMgaW4NCj4gc3VzcGVuZCBhbmQg
cmVzdW1lDQo+IA0KPiBPbiBUaHUsIERlYyAwOCwgMjAyMiBhdCAwMjowNTozNFBNICswODAwLCBS
aWNoYXJkIFpodSB3cm90ZToNCj4gPiBUaGUgTVNJIEVuYWJsZSBiaXQgY29udHJvbHMgZGVsaXZl
cnkgb2YgTVNJIGludGVycnVwdHMgZnJvbSBjb21wb25lbnRzDQo+ID4gYmVsb3cgdGhlIFJvb3Qg
UG9ydC4gVGhpcyBiaXQgbWlnaHQgbG9zdCBkdXJpbmcgdGhlIHN1c3BlbmQsIHNob3VsZCBiZQ0K
PiA+IHJlLXN0b3JlZCBkdXJpbmcgcmVzdW1lLg0KPiA+DQo+ID4gU2F2ZSB0aGUgTVNJIGNvbnRy
b2wgZHVyaW5nIHN1c3BlbmQsIGFuZCByZXN0b3JlIGl0IGluIHJlc3VtZS4NCj4gDQo+IEkgYmVs
aWV2ZSB0aGF0IHdoYXQgTHVjYXMgYW5kIEJqb3JuIGFza2VkIG9uIHYxIGlzIHN0aWxsIG5vdCBh
bnN3ZXJlZC4NCj4gDQo+IFRoZSByb290IHBvcnQgaXMgYSBQQ0kgZGV2aWNlLCB3aHkgZG8gd2Ug
bmVlZCB0byBzYXZlIGFuZCByZXN0b3JlIHRoZSBNU0kgY2FwDQo+IG9uIHRvcCBvZiB3aGF0IFBD
SSBjb3JlIGFscmVhZHkgZG9lcyA/IFRoZSBSUCBzaG91bGQgYmUgZW51bWVyYXRlZCBhcyBhIFBD
SQ0KPiBkZXZpY2UgYW5kIHRoZXJlZm9yZSBJIGV4cGVjdCB0aGUgTVNJIGNhcCB0byBiZSBzYXZl
ZC9yZXN0b3JlZCBpbiB0aGUNCj4gc3VzcGVuZC9yZXN1bWUgZXhlY3V0aW9uLg0KPiANCj4gSSBk
b24ndCB0aGluayB0aGVyZSBpcyBhbnl0aGluZyBpTVg2IHNwZWNpZmljIGluIHRoaXMuDQpIaSBM
b3JlbnpvOg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KU29ycnkgdG8gcmVwbHkgbGF0ZSwg
c2luY2UgSSBnb3QgYSBoaWdoIGZldmVyIGluIHRoZSBwYXN0IGRheXMuDQoNCkJhc2VkIG9uIGku
TVg2UVAgU0FCUkVTRCBib2FyZCBhbmQgWEhDSSBQQ0llMlVTQjMuMCBkZXZpY2UsIHRoZSBNU0kg
Y2FwDQogc2F2ZS9yZXN0b3JlIG9mIFBDSSBjb3JlIGlzIG5vdCBleGVjdXRlZChkZXYtPm1zaV9l
bmFibGVkIGlzIHplcm8pDQogZHVyaW5nIG15IHN1c3BlbmQvcmVzdW1lIHRlc3RzLg0KDQpJdCBz
ZWVtcyB0aGF0IHNvbWUgZGV2aWNlIG1pZ2h0IHNodXRkb3duIG1zaSB3aGVuIGRvIHRoZSBzdXNw
ZW5kIG9wZXJhdGlvbnMuDQo+IA0KPiBXb3VsZCB5b3UgbWluZCBpbnZlc3RpZ2F0aW5nIGl0IHBs
ZWFzZSA/DQpTdXJlLCBJIGRpZCBmdXJ0aGVyIGludmVzdGlnYXRpb24gb24gaS5NWDZRUCBwbGF0
Zm9ybS4NClRoZSBNU0lfRU4gYml0IG9mIFJDIE1TSSBjYXBhYmlsaXR5IHdvdWxkIGJlIGNsZWFy
ZWQgdG8gemVybywgd2hlbg0KIFBDSUVfUkVTRVQoQklUMjkgb2YgSU9NVVhDX0dQUjEpIGlzIHRv
Z2dsZWQgKGFzc2VydGlvbiAxYicxLA0KIHRoZW4gZGUtYXNzZXJ0aW9uIDFiJzApLg0KDQpWZXJp
ZmljYXRpb24gc3RlcHM6DQpNU0lfRU4gb2YgUkMgaXMgc2V0IHRvIDFiJzEgd2hlbiBzeXN0ZW0g
aXMgYm9vdCB1cC4NCiAuL21lbXRvb2wgMWZmYzA1MCAxDQoweDAxRkZDMDUwOiAgMDEwMTcwMDUN
Cg0KVG9nZ2xlIFBDSWUgcmVzZXQgb2YgaS5NWDZRUC4NCnJvb3RAaW14NnFwZGxzb2xveDp+IyAu
L21lbXRvb2wgMjBlMDAwND02ODY5MTAwNQ0KV3JpdGluZyAzMi1iaXQgdmFsdWUgMHg2ODY5MTAw
NSB0byBhZGRyZXNzIDB4MDIwRTAwMDQNCnJvb3RAaW14NnFwZGxzb2xveDp+IyAuL21lbXRvb2wg
MjBlMDAwND00ODY5MTAwNQ0KV3JpdGluZyAzMi1iaXQgdmFsdWUgMHg0ODY5MTAwNSB0byBhZGRy
ZXNzIDB4MDIwRTAwMDQNCg0KVGhlIE1TSV9FTiBiaXQgb2YgUkMgaGFkIGJlZW4gY2xlYXJlZCB0
byAxYicwLg0KLi9tZW10b29sIDFmZmMwNTAgMQ0KMHgwMUZGQzA1MDogIDAxODA3MDA1DQoNClRo
aXMgaXMgd2h5IEkgdXNlZCB0byByZXBseSB0byBCam9ybiB0aGUgTVNJX0VOIG9mIFJDIGlzIGNs
ZWFyZWQgd2hlbg0KIFJFU0VUcyBhcmUgdG9nZ2xlZCBkdXJpbmcgdGhlIGlteDZfcGNpZV9ob3N0
X2luaXQoKSBpbg0KIGlteDZfcGNpZV9yZXN1bWVfbm9pcnEoKSBjYWxsYmFjay4NCg0KQmVzdCBS
ZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gTG9yZW56bw0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdl
cyB2MS0tPnYyOg0KPiA+IE5ldyBjcmVhdGUgb25lIHNhdmUvcmVzdG9yZSBmdW5jdGlvbiwgdXNl
ZCBzYXZlIHRoZSBzZXR0aW5nIGluIHN1c3BlbmQNCj4gPiBhbmQgcmVzdG9yZSB0aGUgY29uZmln
dXJhdGlvbiBpbiByZXN1bWUuDQo+ID4gdjENCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjDQo+ID4NCj4gaHdv
cmsua2VybmVsLm9yZyUyRnByb2plY3QlMkZsaW51eC1wY2klMkZwYXRjaCUyRjE2NjcyODk1OTUt
MTI0NDAtMS1nDQo+IGkNCj4gPg0KPiB0LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1JTQwbnhwLmNv
bSUyRiZkYXRhPTA1JTdDMDElN0Nob25neGluZy56aHUNCj4gJTQwbg0KPiA+DQo+IHhwLmNvbSU3
QzNhZWIxZDEyOGY4NTRkYWQxYTU2MDhkYWVhNzc3MDZkJTdDNjg2ZWExZDNiYzJiNGM2ZmE5Mg0K
PiBjZDk5YzVjDQo+ID4NCj4gMzAxNjM1JTdDMCU3QzAlN0M2MzgwODAwOTU5NTQ4ODEzNzQlN0NV
bmtub3duJTdDVFdGcGJHWnNiMw0KPiBkOGV5SldJam9pTUMNCj4gPg0KPiA0d0xqQXdNREFpTENK
UUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlDQo+IDdD
JTdDJQ0KPiA+DQo+IDdDJnNkYXRhPVY4eVZ2dnBUS0dvUjFVeVFQNUhEMklkbFNqSmR6bkJlRDEy
YmRJNjdkRUklM0QmcmVzZXJ2ZWQ9DQo+IDANCj4gPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggMWRkZTVjNTc5ZWRjLi5h
YTMwOTY4OTBjM2IgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gPiBAQCAtNzYsNiArNzYsNyBAQCBzdHJ1Y3QgaW14Nl9wY2llIHsNCj4gPiAgCXN0cnVj
dCBjbGsJCSpwY2llOw0KPiA+ICAJc3RydWN0IGNsawkJKnBjaWVfYXV4Ow0KPiA+ICAJc3RydWN0
IHJlZ21hcAkJKmlvbXV4Y19ncHI7DQo+ID4gKwl1MTYJCQltc2lfY3RybDsNCj4gPiAgCXUzMgkJ
CWNvbnRyb2xsZXJfaWQ7DQo+ID4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbAkqcGNpZXBoeV9yZXNl
dDsNCj4gPiAgCXN0cnVjdCByZXNldF9jb250cm9sCSphcHBzX3Jlc2V0Ow0KPiA+IEBAIC0xMDQy
LDYgKzEwNDMsMjYgQEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX3BtX3R1cm5vZmYoc3RydWN0DQo+
IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJdXNsZWVwX3JhbmdlKDEwMDAsIDEwMDAwKTsN
Cj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGlteDZfcGNpZV9tc2lfc2F2ZV9yZXN0b3Jl
KHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSwNCj4gPiArYm9vbCBzYXZlKSB7DQo+ID4gKwl1
OCBvZmZzZXQ7DQo+ID4gKwl1MTYgdmFsOw0KPiA+ICsJc3RydWN0IGR3X3BjaWUgKnBjaSA9IGlt
eDZfcGNpZS0+cGNpOw0KPiA+ICsNCj4gPiArCWlmIChwY2lfbXNpX2VuYWJsZWQoKSkgew0KPiA+
ICsJCW9mZnNldCA9IGR3X3BjaWVfZmluZF9jYXBhYmlsaXR5KHBjaSwgUENJX0NBUF9JRF9NU0kp
Ow0KPiA+ICsJCWlmIChzYXZlKSB7DQo+ID4gKwkJCXZhbCA9IGR3X3BjaWVfcmVhZHdfZGJpKHBj
aSwgb2Zmc2V0ICsgUENJX01TSV9GTEFHUyk7DQo+ID4gKwkJCWlteDZfcGNpZS0+bXNpX2N0cmwg
PSB2YWw7DQo+ID4gKwkJfSBlbHNlIHsNCj4gPiArCQkJZHdfcGNpZV9kYmlfcm9fd3JfZW4ocGNp
KTsNCj4gPiArCQkJdmFsID0gaW14Nl9wY2llLT5tc2lfY3RybDsNCj4gPiArCQkJZHdfcGNpZV93
cml0ZXdfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX01TSV9GTEFHUywgdmFsKTsNCj4gPiArCQkJZHdf
cGNpZV9kYmlfcm9fd3JfZGlzKHBjaSk7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICBzdGF0aWMgaW50IGlteDZfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2Ug
KmRldikgIHsNCj4gPiAgCXN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOyBAQCAtMTA1MCw2DQo+ID4gKzEwNzEsNyBAQCBzdGF0aWMgaW50IGlteDZfcGNp
ZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCWlmICghKGlteDZfcGNp
ZS0+ZHJ2ZGF0YS0+ZmxhZ3MgJg0KPiBJTVg2X1BDSUVfRkxBR19TVVBQT1JUU19TVVNQRU5EKSkN
Cj4gPiAgCQlyZXR1cm4gMDsNCj4gPg0KPiA+ICsJaW14Nl9wY2llX21zaV9zYXZlX3Jlc3RvcmUo
aW14Nl9wY2llLCB0cnVlKTsNCj4gPiAgCWlteDZfcGNpZV9wbV90dXJub2ZmKGlteDZfcGNpZSk7
DQo+ID4gIAlpbXg2X3BjaWVfc3RvcF9saW5rKGlteDZfcGNpZS0+cGNpKTsNCj4gPiAgCWlteDZf
cGNpZV9ob3N0X2V4aXQocHApOw0KPiA+IEBAIC0xMDY5LDYgKzEwOTEsNyBAQCBzdGF0aWMgaW50
IGlteDZfcGNpZV9yZXN1bWVfbm9pcnEoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJcmV0
ID0gaW14Nl9wY2llX2hvc3RfaW5pdChwcCk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVy
biByZXQ7DQo+ID4gKwlpbXg2X3BjaWVfbXNpX3NhdmVfcmVzdG9yZShpbXg2X3BjaWUsIGZhbHNl
KTsNCj4gPiAgCWR3X3BjaWVfc2V0dXBfcmMocHApOw0KPiA+DQo+ID4gIAlpZiAoaW14Nl9wY2ll
LT5saW5rX2lzX3VwKQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==
