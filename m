Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98DA56C101
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbiGHSfx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 14:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbiGHSfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 14:35:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0B1CFE8;
        Fri,  8 Jul 2022 11:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6kQ1ajP59X1KcUnWVRG1FEWytHKpXCRVih1OPPS4CwZiLMs9vfRgeky7NPUDJfbJOWKBzdh+Z6b62X0hHtLiw2bhqgVkT+VMe4jt3xIowKt5Lp0RNRLRpiuDJaKMiq46FtKIj3lNOGom50P52KhbAGhfI4JQ/UWiHmf2nE54tur/U9/hFBmlzs+1Ww5THEz9slWWq72GOa+shueNIfaIqw3KC4lh6E1xH1DkzwdLe0bcM0cqxlIUnx24BVm2NXYL8yTSxtGPewnoqLm7jpEcPpJeKAZYELiieZVvld1AILFCRwaPsSjm7n3RoQTL7msLMFltvGNOJyxm7vl85Gt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+S6cAGHCd8GB4TQWFBT/j7B5rshdI/AirPeKM6vFEs=;
 b=OWZb8H6NB7N8cle219BUUXDb4cs+LLSPb2kV54Ijr7bchDSgkPvOx0PQTZTlGFoLr4agtJZ4wF4KkDnywz38LCRHd8/wD/5zUtJ8i/HBs3YO/QkNwob0kb5sNjuHE03v3zMnuGf0VM5UvpwL9ranAdVIQ/koWFKGGQi4jp2aHT7j1m4SB52vHVRrqPS9qdFXf8ou8SMOiUF2wdwlqtGroEg81jTBEKXJD+Dg+ea9p+oSF6hwSl58+jr2XQIFCz1fvgZkXE2Let4BglW2RgnsrRMHLpFK4/3sOtatOOobkIcMbqgNyJC2A19JsS9YE8ySzWjSzXwvLa2NtapSc3YfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+S6cAGHCd8GB4TQWFBT/j7B5rshdI/AirPeKM6vFEs=;
 b=dBx4tasWWC/4Gaxmt714FGcgMIoZQX1VN0HC1t7PyLwP46T5S7AaARO65eiol6c3Da3kkJLcGj+t3XHYj8/ABAXhm0h1XqSBKD9qhBL8iQd2ZYcwTa98RhjzO46IyI77Wb4o0NN9X22cx6RReVbGInuNcHL9VkUCPDbv38Heh2E=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB8590.namprd05.prod.outlook.com (2603:10b6:510:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.11; Fri, 8 Jul
 2022 18:35:48 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%6]) with mapi id 15.20.5417.021; Fri, 8 Jul 2022
 18:35:48 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Ajay Kaher <akaher@vmware.com>, Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH] MMIO should have more priority then IO
Thread-Topic: [PATCH] MMIO should have more priority then IO
Thread-Index: AQHYiw9NzqWSNRsR1kyxPrXhcjObWa1lHkCAgA7qdoCAAHWQAIAAP7qAgAATwgCAAAszgA==
Date:   Fri, 8 Jul 2022 18:35:48 +0000
Message-ID: <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
 <YshvnodeqmJV6uIJ@casper.infradead.org>
In-Reply-To: <YshvnodeqmJV6uIJ@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91f4807d-3cf9-4e7a-20ad-08da6110ad8a
x-ms-traffictypediagnostic: PH0PR05MB8590:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Z2cG25w/6vVI6q0tl1V2COz3MoKd+6WNMHasBtbbAudqWJnW2oWoJg29hjieqECBfpVbRh0aoM2e4LLM+iRU6X2t1h8/Eyk4LeIwab0xOa6Lv6paJ2BiU0jnSkz3rD+vNNy1vF7Rw7UyjWNYKOExb3Kcrs+C8iFHjlDaEn6+b4RhfZ0ZRbagC+1EBo8AN37hDfgjK0nJusbblRy2tCojqEfGIiUByKFtN/DEogDqsRw+ssYe//xXXt1rMZ8gt5mxQftZUJ6MZ+culMboDagJdOVBwioVZ4P78un4Lg5JWp991my7I8Xxf3PUEMG+qSELw+8agiWRrq1mG+ZgJx3JjAtDMR4G8kvgj7qRWUPzk6Vh4dUDZKm77XkBQVAz5X8ighSKeZ+dPV3GdzfxTTib/mb54n/KnXEpT3TSesCFGaT355q4FMZ1jzr7Uv/Qn53TU1ySsIKXh4DkL8c0JVMDlQEhj2z2SMGhkBSr8uQfl/S46S23Gc29Kw2dN342/0hLmd0dMjXF1V9rmlUtXyoig6qf/+TA/+EDY1u5tBy6QE+u8WXCBY3Y6GIg8R+Ldpu96KQwoHQpUdk5QgF4eFtqaYZLzHwKwEqm1XwuhBRwhwcleKgqn9N07aDT7IfGW6FhP1Vx6h2ycpGyB1BruqVeF9ilEPKI1c6mjKRaq/a+kMXbfdyCubDCZduKUHyzPFKdPZ2RIBVq545Og98ZKo+KCy3eESPk4+pyLLy9rECnWsXwHoF9fpOQZZmXMuG6n+lHyMJ2YwLjpSIfuA4S1Re3EQ5KelfffLJHpMExPzBEju1oERNL6ER3EzMWANhEenAcAWMWMuNxjMR4AKtxOtN2JXBELtVIyeItZXjUPA/Puo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(6512007)(186003)(2616005)(316002)(83380400001)(53546011)(36756003)(6506007)(38100700002)(86362001)(66556008)(8676002)(38070700005)(41300700001)(71200400001)(122000001)(5660300002)(8936002)(64756008)(7416002)(2906002)(6486002)(4326008)(26005)(66476007)(54906003)(6916009)(66446008)(45080400002)(66946007)(33656002)(478600001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1BoVEE1T1JKN3hIWVh4STNURnpHM0kzSGMxMUg1WDk0cGJhTVBDei96czdz?=
 =?utf-8?B?dThEZHhWOUJsb2tqRjRVcVhodzhsa3oveUl3SytxSGFvcisrb3QzTHYxazJ5?=
 =?utf-8?B?RGt2OVBQd3dDelBSK2hIeW5ZckFMZkNZcVZVVUl0Y01EWVZta081V2pLczkx?=
 =?utf-8?B?T3VZMXFRaldTai9oQUFPL2x3VTJQNkpUYVZ1QnZ5N2xuU3Zpc3NvUjF5TVBw?=
 =?utf-8?B?c0JxYmpoTUZmNzgxY2NCYkNEcmdKZU53Y1pEdW95MThMalZUNEl5MTc1WTNa?=
 =?utf-8?B?VGQ5b05oMVlPMkRaR2xqQUJQSWZqMFdTZjlvdkt0b0cyKzA1MDdFUlF6T1pq?=
 =?utf-8?B?MVQ5Z2daRXJ4VVlhenl5L3VJV0F6cWw4Nm1aaVpjSnpPWllhTUJKN2FRc3Fa?=
 =?utf-8?B?aHpmaUZUNUFHRHFyOFlZVGR4UUtUaCs5emRkT1VmL2UyZGhQOElsbUlEbmlY?=
 =?utf-8?B?dHNWTWRGK2J1Nm9TWDkydllhNUcxaFhmdjdQNmkxa1E5aUJPYTFZWWcvd3do?=
 =?utf-8?B?dElTT2VlR3ZqYUJVb0VhQ0ZyeGxWSklVbW1YemM2VmdpSGJySjJIaHB5VEhY?=
 =?utf-8?B?Mm8ySHhZOFgyOUdYdTBmUUREZDA1MEdGdmVGSXZOUzNMd05XNE40TktVYmk5?=
 =?utf-8?B?K1BDeWxCcTZpZlcyc3ZmUWNGS1FDbHBvclg5T3N0VlR0U01Gc2dYZnRDYlU1?=
 =?utf-8?B?Y1dRb3ZpN21aN3NqS0lnRU81emNPRDBJNTdzQW5RcDhELzFBWVl4MzJ0ek02?=
 =?utf-8?B?ckk1Y3pTRFo4eUU5bUhnTzVtTmRjUVIreklZV01kNG9lYWpqbkt0WnZRbitX?=
 =?utf-8?B?a2ZqbUNIczlMVFRQTWFyUHFEWlI1ZHJ0dDZreTdEUEhmM1A2NnNUa1dyd0ZI?=
 =?utf-8?B?OUpIVWIvRkprREl5bjdVeFY5dE9RZlBWSUNmNDRZWUREMjcyckNObXVQOTlR?=
 =?utf-8?B?UTRDZzlkaXlrZWxMTmNmaklHTmZ2MCtuWklUWmRZMWVycjlBbEZrUVl4dXZ4?=
 =?utf-8?B?bDJKbE5CUW9sMGJOV3lMdXlHeTlBcGNQQVhaMUNyY1RielZJQWovQjhTT1JE?=
 =?utf-8?B?N1hoTjJrUFdoUWVJRTBBUzVsV1d0Q0VlMDhwZHBWNWUrS0pZQWc5NDllbHh0?=
 =?utf-8?B?WjBBTEY1Z3pmdVNKN2dUeDVJWHpneHJmdERTaWh1RDhuZ1NTdzZWNUIvc2pO?=
 =?utf-8?B?NUN6Y3V6YnM0SDRENi84aDgyaGFqYk1PRjhoSnBaeWVTMmxLSFhMOW8xbzZy?=
 =?utf-8?B?YW1JS2V5bUlOSVoraHoxQ1EvclZnLytsTUt6QjNXTkU5STR5eTFWRFFBWlV0?=
 =?utf-8?B?ZnU0Yzh6cWc0MFFjVndob3pPaXJHMjZQZFJUallYSmdCZ3ZnV0VpZzFnU0VZ?=
 =?utf-8?B?VE96NUNsQi9QbzR4azhHdXBnNGo2aU42UDFyNjlFWVlKdXovd3J1azZSVW5N?=
 =?utf-8?B?YUZvaXBiVVdyTm45UWNyVFQ5bjRPY2hsd0xVdVBINkNNNFJoUjhBUmwvN1Ex?=
 =?utf-8?B?S0QvMkJSdmpBaXRLOS9xeENZSThGWDcxSU42aHVqQWdWclEwYVJ5dGRESnRR?=
 =?utf-8?B?clpsRWh5RW85WXdFclc0YU92QktIUlhZMWs4aGJ4UEwxNUNlNHBZRDd5Q3Ny?=
 =?utf-8?B?cjNtdjdUcVlPYmJpNkplTkxGUzFaRVpYNjRaeFAxTzl6QWxROHlTQjVKSE9a?=
 =?utf-8?B?c2hkand6Z0pLeWpEbEhSVkJmRG5CNzB1cVM4cjN5Wk5RUld3bUZrbmkwaUZ6?=
 =?utf-8?B?SU45c1g0RkF3aWhNbC9zdnFaMTBNOWNGdFRKeHVzWXBSZVpzSzVOcm9pWlZZ?=
 =?utf-8?B?TktVR1hPZlBGbmZaWUdUODZrUm1ROFBYd2pzUmlkMlkwTTRLaXZZL0ZTYmU2?=
 =?utf-8?B?Q1Q1V0VKaHR5WlVCMHBmT3ZJb3loMHZSZXNrMjZGek9naUl1U01CdXRjRDZS?=
 =?utf-8?B?TC9uY2RjNmpncFV0ZkFyZ1lGWi9ublBKUDFtMVE5dGgrK1E0VGRvcnpJVXoz?=
 =?utf-8?B?TW1TN1FyaDJadktuKzNsbHFScUNNT09ZMnQxaWJKcVdTMUc5UXdHK3U4YXU0?=
 =?utf-8?B?eTMxMWhtMEZYVzAzVjBOdjhNbmo0RkNVQ3QvWEtHcVJUd3lDOUR2UExoVFdT?=
 =?utf-8?Q?17RL8IK+GM/SJsSmsI13Ik8xw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD36C27AC4483C46A8BF87D4C6EF3313@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f4807d-3cf9-4e7a-20ad-08da6110ad8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 18:35:48.4915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZh1aOn/kTTHzrFNQmL20lJQYkZEEsQXQ4wacgnRwbqZ7hj3mJoTZwz3PnJFkRoiQSjuQQgP8Z8NBwRLb89pbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8590
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gSnVsIDgsIDIwMjIsIGF0IDEwOjU1IEFNLCBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFk
ZWFkLm9yZz4gd3JvdGU6DQoNCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBPbiBGcmksIEp1
bCAwOCwgMjAyMiBhdCAwNDo0NTowMFBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gT24g
SnVsIDgsIDIwMjIsIGF0IDU6NTYgQU0sIE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQu
b3JnPiB3cm90ZToNCj4+IA0KPj4+IEFuZCBsb29raW5nIGF0IHRoZSByZXN1bHRzIGFib3ZlLCBp
dCdzIG5vdCBzbyBtdWNoIHRoZSBQSU8gdnMgTU1JTw0KPj4+IHRoYXQgbWFrZXMgYSBkaWZmZXJl
bmNlLCBpdCdzIHRoZSB2aXJ0dWFsaXNhdGlvbi4gQSBtbWlvIGFjY2VzcyBnb2VzDQo+Pj4gZnJv
bSAyNjlucyB0byA4NXVzLiBSYXRoZXIgdGhhbiBtZXNzaW5nIGFyb3VuZCB3aXRoIHByZWZlcnJp
bmcgTU1JTw0KPj4+IG92ZXIgUElPIGZvciBjb25maWcgc3BhY2UsIGhhdmluZyBhbiAiZW5saWdo
dGVubWVudCIgdG8gZG8gY29uZmlnDQo+Pj4gc3BhY2UgYWNjZXNzZXMgd291bGQgYmUgYSBtb3Jl
IHByb2ZpdGFibGUgcGF0aC4NCj4+IA0KPj4gSSBhbSB1bmZhbWlsaWFyIHdpdGggdGhlIG1vdGl2
YXRpb24gZm9yIHRoaXMgcGF0Y2gsIGJ1dCBJIGp1c3Qgd2FudGVkIHRvDQo+PiBicmllZmx5IHJl
Z2FyZCB0aGUgYWR2aWNlIGFib3V0IGVubGlnaHRtZW50cy4NCj4+IA0KPj4g4oCcZW5saWdodGVu
bWVudOKAnSwgQUZBSUssIGlzIE1pY3Jvc29mdOKAmXMgdGVybSBmb3IgInBhcmEtdmlydHVhbGl6
YXRpb24iLCBzbw0KPj4gbGV04oCZcyByZWdhcmQgdGhlIGdlbmVyaWMgdGVybS4gSSB0aGluayB0
aGF0IHlvdSBjb25zaWRlciB0aGUgYmFyZS1tZXRhbA0KPj4gcmVzdWx0cyBhcyB0aGUgcG9zc2li
bGUgcmVzdWx0cyBmcm9tIGEgcGFyYXZpcnR1YWwgbWFjaGluZSwgd2hpY2ggaXMgbW9zdGx5DQo+
PiB3cm9uZy4gUGFyYS12aXJ0dWFsaXphdGlvbiB1c3VhbGx5IHN0aWxsIHJlcXVpcmVzIGEgVk0t
ZXhpdCBhbmQgZm9yIHRoZSBtb3N0DQo+PiBwYXJ0IHRoZSBoeXBlcnZpc29yL2hvc3QgcnVucyBz
aW1pbGFyIGNvZGUgZm9yIE1NSU8vaHlwZXJjYWxsIChjb25jZXB0dWFsbHk7DQo+PiB0aGUgY29k
ZSBvZiBwYXJhdmlydHVhbCBhbmQgZnVsbHktdmlydHVhbCBkZXZpY2VzIGlzIG9mdGVuIGRpZmZl
cmVudCwgYnV0DQo+PiBJSVVDLCB0aGlzIGlzIG5vdCB3aGF0IEFqYXkgbWVhc3VyZWQpLg0KPj4g
DQo+PiBQYXJhLXZpcnR1YWxpemF0aW9uIGNvdWxkIGhhdmUgKnBlcmhhcHMqIGhlbHBlZCB0byBy
ZWR1Y2UgdGhlIG51bWJlciBvZg0KPj4gUElPL01NSU8gYW5kIGltcHJvdmUgcGVyZm9ybWFuY2Ug
dGhpcyB3YXkuIElmLCBmb3IgaW5zdGFuY2UsIGFsbCB0aGUNCj4+IFBJTy9NTUlPIGFyZSBkb25l
IGR1cmluZyBpbml0aWFsaXphdGlvbiwgYSBwYXJhdmlydHVhbCBpbnRlcmZhY2UgY2FuIGJlIHVz
ZQ0KPj4gdG8gYmF0Y2ggdGhlbSB0b2dldGhlciwgYW5kIHRoYXQgd291bGQgaGVscC4gQnV0IGl0
IGlzIG1vcmUgY29tcGxpY2F0ZWQgdG8NCj4+IGdldCBhIHBlcmZvcm1hbmNlIGJlbmVmaXQgZnJv
bSBwYXJhdmlydHVhbGl6YXRpb24gaWYgdGhlIFBJTy9NTUlPIGFjY2Vzc2VzDQo+PiBhcmUg4oCc
c3ByZWFk4oCdLCBmb3IgaW5zdGFuY2UsIGRvbmUgYWZ0ZXIgZWFjaCBpbnRlcnJ1cHQuDQo+IA0K
PiBXaGF0IGtpbmQgb2YgbG91c3kgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlIHJlcXVpcmVzIHlvdSB0
byBkbyBhIGNvbmZpZw0KPiBzcGFjZSBhY2Nlc3MgYWZ0ZXIgZXZlcnkgaW50ZXJydXB0PyBUaGlz
IGlzIGxvb25leS10dW5lcy4NCg0KV2lsZCBleGFtcGxlLCBoZW5jZSB0aGUg4oCcZm9yIGluc3Rh
bmNl4oCdLg0KDQo+IA0KPiBZb3UndmUgdXNlZCBhIGxvdCBvZiB3b3JkcyB0byBub3QgYW5zd2Vy
IHRoZSBxdWVzdGlvbiB0aGF0IHdhcyBzbw0KPiBpbXBvcnRhbnQgdGhhdCBJIGFza2VkIGl0IHR3
aWNlLiBXaGF0J3MgdGhlIHVzZSBjYXNlLCB3aGF0J3MgdGhlDQo+IHdvcmtsb2FkIHRoYXQgd291
bGQgYmVuZWZpdCBmcm9tIHRoaXMgcGF0Y2g/DQoNCldlbGwsIHlvdSB1c2VkIGEgbG90IG9mIHdv
cmRzIHRvIHNheSDigJxpdCBjYXVzZXMgcHJvYmxlbXPigJ0gd2l0aG91dCBzYXlpbmcNCndoaWNo
LiBJdCBhcHBlYXJlZCB5b3UgaGF2ZSBtaXNjb25jZXB0aW9ucyBhYm91dCBwYXJhdmlydHVhbGl6
YXRpb24gdGhhdA0KSSB3YW50ZWQgdG8gY29ycmVjdC4NCg0KQXMgSSBzYWlkIGJlZm9yZSwgSSBh
bSBub3QgZmFtaWxpYXIgd2l0aCB0aGUgZXhhY3QgbW90aXZhdGlvbiBmb3IgdGhpcw0KcGF0Y2gu
IEkgbm93IHVuZGVyc3Rvb2QgZnJvbSBBamF5IHRoYXQgaXQgc2hvcnRlbnMgVk0gYm9vdCB0aW1l
DQpjb25zaWRlcmFibHkuDQoNCkkgd2FzIHRhbGtpbmcgdG8gQWpheSB0byBzZWUgaWYgdGhlcmUg
aXMgYSBwb3NzaWJpbGl0eSBvZiBhIFZNd2FyZSBzcGVjaWZpYw0Kc29sdXRpb24uIEkgYW0gYWZy
YWlkIHRoYXQgaW5pdF9oeXBlcnZpc29yX3BsYXRmb3JtKCkgbWlnaHQgdGFrZSBwbGFjZSB0b28N
CmxhdGUuDQoNCg==
