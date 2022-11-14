Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34351627624
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 07:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiKNGwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 01:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiKNGwN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 01:52:13 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2128.outbound.protection.outlook.com [40.107.113.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B781208F;
        Sun, 13 Nov 2022 22:52:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYXRqUGHFF1s0K+xNiNu5wAl67Tfr6SerG5qRLPUy9pWyr9VMeD2aytkO0mrx2tmxeuSnGJBwm69MzHF1U5LZ93F43Jh948Z1lUtc+glRBq/hHBz6W7x+FJwRUvmKVFGpOk09dmZj/955Xoz/j7p8YF24ad0B1+rqDCfTRKMkF42I35sdWMbiAO9zNfR6veswfjyUjY41+tzX4W8WfNAGTfycylp8StU6VcebExdagGj26U8cnGDf6vf0vA57JAETOQHWVPCQ2IgzUr1Bmn2mlyVrzTb4+SmNVVWGdieekkmwK1OZjZrjSUDiRUqmr8UY2WRHKMGVGeEcS0K3I6tiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF2vPCXGDxXD52YHCHgbzwzdvuP8nB/CF587qep9zjE=;
 b=LcUM8nQxCklCtG/nRaMQKP8OgkK6e7H44d5VC1htoYHcPOE3iaYdX5PiNQePoOrzSJTDZQLczj2pgluRe3VpzXK2LcRnhCxvwcNjsSJ1XecJsiD8F5LpFRgnD8pdugQ9eFZNf4sqjfOKIBGUOgdERdAECqdZZVgKgoQ100zKK2LLIkElXt5n4dBoeAYkvPoMT2Ya81sApR+N3ubcY6J4wLeHuTe0HmSG56cyGgJLBGcedsjN0DslqzzBzjddg5i3OLUSCObCR9JAuS/Dqwf/dtUw7TzDr9iohFPjLQ0yX1eHRa61/MfLtpienV+YN9pInW6wqCH7kbuHqU/C4L/egQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF2vPCXGDxXD52YHCHgbzwzdvuP8nB/CF587qep9zjE=;
 b=LlCVU88jexxRAJKORAwDkv/X8vBVPjYmXDc1nCC4ewaOCepJ2+N3ladVQC5OniXG2Z1T/BbqNojvzKob59bLn9wOdGWaaLF3vlUVbZvJhDa2fPGlzC1VjRs399fKw3jEgw29GGO5yeJtoVvZlYHbCK84abLK/hXvEKJJfbThswY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB7747.jpnprd01.prod.outlook.com
 (2603:1096:604:1b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Mon, 14 Nov
 2022 06:52:09 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%8]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 06:52:09 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 05/10] PCI: designware-ep: Add ep_pre_init() callback
 to dw_pcie_ep_ops
Thread-Topic: [PATCH v6 05/10] PCI: designware-ep: Add ep_pre_init() callback
 to dw_pcie_ep_ops
Thread-Index: AQHYzlpQUJ21KOXhlUKflbqzh0jt2a4+RXuAgAAFqUA=
Date:   Mon, 14 Nov 2022 06:52:09 +0000
Message-ID: <TYBPR01MB53413162F66EDB3012D8C8F0D8059@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220922080647.3489791-1-yoshihiro.shimoda.uh@renesas.com>
 <20220922080647.3489791-6-yoshihiro.shimoda.uh@renesas.com>
 <20221114061947.GA3869@thinkpad>
In-Reply-To: <20221114061947.GA3869@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSZPR01MB7747:EE_
x-ms-office365-filtering-correlation-id: 1a708941-34b4-44cc-b168-08dac60cc08a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ipdQpq/5+e/P27Gr0V/RTqTYXiwQhZN4JW+N+C8mb+VgKGfWOBggjMrymHS7tbWDtNonBRadlBzGX9JHCn2uNOug6pIUYceySFUIIyKKWcaDNCvQIR10zGA+HjD16P4B/53tsaIlqqDBmoMyO0x5+n8icC69IJFz7tPzh/nReh3NuROEzwJpv4DyGpxvISCIxVWANvPzo7HyMXxzFKgIwSSycU9+D29kWH+SGjf6mkgn2qbBXyKLLIqnP4qHk40nlY2AlxoArY7Y6AROlRgPCUJtpYry4NGr2RKLCK4HrDyi8y7nzPIqOIMksaeC+UxETyUyS8QTDoUOV0YW4RVDTDY37krGayavlnFjvnfp8QsnJ/OdogPMI577OGIeCexCebIl1YPahduz2LgQVMJG+7cTjJDqSbSQ9S2bCvOu/RH6oxRAadfu+IhFtJkG6PMePi2hsxDhmNfdKrjHuWwPDjN/GplzsBWORgcTVong+MDmXfdqBDFrbqiskJdE9QAYOdTN3rVIsIifhwcBgpDmrDXZhTryUpvJFwBK1++KE8N4Rb9xobLSDlJpsYx66PCaPZyeRDEA+U/qNgar8NVlGpzl42HovCr3qUfm0qB91tM0B1DbdCorkYpdyWIphcLt4vvNS15i/x+uevPH0zR3n/U0Af2X97DGRBtPsJ71E6Xdm8/xxpnxwnooVxbow3yEHn4pTJRuxshfPKUfJQjQLfBTAVgAB/055zjhPpfW7DlvvRWiaXeDGuRPPj61taj/jAcHaPst8J3A+GZfOyq5oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(2906002)(86362001)(122000001)(33656002)(6506007)(9686003)(7696005)(38070700005)(71200400001)(54906003)(316002)(38100700002)(6916009)(186003)(41300700001)(55016003)(83380400001)(52536014)(5660300002)(478600001)(76116006)(66946007)(4326008)(66556008)(66476007)(66446008)(8676002)(64756008)(8936002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkpUMXVZbXdqSlZtY1ZMemRJRzhYbHcxZmRwNlRUaFlBdVhxaDFwYjRPc0FM?=
 =?utf-8?B?TXBaaG9oODhlRDZVcEwwZ0plUWYrMTc1K0VyajFhQ1pWYUdsZjlkZk42a1dD?=
 =?utf-8?B?Qk1BY0p3VFVGM2VyRWNZVFNlY3RwWjdvVmN1Qkkxc2tXL3RLZmhQQW5nZWxH?=
 =?utf-8?B?U2t3MXZlUWNYU3c0V2Vrb0t6Y1A3OXRpVko1TTBqQ3lieXFXRWRHZEpkbllt?=
 =?utf-8?B?eGhlSWZKL0VlY3hubWRjVGpJUVc4VHJaUlpmOE1NN3RDT05UU1RZc05aYnhZ?=
 =?utf-8?B?NmFrN0g1SW5oYnRqZml4dHErM29TMmd1T1Zuc0ViUFRycU11eUdRandCVWQv?=
 =?utf-8?B?Rjkyejk0djhuQm5zMFlBT1JvWWkxem9WZElIMWRDb2t2M3JKQklwTnJZL0xV?=
 =?utf-8?B?ZkxrK1B0OCt1alZYL2JPK2E3dlR1RmZ0N3lnMFo5K3czaDNqSVJOTHlpdEVM?=
 =?utf-8?B?MkIraXRhUjlzd0JzckdJYjZGVy9zSUVMZkZjUG4zTnJBbkd6TFZOemVad3py?=
 =?utf-8?B?eXRSaU5STk9BYUxyZWVORllTdDBEZXdzcGFRaGFXTmh0elN6TlJVTk9VU0tv?=
 =?utf-8?B?aUJvU0gxMmNDV2hUVUFkQk5OaFhzSXRrdHNzZldyRytSYTBlVzk2cDJ4Wlhj?=
 =?utf-8?B?d1Bab2ZMRnNheXlVMVd1K3RUVnM1VDZ0c0tzT2cyVDJlS0sreEEvTGxXUHZ5?=
 =?utf-8?B?V1lyeVAzS3VuazhZK21xQnUydzB2RHh3RUdxRGFuZ0NVUlhaWWRweitncHRy?=
 =?utf-8?B?bGQwTG5tSytGbkpZNHV6NE9XcXVKbm96S2dER2tvWlh1STNmbnl3a29ISWNR?=
 =?utf-8?B?VmNqR2tlek9jME9yQjRTNGppSmx2YWNGdG5ISVZQQlNJV0lmTmpHT09KS3JB?=
 =?utf-8?B?WVRhTG5kcFpOb1g1ZVlIUmw2QVdVTGxBdUZBNEZnazNsVWRwRUkxTERZem9V?=
 =?utf-8?B?OWZralgrMTRyVjBWanZZcDBFcjJYZ0ZSRklqVWUwYzFxRGVFTHhCbGhva0g1?=
 =?utf-8?B?enRLQzJnSXBPMldJS0tRMEIxMy9zRUdxSVdncXhGdXhLUnl3MDRIWTdrN3Ni?=
 =?utf-8?B?QmxlbWhqUWEzL2Y5dnhZNTBaUXVta1dOYlFzUjU4anFTckZScmEraGZ2MFp0?=
 =?utf-8?B?OWpPSXJyN3FYUFZpSTlRSDFQaTZ6Q0phMjdxNHNLUTJkNkdESWJBek1wdXRv?=
 =?utf-8?B?Rm5HaE1WWEkrS25VaTdyYW4rY3lqZTYvUGsxVmFVMWhoNmNBZTFKMHBRUGRz?=
 =?utf-8?B?NHc1VVluSVpHMFlJbUZwQjBudHBRTG1XdXFKUC83dnZNamZGOTJNWnJ1cVRS?=
 =?utf-8?B?d3haSkxDeG9ac1Uwd2g0dkEyY0I3Z2N6Ly9neW5uUXhvSklIbE54R0dPZUln?=
 =?utf-8?B?WE5QRThmOVFJQlRWaVR4aU5OR3BoS3lsZ0htTFYrWnhWOUs3eGQ3K3lvdXJ3?=
 =?utf-8?B?dzBxd3h3UGptNlhVdnB4UkZONVB1aWlEYzNpcGpFUXlkYlFoVUljTTVjNGRF?=
 =?utf-8?B?clhLWW83RUJHT3d5MjlWTm1DS2dMeUNDVExMazA4SnJDd0p6d0pXR2I3cDd4?=
 =?utf-8?B?N3lxU25lOERTWlVyTmd2MGFNN0M0NCt4MlZNMDhxQVpXWVBZOEdSRU1aV3JJ?=
 =?utf-8?B?UXJHY3FxT1RCY0s1RmpuVkhrQWw2MU03Qnl4SURRV29sTGN6ZUJkSHpJWXJS?=
 =?utf-8?B?N3UrR0UyWFFMQjhhbWZQZlJIV2xiUWtPTG4wYnhaSzdGRVl6OWtzNVg0L2Fj?=
 =?utf-8?B?bmk1ZzByWVNwWDMzRWNTcW5BS2lvN1NXNjB0VERFdHhxeDk3OXQ1OWZHY3JU?=
 =?utf-8?B?MFBqSkxTZTRGUzBZQ0F5NUxXb0JQNkNLMmdJbHZIZWNzT0dqUlQ4NUsrcmo1?=
 =?utf-8?B?T2pqOW5zRGM4dkd5UmtndksvVUZpOER4UDUybVhaa1dtRFhLbmtjR3BOR0t0?=
 =?utf-8?B?MUtxWDV4bEtIR3U0SUZZbi8zRXJGRGtzb1ljZTlKOHNQczR0bUczRWZiLzBO?=
 =?utf-8?B?bkt5TkVzZUJZeTlBWG9IMXByQlIyNzJES2UrS1krQTFoallrZUlZeEZKcDdm?=
 =?utf-8?B?NHRVSnRvUU1zbndMM0F4TkI3Vkxzcld3YkRFM1JKcEw1WUV5UlFnSDB5M2li?=
 =?utf-8?B?NzJDNS8xQlk3MXJLNzVaZjl4MzBMQzQ3d2N2TXVIZ0tEL3BZUWdyWkRRcHNx?=
 =?utf-8?B?eURabnpVVVhyejMxZllYbVR4VEtEZU53ay9VSmdKQThjazhlMXBBR1UxaTUw?=
 =?utf-8?B?bjNYVE1xZzR2aVE0dDZHVnhWbnd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a708941-34b4-44cc-b168-08dac60cc08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 06:52:09.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBV53EcYOSQ2qew2AvPMVDMtxdlJo3qbDaD5JaICwiMLf1y2Fl2l2ISivgs+F3GgT0iSgzYWFt/TxX2xK/KJApdyn/3IYs0Tco8pxO3cSoPLRZsUV6Pib2aWPPjHqNkX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7747
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IE1v
bmRheSwgTm92ZW1iZXIgMTQsIDIwMjIgMzoyMCBQTQ0KPiANCj4gT24gVGh1LCBTZXAgMjIsIDIw
MjIgYXQgMDU6MDY6NDJQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gU29t
ZSBQQ0llIGVuZHBvaW50IGNvbnRyb2xsZXJzIG5lZWQgdmVuZG9yLXNwZWNpZmljIGluaXRpYWxp
emF0aW9uDQo+ID4gYmVmb3JlIHRoZSBjb21tb24gY29kZSBpbml0aWFsaXphdGlvbi4gQWRkIGEg
bmV3IGNhbGxiYWNrIGZ1bmN0aW9uDQo+ID4gZXBfcHJlX2luaXQoKSBmb3IgaXQuDQo+ID4NCj4g
DQo+IFdoeSBjYW4ndCB5b3UgY2FsbCB0aGUgY29kZSBhc3NvY2lhdGVkIHdpdGggZXBfcHJlX2lu
aXQoKSBiZWZvcmUgY2FsbGluZw0KPiBkd19wY2llX2VwX2luaXQoKSBpbiBwcm9iZT8NCg0KRm9y
IG15IGVudmlyb25tZW50IChSLUNhciBTNC04KSwgZXBfcHJlX2luaXQoKSB3aWxsIHVzZSBwY2kt
PmRiaV9iYXNlIGFuZA0KcGNpLT5uYW1lLWxhbmVzLiBDYWxsaW5nIGR3X3BjaWVfZ2V0X3Jlc291
cmNlcygpIGluIHByb2JlIGNhbiBnZXQgdGhlc2UgdmFsdWVzLA0KYnV0IGl0IGlzIG5vdCBnb29k
IHdheSBJIHRoaW5rLiBTbywgZXBfcHJlX2luaXQoKSBpcyBuZWVkZWQuDQoNCkJlc3QgcmVnYXJk
cywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gVGhhbmtzLA0KPiBNYW5pDQo+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2Fz
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLWVwLmMgfCAzICsrKw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUuaCAgICB8IDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS1lcC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLWVwLmMNCj4gPiBpbmRleCBjYThmMTgwNGVlMTAuLjFiN2U5ZTFiOGQ1MiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1l
cC5jDQo+ID4gQEAgLTcwOSw2ICs3MDksOSBAQCBpbnQgZHdfcGNpZV9lcF9pbml0KHN0cnVjdCBk
d19wY2llX2VwICplcCkNCj4gPg0KPiA+ICAJZHdfcGNpZV92ZXJzaW9uX2RldGVjdChwY2kpOw0K
PiA+DQo+ID4gKwlpZiAoZXAtPm9wcy0+ZXBfcHJlX2luaXQpDQo+ID4gKwkJZXAtPm9wcy0+ZXBf
cHJlX2luaXQoZXApOw0KPiA+ICsNCj4gPiAgCWR3X3BjaWVfaWF0dV9kZXRlY3QocGNpKTsNCj4g
Pg0KPiA+ICAJZXAtPmliX3dpbmRvd19tYXAgPSBkZXZtX2JpdG1hcF96YWxsb2MoZGV2LCBwY2kt
Pm51bV9pYl93aW5kb3dzLA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5oDQo+ID4gaW5kZXggYjU0MWY2NTNjMjA5Li45ZWQ5NjIxYTEyZTQgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgN
Cj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0K
PiA+IEBAIC0zMTcsNiArMzE3LDcgQEAgc3RydWN0IGR3X3BjaWVfcnAgew0KPiA+ICB9Ow0KPiA+
DQo+ID4gIHN0cnVjdCBkd19wY2llX2VwX29wcyB7DQo+ID4gKwl2b2lkCSgqZXBfcHJlX2luaXQp
KHN0cnVjdCBkd19wY2llX2VwICplcCk7DQo+ID4gIAl2b2lkCSgqZXBfaW5pdCkoc3RydWN0IGR3
X3BjaWVfZXAgKmVwKTsNCj4gPiAgCWludAkoKnJhaXNlX2lycSkoc3RydWN0IGR3X3BjaWVfZXAg
KmVwLCB1OCBmdW5jX25vLA0KPiA+ICAJCQkgICAgIGVudW0gcGNpX2VwY19pcnFfdHlwZSB0eXBl
LCB1MTYgaW50ZXJydXB0X251bSk7DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiANCj4gLS0N
Cj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K
