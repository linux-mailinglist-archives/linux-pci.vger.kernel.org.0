Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132B55734CA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiGMK6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 06:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbiGMK5z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 06:57:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F50FF5A0;
        Wed, 13 Jul 2022 03:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LW5fMsBpDIaOgQExAORPjrIXBb3LEJ1E4A73CBgc/HeXuAdj32eM6ou1vG3GXffTnueRwCsxzvlW2eQwJL2UvoyeOrlbvNFoJAdfn5Fep9Jepa3iHWmXHK2qOOE8mFD5nALNUYLdw97mEi9Ntv+mzl5GV4651fRET4LUG0QiDujuQw1YjaTOWxj+DZJDK3YIvZiZUY4Z+JbNIwPMhREye2maSLQ2v5c65XFL8G4q0doRATaksFDvX8P8Za5EZDyNAHht5OflIJhKuwOed+R/0VpcUnEMUUt9aezXnoy5CMUR0gtqtYUHizHU3UsrfV+31IVGXFXLvw5GnzeqU5cp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WjTMjO/V13piHcCYnuwlbChENbLstKxHDmek+9AGDg=;
 b=A76/I1iSjIjy0NA8E4kGgh3Z6coJJm7fzjzZipooWUBx6ymUVohZnhXKHtqOnuus0Q3jzFALWrDWw0Nu5dusqhsm44UFzBDiW3232EfkugHK2Tnr5zQsHh7ZEaTIlsSM9x4oUeOKyxY0xglJ0Smrzk18cDhwzorAk9Ua1/fOa7IorqRVR6g32wJfAM6koiSDfV/peWkmtjEVrscXkzJvXhhBEPz672yXbwxcQedjxH2ez4yt3VsQiQd46iKNrOjPcAV4IsW+h2cG2NObeMIYNKF0BKFGtNYyMwV7yK8wOy2NpCxpG6YWpGgRyXg81AD92VR2WugpDpPo3FDlwcG6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WjTMjO/V13piHcCYnuwlbChENbLstKxHDmek+9AGDg=;
 b=asHOigk/5bKvFBUR2/oHIJRrjNZpx/oNnSEdOOC3hAEPuo19vwXStEtpsUj14reIfidXbktVh+CoBWafPApprJnm3OkUuqh9Shh2bp1L9Pc7Q5dp+aFrZd3ao1186aNg9QjSQeA6STacag/+vEWv8A0ZLiWHX3NhO6WFU4yk18E=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8522.eurprd04.prod.outlook.com (2603:10a6:20b:431::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 10:57:51 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%7]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 10:57:51 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 14/17] PCI: imx6: Do not hide phy driver callbacks and
 refine the error handling
Thread-Topic: [PATCH v14 14/17] PCI: imx6: Do not hide phy driver callbacks
 and refine the error handling
Thread-Index: AQHYjPxRR2VrUUjfUkSsDg0hZCCmz618E4uAgAAZiQA=
Date:   Wed, 13 Jul 2022 10:57:51 +0000
Message-ID: <AS8PR04MB8676435692989AE1C4082C998C899@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-15-git-send-email-hongxing.zhu@nxp.com>
 <4f49f28d15ad859e34aeeb714b5ddd5d6eba4b4a.camel@pengutronix.de>
In-Reply-To: <4f49f28d15ad859e34aeeb714b5ddd5d6eba4b4a.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d46badcc-4e4b-42a5-a317-08da64be87c7
x-ms-traffictypediagnostic: AM9PR04MB8522:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZaiOMQeX+xPURfbaqiEeSmwt3mlSOC8VDY8J9DTshoImgNI0bj9U91Qp6OR1jrtz7QV1847mSUxLwQzwJqcvJ0L/T5BjJwF9JJmjDHddGQju7R9F3nYRHdqGk6Cp7tz8lDSFKVjZy394sjmkKNy0dsoMdN5jMA6FYZb6xcTrvPokjrIXtWvPYC8Q7lb4KnNQYtIfZ5tdvLstW6yc705kWQ+WFcRPPwe7S01Q5yAznc/Wxc1itSoWMx2jtUIS3siQjaLuFKbGGz+/xnbH5qnD85iijbWpK58sfXrz4L2wVg8BZ2qGJ4sA/NbT7iCr9m2clIDRndSr2JYQnfwHbIrQomOCLfgollLeosAnyCHPUs47Z0LpfAfTVauJB6Z1Zfe5i51wQj8/iKzQUNw4ioJaa7JGc6MVRjedqZYfObg4/9AOqFsSWiku4Y3dw27STnaNWmabtZpPKJa9WinFdgh8A1Y+6hMDrsGFh8qmPYUAuvv3XEN/uswW1hINUFLN54DlCp7He+tVyV8QYg+GiADPFI08M8yoQYuqxnhr58b5qgBK2ImSLr+pv0vpsBaJP3/jPNWb5LyDJ6dbNqmPdSKKRi0tH1B65gZXkD27737J5KBk2qaTGqPJ/jWEZ9nr7VtdO9eFDgmxxw/zTpOGTfDnMNyFousQSqq6VDzNoYSoGyAQykhpJF0U/GIlaX84jEcJWilDOj9XRI/2wZ5CsobYIpm+XtPN9PmQDbLWEGjP+8e1P/zSmi9ul/3tB9F4KZozxTEY/iqlXG9635Hg7T8msGetsGKKxc4vDjzyYt44qJ7KUTHHKO9K/CvTKZzbjcb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(2906002)(110136005)(41300700001)(54906003)(71200400001)(7696005)(53546011)(26005)(8936002)(52536014)(5660300002)(8676002)(316002)(64756008)(86362001)(33656002)(9686003)(4326008)(6506007)(7416002)(44832011)(66556008)(76116006)(186003)(83380400001)(66476007)(55016003)(66946007)(38100700002)(122000001)(38070700005)(66446008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnF3VzJJT0JMbGJIKzJlTm5rZkxKdzU2U3d6T25QR1pRTjJ0NXBjSDlKWXgv?=
 =?utf-8?B?Tkt0NzFFL2ZuSERDVFdaVHJ5T0VpSFB6K3hNWHlNc1J0QjdHYklhck5SQU42?=
 =?utf-8?B?MHdKSUo2UnkxR3VwN0pXZTUyTnJaQ1FJWjErQ0NRZ0JtaG9FeFBIRFJ2NE8y?=
 =?utf-8?B?b00rZTFtRHlSMFpEN0RlVlNzMWhsYkFWSTVtdzJCNjVJQmM4YVVRajVORnhn?=
 =?utf-8?B?cmw4cWR4VUI5bkt3RGFPSjBHVEl1U0RicnltekFLUHR4bU5SNnlyUlpSeEpJ?=
 =?utf-8?B?QXJSKytQQzI0RVFPNzNSL2phZ1JwUnZhUXpwSlJaQUMwTlEvTktiTmxkVnBh?=
 =?utf-8?B?V1pTWHJyY2VaUGlWcHI4MG9MWWVReXlmdEQxaFVteFl5K1NTSFI0OXJJdFVR?=
 =?utf-8?B?clV4ZjMwQWhhK2puaWl4ejRacHg0UVdGZWpxNktlME5LVitST2VEVTFCZ1FV?=
 =?utf-8?B?d2krOXpTd0JUMXRTMnFTV0xEWTVyMVVjSWdBcC9nOEZ1UytuWlJ0VHRKVDZ6?=
 =?utf-8?B?VjNNaVdrN3JGTEt1TUdlTkhUWVNYRDVtejhoT29RVXhieUNodFdHdmFQd2hj?=
 =?utf-8?B?bmxzOUdlazBDZFNHYy9OWjRwQ1puTnQ2S25sT21oMzVJTjd1ckxJOVFmclVr?=
 =?utf-8?B?eTVwTExWQXNGWU9PS2lEaWlZRTI0L2ZEbnd5U2dFTVlFVkJCOFFmS1hPaXg2?=
 =?utf-8?B?UzRrYkFsNzg5a0ZDZDFROFZldkwyWGNkUXJHN0MyUDA2eDVMTTluZGhZbDAw?=
 =?utf-8?B?dkNuZzY3MTVXRXJuamlwSk9ic2VuM2NwWTVCWWJkZENVaUxZWTk2SWt3VHB0?=
 =?utf-8?B?L29TdDVBWGx1eG9IT2l5OUY4QWtpOFd5N3ZKdFBzK0lEUDVlcGdkZWZMUUxz?=
 =?utf-8?B?bFhwQ1JPb3ZUZllhK1dzREhNWGRYTkpnT0EwRGNHUzdUQkNHWUZMZU94bTAx?=
 =?utf-8?B?Q2p0eVIyd1RITzBQaUZZNVpkUDlXWTU5a1Rhc3lTbGxNbXF2V1NqRktWOGdG?=
 =?utf-8?B?TjRVZWVLTXdNOVV3bm4zTVFwRXJaY0NGWkxpMlRHOVlBK3VwSnk2RmcxYVYx?=
 =?utf-8?B?ck0vR1VVa2M0OUt4SlZrRlhtdm1XVEtvS3lUSjNWR1ZHWmlPRkx1bVlGWmJT?=
 =?utf-8?B?ZXZoMVZBSTVkb3BXL1hUYVhhaGxqazlLNXlKb0VQWXNac0ZFT0UzcEtkUnBI?=
 =?utf-8?B?Um9jaE1nQlN6aDNHSEpOWGVTYjU5aWhlbXU5WjJVTFdFNjhxRlpXVHFBZDdT?=
 =?utf-8?B?Qm5CbWZwZ1ZjcVNTSWRHdXA5M2RTMm9QM1VjRGtrcnZKNGV4a0JzT09vM1U2?=
 =?utf-8?B?bHErU1FIRXRHWDY0K2h6WG50ZGRFaVNROG9lZjdUbFVKZlM5ZVRNVmx6Y0JW?=
 =?utf-8?B?THpKaVFQVW1DeUFabGtpNXk2d3phRVNRSGYvVUlaWDUya2lzOW9FeXBSdmEy?=
 =?utf-8?B?SjFjMXBJWVFDQTBwZFloZWFBN2FRU2c2aCtmSnBSaHcyOTg0UkJWQW1yS3Vt?=
 =?utf-8?B?NkVLRmF2NGRBcWZabTlqZFRFcW1JR0J3YjZ0Wk1Eby9Wb1dtRUVzNERMN2NH?=
 =?utf-8?B?a3BNZm5WSHNvem1lWTdzT0ZaUFZUbDlWb0pKMGl2QUdHbk14SEpzMEo3SWtC?=
 =?utf-8?B?dFBoaTNxanoyWUhYeGY2RFp0VG9jOFBXazAzTWQwTWRoN3paVFlwVldsYU5o?=
 =?utf-8?B?RnZaNkl5RXA0WGtGZEsyYk5OWXAzdUJ4M2lFR0o2V0dnSE9OMjdmTURWbUhW?=
 =?utf-8?B?NCtHWTAwR29EVm85ZFZ4dWlFcWphSUE4UkFFL3V1RzR6MzIxaDlaUkQ1QUVv?=
 =?utf-8?B?OUhORnNRWWllNGJKVENEd2R1QThHUGJwVmVEMGFQa0tkbmk2cTY4aU5rK1M1?=
 =?utf-8?B?UG43QnExaUJGUmx4ZjZSODZsWWxZVmU2R2k1Nm5BUHV6SDJNenRJNDNLV0FW?=
 =?utf-8?B?aTJMY3NOOCtMdVFZR2FHRjBvRHhSWEJpYTQ2Y2ExVVlDVHFvQzEwUVd5MW1l?=
 =?utf-8?B?TWFQb3Zzd3c1NVFqN2NDdUxFTHZiSEVxaWJZcFUyMGRBVUdYK0RZTTVLakE0?=
 =?utf-8?B?YWdXaFlmT1oya2RBSEg1QmhKdVRiaE9ZVVZnYnArMXVzZHR4WHJGT2hYSU5M?=
 =?utf-8?Q?IIskd/LH9YUHDok2ny2ZYhP7y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46badcc-4e4b-42a5-a317-08da64be87c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 10:57:51.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zAt1g75LuhYteuY+DywehOKKTAaXG/+4dK+vCB3wLsEA4kCaWXxGnh9Wj0kA+qLXyxIDbOgZdWbIG4PbWO3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8522
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDfmnIgxM+aXpSAxNjo1OQ0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207
DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgYnJvb25pZUBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRv
cmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTQgMTQvMTddIFBDSTogaW14NjogRG8gbm90IGhp
ZGUgcGh5IGRyaXZlciBjYWxsYmFja3MgYW5kDQo+IHJlZmluZSB0aGUgZXJyb3IgaGFuZGxpbmcN
Cj4gDQo+IEFtIEZyZWl0YWcsIGRlbSAwMS4wNy4yMDIyIHVtIDExOjI1ICswODAwIHNjaHJpZWIg
UmljaGFyZCBaaHU6DQo+ID4gLSBNb3ZlIHRoZSBwaHlfcG93ZXJfb24oKSB0byBob3N0X2luaXQg
ZnJvbSBpbXg2X3BjaWVfY2xrX2VuYWJsZSgpLg0KPiA+IC0gTW92ZSB0aGUgcGh5X2luaXQoKSB0
byBob3N0X2luaXQgZnJvbSBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpLg0KPiA+DQo+
ID4gUmVmaW5lIHRoZSBlcnJvciBoYW5kbGluZyBpbiBpbXg2X3BjaWVfaG9zdF9pbml0KCkgYWNj
b3JkaW5nbHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNA
Z29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYyB8IDM0ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCA1YTA2ZmJjYTgyZDYuLjBi
MmE1MjU2ZmIwZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiA+IEBAIC02MzksMTQgKzYzOSw2IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2Nsa19lbmFi
bGUoc3RydWN0IGlteDZfcGNpZQ0KPiAqaW14Nl9wY2llKQ0KPiA+ICAJCWdvdG8gZXJyX3JlZl9j
bGs7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCXN3aXRjaCAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJp
YW50KSB7DQo+ID4gLQljYXNlIElNWDhNTToNCj4gPiAtCQlpZiAocGh5X3Bvd2VyX29uKGlteDZf
cGNpZS0+cGh5KSkNCj4gPiAtCQkJZGV2X2VycihkZXYsICJ1bmFibGUgdG8gcG93ZXIgb24gUEhZ
XG4iKTsNCj4gPiAtCQlicmVhazsNCj4gPiAtCWRlZmF1bHQ6DQo+ID4gLQkJYnJlYWs7DQo+ID4g
LQl9DQo+ID4gIAkvKiBhbGxvdyB0aGUgY2xvY2tzIHRvIHN0YWJpbGl6ZSAqLw0KPiA+ICAJdXNs
ZWVwX3JhbmdlKDIwMCwgNTAwKTsNCj4gPiAgCXJldHVybiAwOw0KPiA+IEBAIC03MjMsMTAgKzcx
NSw2IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+
IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJY2FzZSBJTVg4TVE6DQo+ID4gIAkJcmVzZXRf
Y29udHJvbF9kZWFzc2VydChpbXg2X3BjaWUtPnBjaWVwaHlfcmVzZXQpOw0KPiA+ICAJCWJyZWFr
Ow0KPiA+IC0JY2FzZSBJTVg4TU06DQo+ID4gLQkJaWYgKHBoeV9pbml0KGlteDZfcGNpZS0+cGh5
KSkNCj4gPiAtCQkJZGV2X2VycihkZXYsICJ3YWl0aW5nIGZvciBwaHkgcmVhZHkgdGltZW91dCFc
biIpOw0KPiA+IC0JCWJyZWFrOw0KPiA+ICAJY2FzZSBJTVg3RDoNCj4gPiAgCQlyZXNldF9jb250
cm9sX2RlYXNzZXJ0KGlteDZfcGNpZS0+cGNpZXBoeV9yZXNldCk7DQo+ID4NCj4gPiBAQCAtNzYy
LDYgKzc1MCw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3Ry
dWN0DQo+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJCXVzbGVlcF9yYW5nZSgyMDAsIDUw
MCk7DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAljYXNlIElNWDZROgkJLyogTm90aGluZyB0byBkbyAq
Lw0KPiA+ICsJY2FzZSBJTVg4TU06DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAl9DQo+ID4NCj4gPiBA
QCAtOTEzLDE3ICs5MDIsMzYgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfaG9zdF9pbml0KHN0cnVj
dCBwY2llX3BvcnQNCj4gKnBwKQ0KPiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ICAJCX0NCj4gPiAg
CX0NCj4gPiArCWlmIChpbXg2X3BjaWUtPnBoeSkgew0KPiA+ICsJCXJldCA9IHBoeV9wb3dlcl9v
bihpbXg2X3BjaWUtPnBoeSk7DQo+ID4gKwkJaWYgKHJldCkgew0KPiA+ICsJCQlkZXZfZXJyKGRl
diwgInBjaWUgcGh5IHBvd2VyIHVwIGZhaWxlZC5cbiIpOw0KPiA+ICsJCQlnb3RvIGVycl9yZWdf
ZGlzYWJsZTsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4NCj4gPiAgCXJldCA9IGlteDZfcGNpZV9k
ZWFzc2VydF9jb3JlX3Jlc2V0KGlteDZfcGNpZSk7DQo+ID4gIAlpZiAocmV0IDwgMCkgew0KPiA+
ICAJCWRldl9lcnIoZGV2LCAicGNpZSBkZWFzc2VydCBjb3JlIHJlc2V0IGZhaWxlZDogJWRcbiIs
IHJldCk7DQo+ID4gLQkJZ290byBlcnJfcmVnX2Rpc2FibGU7DQo+ID4gKwkJZ290byBlcnJfcGh5
X29mZjsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJaWYgKGlteDZfcGNpZS0+cGh5KSB7DQo+ID4gKwkJ
cmV0ID0gcGh5X2luaXQoaW14Nl9wY2llLT5waHkpOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiAr
CQkJZGV2X2VycihkZXYsICJ3YWl0aW5nIGZvciBwaHkgcmVhZHkgdGltZW91dCFcbiIpOw0KPiA+
ICsJCQlnb3RvIGVycl9jbGtfZGlzYWJsZTsNCj4gPiArCQl9DQo+ID4gKwl9DQo+IA0KPiBXb3Vs
ZG4ndCBpdCBiZSBtb3JlIGxvZ2ljYWwgdG8gcHV0IHRoaXMgaW50byBpbXg2X3BjaWVfaW5pdF9w
aHkoKT8NCj4gDQpCZWZvcmUgYWRkaW5nIGkuTVg4TU0gUENJZSBzdXBwb3J0LCB0aGUgaW14Nl9w
Y2llX2luaXRfcGh5KCkgb25seSB0b3VjaGVzIHRoZQ0KIEdQUiByZWdpc3RlcnMuIFBDSWUgY2xv
Y2tzIGFuZCBzbyBvbiBhcmUgbm90IHJlcXVpcmVkIGluIHRoaXMgY2FzZS4NCkJ1dCBwaHlfaW5p
dCgpIHVzZWQgYnkgaS5NWDhNTSBQQ0llIHRvdWNoZXMgbm90IG9ubHkgdGhlIEdQUiByZWdpc3Rl
cnMgYnV0DQogYWxzbyB0aGUgUEhZJ3MgcmVnaXN0ZXJzLg0KVGhlIGNsb2NrcyBzaG91bGQgYmUg
b24gYW5kIHJlc2V0cyBvZiBQSFkgc2hvdWxkIGJlIGNvbmZpZ3VyZWQgcHJvcGVybHkgd2hlbg0K
IHBoeV9pbml0KCkgaXMgaW52b2tlZC4NClNvLCBwaHlfaW5pdCgpIGlzIHBsYWNlZCBiZWhpbmQg
b2YgaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoKSBoZXJlLg0KDQpCZXN0IFJlZ2FyZHMN
ClJpY2hhcmQgWmh1DQoNCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4gIAlpbXg2X3NldHVw
X3BoeV9tcGxsKGlteDZfcGNpZSk7DQo+ID4NCj4gPiAgCXJldHVybiAwOw0KPiA+DQo+ID4gK2Vy
cl9jbGtfZGlzYWJsZToNCj4gPiArCWlteDZfcGNpZV9jbGtfZGlzYWJsZShpbXg2X3BjaWUpOw0K
PiA+ICtlcnJfcGh5X29mZjoNCj4gPiArCWlmIChpbXg2X3BjaWUtPnBoeSkNCj4gPiArCQlwaHlf
cG93ZXJfb2ZmKGlteDZfcGNpZS0+cGh5KTsNCj4gPiAgZXJyX3JlZ19kaXNhYmxlOg0KPiA+ICAJ
aWYgKGlteDZfcGNpZS0+dnBjaWUpDQo+ID4gIAkJcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2ll
LT52cGNpZSk7DQo+IA0KDQo=
