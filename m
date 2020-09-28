Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD8E27A6A9
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 06:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbgI1E6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 00:58:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:38921 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1E6d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 00:58:33 -0400
IronPort-SDR: AfxLgJsLeM1/TSSTtYCOx8QRJgt5hg5sarNtELBDtBLH38MbJGxwBNGAn/+f4bEBJ6aYKcCkx2
 CbLDDE66XvzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="226089106"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="226089106"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 21:58:29 -0700
IronPort-SDR: eHI5iMJORO/IUrOEc8k6niJ7n5tnVYhaKGcmAqw+SjEo955PppcB37fwaARtnrlKGxP9omPMUl
 tmWuH7M7pK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="349720149"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2020 21:58:28 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 27 Sep 2020 21:58:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 27 Sep 2020 21:58:28 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.52) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 27 Sep 2020 21:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGHFEMAJYSyqEvWhcT3DIWZF0kD/R7Ag+YWYY511QY4WZ+nF04nXxiuGxP+YrZd+G8nbk23EILYRj6cKYLHXa2fmusDe838hbafMlpLmNQgASi7x7HU693DyCbriLvPpHkOtts96ytPrFes6Dr0AqG+DQVkJ4BY0jc3juhqzAqKS+CvXaRTrtFFicdMQG2EczQRUUM9cNf3PdaGxCiKN5o2G8F7v8iaAdv4ZxVLd+zWWLjFbkCXjPZKr2QXpBujsl9IzhR27B1D2NjZt20+eaKqhF4m2K93qyIhfbLSwSJH+8GvYn8v2+5dhH2GLenf/6dPAKAQF75bhMfn0oO4Mqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOsGUEmL3Z4YursUKNqj9BpvXoKfSF/Lu3fGY9Wm8dM=;
 b=eoBTe/v+9ndxRMPs1tjIGrX4uCYI8AmWBmV9EMm7zZLxJpBe6KVWMW2fzw8wFVdLNO5UllpJH3uQMcwDAMkYQcjntWNULCF5y/zFTNE9pbiDjmN0C6qMy1EGGo1EvNtTy0BFRMXOpq599odNiYgjknTfsqKSbVgoeKk/shEyY7K89d2EPftO7CVDihVONJMui7cgnmJ1BCyl/R0y/aAtB8Vh6WM13YsWXsXbtBZd3VDmjK4VSOOQ8877wtjKDcr1DiRTz5ZlAokAt3X8/P4yO8Ta5phf2F3woJfOOtY8cAc5UZAluAZT36k7BCV5mj3vmvig9jDyrwvBn0oltEENMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOsGUEmL3Z4YursUKNqj9BpvXoKfSF/Lu3fGY9Wm8dM=;
 b=tEyPg1Qk1Z2kxfq2bi3mljhc4Utpgjaa510vCwct8mqQsCGhh/uMHLM8pr+MIhYCEfFuwG8+djX1siK2eFCeTgJ3sAKFrlv4nS+wVnKAwMaZmTy4MYKSMfs5sfR45ObNEshQLyNRwEakYOILtSj1Yg4tW1IzmAn7YtZfLTW0ap0=
Received: from MWHPR11MB1696.namprd11.prod.outlook.com (2603:10b6:300:23::23)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 04:58:25 +0000
Received: from MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f]) by MWHPR11MB1696.namprd11.prod.outlook.com
 ([fe80::449a:93eb:c6d1:ce0f%2]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 04:58:25 +0000
From:   "Zhao, Haifeng" <haifeng.zhao@intel.com>
To:     "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        "ashok.raj@linux.intel.com" <ashok.raj@linux.intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "joe@perches.com" <joe@perches.com>
Subject: RE: [PATCH 2/5 V4] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
Thread-Topic: [PATCH 2/5 V4] PCI: pciehp: check and wait port status out of
 DPC before handling DLLSC and PDC
Thread-Index: AQHWlKhPcHloAk19Z0SY0Cvs9G9XwKl81zWAgACmUdA=
Date:   Mon, 28 Sep 2020 04:58:25 +0000
Message-ID: <MWHPR11MB169606D04B619BBD5174841797350@MWHPR11MB1696.namprd11.prod.outlook.com>
References: <20200927082736.14633-1-haifeng.zhao@intel.com>
 <20200927082736.14633-3-haifeng.zhao@intel.com>
 <35e7a493-a6f0-ac16-eb27-8ee5e77312ab@intel.com>
In-Reply-To: <35e7a493-a6f0-ac16-eb27-8ee5e77312ab@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 181f64d0-cd31-4ed8-b81e-08d8636b21d6
x-ms-traffictypediagnostic: MW3PR11MB4521:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45215A596C04E2C57254342E97350@MW3PR11MB4521.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JyEiBk+RKNre1N3q4Syh8UEW8Fh/jAC/rO5kjOSom13XPXXeSw2ElWjb+UCt7XUUnA7+VSHvrmkcIBj+tZS9sazruYFXkiRVGt4WDdaaijnaiuywQe4S2BjdMBBiMAbm/6YdRUzVvyLGk5SInvNC2G2ValPZmwSbAPFUaK+HCIPSawWzM5rthO73GieanlIamdd+6WIcJdnPuAQ0WY+JVBbIcbMWkfaHvrDajvQxpU97ZjGiA5kPCNvui7ESx+3kVUFCxWelhKzLw5UNL8dAeJP4Z3lxuYLvnppRtkqqjxzeidaPlfZuuS8QGrM4B9vP+pTmMCKL2wkzF84bxCMMENe36WpDkY1fmz2WmQ1CdXm6IiMP1MtWtScU5Ff/+iuiXs6lfixLlMI3zQSHV5uBif74FrplSyXHGkcpBHHrSEflgXpUNTJ9JbUOafat+EgX0UBKUUpjBraMKSnMSAQJDqa+6CQNp+UB4Br6aj0HJrOyj1TxgflmkBKKCj6yqJVf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1696.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(8676002)(52536014)(2906002)(9686003)(4326008)(33656002)(6506007)(478600001)(55016002)(53546011)(45080400002)(966005)(316002)(76116006)(26005)(7696005)(8936002)(71200400001)(66476007)(66446008)(64756008)(66556008)(66946007)(186003)(5660300002)(110136005)(54906003)(7416002)(86362001)(83380400001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8gO2/s7S7CrDeAYDCzT4U8nu+5Cf6Vomqfr5Dig9JBamxAsH9UkSgLhWLBWf2nXg8zWPD/QIJD6ICpApepv6o2ZtAI1wYe1Rysdt+ghpEzoURGIfr48dVe1cpOV+Cr0u2JrQWmGk8GgKtTvvJQ+2WO8fD8DTsHFYO+Dm4OmxMZOctok1FNFLqYr19tCDaCCC0pEGdMEtxvfKVnUw5D4OE2EybdLKXUl9nCUqQwC8OgXX/QgG5w1zwUDFRZ3mQZheynakPO/SsaOizueXOgy33/rIsO7nW/mbOJC5Whh37LGrsZWO9z+1Ni7F/A1mJ3as3WKW92ZRDw8bIBFSxOC/8/anqBv+uJOiyXEXADa0FAub8PJrjCMH3TAqJEysHdSC//78qZ5fdUcPXiBtTcm2Of/19B1sk62f+kwI7h499K0sF2VllL1VJ1Mqy5JSP2tA3A70R6TSX3prVMw3qmZbLSQy0aPe83FQ5CXMXRhh64S7TCwgzy6MNNdW29yJ8kIKCd7iwhxU1jUfvUiq7qmxRVshjV715IhTv6+Tb3WukxiEz8z9TM1UgnYwF8QA8AiYpY4skw5/9RJFaYeC1oVl1leUeYOOvELa2WLwIxHkTLRz4XHrceBZBNxIMlaGAim8TbbUEGEQLc6Z/N3a4sx8WA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1696.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181f64d0-cd31-4ed8-b81e-08d8636b21d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 04:58:25.2426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6JZug25l94Tz0asMEB2YgPUadSJUi+JRV5+rZybbXPKn2F4KhhZZBNglqUi5JE7wXI5FVwUi1Opn2T4Czhl+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U2F0aHlhbmFyYXlhbmFu77yMDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBL
dXBwdXN3YW15LCBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGlu
dGVsLmNvbT4gDQpTZW50OiBNb25kYXksIFNlcHRlbWJlciAyOCwgMjAyMCAyOjU5IEFNDQpUbzog
WmhhbywgSGFpZmVuZyA8aGFpZmVuZy56aGFvQGludGVsLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5j
b207IG9vaGFsbEBnbWFpbC5jb207IHJ1c2N1ckBydXNzZWxsLmNjOyBsdWthc0B3dW5uZXIuZGU7
IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsgc3R1YXJ0LncuaGF5ZXNAZ21haWwu
Y29tOyBtci5udWtlLm1lQGdtYWlsLmNvbTsgbWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNv
bQ0KQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IEppYSwgUGVpIFAgPHBlaS5wLmppYUBpbnRlbC5jb20+OyBhc2hvay5yYWpAbGludXgu
aW50ZWwuY29tOyBoY2hAaW5mcmFkZWFkLm9yZzsgam9lQHBlcmNoZXMuY29tDQpTdWJqZWN0OiBS
ZTogW1BBVENIIDIvNSBWNF0gUENJOiBwY2llaHA6IGNoZWNrIGFuZCB3YWl0IHBvcnQgc3RhdHVz
IG91dCBvZiBEUEMgYmVmb3JlIGhhbmRsaW5nIERMTFNDIGFuZCBQREMNCg0KDQpPbiA5LzI3LzIw
IDE6MjcgQU0sIEV0aGFuIFpoYW8gd3JvdGU6DQo+IFdoZW4gcm9vdCBwb3J0IGhhcyBEUEMgY2Fw
YWJpbGl0eSBhbmQgaXQgaXMgZW5hYmxlZCwgdGhlbiB0cmlnZ2VyZWQgYnkgDQo+IGVycm9ycywg
RFBDIERMTFNDIGFuZCBQREMgaW50ZXJydXB0cyB3aWxsIGJlIHNlbnQgdG8gRFBDIGRyaXZlciwg
DQo+IHBjaWVocCBkcml2ZXIgYXQgdGhlIHNhbWUgdGltZS4NCj4gVGhhdCB3aWxsIGNhdXNlIGZv
bGxvd2luZyByZXN1bHQ6DQo+DQo+IDEuIExpbmsgYW5kIGRldmljZSBhcmUgcmVjb3ZlcmVkIGJ5
IGhhcmR3YXJlIERQQyBhbmQgc29mdHdhcmUgRFBDIGRyaXZlciwNCj4gICAgIGRldmljZQ0KPiAg
ICAgaXNuJ3QgcmVtb3ZlZCwgYnV0IHRoZSBwY2llaHAgbWlnaHQgdHJlYXQgaXQgYXMgZGV2aWNl
IHdhcyBob3QgcmVtb3ZlZC4NCj4NCj4gMi4gUmFjZSBjb25kaXRpb24gaGFwcGVucyBiZXR0d2Vl
biBwY2llaHBfdW5jb25maWd1cmVfZGV2aWNlKCkgY2FsbGVkIGJ5DQo+ICAgICBwY2llaHBfaXN0
KCkgaW4gcGNpZWhwIGRyaXZlciBhbmQgcGNpX2RvX3JlY292ZXJ5KCkgY2FsbGVkIGJ5DQo+ICAg
ICBkcGNfaGFuZGxlciBpbiBEUEMgZHJpdmVyLiBubyBsdWNrLCB0aGVyZSBpcyBubyBsb2NrIHRv
IHByb3RlY3QNCj4gICAgIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZSgpDQo+ICAgICBh
Z2FpbnN0IHBjaV93YWxrX2J1cygpLCB0aGV5IGhvbGQgZGlmZmVyZW50IHNhbXBob3JlIGFuZCBt
dXRleCwNCj4gICAgIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZSBob2xkcyBwY2lfcmVz
Y2FuX3JlbW92ZV9sb2NrLCBhbmQNCj4gICAgIHBjaV93YWxrX2J1cygpIGhvbGRzIHBjaV9idXNf
c2VtLg0KV2h5IG5vdCBhZGRyZXNzIHRoZSBsb2NraW5nIGlzc3VlPyBNYXkgYmUgYSBjb21tb24g
bG9jaz8NCj4NCj4gVGhpcyByYWNlIGNvbmRpdGlvbiBpcyBub3QgcHVyZWx5IGNvZGUgYW5hbHlz
aXMsIGl0IGNvdWxkIGJlIHRyaWdnZXJlZCANCj4gYnkgZm9sbG93aW5nIGNvbW1hbmQgc2VyaWVz
Og0KPg0KPiAgICAjIHNldHBjaSAtcyA2NDowMi4wIDB4MTk2Lnc9MDAwYSAvLyA2NDowMi4wIHJv
b3Rwb3J0IGhhcyBEUEMgY2FwYWJpbGl0eQ0KPiAgICAjIHNldHBjaSAtcyA2NTowMC4wIDB4MDQu
dz0wNTQ0ICAvLyA2NTowMC4wIE5WTWUgU1NEIHBvcHVsYXRlZCBpbiBwb3J0DQo+ICAgICMgbW91
bnQgL2Rldi9udm1lMG4xcDEgbnZtZQ0KPg0KPiBPbmUgc2hvdCB3aWxsIGNhdXNlIHN5c3RlbSBw
YW5pYyBhbmQgTlVMTCBwb2ludGVyIHJlZmVyZW5jZSBoYXBwZW5lZC4NCj4gKHRlc3RlZCBvbiBz
dGFibGUgNS44ICYgSUNTKEljZSBMYWtlIFNQIHBsYXRmb3JtLCBzZWUNCj4gaHR0cHM6Ly9lbi53
aWtpY2hpcC5vcmcvd2lraS9pbnRlbC9taWNyb2FyY2hpdGVjdHVyZXMvaWNlX2xha2VfKHNlcnZl
cg0KPiApKQ0KPg0KPiAgICAgQnVmZmVyIEkvTyBlcnJvciBvbiBkZXYgbnZtZTBuMXAxLCBsb2dp
Y2FsIGJsb2NrIDMzMjgsIGFzeW5jIHBhZ2UgcmVhZA0KPiAgICAgQlVHOiBrZXJuZWwgTlVMTCBw
b2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDUwDQo+ICAgICAjUEY6
IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUNCj4gICAgICNQRjogZXJyb3Jf
Y29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KPiAgICAgUEdEIDANCj4gICAgIE9vcHM6
IDAwMDAgWyMxXSBTTVAgTk9QVEkNCj4gICAgIENQVTogMTIgUElEOiA1MTMgQ29tbTogaXJxLzEy
NC1wY2llLWRwIE5vdCB0YWludGVkIDUuOC4wIGVsOC54ODZfNjQrICMxDQo+ICAgICBSSVA6IDAw
MTA6cmVwb3J0X2Vycm9yX2RldGVjdGVkLmNvbGQuNCsweDdkLzB4ZTYNCj4gICAgIENvZGU6IGI2
IGQwIGU4IGU4IGZlIDExIDAwIGU4IDE2IGM1IGZiIGZmIGJlIDA2IDAwIDAwIDAwIDQ4IDg5IGRm
IGU4IGQzDQo+ICAgICA2NSBmZiBmZiBiOCAwNiAwMCAwMCAwMCBlOSA3NSBmYyBmZiBmZiA0OCA4
YiA0MyA2OCA0NSAzMSBjOSA8NDg+IDhiIDUwDQo+ICAgICA1MCA0OCA4MyAzYSAwMCA0MSAwZiA5
NCBjMSA0NSAzMSBjMCA0OCA4NSBkMiA0MSAwZiA5NCBjMA0KPiAgICAgUlNQOiAwMDE4OmZmOGUw
NmNmODc2MmZkYTggRUZMQUdTOiAwMDAxMDI0Ng0KPiAgICAgUkFYOiAwMDAwMDAwMDAwMDAwMDAw
IFJCWDogZmY0ZTNlYWFjZjQyYTAwMCBSQ1g6IGZmNGUzZWIzMWYyMjNjMDENCj4gICAgIFJEWDog
ZmY0ZTNlYWFjZjQyYTE0MCBSU0k6IGZmNGUzZWIzMWYyMjNjMDAgUkRJOiBmZjRlM2VhYWNmNDJh
MTM4DQo+ICAgICBSQlA6IGZmOGUwNmNmODc2MmZkZDAgUjA4OiAwMDAwMDAwMDAwMDAwMGJmIFIw
OTogMDAwMDAwMDAwMDAwMDAwMA0KPiAgICAgUjEwOiAwMDAwMDBlYjhlYmVhYjUzIFIxMTogZmZm
ZmZmZmY5MzQ1MzI1OCBSMTI6IDAwMDAwMDAwMDAwMDAwMDINCj4gICAgIFIxMzogZmY0ZTNlYWFj
ZjQyYTEzMCBSMTQ6IGZmOGUwNmNmODc2MmZlMmMgUjE1OiBmZjRlM2VhYjQ0NzMzODI4DQo+ICAg
ICBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmY0ZTNlYWIxZmQwMDAwMCgwMDAwKSBr
bmwNCj4gICAgIEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gICAgIENTOiAgMDAxMCBEUzogMDAwMCBF
UzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gICAgIENSMjogMDAwMDAwMDAwMDAwMDA1
MCBDUjM6IDAwMDAwMDBmOGY4MGEwMDQgQ1I0OiAwMDAwMDAwMDAwNzYxZWUwDQo+ICAgICBEUjA6
IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAw
MDAwMA0KPiAgICAgRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBE
Ujc6IDAwMDAwMDAwMDAwMDA0MDANCj4gICAgIFBLUlU6IDU1NTU1NTU0DQo+ICAgICBDYWxsIFRy
YWNlOg0KPiAgICAgPyByZXBvcnRfbm9ybWFsX2RldGVjdGVkKzB4MjAvMHgyMA0KPiAgICAgcmVw
b3J0X2Zyb3plbl9kZXRlY3RlZCsweDE2LzB4MjANCj4gICAgIHBjaV93YWxrX2J1cysweDc1LzB4
OTANCj4gICAgID8gZHBjX2lycSsweDkwLzB4OTANCj4gICAgIHBjaWVfZG9fcmVjb3ZlcnkrMHgx
NTcvMHgyMDENCj4gICAgID8gaXJxX2ZpbmFsaXplX29uZXNob3QucGFydC40NysweGUwLzB4ZTAN
Cj4gICAgIGRwY19oYW5kbGVyKzB4MjkvMHg0MA0KPiAgICAgaXJxX3RocmVhZF9mbisweDI0LzB4
NjANCj4gICAgIGlycV90aHJlYWQrMHhlYS8weDE3MA0KPiAgICAgPyBpcnFfZm9yY2VkX3RocmVh
ZF9mbisweDgwLzB4ODANCj4gICAgID8gaXJxX3RocmVhZF9jaGVja19hZmZpbml0eSsweGYwLzB4
ZjANCj4gICAgIGt0aHJlYWQrMHgxMjQvMHgxNDANCj4gICAgID8ga3RocmVhZF9wYXJrKzB4OTAv
MHg5MA0KPiAgICAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4gICAgIE1vZHVsZXMgbGlua2Vk
IGluOiBuZnRfZmliX2luZXQuLi4uLi4uLi4NCj4gICAgIENSMjogMDAwMDAwMDAwMDAwMDA1MA0K
Pg0KPiBXaXRoIHRoaXMgcGF0Y2gsIHRoZSBoYW5kbGluZyBmbG93IG9mIERQQyBjb250YWlubWVu
dCBhbmQgaG90cGx1ZyBpcyANCj4gcGFydGx5IG9yZGVyZWQgYW5kIHNlcmlhbGl6ZWQsDQpJZiBp
dHMgYSBwYXJ0aWFsIGZpeCwgd2hhdCBzY2VuYXJpbyBpcyBub3QgY292ZXJlZD8NCg0KDQo6c2Vl
IHRoZSAxLzUgcGF0Y2guDQoNCj4gbGV0IGhhcmR3YXJlIERQQyBkbyB0aGUgY29udHJvbGxlciBy
ZXNldCBldGMgcmVjb3ZlcnkgYWN0aW9uIGZpcnN0LCANCj4gdGhlbiBEUEMgZHJpdmVyIGhhbmRs
aW5nIHRoZSBjYWxsLWJhY2sgZnJvbSBkZXZpY2UgZHJpdmVycywgY2xlYXIgdGhlIA0KPiBEUEMg
c3RhdHVzLCBhdCB0aGUgZW5kLCBwY2llaHAgaGFuZGxlIHRoZSBETExTQyBhbmQgUERDIGV0Yy4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogRXRoYW4gWmhhbyA8aGFpZmVuZy56aGFvQGludGVsLmNvbT4N
Cj4gVGVzdGVkLWJ5OiBXZW4gSmluIDx3ZW4uamluQGludGVsLmNvbT4NCj4gVGVzdGVkLWJ5OiBT
aGFuc2hhbiBaaGFuZyA8U2hhbnNoYW5YLlpoYW5nQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiAt
LS0NCj4gQ2hhbmdlczoNCj4gICBWMjogcmV2aXNlIGRvYyBhY2NvcmRpbmcgdG8gQW5keSdzIHN1
Z2dlc3Rpb24uDQo+ICAgVjM6IG5vIGNoYW5nZS4NCj4gICBWNDogbm8gY2hhbmdlLg0KPg0KPiAg
IGRyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX2hwYy5jIHwgNCArKystDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBjLmMgDQo+IGIvZHJpdmVycy9wY2kvaG90cGx1
Zy9wY2llaHBfaHBjLmMNCj4gaW5kZXggNTM0MzNiMzdlMTgxLi42ZjI3MTE2MGYxOGQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX2hwYy5jDQo+ICsrKyBiL2RyaXZl
cnMvcGNpL2hvdHBsdWcvcGNpZWhwX2hwYy5jDQo+IEBAIC03MTAsOCArNzEwLDEwIEBAIHN0YXRp
YyBpcnFyZXR1cm5fdCBwY2llaHBfaXN0KGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gICAJZG93
bl9yZWFkKCZjdHJsLT5yZXNldF9sb2NrKTsNCj4gICAJaWYgKGV2ZW50cyAmIERJU0FCTEVfU0xP
VCkNCj4gICAJCXBjaWVocF9oYW5kbGVfZGlzYWJsZV9yZXF1ZXN0KGN0cmwpOw0KPiAtCWVsc2Ug
aWYgKGV2ZW50cyAmIChQQ0lfRVhQX1NMVFNUQV9QREMgfCBQQ0lfRVhQX1NMVFNUQV9ETExTQykp
DQo+ICsJZWxzZSBpZiAoZXZlbnRzICYgKFBDSV9FWFBfU0xUU1RBX1BEQyB8IFBDSV9FWFBfU0xU
U1RBX0RMTFNDKSkgew0KPiArCQlwY2lfd2FpdF9wb3J0X291dGRwYyhwZGV2KTsNClRoaXMgd291
bGQgYWRkIHdvcnN0IGNhc2UgMXMgZGVsYXkgaW4gaGFuZGxpbmcgdGhlIERMTFNDIGV2ZW50cy4g
VGhpcyBkb2VzIG5vdCBkaXN0aW5ndWlzaCBiZXR3ZWVuIERMTFNDIGV2ZW50IHRyaWdnZXJlZCBi
eSBEUEMgb3IgaG90cGx1Zy4gQWxzbyBhZGRpdGlvbmFsIGRlbGF5IG1heSB2aW9sYXRlIHRoZSB0
aW1pbmcgcmVxdWlyZW1lbnRzLg0KOiBJdCB3aWxsIHdhaXQgb25seSB3aGVuIERQQyBpcyBlbmFi
bGVkIGFuZCB0cmlnZ2VyZWQuIE9yIGl0IHdpbGwgc2tpcCB0aGUgd2FpdGluZy4gDQpUZXN0IHdp
dGggZGlmZmVyZW50IHRpbWUgaW50ZXJ2YWwgYmV0d2VlbiBob3QtcmVtb3ZlIGFuZCBob3QtcGx1
Z2luLCBhbHNvIG5vIHNwZWMNClNheXMgaXQgd2lsbCB2aW9sYXRlIHRpbWluZyByZXF1aXJlbWVu
dC4gSXQgd29ya3MuIA0KDQpUaGFua3MsDQpFdGhhbg0KDQo+ICAgCQlwY2llaHBfaGFuZGxlX3By
ZXNlbmNlX29yX2xpbmtfY2hhbmdlKGN0cmwsIGV2ZW50cyk7DQo+ICsJfQ0KPiAgIAl1cF9yZWFk
KCZjdHJsLT5yZXNldF9sb2NrKTsNCj4gICANCj4gICAJcmV0ID0gSVJRX0hBTkRMRUQ7DQoNCi0t
DQpTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteQ0KTGludXggS2VybmVsIERldmVsb3Blcg0KDQo=
