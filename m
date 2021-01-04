Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EED2E9D45
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 19:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbhADSnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 13:43:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:44942 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhADSnl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 13:43:41 -0500
IronPort-SDR: PSwR8fDBgZVjigOt3x9LjrQcdyM+ET34NfMEJTRE9QxMCaBeHNEx4C8lwV5AnzvLiJx4tHWF8j
 8uQptc/ClC0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156185400"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="156185400"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 10:43:00 -0800
IronPort-SDR: Z3ahTv7XMIuqKxf4M2pDdNRYl0hDE2o+fKK8YcRofDcHXO0kIPE58swwIHeCbsV8U2IHX1uyyt
 tO8Q6sad4ogw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="350041490"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2021 10:43:00 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 10:42:59 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 10:42:59 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 10:42:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni6EvyU5YJF6vWhP8iLKUy5j+DmCkUkwimCBjo4Xt3reufySqe5syl81kss0Zy6PfYng+le2a85ri9oHple9cNlJDSSPllan+84io+9fAiYqm2loa+Mb12QFPADQKm0K9DrIui5V5YxXmV78tEi5QEyIgu4DI5n1dJSurxWW+KlTnqyrJuH0rKYmRLdkfdwzscTYEmXT2H1oI68KTiV4njeIi5vhS1AxucU/db9kdcGujiGJ/+S6CCoDsVzdj+zgfWAnDTbUSPV/eD+iqLO9GGVdD0yEHJ0L+FYWdp52riivWfzCqrGv2rdDPA4ViLM7G7hemEzTqj1KLVTH63LYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQk7Y6QEFNmCKMfLqBvx4QEw/IcQbmoUSuerEMyGwwI=;
 b=gF6CJelnAFmfYxTlixduJVIMrDjnMp7NInlLO3FXzCQ/21ubJO1i0TRNflVVwKhLMYogAH/nY8HsYjaGUN7Jv8EYlPiW1ZkjWQ/V7/RvCkUiFNfRBTzN1y4sU6Isu1tEZS/PS18XuNc06Y16H20CWqNDzOnDPWD4efWpep+BM8/rECyDWzoKrC+YRoha3gvcSjVbmLC7DJPfMqg50XweQ0cdOAtHYmtEM/MNI8o3PrEAtNROWNegd4OccAe/9IzXnsGU5836NHbuNPQP208HSw6rgGiYJ19x/A2ZyJp1hY6dZrUNKxKHEtv4qqeOqhOkd+KN80SsAO+D8ngUO6C/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQk7Y6QEFNmCKMfLqBvx4QEw/IcQbmoUSuerEMyGwwI=;
 b=pyjTFw9jpLm60EnTFeFadgfrVdqveXvgRgiGedNrFdsFOvGvqK5iJNhykXtR7YdVL/pHFvwgd0LmxYlg9uQaSP+Knsd2Qd8HTcXSc9VK4flxB463otqHAJLAW7BiMX3q8uknxU3VcMc/M1J7hmPgvQ6GxnBGISUXG5sBLq9AETM=
Received: from CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 by MWHPR11MB0063.namprd11.prod.outlook.com (2603:10b6:301:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Mon, 4 Jan
 2021 18:42:58 +0000
Received: from CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf]) by CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf%3]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 18:42:58 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI/AER: Actually get the root port
Thread-Topic: [PATCH 2/3] PCI/AER: Actually get the root port
Thread-Index: AQHW1JhOrRzR6Vc1NEaEbAjSo/oS9qoX6aWA
Date:   Mon, 4 Jan 2021 18:42:58 +0000
Message-ID: <F5E3C1CC-4420-4EA2-9770-8AEBDE0CEACA@intel.com>
References: <20201217171431.502030-1-kbusch@kernel.org>
 <20201217171431.502030-2-kbusch@kernel.org>
In-Reply-To: <20201217171431.502030-2-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.32)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84af7dcf-574b-401d-16cc-08d8b0e08e91
x-ms-traffictypediagnostic: MWHPR11MB0063:
x-microsoft-antispam-prvs: <MWHPR11MB00633F0417567CCA79BFFAC4B2D20@MWHPR11MB0063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:216;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOIiPR+RlMZ6617RCN9FwIhorEbkee2fIUn2Lo6Q3AlAJzxGPwZuDk8tUomiVhJ9Nfr8YK2FzUVS0JFrkztb1jUclxomCpFQ+rAujboWqEVyJz1sQPSJI/cZpgr7Q4cF3qza/8DleizLmPNbiJtlSfeccSbRyhQ7DpGStJGQ4Ke6Cb+e45gJaXKFwg4sGK8MXLs5rvT26D8MzAVxcgCBFR8/Ne146w9lgm19+jxI6UjjMFNmFXaT3SD7pKxKEaovHHpVatknQYqwqt7u4IbWLnq6Lrw7Vp3q1eji3cp+qOLDR5pIk0A2dH/aTO1NxjdZd1X1ZMSGiw5w4zJj8ReYKzDw5HNQuQtC13qA8O5K0LbceHsiG/3OlE2NMoe6HGCW34P1HD3zlllyNiZpqWM7zLMJFa1CkPtCVT056DZCQtFxkrgzaRapFW1yk5ppXU4y6x4vgjnxOu44tGBZmL8EcpJ8e/odLrf10ah1rxy2gQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4929.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(6506007)(26005)(8936002)(316002)(86362001)(2616005)(2906002)(4326008)(53546011)(83380400001)(6486002)(186003)(33656002)(54906003)(8676002)(66476007)(71200400001)(36756003)(478600001)(6916009)(66556008)(76116006)(66946007)(6512007)(5660300002)(64756008)(66446008)(15583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bVphNnl5dDF2aFB4SmJvRjQ1S0xSMTRLVWxsRU16UDJ2STViRFBSSHhkTTgx?=
 =?utf-8?B?ektHWXBSU1VMS1FOWWxHdEtvcGxxTFNXeTJMS2pyQzB2WlAwbkhyLzdGME1Z?=
 =?utf-8?B?ZGEzUFVES3c1QndiUzhmbHQ0K2UxakJXV2x1Y25id2VqV1NQWnRqNk8xbnU3?=
 =?utf-8?B?eFFkZW56dlp3MzJ2WkwzSTBHTlpRa0pwNFdickpoZDQwKzAzN1R0QnBmZUFi?=
 =?utf-8?B?QVAwVVlFSDVTRTFJc1RqL2cwMThibVpsS1JlWUVGYlpzeXBKcmQ2cGtydzNN?=
 =?utf-8?B?SEhGc0VEMUhXcEEzb2JVb0lnc2k2WHNWaFJ5VS85ZU1mQUJ0Um02aFIvSWJp?=
 =?utf-8?B?NjRkOXRVVHFoWjE0RzMvZVpWVURwM2wvdjk5RFpXYWYrd2hYUU9sdktpQk5u?=
 =?utf-8?B?MEZnSFJDSDNLUDRpcXZtZWNwRE80Q1NnVllzbk93UUQ2SEs0bmpLVXZDMU1x?=
 =?utf-8?B?QjdXaGJSdW1vMTUwY1J4M0VpWXdWNGg1NUhRN2sweWN1RWRnL3Fyc016WjRF?=
 =?utf-8?B?TUlYV0J6b2pMZTRzYk5HaWpkemo4TndEbUlINFR5ZHg2T0dqT3J5OUUySXlU?=
 =?utf-8?B?VDBuWnJINkh1dXdsV1VCL2xCdzhaV1lDMCtNejJXNVcvMFNDNHpMS2h5bGZ4?=
 =?utf-8?B?dE9rVzJkRTRpL05jR0wxR01SeVpSMWI4WTJrb0c2TFFRS3ZqMW4weXpSKzBC?=
 =?utf-8?B?OXRDUG55dUVhTWlsakltS213Z2RSSTNxRUNNaTZjWmFZVzUzNnluQ2JCNzE3?=
 =?utf-8?B?SG5ZbTYrbWNVUXNJYW45V29WOEFoUlJBWk1FeHJvMEZ0VUd1SEM5eFhBWDF2?=
 =?utf-8?B?dXJPQ1VQb2JXNUVBRmlQY0pTd1NiY0FlUEJoZkxrNzd1NHJJVG0wckNFditJ?=
 =?utf-8?B?Q245dm1CdjZkKzk3dHI3RzlKTDlkdnlFS2duYmRzQUFmbndQOTJtNDFaMmlD?=
 =?utf-8?B?Z3RQZUJXemFaZFl1ZUFPbVllank4U0JPeXE3aDR2YW9TYXVyMXVSUTlKc3pq?=
 =?utf-8?B?dGhMSFVPSW1TMVVXSGI4UlczY0F4NXpXcS8rYUxZeE9Lblo2eXkxOTVpaEtm?=
 =?utf-8?B?eDgrU0FsT0NMNENwSUJMcHF3Qlh5S25JTk95RWZQMzFRQWs4eTlCZXRCV1pS?=
 =?utf-8?B?d3RkL3RKQjVzdmczWXNmRTNIREtuMUxVdWdUQ2Nxemd6Ymo1WDZXdDBuWnRD?=
 =?utf-8?B?NEE1Q2lISUIzTXpwdE5xU2x0TGFDUHJ2TW8rZDJUczlvOFNsMTJHRDAyOUtE?=
 =?utf-8?B?MGlpeGZiYTByekE4UnBZbjFZWTN3WmxwRFJqbnU3MDZQVVFRZmVWQXdLWmcv?=
 =?utf-8?Q?zWmMoQPvq3k7meZSxN0DFeLx0ezXB2HyzA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4740DACA8902A247933681C4920CDE97@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4929.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84af7dcf-574b-401d-16cc-08d8b0e08e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 18:42:58.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wu1HR8NMsLjAZypPvjS8IGl/K/fpKBGvwT7dC1+qzisq2dOq5n6BOh81BRQQEi5b/W47mQJMLnHEX+Owag2LTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0063
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2VpdGgsDQoNCj4gT24gRGVjIDE3LCAyMDIwLCBhdCA5OjE0IEFNLCBLZWl0aCBCdXNjaCA8
a2J1c2NoQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gVGhlIHBjaV9kZXYgcGFyYW1ldGVyIGdp
dmVuIHRvIGFlcl9yb290X3Jlc2V0KCkgbWF5IGJlIGEgZG93bnN0cmVhbSBwb3J0DQo+IHJhdGhl
ciB0aGFuIHRoZSByb290IHBvcnQuIEdldCB0aGUgcm9vdCBwb3J0IGZyb20gdGhlIHByb3ZpZGVk
IGRldmljZSBpbg0KPiBvcmRlciB0byBjbGVhciB0aGUgcm9vdCdzIGFlciBzdGF0dXMsIGFuZCB1
cGRhdGUgdGhlIG1lc3NhZ2UgdG8gaW5kaWNhdGUNCj4gd2hpY2ggdHlwZSBvZiBwb3J0IHdhcyBh
Y3R1YWxseSByZXNldC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoIDxrYnVzY2hA
a2VybmVsLm9yZz4NCj4gLS0tDQo+IGRyaXZlcnMvcGNpL3BjaWUvYWVyLmMgfCA1ICsrKy0tDQo+
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9hZXIuYyBiL2RyaXZlcnMvcGNpL3BjaWUvYWVy
LmMNCj4gaW5kZXggNzdiMGYyYzQ1YmMwLi5iMmIwZTllYjVjZmIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvcGNpL3BjaWUvYWVyLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvcGNpZS9hZXIuYw0KPiBA
QCAtMTM4OCw3ICsxMzg4LDcgQEAgc3RhdGljIHBjaV9lcnNfcmVzdWx0X3QgYWVyX3Jvb3RfcmVz
ZXQoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gCWlmICh0eXBlID09IFBDSV9FWFBfVFlQRV9SQ19F
TkQpDQo+IAkJcm9vdCA9IGRldi0+cmNlYzsNCj4gCWVsc2UNCj4gLQkJcm9vdCA9IGRldjsNCj4g
KwkJcm9vdCA9IHBjaWVfZmluZF9yb290X3BvcnQoZGV2KTsNCg0KVGhpcyBpcyBhIGdvb2Qgc2Fu
aXR5IGNoZWNrIG9uIHRoZSBkZXYgYmVpbmcgcGFzc2VkLiAgVGhpcyBhbHNvIHJlbWluZHMgbWUg
dG8gdGFrZSBhIGxvb2sgYXQgcGNpZV9kb19yZWNvdmVyeSgpIGluIHRlcm1zIG9mIGNsYXJpdHkg
d2l0aCB0aGUgdHdvIGRldmljZXMgb2YgaW50ZXJlc3QgYmVpbmcgaGFuZGxlZC4NCg0KQWNrZWQt
Ynk6IFNlYW4gViBLZWxsZXkgPHNlYW4udi5rZWxsZXlAaW50ZWwuY29tPg0KDQo+IA0KPiAJLyoN
Cj4gCSAqIElmIHRoZSBwbGF0Zm9ybSByZXRhaW5lZCBjb250cm9sIG9mIEFFUiwgYW4gUkNpRVAg
bWF5IG5vdCBoYXZlDQo+IEBAIC0xNDE0LDcgKzE0MTQsOCBAQCBzdGF0aWMgcGNpX2Vyc19yZXN1
bHRfdCBhZXJfcm9vdF9yZXNldChzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiAJCX0NCj4gCX0gZWxz
ZSB7DQo+IAkJcmMgPSBwY2lfYnVzX2Vycm9yX3Jlc2V0KGRldik7DQo+IC0JCXBjaV9pbmZvKGRl
diwgIlJvb3QgUG9ydCBsaW5rIGhhcyBiZWVuIHJlc2V0ICglZClcbiIsIHJjKTsNCj4gKwkJcGNp
X2luZm8oZGV2LCAiJXMgUG9ydCBsaW5rIGhhcyBiZWVuIHJlc2V0ICglZClcbiIsIHJjLA0KDQpQ
ZXJoYXBzIOKApiAiJXMlcyBQb3J0DQoNCg0KPiArCQkJcGNpX2lzX3Jvb3RfYnVzKGRldi0+YnVz
KSA/ICJSb290IiA6ICJEb3duc3RyZWFtIik7DQo+IAl9DQo+IA0KPiAJaWYgKChob3N0LT5uYXRp
dmVfYWVyIHx8IHBjaWVfcG9ydHNfbmF0aXZlKSAmJiBhZXIpIHsNCj4gLS0gDQo+IDIuMjQuMQ0K
PiANCg0K
