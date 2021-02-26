Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D4326673
	for <lists+linux-pci@lfdr.de>; Fri, 26 Feb 2021 18:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZRsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Feb 2021 12:48:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:60932 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhBZRsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Feb 2021 12:48:00 -0500
IronPort-SDR: kxMsLFgRy7hFSN9+USTy70qhqnmIy2ZR87X5bUw/vnjPmORJbDONXWZEkHBuOagNix2hsxCDxc
 0qUJGkuQDqbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="183489155"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="183489155"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 09:47:19 -0800
IronPort-SDR: srmGlupHbVPvRLvoJXpVs7ih0f/eCzCBD9fD2Y3HaESQQsj30ROz1/riNzlRPnZvgw0NTl5Fx3
 3xHwO8+jrypQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="382085562"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 26 Feb 2021 09:47:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Feb 2021 09:47:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 26 Feb 2021 09:47:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 26 Feb 2021 09:47:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnyrkrK/1CK795zfPOhFHFA+wHLyoL7qiraFbQyvW6jVb1JT7v4nnVIG+DNXoN8AYHwD3ZH21QdbmEL6YsXIHGrNT4uHBLwLRdFo8tBBg8dE8UAheox/PAh9FKNrvVOVYx7j9CcjnkcX0ayvNJ+yspkSKSQtK/N7HOhnG0fQcpg/IVyqAlhDlMtn+vqdhCGn957Mb6BPiTdPhTUA85cBjfWxvQqir1YatWP+EZsnwkOORkE1laAXoRZt4vDTPNBMtjRnL6igswNW2wrKjSnHWeYyHmcyudyMB/ZZT5TYxqsvzlsJBaDUHQLbwCvsNazylL/lLFhIYy46AzlWNEf6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXOd9QNtkauWe2WrfIwjopfFLqzJcFouDzOhksoDcio=;
 b=XYvW47Hg3UGMJP0S62f4WKHSTyq8RkUw/9HdYcAykp/6WlolemxP3dkMZ2QU+7OR8XcijP6q719dZ7wClazjFO1kmCOhaSg0V3WszmTXE7bdW2Hc2k75yLrHuDgef7zQmQ7IzpwR7L62RZSfjrHapkLlnrE4ldLCBTv2RkSis3RYx/og1i9hErDwOgyI8uih/druzOkeehhyfaUVLO1vm8btMR9LsYSub5hqlVa9wRuhgBD/buSiOjKQt/iGj09qqPCKpgpyjOQ3YaqQ3E3KzhYoWQqkx30LU6Xyr7vR7UsAfYp/Nt9j8n+b/o773V+tDPXsm91uSNIUQ3JI93uEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXOd9QNtkauWe2WrfIwjopfFLqzJcFouDzOhksoDcio=;
 b=SEnrvnS24mFlXLEkpDPdl6qKObBhuzt8N/d9jTGjSuCfmxfb444kPithFbE3JVB+g4bCSkZSK/lWrACLZeqod65Kk2fitH6HE22nMjpAQHVtlkxxcTLvkT9XP2Ncc5w5tXitrEsYCUUbCPq11R7AUuJDv/TM8m7pgqSLsBLMrsI=
Received: from CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 by MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Fri, 26 Feb
 2021 17:47:17 +0000
Received: from CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::ddb6:ec7f:2548:efdc]) by CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::ddb6:ec7f:2548:efdc%4]) with mapi id 15.20.3890.023; Fri, 26 Feb 2021
 17:47:17 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     Xiaofei Tan <tanxiaofei@huawei.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "refactormyself@gmail.com" <refactormyself@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v2] PCI/AER: Change to use helper pcie_aer_is_native() in
 some places
Thread-Topic: [PATCH v2] PCI/AER: Change to use helper pcie_aer_is_native() in
 some places
Thread-Index: AQHW+2OXTQO1sw4VdEWDiekIWUR+qKpqUfQA
Date:   Fri, 26 Feb 2021 17:47:16 +0000
Message-ID: <24F76C61-22AA-466A-88EA-8C143616BA84@intel.com>
References: <1612490648-44817-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1612490648-44817-1-git-send-email-tanxiaofei@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.46.21020701
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9c59bc5-4dcb-4f80-d583-08d8da7e8ed6
x-ms-traffictypediagnostic: MWHPR11MB2047:
x-microsoft-antispam-prvs: <MWHPR11MB2047028F777B8A5BFBEACF64B29D9@MWHPR11MB2047.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+0rSxxkF/omYedB1k60KziqiOswIeIm21YJzj+mEwMvg8NdoA1D1glIEyw5NWzcfLnHDyZRhi4YzHCVZ1tfvH5q5gVH2H4eQ7ncZ4C2ce35ZidhWkM26VA0SDadBF0N8Ld1BNnbi//9rf/U+ly0sOAFqhcdocLk2Bnz8azaheuE4k3m9+K2eetmRRWWkBfmKBoCqqhuKkwz5qlEF2fcp8lI+MI/DNaPWqpBImJn1Q6dCraa0F271x5kbwqxAH4fBYDz80TKiAWqWgtfZ0GaFrWHx8uiLXNhzEt4yHSI1QFk5C5k5upG2zv+nYWXX2xUvdzswHRhsqKt2eNxYLCqSC4KJL+5FFfHZo0wvWKT0kEAri2xrV66II3m+Wr639sip8JfuSDdPXiB+pxHxawFyHAUI1mzOTwzz4X/OaKBjbu+UYH3z3z9kKpEqEPmqmd4HDbuD7rmxV0ZCl7+JugiTSOK3CktfSxULJZgbfbaYDl7hKjuq3rJ9XR0LCb4p3QmroDI711HKlAE/9tRI9ff2YhFooDHmObqkw5ypXCaF1WlRX84KtwA6wvxCPYGfhkVM1cPvou46mYJ2Tb+OlVRcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4929.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(316002)(71200400001)(91956017)(6512007)(478600001)(66556008)(5660300002)(8936002)(26005)(66946007)(66476007)(64756008)(8676002)(33656002)(110136005)(6486002)(86362001)(2616005)(4326008)(2906002)(186003)(76116006)(6506007)(36756003)(54906003)(83380400001)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RElJaUpLeEZTcnFpNTk3NlduRTFib2NXS1hoZlBscWFrVDNiaGZJWEkyMit6?=
 =?utf-8?B?SW0wUjBuWW5OZlduclRIYXdUTjJJLy8xN1hqTXdsSmtEeVN0amFjT2RxVmhh?=
 =?utf-8?B?Rnpud0V5Vi9uZnJtZVBja3cvVHJBVVREc3pRdXZQM2lRbVVkMlk2eXUyVWhY?=
 =?utf-8?B?d3VMYXlTSnpxbHNjM3hlRjhnQlE0U2wzZjZwajVtQmZxYjNFN3NjeHM3R0dy?=
 =?utf-8?B?c0IyeWJpb2FtV2xhQzM1WjFwemR2a3NqRHRPUlo2VzkySW84ajBNbkM1L0pt?=
 =?utf-8?B?VWZycmEyb09yeDl5MURveDZWTlU2V2oxalE1R3RpWHhhNHlFRjdRVHdGd3pN?=
 =?utf-8?B?VGFQUkxKQjVBUWRwVGg4T2hIamtqNXpNcnZXTUtsQm9pK1hCblR1NHlwOTBr?=
 =?utf-8?B?WjFGWGxnbXVDa3dlU2I5OGt1d25lVEtuU21vQjhjVW8rUStsaS9NTXMySkIx?=
 =?utf-8?B?Rm42UUdKUUkzelNNNEZFcEJDUGw4b0FJNGZBeThObGE4QmpITXpqNEV3Zjkr?=
 =?utf-8?B?eUk1aUNTWFRHOERsQUNXNUwzRWVlZUhkcFczNmJUVHVUMTlJSEpYanc2TjlK?=
 =?utf-8?B?TTdvR09YUWk4YkxjSEE1SWVqSUUxL1hTYkkzajBQZnBWZVpiZTZiRmozVFlY?=
 =?utf-8?B?NWMwL1lwTXUyaWxKYjJEbnRpdHgxVEhLcC9mc2NSZ3Fqeml0N21lMGhxSDJj?=
 =?utf-8?B?RXUrUTVBTmtZMUtrWElkSm5OWUFwMERXaml0d3h3QmZscTRsV2VjQ2xrTDY4?=
 =?utf-8?B?TE1GbitPNks0Si9ncFg2WmhrRDZxQVFLU2hoNTNkRUNIOW1sV0tXQ1lQQ3Mx?=
 =?utf-8?B?U3J5NEZ1dW1lMENacC9EWnZuV05rMTNUd1VSNGd4UTY3RkFnclloNDZ3RjlQ?=
 =?utf-8?B?Snk1bnlxODh4OVA4anUwTGdaSmRsZDNxVVh6OVE2eUh4d1hvbitMdFN1dEox?=
 =?utf-8?B?ZEo0alJweFAvYUp1WnlhNmxaTk9EN3J0aTluS25tNjQrcU1RMy8xRkZQZ09V?=
 =?utf-8?B?YzhLVDdxZElGSzVOWGVoeXNUYU93NGQydVhrSUxxTUFkeHpFSVNGdlE5ODNX?=
 =?utf-8?B?V25WKytXTHlwV2hnMjd0ekJ3eWh2K0w0Q2U3WjVub1hqUEN6eTd0U04rZ0la?=
 =?utf-8?B?dkZKQUhhaG5QeDB1Uzl3eWsvbzBZU0tkdFBtMWowcVNLc3AwblBZL21PYTV3?=
 =?utf-8?B?WDh6MDNzOHpQL2ZNK3RhOWl5c2RBdkJXWFVGN09IUUtnS0x2UUhNakU0aWNX?=
 =?utf-8?B?cWxScVgrTjJlejJRa1U1OEdmS2N0Y25vOWZROXJnNURaSEFUb2tvY3JTZzVV?=
 =?utf-8?B?ME05eHhpTEZoK0NPRmljcmI0SFZTSkQrM05Dc1Z6MWJHY081Y2cyUXVrdE04?=
 =?utf-8?B?S0I2elY4d01zaFg5VDRLRk9aa21NUGRVK1l4MzB3WEFCTHp0Slp0Mmx5Unlo?=
 =?utf-8?B?dzZmdm1IZnk1eVNnQWZzYi9lN2I1dnZJd1VTcEJMMnJPWW5kK09tQmd0TlE3?=
 =?utf-8?B?UUZsT1duMXR6a29EVTRybitEb1RsRmpGaUVNL3RBWXVFNWV4cjFxT2swNWd6?=
 =?utf-8?B?NHM2R0pXbHdpSmZNVUxMSHlFdkt5V1o3bGE4TkFNdUZ5Y3YrU0ViQ28vOGU3?=
 =?utf-8?B?UWNBK1d1RjdVZ0w0d1RZM0xKWWZoZ042c2pGZ0lVVEQrSzRpWFNXQkdMcHhn?=
 =?utf-8?B?K3l4eWltV2ZzcGJRU3R5WUpQUE1hYlVOUDFzYXVISVYrbXJhcmhOTEl2Y1dw?=
 =?utf-8?Q?XAWy610+rrI1GWyMRAuyqfVnWwYmnymmys04Zy5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F08C81A840EE9B4ABDC8CCAB86203557@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4929.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c59bc5-4dcb-4f80-d583-08d8da7e8ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 17:47:16.9247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPAKe/Qdl24cMLLnqsrnlRUACN/uOpspKE0N77ve9HXz9Fui/QreXF+TBJaCOISt0hwynhC+UCbapUeUXu5z8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2047
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCu+7v09uIDIvNC8yMSwgNjowNyBQTSwgIlhpYW9mZWkgVGFuIiA8dGFueGlhb2ZlaUBodWF3
ZWkuY29tPiB3cm90ZToNCg0KICAgIFVzZSBoZWxwZXIgZnVuY3Rpb24gcGNpZV9hZXJfaXNfbmF0
aXZlKCkgaW4gc29tZSBwbGFjZXMgdG8ga2VlcA0KICAgIHRoZSBjb2RlIHRpZHkuIE5vIGZ1bmN0
aW9uIGNoYW5nZXMuDQoNCiAgICBTaWduZWQtb2ZmLWJ5OiBYaWFvZmVpIFRhbiA8dGFueGlhb2Zl
aUBodWF3ZWkuY29tPg0KICAgIFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgV2lsY3p5xYRza2kgPGt3
QGxpbnV4LmNvbT4NCg0KDQpOaWNlIHVzZSBvZiB0aGUgaGVscGVyIGFuZCBnb29kIHN1Z2dlc3Rp
b24gZnJvbSBLcnp5c3p0b2YuDQoNCkFja2VkLWJ5OiBTZWFuIFYgS2VsbGV5IDxzZWFuLnYua2Vs
bGV5QGludGVsLmNvbT4NCg0KDQoNCiAgICAtLS0NCiAgICBDaGFuZ2VzIGZyb20gdjEgdG8gdjI6
DQogICAgLSBBZGQgdGhlIGZpeCBzdWdnZXN0ZWQgYnkgS3J6eXN6dG9mLg0KICAgIC0tLQ0KICAg
ICBkcml2ZXJzL3BjaS9wY2llL2Flci5jICAgICAgICAgIHwgNCArKy0tDQogICAgIGRyaXZlcnMv
cGNpL3BjaWUvZXJyLmMgICAgICAgICAgfCAyICstDQogICAgIGRyaXZlcnMvcGNpL3BjaWUvcG9y
dGRydl9jb3JlLmMgfCAzICstLQ0KICAgICAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCg0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2llL2Fl
ci5jIGIvZHJpdmVycy9wY2kvcGNpZS9hZXIuYw0KICAgIGluZGV4IDc3YjBmMmMuLjAzMjEyZDAg
MTAwNjQ0DQogICAgLS0tIGEvZHJpdmVycy9wY2kvcGNpZS9hZXIuYw0KICAgICsrKyBiL2RyaXZl
cnMvcGNpL3BjaWUvYWVyLmMNCiAgICBAQCAtMTM5Nyw3ICsxMzk3LDcgQEAgc3RhdGljIHBjaV9l
cnNfcmVzdWx0X3QgYWVyX3Jvb3RfcmVzZXQoc3RydWN0IHBjaV9kZXYgKmRldikNCiAgICAgCSAq
Lw0KICAgICAJYWVyID0gcm9vdCA/IHJvb3QtPmFlcl9jYXAgOiAwOw0KDQogICAgLQlpZiAoKGhv
c3QtPm5hdGl2ZV9hZXIgfHwgcGNpZV9wb3J0c19uYXRpdmUpICYmIGFlcikgew0KICAgICsJaWYg
KHBjaWVfYWVyX2lzX25hdGl2ZShkZXYpICYmIGFlcikgew0KICAgICAJCS8qIERpc2FibGUgUm9v
dCdzIGludGVycnVwdCBpbiByZXNwb25zZSB0byBlcnJvciBtZXNzYWdlcyAqLw0KICAgICAJCXBj
aV9yZWFkX2NvbmZpZ19kd29yZChyb290LCBhZXIgKyBQQ0lfRVJSX1JPT1RfQ09NTUFORCwgJnJl
ZzMyKTsNCiAgICAgCQlyZWczMiAmPSB+Uk9PVF9QT1JUX0lOVFJfT05fTUVTR19NQVNLOw0KICAg
IEBAIC0xNDE3LDcgKzE0MTcsNyBAQCBzdGF0aWMgcGNpX2Vyc19yZXN1bHRfdCBhZXJfcm9vdF9y
ZXNldChzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KICAgICAJCXBjaV9pbmZvKGRldiwgIlJvb3QgUG9y
dCBsaW5rIGhhcyBiZWVuIHJlc2V0ICglZClcbiIsIHJjKTsNCiAgICAgCX0NCg0KICAgIC0JaWYg
KChob3N0LT5uYXRpdmVfYWVyIHx8IHBjaWVfcG9ydHNfbmF0aXZlKSAmJiBhZXIpIHsNCiAgICAr
CWlmIChwY2llX2Flcl9pc19uYXRpdmUoZGV2KSAmJiBhZXIpIHsNCiAgICAgCQkvKiBDbGVhciBS
b290IEVycm9yIFN0YXR1cyAqLw0KICAgICAJCXBjaV9yZWFkX2NvbmZpZ19kd29yZChyb290LCBh
ZXIgKyBQQ0lfRVJSX1JPT1RfU1RBVFVTLCAmcmVnMzIpOw0KICAgICAJCXBjaV93cml0ZV9jb25m
aWdfZHdvcmQocm9vdCwgYWVyICsgUENJX0VSUl9ST09UX1NUQVRVUywgcmVnMzIpOw0KICAgIGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2llL2Vyci5jIGIvZHJpdmVycy9wY2kvcGNpZS9lcnIu
Yw0KICAgIGluZGV4IDUxMGYzMWYuLjFkNmNmYjkgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVycy9w
Y2kvcGNpZS9lcnIuYw0KICAgICsrKyBiL2RyaXZlcnMvcGNpL3BjaWUvZXJyLmMNCiAgICBAQCAt
MjM3LDcgKzIzNyw3IEBAIHBjaV9lcnNfcmVzdWx0X3QgcGNpZV9kb19yZWNvdmVyeShzdHJ1Y3Qg
cGNpX2RldiAqZGV2LA0KICAgICAJICogdGhpcyBzdGF0dXMuICBJbiB0aGF0IGNhc2UsIHRoZSBz
aWduYWxpbmcgZGV2aWNlIG1heSBub3QgZXZlbiBiZQ0KICAgICAJICogdmlzaWJsZSB0byB0aGUg
T1MuDQogICAgIAkgKi8NCiAgICAtCWlmIChob3N0LT5uYXRpdmVfYWVyIHx8IHBjaWVfcG9ydHNf
bmF0aXZlKSB7DQogICAgKwlpZiAocGNpZV9hZXJfaXNfbmF0aXZlKGRldikpIHsNCiAgICAgCQlw
Y2llX2NsZWFyX2RldmljZV9zdGF0dXMoYnJpZGdlKTsNCiAgICAgCQlwY2lfYWVyX2NsZWFyX25v
bmZhdGFsX3N0YXR1cyhicmlkZ2UpOw0KICAgICAJfQ0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9wY2llL3BvcnRkcnZfY29yZS5jIGIvZHJpdmVycy9wY2kvcGNpZS9wb3J0ZHJ2X2NvcmUu
Yw0KICAgIGluZGV4IGUxZmVkNjY0Li4zYjM3NDNlIDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMv
cGNpL3BjaWUvcG9ydGRydl9jb3JlLmMNCiAgICArKysgYi9kcml2ZXJzL3BjaS9wY2llL3BvcnRk
cnZfY29yZS5jDQogICAgQEAgLTIyMSw4ICsyMjEsNyBAQCBzdGF0aWMgaW50IGdldF9wb3J0X2Rl
dmljZV9jYXBhYmlsaXR5KHN0cnVjdCBwY2lfZGV2ICpkZXYpDQogICAgIAl9DQoNCiAgICAgI2lm
ZGVmIENPTkZJR19QQ0lFQUVSDQogICAgLQlpZiAoZGV2LT5hZXJfY2FwICYmIHBjaV9hZXJfYXZh
aWxhYmxlKCkgJiYNCiAgICAtCSAgICAocGNpZV9wb3J0c19uYXRpdmUgfHwgaG9zdC0+bmF0aXZl
X2FlcikpIHsNCiAgICArCWlmIChwY2lfYWVyX2F2YWlsYWJsZSgpICYmIHBjaWVfYWVyX2lzX25h
dGl2ZShkZXYpKSB7DQogICAgIAkJc2VydmljZXMgfD0gUENJRV9QT1JUX1NFUlZJQ0VfQUVSOw0K
DQogICAgIAkJLyoNCiAgICAtLSANCiAgICAyLjguMQ0KDQoNCg==
