Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D7A4B02F6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 03:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiBJCCa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 21:02:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiBJCAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 21:00:18 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30051.outbound.protection.outlook.com [40.107.3.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAFE115E;
        Wed,  9 Feb 2022 17:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYxANQSN514SceB8hXzaGbqBGh7XmOxfiup2WkJqgysWpcyqazdF+hWSsbryGAxnu2c45PdMHeK7tfG3PEggAUrMGoJ60bx7GtugtoKpRio/EYK0LehieLfHO/hLQ4O1eBb0qbJscwBxB0CHO2/LxH+MPtjnCrFwCU0+a6Q2iEaDiVxgB+fAiMp9Uvxz5Yx2cMJFStDutxpaiWjcWoOuJG2acnZ/lxqmqMOnCbOsZ0Abfa2cywKkaRDu6tiI83WTXeQSELSQNVheo/Czs1EebYTqs/CDNlKWV8TbooqNupxDuuWtLijgC7uZCPMzMVxlxeZNG6p0LOicvjOBXihxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8Si3gGLeibv1KWhoR4spmUlZ9ZK1lOe2U/iN7BdW1k=;
 b=QsYM22UpwppMofDyIj/DhZzJjfJ0UkVfzPQm/0hMI5a/xnwcQUI9A2wzyZn2/c52Sx9FxJgpRrKYwIBplAdoa5qWvCbuACbygR0huEpB9QZisRvu+VH97B83LLUhO4lsUcMGbY4Tr2BuqujqDmc9TCzKouZL9vu1j0+GepPpSnzSKIsdkh8RntamMmNGZRQUhi6dLgBZCxgErF9OKgVoe5myoDRCFqxr4Xd5Fh+cTxXQjNmSNWRkFc6kgMvQ6gJ2mXWSEMLc2PcEeaO/IbBgKuuIit7H2HmmU+R4ILvWLjQKVCfvNmsEUPZCaRY4OeI3+OXUt5ABzn6aVu7DcQf1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8Si3gGLeibv1KWhoR4spmUlZ9ZK1lOe2U/iN7BdW1k=;
 b=gBuaf44SMYvOhlQljaPWuu7WVqgwVnLF3DRQQMwccPputjf+Z/edF6YiWCOkzzwW1XHy7iP9S4I7sm9A//PkB1Yx0SPJTxdLSAsVVQvx8/RC2xQmI5zL/QGBMh4Wn9cvSU+hEl653usnESW41cMfx3sL1wTUaWxdiZs7LTeWl+4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 01:58:19 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 01:58:19 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Thread-Topic: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Thread-Index: AQHYHYduLICm7+FWyEagAyZved6iF6yK7gKAgAEZ+AA=
Date:   Thu, 10 Feb 2022 01:58:19 +0000
Message-ID: <AS8PR04MB867686E541F5065084153F8E8C2F9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644390156-5940-1-git-send-email-hongxing.zhu@nxp.com>
         <1644390156-5940-2-git-send-email-hongxing.zhu@nxp.com>
 <48735d86d0685a0c94e74481ed5fdf6fe66da8be.camel@pengutronix.de>
In-Reply-To: <48735d86d0685a0c94e74481ed5fdf6fe66da8be.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95c9884c-62c9-485a-9c3b-08d9ec38cf6c
x-ms-traffictypediagnostic: DBAPR04MB7238:EE_
x-microsoft-antispam-prvs: <DBAPR04MB7238C94DC985AB9FD0628F588C2F9@DBAPR04MB7238.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:248;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUJZsVmdERVf/PEpExE3QuinhNk2SztyXs18TpDNKIj226GCxZoqfcuKmvbVeqsct4gq8W+JF/HZ4wblKo+haXmjWkopabBA+Nxv0L5kELnHyc39yyQzihXDyZi1DrKNh4uoglaJgpecKTFMm1o5JcVZ6phx/qjwUwpxyxy6zuBltCT5fXZcJF9qaM8TBdSXXqeEmwEfo2REfrb1SV96J02YdjpcnK/Z6qLM9IMhiJ1MbSyZc5IzAP74cCLD2vrfID27tIe0tZAs5AzDFiiSH0JWWr5xwSXCs/uK4dFgeg6IABd7wh0tcdlQ9YaVarV683qliyFb3KKlxmR5KEavYO7JW+fUyIGEbEgg7hqlyMGBVp5HHFKLauvMVy44C5AgP3APcmTRJ1RlViHH8yPKt1rX4ankZtv1VmuRNnjMPTCwhCMIcpFIxXr0DYcHoxakA0KT6LTjjcK821X6rES7oj6otR9GgCt8qjH8bbW+JLzavOf4Qzwfr1G4YSf9sOR+wTHPtOK/obWGMOuXv7PvsFKj+R3vZb4lNxspbGE9RcPTSihuKqUjdV+MmO+zpyeJQ15bDmdHBA8dEmGCGPV5ILOEsdkJ8Q9MwSi7L9j/sfbejFZowSWQbUltDjee+h2ykDIFgrm7VN27oQ1DXIBg9UHV2WZ51REOhRb/JXAzmOQd85sCnfMEqqlTaqLkdo6dNZQdo1kih3UB/8RezaRXBcL7HVBIzv2VN+yCF7Kv1hM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(86362001)(33656002)(38100700002)(52536014)(71200400001)(8936002)(44832011)(38070700005)(5660300002)(76116006)(2906002)(7696005)(66946007)(110136005)(316002)(54906003)(4326008)(66446008)(66476007)(66556008)(8676002)(64756008)(122000001)(83380400001)(26005)(186003)(6506007)(508600001)(9686003)(53546011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlJOMlhVR3RSRTgvbkQ5NytmY1lyc3lGdDlIR0RvMTNIbi9LVEV6QVdXZk9R?=
 =?utf-8?B?VzZGeDRCQzBZbVJ4a1VPc3pSblZOWnUxTzRuTkpWT2hpOEFhVWdzd3pGMmY4?=
 =?utf-8?B?OFFhYUw1dUpqTmc4NW5Gb2xPZVhYQlNWcWxFTkNjZGVyMEtwUGFzSFRYSTdC?=
 =?utf-8?B?QVdpVzZic0ZIaHN5UVpGV3hteDltZGJ0REExR292T3NBdDdqSHhTOFE4c3JW?=
 =?utf-8?B?N1RJS3d6b01LMnIyMUNTalk4QU5OSEI4dlZnbFZIcGg2U3h1WEpNRzZzNm5i?=
 =?utf-8?B?QU8vM3d3MVZUbTdQRW1jbFdpQkdXblVIdkRjYlNodUhhVURKNGtPMktzTDVu?=
 =?utf-8?B?M0xaQThRVDMwNjZKbDRocGZQWS91bnVxci9EbXZWU0RLVjdoVFN4bmtacWl4?=
 =?utf-8?B?Q2RJRFlPamY3RXBYb2dCZklubXRoZ3owWVcxc2RxRTVjYVJVK1Zwa0dpelBW?=
 =?utf-8?B?RW1TU2J1KzdHcy9uMWV0eE0xbWo1aEJERXg2ZzU3MDRQOWdWOHV1MXhTTmJ4?=
 =?utf-8?B?WWFKVjdhdm5SU0g2QnhwZkY0QmxIOUJxeVpZbzhtNFRXOEQzaGxMb2pqazRE?=
 =?utf-8?B?djUrTTU4SVJLazI0dDBUSnNacHBVOUdRaFFLbzJqY3ozZkdiOWVVSnJpNVFx?=
 =?utf-8?B?UFA2M1pES0NicHV3V3hlR0VFbzhPZEM4bHhvTC8wc3VROXo2dHBVYkRTUDZ3?=
 =?utf-8?B?QmpmZGYySjVOVmU0eXVqRDNRZ0ZuRVNYL0FLeGZOeGpNMy9RTEhTRTBFaGU3?=
 =?utf-8?B?Y3BFdFg3RHB6YitlRmZlODQweWhrNm1CU2pCWndkd3dHU0FvcFFHdlF1MzVt?=
 =?utf-8?B?dmJrTGlFeDFkajF4TVM4MmhHK2VRREVQZjhLNFBjYURJVlRVTWxkQkhEMUpv?=
 =?utf-8?B?dmhmWWF5S00rOU9pZGlHSm9kSDhjT3B0ejBJeTA5Rm5NRU9MMk9VWFNTK0I3?=
 =?utf-8?B?a2xhbVo5MEtxM21YOXRIdGgvK01YUUY1SzZ5VENXS0V2dmo5WE1KZDVsRDhl?=
 =?utf-8?B?dnZOYUJkeU5CL3pPdm1GUXoyWWUrb1J2T09KR2NhZUZ6TXMyRVVDcHBFQ0hh?=
 =?utf-8?B?ajRUSE1hb3ROUEwrNzQrMGI5M0U1VUQzcEdQZ1BSanFtV09vSXdKWEdwdWNQ?=
 =?utf-8?B?TFFpN2NndEd5ak90WStnM3A3VVVnRFVGaTY0ZWhtdFArdXpDZFBnTWhPMWFV?=
 =?utf-8?B?QmZvS04yOUFQTjl3cWlOWktXa3ljZHFwUlR5R1RUd0d3UGlvelRiSFpNbWtm?=
 =?utf-8?B?K25IWWJhY2x2S01mUXpWK2Y4UHVxN2d3K1Q5YnZxZXd0V3VYek0rY2JROE9y?=
 =?utf-8?B?VTZpSWdzVVpNVGRJbWQ5dTdJaWpTaG9iMlJqRmhVNVU1dGNRWDZHY21LM2ZJ?=
 =?utf-8?B?TGNiazdEMGtxd1N0OWlyZFpUaTVBMGVKTDJLQ0JWK3JUZ2dzdHRKcDdORGdK?=
 =?utf-8?B?VkE5N1dQUFZESlNGUjFrd0NFbFFhNVduckpEdlZkOUFvWUxPVGFDY3JzVW80?=
 =?utf-8?B?MlBPQ0tqdWx0K2hkaTJQOEs0VTlxVXFJV2lKU3dybGJLaHVoMSsyaXJ6RFNG?=
 =?utf-8?B?dVVNZWMrUmkzUVVPY0s4Mjc1b1d1c3ZzS3dOd1dxcGhlRFEwSzdLb2ZCRnJR?=
 =?utf-8?B?QW56YzhNQTZmcHVSUC91dUtwSVVnNStSenhnOUV1dCtINVYxSmg1YkpLbC9t?=
 =?utf-8?B?SXI4OUxZNDFVVEdkai80czkyTnpSdUI0eHhkNlYzSzhoZnVTcHA2ZkRzR2Fh?=
 =?utf-8?B?emt0d05vSGpzUHJnVWo5ejlmWlE0d25mMDJKQkJLZkY5eEdiUzhuN3ExdWRq?=
 =?utf-8?B?RHRLNTllTlNlMFdRZVlUY05aMDU4aURpN0s4ajVXMThJRTY3YVcxaWdqU1VN?=
 =?utf-8?B?SVIwSnNxWllXTTJHS0EybUp2UHl6RzErS1JRZkRvNWFUbUFybm44eU5TUUxC?=
 =?utf-8?B?cEZHZTQzcnlrUGxhQlBBWUliNy9XSkEzT2Jqa3JYVS9PaVFFdmRNMjV0c0xT?=
 =?utf-8?B?a3pkd3lXQ2tWNjZvMSt0Z1h5Q2tQMjJRVVcvZ2xlS2NaZCtta1B6MnJwOTB3?=
 =?utf-8?B?NEJsQzZUbjhqRGxXblBYaU1rMDVYTk85amFUdy9SOHpvUGkvTllLTXEzRmZt?=
 =?utf-8?B?RGZLZDczYjV2NFdXNS9YbkM5TWRRZGM1cXpEKzYxdCswbTNLNGRRUXUwYTNM?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c9884c-62c9-485a-9c3b-08d9ec38cf6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 01:58:19.1024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zM9S8HYnigIsKXhi4yYW0gEKH6WVem2xymECIRqISxni1sk5p4z/qKn1ezJ0Yh55x0LWXLrWOlhUJUyFOkxcFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDLmnIg55pelIDE3OjA4DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPiBDYzog
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUkZDIDIvMl0gUENJOiBpbXg2OiBFbmFibGUgaW14NnFwIHBjaWUgcG93ZXIgbWFuYWdlbWVu
dA0KPiBzdXBwb3J0DQo+IA0KPiBzL3BjaWUvUENJZS8gYW5kIG1heWJlIHMvaW14NnFwL2kuTVg2
UVAvIGluIHRoZSBzdWJqZWN0Lg0KVGhhbmtzLCB3b3VsZCBiZSBjaGFuZ2VkIGxhdGVyLg0KDQo+
IA0KPiBBbSBNaXR0d29jaCwgZGVtIDA5LjAyLjIwMjIgdW0gMTU6MDIgKzA4MDAgc2NocmllYiBS
aWNoYXJkIFpodToNCj4gPiBpLk1YNlFQIFBDSWUgc3VwcG9ydHMgdGhlIFJFU0VUIGxvZ2ljLCB0
aHVzIGl0IGNhbiBzdXBwb3J0IHRoZSBMMiBleGl0DQo+ID4gYnkgdGhlIHJlc2V0IG1lY2hhbmlz
bS4NCj4gPiBFbmFibGUgdGhlIGkuTVg2UVAgUENJZSBzdXNwZW5kL3Jlc3VtZSBvcGVyYXRpb25z
IHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+IA0KPiBPdGhlciB0aGFuIHRoZSBuaXRwaWNrOg0KPiBSZXZpZXdlZC1i
eTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQoNClRoYW5rcy4NCkJlc3Qg
UmVnYXJkcw0KUmljaGFyZCBaaHU+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jIHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggNzg0ODAxZjJmOWU2Li42MjI2MjQ4MzQ3MGEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtOTk1
LDYgKzk5NSw3IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9wbV90dXJub2ZmKHN0cnVjdCBpbXg2
X3BjaWUNCj4gKmlteDZfcGNpZSkNCj4gPiAgCS8qIE90aGVycyBwb2tlIGRpcmVjdGx5IGF0IElP
TVVYQyByZWdpc3RlcnMgKi8NCj4gPiAgCXN3aXRjaCAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJp
YW50KSB7DQo+ID4gIAljYXNlIElNWDZTWDoNCj4gPiArCWNhc2UgSU1YNlFQOg0KPiA+ICAJCXJl
Z21hcF91cGRhdGVfYml0cyhpbXg2X3BjaWUtPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIxMiwNCj4g
PiAgCQkJCUlNWDZTWF9HUFIxMl9QQ0lFX1BNX1RVUk5fT0ZGLA0KPiA+ICAJCQkJSU1YNlNYX0dQ
UjEyX1BDSUVfUE1fVFVSTl9PRkYpOw0KPiA+IEBAIC0xMzA3LDcgKzEzMDgsOCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGlteDZfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9DQo+IHsNCj4gPiAgCVtJ
TVg2UVBdID0gew0KPiA+ICAJCS52YXJpYW50ID0gSU1YNlFQLA0KPiA+ICAJCS5mbGFncyA9IElN
WDZfUENJRV9GTEFHX0lNWDZfUEhZIHwNCj4gPiAtCQkJIElNWDZfUENJRV9GTEFHX0lNWDZfU1BF
RURfQ0hBTkdFLA0KPiA+ICsJCQkgSU1YNl9QQ0lFX0ZMQUdfSU1YNl9TUEVFRF9DSEFOR0UgfA0K
PiA+ICsJCQkgSU1YNl9QQ0lFX0ZMQUdfU1VQUE9SVFNfU1VTUEVORCwNCj4gPiAgCQkuZGJpX2xl
bmd0aCA9IDB4MjAwLA0KPiA+ICAJfSwNCj4gPiAgCVtJTVg3RF0gPSB7DQo+IA0KDQo=
