Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B553E432FF8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 09:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhJSHq2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 03:46:28 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:21729
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230207AbhJSHq1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 03:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC9w7S8OnKI/A3FOwKDvNNGMV8LzvSrwB3V/RquogUoc3iPzzfiugmDoFClBhrrKuGssP+9xHEN3ent/5QDNvjOEfLDn7TETztFLhemQMYEMKX8tOiRQwxTYZNM/NaTGTn0U7Hmwkgr5PwlkIhIr+/WDOMJWuGhTs5IFeq3U64pXs1KRIWowc5j3JYJTPDoRq/hgUGIMviu0tSQ1sWVp9K79O9mcepkTTs5Le+BLkBnDaS68pLPmElW1bWlV6MP+TsV6FwQ6WN+ZyovQXz45wG7Z83mflTKgASLfyXtzizqs/zcy6YY6hH8iQvbAzaRnRGD53AL5SghTRaXL/IsOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsZDdt5v0zd7n9k5jtqJwvkh+MsJbk99STmOOGJOaUE=;
 b=P6wngoB3N6gd7bx18ccfsXzZNl9x+8G0D2Fo0XrsPa1fBldKn2aXwjAMj3Qo7pGlw09HBlsq+4X6iQDATWh2YOjjuf5/y6D5Dgfo8cu2awZ06ZtbKN79wwC186wsWbC0nWQuAZHgHA0ZXOaZ6/ARtIxx8N6iwTzAVnFL+ahQmQWQ7+69jBpZUEqO5w6WA7OEHxde3TRtVRikgFWN6E/noHGvJSejUrbxJXVS2KDlCwz30KZtgaRbV4G3cfc9/haILlSvUG1Byn+EsWnKIRD4FRG+9bmqqrSBMkdh9WGPEgcOzYKZCN54lnMAj7hBPhTaw6mediK6dzGBn+fnFV3YVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsZDdt5v0zd7n9k5jtqJwvkh+MsJbk99STmOOGJOaUE=;
 b=nU+Z6JcAAfFsJHNpZq1wWOfepzgev6DJPRoAHOE99fxRH3mnR4MNw2v/ONLq2BxDM594DKUQi47hDUYVwkaKu8ic2inN86H74HOw+8acFv5wz8xgKnlXXnZg8uY3Rf7XzrI3CUO6Pxn3BmPPkZgqy9cDJw9VaKSyy6lKS/VfiT8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8721.eurprd04.prod.outlook.com (2603:10a6:20b:428::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 07:44:12 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:44:12 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: RE: [RESEND v2 3/5] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Topic: [RESEND v2 3/5] PCI: imx6: Fix the regulator dump when link
 never came up
Thread-Index: AQHXwY4tcTr8p7Uwa0qomeYelO+fgavUY4qAgAWTd1A=
Date:   Tue, 19 Oct 2021 07:44:12 +0000
Message-ID: <AS8PR04MB8676FD8266E1E9883251024E8CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
 <1634277941-6672-4-git-send-email-hongxing.zhu@nxp.com>
 <CAOMZO5DD9mouiBvYE0JwHEAJKENC3Af=j3tQbCsUfWCi8Ji8ug@mail.gmail.com>
In-Reply-To: <CAOMZO5DD9mouiBvYE0JwHEAJKENC3Af=j3tQbCsUfWCi8Ji8ug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e782d28c-c99f-441e-fcaf-08d992d43e7d
x-ms-traffictypediagnostic: AS8PR04MB8721:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8721E321982EF57097D90A578CBD9@AS8PR04MB8721.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7t2AErR6LjQieQ66s7TEjNXNCSOvbe59uMQbteE9Fu8cZj2b8GvtzHL9vaSkVBGh8GH/bdp33V6U/J9BLxnnmZJKxOimzPIUwXKuFGIS2DTaCTJ1r/scQ8Z0bm0HnTdRcddcOS4ZG5Gvb7DcZwdmQTUN6PZV5BY67hSo6k3hp984HgYmdblgQTTpdPobz5AOFr6vIU+G4YtPFJRvkUwpVw4LovCwTqrcZBs6EUjJox9XFdHwm3iRvCtjHdRDiF3CQb+zewZaPTwMYNokCNQmuL81HNUdy2LJHdsJ0s0BC2UAKvNhMg7sIN/H5p2FM+nccG2J02s3/egRSuaJB0O3WlyCBSOraeXu47APsCYamdpCanARgN1PbMM6oy+ijHNEpR4YP/mGyPmqafoTK5+e/eX/WNc9taMwh7l4KObxnSgEebsg7TIm5Cfux/wxPok2oEu/Y6GRdBnDHCOzmgt1cSncOJWE1zCd2LPvfM+ecA5NVsfmPNfBH5/YJ+TkiT7DFe7KQDC22HK5/5W6xY0yFhtYLvb2qB+EblRMnsWwxn4r3vIVASsNK4EfZCjYnQLkts8V4LHdKX6sLYHMAV31wXBUjyboxDNr8oNIl6YcapSSpMLglmtxsoMsmrZXkFl3/fpq17bHVCMQFWrhoQFbnbwG4VJ+tzvqFJ0E3PzoF3/PMtSot5MIXhpwm3IRCH6LaLzUqIji1qAuXRliBV/hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(55016002)(54906003)(45080400002)(6506007)(71200400001)(53546011)(186003)(66446008)(26005)(2906002)(9686003)(7696005)(316002)(86362001)(38100700002)(64756008)(122000001)(38070700005)(66946007)(33656002)(52536014)(4326008)(6916009)(76116006)(66556008)(8676002)(66476007)(83380400001)(508600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnFCTHZPN25OV1R0UTNCcjVsTDlISkYvREM5cU5Eemk4WHJNT0d5Skx1d1VS?=
 =?utf-8?B?NCtncnF6ekVQQ042ekdrMm5ZcXRJdUcyVFNvbkQrZmN3Vlo2UHE2UjlsUkRn?=
 =?utf-8?B?WVRObXc5em4vMDV4dThvdlloMnYzOTlXMU9HVzM0R0hUSDJ3dE8yMTFRdU5O?=
 =?utf-8?B?ZUxhQWVjZGdyaGRMQTcyVldLTXprRXRKbnl5RW5Pc3pyU2o4QVhLTTE0dTR2?=
 =?utf-8?B?QlpEanBwcU4veVZiU25LcHZiMThRemFFYk1KNngxMmVSWUlPMitsNGlYSHl3?=
 =?utf-8?B?NWxLc2UrT1pVbWY2OE9adUcxY1ZFNHppeVhsMHJZK2Evb0V1U3dwYWw2MWF4?=
 =?utf-8?B?eUg0N21ZUzdoMmVLeUdSMHNCT0tOeWJDRTFINGFuV0dsZUNEdEliejRwaFNN?=
 =?utf-8?B?TjlZK0NYNmZyK3VlRGtZYzR6NlBtVzRzL2pTOTVxVVNxeThVWmlUaXlxMlIz?=
 =?utf-8?B?a2FIbVlaRllDZk1OR3QyUUFlSVF4V0NRN1NDN1AzNmZXYzdETFFCczJwRFQ2?=
 =?utf-8?B?TkduTDEzMkFodnM2a2h1dFhmY3pRU3ZvdFVwK3A0ZkFVaDZ6T0RxdE1xK1B0?=
 =?utf-8?B?b25Sbm5md3dnd3VmU1k0VVZCcHJJU0k5UEwxa0ZhZG9uTys0T0wrcmFlZENT?=
 =?utf-8?B?Um1JVFVScXRaUGxNbXYxMUhVL1hYbWgzN1RJWDRKYWp6ZjBUTzRCZ0oxTnM4?=
 =?utf-8?B?eURKZHFFOEhlZDRUODdFeXhtZVVFaTlRR0ZzWnF2eGE5Rk55dXBnV0hDOXRK?=
 =?utf-8?B?bkZ6OSswdERoSTh5UzNIMzJZWlR2V1JlSGZmeUlSTGdtbkVic2ZEMnpBNkdN?=
 =?utf-8?B?TVBQOWVwaWIxVndPZ045N1JsNGlqRm5EZ3pDNDhKZVB3OXdzRnBkanc3bGdi?=
 =?utf-8?B?YnpscUdhV2VVUzBROXAzRXhROGFQcTZDMmdYZzlNdjN4a0lSbjBYUldkTWFR?=
 =?utf-8?B?NS96eDFFOHhXL3h2UWRHNHp1c1FUNnh3ZVhuVVdUUXBocDBpVkl0UkU4b012?=
 =?utf-8?B?MjhDRVlLbWNmVFN5TnVGUHAyUUNDclBGYjloUHFOZVU3c2s5NTMrdDJ6dU00?=
 =?utf-8?B?YVFpcENPQUhTWHpwbDVpMFVqOWdJbUU5Vkg2d3FGM3hWSVZpWmdZVllURUlm?=
 =?utf-8?B?QitnQ2ZkeURQc1pkMzMvYzlEcjlQekxlZUJSSXA5Mmhzb1N2RksxN0xLWHd3?=
 =?utf-8?B?aTdNVGRGaTkvY0JPTFhDcHRkWWNBbW43NEpGUUZheU5OYnlyYVVBWEdCTzYv?=
 =?utf-8?B?OGhNNm81aTUyMmp5Z3JoSXNibHlUMmFPNlQ3U3ZvVTVrL21INXI2TEYzejlq?=
 =?utf-8?B?bkV6TzZXNHlhRmZHdUovTEdSVGNST1lUcGE2cGlmbDYwL1owWVhZbE5Vc25W?=
 =?utf-8?B?SkRCNzAyWkYrNjVGbmxaaVJ5WUhFRlBaVUpLUUc3aE9XZ0wvdlBwZ0FLTGlP?=
 =?utf-8?B?SHB0S1FRQ2NRV0hVTW12YUw2RG83Q09SM1cxVkozVUdQQmtGRFlZTjNGdHdy?=
 =?utf-8?B?RnFsT2xGUXBkUDMwVVNuU0R1YjE0R2RUQSs2eEVNQ3MrSUc1aEFkUUdZNFpm?=
 =?utf-8?B?eGtUdzBGSE4rMUNRd01KZitvVDJ0MEYyQ0MrSXBFam1oU0ZEREpPaUhma0Ey?=
 =?utf-8?B?eUhDM2pWNTdrSnE4V1g1ejZnRHJ4NzhVb1Ftdm1XMTJUV0JQRUwzeHhYaTJj?=
 =?utf-8?B?NjBuaDhLTzlycEdEVHBxRU42aUtLUmZCbkEzbGo4U1lGVjcvSnd6clVYV01x?=
 =?utf-8?Q?F6n7YF7uEQdRxiB6DP0Wf7OfpVhTVvsqBShlkdp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e782d28c-c99f-441e-fcaf-08d992d43e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 07:44:12.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/OAQ+uwnn+ng8ja0TLBRBRIRE3+MM0JfPhIvc1G95iSiFvrI4Q7ibDcGkrfBnmdDZbCHhHshTjOSnHFcSc8NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8721
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTYsIDIwMjEgMjoz
NSBBTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogTHVj
YXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+OyBCam9ybiBIZWxnYWFzDQo+IDxiaGVs
Z2Fhc0Bnb29nbGUuY29tPjsgTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFy
bS5jb20+Ow0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsgbW9kZXJhdGVkDQo+IGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMg
QVJNIEFSQ0hJVEVDVFVSRQ0KPiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
PjsgbGludXgta2VybmVsDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU2FzY2hh
IEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5EIHYy
IDMvNV0gUENJOiBpbXg2OiBGaXggdGhlIHJlZ3VsYXRvciBkdW1wIHdoZW4gbGluaw0KPiBuZXZl
ciBjYW1lIHVwDQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gT24gRnJpLCBPY3QgMTUsIDIwMjEg
YXQgMzozMiBBTSBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gV2hlbiBQQ0llIFBIWSBsaW5rIG5ldmVyIGNhbWUgdXAgYW5kIHZwY2llIHJlZ3VsYXRv
ciBpcyBwcmVzZW50LCB0aGVyZQ0KPiA+IHdvdWxkIGJlIGZvbGxvd2luZyBkdW1wIHdoZW4gdHJ5
IHRvIHB1dCB0aGUgcmVndWxhdG9yLg0KPiA+IERpc2FibGUgdGhpcyByZWd1bGF0b3IgdG8gZml4
IHRoaXMgZHVtcCB3aGVuIGxpbmsgbmV2ZXIgY2FtZSB1cC4NCj4gPg0KPiA+ICAgaW14NnEtcGNp
ZSAzMzgwMDAwMC5wY2llOiBQaHkgbGluayBuZXZlciBjYW1lIHVwDQo+ID4gICBpbXg2cS1wY2ll
OiBwcm9iZSBvZiAzMzgwMDAwMC5wY2llIGZhaWxlZCB3aXRoIGVycm9yIC0xMTANCj4gPiAgIC0t
LS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+ICAgV0FSTklORzogQ1BVOiAz
IFBJRDogMTE5IGF0IGRyaXZlcnMvcmVndWxhdG9yL2NvcmUuYzoyMjU2DQo+IF9yZWd1bGF0b3Jf
cHV0LnBhcnQuMCsweDE0Yy8weDE1OA0KPiA+ICAgTW9kdWxlcyBsaW5rZWQgaW46DQo+ID4gICBD
UFU6IDMgUElEOiAxMTkgQ29tbToga3dvcmtlci91ODoyIE5vdCB0YWludGVkDQo+IDUuMTMuMC1y
YzctbmV4dC0yMDIxMDYyNS05NDcxMC1nZTRlOTJiMjU4OGEzICMxMA0KPiA+ICAgSGFyZHdhcmUg
bmFtZTogRlNMIGkuTVg4TU0gRVZLIGJvYXJkIChEVCkNCj4gPiAgIFdvcmtxdWV1ZTogZXZlbnRz
X3VuYm91bmQgYXN5bmNfcnVuX2VudHJ5X2ZuDQo+ID4gICBwc3RhdGU6IDgwMDAwMDA1IChOemN2
IGRhaWYgLVBBTiAtVUFPIC1UQ08gQlRZUEU9LS0pDQo+ID4gICBwYyA6IF9yZWd1bGF0b3JfcHV0
LnBhcnQuMCsweDE0Yy8weDE1OA0KPiA+ICAgbHIgOiByZWd1bGF0b3JfcHV0KzB4MzQvMHg0OA0K
PiA+ICAgc3AgOiBmZmZmODAwMDEyMmViYjMwDQo+ID4gICB4Mjk6IGZmZmY4MDAwMTIyZWJiMzAg
eDI4OiBmZmZmODAwMDExYmU3MDAwIHgyNzogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ICAgeDI2OiAw
MDAwMDAwMDAwMDAwMDAwIHgyNTogMDAwMDAwMDAwMDAwMDAwMCB4MjQ6IGZmZmYwMDAwMDAyNWYy
YmMNCj4gPiAgIHgyMzogZmZmZjAwMDAwMDI1ZjJjMCB4MjI6IGZmZmYwMDAwMDAyNWYwMTAgeDIx
OiBmZmZmODAwMDEyMmViYzE4DQo+ID4gICB4MjA6IGZmZmY4MDAwMTFlM2ZhNjAgeDE5OiBmZmZm
MDAwMDAzNzVmZDgwIHgxODogMDAwMDAwMDAwMDAwMDAxMA0KPiA+ICAgeDE3OiAwMDAwMDAwNDAw
NDRmZmZmIHgxNjogMDA0MDAwMzJiNTUwMzUxMCB4MTU6DQo+IDAwMDAwMDAwMDAwMDAxMDgNCj4g
PiAgIHgxNDogZmZmZjAwMDAwMDNjYzkzOCB4MTM6IDAwMDAwMDAwZmZmZmZmZWEgeDEyOiAwMDAw
MDAwMDAwMDAwMDAwDQo+ID4gICB4MTE6IDAwMDAwMDAwMDAwMDAwMDAgeDEwOiBmZmZmODAwMDEw
NzZiYTg4IHg5IDogZmZmZjgwMDAxMDc2YTU0MA0KPiA+ICAgeDggOiBmZmZmMDAwMDAwMjVmMmMw
IHg3IDogZmZmZjAwMDAwMDFmNDQ1MCB4NiA6IGZmZmYwMDAwMDAxNzZjZDgNCj4gPiAgIHg1IDog
ZmZmZjAwMDAwMzg1Nzg4MCB4NCA6IDAwMDAwMDAwMDAwMDAwMDAgeDMgOiBmZmZmODAwMDExZTNm
ZTMwDQo+ID4gICB4MiA6IGZmZmYwMDAwMDAzY2M0YzAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgw
IDogMDAwMDAwMDAwMDAwMDAwMQ0KPiA+ICAgQ2FsbCB0cmFjZToNCj4gPiAgICBfcmVndWxhdG9y
X3B1dC5wYXJ0LjArMHgxNGMvMHgxNTgNCj4gPiAgICByZWd1bGF0b3JfcHV0KzB4MzQvMHg0OA0K
PiA+ICAgIGRldm1fcmVndWxhdG9yX3JlbGVhc2UrMHgxMC8weDE4DQo+ID4gICAgcmVsZWFzZV9u
b2RlcysweDM4LzB4NjANCj4gPiAgICBkZXZyZXNfcmVsZWFzZV9hbGwrMHg4OC8weGQwDQo+ID4g
ICAgcmVhbGx5X3Byb2JlKzB4ZDAvMHgyZTgNCj4gPiAgICBfX2RyaXZlcl9wcm9iZV9kZXZpY2Ur
MHg3NC8weGQ4DQo+ID4gICAgZHJpdmVyX3Byb2JlX2RldmljZSsweDdjLzB4MTA4DQo+ID4gICAg
X19kZXZpY2VfYXR0YWNoX2RyaXZlcisweDhjLzB4ZDANCj4gPiAgICBidXNfZm9yX2VhY2hfZHJ2
KzB4NzQvMHhjMA0KPiA+ICAgIF9fZGV2aWNlX2F0dGFjaF9hc3luY19oZWxwZXIrMHhiNC8weGQ4
DQo+ID4gICAgYXN5bmNfcnVuX2VudHJ5X2ZuKzB4MzAvMHgxMDANCj4gPiAgICBwcm9jZXNzX29u
ZV93b3JrKzB4MTljLzB4MzIwDQo+ID4gICAgd29ya2VyX3RocmVhZCsweDQ4LzB4NDE4DQo+ID4g
ICAga3RocmVhZCsweDE0Yy8weDE1OA0KPiA+ICAgIHJldF9mcm9tX2ZvcmsrMHgxMC8weDE4DQo+
ID4gICAtLS1bIGVuZCB0cmFjZSAzNjY0Y2E0YTUwY2U4NDliIF0tLS0NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gDQo+IEkgYW0g
c2VlaW5nIHRoaXMgb24gaW14NiB0b28uIFdoZW4geW91IHNlbmQgYSB2MiwgYWZ0ZXIgYWRkcmVz
c2luZyBMdWNhcycNCj4gY29tbWVudHMsIHBsZWFzZSBhZGQgYSBGaXhlcyB0YWcvDQpbUmljaGFy
ZCBaaHVdIE9rYXksIG5vIHByb2JsZW0uIFRoYW5rcy4NCkJSDQpSaWNoYXJkDQo=
