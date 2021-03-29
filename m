Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B93434C0EB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 03:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhC2BPY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 21:15:24 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:37614
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhC2BPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Mar 2021 21:15:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS80T0Xya2Wg3NJyIjJaoTzTb0Wxij3eAq1ap5lr3JD8ZJsJS4zwXnHM8iiiqKsXMN43zOn4PvF4VZ1qgR5iR34AWU8zu2U3QaEAcz7Tr4jZgC+SND1grHiN0az08U4XWOSyhK/UrqD9bnEn9znJ8WQmSflnntoUVy4h2CF7aJWRjUyky5P4YY0Z4QPLePLygl/kAc64tW7ay4qEKVXQ/kzznBpfc3BkuTbZzUx6fdc5PVugD7ykzm5GUe5mKHEwOspYKRm1ZdjutqRXVyIC5jAo78lpUMqPyYfhiwATAsZLniGJCeGXATDH+AbM701VPZlsmYyA12wRv4lq1rT54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE36iYSSLnj1RBhe1bCQ8x9zNu9FTH8d+OZTbEcGyqA=;
 b=VcWLfin63/W5aO7ENKbqDUDLbklj8l2ec8R5Qf/Tecxu/HfPJEMCBnEagcR2c9yhKBgaZQityBVgGEEEZURTWMTwasKCq/QjTLrmixMcyR1enZybeEc/d5JL/8I307F3CWyt1vRpMOzYmeta7AK+vvxnyDlWJGW9mv37e8WQ87uDsCG6j4a6/hR+m80/gwVCykWOXElQ2+ROKWYoMlYHFjVPpBIcAL1aa29InW5of80VTiK+iqe0gsmbI8Is3v3+v+HEgt6I1SJI5/EwBV/qbU1aVec1Pmmf9DQG1/5XGSieUF+4+zThQauBXhv6Fa3MYJQJ/GfHL8O8BvTGG1rpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE36iYSSLnj1RBhe1bCQ8x9zNu9FTH8d+OZTbEcGyqA=;
 b=jv5l4H9rT99wlLvk1nGXYB/s1Jg0y0+Dm89YGusR46RL2H2iBTbeeGZX9jQQQECFsHOExrSCmfq49i2xNO2rg8G6M18gPqiRNWOcOPYn4j+eDFf+kbxV+Ys/z6XkyBIj2cApq99eUk69X0C3yPx//HKzsoUun1amcFJ3k1Y0Dcg=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 01:15:12 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f%7]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 01:15:12 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE:Re: [PATCH v3 1/3] dt-bindings: imx6q-pcie: add one regulator used
 to power up pcie phy
Thread-Topic: Re: [PATCH v3 1/3] dt-bindings: imx6q-pcie: add one regulator
 used to power up pcie phy
Thread-Index: AdckOG9drEkWE7caSve0kTbgIr6taA==
Date:   Mon, 29 Mar 2021 01:15:12 +0000
Message-ID: <VI1PR04MB585349177EF9BCA1359F43708C7E9@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ba8934c-fdfb-47c2-da33-08d8f2501a15
x-ms-traffictypediagnostic: VE1PR04MB6638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6638D812C277FD8341FC6D638C7E9@VE1PR04MB6638.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFbAiREAuXzV0XDbBJLS3ozd/qiKoTaXFemUdBUamu8PBchRD6KPBTFeuvdwLd4KLHHzkQy1ArfMw76vVduODAQsyJctQlBVQn0axgHVQwM9hFte7BjYNYO/hdTlr0rGVSbqNrceOOeS7Q+WMAQM7CGsTaDzxa0uDgqP4nW2Qa+LuAjMvOPvG1FnHwJ6tOazpQ66xYE4q5njuCR1fBZloqCOegudtNBY/facAS6d3pvtmWjkx5LgCvpS/4WgVCIinBFHmxNJwVWrL8Sac+uTwYs69Gev8PGcnCOJgHX7b+98ranzi7NFVSjNRgkxnv/ui/oRjXon21X7WzfMZb7Eku7JHTYx02LvOlk2/CLTOZ9x4yk2uJ+oEBOW62jTivc4v37P2CjxBWOTXIRWIvo4X+lZOsHjqxg/PqxbSp1y8KNFCVxuBFDsRm+kq9vNXhuX7EOIQuMOW8rjkU0SK6iO05zwSJx4GyFJR/qVY9H86VkRwWeIaNUUm1MK0Ku5vu8KRK2FOInj9B83iTeL0pnRdgHOevDCzMPwOlvhXbmIMbQVRCXha90JDEOBIEYlTrgp2rkI4W9MJdzulg3pnOEuvdgVt7nCYT2FjF4qAsXcPwr6toQ/avDS2m5u7hXttPJZdydze1z1W1zFgfAIyb4etfSkwjGxeWOA4tmupZr3+kTs1PwfZ8kMnLdNLqvQbWkf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(76116006)(66946007)(66476007)(66556008)(186003)(8936002)(6506007)(38100700001)(2906002)(53546011)(7696005)(83380400001)(8676002)(316002)(52536014)(26005)(86362001)(33656002)(64756008)(66446008)(110136005)(54906003)(478600001)(4326008)(71200400001)(5660300002)(7416002)(9686003)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YzNiSzhoVjRuVVV4dUd4aU93bUgyd1M2TUtHM05NVzFTc0tvRVkrNmJGb0pI?=
 =?utf-8?B?N3dDdkdpY0JNQ0pnQzhxRG92S1kxcW1tVGxVMG1FbktYYXhuV1oyZnhJQ3Ur?=
 =?utf-8?B?dS9QMTI2T01uY21samJnSVNLK2ZwTFQxVDhTemZISnNzejN5cmUvdGRVN3cr?=
 =?utf-8?B?YzBIOExKUGhUM3d2V2NZTzYraWdOQWFlT2djYzMxK09hQTNBRkdXNlhQSEM0?=
 =?utf-8?B?SENpeVIxR3l5UUFLQ3E1OEdMdTI2SjNkYlc3ZCtFYjdITWphd2huWUszd2dy?=
 =?utf-8?B?WWpUMkdVVVhVRHc5Y0dtbDRHRWVGQnZ0YXp5QVBKdWNxYW45cmM2andiMFZv?=
 =?utf-8?B?cjZ4RUF0aWFSdkladERkeU9odlBHSmx4bjZUUXJiUzJoc0krbGd0bHhlMy81?=
 =?utf-8?B?S2JIQmc0NjZ4ZG9mSDc1dmgwSnR6Q1J2MUJscnVjRHlTUjJ4a0pVN3lFd1NC?=
 =?utf-8?B?bzBGcnZxckdISktWNklLN2ZLQm5YWU9EWGNwQ1lQbEhWclYxT0dvL0V1Mjk2?=
 =?utf-8?B?QVNRZkZjejRJc1RhbTh0aW9MSzVzTFV2elhtR1kxZ1JOaVNGSktCY0FSVzNl?=
 =?utf-8?B?MlZ0eUFHRWtGQzJGR0ovcHdwbGp1V01mVXRWWmRPQTI0YzVCNmNuLzhoZlJm?=
 =?utf-8?B?elE5WVYrVUZsM0huc25mV3crZ1BpMkRQckRENUxQbGdXUzRTOVRuUXpKdUpC?=
 =?utf-8?B?QWI1LzV2d1BKcnlrVzJ0OVBzcVhOTHpLanRvNXYzUzNRVWtoa2lOT211bkZB?=
 =?utf-8?B?dFBlZWtjcGJPM250aEQwcUhCSmV0OHZZYnRjREJoc0FOU3U1QTFxVDRYNUp1?=
 =?utf-8?B?QXVvbWJFOVRhdFprWjFhZWt2MGhvU3VYODJQNFBucytzeWtsSVdmTXdXVzZ1?=
 =?utf-8?B?aTRuM3Z2aDBJTmE5NC9NZjB4TXc3TFVEMjFuQU9xQ25QaUlZeXZRTTVYbmds?=
 =?utf-8?B?RmhZUU16M044ZEFsdStzSzRVYVg1NGdGVE90dFBhYnBtR2VIY0tyZG9ZSjdT?=
 =?utf-8?B?bnVEbTJWU0pWanN6Y0Ztblg2YS95ZmljVGJiTDBhdlFVNWtyeUJQamVPZjdk?=
 =?utf-8?B?TFRDMitSalVzbXMxLy9IdEpYWkF1UXJZd1l1dHBGbmU3YlI3TXRoYW9pOUp6?=
 =?utf-8?B?VSt2M211anJDNnJmYWRBdVE3dk40dzNHdys2c2l0ZkVBSXJQdElOZGxIZjdF?=
 =?utf-8?B?cDlicnJiQVA2RjNqQU5IQ3RmaDRGSm9ndXF1Zy90Z1drdi81cjBSWWRMZGNV?=
 =?utf-8?B?NFYvTDBBRytOWGdEWHZCTDBEeVpUbWMyU05iU2tQbUZZdkVUQXM4OUtwTWh5?=
 =?utf-8?B?MHkyQ1hHcnp1VDQ5b05vVzFNVDRneVZIWUhpaU5keEQxbTYzT0pzUkNOeXhs?=
 =?utf-8?B?QnBiQVNvNWViNm9mYUlzRHhmRFN6d1FJQ1dsU1ZXY2QrVWlqVUhLcytveEJk?=
 =?utf-8?B?VXhzcW5MZDV6UDRVbXhEbDYxQkxSTUVrQnJxNVlwaFlOSHd1M3Zkc24vQ09R?=
 =?utf-8?B?YkVnamM3bHROV21aUlYwWk9Gb2VSZDRDTEQrNFl5bVhrUkFFbkNPRUorT3hu?=
 =?utf-8?B?MjZLaUFzSHNTU2tFZDB6UlhtUU1wRDc1SUFvZ29QV2ZmdjNMM3NmdzlkWmxF?=
 =?utf-8?B?bVg3bXhrcnRFRWdxRVhvNHR3cTJzY3VWb3hKdndtMTJrV3FyUGszSkR6VzEx?=
 =?utf-8?B?RlA2cWpmL01oYU1UY29KWE5EbmNNTnVmdDkzNkUrRGJhbTNBQlJZYklXc1d4?=
 =?utf-8?Q?wKdUNJqSrWGm6iSoosXWeNIPy/6eBO0UVksMjIz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba8934c-fdfb-47c2-da33-08d8f2501a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 01:15:12.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBPmjP/11uiwpwbTWzgenRSwzAinxJoYvGngVag8727iVdQlndji/nqpW3K740bEpuIBmt4QgE9iLnJgRKiT6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6638
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyNiwgMjAyMSA1OjM4IFBN
DQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBhbmRyZXcuc21pcm5v
dkBnbWFpbC5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgYmhlbGdh
YXNAZ29vZ2xlLmNvbTsNCj4gc3RlZmFuQGFnbmVyLmNoOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0u
Y29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzNdIGR0LWJpbmRpbmdzOiBpbXg2cS1wY2llOiBhZGQg
b25lIHJlZ3VsYXRvcg0KPiB1c2VkIHRvIHBvd2VyIHVwIHBjaWUgcGh5DQo+IEFtIERvbm5lcnN0
YWcsIGRlbSAyNS4wMy4yMDIxIHVtIDE2OjQ0ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+
ID4gQm90aCAxLjh2IGFuZCAzLjN2IHBvd2VyIHN1cHBsaWVzIGNhbiBiZSB1c2VkIGJ5IGkuTVg4
TVEgUENJZSBQSFkuDQo+ID4gSW4gZGVmYXVsdCwgdGhlIFBDSUVfVlBIIHZvbHRhZ2UgaXMgc3Vn
Z2VzdGVkIHRvIGJlIDEuOHYgcmVmZXIgdG8gZGF0YQ0KPiA+IHNoZWV0LiBXaGVuIFBDSUVfVlBI
IGlzIHN1cHBsaWVkIGJ5IDMuM3YgaW4gdGhlIEhXIHNjaGVtYXRpYyBkZXNpZ24sDQo+ID4gdGhl
IFZSRUdfQllQQVNTIGJpdHMgb2YgR1BSIHJlZ2lzdGVycyBzaG91bGQgYmUgY2xlYXJlZCBmcm9t
IGRlZmF1bHQNCj4gPiB2YWx1ZSAxYicxIHRvIDFiJzAuIFRodXMsIHRoZSBpbnRlcm5hbCAzdjMg
dG8gMXY4IHRyYW5zbGF0b3Igd291bGQgYmUNCj4gPiB0dXJuZWQgb24uDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+
ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUu
dHh0IHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNs
LGlteDZxLXBjaWUudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL2ZzbCxpbXg2cS1wY2llLnR4dA0KPiA+IGluZGV4IGRlNGIyYmFmOTFlOC4uZTZkMTg4NjE0
NGNlIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvZnNsLGlteDZxLXBjaWUudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS50eHQNCj4gPiBAQCAtMzgsNiArMzgsOSBAQCBP
cHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICAgIFRoZSByZWd1bGF0b3Igd2lsbCBiZSBlbmFibGVk
IHdoZW4gaW5pdGlhbGl6aW5nIHRoZSBQQ0llIGhvc3QgYW5kDQo+ID4gICAgZGlzYWJsZWQgZWl0
aGVyIGFzIHBhcnQgb2YgdGhlIGluaXQgcHJvY2VzcyBvciB3aGVuIHNodXR0aW5nIGRvd24gdGhl
DQo+ID4gICAgaG9zdC4NCj4gPiArLSB2cGgtc3VwcGx5OiBTaG91bGQgc3BlY2lmeSB0aGUgcmVn
dWxhdG9yIGluIGNoYXJnZSBvZiBWUEggb25lIG9mDQo+ID4gK3RoZSB0aHJlZQ0KPiA+ICsgIFBD
SWUgUEhZIHBvd2Vycy4gVGhpcyByZWd1bGF0b3IgY2FuIGJlIHN1cHBsaWVkIGJ5IGJvdGggMS44
diBhbmQNCj4gPiArMy4zdiB2b2x0YWdlDQo+ID4gKyAgc3VwcGxpZXMuIE1pZ2h0IGJlIHVzZWQg
dG8gZGlzdGluZ3Vpc2ggZGlmZmVyZW50IEhXIGJvYXJkIGRlc2lnbnMuDQo+IA0KPiBQbGVhc2Ug
anVzdCBnZXQgcmlkIG9mIHRoZSBsYXN0IHNlbnRlbmNlLiBBbGwgRFQgcHJvcGVydGllcyBhcmUg
dXNlZCBpbiBvbmUgd2F5DQo+IG9yIHRoZSBvdGhlciB0byBkaXN0aW5ndWlzaCBkaWZmZXJlbnQg
SFcgZGVzaWducywgc28gbm8gbmVlZCB0byBtZW50aW9uIHRoaXMuDQpbUmljaGFyZCBaaHVdIFRo
YW5rcywgd291bGQgcmVtb3ZlIHRoZSBsYXN0IHNlbnRlbmNlIGxhdGVyLg0KPiANCj4gUmVnYXJk
cywNCj4gTHVjYXMNCg0K
