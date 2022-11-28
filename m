Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9963A892
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 13:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiK1MlP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 07:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiK1MlO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 07:41:14 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2111.outbound.protection.outlook.com [40.107.114.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158D613F58;
        Mon, 28 Nov 2022 04:41:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0nAgBZSw29kf2i6vkdnHRfVCI06P6TzPqcR2/DUR8dUoWXlXhcG5GJONTxe9smiQvWuS+P/Z4NpTvcQE+E7mBqWDBAduyN7RiSe+eLx2nVxpniMvVqtZ0/MTna9qkTBn53Z/tr92zyFo9o2IxZJb48AT1+L7bnM83/QTUkBLpK4kMjVFc59m7sRaHopgIhBbfppnkXlp7EOi04LbhDn5/r8qTu8SfbcbH6gDp2zrCLW+5jwmuWe/Rz3PEEMI5R4kZSW8Ua/c7HUUR/kgvX0KL2QEQe1bmOrhhdon3D7kught83Jt3WaMY70uakTjzyO5I9GDjJpWW3U4wZWlvGZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WuH5W32dVX+SQTF4yRyN4fXI3NFprqEiSJZsUrlM2c=;
 b=U23HJXmpAO2ScerG8NpMtRE+H2TqjCcwn3A86lPZEOQT3a+KnmoFrojKdi0NeOJ9AUj537iY8RrrFiDSeBHwlo1zZTcllZRbds2SuxI7iXenrqXF4I7yxRGMyYznbCWD53HYzmCzX+CUcAhke05jwLId/3HgfJ067OldG8bNMs8ru6BX+D5mjQ6u+cKe9t06cRKlkQrPdOfdHSgQ42wD6FLRYlQ426jZf6pFnnEV5BUDAeXNQoR4bWXoX0/yajg38YjbR6kTAd/9ne8wBabkFJaB3/ffyijCVXgpuHVs4EagCVjPbQHHVBqje2y+MJx+fDtGeoqwQqVvJ4zkJTiHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WuH5W32dVX+SQTF4yRyN4fXI3NFprqEiSJZsUrlM2c=;
 b=mVPbCWhXhQgveTJOBBsQ2DNs+AJRuDszOyRFgarhQhn6JcBIZX9Bd6wbhHSrA+Nrlj59UA3hZnyjZseGzYSSwV651D+A7RYJ6I0XLJSNB8wBsun1nqHho8UFL2IXnCCnN2NuFdQ8TJI6pmJKjQ6q5DdMEbCDHF36fF4yLpQOVxA=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYBPR01MB5566.jpnprd01.prod.outlook.com
 (2603:1096:404:8021::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 12:41:11 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%8]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 12:41:11 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>
Subject: RE: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Thread-Topic: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Thread-Index: AQHY/ab1Tv+LcLa0Z0uhVdCr0bfU4q5K+PQAgAiDNgCAACHrwIAAqEAAgAAJ9jA=
Date:   Mon, 28 Nov 2022 12:41:11 +0000
Message-ID: <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
 <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
 <20221122135550.GD157542@thinkpad>
 <20221127235532.u7q7oou36wymkpyf@mobilestation>
 <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128115908.awhznkkrelk7h3nm@mobilestation>
In-Reply-To: <20221128115908.awhznkkrelk7h3nm@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYBPR01MB5566:EE_
x-ms-office365-filtering-correlation-id: e52e4dd0-b92d-4406-d99f-08dad13dd450
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PAla1y+MvXc07Ic37T6uVgwSV3m0/XzhsMXZ1SL+O5mxIsZRZBMRYe4PSLkd75IDJINeRLXms0AeB1xB+/csNxWNN84YYdefGZcKfhbnavb3fV9SwUls+LAaO3F9rNByPBWgOCyQVu0oiWf30EdoGxMrBZg6Z6pHR7Tvghx58u6dY6i3yYTGD7Ws1Z1h2g51q4A9A3jvrnZyZ3t/Gduo711Y2eg9EF6lXY0IUUeVBh27YioaAMqmd4rQmspBuQlSfIdxBNwZrne13YivqDq/Dcwj1ysuaESFg83SN3Ecvp/Jz6WQGj8Qz7ERruZWk+hdm2lMjYiUEcvRfP2mUAqgzHtB+0uEoZWsKMh2Ql/PC7N3rkThweflq+K8y3n4f7+emoTUQWSD9MzOs0y/S8SpeAmEdzztc4x8qRh7YI0jKpkj7tSuuNGjLQSjv6RRxMbo0n8vsUWoGF9N9xcG/MHqU8TFG0ScXrUC4qfFXV3jHS8erVU9VGQXH6K2um1PYC47VYThMtAVnuV/6O0yGTr0i1X66b0IHjk7369hf/C9J7G2sgapFIcDAfYTHKMyjaxMmsXAz0aiDJhwolCAHRG0GJ+5aHNm1iXzmXGz9d6Tc4zZjVHaD8rG4BlzelA9gDm0GM2MJ15fFkhuczINGBV/Oxn63tSd53T4SWgmRGYSiyEwH9+/BekYGYTA5qMmlfE5QZk6E/qKooA+JDxDHT1QJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(478600001)(316002)(2906002)(76116006)(66946007)(54906003)(33656002)(6916009)(71200400001)(55016003)(122000001)(38100700002)(26005)(6506007)(7696005)(86362001)(9686003)(186003)(38070700005)(5660300002)(7416002)(52536014)(8936002)(41300700001)(66446008)(66476007)(66556008)(64756008)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTdjSlZVN2xyLzhlaTEwU1Uxd3pJUDdzZ3RxYzhwZjdrdXlSb05PTkRxbUsz?=
 =?utf-8?B?Rm00enRnSWs5ZHBwY09HbytDemJ4aHlkcm9lWWdGM05uRFlEMUFHTUNpSG5z?=
 =?utf-8?B?UHg4dVJhdFVHT1VySHp6MVFrK2M5OXg3MUtwWFRlTWhQYjMzbjlHNTNXUy9U?=
 =?utf-8?B?ZFUwWFZXRUQxUElFSUpENGFjdzV5V2JNMmxkak9XWDdtUjVMcmx0MTBCS0ZO?=
 =?utf-8?B?S3Y0RmVKVmo4eGd1a1I3b1NsK25USHVSZGs0bk5zUEpsMGt5UjJPdFNNY3BX?=
 =?utf-8?B?WWpTK1BFYVY0Ky9QTXZybnVmbkdqSStZMi9wYnBpUVZmT1ZPcHBYRUNGa3pL?=
 =?utf-8?B?QmEvWGxZVW9jZjRacmJNb1JPK0pVOCt5dnNoNTl0M0lRbzRydkdNY2JQNThH?=
 =?utf-8?B?c0k5bnNnbzVXSHp5YStuVXI5S2FSTVp3Qy92MHdUUk1BNHV1SFE0aXUvdG9k?=
 =?utf-8?B?b3N0RitJcTRPQXFPeTlpUDVJNVZGWThkZk1PZFpFczNoZUErdFpveElpZlNz?=
 =?utf-8?B?MWtjS3haeHFsTG9MOXlGeVdsVi8zdE1ZaGdDTk1sdWR4WDlQZ3hxcXhUNEZh?=
 =?utf-8?B?TGhxUXh4QWdTNGNSMFQrcTVVS2wzS1UxQVNVekpMZXJmaS96clRobDlJc2hC?=
 =?utf-8?B?WU96dFdLeGgrV29pcnJ5cU1BNlhDZzJBU0M1QUxVSzhQT3RDMWpPUWgxUU5a?=
 =?utf-8?B?VndDMGs2YWQ3K3JDUXRhbnhZQ3JkQ1B0TVJxay9UK1l2Qmo1NTBYV1gxL0JI?=
 =?utf-8?B?RUFkTUxSVmFocFZydXBBV05VZVBUeWRtd2MwMno3QndBTHlXRTkzczhKSWVn?=
 =?utf-8?B?c2FKY2wrcHhpRGJVcG9QRUxMN1NOaWhuY3JLQUdjVnpraUpvcWxQdTdudmlP?=
 =?utf-8?B?NVpyQkg1M0dPMWZ5WWtCUExpVHNyditPcUlwR0xVbWhsblphNkIzeVJnWGIr?=
 =?utf-8?B?UFBaWkxwTkx5bXJXdWVBSkxnSU1jNDBPdEsvaWRtM01NdlpFSFduMWRhZ2Nh?=
 =?utf-8?B?T05KVzB5SGJuWnRmNmhFVHNFVmJVcVBHZWhyMm9LQlo5eU5xenA4WUlkejFI?=
 =?utf-8?B?aXF0TmkzaEw3T1UxeExVbkh3eXRnOWw4OE9FeVUrUUpmZ2RDbmJoVFBIQnZs?=
 =?utf-8?B?UUlxWllrQm53ZXdiSnFuUkpZdXZkcStnNXBZYlVFOEJpQ2ExS1orWW1NY2Ji?=
 =?utf-8?B?OGhrL04xWlBoay9jbDlKUmlLYnlnN2hSaHFNOEUxeElPNDhiVHk4dytjbDgw?=
 =?utf-8?B?eEZXc3lvNWNxNEx0QXEvVGs0SllwQ2poMkVRQzdhVWZzZnlVZk1yczZFTWt4?=
 =?utf-8?B?NWZya3dpWG9wM3hlT0lVb3U5YS85MmN1SmkrZFpRdEJJYUJRSHV2QWFFK1RH?=
 =?utf-8?B?TTVVbnhTRVRyTStlcU1KU2t5V3dCV2pydlpIQ21NOHZNa24xTUdldkR4WTFh?=
 =?utf-8?B?YzZlZENmSENxa2NzQmgwQzNCZWFpL0pSRmFSV082NmFySFNyRHQ1empnMFdX?=
 =?utf-8?B?ZnQwUVoyd1o1VWZFUmlMQUhnWldOdytZVVJMVWVnZWRtZlJpVFVTSjZSSlN0?=
 =?utf-8?B?UVEvQmIzcG9vblIxdW1RdmhwRDNWbjdRWm50czl0UEJzc3pEcktMeTVEeTFz?=
 =?utf-8?B?MmRKc3IvV1k5NVNJTXFrUk0yUHVyZlhRQzlCV1ZiZmVGYzdJak4rSFFWeHpX?=
 =?utf-8?B?Wk5RbEZkc2J5d1IwYWxSRGM0T0dmMEdnbzkxbVRkU2Q0UDhTbVlZVEx2L3lI?=
 =?utf-8?B?c0MreGZObjJ5TEVFU21rQ0I4NnlRVkdkNTlWRmc5TEp3anZDZ1JkeVVYR1Vy?=
 =?utf-8?B?N1pYOUZBeFk5R2U1YTFycVMyV3ZReTlRalYvV29NV2hEbHdtbmJXWWFVdDF2?=
 =?utf-8?B?dHpKbVFqME9hM29rSDVyTEZoUjdCMWdHMDNGWEJ4eS9ZZTk2SGl1RlpnOU9v?=
 =?utf-8?B?YWFzWmQ0QnhDZGxFNDNJdWRWWWl5Umk0RkFOTk9zZ1k5WEhsZGphdzlmQzhp?=
 =?utf-8?B?QlY1eklpTFh3MkV3Q3UvMFByM0hjbHlXS2FxT3Fod1dRVTc3d21samNpRzV5?=
 =?utf-8?B?bjh5ZzBYNTVWQS9kRk0vbWtHRzU1S1dTaTZWUHoxUGpNamgvTEVXMVFyZm9Q?=
 =?utf-8?B?cUNVVDFhOWo3V0lVRHoxVXhuV0M5L29LL0NTT0U1enh5NzFRM1V4d1krbEpl?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52e4dd0-b92d-4406-d99f-08dad13dd450
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 12:41:11.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNFdfwKwg8ME2HnYQwmjBBfo2wC4KzYL0IYnQyVCFMu0bwFsJsWPac1fWwOFutP+jNgVLny5UhUsDAX3Zqn3s+8aDiNk5CHphT27ZCVVnyQ6yEM9bMReDS8Na+klyiwy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIg
MjgsIDIwMjIgODo1OSBQTQ0KPiANCj4gT24gTW9uLCBOb3YgMjgsIDIwMjIgYXQgMDI6NTI6NTZB
TSArMDAwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gSGkgU2VyZ2UsDQo+ID4NCj4g
PiA+IEZyb206IFNlcmdlIFNlbWluLCBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI4LCAyMDIyIDg6
NTYgQU0NCj4gPiA+DQo8c25pcD4NCj4gPiA+IFdoYXQgZG9lcyB0aGUgZGJpKzB4OGY4IENTUiBj
b250YWluIGluIHRoZSBob3N0DQo+ID4gPiBhbmQgRVAgcmVnaXN0ZXJzIHNwYWNlPyBTaW1pbGFy
bHkgY291bGQgeW91IGFsc28gcHJvdmlkZSBhIGNvbnRlbnQgb2YNCj4gPiA+IHRoZSArMHg5Nzgg
cmVnaXN0ZXI/DQo+ID4NCj4gPiBUaGUgZGJpKzB4OGY4IGFuZCB0aGUgKzB4OTc4IHJlZ2lzdGVy
cycgdmFsdWVzIGFyZSAweDAwMDAwMDAwLg0KPiA+IC0tLS0tLS0tLS0tLS0tLSAoc29ycnksIHJl
cGxhY2UgdGFicyB3aXRoIHNwYWNlcy4uLiktLS0tLS0tLS0tLS0tLS0NCj4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gQEAgLTg0Myw2ICs4
NDMsMTAgQEAgc3RhdGljIGludCBkd19wY2llX2VkbWFfZmluZF9jaGlwKHN0cnVjdCBkd19wY2ll
ICpwY2kpDQo+ID4gIHsNCj4gPiAgICAgICAgIHUzMiB2YWw7DQo+ID4NCj4gDQo+ID4gKyAgICAg
ICBkZXZfaW5mbyhwY2ktPmRldiwgIiVzOiArMHg4ZjggPSAlMDh4LCArMHg5NzggPSAlMDh4XG4i
LCBfX2Z1bmNfXywNCj4gPiArICAgICAgICAgICAgICAgZHdfcGNpZV9yZWFkbF9kbWEocGNpLCAw
eDhmOCksDQo+ID4gKyAgICAgICAgICAgICAgIGR3X3BjaWVfcmVhZGxfZG1hKHBjaSwgMHg5Nzgp
KTsNCj4gPiArDQo+IA0KPiBObywgdGhpcyBzaG91bGQgaGF2ZSBiZWVuIHRoZSBkd19wY2llX3Jl
YWRsX2RiaSgpIGNhbGxzIGluc3RlYWQgb2YNCj4gZHdfcGNpZV9yZWFkbF8hZG1hISgpLiBXaGF0
IEkgdHJ5IHRvIHVuZGVyc3RhbmQgZnJvbSB0aGVzZSB2YWx1ZXMgaXMNCj4gdGhlIHJlYWwgdmVy
c2lvbiBvZiB5b3VyIGNvbnRyb2xsZXIgKGRiaSsweDhmOCkgYW5kIHdoZXRoZXIgdGhlIGxlZ2Fj
eQ0KPiBlRE1BIHZpZXdwb3J0IHJlZ2lzdGVycyByYW5nZSBmb2xsb3dzIHRoZSBkb2N1bWVudGVk
IGNvbnZlbnRpb24gb2YNCj4gaGF2aW5nIEZGcyBpbiB0aGUgZGJpKzB4OTc4IHJlZ2lzdGVyLiBN
eSBjdXJyZW50IGFzc3VtcHRpb24gdGhhdA0KPiBlaXRoZXIgeW91ciBJUC1jb3JlIGlzIG5ld2Vy
IHRoYW4gdjUuMzBhIG9yIGhhcyBzb21lIHZlbmRvci1zcGVjaWZpYw0KPiBtb2RpZmljYXRpb24u
IEJ1dCBsZXQncyBzZWUgdGhlIHZhbHVlIGZpcnN0Lg0KDQpPb3BzISBJJ20gc29ycnkgZm9yIG15
IGJhZCBjb2RlLiBBZnRlciBmaXhlZCB0aGUgY29kZSwgdGhlIHZhbHVlcyBhcmU6DQotLS0NClsg
ICAgMS4xMDg5NDNdIHBjaWUtcmNhci1nZW40IGU2NWQwMDAwLnBjaWU6IGR3X3BjaWVfZWRtYV9m
aW5kX2NoaXA6ICsweDhmOCA9IDM1MzIzMDJhLCArMHg5NzggPSAwMDAwMDAwMA0KLS0tDQoNCjxz
bmlwPg0KPiA+IFNvLCBzaG91bGQgSSBjaGFuZ2UgdGhlIGNvbmRpdGlvbiBsaWtlIGJlbG93Pw0K
PiA+DQo+ID4gLS0tDQo+ID4gLQlpZiAodmFsID09IDB4RkZGRkZGRkYgJiYgcGNpLT5lZG1hLnJl
Z19iYXNlKSB7DQo+ID4gKwlpZiAoKHZhbCA9PSAweEZGRkZGRkZGIHx8IHZhbCA9PSAweDAwMDAw
MDAwKSAmJiBwY2ktPmVkbWEucmVnX2Jhc2UpIHsNCj4gPiAuLi4NCj4gPiAtCX0gZWxzZSBpZiAo
dmFsICE9IDB4RkZGRkZGRkYpIHsNCj4gPiAtCX0gZWxzZSBpZiAoISh2YWwgPT0gMHhGRkZGRkZG
RiB8fCB2YWwgPT0gMHgwMDAwMDAwMCkpIHsNCj4gPiAtLS0NCj4gDQo+IERlZmluaXRlbHkgbm8u
IEV2ZW4gdGhvdWdoIGl0J3MgaW1wb3NzaWJsZSB0byBoYXZlIHRoZSBlRE1BIGNvbnRyb2xsZXIN
Cj4gY29uZmlndXJlZCB3aXRoIHplcm8gbnVtYmVyIG9mIHJlYWQgYW5kIHdyaXRlIGNoYW5uZWxz
IHdlIHNob3VsZG4ndA0KPiBhc3N1bWUgdGhhdCBnZXR0aW5nIGEgemVybyB2YWx1ZSBmcm9tIHRo
ZSBETUFfQ1RSTF9WSUVXUE9SVF9PRkYgb2Zmc2V0DQo+IG1lYW5zIGhhdmluZyB0aGUgdW5yb2xs
ZWQgZURNQSBDU1JzIG1hcHBpbmcuIExldCdzIGhhdmUgYSBsb29rIGF0IHRoZQ0KPiBjb250ZW50
IG9mIHRoZSBkYmkrMHg4ZjggYW5kIGRiaSsweDk3OCBvZmZzZXRzIGZpcnN0LiBCYXNlZCBvbiB0
aGVzZQ0KPiB2YWx1ZXMgd2UnbGwgY29tZSB1cCB3aXRoIHdoYXQgdG8gZG8gbmV4dC4NCg0KSSBn
b3QgaXQuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gLVNlcmdlKHkp
DQo+IA0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IFlvc2hpaGlybyBTaGltb2RhDQo+ID4N
Cj4gPiA+IC1TZXJnZXkNCj4gPiA+DQo+ID4gPiA+ID4gIAl9IGVsc2Ugew0KPiA+ID4gPiA+ICAJ
CXJldHVybiAtRU5PREVWOw0KPiA+ID4gPiA+ICAJfQ0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4g
Mi4yNS4xDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4g4K6u4K6j4K6/
4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K
