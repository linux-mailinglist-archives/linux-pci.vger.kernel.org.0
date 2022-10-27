Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF9A60FA7A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 16:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ0OgC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiJ0OgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 10:36:00 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9EC17F2BF;
        Thu, 27 Oct 2022 07:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah4bcBLvez6vOZEbITKP8ecQ2OKBfageN8du2wecUUezwZX3269slnGYmCe8pcNN7O4YbtbCvSn8YhjrHXG7qV40AsbQyCpB0ci7n0n9rc3/0AaplP/2MzBDHig2G91y92HE/CQteeWt1fxhOU/TqFF26V5hSw2PlupmYJbPg0mrtwu6i4d1hoFgl4lu6PD+yyXY9+LcbY986L6EnCCT8YTEgxVUUFr+0RZSgbCP8ioUVKSECtpVBjsx6bKCsH3PZ/SlzEr7fOGsSkiGUx9v6dZDfnhiSJ+jMNT2NHc2ffWvF+KxXnJJ3yecCVZmlia/cqExhZs+lbZKLXl3gxP6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEgzmMzWbCxAYLyCWmHWGh+Z2m10eoUiDusiBoa3uqg=;
 b=UNKRw5MmzZnU3YQsJDzi9PmXDhU9sAy0gTuNHnCf2Zx5GJ5gsR1FCZTdOEop2pg571UbTxPXxNpEz9yz/PVCEIifLQVBQMcRDqNZYTcQ5ixXvKEVs3epHjl0OSqGmgslj//eBFuu5A2yl+VG9KUZWhLX0zX/g9daZYF1xWheP9bD1C4PhtB/4P8cXXtZdI+PV1/muyhW4TCu7qtohoeSI5SZrB2c8Zfjss1R8uODq1BC/sqzEXcZXfTVifsqvGXlaNF8eHekxI72hGr+kncDaGF+mXejIJrrFBc2vS8jQSIC04Z+TMue7kFNemo6iqakgaHNCPsqXA5qcWVreAg8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEgzmMzWbCxAYLyCWmHWGh+Z2m10eoUiDusiBoa3uqg=;
 b=Iny25XFtncAAw2OP4pkD8eHp1k0mfBGfdtGYTAke5B4bvuPNoKuwvK8w5eMEyt4fRpmb8dHwUyj+n+Vq1F0+nBN3MI5sFNDDnkLW5XQUZloVc787eQXmbM3oVf0GAgLrESedHvxUIK2xQBhI/NAZGkjesHOWbkacOjfaAcJX8n4=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DBBPR04MB7676.eurprd04.prod.outlook.com (2603:10a6:10:20e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 14:35:57 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Thu, 27 Oct
 2022 14:35:57 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shunsuke Mie <mie@igel.co.jp>
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
Thread-Topic: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
Thread-Index: AQHY6H0/bvuG5O/HGUqsNICaEl4Piq4fRolwgAIzcoCAANaFIA==
Date:   Thu, 27 Oct 2022 14:35:56 +0000
Message-ID: <HE1PR0401MB23319EE329D62420919740C688339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20220922092357.123732-1-mie@igel.co.jp>
 <20221025142143.GA109941@thinkpad>
 <HE1PR0401MB233126D2C7410EC5F6C3976488319@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjnbZMzFJt8kBtQz6FHc_QQYw7=fZp8kK87mZ-t75z+g@mail.gmail.com>
In-Reply-To: <CANXvt5qjnbZMzFJt8kBtQz6FHc_QQYw7=fZp8kK87mZ-t75z+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|DBBPR04MB7676:EE_
x-ms-office365-filtering-correlation-id: 2c1bf11c-06ac-402f-b51f-08dab8288f59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E6oSe8N+680vhFrApwvSQTvG9Cd1biy9DjjLe6oMVa/9zrM8hsxEIYYOx4WKDjEFP7m2KbU/4QnzF6o/L2TBnqgn5R8dQjQ6fac+utv1flmG+AHsH+gKbqD88RCT16Nk8WUb8/pIANDLvRFeUleTGInifTFfAQeKfvLl2gta+1gdO7rmmJx8aCriV5NzbL/CTLjyKSrc1d9S22zPJ1/iLbpg60LPRnNnKV2WyUKKdjdAMwjsghFKgE3GmMimamMNttza9eHNeJYYbqs7Xy4+Xnt8VfLGnQDbpTYHVs5Q+6kMk5A6V81dcQdLIbZEq1avN9TUVE+A7h2RiBk4vk2ZBfwmhEYFzpOvYtjvCvo6xy8tHUyE3WLjchZ2oLaYZUMxsLdQKDXTFzU5nNpRSs1hvJsSHHF/saY+E4YVjZ4zYp7Z+Mk8c8S+0bkP+BVaPYDTk7cHQWB17maE5KAqpy1LpxLhqSQaVCdKoO9SISjkh7XHyJdkxBmoagr2lNH8qk2x1/Y4M5x0ylnmARFWaRAnlFKHYHW8RYzgMNpdfT9HVRq0x9tZver3E6GWyE1qAtrFVO09QSP8OJNieM+GAJOQrXN9Vp5i6ItQqMWLKGkVUZqjhAyXiNKoESwlqo/hE2Yig9QqJeSPuKZiME9ixdkiCNqgl1rmj7VGZZhSAVJLWAry3eKCeQ1MqdoH/SI4iMzygYtBDXCxC0k7i4ASG0VIq5Azep3PDzmQvnqeuO/E7/q+jjtKiFyQ9/aGbnyERqYsMvgI/nPiF4OiMOSVHi0/aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(44832011)(76116006)(55016003)(38070700005)(8676002)(66446008)(86362001)(33656002)(64756008)(66556008)(66476007)(66946007)(5660300002)(52536014)(316002)(41300700001)(8936002)(71200400001)(478600001)(186003)(7696005)(6916009)(9686003)(54906003)(26005)(53546011)(6506007)(122000001)(4326008)(38100700002)(55236004)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3JFWUgzMitTSHcxbC9yVGl3U0VVYXpnanRPUFQvOWpMWmNDekdsQ3RjTU1C?=
 =?utf-8?B?K3k5Y2lSUG1icHdJaHkvTHZVN1lTQUdSMzg0T0xCbFJSek9Yb3BqdWltUzBT?=
 =?utf-8?B?TTUrS1ZrVmhNODN2MjBmcFExTFpBK3o0aVdXY3BRakwrMVNmRndPc2ZHbzNy?=
 =?utf-8?B?cTY3M2JLS3BUK0NOYmhvUUNuMWlxTW1EVnNrTUJwZkthczdFSHhpYVlJOTJ4?=
 =?utf-8?B?SVFIN0dQdEF4MVZUZVVxM0JickdQUGxQTGQrVFBOUXA3Um1nVTF4UCtWUU4z?=
 =?utf-8?B?YzczV1NLZzZwWmlPUWxReldpV2NOUmE3Z0xGcUJnTVJuYkNKOEY4cEIyU3p5?=
 =?utf-8?B?SGtRVmRQR2dhMTY4dG0wMnlLTTNWY2JVTklmZXdYelByVWxOSU5xNVJoc3Bq?=
 =?utf-8?B?amJPTFpwcG5yV2xEVVQvRHYxWDV0WkJ0b3kvV3N0bDhCeWRXWVR0TkJwMk4z?=
 =?utf-8?B?VG9ZcE4yZlRSMGhseDRPd3AxRk1kZSsvYmlDajE1S0VzQWltMUJlQUZlaGtT?=
 =?utf-8?B?dGJ0bVNRV2VJcGkxYldzYTVxWmlTWE9YL3A1S2YrYTduREhlOTVPRkNZVjdF?=
 =?utf-8?B?SUZpSEJsYVNSaTdGMUFMdDA4eUpMWm1CMDBTLzNjQzFzU2E3T1RtTFBwWVZu?=
 =?utf-8?B?OFhQbjE4Ynl1WWpWRUp2bXFrK0R3UVl1TTkwaUZKZGNmSEx5NVM3YUR4VkZj?=
 =?utf-8?B?d1ZFd1NkdVg0RWRMYnNmekZOenlOdzhkZy9rZVV0ckZ3OUR4Z1V3eVRnbmJT?=
 =?utf-8?B?bmVlTy9oSldZbGVJeTFaVUpWY2tzSmZJQjFoVnluM2MwcFJXa2xPTmFoN1h3?=
 =?utf-8?B?VHYzQXk0NnBDM2d5TTE3UlYzd3JnSURrRmtCTG9RVEpxMEswN25kWjdVQitT?=
 =?utf-8?B?bjQvdlZ2NHp4bnVUS1NwS1dSWElzUVZNd1hadjVBYWgrRWJkWWxnSXdJelNE?=
 =?utf-8?B?ejR2dWpuMXZIVEZlS1pvRERwa25TN3B1VGVlV2Q1VnpOcW52eDRGVDRUZ2NX?=
 =?utf-8?B?WDN0T1ZBNnk4Z3hhMUY5RVlrSDZDOW9Ha1U5R0MxcHltcVduOE1BTytnd1Nl?=
 =?utf-8?B?bGs2LzBnUHFlYWxLTWU3Z2NnOXRMRmJQOWFHMkNOWGJjNlBzUVYrY1YvSFJU?=
 =?utf-8?B?amxnMVRqMjBYRE5YbzcxWmNreFcwekRYbTRPNHp2U0hCR3ovQXlsRG0rQ0N5?=
 =?utf-8?B?Z09pT1J0NlArOEJQdzlDZWVVRllIYm5ockduWUxWeUVPUTJNRlBjL3VVTWpy?=
 =?utf-8?B?MzFBaGVIMndZM2FvZWcyZWFRWHYycTNuZkVRTW1qUEpkcE1kN0hZeUp4MFVT?=
 =?utf-8?B?TElBOVphNXIva3hlV1dRTkFDVHlDaUs1UHNTaGpxdVMwUEtrakJhWUVnNWk1?=
 =?utf-8?B?Sm9INmpEMFFWVlFaSmsvL2lXd3JtZVdBNHJUYlIza1ozRDNERldTcFlRVTBI?=
 =?utf-8?B?dmdZUlBORmEvZWhLVDB4N0E4NDlBODY4M0Yrb0l1UWUzOXQrS2pEU0ptd28v?=
 =?utf-8?B?L24vTWR1U3NZWTh4cTZkd25oc0hCcnkvWWxTd1pMbDF6RkRtdFYyRDNlYnIr?=
 =?utf-8?B?YnBPSkVuYnlmTjRoZzBQK081WlhldVlxN1pwOGF3ZGQ2RUx5Yk1UcEtUWUZF?=
 =?utf-8?B?Ny9SNU5QcnhyZEROSTg0NUM3RVQrYkl4aDZBb2xOb09MTnQrYjRRU05xbWQr?=
 =?utf-8?B?bkFycmhYS29kM1RZc3V2ZE1IenJNa0pTc2dOYytma29Fa0FuaVpPU3NTazJ1?=
 =?utf-8?B?T0phNG9XUDI5QU1RM2pMUVNaZDNWZ080Q1Mwc1k1VnIxNUpzMlQrM1ZsMnk0?=
 =?utf-8?B?bVBlWGRzZlhUa210V05VNEpVbUFVN09uY0pKNjVpUzdja1NnWWVkZXY1WWtz?=
 =?utf-8?B?YnVnSjhXY0puSHI0UHVuc2dTK1c2UlhCd1hVUE1nLzY4b3JrUzYvVDJMRmkz?=
 =?utf-8?B?OFBhS3VacDlCZ25NM0tzQkJDTTArOEsrQkFGREo5R25sU1BEV2RnRjBwUnZZ?=
 =?utf-8?B?LzZnZ0xXcmo1SDV6RkJmOUI1Qnhoejk4aFBuN3BoVUJ5OFd1a21WWkhkbEtM?=
 =?utf-8?B?ZGY4aXZ4dVQwVnRmdVhWUnl4S1J3bHExYWxwRENYVTVrVXRyai9ad04vOWJs?=
 =?utf-8?Q?rZKo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1bf11c-06ac-402f-b51f-08dab8288f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 14:35:56.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYrHFh3Obm0wduGdv6Arpk554Q4lyW5VcLRN5NMceOog4cNXM50yi06IDYdmaZeDxIgfbnkLQzDDfLc4eklqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2h1bnN1a2UgTWllIDxt
aWVAaWdlbC5jby5qcD4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI2LCAyMDIyIDg6NDMg
UE0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiBDYzogTWFuaXZhbm5hbiBT
YWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz47IEpvbg0KPiBNYXNv
biA8amRtYXNvbkBrdWR6dS51cz47IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPjsg
QWxsZW4NCj4gSHViYmUgPGFsbGVuYmhAZ21haWwuY29tPjsgS2lzaG9uIFZpamF5IEFicmFoYW0g
SSA8a2lzaG9uQHRpLmNvbT47DQo+IExvcmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNpQGtlcm5l
bC5vcmc+OyBLcnp5c3p0b2YgV2lsY3p5xYRza2kNCj4gPGt3QGxpbnV4LmNvbT47IEJqb3JuIEhl
bGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Ow0KPiBudGJAbGlzdHMubGludXguZGV2OyBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYyXSBQQ0k6IGVuZHBvaW50OiBwY2ktZXBmLXss
dn1udGI6IGZpeCBhIGNoZWNrIGZvcg0KPiBubyBlcGMgYWxpZ25tZW50IGNvbnN0cmFpbnQNCj4g
DQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gSGkgRnJhbmssDQo+IA0KPiAyMDIy5bm0MTDm
nIgyNuaXpSjmsLQpIDE6MDcgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Og0KPiA+DQo+ID4N
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1hbml2
YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+ID4g
PiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI1LCAyMDIyIDk6MjIgQU0NCj4gPiA+IFRvOiBTaHVu
c3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPg0KPiA+ID4gQ2M6IEpvbiBNYXNvbiA8amRtYXNvbkBr
dWR6dS51cz47IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPjsNCj4gPiA+IEFsbGVu
IEh1YmJlIDxhbGxlbmJoQGdtYWlsLmNvbT47IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkNCj4gPiA+
IDxraXNob25AdGkuY29tPjsgTG9yZW56byBQaWVyYWxpc2kgPGxwaWVyYWxpc2lAa2VybmVsLm9y
Zz47IEtyenlzenRvZg0KPiA+ID4gV2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT47IEJqb3JuIEhl
bGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+Ow0KPiA+ID4gbnRiQGxpc3RzLmxpbnV4LmRldjsg
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjJdIFBDSTogZW5kcG9pbnQ6IHBj
aS1lcGYteyx2fW50YjogZml4IGEgY2hlY2sgZm9yDQo+IG5vDQo+ID4gPiBlcGMgYWxpZ25tZW50
IGNvbnN0cmFpbnQNCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPiA+DQo+ID4g
PiBPbiBUaHUsIFNlcCAyMiwgMjAyMiBhdCAwNjoyMzo1N1BNICswOTAwLCBTaHVuc3VrZSBNaWUg
d3JvdGU6DQo+ID4gPiA+IFNvbWUgUENJIGVuZHBvaW50IGNvbnRyb2xsZXJzIGhhdmUgbm8gYWxp
Z25tZW50IGNvbnN0cmFpbnRzLCBhbmQgdGhlDQo+ID4gPiA+IGVwY19mZWF0dXJlcy0+YWxpZ24g
YmVjb21lcyAwLiBJbiB0aGlzIGNhc2UsIElTX0FMSUdORUQoKSBpbg0KPiA+DQo+ID4gW0ZyYW5r
IExpXSB3aHkgbm90IHNldCBlcGNfZmVhdHVyZXMtPmFsaWduIDENCj4gPiBubyBhbGlnbm1lbnQg
Y29uc3RyYWludHMgc2hvdWxkIG1lYW4gYWxpZ24gdG8gYnl0ZS4NCj4gSXQgaXMgb25lIG9mIHRo
ZSBzb2x1dGlvbnMgdG9vIEkgdGhpbmsuIEJ1dCBpbiB0aGF0IGNhc2UsICB3ZSBuZWVkIHRvDQo+
IHdyaXRlIGVwY19mZWF0dXJlcy0+YWxpZ24gPSAxIHRvIGFsbCBlcGMgZHJpdmVycywgZHdjLCBx
Y29tLCByY2FyLA0KPiB0ZWdyYSwgYW5kIGV0Yy4NCj4gDQo+IEkgdGhpbmsgdGhhdCBteSBjaGFu
Z2UgaXMgYmV0dGVyLg0KDQpJIHRoaW5rIGl0IHNob3VsZCBiZSBiYXNlZCBvbiB3aGF0IG9yaWdp
bmFsIHRlcm0gZGVmaW5lZC4gDQpJdCBzaG91bGQgYmUgZml4ZWQgYXQgd2hlcmUgbWFrZSBtaXN0
YWtlLiANCg0KQXJlIHRoZXJlIG90aGVyIHBsYWNlIHVzZSBhbGlnbiA9PSAwIG1lYW5zIG5vIGFs
aWdubWVudCBpbiBrZXJuZWw/IA0KDQo+IA0KPiA+ID4gPiBlcGZfbnRiX2NvbmZpZ19zcGFkX2Jh
cl9hbGxvYygpIGRvZXNuJ3Qgd29yayB3ZWxsLiBDaGVjayBmb3IgdGhpcw0KPiBiZWZvcmUNCj4g
PiA+ID4gSVNfQUxJR05FRCgpLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaHVu
c3VrZSBNaWUgPG1pZUBpZ2VsLmNvLmpwPg0KPiA+ID4NCj4gPiA+IFJldmlld2VkLWJ5OiBNYW5p
dmFubmFuIFNhZGhhc2l2YW0NCj4gPiA+IDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9y
Zz4NCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBNYW5pDQo+ID4gPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiA+ID4gKiBGaXggdGhlIGNvbW1pdCBtZXNzYWdl
IGluIHBocmFzaW5ncyBhbmQgd29yZHMuDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLW50Yi5jICB8IDIgKy0N
Cj4gPiA+ID4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYyB8
IDIgKy0NCj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZW5kcG9p
bnQvZnVuY3Rpb25zL3BjaS1lcGYtbnRiLmMNCj4gPiA+IGIvZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtbnRiLmMNCj4gPiA+ID4gaW5kZXggOWEwMDQ0OGM3ZTYxLi5mNzQx
NTVlZThkNzIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0
aW9ucy9wY2ktZXBmLW50Yi5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1
bmN0aW9ucy9wY2ktZXBmLW50Yi5jDQo+ID4gPiA+IEBAIC0xMDIxLDcgKzEwMjEsNyBAQCBzdGF0
aWMgaW50DQo+IGVwZl9udGJfY29uZmlnX3NwYWRfYmFyX2FsbG9jKHN0cnVjdA0KPiA+ID4gZXBm
X250YiAqbnRiLA0KPiA+ID4gPiAgICAgICBwZWVyX3NpemUgPSBwZWVyX2VwY19mZWF0dXJlcy0+
YmFyX2ZpeGVkX3NpemVbcGVlcl9iYXJub107DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgIC8qIENo
ZWNrIGlmIGVwY19mZWF0dXJlcyBpcyBwb3B1bGF0ZWQgaW5jb3JyZWN0bHkgKi8NCj4gPiA+ID4g
LSAgICAgaWYgKCghSVNfQUxJR05FRChzaXplLCBhbGlnbikpKQ0KPiA+ID4gPiArICAgICBpZiAo
YWxpZ24gJiYgKCFJU19BTElHTkVEKHNpemUsIGFsaWduKSkpDQo+ID4gPiA+ICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgIHNwYWRfY291bnQgPSBu
dGItPnNwYWRfY291bnQ7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9lbmRwb2lu
dC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gPiA+IGIvZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5jDQo+ID4gPiA+IGluZGV4IDBlYTg1ZTFkMjkyZS4uNWUz
NDZjMGEwZjA1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5j
dGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5jDQo+ID4gPiA+IEBAIC00MTgsNyArNDE4LDcgQEAgc3Rh
dGljIGludCBlcGZfbnRiX2NvbmZpZ19zcGFkX2Jhcl9hbGxvYyhzdHJ1Y3QNCj4gPiA+IGVwZl9u
dGIgKm50YikNCj4gPiA+ID4gICAgICAgc2l6ZSA9IGVwY19mZWF0dXJlcy0+YmFyX2ZpeGVkX3Np
emVbYmFybm9dOw0KPiA+ID4gPiAgICAgICBhbGlnbiA9IGVwY19mZWF0dXJlcy0+YWxpZ247DQo+
ID4gPiA+DQo+ID4gPiA+IC0gICAgIGlmICgoIUlTX0FMSUdORUQoc2l6ZSwgYWxpZ24pKSkNCj4g
PiA+ID4gKyAgICAgaWYgKGFsaWduICYmICFJU19BTElHTkVEKHNpemUsIGFsaWduKSkNCj4gPiA+
ID4gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAg
c3BhZF9jb3VudCA9IG50Yi0+c3BhZF9jb3VudDsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4xNy4x
DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+Cu
qeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCj4gDQo+IEJlc3QsDQo+IFNodW5zdWtlDQo=
