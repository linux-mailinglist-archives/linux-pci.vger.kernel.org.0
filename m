Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0EF2CF4B9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 20:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgLDT0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 14:26:47 -0500
Received: from mga06.intel.com ([134.134.136.31]:39294 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgLDT0q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 14:26:46 -0500
IronPort-SDR: q9zrGS3dLdJJwIPfrgjL0jArBf4FFf03rNPLkNvvX/ow0A4QlesOcu42WrQAOg2BkEdsgp6Rxl
 XbemV/fkg9HQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="235031834"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="235031834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 11:26:05 -0800
IronPort-SDR: 7MgrrDyzmilp1/f1AnkZCZjwf4Rb3g1Gs/yTp7WwTJmm1cHNUuLOza+sZghe7E0eu8PQjaobVL
 /YY4WLbPWpzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="317051324"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 04 Dec 2020 11:26:04 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Dec 2020 11:26:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 4 Dec 2020 11:26:04 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 4 Dec 2020 11:26:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMsw6TO2Z+68rds1Mvu5x/3pvukQmecAu+cMSalQqRr8TB2taMT+gCxSjk0rEz6BF42cqkRpZDW2uHKc2mItY3LtOfOc9FDIEyz1SSlXeT5DRsIrrP++AYPlJYhq+2QyR6JwTMpjxOaoFNC7ajsN0YT/7gFng/G+wrNfZNNARZrggndlSkpmxo0heDIgBBTZq3wq2KsHHMznvWulJQ3W6gaHtcx9FiLEab+i1F6ad2zUSmSGcw3o1+GXRa0r1Xj+XdPQZ1oszHic5fFaGLhoADqmQ/+QvdpX5FqdlszpmWkSMZ3HgnIVj0D4fmwyoZxJHErcHEsyXVTOUB3axekS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4pEo50c5Lq4IT2sCFPYl3RSi+/K/kEUT7XB/O5Fj7k=;
 b=C6RmJZyf+DxWL3JbPT9eE7bk8PXksf6JE2Qk8jspHdCPhZUflF/YQ097q395SVI5GkvVK5Rnz7Q2ilw3SYxgsfni/gXUeE3FoiVgK4zZQTTkxBY8PkiQZWpMPm2VjARu+2Jo+1q7ouowck1+orpkzoR1nCMErH+9tm9Y0BDiGrBwtOMzK+to+WCcYhTcgdj14Wq9o9+vG/ZFK35cnyrtKRV8jtW18cA9RQd/EJj+yIteSdxM/g2HF8EAZhtNI7uWYhcZvgvqsTk2uSznKJKaPsy3rwHMj5RabwcBWZoqYcDZP5lEE4tgAwXDTvFP9wgAJPATk1i688m0yfjGz+cR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4pEo50c5Lq4IT2sCFPYl3RSi+/K/kEUT7XB/O5Fj7k=;
 b=MtkVtnlQpxzcnqrKn1PZFueMYwVUdCGkBQGXdY8HqcakeWYYUIkhGj6TBilZWrc5Zf2HnDpc6j5l3/wAIjem1F4Jl177Crc9dGye1Ur1R/XzY3VGb18FM7GfXL9Q9R4QLCQ51fhGoKTxedKGR8oJLq3Dg0EqyeJiXzWX/wjrt5I=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2902.namprd11.prod.outlook.com (2603:10b6:a03:83::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 4 Dec
 2020 19:26:01 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3611.035; Fri, 4 Dec 2020
 19:26:01 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>
CC:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 0/9] CXL 2.0 Support
Thread-Topic: [RFC PATCH 0/9] CXL 2.0 Support
Thread-Index: AQHWyfvVM01ohEcArEOgD0FaPRJZoKnnNQaAgAAJAYCAABSZAA==
Date:   Fri, 4 Dec 2020 19:26:01 +0000
Message-ID: <1878cd93df75dc8c1b35eab7b7aaaed243f9129e.camel@intel.com>
References: <FB00A034-7C6D-40B1-8452-318A3B052216@avery-design.com>
         <F0ACA340-5BDE-4C17-80ED-DB7F5C5B8403@avery-design.com>
         <20201204181217.n3cm7gqujaqlcp2h@intel.com>
In-Reply-To: <20201204181217.n3cm7gqujaqlcp2h@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00d34ab9-bcf7-415a-8b19-08d8988a6f70
x-ms-traffictypediagnostic: BYAPR11MB2902:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2902BC9E50F4C73F2B9F7DADC7F10@BYAPR11MB2902.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJSJAqkZNQmORdOroUQQ+5Qhu0e8t6KAg+hg/eMqfMVmeyDFwcIlzMhw82SS8DsXyTy3YJ3p/MrB+oiMCmvJhCJbHvFI15rrKPRPTJUQqL34/3MpJYO6Xf6iRIWvRwAixC+mwDyZLIuRJD0kLaYIMMZp8CLedmTi8lyXg7SHcefU46FlOFfTvKCqEo8XcRSyML2UX1bBGhT4ziCZ09fhfOzqERaevNxslbEMrRJrUgUUemaxpsozGhEGnMQbk4/aZBJ2/D1zgqfUCoLQQx2Gc92zSbUuVB6cZQLMpCF/3m8/jwOCQ45YDuK6gsPBJuyJDgXOmj5tEItfSqdiFsqmKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(66556008)(5660300002)(64756008)(66476007)(76116006)(478600001)(66946007)(4744005)(6486002)(6512007)(83380400001)(4326008)(2616005)(186003)(8936002)(86362001)(91956017)(6506007)(54906003)(26005)(66446008)(53546011)(71200400001)(36756003)(2906002)(8676002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UFllQnRGQWlMRWZPMkQ4WUk5NFhWOStjTmZZRE9jWVhTTDlDQ1Zobkg5WHUy?=
 =?utf-8?B?bS85Y1Z0QXA1dGZuODRUQ0FjRFRQSno1YnlhMjJMYkkxRHo2Qy9EeFNYTXoz?=
 =?utf-8?B?RlVZTzNOVWZ6NHlXSlFONUtKRVltOGZLeW9sSUw3bmNodk04YnFQdFNwLzdG?=
 =?utf-8?B?WU1BM3dOcklHMjg3SmhzeVZkOUtYeDUzRkhIK3R0bUQzVVl2NS9Eblg1MXpp?=
 =?utf-8?B?YjVCVndteFRoTXZ5VWxJYVJDTUNpemdUQmVWSVA5Tm9GZWwvT1lodzhYVFov?=
 =?utf-8?B?anQ4ZFZ0NjFRR0tFU2FzZVN5bzZDL2M2bjc3RjQ0MUhBNjFnT2s5R21Ca29t?=
 =?utf-8?B?aVFzZHlKMVVUYkRYdk13ZnpEbVhQdzhUY1EwbFF1ekZFQzdaT2UvekhrQ0Rk?=
 =?utf-8?B?NTBRTFBJNWZ4NDVGVmJkN1J0OW9ZTmZqS2E5YzNheGlveWhuTEI5TkFucGhG?=
 =?utf-8?B?cmZwZGtDeDRLYWFEUHhOSTlWUG5XMnpLWjh6dHlqWm1wZlhJTmZJcklBdWE0?=
 =?utf-8?B?OXNFVmkzdDdvNnhmTzkxTEZSS011TGU5UWJhTXkwV0VrVEhTd1dpb3JTTVY1?=
 =?utf-8?B?OFZyL1l4aE5ZbmdBejZCL3ZFSmFVNDkwNjY0QVRhb1pNajFRbnprQTVUTXkx?=
 =?utf-8?B?YnBEY2NYdS9iRDIxNFdMZDBxOWcvTndjL0ZvaEFldWdiWFljSUc3bWhMS1hG?=
 =?utf-8?B?a2FQeWhYWU5QZXczVFdFU3l1QlhyNkhlOTJnYzdRMVE0T0FtNXltYndkdUw2?=
 =?utf-8?B?UURyOVZicnpxeVZsVWx0eEwvQkw4aEllbHZYVDY0aisvVDJPVVZwdVpDanVR?=
 =?utf-8?B?WXZTb0cwdHV4UzNOeUpCUGFFMG4ySkhwdmQ3eSt1QTFjUWIxMktFT3BIS3Ar?=
 =?utf-8?B?MmVDM3VkRmdZTHV5RDMrU3VBUnpuTzh1dm14ZkcvVjREc2M1c3JjeHJjaVEr?=
 =?utf-8?B?S25uemdEV2hpYnFZMll0WmFnL0RtaFYrSTZRMlNsUzJBRmovZ09UVTgvdHAy?=
 =?utf-8?B?N0NpWHJZNEVpRFBuV0JiemhDSlR4TDhwY0JneFAyN1J2V0JvL1Q5UW1uNGY1?=
 =?utf-8?B?WXQ1WUdPMEVmeGxXU3hXM0RwUG9qeXhkSEkrQTFWT2wrMGxsdWxHRjlCY3Mv?=
 =?utf-8?B?cThmckNNeUNDZWVvVy9iSkNIL1RCOWI3bW00eC84TUVHVDV3RUFhczlRWnBM?=
 =?utf-8?B?OE1Ub01YcUpIODBQaS84Tmo1Ull1UlNnQkVabitMQW9jZzhCS2dZY2pXQVRH?=
 =?utf-8?B?ZWVBaFlDYlpiTS9TakppcURMcmNJSG9iQTdRYjFaZVJyS0N1Z0EyR0h6eUV4?=
 =?utf-8?Q?JzFoDHJP9LMBfBZ8QBoOa7IyG5I9nswvu4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4822C4BA628064438F6A9CE7A886F3A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d34ab9-bcf7-415a-8b19-08d8988a6f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 19:26:01.4001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQUIigyt+1Pl/141yL1vBMspaC7cWVNboVqHjYo09070Aso5oLZh3uk+T/gXXVssZ20GJAD5+quJDdWffL5D0e6VIBmLc4irat1oQp1nZWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2902
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDEwOjEyIC0wODAwLCBCZW4gV2lkYXdza3kgd3JvdGU6DQo+
IEhpIENocmlzLg0KPiANCj4gT24gMjAtMTItMDQgMTI6NDA6MDMsIENocmlzIEJyb3d5IHdyb3Rl
Og0KWy4uXQ0KPiANCj4gPiAgICBhY3BpZHVtcCBpbmRpY2F0ZXMgdGhlIENYTDAgYW5kIENYTE0g
ZGV2aWNlcyBidXQgbm8gU1JBVCBvciBITUFUIHRhYmxlcyBhcmUNCj4gPiAgICBpbiB0aGUgZHVt
cCB3aGljaCBpcyBjdXJpb3VzLg0KPiANCj4gSSBkb24ndCB0eXBpY2FsbHkgdXNlIEhNQVQsIGJ1
dCBJIGRvIGhhdmUgYW4gU1JBVCBpbiBtaW5lLCBzbyB0aGF0J3Mgc3RyYW5nZS4NCj4gWW91IHNo
b3VsZCBhbHNvIGhhdmUgYSBDRURULg0KPiANCkkgc3VzcGVjdCBhbiBTUkFUIGlzIG9ubHkgYWRk
ZWQgaWYgeW91IGhhdmUgZGlzdGluY3QgbnVtYSBub2Rlcy4gQWRkaW5nDQphIGZldyAnLW51bWEg
bm9kZScgYml0cyB0byB0aGUgcWVtdSBjb21tYW5kIGxpbmUgc2hvdWxkIGJlIGVub3VnaCB0bw0K
bWFrZSB0aGF0IGhhcHBlbi4NCg==
