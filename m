Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427F6764334
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 03:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjG0BGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 21:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG0BGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 21:06:07 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2094.outbound.protection.outlook.com [40.107.113.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883C2706;
        Wed, 26 Jul 2023 18:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgHo5fXf2+7ZwlWxjs4txz824327Pr+CX+laoM7MtzNmdgppb56G4LMhdC7/j7GsnT6tObsUVpLqWy95wi/0kKolA7y0pEgRGGIK1bvtG7H0BWwdW64+xB+xsd95/VaI/AtIyOJgM6+V30+Zg4fD5Tszd0qdeuxg7dBzlgf+rQ8kao9I2ruaul+oyXn5Caut/qZbvXj0lRx4/I4xuXeaPatO+9bBq3zCfhqgyeuJpLQ+rHVYE+PVJyBtSDfq3Zs5qfWX5DnoWlGSdNrnRwqgMcnKPt1OSHqg4DSiccRYPiIXiM4ropqV6dnY0lcUXopR2Pp/AxBzKAqCy7xbTlxfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeCg7mg+UMA3CuYJtXUJR724okbqSQnp6QWFlFiYSYk=;
 b=VIEtd1lmR1WZveVjQ2lwcD2rbeCoJ8Mlxjssumx6qQ03ILtZxudVvQ7YwuRm9AVgjdMy2UKyIhVR4ZYeGn3tiuHRrvRifI+mQX4rf2g7b6MYcd92bIY7OuK5u6CWYnEI23tDzRTFjlYAY4lUuD7uYj7uAIpLzIKJL+8stOlItaqHzDLM4NXHTpAPqFNR9CvXSMs76qzdCx3VZqHcnlAUUecO4sT++olp4K4ThIh2GnjMddVLU0BeqjwGPweF+F3ZERp4ODY7+oM0lRWuV8FT3G5GjV4nloQ1IEauv0G6UqAXfow5ijHRMNeEpAnu9aTESPbGpZKj74l5eH5ebNNGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeCg7mg+UMA3CuYJtXUJR724okbqSQnp6QWFlFiYSYk=;
 b=o9PV1YVRXjp+xEYnHixb6fQcx/LfdyeSnoBtSqRfqI2QMd6JQmsLIvzGmA+yHCz3zC7g7FumYclQ5KhFWEH+C2QoO7D46Id+NZyJoaNEsXTMmvyebln0Qtwkoysv/fC+uffvPCAmZPjyuBYAREj8kciydVQALRK0msBLjw9ULiI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB9959.jpnprd01.prod.outlook.com
 (2603:1096:400:1d7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 01:06:00 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 01:06:00 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Topic: [PATCH v18 04/20] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Thread-Index: AQHZu6dDb7hFhSogz0udklVWjO2cJ6/IjnMAgAL2+QCAAIWDgIAAsmMAgAAQXrA=
Date:   Thu, 27 Jul 2023 01:06:00 +0000
Message-ID: <TYBPR01MB5341407DC508F0B390B84090D801A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-5-yoshihiro.shimoda.uh@renesas.com>
 <20230724074556.GC6291@thinkpad>
 <ezuyypjmhkb4nsruy5kdoopg537yqg2paf4acgfyib6p7kj7g5@kumpnp2cr4zh>
 <20230726130015.GA5633@thinkpad>
 <aldqqozyrjdd74jdm2xmgp53rpke4otm6iy4tjfemdwxd4ir5y@p3dlr3p5c7t4>
In-Reply-To: <aldqqozyrjdd74jdm2xmgp53rpke4otm6iy4tjfemdwxd4ir5y@p3dlr3p5c7t4>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB9959:EE_
x-ms-office365-filtering-correlation-id: 20e74f73-1cfd-499e-16ec-08db8e3da46e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rBZ8W+nuDWIxepOEN1RohekjNRY5CjyE81sGP1UZcHe69j2OCDb9bacFQcrv2mq3iJzf9rDriuXOCycJ746hwjYpp6oxoHZuNoLpIoAkil89lOujDc8+/Ef2r9QMUMO62TVbekPjvIEWaXH+SI1Co+LQbKU1MXJ3CHZkFchroTgxPrMtEua9j8CwxnMgLBTJ5jaZFXLu+gDMk669Xd3EycMEjIBBULGkA3XGesyD22NEnz8TMjgpOfAsSbVnXMYx7nytqlJoKYjiodvuLU+2yjb5aMn/iimK8x+hk4HeXxgMjCRafGZGAUEK1mwuBPY5AcR3u4n6l9H20C3EqIGoIT3J9bH9Z9PvJQ6sIgPErOu9T5jdzG10ka2WBhBpIyxh1KmK+dCjWXg5uuoXR8njG8Kyxxo/Xx7867lmqmcM3rqVhjVQmZKnoQa/qqeWKhWOnaDoiMNgEc6rQ37dahBGYMARJuGMPzIKkvlMMZQJLE1NFLjNn5sYB28azgKPtylptpWYN3Pxb0r+vnYZUn5TDZwS9z/HlyuYosnDS2KQnTlB5k3sGM6OQVZCS8gvEUIuJQnKEqAby+M1IwXIlBhFAApFmXsyuUwLtODGkGiI4sksztEwqo1D1ShGVxjGiJeIeqqwJgdTNmI7kZwH5QhEpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(38070700005)(86362001)(122000001)(33656002)(55016003)(2906002)(110136005)(478600001)(54906003)(38100700002)(186003)(6506007)(71200400001)(41300700001)(52536014)(5660300002)(966005)(7696005)(9686003)(7416002)(76116006)(8676002)(66446008)(64756008)(316002)(66946007)(66556008)(83380400001)(4326008)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVOK1NKa1NEVENnTjZXNlFGR0toak01aHVsQkhoY0VPdlhIeUlIRkZoWEtl?=
 =?utf-8?B?R212U1ZSUXd1eFJuU3I5NnJ3OGRtWGtOcEcrRmFmajRTWE5pZ1RtVUhkWXhD?=
 =?utf-8?B?SENMdTNLMnBIditaNjhBbXloM2FmMFlSdVh0UWNtZWRhSk9TVVVVVzVuMWJK?=
 =?utf-8?B?MzdFWld3bzlaUUNhT2J6Tk5CYkdTNDVUUVRpcll5U2NzeS9YWEZwa21BaDBJ?=
 =?utf-8?B?WUdManhUMjArcDFBRlBVa2pHQnFia1krRkNpT0dZMTVoYW9pYUdPZ2tQVEs5?=
 =?utf-8?B?R2MvcFd6dndzbEZ0RDAraThDY3VwQkhHM2piaFgwZmh1djMrWmEzMzIrRXRT?=
 =?utf-8?B?MFhQR1JJY0VKb2VNT1VpMUs5N1RKcXVNNThDb0Nua296RjZLYXRUM2NmekpH?=
 =?utf-8?B?RmQyNVo1ZXZBdGdyY3lrdnNTMUJieXZBbnpHREtWQlNFeGlLWTdKWVVGK2lN?=
 =?utf-8?B?c3d6bnJHdng0NXNKZG5BYmpGVTdSY3VJOWVhekhZQmNQR3NIcklTSEM4SjFZ?=
 =?utf-8?B?emRLUERnS28vM0dNczhjT0dwZEZKcVNNQ1BpSm9vODNXeDZjYzFNNjhIVVZP?=
 =?utf-8?B?bHV0OWZJV1B2NHI5WFVCdHNBMU8vbFdDcFF0TEFwemV0UysrQVpTNm9RQjRt?=
 =?utf-8?B?dzk0ZFpza0JFZndQOFVFWXJKaVV4RUVobkFxai9hWU5GcjdkY2N3VmwwUkQw?=
 =?utf-8?B?OGdjRnJjQzJQbTZ2b1dBV21CcG5xYlRHcnlmYWxjSFZxWVlKT0tzTXdJVVIy?=
 =?utf-8?B?TC9uTlVRckE2dldjRnhoT3hyL3hDTnJPbThjWHlqcTR6TXo4cFZUTnFybFYv?=
 =?utf-8?B?UWJQTm9Rd04wNmNIL3Jialg5OEt6Vi9DS092aHBqTHM5V2hrdUdRL09saVU3?=
 =?utf-8?B?OTYwd1dNbTZjekNwZG9pN3NFODE3RFJNa3hiNnVJVEM4SjZPRVcxazZHeGtX?=
 =?utf-8?B?WnNmYk1LZlNhN0JsL0QrZFEyNVBYTFE3K2Rvb1ExRmlxK0JnamgzSFhRQXpi?=
 =?utf-8?B?RjFLVDNSU2FWdlFNRjYwRm0zVy9zMUFvR0UzT2VJZUp6WlRtUU1xZGkveFFL?=
 =?utf-8?B?QmRYQzIzc1FDbG4zSzY4eGo2Q2JpWlQ0WlM4aDlzWkhtYm1lYVphTTZ5Qitv?=
 =?utf-8?B?Tk1UUkFKNUM5Tk00VjM1VXZZQjBKcGdaL3FzRERKK0NydllLdmN6WVdQdk9E?=
 =?utf-8?B?MHJpK2pmQ0VkVmtzR2F4T2JkcjloTlpMekUrd0FudjJ0cTgxdkI5dEsreVNI?=
 =?utf-8?B?dUV0ZTVLK0FkQTFvL3ArdHRNbDRud0tHc2lKRElTUWgxZkkyNEpkQU1NejM1?=
 =?utf-8?B?VklXMExyWXhpVGpJNFExc21GWTU1dGFnSVVOMEdQclpLY2xBdWIwK2Jybmxl?=
 =?utf-8?B?N1FkTWhuMlpmd2ExK3RSUXhqYWxwZGkzUU1GaXJFR2o5UzRtWFFQbjByaUlO?=
 =?utf-8?B?MllUTzk3V3JWNURFSUV1NVdCVjFhMHJWaHp6SHIzWmp6bk5vQi9EMWNDcXpZ?=
 =?utf-8?B?aWdpOFVzQW0zZ01WUFFDL2JTelVpTXdnWHdFK0xDdmE2WkFSbk1PeUxmVkNB?=
 =?utf-8?B?MTRhRUZ1NEp4WWNlb2NNUEJKYS9DNVoxZ1RIdldLYmpNRGNoUUtaVjBhWW1E?=
 =?utf-8?B?MEFqd24xSUZLZnFLMjF6SnI1V2NpWWxXNzI0TWkzNll3eFVGTzJZTmdIcWJR?=
 =?utf-8?B?NnM0amp1dlpvNTlhTUg5Q3c0Q1laRjBxWWY0TkdldlVxM1kyMVlHMWMyL2ll?=
 =?utf-8?B?Y1pFd2ZDQUhiaERZOHZsS3k2MklVMWpHSlU0NFBEejJGVlBUWS81YUVyYmxV?=
 =?utf-8?B?VWJGaUtXYU9pRmVyNzRDK3lUZEFRWUpnRFRsZU11Z0dvOWZCcWhmencyTXMx?=
 =?utf-8?B?bE95WWNXdGdvRGJIc2tvOG12VnpvTlJBNTY2bHRWVThmVG94VWNua0lSWWta?=
 =?utf-8?B?T05rQ2syNmpBcG53anU0TnhMZ21FeUNWdWh1eEVHeU1oaGhLaVppOU9QdVpn?=
 =?utf-8?B?LzZGMlFCOVROMEZUMS90S1Z4bWp3K1g2andkUGxteERBL0s2RjNuSmY0bHB3?=
 =?utf-8?B?OSt2NE82WDNtYWIrQkg2cERyMnZrdlNFQW9xVnl0VE5wTlpyQlpLeWd5QVBs?=
 =?utf-8?B?V0tXZSs2ZzI4eENHa1IyZU5hR0VESGFFOWdTdW1oMzVnNEdIZFc2Y1VMcW1M?=
 =?utf-8?B?anBRQ1c5WTU0NzFjaUgxQjNURmQ5dWY1UjZIK2pmVlhYMlRCNkhqOWk4dEhT?=
 =?utf-8?B?cnFTWE51ZUZ5eXZvNXpEb3dNdFpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e74f73-1cfd-499e-16ec-08db8e3da46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 01:06:00.5303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/d0VDRq6qNxGJm0uxiG0r4fdq0tkG0Q61VQ38yr718bm8w2TWkOF+Us3d9JkBbxD89IVUId2lUvgpBYJNC+FAa/aNFlBBkCUeNiQLrr4OQMnrgDv26CwJw+XJhXNY2h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9959
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI3
LCAyMDIzIDg6MzkgQU0NCj4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMDY6MzA6MTVQTSArMDUz
MCwgTWFuaXZhbm5hbiBTYWRoYXNpdmFtIHdyb3RlOg0KPiA+IE9uIFdlZCwgSnVsIDI2LCAyMDIz
IGF0IDA4OjAyOjI0QU0gKzAzMDAsIFNlcmdlIFNlbWluIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBK
dWwgMjQsIDIwMjMgYXQgMDE6MTU6NTZQTSArMDUzMCwgTWFuaXZhbm5hbiBTYWRoYXNpdmFtIHdy
b3RlOg0KPiA+ID4gPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBhdCAwNDo0NDozNlBNICswOTAwLCBZ
b3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiA+ID4gPiBUaGUgX19kd19wY2llX3Byb2dfb3V0
Ym91bmRfYXR1KCkgY3VycmVudGx5IGhhcyA2IGFyZ3VtZW50cy4NCj4gPiA+ID4gPiBUbyBzdXBw
b3J0IElOVHggSVJRcyBpbiB0aGUgZnV0dXJlLCBpdCByZXF1aXJlcyBhbiBhZGRpdGlvbmFsIDIN
Cj4gPiA+ID4gPiBhcmd1bWVudHMuIEZvciBpbXByb3ZlZCBjb2RlIHJlYWRhYmlsaXR5LCBpbnRy
b2R1Y2UgdGhlIHN0cnVjdA0KPiA+ID4gPiA+IGR3X3BjaWVfb2JfYXR1X2NmZyBhbmQgdXBkYXRl
IHRoZSBhcmd1bWVudHMgb2YNCj4gPiA+ID4gPiBkd19wY2llX3Byb2dfb3V0Ym91bmRfYXR1KCku
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBDb25zZXF1ZW50bHksIHJlbW92ZSBfX2R3X3BjaWVfcHJv
Z19vdXRib3VuZF9hdHUoKSBhbmQNCj4gPiA+ID4gPiBkd19wY2llX3Byb2dfZXBfb3V0Ym91bmRf
YXR1KCkgYmVjYXVzZSB0aGVyZSBpcyBubyBsb25nZXINCj4gPiA+ID4gPiBhIG5lZWQuDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBObyBiZWhhdmlvciBjaGFuZ2VzLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVo
QHJlbmVzYXMuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBPbmUgbml0IGJlbG93LiBXaXRoIHRoYXQs
DQo+ID4gPiA+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1h
bml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiA+ID4gPg0KPiA+ID4gPiA+IFJldmll
d2VkLWJ5OiBTZXJnZSBTZW1pbiA8ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+DQo+ID4gPiA+ID4g
LS0tDQo+ID4gPiA+ID4gIC4uLi9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVw
LmMgICB8IDIxICsrKysrLS0tDQo+ID4gPiA+ID4gIC4uLi9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLWhvc3QuYyB8IDUyICsrKysrKysrKysrKystLS0tLS0NCj4gPiA+ID4gPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgIHwgNDkgKysrKysr
LS0tLS0tLS0tLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLmggIHwgMTUgKysrKy0tDQo+ID4gPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNzcg
aW5zZXJ0aW9ucygrKSwgNjAgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gWy4uLl0NCj4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ID4gPiA+IGluZGV4IDNjMDZlMDI1YzkwNS4uODVkZTBk
ODM0NmZhIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiA+ID4gPiBAQCAtMjg4LDYgKzI4OCwxNSBAQCBl
bnVtIGR3X3BjaWVfY29yZV9yc3Qgew0KPiA+ID4gPiA+ICAJRFdfUENJRV9OVU1fQ09SRV9SU1RT
DQo+ID4gPiA+ID4gIH07DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArc3RydWN0IGR3X3BjaWVfb2Jf
YXR1X2NmZyB7DQo+ID4gPiA+ID4gKwlpbnQgaW5kZXg7DQo+ID4gPiA+ID4gKwlpbnQgdHlwZTsN
Cj4gPiA+ID4gPiArCXU4IGZ1bmNfbm87DQo+ID4gPiA+ID4gKwl1NjQgY3B1X2FkZHI7DQo+ID4g
PiA+ID4gKwl1NjQgcGNpX2FkZHI7DQo+ID4gPiA+ID4gKwl1NjQgc2l6ZTsNCj4gPiA+ID4NCj4g
PiA+DQo+ID4gPiA+IFJlb3JkZXIgdGhlIG1lbWJlcnMgaW4gYmVsb3cgb3JkZXIgdG8gYXZvaWQg
aG9sZXM6DQo+ID4gPiA+DQo+ID4gPiA+IHU2NA0KPiA+ID4gPiBpbnQNCj4gPiA+ID4gdTgNCj4g
PiA+DQo+ID4gPiBPbmUgbW9yZSB0aW1lLiBZb3VyIHN1Z2dlc3Rpb24gd29uJ3QgcHJldmVudCB0
aGUgY29tcGlsZXIgZnJvbSBhZGRpbmcNCj4gPiA+IHRoZSBwYWRzLiAoSWYgYnkgImhvbGVzIiB5
b3UgbWVhbnQgdGhlIHBhZGRpbmcuIE90aGVyd2lzZSBwbGVhc2UNCj4gPiA+IGVsYWJvcmF0ZSB3
aGF0IHlvdSBtZWFudD8pLg0KPiA+DQo+ID4gU3RydWN0IHBhZGRpbmcgaXMgb2Z0ZW4gcmVmZXJy
ZWQgYXMgc3RydWN0IGhvbGVzLiBTbyB5ZXMsIEknbSByZWZlcnJpbmcgdGhlDQo+ID4gc2FtZS4N
Cj4gPg0KPiA+ID4gVGhlIHN0cnVjdHVyZSB3aWxsIGhhdmUgdGhlIHNhbWUgc2l6ZSBvZg0KPiA+
ID4gNDAgYnl0ZXMgaW4gYm90aCBjYXNlcy4gU28geW91ciBzdWdnZXN0aW9uIHdpbGwganVzdCB3
b3JzZW4gdGhlDQo+ID4gPiBzdHJ1Y3R1cmUgcmVhZGFiaWxpdHkgZnJvbSBoYXZpbmcgYSBtb3Jl
IG5hdHVyYWwgcGFyYW1ldGVycyBvcmRlciAoTVcNCj4gPiA+IGluZGV4LCB0eXBlLCBmdW5jdGlv
biwgYW5kIHRoZW4gdGhlIG1hcHBpbmcgcGFyYW1ldGVycykgdG8gYSByZWR1bmRhbnQNCj4gPiA+
IHR5cGUtYmFzZWQgb3JkZXIuDQo+ID4gPg0KPiA+DQo+IA0KPiA+IFRoaXMgaXMgYSBjb21tb24g
Y29tbWVudCBJIHByb3ZpZGUgZm9yIGFsbCBzdHJ1Y3R1cmVzLiBFdmVuIHRob3VnaCB0aGUgY3Vy
cmVudA0KPiA+IHJlc3VsdCAocmVvcmRlcmluZykgZG9lc24ndCBzYXZlIGFueSBzcGFjZSwgd2hl
biB0aGUgc3RydWN0dXJlIGdyb3dzIGJpZyAod2hvDQo+ID4ga25vd3MpLCB3ZSBvZnRlbiBzZWUg
bW9yZSBob2xlcy9wYWRkaW5nIGJlaW5nIGluc2VydGVkIGJ5IHRoZSBjb21waWxlciBpZiB0aGUN
Cj4gPiBtZW1iZXJzIGFyZSBub3Qgb3JkZXJlZCBpbiB0aGUgZGVzY2VuZGluZyBvcmRlciB3LnIu
dCB0aGVpciBzaXplLg0KPiA+DQo+ID4gSSBhZ3JlZSB0aGF0IGl0IG1ha2VzIG1vcmUgY2xlYXIg
aWYgdGhlIG1lbWJlcnMgYXJlIGdyb3VwZWQgYmFzZWQgb24gdGhlaXINCj4gPiBmdW5jdGlvbiBl
dGMuLi4gYnV0IGZvciBsYXJnZSBzdHJ1Y3R1cmVzIHRoaXMgd291bGQgb2Z0ZW4gYWRkIG1vcmUg
cGFkZGluZy9ob2xlLg0KPiANCj4gVGhpcyBzdHJ1Y3R1cmUgd2lsbCBuZXZlciBiZSBiaWcgZW5v
dWdoIHRvIGJlIGNvbnNpZGVyZWQgZm9yIHN1Y2gNCj4gc3RyYW5nZSBvcHRpbWl6YXRpb24uIE1v
cmVvdmVyIHByYWN0aWNhbGl0eSBhbG1vc3QgYWx3YXlzIGJlYXRzIHNvbWUNCj4gdGhlb3JldGlj
YWwgY29uc2lkZXJhdGlvbnMuIEluIHRoaXMgY2FzZSB0aGVyZSBpcyBubyBhbnkgcmVhc29uIHRv
DQo+IHJlb3JkZXIgdGhlIGZpZWxkcyBhcyB5b3Ugc2F5Lg0KPiANCj4gU3BlYWtpbmcgaW4gZ2Vu
ZXJhbCBJIHZlcnkgbXVjaCBkb3VidCB0aGF0IHNhdmluZyBhIGZldyBieXRlcyBvZg0KPiBtZW1v
cnkgY2FuIGJlIGNvbnNpZGVyZWQgYXMgYSBiZXR0ZXIgb3B0aW9uIHRoYW4gaGF2aW5nIGEgbW9y
ZQ0KPiByZWFkYWJsZSBzdHJ1Y3R1cmUgZXNwZWNpYWxseSB0aGVzZSBkYXlzLiBNb3Jlb3ZlciBm
b3IgYWxsIHRoZXNlIHllYXJzDQo+IEkgbmV2ZXIgbWV0IGFueWJvZHkgYXNraW5nIHRvIHNldCB0
aGUgZGVzY2VuZGluZyBvcmRlciBvZg0KPiB0aGUgbWVtYmVycyBvciBtYWludGFpbmluZyBzdWNo
IGxpbWl0YXRpb24gaW4gdGhlIGNvbW1vbmx5IHVzZWQga2VybmVsDQo+IHN0cnVjdHVyZXMuIFdo
YXQgaXMgbm9ybWFsbHkgZG9uZToNCj4gMS4gTW92ZSBhbiBlbWJlZGRlZCBvYmplY3QgdG8gdGhl
IGhlYWQgb2YgdGhlIHN0cnVjdHVyZSBmb3IgdGhlDQo+IGNvbnRhaW5lcl9vZi1tYWNybyBvcHRp
bWl6YXRpb24uDQo+IDIuIEdyb3VwIHVwIHRoZSBjb21tb25seSB1c2VkIGZpZWxkcyB0byBvcHRp
bWl6ZSB0aGUgc3lzdGVtIGNhY2hlDQo+IHV0aWxpemF0aW9uLg0KPiAzLiBMb2dpY2FsIGdyb3Vw
aW5nIHRoZSBtZW1iZXJzLCB3aGljaCBuYXR1cmFsbHkgbWF5IGxlYWQgdG8gdGhlIG1vcmUNCj4g
b3B0aW1hbCBjYWNoZSB1dGlsaXphdGlvbi4NCj4gNC4gTW92ZSBhIGZpZWxkIHRvIGEgY2VydGFp
biBwbGFjZSBvZiB0aGUgc3RydWN0dXJlIHRvIGZpbGwgaW4gdGhlDQo+IHBhZHMuDQo+IA0KPiBF
dmVuIGlmIHRoZSAiZGVzY2VuZGluZyBhbGlnbm1lbnQiIHJlcXVpcmVtZW50IG1pbmltaXplcyB0
aGUgbnVtYmVyIG9mDQo+IHRoZSBwYWRzIGl0IGlzbid0IHRoZSBvbmx5IHBvc3NpYmxlIHdheSB0
byBkbyBzbyBpbiB0aGUgcGFydGljdWxhcg0KPiBjYXNlcyBhbmQgaXQgbG9va3MgdG9vIGhhcnNo
IHRvIGJlIGJsaW5kbHkgYXBwbGllZCBhbGwgdGhlIHRpbWUuIElmIGENCj4gZmV3IGJ5dGVzIGlz
IHNvIGltcG9ydGFudCB3aHkgbm90IGRvIHRoZSBzYW1lIGZvciBpbnN0YW5jZSBmb3IgdGhlDQo+
IGxvY2FsIHZhcmlhYmxlcyB0b28/IFRoZXkgYXJlIGFsc28gbm9ybWFsbHkgc2l6ZS1hbGlnbmVk
IGluIHRoZSBzdGFjaw0KPiBtZW1vcnksIHdoaWNoIGlzIG11Y2ggbW9yZSBwcmVjaW91cyBpbiBr
ZXJuZWwuDQoNCkkgZm91bmQgc29tZSBwYXRjaGVzIHRvIHNhdmUgbWVtb3J5IGJ5IGF2b2lkaW5n
IHBhZGRpbmcvaG9sZSBpbiAyMDIzOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ODZjNmJiMGVkZmZh
OWZjMDJiNGUzODAxYjQ4YzhlODIxMTRmMTM1Mg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9NDhjZDZi
YzViMjJkNjhiOGJiYzg2MDFmM2M3ZGRlZWQ5OTU0MWEwYg0KDQo+IEFueXdheSBpbiB0aGlzIGNh
c2UgY2hhbmdpbmcgdGhlIGZpZWxkcyBvcmRlciBpcyBhYnNvbHV0ZWx5IHJlZHVuZGFudC4NCj4g
RXZlbiBhIHByb3ZpZGVkIGFmdGVyd2FyZHMgdXBkYXRlIGRvZXNuJ3QgY2F1c2UgdGhlIHN0cnVj
dHVyZSBzaXplDQo+IGNoYW5nZS4gU28gZm9yIHRoZSBzYWtlIG9mIHJlYWRhYmlsaXR5IGl0J3Mg
YmV0dGVyIHRvIGxlYXZlIGl0cyBmaWVsZHMNCj4gb3JkZXJlZCBhcyBpcy4NCg0KSSBzaG91bGQg
aGF2ZSBhc2tlZCB5b3UgYmVmb3JlIHlvdSBzdWdnZXN0ZWQgdGhpcyBvcmRlcmluZyBbMV0sIGJ1
dA0KSSBkb24ndCBrbm93IHdoeSB0aGUgY3VycmVudCBvcmRlcmluZyBpcyBnb29kIHJlYWRhYmls
aXR5Lg0KDQotLS0tLQ0Kc3RydWN0IGR3X3BjaWVfb2JfYXR1X2NmZyB7DQogICAgICAgIGludCBp
bmRleDsNCiAgICAgICAgaW50IHR5cGU7DQogICAgICAgIHU4IGZ1bmNfbm87DQogICAgICAgIHU2
NCBjcHVfYWRkcjsNCiAgICAgICAgdTY0IHBjaV9hZGRyOw0KICAgICAgICB1NjQgc2l6ZTsNCn07
DQotLS0tLQ0KDQpUaGUgb3JkZXJpbmcgb2Ygc3RydWN0IGR3X3BjaWVfb2JfYXR1X2NmZyBzZWVt
cyB0byByZWxhdGVkIHRvIHRoZSBhcmd1bWVudHMNCm9mIG9yaWdpbmFsIGZ1bmN0aW9ucyB3aGlj
aCBhcmUgZHdfcGNpZV9wcm9nX3tlcH1fb3V0Ym91bmRfYXR1KCkuDQoNCi0tLS0tDQppbnQgZHdf
cGNpZV9wcm9nX291dGJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNpZSAqcGNpLCBpbnQgaW5kZXgsIGlu
dCB0eXBlLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgY3B1X2FkZHIsIHU2NCBw
Y2lfYWRkciwgdTY0IHNpemUpOw0KaW50IGR3X3BjaWVfcHJvZ19lcF9vdXRib3VuZF9hdHUoc3Ry
dWN0IGR3X3BjaWUgKnBjaSwgdTggZnVuY19ubywgaW50IGluZGV4LA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgdHlwZSwgdTY0IGNwdV9hZGRyLCB1NjQgcGNpX2FkZHIsIHU2
NCBzaXplKTsNCi0tLS0tDQoNCkFib3V0IHRoZSBwYXRjaCwgSSByZWxpZWQgb24gdGhlIGFyZ3Vt
ZW50cyBvcmRlciBpbiB0aGUgY29kZSBsaWtlIGJlbG93Og0KLS0tLS0NCi0gICAgICAgICAgICAg
ICByZXQgPSBkd19wY2llX3Byb2dfb3V0Ym91bmRfYXR1KHBjaSwgMCwgUENJRV9BVFVfVFlQRV9J
TywNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBwLT5p
b19iYXNlLCBwcC0+aW9fYnVzX2FkZHIsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwcC0+aW9fc2l6ZSk7DQorICAgICAgICAgICAgICAgYXR1LnR5cGUg
PSBQQ0lFX0FUVV9UWVBFX0lPOw0KKyAgICAgICAgICAgICAgIGF0dS5jcHVfYWRkciA9IHBwLT5p
b19iYXNlOw0KKyAgICAgICAgICAgICAgIGF0dS5wY2lfYWRkciA9IHBwLT5pb19idXNfYWRkcjsN
CisgICAgICAgICAgICAgICBhdHUuc2l6ZSA9IHBwLT5pb19zaXplOw0KLS0tLS0NCg0KRm9yIHJl
dmlld2luZyB0aGUgcGF0Y2gsIEkgYmVsaWV2ZSB0aGlzIGlzIGdvb2Qgb3JkZXJpbmcuIEhvd2V2
ZXIsDQphYm91dCBvcmRlcmluZyBvZiB0aGUgc3RydWN0IGR3X3BjaWVfb2JfYXR1X2NmZyBtZW1i
ZXJzLCBJIHRoaW5rDQp0aGF0IGJvdGggb3JkZXJpbmcgaXMgdGhlIHNhbWUgcmVhZGFiaWxpdHku
IFBlcmhhcHMsIHdlIHNob3VsZCBhZGQNCmNvbW1lbnRzIGluIHRoZSBzdHJ1Y3QgbGlrZSBiZWxv
dz8NCi0tLS0tDQpzdHJ1Y3QgZHdfcGNpZV9vYl9hdHVfY2ZnIHsNCiAgICAgICAgLyogVGhlIGZv
bGxvd2luZyBtZW1iZXJzIGFyZSByZXF1aXJlZCBvbiBib3RoIGhvc3QgYW5kIGVuZHBvaW50ICov
DQogICAgICAgIHU2NCBjcHVfYWRkcjsNCiAgICAgICAgdTY0IHBjaV9hZGRyOw0KICAgICAgICB1
NjQgc2l6ZTsNCiAgICAgICAgaW50IGluZGV4Ow0KICAgICAgICBpbnQgdHlwZTsNCg0KICAgICAg
ICAvKiBUaGUgZm9sbG93aW5nIG1lbWJlciBpcyByZXF1aXJlZCBvbiBlbmRwb2ludCAqLw0KICAg
ICAgICB1OCBmdW5jX25vOw0KfTsNCi0tLS0tDQojIEVhY2ggIlRoZSBmb2xsb3dpbmcgbWVtYmVy
KHMpIGlzL2FyZSIgY2FuIGJlIGRyb3BwZWQ/DQoNCkFuZCB0aGVuLCB3ZSBhZGQgbmV3IG1lbWJl
cnMgbGlrZSBiZWxvdzoNCi0tLS0tDQpzdHJ1Y3QgZHdfcGNpZV9vYl9hdHVfY2ZnIHsNCiAgICAg
ICAgLyogVGhlIGZvbGxvd2luZyBtZW1iZXJzIGFyZSByZXF1aXJlZCBvbiBib3RoIGhvc3QgYW5k
IGVuZHBvaW50ICovDQogICAgICAgIHU2NCBjcHVfYWRkcjsNCiAgICAgICAgdTY0IHBjaV9hZGRy
Ow0KICAgICAgICB1NjQgc2l6ZTsNCiAgICAgICAgaW50IGluZGV4Ow0KICAgICAgICBpbnQgdHlw
ZTsNCg0KICAgICAgICAvKiBUaGUgZm9sbG93aW5nIG1lbWJlciBpcyByZXF1aXJlZCBvbiBlbmRw
b2ludCAqLw0KICAgICAgICB1OCBmdW5jX25vOw0KDQogICAgICAgIC8qIFRoZSBmb2xsb3dpbmcg
bWVtYmVycyBhcmUgb3B0aW9uYWwgZm9yIGVuZHBvaW50ICovDQogICAgICAgIHU4IHJvdXRpbmc7
DQogICAgICAgIHU4IGNvZGU7DQp9Ow0KLS0tLS0NCg0KVGhlcmUgaXMgdGhlIGdvb2Qgb3JkZXJp
bmcgZm9yIHBhZGRpbmcvaG9sZSB1bmV4cGVjdGVkbHkgOikNCkJ1dCwgd2hhdCBkbyB5b3UgdGhp
bms/DQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gLVNlcmdlKHkpDQo+
IA0KPiA+DQo+ID4gLSBNYW5pDQo+ID4NCj4gPiA+IC1TZXJnZSh5KQ0KPiA+ID4NCj4gPiA+ID4N
Cj4gPiA+ID4gLSBNYW5pDQo+ID4gPiA+DQo+ID4gPiA+ID4gK307DQo+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ICBzdHJ1Y3QgZHdfcGNpZV9ob3N0X29wcyB7DQo+ID4gPiA+ID4gIAlpbnQgKCpob3N0
X2luaXQpKHN0cnVjdCBkd19wY2llX3JwICpwcCk7DQo+ID4gPiA+ID4gIAl2b2lkICgqaG9zdF9k
ZWluaXQpKHN0cnVjdCBkd19wY2llX3JwICpwcCk7DQo+ID4gPiA+ID4gQEAgLTQxNiwxMCArNDI1
LDggQEAgdm9pZCBkd19wY2llX3dyaXRlX2RiaTIoc3RydWN0IGR3X3BjaWUgKnBjaSwgdTMyIHJl
Zywgc2l6ZV90IHNpemUsIHUzMiB2YWwpOw0KPiA+ID4gPiA+ICBpbnQgZHdfcGNpZV9saW5rX3Vw
KHN0cnVjdCBkd19wY2llICpwY2kpOw0KPiA+ID4gPiA+ICB2b2lkIGR3X3BjaWVfdXBjb25maWdf
c2V0dXAoc3RydWN0IGR3X3BjaWUgKnBjaSk7DQo+ID4gPiA+ID4gIGludCBkd19wY2llX3dhaXRf
Zm9yX2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSk7DQo+ID4gPiA+ID4gLWludCBkd19wY2llX3By
b2dfb3V0Ym91bmRfYXR1KHN0cnVjdCBkd19wY2llICpwY2ksIGludCBpbmRleCwgaW50IHR5cGUs
DQo+ID4gPiA+ID4gLQkJCSAgICAgIHU2NCBjcHVfYWRkciwgdTY0IHBjaV9hZGRyLCB1NjQgc2l6
ZSk7DQo+ID4gPiA+ID4gLWludCBkd19wY2llX3Byb2dfZXBfb3V0Ym91bmRfYXR1KHN0cnVjdCBk
d19wY2llICpwY2ksIHU4IGZ1bmNfbm8sIGludCBpbmRleCwNCj4gPiA+ID4gPiAtCQkJCSBpbnQg
dHlwZSwgdTY0IGNwdV9hZGRyLCB1NjQgcGNpX2FkZHIsIHU2NCBzaXplKTsNCj4gPiA+ID4gPiAr
aW50IGR3X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUgKnBjaSwNCj4gPiA+
ID4gPiArCQkJICAgICAgY29uc3Qgc3RydWN0IGR3X3BjaWVfb2JfYXR1X2NmZyAqYXR1KTsNCj4g
PiA+ID4gPiAgaW50IGR3X3BjaWVfcHJvZ19pbmJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNpZSAqcGNp
LCBpbnQgaW5kZXgsIGludCB0eXBlLA0KPiA+ID4gPiA+ICAJCQkgICAgIHU2NCBjcHVfYWRkciwg
dTY0IHBjaV9hZGRyLCB1NjQgc2l6ZSk7DQo+ID4gPiA+ID4gIGludCBkd19wY2llX3Byb2dfZXBf
aW5ib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUgKnBjaSwgdTggZnVuY19ubywgaW50IGluZGV4LA0K
PiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gLS0NCj4gPiA+ID4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCu
v+CuteCuruCvjQ0KPiA+DQo+ID4gLS0NCj4gPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g
4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
