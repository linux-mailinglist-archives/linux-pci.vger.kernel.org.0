Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA764C2184
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 03:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiBXCE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 21:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiBXCE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 21:04:57 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00076.outbound.protection.outlook.com [40.107.0.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B08327145;
        Wed, 23 Feb 2022 18:04:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jamu2WI1v/ZxLqp9AVaDE8rUon3JREFdSKXwnkecAB8NIRoBoOhLVo7X9lpwJVxnbPwwlGDSSuAGyRmpJ4KggbTH3bFEqDcZnkh8TaE2k9wGyYxc1Q/7jLRhgdGQ8KU/jZVwrcxantl3h+cGUbNcaRO+JAtsU7EHJEDuPB+1fAH0qeyku9ADhbBNtqoKuPjUdM53ei13ywgySR8wLjjQT6M94Zu/ymDYHa9+a+ezCdYzn+Orp1BG2S/+MIKudpWUTuSNKsrrXaJlbF/nIyBn8NjlLETSJepkfHpVPyMRDx6NU1+PhKegdUo+7VMaptxwW0Op63ZlHpC1KN/ghAOg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOYjDKBW08SLtwrL+AeCNnCnr5Nlb8e7+0kJmHj3spY=;
 b=oRaUxp4/aa0YlRrjmaFqfUlaYgKVSu5YqGrgqKG0oS4ChR8oqAWyyQB4mRF+rtQrjBNk/1DM/hxor5TIT4d6v4IBr8c64alaazvzdE+ZmJfOYq9y0RROGeMP4ctUsraCEpHu9K9mRpN/8oAXwNRRUYFbCn2lGvJVaV1g9QvMmG8iEViQcSy9sHu17kbbiQaKeNagJtAsxoVkgpprWFSMxX3F11tk+GQmqrflYklAq3wKW94UfFr23pLV18biNWkpWcHJ1GxmDKc/xpzw55cfbe+Eh0k49chFTtN+OeuWoj8e41Y0C/SBlnrhozqO0SNgIVtamuv6O8dpMeDRxvTX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOYjDKBW08SLtwrL+AeCNnCnr5Nlb8e7+0kJmHj3spY=;
 b=p05fX58bs9daJ1CcMQOoqE9x4pqbZsAvPGKuhgsNZc0leRsg5FhKPdQUBVYb1j5dghWGSZhDI1Uze2bBxovnWUGvGzSkxPhGDyN3d8rfp3eCvl+Ig4Ipe98lBdbSQ41MvntztBkeo1BjIHN24uoqMnajavE4DmONeS9F1g56+QM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB6179.eurprd04.prod.outlook.com (2603:10a6:208:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Thu, 24 Feb
 2022 02:04:26 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 02:04:26 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] PCI: imx6: Override the CLKREQ low in the initialization
Thread-Topic: [PATCH] PCI: imx6: Override the CLKREQ low in the initialization
Thread-Index: AQHYKJHqhuIPnoSLPUKdwKyRzEnN3qyhdiKAgAB50WA=
Date:   Thu, 24 Feb 2022 02:04:25 +0000
Message-ID: <AS8PR04MB8676FFAEF40286DC979FBEAC8C3D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1645605513-7731-1-git-send-email-hongxing.zhu@nxp.com>
 <20220223183157.GA142509@bhelgaas>
In-Reply-To: <20220223183157.GA142509@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 244b410c-d025-42a3-84be-08d9f739fbd8
x-ms-traffictypediagnostic: AM0PR04MB6179:EE_
x-microsoft-antispam-prvs: <AM0PR04MB617921511965252A70049A7C8C3D9@AM0PR04MB6179.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fkXZ1HpH0IBq6w7Lv1RHB48cqvs7oowhU0Ebzb7EBn2Xn1eOhS4KAj9OK55QKKzGj+drKEYoYirZxCV6tdZmMB5iJ1X90uwM/WZRUwnmXjL+PPUz9XV7xAaXMC9DTBUGLI4MTIk/XEfGGMeIpWKH2PKEmxbtrb4i/SQWMJm7ebLvuKGTv0SQyCHY3gu9FZX6LUc4pwXr8Fsj9NsjD41iRlJimxZcb/1FEjeoxHY1As1AaMZ3+WxX0KkHG9iLjEXkIuOKbgHigXLwMIg1pFuBuC5XQnHnJhxH4JX756ef+Zvj3peR2Mw5dsekuraJpWoYZhM3uSFwMmQkTIcqRd65tzHqTJ49RS0uL/PQOi3o5OD6D0KTl/BytlHALAWPukNgZE6YCOHZWvyp1ei2P3iAcSIRdqfTdFNu1MdB6CY1c53WFPfWJb6D4l/d3n41G/CVi9T8frQ160G9jcz/Z5xo4DDMbh07nq5ahHVryxthwDfxBYHGo7iRtkTU0mMoFDV8v7m7QrM4rVnbswYYz1mPM2mubG3/ofKCRGMS3FqB8UOfRjBgM/M9hFsjPgzzAdX02rEPlj6BXqfc8bjR2kKmeDYxO3jWQA0fgD6nxijNYU9ZVB5LUajbgnlDkP7/WKkq332/If7KraSiJ/nRhqwCuUGRGtr/WiSUr8YkvJmqj5ZvkK7JqD5nDOxZMIh5ofjDflU4wkILxEkip9XzTRRvuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(2906002)(38100700002)(38070700005)(86362001)(54906003)(53546011)(122000001)(71200400001)(33656002)(66946007)(9686003)(64756008)(4326008)(76116006)(5660300002)(44832011)(8676002)(52536014)(316002)(186003)(8936002)(508600001)(66476007)(26005)(6506007)(66446008)(7696005)(83380400001)(6916009)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QkN6blB3V2owVGFTalBQMUFNckQ2Rk9yYjREc2pRZWlEKzArN0h0bkZMNnVu?=
 =?gb2312?B?Y1FlMVltVDhYbi9RT2ExOVE3TksyQU1NZWhYNjZ2TGFvUlV0ZUpxMk1qSVVF?=
 =?gb2312?B?OVFYZ0R1ZjJJVjRpU3F6WmdsZnhCcUdlV0VHd1pUdmQ0TzQ0bkhxNWFEc1FY?=
 =?gb2312?B?amlGQjdGbGN1TWtLWTFscXo2ZjhTS3dvR04vOXhzZ2FYOVk3cTdsRkQzQmND?=
 =?gb2312?B?MGdyOW5zOW9UQzVza2w2YitqSmlBK3l0TDBiendQMGpjTVVEUkNoY2IrbHFO?=
 =?gb2312?B?clRZSXFOQkdKV2k1a0xIV0pFaWRINTNoNU94MDd3Wkp4bDJCbTcvSkd4SWpw?=
 =?gb2312?B?RkpuUlFGalM5ZExBa3dTS2x3MTdMYVFxZHhMZUwvVG9lQW9IZVhLYVdYbjZi?=
 =?gb2312?B?LzdHTlVrcEd3NmRBZUxsUVJUbHpIMEpPRTRjKzlVZUpmVTVyNG5KRERORlBT?=
 =?gb2312?B?VTE0amgzcFBUZ2x4ajBIZnRmbmJUblZWTmlFZ3JHMHI0U0ZQNi9xSHo4U05F?=
 =?gb2312?B?bS92UWZ1Y0dCV3pnSEVBN3dacVYrcWd4UGpyaHpOdHMxZVEzTS82Q0w2bjdr?=
 =?gb2312?B?VkZTYnBHd3RaZlQwbkxqdC9GWlBXQzZCUk9nY2c4UUFmbGovcXNvZm0xUU0z?=
 =?gb2312?B?NVQwTHQ3T1l4RVRMZStDa0FLbDBGRzBjTjR0V0lFanJqSW9jeUpneFp0dG5m?=
 =?gb2312?B?Uk9iZy9iVm9ndkNtaWhOeVAreklPT3FRK1lWSDlJOUZTNzNGZUhmeDhUbi92?=
 =?gb2312?B?clRQSVJXQkd2Q0V3Sk05V2UwQ3g2RzVSY1JTc2loQ01IeVNTUFgyaHBPYVBI?=
 =?gb2312?B?SW9kNjdMMzhZRXliRmxMQ1FpbklyTWJuZElLaGZwaFh4bVVHVW5saER2Wi8w?=
 =?gb2312?B?Wmk0bk9KN2Vpd0paNmZtdnVYZzhMTUlvUDhjUklHR1JDS2pBNUZoeGNna0t0?=
 =?gb2312?B?cGZKak9iSEl4cUI3ZGg4M0ZGb1NGOElVSHAwR0ZVNjhlMENoRjFRQXZ0TTJD?=
 =?gb2312?B?UHh3UExzUzFaN0Vvd1djMElOc0JoTWdiSG13TWxoaDJEVWtuUS9rcGNWQVJL?=
 =?gb2312?B?blI2SGFja2E4S28yVml6Y1p0T1gwcjBlRThDZ2Uydm4vMGNXamdPSU81Ri9U?=
 =?gb2312?B?L3IvNnNWWlhoOEJQV1pzQ29HS2tBS09VSzJxOEhsSmpEZ1B6dERRR3hoeTMw?=
 =?gb2312?B?RUVDdW9lcDFtenEvbkFMMmEycGE2TU1CWVcvQ3NSdVlDNjJsb0VtWnVaUGRO?=
 =?gb2312?B?VHRUV05hMGhlNFZBeGMzLzZnQmR1V0FBSkRjOGhLdFZGVGNKZlRoZ0hoWmt5?=
 =?gb2312?B?ZXRuaFJLMmJTcVVRWFN1SVVVdDNPSkd2K1BEbVVQaEp5K3JNZG1sWVBYWHFu?=
 =?gb2312?B?MUVBYS94aXAxVlhVR2tENjV6SWQzeTFPNDFFSXM0R0xReDBWWVpkMVJoV2JR?=
 =?gb2312?B?d1dFTUVnZnZ1MS9QdWJrTzBjTmFucjBIaStiNWpqd2VzZlFsaFlBUUdabTdI?=
 =?gb2312?B?dCtRdlJFS0dUK0k2aDJGdk1pNWxvQXl0dkNQNk5kSkNxcTJjTzlqSDJJb0M3?=
 =?gb2312?B?TEllbHpzbEJLTnREZmFQQXA2WjVSWjlQOVRrcmFHSUcybjJYOFQ0N3Q2OHVU?=
 =?gb2312?B?L2VzcWhVQkVFWUUyR21UMHVid0lRNWQ3Ym1tTmU2U3NYcVptanVnRFFXcEJG?=
 =?gb2312?B?TnFmeDQ0ZkFlckEycWZxdGdZVWR5WDlPTGpVaitRNDhKTS9sSlVTOGU5T3JU?=
 =?gb2312?B?eUZMZEYwdldrUDV5cktVclFhRzBqbnBDcGxJbW5RK0k0MEw0WmkzdXFuUVV6?=
 =?gb2312?B?MllsMlJ1MTlpWVRkd1c3dUZuVytQT1dPajRhMUk5cmRlQnZRalZwZzh0TUEx?=
 =?gb2312?B?eElpenVNTDIvWVdydmJLN3BpUmY4d2o3cXRablNoaG1PMXBvOFJFOG1vcHZU?=
 =?gb2312?B?TXdxZzFLUGRMeXdJdmQ0eUo1a2E5WGVPNlNlSU5TU01sMHRsbk1WaDhEczJk?=
 =?gb2312?B?Y3oyMG9YV0JFa0lRVlNWV3lSTTR2Nkp4SVZuSUdqNnU2UkREQ0NodUdGWDZj?=
 =?gb2312?B?eXNabEpFeTFKNDB3VXl6WFpzWSsxdGdORjFyVzFxaXZIVGNQcWFmeVdRbGp2?=
 =?gb2312?B?SzVOSW9lL1p6cGxSaVd1TXpoUkdBakpWR3ZnRnlRUHcrQ2RLaWh3Qk5qaVZp?=
 =?gb2312?B?S2c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244b410c-d025-42a3-84be-08d9f739fbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 02:04:25.9166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sJOny2iQeUZeMsgvkq7ZoxXv2kiXhbFOEGRxtc5GisuFqT1gnpOG8v/zMrrR4Y0KRrz7n1CjfQte1Xlkn3Lqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6179
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jLUwjI0yNUgMjozMg0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBQQ0k6IGlteDY6IE92ZXJyaWRlIHRoZSBDTEtSRVEgbG93IGluIHRoZSBpbml0aWFs
aXphdGlvbg0KPiANCj4gSW4gc3ViamVjdCwgbWF5YmU6DQo+IA0KPiAgIFBDSTogaW14NjogQXNz
ZXJ0IGkuTVg4TU0gQ0xLUkVRIyBldmVuIGlmIG5vIGRldmljZSBwcmVzZW50DQo+IA0KPiBPbiBX
ZWQsIEZlYiAyMywgMjAyMiBhdCAwNDozODozM1BNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToN
Cj4gPiBUaGUgQ0xLUkVRIyBzaWduYWwgaXMgYW4gb3BlbiBkcmFpbiwgYWN0aXZlIGxvdyBzaWdu
YWwgdGhhdCBpcyBkcml2ZW4NCj4gPiBsb3cgYnkgdGhlIHJlbW90ZSBFbmRwb2ludCBkZXZpY2Uu
IEJ1dCBpdCBtaWdodCBub3QgYmUgZHJpdmVuIGxvdyBpZg0KPiA+IG5vIEVuZHBvaW50IGRldmlj
ZSBpcyBjb25uZWN0ZWQuDQo+ID4NCj4gPiBPbiBpLk1YOE1NIFBDSWUsIHBoeV9pbml0KCkgd291
bGQgYmUgZmFpbGVkIGFuZCBzeXN0ZW0gYm9vdCBoYW5nIGlmDQo+ID4gdGhlIHJlZmVyZW5jZSBj
bG9jayBpcyBub3QgdG9nZ2xlZC4NCj4gDQo+IHMvd291bGQgYmUgZmFpbGVkL21heSBmYWlsLw0K
PiBzL2Jvb3QgaGFuZy9ib290IG1heSBoYW5nLw0KPiBzL2lmIHRoZSByZWZlcmVuY2UgY2xvY2sg
aXMgbm90IHRvZ2dsZWQvaWYgbm8gRW5kcG9pbnQgaXMgY29ubmVjdGVkIHRvIGFzc2VydA0KPiBD
TEtSRVEjLw0KPiANCj4gPiBGb2xsb3cgd2l0aCBpLk1YOE1RIFBDSWUsIHRvIG1ha2Ugc3VyZSB0
aGUgcmVmZXJlbmNlIGNsb2NrIG9uLA0KPiA+IG92ZXJyaWRlIHRoZSBDTEtSRVEjIGxvdyBkdXJp
bmcgaW5pdGlhbGl6YXRpb24gdG8gZml4IHRoaXMgaXNzdWUuDQo+IA0KPiAgIEhhbmRsZSB0aGlz
IGFzIG9uIGkuTVg4TVEsIHdoZXJlIHdlIGV4cGxpY2l0bHkgYXNzZXJ0IENMS1JFUSMgc28gdGhl
DQo+ICAgUEhZIGNhbiBiZSBpbml0aWFsaXplZC4NCj4gDQo+IChJIGRvbid0IHJlYWxseSB1bmRl
cnN0YW5kIHRoZSBoYXJkd2FyZSBoZXJlLCBzbyBkaXNyZWdhcmQgaWYgdGhpcyBkb2Vzbid0IHNh
eQ0KPiB3aGF0IGl0IG5lZWRzIHRvLikNCkhpIEJqb3JuOg0KVGhhbmtzIGEgbG90Lg0KWW91ciBk
ZXNjcmlwdGlvbiBpcyBtdWNoIGJldHRlciB0aGFuIG1pbmUuDQpXb3VsZCBiZSBjaGFuZ2VkIGxh
dGVyLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+ID4gRml4ZXM6IDE3OGUy
NDRjYjZlMiAoIlBDSTogaW14OiBBZGQgdGhlIGlteDhtbSBwY2llIHN1cHBvcnQiKQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDQgLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggZDdmMGRiMDFmM2MzLi5hMzM0MzQx
YTE3ODkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
PiBAQCAtNDQ3LDEwICs0NDcsNiBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9lbmFibGVfcmVmX2Ns
ayhzdHJ1Y3QNCj4gaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4gIAljYXNlIElNWDdEOg0KPiA+
ICAJCWJyZWFrOw0KPiA+ICAJY2FzZSBJTVg4TU06DQo+ID4gLQkJcmV0ID0gY2xrX3ByZXBhcmVf
ZW5hYmxlKGlteDZfcGNpZS0+cGNpZV9hdXgpOw0KPiA+IC0JCWlmIChyZXQpDQo+ID4gLQkJCWRl
dl9lcnIoZGV2LCAidW5hYmxlIHRvIGVuYWJsZSBwY2llX2F1eCBjbG9ja1xuIik7DQo+ID4gLQkJ
YnJlYWs7DQo+ID4gIAljYXNlIElNWDhNUToNCj4gPiAgCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFi
bGUoaW14Nl9wY2llLT5wY2llX2F1eCk7DQo+ID4gIAkJaWYgKHJldCkgew0KPiA+IC0tDQo+ID4g
Mi4yNS4xDQo+ID4NCg==
