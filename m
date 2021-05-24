Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DB238E5F8
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhEXL7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 07:59:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:34307 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232655AbhEXL7u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 May 2021 07:59:50 -0400
IronPort-SDR: FmqsQ1cEFuT3HqTWeIZqzagyoiZ6NJZ30fy4tJ5rR2UNT+kvuCiFBtkjKbH7JpIHRaqUaAO6mL
 YZvPX/aW19mQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="181554276"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="181554276"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 04:58:22 -0700
IronPort-SDR: 4IBRetXDxZ50QwbeWsviWwqU83blhCKwTI8JL36Pi9uICZrNtsMTCY7iFTuJolqssnI66U8bxr
 F8T8xlZL7tDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="632599108"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 24 May 2021 04:58:22 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 24 May 2021 04:58:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 24 May 2021 04:58:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 24 May 2021 04:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxPc58N6eUulkm5BGcTR2jQtZEzsCvU7+p3CMjdAb+kZOqlLZ3m7wvfvUwpjgP61GVnJFY5pa+hVVYsTh664hNQ6APJLR4ii/OmOMVB0L4Id5CShEMdTzUQvdWmJixh/ZrYCZoKLOyW2Rr0NfSfdSSFXBrKjX59sdmfprX/Hl97Lgncb4pk4xLUoFbpAht2cuaqVyqVk0xD3SN9zdrSkAZj5PxNh1FkTGYcuImuxilB2zld4OVTOCi27fiuioyZk2z4/vFEzNbrf2Tj04x0A00eF93C+WRj2SJ/gg6m3paYCrwS6c3lAt4gI08rH6H3l+da3GpdqedmpdQNuYBH6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptg2qyVCrURzZZk6+caCXIT3/PYNQlpBUg4AIMynbr4=;
 b=jOCw9UZ+A0V6E6IrnFKE7Q88ajmRvIUwUqsABPIym7FgWEXJGcke4vcRHa18ncGBzvbyFljNUNtRPzTjpp7ukPdBQGm0c4K3soCp5kKI8Vp68B67Uimp1fYUB47ddAujPkin+zFRNMv7h7L4PMDPgYZLZJ0+dBlNB6LtjhO54eoRSUeNyKcE/xfCyi4I59JdSCUeVF6Sv36tNocmMiVZdE0oRheMwUgT06GYWE7HC+DgWl6mhGmu+qCjr52xODhAbYpn976rJJkXi5UuzHEEyEoBquRFVGWvi/MscKrf23QclqBTq0SmYYO055AuQ8d3oMgCE8Fx1xH36b5lRDa1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptg2qyVCrURzZZk6+caCXIT3/PYNQlpBUg4AIMynbr4=;
 b=q4ovhlekSoy5Q4pA3ajr7CuXCCnH81/6J6tKLnIKGSf9/mOocf93ruO9pOCFyiMMtC1MO4S8v1G18SpkW7LrgUOcxg9alFYQ3a7v1Sh/5t588aza3sM887akrBVEKnfBKGTgKy2IoOfPKQMtHhOxRN91aBF85vQmJasoDaXOuP8=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5641.namprd11.prod.outlook.com (2603:10b6:510:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 11:58:19 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::e07a:5095:a1a3:2667]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::e07a:5095:a1a3:2667%4]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 11:58:19 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v9 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v9 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXS7R0SyffA1wN50iRs2LKxNotJqryeDaAgAAUMkA=
Date:   Mon, 24 May 2021 11:58:19 +0000
Message-ID: <PH0PR11MB5595DDC966EF6BFE3B9A921885269@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210518150050.7427-1-srikanth.thokala@intel.com>
 <20210518150050.7427-3-srikanth.thokala@intel.com>
 <20210524103027.GA244904@rocinante.localdomain>
In-Reply-To: <20210524103027.GA244904@rocinante.localdomain>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [136.185.183.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d9357d7-e9b7-4b83-768d-08d91eab38fa
x-ms-traffictypediagnostic: PH0PR11MB5641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB56418F63A777ABA62A07203385269@PH0PR11MB5641.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +8pHNuziOBeW3NoWKf1iebHsOnLcohaVMMkKE/jweVxLR6pqtlH/mdh/UY4Xt07XYrJo9lHpSEglANCQBsnTBadmtOg8cxjB2OF7b5ElzBdiSdHd47xDhWTieFogcfiXKGnXgzVTbwgtVM4eN9Rd4+CyNv2Vvx7+RA4gfSMGCPVSC8dVnhp4Ee6rG5pv6p59qFGfnQBy+MPkkSfWKZY5i1celaBkxhSPya8efJXNdzY2YRhxgMREUdvVLEmH16bmMI8cSI1LI9Z724Teu9qJjdbiumNIlwJYa7eCYYAm9GnX3JNV0VsXMRSNBznS5j+xcNQM3MVaBZz25hINSvjK6pUeRFdDlVdTsOSZ1ZeTwPST1xrq2juZRQAmCnUsLZ4AplwVCsxin+IMNWOLYzji0+Zo4GjFPFCH74YSHGt0rh6FV1vS8du14eSlC8CLcsHOuz8FXbRUDbE5sXqbjWB8D8Pr5NWHYr6Xg2N8MYGsbGMhuxi5WnQCgvH+fKwbLsHZ3vdb3vt+yJFhTte1BRAeXo/Z8xm/jXI0tlBj43k49m4rh+jsi1OFv9ZZU6h4FwpPmLJCaJYySqaV43+1rELsUlvclJV7/nOuGFDNHoj0lwY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(366004)(39860400002)(478600001)(9686003)(86362001)(2906002)(55016002)(64756008)(83380400001)(66556008)(186003)(66446008)(66476007)(33656002)(66946007)(52536014)(76116006)(38100700002)(122000001)(66574015)(26005)(53546011)(54906003)(6506007)(5660300002)(8676002)(8936002)(316002)(6916009)(4326008)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2dDa0pOSTkwbi84M21UWERiZUxxN01mNElNZFJCUnByaDlsRFNOOTRIa25O?=
 =?utf-8?B?TzFpT3hvcnhqTmpwWWoydHV5NWI0bVFncDIxV2hOVUsvMGw1REJrb2pjSXJo?=
 =?utf-8?B?Ykt6U2Z5SjVUNFR0b0s4K05BQVZWZjRYUnlVa3FKVnZ4YWlyKy8zQWhQdE1p?=
 =?utf-8?B?ZzUxRW1iTmZuZml5am9Kam13dEhqV2FwVkhxcnR5aWpSc2diQ0Q5Nkw0cURn?=
 =?utf-8?B?YWg0cjNYM2Q2bXYrTWZHNVFnWTVoR0pPMVpmRnZucmRwR2tjK0g3Wnc2akZw?=
 =?utf-8?B?bzM5K1kzcUFHRDVZYlFHcVlUK3krU3ZCci9qRUs0U0g1b0pDU3I4a3dNVlp3?=
 =?utf-8?B?SDArdVlPZnZyWWVuYWV3SE1WSWhuYlNaSytUUWV1YUluS2xMWVFMRzJPVGhX?=
 =?utf-8?B?bG1KZzJuYmJKMWVidVJsTUpkWUkwSjFrQTlFZE01OXRTTnVMOEVwdlUrMWxW?=
 =?utf-8?B?RnBOOC94MUR2MEh2eEp6bUtHOVlFaEhwWHBZMTNRVlV1bm0weHlIYzNrK0s4?=
 =?utf-8?B?RHdjU0ozeFFnTWNzOUYydllXN0tBc2tNaXZySGlYdmNybnFqVnhsRzFxZitv?=
 =?utf-8?B?WWN5QXp2bTd3by9OVk5rK25UZUp3Uzk3Qzl3TytFamQrRWZTVkVEZ3h5TE5Z?=
 =?utf-8?B?K3hGVmtSeE9vRmlMTHhobFc5dFJjOXNyOFZqYTluVWlpOXo3S01POHNmMmdK?=
 =?utf-8?B?N3o4MGpZcWdUVTE3eWNUMWJoNlgxMTM5VVBRcTBDWmVoRmhpa2trcmFDMjJl?=
 =?utf-8?B?cFlqOTRLYzJtTVpReTJOT2l5WDhFVzdtdjVKUTRyK2h6aHdxOU1XZEFvT2xw?=
 =?utf-8?B?cFRUSHNDd21wRXFPMmNsd0xENHZBUllCLzR1VVg2NXlWNGF0WVpWc3UvMEpB?=
 =?utf-8?B?dGxnNzZxNTZxMWtsYkNqRkxOZjZPbitGWmtzY0FlVjBoSHBtemtwTjdMK0dC?=
 =?utf-8?B?U052VW91WVNGTmswMHNjK0ZRTy82SGtNMXR2WXErdTl3VUpySVlSVzdNY0Ew?=
 =?utf-8?B?WnBkcEkrRDRpRkpXTEUzQkI3ckJQYVFXby92YUVhYWRuemJad2VYekRlaU8w?=
 =?utf-8?B?ZEVUQllWMnQ2aEphYWZPazY2VzYrbTNFeGZRT0FJVEk1U0tMQ0pibGNXeWN2?=
 =?utf-8?B?NjBKWUh3NEloVkZmWHR0QXR2WHlvSTI5NUhKM3RQQXJlYlNiSzZ1K3FqV2Zl?=
 =?utf-8?B?TWJManFUdm5SZTkwOFUzaks2WFNvTHZydUZFNzE3UmJlRVNvaG1tOWZTUlFj?=
 =?utf-8?B?d1NQN2dUU1JNcXR4eEJiUDFVaUZOdzRHbGd0VzlxYTQwVGREQlR2cjk0S1Vt?=
 =?utf-8?B?SHg4NnNCMTg4UVNoQk9lR096d1VKQ1ZrNE44a1JnRDRaQ0dpenc0STJxRVlp?=
 =?utf-8?B?SUZkREIvQVZCRkNPWnhNNmhWNktHMnJmWVlQTHBNajhicFNXQUJDczZrRy9r?=
 =?utf-8?B?MWxQSlFNYmEvR1FSWUJCWXlSU0FycEtaTm9UL1BKanVmZmlRbFdrWThTNGNw?=
 =?utf-8?B?M1ZackV3ZUdwWDBTZGxHaWY4Skt5enUxUXFNVnd2WXpwS2RlamJGS251aXp4?=
 =?utf-8?B?MWoySWJlSlFDUWVkMmIrRUJGV3I0QkJra0dteW12ZHBIWDhXdFJ2U2MwcW9Y?=
 =?utf-8?B?Q1YzSzZxaWk1ZjVYcjR3d3dBaFdCeUFJeXhrSWs4bDFtQ0NLczhoWWpKMllh?=
 =?utf-8?B?OEZlaUtkamhLL3FUdXhqdnoyU1VXZ21tQ0l3Y1JtVE8vR1I1a2NjTzA2aVQw?=
 =?utf-8?Q?iTksboIXtVVUEEbeFXELX2Z+HecZODemlGLoL1E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9357d7-e9b7-4b83-768d-08d91eab38fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 11:58:19.3138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yn12Y8Y4825mi64dA/lG4cMdlWa3jPR3dq+NnQ8w4h+Jx8hz2r5QHehZNJ7M8jCS+z1j4aw2e/shzsSIiR15L7OquA9VPcIrvRDUQtkeHnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5641
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPg0KPiBTZW50OiBNb25kYXksIE1heSAy
NCwgMjAyMSA0OjAwIFBNDQo+IFRvOiBUaG9rYWxhLCBTcmlrYW50aCA8c3Jpa2FudGgudGhva2Fs
YUBpbnRlbC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb207IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBtZ3Jvc3NA
bGludXguaW50ZWwuY29tOyBSYWphDQo+IFN1YnJhbWFuaWFuLCBMYWtzaG1pIEJhaSA8bGFrc2ht
aS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+Ow0KPiBTYW5nYW5uYXZhciwgTWFsbGlr
YXJqdW5hcHBhIDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY5IDIvMl0gUENJOiBrZWVtYmF5OiBBZGQgc3VwcG9ydCBmb3IgSW50
ZWwgS2VlbSBCYXkNCj4gDQo+IEhpIFNyaWthbnRoLA0KPiANCj4gRXZlcnl0aGluZyBsb29rcyB2
ZXJ5IGdvb2QhDQo+IA0KPiBbLi4uXQ0KPiA+ICsJcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jl
c2V0KGRldiwNCj4gPiArCQkJCSAgICAgICAodm9pZCgqKSh2b2lkICopKWNsa19kaXNhYmxlX3Vu
cHJlcGFyZSwNCj4gPiArCQkJCSAgICAgICBjbGspOw0KPiBbLi4uXQ0KPiANCj4gSnVzdCBhIHNt
YWxsIG5vdGUgKG5vIG5lZWQgdG8gY2hhbmdlIGFueXRoaW5nKSBhYm91dCB0aGUgYWJvdmUuICBT
b21lDQo+IGRyaXZlcnMgYWRkIGEgc21hbGwgd3JhcHBlciBmdW5jdGlvbiBhcm91bmQgdGhlIGNs
a19kaXNhYmxlX3VucHJlcGFyZSgpDQo+IHRvIGF2b2lkIGhhdmluZyB0byBkbyB0aGlzIGNhc2Ug
YWJvdmUgd2hpY2ggaXMgYWxzbyBlYXNpZXIgdG8gcmVhZCBhcw0KPiBhIHJlc3VsdC4gIEJ1dCwg
dGhpcyBpcyBqdXN0IGEgbWF0dGVyIG9mIHdoZXRoZXIgaXQncyBuZWVkZWQgKGUuZy4sIHNvbWUN
Cj4gZXh0cmEgc3RlcHMgd291bGQgYmUgbmVlZGVkIHRvIGRpc2FibGUgY2xvY2tzLCBldGMuKSBh
bmQgcGVyc29uYWwNCj4gcHJlZmVyZW5jZS4NCg0KSSB3aWxsIG1ha2UgYSBub3RlIG9mIHlvdXIg
c3VnZ2VzdGlvbiwgdGhhbmsgeW91Lg0KDQo+IA0KPiBUaGFuayB5b3UgZm9yIHdvcmtpbmcgb24g
dGhpcyENCj4gDQo+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgV2lsY3p5xYRza2kgPGt3QGxpbnV4
LmNvbT4NCg0KVGhhbmsgeW91LCBLcnp5c3p0b2YsIGZvciB0aGUgIlJldmlld2VkLWJ5Ii4NCg0K
U3Jpa2FudGgNCg0KPiANCj4gCUtyenlzenRvZg0K
