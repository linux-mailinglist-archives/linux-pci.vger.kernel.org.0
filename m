Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF34C24B7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 08:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiBXHvA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 02:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiBXHu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 02:50:59 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10057.outbound.protection.outlook.com [40.107.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFEF17E366;
        Wed, 23 Feb 2022 23:50:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwyC/LJK4AvNizPoc2BG1p3odStL2HtQTO8fHwsdxJAo5A0Yt+1qa3PS2xSeHyMaZsFKeBiVnTfMaRZ78D0xaQUu3sutVUkdh8X0hu+AkbpOyN3BogT8ZpYuU7tQETeRYdUgTNdOS4WNqUKHVzxnz7U7lteMD+U2932dotS/sFiP2VqK06N82DsRI0Dq27UaTB7oJqyj1MHxfTg87oBI8834AKsPJWsFgmAcgkzVlutKHim80kCRv5BOZBYyp0e7ZHUxaj5UhAM+pEwxpR9MfeBnmY2WO1STBfjvN5qdcYCuRcmn0Lj0m2x6Y4SV/MrKnxdzUaUrBlipXJoUHu2niQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9L/ifElCo1zV2DlANRDwSHKlgY8yVK0k/EjERmc7+c=;
 b=FmAKrv3z5O4hFsFErDLxRVcrN1qM/GdX5CNOmINi5qsLiAeSJhbWBaojLDjv41HAiGdkFVeTm38pisc8aVc0bVfsJxYw9Y7jhJQa6GFXKnlczXxCxNEagnmRe6S03NRryvkkhW/8ZWg9A7qgpORKmLYnJ5zKIGTH5rZ002TQd2KZIEL3zv6pPIPkBOfrChw1C5oYMmB4UaFw1pdRFU8P+giVDboGgBVz9v5HlJky36lMiuIIn3prRI7D0DNBjirINEoIUQ/wcvwNc7aVWOY4oOqFiN4rsLEM52bIyl8zAnpvly9NPfrziihdlv4N1NNGXzX1yMZ6syOOO8ERuzTDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9L/ifElCo1zV2DlANRDwSHKlgY8yVK0k/EjERmc7+c=;
 b=m255Pytusnd+Vqtsl+68309N3dgwQMjiT6ULldyy+cS+ErPdaFvt5Z4wx1GxWqR/G+E6KbeJrGm2Jr0fKsUMdc/7AKpXFQP6ZiBiWdM4qO6Rfs8OJbZxwPlhUBrHY3igWbreF+Ctt0c4qN84azGj1JyrNW0iN9elPk3d3Z1PO5s=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB7PR04MB4044.eurprd04.prod.outlook.com (2603:10a6:5:1b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 07:50:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 07:50:25 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
 callback
Thread-Topic: [PATCH v7 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
 callback
Thread-Index: AQHYIwHVTtMWrPSOw0yOEQvP0raQSqyhdXIAgADXGjA=
Date:   Thu, 24 Feb 2022 07:50:25 +0000
Message-ID: <AS8PR04MB8676315428521976BD804D858C3D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644992463-14467-7-git-send-email-hongxing.zhu@nxp.com>
 <20220223174940.GA140379@bhelgaas>
In-Reply-To: <20220223174940.GA140379@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ef4fd8e-f94a-4f46-dd0b-08d9f76a516d
x-ms-traffictypediagnostic: DB7PR04MB4044:EE_
x-microsoft-antispam-prvs: <DB7PR04MB4044DA6790087CAD910196178C3D9@DB7PR04MB4044.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g7EznaryMKDGFhlr7UEHPjRRq25ADxGZ4REZUFPOs/SKNDtPtHw6KEqZy0xpQhvsCN0FpyA5F07NSYITzAoqMqIvmt5w3zPAvftY5Gx+qgx0QVKK4Fk7cGLAMcFuBki3iVdEDvytVeJpY4mQ/8PORYM5eQKnbGjI970V80mSFitb8kcoSFpYFsM51zazWpgGCJOp/hhRFrZHge5Mmfs7ruyBfGDGNOr5LEuqJPzfWMcfAe0m13kjz6nTwvgLqilJCqCk6mc/AvGbnjwQ+jmCyvd7jQ7FZwwCRgY6TUHN0N6uLBM+uWR4m6LHMwTgCDRU/KydCeYnB3vq4ZZ6eAVL+dYX2ifJL2EsemuHAq7i5ygEy5jmjgG22f4Mi8ltbrxjwaYXLsl+n7AuNMkreeWFkNHT566mTKyUMPyU3m97XQ0dc5+/+ph3oMncMmHy0O+Fr5Q//Fn363asHCkwVWO6PdHgQNfZts+PNe4H//w89WjgBK4O3nzF+/3xk/gf6BixZgfVoOSBkgBrwjNOfAL7TvBBPcr8R4ip4w3pgmBiS5HhOMFDWAwR2n/DzfDGFHaiF55tKWT6CX/68FM+M9bL0NVDhEzRxR8R+NzxS3FbpzI1FZde/h3ohN3+nNTzY1XjM1F8adAB1Iy6UXfpTSQW2ghROv5wFT8TH47D30q3T4RnXKhvia0YhNafJSvYhNSCb8PveUApWLShcjBMg5G3aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(4326008)(38070700005)(64756008)(66946007)(8676002)(76116006)(86362001)(38100700002)(7416002)(66476007)(5660300002)(52536014)(66556008)(8936002)(122000001)(44832011)(2906002)(66446008)(26005)(186003)(71200400001)(53546011)(6506007)(7696005)(9686003)(508600001)(316002)(6916009)(83380400001)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?M0FjTEE4U1pXeWZNVlBBY1ZvSTNTd0t4OFJPY01MUUs0bm1oYmVKNS8vUEpU?=
 =?gb2312?B?K2p6dTFSRkgxQTlaUGV5dzRpWnB4UzVqZFRHWUpkK3ZwNlkwUU5FeXFoSzJF?=
 =?gb2312?B?VXowaVFIeE1ERVJMTVZwaDltQjAvMUM2eTFyRUdhZ1RnV0pCbEVKME1QclJB?=
 =?gb2312?B?Ti9aR0M5OUhZS3ZBR3NpQmJJRHdWY1RxZGNJSzQ1NTJ5ZDNZazdydjhEVTVh?=
 =?gb2312?B?SkxEMWpXcDFwOVUwTXU2bThqSm82UGxMNlgyWUF2eG5FUkhLak9wamtORHFl?=
 =?gb2312?B?UGlQVlRrNW5KV0ZxVWJ5aEYzeHNDR2VrOHBDTWQ1NW1kZG5lV3lrZnV6eStD?=
 =?gb2312?B?MkRjbkVrUVN1b01HQUZ0TFd1dDFQWlhHNjc3akUwYW4zT1NmVjd1Y3ZRMDRC?=
 =?gb2312?B?ckdyZWE0WjV6QmVSNjlRZldrZll4clViNUNGbXVESW5iVlVIRVJpNThRc3Er?=
 =?gb2312?B?QzVZYXBBM2o5d0Q4R2JlTnczSUNqenBtYm41RWxMSFRIZElVOTl3UVlqQUJU?=
 =?gb2312?B?QkY3azRVQXA0UytqQWo5bjB3WEM5ZDVjWnloeWNkZFdjYmJEdDFpU0s2RVdq?=
 =?gb2312?B?K1FYS2VrYzFHd2R5NmV1YzRPNkF4cWgyZ1ljSHpqZkF5cFJPZXA3UWJxNjBG?=
 =?gb2312?B?blU5UFY5Y3lIbWFBc0JvVW1xMnMvS0JqdFVpNm1UYXNQL1JDMC9wd0pjTmRQ?=
 =?gb2312?B?Z3Bhc1BLbUd2bmd6T1d2OVFmRHU4STBzUmFMSCsybEdTbXlweTN2V2dzMVJM?=
 =?gb2312?B?WDJFdittQ0NsQTJMaHBLckFCTnQvdG1KcTl5dUc1VFV2L2pQTm1CTFJDQ1JI?=
 =?gb2312?B?OHIza3c0RFM2TE81SVBZRWhyMGpSOTdOMnQ5Y0hYRFZORWNMK2hpNnZKTVVZ?=
 =?gb2312?B?ZzBkUDNsc3FvbWhuTVByM3JCZzRKVWlSQXE4S0M3MFduWUhHYzJqWXFVVXBp?=
 =?gb2312?B?d2ovMUJIRzZoTHQ4RTh0NVh2R1RiNWt5MTR2V1dqKzU5YnZDRUlaT0hLcDhz?=
 =?gb2312?B?UHYrd1VuWGNDOUYyYktpUE51YmQwdzIxNW1nMlk3RWNoSDhlYXVrVW5IQTha?=
 =?gb2312?B?a08rbTBjWEpaRlJoQ0RxWXlwRzlMUWM4N0hpTm1MTmhQVVBsa3ZXMExEcWQz?=
 =?gb2312?B?OC9DM2d5cFZhOHlSWHAyNnBUdWp4WUVOUEFGQnlZcXN6RnlaSS9GRERJZXIy?=
 =?gb2312?B?K0xtVXFxVXB5MUZ3cmgvMGxPTWtOL2hYbkNIbXQrYzZRQngzL3VxVEZVMk9K?=
 =?gb2312?B?cEU3R0xNUGk1ZWZrL0k4NzRsNHQ2eDUxODczUTlXTmFEQTVhTVRHMmRlNi84?=
 =?gb2312?B?WlhySzVhSDlaTU9jcWZ0ZlBkejBpYjBDdEpoZGlTNFRZeFgzeUhhMFV1WlVL?=
 =?gb2312?B?c08wTFpJVVlXVEVGb1I1ZWM2akhzemxXV3RjUVFSbndUdysyV1BjbFVzYU9v?=
 =?gb2312?B?enRMQ3NzanBWbzR3Y3ZuRkYrd2xUTE0wZmxNZit4VzdtOFJLRTVDUkRjeGg4?=
 =?gb2312?B?WitycEVyYTR1eG9yNm8vY1owLzJyam01dmRVd3RKRGN0NC85bnA0SUxLaUdu?=
 =?gb2312?B?cFBydzNsWmVkaXpGcXdlTWloZ2k3eHdNQzduQU9uSXdYQyt5Tm8rWjMzRGpQ?=
 =?gb2312?B?S1RoeXJjaDZJOU53Q3hZVUJIeEh6S0JVT3RaZFd3eFlpVm54dnBNNVRZQXl2?=
 =?gb2312?B?aEVpQlkyZk45NE9yTGZaZ2tLSkgyTzBjT3VLUmFlaGJZMkdqZFhWQWVsQVdr?=
 =?gb2312?B?Wk0zc3JDVVhyaVlHOTBXbTAxeDdvNFdJbmxvMEo1M1huTGo3anE0QjY1ZEsx?=
 =?gb2312?B?WkdBRGZ6Z0ZZaU5QNk1DMXpVa2d2T2RYRkNWN1FrVy9FSDJ2TTM1aWM4YTZN?=
 =?gb2312?B?cjFINkI2QVVJSnNkay9FVTZUU1AvcXFBaUxWanNNcmJobnZldExkeGx5Qm5O?=
 =?gb2312?B?TXlSYUl4Q3p0Y1BZMGlha09tTi9VRnI2blRkVzZRRWcxSHVYM2I1VjRBRFFo?=
 =?gb2312?B?VERTSytUeE1KQU5BMjVxc3llZ0xTOUMrVGZlbDFjcXVPS01WRWkzUHY3bkFD?=
 =?gb2312?B?Y3N5bjVxMDU5N3JORWZNampQekxrcTg2cHQ3MjdEdS9zRUpyNG9DMC9CYzRp?=
 =?gb2312?B?djVFWHVKbGZveXMwb3VOcTg2NXVCTkpzTmVvSktqWVdPcjg2S1BoTytKMnVa?=
 =?gb2312?B?c2c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef4fd8e-f94a-4f46-dd0b-08d9f76a516d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 07:50:25.3759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ct7YeBHKeDJ5ltUgYu/WE2mGJZi78Z2lyf8ErCBZJmTkvpx6Yt8Fst4/A8rHC7kQK0M0URkEzynMJzY60+ub+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4044
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jLUwjI0yNUgMTo1MA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IGZlc3RldmFtQGdtYWlsLmNv
bTsNCj4gZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDYvOF0gUENJ
OiBkd2M6IEFkZCBkd19wY2llX2hvc3Rfb3BzLmhvc3RfZXhpdCgpDQo+IGNhbGxiYWNrDQo+IA0K
PiBPbiBXZWQsIEZlYiAxNiwgMjAyMiBhdCAwMjoyMTowMVBNICswODAwLCBSaWNoYXJkIFpodSB3
cm90ZToNCj4gPiBXaGVuIGxpbmsgaXMgbmV2ZXIgY2FtZSB1cCBpbiB0aGUgbGluayB0cmFpbmlu
ZyBhZnRlciBob3N0X2luaXQuDQo+ID4gVGhlIGNsb2NrcyBhbmQgcG93ZXIgc3VwcGxpZXMgdXNh
Z2UgY291bnRlciBiYWxhbmNlIHNob3VsZCBiZSBoYW5kbGVkDQo+ID4gcHJvcGVybHkgb24gc29t
ZSBEV0MgcGxhdGZvcm1zIChmb3IgZXhhbXBsZSwgaS5NWCBQQ0llKS4NCj4gPg0KPiA+IEFkZCBh
IG5ldyBob3N0X2V4aXQoKSBjYWxsYmFjayBpbnRvIGR3X3BjaWVfaG9zdF9vcHMsIHRoZW4gaXQg
Y291bGQgYmUNCj4gPiBpbnZva2VkIHRvIGhhbmRsZSB0aGUgdW5iYWxhbmNlIGlzc3VlIGluIHRo
ZSBlcnJvciBoYW5kbGluZyBhZnRlcg0KPiA+IGhvc3RfaW5pdCgpIGZ1bmN0aW9uIHdoZW4gbGlu
ayBpcyBkb3duLg0KPiANCj4gUG9zc2libGUgcmV3b3JkaW5nLCBub3Qgc3VyZSBpZiBpdCBjYXB0
dXJlcyBldmVyeXRoaW5nIHlvdSB3YW50Og0KPiANCj4gICBXaGVuIHRoZSBsaW5rIG5ldmVyIGNv
bWVzIHVwIGFmdGVyIC0+aG9zdF9pbml0KCksIHNvbWUgZHJpdmVycywNCj4gICBlc3BlY2lhbGx5
IHRob3NlIHRoYXQgZG9uJ3Qgc3VwcG9ydCBob3RwbHVnLCB3YW50IHRvIHR1cm4gb2ZmIGNsb2Nr
cw0KPiAgIGFuZCBwb3dlciBzdXBwbGllcy4NCj4gDQo+ICAgQWRkIGEgbmV3IC0+aG9zdF9leGl0
KCkgY2FsbGJhY2sgaW4gZHdfcGNpZV9ob3N0X29wcyBzbyB0aGVzZQ0KPiAgIGRyaXZlcnMgY2Fu
IGNsZWFuIHVwIGlmIC0+aG9zdF9pbml0KCkgZmFpbHMuDQoNClRoYW5rcywgaXQncyBtb3JlIGRl
dGFpbGVkLCBhbmQgZWFzaWVyIHVuZGVyc3RhbmQuIFdvdWxkIGJlIHVwZGF0ZWQgbGF0ZXIuDQoN
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0K
