Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80ED5AAB37
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiIBJR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 05:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbiIBJRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 05:17:07 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20047.outbound.protection.outlook.com [40.107.2.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6ACAC9C;
        Fri,  2 Sep 2022 02:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwYOcl4WS//hfMrpdz/GdAY+NzlKANMaqj9dT1bLTS1hCvJtZi5frX1/H/BVJGpHuenWkN5sSXmUKiD68ss6XEwJ4AlABbiqvEznCtmGWXipamodC6jQG4kYhRfnj22ONa4x0ASKppuiRWboAIbrDMsYjqEzPvYXlmyf/5Yf1psbOZB3WQN6yG3TLPi/QlD42vaje+PDH07mRg4qpLEzQbzcNkuy9bav3bxvoptSVwFewrq7PYQEYgCBg4bwk6vqtyIKOTiD9G2dDKfHSWOhHj2E1X9AMPuwBWE0MfJRxvdu4Y71EEHrzDy6huH0ZdBNYxoFmh6to7o8Y1dRY9Ivjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raH8Cmax1bhnSz0cHWHkuuqJL5XGm6D1Uy+ywDMmgH0=;
 b=ZUw7qxdNYs827EGxBM9SM8johf3B0daSUoRf/Er3vJFMF+OmPB3A8jLorQF/kPO1+3+hX5TCUD8DVuNYWTLk28EGs35RZV/JLfZKP1VLDor+l3Uz8zL8aiO1fQlZfy6ojRYWmRqNjmSXSsv4BXS9I0z1oM2kTCSMjS+LKAN1ys0DS+Wft1XSaMmNE3s2PocwKSAdL6GC7UxlXqaVRSnwO88StqQsb15aq/0WFJE0HWRd94AhC1cFDxhmY+8hW5C4eeTARU+YnwTpNxIdPpR9Zx4VZWtAJqcsx3dgfx9mHIM63SFrPhUy3B8whzsmiYfjAZtl8Ndy2hNsIpTvKDjxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raH8Cmax1bhnSz0cHWHkuuqJL5XGm6D1Uy+ywDMmgH0=;
 b=rAW+Sm3SH/3hmVRl9oW6VjZ/D+tkObaQorQbegWAwOYoc1eAYTevujV0rioyRv1OLiU1SG4dIQlijASpibN6nkmzlaED7UcqUDnHmoJATzDbOAMBqsN++7faxchC4Z+u1b/Gbf4A0S8Dq/5YtPPBHDJvxW1SCADDRe8LH/AJAjQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB9662.eurprd04.prod.outlook.com (2603:10a6:102:260::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 09:16:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 09:16:49 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 0/7] Add the iMX8MP PCIe support
Thread-Topic: [PATCH v7 0/7] Add the iMX8MP PCIe support
Thread-Index: AQHYvqxOd4nrrnujJkazBdeE9hjM363L2+kg
Date:   Fri, 2 Sep 2022 09:16:49 +0000
Message-ID: <AS8PR04MB8676F2D976E3BF6A17D567A68C7A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1662108958-15800-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1662108958-15800-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 409aed3d-db11-4126-f287-08da8cc3ddf2
x-ms-traffictypediagnostic: PA4PR04MB9662:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nCcql/FfJ+563aTpqL4n2xkkGsya/Y56RYIuU5ug1S7ujzqQfUZozktE3sJWy8Nhje0rUQa4Bkm7fXRwdN4+240NEj6Bj0MNOYcN/BdLXE5MnPxHfIkdUdQLW7xs2C1l5O6pJw2mti6voZx6xA4qaLQEG/gfcqkpzJ3qkfG9Y7wi8e2D9o5JtVZuj6dj65mfdEpGMU4Ikcc+pN9Tbb04yqXQjdHB+gvnd0rTH4hMaAqlHcDfNOGyhlKZLp6llwV2xe9NuVd+4cbEVcEi5iM5Pa4z/N1gZC9tuhAXr5auxMvxWkVCncfRc0WmVuA3MGI8CBNXweTRE0BIfDgjq0Gbi00g0J1qLeZKnVRDYO4eaHNNUMp4ApMduNZTVu6unqFFFccPFeDRKCCEcfOu+EOUJNkEFnIjdXfmrt2+tTE5JGR70Ls48Euc+hiDOrF3o7VwEgVhs/ZVfQlRebfi8DpNFGgahNHBQW8+Rcgs/PpK7bM/PmWz8/uK5K083QTpfx9aXxEeHAhXJMn6EDKsXr5sxVWH0j7quBSJQpwWDfd5aiixyC2tX1EjYywiy67uOWBTNEHti1/Oo+aED3Mo4gZKETN/QoLrIna93qWUe1gHho3E3WdwasO0ACvZISRdJ/H1sFAPhyJbcdg0AzAWYk+7biVHAzKr4QaWEOBomrdCc4dTJ8l8aqS361cSGPDrWjOH5AWImN5wuivsLPCzgsyrLo259Mrb537E+EJ3oSwtJJQMITCuO9z8ZUMGE4kYTrRxf7hJ9c0FbbfzWxz8HXaOW4XSzRl4LxKVox6yJr1ekaR23ug5vLyjBTtrjM2EEjkt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(66946007)(921005)(122000001)(8676002)(64756008)(66556008)(55016003)(4326008)(66446008)(76116006)(54906003)(316002)(2906002)(66476007)(38100700002)(110136005)(44832011)(52536014)(5660300002)(7416002)(9686003)(7696005)(6506007)(8936002)(53546011)(186003)(26005)(71200400001)(86362001)(478600001)(38070700005)(41300700001)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RTVhSTl3T0k1ZmdsaFo2bytSNkNqOTJWbDBVQmdXZkVIWFpmL2tPd2hSNkxk?=
 =?gb2312?B?OEdkV0FjRk1yWVpwemE4UjF0UlBBWElIVFo2c0RBK0J2RjhTeTJNYWFGZ3R2?=
 =?gb2312?B?cGlHVnJWVjFZdTlyYmYzSUpmdEg2Q0FSUTZsMUtLaVZPR3JYRUZXcHhKK0VW?=
 =?gb2312?B?VnJpeUZ4cnhKeFRLcE15Q1l1Q1FqZE9rbWZaS3U5bWo0dFhHQ08wZjRldzdV?=
 =?gb2312?B?RlU3Z1NKem1rcjlSSGJYNHpCRkpNdk44cWVXbUI3dlJPSXdjUXhIbEg1SlFO?=
 =?gb2312?B?ZWV0SjBJSWo0dmV1WHUxTmFweVBEV2ppMXkrQkQ2RVora3lmUWcwZDVnVk10?=
 =?gb2312?B?RXJ1WHhuOVl1TmwzN3RtbjF5MjdIL21jNXZlUVFXTXZKZkg1NFFtZzlrMjhP?=
 =?gb2312?B?OHllRWwrejVBeWR2WmZ5RmZ0UnNmSVJSWTR5S2NBMGpDa2M0SFYzbG1JcmtO?=
 =?gb2312?B?eHp1K0VGd25EelFwMEFKb1lwckhtM25wd2N2akxCTGFGWTdnbE00OXpHdWVR?=
 =?gb2312?B?RjJiN0w4ZXR0bHk3Q1MwbWxGYngrRXVSbE5BL29yK29taWNpekpoREZqVmt4?=
 =?gb2312?B?cGtNTWJudERSYkJuOFc0REgzMFFRV0VWbGtpL3BrWTJ5dnVYVkg1M0F6Nzhp?=
 =?gb2312?B?TnRHbVVvRm5aQ0FJUGJQWWs3bW1LeHhnR21qb2tjeGFZZlhVbU00ZTlDNU12?=
 =?gb2312?B?cWl5OFNyTE1GcEFWemloeGQwN2xWWFFHRVE2VFFaUUtWWUJJMk1UeC8wcUVN?=
 =?gb2312?B?UFcwQ3RSak1XSkthUFU1UnpVM1BTWEpiUEYyWDFXTXhOVjdoTEpwSUxDSmVH?=
 =?gb2312?B?VjJGUWlYcUhJUGZMNmFDQ0Jwdmw3UGVSQlFYQ2NvZlpUZkxQeHJBVjJSNGFT?=
 =?gb2312?B?aURvSnRtWVErZVY0L0J5clliN1B0WDg0MGxLaXVCU2daOC9DYW9tZ1ErV1J1?=
 =?gb2312?B?K29RdDNqN3FDWDV6TXBIV0VoaWpxZHJLSUVIZlFITmRTbUFyMjNzZjJTQTBU?=
 =?gb2312?B?VlBxc1lVSjNxWkJwS2ZnNnVIMzJ4c0NKaUU3T0ViUGlhbFJqdUI4QlA2NHo0?=
 =?gb2312?B?UGtNWjFIem02YnZIZE52VStLZTg1SnB2UVhMQjAvM0JBMzVPMTBqclJDazFu?=
 =?gb2312?B?NlRUOXNWNkcwU3NUOWcyMnllN2o0NWE5ckJxaDAwcEVud2NDMlJDQ0dUbTB3?=
 =?gb2312?B?RUM0SktGOXU1UnJJVlBFOUljM1lRN1QzOEdKQ1Z6ckk2V3llblRwRXNlUmFJ?=
 =?gb2312?B?NFRiTTFaVDN4em5YQ1BpTHkrTlo2a2JpTG82ZzVmNVhkOTRuUDA4dTdxUGtZ?=
 =?gb2312?B?V0k3cjk4a2V5OEoyOHo0U1FTRHE0dy8vdFN3ZnhNWkowYWR2ZU1iTVczRlZP?=
 =?gb2312?B?dXJIVTcvNWhBODdBYkh3MUhHWXd6WkZvT3k1THRyaHhGQ1R0cG13SUNzNE0r?=
 =?gb2312?B?M3VlNWNaWFJZZkZ6cWEyNmg3MGtZRmRqdkNndVNFRmtJL1dCazFnTloxRFdv?=
 =?gb2312?B?M2N2TDI2a0ZsOWdjVDRaWGp6KzMySWpqbEdYL0lSdkxQQjk0eFRuNE4xOEFW?=
 =?gb2312?B?aEJhL0ZKNkcyem9aaHdnMU1tcEZmZzgxVWdOZG5OZ0dXTzdrTFJab3g2Q2pr?=
 =?gb2312?B?cjNKOXFDd3VaK3NDT2VXU3VWQjZwUjhZekRaaEFZZ21jNTgvWkRPRjRNZExW?=
 =?gb2312?B?b0hFUFR3QUhlajF6NmFmaXFrcWlxamx2cUpob2pjRHJvcHFHMmVkaFVJRkxx?=
 =?gb2312?B?bGFjUTMxazFOZStQalZTTTRhOG15VzhmblNYaHpnKzUxdU1BYTM5ejFLZGEy?=
 =?gb2312?B?OEswTWtzM1gvdWM1TjQzZGMzZUxBLzZVQjFSUEtPU1QyTFg0QkdGS1BqVzha?=
 =?gb2312?B?Q3ZESXRkV2x6RHp2eVZUNHJ2L0FoZmwzakZGTW5YN0NjUFM4S282VDNzMTk4?=
 =?gb2312?B?bHVXSENTKzMxRDA4R2lGUENWRUxQNk4xNEUvV0lubXd6dUJRWUpUdloyaE1S?=
 =?gb2312?B?bUdOY2N1Q29QK0dZNjNKVWNoa2pNV0ZzeW0vcHpabXIydEJKdzBqYnZPUzlK?=
 =?gb2312?B?dkZuTW9ubnJJckpiYWpsOTUwcjVFcEIxM2VMTVh0U2x5anlRamh3KzlsOVJE?=
 =?gb2312?Q?XI6lK4ZFMWzPv+8c32N4a/pgM?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409aed3d-db11-4126-f287-08da8cc3ddf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 09:16:49.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTxrXlYUhiwF5dlcVS2wDlV6tpcwyRLM9nWf1lWevKZ4GuYv0FeXNzDMAQu6cR+h37YylGLrRxdqhhAqjNP4NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9662
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U29ycnksIGdldCB0aGUgd3JvbmcgdjYgcGF0Y2hlcyBzZW5kaW5nIG91dC4NClRoZSBjb3JyZWN0
IG9uZSBpcyByZS1pc3N1ZWQuDQpQbGVhc2UgaWdub3JlIHRoaXMgb25lLg0KDQpCZXN0IFJlZ2Fy
ZHMNClJpY2hhcmQgWmh1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBTZW50OiAyMDIyxOo51MIyyNUg
MTY6NTYNCj4gVG86IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJv
YmhAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gdmtvdWxAa2VybmVsLm9yZzsg
YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsgbWFyZXhAZGVueC5kZTsNCj4gcmljaGFy
ZC5sZWl0bmVyQGxpbnV4LmRldg0KPiBDYzogbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHY3IDAvN10gQWRkIHRoZSBpTVg4
TVAgUENJZSBzdXBwb3J0DQo+IA0KPiBCYXNlZCBvbiB0aGUgNi4wLXJjMSBvZiB0aGUgcGNpL25l
eHQgYnJhbmNoLg0KPiBUaGlzIHNlcmllcyBhZGRzIHRoZSBpLk1YOE1QIFBDSWUgc3VwcG9ydCBh
bmQgdGVzdGVkIG9uIGkuTVg4TVAgRVZLIGJvYXJkDQo+IHdoZW4gb25lIFBDSWUgTlZNRSBkZXZp
Y2UgaXMgdXNlZC4NCj4gDQo+IC0gaS5NWDhNUCBQQ0llIGhhcyByZXZlcnNlZCBpbml0aWFsIFBF
UlNUIGJpdCB2YWx1ZSByZWZlciB0bw0KPiBpLk1YOE1RL2kuTVg4TU0uDQo+ICAgQWRkIHRoZSBQ
SFkgUEVSU1QgZXhwbGljaXRseSBmb3IgaS5NWDhNUCBQQ0llIFBIWS4NCj4gLSBBZGQgdGhlIGku
TVg4TVAgUENJZSBQSFkgc3VwcG9ydCBpbiB0aGUgaS5NWDhNIFBDSWUgUEhZIGRyaXZlci4NCj4g
ICBBbmQgc2hhcmUgYXMgbXVjaCBhcyBwb3NzaWJsZSBjb2RlcyB3aXRoIGkuTVg4TU0gUENJZSBQ
SFkuDQo+IC0gQWRkIHRoZSBpLk1YOE1QIFBDSWUgc3VwcG9ydCBpbiBiaW5kaW5nIGRvY3VtZW50
LCBEVFMgZmlsZXMsIGFuZCBQQ0llDQo+ICAgZHJpdmVyLg0KPiANCj4gTWFpbiBjaGFuZ2VzIHY2
LS0+djc6DQo+IC0gQWRkICJSZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0
cm9uaXguZGU+IiBpbnRvIGZpcnN0IHRocmVlDQo+ICAgcGF0Y2hlcy4NCj4gLSBVc2UgImNvbnN0
ICpjaGFyIiB0byByZXBsYWNlIHRoZSBzdGF0aWMgYWxsb2NhdGlvbi4NCj4gDQo+IE1haW4gY2hh
bmdlcyB2NS0tPnY2Og0KPiAtIFRvIGF2b2lkIGNvZGUgZHVwbGljYXRpb24gd2hlbiBmaW5kIHRo
ZSBncHIgc3lzY29uIHJlZ21hcCwgYWRkIHRoZQ0KPiAgIGdwciBjb21wYXRpYmxlIGludG8gdGhl
IGRydmRhdGEuDQo+IC0gQWRkIG9uZSBtaXNzaW5nIHNwYWNlIGJlZm9yZSBvbmUgY3VybHkgYnJh
Y2UgaW4gMy83IG9mIHY1IHNlcmllcy4NCj4gLSA0Lzcgb2YgdjUgaGFkIGJlZW4gYXBwbGllZCBi
eSBQaGlsbGlwcCwgdGhhbmtzLiBGb3IgZWFzZSBvZiB0ZXN0cywgc3RpbGwNCj4gICBrZWVwIGl0
IGluIHY2Lg0KPiANCj4gTWFpbiBjaGFuZ2VzIHY0LS0+djU6DQo+IC0gVXNlIEx1Y2FzJyBhcHBy
b2FjaCwgbGV0IGJsay1jdHJsIGRyaXZlciBkbyB0aGUgaHNpby1taXggcmVzZXRzLg0KPiAtIEZl
dGNoIHRoZSBpb211eGMtZ3ByIHJlZ21hcCBieSB0aGUgZGlmZmVyZW50IHBoYW5kbGVzLg0KPiAN
Cj4gTWFpbiBjaGFuZ2VzIHYzLS0+djQ6DQo+IC0gUmVnYXJkaW5nIFBoaWxsaXBwJ3Mgc3VnZ2Vz
dGlvbnMsIGFkZCBmaXggdGFnIGludG8gdGhlIGZpcnN0IGNvbW1pdC4NCj4gLSBBZGQgUmV2aWV3
ZWQgYW5kIFRlc3RlZCB0YWdzLg0KPiANCj4gTWFpbiBjaGFuZ2VzIHYyLS0+djM6DQo+IC0gRml4
IHRoZSBzY2hlbWEgY2hlY2tpbmcgZXJyb3IgaW4gdGhlIFBIWSBkdC1iaW5kaW5nIHBhdGNoLg0K
PiAtIEluc3BpcmVkIGJ5IEx1Y2FzLCB0aGUgUExMIGNvbmZpZ3VyYXRpb25zIG1pZ2h0IG5vdCBy
ZXF1aXJlZCB3aGVuDQo+ICAgZXh0ZXJuYWwgT1NDIGlzIHVzZWQgYXMgUENJZSByZWZlcnJlbmNl
IGNsb2NrLiBJdCdzIHRydWUuIFJlbW92ZSBhbGwNCj4gICB0aGUgSFNJTyBQTEwgYml0IG1hbmlw
dWxhdGlvbnMsIGFuZCBQQ0llIHdvcmtzIGZpbmUgb24gaS5NWDhNUCBFVksgYm9hcmQNCj4gICB3
aXRoIG9uZSBOVk1FIGRldmljZSBpcyB1c2VkLg0KPiAtIERyb3AgdGhlICM0IHBhdGNoIG9mIHYy
LCBzaW5jZSBpdCBoYWQgYmVlbiBhcHBsaWVkIGJ5IFJvYi4NCj4gDQo+IE1haW4gY2hhbmdlcyB2
MS0tPnYyOg0KPiAtIEl0J3MgbXkgZmF1bHQgZm9yZ2V0IGluY2x1ZGluZyBWaW5vZCwgcmUtc2Vu
ZCB2MiBhZnRlciBpbmNsdWRlIFZpbm9kDQo+ICAgYW5kIGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRl
YWQub3JnLg0KPiAtIExpc3QgdGhlIGJhc2VtZW50cyBvZiB0aGlzIHBhdGNoLXNldC4gVGhlIGJy
YW5jaCwgY29kZXMgY2hhbmdlcyBhbmQgc28gb24uDQo+IC0gQ2xlYW4gdXAgc29tZSB1c2VsZXNz
IHJlZ2lzdGVyIGFuZCBiaXQgZGVmaW5pdGlvbnMgaW4gIzMgcGF0Y2guDQo+IA0KPiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L2ZzbCxpbXg4LXBjaWUtcGh5LnlhbWwgfCAg
MTYNCj4gKysrKysrKystLQ0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAt
ZXZrLmR0cyAgICAgICAgICAgICAgICAgfCAgNTMNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpICAgICAg
ICAgICAgICAgICAgICB8ICA0Mw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrDQo+IGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgICAgICAgICAgICAgICAgICAgICAgICB8
ICAyNw0KPiArKysrKysrKysrKysrKy0tDQo+IGRyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNs
LWlteDhtLXBjaWUuYyAgICAgICAgICAgICAgICAgICB8IDE0NA0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gLS0t
LS0tLS0tLS0tLS0tLQ0KPiBkcml2ZXJzL3Jlc2V0L3Jlc2V0LWlteDcuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiBkcml2ZXJzL3NvYy9pbXgvaW14OG1wLWJs
ay1jdHJsLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTANCj4gKysrKysrDQo+IDcg
ZmlsZXMgY2hhbmdlZCwgMjQyIGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQ0KPiANCj4g
W1BBVENIIHY2IDEvN10gZHQtYmluZGluZzogcGh5OiBBZGQgaU1YOE1QIFBDSWUgUEhZIGJpbmRp
bmcgW1BBVENIIHY2IDIvN10NCj4gYXJtNjQ6IGR0czogaW14OG1wOiBBZGQgaU1YOE1QIFBDSWUg
c3VwcG9ydCBbUEFUQ0ggdjYgMy83XSBhcm02NDogZHRzOg0KPiBpbXg4bXAtZXZrOiBBZGQgUENJ
ZSBzdXBwb3J0IFtQQVRDSCB2NiA0LzddIHJlc2V0OiBpbXg3OiBGaXggdGhlIGlNWDhNUA0KPiBQ
Q0llIFBIWSBQRVJTVCBzdXBwb3J0IFtQQVRDSCB2NiA1LzddIHNvYzogaW14OiBpbXg4bXAtYmxr
LWN0cmw6IGhhbmRsZSBQQ0llDQo+IFBIWSByZXNldHMgW1BBVENIIHY2IDYvN10gcGh5OiBmcmVl
c2NhbGU6IGlteDhtLXBjaWU6IEFkZCBpLk1YOE1QIFBDSWUgUEhZDQo+IFtQQVRDSCB2NiA3Lzdd
IFBDSTogaW14NjogQWRkIGkuTVg4TVAgUENJZSBzdXBwb3J0DQo=
