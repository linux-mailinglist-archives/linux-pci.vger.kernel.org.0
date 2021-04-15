Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFDD36165C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 01:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbhDOXha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 19:37:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:16253 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237288AbhDOXh2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 19:37:28 -0400
IronPort-SDR: 0+ouTHmYbMIFXfQZ7DaM8MgvRphVqjgiIMe1KsvpU1sN3hU1UCRR5F/VWRbwKhCk6tdZziam3u
 arPsZ8pQ4mWg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="182088148"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="182088148"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:37:04 -0700
IronPort-SDR: V/N08qMkrwaWSz5DKO40MJZrCNTkkPF00r6nP8tV7me9lBMdm1ra7xEGoPxy+0cAofV/iSJb+Z
 nO9yEO9R5hmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="615795889"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2021 16:37:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 16:37:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 16:37:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 15 Apr 2021 16:37:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 15 Apr 2021 16:37:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR+ojJImHkdpBn6SVM7AQwP1BytCveJ8XgANksiApGgUZbMH/ktBFVICUSAami+E8RMUO2MAL++9hJ/Ax+dUxLVOjN16B5QZejqvrlFCxU9KFM7Prg4BK+7pDboHu2vnUOFHkP3QGGKO3pc1AW2vuW0rLbYiJTGfV8G69J7oi5KEA2Pb0hRXsYrNNhZG00rxhB/ywAFmbWWHWF1olGGm5V+l70sAXng2m8nlLMoMiY9TBEu8I1ySE06lhnR7q+yEXmnsP9QrHzKK6D+aCQJcLAEI+A8tZ/m2Jl9sMFHUW7VwlRPIT9ZyP8DhZCx0j/FzCNlmhe55rJbk1zqnwcJe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh7WZKQncCeyHjFO0gshd+S2mPHq7ozQ6E08hEiX5bs=;
 b=JgEgzIACwDx/SjO2JU8RIf0Uk5R+Zq4EXFwKWDD5fiV2VfT8DjnHw2/VpxgGpv/QI6RVOSfF6nIRir7PRyEtD8EAgpnSf4buu89eOLbXFOuAMKZp4JXXBGnAcjUaXSr+T++G174uvZlqyc6IlkIaAOd09drez+jLD1uM0dMDBmCKX1F1As+Q+x010XBE9knaXFzBAyLP6DrtrWFn4Ox/vkBeTUNAsMVnbLeb3M6EEE7LpmPZpWEPMXChOV0zGuO0zwyllFiDV9jQAWyWwU5zPDzumj8A1XO4FwggC1CTMvNSyvHDYssvBIdUcZvs2hnhBKY46I3/g+qYI/4/1v2NHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh7WZKQncCeyHjFO0gshd+S2mPHq7ozQ6E08hEiX5bs=;
 b=dW0t20RyCPQ/UcVEYZB0D3dScmILokMGvqhHqyoHv5dwiIaCGJVOQDxHN9KdjktV2lvEaKSFa20equipsfMB+r5HwGiG6nIgvoIDaD/gXWa7BzRqDtGAB23wMZF1uNXX1EWqzHR4H8jHb0DbzljvxcvWYJbF3Hn67DEKsqGbYv0=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3031.namprd11.prod.outlook.com (2603:10b6:a03:8d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 15 Apr
 2021 23:37:01 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4020.025; Thu, 15 Apr 2021
 23:37:01 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 3/3] cxl/mem: Demarcate vendor specific capability IDs
Thread-Topic: [PATCH 3/3] cxl/mem: Demarcate vendor specific capability IDs
Thread-Index: AQHXMk7BdOBHAJwrwEy3IT39WN89G6q2OUgAgAACkAA=
Date:   Thu, 15 Apr 2021 23:37:01 +0000
Message-ID: <2e570a62f540557d4dda66d90ff73fa841362b45.camel@intel.com>
References: <20210415232610.603273-3-ben.widawsky@intel.com>
         <20210415232750.604112-1-ben.widawsky@intel.com>
In-Reply-To: <20210415232750.604112-1-ben.widawsky@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70771ef2-d5b1-4755-c877-08d900675e9c
x-ms-traffictypediagnostic: BYAPR11MB3031:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB30313D2319A74313305D13AAC74D9@BYAPR11MB3031.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwMYXOBJisX7GWztFwCHsupXTitAO2BB97LlOj5S86qW+f7KcOGc0Vmpm7W7YKUNsbTIRa2SQmVUShZHX/5iKJlVcJJE8wpZeSBySDVCjApew2Qk1tp2t/f28h1aXVntvpEMWyPCIA51SCxMY2s7Udmh1HigAfITbUgatmlTD9ZancmiJo1W4bLCijJ3hgHnkAZejyjeUA1cdK8ucJXjmdxdI+9abcSlUnldi1iWYsRb6ySWn07waxv1NUOY3kHkHrVZQwNT47dNRBYg8xwe4eGM1CVC0GwrXpCup5KobxALK3V9Pie1jJJLhz/re/5yx64tuRfn9uaMcc0PFtuOV6nVUc3rYOaAYJe6a0RssEp/bf2LBszwdIfKXN1n54YqdeaEcfitmBGmwDiLiOiXmV0mrj8PmnY8szlTa09EmmYccvQK/rvfk4vxUcAXTpvVdsqQa35GR2iARYWjz2ZepJK8My/5QVxkKOyfa2Q0I7iLNsg6k4XRZT7BEjQVuNCQVY5Gfa0B++VwzzU859mshTTMaKBifAQB8qhexWO1LJ0Y/3rXOprTH3kZ5SjrNARHAx2D3U5ysIfQTG4uB2++peaND6c3Py6hKU0QomB0DeM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(376002)(136003)(26005)(316002)(6512007)(66946007)(186003)(54906003)(110136005)(86362001)(6486002)(478600001)(122000001)(76116006)(83380400001)(36756003)(71200400001)(2906002)(8676002)(8936002)(5660300002)(66556008)(4326008)(2616005)(64756008)(38100700002)(66446008)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VHBqb2RacW5KRUd5eDd6bWtSeW5OZHBvRTJWMlFLeXhKZEpLT3JxTmpHVTg4?=
 =?utf-8?B?eUpLVkdKVXFXeTEvbFBuTVhCYUlEay9NQ2hyOE15d2NrRVhTM1c0Nkx4aE5F?=
 =?utf-8?B?bnBaeHRCeDJabFFCK1BoblFVb2R0N1crQWZFb3ovcExMTnlBNHB6bDY5TUpY?=
 =?utf-8?B?Yi9JV3lsbEdFeTNhb0tCZkU3bW5EaS9GUjhXUGpPVzZBSUNXcXZqcXM0Q01t?=
 =?utf-8?B?Wk52eURMWjBEazVrSGNScWhwcFVoNmJVU2VKUmVjR3BINnprekxtNk52OGlh?=
 =?utf-8?B?QW92MzJFanEvV1R3YVJWVVVmaXY0VUFkbHVab3JoYTdqSitRK0FNV1VNS1kr?=
 =?utf-8?B?cG5yc3pqdldiK1dXSkhZMUM0ZHpIYTdpRXY4N2JCQ3ZNMDNQKzRUMElNejlz?=
 =?utf-8?B?ajFnZ1JUVUVVTUJFUEhydmJIaC9pK1JnZk5yb2I2T0gwL1NmY3lXRHdYS3M3?=
 =?utf-8?B?eW0xTzFaRVg2Sk13aitrb0JTdSs5VUFtUy9Vb3BtcGtONlRvQTdVTmxLSXNI?=
 =?utf-8?B?N2lNVjZoQU1HQ094emxVa1Z3UUxOaEMrVmRYUE9GM2N1Slk2dnoyNTFGcHUz?=
 =?utf-8?B?alFRNXFDaVdheTlwbktjSzg3dWNaT0dXek02OGtXUXQvQjVpMmdkU1Vic0ls?=
 =?utf-8?B?UEZvMi9GSGRhMGtpRXlkaGlwT1ByTitPUGVlcUlzWERPckFNdkdyMXJoRG4y?=
 =?utf-8?B?Ry9ZMXYrV05iNzQyNm40a0tuNXZ3SUgybTd5a0c3Ym5KUExRV2xFVXRXU0c2?=
 =?utf-8?B?STZ2SVV4bUJ2bU5tOUIrU3VESzdCR0xTSkNUSXowT21GMXFmMGVNWjRkdzZN?=
 =?utf-8?B?SmJySnlKS3RjOEdZZnhjK21ZZm9wUWRPc3BaQjR5RzdhS2cwZGw2a1AxRzUx?=
 =?utf-8?B?aTZpajBQaHZLQ3drdmtuMm1GUW50cG1wVkF6aWtYL1ZoZ3NuZThEZitSUWV5?=
 =?utf-8?B?OHFCeE12OXg0UUh4NWI5SDVVcm5yZTN2SnoxZXQ5anVGc05TWVJwaHJFZVh5?=
 =?utf-8?B?c0ZZdjBaMjYzanM3UHpFMDh1Y0FvZGhMQWY4NjU2V3ZqenhYb0lqWHlzTEZt?=
 =?utf-8?B?d3VJVzVBeFFvb0t3QngxMlZtYjBQWVZsbk9RbzZSRWVVVTlZY09UR2g5SEdR?=
 =?utf-8?B?MStOS2JtZ05OdWFsMzJ6aktRa1M0bURMTlA3RlJEUFU5S0tMdHcveDBuVTdR?=
 =?utf-8?B?dEJIVjBmNk1HUndmeWtuSCtwNGYwbzNaMXRueCtnOVB5TzFORTNvdGwvVzRO?=
 =?utf-8?B?ZjlVWWFYTEx3KzBsdE1nYkluMU80K1Y4UEhiNTloQnRCaEJkMHhkVjlKS210?=
 =?utf-8?B?Q1Nodnh6bXR6TVdjQWFlQmR4c2RCK1dKQWgxZ1JMUzZwNmYxWE9wSFhiMTMr?=
 =?utf-8?B?enVuQS9RY2R2Y1krZnl6bHA2Z3FtQ1hUTTNhYjVwWlRWOElNU0o5SzNkbnFl?=
 =?utf-8?B?QkY4MHJXUXZ4NGZtV3VkTVloQWIydWpyZGxyZjd6aE5SalpOZjkyUExoY2M2?=
 =?utf-8?B?U0dIbUtyQ29tYmhVRFJCNkk5Q0plNHpVMFFCV1I4dVZxb1hRL3JiSEppeVVp?=
 =?utf-8?B?QjR3SHBKNDFmOTBqRlMxSGd6dmNKUU5DRVpONmpPOGI1YTJmR0tNL2lyRytr?=
 =?utf-8?B?L3U3WkwrdjhUaENHZTN5WDIxNTFGTWJQekcrbEU1VVc5cEE5NG5VNFIwL2ZH?=
 =?utf-8?B?NVlLRzhuODljMDh2Zjd2M1hzQkRDeE10d2hWMlhOaW84Zko0NVJZdXo4K0RW?=
 =?utf-8?Q?QKI8ClzOHLolGIE4ggWJ/ntbwPnYUWofSFfnUMM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34519E2A6FAC734DA6CEB847DEF1F305@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70771ef2-d5b1-4755-c877-08d900675e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 23:37:01.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmlJsrjL/OsUI1sev1yVz76CnU30JMbNaXM+nPQq4CycSM/lEg4+sSiIy1oJEIz0f6YUPNpNRhx8z9dZbCVfXvpjmRQPGZ3AVKPkX1so8yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3031
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTE1IGF0IDE2OjI3IC0wNzAwLCBCZW4gV2lkYXdza3kgd3JvdGU6DQo+
IFZlbmRvciBjYXBhYmlsaXRpZXMgb2NjdXB5IDB4ODAwMCB0byAweEZGRkYgYWNjb3JkaW5nIHRv
IENYTCAyLjAgc3BlYw0KPiA4LjIuOC4yLjEgQ1hMIERldmljZSBDYXBhYmlsaXRpZXMuIFdoaWxl
IHRoZXkgYXJlIG5vdCBkZWZpbmVkIGJ5IHRoZQ0KPiBzcGVjLCB0aGV5IGFyZSBhbGxvd2VkIGFu
ZCBub3QgInVua25vd24iLiBDYWxsIHRoaXMgZGV0YWlsIG91dCBpbiB0aGUNCj4gbG9ncyB0byBs
ZXQgdXNlcnMgZWFzaWx5IGRpc3Rpbmd1aXNoIHRoZSBkaWZmZXJlbmNlLg0KPiANCj4gdjI6IFNo
b3VsZCBiZSBncmVhdGVyIHRoYW4gb3IgZXF1YWwgdG8gKEJlbikNCg0KSWYgdGhlcmUncyBhIHYz
LCBkcm9wIHRoaXMgdG8gYmVsb3cgdGhlICctLS0nLiBPdGhlcndpc2Ugbm90ZSBmb3IgRGFuIHRv
DQpkcm9wIHdoZW4gYXBwbHlpbmcgSSBndWVzcyA6KQ0KDQo+IA0KPiBGaXhlczogOGFkYWY3NDdj
OWYwYiAoImN4bC9tZW06IEZpbmQgZGV2aWNlIGNhcGFiaWxpdGllcyIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEJlbiBXaWRhd3NreSA8YmVuLndpZGF3c2t5QGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJp
dmVycy9jeGwvbWVtLmMgfCA1ICsrKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL21lbS5j
IGIvZHJpdmVycy9jeGwvbWVtLmMNCj4gaW5kZXggYzA1NjE3YjBiYTRiLi4yOGM3YzI5NTY3YjMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL21lbS5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL21l
bS5jDQo+IEBAIC05MzksNyArOTM5LDEwIEBAIHN0YXRpYyBpbnQgY3hsX21lbV9zZXR1cF9yZWdz
KHN0cnVjdCBjeGxfbWVtICpjeGxtKQ0KPiDCoAkJCWN4bG0tPm1lbWRldl9yZWdzID0gcmVnaXN0
ZXJfYmxvY2s7DQo+IMKgCQkJYnJlYWs7DQo+IMKgCQlkZWZhdWx0Og0KPiAtCQkJZGV2X2RiZyhk
ZXYsICJVbmtub3duIGNhcCBJRDogJXggKDB4JXgpXG4iLCBjYXBfaWQsIG9mZnNldCk7DQo+ICsJ
CQlpZiAoY2FwX2lkID49IDB4ODAwMCkNCj4gKwkJCQlkZXZfZGJnKGRldiwgIlZlbmRvciBjYXAg
SUQ6ICV4ICgweCV4KVxuIiwgY2FwX2lkLCBvZmZzZXQpOw0KPiArCQkJZWxzZQ0KPiArCQkJCWRl
dl9kYmcoZGV2LCAiVW5rbm93biBjYXAgSUQ6ICV4ICgweCV4KVxuIiwgY2FwX2lkLCBvZmZzZXQp
Ow0KPiDCoAkJCWJyZWFrOw0KPiDCoAkJfQ0KPiDCoAl9DQoNCg==
