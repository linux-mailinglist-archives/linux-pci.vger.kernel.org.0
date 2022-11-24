Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9E638080
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 22:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKXVTQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 16:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXVTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 16:19:15 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD093CDD;
        Thu, 24 Nov 2022 13:19:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf1kkMBxqt3JwKRn6W5T9nGWv0xLFcbqCPmlAu3xDoWUcU3Cs9f4L/6aXRAGcc+aNovJQdvB0ADqRsKR/gtLozO5elfaJLzLHYlsJvs1zZcuTFs1KJoNZ/yZGS+/2N41ajmn8Wt4a8IpiF6KmSiyp1u9pwyH5a9AeLT6ZSMvXB1Jt5opcoKUk0imyHziu1yrG+yLLaNBWBr41Q75Afp864Oy1/IuP9ud6mdz9qfIhyCQYiQhGSiY8dhwnOI/7JzhECkUmAq4gC7LdHxnEjolpy1Om2dmoWoqb5fKN0gmEWN4XZjZ1mJm+lInJa1H+bCDARo3Fs6qK7HsIXih3FLJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE/AqAHPet3P799wmMQAS8GRImhH0tfV9DCI6VZsa2M=;
 b=ZRbMrqiuvZAgoXrqFTOis4wniXINutHH/Qybt2r+p5WOSV3qw4yF0sNLusr29Jth9hTPkDcLmsmtfPM2sgJjVnQ3mSZgc+lyzQoWYcN2NEYwjzgHfTb2vMqOTVmJsbSqV+XEjxSTAl1ISNobOzu+AAjBHesqNMFQsZR6d7nNDWqDUrVLGWmJbbXCvpXanufWUT8G9Glxf99VzkK4iYyTxyVHJMf/9VyWoU6Kpvdd/YDETPvBF8LxhtRO484hfDzFTNWDIyq6ClIZ4BepMkTBpwlvUnHM3P+A+2bjX7VgYa1uahYHDS1Uk/dW/YANjWfDLK0hqgfOoIUQo5OvGjSr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE/AqAHPet3P799wmMQAS8GRImhH0tfV9DCI6VZsa2M=;
 b=NZQ3RXkb9hzc0oLBFP9EafJvM31qsi5tl9hbycqyoPVVJAHlCIIoY2hTxRB5aB1HHMef93jhMV5LnWbGy8RIwQqUDAXgqJr9suGCxjLuFkSHz9AcqyCpGfriJueXHWzyqfPeXA8sAAi5PtzPVoRcDDFV0HtBZvUM6p38SFqhNps=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM0PR04MB7170.eurprd04.prod.outlook.com (2603:10a6:208:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 24 Nov
 2022 21:19:10 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5834.015; Thu, 24 Nov
 2022 21:19:10 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kishon@kernel.org" <kishon@kernel.org>
Subject: RE: [EXT] Re: [PATCH v13 1/2] PCI: endpoint: pci-epf-vntb: change
 doorbell register offset calc mathod
Thread-Topic: [EXT] Re: [PATCH v13 1/2] PCI: endpoint: pci-epf-vntb: change
 doorbell register offset calc mathod
Thread-Index: AQHY/8jAG9vNVXWRjUy04adMBun1ma5NzBqAgACIIDCAABerAIAAKONQ
Date:   Thu, 24 Nov 2022 21:19:09 +0000
Message-ID: <HE1PR0401MB23314EFD68910161C1A716AC880F9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
 <20221124055036.1630573-2-Frank.Li@nxp.com> <20221124091921.GD5119@thinkpad>
 <HE1PR0401MB233169E8D223BC8809BB3DB8880F9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221124185116.GG5119@thinkpad>
In-Reply-To: <20221124185116.GG5119@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AM0PR04MB7170:EE_
x-ms-office365-filtering-correlation-id: 180bad06-89e2-4483-ac70-08dace61871c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvJn3/DEERTbuGIUAnp9SaTLHiQvY37UVcCdPe5zGyeD8iCJ31qJmWnjG38oBW06+gJrTtDnmrRCzGsWUTM4vJazrG/sGtg4hYAQ9fDudSo/XuEbQLRGidAKAF8aQeSOzOq5zARnPXTT3htQ9xBQsec4HGB8I0rddWAvxXjnwPPDrh3k3HD5H8ELceo3ofJrpKRad1Yug6olBCW4KRdkgLIWZac05yHXrxu6f4+zgb3BCt8XNvAdX3+1NONs3zjX3vNwwzjsptTed3chXYgRRDeThb46qwKR5nJS/AqF38YZ3RFWpf1lc52TyQqKYOtg4olI62tPE4aZoVTIB6Gou+DuIdylW/Sg1g8cSgw4WwaDkHaSFbxsXvwbkyeXpSQV3An5YZ5CmJzq6yHlZxbyyajEymAsu2AZdPpuLwBWJ5ef5rK9m+XwzP68Hyxnjni+uwtTWQight5XFOfxBe/2H9km4jY1ySuztgGj2av6c7WTD3V5jPeUy0kU/lqMKkZzRsm30TdSRdPBg5g8m9G7ohG18kwBpjabSHWkfodkCgnPTA85xC7FOUHyyggAgE4RbFFNxnqrDA9ZErc9XmuJqGPGigl28H0b9gTp/tDQt/DQSNLKmrIH9S9fm8LctN5JpUXGRBaR/WP1OKZoCGbADczUn3me9bMEc8xWKpKf39cIOA6ZfGahpSuziHA6kZqXh/GtcaQ9MyqXaYSrh8g2LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(55016003)(38070700005)(9686003)(33656002)(86362001)(71200400001)(54906003)(6506007)(6916009)(7696005)(26005)(55236004)(53546011)(478600001)(7416002)(52536014)(44832011)(5660300002)(8936002)(66556008)(316002)(41300700001)(4326008)(76116006)(66946007)(8676002)(64756008)(66446008)(66476007)(2906002)(38100700002)(122000001)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qkx2MUdxZWhOdVFBSTlKRm90WU02SytCM09wQnpWUFhGa1Nvb1ZMaHlNeFhp?=
 =?utf-8?B?Qm0xL1k5U0ZFQVJaR0tPZ1A1TFVJS21vRmt6dWg4N1Q3bUZScFJVYnI5M0li?=
 =?utf-8?B?MTY4a2tpTmVQbW92dmpPbHlvNnNwNlplM01GU2xVWncwSzYxOVUvSW14Tll1?=
 =?utf-8?B?Y0Z6eDNYZlVReWMrZWFCTzRPQm15VVYwUDQreEdkKzBaZW9McTZlRWgzUEx2?=
 =?utf-8?B?MUFVcnFWeUdvYTQ5YkVMaHVKUnlNU3ZITzU0WmJCVTFBY2xFR0ZBd21PbEl1?=
 =?utf-8?B?ai9vaVJhSlN5bDNrZVR2RUYxY2dqby9xZXZuVVNPMDZXNDJPUVdZdFBlTUoy?=
 =?utf-8?B?STEreFZ2Tm96NWQyeXlRSG5JRERrajA5cy85NWdubXgyVGI4R2ZvQUlJWnpX?=
 =?utf-8?B?VFF6a2VROFFTZytpM0FzZUNRSFZlVG9xTlhwbEJ3L1lCMm9qV0ZVK1JiN2xX?=
 =?utf-8?B?cEpKaXFKZEVmMWIxV3QvK0wra0RXUEMrbTlCZlV3RFBwdlQyOVRZZUduakRm?=
 =?utf-8?B?bTJ1b3V5YlJqRTdtSmRHMXpSV3hMRUFBamlmM3AwVXZVbk5PMlJQR0lQWTVv?=
 =?utf-8?B?YzFQS3N4dlRuS2c4Rno1bThtdlVIOXRGU2V4TnNGMmNnNXl1RGFpTm9heUdD?=
 =?utf-8?B?Y2hRN2ZYVk5EOHNrNmdVL2hrTjNpRGIxRDFnUXBvRmpkcjFFeTlTbmE1eGZw?=
 =?utf-8?B?ak5rWUJDMXJQeWkwMUMvSlpwSytKSUZRZWd2NFA1a0d4VmZvMmFOYlM2Q0hL?=
 =?utf-8?B?S1dobWRNTFZhR0pCVW85NERJY3U2UHZNclNWdy80ejNKSzFqTUViT0h4THdu?=
 =?utf-8?B?TUpDT09PdDlWRWdkQ3dqSmFEa2pSZ21PVEcwbm1rc05iMER5TE5TS2kzak54?=
 =?utf-8?B?MTNmcmpnQ3VPdTBPVDllTG9VNjI4VEdlZHl2c3BhdS84OXhnOXpxU3k4UWM5?=
 =?utf-8?B?dlV6QTB6Q0htd1B6LzlIU3ZtVVRJWW93cHVEV0lQSDM4WGs1TEhKSHBHNWd5?=
 =?utf-8?B?Um8wYVVKd0NnaEtjMFFMUS9IcVNkOW93Wm5WSWdpSkZJbVo4UEVBUTMvaXdK?=
 =?utf-8?B?d0lxTWY4b2lNcU9seG9Zdi9JVjZHYnVYc2Z4RmQzakhnZEZLeWNjL2F3c2ky?=
 =?utf-8?B?RlQ5SkRtVXRnSHRPdkF2b2dmUDNmd3hUcEFqSUNETDJoOCswVk5TZHhmUVRE?=
 =?utf-8?B?d200SkZlMVlPU1piVittck81Z0pRenlJeEc0SDNxN3BPdXBmaVI3ZTcvWlVi?=
 =?utf-8?B?WWlBMWhIZUpLV1cxYjF1cnZ5cjBiZEpvVFdiOXBsMGpENDJvRGZzMnIxRld0?=
 =?utf-8?B?MXZzVm5nQjR4aG5MWXEzZmYxMVRpdFAvaVo1YVdVMjdqblRLR3ErNjhvcTBG?=
 =?utf-8?B?RVRIb1NXeU9rbFo1N2dvb2ppQWFiZW0xQnJNY2FQYmhheDBwSWQyVlFGcm9K?=
 =?utf-8?B?Q2lGR0Z1UnhmcXd5aVNjM3RzWU5nN2VXdTdvdXJ2bmhtZ043aFErT0ZlUTF0?=
 =?utf-8?B?aEZZVEdiY0Q5ZlZsdlZHVXc3Z2RDMzcrdTRtaDFLbVRlMTJHUzdSL0x4MnRo?=
 =?utf-8?B?aFIreUJpL3A4UWxuQWhtd1dsRTdpKzRyc1I2QW1lMXlaNlhhUjE5dFBtOFRH?=
 =?utf-8?B?RFZQcVNVNHlBTFFJRmZJYWxqbGVFcnJSWWdwSW4vaUdkSE85Y3dIbU41aENY?=
 =?utf-8?B?K2QvbWJBZ1FRa3RCQUpMZ0JXK3h2blFEQ2w0NXRIRFhXaFo3citUNmxRZm1r?=
 =?utf-8?B?MzY1QU45ZndZZC9GSHFzaVFYNnR2aVFqWnVoWk5MaHRQK3dZSWhHNVNLb0xx?=
 =?utf-8?B?UzFwdEdhaVN5c1lNdlFEVENXMXYrNjVyZGg5SHFPK2d2dWpwOC9UdTg1bCtW?=
 =?utf-8?B?a1pQbDE2Z3VIbnd6Ykd2Vmlhb0VMVUF2bVIwQkRtelJZbXVLUVg3RUdVVGVB?=
 =?utf-8?B?OE1QRzZGanNUWWJQa0JwU0xlbSthalVZMmpoUzJsUDh6bFJxMmIrS0R5VmxO?=
 =?utf-8?B?eVJTNHk1d25EZGdWT1N4VDBycXorSEE3Z0NCV21POFFRa1RkUzhiWExGY21o?=
 =?utf-8?B?dDNGWmFCUFJzUXczdUFURUNjUjFvcXV1aHgrSExWbVRsTCtKczE4ekcyTmk2?=
 =?utf-8?Q?cRAM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180bad06-89e2-4483-ac70-08dace61871c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 21:19:10.0143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8n4cGCXipIoqQHGkqlIHKJ64H3WC9B2c9FDpeWn4+nPjSpzHS1r8VrmfrqznAnuxbvkt3INdiUq9PhvoW+ANUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNk
YXksIE5vdmVtYmVyIDI0LCAyMDIyIDEyOjUxIFBNDQo+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gQ2M6IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsgQWlzaGVuZyBEb25nIDxhaXNo
ZW5nLmRvbmdAbnhwLmNvbT47DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGlteEBsaXN0cy5saW51eC5kZXY7
IGpkbWFzb25Aa3VkenUudXM7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4ga3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnOyBrd0BsaW51eC5jb207IGxpbnV4LWFybS0NCj4ga2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZzsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgbHpudWFhQGdtYWlsLmNvbTsgbWF6QGtl
cm5lbC5vcmc7DQo+IG50YkBsaXN0cy5saW51eC5kZXY7IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBzaGF3
bmd1b0BrZXJuZWwub3JnOyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IGtpc2hvbkBrZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYxMyAxLzJdIFBDSTogZW5kcG9pbnQ6
IHBjaS1lcGYtdm50YjogY2hhbmdlDQo+IGRvb3JiZWxsIHJlZ2lzdGVyIG9mZnNldCBjYWxjIG1h
dGhvZA0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBUaHUsIE5vdiAyNCwgMjAy
MiBhdCAwNTo0OTozMlBNICswMDAwLCBGcmFuayBMaSB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNp
dmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gPiA+IFNlbnQ6IFRodXJz
ZGF5LCBOb3ZlbWJlciAyNCwgMjAyMiAzOjE5IEFNDQo+ID4gPiBUbzogRnJhbmsgTGkgPGZyYW5r
LmxpQG54cC5jb20+DQo+ID4gPiBDYzogbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBBaXNoZW5nIERv
bmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsNCj4gPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gPiBp
bXhAbGlzdHMubGludXguZGV2OyBqZG1hc29uQGt1ZHp1LnVzOyBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7DQo+ID4gPiBraXNob25AdGkuY29tOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5v
cmc7IGt3QGxpbnV4LmNvbTsgbGludXgtDQo+ID4gPiBhcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC0NCj4gPiA+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
PiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBsem51YWFAZ21haWwuY29tOyBtYXpAa2VybmVs
Lm9yZzsNCj4gPiA+IG50YkBsaXN0cy5saW51eC5kZXY7IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsg
c2hhd25ndW9Aa2VybmVsLm9yZzsgdGdseEBsaW51dHJvbml4LmRlDQo+ID4gPiBTdWJqZWN0OiBb
RVhUXSBSZTogW1BBVENIIHYxMyAxLzJdIFBDSTogZW5kcG9pbnQ6IHBjaS1lcGYtdm50YjogY2hh
bmdlDQo+ID4gPiBkb29yYmVsbCByZWdpc3RlciBvZmZzZXQgY2FsYyBtYXRob2QNCj4gPiA+DQo+
ID4gPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIE5vdiAyNCwgMjAy
MiBhdCAxMjo1MDozNUFNIC0wNTAwLCBGcmFuayBMaSB3cm90ZToNCj4gPiA+ID4gSW4gZHJpdmVy
cy9udGIvaHcvZXBmL250Yl9od19lcGYuYw0KPiA+ID4gPiBudGJfZXBmX3BlZXJfZGJfc2V0KCkN
Cj4gPiA+ID4gew0KPiA+ID4gPiAgICAuLi4NCj4gPiA+ID4gICAgZGJfb2Zmc2V0ID0gcmVhZGwo
bmRldi0+Y3RybF9yZWcgKw0KPiBOVEJfRVBGX0RCX09GRlNFVChpbnRlcnJ1cHRfbnVtKSk7DQo+
ID4gPiA+ICAgIHdyaXRlbChkYl9kYXRhLCBuZGV2LT5kYl9yZWcgKyAoZGJfZW50cnlfc2l6ZSAq
IGludGVycnVwdF9udW0pICsNCj4gPiA+ID4gICAgICAgICAgICAgICAgZGJfb2Zmc2V0KTsNCj4g
PiA+ID4gICAgLi4uDQo+ID4gPiA+IH0NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGRvb3IgcmVnaXN0
ZXIgb2Zmc2V0J3MgZm9ybXVsYXIgaXMNCj4gPiA+ID4gICAgICAgb2Zmc2V0ID0gZGJfZW50cnlf
c2l6ZSAqIGludGVycnVwdF9udW0gKw0KPiBkYl9vZmZzZXRbaW50ZXJydXB0X251bWJlcl0NCj4g
PiA+DQo+ID4gPiBZb3UgZGlkIG5vdCBtZW50aW9uIHRoZSBEQiBCQVIgaGVyZS4gV2l0aG91dCB0
aGF0LCB0aGlzIGNhbGN1bGF0aW9uDQo+IGRvZXNuJ3QNCj4gPiA+IG1ha2Ugc2Vuc2UuDQo+ID4N
Cj4gPiBEb29yYmVsbCByZWdpc3RlciBvZmZzZXQgc2hvdWxkIG1lYW5zIEJhc2Ugb24gREIgQkFS
Lg0KPiA+IEhvdyBhYm91dCAiVGhlIGZvcm11bGEgb2YgIGRvb3IgcmVnaXN0ZXIgb2Zmc2V0IHJl
ZmVyIHRvIERCIEJBUiI/DQo+IA0KPiAiRG9vYmVsbCByZWdpc3RlciBvZmZzZXQgaW4gREIgQkFS
IGlzIGNhbGN1bGF0ZWQgdXNpbmc6Ig0KPiANCj4gPg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4g
UHJldmlvdXMgZGJfZW50cnlfc2l6ZSBpcyA0LCBhbGwgZGJfb2Zmc2V0IGlzIDAuDQo+ID4gPg0K
PiA+ID4gcy9QcmV2aW91cy9QcmV2aW91c2x5DQo+ID4gPg0KPiA+ID4gPiAgICAgICBpcnEgfCBv
ZmZzZXQNCj4gPiA+ID4gICAgICAgIC0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICAgICAgICAgIDAg
ICAgIDANCj4gPiA+ID4gICAgICAgICAgMSAgICAgNA0KPiA+ID4gPiAgICAgICAgICAyICAgICA4
DQo+ID4gPiA+ICAgICAgICAgLi4uDQo+ID4gPiA+DQo+ID4gPiA+IENoYW5nZSB0byBkYl9lbnRy
eV9zaXplIGlzIDAgYW5kIGRiX29mZnNldCBpcyAwLCA0LCA4LCAuLi4NCj4gPiA+ID4gU28gd2Ug
Y2FuIGdldCB0aGUgc2FtZSBtYXAgdmFsdWUgYmV0d2VlbiBpcnEgYW5kIG9mZnNldC4gVGhpcyB3
aWxsIGJlDQo+ID4gPiA+IGNvbnZlbmllbmNlIGZvciBoYXJkd2FyZSBkb29yYmVsbCByZWdpc3Rl
ciBtZW1vcnkgbWFwLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEluIHlvdXIgaXJxLWlteC1tdS1t
c2kuYyBkcml2ZXIsIHRoZSBtc2lfYWRkcmVzcyBpcyBjYWxjdWxhdGVkIGFzOg0KPiA+ID4NCj4g
PiA+IGBgYA0KPiA+ID4gdTY0IGFkZHIgPSBtc2lfZGF0YS0+bXNpaXJfYWRkciArIDQgKiBkYXRh
LT5od2lycTsNCj4gPiA+IGBgYA0KPiA+ID4NCj4gPiA+IFNvIHRoZSBNU0kgYWRkcmVzc2VzIGl0
c2VsZiBhcmUgb2YgNCBieXRlcyB3aWR0aC4gU28gdGhlIG9mZnNldHMgd2lsbCBiZQ0KPiA+ID4g
c2VwYXJhdGVkIGJ5IDggYnl0ZXMgbGlrZSwgMCwgOCwgMTYsLi4uIGFuZCB0aGlzIHdvbid0IG1h
dGNoIHRoZSBNU0kNCj4gYWRkcmVzc2VzDQo+ID4gPiBhcyB0aGV5IGFyZSA0IGJ5dGVzIGFwYXJ0
Lg0KPiA+DQo+ID4gQWRkciBpcyBhYnNvbHV0ZSBwaHlzaWNhbCBJTyBhZGRyZXNzLCB3aGljaCBp
bmNyZWFzZWQgYnkgNC4gQnV0IGl0IGRvZXNuJ3QNCj4gbWF0dGVyLg0KPiA+IEl0IHNob3VsZCBi
ZSBva2F5IGlmIHJhbmdlIGlzIGJldHdlZW4gMl4zMi4NCj4gPg0KPiA+ID4NCj4gPiA+IFNvIHlv
dSB3YW50IHRvIGNoYW5nZSB0aGUgb2Zmc2V0IHRvIDAsIDQsIDgsLi4uIGJ5IHplcm9pbmcgZGJf
ZW50cnlfc2l6ZSwNCj4gPiA+IHJpZ2h0Pw0KPiA+DQo+ID4gSSB3YW50IHRvIGRpcmVjdGx5IHVz
aW5nIGRiX29mZnNldFtpcnFdIHZhbHVlIGFzIG9mZnNldC4gSXQgd2lsbCBiZSBzaW1wbGUuDQo+
ID4NCj4gPiBJIGFtIG5vdCBzdXJlIHdoeSBudGJfaHdfZXBmLmMgdXNlIGJlbG93IGZvcm11bGFy
Lg0KPiA+ICAiRGJfb2Zmc2V0W2lycV0gKyBpcnEgKiBkYl9lbnRyeV9zaXplIg0KPiA+DQo+ID4g
RGJfZW50cnlfc2l6ZSA9IDAgd2lsbCBiZSBzaW1wbGUsICBhbGwgb2Zmc2V0IHdpbGwgYmUgY29u
dHJvbGxlZCBieSBkYl9vZmZzZXRbXQ0KPiA+DQo+ID4gWW91IGNhbiBzYXZlIGRiX29mZnNldFtd
IGFzIDAsIDQsIDguLi4gb3IgMCwgOCwgMTYgYXMgbmVlZHMuDQo+ID4NCj4gPiA+DQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYyB8
IDQgKystLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2VuZHBv
aW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiA+ID4gYi9kcml2ZXJzL3BjaS9lbmRwb2lu
dC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gPiA+ID4gaW5kZXggMDQ2OThlNzk5NWE1Li4w
ZDc0NDk3NWY4MTUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1
bmN0aW9ucy9wY2ktZXBmLXZudGIuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9lbmRwb2lu
dC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gPiA+ID4gQEAgLTQ2MSwxMSArNDYxLDExIEBA
IHN0YXRpYyBpbnQNCj4gZXBmX250Yl9jb25maWdfc3BhZF9iYXJfYWxsb2Moc3RydWN0DQo+ID4g
PiBlcGZfbnRiICpudGIpDQo+ID4gPiA+ICAgICAgIGN0cmwtPm51bV9td3MgPSBudGItPm51bV9t
d3M7DQo+ID4gPiA+ICAgICAgIG50Yi0+c3BhZF9zaXplID0gc3BhZF9zaXplOw0KPiA+ID4gPg0K
PiA+ID4gPiAtICAgICBjdHJsLT5kYl9lbnRyeV9zaXplID0gc2l6ZW9mKHUzMik7DQo+ID4gPiA+
ICsgICAgIGN0cmwtPmRiX2VudHJ5X3NpemUgPSAwOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICBm
b3IgKGkgPSAwOyBpIDwgbnRiLT5kYl9jb3VudDsgaSsrKSB7DQo+ID4gPiA+ICAgICAgICAgICAg
ICAgbnRiLT5yZWctPmRiX2RhdGFbaV0gPSAxICsgaTsNCj4gPiA+ID4gLSAgICAgICAgICAgICBu
dGItPnJlZy0+ZGJfb2Zmc2V0W2ldID0gMDsNCj4gPiA+ID4gKyAgICAgICAgICAgICBudGItPnJl
Zy0+ZGJfb2Zmc2V0W2ldID0gc2l6ZW9mKHUzMikgKiBpOw0KPiA+ID4NCj4gPiA+IElmIG15IGFi
b3ZlIHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdCwgdGhlbiB5b3UgY291bGQganVzdCByZWFzc2ln
bg0KPiA+ID4gImRiX2VudHJ5X3NpemUiIGluIGVwZl9udGJfZXBjX21zaV9pbml0KCkuDQo+ID4N
Cj4gPiBZZXMsIHRoYXQncyBvbmUgbWV0aG9kLg0KPiA+IEkgd2FudCB0byB1c2Ugb25lIG1ldGhv
ZCB0byBjYWxjIGRiIG9mZnNldCBmb3IgYm90aCBzb2Z0d2FyZSBwb2xsaW5nDQo+ID4gYW5kIE1T
SS4gIFNvIG92ZXJhbGwgbG9naWMgc2hvdWxkIGJlIHNpbXBsZS4NCj4gPg0KPiANCj4gSSB0aGlu
ayBpdCBpcyBiZXR0ZXIgdG8gbGVhdmUgZGJfZW50cnlfc2l6ZSBmb3IgcG9sbGluZyBhcyBpdCBp
cyBhbmQgbW9kaWZ5IGl0DQo+IGZvciBNU0kgYWxvbmUuDQoNCk9rYXksIHRoYXQgbWVhbnMgbmVl
ZG4ndCB0aGlzIHBhdGNoIGF0IGFsbC4NCg0KPiANCj4gVGhhbmtzLA0KPiBNYW5pDQo+IA0KPiA+
IEZyYW5rIExpDQo+ID4NCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBNYW5pDQo+ID4gPg0K
PiA+ID4gPiAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ID4g
PiAtLQ0KPiA+ID4gPiAyLjM0LjENCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4g4K6u
4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0KPiANCj4g
LS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCv
jQ0K
