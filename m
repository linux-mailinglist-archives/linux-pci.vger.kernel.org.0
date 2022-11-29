Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9763B684
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 01:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiK2AVo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 19:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiK2AVn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 19:21:43 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736B32061;
        Mon, 28 Nov 2022 16:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxS3+pGiQcavAm04LaxcF8Lo9H5kBguggwObgdRfHDED94/crS7EToIPkYpAxaY+HMnvyiuVHk6T9H33NJd022iemkiq/zBQ/E+ZuzNskyMAzg1is51juIDuPiFXkj6TQttaC71tH7pHa5epXIl1HZzHgQifjq5vzyY8QHX2JTR1OMOPjhArSmgS09YGbKMmSFCmAOtkOTWEx3xlSRTbmki67fA6H6qoa6UXJNVYODH6vbOUu+LBbeyAbzWwE4lt2+GrLpJr0J6vJxYYgnA3BA0IJ6b0GrrcFSVFncWGPigw20wYdv994B9hBxfD5qKu87OF8AbGC8YmlAXCnUy1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH3wAVt4NBiNRmjU1cERXtFzZFo3ImrEJ76V8h2yxoc=;
 b=gARmyIrv47ro4fXAaECirXdSs52nulxFTiRbnXrty1FlLQRr/R6T0qU83sgMcpHAuLtQhL3NpeF7krpRp3kZDEUNjxCFtP8BelzOSGpH0ZK7mJVMIleSbVKcqFMYJsKCGSqdxzOEitNl0nEJTgZvzmnMPoNXzAxnCmWgSlDGc6CM+ahl/CN2xpPjGPaQCaJMzsV6rNIVQgWB0kMxbtBN0p13SQDbaSGsiXjPqtrXwLeI/hkOQFZv5vnVVjnHIVtdb6osVv6K9k0luIjLfFVNqo056/p9BGlnyfgskSC0Csc0OGEwReGfJOnNHSyL/MXrWLpjyWAZavkBh8yc06AG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH3wAVt4NBiNRmjU1cERXtFzZFo3ImrEJ76V8h2yxoc=;
 b=YocXFJxEkxCGSeDyuCEdeOs7bvQRJWilzqYNylh5q3lB7IZFmFvCsX8tyIVBSu8NO5QMy4Pg+Kq/5nvIad1WnrdoQ/CgxP2O67To1qLoC9JaHP4AujrEMVR1Xo4TkWqlgBb0DcgQ3SkU/rU5AA0itlCAwCMYwB01zVXwGC1lPMw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB6157.jpnprd01.prod.outlook.com
 (2603:1096:400:60::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 00:21:39 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 00:21:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
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
Thread-Index: AQHY/ab1Tv+LcLa0Z0uhVdCr0bfU4q5K+PQAgAiDNgCAACHrwIAAqEAAgAAJ9jCAADx6AIAAiB/A
Date:   Tue, 29 Nov 2022 00:21:39 +0000
Message-ID: <TYBPR01MB5341FA664D5F1FCA07294F96D8129@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
 <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
 <20221122135550.GD157542@thinkpad>
 <20221127235532.u7q7oou36wymkpyf@mobilestation>
 <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128115908.awhznkkrelk7h3nm@mobilestation>
 <TYBPR01MB534107A3C2B521BA0D67B4A7D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221128161114.deacldwbckfnn6ft@mobilestation>
In-Reply-To: <20221128161114.deacldwbckfnn6ft@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB6157:EE_
x-ms-office365-filtering-correlation-id: e0887265-4b21-4f30-5421-08dad19faefe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mCi5SUBc6oRb3xY4g4FJZeL5B8lnuPM87avrLWx6VZ6BBiJNRaI1FBmSBTX28y1Ixqe6vsxH+cppd4tSpYkT5DTBqWbYZwxkSVSBhoq9Q+UwFjBoTTpEofDaUccL6jvYtGyWrlE95eSqpFNGI9ZoXASHn5SosPRPzQCp/S2sPmoWFFDgCejdieBrAJNelWzHfEPjTLF8rGHA81/gls1EzScvRfFCgfbexmulyh9TFV/FNiRnSM52RicLrrdC+y/i65PX42Yz55qtHd4jo6uq/hdPdxiiS437zJh/cig67oeki+aChQGVyPPQdAXLO/fujZzknBjiZKkvdZ9I717XmIVvKN0fIdkzyWhO+IE/P9gdra2NCzF92F1/CFvslp4LOctg1TuqUgAuIT1oC+BNKEHM7PhqUv6fQNXgWl44Lm/MadQ6U2wbNxZ9vOpsunEpzuI+5wnlkkmvizECcAlG321GvviqrXwJEepHlY5i8gIT+k2PR3X7o8MGdsxKJFSvV321JartiHgoSI7Zyakw88DPL8vF523JZNMQ6XeI2WSvK0WEjoJFV32syX8Kr2rbIlag6a1wBMaWp/h0cii3Uk+hwO8KpmGmSPUse3V47BSVYw/+QfrrHCfhyHcX9CNvqBUxUs65MkLV+41Y7kR4Jer9erx2aeZYzl6ekYXE4SB8Co/wGYBMUuTEdRUQwQh0UyUsjbaDQZv0YvY9BaQsKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(5660300002)(7416002)(33656002)(55016003)(54906003)(316002)(9686003)(110136005)(41300700001)(52536014)(66556008)(76116006)(66946007)(8676002)(66446008)(66476007)(64756008)(4326008)(122000001)(186003)(8936002)(38070700005)(2906002)(38100700002)(86362001)(7696005)(6506007)(71200400001)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFZ5MzFzYldBYVRhckhwRElHdGQ0WmV6bEVHdWJlU0tvVnZrV25VQWFSazZC?=
 =?utf-8?B?QkFhSzE4eVJ3MThWL3hFUS90ZkU0NFNkaXNFSnZQdFNvai92TzU3Z1I4TkU0?=
 =?utf-8?B?amF6Z2JNWUxMV1FvWURLMURGZXFMd1ZMV1hUK0RiMzMyTUZoRlJnZjJCNk9S?=
 =?utf-8?B?c2xiOXJ0TFltd3E3eDhGL3Znek1VWW1QNEgzMVdPVG9nekhTbi9ZZVprbVlD?=
 =?utf-8?B?akVkSnd0SzdYUDhVMXNuK1VjbDVMdURUOEcya0FRcWVaKzl1dkRjYzltL2lQ?=
 =?utf-8?B?TFJDVTlMSVJJZ3dKWEdxakVNOUZKWlJXQXk3eWQxeDJNVTRBMG5PSU11dG42?=
 =?utf-8?B?UyswK0hrTGY2WmJ1aTJ3blVXQVJ2SFlMVjM2UTM5SzZNVnJPb0F1a0Q0QWJB?=
 =?utf-8?B?bVJHU3dqVmJDMU5uZngvcWw1SldGRkEzWTByTzdYMFY2UWZOSE9BYmdrcUNW?=
 =?utf-8?B?eldaQk16aWdSNGJZalF3a1h5anhBeTRnYStmaGdsdTdRZ1FHT3hvRUtQeWx3?=
 =?utf-8?B?MDlGekI1NUFIc1NOL2xJMXRUOHFZK0tHdzlhTFgzOXJlb1drTUJSNUdLNm5r?=
 =?utf-8?B?d1laNGZLdkNXemIybUJGWHUwY0ZCejVqWFJGdnFUbytQbUFhTzFhK2ZFY21H?=
 =?utf-8?B?YW93RkFycU85MlFydkNHeEdSTGc5NFpKRHVXM09xTmczRkh1TkMvM3JLUEN5?=
 =?utf-8?B?d1R5ZXJmaGxVcEJrb09nRXcrdXpDZ0VPN1ZqQ1BSOVlFKyt4OHhic2d5OUdJ?=
 =?utf-8?B?Y2ZCdzlEZ3AySjVJYmo3N1l5YjFSZERxWk1Jb25qd0lPbE5wdkZCVFF5cFdy?=
 =?utf-8?B?OFprOWdhb0krS2o4OU5SYW4vcG5WYmRqaE05U1h0MUJqOXhrTFEzQUQyK3dr?=
 =?utf-8?B?QlFNdmNzQUpEaVgxZWFjdVUyTjhuOE95NXhoQkJ4NjFHaXpRd2NSRnk3blBh?=
 =?utf-8?B?ZFRFZXhkbzlNMmZsMFVFRmlRUEV6UmFiY1JNWndoMnF2bFUvUm5saTFKZU9I?=
 =?utf-8?B?dXlLdC9DRk9BaXpwV1M4RWZudjhVcDVlem9Xc1M4cVNDVlIrN3MrVnNzM2ZN?=
 =?utf-8?B?cjkrZEh6QTNYd09DdXhraGo4bUNmS1VDYnNXbm5zdjNiblRLL1ErQy9GcmZX?=
 =?utf-8?B?cWhVTHlCOVhDU1dRZlFpZmxNWmV2RW5QMjJMcXd6cDl6K2k3c0dPZ2JhdDQ3?=
 =?utf-8?B?VDQrV0RhM3JPY0hqQjNHNW1BRWVLcEhNUXdzTktzUlVmL1BsWVdTRTYzNFJQ?=
 =?utf-8?B?akdWRjBqRlE3UC9ZSGJwcjJKdUIralh5YmZaR3NVcE01SnJLWUY1NERyNkU2?=
 =?utf-8?B?Q3Rvb0NLcFlUNDVXdFlsa21ickhMVG9Hbkt2ZjJvK0szZVhDUGpuaVptKzFM?=
 =?utf-8?B?RjdtZEdVUGpRcWdGcnBYZ2FQblI1bzhoajBWTHZyVm5iTTErdzRCOWNZWFY1?=
 =?utf-8?B?Y2FNWlVEV1pxTmsxVjRURFhmR3hsdVlPTm9ORCtXRTlPQkRqUzNhVS9UVlVq?=
 =?utf-8?B?bEFJVTBGek5XNHBlNldpTVlKYW5MVjMxZFFqbkI5SG5PWnVJSTkwUkNZZXNa?=
 =?utf-8?B?NG5hOWllV015dmwvVm9xRnA1Z2I2ZHlGNUs4ZXdKcDdjWnpjdmczbE1WQWJm?=
 =?utf-8?B?SWVVQlJoMHBBRHJvMFphSFJoU0RSQkdxTmlwTk1IUk5hV2h3VzdtWmNRS1FY?=
 =?utf-8?B?YlVWblhzOFJucGg1RE4xVWhFaEdJY1UwU2lkWEJZK3FTSFJkQXI0M3RQUmNu?=
 =?utf-8?B?c2NIMEhNcWNCSzAvRmlYaGNjMzVjRjRkUDN2TmlPOXJlQkVYN2RlMXRUb05l?=
 =?utf-8?B?ekRCTEdYN045RW4xR1RtQVIvT1JYMENCZkVkaEtiL0dTWGNlZDdkYUc4bVdv?=
 =?utf-8?B?b0tPMzhmSHlhK3JzZDI1NU9Eaks0KzRoUVFSanFwSzYxRWdCL240OHNnMCtD?=
 =?utf-8?B?M2hmNUcxSTRXcXhjRXlDNlNFejFzaXBBb0pnSlFyaXlKOVh3SnFyNnpHK3JU?=
 =?utf-8?B?K3VyclJDbmZES2hIc1dCTTZOOGgzWGw1aGxmbzhNQ2pXRm9zNVFyRldyc3Rt?=
 =?utf-8?B?NTBEcmJWVCttajRmbkxZMFJLUkJKVDFPcVAwcWVlMUw1aElZZHZyZHZ6ZEgr?=
 =?utf-8?B?QU9UTVFnVTAxZVFYOFZWcEFHalQ5bGlNMzRsZU1ZaEpqUU1PZ2NiV3ZGZjdl?=
 =?utf-8?B?WXJqdkx0V2p4YVRvYzV2K2dVOU5WODVxN1dOdFRQTEl6bGd4dU5LTGZUWDBL?=
 =?utf-8?B?VmZkYmhWOWQwL2tkK2UwcXZwNTJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0887265-4b21-4f30-5421-08dad19faefe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 00:21:39.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHSFGSg7GpRbM0tO0QOYXtCfFYCjPg2bzOkjVPLsz0eGTEpkaRLELxj3ah2P3BrgIKEDHkrYHay7j7+Rkh7xj0PtvAbmohqYpIitRQDyYkJguKTyZ8NcAqwiw/fwqcXC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDI5LCAyMDIyIDE6MTEgQU0NCj4gDQo+IE9uIE1vbiwgTm92IDI4LCAyMDIyIGF0IDEyOjQxOjEx
UE0gKzAwMDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+IEhpIFNlcmdlLA0KPiA+DQo+
ID4gPiBGcm9tOiBTZXJnZSBTZW1pbiwgU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyOCwgMjAyMiA4
OjU5IFBNDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBOb3YgMjgsIDIwMjIgYXQgMDI6NTI6NTZBTSAr
MDAwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gPiA+IEhpIFNlcmdlLA0KPHNuaXA+
DQo+ID4gPiBObywgdGhpcyBzaG91bGQgaGF2ZSBiZWVuIHRoZSBkd19wY2llX3JlYWRsX2RiaSgp
IGNhbGxzIGluc3RlYWQgb2YNCj4gPiA+IGR3X3BjaWVfcmVhZGxfIWRtYSEoKS4gV2hhdCBJIHRy
eSB0byB1bmRlcnN0YW5kIGZyb20gdGhlc2UgdmFsdWVzIGlzDQo+ID4gPiB0aGUgcmVhbCB2ZXJz
aW9uIG9mIHlvdXIgY29udHJvbGxlciAoZGJpKzB4OGY4KSBhbmQgd2hldGhlciB0aGUgbGVnYWN5
DQo+ID4gPiBlRE1BIHZpZXdwb3J0IHJlZ2lzdGVycyByYW5nZSBmb2xsb3dzIHRoZSBkb2N1bWVu
dGVkIGNvbnZlbnRpb24gb2YNCj4gPiA+IGhhdmluZyBGRnMgaW4gdGhlIGRiaSsweDk3OCByZWdp
c3Rlci4gTXkgY3VycmVudCBhc3N1bXB0aW9uIHRoYXQNCj4gPiA+IGVpdGhlciB5b3VyIElQLWNv
cmUgaXMgbmV3ZXIgdGhhbiB2NS4zMGEgb3IgaGFzIHNvbWUgdmVuZG9yLXNwZWNpZmljDQo+ID4g
PiBtb2RpZmljYXRpb24uIEJ1dCBsZXQncyBzZWUgdGhlIHZhbHVlIGZpcnN0Lg0KPiA+DQo+IA0K
PiA+IE9vcHMhIEknbSBzb3JyeSBmb3IgbXkgYmFkIGNvZGUuIEFmdGVyIGZpeGVkIHRoZSBjb2Rl
LCB0aGUgdmFsdWVzIGFyZToNCj4gPiAtLS0NCj4gPiBbICAgIDEuMTA4OTQzXSBwY2llLXJjYXIt
Z2VuNCBlNjVkMDAwMC5wY2llOiBkd19wY2llX2VkbWFfZmluZF9jaGlwOiArMHg4ZjggPSAzNTMy
MzAyYSwgKzB4OTc4ID0gMDAwMDAwMDANCj4gPiAtLS0NCj4gDQo+IEBZb3NoaWhpcm8uIEdvdCBp
dC4gVGhhbmtzLiBDb3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gKGRvdWJsZS1jaGVjaykNCj4gdGhh
dCB3aGF0IHRoZSBjb250ZW50IG9mIHRoZSArMHg5NzggQ1NSIHdhcyByZWFsbHkgcmVhZCBieSBt
ZWFucyBvZiB0aGUNCj4gZHdfcGNpZV9yZWFkbF9kYmkoKSBtZXRob2Q/DQoNClllcywgSSB1c2Vk
IGR3X3BjaWVfcmVhZGxfZGJpKCkgbGlrZSBiZWxvdy4NCg0KLS0tLS0tLS0tLS0tLS0tIChzb3Jy
eSwgdGFicyByZXBsYWNlZCB3aXRoIHNwYWNlcykgLS0tLS0tLS0tLS0tLS0tDQotLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KKysrIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCkBAIC04NDMsNiArODQzLDEwIEBA
IHN0YXRpYyBpbnQgZHdfcGNpZV9lZG1hX2ZpbmRfY2hpcChzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0K
IHsNCiAgICAgICAgdTMyIHZhbDsNCg0KKyAgICAgICBkZXZfaW5mbyhwY2ktPmRldiwgIiVzOiAr
MHg4ZjggPSAlMDh4LCArMHg5NzggPSAlMDh4XG4iLCBfX2Z1bmNfXywNCisgICAgICAgICAgICAg
ICBkd19wY2llX3JlYWRsX2RiaShwY2ksIDB4OGY4KSwNCisgICAgICAgICAgICAgICBkd19wY2ll
X3JlYWRsX2RiaShwY2ksIDB4OTc4KSk7DQorDQogICAgICAgIGlmIChwY2ktPmVkbWEucmVnX2Jh
c2UpIHsNCiAgICAgICAgICAgICAgICBwY2ktPmVkbWEubWYgPSBFRE1BX01GX0VETUFfVU5ST0xM
Ow0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gQE1h
bmksIGNvdWxkIHlvdSBwbGVhc2UgaGF2ZSBhIGxvb2sgYXQgdGhlIGNvbnRlbnQgb2YgdGhlICsw
eDhmOCBhbmQNCj4gKzB4OTc4IENTUnMgaW4gdGhlIENETSBzcGFjZSBvZiB0aGUgYXZhaWxhYmxl
IHRvIHlvdSBjb250cm9sbGVycz8NCj4gDQo+IEkndmUgcmVwcm9kdWNlZCB0aGUgYmVoYXZpb3Ig
d2hhdCBkaXNjb3ZlcmVkIGJ5IEBZb3NoaWhpcm8sIGJ1dCBvbg0KPiB2NS40MGEgSVAtY29yZSBv
bmx5LiBJdCB3YXMgZXhwZWN0ZWQgZm9yIHRoYXQgY29udHJvbGxlciB2ZXJzaW9uLCBidXQNCj4g
djUuMjBhIHdhcyBzdXBwb3NlZCB0byBoYXZlIEZGcyBpbiArMHg5NzggZm9yIHRoZSB1bnJvbGxl
ZCBpQVRVL2VETUENCj4gc3BhY2UuIEl0J3Mgc3RyYW5nZSB0byBzZWUgaXQgZGlkbid0Lg0KPiAN
Cj4gLVNlcmdleQ0KPiANCj4gPg0KPiA+IDxzbmlwPg0KPiA+ID4gPiBTbywgc2hvdWxkIEkgY2hh
bmdlIHRoZSBjb25kaXRpb24gbGlrZSBiZWxvdz8NCj4gPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+IC0JaWYgKHZhbCA9PSAweEZGRkZGRkZGICYmIHBjaS0+ZWRtYS5yZWdfYmFzZSkgew0KPiA+
ID4gPiArCWlmICgodmFsID09IDB4RkZGRkZGRkYgfHwgdmFsID09IDB4MDAwMDAwMDApICYmIHBj
aS0+ZWRtYS5yZWdfYmFzZSkgew0KPiA+ID4gPiAuLi4NCj4gPiA+ID4gLQl9IGVsc2UgaWYgKHZh
bCAhPSAweEZGRkZGRkZGKSB7DQo+ID4gPiA+IC0JfSBlbHNlIGlmICghKHZhbCA9PSAweEZGRkZG
RkZGIHx8IHZhbCA9PSAweDAwMDAwMDAwKSkgew0KPiA+ID4gPiAtLS0NCj4gPiA+DQo+ID4gPiBE
ZWZpbml0ZWx5IG5vLiBFdmVuIHRob3VnaCBpdCdzIGltcG9zc2libGUgdG8gaGF2ZSB0aGUgZURN
QSBjb250cm9sbGVyDQo+ID4gPiBjb25maWd1cmVkIHdpdGggemVybyBudW1iZXIgb2YgcmVhZCBh
bmQgd3JpdGUgY2hhbm5lbHMgd2Ugc2hvdWxkbid0DQo+ID4gPiBhc3N1bWUgdGhhdCBnZXR0aW5n
IGEgemVybyB2YWx1ZSBmcm9tIHRoZSBETUFfQ1RSTF9WSUVXUE9SVF9PRkYgb2Zmc2V0DQo+ID4g
PiBtZWFucyBoYXZpbmcgdGhlIHVucm9sbGVkIGVETUEgQ1NScyBtYXBwaW5nLiBMZXQncyBoYXZl
IGEgbG9vayBhdCB0aGUNCj4gPiA+IGNvbnRlbnQgb2YgdGhlIGRiaSsweDhmOCBhbmQgZGJpKzB4
OTc4IG9mZnNldHMgZmlyc3QuIEJhc2VkIG9uIHRoZXNlDQo+ID4gPiB2YWx1ZXMgd2UnbGwgY29t
ZSB1cCB3aXRoIHdoYXQgdG8gZG8gbmV4dC4NCj4gPg0KPiA+IEkgZ290IGl0Lg0KPiA+DQo+ID4g
QmVzdCByZWdhcmRzLA0KPiA+IFlvc2hpaGlybyBTaGltb2RhDQo+ID4NCj4gPiA+IC1TZXJnZSh5
KQ0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gPiBZb3NoaWhp
cm8gU2hpbW9kYQ0KPiA+ID4gPg0KPiA+ID4gPiA+IC1TZXJnZXkNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiAgCX0gZWxzZSB7DQo+ID4gPiA+ID4gPiA+ICAJCXJldHVybiAtRU5PREVWOw0KPiA+
ID4gPiA+ID4gPiAgCX0NCj4gPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+ID4gMi4yNS4xDQo+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+IOCu
ruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
