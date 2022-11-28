Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1755463A02F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 04:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiK1Dph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 22:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiK1Dpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 22:45:36 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B6101F0;
        Sun, 27 Nov 2022 19:45:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeTTNPklFeQhYT+BlIrSrNi2mnXhVN5pJbGYnZvJW+wMAhATNMEVZTLHfYMSHU9C9DBw79gBL0l+EL87iAol+XYIE9VXZ/s7Pv8xx6r3FAm2TwIbye8/1Q1Z22oGZQskMD7ndmq3qZPG6p68hjJIpoAeqT0SZcQFZx5Qot8TcgWWstZ/tn8o4XVfq7ajQweootRLFszfvhKkFqfAZhhyzmrXQBqMya38HmS6b3c/8mc/vh/5qgz9lE1U1Lu4EQn64ZnxeHIKOwEdHXoCO6onZlxdvwkeemk2BzW+IazUjNJM35L2Qb1p+UQqUgxiucRBJk1iMgknr6R+TCcu0KAoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlcZstC8nTi4+dFrATV3HTV7dmgnPKNByW9XNuIzllY=;
 b=I3/zG5ywx+xainpacznixng3aJUzW6HOyBPPl1ItGcpgP5RXjOBEJx2fSUJODdrtJ0pjlVgvGrmu5rGfVVJUEfK1wEkBSb3oCAbdsxDNG9geOYYi518kuLox+W7+WuJuRpXFpiyr4i6KeoinqjkLBc2CQnT5I2DHl/t/ONAcYzlnAVpSPpjgW/KtQiJ64Qm/sFCPITSLpnkyRP0ZLPfIcMsupV4dSw1nNA5ei1AvubJVhzK0GVtRmmlMq3Z1ziiAchRoHCEEMhCsECPVDcDUqaLOVZm49H7Zm5gMZv4OCWhANPFWXdkc+0kjr/8zia4c2UhS/g23er12ZXo+u8NC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlcZstC8nTi4+dFrATV3HTV7dmgnPKNByW9XNuIzllY=;
 b=fUUSS54kHcAGI10cGAVmvZbEnps+yda/+/3B93vz/d+rq14AgvWqtAELRaC4Dod0CNaoPr3c/9CoC+4vkFe8cnpW1LZM08dErhRHH2kUkkwRAUidgsLu8P7qcN9+BsvXcT5nuR1bHepY/jDVqBKHtgOWUOTeAHjz5dZdkZHJoDM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Mon, 28 Nov
 2022 03:45:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866%9]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 03:45:30 +0000
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
Subject: RE: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
Thread-Topic: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
Thread-Index: AQHY7crVp6JPT10pBkes7VgrUc48l65PCPbwgACKOQCABCxScA==
Date:   Mon, 28 Nov 2022 03:45:30 +0000
Message-ID: <AS8PR04MB8676A283EB7C3EFD5407E3CF8C139@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1667289595-12440-1-git-send-email-hongxing.zhu@nxp.com>
         <AS8PR04MB8676A61A8C554EB0F0162C998C0E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <9ea3b053cf20d0f3564ccd6152b258ddf0cc8d1e.camel@pengutronix.de>
In-Reply-To: <9ea3b053cf20d0f3564ccd6152b258ddf0cc8d1e.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM9PR04MB8953:EE_
x-ms-office365-filtering-correlation-id: cd3bedc5-ac35-4d3d-5436-08dad0f2fef9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTMz1Go9G9/9P0NOTf8XGgZfiMDlBbjseyWkUqDXDw+HMuZUq6h1sM0+1m2FAwoS70yr+ltyEXPKg0r60dlZYEafmVcAEchmu8EV3c4Ztj0qxZ8Job6Jv7jwyscza+UUjzKkYuKMvTY/GHab+aQ7YF0nOaMqWpM3TcSwJKxIUQI4ZcZs7DJUXqC+AQjAx7YuhpnC8PGZnlpjHP8l7dhdY6z4BnBmkvcR+Gv9T79qeIDA5qEfC0VISZtrTv26KCHGZmGrI3jjtSCTouYFYkkWTh2A6DG3iif6M6UFVLpTb69te7NgYs7ztnigiD7cslThvK9N2HZxWeJjvdt8vOPK3aBoDJo234/ilipGfPANNUU2Kb6MIwgQ0hcYuPKI+8TvTZrPOv6IayeVCgOZ7IEaGeYpFN8jLLSovM/dI6s3amnygtRNBXLq//AMn014wckdTBhFBtyb21h4KNLsBHramOtzGS9PGz16d1/oS4AHUsgdQudAjB9MNz4pMShjXDfuHU6JWIsDAkyRYoo+rURkJGt3fB/79QFmwDXEqmMML4HWJ8pgn8kecnPRNvcFOMy9vN/HmcGJzvnTofIRB36O7UARY3nhoIQjzYbwzQzzUouv2d+9XmQ0qWRIQkvRNJgZVcITmxdJPCzwzvxuWQvES4KuD7TgiA+TBOSLWBv+NN6BKuhOBgej0KjtTqfcSh+017Z63DYwmtGxsG5i6lktgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(66446008)(64756008)(8676002)(5660300002)(4326008)(186003)(52536014)(26005)(9686003)(8936002)(41300700001)(66556008)(66476007)(38070700005)(110136005)(54906003)(316002)(44832011)(2906002)(33656002)(122000001)(86362001)(38100700002)(83380400001)(478600001)(76116006)(66946007)(7696005)(6506007)(53546011)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGd1aFZSVzhDSk1JSVlJMFpCNWxtaGZKZFJjQnBnMk5NQUsrZ0lPWktYOGMw?=
 =?utf-8?B?bzI0YXZ3TCs2cVhTbTQxOUtKcWhEbnQydmgxWmRNdzMwV3BGa2RYZWhUMHA5?=
 =?utf-8?B?MEJ6ZkdVQzhNSjhMOXpYWFlhMXpPOEZrYlo0SGNuTTNYMzVWdEkyd3hPTUdx?=
 =?utf-8?B?VTJNQUxRNjI0Vkc1dHVsSUlZNmU4RGNnNm1CMFdha25rMkNLYjVzYjgwd0NE?=
 =?utf-8?B?QVRwV1ZhQlBjNHR3d1NiVHJ5OTk3eW0vUnordzM5NVRBUzN3Mnp0QXFpbjk0?=
 =?utf-8?B?aUZ3QnZaSWc3OEFKUkpYZmgreWxTNUtQR3BVT0dxaXhKTzRqR0VhajBDSTdh?=
 =?utf-8?B?cFRCa0psTGs0TUdXLzh5d0ttZGVHSXc1Sm5ma1BWeE55QnNMTEtKVlpWY2J6?=
 =?utf-8?B?TWhZamltb1dMR1NwODBjOWk1cXQvMWVyU25jemdrdVZYVmFiYzE2eXlNTGMy?=
 =?utf-8?B?c0lxMyszbFJ0VGEzRWpxd3BTS1NJTFpqbmhJUjhlTzNJbDdUTVpKNWRSay9t?=
 =?utf-8?B?eDVOOXFrdjFqa0Z4OTVrSlRGQlRUcys3RTdQU3FLb1kyL3VFdEIvOFlNRmNh?=
 =?utf-8?B?SWpNeEN4dVpKTjZiS1hJdzRqY3hQMSs4Rm5nY1MvckJ6RWdPdTN0Y2ZPUGdC?=
 =?utf-8?B?S3VEQ1QxckFWdHEyQkhyU25hV1ViVE4rY3R0SGtFT1JubUJ5WndlaVJ1dXQ0?=
 =?utf-8?B?Q1hYdFhteFZhYTcwSXhPUEtKRUZvWitpQm9qcE5FTkx0cnVtU3NsdU1IK0No?=
 =?utf-8?B?UkhBU0lFMHc3ankvY0hyWitzLzh1Y2UzZXRyOEJPclVWQ2s1SkZsUndhSnc5?=
 =?utf-8?B?Y0xPQzNYR0xHQzllMnJ5WWc2K0tvbHpFYnpKdmUvdDdLNURBb28raDBmd2tF?=
 =?utf-8?B?aUNLLzNkcXNCQmJoUE5OdGh4WFBBUTQyWlh2QWN4M1Z6NHBQRjZjKzk1NUlq?=
 =?utf-8?B?RnpucmV5Y1pIN3FWenVxUU5KbFBPK0JqNEFyczh2THFGTXF5VjY4aWR6UVRv?=
 =?utf-8?B?SlNJektaYXFGRWNkWFdhNjZuelFrcU9idklrWVEreXVEdUt4NWpsMVVDcS84?=
 =?utf-8?B?V3hpQXJGVXRhL1ZlSko4WndUOWJIakpkcGhMR0g5VUZCODNuY1dPSWVxSkQ3?=
 =?utf-8?B?cUJDdlhlTWtQRGhyZGRwMXE0SGd3V0w2ZnptSHZxNndQQU1OdkhSc1hiMDhR?=
 =?utf-8?B?cmlEN3BkanFGRWl4bnN5bVVqKzh4UFdRNndXZXorZUpUeXNwY3JRUGxBQWwy?=
 =?utf-8?B?UUtvSWVBeVc5R1FFUjQwT0VjTFZ0Y0hSRnJGK1F1NEFKb01UekxSNVlBemRj?=
 =?utf-8?B?anhIWmx6U21Qa21IVmJpWmNoSUpUVWpYOUZEMUlrZmd4alpSWmhhaHZzbmJu?=
 =?utf-8?B?R29LSVdiTHlBRVRUSFZkVEJacWNmQmRmNzJQNlFaY2p4c1BJa25tMjBCVjZB?=
 =?utf-8?B?Z0lGQXBVOHNCVlpMTEsydGNMdlVueEovRnpBTnUvZ3JXK0cyZnF4b0Zzcyta?=
 =?utf-8?B?c2QwZno4WldUUzNCOVpXUlFMc21WbW41S28ycGJPV01aVDVLV0hubFphLzRz?=
 =?utf-8?B?eG9XcmFRdEtRekd3Z09Tb0pielo1VFVZMTJCY01UdTBRL0JrRlVieVRJWE5N?=
 =?utf-8?B?R2tZZWg3NFE3eWlVaUkrVnhaWDd3Tk9BVU4yR1I3WDJRRmdrOHNWNTBRZVEv?=
 =?utf-8?B?ZEd3R2U2L2p2NjRSVTMzRFozU1dxT2FycHFhOU12MFBCQWFZTmFjVUVRa21m?=
 =?utf-8?B?UzBqdGdjc3U0RUZ4citnRGY5eGtXaE9pU1J5SWVISWdqYjhFMlpGV0MxSWtm?=
 =?utf-8?B?V1VaMjdxeHdSL1JlYk1FVHQzS21aeFVybi8rQ3hKWGNXbmxBVjlyMXBjN0Va?=
 =?utf-8?B?eWp3SEhmbHZ3QVFyUklUbEJpOU5KSXhMajRUVEFaanlpdFd6NlF0eEhaYWdE?=
 =?utf-8?B?NGlHNmU0K1VZcENZaWVCM0Fud3k4Z3h5aGYwejFPUjkrZklrM1UrVG10ZUd5?=
 =?utf-8?B?eUVRbHNOcTJyb1pQbE1ES3BKK05kb2VjU2U1SU5lMWpYQnFxQ010Y3RFdWc1?=
 =?utf-8?B?azZhM2JyTkdTR3lCNnBHTDhEUVc2VTRyMmRYNEFlNVd1VjB2VVEvWEpGL2Iw?=
 =?utf-8?Q?voXo8i9biZr2KtHAo3tkdH1lT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3bedc5-ac35-4d3d-5436-08dad0f2fef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 03:45:30.4606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPHt+SCPuOI3EVrx4dHlM4CUYhZJnmmUriExqyXb8oI3DRSYvRxwTdqMrtuHh6wVebmgS5R99Cr25p0d+Ykb+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDEx5pyIMjXml6UgMTg6MTkNCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29t
Ow0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14
DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gUENJOiBp
bXg2OiBTZXQgTVNJIGVuYWJsZSBiaXQgb2YgUkMgaW4gcmVzdW1lDQo+IA0KPiBBbSBGcmVpdGFn
LCBkZW0gMjUuMTEuMjAyMiB1bSAwMjowNyArMDAwMCBzY2hyaWViIEhvbmd4aW5nIFpodToNCj4g
PiBGcmllbmRseSBwaW5nLg0KPiA+IEFueW1vcmUgY29tbWVudHMgYXJlIHZlcnkgYXBwcmVjaWF0
ZWQuDQo+ID4NCj4gPiBCVFcsIEkgaGFkIHZlcmlmaWVkIG9uIGkuTVg3RC9pLk1YNlFQIHBsYXRm
b3JtcyB0aGF0IE1TSSB3b3VsZG7igJl0IGJlDQo+ID4gZnVuY3Rpb25hbCAgYWZ0ZXIgcmVzdW1l
IHdpdGhvdXQgdGhpcyBwYXRjaC4NCj4gDQo+IEluc3RlYWQgb2YgcGxheWluZyB3aGFjay1hLW1v
bGUgYW5kIHJlc3RvcmluZyBpbmRpdmlkdWFsIGNvbmZpZyBzZXR0aW5nIGFmdGVyDQo+IHJlc3Vt
ZSwgc2hvdWxkbid0IHdlIGp1c3QgZG8gYSBwY2lfc2F2ZV9zdGF0ZSgpIG9uIHN1c3BlbmQgYW5k
IHRoZW4gcmVzdG9yZQ0KPiB0aGUgY29tcGxldGUgY29uZmlnIGJ5IGNhbGxpbmcgcGNpX3Jlc3Rv
cmVfc3RhdGUoKSBvbiByZXN1bWU/DQo+IA0KSGkgTHVjYXM6DQpUaGFua3MgZm9yIHlvdXIgY29t
bWVudHMuDQpSZWZlciB0byBteSB1bmRlcnN0YW5kaW5nLCBvbmx5IHRoZSBpLk1YIFBDSWUgc3Bl
Y2lmaWMgY29uZmlncyB0aGF0IG1pZ2h0DQogYmUgbG9zdCBkdXJpbmcgc3VzcGVuZC9yZXN1bWUg
c2hvdWxkIGJlIHNhdmVkL3Jlc3RvcmVkIGhlcmUuDQoNCkJlY2F1c2UgdGhhdCBtb3N0IG9mIHRo
ZSBjb25maWdzIGhhZCBiZWVuIHJlLWNvbmZpZ3VyZWQgaW4gdGhlDQogc3VzcGVuZC9yZXN1bWUg
cGF0aHMgYWxyZWFkeS4NClNvLCBvbmx5IHRoZSBQQ0lfTVNJX0ZMQUdTIHNob3VsZCBiZSBzYXZl
ZC9yZXN0b3JlZCBoZXJlLCByaWdodD8NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+
IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzDQo+ID4gUmljaGFy
ZCBaaHUNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206
IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IFNlbnQ6IDIwMjLlubQx
MeaciDHml6UgMTY6MDANCj4gPiA+IFRvOiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBiaGVsZ2Fh
c0Bnb29nbGUuY29tOw0KPiA+ID4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiA+ID4gQ2M6
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOw0KPiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBk
bC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogW1BBVENIIHYx
XSBQQ0k6IGlteDY6IFNldCBNU0kgZW5hYmxlIGJpdCBvZiBSQyBpbiByZXN1bWUNCj4gPiA+DQo+
ID4gPiBUaGUgTVNJIEVuYWJsZSBiaXQgY29udHJvbHMgZGVsaXZlcnkgb2YgTVNJIGludGVycnVw
dHMgZnJvbQ0KPiA+ID4gY29tcG9uZW50cyBiZWxvdyB0aGUgUm9vdCBQb3J0LiBUaGlzIGJpdCBt
aWdodCBsb3N0IGR1cmluZyB0aGUNCj4gPiA+IHN1c3BlbmQsIHNob3VsZCBiZSByZS1jb25maWd1
cmVkIGR1cmluZyByZXN1bWUuDQo+ID4gPg0KPiA+ID4gRW5jYXBzdWxhdGUgdGhlIE1TSSBlbmFi
bGUgc2V0IGludG8gYSBzdGFuZGFsb25lIGZ1bmN0aW9uLCBhbmQNCj4gPiA+IGludm9rZSBpdCBp
biBib3RoIHByb2JlIGFuZCByZXN1bWUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDI0ICsrKysrKysrKysrKysrKysrLS0t
LS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jDQo+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gPiA+IGluZGV4IDI2MTY1ODVjYTVmOC4uZGJhMTU1NDYwNzVmIDEwMDY0NA0KPiA+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gQEAgLTEwNDEsNiAr
MTA0MSwyMSBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfcG1fdHVybm9mZihzdHJ1Y3QNCj4gPiA+
IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ID4gIAl1c2xlZXBfcmFuZ2UoMTAwMCwgMTAwMDAp
Ow0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiArc3RhdGljIHZvaWQgcGNpX2lteF9zZXRfbXNpX2Vu
KHN0cnVjdCBkd19wY2llICpwY2kpIHsNCj4gPiA+ICsJdTggb2Zmc2V0Ow0KPiA+ID4gKwl1MTYg
dmFsOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAocGNpX21zaV9lbmFibGVkKCkpIHsNCj4gPiA+ICsJ
CW9mZnNldCA9IGR3X3BjaWVfZmluZF9jYXBhYmlsaXR5KHBjaSwgUENJX0NBUF9JRF9NU0kpOw0K
PiA+ID4gKwkJZHdfcGNpZV9kYmlfcm9fd3JfZW4ocGNpKTsNCj4gPiA+ICsJCXZhbCA9IGR3X3Bj
aWVfcmVhZHdfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX01TSV9GTEFHUyk7DQo+ID4gPiArCQl2YWwg
fD0gUENJX01TSV9GTEFHU19FTkFCTEU7DQo+ID4gPiArCQlkd19wY2llX3dyaXRld19kYmkocGNp
LCBvZmZzZXQgKyBQQ0lfTVNJX0ZMQUdTLCB2YWwpOw0KPiA+ID4gKwkJZHdfcGNpZV9kYmlfcm9f
d3JfZGlzKHBjaSk7DQo+ID4gPiArCX0NCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAgc3RhdGlj
IGludCBpbXg2X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpICB7DQo+ID4g
PiAgCXN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOyBA
QCAtMTA3Myw2DQo+ID4gPiArMTA4OCw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3Jlc3VtZV9u
b2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiAgCWlmIChpbXg2X3BjaWUtPmxpbmtfaXNf
dXApDQo+ID4gPiAgCQlpbXg2X3BjaWVfc3RhcnRfbGluayhpbXg2X3BjaWUtPnBjaSk7DQo+ID4g
Pg0KPiA+ID4gKwlwY2lfaW14X3NldF9tc2lfZW4oaW14Nl9wY2llLT5wY2kpOw0KPiA+ID4gIAly
ZXR1cm4gMDsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gQEAgLTEwOTAsNyArMTEwNiw2IEBAIHN0
YXRpYyBpbnQgaW14Nl9wY2llX3Byb2JlKHN0cnVjdA0KPiA+ID4gcGxhdGZvcm1fZGV2aWNlDQo+
ID4gPiAqcGRldikNCj4gPiA+ICAJc3RydWN0IHJlc291cmNlICpkYmlfYmFzZTsNCj4gPiA+ICAJ
c3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2RlOw0KPiA+ID4gIAlpbnQgcmV0
Ow0KPiA+ID4gLQl1MTYgdmFsOw0KPiA+ID4NCj4gPiA+ICAJaW14Nl9wY2llID0gZGV2bV9remFs
bG9jKGRldiwgc2l6ZW9mKCppbXg2X3BjaWUpLCBHRlBfS0VSTkVMKTsNCj4gPiA+ICAJaWYgKCFp
bXg2X3BjaWUpDQo+ID4gPiBAQCAtMTI4MiwxMiArMTI5Nyw3IEBAIHN0YXRpYyBpbnQgaW14Nl9w
Y2llX3Byb2JlKHN0cnVjdA0KPiA+ID4gcGxhdGZvcm1fZGV2aWNlDQo+ID4gPiAqcGRldikNCj4g
PiA+ICAJaWYgKHJldCA8IDApDQo+ID4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ID4NCj4gPiA+IC0J
aWYgKHBjaV9tc2lfZW5hYmxlZCgpKSB7DQo+ID4gPiAtCQl1OCBvZmZzZXQgPSBkd19wY2llX2Zp
bmRfY2FwYWJpbGl0eShwY2ksIFBDSV9DQVBfSURfTVNJKTsNCj4gPiA+IC0JCXZhbCA9IGR3X3Bj
aWVfcmVhZHdfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX01TSV9GTEFHUyk7DQo+ID4gPiAtCQl2YWwg
fD0gUENJX01TSV9GTEFHU19FTkFCTEU7DQo+ID4gPiAtCQlkd19wY2llX3dyaXRld19kYmkocGNp
LCBvZmZzZXQgKyBQQ0lfTVNJX0ZMQUdTLCB2YWwpOw0KPiA+ID4gLQl9DQo+ID4gPiArCXBjaV9p
bXhfc2V0X21zaV9lbihwY2kpOw0KPiA+ID4NCj4gPiA+ICAJcmV0dXJuIDA7DQo+ID4gPiAgfQ0K
PiA+ID4gLS0NCj4gPiA+IDIuMjUuMQ0KPiA+DQo+IA0KDQo=
