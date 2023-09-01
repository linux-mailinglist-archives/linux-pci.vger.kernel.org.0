Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FDE78F69D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 03:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348028AbjIABNV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 21:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbjIABNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 21:13:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2096.outbound.protection.outlook.com [40.107.113.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE0E67;
        Thu, 31 Aug 2023 18:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMqmRxfzMV8/Cj9TtXbFdQZVBUp979rFbztXyCEbtLLvmWC0U2KuDeEFHkRNTwMJxsvBiF5kCuyfIEthOarY/xAgZyMak4R7M8SLKhxk/UeaGR8M0HQ9Q0GlIKpZHmeBhkBrf86rB/u1r6KIYHUzAQ9F0vlzcA2RYMUx1ibBgiWACZ/cbqfK49AF/z5RfD3z9LWWgsTsDoA+F+ZhSipIC5iGe9QHkRTkBwxtBaTubnq3OYE3FtDzTfFJzzxjvH8Y8pbZS+0kq0CNYeDnCxN1gWnZUp/TbgVDRw7FVGLlZLLkUgWh8It2MwfTg+/CqFty6xeRvsULYY/j6Yc7msnJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeYBVnFEwHhJCIakiGi1BfBGlXJazvayapL+GiHOGzQ=;
 b=ZaBq396Vs1LXsxAxPJpV9v98yixHjshLIRKMpMhtiPK0Zyn8mTlU65LH8Xe1OBVGWVsAohbwucyXApkR3uPObeJbzVTbbMNDfcKGzI2RwZAAhLvAHGfYq0w5mw4SbEK0rzf6IwWOBwi4kA2qmB19rrx83/9yS8svnxYyELmVER622BBpefl9g5T7ZAi7dvkdus4YhPRlxXGZYS8ItDx+mBWdbeR/QB+25J3av38dcGdDvwlGhiR2TkRuAOv6m8gf3NWANrIUnuWtyo2k+vtzXTF8N534Da04I6SbZMk6ys7W8kWfzueuHwYD2FYYR1xf0LnTss2h8XLEIS2PQhDMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeYBVnFEwHhJCIakiGi1BfBGlXJazvayapL+GiHOGzQ=;
 b=F7Wbyn1GyShWlLDNH7XbujUiEr5VlwJG0GIa3RYI0+oJx6freQ6KUMgK4ePX58UKQlkpMW/xVwy60gsU5W52Dw/PDjW/D3lWZQ6HniJhh1TBIZfD26TKgsHhfzANxTME2TAiGrL9iIqDp7si1OB0CwArbfuWqounxuOxatp+QBA=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB8646.jpnprd01.prod.outlook.com
 (2603:1096:604:188::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 01:13:12 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6745.022; Fri, 1 Sep 2023
 01:13:12 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: RE: [PATCH v20 15/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Topic: [PATCH v20 15/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Index: AQHZ1zcP3wgZtbwx8k6MVXo7DrjVcbAEbEuAgADGgGA=
Date:   Fri, 1 Sep 2023 01:13:12 +0000
Message-ID: <TYBPR01MB5341A5BC7490E5835E309025D8E4A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
 <20230825093219.2685912-16-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdV5NEJFSmL6Ey6TwSaaX4Mj5k3C9_UP0psyijeaLVCEPw@mail.gmail.com>
In-Reply-To: <CAMuHMdV5NEJFSmL6Ey6TwSaaX4Mj5k3C9_UP0psyijeaLVCEPw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSZPR01MB8646:EE_
x-ms-office365-filtering-correlation-id: 798a58c8-ab06-42ec-ab29-08dbaa889cdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YMGI6G/qsasr9Z/oL/wfzBqtr6xvkWjxHpqgOs6Tjq9nf5myyxnczAwTFqgT6eILbJq3oFoOq2nSF1IiR8VXSFvqyVNwGFy2v4AL+FH9WIBOxITMtT+aMIYUraIJSL/7uKYoHLOAtkW8h50OrbPVCLJ17BaGUybZ2H5kjTTBvKWQaGE/sAyxUH5jS/zR+CgCUBOO48LFb0BLVQshJiAWXYYSJf7uqncR9WWG28F9oQK7vi70KWktQX9AbOskMXpPb+bG1dsLqZV6t/S+nOY4ym+wd/cF1ZHLl/cGDN09UKh9kpOTYTOxW1PbxvnvBJis4EyxNY9T2FtOx5P7nNGgBM6x5EYU8cGMn/zWnDasHrly7Ifs0InKuKOZOLlNW3467E3kNAjoPaI4QubEeHsoLMfBDiIOl6EYzVa3NKoCEAGogfFCDGz0j0oFtXf2NsuwYz2Njuw1+i+lIwYzRBlrfxZlWEVG+OMMsA+b8lgu3CR6zHUp85rhK3abK3RitXkCcmYpt+0zt8WcvDPsV9uyrjjUI1QRo90q42tU365VvMhEP9aw9LejYDGpKWOqvP5tR9eAjKQ1GnhEVWYOzmAZTICuexXxU7FRqp3LJsHkZFS/P5teRbKO3BnPfDp53RZL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199024)(186009)(1800799009)(38100700002)(66556008)(38070700005)(54906003)(66476007)(64756008)(76116006)(66946007)(66446008)(9686003)(7416002)(122000001)(53546011)(83380400001)(316002)(6916009)(86362001)(7696005)(6506007)(2906002)(33656002)(41300700001)(478600001)(4326008)(8676002)(8936002)(71200400001)(5660300002)(52536014)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWpaVUs5dlB1cnFIQ0NTRlNrOXZPNUZwbzZoVXhDMy9uejJ0bHl0OVdVbE5s?=
 =?utf-8?B?SC94cm1CQVJvYW1QaHJNait2SXF5RDZQN0paOEtpUVdtTjBqVnJMUVJoQnlQ?=
 =?utf-8?B?MXR4ZzNNdmh1djg3VnZCeUxsNG41d0hXQzNETFYrRWZCQWZMMGZkVHpibGJC?=
 =?utf-8?B?blNYa1pIbnRHMnZrbWw0R21DZnpyMkpaM2xtaGlsbUw1MnoycTNvci9nWTJx?=
 =?utf-8?B?RnZXWDVzbXhEVStGNnl2MnJSaWVzbCtiOXVBWWNoMWNzaGdySW1DWC9RdGJJ?=
 =?utf-8?B?QXF5ZzE0a3J1eDZIb3AxOWcwV0tqRWdLTjcxWk1sWGI2d3ZPZ2xZVXMyNU9n?=
 =?utf-8?B?QW5CK0J1ZVg0TWlBc3drS2ZpU29laFBoT3RQMTVXS3ZyZEQ5N2VVNWZhd0M0?=
 =?utf-8?B?bVBRWEROeUJnU253UjZ1SU1odmhlWDZVTDZ2d0IrZnNwNVdTaVJXWkczOGF2?=
 =?utf-8?B?U0doNngvU0lrQ3hSY0RXREFxdUwyQjhnMk5XSC91Q0hoODV2UGx0b1h3SEZM?=
 =?utf-8?B?dk9ZdHZnRVZnVzIwZk5CYnNSNmRCUXRYdkV4clc5M2ZNY2theUV2b2M5NktC?=
 =?utf-8?B?UXVVazBObEdEbnpVV2FPazYvRytxVXovWkp4bTZWdlpqTytMeUdMbFlLY2t4?=
 =?utf-8?B?T2VwT2t4SU0yZGE2MDN3dDhXM1dtUjRCaSs5akdWSGptcGdEYzN3Y3Q4ZVdW?=
 =?utf-8?B?M05UWFlweTBqc0NNTnN3emkvL1hSREF3YVg1UGFOZlFVWUdma25ESEhibTdi?=
 =?utf-8?B?dkdFd1Q3bURaSzUxWlVITU01QkhoaUg3cTdqZ1NQS0wrNE9wbk0vRVRCU2JL?=
 =?utf-8?B?QXpNN1ZYWWZ6UkkyQVErMnF0UXUxK1FWdXhKcHN3ZlFHTG55eGxlaXkrRUJo?=
 =?utf-8?B?Q0NKUjIxcEorYllhSERQMGRLYmVNWmd0QWtQSHI2ZlJ6bHM1eGcweU44aWxR?=
 =?utf-8?B?ZDdLVFZWblRRQ0N0ajNsV3Zpd21qMzdnK3hQa09zaWJreDFiQXpKQXdPU2Er?=
 =?utf-8?B?RUhPa2R4SDVjUGhUZFhCRWp1VmloM1locDNnaWg2OG9CajRuS2ZwWEZHYTFP?=
 =?utf-8?B?eDB0MFhYcVpjTEdwd2ZSQi9ZV0ZTYmtST0lUUGt2VlVtdnVIZUN5RFdBQVE2?=
 =?utf-8?B?VFlTNDVlZmlCaUljV3RXejNFVEUxSEZVV0ZNcFVBZXZ6N0ZpekVTTGhBb09V?=
 =?utf-8?B?MTRwWXFXaVZ1R0t0bVY5aEMxWVladm9CajFWcG5rYXZkR1VVSlBianBPSjUy?=
 =?utf-8?B?NnRQWXY5NThtUHlTYnBicktnT3JoVEtTbjdESmVRU1hyc2dwYVUyN0czc3Mz?=
 =?utf-8?B?Nm5QckVsQTUwYUNpbmhQdk1vNzF2d1VmMW9WOVEvMEg5dVQ0citoL2VTNlgv?=
 =?utf-8?B?MFVpajZ2RVBDZC9VeHlNRisxL1ROTE1ZU2ZydHl2LysxYTdBY2lDNlpGNGdi?=
 =?utf-8?B?eFJMZnBFbjNuTTVsdEZaaHFxaDFNSUZ3a1E5V3lIajZISVRZaU15VWh2UkZM?=
 =?utf-8?B?cVFpWktORHhaaTk5VkdTZXBURk9jR3dBVENIbnp0TE84QXAyTHBxNjhzU28v?=
 =?utf-8?B?b0FteUd6M01uQmo0YmFJTW1nTVpqQk1nb0w2cVRvR09SYTNMUVA5ck56MFpV?=
 =?utf-8?B?RHdsN1dZUktaWXgxVlhUWU5Vb0VlNzVHL0o2L2FRVG8wQ2ttRis0RE02MnF3?=
 =?utf-8?B?dTVsTWpkVW1UZzJsWEh3blR0Z3lkalJNR21vWDVDbXJueUVPdGtxWjRtR1Fi?=
 =?utf-8?B?NmJ5QmVqOWxuZnBmL3NRWUxtUUlGTXBoNnNyTlpKQjNwU0Z5ZnJRdTIyVGth?=
 =?utf-8?B?cDNzWVpROHRuLzB4TmdYanZja1llWGVQT0R3NzBMZFZMSjc1aU1pV2QrR0Vi?=
 =?utf-8?B?ZTlSSng2TjZ6YkdRSVM3RXN6akk4aDc1MUw2bmc1U2kxdjYreEdRWGtvMUxB?=
 =?utf-8?B?enAwR1pNTWFSYUtwWWlpN09JSlhIUTRnNlJ4eldnb0pTbXNwRWYxTlU5QXds?=
 =?utf-8?B?bHNxNExTMHI5UEpNL0E0Y1V1ajdmdlkvRFl6bmFYUE9leXZGdzVWK0hhN2kx?=
 =?utf-8?B?MlpFYW5GclVFNXZPdE5uMHNhNkM4QXFSMWhNR1pnSmdQYlNodjZ2YXRWM21j?=
 =?utf-8?B?N1pSeVVCNTQ3b25vR09ObzRRL0JjM293akVyNUdwcFlHRXVaMHFoZG80VkJB?=
 =?utf-8?B?YTlZeUxQRm5pYVI3Y3RmeThoZVd5bGtSRTBnM0ZhZGR2OUx5OFFERi9EMTBj?=
 =?utf-8?B?ZmRWMnl5bE5qVUUyV3pZM2kzWUpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798a58c8-ab06-42ec-ab29-08dbaa889cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 01:13:12.6577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34ZyiyrkJXS6imiuH3PwODzH1mPPGUS045I68Syi9RoHW0EvWE+ccF6ZHe6GHURdPKv3t+gBVq9NLRt6zh3R/ZOZWpyOZmZE8v7eFQcj1y5e7DsKI+Aom4OZ/m0QkBNT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8646
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVGh1cnNk
YXksIEF1Z3VzdCAzMSwgMjAyMyAxMDoxNyBQTQ0KPiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0K
PiBPbiBGcmksIEF1ZyAyNSwgMjAyMyBhdCAzOjU34oCvUE0gWW9zaGloaXJvIFNoaW1vZGENCj4g
PHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBEb2N1bWVudCBi
aW5kaW5ncyBmb3IgUmVuZXNhcyBSLUNhciBHZW40IGFuZCBSLUNhciBTNC04IChSOEE3NzlGMCkN
Cj4gPiBQQ0llIGVuZHBvaW50IG1vZHVsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hp
aGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiBSZXZpZXdlZC1ieTog
U2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPg0KPiA+IEFja2VkLWJ5OiBNYW5p
dmFubmFuIFNhZGhhc2l2YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gDQo+IFRoYW5rcyBmb3IgeW91
ciBwYXRjaCENCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyENCg0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3JjYXIt
Z2VuNC1wY2ktZXAueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTA2IEBADQo+IA0KPiA+ICsgIHJlc2V0
czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+IA0KPiBNaXNzaW5nIHJlc2V0LW5hbWVzLCBjZnIu
DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvc25wcyxkdy1wY2llLWNv
bW1vbi55YW1sDQoNCk9vcHMhIEknbGwgYWRkIHJlc2V0LW5hbWVzLg0KDQo+ID4gK3JlcXVpcmVk
Og0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSByZWctbmFtZXMN
Cj4gPiArICAtIGludGVycnVwdHMNCj4gPiArICAtIHJlc2V0cw0KPiA+ICsgIC0gcG93ZXItZG9t
YWlucw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBjbG9jay1uYW1lcw0KPiANCj4gTWlzc2lu
ZyByZXNldC1uYW1lcy4NCg0KSSdsbCBhZGQgaXQuDQoNCj4gPiArDQo+ID4gK3VuZXZhbHVhdGVk
UHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+
ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL3I4YTc3OWYwLWNwZy1tc3NyLmg+DQo+
ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdp
Yy5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL3I4YTc3OWYwLXN5c2Mu
aD4NCj4gPiArDQo+ID4gKyAgICBzb2Mgew0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDI+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsNCj4gPiArICAgICAg
ICBwY2llMF9lcDogcGNpZS1lcEBlNjVkMDAwMCB7DQo+ID4gKyAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAicmVuZXNhcyxyOGE3NzlmMC1wY2llLWVwIiwgInJlbmVzYXMscmNhci1nZW40LXBjaWUt
ZXAiOw0KPiA+ICsgICAgICAgICAgICByZWcgPSA8MCAweGU2NWQwMDAwIDAgMHgyMDAwPiwgPDAg
MHhlNjVkMjgwMCAwIDB4MDgwMD4sDQo+IA0KPiA8MCAweGU2NWQyODAwIDAgMHgwODAwPiBkb2Vz
IG5vdCBtYXRjaCB5b3VyIERUUyBwYXRjaA0KPHNuaXAgVVJMPg0KDQpPb3BzLiBUaGlzIGV4YW1w
bGUgaXMgbm90IGNvcnJlY3QuIEknbGwgcmV2aXNlIGl0Lg0KDQo+IA0KPiA+ICsgICAgICAgICAg
ICAgICAgICA8MCAweGU2NWQzMDAwIDAgMHgyMDAwPiwgPDAgMHhlNjVkNTAwMCAwIDB4MTIwMD4s
DQo+ID4gKyAgICAgICAgICAgICAgICAgIDwwIDB4ZTY1ZDYyMDAgMCAweDBlMDA+LCA8MCAweGZl
MDAwMDAwIDAgMHg0MDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICByZWctbmFtZXMgPSAiZGJpIiwg
ImRiaTIiLCAiYXR1IiwgImRtYSIsICJhcHAiLCAiYWRkcl9zcGFjZSI7DQo+ID4gKyAgICAgICAg
ICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA0MTcgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSA0MTggSVJRX1RZUEVfTEVWRUxfSElH
SD4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSA0MjIgSVJRX1RZUEVf
TEVWRUxfSElHSD47DQo+IA0KPiBXaGF0IGFib3V0IFNQSSA0MTksIDQyMCwgNDIxPw0KDQpUaGVz
ZSBTUEkgaW50ZXJydXB0cyBjYW5ub3QgbWF0Y2ggdGhlIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvc25wcyxkdy1wY2llLnlhbWwuDQpBbHNvLCBJIGNhbm5vdCBkZXNjcmli
ZSB0aGUgZGV0YWlsIG9mIHRoZXNlIFNQSSBpbnRlcnJ1cHRzIGJlaGF2aW9yIGJlY2F1c2Ugb2Yg
dGhlIGRhdGFzaGVldA0KZG9lc24ndCBtZW50aW9uIHRoZSBkZXRhaWwuLi4gU28sIEkgZGlkbid0
IGRlc2NyaWJlIHRoZW0uDQoNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gImRt
YSIsICJzZnRfY2UiLCAiYXBwIjsNCj4gPiArICAgICAgICAgICAgY2xvY2tzID0gPCZjcGcgQ1BH
X01PRCA2MjQ+LCA8JnBjaWUwX2Nsa3JlZj47DQo+ID4gKyAgICAgICAgICAgIGNsb2NrLW5hbWVz
ID0gImNvcmUiLCAicmVmIjsNCj4gPiArICAgICAgICAgICAgcG93ZXItZG9tYWlucyA9IDwmc3lz
YyBSOEE3NzlGMF9QRF9BTFdBWVNfT04+Ow0KPiA+ICsgICAgICAgICAgICByZXNldHMgPSA8JmNw
ZyA2MjQ+Ow0KPiA+ICsgICAgICAgICAgICBudW0tbGFuZXMgPSA8Mj47DQo+ID4gKyAgICAgICAg
ICAgIG1heC1saW5rLXNwZWVkID0gPDQ+Ow0KPiA+ICsgICAgICAgICAgICBtYXgtZnVuY3Rpb25z
ID0gL2JpdHMvIDggPDI+Ow0KPiA+ICsgICAgICAgIH07DQo+ID4gKyAgICB9Ow0KPiANCj4gQlRX
LCBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8gbWFrZSB0aGUgb3JkZXIgb2YgdGhlIHByb3Bl
cnRpZXMgYW5kDQo+IGluIHRoZSBleGFtcGxlIG1hdGNoIGJldHdlZW4gdGhlIGhvc3QgYW5kIGVu
ZHBvaW50IGJpbmRpbmdzLCB0byBtYWtlDQo+IHRoZSBvdXRwdXQgb2YNCj4gImRpZmYgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9yY2FyLWdlbjQtcGNpLXtob3N0LGVwfS55
YW1sIg0KPiBhcyBzbWFsbCBhcyBwb3NzaWJsZS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHN1Z2dl
c3Rpb24hIEknbGwgcmV2aXNlIHRoZSBkdC1iaW5kaW5ncyBkb2MuDQoNCkJlc3QgcmVnYXJkcywN
Cllvc2hpaGlybyBTaGltb2RhDQoNCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0t
IFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9y
Zw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUs
IEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJu
YWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
