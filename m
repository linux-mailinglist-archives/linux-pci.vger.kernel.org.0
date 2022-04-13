Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79BE4FF113
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiDMH6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiDMH6I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 03:58:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A8449694;
        Wed, 13 Apr 2022 00:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEuMsxhTu5rDWuvKe/V395y/Zb3btDXsemCMaBNfGI0OxpniFWFQGpLvRGB5lbVAlmpJJob/bs7Szbqv2edfm4FN3HZiimClXNe/AsyVyIM+0aezHZRnIdXV5hfsratN40iTmva5nKarDB/AhrOHFa5zAMf7MxGB07WajE7txJ39WvH53II0zMmkK0lKVIxTcfo692FCs1tw5gC3rbgmKurDoTQ/BOkOUl3XEzESVsFdGZtgBOEWZYE+D6W19Evw/i4LdJGpHCbGAspH3F9Exm2cloygT776Ywd5DJh6whHtRpzlqhfeYnfx6A2kGQQroRTAYxT0/6dBN+NCE++/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXtAlF38GodfS/112N9vrWgLBAgxn30cZz4b4KEFXBU=;
 b=BFQUIbtTEkS+HMpXap/+RhKyHnIEa0THJ5TahYvI8Y657EEP0LK6yL1jPWpDnDDdY9p0Ci8HlXfJvttQmJIgj/oqTVF0qmfELVdjarPBOdi3zplruMgrePQkWMa+nOef7RTJg2DRQqhJRcdMs+WoRYID/v/2obIIU/zHKYj97VM5ag+i+y88XliE8/Lv/tgra80WK+PxMd1Ok2e+Me5B5ODQ/AXINw1m+GxJW+Qia4KU5YX4RHGCZIMpyzfUGrGRlyHIKDUAB/aQIpYaCNZgO6ZrWWZjiXbwvhp2uhJRj1f8ZE5mPWywHKzXHd5QHl1nPMofpyHemsi8MEXYfAVDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXtAlF38GodfS/112N9vrWgLBAgxn30cZz4b4KEFXBU=;
 b=k1/M8AQSLFe8xrea1780CCgBWekUPbcy1JnKBJY20C7IdODKUurKq8dDwDqKDH6AOpLFhOP6rvnMVyVHabctGVWt8J2plk6lZP98rbQAaeKYOAorkQTEoIaMbJ9sG87z2eovI5wMWpALwG/OvsJBHx/mT+EgrMvtN5vvWtfdU58=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7234.eurprd04.prod.outlook.com (2603:10a6:20b:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 13 Apr
 2022 07:55:44 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%4]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 07:55:44 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 0/7] Add the iMX8MP PCIe support
Thread-Topic: [PATCH v2 0/7] Add the iMX8MP PCIe support
Thread-Index: AQHYMgQJVjtpqun8b0KM+ThJT0OxrazlG8MAgABHu+CAAHlZgIAEZttwgANmkoCAAAZ+oA==
Date:   Wed, 13 Apr 2022 07:55:44 +0000
Message-ID: <AS8PR04MB86765A8E9C77BBA8D1E930FE8CEC9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <CAJ+vNU0McZxj_74DC0wCUyHq-NaT14URnvUP+kvudz7YLQq7fg@mail.gmail.com>
         <AS8PR04MB86766041887E97E22B0AC8C48CE99@AS8PR04MB8676.eurprd04.prod.outlook.com>
         <4f8f93c51fedc84d94534e962bc7c68c4a4e5616.camel@pengutronix.de>
         <AS8PR04MB867606A1E2E45A0C0A1525A48CEA9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <b112c517d5ee86ef09088ed3cc00291417101a6e.camel@pengutronix.de>
In-Reply-To: <b112c517d5ee86ef09088ed3cc00291417101a6e.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 779f4444-205d-43b2-328e-08da1d230389
x-ms-traffictypediagnostic: AM8PR04MB7234:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM8PR04MB72341AA1797DD377A7E77A7D8CEC9@AM8PR04MB7234.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ziHp8wDWZyVdf9HaL3nJtqMFRXn5KYAX/0tMn1+pcJZA3nZ8r6NmMcRjDFR20AUHUjCtRF463mRZ7VJHsMyq4c5z1n4FGxX9KpdvJ2GMvQFNLKtKDygrdKO8+YWH8deJIz35qCtUXs+MRI+U2B+giQs+fusmK2lgPAkdSFJVhylyk+gW3M6afR1WWRo9xXcECd9R6cq1OiFO5INCvQIKfmj9e1CJFBpwPTNH/G7KmaqOTk+AQJ3R8x7+m2KxvjVidmKtmljXyVkOn7UqGoedZ/PYI3P0Q6QjT43lsjd+mZvEXmlKv9+SuZaXRyUs7DJA2lBtTCBu8kTPlu4focCGp8n58zD0fLVns5AhAlIxRO/3beojChmRVUPRu60LDjxCCphbALRsNYzYzHl66IALHzpw8qiHA45A55K609Tg+p2D2/aZOUzkNTObNfer/fZ7XQFE2udLEE3HuSXTRfssMukUzWybRPfu7FTPlwB+JNpx4S+JrP32z7TUIhJJLOS+hilR5EmujhJmgFgIpa2xe5FQBYWn+56CoyehQONFB2kIgWsYKWSwZfAlVN7bBkpyGeFNQtMBGLYY0bVt8jPsN2gpaSlkigtkDZOjVS1ccwBoduQJ09ivesZwBBxU8BY7zN2PObfAP142bBm4qI0ZHXFA6/giziz5tKKK5jrSVVl5VpJazU/fY9G+2p6ru6nSBtqZc4aszejgfOg3G2Fcd94P5IgHqoVtPgcHOR6T44=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(316002)(55016003)(110136005)(54906003)(7696005)(53546011)(66556008)(66446008)(44832011)(2906002)(76116006)(38070700005)(122000001)(66946007)(8676002)(64756008)(508600001)(7416002)(33656002)(38100700002)(8936002)(83380400001)(5660300002)(71200400001)(52536014)(9686003)(26005)(186003)(6506007)(86362001)(4326008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODhFRFN2cFNYTERjMlNvMUpyZzVQbFZ4aTQ1MVRTak4xNy9GN1ZsbDJ2WlJQ?=
 =?utf-8?B?WVNaVjlKeTZzUHU0azJjL3J6dG0vT3o4ZmFsWDVTd0ZxN3VMSmF1dXJFNVRi?=
 =?utf-8?B?ZlltUmNEdDRQSTQwZlRzc2ZqY0UvcjhhZGRJQU5FUUxTNnRIMkF6M0djcHgy?=
 =?utf-8?B?M2ZGTGNNUXZjRnpra3Y4UHFTUENPVFlzWkN0amhCb1FFZno1UXEvQkY2UTg4?=
 =?utf-8?B?SFNXKzVBclczalIySEgvNU9SNC9RelEzbjFDZlkwU3FBcHpvaHRHQnZnNWVX?=
 =?utf-8?B?Vi9VV0k1dXlJeUQ5ZVRyemErS1lWam9XSCtWYlpYWDZCcXB5WWZBTFZnYTBE?=
 =?utf-8?B?UkRvVGUxaG1yZTZHbHFBWXNjN0pGTUI4OG5yVkhxemhmeXgwcC9LcVg4eXJx?=
 =?utf-8?B?bHdqaVZIVlFnN092dlk2ZTA2QU9aL3cxdW9IeUYzajNWZWtWdHhOWEwrZllE?=
 =?utf-8?B?VmNFUjJHQ21tNVh6TG1iMlZGTm01b0htS1dsYWNGaUdWTXByT000WnVma2RD?=
 =?utf-8?B?TlhIcHdhazlFaVpzaE9IWnplSHJUN3dYU1VzT1VQN1djWXBkWlIwYlc3MHRY?=
 =?utf-8?B?R0hkd2NGejB5Z1VuR3A0ODJkL2RIUjN1T0NBYTlLNm10Z3B2Nk1pUjJoekQy?=
 =?utf-8?B?UFFEQjk3Q1dOWVNYZzVwSXJnZUpLdnZnWi9Wd3FuS214dEk4VlkrUkEzc1JU?=
 =?utf-8?B?ODlqekJXOXY5V3c4Q2lzOWpVQ0lCSzU1ZVVoZHFybCt5djNWdEw0U3JZd2hv?=
 =?utf-8?B?UkZldVQ2WlhxMWpuQ2psVW1jTXgzbWxmcytvSmxIU0hyQmJqVW9xeVpuVFRi?=
 =?utf-8?B?MExDS2NTbEVDYW92WGZGdHZodFRJRFJwS3BleEQ2ckliQVdNS3o0bWFyR2Er?=
 =?utf-8?B?cm92eVdNNUZ5WEJGUXZBMlNNbXlZd2l4Y2haL0tBSEVJeTZCMFd5MGhNNVlB?=
 =?utf-8?B?S0U1aWRQSWhqTFhBVityaWN5dG90aGhKTXlJYUdXdmd6NnVzeUZNbUFFYW9l?=
 =?utf-8?B?ZUlGOWc4VklLMjVaVUF4bVZHMG4ydGtWVjd0eFY5bmExRUxUaVJMUTMzWUlO?=
 =?utf-8?B?anRTTXpqK25EVHV1WWhQS2dYenRmYng5M2hPNDRRSkNjYzVrazQweWRlSmNP?=
 =?utf-8?B?cmZsUUpoUDQ3ZGJ6VnhKZXlNNVZPM0czSXdzOTJnNXlvZHBpVGNWMVJTUEdw?=
 =?utf-8?B?STA4cVA3NTA1ZTVLM0R0ZDIwQWdkdmFqN01wNC8xbzBCNEVVMjlRSytmSXds?=
 =?utf-8?B?Q0V0aGhvTjRVeS92UE9UVjN1TFJFdEZWaE9OTmtjcGZGelArS0c5Q2drNTMy?=
 =?utf-8?B?Y3F6R3QzcXkvSCtDVXNJQmQrRGlmYllsanI0ME1TSGRaQWtabUw0NmJtV09W?=
 =?utf-8?B?ZjVWb213UWJWeW1qRDd6U0tMZXNXcVBybVdBY0Q4OHB6eDV2SVdrMmlKVyti?=
 =?utf-8?B?a2o2SnpyNk5ZTzRjbWgySjBTYTJWWGl0aHV5clZLbDJBYmN6QjVSTlJOSTgy?=
 =?utf-8?B?SmJ1MW5nazVvZEMzNWduT0tKa09YeHVuL2oxWTJzZEQ5bHdZZmM5VFhCVlV4?=
 =?utf-8?B?RGlnVDVpT0R3Qld1ZmRVSll0eTh4NXhNZmJLWmFYUlE0Z3grMDBYRGcxaVQ0?=
 =?utf-8?B?c1RtRGwzUFF3TGt5QjRRdC9ZcFVRSzdoY2lQcDhsM01OaVgrbDdTNjB1Tms5?=
 =?utf-8?B?NnFkVXFZYkpxOEZ5a3Z3QndTVUNWUjBEc01yaE5mTERGNFFCUlRSVmU2aVMz?=
 =?utf-8?B?VEdESmVUVmJLRldIeUdFWWw4cmxJNVBnczYwR3VLdHV5aGFjTXFWZU1tWFBj?=
 =?utf-8?B?NU50QjVjMTN5YzZQdDM1T1h2QzNkcjdqSVQ1VHlTcjUwSHRSN21lTUpqVkpl?=
 =?utf-8?B?T29teHBtUThpQ21ESDJrT1EweldUcWNjRG13eHZLRWlQUm1mb0NMSXlyUjYy?=
 =?utf-8?B?d00xc0s5UHhnMGx4b0dVMzJLRXN2RWdITGlPbjJ0OVZHZEtkdmxrZDF3Vkt5?=
 =?utf-8?B?RFlleVdnOHZqQWNUdVlFNkNBMHRqUXIveE50UTQ0Z0xrNFVKdFlORGVjc1hS?=
 =?utf-8?B?Z01pVWxIMmtCUVBwbE9PVlM2RTZnVUo0MEpSVy80Z3pqcjdrSGVKTmZkdWMz?=
 =?utf-8?B?cDVMSlhxOHZlTU01aHJ4aTB0YjlyTERmTWl5Umo3OURkRWcwRWdydExWUDBH?=
 =?utf-8?B?bG45MXk0cFpnWUgwODhCOG5wdkVnSTlQcDhBSDdQalQ5bCtwaDZtS2Z2M1dt?=
 =?utf-8?B?N2ZVVDBzUkhBRWc5TjV6L2NNeTdKZGJjUjdjN3o0SDM1dVF5YTZ3QmFxMVgw?=
 =?utf-8?B?OE5rRmFoWWpGOUY2b0ZNaDlseHBsTEZUSmhKam1tVldjYlJ3Y3ZQZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779f4444-205d-43b2-328e-08da1d230389
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 07:55:44.5793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhxtJA7YDj9Rvv9vI0/GnZB7IhMQwAcaCXM7x28AO3aN1u/dM5Xia1z/iBYCNuREYw9b+/Vb3blvq3btqnnHVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7234
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDTmnIgxM+aXpSAxNToyMg0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNv
bTsNCj4gQWxleGFuZGVyIFN0ZWluIDxhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tPg0K
PiBDYzogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47IGJoZWxnYWFzQGdv
b2dsZS5jb207IExvcmVuem8NCj4gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29t
PjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IFNoYXduDQo+IEd1byA8c2hhd25ndW9A
a2VybmVsLm9yZz47IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+Ow0KPiBsaW51eC1waHlA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgRGV2aWNlIFRyZWUgTWFpbGluZyBMaXN0DQo+IDxkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IExpbnV4IEFS
TSBNYWlsaW5nDQo+IExpc3QgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47
IG9wZW4gbGlzdA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFNhc2NoYSBIYXVl
ciA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzddIEFkZCB0aGUgaU1YOE1QIFBDSWUg
c3VwcG9ydA0KPiANCj4gSGkgUmljaGFyZCwNCj4gDQo+IEFtIE1vbnRhZywgZGVtIDExLjA0LjIw
MjIgdW0gMDM6MzIgKzAwMDAgc2NocmllYiBIb25neGluZyBaaHU6DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0
cm9uaXguZGU+DQo+ID4gPiBTZW50OiAyMDIy5bm0NOaciDjml6UgMTY6MTMNCj4gPiA+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgdGhhcnZleUBnYXRld29ya3MuY29t
Ow0KPiA+ID4gQWxleGFuZGVyIFN0ZWluIDxhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29t
Pg0KPiA+ID4gQ2M6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+OyBiaGVs
Z2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb20+OyBSb2IgSGVycmluZw0KPiA+ID4gPHJvYmhAa2VybmVsLm9yZz47IFNoYXdu
IEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFZpbm9kIEtvdWwNCj4gPiA+IDx2a291bEBrZXJu
ZWwub3JnPjsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IERldmljZSBUcmVlDQo+ID4g
PiBNYWlsaW5nIExpc3QgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsNCj4gPiA+IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IExpbnV4IEFSTSBNYWlsaW5nIExpc3QNCj4gPiA+IDxsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBvcGVuIGxpc3QNCj4gPiA+IDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyDQo+ID4gPiA8a2VybmVsQHBl
bmd1dHJvbml4LmRlPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC83XSBBZGQgdGhlIGlNWDhNUCBQQ0llIHN1cHBvcnQNCj4g
PiA+DQo+ID4gPiBBbSBGcmVpdGFnLCBkZW0gMDguMDQuMjAyMiB1bSAwMzoxNCArMDAwMCBzY2hy
aWViIEhvbmd4aW5nIFpodToNCj4gPiA+ID4gPg0KPiA+ID4gWy4uLl0NCj4gPiA+ID4gPiBSaWNo
YXJkLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMhDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBEbyB5b3UgcGxhbiBvbiBzdWJtaXR0aW5nIGFub3RoZXIgdmVy
c2lvbiBzb29uPyBJJ3ZlIHRyaWVkIHRvDQo+ID4gPiA+ID4gdGVzdCB0aGlzIHdpdGggYW4gaW14
OG1wIGJvYXJkIEknbSBicmluZ2luZyB1cCBhbmQgd2hpbGUgdGhlDQo+ID4gPiA+ID4gaG9zdCBj
b250cm9sbGVyIGVudW1lcmF0ZXMgSSBmYWlsIHRvIGdldCBhIGxpbmsgdG8gYSBkZXZpY2UuDQo+
ID4gPiA+ID4gSXQncyB2ZXJ5IGxpa2VseSBJIGFtIG1pc3Npbmcgc29tZXRoaW5nIGFzIHRoaXMg
c2VyaWVzIGRlcGVuZHMNCj4gPiA+ID4gPiBvbiB0aGUgSU1YOE1QIGJsay1jdHJsDQo+ID4gPiBh
bmQgZ3BjIHNlcmllcyB3aGljaCBJIGFsc28gY2FuJ3QgY2xlYW5seSBhcHBseS4NCj4gPiA+ID4g
PiBMdWNhcyBqdXN0IHN1Ym1pdHRlZCBhICdjb25zb2xpZGF0ZWQgaS5NWDhNUCBIU0lPL01FRElB
L0hETUkNCj4gPiA+ID4gPiBibGstY3RybCBzZXJpZXMnIFsxXSB5ZXQgSSBjYW4ndCBmaW5kIGEg
cmVwby9icmFuY2ggdGhhdCBhcHBsaWVzDQo+ID4gPiA+ID4gdG8gZWl0aGVyLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gUGVyaGFwcyB5b3UgaGF2ZSBhIGdpdCByZXBvIHNvbWV3aGVyZSBJIGNhbiBs
b29rIGF0IHdoaWxlIHdlDQo+ID4gPiA+ID4gd2FpdCBmb3IgaW14OG1wIGJsay1jdGwvZ3BjIHRv
IHNldHRsZSBhbmQgeW91IHRvIHN1Ym1pdCBhIHYzPw0KPiA+ID4gPiBIaSBUaW06DQo+ID4gPiA+
IFRoYW5rcyBmb3IgeW91ciBraW5kbHkgaGVscCB0byBkbyB0aGUgdGVzdHMuDQo+ID4gPiA+IEkg
aGFkIGxpc3RlZCB0aGUgZGVwZW5kZW5jaWVzIGluIHRoZSBjb3Zlci1sZXR0ZXIgbG9nLg0KPiA+
ID4gPiBBbGV4YW5kZXIgYW5kIEkgdXNlZCB0byB0ZXN0IHRoaXMgc2VyaWVzIGNvbW1pdHMgYmFz
ZWQgb24gdGhlDQo+ID4gPiA+IFY1LjE3IGtlcm5lbC4NCj4gPiA+ID4NCj4gPiA+ID4gTHVjYXMg
aGFkIHByb3ZpZGVkIHNvbWUgcmV2aWV3IGNvbW1lbnRzIGFuZCBzdWdnZXN0aW9ucyBhYm91dCB0
aGUNCj4gPiA+ID4gUExMIGJpdHMNCj4gPiA+ID4gwqBtYW5pcHVsYXRpb25zIG9mIEhTSU9NSVgg
aW4gaS5NWDhNUCBQQ0llIFBIWSBkcml2ZXIgIzMgb2YgdGhpcw0KPiA+ID4gPiBzZXJpZXMuDQo+
ID4gPiA+IEFuZCBoZSBzdWdnZXN0ZWQgdG8gbGV0IHRoZSBIU0lPTUlYIGJsay1jdHJsIG1ha2Ug
dGhpcyBQTEwgYXMgYQ0KPiA+ID4gPiByZWFsIGNsb2NrLA0KPiA+ID4gPiDCoGFuZCB1c2VkIGJ5
IGkuTVg4TVAgUENJZSBQSFkgZHJpdmVyIGxhdGVyLg0KPiA+ID4gPg0KPiA+ID4gPiBBbHRob3Vn
aCBJIGhhdmUgc29tZSBjb25mdXNpb25zLCBpdCdzIGJldHRlciBsZXQncyB3YXRpbmcgZm9yIHRo
ZQ0KPiA+ID4gPiBibGstY3RybCBzZXR0bGUgZG93biBhbmQgZ2V0IGNsZWFyIGRpc2N1c3Npb24g
d2l0aCBMdWNhcyBsYXRlci4NCj4gPiA+ID4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0aGF0Pw0K
PiA+ID4NCj4gPiA+IEp1c3QgdG8gbGV0IHlvdSBrbm93IG15IHBsYW5zOiBJIHdhcyBxdWl0ZSBi
dXN5IHdpdGggZ2V0dGluZyB0aGUNCj4gPiA+IGkuTVg4TVAgSERNSSBwYXJ0IHRvIHdvcmsuIE5v
dyB0aGF0IHRoaXMgaXMgYXQgbGVhc3QgaW4gYSBzdGF0ZQ0KPiA+ID4gd2hlcmUgaXQgY2FuIGNv
bGxlY3Qgc29tZSBmZWVkYmFjayBmcm9tIHVwc3RyZWFtIEkgaGF2ZSBzb21lIHRpbWUgdG8NCj4g
PiA+IGNpcmNsZSBiYWNrIHRvIHRoaXMgdG9waWMuIEkgY2FuJ3QgY29tbWl0IHRvIGRvIGl0IGlt
bWVkaWF0ZWx5LCBidXQNCj4gPiA+IEknbGwgZ2V0IGFyb3VuZCB0byBsb29raW5nIGF0IHRoZSBQ
Q0llIHNlcmllcyBhIGJpdCBtb3JlIGluLWRlcHRoDQo+ID4gPiBhbmQgYXBwbHkgbXkgSFNJTyBQ
TEwgc3VnZ2VzdGlvbiB0byB0aGUgYmxrLWN0cmwgZHJpdmVyIGR1cmluZyB0aGUNCj4gPiA+IG5l
eHQgd2Vlay4NCj4gPg0KPiA+IEhpIEx1Y2FzOg0KPiA+IFRoYW5rcyBmb3IgeW91ciBoZWxwZnVs
IHJlcGx5Lg0KPiA+IEkga25vdyB0aGF0IHlvdSdyZSBidXN5IHdpdGggdGhlIGJsay1jdHJsIHNl
dHRsZSBkb3duIG5vdywgYW5kIGhhZA0KPiA+IGV4cGxhaW5lZCB0byBUaW0uDQo+IA0KPiBZZXN0
ZXJkYXkgSSB0cmllZCB0byBnZXQgdGhpcyBzZXJpZXMgd29ya2luZyBvbiBteSA4TVAtRVZLIGJv
YXJkLCBidXQgd2FzDQo+IHVuc3VjY2Vzc2Z1bCBmb3Igbm93LiBUaGUgUENJZSBsaW5rIGRvZXMg
bm90IGNvbWUgdXAuIFBDSWUgUkVGX0NMSyBpcyBwcmVzZW50DQo+IGFuZCBQRVJTVCBkZS1hc3Nl
cnRlZC4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgZHVlIHRvIGEgZmF1bHR5IEVQIGRldmljZSAo
SSBkb24ndA0KPiBoYXZlIGFub3RoZXIgTS4yIEtleUUgZGV2aWNlIGFyb3VuZCB0byBjaGVjaykg
b3IgaWYgdGhpcyBtYXkgYmUgZHVlIHRvIHRoZSBvbGQNCj4gcmV2aXNpb24gb2YgbXkgOE1QLUVW
SywgYXMgSSdtIHN0aWxsIHdvcmtpbmcgd2l0aCBhIFJldkEgYm9hcmQuIFRoZSBzY2hlbWF0aWMN
Cj4gcmV2aXNpb24gbG9nIGRvZXNuJ3Qgc2hvdyBhbnl0aGluZyB0aGF0IHdvdWxkIG9idmlvdXNs
eSBpbmZsdWVuY2UgUENJZQ0KPiBvcGVyYXRpb24sIGJ1dCBJIGhhdmUgYWxzbyBub3QgZm91bmQg
YW55IHNjaGVtYXRpY3MgZm9yIFJldkEuDQo+IA0KPiBEbyB5b3Uga25vdyBpZiB0aGVyZSBoYXZl
IGJlZW4gYW55IFBDSWUgcmVsYXRlZCBjaGFuZ2VzL2ZpeGVzIGluIHRoZSBsYXRlciBFVksNCj4g
Ym9hcmQgcmV2aXNpb25zPw0KPiANCkhpIEx1Y2FzOg0KRmlyc3Qgb2YgYWxsLCB0aGFua3MgYSBs
b3QgZm9yIHlvdXIga2luZGx5IGhlbHAgb24gdGhpcyBzZXJpZXMuDQpJIHJlbWVtYmVyIHRoYXQg
dGhlcmUgaXMgb25lIFBDSWUgcmVsYXRlZCBIVyByZXdvcmsgdXNlZCB0byBzdXBwb3J0IHRoZSBO
Vk1FDQogZGV2aWNlIHdoZW4gUmV2IEEgYm9hcmQgaXMgdXNlZC4NCkhlcmUgaXMgZGVzY3JpcHRp
b24gb2YgdGhpcyByZXdvcmsgYW5kIGhvcGUgaXQncyBoZWxwZnVsLg0KDQpTdXBwb3J0IEhpZ2gg
cG93ZXIgY29uc3VtcHRpb24gTlZNZSBTU0QNCkN1cnJlbnQgRVZLIGhhcyBsaW1pdGF0aW9uIHRv
IHN1cHBvcnQgaGlnaCBwb3dlciBjb25zdW1wdGlvbiBOVk1lIFNTRCwgdHJhbnNpZW50DQogdm9s
dGFnZSBkcm9wIGlzIGhpZ2gsIG5lZWQgdG8gY2hhbmdlIFI0NTIgdG8gMG9obSB0byBzb2x2ZSB0
aGlzIGlzc3VlLg0KUmV3b3JrIFN0ZXBzOg0KQ2hhbmdlIFI0NTIgIHRvIDQ3MC03NTM5NCAwb2ht
LCAwNDAyDQoNCkJUVywgUjQ1MiBpcyBwbGFjZWQganVzdCBhdCB0aGUgcmlnaHQgc2lkZSBvZiB0
aGUgTS4yIHNsb3QuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiBGb3Igbm93IEkn
bGwgdHJ5IHRvIGdldCB0aGlzIHdvcmtpbmcgb24gYSBjdXN0b20gaS5NWDhNUCBib2FyZCwgd2hl
cmUgSSBjYW4NCj4gdXNlIGEgZGlmZmVyZW50IEVQIGRldmljZS4gTWF5YmUgSSdsbCBoYXZlIGEg
Yml0IG1vcmUgbHVjayB0aGVyZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQoNCg==
