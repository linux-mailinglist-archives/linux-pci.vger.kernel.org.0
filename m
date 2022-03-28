Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D742E4E8C62
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 05:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiC1DBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Mar 2022 23:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiC1DBq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2022 23:01:46 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB3DEB0;
        Sun, 27 Mar 2022 20:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4N4buFpg7UJ+vYPsLRmSV0H8n58b/mmUNlTKZ0HGQQgx752k7pOmiCfIbzhEjGTvkFsLzhy6bhnvy2AnbvJXDNxWGfFrgUEACR8zGctbfo5jzuJVDTjJS8Y3+yzQuyr1RPcCmoSBxRez2On5Vvlf+7XnPBIy1C8C6NQsCI1TT8hj4HydL1aQ1GEzobAy6+xaJ5sgb15kkJbR1jytjuGOemLyBxlb1DeE2Sj39gU1UbXDCtPWHKCoEqyQMVQ41Vs9s8ANcfkQnlQ+/qglnhlzs9jfnKOmE3WJkiRGYdAW1ZeBKq6lWEe7H2h449ih7/m292PsMJPpA0kdMOt+lIrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoXwEEoMjkn0ZCP4vaSZGYlJ/6Up3KJoURpjveabXsQ=;
 b=KMcLSAXKdyoDGrI7KO7epHlDRlMfTTMsbr29Fjgo7L74AfFbpc2vAO/wq/TvVENWkFGPnJq/nfNJDJ6sevAki7SR1YH1RLj0cUvBMqkNqmMaR45BC/I8b7yI+9HbPNsCg/bTs82EKWJjYPgShcT4J82wO+C2MHoRh0OZvKfuYNKxARnlrxlubmS1Ue6K5Q0Y3saggVmzX1ZflrY16Ipp/y6yz8ZO+2o2S1t4TUJ54I6myXTJlmmjkb1ZfCTQCPZH1KSJkHEYoMT1POdnowXY+Gj0Y2QPwRBVhAiSgyeoE8M11ZPus+Uc3fqSoj7dbXYeWqeHRnYFSg0a9voUY1XFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoXwEEoMjkn0ZCP4vaSZGYlJ/6Up3KJoURpjveabXsQ=;
 b=TCE0pNycDBHAuRGeH8eyfWZet9nOwiqkZpdtEw/4y7Fu41ARsZk0DCJiYUs8zMz2ZG56FtoBLugnV3YjsKbPrGqpkxiISS3eo+ebWlrkNWcIafLb70L5bMiXK+mg5dO6/0v6Lccrk+/eEnJy7kyLtzQ/GvpJp81Ya0hBxnOp6hk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 03:00:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%9]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 03:00:02 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: (EXT) [PATCH v2 6/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Topic: (EXT) [PATCH v2 6/7] arm64: dts: imx8mp-evk: Add PCIe support
Thread-Index: AQHYMgQOjiRgAbocuEmOYPQXoupihazOaRiAgATDy7A=
Date:   Mon, 28 Mar 2022 03:00:02 +0000
Message-ID: <AS8PR04MB86766AA20CEC9D04EBAE44018C1D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <1646644054-24421-7-git-send-email-hongxing.zhu@nxp.com>
 <2236205.ElGaqSPkdT@steina-w>
In-Reply-To: <2236205.ElGaqSPkdT@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e6e8346-6e9d-4489-ee92-08da10670d83
x-ms-traffictypediagnostic: VI1PR04MB6797:EE_
x-microsoft-antispam-prvs: <VI1PR04MB679767EA39DA5280096907638C1D9@VI1PR04MB6797.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7uWZPoAQCvna/O6PX/ZY+IKMDD0UPph2eVCfyCRuQI1sUAb345HZSFT8juUsym+SolOeH1pOr5MbNT+6ZNsMArt6tVVb6CwO5YK1vD6UMXBfpHzxv2EOVkKPyvNczqvrcYpUO7ieiq2rXlQ/NnFzSmfrb+mSm4qlxyx+jsXuWPc+YLjIBVTVsLwGnBYB5m1SGXKxo6WmnOXAaBuPZPm4Od4LGkNwXFHSeojPPHZsdyg5zHZGEmLvisIgAN95usWz5aIWPWykDKVzOq1SDa/jUApxuxa2lwv6Nl206zxzol14oNxdVDrENMgZGShFNSMrypHBWXsW6ozJgTAVm7Xljkg/z9qIodpc52xpOtPxzP6uoS/Pv1Ks/Syo+ZeWY3womLyBbozhnpk/3GO5jApAZfNLf+xzI3i65ZGnavGyLPQu9Sf9Xt+ETDRl+wjaYVG9uKuiFFiPb+dvrQr5E5h1aZR9zTmCIzgbKly48OGhrm0WpxAqJYi/6hrnamHikUDjihBIT3Tcqf3nOL1mphXF7EmKrOl4QS5Rhtb/6SkUJ8KYpqID7gu0MVRr7S4r6b5hRUZB6UmtPWZC9XDtJv5DDkB/QsjIZ5uaXwlc1m4Mc+hkmIxQuAuBtgZq2Ng0YNJwxMNR0/EmuKMYBplKzLDcaNP1bNuT6bqq66xDkoouVAVc3Md4982lT3NlRG2RuCBnwfRsngM6b2XYzbsspogEfgeV6cec35Bf9merZWQw5gQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(9686003)(7696005)(5660300002)(38070700005)(4326008)(2906002)(33656002)(52536014)(83380400001)(38100700002)(53546011)(6506007)(55016003)(7416002)(54906003)(44832011)(110136005)(8936002)(122000001)(26005)(508600001)(66574015)(86362001)(316002)(76116006)(186003)(66476007)(66946007)(8676002)(66556008)(64756008)(66446008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkdjRmdna0VtalZBKzNqb0c3SGRKL0ZxTVNOd01iMlZ1S0g3S0ZvMzVGS25C?=
 =?utf-8?B?MjVBVUVIM1JlWi84V1JCdDNZcUozeFNPa1Y2azJENmMxdWg4L1NJcUlxMVd2?=
 =?utf-8?B?eDhZUGc2V01SQUExbUZRZlNUNzBveFU2ZlFVdHhEanNVNFBVZTJBaFJVU0Fn?=
 =?utf-8?B?eENyRXhoaUNmcFFSdzdYRUtEcHBzSnJOUFc2MGdBeFJpb2l3OFowdXhQWHMz?=
 =?utf-8?B?QmVZQkhyKzVWUzhUbm4ycWplaW9RRHJPT3BJVjlzdmQ2bG5XMmhUdjNnZ2V2?=
 =?utf-8?B?TzJHaXJHN0RLQjJET0x5RkltcGdZMHNBOEUveU5zbmhqNml5SytmWGZ6NWdm?=
 =?utf-8?B?ZVhEN0tVSGVpeFJzbW5sV3RPSk9ORHdNZy9paU9aM2YzRDhDZXZnRTloRlFV?=
 =?utf-8?B?WkI4ZUFEbXpuSy9RbnlQWjhFQjV1OUQyN3Z1MzJwWDhyTVBHbTNtT3ZjYTdV?=
 =?utf-8?B?UWoya1lRTEQ1VmtlMFh1cmVqVnJFS29PdXRGeHJ0UlRZT1J1b1JETXQ4c2ph?=
 =?utf-8?B?UDVIeWNMWVpkcnNOS3JLWmkxQUthZjI2R1JzSytzS0wrSWprUUwySXMrSkhN?=
 =?utf-8?B?cVFqcnZ0TzdVMUxhblRzZ1pZZ05uWW0wcW0vWkZSUHc4ckRjU3lUZXd1dzla?=
 =?utf-8?B?K2ZKL3hSUzBaTlhxSjd0M3BNNDgvdnoyMjZvNnNSYXFjS081aDFFMnpITUxL?=
 =?utf-8?B?M0F5NlU2Rk1UejJLTzdpMkNYQ21GVmFmYkpCNVAyZEZqSUdoaHBBVXZ2VURP?=
 =?utf-8?B?ekZTTmNBL0YvMUpjcDJDaEJ3OXhOaFlYV1N2QlYyQ2oxclJlWEpEcWdwcUJK?=
 =?utf-8?B?enJCRnFKdjRBcGNPRVZOTHBSM3ExUndGTVVXcDJLOEYvaVdLdHFIKytxNU0w?=
 =?utf-8?B?Tnd1UXlOeUJqeW5yNytUdDI5SkdraTNvTXZFZFNrZkxoNW9YWmRScW45dEVC?=
 =?utf-8?B?c2RUU3d0cUFkU0RjZUpxVldhNXJ0bmhzVDB4ZTFzczBkblcyaU9oOC9jUjhs?=
 =?utf-8?B?ZkJmajVRREs4eFM3OEZYWndjbFgxNllMZ0EyUXdCUUF5cVVQaXRuRGZjTjJw?=
 =?utf-8?B?TllhYVM0TUVTR2lpaTRCY3VTK3RuNTFjZmQxNHFEcm4vK056TGFkTGFEWS9T?=
 =?utf-8?B?Zm95M0xFa0s1YnNTZDlIaXdjZHBMNTVLMW5kWW9ycHlyY0t4WVlla3FDazFS?=
 =?utf-8?B?UThqa1EwTStxTFBSTmwxTTdJSVVhaWVRb2pxMjUvSytnYmFnK1VIa0p1UUtM?=
 =?utf-8?B?SXY3YmJIaEdkUmhVczVneEs1U3gyVlUwOHNyWGxOZktpYndmcHpNdXY4OUUz?=
 =?utf-8?B?cWxMQlNpZUVtaEMwblJpaWt4Mm13QVJldjkvalNydWpXWmg4OUdKaUVabmZz?=
 =?utf-8?B?TmJUZUdGdFhYZkszM29QMDhWd0lNVGJXZmNBU1E1YWM0bG5NaGJ1TVkwTXpk?=
 =?utf-8?B?TjFpQjlGYUlUTkFkc3ZCSjZIZ3BMZ01ranl1WkZENU1kSjlYRzQxWWpIT2Ew?=
 =?utf-8?B?UG4vY0ptV1BXNFk0K1BCRnMwY2tud1JFR3BHS2pKS2Q1YW05dG5sZDB5cG1o?=
 =?utf-8?B?RlBld1FMc3R3TW1UbHlmbnBpWnBoSFUyeTB4UnNWOW5pdFJvMWFzSXBhd1Vw?=
 =?utf-8?B?bzZFdTR0dHN1Zm9Oblg3TU90VG16cktWcVBXWHE0L0p2MXNlZ1ViQXQ4SWFM?=
 =?utf-8?B?dzREUXJiWnljN2hMczNnVk9hTUM0YnNnRlhHb2sxRlNIR0ZNWWVDZUJOYUxZ?=
 =?utf-8?B?SG10QTcvdUVMSTZhTTZxUWFMMi9GNXczdTk0TEtFV0lGQXE3NDQwYXJPVjlD?=
 =?utf-8?B?Q2dmODBxVzNHZjByQTJ3K2RlQ0M2UG93Q1FRWXQ4Z1lFdGYvdS95bVJObStB?=
 =?utf-8?B?cEF6YTRJeTRhODdQSVdjSW9ualhKOVorWW5QRGxmdTlXUElaTG1IRmZET2NC?=
 =?utf-8?B?NW1ndy8wSEpwU1Z6ejJHRXRzelNtSTRIL0dZSDg0emZ0TzRCbXQ3emxMRzVR?=
 =?utf-8?B?dzBPUEg0Um5aUHc2RFhCVVV6ZVVibVRVQVJBcDFQNmhSaCtzYTk5OVhmaHo0?=
 =?utf-8?B?K21aUnFQeUdFcmhxWi9KSDllZVBYVE10aUt4a1ZpTUVoVldxQzg2aEZCd2or?=
 =?utf-8?B?MWVPRjhQYXBXSXJhMzhTdktaZ1RDb2grbGU4c2d4ODR2S3JBZlFYMGpURnJn?=
 =?utf-8?B?WndEaFFIbHBQN1NHeUtRbkRDK04yVU5sSit4V1JRSTJEY1dlZXZBTmlzeDVR?=
 =?utf-8?B?SVpZN3k2S214MFU3anFuL08vVXdSRFl1ZEFPTDE2Y09YLytITFBBbHJZNDl3?=
 =?utf-8?B?cnB0ejE1YjlrZlFlck9nVHRBTVNJTEpiYmVDREcvN0k5WFBYNHZXQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6e8346-6e9d-4489-ee92-08da10670d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 03:00:02.0304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73yT3gGV+xy6wABfvRrLdv2nm6i/ryJlcyuPLrw96t74RICdpjznAZ3ruP35QF3/9GA+RVMTBGKOVsrpa8pBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgU3RlaW4gPGFs
ZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb20+DQo+IFNlbnQ6IDIwMjLlubQz5pyIMjTml6Ug
MTg6MDUNCj4gVG86IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJv
YmhAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gdmtvdWxAa2VybmVsLm9yZzsg
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBoeUBsaXN0
cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRs
LWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBIb25neGluZyBaaHUgPGhvbmd4aW5n
LnpodUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogKEVYVCkgW1BBVENIIHYyIDYvN10gYXJtNjQ6
IGR0czogaW14OG1wLWV2azogQWRkIFBDSWUgc3VwcG9ydA0KPiANCj4gSGVsbG8gUmljaGFyZCwN
Cj4gDQo+IHRoYW5rcyBmb3IgcHJvdmlkaW5nIFBDSWUgc3VwcG9ydCBmb3IgaU1YOE1QLg0KPiAN
Cj4gQW0gTW9udGFnLCA3LiBNw6RyeiAyMDIyLCAxMDowNzozMyBDRVQgc2NocmllYiBSaWNoYXJk
IFpodToNCj4gPiBBZGQgUENJZSBzdXBwb3J0IG9uIGkuTVg4TVAgRVZLIGJvYXJkLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0cyB8
IDU1DQo+ID4gKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDU1IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXAtZXZrLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLWV2ay5kdHMgaW5kZXgNCj4gPiAyZWI5NDMyMTA2NzguLmVkNzc0NTVhM2Y3MyAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZr
LmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsu
ZHRzDQo+ID4gQEAgLTUsNiArNSw3IEBADQo+ID4NCj4gPiAgL2R0cy12MS87DQo+ID4NCj4gPiAr
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BoeS9waHktaW14OC1wY2llLmg+DQo+ID4gICNpbmNsdWRl
ICJpbXg4bXAuZHRzaSINCj4gPg0KPiA+ICAvIHsNCj4gPiBAQCAtMzMsNiArMzQsMTIgQEAgbWVt
b3J5QDQwMDAwMDAwIHsNCj4gPiAgCQkgICAgICA8MHgxIDB4MDAwMDAwMDAgMCAweGMwMDAwMDAw
PjsNCj4gPiAgCX07DQo+ID4NCj4gPiArCXBjaWUwX3JlZmNsazogcGNpZTAtcmVmY2xrIHsNCj4g
PiArCQljb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4gPiArCQkJI2Nsb2NrLWNlbGxzID0g
PDA+Ow0KPiA+ICsJCQljbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gPiArCX07DQo+
ID4gKw0KPiA+ICAJcmVnX2NhbjFfc3RieTogcmVndWxhdG9yLWNhbjEtc3RieSB7DQo+ID4gIAkJ
Y29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiA+ICAJCXJlZ3VsYXRvci1uYW1lID0g
ImNhbjEtc3RieSI7DQo+ID4gQEAgLTU1LDYgKzYyLDE3IEBAIHJlZ19jYW4yX3N0Ynk6IHJlZ3Vs
YXRvci1jYW4yLXN0Ynkgew0KPiA+ICAJCWVuYWJsZS1hY3RpdmUtaGlnaDsNCj4gPiAgCX07DQo+
ID4NCj4gPiArCXJlZ19wY2llMDogcmVndWxhdG9yLXBjaWUgew0KPiA+ICsJCWNvbXBhdGlibGUg
PSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0K
PiA+ICsJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llMF9yZWc+Ow0KPiA+ICsJCXJlZ3VsYXRv
ci1uYW1lID0gIk1QQ0lFXzNWMyI7DQo+ID4gKwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8
MzMwMDAwMD47DQo+ID4gKwkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+
ID4gKwkJZ3BpbyA9IDwmZ3BpbzIgNiBHUElPX0FDVElWRV9ISUdIPjsNCj4gPiArCQllbmFibGUt
YWN0aXZlLWhpZ2g7DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAgCXJlZ191c2RoYzJfdm1tYzogcmVn
dWxhdG9yLXVzZGhjMiB7DQo+ID4gIAkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0K
PiA+ICAJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gQEAgLTI5Nyw2ICszMTUsMzAg
QEAgcGNhNjQxNjogZ3Bpb0AyMCB7DQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gKyZwY2ll
X3BoeSB7DQo+ID4gKwlmc2wscmVmY2xrLXBhZC1tb2RlID0gPElNWDhfUENJRV9SRUZDTEtfUEFE
X0lOUFVUPjsNCj4gPiArCWNsb2NrcyA9IDwmcGNpZTBfcmVmY2xrPjsNCj4gPiArCWNsb2NrLW5h
bWVzID0gInJlZiI7DQo+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+
ICsmcGNpZXsNCj4gPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gKwlwaW5jdHJs
LTAgPSA8JnBpbmN0cmxfcGNpZTA+Ow0KPiA+ICsJcmVzZXQtZ3BpbyA9IDwmZ3BpbzIgNyBHUElP
X0FDVElWRV9MT1c+Ow0KPiA+ICsJY2xvY2tzID0gPCZjbGsgSU1YOE1QX0NMS19IU0lPX1JPT1Q+
LA0KPiA+ICsJCSA8JmNsayBJTVg4TVBfQ0xLX1BDSUVfUk9PVD4sDQo+ID4gKwkJIDwmY2xrIElN
WDhNUF9DTEtfSFNJT19BWEk+Ow0KPiA+ICsJY2xvY2stbmFtZXMgPSAicGNpZSIsICJwY2llX2F1
eCIsICJwY2llX2J1cyI7DQo+IA0KPiBUaGlzIGNhdXNlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmdz
IGluIGR0YnNfY2hlY2sgKHBhdGhzIHN0cmlwcGVkKToNCj4gaW14OG1wLWV2ay5kdGI6IHBjaWVA
MzM4MDAwMDA6IGNsb2NrLW5hbWVzOjE6ICdwY2llX2J1cycgd2FzIGV4cGVjdGVkDQo+ICAgICAg
ICAgRnJvbSBzY2hlbWE6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
ZnNsLGlteDZxLXBjaWUueWFtbA0KPiBpbXg4bXAtZXZrLmR0YjogcGNpZUAzMzgwMDAwMDogY2xv
Y2stbmFtZXM6MjogJ3BjaWVfcGh5JyB3YXMgZXhwZWN0ZWQNCj4gICAgICAgICBGcm9tIHNjaGVt
YToNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNp
ZS55YW1sDQo+IA0KPiBUaGUgYmluZGluZ3Mgd2FudCA0IGNsb2NrcyBmb3IgaW14OG1xIChhbmQg
aW14OG1wIHdoaWNoIHNlZW1zIHNpbWlsYXIpOg0KPiAqIHBjaWUNCj4gKiBwY2llX2J1cw0KPiAq
IHBjaWVfcGh5DQo+ICogcGNpZV9hdXgNCj4gDQo+IElnbm9yaW5nIHRoZSBvcmRlciB0aGVyZSBp
cyBubyBwY2llX3BoeSBjbG9jayBhbnltb3JlLCBpdCB3YXMgcmVtb3ZlZCBpbg0KPiBjb21taXQg
MTg0MDUxOGFlN2RlICgiY2xrOiBpbXg4bXA6IFJlbW92ZSB0aGUgbm9uZSBleGlzdCBwY2llIGNs
b2NrcyIpLiBJDQo+IHdhcyB3b25kZXJpbmcgd2h5LCBiZWNhdXNlIHRoZSBQQ0lFX1BIWV9DTEtf
Uk9PVCBhdCByZWdpc3RlciAweGEzODANCj4gaW5zaWRlIENDTSBpcyBsaXN0ZWQgaW4gUk0uDQo+
IFNvIHRoZXJlIGlzIGEgY2xvY2sgbWlzc2luZyBmb3IgJ3BjaWVfcGh5JyBvciB0aGUgYmluZGlu
ZyBuZWVkcyBzb21lIHVwZGF0ZSBmb3INCj4gaW14OG1wLCBubz8NCkhpIEFsZXhhbmRlcjoNClRo
YW5rcyBmb3IgeW91ciBjb21tZW50cy4NCkkgaGFkIGNvbmZpcm1lZCB3aXRoIGRlc2lnbiB0ZWFt
LCB0aGUgUENJRV9QSFlfQ0xLX1JPT1QgYXQgcmVnaXN0ZXIgMHhhMzgwIGlzDQogbm90IHVzZWQg
YW55bW9yZSBvbiBpLk1YOE1QIFBDSWUuIFNvIEkgdXNlZCB0byBpc3N1ZSBvbmUgcGF0Y2ggdG8g
cmVtb3ZlIHRoZQ0KdXNlbGVzcyBjb2RlIGZyb20gY2xvY2sgZHJpdmVyLg0KQWJvdXQgdGhlIGR0
LWJpbmRpbmcgb2YgdGhlIGkuTVg4TVAgY2xvY2tzLCBJIHdvdWxkIHVwZGF0ZSB0aGUgeWFtbCBs
YXRlci4NCkJUVywgaS5NWDhNUCBQQ0llIGlzIHNpbWlsYXIgdG8gdGhlIGkuTVg4TU0gUENJZSdz
Lg0KSXQncyBiZXR0ZXIgdG8gbWFrZSByZWZlcmVuY2UgdG8gdGhlIGkuTVg4TU0gUENJZSBjbG9j
a3MgZGVmaW5pdGlvbnMuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiANCj4gUmVn
YXJkcywNCj4gQWxleGFuZGVyDQo+IA0KPiA+ICsJYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1Y
OE1QX0NMS19IU0lPX0FYST4sDQo+ID4gKwkJCSAgPCZjbGsgSU1YOE1QX0NMS19QQ0lFX0FVWD47
DQo+ID4gKwlhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDw1MDAwMDAwMDA+LCA8MTAwMDAwMDA+Ow0K
PiA+ICsJYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmY2xrIElNWDhNUF9TWVNfUExMMl81MDBN
PiwNCj4gPiArCQkJCSA8JmNsayBJTVg4TVBfU1lTX1BMTDJfNTBNPjsNCj4gPiArCXZwY2llLXN1
cHBseSA9IDwmcmVnX3BjaWUwPjsNCj4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiArfTsNCj4g
PiArDQo+ID4gICZzbnZzX3B3cmtleSB7DQo+ID4gIAlzdGF0dXMgPSAib2theSI7DQo+ID4gIH07
DQo+ID4gQEAgLTQ0Miw2ICs0ODQsMTkgQEAgTVg4TVBfSU9NVVhDX0kyQzNfU0RBX19JMkMzX1NE
QQ0KPiAJMHg0MDAwMDFjMw0KPiA+DQo+ID4gIAkJPjsNCj4gPg0KPiA+ICAJfTsNCj4gPg0KPiA+
ICsJcGluY3RybF9wY2llMDogcGNpZTBncnAgew0KPiA+ICsJCWZzbCxwaW5zID0gPA0KPiA+ICsJ
CQlNWDhNUF9JT01VWENfSTJDNF9TQ0xfX1BDSUVfQ0xLUkVRX0INCj4gMHg2MSAvKiBvcGVuIGRy
YWluLCBwdWxsIHVwICovDQo+ID4gKwkJCU1YOE1QX0lPTVVYQ19TRDFfREFUQTVfX0dQSU8yX0lP
MDcNCj4gMHg0MQ0KPiA+ICsJCT47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCXBpbmN0cmxfcGNp
ZTBfcmVnOiBwY2llMHJlZ2dycCB7DQo+ID4gKwkJZnNsLHBpbnMgPSA8DQo+ID4gKwkJCU1YOE1Q
X0lPTVVYQ19TRDFfREFUQTRfX0dQSU8yX0lPMDYNCj4gMHg0MQ0KPiA+ICsJCT47DQo+ID4gKwl9
Ow0KPiA+ICsNCj4gPiAgCXBpbmN0cmxfcG1pYzogcG1pY2dycCB7DQo+ID4gIAkJZnNsLHBpbnMg
PSA8DQo+ID4gIAkJCU1YOE1QX0lPTVVYQ19HUElPMV9JTzAzX19HUElPMV9JTzAzDQo+IDB4MDAw
MDAxYzANCj4gDQo+IA0KPiANCg0K
