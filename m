Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9827A55C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 04:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1COz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 22:14:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:35386 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgI1COz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 22:14:55 -0400
IronPort-SDR: 3gcLI5qxo6AZ/wjWruNla9xeQTiFXzjHNrNSAYh6xybBoTIphZ75ADlr77tc46bi5rfhX9SC+5
 foR+BPQm2FEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="161159884"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="161159884"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 19:01:38 -0700
IronPort-SDR: itEfn0YHHmZeba64YLVDlr0y7E4zrdclxJdk0Z72/LG2a2snDOgijJOLyBwwtXHyZO7W0dJJ3V
 EJ1xymAIBK2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="307148499"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2020 19:01:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 27 Sep 2020 19:01:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 27 Sep 2020 19:01:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 27 Sep 2020 19:01:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPz3uv49uPRgkd3LuMz58dwJIqiWYpLlIG64izwbUNXHyOXLw6zz0VPTBOG/uS3DM2YMcfocpcU95pbwEDbMkuZeDybuV50JaiOjc8V6g973JmywZm8mHt0dJnY6dcEu2mv185pDvINk2NO2czUQN+hjWKcNYHpfY81aGsVTH6tTTwGtMF5nkh4cXGRyC94tyP2wNrZJDJkttmpHtbVb51NGGl0vJbVsVe/4qAk3H497ij8qqcYXGM6iT9KuLfzhhgDgzBmQdDjmbevsQoZSbzOAqOBNSPeSa/Xo3hoeeNvoDTodhJwrQEiq39Fko2la9g9bA3vkZHm6v2UIqj/91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lWfQn4yP0+SRNijEeHotitosHrt4zRJQGhb0co2xPM=;
 b=lWlPztqWT7DVLzN9uPDkf+6VwZbI0yiHM+ZxyOOCsdPfyt2Q68nmsSR26k54ABz4B31XWWqErQiYX/v7DYcUhLM/xfW4oKN8iSw/Y1Kex0acQTRCZHvx/QrSogU/ClTZOz+qAR8i1IbXeKfcQ73+SUC1D3JwAW0c3rK8URGjlv2tP7ZhT0/J4CXAjnuZ8/sosEMU1ZG5wMAT+kITFG7s9uq+pa4u/MTtL/n1+KVD0YLxQyOCB1vmiKlVBVft68CC2Yt75KksDK/XwIcLVVAezbSm4i0/ZWfBcyd7w3nBGkHHx3IMqm+lAK8KlRVoPoGTf0f9EiufLLKe78HJigfFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lWfQn4yP0+SRNijEeHotitosHrt4zRJQGhb0co2xPM=;
 b=cEo/8gnPvqjUiVPk441jQp89gDRbCgEcLVJ7SdcV1cTFaJ5nVy6bNwaMlndd95h3nF8RuDOfJhC0XEf+5c73cTWba8Td7V47eLiQ6lUl28y9XFcIM6WJQqDFA+1Z2ytjtpryP5VzUUwbLSCZMN0xQccjWnc4Fr6u7YvG+C4ug68=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MWHPR11MB1838.namprd11.prod.outlook.com (2603:10b6:300:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 02:01:35 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f%2]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 02:01:35 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     Sinan Kaya <okaya@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        "ashok.raj@linux.intel.com" <ashok.raj@linux.intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Subject: RE: [PATCH 2/5 V2] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
Thread-Topic: [PATCH 2/5 V2] PCI: pciehp: check and wait port status out of
 DPC before handling DLLSC and PDC
Thread-Index: AQHWlH6LxfqIFYMIqEuV1CKCG1iyKal8nIMAgACwpuA=
Date:   Mon, 28 Sep 2020 02:01:34 +0000
Message-ID: <MWHPR11MB1696BA6B8473248A8638FD3797350@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-3-haifeng.zhao@intel.com>
 <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
In-Reply-To: <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7f89cbc-351d-4c74-a29c-08d863526da4
x-ms-traffictypediagnostic: MWHPR11MB1838:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1838E5B172CE39D5A203BE0897350@MWHPR11MB1838.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lHItus6VuHLkUFxypqNbJi0O3PlCDlBwazvSVKdcVsOU82JmKMtx1RrG0dN+9xODiX6W5Q81zm5RwKukMf32ijxZhmrJ0z8mEuphQXWRN7oEnc0jFsMZU3qAHoGZhADkc+66qSowe8/5ZD7h05EUZq23ouzqLrW+KRRRIzmKi7dOn8iN+0ZkgOTFGhfm+RSllpGruOTRjw2VO496rP9t6D+PDDhDsMIAhjlCr2xag/nOpi8+ibEdHQvSFQ05Z+nzmKodZ53gpKnRM2E7S4yyXeWQVg07hlwfy+aEeKvT25JLui8hr8slmIHyy72gAmD/LhF+g9+U8psJHw9crPckJMmamRZjVwwpJiMIxWpFDBeX84BlS/gkycuebg+mzYeHKk+uR7zR0cfGgQdLN+LtxsOE5CkyTtZdJnm8dFqBzNA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(54906003)(5660300002)(7416002)(316002)(66476007)(66556008)(66446008)(64756008)(66946007)(86362001)(8676002)(55016002)(9686003)(26005)(7696005)(6636002)(110136005)(4326008)(478600001)(186003)(53546011)(8936002)(71200400001)(6506007)(76116006)(52536014)(33656002)(2906002)(83380400001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: S0y23/M6+oxwKLrYb9QawP3KDeV3RXVsLAu3WCFeypjFNX9ZieHxSXYHqO6q9neF/f7fUniiEKJJ296rYouuoVnYTQu3D1bJOYJx9Jb9+QO+HXKvYcdlnqRhAnMIEsQOhWWZGRI7qSNtSFsB6BUrCIyOgHBlj0rCyiJ17dLkVsU7bIUvqtd+jmJxNPdidklhq8eiawvooeb0TrIZDsAOgUday/qjMe0XpA7ua8zPFjO+QU/SEvOcnaMU7POeL4pu6a7tPgT6zj7O0lO4b3P/GjEtEyz1/m+CFgbWQxFhn7qz64xgZL2KeDeWqyRpCzYSyU6lN6fYOR7tMizDnOTPFTSo7fIEmWuX/Gn1RW8Tea6blxFSCmYAolB3JAVNnVUD06mor483JGnA2pW20GlvuDHeG4wld7Jk71zot5p7LoyhfvGLhV63YW75ITEkWyqKk80wC9xIJWe+Ug2PY3PIN+ecEse1X9yJBgyGh1fU2XZtLkjrSIx+qcZ25icWp5RlvUjYA4vll5TfSfapFUKoqp7y+6Wx5YWa/j+KmhyMuLbgeo9IQP6TSDgoIwfC+wpdrIEloAtLYRbD9QR3EdNw2bjTfDD+Sls62IDh8xlrSw9wohJpEbbWzoat0aeTdL74QSicWkTNAAfv2IEVTq2n8A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f89cbc-351d-4c74-a29c-08d863526da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 02:01:34.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAcOD/z50rKKcvd3rNkbBH4IAUbHtEHpgeYAoCJRQyWbg0np8C+TOrw6BnAuS5zxyrxcQR8m290RdQCtL5vqeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1838
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U2luYW4sDQogICBJIGV4cGxhaW5lZCB0aGUgcmVhc29uIHdoeSBsb2NrcyBkb24ndCBwcm90ZWN0
IHRoaXMgY2FzZSBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gcGFydC4gDQpXcml0ZSBzaWRlIGFu
ZCByZWFkIHNpZGUgaG9sZCBkaWZmZXJlbnQgc2VtYXBob3JlIGFuZCBtdXRleC4NCg0KVGhhbmtz
LA0KRXRoYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNpbmFuIEtheWEg
PG9rYXlhQGtlcm5lbC5vcmc+IA0KU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjAgMTE6
MjggUE0NClRvOiBaaGFvLCBIYWlmZW5nIDxoYWlmZW5nLnpoYW9AaW50ZWwuY29tPjsgYmhlbGdh
YXNAZ29vZ2xlLmNvbTsgb29oYWxsQGdtYWlsLmNvbTsgcnVzY3VyQHJ1c3NlbGwuY2M7IGx1a2Fz
QHd1bm5lci5kZTsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBzdHVhcnQudy5o
YXllc0BnbWFpbC5jb207IG1yLm51a2UubWVAZ21haWwuY29tOyBtaWthLndlc3RlcmJlcmdAbGlu
dXguaW50ZWwuY29tOyBLZWl0aCBCdXNjaCA8a2VpdGguYnVzY2hAaW50ZWwuY29tPg0KQ2M6IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEpp
YSwgUGVpIFAgPHBlaS5wLmppYUBpbnRlbC5jb20+OyBhc2hvay5yYWpAbGludXguaW50ZWwuY29t
OyBLdXBwdXN3YW15LCBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15
QGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi81IFYyXSBQQ0k6IHBjaWVocDogY2hl
Y2sgYW5kIHdhaXQgcG9ydCBzdGF0dXMgb3V0IG9mIERQQyBiZWZvcmUgaGFuZGxpbmcgRExMU0Mg
YW5kIFBEQw0KDQpPbiA5LzI2LzIwMjAgMTE6MjggUE0sIEV0aGFuIFpoYW8gd3JvdGU6DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9ocGMuYyBiL2RyaXZlcnMvcGNp
L2hvdHBsdWcvcGNpZWhwX2hwYy5jDQo+IGluZGV4IDUzNDMzYjM3ZTE4MS4uNmYyNzExNjBmMThk
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9ocGMuYw0KPiArKysg
Yi9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9ocGMuYw0KPiBAQCAtNzEwLDggKzcxMCwxMCBA
QCBzdGF0aWMgaXJxcmV0dXJuX3QgcGNpZWhwX2lzdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+
ICAJZG93bl9yZWFkKCZjdHJsLT5yZXNldF9sb2NrKTsNCj4gIAlpZiAoZXZlbnRzICYgRElTQUJM
RV9TTE9UKQ0KPiAgCQlwY2llaHBfaGFuZGxlX2Rpc2FibGVfcmVxdWVzdChjdHJsKTsNCj4gLQll
bHNlIGlmIChldmVudHMgJiAoUENJX0VYUF9TTFRTVEFfUERDIHwgUENJX0VYUF9TTFRTVEFfRExM
U0MpKQ0KPiArCWVsc2UgaWYgKGV2ZW50cyAmIChQQ0lfRVhQX1NMVFNUQV9QREMgfCBQQ0lfRVhQ
X1NMVFNUQV9ETExTQykpIHsNCj4gKwkJcGNpX3dhaXRfcG9ydF9vdXRkcGMocGRldik7DQo+ICAJ
CXBjaWVocF9oYW5kbGVfcHJlc2VuY2Vfb3JfbGlua19jaGFuZ2UoY3RybCwgZXZlbnRzKTsNCj4g
Kwl9DQo+ICAJdXBfcmVhZCgmY3RybC0+cmVzZXRfbG9jayk7DQoNClRoaXMgbG9va3MgbGlrZSBh
IGhhY2sgVEJILg0KDQpMdWthcywgS2VpdGg7DQoNCldoYXQgaXMgeW91ciB0YWtlIG9uIHRoaXM/
DQpXaHkgaXMgZGV2aWNlIGxvY2sgbm90IHByb3RlY3RpbmcgdGhpcyBzaXR1YXRpb24/DQoNCklz
IHRoZXJlIGEgbG9jayBtaXNzaW5nIGluIGhvdHBsdWcgZHJpdmVyPw0KDQpTaW5hbg0K
