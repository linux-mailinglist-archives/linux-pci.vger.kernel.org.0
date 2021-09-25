Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7561C417FD4
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 07:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344721AbhIYF25 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 01:28:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3078 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhIYF2y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 01:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632547641; x=1664083641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CmomWeXEXqXneHDJ4GQpzbTJ1+/x6vkvKAH1gDONmNE=;
  b=FL0VLOekD4blstJ2eglWTOLQqvTc8F1IA6Cx3odB0xaCg4c91kbX5uV7
   yAzzpTPz4D6tQ0ZP/YBofW6mZJP2QjYnGPHPqnO3r9wS99I6V5h+D/5U3
   Z69onaWk0kSjhueb1ANpmLHhxMjiwhAdCYmXTJraGDZo14z0MjezboCGf
   Dp6jCXZpHQyIBGDpX7+2ohfc5RI4ASGGleDK9IBCWG064zyYc+FbhTtnL
   vdzWWwO4kID1fr6Kju31SED3g5VKo0A2CiccvuBq+QMQc1yXq5wfwNuwG
   XumZb72TxiYVBPidL5Ua91bPqDSf86BqIxnvhuWOiMbBmINGe9SCAmLGR
   A==;
IronPort-SDR: VnXVVK+WpUv/zAtBGykMO7N9uI6sLVVPn8pD7rHkXSN9T6Yz3+Lf8BRhjzp6QD3Quv45G66vbl
 7RJzsBNiHmUDX9TsgRF0TXLcpswJwPJsEaDE2hu2U6sHnIlz9ctQDJXg2aN1iFlA/b8qbqyd/p
 b9PsB6UQHYIbJlaXrHdONn5sP/3P3rX9xpr4yzTFUzgYic3AOETndTxt/iZ2W3VtdO4fzrgPmR
 Q14uwAiwFaV1uDxrGOAlosESkh8IXj8Im1HdzwAZZNnPYkesXIjaVPCkUK65nL6AcaHRt46swB
 NDmcemU75uaksvLjcVgM56lM
X-IronPort-AV: E=Sophos;i="5.85,321,1624345200"; 
   d="scan'208";a="133154958"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 22:27:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 22:27:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 22:27:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojex+yzNF/ZQjoFemlYWYJtDPVOoRc253zlNrXkpSQQAR91fQq2KDCL8gDwv+y+w+HaXxAGC5HVLuTA9Fq9r71Iu6CI7uoEhzj2Y7QIKImMgcHPC+oogn0dmiAQpuBmBn6KDQz63j5d+mtE2fn3YQPSqlsY7JOgkOp6ozljZs75eVmUOFQ6S6/lKdSdDpnnLZalHDfQIZmF/EBrTpOopA9xAVKIf77iH3ibHx85vpBeOZ4GLiKl/B3WTGLsE+QRAuBmFaDOoVbPSZcLnAhCt2l/jfhg87KVHn0FAB0x8/dGdfMlY0pZmjXnjgdyfqJKVmWOhUoFSTjvVkjWTmOCWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CmomWeXEXqXneHDJ4GQpzbTJ1+/x6vkvKAH1gDONmNE=;
 b=d6lz+e1lPAxyH5gQDvdokw8RN9Rzv5QAWMnTDz/FLTC+P7MfPNtHkIzpL/4ZSCBnjxbzDy/Tw5jGsnvXHNt9kO1Z3Cind21ndYoAgXtRhb3a7WOHeCU0tRi4EQwIDroWkP/gpYUxXYLf6taV5UiTzJbN/asp1qW61JiQWyfN6wfNwdCfbYwnlO4pe2f0BJk+EGMrHSK49MwZulMXCd7Bp8z+M+tqIvCakzwA8BjJN411g3Upv5zitAvJ8IwUtNPjYdtTuBDVSZhrraszfA/Y5FDP7PSNjscdxKuIg47VQ5B2WeJRz4zEvj9Wc4VA0QLw0W+Mao05FUIVQe0GTcPVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmomWeXEXqXneHDJ4GQpzbTJ1+/x6vkvKAH1gDONmNE=;
 b=RBuVIB3Acj/9/QkZPzrKiDR0rGhm8wUTjO7vM9hSMiMgLYRcmUL2n7QC+l7cCmxxDZeEZa+yX0JSkUXjy+rMdYZTLO7hBfHqafKv1svNtPjbyZiQFgwjiGf5qfYQ61C6cQ4wNfnycb3aHpJ7yp1UZq8tFu+7in4Qhk/pXmwRCT4=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5667.namprd11.prod.outlook.com (2603:10b6:5:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Sat, 25 Sep
 2021 05:27:16 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::652e:8046:89c3:1ecf]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::652e:8046:89c3:1ecf%8]) with mapi id 15.20.4544.019; Sat, 25 Sep 2021
 05:27:16 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <kelvincao@outlook.com>
Subject: Re: [PATCH 0/5] Switchtec Fixes and Improvements
Thread-Topic: [PATCH 0/5] Switchtec Fixes and Improvements
Thread-Index: AQHXsPrd45zTfENXRE24lSDAW63fTKuzVqqAgADjIAA=
Date:   Sat, 25 Sep 2021 05:27:15 +0000
Message-ID: <8c98f3f042e785f7754db15691d93371d8578118.camel@microchip.com>
References: <20210924110842.6323-1-kelvin.cao@microchip.com>
         <b4908c93-fb43-001b-b3eb-d3da0bb377c9@deltatee.com>
In-Reply-To: <b4908c93-fb43-001b-b3eb-d3da0bb377c9@deltatee.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: microsemi.com; dkim=none (message not signed)
 header.d=none;microsemi.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c77c8ca8-a1d4-4904-87a6-08d97fe52308
x-ms-traffictypediagnostic: CO6PR11MB5667:
x-microsoft-antispam-prvs: <CO6PR11MB56674C7FFE8A033B22FE29328DA59@CO6PR11MB5667.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /nl9HgOvmNXyKiArd5xypwR+v/j2ATDKTxIdKwfiOFcE3dsRee3F6hwrQUus3CrllezHEbMyYCQ0DS7AsKlBRtUgOg3/NF6JvxtUpLQ/Y/U8eKxIq4s8AM09GULzpDbRTRkjChz4gfc2RV+5G8D/Z9NLL8SnHCrzPgtrZhNxD2Bxnff/WIoRYbfrZDv8f8E6eT7t1Ky0ijgjOr0YR9UGeJk6lr8UQypb3kvhSM5brmSKCyJoHmRstmBWX5g5dNFtqdzsa2XRmAa1d4UlzGu4UqF8jwshTpE3wQvRFvuqH3vGjKIYnVkp6Ser1usN9IMjx4BZ8y4dSXBMIlqQL62mo/C4VGgfK7DmGjNhDoLj+XQfxKSmrKphYioYHHATB1m5r4xaAn9OmafZ4oG8077iIPki3pAHtR6Nr1pQRzV9NGAhiOYAG2rVhc0F1BQxAx3S+4XAx+3Bk1ZCH5CYpVT2kbVF8tOoLjOSBv7ypTEF9AUbkz682t1/CcmKEjv6NTqgAZIZYfu9ZjVIIQ5Bx4cI+L+Tfpwg+Jr6oFgU8vR/zH7nYQ2ge6Oq5rIst/p14LHVy06xeEn+lpJ+5Lx3jbUj7CqBOOU74sI3Pkysz6QG/KWBQ4uLeGc4fPAasVJh9BW1LgP6H6yBZgHDiheHly1MjWT2JBE/ghHXvjnsUjCgZdRYO7pOls3mriRacCwEzkES9EyEfoGZDByiHOP3HjdLmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(71200400001)(508600001)(66476007)(26005)(86362001)(66556008)(4326008)(110136005)(36756003)(5660300002)(38070700005)(66446008)(83380400001)(38100700002)(186003)(6512007)(66946007)(8676002)(53546011)(76116006)(122000001)(316002)(6506007)(2906002)(6486002)(2616005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnEySWYvNE1sUnNIbmRDamltZDJZNHpIUEJ3VkdLRHBKN016RWZsN01tM3pk?=
 =?utf-8?B?elRLU2p4Rk0vQm1LN0hLM1FMMGFhSWdWTHFaLzJoaHl0YXpKUUp3aTZKcWh6?=
 =?utf-8?B?TmNZRUpVQUloTnJ0NGNUUWpkRXpVaEhjcktNbWpjMjArdWpUd3FmWDdPMWtF?=
 =?utf-8?B?bmVVTnY2SWZhd3QweE9YbUYzT0I3dC9URVNjVnVGbHJ3MnFMV2xxa0dGdTY5?=
 =?utf-8?B?c0gyWVBmQVdYSTVONktacFdxODYxNnVjSW1idkFOQ3JXalpKRFFIV29qS1pS?=
 =?utf-8?B?a3RtcCtmdWVhTEZNazBhL0lVamdjVFdpMXFhRDhoTENWM2puL3NhRDlUYnJh?=
 =?utf-8?B?WS8yNU9wOVVFOGQweEV3Mm1RK29Id2NtTnU1RWFlcEI0SWJTY2NVNURuNHB1?=
 =?utf-8?B?SFZmenZlOWtpRDRFdElIbk1kM1F4MTg1OGsxVkVxUVlvWUVaKzFDWStCdlUw?=
 =?utf-8?B?SFEzVmsvNUNEeFY2RkRiMC9uVkM0ZmlaZHk5cXpaZWloc0o5M2FwR2ZnV1BH?=
 =?utf-8?B?Vmc2SVdOeFZON1pXNDJHZzVPOTNnS2Q5NGNxMVdmUlV5UkpPeGhjM0k4RklE?=
 =?utf-8?B?ckt2TG5UT1dNdE53bndGVktSVlhzSEkyL0hVTnBwS1hmRTZJNzZRK1Q0TmJS?=
 =?utf-8?B?dWEwd2svY25LelRpcFNGSWhOTEE1Zi9zWlpwbHNmU2RjUUJaenVZQ2F3VGNU?=
 =?utf-8?B?ZHdKelJqaERWU0poaGJXY3NiY0Z5bUExS0NybHNPVFBPMklvZU5VMEwrM3c0?=
 =?utf-8?B?WUd6MmJiQzJQTitxV3p3ZHZvSFVnMmFWWEdhTk5RU1doeUVsOThTV0tNU3Ir?=
 =?utf-8?B?TnBYelpZL1daejdDNWRrZ0VySzVXNldNa25jRmZycXEvR2htTC9PLzNmZ25N?=
 =?utf-8?B?cDdRaGRWY2Y1dXJoZnJyOTQ0cFJrZjJmRW84dlRvUVY0bEhDSFZMeUtHR21a?=
 =?utf-8?B?LzFQWUNIL0NEeWU0Ukhpc09yQkRJQm5lUm5FMGFldFpkc044eDRZZ2Z5ZDNI?=
 =?utf-8?B?L2cxZ2dld0ZlYUl0RWlBVTZwV3hqb1kxS1g5ZzZadGhla0V3R3BCTW1CMHNS?=
 =?utf-8?B?L21IWDc4UDZ3eUw5UmFSdndwMEVKdCs2Z0xHbElVY0lSTENxQW1DcXRpb1dt?=
 =?utf-8?B?VTRsUFFUSG5aSXBOa1ZzRk5lMDdtZzFJcFJaRC9WN3UrU2t1OFpaWitacUpy?=
 =?utf-8?B?Z0xNV0ZrMjF1N3hmZzc1bWpOUXloZzdkRGZKM0VKZ3FrRm1DdE0zNHBtclZv?=
 =?utf-8?B?N2phTlpmS0huZFFwRDB5YU9obGdhUlFXcWxyUjBVMFNFd0JkK1QzMENoK2d4?=
 =?utf-8?B?ZHRZTzdnU2dpK1M1bEl2VDgwdDF1Q0JTd0E5TGFNOWpGYXo2V1U4bDVvT3or?=
 =?utf-8?B?Rk5ScXdpNTNSQmx2dE5acnkxYTFPbnhjYm1iY0dmSWVPTlc5VUN5cU5sUHMw?=
 =?utf-8?B?U0V0b3BrOE1EZ0JpRjFlQ0FNajAyRDdoaFc3RlZSellkMzNSUkNNUjcrcW9z?=
 =?utf-8?B?dm5MaG50QThNMVVuTFJRUy85alpybVEyQXo1UDlLYkF6eDVmMVJXa1VqblBZ?=
 =?utf-8?B?VkFnRzZTcGw5bTA1UnVlUFBOMWl1N0M5dkdNNnJiUWx4MStvOVU2a1g0OUhG?=
 =?utf-8?B?K3VuWG0reExHYXZyMEFTQ05mT3ZkS2h1L2pBaEN5cWEwQWZRMUNKSEhaN3FQ?=
 =?utf-8?B?V2h2RkxZbTFoNWRTbHVLVnl2bFVITUFSRzFOeE9rY0E2UzVLdEliSXdVNUhY?=
 =?utf-8?Q?D2gAHj+OPnelraDV9cKk8+ftSOPe/xCKt92W4bS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <23822C04DCA6F2438C652B0873A0427D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77c8ca8-a1d4-4904-87a6-08d97fe52308
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2021 05:27:16.0321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUDQ1B0DJomfi67oRQAAW+gYsNzhpKRHrNIVZ51eD0de/UZ8YeTo072h1mfkPBD3W+qMv0LE/fCIo4rqIo8wV1MygJISKGd0xow1CX6RPik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5667
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTA5LTI0IGF0IDA5OjUzIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IE9uIDIwMjEtMDktMjQgNTowOCBhLm0uLCBrZWx2aW4uY2FvQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+ID4gRnJvbTogS2VsdmluIENhbyA8a2VsdmluLmNhb0BtaWNyb2NoaXAuY29tPg0KPiA+
IA0KPiA+IEhpLA0KPiA+IA0KPiA+IFBsZWFzZSBmaW5kIGEgYnVuY2ggb2YgcGF0Y2hlcyBmb3Ig
dGhlIHN3aXRjaHRlYyBkcml2ZXIgY29sbGVjdGVkDQo+ID4gb3ZlciB0aGUNCj4gPiBsYXN0IGZl
dyBtb250aHMuDQo+ID4gDQo+ID4gVGhlIGZpcnN0IDIgcGF0Y2hlcyBmaXggdHdvIG1pbm9yIGJ1
Z3MuIFBhdGNoIDMgdXBkYXRlcyB0aGUgbWV0aG9kDQo+ID4gb2YNCj4gPiBnZXR0aW5nIG1hbmFn
ZW1lbnQgVkVQIGluc3RhbmNlIElEIGJhc2VkIG9uIGEgbmV3IGZpcm13YXJlIGNoYW5nZS4NCj4g
PiBQYXRjaA0KPiA+IDQgcmVwbGFjZXMgRU5PVFNVUFAgd2l0aCBFT1BOT1RTVVBQIHRvIGZvbGxv
dyB0aGUgcHJlZmVyZW5jZSBvZg0KPiA+IGtlcm5lbC4NCj4gPiBBbmQgdGhlIGxhc3QgcGF0Y2gg
YWRkcyBjaGVjayBvZiBldmVudCBzdXBwb3J0IHRvIGFsaWduIHdpdGggbmV3DQo+ID4gZmlybXdh
cmUNCj4gPiBpbXBsZW1lbnRhdGlvbi4NCj4gPiANCj4gPiBUaGlzIHBhdGNoc2V0IGlzIGJhc2Vk
IG9uIHY1LjE1LXJjMi4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gS2VsdmluDQo+ID4gDQo+ID4g
S2VsdmluIENhbyAoNCk6DQo+ID4gICBQQ0kvc3dpdGNodGVjOiBFcnJvciBvdXQgTVJQQyBleGVj
dXRpb24gd2hlbiBubyBHQVMgYWNjZXNzDQo+ID4gICBQQ0kvc3dpdGNodGVjOiBGaXggYSBNUlBD
IGVycm9yIHN0YXR1cyBoYW5kbGluZyBpc3N1ZQ0KPiA+ICAgUENJL3N3aXRjaHRlYzogVXBkYXRl
IHRoZSB3YXkgb2YgZ2V0dGluZyBtYW5hZ2VtZW50IFZFUCBpbnN0YW5jZQ0KPiA+IElEDQo+ID4g
ICBQQ0kvc3dpdGNodGVjOiBSZXBsYWNlIEVOT1RTVVBQIHdpdGggRU9QTk9UU1VQUA0KPiA+IA0K
PiA+IExvZ2FuIEd1bnRob3JwZSAoMSk6DQo+ID4gICBQQ0kvc3dpdGNodGVjOiBBZGQgY2hlY2sg
b2YgZXZlbnQgc3VwcG9ydA0KPiA+IA0KPiA+ICBkcml2ZXJzL3BjaS9zd2l0Y2gvc3dpdGNodGVj
LmMgfCA4NyArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAtLS0tDQo+ID4gIGlu
Y2x1ZGUvbGludXgvc3dpdGNodGVjLmggICAgICB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA3MSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IFRoYW5rcyBLZWx2aW4h
IFRoaXMgYWxsIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBGb3IgdGhlIGVudGlyZSBzZXJpZXMg
KGV4Y2VwdCB0aGUgbGFzdCBwYXRjaCB3aGljaCBJIHdyb3RlKToNCj4gDQo+IFJldmlld2VkLWJ5
OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+DQo+IA0KPiBMb2dhbg0KDQpU
aGFua3MgZm9yIHRoZSByZXZpZXchDQoNCktlbHZpbg0K
