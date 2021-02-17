Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91E31D53B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Feb 2021 07:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBQGEw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Feb 2021 01:04:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:34885 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231567AbhBQGEP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Feb 2021 01:04:15 -0500
IronPort-SDR: 2b7R0VyRgkSKM+N1vlHtJzImC7WQ5WIDVM4mAdMIbw1eYROWCYmWKHDh52uhcSFPKhg34P21lZ
 +NCtltkiAD8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="183243472"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="183243472"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 22:03:33 -0800
IronPort-SDR: yLngEhHYn0C9P5SKuFQxW3yvdaFi/EJbFZSLzXda0wO3DreLuYsXUO44tH5aKEx6J1cY/7Cw+f
 25cVMsH/92jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="361929106"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 16 Feb 2021 22:03:33 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 22:03:33 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 22:03:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 16 Feb 2021 22:03:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 16 Feb 2021 22:03:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpTe6XV8tMVONuc0qhBREFhv7WoRaaKFpDIcke3+wtbL8xls98b45Rcp3LgrEEgn/SsPM9O1A8CzeKJpGusIf7NZxBPxyqOmjkF/gadncOaPIZynMKlbxs2ARPDiOL+5Pjv44rnkyTrJ4LSq6bdkHuCrXsWP3aH6VltqC1k5fg+36f7W+2vJx9E51z2xL3AWifBS6f6KjbHsJYh0/v/DKSE9E88vVPRnWZ4GSZ1WZaUX4elZ5D8taymd7D9SWaC9kE2v1E9wnWVKbBVv2WOCoA5mWTx9MUvpjegigXZyhSzmYwDcLc4TMkaTY+edMDXPxRxAl85w/auAy4BjmAlbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC9vqAMWTOrVUYcTv2gll3ldlu45F7KNFl36w8vAmPQ=;
 b=i4xz5bT7td18TWV4nzmY0d5eGRT73vI4zIJlm8dyMv4HpdgiaIKU1o+l0EEV1UesUF5K6gmthsaLT8KEIlg0w9A7efMhDvH4sSblvIdd9v//EAtgO0AS0DiWpBdmY605cXm4nz33KfA7hQkC65Z7HHuxjuzFLSw0EJwrPtBsdlR2dO89v/fFB+BYnnI4GRRHP64RbPbwC9YTRJxWaR27tekqA2F7KYJbnDfTaKws2TNiUy651WC2wlNbEkO8xNgw1lUElkylq2HGis36MM981OQJERJGvujhVM5mpfvoYWfmHW2iXmMFz/Y3AlT6SrWOz7PVJTQNESrVqCA6a8BZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC9vqAMWTOrVUYcTv2gll3ldlu45F7KNFl36w8vAmPQ=;
 b=D+JwhLwVdPm6F2B3ako/u8eGVUFjHgH66sDdZFp8K3TQCc3bPz3zgj2yCgjrcXhuIvau7uHTleb2ozvqkiFXMpn4q8FWaneHz48hsPdeME0Lv1wL5D4COwIBeNMLxT2bkfL8Hm1jza3LJ3QRash1CXP1cQmhwKzPf/Erxjwa6dY=
Received: from MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 17 Feb
 2021 06:03:32 +0000
Received: from MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a]) by MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a%7]) with mapi id 15.20.3846.041; Wed, 17 Feb 2021
 06:03:31 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [PATCH v7 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe
 controller
Thread-Topic: [PATCH v7 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe
 controller
Thread-Index: AQHW8mkgIampmTGXTkykMhibPE2oSqpQpkuAgAtZcjA=
Date:   Wed, 17 Feb 2021 06:03:31 +0000
Message-ID: <MWHPR11MB140611D7EE90A7170361039185869@MWHPR11MB1406.namprd11.prod.outlook.com>
References: <20210124234702.21074-1-srikanth.thokala@intel.com>
 <20210124234702.21074-2-srikanth.thokala@intel.com>
 <YCMr3yCv5+cAjzDc@rocinante>
In-Reply-To: <YCMr3yCv5+cAjzDc@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [124.123.181.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4988e0ba-1c1f-4bc5-b219-08d8d309c108
x-ms-traffictypediagnostic: CO1PR11MB4964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB49640F25DFCD11CC424A848885869@CO1PR11MB4964.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eG+2B0xWJfemZwz39sCeZS4AGujC3QQ7U8gU0X8hzDDTgBvwAJG9Yy1HNWgUwkQtMSP/fGEU/RMCA6RZZBVUND6Y41O66d1ADI+D9Iit4l6liOHd0uUcRKD1Od5M+yIIdk351DjdyUEeFzjbSlNGUZbiKFZDD98jADRGeVRjiUQJ5U71wVh86TefRtt5A9b4osTDFrpZjyrN+rTIJhlBY1kEWaiBGHgdyvrtdWQ+MYrIZAXaGbrdh7l8NUlXQFC7NMWUo5avJgh9Y+yvkkhMq0X3lJ74+C62PQKvDi/cPRyWJwG2WgH2cmagHC/q+FrgsSOXp1cSXWcCH6SVGJDHS2rYrcQnFnw1S71l6dcUDt8e5LRfF/4tVYxCz533EzI0I7ZIfL/rxiwtLiJ8cwben5Tu7CIiteE5zQFSFJ+dceo94rg1gMEuMXiOvCa/OOzzh7y2YQPRZMFlM5fNJl9ohslrxkWiH+ZPWTuWF2q1ncnTi6YTJTOdcvtCjyUU1gO+ScVJzyL0JCed1+Fo9G/s4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1406.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(376002)(366004)(136003)(478600001)(55016002)(71200400001)(26005)(54906003)(53546011)(316002)(66476007)(8936002)(52536014)(64756008)(6916009)(6506007)(66446008)(66556008)(76116006)(2906002)(9686003)(66574015)(33656002)(186003)(7696005)(5660300002)(4326008)(86362001)(8676002)(66946007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RFhiZU04N1RweFFlaGp4UWw1Wkhvc3ZpUzgza2VHOGpMRG5kM053ZEpENUQ0?=
 =?utf-8?B?enh5Tklpa1o2VExyYkY5d1RaVHFicDE3UDNxNXZQSkova0d6R1ZCR0pmOVRs?=
 =?utf-8?B?cnRPMTR3cGhTbWVBQlBiTExFTS9ubHR4N2NxTEw2SDA3ZTBmbkJ4L0puVUhV?=
 =?utf-8?B?UG5laGtZeW9VWXFQUm9SZVA3RGJiK2lrTnFLYTNvLysvc05EYTJVUEVrYWFW?=
 =?utf-8?B?MG0wMFRTVlFuVVBERnRKRDNKMTgxV1dtV1NTdFRnUndHWktqZkdxQU96TmFr?=
 =?utf-8?B?bGhUZ2NiTXUrdkcweXpvdi9mcERXM05MWGtSNng1V1V0Y1RNbjNFZmVnVFd4?=
 =?utf-8?B?a0pMclBpbDJYMzBCSkEvOHNHbXJ3b3lwNFh4WVp4NjlkWUEvTFFjaGFUd0c3?=
 =?utf-8?B?cWpMZW5ZUUpQQitUYTNuaUw3TWxKU21GTE5La2FFakRJKzUvd2NEbC9lcm9F?=
 =?utf-8?B?WlZpN1BLelorWlRSSW5RdW1qOHZYYWtXQ29sUUpyN29ydCtGMkREQXl0Zi8z?=
 =?utf-8?B?SzcxQ1lTanB4R2Zuc1JFaWQxWkdvZGhvNVhsZDN5RmJiS1JUSjNTU25kUlhK?=
 =?utf-8?B?WXJCeG8zWWlFN3VKVC9yM0gwdHUvOFducWx5Z2ZhMkcwOVZ4bkdSRnJlT1Uy?=
 =?utf-8?B?cS9LZ3o3bjhSQUhSSDAvU3BLTm0zQ0hZbXBVd1Q2ZVhadU1KMFB3Ny9jTHNB?=
 =?utf-8?B?YS8rdXlka0ZONjhYMDRnaFNER0h2V2JPTmNSZ0FKWVJVOVBicVpGUlZ2OGdD?=
 =?utf-8?B?M0hJWmNXbjVINm1TVlFuN3FpSjM4RSt4MDh2aWZSaU8xOVRLcmIxU1VKbzlE?=
 =?utf-8?B?QlRCK0NZWXNHNXJtUDFWa21EMWhuN1J0ellkU3loMTErQnhtS3FqaXV3clhT?=
 =?utf-8?B?VzlCSjd4UjY5UlBXOXBEMkoxczAydkRla1g1YUZiZGl5MjlNRjc0bmMyeVhm?=
 =?utf-8?B?K2pOYjNEWXVhckQzTnA1b1ZxKzRaMUNONkdPV2V6Y2pacnhKeU11T1hxcEE1?=
 =?utf-8?B?eTV2UloxaVNkbEUzWFlZRHdtNWs2Wlk5ZTJTNFVIcnFxWFRQVzJ1LzRqZTdm?=
 =?utf-8?B?Lzd0VlE2M3k0TjNsS1krS0RwVDU1UW5EeWdMY2pYUVAxZ1c3OERsZFF4dkFN?=
 =?utf-8?B?YnhySFBKMlBlbnk0MHFSL0orUjh6R2ppaFpRcTVsOXR1OGJTeDhWVVYrZkV2?=
 =?utf-8?B?SWxGV2d6ZXlQWGxxMXphN3VGSWd2Qk9OVHk0TzRFYWFuVkRiUVBRcnhYdVht?=
 =?utf-8?B?dWltYWFhM3VwOFlUeGZFaVVOcHVCQlB6aENST1ZFOWdkV3JBbzhNWHZXWFlV?=
 =?utf-8?B?YXpwRC82UmQvNUVFYzkwdVNJOXoyQVVRbHFzNFRBWk0rWnJCMnhFVXY4V3hu?=
 =?utf-8?B?NWpBZHFpbVBrTEtlUnBiQnFXNjNTM3F2SWllTTVWcDZ3Vk9SemtBcHdTZDhR?=
 =?utf-8?B?bjV0eHkzZ3FqWmYzVlR2VkNrejdUOG5uelM3WjV1T0o4bitXbHZ0cWx4ZUND?=
 =?utf-8?B?VkQ4Z3NHQTFYQ1FkQnNmeHFDRE5UYkZCRkJiZHlSTkhBZW9TajJZOTRGR01k?=
 =?utf-8?B?em02NnBKaWFxTG4zSXFWMy9mUnFSQlhRVHNaZDR0QnFKR1BUcnA0bC9ZbFZZ?=
 =?utf-8?B?Znk4ZnFnbkZwZ2pEZS9YMFBaenpOZERiR3RycEhSUGVBS24rUGpYTHY4Y2RY?=
 =?utf-8?B?QXp5WmJRcU1aYjlnVFZBcndrT2F3VjE1MkhHMlhmOVJNZDRCNklzc3Q2TFJ1?=
 =?utf-8?Q?GC3eteNO09aQCFcwrzke/GhF4GAr0k/MVLX6P9V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1406.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4988e0ba-1c1f-4bc5-b219-08d8d309c108
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 06:03:31.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cI81gLLipCphXj/S+yxbJUkfXFl/f7WKH4fpphHbGr8sHv9FrN1OS0cJLuN6ahDyNEg66zqr3Shs7r1aeyvTu1XwZjk7USZfXQ2IPy/34N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51
eC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMTAsIDIwMjEgNjoxMiBBTQ0KPiBU
bzogVGhva2FsYSwgU3Jpa2FudGggPHNyaWthbnRoLnRob2thbGFAaW50ZWwuY29tPg0KPiBDYzog
YmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlz
aUBhcm0uY29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBtZ3Jvc3NA
bGludXguaW50ZWwuY29tOyBSYWphDQo+IFN1YnJhbWFuaWFuLCBMYWtzaG1pIEJhaSA8bGFrc2ht
aS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+Ow0KPiBTYW5nYW5uYXZhciwgTWFsbGlr
YXJqdW5hcHBhIDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY3IDEvMl0gZHQtYmluZGluZ3M6IFBDSTogQWRkIEludGVsIEtlZW0g
QmF5IFBDSWUNCj4gY29udHJvbGxlcg0KPiANCj4gSGkgU3Jpa2FudGgsDQo+IA0KPiBUaGFuayB5
b3UgZm9yIHdvcmtpbmcgb24gdGhpcyBuZXcgZHJpdmVyIQ0KPiANCj4gWy4uLl0NCj4gPiArdGl0
bGU6IEludGVsIEtlZW0gQmF5IFBDSWUgY29udHJvbGxlciBlbmRwb2ludCBtb2RlDQo+IFsuLi5d
DQo+ID4gK3RpdGxlOiBJbnRlbCBLZWVtIEJheSBQQ0llIGNvbnRyb2xsZXIgcm9vdCBjb21wbGV4
IG1vZGUNCj4gWy4uLl0NCj4gDQo+IE5vdCBzdXJlIGlmIHdvcnRoIHNwZW5kaW5nIG9uIHRoaXMs
IGJ1dCBJJ3ZlIG5vdGljZWQgdGhhdCBwZW9wbGUgb2Z0ZW4NCj4gY2FwaXRhbGlzZSAiUm9vdCBD
b21wbGV4IiBhbmQgIkVuZHBvaW50IiB3aGVuIHRhbGtpbmcgYWJvdXQgUENJZQ0KPiBjb250cm9s
bGVyDQo+IGZlYXR1cmVzIC0geW91IGRpZCB0aGUgc2FtZSBpbiB0aGUgY292ZXIgbGV0dGVyLCBz
byBJIHdvbmRlciBpZiB5b3Ugd2FudA0KPiB0byBrZWVwIHRoaXMgY29uc2lzdGVudC4NCg0KU3Vy
ZSBJIHdpbGwgbWFrZSBjaGFuZ2UgdG8ga2VlcCBpdCBjb25zaXN0ZW50Lg0KDQpUaGFua3MhDQpT
cmlrYW50aA0KDQoNCj4gDQo+IEtyenlzenRvZg0K
