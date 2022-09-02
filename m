Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D15AA541
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 03:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiIBBsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 21:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiIBBsI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 21:48:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455EEA8CD7;
        Thu,  1 Sep 2022 18:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYah4zj/COIILdeBgAObZRrrb3T3uXDjKHDhRuUQh2nEH1mhTPFDsuKJJr6MJN4VCsm/SqkAZHdeBU+LZmsDahq2xVByZgvqrTS5NSlpSd0kPPaEBW64OeRyCFCo0LDrKITODZSR/LYeHU4JtHvENWRi17gFn2+7WpXOKlQDsjcVepxz5BBtX2gKvoDFg87rEYF+C5Q5ctivJvIEiREiPIF4qd8pS88eQipakxz7Q1czY9VhzObKzy7Ppgz3BZCIqF7x34FcHTrYJgmiiNoRZwxgjlzbXnd8hpDIbfBqmP0prtzZHouZLj5woMxlHsTfwuUa4KIIasWatwOpUVnFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO6VOt9eI8qzKR2Vx6wHcrax87Q5UWXdt7QHG/8Yb3E=;
 b=Eqv6jzB+fRufrmlOoFZqRhxpJXjaklp9BWlrhfvSkXQa2aSbimcakd464m3jDrzXj0pzWzxYdmheeBAuBELUplY3aC66vCscEvBxbWlZMC6uQb7dAgswLMpvwagsU5Q55VBu9GJpdz/Daguld/xoI7ffbbYYd8GSDTmLv5OvYv1ErvQLa2NhackBD0QXrkXVVDgBdm0ttZxaOlaNa6EYI3kV4UQuXYT+0ieHrOzG9ZqgrDq0pMcQnfIeOXTjsBPveTF/wK6DLwp6PTggE4yJxk1IbVB7Obewpr8l9wiXX/vakq1vg913VUS6Yp8JLCotkGUeBZEfZKJMG5AGxGp5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO6VOt9eI8qzKR2Vx6wHcrax87Q5UWXdt7QHG/8Yb3E=;
 b=kfJKEwDPqeu3MB8eI8tZUnpvNHCgyZVfa5CEdQja9JgfnNWjhHcoV7qSuJNk7TZ1JVgmZ+rECykFSMtphVv4BCRzLt6ypLMyZ6gYUC8vf+HURFkT7paJj/QMHcsWOq+6NJw6uTVhZlZRLCF3oKTdsATDB1ows9bEQGjnpGB8jcA=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM5PR0401MB2513.eurprd04.prod.outlook.com (2603:10a6:203:3a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 2 Sep
 2022 01:48:04 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%8]) with mapi id 15.20.5588.015; Fri, 2 Sep 2022
 01:48:04 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>
Subject: RE: [EXT] Re: [PATCH v6 4/4] pcie: endpoint: pci-epf-vntb: add
 endpoint MSI support
Thread-Topic: [EXT] Re: [PATCH v6 4/4] pcie: endpoint: pci-epf-vntb: add
 endpoint MSI support
Thread-Index: AQHYsxTj8ial5WQflUOYb2uoUuXnWa3I5nOAgABYdCCAAjRtAIAAAQyw
Date:   Fri, 2 Sep 2022 01:48:03 +0000
Message-ID: <AM9PR04MB87930B4EF3ED6BB5FE88A151887A9@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220818151127.2449064-1-Frank.Li@nxp.com>
 <20220818151127.2449064-5-Frank.Li@nxp.com> <20220831104203.GD5076@thinkpad>
 <AM9PR04MB8793BEEC8B2F1713C252B4CA88789@AM9PR04MB8793.eurprd04.prod.outlook.com>
 <20220902013848.GA4935@thinkpad>
In-Reply-To: <20220902013848.GA4935@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84a0bbb5-0f72-43c9-5add-08da8c852d39
x-ms-traffictypediagnostic: AM5PR0401MB2513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wasfb5RV0xiXCtM6rEOyYnarxFBUbBFGj30Khn9xMyR5oR5pnzzMO4S0g8nRtuflz4IJvM20bjNrSx8VuWxIzhICln/wtZf7CsRl7wH1yjG/dAZ3VjZ3lbaeSePzlAyb53FajjVSgcrN0PigqbX7af4sZZfaPzEbdUHNOeLwdqhEouElslSmwp45HQZpJxO1w1NJV8APnFZ38wATyxRzoEm9j8vPuEJJryMCdkHSXidOocyE9kUHu0GO5XWqq5QqCvZBg4XUB0y+j51lvBthADmCTBsDVSMZb4zZsbZ0dyHb3jqxRGfHw2yG7bNhee/ZLJIZOb0qTjPbUsFPd89SvQ2Y3FdQ/hUKkGC+sK7YgsOgAUqTzIo4U3ouXJjSLMjcdcPQP4wsMc0NiiagLR8S6GReMFamSWvAfZfQ00QVXFHlsy2uDKyt4mwoXIQkKSD7TWbmlOOL4udYBhFZz4L9jXLzU26ApyyNNpOB1lL0dr7kXXTNUwi5wWky+vI/hqJPA0uiVgylfWJevTh+JDENiA23YPB0rCIhKGAK22Lxq+feVjiVNYc1V148wNmbBgmdMHW3F8t4ACdAHhREk13A5RHxt6s5MlXVrOGCi+k1bpT0kSsfKz/LN8R9gyt4h1JGpiChY1V5WaHfBxanHYz1hyvfm7Ic4yTBW2L1iHpB4xfq7FtDr32jhTESszTBFYcyQTkfqp+6SF3xXIgYMqJ0PYwydY8n4aneBdzX81Yohwd3Cbd4uO8tenYCrc0CaQW+smho4FVsx4Sz7LrHF4845Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(38070700005)(83380400001)(186003)(122000001)(66476007)(6916009)(54906003)(4326008)(478600001)(8676002)(76116006)(66556008)(66446008)(64756008)(66946007)(71200400001)(316002)(26005)(44832011)(9686003)(7416002)(41300700001)(8936002)(33656002)(52536014)(5660300002)(38100700002)(7696005)(6506007)(53546011)(55236004)(86362001)(2906002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkRYTG9hN1NVSGRpeW1oK0tzb2Z0M1k0ZGtEYnRHaGpyNFRaUlZQZHdlSWc2?=
 =?utf-8?B?NDFXV3BzRFlpMDMvMWVTWEpPT0psRTBVYWdRd1lCTGVQYXF4VXY5WFVJR2lM?=
 =?utf-8?B?T1ZTaEl0dlZUS1ZBV0hYYnFtVmtUT3VFMGR5Z1ZnMlNOakw5NDIrU0hTTTNL?=
 =?utf-8?B?RzdEcWFQWThhRDVmSlIwK3o2dUIrVTROczhhTlN0MGVVb21Rdk9HaDdNRDNM?=
 =?utf-8?B?VUNuVnFoU3c4S3Bkbi90R2twTGxLZS9ZdnNYZ0ZIOWh2K25YSk5LVERBTFVU?=
 =?utf-8?B?Uld4VUhvcFBYVTVhL2JodFZxYW9oK0MwRll5U24xMGY1TlQ2VTBwbGViYkw4?=
 =?utf-8?B?WkVPWWRGenJCQVU3QXdyTmQ2R0RybmNiWE8yVUpHNGlrR3JLd0I0cG8rNFZN?=
 =?utf-8?B?bXdnREJmQ0NwaGVJQ3RVV3NQNjM2VkhLaEdJRU5QYzVNTVNtNER3WC9oYU1C?=
 =?utf-8?B?Q3NtWEhBei96L3lUaDdiZ0ZnM2Y3YitMM3FqTDEwTXJGRllQSmtqNk12cHA1?=
 =?utf-8?B?cnBHL3I4TVQreWJqVHlMTVFvbGw2MmM2THhwTzN4Y3VzV21jR1R6TE5KYTU1?=
 =?utf-8?B?WnBNNHRIMjJMMy9rTGl5OE81NmNQdDVDK1NSMyt0ZnRBQUtSWUhUaVNZUVFX?=
 =?utf-8?B?RHlNWnUyQmpiSGgyZGx1N0VRbExsZmIydnFnZTRydThmdjQvN05PWnBvT0xh?=
 =?utf-8?B?bk52RUZEZjdZZS9iOVU3YmpZeHZxZnFWUXphTG9HQWd2eU1BS2pCemN2SStw?=
 =?utf-8?B?Q3FvdmV5SHB2RjJkL1M1T0dCOFVaSzFQTkdOK0pLUzhOblcyUnR6L0VQWm1j?=
 =?utf-8?B?eVUrK08yWmQ2bHUrMXVyM2ZnZVRXdFRJVEh5am1DRiszUGJ6UVl2ZloyZ2lE?=
 =?utf-8?B?NVVTVUJwaXMrSS9iWVJjWEg5TjV3MVVCb3YzelhuUW9ZRlVVbGlpeG9CR01a?=
 =?utf-8?B?QWFSNWZIUVd3MHBJN2dnTHZUS2NhaGw3V290SHpnampoQVRaT1VwMEkwVU9H?=
 =?utf-8?B?a1FxdDAvWlZGRlRHK0RhU2Y4TTl6Q2YxZlg0N05TTDUyZ3NvY0lNYWRsOWVv?=
 =?utf-8?B?QlJMRjI2Sm94ZWNBbUhWTlpmY0hZYlp4WVRtN0RKaXJiczZLRnJWZXN3SUI4?=
 =?utf-8?B?YUsvMjZiL1BVNVpic1RPcGZUcUhyWG9OUFFBcFZZYUI5ZXdTUmNUdU03RTJU?=
 =?utf-8?B?VXU5dlV3RFFROE0yZ3B3WHBEMURnd05FY01TTEdmVGw1YmthbElCK2VWdVhi?=
 =?utf-8?B?TmJmeXZ3a2svQjVzaUFKYlR4V0dtU1pCQ3VjZ1c2SmlpaW1pVmlOa0JINndk?=
 =?utf-8?B?aWR0bG9zUkpkTU9yeHl6MFA4aVV3Q0RWSVdaT3hKOTNObEh3SkZRWUNoK201?=
 =?utf-8?B?MExndmVqTGQyQUQxSEpPTGVCUmIyM2VrVXlMTjdlOUhBNVZ5dWJnU2VXWHl2?=
 =?utf-8?B?bmpWZHdKTjIrSG1iK2MrelpwWUhQU3ZmNE9WdmFSMlBQQjdqR0MvNGFuVENB?=
 =?utf-8?B?YmZadUNFczVWdW8yditNSExQQm4ycXlmaEZVVmVsQ24vN1Q0N2hMeGd4bncr?=
 =?utf-8?B?NDQxeEh6UnhZRDhTNkR2WVRpNlJROHZYUnNLSVlBWWw2RUo4Yk1vbHdPb2p4?=
 =?utf-8?B?R0FZcmdDSjJHNE9rdmVEMmttU3JDMHQ3L2ZpYnFPclFTZUtZQnF2ckIrbUJl?=
 =?utf-8?B?RjQ5enpDWXowaTRMRER4a1BVeXNtTWZWVU8yaEl1Vmp0TlEvUWU2SWlLU25L?=
 =?utf-8?B?dm1iQlZYUEk5TGtYR0dJQTFZZVY1dkdvUy9jYU82ZDltRS9TYUtxc2F3YW9q?=
 =?utf-8?B?dGo3bi91ZEdDYkVueVNkYzN4VUpXQzVES0NXbEw5SEpPYWdJbTFqM24wNjFT?=
 =?utf-8?B?dHFCSFBsRnFFelE0TmhpUlpTWDlOaXNGWW9SR1FwN1JCRnZzeWRrK0hOVGMv?=
 =?utf-8?B?WC9YNEt5WUk2dk1EaFliTkZUaUVZQUowQ2VCQi9nS1VWQWV0VW5xR2xXbDBO?=
 =?utf-8?B?NWc2RjJYYnp4Ri9IWCt2N3ZFTlFxVUlHV2M4dlROdnNMdGJ5Y3ltSDVlTEl6?=
 =?utf-8?B?ZEZzZmMxSTBwR2doV0hKaXdpZXl3UmpndzlZTFg5bmc4QytXR2hGUnhTclEw?=
 =?utf-8?Q?p4xY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a0bbb5-0f72-43c9-5add-08da8c852d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 01:48:04.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUCeb6Xr5s4TvLtcX6gUtH9CwRGrXH/mObaTr16jqudmlZ1WP87ENctbqNR+hOpCyCBbaKe9uZXM563orhJtaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNk
YXksIFNlcHRlbWJlciAxLCAyMDIyIDg6MzkgUE0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPg0KPiBDYzogbWF6QGtlcm5lbC5vcmc7IHRnbHhAbGludXRyb25peC5kZTsgcm9iaCtk
dEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGt3QGxpbnV4LmNvbTsg
YmhlbGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBQZW5nIEZhbg0KPiA8cGVuZy5m
YW5AbnhwLmNvbT47IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+Ow0KPiBqZG1h
c29uQGt1ZHp1LnVzOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsg
ZGwtbGludXgtDQo+IGlteCA8bGludXgtaW14QG54cC5jb20+OyBraXNob25AdGkuY29tOyBsb3Jl
bnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiBudGJAbGlzdHMubGludXguZGV2OyBsem51YWFAZ21h
aWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHY2IDQvNF0gcGNpZTogZW5k
cG9pbnQ6IHBjaS1lcGYtdm50YjogYWRkDQo+IGVuZHBvaW50IE1TSSBzdXBwb3J0DQo+IA0KPiBD
YXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIFdlZCwgQXVnIDMxLCAyMDIyIGF0IDA0OjE5OjE3
UE0gKzAwMDAsIEZyYW5rIExpIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5u
YW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3Qg
MzEsIDIwMjIgNTo0MiBBTQ0KPiA+ID4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0K
PiA+ID4gQ2M6IG1hekBrZXJuZWwub3JnOyB0Z2x4QGxpbnV0cm9uaXguZGU7IHJvYmgrZHRAa2Vy
bmVsLm9yZzsNCj4gPiA+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgc2hhd25n
dW9Aa2VybmVsLm9yZzsNCj4gPiA+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGt3QGxpbnV4LmNv
bTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiA+ID4ga2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IFBlbmcgRmFu
DQo+ID4gPiA8cGVuZy5mYW5AbnhwLmNvbT47IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54
cC5jb20+Ow0KPiA+ID4gamRtYXNvbkBrdWR6dS51czsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBm
ZXN0ZXZhbUBnbWFpbC5jb207IGRsLQ0KPiBsaW51eC0NCj4gPiA+IGlteCA8bGludXgtaW14QG54
cC5jb20+OyBraXNob25AdGkuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiA+ID4g
bnRiQGxpc3RzLmxpbnV4LmRldjsgbHpudWFhQGdtYWlsLmNvbQ0KPiA+ID4gU3ViamVjdDogW0VY
VF0gUmU6IFtQQVRDSCB2NiA0LzRdIHBjaWU6IGVuZHBvaW50OiBwY2ktZXBmLXZudGI6IGFkZA0K
PiBlbmRwb2ludA0KPiA+ID4gTVNJIHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBFWFQg
RW1haWwNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIEF1ZyAxOCwgMjAyMiBhdCAxMDoxMToyN0FNIC0w
NTAwLCBGcmFuayBMaSB3cm90ZToNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg4pSM
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUkA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICDilIIgICAgICAg
4pSCICAgICAgICAgIOKUgiAgICAgICAgICDilIINCj4gPiA+ID4gICAgICAg4pSM4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAg4pSCICAgICAgIOKUgiAgICAgICAg
ICDilIIgUENJIEhvc3Qg4pSCDQo+ID4gPiA+ICAgICAgIOKUgiBNU0kgICAgICAgICDilILil4Ti
lJAg4pSCICAgICAgIOKUgiAgICAgICAgICDilIIgICAgICAgICAg4pSCDQo+ID4gPiA+ICAgICAg
IOKUgiBDb250cm9sbGVyICDilIIg4pSCIOKUgiAgICAgICDilIIgICAgICAgICAg4pSCICAgICAg
ICAgIOKUgg0KPiA+ID4gPiAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilJgg4pSU4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSADQo+IOKU
gA0KPiA+ID4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSAQkFSMCAgICAg4pSCDQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiBQQ0kgICDilIIgICAgICAgICAg4pSCIEJBUjEg
ICAgIOKUgg0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICDilIIgRnVuYyAg4pSCICAg
ICAgICAgIOKUgiBCQVIyICAgICDilIINCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
4pSCICAgICAgIOKUgiAgICAgICAgICDilIIgQkFSMyAgICAg4pSCDQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIOKUgiAgICAgICDilIIgICAgICAgICAg4pSCIEJBUjQgICAgIOKUgg0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICDilIIgICAgICAg4pSc4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pa64pSCICAgICAgICAgIOKUgg0KPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilJggICAgICAgICAg4pSU4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gVGhpcyBk
aWFncmFtIGRvZXNuJ3Qgc2F5IHdoaWNoIHNpZGUgaXMgaG9zdCBhbmQgd2hpY2ggb25lIGlzIGVu
ZHBvaW50Lg0KPiA+ID4gQW5kIG5vdCBjb252ZXlpbmcgYW55IHVzZWZ1bCBpbmZvcm1hdGlvbi4N
Cj4gPg0KPiA+IFtGcmFuayBMaV0gQXQgVjIgdmVyc2lvbiwgdGhpcyBkaWFncmFtIGlzIGluIGNv
dmVyIGxldHRlci4gIEJqb3JuIHN1Z2dlc3QgbW92ZQ0KPiB0byBoZXJlLg0KPiA+IEkgdGhpbmsg
eW91IGhhdmUgZ29vZCBiYWNrZ3JvdW5kIGtub3dsZWRnZS4gIEJ1dCBpdCBzaG91bGQgYmUgaGVs
cGZ1bCBmb3INCj4gbmV3DQo+ID4gUGVvcGxlLCAgd2hvIGp1c3QgdG91Y2ggdGhpcyBhcmVhLg0K
PiA+DQo+IA0KPiBIYXZpbmcgdGhlIGJsb2NrIGRpYWdyYW0gYWx3YXlzIGhlbHBzIGJ1dCBteSBw
b2ludCBpcyB0aGF0IHRoaXMgZGlhZ3JhbQ0KPiBkb2Vzbid0DQo+IGNvbnZleSB0aGUgaW1tZWRp
YXRlIGtub3dsZWRnZSB0aGF0IGl0IGlzIHN1cHBvc2VkIHRvIGRvIHNvLiBMaWtlIHRoZXJlIGlz
IG5vDQo+IHBhcnRpdGlvbiBiZXR3ZWVuIGhvc3QgYW5kIGVuZHBvaW50IGFuZCB5b3UgZGlkIG5v
dCBhZGQgYW55IGV4cGxhbmF0aW9uDQo+IGFib3V0DQo+IGl0IGluIHRoZSBiZWxvdyB0ZXh0LiBT
byBpbiB2MiwgcGxlYXNlIGluY29ycG9yYXRlIHRob3NlLg0KPiANCj4gPiBJIGFscmVhZHkgbWFy
ayAiUENJIEZ1bmMiIGFuZCAiUENJIEhvc3QiLg0KPiA+DQo+IA0KPiBTb3JyeSwgdGhhdCdzIG5v
dCBoZWxwZnVsIGFuZCB5b3UgbmVlZCB0byBpbXByb3ZlIGl0Lg0KPiANCj4gPiA+DQo+ID4gPiA+
IExpbnV4IHN1cHBvcnRzIGVuZHBvaW50IGZ1bmN0aW9ucy4gUENJIEhvc3Qgd3JpdGUgQkFSPG4+
IHNwYWNlIGxpa2UNCj4gd3JpdGUNCj4gPiA+ID4gdG8gbWVtb3J5LiBUaGUgRVAgc2lkZSBjYW4n
dCBrbm93IG1lbW9yeSBjaGFuZ2VkIGJ5IHRoZSBob3N0IGRyaXZlci4NCj4gPiA+ID4NCj4gPiA+
DQo+ID4gPiBJIHRoaW5rIHlvdSBqdXN0IHNheSwgdGhhdCB0aGVyZSBpcyBubyBkZWZpbmVkIHdh
eSBvZiByYWlzaW5nIElSUXMgYnkgaG9zdA0KPiA+ID4gdG8gdGhlIGVuZHBvaW50Lg0KPiA+ID4N
Cj4gPiA+ID4gUENJIFNwZWMgaGFzIG5vdCBkZWZpbmVkIGEgc3RhbmRhcmQgbWV0aG9kIHRvIGRv
IHRoYXQuIE9ubHkgZGVmaW5lDQo+IE1TSSh4KQ0KPiA+ID4gPiB0byBsZXQgRVAgbm90aWZpZWQg
UkMgc3RhdHVzIGNoYW5nZS4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBNU0kgaXMgZnJvbSBFUCwg
cmlnaHQ/IFRocm91Z2hvdXQgdGhlIGRyaXZlciB5b3Ugc2hvdWxkIGNhbGwgaXQgYXMNCj4gImRv
b3JiZWxsIg0KPiA+ID4gYW5kIG5vdCBNU0kuDQo+ID4NCj4gPiBbRnJhbmsgTGldIFdoYXQncyBJ
IHdhbnQgc2FpZCBpcyB0aGF0IFBDSSBzdGFuZGFyZCBkZWZpbmUgTVNJKHgpIHRvIGxldCBFUA0K
PiBub3RpZnkgUkMuDQo+ID4gQnV0IHRoZXJlIGFyZSBub3Qgc3RhbmRhcmQgd2F5IGZvciByZXZl
cnNlIGRpcmVjdGlvbi4gIE1TSSBzaG91bGQgYmUNCj4gY29ycmVjdCBoZXJlLg0KPiA+DQo+IA0K
PiBSaWdodC4gQnV0IGFsc28gdXNlICJNU0kvTVNJLVgiIGluc3RlYWQgb2YgIk1TSSh4KSINCj4g
DQo+ID4gPg0KPiA+ID4gPiBUaGUgYmFzaWMgaWRlYSBpcyB0byB0cmlnZ2VyIGFuIElSUSB3aGVu
IFBDSSBSQyB3cml0ZXMgdG8gYSBtZW1vcnkNCj4gPiA+ID4gYWRkcmVzcy4gVGhhdCdzIHdoYXQg
TVNJIGNvbnRyb2xsZXIgcHJvdmlkZWQuIEVQIGRyaXZlcnMganVzdCBuZWVkIHRvDQo+ID4gPiA+
IHJlcXVlc3QgYSBwbGF0Zm9ybSBNU0kgaW50ZXJydXB0LCBzdHJ1Y3QgbXNpX21zZyAqbXNnIHdp
bGwgcGFzcyBkb3duIGENCj4gPiA+ID4gbWVtb3J5IGFkZHJlc3MgYW5kIGRhdGEuIEVQIGRyaXZl
ciB3aWxsIG1hcCBzdWNoIG1lbW9yeSBhZGRyZXNzIHRvDQo+IG9uZQ0KPiA+ID4gb2YNCj4gPiA+
ID4gUENJIEJBUjxuPi4gIEhvc3QganVzdCB3cml0ZXMgc3VjaCBhbiBhZGRyZXNzIHRvIHRyaWdn
ZXIgRVAgc2lkZSBpcnEuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSUlVQyAoYnkgbG9va2luZyBh
dCBvdGhlciBwYXRjaGVzIGluIHRoZSBzZXJpZXMpLCB0aGUgbWVtb3J5IGFzc2lnbmVkIGZvcg0K
PiBCQVINCj4gPiA+IHJlZ2lvbiBieSB0aGUgUENJIGhvc3QgaXMgbWFwcGVkIHRvIHRoZSBwbGF0
Zm9ybSBpbnRlcnJ1cHQgY29udHJvbGxlciBpbg0KPiA+ID4gUENJIEVuZHBvaW50LiBTdWNoIHRo
YXQsIHdoZW5ldmVyIHRoZSBQQ0kgaG9zdCB3cml0ZXMgdG8gdGhlIEJBUiByZWdpb24sDQo+IGl0
DQo+ID4gPiB3aWxsIHRyaWdnZXIgYW4gSVJRIGluIHRoZSBFbmRwb2ludC4NCj4gPiA+DQo+ID4g
PiBUaGlzIGtpbmQgb2Ygc2V0dXAgaXMgYXZhaWxhYmxlIGluIG90aGVyIHBsYXRmb3JtcyBsaWtl
IFF1YWxjb21tIHdoZXJlDQo+IHRoZQ0KPiA+ID4gbWFwcGluZyBvZiBhIHJlZ2lzdGVyIHJlZ2lv
biBhdmFpbGFibGUgaW4gQkFSMCBhbmQgaW50ZXJydXB0IGNvbnRyb2xsZXIgaXMNCj4gPiA+IGRv
bmUgaW4gdGhlIGhhcmR3YXJlIGl0c2VsZi4gU28gd2hlbmV2ZXIgdGhlIFBDSSBob3N0IHdyaXRl
cyB0byB0aGF0DQo+IHJlZ2lzdGVyDQo+ID4gPiBpbiBCQVIwLCBhbiBJUlEgd2lsbCBiZSBkZWxp
dmVyZWQgdG8gdGhlIGVuZHBvaW50Lg0KPiA+DQo+ID4gW0ZyYW5rIExpXSBZZXMsICBub3QgYWxs
IHBsYXRmb3JtIGhhdmUgaXQuIEFuZCBFUCBkcml2ZXIgaGF2ZSBub3QgcHJvdmlkZSBhIEFQSQ0K
PiA+IHRvIGdldCByZWdpc3RlciByZWdpb24uICBJIHRoaW5rIHBsYXRmb3JtIG1zaSBBUEkgaXMg
cHJldHR5IGdvb2QgQVBJLg0KPiA+IE1hbnkgc3lzdGVtIGhhdmUgR0lDIElUUywgIHNvIEVQIGZ1
bmN0aW9uIGRyaXZlciBjYW4gdXNlIGl0LiAgT3VyIHRlc3QNCj4gcGxhdGZvcm0NCj4gPiBoYXZl
IG5vdCBJVFMgeWV0LCAgc28gd2UgYWRkZWQgYSBzaW1wbGUgTVUtTVNJIGRyaXZlciB0byBkbyBp
dC4gSSB0aGluaw0KPiBxdWFsY29tbQ0KPiA+IHBsYXRmb3JtIGNhbiB1c2Ugc2ltaWxhciBtZXRo
b2QuICBTbyBhbGwgRVAgZnVuY3Rpb24gZHJpdmVyIGNhbiB1c2UgY29tbW9uDQo+IG1ldGhvZA0K
PiA+IHRvIGdldCBub3RpZmljYXRpb24gZnJvbSBQQ0kgaG9zdC4NCj4gPg0KPiANCj4gV2hhdCBp
cyB0aGUgY29tbW9uIG1ldGhvZCBoZXJlPyBJZiB5b3Ugd2FudCB0byBtYWtlIHRoaXMgZG9vcmJl
bGwgZmVhdHVyZQ0KPiBjb21tb24gYWNyb3NzIGFsbCBFUEYgZHJpdmVycywgdGhlbiB5b3UgbmVl
ZCB0byBwcm92aWRlIEVQRiBBUElzLg0KDQpbRnJhbmsgTGldIEV4aXN0ZWQgTVNJIEFQSSBoYXZl
IG1hdGNoZWQgcmVxdWlyZW1lbnQuICBFUEYganVzdCByZXVzZWQgaXQuDQpUaGlzIHBhdGNoIHBy
b3ZpZGVkIGRlbW8gbWV0aG9kIHRvIHNob3cgaG93IHRvIHVzZSBwbGF0Zm9ybSBNU0kgQVBJIHRv
IG1ha2UgdGhpcw0KRG9vcmJlbGwuIA0KDQo+IA0KPiA+ID4NCj4gPiA+ID4gQWRkIE1TSSBzdXBw
b3J0IGZvciBwY2ktZXBmLXZudGIuIHBjaS1lcGYtdm50YiBkcml2ZXIgcXVlcnkgaWYgc3lzdGVt
DQo+ID4gPiA+IGhhdmUgTVNJIGNvbnRyb2xsZXIuIFNldHVwIGRvb3JiZWxsIGFkZHJlc3MgYWNj
b3JkaW5nIHRvIHN0cnVjdA0KPiBtc2lfbXNnLg0KPiA+ID4gPg0KPiA+ID4gPiBTbyBQQ0llIGhv
c3QgY2FuIHdyaXRlIHRoaXMgZG9vcmJlbGwgYWRkcmVzcyB0byB0cmlnZXIgRVAgc2lkZSdzIGly
cS4NCj4gPiA+ID4NCj4gPiA+ID4gSWYgbm8gTVNJIGNvbnRyb2xsZXIgZXhpc3QsIGZhbGwgYmFj
ayB0byBzb2Z0d2FyZSBwb2xsaW5nLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBG
cmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJz
L3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMgfCAxMzQgKysrKysrKysrKysr
KysrLQ0KPiAtLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDExMiBpbnNlcnRpb25zKCspLCAy
MiBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiA+ID4gYi9kcml2ZXJzL3BjaS9l
bmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gDQo+IFsuLi5dDQo+IA0KPiA+ID4g
PiArc3RhdGljIHZvaWQgZXBmX250Yl9lcGNfbXNpX2luaXQoc3RydWN0IGVwZl9udGIgKm50YikN
Cj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJm50Yi0+ZXBm
LT5kZXY7DQo+ID4gPiA+ICsgICAgIHN0cnVjdCBpcnFfZG9tYWluICpkb21haW47DQo+ID4gPiA+
ICsgICAgIGludCB2aXJxOw0KPiA+ID4gPiArICAgICBpbnQgcmV0Ow0KPiA+ID4gPiArICAgICBp
bnQgaTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBkb21haW4gPSBkZXZfZ2V0X21zaV9kb21h
aW4obnRiLT5lcGYtPmVwYy0+ZGV2LnBhcmVudCk7DQo+ID4gPiA+ICsgICAgIGlmICghZG9tYWlu
KQ0KPiA+ID4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAg
ICBkZXZfc2V0X21zaV9kb21haW4oZGV2LCBkb21haW4pOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsg
ICAgIGlmIChwbGF0Zm9ybV9tc2lfZG9tYWluX2FsbG9jX2lycXMoJm50Yi0+ZXBmLT5kZXYsDQo+
ID4gPiA+ICsgICAgICAgICAgICAgbnRiLT5kYl9jb3VudCwNCj4gPiA+ID4gKyAgICAgICAgICAg
ICBlcGZfbnRiX3dyaXRlX21zaV9tc2cpKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgZGV2X2lu
Zm8oZGV2LCAiQ2FuJ3QgYWxsb2NhdGUgTVNJLCBmYWxsIGJhY2sgdG8gcG9sbCBtb2RlXG4iKTsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICByZXR1cm47DQo+ID4gPiA+ICsgICAgIH0NCj4gPiA+ID4g
Kw0KPiA+ID4gPiArICAgICBkZXZfaW5mbyhkZXYsICJ2bnRiIHVzZSBNU0kgYXMgZG9vcmJlbGxc
biIpOw0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4gV2h5IGFyZSB5b3UgdXNpbmcgdGhlIGludGVy
cnVwdCBjb250cm9sbGVyIGFzIHRoZSBNU0kgY29udHJvbGxlcj8gV2h5IG5vdA0KPiA+ID4ganVz
dA0KPiA+ID4gYSBwbGFpbiBpbnRlcnJ1cHQgY29udHJvbGxlcj8NCj4gPg0KPiA+IFtGcmFuayBM
aV0gd2hhdCdzIHlvdXIgbWVhbnM/ICAgSSB0aGluayBvbmx5IE1TSSBjb250cm9sbGVyIHN1cHBv
cnQgd3JpdGUNCj4gbWVtb3J5IHRvIHRyaWdnZXIgaXJxLg0KPiA+DQo+IA0KPiBGcm9tIEVQRiBk
cml2ZXIgcGVyc3BlY3RpdmUsIG9ubHkgdGhlIElSUXMgbmVlZCB0byBiZSByZXF1ZXN0ZWQsIHJp
Z2h0PyBTbw0KPiB3aHkNCj4gY2Fubm90IHlvdSBleHBvc2UgTVUgYXMgYSBnZW5lcmljIGlycWNo
aXAgZHJpdmVyLCBpbnN0ZWFkIG9mIGEgTVNJIGNvbnRyb2xsZXI/CQ0KDQpbRnJhbmsgTGldIE5v
LiAgRVBGIG5lZWQgdHdvIGluZm9ybWF0aW9uLiANCjEuIElSUSBudW1iZXIuIA0KMi4gQSBwaHlz
aWNhbCBhZGRyZXNzLCB3aGljaCBtYXAgc3VjaCBwaHlzaWNhbCBhZGRyZXNzIHRvIFBDSWUgQmFy
LCBzbyBQQ0kgaG9zdCBjYW4gDQpXcml0ZSBpdCBhbmQgdHJpZ2dlciBFUCBzaWRlIElSUS4NCg0K
PiANCj4gVGhhbmtzLA0KPiBNYW5pDQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPg
rqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
