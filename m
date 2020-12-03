Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3382CDDF3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgLCSpp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 13:45:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:65458 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgLCSpo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 13:45:44 -0500
IronPort-SDR: apa4ETHVzzlqqy4qSAaNeOCUWngF77VuAofZAHaqRGFPCQJLFT9HXEJNNTan5zKw2+M/SGbdQb
 7Y+MkAWmOvmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="153078148"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="153078148"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 10:45:03 -0800
IronPort-SDR: pP0ieNIrXG7UuX7378Qk0avKW6/T8I8b+FLnaINBZf5j6HxP0stnbept7lx2JQcfZgLZ/Q/txr
 HwYUmo3sjGEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="346339927"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2020 10:45:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Dec 2020 10:45:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Dec 2020 10:45:03 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 3 Dec 2020 10:45:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpGqtkT7fZkqxUdTTbomcQ+HPrL3RgSJxHs74AW9kcEqvbE9aOORP68aTI+cBg/u+co/JTG9pCM6e0EJ6inVnNn0Fc7UyfDDeL/X+R0mw9pxm1eTzD2cXCdammv8O+ldY7YDQMV8x58v2RLc7B7JkbPphZn8Ui0F49pKmM3fZg3QS/eoKkL8M8IUreuAFYfOvdlw/vg/+XOrnxaLwSVZZwH2odrvBr3LIdSAu72L+o6PhONqvHj/tA42Za9PePukh44EwFxae9YPEs5Q5QzLbLcjQThAbsrbT4FoLjYc34c7q1AY5n3X/tEvrvpiqAc+Cd8ygYRbfTCdfvL+pcGTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvMXj236IhCG0noQgFSty9oTbcMA1Z+nfHcWFlWLbfQ=;
 b=Wh/zD+mqXQsqDnLiBNVGqNzumUpUZ58DmnupcntXCUk1eW1t/HCznO3Jpf+hQsQYz2/TFvmQfGZcLTCRD0Lx+mZDPP4UT1xvdYiAKji96Eefflj7ekdVcA02Dp+8CszJNcQPks9TNH8N0AnnaZkKe0X7KbAoqAfs6YG7KEGnJB5kt2B2FaBerviH6yjf4IZnULIuTYIFf0p6/iXzD8hPA1U9x6NuRVxOT8DgA70LDukvtsyW9r57tJnsZNrL5wE3W1wc8gR5K6bVaaDC3ygXX2tX1bWg+c//6rN3Pym0BGamX6r2iY4RGlXrmuZRlZKHiyfP43+G3hLcChf/eiolEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvMXj236IhCG0noQgFSty9oTbcMA1Z+nfHcWFlWLbfQ=;
 b=lZUCJBMiNbJCX4zgZZaYAy2CsjXSFim7W9V8eDObSEiqhJnGX6fGj35XcNEq3Ht4R6B5nIEx39cVEhyCZV3Ia4ePsOxMdj3iKajhkO99thJfslEXHB+iYhsbaZran2MVvojqNK+Wcvq4PlN989sxz5xhlJORq51YAbQs1AqleA0=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:50::16) by BN8PR11MB3619.namprd11.prod.outlook.com
 (2603:10b6:408:85::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Thu, 3 Dec
 2020 18:45:00 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51%11]) with mapi id 15.20.3611.031; Thu, 3 Dec 2020
 18:45:00 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "xerces.zhao@gmail.com" <xerces.zhao@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v12 05/15] PCI/ERR: Simplify by using
 pci_upstream_bridge()
Thread-Topic: [PATCH v12 05/15] PCI/ERR: Simplify by using
 pci_upstream_bridge()
Thread-Index: AQHWv5rGUhzm/hDqdEig3r4uVN4V9anlyZeA
Date:   Thu, 3 Dec 2020 18:45:00 +0000
Message-ID: <BA95A917-CCFA-4A21-9146-0626716CAF65@intel.com>
References: <20201121001036.8560-1-sean.v.kelley@intel.com>
 <20201121001036.8560-6-sean.v.kelley@intel.com>
In-Reply-To: <20201121001036.8560-6-sean.v.kelley@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.20.0.2.21)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a447ec0e-3c5c-4acd-c060-08d897bb8a18
x-ms-traffictypediagnostic: BN8PR11MB3619:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB3619DBFA1949D789052BECBCB2F20@BN8PR11MB3619.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuQNlBII3ooqWLXY0tAj0T8t2wHoMZIbh4ykR7uvNSJKcMYrvsIRF1/q2i5ScLcdUE0hGelEznv//GB2UhEmW6930dJpqobKfb+mrS7y59YAQuOdV8hN6IGFjQmXnIdx8iG39wCREF5qkEaqXsbnA0n9imWabafM5No5vb5gHjxKlifknYiaJiMD5VbaD9u99IYoFTvUJ7ZJW+eON9XFGD7E4TqEN0ZSSAmxoRieX2VufNS+wTq9dKuE2Co2nwu3ecSnCov+DcmvE00Swci/S6jEyz3R+NL8E/tLixXoNiBA1+sqPnPSq1fmg4iQb5/TbR/UkPnJNclCBP6bWWjo7+Q+ojuG8zE9x/ZDJvIYffZS76m6DD1Lud0Kx29nwbKVB0/w5fXK5sOPVaWqZn9f3mUKnCM7/6AzAU6QlyD+Kcs0QtnXXQzhIi+cCXuoeSrOJxdzAal6tK7xiWXC2ecwpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(8676002)(86362001)(83380400001)(8936002)(64756008)(316002)(4326008)(54906003)(66946007)(5660300002)(6506007)(53546011)(6512007)(66476007)(76116006)(186003)(66556008)(26005)(6486002)(33656002)(91956017)(66446008)(71200400001)(478600001)(2616005)(6916009)(36756003)(966005)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aDdsN1lOWmN3eDBXQU5IZUNocjFnWm5BRkk4SHBNbTBZdSt1NmgxU2k1OTNq?=
 =?utf-8?B?TzVTUXhNUXc5cDhNd2dOUDZ0QTNaK1BRM1BrSVltWmtiTXdGUkFjMmVocVBW?=
 =?utf-8?B?eUp3V2tEb2JoZHA4c1llSGRKZHVPU29taUFDK0owaHBFa0FhTG9DaHVnM3Jo?=
 =?utf-8?B?aTN6OUxtMkwrREw3aTVqZHNaSWNBYmpzNWgwdEczTlpZRWlqRlNSdkE3UGlC?=
 =?utf-8?B?aVkyRUNBRGUveFR5TmFpSGhwQm5mNGFJRVJ3UjZFa3AwVW1qT1hycmpnMUZW?=
 =?utf-8?B?NkVUa2FML3hLd1RpTElmRHlieW9aRzM1Nm9hSTFvOTZuM0x6c2ZOUDJDbStl?=
 =?utf-8?B?dk9ONFBxYmVONHV6anFRS09Sc3R5R0U1VWRQcElpS0hsYVdOemh5R3g5TW03?=
 =?utf-8?B?V0pObWd6U0wxZFk3aHhVVnhzbXkzY2phcVFxdlB4aGRpSFNnRSticms0VURN?=
 =?utf-8?B?d2F4OERPR3lFSGN1YVlqZ3RvNTZoR1pTR2hVaG1KQklTU3JEUk9yNFN0a0Yy?=
 =?utf-8?B?YVZ1SWtGYk9aV29RZzlVeGs1U0htWndHWis5U0NmdVNwdWVCcjFpQlljall6?=
 =?utf-8?B?aXlVdnM1eEtmZ0tnZXJoZ1dRd2Z6OVRGaGdTTTc5Y2FlT2Zrd2lubXdlakNF?=
 =?utf-8?B?YmF3K05mZDYwRkVHVXN4dEVjT29jVnZoNTFRSXc1M1FVRkMwYmtOcE42ZEtG?=
 =?utf-8?B?SytvSlFGMHhrZEpTUzhoaFpFb2I4TkVraytDeWhOaThXN2QySW9TQWt6SnFQ?=
 =?utf-8?B?NENHVmhYaTE3NnAvVGZGVTFabkV4ekVXbjBlQWN4YjFUSGkvUWRjN0liNHh5?=
 =?utf-8?B?OEhMN0JDRDBXb3Jzb1V4TFUzT1dtYlNWbjZYZVJkNHZqZUVybG5QYjMxMTdT?=
 =?utf-8?B?c0NZdWk2dzY5YkVBeHF3ZkkxdUhkTTB2amVlR1VmSjVjTlk2azJqcU5uNWkr?=
 =?utf-8?B?ZDlwMnVkRWVINHoxUktxcG5yVmQ2b2NxSkc4a3RzTGU2Yzl5a1Fzd21qdFRP?=
 =?utf-8?B?MnZzSTd1Z3ZiZ2ZlMGRrOHEvdlBqVFFsQ2ZlQmVRdWxnWnM1U3BPZ0R0eG8z?=
 =?utf-8?B?dVdlUHpJM1Vma01qNWI1WWo5TDVVNGhuZHVuZmU0N1hVdnkvR0tLd0Fvb1FI?=
 =?utf-8?B?cG5uZCtGMEpOT09hb003K1htSlgrUWtZbGlwT2t2Nnp3TVJmR0dQRTFGaXNI?=
 =?utf-8?B?VHg5MnM0TFprR1FvajNYMGQ4VzYzYldwLzBZTDNqOEdMbVVMSlhCdjhoQzBB?=
 =?utf-8?B?aDlkR0FYOUMrUS9tdng0RU1Sem1nQldLc09qTUZkUHcxb0lQMGlHVCthZGJ0?=
 =?utf-8?Q?tkWBlzwIe6X+BN7b0n7rIiuapJ+8TpBII0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A841EE585B9ADF4B9A484B6D5E9F338F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a447ec0e-3c5c-4acd-c060-08d897bb8a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 18:45:00.3102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnu7evXsCtIyThbRkeYcNylA/7YQhzre8NowzCHrrpoQ2zo7fcPfektdhOs4+7fvwAfM2yjt2cGUHOeqvTwGEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3619
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpIaSBCam9ybiwNCg0KSnVzdCBjb25maXJtaW5nIHRoYXQgd2hlbiBzd2l0Y2hlZCBmcm9tIGRl
di0+YnVzLT5zZWxmIHRvIHBjaV91cHN0cmVhbV9icmlkZ2UoKSB3ZeKAmXJlIG9rYXkgd2l0aCB0
aGUgTlVMTCBjYXNlOg0KDQo+IE9uIE5vdiAyMCwgMjAyMCwgYXQgNDoxMCBQTSwgU2VhbiBWIEtl
bGxleSA8c2Vhbi52LmtlbGxleUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gVXNlIHBjaV91cHN0
cmVhbV9icmlkZ2UoKSBpbiBwbGFjZSBvZiBkZXYtPmJ1cy0+c2VsZi4gIE5vIGZ1bmN0aW9uYWwg
Y2hhbmdlDQo+IGludGVuZGVkLg0KPiANCj4gW2JoZWxnYWFzOiBzcGxpdCB0byBzZXBhcmF0ZSBw
YXRjaF0NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIwMTAwMjE4NDczNS4x
MjI5MjIwLTYtc2VhbnZrLmRldkBvcmVnb250cmFja3Mub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFNl
YW4gViBLZWxsZXkgPHNlYW4udi5rZWxsZXlAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBC
am9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBBY2tlZC1ieTogSm9uYXRoYW4g
Q2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiBSZXZpZXdlZC1ieTogS3Vw
cHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4
LmludGVsLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvcGNpL3BjaWUvZXJyLmMgfCAyICstDQo+IDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvZXJyLmMgYi9kcml2ZXJzL3BjaS9wY2llL2Vyci5jDQo+
IGluZGV4IGRiMTQ5YzZjZTRmYi4uMDVmNjFkYTVlZDlkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3BjaS9wY2llL2Vyci5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaWUvZXJyLmMNCj4gQEAgLTE1
OSw3ICsxNTksNyBAQCBwY2lfZXJzX3Jlc3VsdF90IHBjaWVfZG9fcmVjb3Zlcnkoc3RydWN0IHBj
aV9kZXYgKmRldiwNCj4gCSAqLw0KPiAJaWYgKCEocGNpX3BjaWVfdHlwZShkZXYpID09IFBDSV9F
WFBfVFlQRV9ST09UX1BPUlQgfHwNCj4gCSAgICAgIHBjaV9wY2llX3R5cGUoZGV2KSA9PSBQQ0lf
RVhQX1RZUEVfRE9XTlNUUkVBTSkpDQo+IC0JCWRldiA9IGRldi0+YnVzLT5zZWxmOw0KPiArCQlk
ZXYgPSBwY2lfdXBzdHJlYW1fYnJpZGdlKGRldik7DQoNCg0KVGhlIG9ubHkgY2FzZSB3aGVyZSBw
Y2lfdXBzdHJlYW1fYnJpZGdlKGRldikgY291bGQgYmUgTlVMTCBpcyBpZiBkZXYtPmJ1cyBpcyB0
aGUgcm9vdCBidXMgYW5kIHdlIGFyZSBiZWluZw0Kc2VsZWN0aXZlIGJhc2VkIG9uIHRoZSB0eXBl
Lg0KDQpFdmVuIGxhdGVyIGluIHRoaXMgc2VyaWVzIHdoZW4gd2UgYWN0dWFsbHkgYWRkIGluIFJD
X0VDL1JDX0VORCB3ZSBtYWludGFpbiB0aGUgY29uZGl0aW9uYWwgY2hlY2tzOg0KDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyMDExMjEwMDEwMzYuODU2MC0xMS1zZWFuLnYu
a2VsbGV5QGludGVsLmNvbS8NCg0KIHBjaV9lcnNfcmVzdWx0X3QgcGNpZV9kb19yZWNvdmVyeShz
dHJ1Y3QgcGNpX2RldiAqZGV2LA0KDQpAQCAtMTc0LDEwICsxODAsMTMgQEAgcGNpX2Vyc19yZXN1
bHRfdCBwY2llX2RvX3JlY292ZXJ5KHN0cnVjdCBwY2lfZGV2ICpkZXYsDQoNCiANCiAJLyoNCiAJ
ICogRXJyb3IgcmVjb3ZlcnkgcnVucyBvbiBhbGwgc3Vib3JkaW5hdGVzIG9mIHRoZSBicmlkZ2Uu
ICBJZiB0aGUNCi0JICogYnJpZGdlIGRldGVjdGVkIHRoZSBlcnJvciwgaXQgaXMgY2xlYXJlZCBh
dCB0aGUgZW5kLg0KKwkgKiBicmlkZ2UgZGV0ZWN0ZWQgdGhlIGVycm9yLCBpdCBpcyBjbGVhcmVk
IGF0IHRoZSBlbmQuICBGb3IgUkNpRVBzDQorCSAqIHdlIHNob3VsZCByZXNldCBqdXN0IHRoZSBS
Q2lFUCBpdHNlbGYuDQoNCiAJICovDQogCWlmICh0eXBlID09IFBDSV9FWFBfVFlQRV9ST09UX1BP
UlQgfHwNCi0JICAgIHR5cGUgPT0gUENJX0VYUF9UWVBFX0RPV05TVFJFQU0pDQorCSAgICB0eXBl
ID09IFBDSV9FWFBfVFlQRV9ET1dOU1RSRUFNIHx8DQorCSAgICB0eXBlID09IFBDSV9FWFBfVFlQ
RV9SQ19FQyB8fA0KKwkgICAgdHlwZSA9PSBQQ0lfRVhQX1RZUEVfUkNfRU5EKQ0KIAkJYnJpZGdl
ID0gZGV2Ow0KIAllbHNlDQogCQlicmlkZ2UgPSBwY2lfdXBzdHJlYW1fYnJpZGdlKGRldik7DQoN
CkkgYmVsaWV2ZSB3ZSBhcmUgb2theSBoZXJlLg0KDQpTZWFuDQoNCg0KPiAJYnVzID0gZGV2LT5z
dWJvcmRpbmF0ZTsNCj4gDQo+IAlwY2lfZGJnKGRldiwgImJyb2FkY2FzdCBlcnJvcl9kZXRlY3Rl
ZCBtZXNzYWdlXG4iKTsNCj4gLS0gDQo+IDIuMjkuMg0KPiANCj4gDQoNCg==
