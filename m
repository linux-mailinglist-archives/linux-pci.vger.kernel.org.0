Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3834874B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 04:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhCYDFI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 23:05:08 -0400
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:49345
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230274AbhCYDFB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 23:05:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oghf/i2mgezn03+79lExOV0jSsz9YKr/Gtkb47pYz6Qd2w7PKjmGf0Nur/i3MIM0MTzWkxHtWtd3YNkmMFQNvYiENTQTX1zDXXaZC8lMpgsU+sSwxZAo44M+OYehZSiJfRTnT94SIp5gnFpkGYJDBC/1iCi8o8BbJCZI7D2DUp6WE7OmsB6QYfTvgi6mQlEyDU3H47le0S3NwiIZujJ7ez9MWo5w4FKRXdzYgM89MapMb7Fhu1HyWXu5YI/WppGVyIprIoNUHq7olKkcCoYv/cixSaS3k0WVvrL+gEpwrikQ9O3kizgRUns1B70Nf3zzEQoAuklDeluPFZPCM2P8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgjJ1iRpsFHeXSUdNgBp2B955qnAqk2koqugwlm1XNs=;
 b=nqBISOX2cnLF1KIizkX2AsqdMjPgzcuER1HgMqZ5Alu8lTsofTgEfm1qE+Wkod2APP8TMlO2TIS+J/U74sZlzUss8bNgNF6PTyrXZsaQwCQQIYoS98eybs70GjOGwFOBeT/OQo98MpV59QEdAZgFZFMv8TZx5u48FHkDEqP2iIAV2k73Ii16Q2oRlwXnqlParqwf5aibOXZ5zuB2lQ8NZ8SDnu580nQDx5RZdUSuaLJXZwNAli45B56UICg9Y17HV2BX57iuh/Aj253xFgrWoflCd99y34DDU4WYkmgtVZw/SIuzETlPS4Z56xCab1QaduSxnIij81JOLg6CWS/3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgjJ1iRpsFHeXSUdNgBp2B955qnAqk2koqugwlm1XNs=;
 b=V2S7SE233gQUnSIKScubN48oFMgB95yLwL+O76ey+SLQqrtrGBI0W7aIe30/1psGaBuWct4w/oy+hM+ng7smwIAsajdrzrodTx4yoXIJ9Z58EXVT80HjehJFoRIkf9RTJXMoqBPam8zJzAIZKRnTUgTmH0zv7kBaaKHU01eL8MY=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0402MB2798.eurprd04.prod.outlook.com (2603:10a6:800:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 03:04:58 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 03:04:58 +0000
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
Subject: RE: Re: [PATCH v2 1/3] dt-bindings: imx6q-pcie: add one regulator
 used to power up pcie phy
Thread-Topic: Re: [PATCH v2 1/3] dt-bindings: imx6q-pcie: add one regulator
 used to power up pcie phy
Thread-Index: AdchHmTtmbx/Uf6YR/WCKABquy4MTw==
Date:   Thu, 25 Mar 2021 03:04:58 +0000
Message-ID: <VI1PR04MB5853E879F65E448244FBEF6F8C629@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbe7cc24-25f7-4b0d-9655-08d8ef3ac613
x-ms-traffictypediagnostic: VI1PR0402MB2798:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB27985C6DE04BDCD8EF6F16F08C629@VI1PR0402MB2798.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6EAvhOck40dvWn5buNVFUkB3yF6Ag+ioIM4vrF3VpbjeuOpS1DEvxOMVo+RuhhDnPW48ljuOKBngkKXQDkylZwmLC9P4bAADI8OLhDV5apGvaGxyuIX1jp63TQwbPz76KGbplysYSE1RkB17ZfGXfl6H+IQjiT2VUBJGyq3XzvnEof0EC/H5VBS4odUlc6WJ1Hd8+DqbyGcf3HIHwZOXh2hhYcNEK1NS5diaf4QhJUfH0CfPoLyYw2kIdKnfHIce5ZSpcvl6qwMDOvMysQpLG4oktRrXGQKjSLockMvIAN+5V61RIFHY79PcIKMVecUC3xAgg7TX5zQa+0xG5rN6Vj69b1dw7UMx/rwipfTA4zZRg5qsTJiDB5cBJM+V7YkbfiGReaCCPjuq6/ARVXflQLTYFFi+66r8VAi1PHCex+6hLPdoA1mM5YqE9MrwiLniYrvEJSGBhNVsdFBCvXW14auANLvD7Od5LaDPORBdqs4FHTaMqO+lDEuUvHdDzn0IkUWMd65q0cbw9jD6TDruPfK6nSj5beirhCIk6zzTHynf4/CaNztzyn3Bw4eanOP/khjxsszXQNM1KTwpgiPizHXx2oBqPG1Q9WJvfpz0jkq0P+Jp0u+oiHYUvigNCGrlz3wL81eGl6FGcERddgx321X++2XyNp2VAKjLmVbcoLAFeI2EX+kV+/G6ZcZ82x5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(2906002)(71200400001)(8936002)(9686003)(5660300002)(55016002)(4326008)(316002)(110136005)(7416002)(54906003)(26005)(478600001)(38100700001)(8676002)(186003)(86362001)(7696005)(33656002)(83380400001)(6506007)(66946007)(66446008)(64756008)(66556008)(76116006)(66476007)(52536014)(53546011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WHZqdlBLTVp4VTJCMEprdGlsNzR1SGw5b3B2RUxBbEs5d0h3ZC9CRTlqMjVw?=
 =?utf-8?B?L1ZMTkRFQnhpaCtkbGVKMjNTY3R2ZzBzK0d5aVR3NC9GZ2daR05UVjdTem5w?=
 =?utf-8?B?bWdlWUdrSEFGRHh0dkJNVVJTRHRvNzA3dzltMy9QdEdWcEh2NjdaSXhtbzNm?=
 =?utf-8?B?WmJ1NjcvZmQ1dkptTkNMbUsza2NHSFdyR0NmUkF3TjIrVEtqQSs4eFduNnRX?=
 =?utf-8?B?Zy9IKy94VUpWd3FiRCtGQjNTTFZjemRWWjdYV1hBam5lUXlsWllkMFBBMjdH?=
 =?utf-8?B?TlB0R1lyaHI0TmcxWlJZUDZMUHZWQW9tdVIvK29Yeldmd3RDSFF2UmRWRUpO?=
 =?utf-8?B?cmpYem9rWFZjR0J4d0dKdHdxTU81VlQ5RFIrSjdCMmNFNjRVWDhZK0lqbStD?=
 =?utf-8?B?aG5DZTJHV3gvZEM3OSthaHJoSGJQeXFGbERZakR5cmRYMDJZVTE5ZEMrS3JU?=
 =?utf-8?B?OU9Fc093ayt1SVNFVzlmejArZi9HaUFkb3VMWU56VVgwVXdtdk92UXlQTFVK?=
 =?utf-8?B?TnhlK2N4MEllUG9VK1RZK0pPSzRJY3ZPTVVQMEtFdGhSM3ZPanJEOHU2VFV4?=
 =?utf-8?B?STFwRjV1ajQzMXlPa2dMTGZaRlBhbDVQY2hFWjVFL3lWNzBoK04rRmVQVGZL?=
 =?utf-8?B?OUpYRWhaUDNJVEo4Znk0dDBsK2ZOb0MzSDJxcnFjZ3hvL1kzcFcyb1h1elNF?=
 =?utf-8?B?U3p3cm9zTnA1aEVCdWIvaE91VGRsOHNaQ0FmQjdnY3ZST3EraGZPc1VpTmJh?=
 =?utf-8?B?YzhQUzJ6MHJEUkt5OTN2a1ZLZFczTjg1b0JuekpjMFBpR3lwbXRGRVR2bGlD?=
 =?utf-8?B?UENiVGRNTHdsSlQ3WlVNeVltM04yS0d3Wm0vL0lNbTBHQ21jVDR0YTFRaXZ2?=
 =?utf-8?B?VjdRS0hRalp5YllCZGVXUGFjLzBieXBGVHRmOW1iWlZwUnFKSFdBbVBoZlg3?=
 =?utf-8?B?bjJISnRGT0lhRk5wcHYxMWMza0R5ZDdSbWhwUVYyYmcybTJEZVE5QWo4STdJ?=
 =?utf-8?B?L2JreEVlZmxtQTh5QlNOcWovQjMxZkJyR2E4YXBpUHUxWHUwUWJYQStXWDht?=
 =?utf-8?B?T3Jxd2JoZmc1cU9qcGlCeWVVWUl0YzZhbEp3UzFIZFVwVndjczhTbTJ3VDlU?=
 =?utf-8?B?RmNBMjl4cDZULzA4VEJiNnRjRlpXNlhOMzZWOEw5R0NaQ2dDSkdQWEVGaFhj?=
 =?utf-8?B?RHZiZ3krRTJYQnoyME5idDJwdXZKbEJOMGY3bWQwTmx6SUVxWm5SZVdtMTBw?=
 =?utf-8?B?SHNmbDlvNGdQeVl3TkxFc21SbmJaMThLSFRoSDhMK3crWmdDY21sMGpBTVFi?=
 =?utf-8?B?S2VjcFR2YnY0QUZkMDRtVFF5MTRiNDV5VXA2VVoySlhsbldFYlBzc3MrSHNP?=
 =?utf-8?B?c3NtcU5jZ2IrTCsyYVFBbk1EUUR1cStoVVBQY2ZLYkFxT1ErZDhnbkNzYTJh?=
 =?utf-8?B?Q1dPajlhaW4yVGdCc21mMjdtVGVYSnBOWmdPaFpHTDNCVlZxN0luOVE1Q3k5?=
 =?utf-8?B?YzYzUjVWd1FNSkJMeiszS3dZYVRFR29ERjNyVXV2aVRiZDV6ZGhSM1N5Umd6?=
 =?utf-8?B?MFkwY3lVaUlRWUd2L0VOMXhvNWcxOFpaL0VUOVhKVGVKMlJKTUI1cUpac2t4?=
 =?utf-8?B?a2ZCdWxkaEc5Q2pSZ0UvbjhjS1hXWWwwMDVBaS9SeklGSGx0ZVpsNzMrQ2dF?=
 =?utf-8?B?YVYzU0VwRlVYYVFrckd5YTFwbHEvcmpON0pqSVJIajcvWlV3QlZSMWlyNHlu?=
 =?utf-8?Q?tLntMevzc6oRoPGWGgYycbCFW1Nt9CQ0BJItmia?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe7cc24-25f7-4b0d-9655-08d8ef3ac613
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 03:04:58.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxkYAGJ/2QKu3PgEBb98LBEFev+IN7pm4dd/kwxEU9ocLalnTbz+F9wQDO9034tJls6AZgyeaaFH+fE/7pkB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2798
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1Y2FzIFN0YWNoIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI0LCAyMDIxIDU6
MjcgUE0NCj4gVG86IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGFuZHJldy5z
bWlybm92QGdtYWlsLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsga3dAbGludXguY29tOyBi
aGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBzdGVmYW5AYWduZXIuY2g7IGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb20NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5k
ZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6
IGFkZCBvbmUgcmVndWxhdG9yDQo+IHVzZWQgdG8gcG93ZXIgdXAgcGNpZSBwaHkNCj4gSGkgUmlj
aGFyZCwNCj4gDQo+IEFtIE1pdHR3b2NoLCBkZW0gMjQuMDMuMjAyMSB1bSAxMzozNCArMDgwMCBz
Y2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IEJvdGggMS44diBhbmQgMy4zdiBwb3dlciBzdXBwbGll
cyBjYW4gYmUgdXNlZCBieSBpLk1YOE1RIFBDSWUgUEhZLg0KPiA+IEluIGRlZmF1bHQsIHRoZSBQ
Q0lFX1ZQSCB2b2x0YWdlIGlzIHN1Z2dlc3RlZCB0byBiZSAxLjh2IHJlZmVyIHRvIGRhdGENCj4g
PiBzaGVldC4gV2hlbiBQQ0lFX1ZQSCBpcyBzdXBwbGllZCBieSAzLjN2IGluIHRoZSBIVyBzY2hl
bWF0aWMgZGVzaWduLA0KPiA+IHRoZSBWUkVHX0JZUEFTUyBiaXRzIG9mIEdQUiByZWdpc3RlcnMg
c2hvdWxkIGJlIGNsZWFyZWQgZnJvbSBkZWZhdWx0DQo+ID4gdmFsdWUgMWInMSB0byAxYicwLiBU
aHVzLCB0aGUgaW50ZXJuYWwgM3YzIHRvIDF2OCB0cmFuc2xhdG9yIHdvdWxkIGJlDQo+ID4gdHVy
bmVkIG9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4dCB8IDYgKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4dA0KPiA+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS50eHQNCj4gPiBpbmRl
eCBkZTRiMmJhZjkxZTguLjMyNDhiNzE5MmNlZCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4dA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUudHh0
DQo+ID4gQEAgLTM4LDYgKzM4LDEyIEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gICAgVGhl
IHJlZ3VsYXRvciB3aWxsIGJlIGVuYWJsZWQgd2hlbiBpbml0aWFsaXppbmcgdGhlIFBDSWUgaG9z
dCBhbmQNCj4gPiAgICBkaXNhYmxlZCBlaXRoZXIgYXMgcGFydCBvZiB0aGUgaW5pdCBwcm9jZXNz
IG9yIHdoZW4gc2h1dHRpbmcgZG93biB0aGUNCj4gPiAgICBob3N0Lg0KPiA+ICstIHZwaC1zdXBw
bHk6IFNob3VsZCBzcGVjaWZ5IHRoZSByZWd1bGF0b3IgaW4gY2hhcmdlIG9mIFBDSWUgUEhZIHBv
d2VyLg0KPiA+ICsgIE9uIGkuTVg4TVEsIGJvdGggMS44diBhbmQgMy4zdiBwb3dlciBzdXBwbGll
cyBjYW4gYmUgdXNlZCBieQ0KPiA+ICtpLk1YOE1RIFBDSWUNCj4gPiArICBQSFkuIEluIGRlZmF1
bHQsIHRoZSBQQ0lFX1ZQSCB2b2x0YWdlIGlzIHN1Z2dlc3RlZCB0byBiZSAxLjh2IHJlZmVyDQo+
ID4gK3RvIGRhdGENCj4gPiArICBzaGVldC4gV2hlbiBQQ0lFX1ZQSCBpcyBzdXBwbGllZCBieSAz
LjN2IGluIHRoZSBIVyBzY2hlbWF0aWMNCj4gPiArZGVzaWduLCB0aGUNCj4gPiArICBWUkVHX0JZ
UEFTUyBiaXRzIG9mIEdQUiByZWdpc3RlcnMgc2hvdWxkIGJlIGNsZWFyZWQgZnJvbSBkZWZhdWx0
DQo+ID4gK3ZhbHVlIDFiJzENCj4gPiArICB0byAxYicwLg0KPiANCj4gVGhpcyBkZXNjcmlwdGlv
biBvZiB0aGUgaW50ZXJuYWwgZHJpdmVyIGJlaGF2aW9yIGRvZXMgbm90IGJlbG9uZyBpbnRvIGEg
RFQNCj4gYmluZGluZyBkZXNjcmlwdGlvbi4NCj4gSW5zdGVhZCB0aGUgYmluZGluZyBzaG91bGQg
ZGVzY3JpYmUgdGhlIGZ1bmN0aW9uIG9mIHRoZSByZWd1bGF0b3IgZXhhY3RseS4gRnJvbQ0KPiB0
aGUgZGF0YXNoZWV0IEkgY2FuIHNlZSB0aGF0IHRoZXJlIGFyZSBhY3R1YWxseSAzIHN1cHBsaWVz
IChWUEgsIFZQLCBWUFRYKQ0KPiBnb2luZyBpbnRvIHRoZSBQQ0llIFBIWSwgc28gInJlZ3VsYXRv
ciBpbiBjaGFyZ2Ugb2YgUENJZSBQSFkgcG93ZXIiIGRvZXNuJ3QNCj4gc2VlbSBsaWtlIGEgdmVy
eSBhY2N1cmF0ZSBkZXNjcmlwdGlvbi4NCltSaWNoYXJkIFpodV0gSGkgTHVjYXM6ICBUaGFua3Mg
Zm9yIHlvdXIgY29tbWVudHMuDQpWUC9WUFRYIGFyZSBjb21iaW5lZCB0b2dldGhlciBhbmQgY29u
bmVjdGVkIHRvIFZERF9QSFlfMFY5Lg0KT25seSBWUEggY2FuIGJlIHN1cHBsaWVkIGJ5IGRpZmZl
cmVudCB2b2x0YWdlIHBvd2VyIHN1cHBsaWVzLg0KU28sIG9ubHkgVlBIIGlzIHNwZWNpZmllZCBp
biB0aGUgRFQgYmluZGluZywgbWlnaHQgYmUgdXNlZCB0byBkaXN0aW5ndWlzaCBkaWZmZXJlbnQN
CiBIVyBib2FyZCBkZXNpZ25zLg0KDQpIb3cgYWJvdXQgdGhpcyBkZXNjcmlwdGlvbjoNCi0gdnBo
LXN1cHBseTogU2hvdWxkIHNwZWNpZnkgdGhlIHJlZ3VsYXRvciBpbiBjaGFyZ2Ugb2YgVlBIIG9u
ZSBvZiB0aGUgdGhyZWUNCiAgUENJZSBQSFkgcG93ZXJzLiBUaGlzIHJlZ3VsYXRvciBjYW4gYmUg
c3VwcGxpZWQgYnkgYm90aCAxLjh2IGFuZCAzLjN2IHZvbHRhZ2UNCiAgc3VwcGxpZXMuIE1pZ2h0
IGJlIHVzZWQgdG8gZGlzdGluZ3Vpc2ggZGlmZmVyZW50IEhXIGJvYXJkIGRlc2lnbnMuDQo+IA0K
PiBSZWdhcmRzLA0KPiBMdWNhcw0KDQo=
