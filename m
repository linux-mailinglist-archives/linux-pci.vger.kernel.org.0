Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0663432F97
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 09:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhJSHfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 03:35:11 -0400
Received: from mail-db8eur05on2063.outbound.protection.outlook.com ([40.107.20.63]:38401
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229930AbhJSHfL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 03:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOHNpK/+N/sFf+1wRNgK/rntN9j7TCRkDLsX78ZrPw9Qq5CWiDZati1hl3fWh9rsOkt1w7JRJ3Jkw7pt2P4NQd6L9XahFp6u6eQt4fIgyKSUSZGzuJA287lb/LYCbzhMavDoDZApptnVR0i+8PBqDu++ie+vFzxbFr82uK6E6XanGpg7SMrEWRZZ1wVBnuGvMp+mysIkRvHmtBiIOe9P+lNvpFwENMTs9bl+2Cw0KrVvCoUVNzxjnA7srm27RhP3NLLsRtvLpURkezVSlDUoSZ/WNF6hZTsdaL2Cuhs4gGgSNhMZuJcbTwMZi+e4OEFDM45i1mRyN+YQfLPbLUl9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alg8bTvIpAAizR4bBPSNVZqwS1F9jF3VNh8rEU7yCfA=;
 b=SHj0oiXrNe1E7bghwydR8I7wfh65rkZlbwIKTWV4LLYeVBrgM1GjiS8mvv13VCBL5LPsK79PblMzB/l1n1EZFVGkO94lPu9wd/YEU8BJ+U/uApVBgItUFDVCYKMmMo0/tHmOFMAXqnqNh93KFJPLWmr7EGk/Ws7Bx2RBGq1YnE1XEvnIhEdnkzS2tB326sBtDQAj0tophBaD9/qBPQ30RgipgEvUERWgtNsqp3WLaowngea8Vwuk4uByBoODiPvVepOYY87HNGccgvaV3zOS5Oom02VqB7ykbNA+i0yT+eNcjXHGczC7KkJBLPTrqzppczUVZcUw3J6KZxB3IwHu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alg8bTvIpAAizR4bBPSNVZqwS1F9jF3VNh8rEU7yCfA=;
 b=OtAqA8irtEonlxqos63VGf1RfhxJ+OvCFqZ61yfoUH25SMW1BIgkGuVPCp0YHA9gI7z4zk8XK46CwDaT/C9lcN9DBPQJBH2NWAyv3iXLU0KD0p8gpSubbSPDSdn34Xpmda8DgUbCMDbHV5R7aRWRcdd5UHmXEuwMBvlmvk3Z0bg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8882.eurprd04.prod.outlook.com (2603:10a6:20b:42d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 07:32:55 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:32:55 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RESEND v2 1/5] PCI: imx6: Encapsulate the clock enable into one
 standalone function
Thread-Topic: [RESEND v2 1/5] PCI: imx6: Encapsulate the clock enable into one
 standalone function
Thread-Index: AQHXwY4s6kZeP+E3uEGrVnpQc2fDkqvUXbIAgAWWIQA=
Date:   Tue, 19 Oct 2021 07:32:55 +0000
Message-ID: <AS8PR04MB86764DE4738047BB39EEF9658CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-2-git-send-email-hongxing.zhu@nxp.com>
 <b1c38eb0cbded46d5f3c087e641b18cdb4f500ac.camel@pengutronix.de>
In-Reply-To: <b1c38eb0cbded46d5f3c087e641b18cdb4f500ac.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4313ebf-89cb-4c10-1f7c-08d992d2aacf
x-ms-traffictypediagnostic: AS8PR04MB8882:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8882EF3DF6FAF17158358C808CBD9@AS8PR04MB8882.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5sJi4GNeB1r5QkE9uGGC/DyelturoClOotDJgltQYnbNR/+caOym6NhQ0t++9xrOtAnVhxVuB9VJ1MJhPrOCrrvj8CoBHMQEv0NH0diail7sdKoLzAuNOTcoO/GMdthbKSmhY8SB+4mXRm8uTeM8UPSxZnC6jXq/+vIS9KI1Gztd2OeR0msk1I0XR7rZRKzfh+HHxSVCu6ZVu13a1e7ShUeJeThXXMCi/zGgOgBqkfpRyMumDwniJjo4kCFdjZzDrr2YqbKLNkG9HX+gXdHfJGmlQF9ZuYXiTaCawRrBiAr9y8tHSEmnPwE7TdrrbURUlDhMDHYWAwsFmqidduSePPDIeGbbjDd5ZK9vI7H/smvo1n3JhDfHVqyQAocyTct2zzLjr07ebOomPNZDU83TKA49jQSOGjiGpEZ5flv5w+B1P1YVNjaLWOsAVsbTg7HRWOxifJxZ1OD8chmNvDvXqzMlAUCXzuTNi87GtqAK6oV6D5ld3neZ5UiIvNk2cItaucQpk/w/TtGsXvVJvXFYNMOyGXRpXCAZVCLukGiqUqDssX6ijqjto2BqJTBAZfa1ZMtF6MzJl5ZaVPfInUOaMs+VH6y+Kxa2gVkhlYwRzqfQXjb2S0X0Ycb74tOTZY8nxeSHeOMyJs/7p8C46laUAmL4dEBaLsccabxMFMXpuP4fvAA9SV5yW7ulH0EQNW+BLJ1NCWHIocEV5iyqCavAog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(52536014)(86362001)(2906002)(122000001)(33656002)(76116006)(508600001)(9686003)(6506007)(8676002)(66556008)(26005)(53546011)(110136005)(5660300002)(316002)(83380400001)(66946007)(54906003)(64756008)(66446008)(66476007)(38100700002)(38070700005)(55016002)(8936002)(7696005)(4326008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bURMYVhXRGdjZmlTSlUvU2s0Y1dhaXIvM3pDdE82eGhSMkFlUHAzd1VmQXhD?=
 =?utf-8?B?V1pwT3JTTWRSTmJiRk5NcHdBZHg2elQwVGRRaWdDTGNncnoxZmYwQVJoejFN?=
 =?utf-8?B?TzlKS1Zvdy9IeXVrMFIrWGY4OEhRV1drNEpaZk9HNzhHVnJXdHNCVndaMG1M?=
 =?utf-8?B?M21Yakk5R1l6SlNNck5DVHhBMnlpVlRkbVk2N3RDYWhncnNGR3Vhd3o3d3Ir?=
 =?utf-8?B?YTdhblA5Q0JzU3VRL21Xa1RVNUlHZ1FVYW90cmowRGV4SU4yN2pqZ2M1Mzd3?=
 =?utf-8?B?U1kxQy85dElYN2wzeE40eXkrVSs1YlJ4cDhrYjNtOHRLOTN1TjRySGVvemxu?=
 =?utf-8?B?U3BCK3RZT2ZVNk1ZMDVDR1BKYlNOcDFmdzVJV2NOZUsvWVZCSkd4TXpLQ2s0?=
 =?utf-8?B?NStuMFNZMzRNanl1eTM3eHd0OUZ6Ly84Zkt0ZEpzekdOR0Z0UWtJWXFZeUNy?=
 =?utf-8?B?VmM5dVZkUVFIL1hLYjR5bGlSYTRvUVIyOHp6bjJTKzJmdEJyWDFxcmdnNzda?=
 =?utf-8?B?WkEzSllKWkhneXlOTURtck0wWE16ay9HNEo2VUhnaDBYbEoyM2luSW93Z2RH?=
 =?utf-8?B?Z2crYWF4RXgzVTY1UklmOXVSWTRDZmgrWHRGdHFGWVlxSVZ4T01BaXVsdmtt?=
 =?utf-8?B?MkgyRktVRTFvUzFOL0ttMXpETk9YbUNBaEFmeTFqUEp4MUhnT3l2WUVEYmYy?=
 =?utf-8?B?a29EQ3pNZEpLaktneFdFd1hEN1ZqY1ZpWGx3Qi91WFRFb0NBMjFsdjZBd1F6?=
 =?utf-8?B?MlRjYmNRVEg0cDhiUmZhQ3VwMXUrbU1OYWUrTzF4RCtHSThySDhvZEV4VEow?=
 =?utf-8?B?andCNzR4SzRrb3lIcjk4MDRtTGIvUzRpTk9kTmlxd0YvZ1BmclFYajVLMC93?=
 =?utf-8?B?cmptKytTSDN1M2pVN0l6aHF1TXI1T0FZNmZYM0lzUnNzYWVhMWN4Y2dvdFJr?=
 =?utf-8?B?ZnNOUzNUWXNMN1lSbE1Dam5uUlJheEhhOGx2RHVZWitMZlpRRTdrVG1tdnk3?=
 =?utf-8?B?RE5ZR2JKTnZWNnhwODJwVURIbXZ0SWdweFlLckdnQ3BtYmxxbDMvQ29BcFdu?=
 =?utf-8?B?MzQ1bWxZdGMweThmNERFNXJkbzBnL2F4OThadUR3NVgyTE9XVC9FbWNXbGts?=
 =?utf-8?B?M0E1Y2JrczJIVi9JYXg2ZjlldVBhOFpwMzNUV3BkSXVMVHhjaXI0ck1keDZs?=
 =?utf-8?B?L3JQdW1EYW1xMlJVa2IvbmNrQjFmYXJnVHJSZlFVMUVya2ErcGxHT25TL2Zp?=
 =?utf-8?B?TG5mMHZGQjZRazVaQjFtbFViUDU0a0xyL29zSEk4ZmZKRjVOYVl2clNFYTNC?=
 =?utf-8?B?L00zVEJQb1pkWHFORmswRmQvTnlQcWRTRWRHNWhrSjNVd3V0RHBKY3JjMWhw?=
 =?utf-8?B?bjN2dlp3aGF2RVNxeGhqUFhDSmlWNDJFeUZIUndKRTFyckNoREhqeVZCR2lM?=
 =?utf-8?B?aFFDV3NmRm4yWEdYUnJEUTdidjh6NVZGeVdxeTYxNlRhbzBtNUVvamdpV1BQ?=
 =?utf-8?B?RmRDbEh4NjZMcW9sY1IyTE10aDZkWDliam9acE1WSlRrcy9iWS8xU0ZBRG1M?=
 =?utf-8?B?VjhWZkJBMlIrdFB1Y1pRWWJGL0FRcDBYTGNraEtBZHN0ekVkUmJMaCswVVdt?=
 =?utf-8?B?U0M4RWxndW04ZlRBU09nMFc1ZGZEM0lZVjc1NjljTTFYcHQvMVY0cThqRVQ3?=
 =?utf-8?B?REVXQlZmUGJPWDg1M00zUUprWjVpeEF2YmgwZkFXOFh6bHJzUU14QXBjRG9L?=
 =?utf-8?Q?1aCn6uzqE73OMaw+i8iRdijhGTw3qzQ7F2IAUKK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4313ebf-89cb-4c10-1f7c-08d992d2aacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 07:32:55.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fiu4xH1rhyaWf5mFj6aqDeLBt/Cx6f6Vl+nCI8vvNMChRVJi96QQyeGLcdi/YBmq+cTtov8c2fkxsVV8nht72g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8882
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1Y2FzIFN0YWNoIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAxNiwgMjAyMSAy
OjE0IEFNDQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBiaGVsZ2Fh
c0Bnb29nbGUuY29tOw0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tDQo+IENjOiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogUmU6IFtSRVNF
TkQgdjIgMS81XSBQQ0k6IGlteDY6IEVuY2Fwc3VsYXRlIHRoZSBjbG9jayBlbmFibGUgaW50bw0K
PiBvbmUgc3RhbmRhbG9uZSBmdW5jdGlvbg0KPiANCj4gQW0gRnJlaXRhZywgZGVtIDE1LjEwLjIw
MjEgdW0gMTQ6MDUgKzA4MDAgc2NocmllYiBSaWNoYXJkIFpodToNCj4gPiBObyBmdW5jdGlvbiBj
aGFuZ2VzLCBqdXN0IGVuY2Fwc3VsYXRlIHRoZSBpLk1YIFBDSWUgY2xvY2tzIGVuYWJsZQ0KPiA+
IG9wZXJhdGlvbnMgaW50byBvbmUgc3RhbmRhbG9uZSBmdW5jdGlvbg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiANCj4gUmV2aWV3
ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiANCltSaWNoYXJk
IFpodV0gVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCA3OQ0KPiA+ICsrKysrKysr
KysrKysrKystLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygr
KSwgMzEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiA+IGluZGV4IDI2ZjQ5Zjc5N2IwZi4uMWZhMWRiYTZkYTgxIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTQ3MCwzOCAr
NDcwLDE2IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2VuYWJsZV9yZWZfY2xrKHN0cnVjdA0KPiBp
bXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+
IC1zdGF0aWMgdm9pZCBpbXg3ZF9wY2llX3dhaXRfZm9yX3BoeV9wbGxfbG9jayhzdHJ1Y3QgaW14
Nl9wY2llDQo+ID4gKmlteDZfcGNpZSkgLXsNCj4gPiAtCXUzMiB2YWw7DQo+ID4gLQlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSBpbXg2X3BjaWUtPnBjaS0+ZGV2Ow0KPiA+IC0NCj4gPiAtCWlmIChyZWdt
YXBfcmVhZF9wb2xsX3RpbWVvdXQoaW14Nl9wY2llLT5pb211eGNfZ3ByLA0KPiA+IC0JCQkJICAg
ICBJT01VWENfR1BSMjIsIHZhbCwNCj4gPiAtCQkJCSAgICAgdmFsICYgSU1YN0RfR1BSMjJfUENJ
RV9QSFlfUExMX0xPQ0tFRCwNCj4gPiAtCQkJCSAgICAgUEhZX1BMTF9MT0NLX1dBSVRfVVNMRUVQ
X01BWCwNCj4gPiAtCQkJCSAgICAgUEhZX1BMTF9MT0NLX1dBSVRfVElNRU9VVCkpDQo+ID4gLQkJ
ZGV2X2VycihkZXYsICJQQ0llIFBMTCBsb2NrIHRpbWVvdXRcbiIpOw0KPiA+IC19DQo+ID4gLQ0K
PiA+IC1zdGF0aWMgdm9pZCBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QgaW14
Nl9wY2llDQo+ID4gKmlteDZfcGNpZSkNCj4gPiArc3RhdGljIGludCBpbXg2X3BjaWVfY2xrX2Vu
YWJsZShzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBk
d19wY2llICpwY2kgPSBpbXg2X3BjaWUtPnBjaTsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9
IHBjaS0+ZGV2Ow0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+IC0JaWYgKGlteDZfcGNpZS0+dnBj
aWUgJiYgIXJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0+dnBjaWUpKSB7DQo+ID4gLQkJ
cmV0ID0gcmVndWxhdG9yX2VuYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAtCQlpZiAocmV0
KSB7DQo+ID4gLQkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSB2cGNpZSByZWd1bGF0
b3I6ICVkXG4iLA0KPiA+IC0JCQkJcmV0KTsNCj4gPiAtCQkJcmV0dXJuOw0KPiA+IC0JCX0NCj4g
PiAtCX0NCj4gPiAtDQo+ID4gIAlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoaW14Nl9wY2llLT5w
Y2llX3BoeSk7DQo+ID4gIAlpZiAocmV0KSB7DQo+ID4gIAkJZGV2X2VycihkZXYsICJ1bmFibGUg
dG8gZW5hYmxlIHBjaWVfcGh5IGNsb2NrXG4iKTsNCj4gPiAtCQlnb3RvIGVycl9wY2llX3BoeTsN
Cj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlyZXQgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoaW14Nl9wY2llLT5wY2llX2J1cyk7DQo+ID4gQEAgLTUyNCw2ICs1MDIsNTEgQEAg
c3RhdGljIHZvaWQgaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+ID4gaW14
Nl9wY2llICppbXg2X3BjaWUpDQo+ID4NCj4gPiAgCS8qIGFsbG93IHRoZSBjbG9ja3MgdG8gc3Rh
YmlsaXplICovDQo+ID4gIAl1c2xlZXBfcmFuZ2UoMjAwLCA1MDApOw0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gKw0KPiA+ICtlcnJfcmVmX2NsazoNCj4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShp
bXg2X3BjaWUtPnBjaWUpOw0KPiA+ICtlcnJfcGNpZToNCj4gPiArCWNsa19kaXNhYmxlX3VucHJl
cGFyZShpbXg2X3BjaWUtPnBjaWVfYnVzKTsNCj4gPiArZXJyX3BjaWVfYnVzOg0KPiA+ICsJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9waHkpOw0KPiA+ICsNCj4gPiArCXJl
dHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGlteDdkX3BjaWVfd2Fp
dF9mb3JfcGh5X3BsbF9sb2NrKHN0cnVjdCBpbXg2X3BjaWUNCj4gPiArKmlteDZfcGNpZSkgew0K
PiA+ICsJdTMyIHZhbDsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IGlteDZfcGNpZS0+cGNp
LT5kZXY7DQo+ID4gKw0KPiA+ICsJaWYgKHJlZ21hcF9yZWFkX3BvbGxfdGltZW91dChpbXg2X3Bj
aWUtPmlvbXV4Y19ncHIsDQo+ID4gKwkJCQkgICAgIElPTVVYQ19HUFIyMiwgdmFsLA0KPiA+ICsJ
CQkJICAgICB2YWwgJiBJTVg3RF9HUFIyMl9QQ0lFX1BIWV9QTExfTE9DS0VELA0KPiA+ICsJCQkJ
ICAgICBQSFlfUExMX0xPQ0tfV0FJVF9VU0xFRVBfTUFYLA0KPiA+ICsJCQkJICAgICBQSFlfUExM
X0xPQ0tfV0FJVF9USU1FT1VUKSkNCj4gPiArCQlkZXZfZXJyKGRldiwgIlBDSWUgUExMIGxvY2sg
dGltZW91dFxuIik7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGlteDZfcGNpZV9kZWFzc2Vy
dF9jb3JlX3Jlc2V0KHN0cnVjdCBpbXg2X3BjaWUNCj4gPiArKmlteDZfcGNpZSkgew0KPiA+ICsJ
c3RydWN0IGR3X3BjaWUgKnBjaSA9IGlteDZfcGNpZS0+cGNpOw0KPiA+ICsJc3RydWN0IGRldmlj
ZSAqZGV2ID0gcGNpLT5kZXY7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlmIChpbXg2
X3BjaWUtPnZwY2llICYmICFyZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2X3BjaWUtPnZwY2llKSkg
ew0KPiA+ICsJCXJldCA9IHJlZ3VsYXRvcl9lbmFibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+ID4g
KwkJaWYgKHJldCkgew0KPiA+ICsJCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBlbmFibGUgdnBj
aWUgcmVndWxhdG9yOiAlZFxuIiwNCj4gPiArCQkJCXJldCk7DQo+ID4gKwkJCXJldHVybjsNCj4g
PiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0ID0gaW14Nl9wY2llX2Nsa19lbmFibGUo
aW14Nl9wY2llKTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgInVuYWJs
ZSB0byBlbmFibGUgcGNpZSBjbG9ja3NcbiIpOw0KPiA+ICsJCWdvdG8gZXJyX2Nsa3M7DQo+ID4g
Kwl9DQo+ID4NCj4gPiAgCS8qIFNvbWUgYm9hcmRzIGRvbid0IGhhdmUgUENJZSByZXNldCBHUElP
LiAqLw0KPiA+ICAJaWYgKGdwaW9faXNfdmFsaWQoaW14Nl9wY2llLT5yZXNldF9ncGlvKSkgeyBA
QCAtNTc4LDEzICs2MDEsNyBAQA0KPiA+IHN0YXRpYyB2b2lkIGlteDZfcGNpZV9kZWFzc2VydF9j
b3JlX3Jlc2V0KHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPg0KPiA+ICAJcmV0dXJu
Ow0KPiA+DQo+ID4gLWVycl9yZWZfY2xrOg0KPiA+IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlt
eDZfcGNpZS0+cGNpZSk7DQo+ID4gLWVycl9wY2llOg0KPiA+IC0JY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKGlteDZfcGNpZS0+cGNpZV9idXMpOw0KPiA+IC1lcnJfcGNpZV9idXM6DQo+ID4gLQljbGtf
ZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llX3BoeSk7DQo+ID4gLWVycl9wY2llX3Bo
eToNCj4gPiArZXJyX2Nsa3M6DQo+ID4gIAlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0
b3JfaXNfZW5hYmxlZChpbXg2X3BjaWUtPnZwY2llKSA+IDApIHsNCj4gPiAgCQlyZXQgPSByZWd1
bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgCQlpZiAocmV0KQ0KPiANCg0K
