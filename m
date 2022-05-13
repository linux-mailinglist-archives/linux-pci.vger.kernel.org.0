Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8895259B3
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 04:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376515AbiEMCWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 22:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355770AbiEMCWe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 22:22:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742B4F68B1;
        Thu, 12 May 2022 19:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTMmF1f/rLHSrrY6xTQX7OuxdaB6JCiK6SSCmhpjY2k665gOWk6RUZSPFtPkQVE867ZanxvmgsPg9j/4BK6TQ+Ubxr0NEAabruIy3Xi7rKwKWQYfl2hHRAuaYQ+70JGIPtwCMjMdglhIzYgytHI59avL9tm7EKl/qhYbUzUJFbksfanbnNiMsbwI77jBEE6TaLUMD0ShwDw7tWwA5eu+jpgXLZ9/xlCNbdZW5MIcfhOwE5vhWYuPvQyFl4437/DyFz+q6sdDaxKEXGaNKIdt5q+M3qWagD4l/Xmknb1WRnKclb00Rqpp+qc7FMKhthPTH4RFkOPKaa6QvbFHRuHfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyVZC4Y5l/28cHcOmKhFH/VwMkXJm2+3WZB/QaoY4Nc=;
 b=hphsoNaQDS+mNJA97mTrOA1GAnvfaFVVKELb0Uc1HtcFzjQEmvoJMXX16AE/iH86yTRFzoWrEG6ome0k1Nt1uR5s+t2+0/CZ4L6Glyb0wzor+6kdMVCRemmN6c8I99uKQTnKSUBwkqKA4UjCkAg2wM3eqaOqCHNzX9Q/lk3xLrT5i1RnmTUz49BbAhZLOY8UGRWvuV89jSwIkidV/xOeUYYWdgKHz7SbDNBd3ZNfG+CSWrhtLsQ0CAidTcfNLZx9uuY3MoflHnBZvRh0SRSVu16uBkgPuCZGs3BWEWjYzgqaNlTVVS7UOqn7nB3Oa+RQzS1rKjmJOkBsVDpdwyWzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyVZC4Y5l/28cHcOmKhFH/VwMkXJm2+3WZB/QaoY4Nc=;
 b=j7PIpk6VQm8dNXwakbZwr4gIgZkW5twJRU1rxS6YXxowK2useq0fOQ1kqakfUXiDjDX9JpxQKUAmZeOe6XHUtCgoTUmKJK0ghA+GWFbGuiehNMAOXYUMXbK71FPNkqvDsYy8OBOzNZ5VA38lC8q6ogVX3jM1CFdeIlFJY6k1Oi4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 02:22:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::65e4:3df9:cbcc:7cf0]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::65e4:3df9:cbcc:7cf0%7]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 02:22:29 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 7/7] PCI: imx6: Add the iMX8MP PCIe support
Thread-Topic: [PATCH v2 7/7] PCI: imx6: Add the iMX8MP PCIe support
Thread-Index: AQHYMgQPVpBhfK4bZk2w4b8ydmjAAa0b0RSAgAClnqA=
Date:   Fri, 13 May 2022 02:22:29 +0000
Message-ID: <AS8PR04MB8676765583E72CB09C6CAE878CCA9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <1646644054-24421-8-git-send-email-hongxing.zhu@nxp.com>
 <20220512160845.GB2506@lpieralisi>
In-Reply-To: <20220512160845.GB2506@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8796b095-8527-4657-4b29-08da34876de0
x-ms-traffictypediagnostic: AM6PR04MB6407:EE_
x-microsoft-antispam-prvs: <AM6PR04MB64077221C74F5665C6F2CFCF8CCA9@AM6PR04MB6407.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DV0u8iZEwF5FvMpHQUXD/CjgsnVBF0bhaMtYYptuNNqhhgEQPejDhyRvk54ioOGvzzEgDlAM+HJpc/UFMVV7nkSJGycpTrKqf1ZJpQzKOd0CQ/clegYjXm1v63OmW1sGhXUnh1N9imrWoSu+KW/syPhcj/HhTAORIj/NWvHM0Ni6LZyC8Jzox8e812l+kZZWEIT40JsER20DiDyeuCxWVdAJZbusIhwPYKYFBXfHczY8yYEQXphVHp9ZgYxyrbzBZzFP9hBHqHAG+bVArAL5IS3wMDt396rQY6lAnj7iInx+SKEVesQlog3beDN+ZgDlKYWlpEH79vTd+RO3BPcRoiigY8NHK6b5LwCLt/4EB/B0sZDE2Oqnax7soWBxohLtKMmwZkX7+TxYxPsMZO31JOb5rXHMwMAzKXEdqClK2nc2Zb0U71mq8qvc+A7YeM7Twn5h1kBfCahcI9RY2lJ8MCopLGc5GAkMyHjpMV5vPlKzp/uiTImyihB6OPpidBFUqrpeoi1fmi72Vq05AVz40P7fTXzzB0Hq+1DujPc2c4Hmh6xLqlSd1CFFvxHH6GCrnenGd5xpdgPCyONA8fgSqczPpaJDlwc+xP6DmTT0KOV6DTwpxKlv2kSpn8nL8sxgA+YIdE3/RhdllGCVJnhIP+dmjOP86SQQ27JkQrDF5Uep6+QXCmpKqpYzmU5VvgeKpAj48q6K6H6RUTyX01y2U1HvxZfAQ0I3M2aYIqM+XtU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66446008)(66556008)(33656002)(316002)(38070700005)(122000001)(38100700002)(44832011)(64756008)(66476007)(76116006)(54906003)(186003)(83380400001)(7416002)(9686003)(26005)(2906002)(7696005)(6916009)(55016003)(86362001)(8676002)(71200400001)(8936002)(52536014)(5660300002)(508600001)(53546011)(4326008)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SnFWWHM2cjF5WnNXaU9CUHVjTUlBQ21Gc3dwUHN5NlB3Q2h6eVZYZVNjYm82?=
 =?gb2312?B?dHhZa1IzeTJWN0hDVVpSU0pUb2xjSnJlbjV6aW1JQ3hWelVoekJlQlplVUIz?=
 =?gb2312?B?SEYwK0hXTzNGOW1iODdaazNIZEl6UU83VkFpRGxwUmVVdHRIWjBUSlNFZEJY?=
 =?gb2312?B?eUE2OFUwZTlFcll4YVNxQ0VHdm9WR0d4K0NyNE1VTlF6bnZiUHJLQ0Z6Tzcv?=
 =?gb2312?B?cTRSbktwNGxWeVJpdXBibDdIV1FoYkpVb2x0SjNUb1FIZEJNRHZiNEdhaUE1?=
 =?gb2312?B?VDcvOHRxKzhOaTNkdGlaanF2QlByeENyckg1VDQ0YThlallwbTJhUG9SYnRS?=
 =?gb2312?B?cVpBcnpxRVEwOEFqWGxlVXUrLy8rZmo5UHNKMkZaMStUaSt0QWx6VkhNRzl5?=
 =?gb2312?B?ZjFkbTB5QnRWT0hJK0hYRWZhT2VRQWlhR1Uxd0xENDZlN0FzWFMrZFZXS1lD?=
 =?gb2312?B?OGozWGZCOWh5ak9ybGFtcWVGRFZJcVVJU2w4a254LzlXeXFoRzRIS0kyaGpO?=
 =?gb2312?B?TjF4WDF0eHF2Q0xldTRqSGZ2a2M1U0NqSDNqTFU3S2JOSEgzQjIyZUpoVlVq?=
 =?gb2312?B?K3Y3ZytXUHN5RFh5bWwrRVJjWE5LWEJtQW5mOEJPMVNVRXRXaXMzeGVrb0F1?=
 =?gb2312?B?ZWRJWW5CTW5hVzNsQlgvQVlvcUFVQlo4djBIZmRjZk9NaHhwTDBwSndCUzBu?=
 =?gb2312?B?WWl6OGVCUXpZMjdENUxxc29lVGdFQXg3SHB1dWNzNXNWelVIcFVkRHF4NHg5?=
 =?gb2312?B?SG5NT3U2K05kY3E3eE8rditwK1c3cTRiak5XUmdyQktDRnhsWk43Q2xtYVZP?=
 =?gb2312?B?aWlYTmVTeEwwMGQzNUFOZUZlQWJjOWl3bHd1bHd0aWdVYU9EVldzWVR5Ulpj?=
 =?gb2312?B?c2YzOVQ2SU16ME1yWDNscWFjSmQwT0hoS0h2Z1p0akRzcExjc3VOd2laWXAy?=
 =?gb2312?B?UGZDT2RDenNxWGRhU0pqZERwMStWVUFjTC9wekRmVTM0MDRQd2lQNXRLUUVn?=
 =?gb2312?B?WEdJYWIveUFJV3pINzZOdFQvZEwwUjd0UzZwNndvREpjMGtsN0JnS3pxUmNH?=
 =?gb2312?B?cFdaYllGQ1lYcGNzQzdRdlBLK24vT0FJSGN5THVpZGhraXRuOE91WWc2bEIr?=
 =?gb2312?B?bGRJZzFONnR4RXRDdSs4NFk5cVhzR2M5c2M3ajYxT1d1Z2JqcjQ2YVpBTTI3?=
 =?gb2312?B?ZnZxaml0eWhlcnJWbWlLYS84c05za0MxR2xJbHFTUTRRdDY0Z04waDdoeVhB?=
 =?gb2312?B?Rk5EZlFXRVVsYVFuQVV3bUcrcUZtdUlKY0Iyamo5V05aayswc0FpYkt1UGtn?=
 =?gb2312?B?aG81SGZMM21XazRDOG5oNXVBNlZrb0RiZllBL252ZmlEeDZpTGM1aVBqNDBB?=
 =?gb2312?B?bFBMT0lqekVnTldxV2ZWdVNoSU01MjBvNU54U1FPbXRCS09qZlc2UTRZSUJs?=
 =?gb2312?B?c0tiYnQxbHR1TkNtKzVMS2hGdlNSSFExTlVCTDNDQm5IUmx0QlpNU2lhZ080?=
 =?gb2312?B?VTlzZ1VVVGp2UklnNmR3Y3FrbVZFcEtCV0dnR1hLM2Jlck9QTlBMQ2JCNVli?=
 =?gb2312?B?VnEyR0dKVlhKSEoyUzFjYVZhUTZrcnQ0cnJUempJTUJvRHZjOU1iMWxjNGtz?=
 =?gb2312?B?MHA1dHI5L1pkVURVZWRmZzVqbkNzNnJnV1cwNmtmTUgxNDZjOFpSOE1ydDFi?=
 =?gb2312?B?cXFHdVlPejhiYnNwWXNPNkx0N05QdlVMc0NlMGE3TVg0ckZvdzhwQzZYbVJK?=
 =?gb2312?B?UmUrZUI2TUxhSVBPcVRMR0NnTjZPSUhLZnNnUmJhOHl4WlBkbmJ6SXVIbjRF?=
 =?gb2312?B?c2lZeUtRTldUYTRHMkt3MzNRblFkTWJDYklaSHB3RHUwdVA1a1JiUlNVdyti?=
 =?gb2312?B?T1o4cDk4VlovSXJyMnNFTTFqM1FCUERjUGNDNDcwRGkxRzh3R1BGbkdXdkdE?=
 =?gb2312?B?TmM2aThBZHRPcFptVWNoZ3k2KzkyUlplTXZ6VGJudHhxZWltVnl0R21kZFYx?=
 =?gb2312?B?aURSYjRTamwrMUduY2RxQkovLzNORnlES1JBck5EL0NOTk1xNjRFR2dKd2tT?=
 =?gb2312?B?S3g0bndWTjM0T1RJUmM3ZUVFR2o0Qm9WYkxiRUU2MmR3bk5CNGg5Uk9NbWVP?=
 =?gb2312?B?Rkt6Q3N4TFh6cDhQUXF3eERZMFFjSC9FQkJOUzFXeldQUDd3Qk5MMjZBVnhx?=
 =?gb2312?B?OXZYQzFDQ3c1MVBVTXY5aUxZWkNGZkhMV0dTRmpkdytQcHliODMrR1ZqOVkr?=
 =?gb2312?B?SUpXSVJ6VW1hS25iN0dlMlUvbXhrNjBCZU5WYTBMOGhBMy9rRGdqeEdiWFk0?=
 =?gb2312?B?THRuUXB1V1pwdEQ1aDljbldCaExLSDZsUGd2Z0s0Z2ZjNVFmSDI0dz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8796b095-8527-4657-4b29-08da34876de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 02:22:29.4679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcT36APMEpMG0V0LKYltvAO65b+uhrmeaANdt9dSEffBJfwwbopVi/v/CLDPJlrzYiVMDY1BvXZUunpVhLoCug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bzoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogMjAyMsTq
NdTCMTPI1SAwOjA5DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiBDYzogcC56YWJlbEBwZW5ndXRyb25peC5kZTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhl
bGdhYXNAZ29vZ2xlLmNvbTsNCj4gcm9iaEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3Jn
OyB2a291bEBrZXJuZWwub3JnOw0KPiBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOyBs
aW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyIDcvN10gUENJOiBpbXg2OiBBZGQgdGhlIGlNWDhNUCBQQ0llIHN1cHBv
cnQNCj4gDQo+IE9uIE1vbiwgTWFyIDA3LCAyMDIyIGF0IDA1OjA3OjM0UE0gKzA4MDAsIFJpY2hh
cmQgWmh1IHdyb3RlOg0KPiA+IEFkZCB0aGUgaS5NWDhNUCBQQ0llIHN1cHBvcnQuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAxOSArKysr
KysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBJIGV4cGVjdCB0aGlzIHNlcmllcyB3aWxsIGV2ZW50dWFsbHkg
Z28gdmlhIHRoZSBpbXg2IHBsYXRmb3JtIHRyZWUuDQo+IA0KPiBUbyBhdm9pZCB5b3Ugd2FpdGlu
ZyBmb3IgbWUgd2hlbiB0aGlzIHNlcmllcyBpcyBkZWVtZWQgYWNjZXB0YWJsZToNCj4gDQo+IEFj
a2VkLWJ5OiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4g
DQo+IEkgd2lsbCBtYXJrIGl0IGFzICJoYW5kbGVkIGVsc2V3aGVyZSIgaW4gdGhlIFBDSSB0cmVl
IHBhdGNod29yay4NCg0KVGhhbmtzIGZvciB5b3VyIGtpbmRseSBoZWxwLg0KTHVjYXMgaGFzIHNv
bWUgc3VnZ2VzdGlvbnMgYW5kIGFkdmljZXMgYWJvdXQgdGhlIEhTSU9NSVggYml0cyBtYW5pcHVs
YXRpb25zDQppbiB0aGUgUEhZIGRyaXZlciBvZiB0aGlzIHNlcmllcy4NCldvdWxkIGlzc3VlIHRo
ZSBuZXh0IHZlcnNpb24sIGFmdGVyIGNvLW9wZXJhdGUgd2l0aCBMdWNhcyBhbmQgc2V0dGxlLWRv
d24NCiB0aGF0IHBhcnQuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZA0KPiANCj4gTG9yZW56bw0K
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4
IGJiNjYyZjkwZDRmMy4uNGQzNGYwYzg4NTUwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTUxLDYgKzUxLDcgQEAgZW51bSBpbXg2X3BjaWVf
dmFyaWFudHMgew0KPiA+ICAJSU1YN0QsDQo+ID4gIAlJTVg4TVEsDQo+ID4gIAlJTVg4TU0sDQo+
ID4gKwlJTVg4TVAsDQo+ID4gIH07DQo+ID4NCj4gPiAgI2RlZmluZSBJTVg2X1BDSUVfRkxBR19J
TVg2X1BIWQkJCUJJVCgwKQ0KPiA+IEBAIC0zNzksNiArMzgwLDcgQEAgc3RhdGljIHZvaWQgaW14
Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkN
Cj4gPiAgCQlyZXNldF9jb250cm9sX2Fzc2VydChpbXg2X3BjaWUtPnBjaWVwaHlfcmVzZXQpOw0K
PiA+ICAJCWZhbGx0aHJvdWdoOw0KPiA+ICAJY2FzZSBJTVg4TU06DQo+ID4gKwljYXNlIElNWDhN
UDoNCj4gPiAgCQlyZXNldF9jb250cm9sX2Fzc2VydChpbXg2X3BjaWUtPmFwcHNfcmVzZXQpOw0K
PiA+ICAJCWJyZWFrOw0KPiA+ICAJY2FzZSBJTVg2U1g6DQo+ID4gQEAgLTQwNyw3ICs0MDksOCBA
QCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+ID4gaW14
Nl9wY2llICppbXg2X3BjaWUpICBzdGF0aWMgdW5zaWduZWQgaW50IGlteDZfcGNpZV9ncnBfb2Zm
c2V0KGNvbnN0DQo+ID4gc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKSAgew0KPiA+ICAJV0FS
Tl9PTihpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQgIT0gSU1YOE1RICYmDQo+ID4gLQkJaW14
Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50ICE9IElNWDhNTSk7DQo+ID4gKwkJaW14Nl9wY2llLT5k
cnZkYXRhLT52YXJpYW50ICE9IElNWDhNTSAmJg0KPiA+ICsJCWlteDZfcGNpZS0+ZHJ2ZGF0YS0+
dmFyaWFudCAhPSBJTVg4TVApOw0KPiA+ICAJcmV0dXJuIGlteDZfcGNpZS0+Y29udHJvbGxlcl9p
ZCA9PSAxID8gSU9NVVhDX0dQUjE2IDogSU9NVVhDX0dQUjE0Ow0KPiA+IH0NCj4gPg0KPiA+IEBA
IC00NDgsNiArNDUxLDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfZW5hYmxlX3JlZl9jbGsoc3Ry
dWN0IGlteDZfcGNpZQ0KPiAqaW14Nl9wY2llKQ0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJY2FzZSBJ
TVg4TU06DQo+ID4gIAljYXNlIElNWDhNUToNCj4gPiArCWNhc2UgSU1YOE1QOg0KPiA+ICAJCXJl
dCA9IGNsa19wcmVwYXJlX2VuYWJsZShpbXg2X3BjaWUtPnBjaWVfYXV4KTsNCj4gPiAgCQlpZiAo
cmV0KSB7DQo+ID4gIAkJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGVuYWJsZSBwY2llX2F1eCBj
bG9ja1xuIik7IEBAIC01MDMsNg0KPiA+ICs1MDcsNyBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9j
bGtfZW5hYmxlKHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPg0KPiA+ICAJc3dpdGNo
IChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gPiAgCWNhc2UgSU1YOE1NOg0KPiA+
ICsJY2FzZSBJTVg4TVA6DQo+ID4gIAkJaWYgKHBoeV9wb3dlcl9vbihpbXg2X3BjaWUtPnBoeSkp
DQo+ID4gIAkJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIHBvd2VyIG9uIFBIWVxuIik7DQo+ID4g
IAkJYnJlYWs7DQo+ID4gQEAgLTYwMyw2ICs2MDgsNyBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9k
ZWFzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPiAg
CQlyZXNldF9jb250cm9sX2RlYXNzZXJ0KGlteDZfcGNpZS0+cGNpZXBoeV9yZXNldCk7DQo+ID4g
IAkJYnJlYWs7DQo+ID4gIAljYXNlIElNWDhNTToNCj4gPiArCWNhc2UgSU1YOE1QOg0KPiA+ICAJ
CWlmIChwaHlfaW5pdChpbXg2X3BjaWUtPnBoeSkpDQo+ID4gIAkJCWRldl9lcnIoZGV2LCAid2Fp
dGluZyBmb3IgcGh5IHJlYWR5IHRpbWVvdXQhXG4iKTsNCj4gPiAgCQlicmVhazsNCj4gPiBAQCAt
Njc4LDYgKzY4NCw3IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9pbml0X3BoeShzdHJ1Y3QgaW14
Nl9wY2llDQo+ID4gKmlteDZfcGNpZSkgIHsNCj4gPiAgCXN3aXRjaCAoaW14Nl9wY2llLT5kcnZk
YXRhLT52YXJpYW50KSB7DQo+ID4gIAljYXNlIElNWDhNTToNCj4gPiArCWNhc2UgSU1YOE1QOg0K
PiA+ICAJCS8qDQo+ID4gIAkJICogVGhlIFBIWSBpbml0aWFsaXphdGlvbiBoYWQgYmVlbiBkb25l
IGluIHRoZSBQSFkNCj4gPiAgCQkgKiBkcml2ZXIsIGJyZWFrIGhlcmUgZGlyZWN0bHkuDQo+ID4g
QEAgLTgyMyw2ICs4MzAsNyBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfbHRzc21fZW5hYmxlKHN0
cnVjdCBkZXZpY2UNCj4gKmRldikNCj4gPiAgCWNhc2UgSU1YN0Q6DQo+ID4gIAljYXNlIElNWDhN
UToNCj4gPiAgCWNhc2UgSU1YOE1NOg0KPiA+ICsJY2FzZSBJTVg4TVA6DQo+ID4gIAkJcmVzZXRf
Y29udHJvbF9kZWFzc2VydChpbXg2X3BjaWUtPmFwcHNfcmVzZXQpOw0KPiA+ICAJCWJyZWFrOw0K
PiA+ICAJfQ0KPiA+IEBAIC05MzgsNiArOTQ2LDcgQEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2hv
c3RfZXhpdChzdHJ1Y3QgcGNpZV9wb3J0DQo+ICpwcCkNCj4gPiAgCQlpbXg2X3BjaWVfY2xrX2Rp
c2FibGUoaW14Nl9wY2llKTsNCj4gPiAgCQlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFy
aWFudCkgew0KPiA+ICAJCWNhc2UgSU1YOE1NOg0KPiA+ICsJCWNhc2UgSU1YOE1QOg0KPiA+ICAJ
CQlpZiAocGh5X3Bvd2VyX29mZihpbXg2X3BjaWUtPnBoeSkpDQo+ID4gIAkJCQlkZXZfZXJyKGRl
diwgInVuYWJsZSB0byBwb3dlciBvZmYgcGh5XG4iKTsNCj4gPiAgCQkJcGh5X2V4aXQoaW14Nl9w
Y2llLT5waHkpOw0KPiA+IEBAIC05NzIsNiArOTgxLDcgQEAgc3RhdGljIHZvaWQgaW14Nl9wY2ll
X2x0c3NtX2Rpc2FibGUoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiA+ICAJCWJyZWFrOw0KPiA+
ICAJY2FzZSBJTVg3RDoNCj4gPiAgCWNhc2UgSU1YOE1NOg0KPiA+ICsJY2FzZSBJTVg4TVA6DQo+
ID4gIAkJcmVzZXRfY29udHJvbF9hc3NlcnQoaW14Nl9wY2llLT5hcHBzX3Jlc2V0KTsNCj4gPiAg
CQlicmVhazsNCj4gPiAgCWRlZmF1bHQ6DQo+ID4gQEAgLTEwMjgsNiArMTAzOCw3IEBAIHN0YXRp
YyBpbnQgaW14Nl9wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGRldmljZQ0KPiAqZGV2KQ0KPiA+
ICAJaW14Nl9wY2llX2Nsa19kaXNhYmxlKGlteDZfcGNpZSk7DQo+ID4gIAlzd2l0Y2ggKGlteDZf
cGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiA+ICAJY2FzZSBJTVg4TU06DQo+ID4gKwljYXNl
IElNWDhNUDoNCj4gPiAgCQlpZiAocGh5X3Bvd2VyX29mZihpbXg2X3BjaWUtPnBoeSkpDQo+ID4g
IAkJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIHBvd2VyIG9mZiBQSFlcbiIpOw0KPiA+ICAJCXBo
eV9leGl0KGlteDZfcGNpZS0+cGh5KTsNCj4gPiBAQCAtMTE3Nyw2ICsxMTg4LDcgQEAgc3RhdGlj
IGludCBpbXg2X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4g
PiAgCQl9DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAljYXNlIElNWDhNTToNCj4gPiArCWNhc2UgSU1Y
OE1QOg0KPiA+ICAJCWlteDZfcGNpZS0+cGNpZV9hdXggPSBkZXZtX2Nsa19nZXQoZGV2LCAicGNp
ZV9hdXgiKTsNCj4gPiAgCQlpZiAoSVNfRVJSKGlteDZfcGNpZS0+cGNpZV9hdXgpKQ0KPiA+ICAJ
CQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoaW14Nl9wY2llLT5wY2llX2F1eCks
IEBADQo+IC0xMzI3LDYNCj4gPiArMTMzOSwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDZf
cGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDhNTSwNCj4g
PiAgCQkuZmxhZ3MgPSBJTVg2X1BDSUVfRkxBR19TVVBQT1JUU19TVVNQRU5ELA0KPiA+ICAJfSwN
Cj4gPiArCVtJTVg4TVBdID0gew0KPiA+ICsJCS52YXJpYW50ID0gSU1YOE1QLA0KPiA+ICsJCS5m
bGFncyA9IElNWDZfUENJRV9GTEFHX1NVUFBPUlRTX1NVU1BFTkQsDQo+ID4gKwl9LA0KPiA+ICB9
Ow0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteDZfcGNpZV9v
Zl9tYXRjaFtdID0geyBAQCAtMTMzNiw2DQo+ID4gKzEzNTIsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCBpbXg2X3BjaWVfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAgCXsgLmNvbXBh
dGlibGUgPSAiZnNsLGlteDdkLXBjaWUiLCAgLmRhdGEgPSAmZHJ2ZGF0YVtJTVg3RF0sICB9LA0K
PiA+ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLXBjaWUiLCAuZGF0YSA9ICZkcnZkYXRh
W0lNWDhNUV0sIH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bW0tcGNpZSIsIC5k
YXRhID0gJmRydmRhdGFbSU1YOE1NXSwgfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlt
eDhtcC1wY2llIiwgLmRhdGEgPSAmZHJ2ZGF0YVtJTVg4TVBdLCB9LA0KPiA+ICAJe30sDQo+ID4g
IH07DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
