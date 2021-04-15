Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF01136164F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 01:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhDOXf1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 19:35:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:10278 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235216AbhDOXfZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 19:35:25 -0400
IronPort-SDR: 4gu8FLP8gR/8y/qtCtpG7UsczqMYQiXGkeZPC1BQ8x9uWvyQ5Tw3X1VCZQw7+uLfTQBmiDiepd
 iFtAb4TuWeZg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="191774075"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191774075"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:35:01 -0700
IronPort-SDR: HLbap0Tf+0XTuKmIzhv+o+IQl5ps7Sgjcnhw5pyqPKmrH1b34CW4mECWSV3PSET/4oBjxXqM90
 yXWYlrVOpyeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="425378065"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 15 Apr 2021 16:35:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 16:34:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 15 Apr 2021 16:34:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 15 Apr 2021 16:34:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K00aq5B/QY8q/c3mxGobyacYLm0KGbs8EAi++Q45Vg/nbUBb6WM8eJqowz/PPePDuYm8THu9qoCx26pDVCX/3HR4oJ5qCFrw/7OUPnhjzdfx5hz0+RVWvAW3s1gcYATZn2c9bmh+kpP4Oxgr7Tgr7GimxOg39YFJA8DmZaGIR8yuV38DrwwAVGhKu0o1M6CgCCi6DbEfEkHZoZEXAhQ9uZW8IhGw8pwmWqxNb+EsuV/mgj7vCP8SBDoX3t4SyXB031AuVb8YuMi6sPX8Y1AG+xMuVfxoiWfHqmV/5hL+n4dzz1sgm18eiyIfL25K3R2sOzXN7b42uf42imNsqeyAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbS1d3gLBZA9tbFWTAp3NtKJXPrwxUaKzr5SEJu5tqI=;
 b=DfQ39cKdU+yMLNqL8QvibCi/Ks7abJIiyGdnJQvFSsezpTgBTD+GG3RWlM4qhr4w/QyGh3VUn4/xthgTb6GbJkGcvkv8ON9hyD+6TwiyAvyl4+HxhUt0FF9xNeZ9ZvTsM+QxNXxMj2Vc/vJIHw+vLqilFUfWj7sInlQfep7HOtOnz8LBEOqShgvuNAN0GGWOBUWq2vvecZ2pgiToolCf6oeRvKVODIccYsgRtB+eyhGvBNEKn2JbtBibPjxUmYk5GsNzuzs31AZPU3eiUCxfJ17grHUg/8rAcZhVk/xszqMdtp73llU/lKaIKPHoPFxLnqLSKwGoXCwm9HdOPGklXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbS1d3gLBZA9tbFWTAp3NtKJXPrwxUaKzr5SEJu5tqI=;
 b=fyoXHDFhjjdMQAXE6tGT/jbENFSdilxxjCr7MITbBhjS2djfA5vDh6JN9l1tuLCjtstXru1e5Y/qmCzW0eh1ZitEFwoFaaIg/WSHvp5A28OqxL6kP/e6EyiRwJYdU/nvfIZMeqgV0+sgkrc3Gc1y0xTqUHupE8E1nbutU+NKYsM=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2536.namprd11.prod.outlook.com (2603:10b6:a02:c4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Thu, 15 Apr
 2021 23:34:57 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4020.025; Thu, 15 Apr 2021
 23:34:57 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 2/3] cxl/mem: Print unknown capability IDs as hex
Thread-Topic: [PATCH 2/3] cxl/mem: Print unknown capability IDs as hex
Thread-Index: AQHXMk7AA0OrOvW5sUiqWMw9RKDHoaq2O0QA
Date:   Thu, 15 Apr 2021 23:34:57 +0000
Message-ID: <40063fe52fcaa066a42d352b13128b6762277542.camel@intel.com>
References: <20210415232610.603273-1-ben.widawsky@intel.com>
         <20210415232610.603273-2-ben.widawsky@intel.com>
In-Reply-To: <20210415232610.603273-2-ben.widawsky@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1e3bfdb-8939-4d19-5058-08d900671483
x-ms-traffictypediagnostic: BYAPR11MB2536:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB25363C975F0277168D26B101C74D9@BYAPR11MB2536.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eAfbuXrhucNUMp6FO/ecagGfw53qaCWVIat3ud7mcH+V+F0tLV79LMitI1Qbyyew0ZBRCC5z0uUB07YB0ukKdhbGY0qstrO0xol0v8MEbpeujVFByvfEx7tWVO9aaxA0Efsf/oYEtd8cM0+s4bCwYxl3c+Y4rUhLdWMQrwqSiFbkZnPnJeFLARDlPcocmS5pMa9Oa+Dq8y/8VswXOXhybnkb7uf+yJudcw/9JFUdfnZK+KofZZdtiNPRXN/N3Y9zSPdg9KWR3Ya9Mramgs0ckIOkXtlx5ApYSRCC+6l87g1g4QHImQ/JTWNDmNE9tav98R3TZ+knjdL1iEuUU0fZqyy7aPTI5nDIu20YLhLPNjmQezLG9qjGpKtFbfJCISVVQRSmlEUchkgz0ahxpx6Npa/vihtn89kqaf1IHpmtR2Rgkk6q0AI60HXtDHKpIpLZA5f/ZbQ/rcPerlAexk0kPDM2ZqBvu3MZZ6Q0MmyZjrVhtuHqHM5Ew+Ydld/wr+LJwbVoa56AlilRA6Lk+TgThwEeim3fiWnr2DYo1dc1U4al4x42p094ZLr8IK/+f/FhG91dFhQxoCERUgVQMPvCtToiv+3bPLcIuoSXvzPD81Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(376002)(39860400002)(136003)(38100700002)(478600001)(110136005)(6506007)(4744005)(316002)(36756003)(122000001)(86362001)(71200400001)(6486002)(26005)(66946007)(66556008)(76116006)(64756008)(83380400001)(4326008)(2906002)(66476007)(186003)(5660300002)(2616005)(8936002)(54906003)(6512007)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UXZJVFhTUnRMWVNhRVBRV1kyVGJpMW9MV0luaGt1Z3NWSnNTbyt3c052ZXM4?=
 =?utf-8?B?OHJmWTdvbFJSQ2pnOHFESG5HOEwybFNtaFZmUFgxUStjeGRNVG4vODlhYkZr?=
 =?utf-8?B?RUplSFFjdVlFVWlDblZrbFM0MExjR2o5c0UwcHoxdjYxbFJGZnZKNXlyM2dj?=
 =?utf-8?B?eXd1elRuQnc2WUttOUU1YmIrN2t1ekhFc0taSEtMRkQ1MWY5STBzZ2gwbFJa?=
 =?utf-8?B?N1k4QTZlSi8vd2lITUZlTkVvdFh2NERLcnN5dkFHWEp6ank3SURLSXRhc2or?=
 =?utf-8?B?UDgrMUhNTEc2aUdJQnpYeXUwQWJab1dMMHBxb0d3eDE0Yzh4Q2F6dFM2RENB?=
 =?utf-8?B?dGRaNmswSllLakJoU2Q2bVo0Zlg1c01UeS9DOEIxdWt1Tmt5OCs3b1puZHM3?=
 =?utf-8?B?aitPYU9HcGhINnRTYU94c2hkS3o3aCtBNlVaQWZjNjJkTDlFc1hBK25sM005?=
 =?utf-8?B?NWZkaUNwUG1ybGJNK08xWjRJMkNldDd1UVN4c25DWjNFT2U4OHZMdTN2UjZk?=
 =?utf-8?B?bjNWZmpEcjB5M1RwSGJiaTl4STZIaDF5M3JwMUF2cHBVOHZzbUFTZXdUdjZ1?=
 =?utf-8?B?Z1NSL1BTcDY0cDNDMG9MQ09NKzl5cThtcUlXdmF2VlZ4THRXM3ZRM29zQkor?=
 =?utf-8?B?QkFPM200OURBa3QxZjMrcDBCbTlVQllSejdPUWEzQTVmeUpxTTNZUGs2RGo4?=
 =?utf-8?B?L2tqOWkxa1l3Vjkvd1JyRmVwNDErWVQ2TGJpWWhFSlY4ZjdrUHI3SW9KVVh2?=
 =?utf-8?B?Q0xmbnUwdjZBZDEzSmNYT2diZVNTU1NiazBLZHcxU05QK3pqQUhCTi85M2FB?=
 =?utf-8?B?YzdlaDVERXN5dWtodDhqV21KMURvLzZPYnZXQ2VCcG5FZGtod1NDcVRjMUlt?=
 =?utf-8?B?QU5KMlJtN21Ta3paMm9Pb1VEcTJSeVZxZzUvVUZzS2pTaU5ZL1ZUOUFjd0ZG?=
 =?utf-8?B?ZEk0QlBJMENmMFdGZW9hdThuang3bllTdEZhR1IvL3kxKzRIaWpqaDN6VEFz?=
 =?utf-8?B?eTE1K0pmVy81TmhsS0FpdHBDRkpENGNIMzd4OThWdFRsZFVFMFZmQjZ6alFp?=
 =?utf-8?B?azZaYkJ6Z1NtY296QWZOdi9Zd2EwVXpoRk1IbThMOXEzdkUwS3BMMUYwQytw?=
 =?utf-8?B?T1J2REJBajB0V3dLWmFQbFhKUG9US2cxcWJ4eEMySDhlU3grdk5TcjNPOHFM?=
 =?utf-8?B?TTlFdWQxSGI5QnIvL1p5bXpNMkFDR2RzeVVSeWNmN1FtN3puSVdON0d0Q21E?=
 =?utf-8?B?N1dxUW5hRC9wQjh1NjdEd241M3U0emtDNGxhM041aXRCamlJdHAzYzV5a3Rp?=
 =?utf-8?B?Y3FXTEVSUlI4anR5VkNUVUl6a09xR2plSlN2bk9qRDZyN1NBV0ovTG9MVEFY?=
 =?utf-8?B?aGhyM0lBeGFmT2h0MWkzRXduVlluWjlZdzNqQk41TWJ2dU1yelV0NDcvSjhB?=
 =?utf-8?B?ay9FZ3J2SFB6VnVkWjMrRXpRQTduSjhmc0tNWDR2VUEzdmhac29KbC9aKzZS?=
 =?utf-8?B?YSt5UXV3cnUrZHR5a2NzaE9SaitSVUFNazYwQkJuRWxmdFM3Q1oxMklXajNn?=
 =?utf-8?B?WXZPUkUyd3NiRHNoMzRSY1pYdC8rNzErdkNabXJFSUlOUStKNnBPdkNXOUV1?=
 =?utf-8?B?YnlMRWFEL253Rng1UlcyZXR5bENBeklwcGJ3RTBaUGpZaUUyUlVodktTWTNw?=
 =?utf-8?B?aStNalZFR1k5K1ZIcVgxYm53OWZpUEVzYlplcVBiTjNZNnBVT0dJTjRkTUtT?=
 =?utf-8?Q?P/pp/SBTKB8w7z1C6pibc+a8avN2TOcROu9gpf9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <110585419464FC4F9AD5F97E2A40C037@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e3bfdb-8939-4d19-5058-08d900671483
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 23:34:57.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzWZNiiYcR8tNPc2+UHZPDcoDi8/0GwGbRFeK6gLMLbD7ohTOSLaosuZvvFAQCBq2qPdh+A74ONvWvtGsJM1Q3ALtAYiWRmr9FvKjAACud0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2536
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTE1IGF0IDE2OjI2IC0wNzAwLCBCZW4gV2lkYXdza3kgd3JvdGU6DQo+
IFRyaXZpYWwuIFRoZSBzcGVjIGxpc3RzIHRoZXNlIGFzIGhleCwgc28gZG8gdGhlIHNhbWUgaGVy
ZSB0byBtYWtlDQo+IGRlYnVnZ2luZyBlYXNpZXIuDQo+IA0KPiBGaXhlczogOGFkYWY3NDdjOWYw
YiAoImN4bC9tZW06IEZpbmQgZGV2aWNlIGNhcGFiaWxpdGllcyIpDQo+IFNpZ25lZC1vZmYtYnk6
IEJlbiBXaWRhd3NreSA8YmVuLndpZGF3c2t5QGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVy
cy9jeGwvbWVtLmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvbWVtLmMgYi9kcml2
ZXJzL2N4bC9tZW0uYw0KPiBpbmRleCAxYjUwNzgzMTFmN2QuLmMwNTYxN2IwYmE0YiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9jeGwvbWVtLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvbWVtLmMNCj4g
QEAgLTkzOSw3ICs5MzksNyBAQCBzdGF0aWMgaW50IGN4bF9tZW1fc2V0dXBfcmVncyhzdHJ1Y3Qg
Y3hsX21lbSAqY3hsbSkNCj4gwqAJCQljeGxtLT5tZW1kZXZfcmVncyA9IHJlZ2lzdGVyX2Jsb2Nr
Ow0KPiDCoAkJCWJyZWFrOw0KPiDCoAkJZGVmYXVsdDoNCj4gLQkJCWRldl9kYmcoZGV2LCAiVW5r
bm93biBjYXAgSUQ6ICVkICgweCV4KVxuIiwgY2FwX2lkLCBvZmZzZXQpOw0KPiArCQkJZGV2X2Ri
ZyhkZXYsICJVbmtub3duIGNhcCBJRDogJXggKDB4JXgpXG4iLCBjYXBfaWQsIG9mZnNldCk7DQoN
CldvdWxkICUjeCBiZSBiZXR0ZXIganVzdCBmb3IgbWFraW5nIGl0IHVuYW1iaWd1b3VzPyBNYXli
ZSBhbHNvIGNoYW5nZQ0KdGhlIGFkamFjZW50IDB4JXggdG8gJSN4IHdoaWxlIGF0IGl0Lg0KDQo+
IMKgCQkJYnJlYWs7DQo+IMKgCQl9DQo+IMKgCX0NCg0K
