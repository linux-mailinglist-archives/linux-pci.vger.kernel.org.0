Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FCE570989
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiGKRyB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiGKRyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 13:54:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9DD3245D;
        Mon, 11 Jul 2022 10:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pkt4tsK8RgpuCy2k3/erbudMbXcrtiJH6qF3AUAI+ZSlrC+0yS+OGmgbSgtW2kVJtaVr4jOUKo/MhYZ8ep1yiNKvhCE4hZkNRAg4fLHEnJXqEbHOMtdZHpU3bSazk0BR6QcIMeRRRT+xmsvFPQssd/AXGOgB5wj8urMf2M5gK+bq1xtzYYr7u4Zak15beo8gLDms6AK8g1BZ56cMatwl4b0ewz3pxOjXjGnez29UMhhAIfm7n1+dDDSHSAtrNpbCflHCQhghC2PZnfBONd39G3KN0biG5jvASesh2z2+iJDyQ2R+dMD/J6/pni5CZO5Ih5gXxZLTy2df893S8r99fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5nk98W0J5STKupO8ztTvxsb3jnbmpimtMbQky+zeMU=;
 b=AUStX83l8S7DqTU0/ll2zdcZZULWj8KHOSIYQedKzZ+512Vy6BMYMyhAVgXGqFmFSPh5s8BrotSSeLaIT2cOmI7DOPb0i1WT8kf6JHGgoyK5EIKeTpsIC1gM1FyC+3HdEaxp4nDAXIpwoDue7cqzMXTvI7QTerPRH2CapCgOnbmRXu5LjViIL4pRxt4nV1f/WgxGERSxFkdXEqWwRBzyK8+810NvI0NTNU5Pd2eWPayqx6l9ABgA8LC0JDB1kLUOGgO7MTC15vx/XbXizpQElS+xZe2NxPi45E/7uQh03TsZpjPorjuA3baGVK99g+EUxltL6mEm19jnCzRQL4B7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5nk98W0J5STKupO8ztTvxsb3jnbmpimtMbQky+zeMU=;
 b=dD/wKJyXtLM95F15nW0VMMB2jTVwc8xNqO/tKP8y0lI863h+LIeu6P3BYU3I4z4L0Ikznkxg0VO9VlJVV0JfKEorVsfFc4w5u+WQamxXKwgjBm4VyT1FEPk1Khcb6EwmSkaVpAmeITWVzqwnvz7P8wU3fD2uDuCErdyRyjcFnVs=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BY3PR05MB8529.namprd05.prod.outlook.com (2603:10b6:a03:3cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11; Mon, 11 Jul
 2022 17:53:56 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f04f:38dd:7a3d:e6ae]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f04f:38dd:7a3d:e6ae%4]) with mapi id 15.20.5438.010; Mon, 11 Jul 2022
 17:53:55 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Nadav Amit <namit@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] MMIO should have more priority then IO
Thread-Topic: [PATCH] MMIO should have more priority then IO
Thread-Index: AQHYiw9MIzjUV7s8202eNjeTozcWMq1lHkCAgA9GoQCAABllAIAAP7sAgAATwQCAAAs0AIAAAjUAgAASWICABDRogIAAVJ0AgABp6oA=
Date:   Mon, 11 Jul 2022 17:53:54 +0000
Message-ID: <F9E62470-71EA-40DD-875C-6B2B1831F3ED@vmware.com>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
 <YshvnodeqmJV6uIJ@casper.infradead.org>
 <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
 <Ysh63kRVGMFJMNfG@casper.infradead.org>
 <85071FE5-E37A-44CF-9EF7-CB80C116A876@vmware.com>
 <4E0E503E-64E1-4B0A-B96A-0CD554A67107@vmware.com>
 <83C436BD-E12E-420C-B651-B3788F1C4683@vmware.com>
In-Reply-To: <83C436BD-E12E-420C-B651-B3788F1C4683@vmware.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.61.22050700
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ae2a44c-5e97-476e-f039-08da636652f6
x-ms-traffictypediagnostic: BY3PR05MB8529:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hpzE9ePLwwmEx1GmKk8Nz/Zzm+LwEIFv446+ULpDtV4Xva/lt+QJNu3w3zWRdrlqZcQ+Vt6IlOhnUaf2OKWU4mzXbcg/EZFz79zYbJhSp2V7zjIwWn7uoufCVvoWyl+Pw1+QhYvZBChYJKccejt2qGXHKDK36JmlKc4aoljr4vjz2npSxyzwbXTf5g4RMn7gVswjIsc9CcHTlhnaAvVH4IgAvsY5PsAA2K7UpdLyBVDozvh3gm0VcBJpNgn6K/VanaJ4JNHOy9wOjPZeXZOXoCpmEzLmLaX0nKgyCQDY4bydtfft0L187xir+jkBaFYL8LPfJ4RqVHB3qYFX5A9jDsAPxQ0i1Y/LRBarg+u9mOYgAVJTIHhTUDg0spxG4tDmcZgxcxF/sZ5tQW+IkeGE1Kgln9C5YI1iVO+A+Tn9HIWcrPvNmqQZJHKKnTu8sdVRVnR18mhae3LHXRl6zhuLRTwLvjd5Kn1PKL2fiDlg1bWfmciljg0Dxs0qch2TX1sw45P0GNn/LVM0EQvdelaQvgmbB+wzfNJXhFikt5FL6u2soCTOhfpmePzB370avP+Y7rpIRoAs3MOVRWJZkTlJ/SPyozavNTF145Zyl0kwlDiwKeRnVfLRLVqtIaHv1mw7lijn14SpONteGsxqarbtiEm131r2OZhx9wULx1tTyjYAPaaQJNyVGtt1OoC72HosVbFsiYotOaTtsjwgZ64NrSvm0aoufFbaPpCXlAm1kedgLiLGoIts7YJbFt4AU2lGPT9dTER7q4hSeKKeIbNnJyo2Ouu5nXkzpGso1jfD95BDKkxLXZsvImk2uC80uEvSxL8A+qhpijJj311KyAt6USsgjS+5dPb1vxLZ4tXLY0c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(64756008)(8676002)(66446008)(76116006)(66946007)(66476007)(66556008)(91956017)(186003)(4326008)(55236004)(53546011)(6506007)(6512007)(86362001)(6486002)(478600001)(26005)(41300700001)(71200400001)(54906003)(38070700005)(2616005)(110136005)(316002)(38100700002)(122000001)(36756003)(83380400001)(8936002)(7416002)(5660300002)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU0zZkVxbTYzeWRKSjRoNm5FbzBKN0N6N3BvZG5hNjV5ZGNuL09oaHFta1Zl?=
 =?utf-8?B?c25lU2pHSWhNN2lzMUlEOWFkYVhWNi9FdGc5cjdPQVFXSUhQSlM0KzYrdHFp?=
 =?utf-8?B?MHBnRXUzdEZEcTY0dEt3eXVTcnNFaStxNWV2V3Y0dys2a2tyc2lVUFk0Z1Vi?=
 =?utf-8?B?eEhIWFZyMDFSRmd0bHBVeEhuSEVJeEZxajd4Z3dqaDFDQkt6WUhMZlBsc2sx?=
 =?utf-8?B?K2Zadnk1NFdzV3lQZWEzaFQ4dklscTMxbHFicFNCZnJpeWdDVk95Sk0wdWpa?=
 =?utf-8?B?YTdoUWNKYkVJdGw1Z21uM05QSGZpODdEVGV0Z1JIbWttWmJrbERXZXdHMVVi?=
 =?utf-8?B?WE9DZlREaEZQTGF0NXE0V3lQNHcwRmRNbWZwWXZBWXJsTVp5eXY4ajR3QTVs?=
 =?utf-8?B?bWhXUTlJZVdaUFByWmxrS2Q2Y1pxTWxSS0dMckRWVldQcWtXd0JuVldObDBK?=
 =?utf-8?B?NzJiV3d6Vy9pVGhZbWFYanhGZHVqMHdWZ240WmNuM0JMOU00cHBsWDFGN1Nj?=
 =?utf-8?B?WE9pVWdueWlkbTVtbU5NUUEzTnVPZExMTFI3RCs2TXZNYWN6V2JQSjgyUyti?=
 =?utf-8?B?WDQ3bEQ4eGYyUGtacDRaRGZDOWdKRk1IMEJWZ3lIaFRwdkJyMDlRVDQ1a2Rz?=
 =?utf-8?B?alpzdjRJMmpNK3NoVkdYcmFkZlZBNzBUakJEbjZpYTA0TVhjbk9GUUl0N053?=
 =?utf-8?B?bnpoclBZVkVMYjI0cW1lTmVnb1VXbDJlZk9tbDlBMEhSZklwUjk1Sklza1NY?=
 =?utf-8?B?SEpIUVZjTHJzNzVMVjhrSGtUNGUwazJjcDhxL3RoNFJvQlpxUDNYdE50OEdO?=
 =?utf-8?B?VnZ6aTNma2s4Ni9BdjNhR1FKVjBlVkxZV3J5c0lWd0lFd0twNnVYU04yRFJy?=
 =?utf-8?B?QkI3dzFxYnZrUEtWZWJhN0F6ZVdXZUxzem1uRnBHMFhWaDV2STBvZ1V4azFr?=
 =?utf-8?B?MmFKdW5uNzVsQXNiWStESjFNcVdrWmtsWSttb2Q2dnNvNld2bXBLNWlDQytF?=
 =?utf-8?B?RnZEU2RaQi85UE1vNnArQno2OG5MZERVZzVkZms5dXl2TmFTbXFmY1RQTzlo?=
 =?utf-8?B?Y0M3K2M2UXRWQzZhTnJKNUM3NDlwNGZwR3VvK3dBNlNwQkpsMFE3ZDR2Ti84?=
 =?utf-8?B?dExXdFE3UjdxVWUya1JJQzg0VUV6b1o3QXQ1OXF5K3hBVlNpYXVtQWs2aFNH?=
 =?utf-8?B?U1k3aUtwa1BVZjdNS2h2ZnpCWE8zZCsrbU9OQS9oaU9lT3h6TTArR05sVWtM?=
 =?utf-8?B?R0cvSVRLTE5DTHk1RnY0U1NySUZIU3RhUCszMFdaV1VKRklQdHBLZTZibDUv?=
 =?utf-8?B?ck5MNnFEZzFkTTZROTBKUUxEc24vT2F6bzlVL2FodnNDanMxN1lzdU5IZWlj?=
 =?utf-8?B?dERLZGk2SGpIN1c4WWtEYXp3aTZFWWZjekg2NHduQXN4ejdlaGlZbjkrbjRW?=
 =?utf-8?B?OXBNZEt5V1Jjc21PN241cVF1dUlQb0YzNHJ0YlRuWmw2eWdVWG5MbWJWZDV2?=
 =?utf-8?B?WW9FdThRcTRadWRaS0RTRW02aFI2dmRlT1dSK3FVS21ZNlE0anh6VDhwMUZt?=
 =?utf-8?B?UFdHVTgzMHc3dndtd1hobDFPZlVSQzhIMmFYbnd2Q3dxbmVyOVQ0Y1l3Y0dt?=
 =?utf-8?B?bVZHYzhCVnV2TzFPNHdDY21WOGI0SzYxYUhkMzFSNEZ3NlprdVh2a0dKMFla?=
 =?utf-8?B?aThHN2xDZHUvYVlhM0FxRHVEZEMrMnM0RFhxWjNyUk43ZVVXeHJUdGZkbXV4?=
 =?utf-8?B?Rko1QVlKTXZ1bVAxK3lKOVBFbTBMMmcrR28ybUxiUlhHODZWM0JrSFo2c2RD?=
 =?utf-8?B?VnM3NU1MT0I2cDgvWGpXTmZPOUJpY1FPQjdOVUNyNGVXaEV2S3BwVjRzYVNN?=
 =?utf-8?B?VFgyS0kycEdzZzdCVFMyVWRMSFE1U0FhQUR2VVVhY0txbnh5TUNHSGduM0s3?=
 =?utf-8?B?akdYNTE4RG5Falk4OFYyaTNtaDR5cnpSRXB5U2JEN3BmRnViakdkbllJU0or?=
 =?utf-8?B?ekhZcGlmaGU4UnNCZndNZGhFU1Iza2dmMk5uK3MwL01KRUtNSEJLM2Q2OWVp?=
 =?utf-8?B?NCtwaDBFSmdFVVZNaFVRc1BwRGxuVFk1T21LM3piQjJXaEJtY3RNQitGYW84?=
 =?utf-8?B?UmJZaEJOSndLS0I3VWcyMUNLTm5JeENVb0x3QW40Ly9BWXJEUEN5NU9Gc01I?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E1FEC0CC02BF847AA8A5739FDC07D2A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae2a44c-5e97-476e-f039-08da636652f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 17:53:55.5606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1NvoeDshdJp1Icyr3oTIyRupO/q1whJpjqeJW0kZ4sB3p3/obe0P4vwIFY+ku1wKNmtA+vbsXHEAA4d8+mSlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8529
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQrvu79PbiAxMS8wNy8yMiwgMTA6MzQgUE0sICJOYWRhdiBBbWl0IiA8bmFtaXRAdm13YXJlLmNv
bT4gd3JvdGU6DQoNCj4gT24gSnVsIDEwLCAyMDIyLCBhdCAxMTozMSBQTSwgQWpheSBLYWhlciA8
YWthaGVyQHZtd2FyZS5jb20+IHdyb3RlOg0KPg0KPiBEdXJpbmcgYm9vdC10aW1lIHRoZXJlIGFy
ZSBtYW55IFBDSSByZWFkcy4gQ3VycmVudGx5LCB3aGVuIHRoZXNlIHJlYWRzIGFyZQ0KPiBwZXJm
b3JtZWQgYnkgYSB2aXJ0dWFsIG1hY2hpbmUsIHRoZXkgYWxsIGNhdXNlIGEgVk0tZXhpdCwgYW5k
IHRoZXJlZm9yZSBlYWNoDQo+IG9uZSBvZiB0aGVtIGluZHVjZXMgYSBjb25zaWRlcmFibGUgb3Zl
cmhlYWQuDQo+DQo+IFdoZW4gdXNpbmcgTU1JTyAoYnV0IG5vdCBQSU8pLCBpdCBpcyBwb3NzaWJs
ZSB0byBtYXAgdGhlIFBDSSBCQVJzIG9mIHRoZQ0KPiB2aXJ0dWFsIG1hY2hpbmUgdG8gc29tZSBt
ZW1vcnkgYXJlYSB0aGF0IGhvbGRzIHRoZSB2YWx1ZXMgdGhhdCB0aGUg4oCcZW11bGF0ZWQNCj4g
aGFyZHdhcmXigJ0gaXMgc3VwcG9zZWQgdG8gcmV0dXJuLiBUaGUgbWVtb3J5IHJlZ2lvbiBpcyBt
YXBwZWQgYXMgInJlYWQtb25seeKAnQ0KPiBpbiB0aGUgTlBUL0VQVCwgc28gcmVhZHMgZnJvbSB0
aGVzZSBCQVIgcmVnaW9ucyB3b3VsZCBiZSB0cmVhdGVkIGFzIHJlZ3VsYXINCj4gbWVtb3J5IHJl
YWRzLiBXcml0ZXMgd291bGQgc3RpbGwgYmUgdHJhcHBlZCBhbmQgZW11bGF0ZWQgYnkgdGhlIGh5
cGVydmlzb3IuDQoNCkkgZ3Vlc3Mgc29tZSB0eXBvIG1pc3Rha2UgaW4gYWJvdmUgcGFyYWdyYXBo
LCBpdCdzIHBlci1kZXZpY2UgUENJIGNvbmZpZyBzcGFjZQ0KaS5lLiA0S0IgRUNBTSBub3QgUENJ
IEJBUnMuIFBsZWFzZSByZWFkIGFib3ZlIHBhcmFncmFwaCBhczoNCg0KV2hlbiB1c2luZyBNTUlP
IChidXQgbm90IFBJTyksIGl0IGlzIHBvc3NpYmxlIHRvIG1hcCB0aGUgUENJIGNvbmZpZyBzcGFj
ZSBvZiB0aGUNCnZpcnR1YWwgbWFjaGluZSB0byBzb21lIG1lbW9yeSBhcmVhIHRoYXQgaG9sZHMg
dGhlIHZhbHVlcyB0aGF0IHRoZSDigJxlbXVsYXRlZA0KaGFyZHdhcmXigJ0gaXMgc3VwcG9zZWQg
dG8gcmV0dXJuLiBUaGUgbWVtb3J5IHJlZ2lvbiBpcyBtYXBwZWQgYXMgInJlYWQtb25seeKAnQ0K
aW4gdGhlIE5QVC9FUFQsIHNvIHJlYWRzIGZyb20gdGhlc2UgUENJIGNvbmZpZyBzcGFjZSB3b3Vs
ZCBiZSB0cmVhdGVkIGFzIHJlZ3VsYXINCm1lbW9yeSByZWFkcy4gV3JpdGVzIHdvdWxkIHN0aWxs
IGJlIHRyYXBwZWQgYW5kIGVtdWxhdGVkIGJ5IHRoZSBoeXBlcnZpc29yLg0KDQpXZSB3aWxsIHNl
bmQgdjIgb3IgbmV3IHBhdGNoIHdoaWNoIHdpbGwgYmUgVk13YXJlIHNwZWNpZmljLg0KDQo+IEkg
aGF2ZSBhIHZhZ3VlIHJlY29sbGVjdGlvbiBmcm9tIHNvbWUgc2ltaWxhciBwcm9qZWN0IHRoYXQg
SSBoYWQgMTAgeWVhcnMNCj4gYWdvIHRoYXQgdGhpcyBtaWdodCBub3Qgd29yayBmb3IgY2VydGFp
biBlbXVsYXRlZCBkZXZpY2UgcmVnaXN0ZXJzLiBGb3INCj4gaW5zdGFuY2Ugc29tZSBoYXJkd2Fy
ZSByZWdpc3RlcnMsIHNwZWNpZmljYWxseSB0aG9zZSB0aGUgcmVwb3J0IGhhcmR3YXJlDQo+IGV2
ZW50cywgYXJlIOKAnGNsZWFyLW9uLXJlYWTigJ0uIEFwcGFyZW50bHksIEFqYXkgdG9vayB0aGF0
IGludG8gY29uc2lkZXJhdGlvbi4NCj4NCj4gVGhhdCBpcyB0aGUgcmVhc29uIGZvciB0aGlzIHF1
aXRlIGFtYXppbmcgZGlmZmVyZW5jZSAtIHNldmVyYWwgb3JkZXJzIG9mDQo+IG1hZ25pdHVkZSAt
IGJldHdlZW4gdGhlIG92ZXJoZWFkIHRoYXQgaXMgY2F1c2VkIGJ5IHJhd19wY2lfcmVhZCgpOiAx
MjB1cyBmb3INCj4gUElPIGFuZCAxMDBucyBmb3IgTU1JTy4gQWRtaXR0ZWRseSwgSSBkbyBub3Qg
dW5kZXJzdGFuZCB3aHkgUElPIGFjY2VzcyB3b3VsZA0KPiB0YWtlIDEyMHVzIChJIHdvdWxkIGhh
dmUgZXhwZWN0ZWQgaXQgdG8gYmUgMTAgdGltZXMgZmFzdGVyLCBhdCBsZWFzdCksIGJ1dA0KPiB0
aGUgYmVuZWZpdCBpcyBxdWl0ZSBjbGVhci4NCg0KDQo=
