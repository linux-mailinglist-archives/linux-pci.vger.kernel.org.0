Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3524B02B2
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 03:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiBJB7c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 20:59:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiBJB7K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 20:59:10 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40079.outbound.protection.outlook.com [40.107.4.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D42BB05;
        Wed,  9 Feb 2022 17:49:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En5i4Q40FmcWCCPT7RfIsvLZ704nSgOKNFwntt2j9lmxJjQ/ATMOWrlq6V1dVIA9kUAciR/Yo91eSvedpygH+ct6utQD5lXqLcBeZDo+OGoxxBdJwzWB4ofoUuHusVfpW9KJX9ch3we7WlQM7IhNS1x0s54bcMkT8KyoZ86o7JIISU7OAFJXdOTmTvBA7v2jUHJ9C7SVOcfY2maxHRC9740KjvbQRVXBAeO1uiSchM2cdZsGdrg0DNhHjNtIpY3Eo3EKWoDAEYVAwimLIVVXBNDw3Aqkbk8kjkhJnMfp2iyD+jECNrO+/5ZRpQ/vv/t5M7n544CBDwUOB60LsEAATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiPd+1t7tx4nAqNnUXoQYwc0/VeLRG2sb/m6bdT3CME=;
 b=cBzNQ/E/fpKZW/shKDGiGdknZI72diQkAw4QWLluOdhlRmEaBy9ZT2k0N9o8XKaO7UKRnMXQsigiCCPuhTb5QApibvzVI4gQ4dZmp+zSQ9SfeCD05nRO///Fxyw+eH82BE5rDGwQgHNuv33BEBNZWn0odgLZPxCSQU10zu1U2BF97ocfK/SZsCsqvGOMcvc8hcxeAddOvGtTR1P6Kjy4yr6OjIyamhcKHdNrA7705LWmnaDEWtXFc8EM/BUh76XRfcxKWH57tTjmIDRcsqVYFisloDjMvkqunocCcWaX4h5hZnB0WdGhx+aEMuJXPZ6NIoc8ySGdqWkmzB4iv9KjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiPd+1t7tx4nAqNnUXoQYwc0/VeLRG2sb/m6bdT3CME=;
 b=EZQDLRXXzwbGrILaGjYQw+Oj5DxGxdg7fK4lzdDYVSz/TWXJFB06aqhLST0EesBBlEvrWfd73z4Z535SBWBfdRVgR1KjenD0XHOtPZoyvjKXCsEkv4MbmLW5kvRwylqf+jYNRJObJz0Ib1aIDQfmICfIo2iJl3ud2+eglGQzbp4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB4606.eurprd04.prod.outlook.com (2603:10a6:803:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 01:49:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 01:49:01 +0000
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
Subject: RE: [RFC 1/2] ARM: dts: imx6qp-sabresd: Enable pcie support
Thread-Topic: [RFC 1/2] ARM: dts: imx6qp-sabresd: Enable pcie support
Thread-Index: AQHYHYdu67AFaSp4qEGLVrmOItYVrayK7T8AgAESc1A=
Date:   Thu, 10 Feb 2022 01:49:01 +0000
Message-ID: <AS8PR04MB8676827B341CCD4580DF53198C2F9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644390156-5940-1-git-send-email-hongxing.zhu@nxp.com>
 <936cc917828bfa3c089a33f0af219fecdc2a778a.camel@pengutronix.de>
In-Reply-To: <936cc917828bfa3c089a33f0af219fecdc2a778a.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6db21ba-ca4d-487c-1e16-08d9ec37834a
x-ms-traffictypediagnostic: VI1PR04MB4606:EE_
x-microsoft-antispam-prvs: <VI1PR04MB4606920412AB587FC17731268C2F9@VI1PR04MB4606.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utR/Wj8KDP+VkrAcluUJHe0jUS+ehvWsFYUfoEIUXAUay5KurY2tQl9HjBL40Bk/oiSgszbFKxBl5T+kkejPFdRxd9okrdoynM9tvYnygYaZRTOopqVXYfGutPDLhzmqjQWEK9Z2ZtTBqxQUqCzV9rLDlXPMga4OFJgX3s4sJM8MkrVfImpScJSWCy7UebcpGAT2vhtRM21Eom2WefKzDzCJn3RNvSrDqTMFJs2dbsEACp2EpB2vHQVUOmgRviaq0qW4taHbyheO+sf4uuO2ypt3vyGTG4RaHB8Tl6OIu55Nyr7cD8XBHo5Cx363x2uAliGcx2Cah4Dt0tQtlYM8BYmyMme42Uj0ckPNSR8eEY5C4hGcLqcVETW5YNb6WhWkjyPFRnMR88j6DrDe+3CdZYy7IDcxMDhv9Zg9pFBb5x/fBEAL6y1fVzSXY7rENlsdxZ1qcZXFnSASJ85b7KKGTzqQSccZwd7w9BhO1NZN20L6ae70BKjExAC7mTJb6keOYmIRQE3y6+AjqQW3cyJg7l7rHIVKmdMCCiNFcP576ihJ4hMsTvsh0uwGid3RDxBIJJOzwJ8DuWggZbc9aGU69nXfg0InfaUfya9RJS+BeUWv+/Lkx9sr8k6jlmuAGBw4dXB0tElekQ+wNAhkx1fsasCChFYQJeSP/UJEE+1qEMDY1QtXzrdrP8a4IoRozlPpYb55MNE8Er0CuAxgacVX0e9ULs07Wa3oW2H82yyUJoY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66446008)(76116006)(66476007)(38100700002)(83380400001)(38070700005)(53546011)(122000001)(508600001)(8936002)(8676002)(66946007)(66556008)(55016003)(4326008)(52536014)(86362001)(316002)(110136005)(54906003)(26005)(44832011)(2906002)(186003)(5660300002)(9686003)(6506007)(7696005)(33656002)(71200400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1lvcVVGOG12bWpCVXlrQUU3RUtUZDVPZjh5WDdUc0hKTktPUllOT1Q5ejhW?=
 =?utf-8?B?aUhKRENQbks3aW9IYWFIZzBVN3pGWHh4NXVRNlM1R0F1dVQwS0MzLzk2WVBK?=
 =?utf-8?B?OHBTaHozUGRjM1N4VTZNVlNhYU1pZ3BjTDZ0elYyekgvYXl3MW1WcVI4eTlZ?=
 =?utf-8?B?S0J4UVcxUTA1eVRXU2pYNEEvR2Z2bERraStUenhrVjRQTnRkRW9FdDUzaDFm?=
 =?utf-8?B?ekxDM2x5bEpscGRtNGpPS3doZ292MzhIbSt5Q1YrY1d4MTE2TFpMTHJkZE8x?=
 =?utf-8?B?TGJHdnhaOGovVnA3UllldUVycEkyVFZSZW5aRHRqNFBFMGVSQTB0aGl2d2Rv?=
 =?utf-8?B?Yjlnd1FVaUEzamxVTmJ3VWpsckVHblZtenlHSEJKK0ZDemlyekFOdkhvMGRL?=
 =?utf-8?B?MkJFazhUd3dNTmtMZkkySHg0RjB2RXJjMldmNnZEVWdQK1JZTHlYZHRhaEd5?=
 =?utf-8?B?MjhjUWdZS3pxNlJ2SmF0NnFCOUlXU3FGdy8vL21tRlhFdVpGVkkva0tMOFdk?=
 =?utf-8?B?WWVwTm1IQ0txMHFzUGU4UFZOVEI1djgvZlN1eE1ieUdJU1dCaHliY2E5cEFE?=
 =?utf-8?B?UHlxUWtGRkhraXNpMmZ5SDg1bUJaZkdiSHdOM0FJZUdTdHl2TDMyNlN2eFBm?=
 =?utf-8?B?VG1reFhZM3dwSUVOUENvRWkzQi9TYWdqbFpDNktRUXFhd1RWRlVQeUZkUy84?=
 =?utf-8?B?UGFzQTdMcHlJMkNSZWlOSnF3aFpGclhyWk5zWWdHcTRhM0toeU9qZ0JoTTl6?=
 =?utf-8?B?YWZNSUtZam9ycDBoWjV2aU1FWnQwc2VDQmdXaW1odGdsL2JGcUhBRy9Pd1oz?=
 =?utf-8?B?QjhWTlpORmoxa1J5VE5Mbk9DSEFHdTRiMDFPYWEwR1g5YnJ6UzF5U2lVVmVh?=
 =?utf-8?B?VjB3WDFPUllSeW4vNTl4Q1hLNElMMTFHMGNaYkhaejRML1MwL3NQaElUMlFR?=
 =?utf-8?B?SGJaYmFzbGhLcGdPMUsvZS9VTTVRNkc0ZTVFUXB5b2kzZXlPVWpqSStjMGZV?=
 =?utf-8?B?aEh1ZFhJUmhsejhRVG5oNVNjTmozY1lIcG00VDA2bm12V1pxQVFHM3VCcDNE?=
 =?utf-8?B?V1dnL1FIWFpXTzlXcVAzbjFhMFVSMDBJOHBUTklOamU0RUxYdWFtTXZrdXRk?=
 =?utf-8?B?RXd4UCsySHBoRC8wSnNHV1B5cFZ3NWRQeCtUVUh4OGF4Q2g0Y1RqMFpvMDF1?=
 =?utf-8?B?WXdmaGhwTnNncG9JRFR5TXJING9HZ1RlRUd6dzc1VUo3M1hzUnNKSWRGTkhv?=
 =?utf-8?B?eGczekNSY0RLWmFDQjBNdGJkMUhaY3NvNEtEdDREMXNHOXRNYW1nMGpkK1BO?=
 =?utf-8?B?dzZRcjZuM1ZueVNDQW5yNHNTc2JYL3ZVMm5xNFJ6NlNWRTBabFJTQUtvZ0FY?=
 =?utf-8?B?cEJTNDBoWThJOUEvZFZ2MVFuOTdOMnRmcFZsOUlQRWVQbFhFaytMTjBlbEhD?=
 =?utf-8?B?TldTNkNIVEx3WFJlK1RXY1ZONkk3ZDdhQjFZbTZaQkloU1FaMGJwZFRpQUJR?=
 =?utf-8?B?eDdCSmJ0QnBvZmF6VS9FcTJPNW5FeWFXTVpLU3MrMDVIcHQ5UGhsUzFYUWp6?=
 =?utf-8?B?dFV2YUF6bnVkMWZ1cnY1V2lybTFTVm1ubEdNQks0MitNQnlFOFRMMTlneGpY?=
 =?utf-8?B?Sk8xYUQzQitjUFM2NTFpWWRYQXQxTDc1NFNiWlAvMTVKV3AwTi9pK1J0bHh1?=
 =?utf-8?B?OFpIV3BqamtmaUJ1L2NGUHZ0eS9Ia3Y3Z2VmSWEvdExRWWQ4V2xxVmdTaVlC?=
 =?utf-8?B?T0ZqbUV6UElieGIxa2JDMThRQ0sxWG9YUHlDMTNHRWY5LzIyYUZEbmRwYmxT?=
 =?utf-8?B?N3dDRmlTNThyUUNNcmR4ZlN0VVBFTi91SzE0eTFJSEJjZlJqSk9CN3FyNit5?=
 =?utf-8?B?aWw2eWVXUGwyTjVrK0tyY1J6a2g5ck45blV2Vk52MVJpUDQzMGFSU2NwSmwz?=
 =?utf-8?B?RTVpWlM5anpPU053bGd2cDRVMFNiQUlPNWI5N3EzQmw1NVk4aHFXOG9NbzNO?=
 =?utf-8?B?NlQ2WXNLblRhRXBodTRyS2VDTmkrbS9nbU05YjhGQVRtU3dhSkFweGlzcWkr?=
 =?utf-8?B?TkJ1V0Rxc2JLSnkxcVRKOG1PZ2RFUkFIVXh1MlBsZnZEdnNJT3VLOGFWVDVH?=
 =?utf-8?B?dzZvTjRIRWpqREVVN0FRQmhiUlBiYVlpWStIcmZSSWZUUUc1QVYzcjdxZ1hm?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6db21ba-ca4d-487c-1e16-08d9ec37834a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 01:49:01.8883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWwEVxLA4QRX0n2hlrcV1//xsnYijAn8mwFxD2hwb0gWgsEeVt1PtcS3uJDgoJawkE+GIa9+MTUGtBZummekBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4606
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDLmnIg55pelIDE3OjA1DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPiBDYzog
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUkZDIDEvMl0gQVJNOiBkdHM6IGlteDZxcC1zYWJyZXNkOiBFbmFibGUgcGNpZSBzdXBwb3J0
DQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gQW0gTWl0dHdvY2gsIGRlbSAwOS4wMi4yMDIyIHVt
IDE1OjAyICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gSW4gdGhlIGkuTVg2UVAgc2Fi
cmVzZCBib2FyZChzY2gtMjg4NTcpIGRlc2lnbiwgb25lIGV4dGVybmFsDQo+ID4gb3NjaWxsYXRv
ciBpcyB1c2VkIGFzIHRoZSBQQ0llIHJlZmVyZW5jZSBjbG9jayBzb3VyY2UgYnkgdGhlIGVuZHBv
aW50IGRldmljZS4NCj4gPg0KPiA+IElmIFJDIHVzZXMgdGhpcyBvc2NpbGxhdG9yIGFzIHJlZmVy
ZW5jZSBjbG9jayB0b28sIFBMTDYoRU5FVCBQTEwpDQo+ID4gd291bGQgaGFzIHRvIGJlIGluIGJ5
cGFzcyBtb2RlLCBhbmQgRU5FVCBjbG9ja3Mgd291bGQgYmUgbWVzc2VkIHVwLg0KPiA+DQo+ID4g
VG8ga2VlcCB0aGluZ3Mgc2ltcGxlLCBsZXQgUkMgdXNlIHRoZSBpbnRlcm5hbCBQTEwgYXMgcmVm
ZXJlbmNlIGNsb2NrDQo+ID4gYW5kIGFsd2F5cyBlbmFibGUgdGhlIGV4dGVybmFsIG9zY2lsbGF0
b3IgZm9yIGVuZHBvaW50IGRldmljZSBvbg0KPiA+IGkuTVg2UVAgc2FicmVzZCBib2FyZC4NCj4g
Pg0KPiBUaGUgY29tbWl0IG1lc3NhZ2UgZG9lc24ndCByZWFsbHkgbWF0Y2ggd2hhdCdzIGJlaW5n
IGRvbmUgaW4gdGhlIHBhdGNoLg0KPiBNYXliZSB5b3UgbWVhbnQgdG8gc2F5IHRoYXQgZXZlbiB0
aG91Z2ggdGhlIEhXIGRlc2lnbiBpcyBkaWZmZXJlbnQgeW91IGFyZQ0KPiBlbmFibGluZyB0aGUg
UENJZSBjb250cm9sbGVyIGluIHRoZSBzYW1lIHdheSBhcyBvbiB0aGUgNlEgc2FicmVzZD8NCj4g
DQo+IEFsc28sIGlzIHRoaXMgY29uZmlndXJhdGlvbiBzdGFibGUgZm9yIHlvdT8gV2UndmUgaGFk
IHNvbWUgaXNzdWVzIHdpdGggdGhpcyBraW5kDQo+IG9mIHNwbGl0IGNsb2NraW5nIHNldHVwIGlu
IGEgY3VzdG9tZXIgZGVzaWduLCB3aGVyZSBpdCB3YXMgZW5hYmxlZCBieSBhY2NpZGVudCwNCj4g
ZHVlIHRvIFBMTDYgbm8gYmVpbmcgYnlwYXNzZWQuIEluIHRoaXMgZGVzaWduIGl0IGNhdXNlZCB0
aGUgbGluayB0byByYW5kb21seQ0KPiBkcm9wIHVuZGVyIGxvYWQgYW5kIGNhdXNpbmcgYWJvcnRz
IG9uIHRoZSBDUFUgc2lkZSwgZHVlIHRvIGNvbXBsZXRpb24NCj4gdGltZW91dHMuIEkgdGhpbmsg
aXQgYXQgbGVhc3Qgd2FycmFudHMgYSBjb21tZW50IHNvbWV3aGVyZSB0aGF0IHRoaXMgaXNuJ3Qg
YQ0KPiByZWNvbW1lbmRlZCBzZXR1cC4NCkhpIEx1Y2FzOg0KVGhhbmtzIGZvciB5b3VyIHJldmll
dy4NClRoZXJlIGlzIGEgZGlmZmVyZW5jZSBiZXR3ZWVuIGkuTVg2US9ETCBzYWJyZXNkIGFuZCBp
Lk1YNlFQIHNhYnJlc2QgYm9hcmQuDQoNCk9uIGkuTVg2US9ETCBzYWJyZXNkIGJvYXJkIGRlc2ln
biwgdGhlIFBDSWUgY2xvY2sgdXNlZCBieSBFUCBkZXZpY2UgaXMNCiBvdXRwdXQgZnJvbSBpbnRl
cm5hbCBQTEwgYnkgQ0xLX04vUCBwYWRzLiBUaGlzIGNsb2NrIGhhcyBzb21lIGppdHRlcg0KIHBy
b2JsZW1zLCBhbmQgY2FuJ3QgcGFzcyB0aGUgR0VOMiBUWCBjb21wbGlhbmNlIHRlc3RzIGVpdGhl
ci4NCg0KVG8gbGV0IHJlbW90ZSBFUCBkZXZpY2UgdXNlIHF1YWxpZmllZCByZWZlcmVuY2UgY2xv
Y2ssIGFuZCBsZXQgUENJZQ0KIGhhcmR3YXJlIGRlc2lnbiBwYXNzIHRoZSBQQ0llIEdFTjIgVFgg
Y29tcGxpYW5jZSB0ZXN0cywgb25lIGV4dGVybmFsDQogb3NjaWxsYXRvciBpcyBwb3B1bGF0ZWQg
b24gdGhlIGkuTVg2UVAgc2FicmVzZCBib2FyZC4NCg0KVGhpcyBwYXRjaCBpcyBhcHBsaWVkIHRv
IGkuTVg2UVAgc2FiZXJzZCBib2FyZCwgYW5kIGVuYWJsZSBQQ0llIHBvcnQuDQpZZXMsIHRoZSBQ
Q0llIGlzIHN0YWJsZSBhbmQgcGFzcyB0aGUgR0VOMiBUWCBjb21wbGlhbmNlIHRlc3RzIG9uIGku
TVg2UVANCiBzYWJyZXNkIGJvYXJkDQoNClRoYW5rcy4NCkJlc3QgUmVnYXJkcw0KUmljaGFyZA0K
PiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9ib290L2R0
cy9pbXg2cXAtc2FicmVzZC5kdHMgfCA4ICsrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9pbXg2cXAtc2FicmVzZC5kdHMNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZxcC1zYWJyZXNkLmR0cw0KPiA+IGluZGV4IDQ4MGU3MzE4M2Y2Yi4uMDgzY2Y5MGJjYWI1
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1zYWJyZXNkLmR0cw0K
PiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1zYWJyZXNkLmR0cw0KPiA+IEBAIC01
MCw4ICs1MCwxNCBAQCBNWDZRRExfUEFEX1NEM19EQVQ3X19TRDNfREFUQTcNCj4gCTB4MTcwNTkN
Cj4gPiAgCX07DQo+ID4gIH07DQo+ID4NCj4gPiArJnZnZW4zX3JlZyB7DQo+ID4gKwlyZWd1bGF0
b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCj4gPiArCXJlZ3VsYXRvci1tYXgtbWljcm92
b2x0ID0gPDMzMDAwMDA+Ow0KPiA+ICsJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4gPiArfTsNCj4g
PiArDQo+ID4gICZwY2llIHsNCj4gPiAtCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gKwlzdGF0
dXMgPSAib2theSI7DQo+ID4gIH07DQo+ID4NCj4gPiAgJnNhdGEgew0KPiANCg0K
