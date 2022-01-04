Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23DD4849D9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 22:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiADV2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 16:28:41 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:41339 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiADV2l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 16:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641331721; x=1672867721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ALopYdnZUA8h6oObGxBTqGfpaaMRVVkIqSDMnXdOQx4=;
  b=hZQ9OxxTSvkuEQ2kUYSFmzuEbfVomvMNhF23vBmbv6yD4MrI8hJudg7N
   grkQo2cZGDWUw3dC+bn+xk0woP933FmIpAGiNMB9ulRr5ICW6n56eo4d/
   gk/uYukpuC2DyvCBJCcey54Ha3E1QeMRmS9t12u7y53h+ZET26ox56Fw4
   S+IrP/etJUXigtflDnZvBBqHpQkzhKOfoiIS8NNLWKZUFEgw+R8wC635c
   P0GLd5o9rmSbL9aI5QmAJAZD61BNCpuwY8burYkUCIFm0J2K9KGQuzmIN
   t3bMNsicJE3xe2kDWZ12P9SVLv8oI0BGII/PQGVhrMnA/eQbIafaQQmEd
   w==;
IronPort-SDR: jYYPbQldhE8+lCOgzWqs1RLCxmNh1E3vY/aLo5R6qnimmwuXadEAFb+cIkxprG1e9vQC0NRfz6
 k9XgI1t9BpQCvRwkXWI0OuWBcNGK2nFsnRll8IQISNNfE0FBhGc6a83HoFKiSmtOZe4zMuOMET
 6JJT2yWNpYfSRUVdXJn1R14K03Iz6ev/ZXyHFk4ijSpZIsPedK7ReF8VkMBvBqZOXyfdQONod8
 O+o31ofrW93xv4OcTIOW/DtExz7mFbpk3jtZcxrVhxb5ktgqabhe6WJXXlq/xQrmBPJE89XIuJ
 D0mtAK7Sn7DVP48nCJCHiwWD
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="157521558"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jan 2022 14:28:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 4 Jan 2022 14:28:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 4 Jan 2022 14:28:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWNpdhnY3GSjEBtFPu2Vz0gNyrs4B4NqUtUv423JYWRx/oVOm6wwJAvwaprSf57kCs6OAXE4RBl0sITB42IL5yDBRWosIM+cMmHUxzRKMNRd2rmy4ShXjwsC8Ex9Luw/omqq2Xeq1bUZ3ZLNG9W8C31hKNruCFgOoe8Z9eqamU2qV5l9AZP7hK9XwCCkJ5vFfxZzW2Ol+7hDEqveEC3X38QdeabmJav9UgKq2yi6dDZgqV/Q1agt079kjwt9frPruJdvGQuBmN6A3VJZaPcJ1qDug4Tj3bhF+OV4TKPqk9Oq+STy8aNVW1NfJB6G4Mr0MW8umlkZiYEL4OZDNwut/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALopYdnZUA8h6oObGxBTqGfpaaMRVVkIqSDMnXdOQx4=;
 b=MU2DlwJaiBzmboqaYRI5Mq2sN//o/GywCfNGXErN4WN0WUctew13YGBQa/FE81dt/Ta/N+aamzPDIEtryRHY2F7ywZ2R1zcbA42oLJj9k1d78l4ITlbrlPsIsL7n4hYVJNi2b5yEddZKIqfKIkgpXITdWWqsp/5I9ft0+ypGR4b1D4Tm34sGGfexTcKbxQbPaTrb4URtWzuplHyxsIOr6YYgQInBfCVdxWsGGVkkHD7lVIFBiewwYKIbrBCT4sufaqlSkP6DtKJr6eGhnPdx8XcOAfEhKWzQhRb01gFgzhb64wgnXpeZ7oKMNsrKZeoxVXdPmKzomhLU7nlmlgKMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALopYdnZUA8h6oObGxBTqGfpaaMRVVkIqSDMnXdOQx4=;
 b=OujJD/wqHfW2pZaOwPdagvxzhLg/1ukfzu4fN+iEjMHwHoBtxHHuLvjpmQahqrKs8xyL6kVl5AkETiZ4fj/aEjau8d/UiBYspuzt+ynboOYYLrE+GFF0VNgJxJZQNFJZj5TraaK9T7JMZeWTK0Pu4omezFBIoMlf11fZdvPvQJw=
Received: from SJ0PR11MB5629.namprd11.prod.outlook.com (2603:10b6:a03:3ab::13)
 by SJ0PR11MB5599.namprd11.prod.outlook.com (2603:10b6:a03:3af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 21:28:30 +0000
Received: from SJ0PR11MB5629.namprd11.prod.outlook.com
 ([fe80::28a8:253b:8957:814e]) by SJ0PR11MB5629.namprd11.prod.outlook.com
 ([fe80::28a8:253b:8957:814e%3]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 21:28:30 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <linux-ntb@googlegroups.com>, <kurt.schwemmer@microsemi.com>,
        <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-kernel@vger.kernel.org>, <logang@deltatee.com>,
        <linux-pci@vger.kernel.org>, <jdmason@kudzu.us>
CC:     <kelvincao@outlook.com>, <jmpallotta@gmail.com>
Subject: Re: [PATCH 0/6] Switchtec NTB Fixes and Improvements
Thread-Topic: [PATCH 0/6] Switchtec NTB Fixes and Improvements
Thread-Index: AQHX+GUbrTDHYG5Daki3qpAU+gGIWaxTJuwAgABL2IA=
Date:   Tue, 4 Jan 2022 21:28:30 +0000
Message-ID: <41ea955218bb9fa42e59e106b7ee4e2c9c69cb3d.camel@microchip.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
         <91ece4bb-5ab3-4ec9-acb0-0b054d4ec435@deltatee.com>
In-Reply-To: <91ece4bb-5ab3-4ec9-acb0-0b054d4ec435@deltatee.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98604e28-abc8-4ff2-04a9-08d9cfc9273f
x-ms-traffictypediagnostic: SJ0PR11MB5599:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB55990937889E1C859A90F3498D4A9@SJ0PR11MB5599.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4afWrZO44WoG6l3L6Cwo93Anq+CRjQYyL//pvx/lp7Z0CcxLUh6uhW1ApPzknPcUJ/IoMXgu81krpR3Ksjc6b2KrgMLYFzYG3cU/7PREgmp1LMAq0DmLAVPLDdIENyNDay81vwbVmwBfG6EQYq665qvjsD1oKsUYSDLZ1DMIDdK0zv25ZlYHUlHuN7/fn/MQsmDlR7zKiMPTCilGZwM6PSIeB+NJ45aFFw2s6EyghDaji5ELucbdERCrCKKU6fv0hAoPcj1wBRGCUB7BLtkl3PVSBJMa53LTwT4VGhxDAgI9DMn7x45+zIcDZk22QtelJ01zIVctFxfPPABeH/h1+PF4dSsQtDtSQmaFp69gUfiq0lSvuj7I9k9IUS3g5aAsoqwZ9Txu73oXc8g8D/8Uq5yS4CkkNnoKHMF0xyvE6gFOiyXHCWMe230jt6KXDALtPfPQ8VX1cB0A9hudkhCBBtWmKiBwQIF9CS5GNy4tCiR9ku+7stLs+4wM3/kOQUtEqhRDKIqGNEPON7Q70AofKkCwOXeKf+gRS3Xj/78ILZN0s6i+irVtzWzgbDFJN4FKSZmJz3HVgcgAY13IcCWf4u2h/w4sGEI175Ptpcrk1G1JNLGnpOoi7HPI3lkmAVwAfQ6z5WhO5TUk94oUAaJNO/A1sDnH0hodbeobOntr4R3vC7tgLtKoYOzq6u13JObVtdUo9Ui1Vfkx5COkGuQojw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5629.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(316002)(4326008)(66476007)(76116006)(7416002)(53546011)(64756008)(66946007)(91956017)(66446008)(6506007)(54906003)(71200400001)(110136005)(5660300002)(508600001)(86362001)(6512007)(8936002)(36756003)(66556008)(83380400001)(2616005)(26005)(4001150100001)(122000001)(6486002)(186003)(38070700005)(38100700002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHVYNzFuWnNhVHJjWEdaaVRGWHY5MjRULzQrOGtXU296bENNd2VXQ09BRXFU?=
 =?utf-8?B?a2RvMHpIcm9RQ3dzV1kreTh2QVNYL2N4UWEwMFdOdUNRYU9OTnluai9tK2ps?=
 =?utf-8?B?MFRBbDRWV1VCQkdGdGhzeS9FejUvRk02cTdxay90d0lZUUZXODdpSVkzSHhG?=
 =?utf-8?B?dWEzQzExTUpheVYxVGhMcnhGOHZabnFIU09Kbkc1Ym5CZkxOWExQTEJXemhJ?=
 =?utf-8?B?eEhqNDBTYXN2RDB0Ykxxb0wzazZjWFpZM24zbmQ1aEFkWXdYZk9mMnFNdjlX?=
 =?utf-8?B?YUtCSGRkM0p2TWFRbDNvaFJ6bENaL0ZqUmRYZE1nbm8xRDAxTmxaR2xtV1E3?=
 =?utf-8?B?TUE5b3U2dDhuUEJSN0hsaFRaSnh0Uk1UQUVROElPdkQwMU4zd1djWExIR2N6?=
 =?utf-8?B?eVF4YjRNcFdUdHpkR000dVdtKzM1VUNxQTFIelZ3bTZIc1c0YmxRNGt3VnV5?=
 =?utf-8?B?VVQ2ajJBa2FrMUxVY2VSeWxTUEwvT2l6b3UwV3VLcFZIRHZ1VzRqRHgyYWFY?=
 =?utf-8?B?TC9zdS9OZ0wvclJjKzhGS21LL1c1dU5jRlZXdXFuS1JUL0E5cFFNeTNxRjhq?=
 =?utf-8?B?MnlTeUkySmhnczlLdkR4ZVR0OGN0VkNLUEZ1bHlROXBuK0RPSjV2QS9PbEVI?=
 =?utf-8?B?TlI0ZlZiL2VMeGFYaXVvbC91MzNNKzhYbXRteVhPUGx2UEFibWQ1RXRCM01B?=
 =?utf-8?B?NElUcGNDMnlmUHhQRDQ1L3FUU2grSFhBaTNOQ1NkV2VnbUhsQmYvTm9talJu?=
 =?utf-8?B?dzg4QWNFUnR4Tlg3ai80a09jUXVHdTdUUG5TTXUyMG5zazc0WUJUQUV5MG10?=
 =?utf-8?B?OXlDM3JxUFBsTTZiSnRhcStkR2UrMUNlM1lEcnRLQThRT1FkTlZGWG5KRHp5?=
 =?utf-8?B?T3ZkV3hmckZyM0h6eXZpczBxQW0zcE53TGs2SVpIaS9lM3EzcjE2YS8zSzVz?=
 =?utf-8?B?MDF4aUYzcTA1b05vUkE1VDVZWmpyL0paZCszclR4S1lNZUU0QSs5Y0VvWUhq?=
 =?utf-8?B?emxrYVQ1VGM3MUVJVEZSbmNQanA2eWg0aGVRbDZrSzdUNnBSN3cya1FzRkpv?=
 =?utf-8?B?OVo5V1JQRUMyUExxRFVST0N4Yi9GdHdLbENkcWVNeTd1VFZ0Umo0dE4xTVZD?=
 =?utf-8?B?T0dMRUtXdkdLbmVIMllSSEpmU2NJNXNIOWhaYTlnb1ZUWXBPcTVzSStXbEhi?=
 =?utf-8?B?M0hQa0Q3MnUvMmFMa2J6eUJsVFZuU3NKVnhEa3NUUTlxQVdvM1VXbXkrVTgr?=
 =?utf-8?B?VXFsM3c1NngvWW5KdGZRM2dqT1daeGR1bDdNL2twWW5KRFVoYkViMTljMW0r?=
 =?utf-8?B?Y1E1Wk1TdXFYUWk0NmJwNTBwY3lMTzRpU3NpU1drYzRHSzZDL3paS3daSHVJ?=
 =?utf-8?B?WUZKSWZzaXl5TUkwWkl6T0lMVTdRSnJheFFyOG1sR3hwRFlYdzlZVDZyL0Qw?=
 =?utf-8?B?bytmSmtXYkZPQ1I0UU1rUHY2RmZFL25UaFVOWUlFMWlEK056dHpJVG95L0hq?=
 =?utf-8?B?Z1gySWQyWFR4U1J3NjZHV2dndnREZDNvMFVvS0VKT05BKzV4MjBnWmlPaEpI?=
 =?utf-8?B?Zm12VVEvZ0ZpT3VaalZPZzR6MDE1ZWMwMVh0Z2ozdEdTNzkyT2J4dHRTV2tk?=
 =?utf-8?B?VzJ0elNMUWlBK0NPUXo0SDRPNXRyZW5WVEdsWmk2NXlLSVhNMFFpRTVacVdh?=
 =?utf-8?B?WnRJcjI4ZWltZDhaZmdUb2pnbS9FV0l1Um5HR3NaNVR4dTIxV2RyYmI0ZVN4?=
 =?utf-8?B?ZERTbDg5dExBMmZhbWsvM2dwMG00VUtmRE1zM3JCbVF0V0phdk5GWEEzMCtU?=
 =?utf-8?B?bGpPZkFwYzJ4UDVqOXc2VGVoSGUrTElkbzluZ0lYeXdLQWVTWTJXdFpLVU9H?=
 =?utf-8?B?ZHBtY3hGdHZoU1NuamV5Z0RERTRudUtCczc0SG5CR0xadU5Vb295ZXRXS3l6?=
 =?utf-8?B?QzZ2QnpkMTB4ZWs5NnpvM2pmbTVDK1Y3cjZXU25YNFJXaUpmMXFhK3UxRWlS?=
 =?utf-8?B?N2xYdVBmbGNYVDhuVEVLWlVLNDhpTXpUaGtkY1Y0aHBFaVcrYWtMZUN3YWZE?=
 =?utf-8?B?Q0JYZC9NZ29ER21WakUrRUtSb2dpSDV6S0tVWUcwZ21kZmZDRnVOUU5FWFFu?=
 =?utf-8?B?eEZMOFlDaEdkSWF3QmZERWtZczZERk9vazhrNXBWWXVjbEE3Nk9SVXBQenpr?=
 =?utf-8?B?aENpZmJIYjRrSlJQdzgvdURNN2hwQXNPYU0wWWVpV0krcG9iSjJVSE9Dakt4?=
 =?utf-8?Q?DYvZ8te0+4foxiLOfQDRwhy45u9Bl3vhTWdPvF//3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DBE65673B8B79429C11FB6484DD176A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5629.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98604e28-abc8-4ff2-04a9-08d9cfc9273f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 21:28:30.2361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmOFbHw0ihXQQGY6qY1tRZKDaCNjUkj0hATKrRJEN/fODh/WPDGgcOHTUrpDJK8o2C+IzY7lVqyDNllkbOq8iDUte3Hxp64apoHI9noPUj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5599
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTA0IGF0IDA5OjU1IC0wNzAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjAyMS0x
Mi0yMyA2OjIzIHAubS4sIEtlbHZpbiBDYW8gd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gUGxl
YXNlIGZpbmQgYSBidW5jaCBvZiBwYXRjaGVzIGZvciB0aGUgU3dpdGNodGVjIE5UQiBkcml2ZXIu
DQo+ID4gDQo+ID4gUGF0Y2hlIDEsIDIgYW5kIDYgZml4IHRocmVlIG1pbm9yIGJ1Z3MuIFBhdGNo
IDMgd29ya3MgYXJvdW5kIGENCj4gPiBtaW5vcg0KPiA+IGZpcm13YXJlIGlzc3VlLiBQYXRjaCA0
IHVwZGF0ZXMgdGhlIG1ldGhvZCBvZiBnZXR0aW5nIG1hbmFnZW1lbnQNCj4gPiBWRVANCj4gPiBp
bnN0YW5jZSBJRCBiYXNlZCBvbiBhIG5ldyBmaXJtd2FyZSBjaGFuZ2UuIFBhdGNoIDUgcmVtb3Zl
cyBjb2RlDQo+ID4gdGhhdA0KPiA+IGRpc2FibGVzIElEIHByb3RlY3Rpb24gdG8gYXZvaWQgY29u
ZmxpY3Qgd2l0aCBzdGF0aWMgU3dpdGNodGVjDQo+ID4gY29uZmlnDQo+ID4gc2V0dGluZ3MuDQo+
ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBpcyBiYXNlZCBvbiA1LjE2LjAtcmM1Lg0KPiA+IA0KPiA+
IFRoYW5rcywNCj4gPiBLZWx2aW4NCj4gPiANCj4gPiBKZXJlbXkgUGFsbG90dGEgKDIpOg0KPiA+
ICAgbnRiX2h3X3N3aXRjaHRlYzogRml4IHBmZiBpb3JlYWQgdG8gcmVhZCBpbnRvIG1taW9fcGFy
dF9jZmdfYWxsDQo+ID4gICBudGJfaHdfc3dpdGNodGVjOiBBTkQgd2l0aCB0aGUgcGFydF9tYXAg
Zm9yIGEgdmFsaWQgdHBhcnRfdmVjDQo+ID4gDQo+ID4gS2VsdmluIENhbyAoMyk6DQo+ID4gICBu
dGJfaHdfc3dpdGNodGVjOiBVcGRhdGUgdGhlIHdheSBvZiBnZXR0aW5nIFZFUCBpbnN0YW5jZSBJ
RA0KPiA+ICAgbnRiX2h3X3N3aXRjaHRlYzogUmVtb3ZlIGNvZGUgZm9yIGRpc2FibGluZyBJRCBw
cm90ZWN0aW9uDQo+ID4gICBudGJfaHdfc3dpdGNodGVjOiBGaXggYSBtaW5vciBpc3N1ZSBpbiBj
b25maWdfcmVxX2lkX3RhYmxlKCkNCj4gPiANCj4gPiBXZXNsZXkgU2hlbmcgKDEpOg0KPiA+ICAg
bnRiX2h3X3N3aXRjaHRlYzogRml4IGJ1ZyB3aXRoIG1vcmUgdGhhbiAzMiBwYXJ0aXRpb25zDQo+
IA0KPiBJJ3ZlIHJldmlld2VkIGFsbCB0aGVzZSBwYXRjaGVzIGFuZCB0aGV5IGxvb2sgZ29vZCB0
byBtZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRl
ZS5jb20+DQo+IA0KVGhhbmtzIExvZ2FuIQ0KDQpLZWx2aW4NCg0KPiBUaGFua3MsDQo+IA0KPiBM
b2dhbg0K
