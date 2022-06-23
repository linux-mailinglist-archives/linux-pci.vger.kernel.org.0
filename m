Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381B7556F54
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 02:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiFWAUD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 20:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFWAUC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 20:20:02 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49A841612;
        Wed, 22 Jun 2022 17:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lETcd37ghOj2cBI7RWAJrEf097G1tHtgdCIdmAD5ecfUFJHOsFhEUayflMdxRaHiEKAkhyhxWHkr4cKLPOHYjVyIL6iRGlMwrMIRBoCDh+V2+DTAia94INMKdctAHB6fS4reE2LBrLVzt57p7cmFkENEQqGVCOca1I5cwdsiAit8qTaBv+aCEXIOUM5/i4ZXrmDbCRmsw/1BmIzqxDcH7UoVtpkxM4BsQii2qCzutgizorljdwb+IU4E5RPpT9pNz2ZByWeZgLFu4Tsm0t5MDUXEyIpas4f4M0hZIbgfY37OgoiD8PYjCtc8Tlryw5FGUQ7gMHKCZKy6xvU30gl/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaYBKN52p5iftmioy5ZFifClfQlJ08hKImtlPFnUCFU=;
 b=AB0dz9fF1UWVkGSF+0aCe0q8zi5Mjzm1jXWODwmce4B1WBOGplUbfJ7ic4cCUDPyKAzMMDF6184vFSVzVDDRL9mGGtobz0KTGndWZC4zMgKoqERtHOMCxu5F2iPCaBj4OKHvk+DRk2MBTxINhaAtW84M2h2nASXE52giPELIUanqCcamg1Mljen5eZxE0dIn5AdGRyXT/MQ5lMQ2+5oMGqXuHZ3xsY7IzCvrcOuDpcWFj4GW7jjot7wxmeTtCBpAw+qt4jPvk7H03nj1CtKT7Ys5jK1SYSnHHW1hzaJwE/qWYxC9n5YfmMoSuAL96sImoJT1IBsv4W+5r7MfpK0gig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaYBKN52p5iftmioy5ZFifClfQlJ08hKImtlPFnUCFU=;
 b=jmRlqOOGlNgNRebmIeBy2Ak7T124b1POF1sYff2S54ARNO0UuFPw40HuI3VviA+CvH84rSOjQjSvm+v9AJ3Uk5xfj8Lagdi9bcKwzC472OSYGawJpkJShpbRWXdvbQziHsOW1x3qC99Nu+Cuhzfo/zifRMH1LEtpqjz+YGqTtKM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB8564.jpnprd01.prod.outlook.com
 (2603:1096:604:18d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 00:19:58 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%6]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 00:19:58 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: endpoint: Fix WARN() when an endpoint driver is
 removed
Thread-Topic: [PATCH v2] PCI: endpoint: Fix WARN() when an endpoint driver is
 removed
Thread-Index: AQHYheLaRaNISSJcFk2RWiiahEAPLK1bHiOAgAECpnA=
Date:   Thu, 23 Jun 2022 00:19:58 +0000
Message-ID: <TYBPR01MB53416D30C098DC817A52BE6BD8B59@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220622025031.51812-1-yoshihiro.shimoda.uh@renesas.com>
 <20220622084917.GC6263@thinkpad>
In-Reply-To: <20220622084917.GC6263@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50c4747e-3e6f-418d-c9fb-08da54ae1b2c
x-ms-traffictypediagnostic: OSZPR01MB8564:EE_
x-microsoft-antispam-prvs: <OSZPR01MB85647DBBFB4AEA86F1DAE440D8B59@OSZPR01MB8564.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLEX4eZW9e3+dhGaDtQmFHfitnPDzYChMTzgc4VscxjjXMBbBlUptm5BV92c+fxYuEBX32SBtIjPEng5eywM7i7LCXn4qyOxvT8YKoN9e2YTdl6q/CDNEpBCz69MHP9xGAvhXaYMnLsVZCngOjzH3wkIvbt7W8RT6BHZB0tDnFK8wcufpcs/72v1US9EUHiYpOMxTvmZuzWKKxs7jF1+LyNRmSWoUbu3ZjTNs9C/ROnTnxhHL1O7vzHMurwIl66Y5yWVbYOdGo69o4MWBK3WCnJxgaQLiUHf/9jlo55r3vQsnxUPIUF4OrupF+9MhUjuAMiXsJ2TkrKF/mmNt9996mcodTWh6xezFFGtOstoCOEbhQzCHWzwnwKg0Q/XYrq+GDeni6y/7oc1RQmHIc5OfESz9kSxVC8iRcQYDqSbeCvbwtt85qXK4TbawA+ra/Vzew8f7FYWz+qnuUvWMekLjLDfr4r1vcHmkJub0/XV1iW0jdp8ECtYfpy5os95UL3CdVTg8lFtn+hK2u5gM3KBpjN41DsCCCw1gwhjLVeVgLOueA2VliwSJKyuELfqe5eRIv/JlRUmydZSIzqLXwXTAFX8X4TKFzYty7FgsRhFLjYKZ+Z/bzKOUMBOyAw8fk61VRfKfZDwhrmDSLRwB/GAUlBDifJ4MOiOI36pNk3WNchpL6IDRkqEmZMIBZbmiXA/zdKHEH1cORfLOxjxqZIuwj0FPuMgPQyMNy2ZEdhUa3WSuvM72LNxbEtTnMVV+NyA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(86362001)(83380400001)(4326008)(64756008)(76116006)(66476007)(66556008)(66946007)(8676002)(66446008)(38100700002)(186003)(8936002)(122000001)(5660300002)(52536014)(38070700005)(2906002)(55016003)(71200400001)(316002)(9686003)(6506007)(6916009)(7696005)(54906003)(478600001)(33656002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXoyUTU4c3lFeWtta0Q1QWNjdklHcExDQTg3RlJmdjBKRGRnYVZwcGh0ZFJT?=
 =?utf-8?B?b3piL3lqbmI2L3I3cnlTbGFXak9VRzRlNGZhVjZwVUxUTlZmbTRmMWFGY1Fk?=
 =?utf-8?B?dHJadnJtYnZ6UllnUjBvZDlqcGp3cUpUc0NQME5XNnBHTVVCRnEzaHJkdmta?=
 =?utf-8?B?eDlrOXFiWmJGUVBZKzFKRmgyS1FyNE54ME1XN21lMU9RYTBGQ1RDdUk3cU5i?=
 =?utf-8?B?TjRUTVRrTkcrbkk1ZnAzSnRXcEdNeXdwNU4vNEZpRmE1WjliNVpKdk02STBV?=
 =?utf-8?B?TmJ0VEVMbWdxL3B1ckFJcUdTdXJlUE84eGJBRkJiTjNtM2ZEa0NFTWZ6bTc2?=
 =?utf-8?B?Ky9BdDlBRHhaVklmeHpUMzlqSUx3MnlvU1RxT0NYbHhLcHdwZ1FENGxiVzVY?=
 =?utf-8?B?cWZueHVuQWNJL0xhUWtkVzM5T3F0TnlDZVpqN0hDTnRuQ25XWE1LWmRZeEE4?=
 =?utf-8?B?L01sSjM4NnlMWlkxK0hwajY0L2ZyaHR5a2pRa1RmcTR1dHlWTlVSeXVVREJp?=
 =?utf-8?B?TTA1UmYyOERuSWgvamdzWWVWcUpWMUs3TjZwSDFZUmlNOUJKbWZtQmh2bXNl?=
 =?utf-8?B?L0xUNGpXSlV0UDZsejRkUjVzbGtjVUtpVWJkdWcyS0kwb2FhNzdsNWg2MjRT?=
 =?utf-8?B?MHNJT2FqZTBUWTAxTG1oaXVleGFscHg5QllYZjlmUlJwNCszZzVxc0l3a25j?=
 =?utf-8?B?VmZQSnorSlNMV2ozVDhsREZIMFhpUFN4RzZ1TmNPbFE4T2hXTEoyY2Z1T2dt?=
 =?utf-8?B?S2FPQzUrVFRaTERzdFczRnJ3ai8vL3Q4dFAxMkk4c0RWSGw0UjNZd2FGdmkw?=
 =?utf-8?B?VzZ0TmNwek5aUFBycEtOL1JnMGpzQWowKzA4eGZCQjlsWVZPRjlhTm9nWFNt?=
 =?utf-8?B?SUhZVEE2YzY5aC81WGRnNGFja05pT2Y0cjI4OFRIQ1hRRU9QM1Fla3M4Z1BQ?=
 =?utf-8?B?SXZQM3BmQS8zdWVNZk9vN0g3YmluT0FDWVRZNkhaS2l3dWdXeEZuRWE0Lyt4?=
 =?utf-8?B?T0Q2LzluVVdoelUwYnRYd1U2VUx0Ynp4bnNmUE1CWTB1c2c3VEpCN0E1dFYv?=
 =?utf-8?B?ZXM4RVB4NG8rcTBNOGppRWM4VE5NYUoyZmZOclQ5QUZRU2RwYjM5VU9Hb0Rx?=
 =?utf-8?B?Rkk3U1ZVcFNUZlQ4VXBQZ0FvS3BxaVcvdUMxNzNzT3gvenlTNnVNT0R3REo0?=
 =?utf-8?B?U2c4MG9EcmdwNHpQTVpTdHdKK0JGbmxMMk1aUDhyTjdLOUp0MVB3NWV2NlRV?=
 =?utf-8?B?WjQrVlJuSEk1dkxyUStLdk1kaUFrazFiRDBkVlh4R3oxODR2RFhEYUx2Q0RI?=
 =?utf-8?B?WXQ1QWI2dGZ0aGlXdUdDTmJsZEJieDFoQWtSa2d4OXcrNXVxd2Evd0phYnl4?=
 =?utf-8?B?SXhuSTNtWnBISVIySTEyNVhROVVuUExtOFNzeXI3Y2NScE04QUFUTFZvL1kv?=
 =?utf-8?B?VUxWanVyWjNCWGx0N0dSOXFCMGlpWjdOUzA0THo5RW12byt2a0dNa3phd1Iy?=
 =?utf-8?B?N01BWWk0aGZGR2RoUGovOTNGa3lKajN1cFR4dTVyajNneFlrMG9CZFFHd21H?=
 =?utf-8?B?c2d4V3lVUnF2NDc5UmpNRlh2aTVLQmF4MG1ZTzV0OVhTTmFKVzVMNkFlY3dx?=
 =?utf-8?B?Y01rcFowTkRYWk9wbnNWRG1meElkU2YzWHpRRG5oOVNreGxhVlV3dlBpYUoy?=
 =?utf-8?B?RGZaaUFKV1ZSWW1KcUhBV2NIVzU5WCtHTS82Sk1ySU9BcG1XZ3hRamlYREh2?=
 =?utf-8?B?aFBibVZFM2VZOFVFbG1aUWd4Vnc3WnVYcXRDRXZTN2FVdnhFMHVEUGNpZ2hD?=
 =?utf-8?B?bkRrTEJSR2FFMEpYaFR2MzBIbzduM29vNnB6cHNSMVhWMTJLN05WWHZRcis3?=
 =?utf-8?B?d29TNDVyQkJzVE9DdFFWbmxGS0IyeG1YUmc1cmVIdC9xVHk1QWRjZkN5aGZn?=
 =?utf-8?B?NE9CV3lDNmVVM0pHYkd0aU5UTlNDSUlkZFFSeXFmbFBZbzJLblkyZzc1UHlu?=
 =?utf-8?B?UGkxL1hWNlRaQ0hpNmQrcFovaVZGODNqK1VKejlNN1o1UlQ1L2dVZjRjcDNh?=
 =?utf-8?B?Q2NjODgraGlkazFkeGFlMUN5eGFxcHpOTXEwaU9yMi9JR0p4QW80ZmN6T1F2?=
 =?utf-8?B?ZFVRbDZkMlVJY2U5bGsvdS9ieExxemc0b1hFUVNUREpYVVZhcFhEYTFnRVZP?=
 =?utf-8?B?UDBPOXcvV3BrMkZzcXVEMitPamVZTHF1NkdNWCtMYVhXODUvSkdUQ0xtdU9a?=
 =?utf-8?B?S1czN3JXTzBJV2FucUxkcUg1dndDUVNQVXZ0OS9GRHFZVlgwU3QwS0Nmd0Rt?=
 =?utf-8?B?Z05kQkg2eG9OcmVEcCsxa0pqL2pGTUdTR2lvMzVKNnpKbSt5ODVyZ0psMnVP?=
 =?utf-8?Q?8w0CLG5hG3HFvW+ciUwRehQdgOv0GXgykedpNAi+mdHwG?=
x-ms-exchange-antispam-messagedata-1: ImumoKsgNJHsiCh3VvrzVR8r61yD0pOqpF0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c4747e-3e6f-418d-c9fb-08da54ae1b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 00:19:58.2996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqAIraXwLhWV4FmFrAo947sYVpI5XCcgaxe1w0qnjk+7Grj6QO5qv2wQsO/stiDp8HSK23tr2IGmNdlob6d7rxIPVWxKo6zQ6VQ4DA/3iEBHcryN6qveR/hhvRx9Eob5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFdl
ZG5lc2RheSwgSnVuZSAyMiwgMjAyMiA1OjQ5IFBNDQo+IA0KPiBPbiBXZWQsIEp1biAyMiwgMjAy
MiBhdCAxMTo1MDozMUFNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBBZGQg
cGNpX2VwY19yZWxlYXNlKCkgZm9yIGVwYy0+ZGV2LnJlbGVhc2UgYW5kIG1vdmUga2ZyZWUoZXBj
KQ0KPiA+IHRvIHRoZSByZWxlYXNlIGZ1bmN0aW9uLiBPdGhlcndpc2UsIFdBUk4oKSBoYXBwZW5l
ZCB3aGVuIGEgUENJZQ0KPiA+IGVuZHBvaW50IGRyaXZlciBpcyByZW1vdmVkLg0KPiANCj4gU28g
eW91IGhhdmUgbWVudGlvbmVkIHdoeSB5b3UgYXJlIGFkZGluZyB0aGUgcmVsZWFzZSBjYWxsYmFj
ayBidXQgbm90IGp1c3RpZmllZA0KPiB0aGUgbW92ZSBvZiBrZnJlZSgpIHRvIHJlbGVhc2UgY2Fs
bGJhY2suDQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2Ugc2hvdWxkIGNsZWFybHkgc3RhdGUgd2hh
dCB0aGUgcGF0Y2ggZG9lcyBhbmQgd2h5Lg0KPiANCj4gWW91IGNhbiB1c2Ugc29tZXRoaW5nIGxp
a2UgYmVsb3c6DQo+IA0KPiBTaW5jZSB0aGVyZSBpcyBubyByZWxlYXNlIGNhbGxiYWNrIGRlZmlu
ZWQgZm9yIHRoZSBQQ0kgRVBDIGRldmljZSwgdGhlIGJlbG93DQo+IHdhcm5pbmcgaXMgdGhyb3du
IGJ5IGRyaXZlciBjb3JlIHdoZW4gYSBQQ0kgZW5kcG9pbnQgZHJpdmVyIGlzIHJlbW92ZWQ6DQo+
IA0KPiAgIERldmljZSAnZTY1ZDAwMDAucGNpZS1lcCcgZG9lcyBub3QgaGF2ZSBhIHJlbGVhc2Uo
KSBmdW5jdGlvbiwgaXQgaXMgYnJva2VuIGFuZCBtdXN0IGJlIGZpeGVkLiBTZWUNCj4gRG9jdW1l
bnRhdGlvbi9jb3JlLWFwaS9rb2JqZWN0LnJzdC4NCj4gICBXQVJOSU5HOiBDUFU6IDAgUElEOiAx
MzkgYXQgZHJpdmVycy9iYXNlL2NvcmUuYzoyMjMyIGRldmljZV9yZWxlYXNlKzB4NzgvMHg4Yw0K
PiANCj4gSGVuY2UsIGFkZCB0aGUgcmVsZWFzZSBjYWxsYmFjayBhbmQgYWxzbyBtb3ZlIHRoZSBr
ZnJlZShlcGMpIGZyb20NCj4gcGNpX2VwY19kZXN0cm95KCkgc28gdGhhdCB0aGUgZXBjIG1lbW9y
eSBpcyBmcmVlZCB3aGVuIGFsbCByZWZlcmVuY2VzIGFyZQ0KPiBkcm9wcGVkLg0KDQpUaGFuayB5
b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbiEgVGhpcyBkZXNjcmlwdGlvbiBsb29rcyB0aGUgYmVzdCB0
byBtZS4NCg0KPiA+DQo+ID4gIERldmljZSAnZTY1ZDAwMDAucGNpZS1lcCcgZG9lcyBub3QgaGF2
ZSBhIHJlbGVhc2UoKSBmdW5jdGlvbiwgaXQgaXMgYnJva2VuIGFuZCBtdXN0IGJlIGZpeGVkLiBT
ZWUNCj4gRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9rb2JqZWN0LnJzdC4NCj4gPiAgV0FSTklORzog
Q1BVOiAwIFBJRDogMTM5IGF0IGRyaXZlcnMvYmFzZS9jb3JlLmM6MjIzMiBkZXZpY2VfcmVsZWFz
ZSsweDc4LzB4OGMNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5
b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gDQo+IFdpdGggdGhlIGNvbW1pdCBt
ZXNzYWdlIGZpeGVkLA0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8
bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQoNClRoYW5rIHlvdSENCg0KQmVzdCBy
ZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiBUaGFua3MsDQo+IE1hbmkNCj4gDQo+ID4g
LS0tDQo+ID4gIENoYW5nZXMgZnJvbSB2MToNCj4gPiAgLSBNb3ZlIGtmcmVlKGVwYykgdG8gdGhl
IHJlbGVhc2UgZnVuY3Rpb24uDQo+ID4gIC0gUmV2aXNlZCB0aGUgY29tbWl0IGRlc2NyaXB0aW9u
Lg0KPiA+DQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQvcGNpLWVwYy1jb3JlLmMgfCA3
ICsrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L3BjaS1lcGMt
Y29yZS5jIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvcGNpLWVwYy1jb3JlLmMNCj4gPiBpbmRleCAz
YmM5MjczZDBhMDguLjI1NDIxOTZlOGMzZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9l
bmRwb2ludC9wY2ktZXBjLWNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L3Bj
aS1lcGMtY29yZS5jDQo+ID4gQEAgLTcyNCw3ICs3MjQsNiBAQCB2b2lkIHBjaV9lcGNfZGVzdHJv
eShzdHJ1Y3QgcGNpX2VwYyAqZXBjKQ0KPiA+ICB7DQo+ID4gIAlwY2lfZXBfY2ZzX3JlbW92ZV9l
cGNfZ3JvdXAoZXBjLT5ncm91cCk7DQo+ID4gIAlkZXZpY2VfdW5yZWdpc3RlcigmZXBjLT5kZXYp
Ow0KPiA+IC0Ja2ZyZWUoZXBjKTsNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChwY2lf
ZXBjX2Rlc3Ryb3kpOw0KPiA+DQo+ID4gQEAgLTc0Niw2ICs3NDUsMTEgQEAgdm9pZCBkZXZtX3Bj
aV9lcGNfZGVzdHJveShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBwY2lfZXBjICplcGMpDQo+
ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoZGV2bV9wY2lfZXBjX2Rlc3Ryb3kpOw0KPiA+
DQo+ID4gK3N0YXRpYyB2b2lkIHBjaV9lcGNfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
ID4gK3sNCj4gPiArCWtmcmVlKHRvX3BjaV9lcGMoZGV2KSk7DQo+ID4gK30NCj4gPiArDQo+ID4g
IC8qKg0KPiA+ICAgKiBfX3BjaV9lcGNfY3JlYXRlKCkgLSBjcmVhdGUgYSBuZXcgZW5kcG9pbnQg
Y29udHJvbGxlciAoRVBDKSBkZXZpY2UNCj4gPiAgICogQGRldjogZGV2aWNlIHRoYXQgaXMgY3Jl
YXRpbmcgdGhlIG5ldyBFUEMNCj4gPiBAQCAtNzc5LDYgKzc4Myw3IEBAIF9fcGNpX2VwY19jcmVh
dGUoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2VwY19vcHMgKm9wcywNCj4g
PiAgCWRldmljZV9pbml0aWFsaXplKCZlcGMtPmRldik7DQo+ID4gIAllcGMtPmRldi5jbGFzcyA9
IHBjaV9lcGNfY2xhc3M7DQo+ID4gIAllcGMtPmRldi5wYXJlbnQgPSBkZXY7DQo+ID4gKwllcGMt
PmRldi5yZWxlYXNlID0gcGNpX2VwY19yZWxlYXNlOw0KPiA+ICAJZXBjLT5vcHMgPSBvcHM7DQo+
ID4NCj4gPiAgCXJldCA9IGRldl9zZXRfbmFtZSgmZXBjLT5kZXYsICIlcyIsIGRldl9uYW1lKGRl
dikpOw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCu
o+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
